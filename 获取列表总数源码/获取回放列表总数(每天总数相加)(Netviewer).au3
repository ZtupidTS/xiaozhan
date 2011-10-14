#NoTrayIcon
#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=..\..\工具\综合软件\3D风格ICO图标\f2.ico
#AutoIt3Wrapper_outfile=..\获取回放列表总数(每天总数相加)(Netviewer).exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Include <GuiListView.au3>
#Region ### START Koda GUI section ### Form=

$I= IniRead(@scriptdir & "\获取回放列表总数(每天总数相加)(Netviewer).ini", "Netviewer","标题","")

$Form1_1 = GUICreate("获取回放列表总数(Netviewer)", 291, 143, 192, 124,$WS_THICKFRAME)
$Input1 = GUICtrlCreateInput($I, 24, 48, 241, 21)
$Label1 = GUICtrlCreateLabel("请输入Netviewer的标题名字", 24, 16, 244, 17)
$Button1 = GUICtrlCreateButton("确定", 48, 82, 81, 25,$WS_GROUP)
GUICtrlSetState(-1, $GUI_DEFBUTTON)
$Button2 = GUICtrlCreateButton("取消", 160, 82, 81, 25)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Select 
		Case $nMsg = $GUI_EVENT_CLOSE
			Exit
		Case $nMsg = $Button2
			Exit
		Case $nMsg = $Button1
			IniWrite(@ScriptDir & "\获取回放列表总数(每天总数相加)(Netviewer).ini", "Netviewer", "标题", GUICtrlRead ($Input1)) 
			_hqzs()
			Exit
	EndSelect
WEnd

Func _hqzs()
	$I= IniRead(@scriptdir & "\获取回放列表总数(每天总数相加)(Netviewer).ini", "Netviewer","标题","")
	WinActivate($I,"Playback")  ;激活指定的窗口(设置焦点到该窗口,使其成为活动窗口)
	$xiaozhan = ControlGetHandle ( $I, "", "SysListView321")  ;获取指定控件的内部句柄.
	$count = _GUICtrlListView_GetItemCount($xiaozhan) ;获取列表视图控件的项目数
	MsgBox(1, "获取回放列表总数" ,"获取回放列表当天总数:  " & $count)
	IniWrite(@ScriptDir & "\获取回放列表总数(每天总数相加)(Netviewer).ini", "列表", "当天总数", $count);单独一天的数目总数
	$R = IniRead(@ScriptDir & "\获取回放列表总数(每天总数相加)(Netviewer).ini", "列表", "相加总数和","");读取相加后的总数和
	IniWrite(@ScriptDir & "\获取回放列表总数(每天总数相加)(Netviewer).ini", "列表", "相加总数和", $count + $R) ;需要把单独一天的数目总数 + 相加后的总数
	$Z = IniRead(@ScriptDir & "\获取回放列表总数(每天总数相加)(Netviewer).ini", "列表", "相加总数和","");$count+$H后的总数
	MsgBox(1, "获取回放列表总数" ,"获取回放列表相加总数:  " & $Z);$count+$H提示总数
EndFunc