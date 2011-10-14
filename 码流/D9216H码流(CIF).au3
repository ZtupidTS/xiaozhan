#Include <GuiComboBox.au3>
#Include <GuiToolTip.au3>
Local $c
HotKeySet("{ESC}", "Terminate")

;CIF

;1
WinActivate("设备参数配置(14)")
$j = ControlGetHandle ("设备参数配置(14)","","ComboBox17")
_GUICtrlComboBox_SetCurSel($j,1)
ControlClick("设备参数配置(14)","","ComboBox17","left",2)
Send("{up}")
$y= ControlGetHandle ("设备参数配置(14)","","ComboBox17")
$x =_GUICtrlComboBox_GetCurSel($y)

ml(1)

;2
zl()
ml(2)
;3
zl()
ml(3)
;4
zl()
ml(3)
;5
zl()
ml(4)
;6
zl()
ml(5)
;7
zl()
ml(5)
;8
zl()
ml(6)
;9
zl()
ml(6)
;10
zl()
ml(5)
;11
zl()
ml(6)
;12
zl()
ml(7)
;13
zl()
ml(7)
;14
zl()
ml(6)
;15
zl()
ml(7)
;16
zl()
ml(7)
;17
zl()
ml(7)
;18
zl()
ml(8)
;19
zl()
ml(8)
;20
zl()
ml(7)
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
ml(9)
;25
zl()
ml(8)

Func Terminate()
	Exit 0
EndFunc

Func zl()
	WinActivate("设备参数配置(14)")
	ControlClick("设备参数配置(14)","","ComboBox17","left",2)
	;$q = ControlGetHandle ("设备参数配置(14)","","ComboBox17")
	;_GUIToolTip_Activate($q,"True")
	Send("{down}")
	$y= ControlGetHandle ("设备参数配置(14)","","ComboBox17")
	$x =_GUICtrlComboBox_GetCurSel($y)
	$x+=2
EndFunc


Func ml($num1)
	$n= 0 
	for $b = 1 to $num1
WinActivate("设备参数配置(14)")
$h= ControlGetHandle ("设备参数配置(14)","","ComboBox18")
_GUICtrlComboBox_SetCurSel($h,$n)
$v = _GUICtrlComboBox_GetCount($h)
$s = _GUICtrlComboBox_GetLBText($h,$n,$c)
$n+=1
ControlClick("设备参数配置(14)","设置","Button3")
MsgBox(1,"请对DVR","是否和DVR一致    " & "帧率: " &  $x & "  码流: " & $c  & "  码流排序: " & $b & "  码流总: " & $v)
Sleep(500)
If $b = $num1 Then
	WinActivate("设备参数配置(14)")
	  MsgBox(1,"核对码流","码流总共有:  " & $b & "个可选")
EndIf	    
next
EndFunc




