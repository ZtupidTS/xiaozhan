;#include <msgboxDJS_UDF.au3>
;========例子1：标题倒计时。
$msg = MsgBoxDJS(48 + 3, '标题例子：在 %s 秒后将自动点击默认的按钮(是)', '时间到后将点击默认的按钮(是)而继续下一个例子，是否继续？', 10, 0)
If $msg = 7 Then exit (MsgBox(64, 'ok', '已点击否，例子退出'))
If $msg = 2 Then exit (MsgBox(64, 'ok', '已点击取消或关闭，例子退出'))

;========例子2：消息框倒计时。
$msg = MsgBoxDJS(48 + 1, '消息框例子：时间到后将点击默认的按钮(确定)', '时间到后将自动点击默认的按钮(确定)而继续下一个例子，' & @CRLF & '是否继续？（剩余 %s 秒）', 10, 1)
If $msg = 2 Then exit (MsgBox(64, 'ok', '已点击取消或关闭，例子退出'))

;========例子3：按钮倒计时。
$msg = MsgBoxDJS(256 + 48 + 4, '按钮例子：默认按钮(否)', '时间到后将自动点击默认的按钮(否)而结束例子，' & @CRLF & '是否继续？', 10, 2)
If $msg = 6 Then exit (MsgBox(64, 'ok', '你想继续，不过例子已结束~ ^ ^'))
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

 