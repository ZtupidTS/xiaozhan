#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_outfile=jylog.exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
;ShellExecute(@ScriptDir&"\jylog.exe","jycel1",@ScriptDir&"\")
;����Ϊ���ô��룬�����jycel1����
If $cmdline[0] = 1 Then
	If $cmdline[1] = "jycel1" Then
		_jycel1()
	ElseIf $cmdline[1] = "jycel2" Then
		_jycel2()
	EndIf
Else    
	MsgBox(16,"��ʾ����","�㻹δ�Ӳ�������",10)
	Exit
EndIf

Func _jycel1()
MsgBox(64,"��ʾ����","��ǰ���ò���Ϊjycel1",10)
EndFunc
Func _jycel2()
MsgBox(64,"��ʾ����","��ǰ���ò���Ϊjycel2",10)
EndFunc