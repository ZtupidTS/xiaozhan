#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=..\..\qq.ico
#AutoIt3Wrapper_outfile=C:\Users\xiaozhan\Desktop\1648872206 QQ.exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
Opt("MouseCoordMode", 0)
			ShellExecute("QQ.exe","","D:\QQϵ��\QQ2010\Bin")
			;ShellExecute($qq_exe) ;ִ��QQ
			$title = "QQ20" ;���ڱ���
			$text = ""  ;�����ı�
			WinWaitActive($title, $text, 5) ;��ͣ�ű���ִ��ֱ��ָ�����ڱ�����(��Ϊ�״̬)Ϊֹ.

			If WinExists($title, $text) Then ;�ж�
				;����
				WinWait($title, $text, 1) ;��ͣ�ű���ִ��ֱ��ָ�����ڴ���(����)Ϊֹ.
				If Not WinActive($title, $text) Then WinActivate($title, $text);����ָ���Ĵ���(���ý��㵽�ô���,ʹ���Ϊ�����).
				WinWaitActive($title, $text, 1) ;��ͣ�ű���ִ��ֱ��ָ�����ڱ�����(��Ϊ�״̬)Ϊֹ.

				$ClassList = WinGetClassList($title, $text) ;��ȡָ�����ڵ����пؼ�����б�.

				;�����˺�
				If Not WinActive($title, $text) Then WinActivate($title, $text);����ָ���Ĵ���(���ý��㵽�ô���,ʹ���Ϊ�����).
				$array = StringRegExp($ClassList, ".*", 1) ;����ִ��Ƿ���ϸ�����������ʽ.
				For $i = 0 To UBound($array) - 1
					;MsgBox(4096, "3081A", $array[$i])
					
					If Not WinActive($title, $text) Then WinActivate($title, $text);����ָ���Ĵ���(���ý��㵽�ô���,ʹ���Ϊ�����).
					WinWaitActive($title, $text, 1) ;��ͣ�ű���ִ��ֱ��ָ�����ڱ�����(��Ϊ�״̬)Ϊֹ.
					ControlClick($title,$text, "[CLASS:" & $array[$i] & "; INSTANCE:1]","left",2)
					ControlSetText($title, $text, "[CLASS:" & $array[$i] & "; INSTANCE:1]", 1648872206, 1);�˺�
				Next


				;��������  ģ�����
				;MouseClick("Left", 143, 146, 1, 0);ִ�����������.
				;����
				;Send($mima)


				;��������
				If Not WinActive($title, $text) Then WinActivate($title, $text)
				$array = StringRegExp($ClassList, "\n.*", 1);����ִ��Ƿ���ϸ�����������ʽ.
				For $i = 0 To UBound($array) - 1
					$aa = StringTrimLeft($array[$i], 1);ɾ���ַ����д���ʼָ���������ַ�
					;MsgBox(4096, "3081A", $aa)
					
					If Not WinActive($title, $text) Then WinActivate($title, $text);����ָ���Ĵ���(���ý��㵽�ô���,ʹ���Ϊ�����).
					WinWaitActive($title, $text, 1) ;��ͣ�ű���ִ��ֱ��ָ�����ڱ�����(��Ϊ�״̬)Ϊֹ.
					
					;ControlSetText($title, $text, "[CLASS:" & $aa & "; INSTANCE:1]", $mima, 1) ;ControlSend��֧������ ����
					Send("{TAB}")
					Send("123456789")
					Send("{enter}")
				Next
	EndIf			