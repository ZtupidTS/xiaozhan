#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=L:\测试脚本\1648872206.exe|-1
#AutoIt3Wrapper_Outfile=1648872206.exe
#AutoIt3Wrapper_Outfile_x64=G:\Autoit3\Aut2Exe\Aut2exe_x64.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
ShellExecute("QQ.exe","","G:\toors\QQ\Bin\")




			Opt("MouseCoordMode", 0)
			;ShellExecute($qq_exe) ;执行QQ
			$title = "QQ20" ;窗口标题
			$text = ""  ;窗口文本
			WinWaitActive($title, $text, 5) ;暂停脚本的执行直至指定窗口被激活(成为活动状态)为止.

			If WinExists($title, $text) Then ;判断
				;存在
				WinWait($title, $text, 1) ;暂停脚本的执行直至指定窗口存在(出现)为止.
				If Not WinActive($title, $text) Then WinActivate($title, $text);激活指定的窗口(设置焦点到该窗口,使其成为活动窗口).
				WinWaitActive($title, $text, 1) ;暂停脚本的执行直至指定窗口被激活(成为活动状态)为止.

				$ClassList = WinGetClassList($title, $text) ;获取指定窗口的所有控件类的列表.

				;激活账号
				If Not WinActive($title, $text) Then WinActivate($title, $text);激活指定的窗口(设置焦点到该窗口,使其成为活动窗口).
				$array = StringRegExp($ClassList, ".*", 1) ;检查字串是否符合给定的正则表达式.
				For $i = 0 To UBound($array) - 1
					;MsgBox(4096, "3081A", $array[$i])
					
					If Not WinActive($title, $text) Then WinActivate($title, $text);激活指定的窗口(设置焦点到该窗口,使其成为活动窗口).
					WinWaitActive($title, $text, 1) ;暂停脚本的执行直至指定窗口被激活(成为活动状态)为止.
					ControlClick($title,$text, "[CLASS:" & $array[$i] & "; INSTANCE:1]","left",2)
					ControlSetText($title, $text, "[CLASS:" & $array[$i] & "; INSTANCE:1]", 帐号, 1);账号
				Next


				;激活密码  模拟鼠标
				;MouseClick("Left", 143, 146, 1, 0);执行鼠标点击操作.
				;密码
				;Send($mima)


				;激活密码
				If Not WinActive($title, $text) Then WinActivate($title, $text)
				$array = StringRegExp($ClassList, "\n.*", 1);检查字串是否符合给定的正则表达式.
				For $i = 0 To UBound($array) - 1
					$aa = StringTrimLeft($array[$i], 1);删除字符串中从左开始指定数量的字符
					;MsgBox(4096, "3081A", $aa)
					
					If Not WinActive($title, $text) Then WinActivate($title, $text);激活指定的窗口(设置焦点到该窗口,使其成为活动窗口).
					WinWaitActive($title, $text, 1) ;暂停脚本的执行直至指定窗口被激活(成为活动状态)为止.
					
					;ControlSetText($title, $text, "[CLASS:" & $aa & "; INSTANCE:1]", $mima, 1) ;ControlSend不支持中文 密码
					Send("{TAB}")
					Send("QQ密码")
					Send("{enter}")
				Next
	EndIf			