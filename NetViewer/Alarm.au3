#Include <GuiComboBox.au3>
Local $Paused

Func Alarm()
WinActivate("NetViewer")
$a = ControlGetHandle ("NetViewer","","ComboBox19")
_GUICtrlComboBox_SetCurSel($a,4)
ControlClick("NetViewer","","Button82")
ControlClick("NetViewer","","Button84")
ControlClick("NetViewer","","Button85")
ControlClick("NetViewer","","Button86")
ControlClick("NetViewer","","Button107")
ControlClick("NetViewer","","Button109")
$b = ControlGetHandle ("NetViewer","","ComboBox21")
_GUICtrlComboBox_SetCurSel($b,3)
$c = ControlGetHandle ("NetViewer","","ComboBox22")
_GUICtrlComboBox_SetCurSel($c,0)
ControlClick("NetViewer","Apply","Button72")
WinWait("HiDvrOcx")
Sleep(100)
ControlClick("HiDvrOcx","ȷ��","Button1")
MsgBox(1,"�˶԰����Ϣ","�˶԰����Ϣ�Ƿ񱣴���ȷ")
EndFunc
