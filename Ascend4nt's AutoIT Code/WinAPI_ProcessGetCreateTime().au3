; ===============================================================================================; Func _WinAPI_ProcessGetCreateTime($vProcess);; Function to get the Process Creation Time;; $vProcess = Process ID or Process Name;; Returns:;   Success: Creation Time in the form YYYYMMDDHHSS;   Failure: Empty string, and @error set to 2 if DLLCall failure;; Author: Ascend4nt; ===============================================================================================Func _WinAPI_ProcessGetCreateTime($vProcess)    If Not IsNumber($vProcess) Then        $vProcess=ProcessExists($vProcess)        If Not $vProcess Then Return SetError(1,0,"")    EndIf    Local $stCreateTime,$stExitTime,$stKernelTime,$stUserTime    ; Open Process handle (PROCESS_QUERY_INFORMATION 0x400) @http://msdn.microsoft.com/en-us/library/ms684880(VS.85).aspx    Local $hProcess = DllCall('kernel32.dll','ptr', 'OpenProcess','int', 0x400,'int', 0,'int', $vProcess)    If @error Or Not IsArray($hProcess) Then Return SetError(2,0,"")    $stCreateTime=DllStructCreate("dword[2]")    $stExitTime=DllStructCreate("dword[2]")    $stKernelTime=DllStructCreate("dword[2]")    $stUserTime=DllStructCreate("dword[2]")    Local $aRet=DllCall("kernel32.dll","int","GetProcessTimes","ptr",$hProcess[0],"ptr",DllStructGetPtr($stCreateTime), _        "ptr",DllStructGetPtr($stExitTime),"ptr",DllStructGetPtr($stKernelTime),"ptr",DllStructGetPtr($stUserTime))    ; Close the process handle    DllCall('kernel32.dll','int', 'CloseHandle','ptr', $hProcess[0])    If Not IsArray($aRet) Then Return SetError(2,0,"")        Return _WinAPI_FileTimeConvert(DllStructGetData($stCreateTime,1,1),DllStructGetData($stCreateTime,1,2))EndFunc; ===============================================================================================================================
; Func _WinAPI_FileTimeConvert($iFileDateTimeLo,$iFileDateTimeHi,$iFormat=1,$iPrecision=1,$DLL=-1)
;
; Function to Convert Date-Time double-dword values stored in Windows FILETIME structures
;    (FILETIME is a 64-bit unsigned value representing the # of 100-nanosecond intervals since January 1, 1601)
;    NOTE: It *has* to be passed as two dwords in this version.
;
; NOTE: When used with _WinAPI_FileFind.. functions, the *PREFERRED* METHOD of calling this is:
;    _WinAPI_FileFindTimeConvert()
;
; $iFileDateTimeLo = Lo word of date/time info returned in a the FILETIME structure
; $iFileDateTimeHi = Hi word of date/time info returned in a FILETIME structure.
; $iFormat = Format to return in. 1 = string, 0 = array of 3 strings (24-hour military clock for both):
;    0 Array format:
;        [0]=YYYYMMDDHHMM[SS[MSMSMSMS]]
;        [1]=Month ("January"-"December")
;        [2]=DayOfWeek ("Sunday"-"Saturday")
;    1 format: YYYYMMDDHHMM[SS[MSMSMSMS]]
;        [technically Year can be 5 chars - but that's a good 7900+ years from now]
; $iPrecision = extra precision of return: 0 = Minutes, 1=Minutes+Seconds,>1=Minutes+Seconds+Milliseconds
; $DLL = DLL handle or -1
;
; Return:
;    Success: Based on $iFormat: either a formatted string, or an array of formatted strings
;    Failure: empty string, with @error=2 (DLL call fail)
;
; Author: Ascend4nt
; ===============================================================================================================================

Func _WinAPI_FileTimeConvert($iFileDateTimeLo,$iFileDateTimeHi,$iFormat=1,$iPrecision=1,$DLL=-1)
    Local Const $aMonths[12]=["January","February","March","April","May","June","July","August","September","October","November","December"]
    Local Const $aDays[7]=["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
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
    If @error Or Not $aRet[0] Then Return SetError(2,@error,"")

    ; Then convert file time to a system time structure
    $aRet=DllCall($DLL,"int","FileTimeToSystemTime","ptr",DllStructGetPtr($stLocalFileTime),"ptr",DllStructGetPtr($stSystemTime))
    If @error Or Not $aRet[0] Then Return SetError(2,@error,"")
    
    ; Now format it in a string. Regular precision:: YYYYMMDDHHMM
    ;    [technically Year can be 5 chars - but that's a good 7900+ years from now]
    $sDateTimeStr = DllStructGetData($stSystemTime,1) & StringRight('0' & DllStructGetData($stSystemTime,2),2) & _
        StringRight('0' & DllStructGetData($stSystemTime,4),2) & _
        StringRight('0' & DllStructGetData($stSystemTime,5),2) & StringRight('0' & DllStructGetData($stSystemTime,6),2)
    ; +SS (Seconds)
    If $iPrecision Then $sDateTimeStr&=StringRight('0' & DllStructGetData($stSystemTime,7),2)
    ; +MSMSMSMS (Milliseconds)
    If $iPrecision>1 Then $sDateTimeStr&=StringRight('000' & DllStructGetData($stSystemTime,8),4)
    
    ; DLLStructDelete()'s
    $stFileTime=0
    $stLocalFileTime=0
    If Not $iFormat Then
        Local $iMonth=DllStructGetData($stSystemTime,2)-1
        ; Shouldn't be necessary:
        If $iMonth>11 Then $iMonth=11
        Local $iDay=DllStructGetData($stSystemTime,3)
        ; Shouldn't be necessary:
        If $iDay>6 Then $iDay=6
    
        Local $aReturnArray[3]=[$sDateTimeStr,$aMonths[$iMonth],$aDays[$iDay]]

        ; DLLStructDelete()'s
        $stSystemTime=0
        Return $aReturnArray
    EndIf    
    ; DLLStructDelete()'s
    $stSystemTime=0
    Return $sDateTimeStr
EndFunc
