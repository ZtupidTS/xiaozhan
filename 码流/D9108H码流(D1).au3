#Include <GuiComboBox.au3>
#Include <GuiToolTip.au3>
Local $c
HotKeySet("{ESC}", "Terminate")

;D1

;1

WinActivate("�豸��������(14)")
$j = ControlGetHandle ("�豸��������(14)","","ComboBox17")
_GUICtrlComboBox_SetCurSel($j,1)
ControlClick("�豸��������(14)","","ComboBox17","left",2)
Send("{up}")
$y= ControlGetHandle ("�豸��������(14)","","ComboBox17")
$x =_GUICtrlComboBox_GetCurSel($y)

zl()
ml(7)
;2
zl()
ml(9)
;3
zl()
ml(11)
;4
zl()
ml(10)
;5
zl()
ml(11)
;6
zl()
ml(12)
;7
zl()
ml(12)
;8
zl()
ml(11)
;9
zl()
ml(11)
;10
zl()
ml(11)
;11
zl()
ml(11)
;12
zl()
ml(12)
;13
zl()
ml(11)
;14
zl()
ml(11)
;15
zl()
ml(11)
;16
zl()
ml(10)
;17
zl()
ml(9)
;18
zl()
ml(9)
;19
zl()
ml(9)
;20
zl()
ml(8)
;21
zl()
ml(8)
;22
zl()
ml(8)
;23
zl()
ml(8)
;24
zl()
ml(8)
;25
zl()
ml(7)

Func Terminate()
	Exit 0
EndFunc

Func zl()
	WinActivate("�豸��������(14)")
	;ControlClick("�豸��������(14)","","ComboBox17","left",2)
	$q = ControlGetHandle ("�豸��������(14)","","ComboBox17")
	_GUICtrlComboBox_SetCurSel($h,$n)
	ControlCommand ("�豸��������(14)","","ComboBox17", "SetCurrentSelection", "")
	;_GUIToolTip_Activate($q,"True")
	;Send("{down}")
	$y= ControlGetHandle ("�豸��������(14)","","ComboBox17")
	$x =_GUICtrlComboBox_GetCurSel($y)
	$x+=2
EndFunc


Func ml($num1)
	$n= 0 
	for $b = 1 to $num1
WinActivate("�豸��������(14)")
$h= ControlGetHandle ("�豸��������(14)","","ComboBox18")
_GUICtrlComboBox_SetCurSel($h,$n)
$v = _GUICtrlComboBox_GetCount($h)
$s = _GUICtrlComboBox_GetLBText($h,$n,$c)
$n+=1
ControlClick("�豸��������(14)","����","Button3")
MsgBox(1,"���DVR","�Ƿ��DVRһ��    " & "֡��: " &  $x & "  ����: " & $c  & "  ��������: " & $b & "  ������: " & $v)
Sleep(500)
If $b = $num1 Then
	WinActivate("�豸��������(14)")
	  MsgBox(1,"�˶�����","�����ܹ���:  " & $b & "����ѡ")
EndIf	    
next
EndFunc




