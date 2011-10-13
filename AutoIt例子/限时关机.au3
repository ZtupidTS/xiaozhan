;$answer = InputBox("Question", "Where were you born?", "BlockInput(1)", "", _
	;-1, -1, 0, 0)
;InputBox("请输入你要限时关机的双击键", ""与秒为单位", "Planet Earth", "")
$xiaozhan = InputBox("请输入你要限时关机的时间", "以秒为单位", "请输入数字", "", _
	-1, -1, 0, 0)

Opt("TrayIconHide", 1) 
Dim $i=MsgBox(1, "关机", "限时30秒关机", "$xiaozhan")  ;30是与秒为单位的
if  $i<>2  Then
	 ;Shutdown(13)
	 MsgBox(1, "想重新限时关机", "？新点击限时关机","")
    Exit 0
EndIf
MsgBox(1, "想重新限时关机", "请重新点击限时关机","")
