HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")

$i = 0
Do
ShellExecute("Lorex Client 10.exe","","C:\Program Files\Lorex Client 10")
WinWait("Lorex Client 10","Login","Button10")
ControlClick("Lorex Client 10","","Edit1")
Send("172.18.6.14")
ControlClick("Lorex Client 10","","Edit2")
Send("2050")
ControlClick("Lorex Client 10","","Edit3")
Send("admin")
ControlClick("Lorex Client 10","","Edit4")
Send("519070")
ControlClick("Lorex Client 10","StartPreview","Button9")
ControlClick("Lorex Client 10","Login","Button10")
WinWait("Lorex Client 10","Remote Setting")
ControlClick("Lorex Client 10","Remote Setting","Button3")
ControlTreeView ("Lorex Client 10", "", "SysTreeView321", "Expand", "System|User")
ControlTreeView ("Lorex Client 10", "", "SysTreeView321", "Select", "System|User")
$msg = MsgBoxDJS(0 + 48 + 4, '�����Ƿ�ȫ������', '����ȫ��ʵ������ȷ����' & @CRLF & '�Ƿ������', 5, 2)
ProcessClose ( "Lorex Client 10.exe")
Sleep(1000)

$i = $i + 1
Until $i = 100000000000000000000000000000000000000






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


;==========================================================================================
; ˵��:���޸�MsgBox������ʽ����̬��ʾ����ʱ��
; �﷨:��MsgBoxDJS(msgbox��ʽ��־, '����', '��ʾ�ı�'[, ����ʱ��(��)[, ��̬�ؼ��ı�־[, ���]]])
; ����:��msgbox��ʽ��־��'����'��'��ʾ�ı�'����� ��ͬMsgBox���������������MsgBox()����˵����
;������������ʱʱ��(��) - [��ѡ]��λΪ�룬Ĭ��Ϊ10��
;����������̬�ؼ��ı�־ - [��ѡ] 0 = ��̬"����", 1 = ��̬"��ʾ�ı�"(Ĭ��), 2 = ��̬"��ť"��
; ע��:���ڱ������Ϣ��̬��ʾ��ʱ��Ĭ����ʾ���ַ���ǰ�棬�������������Ҫ��λ�ñ�� %s ��
;��������(������ʾ��%s���ַ���������ʹ�á�%\s��)
; ����ֵ:���ذ��°�ť��ID(ͬMsgBox����)��
; ����:��Afan -- http://www.autoit.net.cn ����udf������ guland ��˼·��THX ~��
;=====================================================================================start
Func MsgBoxDJS($flag, $title, $text, $timeout = 10, $Cflag = 1, $hwnd = '')
	Global $Timer = DllCallbackRegister('Timer', 'int', 'hwnd;uint;uint;dword')
	If $timeout = '' Or $timeout = -1 Then $timeout = 10
	Global $_title = $title, $_text = $text, $_Cflag = $Cflag, $_ibj = 1, $_ttc = $timeout, $bttxtbj = 0
	Global $TimerDLL = DllCall('user32.dll', 'uint', 'SetTimer', 'hwnd', 0, 'uint', 0, 'int', 100, 'ptr', DllCallbackGetPtr($Timer))
	Local $Mkmsg
	If $Cflag = 0 Then
		If StringRegExp($title, '%s') = 0 Then
			$title = '%s' & $title
			$_title = $title
		EndIf
		$title = StringRegExpReplace($title, '%s', StringFormat('%03s', $_ttc))
		$title = StringRegExpReplace($title, '%\\s', '%s')
	EndIf
	If $Cflag = 1 Then
		If StringRegExp($text, '%s') = 0 Then
			$text = '%s' & $text
			$_text = $text
		EndIf
		$text = StringRegExpReplace($text, '%s', StringFormat('%03s', $_ttc))
		$text = StringRegExpReplace($text, '%\\s', '%s')
	EndIf
	$Mkmsg = MsgBox($flag, $title, $text, 0, $hwnd)

	DllClose($TimerDLL)
	DllCallbackFree($Timer)
	Return $Mkmsg
EndFunc   ;==>MsgBoxDJS
Func Timer($hwnd, $uiMsg, $idEvent, $dwTime)
	Global $TimerDLL, $bttxtbj, $_Cflag, $_title, $_ttc, $_text, $_ibj, $Timer, $_titleF, $TimerJS
	If $idEvent = $TimerDLL[0] Then
		Global $bttxt, $CtrlF, $Static
		If $bttxtbj = 0 Then
			WinActivate($_title)
			If $_Cflag = 0 Then
				$_titleF = StringRegExpReplace($_title, '%s', StringFormat('%03s', $_ttc))
				$_titleF = StringRegExpReplace($_titleF, '%\\s', '%s')
				$CtrlF = ControlGetFocus($_titleF)
			EndIf
			If $_Cflag = 1 Or $_Cflag = 2 Then $CtrlF = ControlGetFocus($_title)
			$bttxt = ControlGetText($_title, $_text, $CtrlF)
			If $_Cflag = 1 Then
				$Static = 'Static1'
				ControlGetText($_title, StringRegExpReplace($_text, '%s', StringFormat('%03s', $_ttc)), 'Static1')
				If @error Then $Static = 'Static2'
			EndIf
			$bttxtbj = 1
		EndIf
		If $TimerJS = 9 Then
			If $_Cflag = 0 Then
				$_title1 = StringRegExpReplace($_title, '%s', StringFormat('%03s', $_ttc - $_ibj + 1))
				$_title1 = StringRegExpReplace($_title1, '%\\s', '%s')
				$_title2 = StringRegExpReplace($_title, '%s', StringFormat('%03s', $_ttc - $_ibj))
				$_title2 = StringRegExpReplace($_title2, '%\\s', '%s')
				WinSetTitle($_title1, $_text, $_title2)
			ElseIf $_Cflag = 1 Then
				$_text1 = StringRegExpReplace($_text, '%s', StringFormat('%03s', $_ttc - $_ibj + 1))
				$_text1 = StringRegExpReplace($_text1, '%\\s', '%s')
				$_text2 = StringRegExpReplace($_text, '%s', StringFormat('%03s', $_ttc - $_ibj))
				$_text2 = StringRegExpReplace($_text2, '%\\s', '%s')
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
			$TimerJS = 0
		Else
			$TimerJS += 1
		EndIf
	EndIf
EndFunc   ;==>Timer
;=========================================================================================end