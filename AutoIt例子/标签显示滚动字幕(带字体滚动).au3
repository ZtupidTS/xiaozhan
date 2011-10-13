#include<guiconstantsex.au3>
Global $i =1, $label, $text, $timer = TimerInit()
_main()
Func _main()
	GUICreate("example", 200,200,50,50)
	$label = GUICtrlCreateLabel("", 2, 50, 196, 12)
	$text = "资料已经保存可以使用配置文件"
	GUISetState()
	AdlibRegister("_scroll", 1000)
    Do
    Until GUIGetMsg() = $GUI_EVENT_CLOSE
    GUIDelete()
EndFunc

Func _scroll()
	If TimerDiff($timer) < 9000 Then
       GUICtrlSetData($label6, $text);静态效果
       	;GUICtrlSetData($label6, StringLeft($text,$i));动态效果
		;$i += 1
	Else
		GUICtrlSetData($label, '')
	EndIf
	$i += 1
EndFunc

#cs
字体可以滚动(头尾接着不接着)
Func _scroll()
	If TimerDiff($timer) < 16000 Then
		If StringLen(GUICtrlRead($label6)) < StringLen($text) Then
			GUICtrlSetData($label6, $text);静态效果
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
字体可以滚动(头尾不接着)
Func _scroll()
	If TimerDiff($timer) < 160000 Then
 		If StringLen(GUICtrlRead($label6)) < StringLen($text) Then
			GUICtrlSetData($label6, $text);静态效果
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