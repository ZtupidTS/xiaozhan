#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_Icon=D:\ProgrammeDesign\Autoit\Aut2Exe\Icons\configure.ico
#AutoIt3Wrapper_Compression=4
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
Opt("TrayAutoPause", 0)
Opt("TrayIconHide", 1)
 
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
 
Local $Title = "MAC随心换 - xayle", $Zero = "000000000000"
 
 
 
 
$Form1 = GUICreate($Title, 400, 96, -1, -1)
GUISetFont(9, 400, 0, "Tahoma")
$NICInfo = GUICtrlCreateLabel(_Regedit(3), 0, 8, 400, 18, $SS_CENTER)
$OldMACl = GUICtrlCreateLabel("原始MAC:", 6, 30, 56, 18)
$NewMACl = GUICtrlCreateLabel("随机MAC:", 6, 52, 56, 18)
$ModifyMAC = GUICtrlCreateButton("更换(&M)", 290, 28, 52, 20, 0)
$RestorMAC = GUICtrlCreateButton("还原(&R)", 344, 28, 52, 20, 0)
$DemandMAC = GUICtrlCreateButton("手动输入", 290, 52, 60, 20, 0)
$LogRecord = GUICtrlCreateCheckbox("记录", 354, 52, 42, 20, 0)
If _Regedit(4) <> $Zero Then
        $OldMAC = GUICtrlCreateLabel("当前网卡MAC地址已被修改,点击还原恢复.", 60, 30, 224, 18)
Else
        $OldMAC = GUICtrlCreateLabel(_GetNICInfo(1), 60, 30, 120, 18)
EndIf
If _Regedit(4) == $Zero Then
        $NewMAC = GUICtrlCreateLabel("当前网卡MAC地址未被修改,点击更换修改.", 60, 52, 224, 18)
Else
        $NewMAC = GUICtrlCreateLabel(_GetNICInfo(1), 60, 52, 120, 18)
EndIf
$GuiTip = GUICtrlCreateLabel("", 5, 76, 390, 18, $SS_CENTER)
GUICtrlSetColor($OldMAC, 0x0000FF)
GUICtrlSetColor($NewMAC, 0x008080)
GUICtrlSetColor($GuiTip, 0x800000)
GUICtrlSetTip($ModifyMAC, "自动生成并修改MAC,重启网卡.")
GUICtrlSetTip($RestorMAC, "还原为原始MAC,重启网卡.")
GUICtrlSetTip($DemandMAC, "手动输入并修改MAC,重启网卡.")
GUICtrlSetTip($LogRecord, "记录修改日志到桌面.")
GUICtrlSetState($LogRecord, $GUI_CHECKED)
GUISetState(@SW_SHOW)
 
While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
                Case $GUI_EVENT_CLOSE
                        Exit
                Case $ModifyMAC
                        $MakeMAC = _MakeMAC()
                        WinSetTitle($Title, "", $Title & " :: " & "正在更换网卡MAC地址,请稍候...")
                        GUICtrlSetData($GuiTip, "网卡MAC地址随机更换为 " & _ConvMAC($MakeMAC))
                        _GuiState(0)
                        _ModifyMAC($MakeMAC)
                        WinSetTitle($Title, "", $Title & " :: " & "正在重新启动网卡,请稍候...")
                        _ReStartNIC("Modify")
                        GUICtrlSetData($NewMAC, _GetNICInfo(1))
                        GUICtrlSetData($GuiTip, "本机网卡的MAC地址更换为 " & _GetNICInfo(1))
                        If GUICtrlRead($LogRecord) = $GUI_CHECKED Then _LogRecord(0)
                        _GuiState(1)
                Case $RestorMAC
                        If _Regedit(4) <> $Zero Then
                                WinSetTitle($Title, "", $Title & " :: " & "正在还原网卡MAC地址,请稍候...")
                                _GuiState(0)
                                _ModifyMAC($Zero)
                                WinSetTitle($Title, "", $Title & " :: " & "正在重新启动网卡,请稍候...")
                                _ReStartNIC("Restor")
                                GUICtrlSetData($OldMAC, _GetNICInfo(1))
                                GUICtrlSetData($GuiTip, "本机网卡的MAC地址还原为 " & _GetNICInfo(1))
                                If GUICtrlRead($LogRecord) = $GUI_CHECKED Then _LogRecord(2)
                                _GuiState(1)
                        Else
                                GUICtrlSetData($GuiTip, "当前网卡MAC地址未被修改!")
                        EndIf
                Case $DemandMAC
                        $MACInput = InputBox("手动输入MAC", "正确MAC应为[0~9,A~F]共12个字符" & @CRLF & "示例:" & _ConvMAC(_MakeMAC()) & @CRLF & _
                                        "示例:" & _ConvMAC(_MakeMAC(), "-") & @CRLF & "示例:" & _ConvMAC(_MakeMAC(), " "), _ConvMAC(_MakeMAC()), " 17", -1, 140)
                        If Not @error Then
                                $MakeMAC = _ChecMAC($MACInput)
                                WinSetTitle($Title, "", $Title & " :: " & "正在更换网卡MAC地址,请稍候...")
                                GUICtrlSetData($GuiTip, "网卡MAC地址随机更换为 " & _ConvMAC($MakeMAC))
                                _GuiState(0)
                                _ModifyMAC($MakeMAC)
                                WinSetTitle($Title, "", $Title & " :: " & "正在重新启动网卡,请稍候...")
                                _ReStartNIC("Modify")
                                GUICtrlSetData($NewMAC, _GetNICInfo(1))
                                GUICtrlSetData($GuiTip, "已将本机网卡的MAC地址更改为 " & _GetNICInfo(1))
                                If GUICtrlRead($LogRecord) = $GUI_CHECKED Then _LogRecord(1)
                                _GuiState(1)
                        Else
                                GUICtrlSetData($GuiTip, "取消手动输入MAC更改.")
                        EndIf
        EndSwitch
WEnd
 
Func _MakeMAC()
        Local $tt = "00", $t[16] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, "A", "B", "C", "D", "E", "F"]
        For $i = 0 To 9
                $tt &= $t[Random(0, 15, 1)]
        Next
        Return $tt
EndFunc   ;==>_MakeMAC
 
 
Func _ConvMAC($ConvMAC, $int = 0, $Gap = ":")
        If $int = 0 Then
                $ConvMAC = StringRegExp($ConvMAC, "[0-9a-fA-F]{2}", 3)
                $ConvMAC = $ConvMAC[0] & $Gap & $ConvMAC[1] & $Gap & $ConvMAC[2] & $Gap & $ConvMAC[3] & $Gap & $ConvMAC[4] & $Gap & $ConvMAC[5]
                Return $ConvMAC
        Else
                $ConvMAC = StringReplace(StringReplace(StringReplace($ConvMAC, " ", ""), "-", ""), ":", "")
                Return $ConvMAC
        EndIf
EndFunc   ;==>_ConvMAC
 
Func _ChecMAC($ChecMAC)
        $ChecMAC = StringUpper($ChecMAC)
        If StringLen($ChecMAC) <= 17 Then
                $ChecMAC = _ConvMAC($ChecMAC, 1)
                If StringLen($ChecMAC) == 12 Then
                        If Not StringIsXDigit($ChecMAC) Then
                                GUICtrlSetData($GuiTip, "MAC输入[" & $MACInput & "]错误!正确应为[0~9,A~F]共12个字符.")
                        Else
                                GUICtrlSetData($GuiTip, "MAC输入[" & _ConvMAC($ChecMAC) & "]正确!可以更换.")
                                Return $ChecMAC
                        EndIf
                Else
                        GUICtrlSetData($GuiTip, "MAC输入[" & $MACInput & "]错误!正确应为[0~9,A~F]共12个字符.")
                EndIf
        Else
                GUICtrlSetData($GuiTip, "MAC输入[" & $MACInput & "]错误!正确应为[0~9,A~F]共12个字符.")
        EndIf
EndFunc   ;==>_ChecMAC
 
Func _ModifyMAC($RandMAC)
        If _Regedit(1) = _Regedit(2) Then
                RegWrite(_Regedit(0), "NetworkAddress", "REG_SZ", $RandMAC)
                $Path = _Regedit(0) & "\Ndi\Params\NetworkAddress\"
                RegWrite($Path)
                RegWrite($Path, "ParamDesc", "REG_SZ", "Network Address")
                RegWrite($Path, "Default", "REG_SZ", $RandMAC)
                RegWrite($Path, "Optional", "REG_SZ", "1")
        Else
                GUICtrlSetData($GuiTip, "检测到网卡修改后可能会出现问题!禁止修改!")
        EndIf
EndFunc   ;==>_ModifyMAC
 
Func _Regedit($n)
        $Path = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\" & _GetNICInfo(2)
        $ComponentId = RegRead($Path, "ComponentId")
        $MatchingDeviceId = RegRead($Path, "MatchingDeviceId")
        $DriverDesc = RegRead($Path, "DriverDesc")
        $NetworkAddress = RegRead($Path, "NetworkAddress")
        Switch $n
                Case 0
                        Return $Path
                Case 1
                        Return $ComponentId
                Case 2
                        Return $MatchingDeviceId
                Case 3
                        Return $DriverDesc
                Case 4
                        Return $NetworkAddress
        EndSwitch
EndFunc   ;==>_Regedit
 
Func _GuiState($n)
        Switch $n
                Case 0
                        GUICtrlSetState($ModifyMAC, $GUI_DISABLE)
                        GUICtrlSetState($RestorMAC, $GUI_DISABLE)
                        GUICtrlSetState($DemandMAC, $GUI_DISABLE)
                        GUICtrlSetState($LogRecord, $GUI_DISABLE)
                Case 1
                        GUICtrlSetState($ModifyMAC, $GUI_ENABLE)
                        GUICtrlSetState($RestorMAC, $GUI_ENABLE)
                        GUICtrlSetState($DemandMAC, $GUI_ENABLE)
                        GUICtrlSetState($LogRecord, $GUI_ENABLE)
        EndSwitch
EndFunc   ;==>_GuiState
 
Func _LogRecord($Demand = 0)
        $LogFile = @DesktopDir & "\" & $Title & " 更换记录.txt"
        $NowTime = @YEAR & "/" & @MON & "/" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC
        $tmp = _GetNICInfo(1)
        Switch $Demand
                Case 0
                        FileWriteLine($LogFile, "生成时间: " & $NowTime & Chr("44") & "生成MAC: " & $tmp & Chr("44") & "自动生成")
                Case 1
                        FileWriteLine($LogFile, "生成时间: " & $NowTime & Chr("44") & "生成MAC: " & $tmp & Chr("44") & "手动输入")
                Case 2
                        FileWriteLine($LogFile, "生成时间: " & $NowTime & Chr("44") & "生成MAC: " & $tmp & Chr("44") & "恢复原始")
        EndSwitch
EndFunc   ;==>_LogRecord
 
Func _GetNICInfo($n)
        $strComputer = "."
        $objWMIService = ObjGet("winmgmts:\\" & $strComputer & "\root\cimv2")
        $colItems = $objWMIService.ExecQuery("Select * From Win32_NetworkAdapterConfiguration Where IPEnabled = True")
        For $objItem In $colItems
                If StringLeft($objItem.MACAddress, 2) = 00 Then
                        $MACAdress = $objItem.MACAddress
                        $Key = StringMid($objItem.Caption, 6, 4)
                        $DriverDesc = $objItem.Description
                EndIf
        Next
        Switch $n
                Case 1
                        Return $MACAdress
                Case 2
                        Return $Key
                Case 3
                        Return $DriverDesc
        EndSwitch
EndFunc   ;==>_GetNICInfo
 
Func _ReStartNIC($r)
        $devcon = "dev.con"
        FileInstall("devcon.exe", $devcon)
        If FileExists($devcon) Then
                $tmp = TimerInit()
                If $r = "Modify" Then
                        While StringReplace(_GetNICInfo(1), ":", "") <> _Regedit(4)
                                RunWait($devcon & " restart =net pci\*", "", @SW_HIDE)
                                Do
                                        WinSetTitle($Title, "", $Title & " :: " & "网卡重启中,请稍候...")
                                        $Sec = Int(TimerDiff($tmp) / 1000) & "." & StringRight(Int(TimerDiff($tmp)), 3)
                                        GUICtrlSetData($GuiTip, "等候网卡初始化,已过:" & $Sec & "秒.")
                                        $ping = Ping("www.baidu.com")
                                Until Not @error
                                WinSetTitle($Title, "", $Title)
                        WEnd
                ElseIf $r = "Restor" Then
                        While _Regedit(4) = $Zero
                                RunWait($devcon & " restart =net pci\*", "", @SW_HIDE)
                                Do
                                        WinSetTitle($Title, "", $Title & " :: " & "网卡重启中,请稍候...")
                                        $Sec = Int(TimerDiff($tmp) / 1000) & "." & StringRight(Int(TimerDiff($tmp)), 3)
                                        GUICtrlSetData($GuiTip, "等候网卡初始化,已过:" & $Sec & "秒.")
                                        $ping = Ping("www.baidu.com")
                                Until Not @error
                                WinSetTitle($Title, "", $Title)
                                If StringReplace(_GetNICInfo(1), ":", "") <> _Regedit(4) Then ExitLoop
                        WEnd
                EndIf
                FileDelete($devcon)
        Else
                GUICtrlSetData($GuiTip, "缺少devcon.exe文件!" & @CRLF & "请重新启动主程序!")
                Sleep(1000)
                Exit
        EndIf
EndFunc   ;==>_ReStartNIC