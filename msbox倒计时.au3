;#include <msgboxDJS_UDF.au3>
;========����1�����⵹��ʱ��
$msg = MsgBoxDJS(48 + 3, '�������ӣ��� %s ����Զ����Ĭ�ϵİ�ť(��)', 'ʱ�䵽�󽫵��Ĭ�ϵİ�ť(��)��������һ�����ӣ��Ƿ������', 10, 0)
If $msg = 7 Then exit (MsgBox(64, 'ok', '�ѵ���������˳�'))
If $msg = 2 Then exit (MsgBox(64, 'ok', '�ѵ��ȡ����رգ������˳�'))

;========����2����Ϣ�򵹼�ʱ��
$msg = MsgBoxDJS(48 + 1, '��Ϣ�����ӣ�ʱ�䵽�󽫵��Ĭ�ϵİ�ť(ȷ��)', 'ʱ�䵽���Զ����Ĭ�ϵİ�ť(ȷ��)��������һ�����ӣ�' & @CRLF & '�Ƿ��������ʣ�� %s �룩', 10, 1)
If $msg = 2 Then exit (MsgBox(64, 'ok', '�ѵ��ȡ����رգ������˳�'))

;========����3����ť����ʱ��
$msg = MsgBoxDJS(256 + 48 + 4, '��ť���ӣ�Ĭ�ϰ�ť(��)', 'ʱ�䵽���Զ����Ĭ�ϵİ�ť(��)���������ӣ�' & @CRLF & '�Ƿ������', 10, 2)
If $msg = 6 Then exit (MsgBox(64, 'ok', '������������������ѽ���~ ^ ^'))
Func MsgBoxDJS($flag, $title, $text, $timeout = 10, $Cflag = 1, $hwnd = '')
	Global $Timer = DllCallbackRegister('Timer', 'int', 'hwnd;uint;uint;dword')
	If $timeout = '' Or $timeout = -1 Then $timeout = 10
	Global $_title = $title, $_text = $text, $_Cflag = $Cflag, $_ibj = 1, $_ttc = $timeout, $bttxtbj = 0
	Global $TimerDLL = DllCall('user32.dll', 'uint', 'SetTimer', 'hwnd', 0, 'uint', 0, 'int', 1000, 'ptr', DllCallbackGetPtr($Timer))
	Local $Mkmsg
	If $Cflag = 0 Then
		If StringRegExp($title, '%s') = 0 Then
			$title = '%s' & $title
			$_title = $title
		EndIf
		$title = StringRegExpReplace($title, "%s", StringFormat('%03s', $_ttc), 1)
	EndIf
	If $Cflag = 1 Then
		If StringRegExp($text, '%s') = 0 Then
			$text = '%s' & $text
			$_text = $text
		EndIf
		$text = StringRegExpReplace($text, "%s", StringFormat('%03s', $_ttc), 1)
	EndIf
	$Mkmsg = MsgBox($flag, $title, $text)
	DllClose($TimerDLL)
	DllCallbackFree($Timer)
	Return $Mkmsg
EndFunc   ;==>MsgBoxDJS
Func Timer($hwnd, $uiMsg, $idEvent, $dwTime)
	Global $TimerDLL, $bttxtbj, $_Cflag, $_title, $_ttc, $_text, $_ibj, $Timer
	If $idEvent = $TimerDLL[0] Then
		Global $bttxt, $CtrlF, $Static
		If $bttxtbj = 0 Then
			If $_Cflag = 0 Then $CtrlF = ControlGetFocus(StringRegExpReplace($_title, "%s", StringFormat('%03s', $_ttc), 1))
			If $_Cflag = 1 Or $_Cflag = 2 Then $CtrlF = ControlGetFocus($_title)
			$bttxt = ControlGetText($_title, $_text, $CtrlF)
			If $_Cflag = 1 Then
				$Static = 'Static1'
				ControlGetText($_title, StringRegExpReplace($_text, "%s", StringFormat('%03s', $_ttc), 1), 'Static1')
				If @error Then $Static = 'Static2'
			EndIf
			$bttxtbj = 1
		EndIf
		If $_Cflag = 0 Then
			$_title1 = StringRegExpReplace($_title, "%s", StringFormat('%03s', $_ttc - $_ibj + 1), 1)
			$_title2 = StringRegExpReplace($_title, "%s", StringFormat('%03s', $_ttc - $_ibj), 1)
			WinSetTitle($_title1, $_text, $_title2)
		ElseIf $_Cflag = 1 Then
			$_text1 = StringRegExpReplace($_text, "%s", StringFormat('%03s', $_ttc - $_ibj + 1), 1)
			$_text2 = StringRegExpReplace($_text, "%s", StringFormat('%03s', $_ttc - $_ibj), 1)
			ControlSetText($_title, $_text1, $Static, $_text2)
		ElseIf $_Cflag = 2 Then
			ControlSetText($_title, $_text, $CtrlF, $bttxt & StringFormat(' %03s', $_ttc - $_ibj))
		EndIf
		If $_ibj = $_ttc Then
			If $_Cflag = 0 Then $_title = $_title2
			If $_Cflag = 1 Then $_text = $_text2
			DllClose($TimerDLL)
			DllCallbackFree($Timer)
			ControlClick($_title, $_text, $CtrlF, '', 2)
		EndIf
		$_ibj += 1
	EndIf
EndFunc

 