#include-once

; ===================================================================================================
; <_WinAPI_FileFind.au3>
;
; Direct Windows API FindFirst/Next File DLL calls for the purpose of getting additional information
;   not found in FileFindFirst/NextFile() calls (these calls would need to be added to get the same
;       information: (FileGetAttrib(),FileGetTime(),FileGetSize()) -> all adding additional overhead
;
; Functions:
;   _WinAPI_FileFindFirstFile()
;   _WinAPI_FileFindNextFile()
;   _WinAPI_FileFindClose()
;   _WinAPI_FileFindTimeConvert()
;
; Internal Functions:
;   _WinAPI_FileTimeConvert()   ; Called by _WinAPI_FileFindTimeConvert()
;
; Author: Ascend4nt
; ===================================================================================================

; ===================================================================================================
; _WinAPI_FileFind *Attribute* bits:
; ===================================================================================================
; 1  [0x1]  = Read Only Attribute
; 2  [0x2]  = Hidden Attribute
; 4  [0x4]  = System Attribute
; 16 [0x10] = Directory Attribute (it is a folder, not a file)
; 32 [0x20] = Archive Attribute
;
; - less-commonly used attributes -
;
; 64    [0x40]   = Device ('RESERVED - Do Not Use')
; 128   [0x80]   = NORMAL Attribute (no other attributes set)
; 256   [0x100]  = Temporary file (for temporary use)
; 512   [0x200]  = Sparse file type (?)
; 1024  [0x400]  = File or Directory has an associated reparse (?) point
; 2048  [0x800]  = Compressed file or folder
; 4096  [0x1000] = Offline status (file data moved to offline storage)
; 8192  [0x2000] = File is not to be content-indexed
; 16834 [0x4000] = Encryption attribute (file/folder is encrypted)
; 32768 xx NOT USED xx
; 65536 [0x10000] = Virtual file (?)
; ===================================================================================================

; ===================================================================================================
; Global structure to cut down on DLLStruct creation
; ===================================================================================================

Global $_st_INT_FileFindInfo,$_i_INT_FileFindHandleCount=0

; ===================================================================================================
; Func _WinAPI_FileFindFirstFile($sSearchString,$DLL=-1)
;
; $sSearchString = pathname + filesearch parameters (ex: C:\windows\system32\*.dll)
;
; Returns:
;   Success: an array containing the 1st find and file handle. (see below for Array format)
;   Failure: -1 with @error set:
;       @error = 1 = invalid parameter
;       @error = 2 = path length to big
;       @error = 3 = DLL call fail
;
; Format of array passed (on success) [1st 4 will be programmer's concern, date/time is accessed an easier way]
;   $array[0] = File Name
;   $array[1] = 8.3 Alternate Short File name
;   $array[2] = File Attributes
;   $array[3] = File Size (64-bits), ~ 9 exabytes max (~ 9,000 terabytes)
;   $array[4] = File Creation time Lo (32-bits) - had to be split up unfortunately
;   $array[5] =   File Creation time Hi (32-bits)
;   $array[6] = File Last Access time Lo (32-bits) - had to be split up unfortunately
;   $array[7] =   File Last Access Time Hi (32-bits)
;   $array[8] = File Last Write time Lo (32-bits) - had to be split up unfortunately
;   $array[9] =   File Last Write time Hi (32-bits)
;   $array[10] = File-Find Handle [Internal Use]
;
; Author: Ascend4nt
; ===================================================================================================

Func _WinAPI_FileFindFirstFile($sSearchString,$DLL=-1)
    If Not IsString($sSearchString) Then Return SetError(1,0,-1)
    Local $aRet,$iSearchLen=StringLen($sSearchString)
    
    ; File length special op for Unicode paths>259
    If $iSearchLen>259 Then
        If $iSearchLen>(32766-4) Then Return SetError(2,0,-1)
        $sSearchString='\\?\' & $sSearchString
    EndIf       

    Local $stPathStruct=DllStructCreate("wchar["&($iSearchLen+1)&"]")
    DllStructSetData($stPathStruct,1,$sSearchString)
    
    ; Create WIN32_FIND_DATA structure If no other open find-file handles.
    ;   We avoid recreating the DLL structure for each call (and hopefully successive recursive find calls)
    ;   to cut down on time (noticeable as file\folders approach tens of thousands)
    If Not $_i_INT_FileFindHandleCount Then _
        $_st_INT_FileFindInfo=DllStructCreate("dword;dword[2];dword[2];dword[2];dword;dword;dword;dword;wchar[260];wchar[14]")
        
    ; Make the call, and fill the $_st_INT_FileFindInfo structure
    If $DLL==-1 Then $DLL="Kernel32.dll"

    $aRet=DllCall($DLL,"ptr","FindFirstFileW","ptr",DllStructGetPtr($stPathStruct),"ptr",DllStructGetPtr($_st_INT_FileFindInfo))
    If @error Or Not IsArray($aRet) Or $aRet[0]==-1 Then Return SetError(3,0,-1)
    ; Success
    
    ; Increase find-file handle count
    $_i_INT_FileFindHandleCount+=1
    
    Local $aReturnArray[11]
    ; Set the Find-File handle
    $aReturnArray[10]= $aRet[0]
    ; Copy file-name
    $aReturnArray[0] = DllStructGetData($_st_INT_FileFindInfo,9)
    ; Copy 8.3 short-name if it exists
    $aReturnArray[1] = DllStructGetData($_st_INT_FileFindInfo,10)
    ; Copy file attributes element
    $aReturnArray[2] = DllStructGetData($_st_INT_FileFindInfo,1)    
    ; Combine two dwords together to get full filesize (64bit value - supported in AutoIT x32 (shouldn't exceed ~ 9 EXAbytes)
    $aReturnArray[3] = (DllStructGetData($_st_INT_FileFindInfo,5)*4294967296) + DllStructGetData($_st_INT_FileFindInfo,6)
    ; File Creation Time - Unfortunately these had to be split up despite 64-bit support (perhaps sign-bit was being touched)
    $aReturnArray[4] = DllStructGetData($_st_INT_FileFindInfo,2,1)
    $aReturnArray[5] = DllStructGetData($_st_INT_FileFindInfo,2,2)
    ; File Last-Access Time - Unfortunately these had to be split up despite 64-bit support (perhaps sign-bit was being touched)
    $aReturnArray[6] = DllStructGetData($_st_INT_FileFindInfo,3,1)  
    $aReturnArray[7] = DllStructGetData($_st_INT_FileFindInfo,3,2)  
    ; File Last-Write Time - Unfortunately these had to be split up despite 64-bit support (perhaps sign-bit was being touched)
    $aReturnArray[8] = DllStructGetData($_st_INT_FileFindInfo,4,1)
    $aReturnArray[9] = DllStructGetData($_st_INT_FileFindInfo,4,2)
    
    ; Return file-find array
    Return $aReturnArray
EndFunc

; ===================================================================================================
; Func _WinAPI_FileFindNextFile(ByRef $aFileFindArray,$DLL=-1)
;
; $aFileFindArray = array received from a call to _WinAPI_FileFindFirstFile(). It will pull out the handle itself.
; $DLL = DLL handle or -1
;
; Returns:
;   Success: True, with the $aFileFindArray updated with the next found file information
;   Failure: False with @error set:
;       @error = 0 = last file
;       @error = 1 = invalid parameter
;       @error = 2 = DLL call failure
;
; Format of array passed (and modified on success) [1st 4 will be programmer's concern, date/time is accessed an easier way]
;   $array[0] = File Name
;   $array[1] = 8.3 Alternate Short File name
;   $array[2] = File Attributes
;   $array[3] = File Size (64-bits), ~ 9 exabytes max (~ 9,000 terabytes)
;   $array[4] = File Creation time Lo (32-bits) - had to be split up unfortunately
;   $array[5] =   File Creation time Hi (32-bits)
;   $array[6] = File Last Access time Lo (32-bits) - had to be split up unfortunately
;   $array[7] =   File Last Access Time Hi (32-bits)
;   $array[8] = File Last Write time Lo (32-bits) - had to be split up unfortunately
;   $array[9] =   File Last Write time Hi (32-bits)
;   $array[10] = File-Find Handle [Internal Use]
;
; Author: Ascend4nt
; ===================================================================================================

Func _WinAPI_FileFindNextFile(ByRef $aFileFindArray,$DLL=-1)
    If Not IsArray($aFileFindArray) Or Not $_i_INT_FileFindHandleCount Then Return SetError(1,0,False)

    If $DLL==-1 Then $DLL="Kernel32.dll"
    ; Make the next DLL call
    Local $aRet=DllCall($DLL,"dword","FindNextFileW","ptr",$aFileFindArray[10],"ptr",DllStructGetPtr($_st_INT_FileFindInfo))
    
    If @error Or Not IsArray($aRet) Then Return SetError(2,0,False)

    ; Last file? Then return False
    If Not $aRet[0] Then Return False
    
    ; Call was successful. Set array
    
    ; File name
    $aFileFindArray[0] = DllStructGetData($_st_INT_FileFindInfo,9)
    ; 8.3 short name
    $aFileFindArray[1] = DllStructGetData($_st_INT_FileFindInfo,10)
    ; File Attribs
    $aFileFindArray[2] = DllStructGetData($_st_INT_FileFindInfo,1)
;~  ; Combine two dwords together to get full filesize (64bit value - supported in AutoIT x32 (shouldn't exceed ~ 9 EXAbytes)
    $aFileFindArray[3] = (DllStructGetData($_st_INT_FileFindInfo,5)*4294967296) + DllStructGetData($_st_INT_FileFindInfo,6)
    ; File Creation Time - Unfortunately these had to be split up despite 64-bit support (perhaps sign-bit was being touched)
    $aFileFindArray[4] = DllStructGetData($_st_INT_FileFindInfo,2,1)
    $aFileFindArray[5] = DllStructGetData($_st_INT_FileFindInfo,2,2)
    ; File Last-Access Time - Unfortunately these had to be split up despite 64-bit support (perhaps sign-bit was being touched)
    $aFileFindArray[6] = DllStructGetData($_st_INT_FileFindInfo,3,1)    
    $aFileFindArray[7] = DllStructGetData($_st_INT_FileFindInfo,3,2)    
    ; File Last-Write Time - Unfortunately these had to be split up despite 64-bit support (perhaps sign-bit was being touched)
    $aFileFindArray[8] = DllStructGetData($_st_INT_FileFindInfo,4,1)
    $aFileFindArray[9] = DllStructGetData($_st_INT_FileFindInfo,4,2)

    Return SetError(0,0,True)   
EndFunc

; ===================================================================================================
; Func _WinAPI_FileFindClose(ByRef $aFileFindArray,$DLL=-1)
;
; Closes file handle received from _WinAPI_FileFindFirstFile()
;
; $aFileFindArray = array received from a call to _WinAPI_FileFindFirstFile(). It will pull out the handle itself.
; $DLL = DLL handle or -1
;
; Returns: True if successful (with $aFileFindArray set to -1), or False if unsuccessful @error is set to:
;   @error = 1 = invalid file handle
;   @error = 2 = DLL call failure (or return of False)
;
; Author: Ascend4nt
; ===================================================================================================
Func _WinAPI_FileFindClose(ByRef $aFileFindArray,$DLL=-1)
    If Not IsArray($aFileFindArray) Or Not $_i_INT_FileFindHandleCount Then Return SetError(1,0,False)

    If $DLL==-1 Then $DLL="Kernel32.dll"
    Local $aRet=DllCall($DLL,"dword","FindClose","ptr",$aFileFindArray[10])

    ; Now look at error/return
    If @error Or Not IsArray($aRet) Or Not $aRet[0] Then Return SetError(2,0,False)
    
    ; Success. Invalidate file-find array
    $aFileFindArray=-1
    ; Decrease find-file handle count
    $_i_INT_FileFindHandleCount-=1
    ; DLLStructDelete() if last open file find handle
    If Not $_i_INT_FileFindHandleCount Then $_st_INT_FileFindInfo=0
    
    Return True
EndFunc

; ===================================================================================================
; Func _WinAPI_FileTimeConvert($iFileDateTimeLo,$iFileDateTimeHi,$DLL=-1)
;
; Internal method to Convert Date-Time double-dword values stored in Windows FILETIME structures
;   NOTE: It *has* to be passed as two dwords, otherwise there are issues with 64-bit parameters.
;
; When used with _WinAPI_FileFind.. functions, the *PREFERRED* METHOD of calling this is:
;   _WinAPI_FileFindTimeConvert()
;
; $iFileDateTimeLo = Lo word of date/time info returned in a the FILETIME structure
; $iFileDateTimeHi = Hi word of date/time info returned in a FILETIME structure.
; $DLL = DLL handle or -1
;
; Return:
;   Success: formatted string : YYYYMMDDHHMMSS (24-hour clock)
;   Failure: empty string, with @error=2 (DLL call fail)
;
; Author: Ascend4nt
; ===================================================================================================

Func _WinAPI_FileTimeConvert($iFileDateTimeLo,$iFileDateTimeHi,$DLL=-1)
    Local $sDateTimeStr,$stLocalFileTime,$stFileTime,$stSystemTime,$aRet
    ; FILETIME structures [DateTimeLo,DateTimeHi]
    $stLocalFileTime=DllStructCreate("dword[2]")
    $stFileTime=DllStructCreate("dword[2]")
    ; SYSTEMTIME structure [Year,Month,DayOfWeek,Day,Hour,Min,Sec,Milliseconds]
    $stSystemTime=DllStructCreate("ushort;ushort;ushort;ushort;ushort;ushort;ushort;ushort")
    
    If $DLL==-1 Then $DLL="Kernel32.dll"
    ; Set the appropriate data members of the FileTime structure
    DllStructSetData($stFileTime,1,$iFileDateTimeLo,1)
    DllStructSetData($stFileTime,1,$iFileDateTimeHi,2)

    ; First convert file time (UTC-based file time) to 'local file time'
    $aRet=DllCall($DLL,"int","FileTimeToLocalFileTime","ptr",DllStructGetPtr($stFileTime),"ptr",DllStructGetPtr($stLocalFileTime))
    If @error Or Not IsArray($aRet) Or Not $aRet[0] Then Return SetError(2,0,"")

    ; Then convert file time to a system time structure
    $aRet=DllCall($DLL,"int","FileTimeToSystemTime","ptr",DllStructGetPtr($stLocalFileTime),"ptr",DllStructGetPtr($stSystemTime))
    If @error Or Not IsArray($aRet) Or Not $aRet[0] Then Return SetError(2,0,"")
    
    ; Now format it and return it in a string. Format: YYYYMMDDHHSSMM
    $sDateTimeStr = DllStructGetData($stSystemTime,1) & StringRight('0' & DllStructGetData($stSystemTime,2),2) & _
        StringRight('0' & DllStructGetData($stSystemTime,4),2) & _
        StringRight('0' & DllStructGetData($stSystemTime,5),2) & StringRight('0' & DllStructGetData($stSystemTime,6),2) & _
        StringRight('0' & DllStructGetData($stSystemTime,7),2)
    
    ; DLLStructDelete()'s
    $stSystemTime=0
    $stFileTime=0
    $stLocalFileTime=0
    
    Return $sDateTimeStr
EndFunc

; ===================================================================================================
; Func _WinAPI_FileFindTimeConvert(Const ByRef $aFileFindArray,$iOption=0,$DLL=-1)
;
; Simple wrapper for _WinAPI_FileTimeConvert, uses same options as FileGetTime()
;   (but works on $array's returned by _WinAPI_FileFindFirst/Next functions)
;
; $aFileFindArray = array returned by _WinAPI_FileFindFirst/Next function
; $iOption = Type of date to convert [Same as FileGetTime()]:
;   0 = Modified (default)
;   1 = Created
;   2 = Accessed
; $DLL = DLL handle or -1
;
; Author: Ascend4nt
; ===================================================================================================

Func _WinAPI_FileFindTimeConvert(Const ByRef $aFileFindArray,$iOption=0,$DLL=-1)
    Switch $iOption
        ; File Created Time
        Case 1
            Return _WinAPI_FileTimeConvert($aFileFindArray[4],$aFileFindArray[5],$DLL)
        ; File Last Accessed Time
        Case 2
            Return _WinAPI_FileTimeConvert($aFileFindArray[6],$aFileFindArray[7],$DLL)
        ; Case 0, else - File Last Modified Time
        Case Else
            Return _WinAPI_FileTimeConvert($aFileFindArray[8],$aFileFindArray[9],$DLL)
    EndSwitch
EndFunc

; ===================================================================================================
; Func _FileGetShortFilename($sPath)
;
; Simple function to return short filename from a full FileGetShortName() path, if one exists.
; NOTE one difference: It will return "" if shortname matches longname (matching _WinAPI_FileFind results)
; ===================================================================================================

Func _FileGetShortFilename($sPath)
    Local $sShortFilename,$sCurrentFilename=StringMid($sPath,StringInStr($sPath,'\',1,-1)+1)
    $sPath=FileGetShortName($sPath)
    $sShortFilename=StringMid($sPath,StringInStr($sPath,'\',1,-1)+1)
    If $sCurrentFilename==$sShortFilename Then Return ""
    Return $sShortFilename
EndFunc

; ===================================================================================================
; - START -
; ===================================================================================================

Local $aFileFindArray,$iTotalCount=0,$iFolderCount=0,$iTimer,$hDLLHandle,$sFilename,$sAttrib,$hFindFileHandle
Local $sFolder="C:\WINDOWS\system32\"
Local $sSearchWildCard="*.*"

; Test _WinAPI_FileFindFirst/Next Loop

$iTimer=TimerInit()
$hDLLHandle=DllOpen("Kernel32.dll")
$aFileFindArray=_WinAPI_FileFindFirstFile($sFolder & $sSearchWildCard,$hDLLHandle)
If $aFileFindArray==-1 Then Exit

Do
    ; Check if it is a folder
    If BitAND($aFileFindArray[2],16) Then
        ; Necessary test with _WinAPI_FindFirst\NextFile() functions. Relative 'folders' need to be ignored:
        If $aFileFindArray[0]=='.' Or $aFileFindArray[0]=='..' Then ContinueLoop
        ; Increase found-folder count
        $iFolderCount+=1
    EndIf
    ; Total file+folder count
    $iTotalCount+=1
    ; Filename:
    ;   $aFileFindArray[0]
    ; 8.3 Short Name [If 1. exists and 2. different from filename]
    ;   $aFileFindArray[1]
    ; Attributes:
    ;   $aFileFindArray[2]
    ; File Size:
    ;   $aFileFindArray[3]
    
    ; [Converting File Date/Time to readable format (not necessary for *compares*)]
    ; Creation Time:
    ;   _WinAPI_FileFindTimeConvert($aFileFindArray,1,$hDLLHandle)
    ; Last Access Time:
    ;   _WinAPI_FileFindTimeConvert($aFileFindArray,2,$hDLLHandle)
    ; Last Write Time:
        _WinAPI_FileFindTimeConvert($aFileFindArray,0,$hDLLHandle)

Until Not _WinAPI_FileFindNextFile($aFileFindArray,$hDLLHandle)
_WinAPI_FileFindClose($aFileFindArray,$hDLLHandle)
DllClose($hDLLHandle)

ConsoleWrite("_WinAPI_FileFind Stats:" & @CRLF & _
    "Total File count:" & $iTotalCount-$iFolderCount & ", Total Folder count:" & $iFolderCount & _
    ", Time elapsed:" & TimerDiff($iTimer) & " ms" & @CRLF)

; Test Regular FileFindFirst/NextFile Loop

$iTotalCount=0
$iFolderCount=0
$iTimer=TimerInit()
$hFindFileHandle=FileFindFirstFile($sFolder & $sSearchWildCard)
While 1
    $sFilename=FileFindNextFile($hFindFileHandle)
    If @error Then ExitLoop

    $sAttrib=FileGetAttrib($sFolder & $sFilename)
    
    ; Check if file is a folder. If so, increase found-folder count:
    If StringInStr($sAttrib,"D",0) Then $iFolderCount+=1
    
    ; Total file+folder count
    $iTotalCount+=1 

    ; Filename:
    ;   $sFilename
    ; 8.3 Short Name [If 1. exists and 2. different from filename]
        _FileGetShortFilename($sFolder & $sFilename)
    ; Attributes:
    ;   $sAttrib [FileGetAttrib($sFolder & $sFilename)]
    ; File Size:
        FileGetSize($sFolder & $sFilename)
    
    ; [Reading File Date/Time]
    ; Creation Time:
    ;   FileGetTime($sFolder & $sFilename,1,1)
    ; Last Access Time:
    ;   FileGetTime($sFolder & $sFilename,2,1)
    ; Last Write Time:
        FileGetTime($sFolder & $sFilename,0,1)
WEnd
FileClose($hFindFileHandle)

ConsoleWrite("FileFindFile Stats:" & @CRLF & _
    "Total File count:" & $iTotalCount-$iFolderCount & ", Total Folder count:" & $iFolderCount & _
    ", Time elapsed:" & TimerDiff($iTimer) & " ms" & @CRLF)

- End Code -
