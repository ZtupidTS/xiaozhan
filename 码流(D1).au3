#Include <GuiComboBox.au3>
#Include <GuiToolTip.au3>

HotKeySet("{ESC}", "Terminate")

;D1

WinActivate("�豸��������(14)")
$j = ControlGetHandle ("�豸��������(14)","","ComboBox32")
_GUICtrlComboBox_SetCurSel($j,1)
ControlClick("�豸��������(14)","","ComboBox32","left",2)
Send("{up}")

ml(7)

zl()
ml(9)

zl()
ml(11)

zl()
ml(10)

zl()
ml(11)

zl()
ml(12)

zl()
ml(12)

zl()
ml(11)

zl()
ml(11)

zl()
ml(11)

zl()
ml(11)

zl()
ml(12)

zl()
ml(11)

zl()
ml(11)

zl()
ml(11)

zl()
ml(10)

zl()
ml(9)

zl()
ml(9)

zl()
ml(9)

zl()
ml(8)

zl()
ml(8)

zl()
ml(8)

zl()
ml(8)

zl()
ml(8)

zl()
ml(7)


Func zl()
	WinActivate("�豸��������(14)")
	$q = ControlGetHandle ("�豸��������(14)","","ComboBox32")
	_GUIToolTip_Activate($q,"True")
	Send("{down}")
EndFunc


Func ml($num1)
	$n= 0
	for $b = 1 to $num1
WinActivate("�豸��������(14)")
$h= ControlGetHandle ("�豸��������(14)","","ComboBox34")
_GUICtrlComboBox_SetCurSel($h,$n)
$n+=1
;ControlClick("�豸��������(14)","����","Button3")
;MsgBox(1,"���DVR","�Ƿ��DVRһ��")
next
EndFunc


Func Terminate()
	Exit 0
EndFunc

