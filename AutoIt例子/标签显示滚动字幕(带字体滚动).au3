#include<guiconstantsex.au3>
Global $i =1, $label, $text, $timer = TimerInit()
_main()
Func _main()
	GUICreate("example", 200,200,50,50)
	$label = GUICtrlCreateLabel("", 2, 50, 196, 12)
	$text = "�����Ѿ��������ʹ�������ļ�"
	GUISetState()
	AdlibRegister("_scroll", 1000)
    Do
    Until GUIGetMsg() = $GUI_EVENT_CLOSE
    GUIDelete()
EndFunc

Func _scroll()
	If TimerDiff($timer) < 9000 Then
       GUICtrlSetData($label6, $text);��̬Ч��
       	;GUICtrlSetData($label6, StringLeft($text,$i));��̬Ч��
		;$i += 1
	Else
		GUICtrlSetData($label, '')
	EndIf
	$i += 1
EndFunc

#cs
������Թ���(ͷβ���Ų�����)
Func _scroll()
	If TimerDiff($timer) < 16000 Then
		If StringLen(GUICtrlRead($label6)) < StringLen($text) Then
			GUICtrlSetData($label6, $text);��̬Ч��
			;GUICtrlSetData($label6, StringLeft($text, $i))
		    ;$i += 1
		Else
        	GUICtrlSetData($label6, StringTrimLeft($text, $j) & StringLeft($text, $j))
     		$j += 1
		EndIf
	Else
		GUICtrlSetData($label6, '')
	EndIf
	$i += 1
EndFunc

#ce

#cs
������Թ���(ͷβ������)
Func _scroll()
	If TimerDiff($timer) < 160000 Then
 		If StringLen(GUICtrlRead($label6)) < StringLen($text) Then
			GUICtrlSetData($label6, $text);��̬Ч��
			;GUICtrlSetData($label6, StringLeft($text, $i))
		    ;$i += 1
		Else
           	GUICtrlSetData($label6, StringTrimLeft(GUICtrlRead($label6), 1) & StringLeft(GUICtrlRead($label6), 1))
		EndIf
	Else
		GUICtrlSetData($label6, '')
	EndIf
EndFunc
#ce