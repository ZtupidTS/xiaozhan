#Include <GuiComboBox.au3>
Local $c,$Paused ,$d = 1

Func Record();��Ե�ǰѡ���ҳ��
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
ControlClick("HiDvrOcx","ȷ��","Button1")
MsgBox(1,"�˶԰����Ϣ","�˶԰����Ϣ�Ƿ񱣴���ȷ")
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
ControlClick("HiDvrOcx","ȷ��","Button1")
MsgBox(1,"�˶԰����Ϣ","�˶԰����Ϣ�Ƿ񱣴���ȷ")
next
EndFunc



Func sl()
     Sleep(1000)
EndFunc
