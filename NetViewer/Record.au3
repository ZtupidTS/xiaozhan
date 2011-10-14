#Include <GuiComboBox.au3>
Local $c,$Paused ,$d = 1

Func Record();针对当前选项的页面
WinActivate("Netviewer")
$a = ControlGetHandle ("Netviewer","","ComboBox7")
_GUICtrlComboBox_SetCurSel($a,0)
ControlCommand ( "Netviewer","","ComboBox7", "SetCurrentSelection", "")
sl()
$b = ControlGetHandle ("Netviewer","","ComboBox8")
_GUICtrlComboBox_SetCurSel($b,0)
ControlCommand ( "Netviewer","","ComboBox8", "SetCurrentSelection", "")
sl()
$c = ControlGetHandle ("Netviewer","","ComboBox9")
_GUICtrlComboBox_SetCurSel($c,1)
ControlCommand ( "Netviewer","","ComboBox9", "SetCurrentSelection", "")
sl()
$d = ControlGetHandle ("Netviewer","","ComboBox10")
_GUICtrlComboBox_SetCurSel($d,0)
ControlCommand ( "Netviewer","","ComboBox10", "SetCurrentSelection", "")
sl()
$e = ControlGetHandle ("Netviewer","","ComboBox13")
_GUICtrlComboBox_SetCurSel($e,2)
ControlCommand ( "Netviewer","","ComboBox13", "SetCurrentSelection", "")
sl()
ControlClick("Netviewer","Apply","Button72")
WinWait("HiDvrOcx")
Sleep(100)
ControlClick("HiDvrOcx","确定","Button1")
MsgBox(1,"核对板端信息","核对板端信息是否保存正确")
FileSize(3)
EndFunc

Func FileSize($num)
	$ab = 1
	for $nu = 1 to $num
$b = ControlGetHandle ("Netviewer","","ComboBox8")
_GUICtrlComboBox_SetCurSel($b,$ab )
$ab+=1
ControlClick("Netviewer","Apply","Button72")
WinWait("HiDvrOcx")
Sleep(100)
ControlClick("HiDvrOcx","确定","Button1")
MsgBox(1,"核对板端信息","核对板端信息是否保存正确")
next
EndFunc



Func sl()
     Sleep(1000)
EndFunc
