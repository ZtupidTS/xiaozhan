;��ͬ��·������ʽ���в�ͬ�Ľ��
#Include <GuiComboBox.au3>
Func
	WinActivate("Netviewer")
ControlClick("Netviewer","","ComboBox11")
Sleep(500)
Send("{down}")
Send("{tab}")
ControlClick("Netviewer","","Edit6","left",2)
Send("30")
Send("{tab}")
ap()
ControlClick("Netviewer","","ComboBox6","left",2)
Send("{down}")
sleep(500)
ControlClick("Netviewer","","Edit6","left",2)
Send("16")
Send("{tab}")
ap()

EndFunc


Func ap()
ControlClick("Netviewer","Apply","Button72")
WinWait("HiDvrOcx")
Sleep(100)
ControlClick("HiDvrOcx","ȷ��","Button1")
MsgBox(1,"�˶԰����Ϣ","�˶԰����Ϣ�Ƿ񱣴���ȷ")
EndFunc