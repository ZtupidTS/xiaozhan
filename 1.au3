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

Opt('GUIResizeMode', 802)

$Version = "QQLoginV2.0_By_5i3p"
If WinExists($Version) Then Exit
AutoItWinSetTitle($Version)

;_CreatIni()        
Global $NumList[2], $List1, $List2
$IniFile = @ScriptDir&"\Config.ini"
$Window = GUICreate("QQ自动登录器", 367, 300, 192, 114)
GUICtrlCreateGroup("请选择您要登陆的QQ号码:", 4, 8, 361, 289)
$List1 = GUICtrlCreateListView("      IP地址   |昵称        |上次登陆时间", 10, 32, 245, 233)
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

;regwrite

While 1
        $nMsg = GUIGetMsg()
		Switch $nMsg
                Case $GUI_EVENT_CLOSE
                        Exit
	EndSwitch
                        
WEnd