#Include <GuiComboBox.au3>
#Include <GuiToolTip.au3>
Local $c
HotKeySet("{ESC}", "Terminate")

;HD1

;1
WinActivate("�豸��������(14)")
$j = ControlGetHandle ("�豸��������(14)","","ComboBox17")
_GUICtrlComboBox_SetCurSel($j,1)
ControlClick("�豸��������(14)","","ComboBox17","left",2)
Send("{up}")
$y= ControlGetHandle ("�豸��������(14)","","ComboBox17")
$x =_GUICtrlComboBox_GetCurSel($y)

ml(1)

;2
zl()
ml(4)
;3
zl()
ml(6)
;4
zl()
ml(7)
;5
zl()
ml(8)
;6
zl()
ml(9)
;7
zl()
ml(10)
;8
zl()
ml(9)
;9
zl()
ml(10)
;10
zl()
ml(10)
;11
zl()
ml(10)
;12
zl()
ml(11)
;13
zl()
ml(10)
;14
zl()
ml(11)
;15
zl()
ml(10)
;16
zl()
ml(10)
;17
zl()
ml(11)
;18
zl()
ml(11)
;19
zl()
ml(11)
;20
zl()
ml(11)
;21
zl()
ml(11)
;22
zl()
ml(11)
;23
zl()
ml(11)
;24
zl()
ml(12)
;25
zl()
ml(11)

Func Terminate()
	Exit 0
EndFunc

Func zl()
	WinActivate("�豸��������(14)")
	ControlClick("�豸��������(14)","","ComboBox17","left",2)
	;$q = ControlGetHandle ("�豸��������(14)","","ComboBox17")
	;_GUIToolTip_Activate($q,"True")
	Send("{down}")
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

