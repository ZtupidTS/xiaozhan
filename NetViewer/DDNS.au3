#Include <GuiComboBox.au3>
Local $Paused

Func DDNS()
WinActivate("NetViewer")
ControlClick("NetViewer","","ComboBox15")
Send("{down}")
$d = ControlGetHandle ("NetViewer","","ComboBox16")
_GUICtrlComboBox_SetCurSel($d,0)
ControlClick("NetViewer","","Edit18")
Send("xiaozhan.haha.com")
ControlClick("NetViewer","","Edit19")
Send("xiaozhan")
ControlClick("NetViewer","","Edit20")
Send("123456")

ControlClick("NetViewer","Apply","Button73")
WinWait("HiDvrOcx")
Sleep(100)
ControlClick("HiDvrOcx","确定","Button1")
MsgBox(1,"核对板端信息","核对板端信息是否保存正确")
EndFunc
