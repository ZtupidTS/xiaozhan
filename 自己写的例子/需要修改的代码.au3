#include <file.au3>
#include <GuiEdit.au3>
#include <servicecontrol.au3>
#include <GUIListBox.au3>
#include <GuiListView.au3>
#include <GUIComboBox.au3>
#include <GuiTreeView.au3>
#include <GuiIPAddress.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <TreeViewConstants.au3>
#include <ListViewConstants.au3>
 #include <ButtonConstants.au3>
 Opt("GUIOnEventMode", 1)

$Command = IniReadSection("menu.ini", "command")

$title=IniRead("menu.ini","title","title","")
$Form13 = GUICreate("启动项清理", 620, 429, 192, 124, BitOR($WS_SYSMENU, $WS_CAPTION, $WS_POPUP, $WS_POPUPWINDOW, $WS_BORDER, $WS_CLIPSIBLINGS))
$List = GUICtrlCreateListView("序号   | 路径      |程序名称", 24, 32, 577, 346)
GUICtrlCreateLabel("启  动  项  列  表", 232, 8, 101, 20)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$Radio5 = GUICtrlCreateRadio("包括系统核心", 24, 392, 113, 17)
GUICtrlSetOnEvent(-1, "Radio5Click")
$Radio6 = GUICtrlCreateRadio("不包括系统核心", 144, 392, 113, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent(-1, "Radio6Click")
$Button1 = GUICtrlCreateButton("查看", 272, 392, 75, 25, 0)
GUICtrlSetOnEvent(-1, "remain")
$Button2 = GUICtrlCreateButton("导出", 352, 392, 75, 25, 0)
GUICtrlSetOnEvent(-1, "backup")
$Button3 = GUICtrlCreateButton("删除", 432, 392, 75, 25, 0)
GUICtrlSetOnEvent(-1, "delstart")
$Button4 = GUICtrlCreateButton("返回", 512, 392, 75, 25, 0)
GUICtrlSetOnEvent(-1, "Form13close")
GUISetOnEvent($GUI_EVENT_CLOSE, "Form13Close")
GUISetState(@SW_SHOW)

While 1
		$nMsg = GUIGetMsg()   ;捕获窗口消息
		Switch $nMsg
			Case $Button1
				
			Case $GUI_EVENT_CLOSE
				Exit

		EndSwitch
	WEnd
Func Radio5Click()

EndFunc
Func Radio6Click()

EndFunc
Func remain()

EndFunc
Func backup()

EndFunc
Func delstart()

EndFunc
Func Form13close()
     Exit
EndFunc



