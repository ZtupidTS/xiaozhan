#Include <GuiComboBox.au3>
HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")
Local $Paused
$i = 0
Do

WinActivate("���ز�������")
MouseClick("left",481, 210,1,50)
WinActivate("�û���Ϣ")
BlockInput(1)
ControlClick("�û���Ϣ","","Edit1")
Send($i)
Sleep(500)
ControlClick("�û���Ϣ","","Edit2")
Send($i)
Sleep(500)
ControlClick("�û���Ϣ","","Edit3")
Send($i)
Sleep(500)
$j = ControlGetHandle ("�û���Ϣ","","ComboBox1")
_GUICtrlComboBox_SetCurSel($j,1)
Send("{ENTER}")
Sleep(3000)
BlockInput(0)
If WinExists("DvrClient") Then
    Send("{ENTER}")
	ControlClick("�û���Ϣ","ȡ��","Button2")
EndIf


$i = $i + 1
Until $i = 1


Func Terminate()
	Exit 0
EndFunc

Func Togglepause()
    $Paused = NOT $Paused 
	
   While $Paused 
	tooltip("��ͣһ��",0,0)
	sleep(100)
   tooltip("")
   WEnd
EndFunc