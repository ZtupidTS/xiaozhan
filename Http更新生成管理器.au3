;~ 文件CRC32校验判断更新
;~ By Crossdoor
Dim $FlieSize = 0;记录检测到的所有文件的总大小，也就是需更新的数据总量
Dim $gxurl="http://www.baidu.com/"
InetGet($gxurl & 'up.ini', @TempDir & "\up.ini", 1)
$gengxin = getcrc32()
If $gengxin <> '' Then gengxin()
Func gengxin();执行更新
        $updataname = StringSplit($gengxin, ',')
        $zdx = MylBytes($UpSize);总计需要更新文件
        $FlieSize_A = StringSplit($FlieSize, ',')
        $gxbegin = TimerInit()
        Local $yxz = 0, $nD = 5, $hDownload[$nD], $down[$nD], $nF = 1
;~         $nD变量为同时进行更新下载的文件数，如果更新文件总数小于$nD，则将单个下载
        For $i = 1 To $updataname[0] Step $nD
                $fdx = 0
                For $j = 0 To $nD - 1
                        If $i + $j <= $updataname[0] Then
                                $fdx += $FlieSize_A[$i + $j]
                                $url = $gxurl & StringReplace($updataname[$i + $j], '\', '/')
                                $saveurl = @ScriptDir & "\TEMP\" & $updataname[$i + $j]
                                $saveurl_tmp = StringMid($saveurl, 1, StringInStr($saveurl, '\', 0, -1))
                                If Not FileExists($saveurl_tmp) Then DirCreate($saveurl_tmp)
                                $hDownload[$j] = InetGet($url, $saveurl, 1, 1)
                                $nF = $i
                        Else
                                $hDownload[$j] = ''
                        EndIf
                Next
                Do
                        For $t = Int(100 / $UpSize) To 100
                                Sleep(300)
                                $dif = TimerDiff($gxbegin)
                                $s = Round($dif / 1000)
                                For $j = 0 To $nD - 1
                                        If $hDownload[$j] <> '' Then
                                                $down[$j] = InetGetInfo($hDownload[$j], 0)
                                        Else
                                                $down[$j] = 0
                                        EndIf
                                Next
                                $s1 = getsize($down) + $yxz;已下载
                                $s3 = Round($s1 / $s);下载速度
                                If $s3 < 0 Then $s3 = 0 & 'k'
                                $stime = Round(($UpSize - $s1) / ($s3));剩余时间
                                If $stime < 0 Then $stime = ""
                                $t = ($s1 / $UpSize) * 100
                                If getsize($down) = $fdx Then ExitLoop
                        Next
                Until getsize($down) = $fdx
                For $j = 0 To $nD - 1
                        If $hDownload[$j] <> '' Then
                                $yxz += InetGetInfo($hDownload[$j], 0)
                                InetClose($hDownload[$j])
                        EndIf
                Next
        Next
        If $nF < $updataname[0] Then
                For $i = $nF To $updataname[0]
                        $fdx = $FlieSize_A[$i]
                        $url = $gxurl & StringReplace($updataname[$i], '\', '/')
                        $saveurl = @ScriptDir & "\TEMP\" & $updataname[$i]
                        $saveurl_tmp = StringMid($saveurl, 1, StringInStr($saveurl, '\', 0, -1))
                        If Not FileExists($saveurl_tmp) Then DirCreate($saveurl_tmp)
                        $shDownload = InetGet($url, $saveurl, 1, 1)
                        Do
                                For $t = Int((InetGetInfo($shDownload, 0) + $yxz) / $UpSize * 100) To 100
                                        Sleep(300)
                                        $dif = TimerDiff($gxbegin)
                                        $s = Round($dif / 1000)
                                        $s1 = InetGetInfo($shDownload, 0) + $yxz
                                        $s3 = Round($s1 / $s)
                                        If $s3 < 0 Then $s3 = 0 & 'k'
                                        $stime = Round(($UpSize - $s1) / ($s3))
                                        If $stime < 0 Then $stime = ""
                                        $t = ($s1 / $UpSize) * 100
                                        GUICtrlSetData($progressbar1, $t)
                                        GUICtrlSetData($gxmsg, '总计更新 ' & $zdx & @LF & '已经下载 ' _
                                                        & MylBytes($s1) & @LF & '下载速度 ' & MylBytes($s3) & '/s' & @LF & '剩余时间 ' & $stime & '秒')
                                        If InetGetInfo($shDownload, 0) = $fdx Then ExitLoop
                                Next
                        Until InetGetInfo($shDownload, 2)
                        $yxz = $yxz + (InetGetInfo($shDownload, 0))
                        InetClose($shDownload)
                Next
        EndIf
        For $i = 1 To $updataname[0]
                If $updataname[$i] = 'play.exe' Then
                        $upme = True
                Else
                        $move = FileMove(@ScriptDir & "\TEMP\" & $updataname[$i], @ScriptDir & "\" & $updataname[$i], 9)
                        If $move <> 1 Then
                                MsgBox(0, '', '更新失败！', 10, $GUI)
                                Exit
                        EndIf
                EndIf
        Next
EndFunc   ;==>gengxin

Func getsize($Array)
        Dim $size = 0 
        For $i = 0 To UBound($Array) - 1
                $size += $Array[$i]
        Next
        Return $size
EndFunc

Func getcrc32();校验文件是否需要更新
        Dim $file_crc32
        $file = FileOpen(@TempDir & "\up.ini", 0)
        While 1
                $Line = FileReadLine($file)
                If @error = -1 Then ExitLoop
                $filename = StringSplit($Line, '=')
                If Not @error Then
                        $CheckCrc32 = StringSplit($filename[2], '|')
                        If Not @error Then
                                $CRC32 = _CRC32ForFile($filename[1])
                                If $CRC32 <> $CheckCrc32[1] Then
                                        $file_crc32 &= $filename[1] & ","
                                        $FlieSize &= $CheckCrc32[2] & ","
                                        $UpSize += $CheckCrc32[2]
                                EndIf
                        EndIf
                EndIf
        WEnd
        FileClose($file)
        $FlieSize = StringTrimRight($FlieSize, 1)
        Return StringTrimRight($file_crc32, 1)
EndFunc

Func MylBytes($lBytes);换算大小
        If $lBytes < 1024 Then
                Return ($lBytes & "b")
        ElseIf $lBytes < 1048576 Then
                Return Round($lBytes / 1024, 2) & "k"
        ElseIf $lBytes < 536870912 Then
                Return Round($lBytes / (1024 ^ 2), 2) & "M"
        Else
                Return Round($lBytes / (1024 ^ 3), 2) & "G"
        EndIf
EndFunc

Func _makeup();生成up.ini
        If FileExists("up.ini") Then FileDelete("up.ini")
        $aFile = myFileListToArray(@ScriptDir, 0, 1)
        If IsArray($aFile) Then
                For $i = 1 To $aFile[0] Step 1
                        $file = StringReplace($aFile[$i], @ScriptDir & '\', "")
                        If $file <> @ScriptName Then
                        IniWrite("up.ini", "crc32", $file, _CRC32ForFile($file) & '|' & FileGetSize($file))
                        EndIf
                Next
        EndIf
EndFunc

Func _CRC32ForFile($sFile);crc32校验
        Local $a_hCall = DllCall("kernel32.dll", "hwnd", "CreateFileW", _
                        "wstr", $sFile, _
                        "dword", 0x80000000, _ ; GENERIC_READ
                        "dword", 1, _ ; FILE_SHARE_READ
                        "ptr", 0, _
                        "dword", 3, _ ; OPEN_EXISTING
                        "dword", 0, _ ; SECURITY_ANONYMOUS
                        "ptr", 0)
        If @error Or $a_hCall[0] = -1 Then
                Return SetError(1, 0, "")
        EndIf
        Local $hFile = $a_hCall[0]
        $a_hCall = DllCall("kernel32.dll", "ptr", "CreateFileMappingW", _
                        "hwnd", $hFile, _
                        "dword", 0, _ ; default security descriptor
                        "dword", 2, _ ; PAGE_READONLY
                        "dword", 0, _
                        "dword", 0, _
                        "ptr", 0)
        If @error Or Not $a_hCall[0] Then
                DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile)
                Return SetError(2, 0, "")
        EndIf
        DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile)
        Local $hFileMappingObject = $a_hCall[0]
        $a_hCall = DllCall("kernel32.dll", "ptr", "MapViewOfFile", _
                        "hwnd", $hFileMappingObject, _
                        "dword", 4, _ ; FILE_MAP_READ
                        "dword", 0, _
                        "dword", 0, _
                        "dword", 0)
        If @error Or Not $a_hCall[0] Then
                DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFileMappingObject)
                Return SetError(3, 0, "")
        EndIf
        Local $pFile = $a_hCall[0]
        Local $iBufferSize = FileGetSize($sFile)
        Local $a_iCall = DllCall("ntdll.dll", "dword", "RtlComputeCrc32", _
                        "dword", 0, _
                        "ptr", $pFile, _
                        "int", $iBufferSize)
        If @error Or Not $a_iCall[0] Then
                DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pFile)
                DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFileMappingObject)
                Return SetError(4, 0, "")
        EndIf
        DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pFile)
        DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFileMappingObject)
        Local $iCRC32 = $a_iCall[0]
        Return SetError(0, 0, Hex($iCRC32))
EndFunc

Func myFileListToArray($sPath, $rPath = 0, $iFlag = 0, $sPathExclude = 0);遍历目录
        Local $asFileList[1]
        $asFileList = myFileListToArrayTemp($asFileList, $sPath, $rPath, $iFlag, $sPathExclude)
        Return $asFileList
EndFunc

Func myFileListToArrayTemp(ByRef $asFileList, $sPath, $rPath = 0, $iFlag = 0, $sPathExclude = 0)
        Local $hSearch, $sFile
        If Not FileExists($sPath) Then Return SetError(1, 1, "")
        If Not ($iFlag = 0 Or $iFlag = 1 Or $iFlag = 2) Then Return SetError(3, 3, "")
        $hSearch = FileFindFirstFile($sPath & "\*")
        If $hSearch = -1 Then Return SetError(4, 4, "")
        While 1
                $sFile = FileFindNextFile($hSearch)
                If @error Then
                        SetError(0)
                        ExitLoop
                EndIf

                ;yidabu.com提示：已经被排除的路径，就不要搜索子目录了
                If $sPathExclude And StringLen($sPathExclude) > 0 Then $sPathExclude = StringSplit($sPathExclude, ",")
                $bExclude = False
                If IsArray($sPathExclude) Then
                        For $ii = 1 To $sPathExclude[0] Step 1
                                If StringInStr($sPath & "\" & $sFile, $sPathExclude[$ii]) Then
                                        $bExclude = True
                                        ExitLoop
                                EndIf
                        Next
                EndIf
                If $bExclude Then ContinueLoop

                Select
                        Case StringInStr(FileGetAttrib($sPath & "\" & $sFile), "D") ;如果遇到目录
                                Select
                                        Case $iFlag = 1 ;求文件时就递归
                                                myFileListToArrayTemp($asFileList, $sPath & "\" & $sFile, $rPath, $iFlag, $sPathExclude)
                                                ContinueLoop ;求文件时跳过目录
                                        Case $iFlag = 2 Or $iFlag = 0 ;求目录时分两种情况
                                                If $rPath Then ;1如果要求对路径进行正则匹配
                                                        If Not StringRegExp($sPath & "\" & $sFile, $rPath, 0) Then ;正则匹配失败就递归
                                                                myFileListToArrayTemp($asFileList, $sPath & "\" & $sFile, $rPath, $iFlag, $sPathExclude)
                                                                ContinueLoop ;正则匹配失败时跳过本目录
                                                        Else ;正则匹配成功就递归，并把本目录加入匹配成功
                                                                myFileListToArrayTemp($asFileList, $sPath & "\" & $sFile, $rPath, $iFlag, $sPathExclude)
                                                        EndIf
                                                Else ;2如果不要求对路径进行正则匹配，递归，并把本目录加入匹配成功，
                                                        myFileListToArrayTemp($asFileList, $sPath & "\" & $sFile, $rPath, $iFlag, $sPathExclude)
                                                EndIf
                                EndSelect

                        Case Not StringInStr(FileGetAttrib($sPath & "\" & $sFile), "D") ;如果遇到文件
                                If $iFlag = 2 Then ContinueLoop ;求目录时就跳过
                                ;yidabu.com提示：要求正则匹配路径，且匹配失败时就跳过。遇文件就不要递归调用了。
                                If $rPath And Not StringRegExp($sPath & "\" & $sFile, $rPath, 0) Then ContinueLoop
                EndSelect

                ReDim $asFileList[UBound($asFileList) + 1]
                $asFileList[0] = $asFileList[0] + 1
                $asFileList[UBound($asFileList) - 1] = $sPath & "\" & $sFile

        WEnd
        FileClose($hSearch)
        Return $asFileList
EndFunc