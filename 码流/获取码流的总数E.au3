
HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")
#Include <Date.au3>
#Include <GuiComboBox.au3>
Local $c,$Paused ,$d = 1

WinActivate("Device parameters(14)")
$j = ControlGetHandle ("Device parameters(14)","","ComboBox19")
_GUICtrlComboBox_SetCurSel($j,1)
ControlClick("Device parameters(14)","","ComboBox19","left",2)
Send("{up}")
Sleep(500)
$h= ControlGetHandle ("Device parameters(14)","","ComboBox20")
$b = _GUICtrlComboBox_GetCount($h)
_write($d)
$d+=1

$i = 0
Do
	WinActivate("Device parameters(14)")
	ControlClick("Device parameters(14)","","ComboBox19","left",2)
	;$q = ControlGetHandle ("Device parameters(14)","","ComboBox19")
	;_GUIToolTip_Activate($q,"True")
	Send("{down}")
	
WinActivate("Device parameters(14)")
$h= ControlGetHandle ("Device parameters(14)","","ComboBox20")
$b = _GUICtrlComboBox_GetCount($h)
;$s =   _GUICtrlComboBox_GetLBText($h,2,$c)
;MsgBox(1,"�˶�����","�����ܹ�    " & $b );& $c)
_write($d)
	$d+=1
	Sleep(1000)
	 
$i = $i + 1
Until $i = 24
	
Func _write($d)
  $file = FileOpen(@ScriptDir & '\TAB����.ini', 1)
  FileWrite($file , $d & '����ֵ:   ' & $b & @CRLF )
  ;MsgBox(1,"�˶�����","�����ܹ�    " & $d )
  FileClose($file )
EndFunc


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