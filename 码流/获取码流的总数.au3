
HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")
#Include <Date.au3>
#Include <GuiComboBox.au3>
Local $c,$Paused ,$d = 1

WinActivate("�豸��������(14)")
$j = ControlGetHandle ("�豸��������(14)","","ComboBox32")
_GUICtrlComboBox_SetCurSel($j,1)
ControlClick("�豸��������(14)","","ComboBox32","left",2)
Send("{up}")
Sleep(500)
$h= ControlGetHandle ("�豸��������(14)","","ComboBox34")
$b = _GUICtrlComboBox_GetCount($h)
_write($d)
$d+=1

$i = 0
Do
	WinActivate("�豸��������(14)")
	ControlClick("�豸��������(14)","","ComboBox32","left",2)
	;$q = ControlGetHandle ("�豸��������(14)","","ComboBox32")
	;_GUIToolTip_Activate($q,"True")
	Send("{down}")
	
WinActivate("�豸��������(14)")
$h= ControlGetHandle ("�豸��������(14)","","ComboBox34")
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