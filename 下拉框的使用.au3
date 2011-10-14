#Include <GuiComboBox.au3>
HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")
Local $Paused
$i = 0
Do

WinActivate("本地参数配置")
MouseClick("left",481, 210,1,50)
WinActivate("用户信息")
BlockInput(1)
ControlClick("用户信息","","Edit1")
Send($i)
Sleep(500)
ControlClick("用户信息","","Edit2")
Send($i)
Sleep(500)
ControlClick("用户信息","","Edit3")
Send($i)
Sleep(500)
$j = ControlGetHandle ("用户信息","","ComboBox1")
_GUICtrlComboBox_SetCurSel($j,1)
Send("{ENTER}")
Sleep(3000)
BlockInput(0)
If WinExists("DvrClient") Then
    Send("{ENTER}")
	ControlClick("用户信息","取消","Button2")
EndIf


$i = $i + 1
Until $i = 1


Func Terminate()
	Exit 0
EndFunc

Func Togglepause()
    $Paused = NOT $Paused 
	
   While $Paused 
	tooltip("暂停一会",0,0)
	sleep(100)
   tooltip("")
   WEnd
EndFunc