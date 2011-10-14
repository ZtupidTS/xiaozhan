#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=..\..\工具\综合软件\3D风格ICO图标\deamon.ico
#AutoIt3Wrapper_outfile=配置文件初始化工具(每天总数相加)(单选).exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
$I = IniRead(@ScriptDir & "\获取回放列表总数(每天总数相加)(Netviewer).ini", "列表", "相加总数和","")
$J = IniRead(@ScriptDir & "\获取回放列表总数(每天总数相加)(91IE).ini", "列表", "相加总数和","")
$K = IniRead(@ScriptDir & "\获取回放列表总数(每天总数相加)(90IE).ini", "列表", "相加总数和","")
$Form1 = GUICreate("配置文件初始化工具(每天总数相加)", 319, 240, 187, 124)
$Input2 = GUICtrlCreateInput("", 112, 152, 169, 21,$ES_READONLY)
$Button1 = GUICtrlCreateButton("确定", 64, 192, 65, 25)
$Button2 = GUICtrlCreateButton("取消", 188, 192, 65, 25)
$Label1 = GUICtrlCreateLabel("         请把本软件放到配置文件下面使用或者" & @CRLF & "         放到“每天总数相加”程序下面使用",  0, 8, 308, 25)
$Label3 = GUICtrlCreateLabel("相加总数和", 28, 156, 72, 17)
$Radio1 = GUICtrlCreateRadio($I, 152, 48, 161, 17)
$Radio2 = GUICtrlCreateRadio($J, 152, 80, 161, 17)
$Radio3 = GUICtrlCreateRadio($K, 152, 112, 161, 17)
$Label2 = GUICtrlCreateLabel("Netviewer相加总数和", 32, 51, 120, 17)
$Label4 = GUICtrlCreateLabel("91IE相加总数和", 64, 83, 86, 17)
$Label6 = GUICtrlCreateLabel("90IE相加总数和", 64, 115, 86, 17)
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
			csh()
			Exit
	EndSelect
WEnd

Func csh()
	If BitAND(GUICtrlRead($Radio1), $GUI_CHECKED) Then ;BitAnd 比较前后两个值
				GUISetState($Radio2, $GUI_UNCHECKED)
				GUISetState($Radio3, $GUI_UNCHECKED)
				IniWrite(@ScriptDir & "\获取回放列表总数(每天总数相加)(Netviewer).ini", "列表", "相加总数和", GUICtrlRead ($Input2)) 
			Else
				GUISetState($Radio1, $GUI_UNCHECKED)
				GUISetState($Radio2, $GUI_CHECKED)
				GUISetState($Radio3, $GUI_CHECKED)
			EndIf

			If BitAND(GUICtrlRead($Radio2), $GUI_CHECKED) Then
				GUISetState($Radio3, $GUI_UNCHECKED)
				GUISetState($Radio2, $GUI_UNCHECKED)
				IniWrite(@ScriptDir & "\获取回放列表总数(每天总数相加)(91IE).ini", "列表", "相加总数和",GUICtrlRead ($Input2))
			Else
				GUISetState($Radio2, $GUI_UNCHECKED)
				GUISetState($Radio1, $GUI_CHECKED)
				GUISetState($Radio3, $GUI_CHECKED)
			EndIf

			If BitAND(GUICtrlRead($Radio3), $GUI_CHECKED) Then
				GUISetState($Radio1, $GUI_UNCHECKED)
				GUISetState($Radio2, $GUI_UNCHECKED)
				IniWrite(@ScriptDir & "\获取回放列表总数(每天总数相加)(90IE).ini", "列表", "相加总数和",GUICtrlRead ($Input2)) 
			Else
				GUISetState($Radio3, $GUI_UNCHECKED)
				GUISetState($Radio1, $GUI_CHECKED)
				GUISetState($Radio2, $GUI_CHECKED)
			EndIf


EndFunc