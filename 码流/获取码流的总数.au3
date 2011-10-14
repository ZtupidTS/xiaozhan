
HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")
#Include <Date.au3>
#Include <GuiComboBox.au3>
Local $c,$Paused ,$d = 1

WinActivate("设备参数配置(14)")
$j = ControlGetHandle ("设备参数配置(14)","","ComboBox32")
_GUICtrlComboBox_SetCurSel($j,1)
ControlClick("设备参数配置(14)","","ComboBox32","left",2)
Send("{up}")
Sleep(500)
$h= ControlGetHandle ("设备参数配置(14)","","ComboBox34")
$b = _GUICtrlComboBox_GetCount($h)
_write($d)
$d+=1

$i = 0
Do
	WinActivate("设备参数配置(14)")
	ControlClick("设备参数配置(14)","","ComboBox32","left",2)
	;$q = ControlGetHandle ("设备参数配置(14)","","ComboBox32")
	;_GUIToolTip_Activate($q,"True")
	Send("{down}")
	
WinActivate("设备参数配置(14)")
$h= ControlGetHandle ("设备参数配置(14)","","ComboBox34")
$b = _GUICtrlComboBox_GetCount($h)
;$s =   _GUICtrlComboBox_GetLBText($h,2,$c)
;MsgBox(1,"核对码流","码流总共    " & $b );& $c)
_write($d)
	$d+=1
	Sleep(1000)
	 
$i = $i + 1
Until $i = 24
	
Func _write($d)
  $file = FileOpen(@ScriptDir & '\TAB功能.ini', 1)
  FileWrite($file , $d & '码流值:   ' & $b & @CRLF )
  ;MsgBox(1,"核对码流","码流总共    " & $d )
  FileClose($file )
EndFunc


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