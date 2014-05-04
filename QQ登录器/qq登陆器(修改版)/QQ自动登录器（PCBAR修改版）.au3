#Region ACN预处理程序参数(常用参数)
#PRE_Icon= 										;图标,支持EXE,DLL,ICO
#PRE_OutFile=									;输出文件名
#PRE_OutFile_Type=exe							;文件类型
#PRE_Compression=4								;压缩等级
#PRE_UseUpx=y 									;使用压缩
#PRE_Res_Comment= 								;程序注释
#PRE_Res_Description=							;详细信息
#PRE_Res_Fileversion=							;文件版本
#PRE_Res_FileVersion_AutoIncrement=p			;自动更新版本
#PRE_Res_LegalCopyright= 						;版权
#PRE_Change2CUI=N                   			;修改输出的程序为CUI(控制台程序)
;#PRE_Res_Field=AutoIt Version|%AutoItVer%		;自定义资源段
;#PRE_Run_Tidy=                   				;脚本整理
;#PRE_Run_Obfuscator=      						;代码迷惑
;#PRE_Run_AU3Check= 							;语法检查
;#PRE_Run_Before= 								;运行前
;#PRE_Run_After=								;运行后
;#PRE_UseX64=n									;使用64位解释器
;#PRE_Compile_Both								;进行双平台编译
#EndRegion ACN预处理程序参数设置完成
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿

 Au3 版本: 
 脚本作者: 
 电子邮件: 
	QQ/TM: 
 脚本版本: 
 脚本功能: 

#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿

#NoTrayIcon
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
#include <QQPwd.au3>
 
Opt('GUIResizeMode', 802)
 
$Version = "QQLoginV2.0_By_5i3p"
If WinExists($Version) Then Exit
AutoItWinSetTitle($Version)
 
If Not FileExists(@ScriptDir&"\Config.ini") Then RegDelete("HKCU\Software\QQLogin", "NeedPWD")
 
If RegRead("HKCU\Software\QQLogin", "NeedPWD") = "1" Then
        $setpwd = RegRead("HKCU\Software\QQLogin", "PassWord")
        For $i = 1 To 3
                $pwd_00 = InputBox("权限认证:", '该软件已被设置为需要密码才能进入!' &@LF&@LF& '请输入密码:', "", "*M30", "-1", "150", "-1", "-1")
                If @error = 1 Then Exit
                If $pwd_00 <> $setpwd Then
                        If $i = 3 Then
                                MsgBox(16, "警告！", "三次都不对，你肯定是非法用户！" &@LF&@LF& "请勿再尝试，否则将自动接通电话到当地110。")
                                Exit
                        EndIf
                        MsgBox(48, "提示", "密码不对，请重输！", 2)
                Else
                        ExitLoop
                EndIf
        Next
EndIf
 
FileInstall("Hide.ico", @ScriptDir & "\Hide.ico")
FileInstall("Online.ico", @ScriptDir & "\Online.ico")
_CreatIni()     
Global $NumList[2]
$IniFile = @ScriptDir&"\Config.ini"
$Window = GUICreate("QQ自动登录器", 367, 300, 192, 114)
GUICtrlCreateGroup("请选择您要登陆的QQ号码:", 4, 8, 361, 289)
$List1 = GUICtrlCreateListView("      QQ号码   |昵称        |上次登陆时间", 10, 32, 245, 233)
GUICtrlSendMsg($List1, $LVM_SETEXTENDEDLISTVIEWSTYLE, $LVS_EX_GRIDLINES, $LVS_EX_GRIDLINES)
GUICtrlSetTip(-1, "刷新列表后，红色表示现在已在本机登陆的号码")
Dim $B_DESCENDING[_GUICtrlListView_GetColumnCount($List1)]
$Denglu = GUICtrlCreateButton("登陆", 268, 32, 83, 25, 0)
$Refresh = GUICtrlCreateButton("刷新列表", 268, 68, 83, 25, 0)
$Run = GUICtrlCreateButton("运行QQ", 268, 104, 83, 25, 0)
$Set = GUICtrlCreateButton("设置↓", 268, 140, 83, 25, 0)
GUICtrlSetColor(-1, 0x0000FF)
$Close = GUICtrlCreateButton("关闭所有QQ", 268, 193, 83, 25, 0)
$About = GUICtrlCreateButton("关于(&A)", 268, 226, 83, 25, 0)
$Exit = GUICtrlCreateButton("退出(&X)", 268, 260, 83, 25, 0)
$Check = GUICtrlCreateCheckbox("登陆完成后关闭登录器", 10, 272, 153, 17)
GUICtrlCreateLabel("By: 范统.贾", 189, 274, 78, 17)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateGroup("功能设置", 4, 312, 361, 97)
GUICtrlCreateLabel("QQ程序所在路径:", 12, 340, 95, 17)
$Input = GUICtrlCreateInput(IniRead($IniFile, "腾讯QQ", "安装路径", ""), 112, 336, 241, 21)
$Zidong = GUICtrlCreateButton("自动查找", 168, 372, 89, 25, 0)
$Shoudong = GUICtrlCreateButton("手动指定", 265, 372, 89, 25, 0)
GUICtrlCreateGroup("QQ号码编辑", 4, 424, 361, 150)
$NeedCheck = GUICtrlCreateCheckbox("设置登陆本软件需要密码", 167, 455, 150, 17)
If RegRead("HKCU\Software\QQLogin", "NeedPWD") = "1" Then
        GUICtrlSetState($NeedCheck, $GUI_CHECKED)
Else
        GUICtrlSetState($NeedCheck, $GUI_UNCHECKED)
EndIf
$List2 = GUICtrlCreateList("", 12, 444, 135, 128, BitOR($WS_BORDER, $WS_VSCROLL, $LBS_NOTIFY))
$Tianjia = GUICtrlCreateButton("添加", 167, 504, 83, 25, 0)
$Shanchu = GUICtrlCreateButton("删除", 262, 504, 83, 25, 0)
$Bianji = GUICtrlCreateButton("编辑", 167, 540, 83, 25, 0)
$Shuaxin = GUICtrlCreateButton("刷新", 262, 540, 83, 25, 0)
GUISetState(@SW_SHOW)
_ShowList()
 
Dim $savemima = RegRead("HKCU\Software\QQLogin", "PassWord")
While 1
        If GUICtrlRead($NeedCheck) = $GUI_CHECKED Then                              
                RegWrite("HKCU\Software\QQLogin", "NeedPWD", "REG_SZ", "1")
                RegWrite("HKCU\Software\QQLogin", "PassWord", "REG_SZ", $savemima)
        Else
                RegWrite("HKCU\Software\QQLogin", "NeedPWD", "REG_SZ", "0")
                RegWrite("HKCU\Software\QQLogin", "PassWord", "REG_SZ", "")
        EndIf   
        $QQFile = IniRead($IniFile, "腾讯QQ", "安装路径", "")
    $QQPath = _Getpath($QQFile)
        $nMsg = GUIGetMsg()
        Switch $nMsg
                Case $GUI_EVENT_CLOSE
                        Exit
                Case $Exit
                        Exit
                Case $NeedCheck
                        If GUICtrlRead($NeedCheck) = $GUI_CHECKED Then
                                $setpwd_tmp = InputBox("设置密码:", "请输入密码:", "", "*M30", "-1", "120", "-1", "-1")
                                If @error = 1 Then
                                        GUICtrlSetState($NeedCheck, $GUI_UNCHECKED)
                                Else
                                        $setpwd = InputBox("重复密码:", "请再输入一次密码:", "", "*M30", "-1", "120", "-1", "-1")
                                        If $setpwd <> $setpwd_tmp Then
                                                MsgBox(64, "提示", "你两次输入的密码不一样，请重新设定！")
                                                GUICtrlSetState($NeedCheck, $GUI_UNCHECKED)
                                        Else 
                                                $savemima = $setpwd
                                        EndIf
                                EndIf
                        EndIf                   
                Case $Shoudong
                        $Value = FileOpenDialog("请选择QQ所在的目录...", @ProgramFilesDir, "可执行文件(*.exe)")
                        GUICtrlSetData($Input, $Value)
                        IniWrite($IniFile, "腾讯QQ", "安装路径", $Value)
                Case $Zidong
                        $Value = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\TENCENT\QQ", "install")
                        GUICtrlSetData($Input, $Value &"QQ.exe")
                        IniWrite($IniFile, "腾讯QQ", "安装路径", $Value &"QQ.exe")
                Case $Set
                        $pos = WinGetPos("QQ自动登陆器","")
                        If GUICtrlRead($Set) = "设置↓" Then
                                WinMove  ($Window,"", Default, Default, Default , 605)
                                GUICtrlSetData($Set,"设置↑")
                        ElseIf GUICtrlRead($Set) = "设置↑" Then
                                WinMove  ($Window,"", Default, Default,Default , 326)
                                GUICtrlSetData($Set,"设置↓")
                        EndIf
;~                         _ShowQQ()
                Case $Tianjia
                        _Tianjia()
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
                Case $Bianji
                        If GUICtrlRead($List2) = "" Then
                                MsgBox(64, "提示", "请先选择您要编辑的QQ号码后再试！")
                        Else
                                _EditQQ()
                        EndIf
                Case $Shuaxin
                        _ShowQQ()
                Case $Run
                        Run($QQFile, $QQPath)
                Case $Refresh
                        GUICtrlSendMsg($List1, $LVM_DeleteALLITEMS, 0, 0)
                        _ShowList()
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
                                If GUICtrlRead($UseNick) = $GUI_CHECKED Then
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
                                If GUICtrlRead($UseNick) = $GUI_CHECKED Then
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
 
;未实现：
;3、多个号码同时登陆
