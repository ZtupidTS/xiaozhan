#include-once

; ==================================================================================================
; <_WinAPI_ProcessGetPathname.au3>
;
; Alternative to _WinAPI_ProcessGetFilename() (but only for 'True' secondary parameter)
;    This function is needed when working in x86 mode under x64 OS's.
;
; REQUIREMENTS: Windows XP+ or Win2003+, AutoIT v3.2.12.1 UNICODE (also tested on v3.3)
;
; Function:
;   _WinAPI_ProcessGetPathname()
;
; NOTE: Drive array is usually built once, and only rebuilt when either A) requested, or
;    B) if a search fails. Generally this is okay behavior because a failed search
;   will rescan the drives and find any new/changed ones. However, if you wish to force
;   an array re-initialization, the 2nd parameter is available for that option.
;
; Alternatives:
;   _WinAPI_ProcessGetFilename() for non-x64 OS's, or
;   for WinVista, Win2008+: QueryFullProcessImageNameW
;
; Internal (do not touch) functions:
;   _INT_BuildDeviceToDriveXlateArray()
;   _INT_TranslateDeviceFilename()
;
; Author: Ascend4nt
; ==================================================================================================


; ==================================================================================================
; Func _WinAPI_ProcessGetPathname($vProcessID,$bResetDriveMap=False)
;
; Alternative to _WinAPI_ProcessGetFileName (when called with a 'True' secondary parameter),
;   this works on WinXP+ and Win2003+ x64 OS's whereas the former 'full path' option does not.
;
; NOTE that because of the return type of the DLL call GetProcessImageFileName, there needs to be a translation.
;   This is handled by 'internal' functions in this source file which utilizes the QueryDosDevice call.
;
; ADDITIONAL NOTE: Certain processes require elevated privileges. See 'Privilege.au3' at:
;   http://www.autoitscript.com/forum/index.php?showtopic=75250&st=0&p=545798&#entry545798
;
; $vProcessID = process name (explorer.exe) or ID #
; $bResetDriveMap = If True, the Drive map array is reset. This is normally only set once, and automatically
;       reset if a match wasn't found. However, to force a remap, set this to True.
;
; Returns:
;   Success: Full pathname of process
;   Failure: "", with @error set
;       @error = 1 if invalid process name, or path not found
;       @error = 2 if DLL call failure
;       @error = 3 = Couldn't obtain Process handle
;       @error = 4 = GetProcessImageFileName returned a 0 for filename-length
;       @error = 5 if DriveGetDrive("ALL") call failure (only on 1st initialization)
;
; Author: Ascend4nt
; ==================================================================================================

Func _WinAPI_ProcessGetPathname($vProcessID,$bResetDriveMap=False)
    ; Not a Process ID? Must be a Process Name
    If Not IsNumber($vProcessID) Then
        $vProcessID=ProcessExists($vProcessID)
        ; Process Name not found (or invalid parameter?)
        If $vProcessID==0 Then Return SetError(1,0,"")
    EndIf
    Local $sImageFilename,$stImageFilename,$aRet,$tErr
    ; Open Process handle (PROCESS_QUERY_INFORMATION 0x400) @http://msdn.microsoft.com/en-us/library/ms684880(VS.85).aspx
    Local $hProcess = DllCall('kernel32.dll','ptr', 'OpenProcess','int', 0x400,'int', 0,'int', $vProcessID)
    If @error Then Return SetError(2,0,"")
    If Not $hProcess[0] Then Return SetError(3,0,"")
    
    $stImageFilename=DllStructCreate("wchar[32767]")
    $aRet=DllCall("Psapi.dll","dword","GetProcessImageFileNameW","ptr",$hProcess[0],"ptr", _
        DllStructGetPtr($stImageFilename),"ulong",32767)
        
    If @error Then
        $tErr=2
    ElseIf Not $aRet[0] Then
        $tErr=4
    Else
        $tErr=0
    EndIf
    ; Close process
    DllCall('kernel32.dll','int', 'CloseHandle','ptr', $hProcess[0])
    ; Error above?
    If $tErr Then Return SetError($tErr,0,"")
    ; Grab device\filename
    $sImageFilename=DllStructGetData($stImageFilename,1)
    ; DLLStructDelete()
    $stImageFilename=0
    Return _INT_TranslateDeviceFilename($sImageFilename,$bResetDriveMap)
EndFunc

; ==================================================================================================
; Global Device-Drive Mapping array & state of array (for internal use)
; ==================================================================================================

Global $_aINTDeviceToDriveMapArray
Global $_bINTDeviceToDriveMapInit=False

; ==================================================================================================
; Func _INT_BuildDeviceToDriveXlateArray()
;
; Internal function used to build the Device-Drive Map Array (using all available drives)
;   It calls DriveGetDrive("ALL") to get all drives, then uses the DLL call QueryDosDevice to get device names
;   The importance of this is in translating returns from GetProcessImageFileName DLL calls, which is the only
;   reliable way to get paths for processes on X64 OS's (x32 OS can use GetModuleFileNameEx)
;
; Returns: True if successfull, False if error with @error = 5 if DriveGetDrive() failure, @error=2 if DLL call error
; ==================================================================================================

Func _INT_BuildDeviceToDriveXlateArray()
    If $_bINTDeviceToDriveMapInit Then Return True
    
    Local $aRet,$aDriveArray=DriveGetDrive("ALL")
    If @error Then Return SetError(5,0,0)
    
    Local $stDriveName,$stReturnBuffer
    
    Dim $_aINTDeviceToDriveMapArray[$aDriveArray[0]][2]

    $stDriveName=DllStructCreate("wchar[3]")
    $stReturnBuffer=DllStructCreate("wchar[100]")   ; 100 is overkill, but I don't know the max device name currently
    
    For $i=1 To $aDriveArray[0]
        ; Put the drive letter in the array and in the structure (uppercase is part preference, & generally expected)
        $_aINTDeviceToDriveMapArray[$i-1][0]=StringUpper($aDriveArray[$i])
        DllStructSetData($stDriveName,1,$_aINTDeviceToDriveMapArray[$i-1][0])
        ; Get \Device\HarddiskVolume1, \Device\CdRom0, \Device\Floppy0 etc
        $aRet=DllCall("Kernel32.dll","dword","QueryDosDeviceW","ptr",DllStructGetPtr($stDriveName), _
            "ptr",DllStructGetPtr($stReturnBuffer),"ulong",200) 
        If @error Then
            ;ConsoleWrite("ERROR:" & _WinAPI_GetLastErrorMessage() & @CRLF)
            $_aINTDeviceToDriveMapArray=0
            Return SetError(2,0,False)
        EndIf
        ; Set the device name
        $_aINTDeviceToDriveMapArray[$i-1][1]=DllStructGetData($stReturnBuffer,1)
        ;ConsoleWrite("Drive-" & $aDriveArray[$i] & ",upper-" & $_aINTDeviceToDriveMapArray[$i-1][0] & ",Device:" & $_aINTDeviceToDriveMapArray[$i-1][1] & @CRLF)
    Next
    ;DLLStructDelete()'s
    $stDriveName=0
    $stReturnBuffer=0
    $_bINTDeviceToDriveMapInit=True
    Return True 
EndFunc

; ==================================================================================================
; Func _INT_TranslateDeviceFilename(Const ByRef $sImageFilename,$bResetDriveMap)
;
; Internal function used to translate strings returned from GetProcessImageFileName DLL calls to actual hard paths
;
; Returns: String if successfull, False if not found (caller issue usually), @error=1 = not a string, or not found
; ==================================================================================================

Func _INT_TranslateDeviceFilename(Const ByRef $sImageFilename,$bResetDriveMap)
    If Not IsString($sImageFilename) Or $sImageFilename="" Then Return SetError(1,0,"")
    If $bResetDriveMap Then $_bINTDeviceToDriveMapInit=False
    If Not (_INT_BuildDeviceToDriveXlateArray()) Then Return SetError(@error,0,"")
    
    For $i2=1 to 2
        For $i=0 to UBound($_aINTDeviceToDriveMapArray)-1
            If StringInStr($sImageFilename,$_aINTDeviceToDriveMapArray[$i][1])=1 Then _
                Return StringReplace($sImageFilename,$_aINTDeviceToDriveMapArray[$i][1],$_aINTDeviceToDriveMapArray[$i][0])
        Next
        ; Already reset the drive map? No use continuing
        If $bResetDriveMap Then Return SetError(1,0,"")
        ; Reset the drive map since there was no matches
        $_bINTDeviceToDriveMapInit=False
        If Not (_INT_BuildDeviceToDriveXlateArray()) Then Return SetError(@error,0,"")
        ; Flag this for next run (so it returns before trying to rebuild again)
        $bResetDriveMap=True
        ; Cycle through once more
    Next
    ; Actually shouldn't get here..
    Return SetError(1,0,"")
EndFunc

; ==================================================================================================
; TEST
; ==================================================================================================

#include <WinApi.au3>
#include <Array.au3>
#include <_SetPrivilege.au3>
Local $iOverallTimer,$iTimer,$sImageName,$aProcessList,$aPathList
Local $avCurr,$avPrev

If IsAdmin() Then
    Dim $avCurr[2] = [$SE_DEBUG_NAME, $SE_PRIVILEGE_ENABLED]
    $avPrev = _SetPrivilege($avCurr)
EndIf

$aProcessList=ProcessList()
If Not IsArray($aProcessList) Then Exit
Dim $aPathList[$aProcessList[0][0]][3]
$iOverallTimer=TimerInit()

For $i=1 to $aProcessList[0][0]
    ;$iTimer=TimerInit()
    ; PID
    $aPathList[$i-1][0]=$aProcessList[$i][1]
    ; Process Name
    $aPathList[$i-1][1]=$aProcessList[$i][0]
    ; Full Path
    $aPathList[$i-1][2]=_WinAPI_ProcessGetPathname($aProcessList[$i][1])
    ;ConsoleWrite("Time elapsed:" & TimerDiff($iTimer) & " ms" & @CRLF)
Next

ConsoleWrite("Complete Time elapsed for all processes:" & TimerDiff($iOverallTimer) & " ms" & @CRLF)
_ArrayDisplay($aPathList,"PID,ProcesName,TranslatedPath")

If IsAdmin() Then _SetPrivilege($avPrev)
