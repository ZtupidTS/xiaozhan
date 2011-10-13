#include-once

; ==================================================================================================
; <_WinAPI_ProcessGetFileName.au3>
;
; Function:
;   _WinAPI_ProcessGetFilename()
;
; Author: Ascend4nt
; ==================================================================================================

; ==================================================================================================
; Func _WinAPI_ProcessGetFilename($vProcessID,$bFullPath=False)
;
; Function to get the process executable filename, or full path name, for Process
;       using DLL calls rather than WMI.
;
; $vProcessID = either a process name ("explorer.exe") or Process ID (2314)
; $bFullPath = If True, return the full path to the executable. If False, just return the process executable filename.
;
; Returns:
;   Success: String - either full path or just executable name, based on $bFullPath parameter
;   Failure: "" empty string, with @error set:
;       @error = 1 = invalid parameter or process name not found to 'exist'
;       @error = 2 = DLL call error, use _WinAPI_GetLastError()
;       @error = 3 = Couldn't obtain Process handle
;       @error = 4 = empty string returned from call (possible privilege issue)
;
; Author: Ascend4nt
; ==================================================================================================

Func _WinAPI_ProcessGetFilename($vProcessID,$bFullPath=False)
    ; Not a Process ID? Must be a Process Name
    If Not IsNumber($vProcessID) Then
        $vProcessID=ProcessExists($vProcessID)
        ; Process Name not found (or invalid parameter?)
        If Not $vProcessID Then Return SetError(1,0,"")
    EndIf
    
    Local $sDLLFunctionName,$tErr
    
    ; Since the parameters and returns are the same for both of these DLL calls, we can keep it all in one function
    If $bFullPath Then
        $sDLLFunctionName="GetModuleFileNameExW"
    Else
        $sDLLFunctionName="GetModuleBaseNameW"
    EndIf   
    
    ; Get process handle
    Local $hProcess = DllCall('kernel32.dll','ptr', 'OpenProcess','int', BitOR(0x400,0x10),'int', 0,'int', $vProcessID)
    If @error Then Return SetError(2,0,"")
    If Not $hProcess[0] Then Return SetError(3,0,"")
    
    ; Create 'receiving' string buffers and make the call
    ; Path length size maximum in Unicode is 32767 (-1 for NULL)
    Local $stFilename=DllStructCreate("wchar[32767]")
    ; Make the call (same parameters for both)
    Local $aRet=DllCall("Psapi.dll","dword",$sDLLFunctionName,"ptr",$hProcess[0],"ptr",0,"ptr",DllStructGetPtr($stFilename),"dword",32767)
    
    If @error Then
        $tErr=2
    ElseIf Not $aRet[0] Then
        $tErr=4
    Else
        $tErr=0
    EndIf
    ; Close process handle
    DllCall('kernel32.dll','int', 'CloseHandle','ptr', $hProcess[0])
    ; Error above?
    If $tErr Then Return SetError($tErr,0,"")
    
    ;$stFilename should now contain either the filename or full path string (based on $bFullPath)
    Local $sFilename=DllStructGetData($stFilename,1)

    ; DLLStructDelete()'s
    $stFilename=0
    $hProcess=0

    SetError(0)
    Return $sFilename
EndFunc

; ==================================================================================================
; Test:
; ==================================================================================================

ConsoleWrite("Process full path for svchost.exe:" & _WinAPI_ProcessGetFilename("svchost.exe",True) & @CRLF)
