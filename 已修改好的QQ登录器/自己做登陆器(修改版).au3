;#NoTrayIcon
#include <ButtonConstants.au3>
#include <GUIConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Include <GuiListView.au3>
#include <ListViewConstants.au3>
#include <GuiImageList.au3>
;#include <QQpswd.au3>
;#include "md5.au3"


Opt('GUIResizeMode', 802)

$Version = "QQLoginV2.0_By_5i3p"
If WinExists($Version) Then Exit
AutoItWinSetTitle($Version)

_CreatIni()        
Global $NumList[2], $List1, $List2
$IniFile = @ScriptDir&"\Config.ini"
$Window = GUICreate("QQ自动登录器", 367, 300, 192, 114)
GUICtrlCreateGroup("请选择您要登陆的QQ号码:", 4, 8, 361, 289)
$List1 = GUICtrlCreateListView("      QQ号码   |昵称        |上次登陆时间", 10, 32, 245, 233)
GUICtrlSendMsg($List1, $LVM_SETEXTENDEDLISTVIEWSTYLE, $LVS_EX_GRIDLINES, $LVS_EX_GRIDLINES)
GUICtrlSetTip(-1, "刷新列表后，红色表示现在已在本机登陆的号码")
Dim $B_DESCENDING[_GUICtrlListView_GetColumnCount($List1)]
$Denglu = GUICtrlCreateButton("登陆", 268, 26, 83, 25, 0)
$Refresh = GUICtrlCreateButton("刷新列表", 268, 60, 83, 25, 0)
$Run = GUICtrlCreateButton("运行QQ", 268, 94, 83, 25, 0)
$Set = GUICtrlCreateButton("设置", 268, 128, 83, 25, 0)
$ADD = GUICtrlCreateButton("添加QQ", 268, 160, 83, 25, 0)
;GUICtrlSetColor(-1, 0x0000FF)
$Close = GUICtrlCreateButton("关闭所有QQ", 268, 192, 83, 25, 0)
$About = GUICtrlCreateButton("关于(&A)", 268, 226, 83, 25, 0)
$Exit = GUICtrlCreateButton("退出(&X)", 268, 260, 83, 25, 0)
$Check = GUICtrlCreateCheckbox("登陆完成后关闭登录器", 10, 272, 153, 17)
GUICtrlCreateLabel("By: 范统.贾", 189, 274, 78, 17)
GUICtrlSetState(-1, $GUI_DISABLE)
GUISetState(@SW_SHOW)

While 1
	$QQFile = IniRead($IniFile, "腾讯QQ", "安装路径", "")
    $QQPath = _Getpath($QQFile)
       $nMsg = GUIGetMsg()
        Switch $nMsg
                Case $GUI_EVENT_CLOSE
                        Exit
                
			Case $Set
				set()
			Case $ADD
				ADD()
                Case $About
                        _About()
                Case $Check
                        If GUICtrlRead($Check) = $GUI_CHECKED Then
                                IniWrite($IniFile, "软件设置", "登陆后退出", "是")
                        Else
                                IniWrite($IniFile, "软件设置", "登陆后退出", "否")
                        EndIf
                Case $Close
                        _CloseAllQQ()
                Case $Denglu                        
                        If _GUICtrlListView_GetSelectedCount($List1) = 0 Then
                           MsgBox(64, "提示", "请先选择您要登陆的QQ号码后再试！")
                           ContinueLoop
                        ElseIf StringRight($QQFile, 7) <> "\QQ.exe" Then
                                MsgBox(64, "", "您设置得QQ路径不存在，或者设置错误。"&@CRLF&@CRLF&"如果您用的绿色版QQ请手动指定路径，路径必须为QQ.exe结尾。"&@CRLF&@CRLF&"点击“设置”按钮设置好路径后再试！")
                        Else
                                $Num = _GUICtrlListView_GetItemText($List1, Int(_GUICtrlListView_GetSelectedIndices($List1)))
                                $PassTemp = IniRead($IniFile, $Num, "密码", "")
                                $Pass = _Password(0, $PassTemp, '用户保存的QQ密码',5)
                                $StatTemp = IniRead($IniFile, "QQ列表", $Num, "")
                                If $StatTemp = "隐身" Then 
                                        $Status = 40
                                Else
                                        $Status = 41
                                EndIf
                                Run($QQFile & " /START QQUIN:" & $Num & " PWDHASH:" & Str2QQPwdHash($Pass) & " /STAT:" & $Status)
                                IniWrite($IniFile, $Num, "上次登陆时间", @YEAR & @MON & @MDAY)
                        EndIf
                        If GUICtrlRead($Check) = $GUI_CHECKED Then Exit
                
                Case $Run
                        Run($QQFile, $QQPath)
                Case $Refresh
                        GUICtrlSendMsg($List1, $LVM_DeleteALLITEMS, 0, 0)
                        _ShowList()
		
                Case $List1
                        _GUICtrlListView_SimpleSort($List1, $B_DESCENDING, GUICtrlGetState($List1))        
        EndSwitch

        _ReduceMemory(@AutoItPID)
WEnd


Func set()
$IniFile = @ScriptDir&"\Config.ini"
$from = GUICreate("设置", 430, 310, 192, 124)
GUICtrlCreateGroup("功能设置",8, 8, 415, 295)
GUICtrlCreateLabel("QQ程序所在路径:", 32, 85, 95, 17)
$Input = GUICtrlCreateInput(IniRead($IniFile, "腾讯QQ", "安装路径", ""), 130, 80, 241, 21)
$Zidong = GUICtrlCreateButton("自动查找", 100, 200, 89, 25, 0)
$Shoudong = GUICtrlCreateButton("手动指定", 265, 200, 89, 25, 0)
GUISetState(@SW_SHOW)
While 1
	 $QQFile = IniRead($IniFile, "腾讯QQ", "安装路径", "")
    $QQPath = _Getpath($QQFile)
        ;$nMsg = GUIGetMsg()
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
	              Case $Shoudong
                        $Value = FileOpenDialog("请选择QQ所在的目录...", @ProgramFilesDir, "可执行文件(*.exe)")
                        GUICtrlSetData($Input, $Value)
                        IniWrite($IniFile, "腾讯QQ", "安装路径", $Value)
                Case $Zidong
                        $Value = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\TENCENT\QQ", "install")
                        GUICtrlSetData($Input, $Value &"QQ.exe")
                        IniWrite($IniFile, "腾讯QQ", "安装路径", $Value &"QQ.exe")

	EndSwitch
WEnd
EndFunc

Func ADD()
$from12 = GUICreate("添加QQ", 400, 250, 192, 124)
GUICtrlCreateGroup("QQ号码编辑", 8, 8, 401, 281)
$List2 = GUICtrlCreateList("", 15, 26, 135, 200, BitOR($WS_BORDER, $WS_VSCROLL, $LBS_NOTIFY))
$Tianjia = GUICtrlCreateButton("添加", 180, 60, 83, 25, 0)
$Shanchu = GUICtrlCreateButton("删除", 300, 60, 83, 25, 0)
$Bianji = GUICtrlCreateButton("编辑", 180, 120 ,83, 25, 0)
$Shuaxin = GUICtrlCreateButton("刷新", 300, 120, 83, 25, 0)
GUISetState(@SW_SHOW)
_ShowList()
While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
			 Case $Tianjia
				_Tianjia()
				
		 	         If GUICtrlRead($Check) = $GUI_CHECKED Then Exit
                Case $Bianji
                        If GUICtrlRead($List2) = "" Then
                                MsgBox(64, "提示", "请先选择您要编辑的QQ号码后再试！")
                        Else
                                _EditQQ()
                        EndIf
                Case $Shuaxin
                        _ShowQQ()
			Case $Shanchu
                        If  GUICtrlRead($List2) = "" Then
                                MsgBox(64, "提示", "请先选择您要编辑的QQ号码后再试！")
                        Else
                                IniDelete(@ScriptDir&"\config.ini",GUICtrlRead($List2))
                            IniDelete(@ScriptDir&"\config.ini","QQ列表",GUICtrlRead($List2))
                               _ShowQQ()
                                MsgBox(64, "提示", "删除成功！")
                        EndIf
                        GUICtrlSendMsg($List1, $LVM_DeleteALLITEMS, 0, 0)
                        _ShowList()
                Case $List1
                        _GUICtrlListView_SimpleSort($List1, $B_DESCENDING, GUICtrlGetState($List1))        
        EndSwitch

        _ReduceMemory(@AutoItPID)
	WEnd
EndFunc	

Func _About()
        GUISetState(@SW_DISABLE, $Window)
        $AboutWindow = GUICreate("关于...", 235, 240, 565, 114)
        GUICtrlCreateIcon (@AutoItExe,-1,22,40)
        GUICtrlCreateGroup("", 8, 4, 220, 195)
        $Label1 = GUICtrlCreateLabel("QQ自动登陆器 V2.0", 70, 40, 142, 17, $WS_GROUP)
        GUICtrlSetFont(-1, 10, 800, 0, "宋体")
        GUICtrlCreateLabel("范统.贾(修改版)", 70, 80, 100, 17)
        $Mail = GUICtrlCreateLabel("5i3p@sina.com", 70, 102, 100, 17)
        GuiCtrlSetCursor($Mail,0)
    GUICtrlSetColor(-1, 0x0000FF)
        GUICtrlCreateLabel("版权为PCBar所有，盗版大概不究。", 20, 144, 200, 17, $WS_GROUP)
        GUICtrlCreateLabel("欢迎加入QQ群227200 (AU3技术交流)", 20, 168, 194, 17)
        GUICtrlCreateGroup("", -99, -99, 1, 1)
        $OK = GUICtrlCreateButton("确定(&O)", 90, 208, 75, 25)
        GUISetState(@SW_SHOW)

        While 1
                Switch GUIGetMsg()
                        Case $GUI_EVENT_CLOSE
                                        GUISetState(@SW_ENABLE,$Window)
                                        GUIDelete($AboutWindow)
                                        ExitLoop
                        Case $OK
                                        GUISetState(@SW_ENABLE,$Window)
                                        GUIDelete($AboutWindow)
                                        ExitLoop
                        Case $Mail
                                        Run(@ComSpec & " /c " & 'start mailto:5i3p@sina.com?subject=Something', "", @SW_HIDE)
                EndSwitch
                _ReduceMemory(@AutoItPID)
        WEnd
EndFunc;<==关于窗口

Func _Tianjia()
        GUISetState(@SW_DISABLE, $Window)
        $AddWindow = GUICreate("添加QQ号码", 281, 178, 565, 516)
        GUICtrlCreateGroup("请输入QQ账号信息", 2, 8, 276, 125)
        GUICtrlCreateLabel("QQ号码:", 16, 33, 47, 16)
        GUICtrlCreateLabel("QQ密码:", 16, 59, 47, 16)
        GUICtrlCreateLabel("重复密码:", 16, 84, 55, 16)
        $UseNick = GUICtrlCreateCheckbox("使用自定义昵称:", 16, 110, 113, 17)
        $QQ = GUICtrlCreateInput("", 72, 30, 137, 21, $ES_NUMBER,$WS_EX_STATICEDGE)
        GUICtrlSetLimit(-1, 10)
        $Mima = GUICtrlCreateInput("", 72, 56, 193, 20, $ES_PASSWORD,$WS_EX_STATICEDGE)
        $Remima = GUICtrlCreateInput("", 72, 81, 193, 20, $ES_PASSWORD,$WS_EX_STATICEDGE)
        $NickName = GUICtrlCreateInput("", 128, 107, 137, 20)
        GUICtrlSetState(-1, $GUI_DISABLE)
        GUICtrlSetLimit(-1, 4)
        $Yinshen = GUICtrlCreateCheckbox("隐身", 224, 32, 41, 17)
        $Save = GUICtrlCreateButton("保存(&S)", 50, 145, 65, 25, 0)
        $Cancel = GUICtrlCreateButton("取消(&C)", 160, 145, 65, 25, 0)
        ControlFocus("添加QQ号码", "", "Edit1")
        GUISetState(@SW_SHOW)
        
    While 1
                Switch GUIGetMsg()
                        Case $GUI_EVENT_CLOSE
                                GUISetState(@SW_ENABLE,$Window)
                                GUIDelete($AddWindow)
                                ExitLoop
                        Case $Cancel
                                GUISetState(@SW_ENABLE,$Window)
                                GUIDelete($AddWindow)
                                ExitLoop
                        Case $UseNick
                                If GUICtrlRead($UseNick) = $GUI_CHECKED        Then
                                        GUICtrlSetState($NickName, $GUI_ENABLE)
                                Else
                                        GUICtrlSetState($NickName, $GUI_DISABLE)
                                EndIf
                        Case $Save
                                if GUICtrlRead($QQ)="" then
                           MsgBox(64, "提示", "请输入QQ号码!")
                                   ContinueLoop
                                EndIf
                                If GUICtrlRead($Mima) = GUICtrlRead($Remima) Then
                                                If GUICtrlRead($Yinshen) = $gui_checked Then
                                                        IniWrite($IniFile, "QQ列表", GUICtrlRead($QQ), "隐身")
                                                Else
                                                        IniWrite($IniFile, "QQ列表", GUICtrlRead($QQ), "在线")
                                                EndIf
                                                IniWrite($IniFile, GUICtrlRead($QQ), "密码", _Password(1, GUICtrlRead($Mima), '用户保存的QQ密码',5))
                                                if  GUICtrlRead($UseNick) = $gui_checked Then
                                                        IniWrite($IniFile,GUICtrlRead($QQ),"昵称",GUICtrlRead($NickName))
                                                EndIf
                                                _ShowQQ()
                                Else
                                                MsgBox(64, "注意", "两次输入的密码不一样，请重输！")
                                                ContinueLoop
                                EndIf
                                GUISetState(@SW_ENABLE,$Window)
                                GUIDelete($AddWindow)
                                ExitLoop
                EndSwitch
                _ReduceMemory(@AutoItPID)
        WEnd
        GUICtrlSendMsg($List1, $LVM_DeleteALLITEMS, 0, 0)
        _ShowList()
EndFunc;<==添加号码窗口

Func _EditQQ()
        GUISetState(@SW_DISABLE, $Window)
        $AddWindow = GUICreate("编辑QQ号码", 281, 178, 565, 516)
        GUICtrlCreateGroup("请输入QQ账号信息", 2, 8, 276, 125)
        GUICtrlCreateLabel("QQ号码:", 16, 33, 47, 16)
        GUICtrlCreateLabel("QQ密码:", 16, 59, 47, 16)
        GUICtrlCreateLabel("重复密码:", 16, 84, 55, 16)
        $UseNick = GUICtrlCreateCheckbox("使用自定义昵称:", 16, 110, 113, 17)
        $QQ = GUICtrlCreateInput("", 72, 30, 137, 21, $ES_NUMBER,$WS_EX_STATICEDGE)
        GUICtrlSetLimit(-1,10)
        $Mima = GUICtrlCreateInput("", 72, 56, 193, 20, $ES_PASSWORD,$WS_EX_STATICEDGE)
        $Remima = GUICtrlCreateInput("", 72, 81, 193, 20, $ES_PASSWORD,$WS_EX_STATICEDGE)
        $NickName = GUICtrlCreateInput("", 128, 107, 137, 20)
        GUICtrlSetState(-1, $GUI_DISABLE)
        GUICtrlSetLimit(-1, 4)
        $Yinshen = GUICtrlCreateCheckbox("隐身", 224, 32, 41, 17)
        $Save = GUICtrlCreateButton("保存(&S)", 50, 145, 65, 25, 0)
        $Cancel = GUICtrlCreateButton("取消(&C)", 160, 145, 65, 25, 0)
        $tempmima = IniRead($IniFile, _GUICtrlListBox_GetText($List2, _GUICtrlListBox_GetCurSel($List2)), "密码", "")
        GUICtrlSetData($QQ,  _GUICtrlListBox_GetText($List2, _GUICtrlListBox_GetCurSel($List2)))
        GUICtrlSetState($QQ, $GUI_DISABLE)
        GUICtrlSetData($Mima, _password(0, $tempmima, "用户保存的QQ密码", 5))
        GUICtrlSetData($Remima, _password(0, $tempmima, "用户保存的QQ密码", 5))
        If IniRead($IniFile, _GUICtrlListBox_GetText($List2, _GUICtrlListBox_GetCurSel($List2)), "昵称", "") <> "" Then 
                GUICtrlSetState($UseNick, $GUI_CHECKED)
                GUICtrlSetState($NickName, $GUI_ENABLE)
            GUICtrlSetData($NickName, IniRead($IniFile, _GUICtrlListBox_GetText($List2, _GUICtrlListBox_GetCurSel($List2)), "昵称", ""))
        EndIf
        
        If IniRead($IniFile, "QQ列表", _GUICtrlListBox_GetText($List2, _GUICtrlListBox_GetCurSel($List2)), "") = "隐身" Then
                GUICtrlSetState($Yinshen, $GUI_CHECKED)
        Else
                GUICtrlSetState($Yinshen, $GUI_UNCHECKED)
        EndIf
        ControlFocus("编辑QQ号码", "", "Edit2")
        GUISetState(@SW_SHOW)
        
    While 1
                Switch GUIGetMsg()
                        Case $GUI_EVENT_CLOSE
                                GUISetState(@SW_ENABLE,$Window)
                                GUIDelete($AddWindow)
                                ExitLoop
                        Case $Cancel
                                GUISetState(@SW_ENABLE,$Window)
                                GUIDelete($AddWindow)
                                ExitLoop
                        Case $UseNick
                                If GUICtrlRead($UseNick) = $GUI_CHECKED        Then
                                        GUICtrlSetState($NickName, $GUI_ENABLE)
                                Else
                                        GUICtrlSetState($NickName, $GUI_DISABLE)
                                EndIf
                        Case $Save
                                if GUICtrlRead($QQ)="" then
                           MsgBox(64, "提示", "请输入QQ号码!")
                                   ContinueLoop
                            EndIf
                                If GUICtrlRead($Mima) = GUICtrlRead($Remima) Then
                                                If GUICtrlRead($Yinshen) = $gui_checked Then
                                                        IniWrite($IniFile, "QQ列表", GUICtrlRead($QQ), "隐身")
                                                Else
                                                        IniWrite($IniFile, "QQ列表", GUICtrlRead($QQ), "在线")
                                                EndIf
                                                IniWrite($IniFile, GUICtrlRead($QQ), "密码", _Password(1, GUICtrlRead($Mima), '用户保存的QQ密码',5))
                                                if  GUICtrlRead($UseNick) = $gui_checked Then
                                                        IniWrite($IniFile,GUICtrlRead($QQ),"昵称",GUICtrlRead($NickName))
                                                EndIf
                                        _ShowQQ()
                                Else
                                                MsgBox(64, "注意", "两次输入的密码不一样，请重输！")
                                                ContinueLoop
                                EndIf
                                GUISetState(@SW_ENABLE,$Window)
                                GUIDelete($AddWindow)
                                ExitLoop
                EndSwitch
                _ReduceMemory(@AutoItPID)
        WEnd
        GUICtrlSendMsg($List1, $LVM_DeleteALLITEMS, 0, 0)
        _ShowList()
EndFunc;<==编辑号码窗口

Func _CreatIni()
        If Not FileExists(@ScriptDir&"\Config.ini") Then
                $file = FileOpen(@ScriptDir&"\Config.ini", 1)
                FileWriteLine($file, "[软件设置]")
                FileWriteLine($file, "登陆后退出=否"& @CRLF & @CRLF)
                FileWriteLine($file, "[腾讯QQ]")
                FileWriteLine($file, "安装路径="& @CRLF & @CRLF)
                FileClose($file)
        EndIf
EndFunc;<==建立Config.ini配置文件

Func _Getpath($x)
        If Not FileExists($x) Then
                Return ""
        EndIf
        Local $tmp
        $tmp = StringInStr($x, "\", 0, -1)
        Return StringLeft($x, $tmp - 1)
EndFunc ;<==获得不带"\"结尾的路径

Func _CloseAllQQ()
        If Not ProcessExists("QQ.exe") Then
                MsgBox(262144, "提示", "没QQ在运行你关闭个什么劲儿哦？", 2)
        Else
                $QQlist = ProcessList("QQ.exe")
                If @error Then Return
                If IsArray($QQlist) Then
                        For $i = 1 To $QQlist[0][0]
                                ProcessClose($QQlist[$i][1])
                        Next
                EndIf
                MsgBox(262144, "提示", "所有的QQ都已关闭。", 2)
        EndIf
        GUICtrlSendMsg($List1, $LVM_DeleteALLITEMS, 0, 0)
        _ShowList()
EndFunc ;<==关闭所有QQ

Func _ShowQQ()
        GUICtrlSetData($List2, "")
        Local $QQNumbers
        $QQNumbers = IniReadSection($IniFile, "QQ列表")
        If IsArray($QQNumbers) Then
                For $i = 1 To $QQNumbers[0][0]
                        _GUICtrlListBox_AddString($List2, $QQNumbers[$i][0])
                Next
        Else
                Return
        EndIf
EndFunc;<==刷新List2里的QQ列表

Func _ShowList()
        $Number = IniReadSection($IniFile, "QQ列表")
        If IsArray($Number) Then 
                ReDim $NumList[$Number[0][0]]
                For $i = 1 To $Number[0][0]
                        $NumList[$i - 1] = $Number[$i][0]
                        $Stat = IniRead($IniFile, "QQ列表", $Number[$i][0], "")
                        $LastDate = _MyDate(IniRead($IniFile, $Number[$i][0], "上次登陆时间", "Never Logined"))
                        $Name = IniRead($IniFile, $Number[$i][0], "昵称", "Default")
                        $item = GUICtrlCreateListViewItem($Number[$i][0]&"|"&$Name&"|"&$LastDate, $List1)
                        If Round($i/2) <> $i/2 Then GUICtrlSetBkColor($item, 0xEEEEEE)
                        If $Stat = "隐身" Then
                           GUICtrlSetImage($item, @ScriptDir&"\Hide.ico")
                    Else
                           GUICtrlSetImage($item, @ScriptDir&"\Online.ico")
                        EndIf
            $var = WinList()
                        For $e = 1 to $var[0][0]
                                If $var[$e][0] <> "" Then
                                $s = StringInStr ($var[$e][0], "_QQMusic_SmallClient")
                                        if $s <> 0 then 
                                                $ms = StringLeft ( $var[$e][0], $s-1)
                                                if $Number[$i][0] = $ms Then GUICtrlSetColor(-1, 0xFF0000)
                                        EndIf
                                EndIf
                        Next
                Next
        EndIf
        If IniRead($IniFile, "软件设置", "登陆后退出", "") = "是" Then
                GUICtrlSetState($Check, $GUI_CHECKED)
        Else
                GUICtrlSetState($Check, $GUI_UNCHECKED)
        EndIf
EndFunc   ;==>显示，刷新List1

Func _MyDate($tmpdate)
        If StringIsDigit($tmpdate) Then
                $t1 = StringLeft($tmpdate, 4) & "." & StringMid($tmpdate, 5, 2) & "." & StringMid($tmpdate, 7, 2)
                Return $t1
        Else
                Return $tmpdate
        EndIf
EndFunc ;<==上次登陆时间

Func _ReduceMemory($i_PID = -1)
        If $i_PID <> -1 Then
                Local $ai_Handle = DllCall("kernel32.dll", 'int', 'OpenProcess', 'int', 0x1f0fff, 'int', False, 'int', $i_PID)
                Local $ai_Return = DllCall("psapi.dll", 'int', 'EmptyWorkingSet', 'long', $ai_Handle[0])
                DllCall('kernel32.dll', 'int', 'CloseHandle', 'int', $ai_Handle[0])
        Else
                Local $ai_Return = DllCall("psapi.dll", 'int', 'EmptyWorkingSet', 'long', -1)
        EndIf
    Return $ai_Return[0]
EndFunc ;<==释放内存
        
Func _PassWord($jiami_lp, $jiami_txt,$jiami_pas,$jiami_lev)
    Local $tlev,$bhb,$jjxc =1,$Num
    Local $jh[100]
    If $jiami_txt='' Or $jiami_pas='' Or StringLen ($jiami_pas) > 100 _
        Or $jiami_lev > 9 Or Int($jiami_lev)<>$jiami_lev Or $jiami_lev < 0 Then Return -1    
    If $jiami_lp = 1 Then
        $sosu=StringLen ($jiami_pas)
        For $pa_s=1 To $sosu
            $jh[$pa_s]=Asc(StringMid($jiami_pas,$pa_s,1))
            $Num=$Num&$jh[$pa_s]
            If $jjxc > 3 Then $jjxc=1
            If $jjxc=1 Then
                $bhb=Int($bhb+$jh[$pa_s])
            ElseIf    $jjxc=2 Then
                $bhb=Int($bhb*$jh[$pa_s])
            ElseIf    $jjxc=3 Then
                $bhb=Int($bhb-$jh[$pa_s])
            EndIf        
            $jjxc +=1
        Next
        $Num=StringLeft($Num, $jiami_lev)&$bhb&StringRight($Num, $jiami_lev)
        $jiami_txt=StringTrimLeft(StringToBinary($jiami_txt,2),2)
        $y_si=$sosu
        $j_si=1
        Do    
            $vi=StringMid($jh[$j_si],1,1)+StringMid($jh[$y_si],StringLen ($jh[$y_si]),1)
            $tempa=StringMid($jiami_txt,1,$vi-1)
            $tempb=StringMid($jiami_txt,$vi)
            $jiami_txt=$tempa&$jh[$j_si]&$tempb
            $y_si -=1
            $j_si +=1
        Until $y_si <= 0 And $j_si >= $sosu
        $st=StringLen ($Num)
        $txtshi=StringLen ($jiami_txt)
        For $kl=1 To $st
            $rtemp=''
            For $vn=1 To $txtshi Step StringMid($Num,$kl,1)+30
                $rtemp = StringMid($jiami_txt,$vn,StringMid($Num,$kl,1)+30)&$rtemp
            Next    
            $jiami_txt=$rtemp
        Next    
        Return $jiami_txt
    ElseIf $jiami_lp = 0 Then
        $sosu=StringLen ($jiami_pas)
        For $pa_s=1 To $sosu
            $jh[$pa_s]=Asc(StringMid($jiami_pas,$pa_s,1))
            $Num=$Num&$jh[$pa_s]
            If $jjxc > 3 Then $jjxc=1
            If $jjxc=1 Then
                $bhb=Int($bhb+$jh[$pa_s])
            ElseIf    $jjxc=2 Then
                $bhb=Int($bhb*$jh[$pa_s])
            ElseIf    $jjxc=3 Then
                $bhb=Int($bhb-$jh[$pa_s])
            EndIf        
            $jjxc +=1            
        Next
        $Num=StringLeft($Num, $jiami_lev)&$bhb&StringRight($Num, $jiami_lev)
        $st=StringLen ($Num)
        Do     
            $txtshi=StringLen ($jiami_txt)
            $rtemp=''
            Do     
                $rtemp =$rtemp&StringRight ($jiami_txt, StringMid($Num,$st,1)+30)
                $jiami_txt=StringTrimRight ($jiami_txt, StringMid($Num,$st,1)+30)
                $txtshi -= StringMid($Num,$st,1)+30    
            Until $txtshi <= 0
            $jiami_txt=$rtemp
            $st -=1
        Until $st <= 0    
        $y_si=$sosu
        $j_si=1
        Do
            $vi=StringMid($jh[$y_si],1,1)+StringMid($jh[$j_si],StringLen ($jh[$j_si]),1)
            $tempa=StringMid($jiami_txt,1,$vi-1)
            $tempb=StringMid($jiami_txt,$vi+StringLen ($jh[$y_si]))
            $jiami_txt=$tempa&$tempb    
            $y_si -=1
            $j_si +=1            
        Until $y_si <= 0
        $jiami_txt='0x'&$jiami_txt
        $jiami_txt = BinaryToString($jiami_txt,2)
        Return $jiami_txt
    Else
        Return -1
    EndIf
EndFunc ;<==加密解密函数 
;************************************************************************
;==================================================
;加密函数
;       _StringMD5($sMessage)
;
;===============================================

Const $BITS_TO_A_BYTE  = 8
Const $BYTES_TO_A_WORD = 4
Const $BITS_TO_A_WORD  = $BYTES_TO_A_WORD * $BITS_TO_A_BYTE

Dim $m_lOnBits[31]
Dim $m_l2Power[31]

Func Class_Initialize()
    ; Could have done this with a loop calculating each value, but simply
    ; assigning the values is quicker - BITS SET FROM RIGHT
    $m_lOnBits[0] = 1            ; 00000000000000000000000000000001
    $m_lOnBits[1] = 3            ; 00000000000000000000000000000011
    $m_lOnBits[2] = 7            ; 00000000000000000000000000000111
    $m_lOnBits[3] = 15           ; 00000000000000000000000000001111
    $m_lOnBits[4] = 31           ; 00000000000000000000000000011111
    $m_lOnBits[5] = 63           ; 00000000000000000000000000111111
    $m_lOnBits[6] = 127          ; 00000000000000000000000001111111
    $m_lOnBits[7] = 255          ; 00000000000000000000000011111111
    $m_lOnBits[8] = 511          ; 00000000000000000000000111111111
    $m_lOnBits[9] = 1023         ; 00000000000000000000001111111111
    $m_lOnBits[10] = 2047        ; 00000000000000000000011111111111
    $m_lOnBits[11] = 4095        ; 00000000000000000000111111111111
    $m_lOnBits[12] = 8191        ; 00000000000000000001111111111111
    $m_lOnBits[13] = 16383       ; 00000000000000000011111111111111
    $m_lOnBits[14] = 32767       ; 00000000000000000111111111111111
    $m_lOnBits[15] = 65535       ; 00000000000000001111111111111111
    $m_lOnBits[16] = 131071      ; 00000000000000011111111111111111
    $m_lOnBits[17] = 262143      ; 00000000000000111111111111111111
    $m_lOnBits[18] = 524287      ; 00000000000001111111111111111111
    $m_lOnBits[19] = 1048575     ; 00000000000011111111111111111111
    $m_lOnBits[20] = 2097151     ; 00000000000111111111111111111111
    $m_lOnBits[21] = 4194303     ; 00000000001111111111111111111111
    $m_lOnBits[22] = 8388607     ; 00000000011111111111111111111111
    $m_lOnBits[23] = 16777215    ; 00000000111111111111111111111111
    $m_lOnBits[24] = 33554431    ; 00000001111111111111111111111111
    $m_lOnBits[25] = 67108863    ; 00000011111111111111111111111111
    $m_lOnBits[26] = 134217727   ; 00000111111111111111111111111111
    $m_lOnBits[27] = 268435455   ; 00001111111111111111111111111111
    $m_lOnBits[28] = 536870911   ; 00011111111111111111111111111111
    $m_lOnBits[29] = 1073741823  ; 00111111111111111111111111111111
    $m_lOnBits[30] = 2147483647  ; 01111111111111111111111111111111
    

    $m_l2Power[0] = 1            ; 00000000000000000000000000000001
    $m_l2Power[1] = 2            ; 00000000000000000000000000000010
    $m_l2Power[2] = 4            ; 00000000000000000000000000000100
    $m_l2Power[3] = 8            ; 00000000000000000000000000001000
    $m_l2Power[4] = 16           ; 00000000000000000000000000010000
    $m_l2Power[5] = 32           ; 00000000000000000000000000100000
    $m_l2Power[6] = 64           ; 00000000000000000000000001000000
    $m_l2Power[7] = 128          ; 00000000000000000000000010000000
    $m_l2Power[8] = 256          ; 00000000000000000000000100000000
    $m_l2Power[9] = 512          ; 00000000000000000000001000000000
    $m_l2Power[10] = 1024        ; 00000000000000000000010000000000
    $m_l2Power[11] = 2048        ; 00000000000000000000100000000000
    $m_l2Power[12] = 4096        ; 00000000000000000001000000000000
    $m_l2Power[13] = 8192        ; 00000000000000000010000000000000
    $m_l2Power[14] = 16384       ; 00000000000000000100000000000000
    $m_l2Power[15] = 32768       ; 00000000000000001000000000000000
    $m_l2Power[16] = 65536       ; 00000000000000010000000000000000
    $m_l2Power[17] = 131072      ; 00000000000000100000000000000000
    $m_l2Power[18] = 262144      ; 00000000000001000000000000000000
    $m_l2Power[19] = 524288      ; 00000000000010000000000000000000
    $m_l2Power[20] = 1048576     ; 00000000000100000000000000000000
    $m_l2Power[21] = 2097152     ; 00000000001000000000000000000000
    $m_l2Power[22] = 4194304     ; 00000000010000000000000000000000
    $m_l2Power[23] = 8388608     ; 00000000100000000000000000000000
    $m_l2Power[24] = 16777216    ; 00000001000000000000000000000000
    $m_l2Power[25] = 33554432    ; 00000010000000000000000000000000
    $m_l2Power[26] = 67108864    ; 00000100000000000000000000000000
    $m_l2Power[27] = 134217728   ; 00001000000000000000000000000000
    $m_l2Power[28] = 268435456   ; 00010000000000000000000000000000
    $m_l2Power[29] = 536870912   ; 00100000000000000000000000000000
    $m_l2Power[30] = 1073741824  ; 01000000000000000000000000000000
EndFunc


Func LShift($lValue,  $iShiftBits)

    If $iShiftBits = 0 Then
        Return $lValue
        
        

    ElseIf $iShiftBits = 31 Then
        If BitAND($lValue, 1) Then
            Return 0x80000000
        Else
            Return 0
        Endif
        
        

    ElseIf $iShiftBits < 0 Or $iShiftBits > 31 Then
        SetError(6)
    Endif
    

    If BitAND($lValue, $m_l2Power[31 - $iShiftBits]) Then
    

        Return BitOR((BitAND($lValue, $m_lOnBits[31 - ($iShiftBits + 1)]) * _
            $m_l2Power[$iShiftBits]) , 0x80000000)
    
    Else
    

        Return (BitAND($lValue, $m_lOnBits[31 - $iShiftBits]) * _
            $m_l2Power[$iShiftBits])
        
    Endif
EndFunc


Func RShift($lValue, $iShiftBits)
    
	Local $RShift
	

    If $iShiftBits = 0 Then
        Return $lValue
        

    ElseIf $iShiftBits = 31 Then
        If BitAND($lValue, 0x80000000) Then
            Return 1
        Else
            Return 0
        Endif
        

    ElseIf $iShiftBits < 0 Or $iShiftBits > 31 Then
        SetError(6)
    Endif
    

    $RShift = int(BitAND($lValue, 0x7FFFFFFE) / $m_l2Power[$iShiftBits])
    

    If BitAND($lValue, 0x80000000) Then

        $RShift = int(BitOR($RShift, (0x40000000 / $m_l2Power[$iShiftBits - 1])))
    Endif
	
	Return $RShift
	
EndFunc


Func RShiftSigned($lValue , $iShiftBits)

    If $iShiftBits = 0 Then
        Return $lValue

    ElseIf $iShiftBits = 31 Then
       
        If BitAND($lValue, 0x80000000) Then
            Return -1
        Else
            Return 0
        Endif

    ElseIf $iShiftBits < 0 Or $iShiftBits > 31 Then
        SetError(6)
    Endif
    

    Return Int($lValue / $m_l2Power[$iShiftBits])
EndFunc


Func RotateLeft($lValue , $iShiftBits)
    Return BitOR(LShift($lValue, $iShiftBits), RShift($lValue, (32 - $iShiftBits)))
EndFunc


Func AddUnsigned($lX , $lY )
 
    $lX8 = BitAND($lX, 0x80000000)
    $lY8 = BitAND($lY, 0x80000000)
    $lX4 = BitAND($lX, 0x40000000)
    $lY4 = BitAND($lY, 0x40000000)
 
    $lResult = BitAND($lX, 0x3FFFFFFF) + BitAND($lY, 0x3FFFFFFF)
 
    If BitAND($lX4, $lY4) Then
        $lResult = BitXOR($lResult, 0x80000000, $lX8, $lY8)
    ElseIf BitOR($lX4 , $lY4) Then
        If BitAND($lResult, 0x40000000) Then
            $lResult = BitXOR($lResult, 0xC0000000, $lX8, $lY8)
        Else
            $lResult = BitXOR($lResult, 0x40000000, $lX8, $lY8)
        Endif
    Else
        $lResult = BitXOR($lResult, $lX8, $lY8)
    Endif
 
    Return $lResult
EndFunc
Func F($x , $y , $z )
    Return BitOR(BitAND($x, $y) , BitAND((BitNOT($x)), $z))
EndFunc


Func G($x , $y , $z )
    Return BitOR(BitAND($x, $z) , BitAND($y , (BitNOT($z))))
EndFunc


Func H($x , $y , $z )
    Return BitXOR($x , $y , $z)
EndFunc


Func I($x , $y , $z )
    Return BitXOR($y , BitOR($x , (BitNOT($z))))
EndFunc


Func FF(ByRef $a , $b , $c , $d , $x , $s , $ac )
    $a = AddUnsigned($a, AddUnsigned(AddUnsigned(F($b, $c, $d), $x), $ac))
    $a = RotateLeft($a, $s)
    $a = AddUnsigned($a, $b)
EndFunc


Func GG(ByRef $a , $b , $c , $d , $x , $s , $ac )
    $a = AddUnsigned($a, AddUnsigned(AddUnsigned(G($b, $c, $d), $x), $ac))
    $a = RotateLeft($a, $s)
    $a = AddUnsigned($a, $b)
EndFunc


Func HH(ByRef $a , $b , $c , $d , $x , $s , $ac )
    $a = AddUnsigned($a, AddUnsigned(AddUnsigned(H($b, $c, $d), $x), $ac))
    $a = RotateLeft($a, $s)
    $a = AddUnsigned($a, $b)
EndFunc


Func II(ByRef $a , $b , $c , $d , $x , $s , $ac )
    $a = AddUnsigned($a, AddUnsigned(AddUnsigned(I($b, $c, $d), $x), $ac))
    $a = RotateLeft($a, $s)
    $a = AddUnsigned($a, $b)
EndFunc


Func ConvertToWordArray($sMessage )
    Dim $lWordArray[1]
    
    Const $MODULUS_BITS     = 512
    Const $CONGRUENT_BITS   = 448
    
    $lMessageLength = StringLen($sMessage)
    

    $lNumberOfWords = (int(($lMessageLength + _
        int(($MODULUS_BITS - $CONGRUENT_BITS) / $BITS_TO_A_BYTE)) / _
        int($MODULUS_BITS / $BITS_TO_A_BYTE)) + 1) * _
        int($MODULUS_BITS / $BITS_TO_A_WORD)
    ReDim $lWordArray[$lNumberOfWords]
    

    $lBytePosition = 0
    $lByteCount = 0
    Do 

        $lWordCount = int($lByteCount / $BYTES_TO_A_WORD)

        $lBytePosition = (Mod($lByteCount , $BYTES_TO_A_WORD)) * $BITS_TO_A_BYTE
        $lWordArray[$lWordCount] = BitOR($lWordArray[$lWordCount] , _
            LShift(Asc(StringMid($sMessage, $lByteCount + 1, 1)), $lBytePosition))
        $lByteCount = $lByteCount + 1
    Until $lByteCount >= $lMessageLength

    $lWordCount = int($lByteCount / $BYTES_TO_A_WORD)
    $lBytePosition = (Mod($lByteCount , $BYTES_TO_A_WORD)) * $BITS_TO_A_BYTE
    $lWordArray[$lWordCount] = BitOR($lWordArray[$lWordCount] , _
        LShift(0x80, $lBytePosition))

    $lWordArray[$lNumberOfWords - 2] = LShift($lMessageLength, 3)
    $lWordArray[$lNumberOfWords - 1] = RShift($lMessageLength, 29)
    
    Return $lWordArray
EndFunc


Func WordToHex($lValue)
    
	$WordToHex=""
	
    For $lCount = 0 To 3
        $lByte = BitAND(RShift($lValue, $lCount * $BITS_TO_A_BYTE) , _
            $m_lOnBits[$BITS_TO_A_BYTE - 1])
        $WordToHex = $WordToHex & StringRight("0" & Hex($lByte,2), 2)
    Next
	Return $WordToHex
EndFunc


Func _StringMD5($sMessage)
    
    Const $S11  = 7
    Const $S12  = 12
    Const $S13  = 17
    Const $S14  = 22
    Const $S21  = 5
    Const $S22  = 9
    Const $S23  = 14
    Const $S24  = 20
    Const $S31  = 4
    Const $S32  = 11
    Const $S33  = 16
    Const $S34  = 23
    Const $S41  = 6
    Const $S42  = 10
    Const $S43  = 15
    Const $S44  = 21

    Class_Initialize()
	

    $x = ConvertToWordArray($sMessage)
    
    ; Step 3.  Initialise
    $a = 0x67452301
    $b = 0xEFCDAB89
    $c = 0x98BADCFE
    $d = 0x10325476


    For $k = 0 To UBound($x)-1 Step 16
        $AA = $a
        $BB = $b
        $CC = $c
        $DD = $d

        FF( $a, $b, $c, $d, $x[$k + 0], $S11, 0xD76AA478 )
        FF( $d, $a, $b, $c, $x[$k + 1], $S12, 0xE8C7B756 )
        FF( $c, $d, $a, $b, $x[$k + 2], $S13, 0x242070DB )
        FF( $b, $c, $d, $a, $x[$k + 3], $S14, 0xC1BDCEEE )
        FF( $a, $b, $c, $d, $x[$k + 4], $S11, 0xF57C0FAF )
        FF( $d, $a, $b, $c, $x[$k + 5], $S12, 0x4787C62A )
        FF( $c, $d, $a, $b, $x[$k + 6], $S13, 0xA8304613 )
        FF( $b, $c, $d, $a, $x[$k + 7], $S14, 0xFD469501 )
        FF( $a, $b, $c, $d, $x[$k + 8], $S11, 0x698098D8 )
        FF( $d, $a, $b, $c, $x[$k + 9], $S12, 0x8B44F7AF )
        FF( $c, $d, $a, $b, $x[$k + 10], $S13, 0xFFFF5BB1)
        FF( $b, $c, $d, $a, $x[$k + 11], $S14, 0x895CD7BE)
        FF( $a, $b, $c, $d, $x[$k + 12], $S11, 0x6B901122)
        FF( $d, $a, $b, $c, $x[$k + 13], $S12, 0xFD987193)
        FF( $c, $d, $a, $b, $x[$k + 14], $S13, 0xA679438E)
        FF( $b, $c, $d, $a, $x[$k + 15], $S14, 0x49B40821)
    
        GG( $a, $b, $c, $d, $x[$k + 1], $S21, 0xF61E2562 )
        GG( $d, $a, $b, $c, $x[$k + 6], $S22, 0xC040B340 )
        GG( $c, $d, $a, $b, $x[$k + 11], $S23, 0x265E5A51)
        GG( $b, $c, $d, $a, $x[$k + 0], $S24, 0xE9B6C7AA )
        GG( $a, $b, $c, $d, $x[$k + 5], $S21, 0xD62F105D )
        GG( $d, $a, $b, $c, $x[$k + 10], $S22, 0x2441453 )
        GG( $c, $d, $a, $b, $x[$k + 15], $S23, 0xD8A1E681)
        GG( $b, $c, $d, $a, $x[$k + 4], $S24, 0xE7D3FBC8 )
        GG( $a, $b, $c, $d, $x[$k + 9], $S21, 0x21E1CDE6 )
        GG( $d, $a, $b, $c, $x[$k + 14], $S22, 0xC33707D6)
        GG( $c, $d, $a, $b, $x[$k + 3], $S23, 0xF4D50D87 )
        GG( $b, $c, $d, $a, $x[$k + 8], $S24, 0x455A14ED )
        GG( $a, $b, $c, $d, $x[$k + 13], $S21, 0xA9E3E905)
        GG( $d, $a, $b, $c, $x[$k + 2], $S22, 0xFCEFA3F8 )
        GG( $c, $d, $a, $b, $x[$k + 7], $S23, 0x676F02D9 )
        GG( $b, $c, $d, $a, $x[$k + 12], $S24, 0x8D2A4C8A)
            
        HH( $a, $b, $c, $d, $x[$k + 5], $S31, 0xFFFA3942 )
        HH( $d, $a, $b, $c, $x[$k + 8], $S32, 0x8771F681 )
        HH( $c, $d, $a, $b, $x[$k + 11], $S33, 0x6D9D6122)
        HH( $b, $c, $d, $a, $x[$k + 14], $S34, 0xFDE5380C)
        HH( $a, $b, $c, $d, $x[$k + 1], $S31, 0xA4BEEA44 )
        HH( $d, $a, $b, $c, $x[$k + 4], $S32, 0x4BDECFA9 )
        HH( $c, $d, $a, $b, $x[$k + 7], $S33, 0xF6BB4B60 )
        HH( $b, $c, $d, $a, $x[$k + 10], $S34, 0xBEBFBC70)
        HH( $a, $b, $c, $d, $x[$k + 13], $S31, 0x289B7EC6)
        HH( $d, $a, $b, $c, $x[$k + 0], $S32, 0xEAA127FA )
        HH( $c, $d, $a, $b, $x[$k + 3], $S33, 0xD4EF3085 )
        HH( $b, $c, $d, $a, $x[$k + 6], $S34, 0x4881D05  )
        HH( $a, $b, $c, $d, $x[$k + 9], $S31, 0xD9D4D039 )
        HH( $d, $a, $b, $c, $x[$k + 12], $S32, 0xE6DB99E5)
        HH( $c, $d, $a, $b, $x[$k + 15], $S33, 0x1FA27CF8)
        HH( $b, $c, $d, $a, $x[$k + 2], $S34, 0xC4AC5665 )
    
        II( $a, $b, $c, $d, $x[$k + 0], $S41, 0xF4292244 )
        II( $d, $a, $b, $c, $x[$k + 7], $S42, 0x432AFF97 )
        II( $c, $d, $a, $b, $x[$k + 14], $S43, 0xAB9423A7)
        II( $b, $c, $d, $a, $x[$k + 5], $S44, 0xFC93A039 )
        II( $a, $b, $c, $d, $x[$k + 12], $S41, 0x655B59C3)
        II( $d, $a, $b, $c, $x[$k + 3], $S42, 0x8F0CCC92 )
        II( $c, $d, $a, $b, $x[$k + 10], $S43, 0xFFEFF47D)
        II( $b, $c, $d, $a, $x[$k + 1], $S44, 0x85845DD1 )
        II( $a, $b, $c, $d, $x[$k + 8], $S41, 0x6FA87E4F )
        II( $d, $a, $b, $c, $x[$k + 15], $S42, 0xFE2CE6E0)
        II( $c, $d, $a, $b, $x[$k + 6], $S43, 0xA3014314 )
        II( $b, $c, $d, $a, $x[$k + 13], $S44, 0x4E0811A1)
        II( $a, $b, $c, $d, $x[$k + 4], $S41, 0xF7537E82 )
        II( $d, $a, $b, $c, $x[$k + 11], $S42, 0xBD3AF235)
        II( $c, $d, $a, $b, $x[$k + 2], $S43, 0x2AD7D2BB )
        II( $b, $c, $d, $a, $x[$k + 9], $S44, 0xEB86D391 )
    
        $a = AddUnsigned($a, $AA)
        $b = AddUnsigned($b, $BB)
        $c = AddUnsigned($c, $CC)
        $d = AddUnsigned($d, $DD)
    Next
    

   Return StringLower(WordToHex($a) & WordToHex($b) & WordToHex($c) & WordToHex($d))
EndFunc

;************************************************************************

Func Hex2Bin($HexStr1)
dim $q1
Select
Case $HexStr1="0"
$q1 = "0000"
Case $HexStr1="1"
$q1 = "0001"
Case $HexStr1="2"
$q1 = "0010"
Case $HexStr1="3"
$q1 = "0011"
Case $HexStr1="4"
$q1 = "0100"
Case $HexStr1="5"
$q1 = "0101"
Case $HexStr1="6"
$q1 = "0110"
Case $HexStr1="7"
$q1 = "0111"
Case $HexStr1="8"
$q1 = "1000"
Case $HexStr1="9"
$q1 = "1001"
Case $HexStr1="A"
$q1 = "1010"
Case $HexStr1="B"
$q1 = "1011"
Case $HexStr1="C"
$q1 = "1100"
Case $HexStr1="D"
$q1 = "1101"
Case $HexStr1="E"
$q1 = "1110"
Case $HexStr1="F"
$q1 = "1111"
EndSelect
$Hex2Bin=$q1
Return $Hex2Bin
EndFunc

Func Hex2Bin1($HexStr2)
$q1 = Hex2Bin(stringMid($HexStr2, 1, 1))
$q2 = Hex2Bin(stringMid($HexStr2, 2, 1))
$q3 = Hex2Bin(stringMid($HexStr2, 3, 1))
$q4 = Hex2Bin(stringMid($HexStr2, 4, 1))
$q5 = Hex2Bin(stringMid($HexStr2, 5, 1))
$q6 = Hex2Bin(stringMid($HexStr2, 6, 1))
$q7 = Hex2Bin(stringMid($HexStr2, 7, 1))
$q8 = Hex2Bin(stringMid($HexStr2, 8, 1))
$q9 = Hex2Bin(stringMid($HexStr2, 9, 1))
$q10 = Hex2Bin(stringMid($HexStr2, 10, 1))
$q11 = Hex2Bin(stringMid($HexStr2, 11, 1))
$q12 = Hex2Bin(stringMid($HexStr2, 12, 1))
$Hex2Bin1 = $q1&$q2&$q3&$q4&$q5&$q6&$q7&$q8&$q9&$q10&$q11&$q12
Return $Hex2Bin1
EndFunc

Func Bin324($BinCode1)
$q1 = stringMid($BinCode1, 1, 6)
$q2 = stringMid($BinCode1, 7, 6)
$q3 = stringMid($BinCode1, 13, 6)
$q4 = stringMid($BinCode1, 19, 6)
$q5 = stringMid($BinCode1, 25, 6)
$q6 = stringMid($BinCode1, 31, 6)
$q7 = stringMid($BinCode1, 37, 6)
$q8 = stringMid($BinCode1, 43, 6)
$Bin324 = "00"&$q1&"00"&$q2&"00"&$q3&"00"&$q4&"00"&$q5&"00"&$q6&"00"&$q7&"00"&$q8
Return $Bin324
EndFunc

Func Bin2Hex($BinCode2)
	Dim $q1
Select 
Case $BinCode2="0000"
$q1 = "0"
Case $BinCode2="0001"
$q1 = "1"
Case $BinCode2="0010"
$q1 = "2"
Case $BinCode2="0011"
$q1 = "3"
Case $BinCode2="0100"
$q1 = "4"
Case $BinCode2="0101"
$q1 = "5"
Case $BinCode2="0110"
$q1 = "6"
Case $BinCode2="0111"
$q1 = "7"
Case $BinCode2="1000"
$q1 = "8"
Case $BinCode2="1001"
$q1 = "9"
Case $BinCode2="1010"
$q1 = "A"
Case $BinCode2="1011"
$q1 = "B"
Case $BinCode2="1100"
$q1 = "C"
Case $BinCode2="1101"
$q1 = "D"
Case $BinCode2="1110"
$q1 = "E"
Case $BinCode2="1111"
$q1 = "F"
EndSelect
$Bin2Hex = $q1
Return $Bin2Hex
EndFunc

Func Bin2Hex2($BinCode)
$q1 = Bin2Hex(stringMid($BinCode, 1, 4))
$q2 = Bin2Hex(stringMid($BinCode, 5, 4))
$q3 = Bin2Hex(stringMid($BinCode, 9, 4))
$q4 = Bin2Hex(stringMid($BinCode, 13, 4))
$Bin2Hex2 =$q1&$q2&$q3&$q4
Return $Bin2Hex2
EndFunc

Func Bin2Hex3($BinCode3)
$q1 = Bin2Hex2(stringMid($BinCode3, 1, 16))
$q2 = Bin2Hex2(stringMid($BinCode3, 17, 16))
$q3 = Bin2Hex2(stringMid($BinCode3, 33, 16))
$q4 = Bin2Hex2(stringMid($BinCode3, 49, 16))
$Bin2Hex3 =$q1&$q2&$q3&$q4
Return $Bin2Hex3
EndFunc

Func HexBase64($HexString)
$HexBase64 = HexBase64_2(Bin2Hex3(Bin324(Hex2Bin1($HexString))))
Return $HexBase64
EndFunc

Func HexBase64_1($HexString)
	Dim $q1
Select
Case $HexString="00"
$q1 = "A"
Case $HexString="01"
$q1 = "B"
Case $HexString="02"
$q1 = "C"
Case $HexString="03"
$q1 = "D"
Case $HexString="04"
$q1 ="E"
Case $HexString="05"
$q1 = "F"
Case $HexString="06"
$q1 = "G"
Case $HexString="07"
$q1 = "H"
Case $HexString="08"
$q1 = "I"
Case $HexString="09"
$q1 = "J"
Case $HexString="0A"
$q1 = "K"
Case $HexString="0B"
$q1 = "L"
Case $HexString="0C"
$q1 = "M"
Case $HexString="0D"
$q1 = "N"
Case $HexString="0E"
$q1 = "O"
Case $HexString="0F"
$q1 = "P"
Case $HexString="10"
$q1 = "Q"
Case $HexString="11"
$q1 = "R"
Case $HexString="12"
$q1 = "S"
Case $HexString="13"
$q1 = "T"
Case $HexString="14"
$q1 = "U"
Case $HexString="15"
$q1 = "V"
Case $HexString="16"
$q1 = "W"
Case $HexString="17"
$q1 = "X"
Case $HexString="18"
$q1 = "Y"
Case $HexString="19"
$q1 = "Z"
Case $HexString="1A"
$q1 = "a"
Case $HexString="1B"
$q1 = "b"
Case $HexString="1C"
$q1 = "c"
Case $HexString="1D"
$q1 = "d"
Case $HexString="1E"
$q1 = "e"
Case $HexString="1F"
$q1 = "f"
Case $HexString="20"
$q1 = "g"
Case $HexString="21"
$q1 = "h"
Case $HexString="22"
$q1 = "i"
Case $HexString="23"
$q1 = "j"
Case $HexString="24"
$q1 = "k"
Case $HexString="25"
$q1 = "l"
Case $HexString="26"
$q1 = "m"
Case $HexString="27"
$q1 = "n"
Case $HexString="28"
$q1 = "o"
Case $HexString="29"
$q1 = "p"
Case $HexString="2A"
$q1 = "q"
Case $HexString="2B"
$q1 = "r"
Case $HexString="2C"
$q1 = "s"
Case $HexString="2D"
$q1 = "t"
Case $HexString="2E"
$q1 = "u"
Case $HexString="2F"
$q1 = "v"
Case $HexString="30"
$q1 = "w"
Case $HexString="31"
$q1 = "x"
Case $HexString="32"
$q1 = "y"
Case $HexString="33"
$q1 = "z"
Case $HexString="34"
$q1 = "0"
Case $HexString="35"
$q1 = "1"
Case $HexString="36"
$q1 = "2"
Case $HexString="37"
$q1 = "3"
Case $HexString="38"
$q1 = "4"
Case $HexString="39"
$q1 = "5"
Case $HexString="3A"
$q1 = "6"
Case $HexString="3B"
$q1 = "7"
Case $HexString="3C"
$q1 = "8"
Case $HexString="3D"
$q1 = "9"
Case $HexString="3E"
$q1 = "+"
Case $HexString="3F"
$q1 = "/"
EndSelect
$HexBase64_1 = $q1
Return $HexBase64_1
EndFunc

Func HexBase64_2($HexString)
$q1 = HexBase64_1(stringMid($HexString, 1, 2))
$q2 = HexBase64_1(stringMid($HexString, 3, 2))
$q3 = HexBase64_1(stringMid($HexString, 5, 2))
$q4 = HexBase64_1(stringMid($HexString, 7, 2))
$q5 = HexBase64_1(stringMid($HexString, 9, 2))
$q6 = HexBase64_1(stringMid($HexString, 11, 2))
$q7 = HexBase64_1(stringMid($HexString, 13, 2))
$q8 = HexBase64_1(stringMid($HexString, 15, 2))
$HexBase64_2 =$q1&$q2&$q3&$q4&$q5&$q6&$q7&$q8
Return $HexBase64_2
EndFunc

Func Hex2Base64($HexCode)
	Dim $q1
For $i = 0 To stringLen($HexCode) Step 12
$q1 = $q1&HexBase64(stringMid($HexCode, $i+1, 12))
Next
$Hex2Base64 = $q1
Return $Hex2Base64
EndFunc



Func Str2QQPwdHash($Str1)
$Str2QQPwdHash = Hex2Base64(_StringMD5($Str1)) & "=="
Return $Str2QQPwdHash
EndFunc

;############################################################