#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=L:\���Խű�\1648872206.exe|-1
#AutoIt3Wrapper_Outfile=1648872206.exe
#AutoIt3Wrapper_Outfile_x64=G:\Autoit3\Aut2Exe\Aut2exe_x64.exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
ShellExecute("QQ.exe","","G:\toors\QQ\Bin\")




			Opt("MouseCoordMode", 0)
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
					ControlSetText($title, $text, "[CLASS:" & $array[$i] & "; INSTANCE:1]", �ʺ�, 1);�˺�
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
					Send("QQ����")
					Send("{enter}")
				Next
	EndIf			