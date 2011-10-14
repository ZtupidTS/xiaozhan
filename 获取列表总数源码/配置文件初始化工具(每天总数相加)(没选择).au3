#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("配置文件初始化工具(每天总数相加)", 315, 172, 187, 124)
$Input2 = GUICtrlCreateInput("", 112, 88, 169, 21)
$Button1 = GUICtrlCreateButton("确定", 64, 128, 65, 25)
$Button2 = GUICtrlCreateButton("取消", 188, 128, 65, 25)
$Label1 = GUICtrlCreateLabel("         请把本软件放到配置文件下面使用或者" & @CRLF & "         放到“每天总数相加”程序下面使用",  0, 8, 308, 25)
;$Input1 = GUICtrlCreateInput("", 112, 56, 169, 21)
;$Label2 = GUICtrlCreateLabel("当天总数", 32, 60, 52, 17)
$Label3 = GUICtrlCreateLabel("相加总数和", 28, 92, 72, 17)
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
	$I = IniRead(@ScriptDir & "\获取回放列表总数(每天总数相加)(Netviewer).ini", "列表", "相加总数和","")
	$J = IniRead(@ScriptDir & "\获取回放列表总数(每天总数相加)(91IE).ini", "列表", "相加总数和","")
	$K = IniRead(@ScriptDir & "\获取回放列表总数(每天总数相加)(90IE).ini", "列表", "相加总数和","")
If $I > 0 Then
	IniWrite(@ScriptDir & "\获取回放列表总数(每天总数相加)(Netviewer).ini", "列表", "相加总数和", GUICtrlRead ($Input2)) 
	
ElseIf $J > 0 Then
	IniWrite(@ScriptDir & "\获取回放列表总数(每天总数相加)(91IE).ini", "列表", "相加总数和",GUICtrlRead ($Input2)) 
	
ElseIf $K > 0 Then
	IniWrite(@ScriptDir & "\获取回放列表总数(每天总数相加)(90IE).ini", "列表", "相加总数和",GUICtrlRead ($Input2)) 
EndIf

EndFunc