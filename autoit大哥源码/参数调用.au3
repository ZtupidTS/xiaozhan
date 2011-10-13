#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_outfile=jylog.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
;ShellExecute(@ScriptDir&"\jylog.exe","jycel1",@ScriptDir&"\")
;上面为调用代码，需更改jycel1即可
If $cmdline[0] = 1 Then
	If $cmdline[1] = "jycel1" Then
		_jycel1()
	ElseIf $cmdline[1] = "jycel2" Then
		_jycel2()
	EndIf
Else    
	MsgBox(16,"提示标题","你还未加参数调用",10)
	Exit
EndIf

Func _jycel1()
MsgBox(64,"提示标题","当前调用参数为jycel1",10)
EndFunc
Func _jycel2()
MsgBox(64,"提示标题","当前调用参数为jycel2",10)
EndFunc