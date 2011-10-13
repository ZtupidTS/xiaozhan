HotKeySet("!a", "ShowMessage")          ;ALT+a 注释符号（；）
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z

WinActivate ( "FT-200W","" );激活指定的窗口(设置焦点到该窗口,使其成为活动窗口).
ControlClick( "FT-200W", "", "[ID:1005]")
Sleep(2000)
BlockInput(1)
$var = ControlGetText("#32770", "", "Edit1")
ControlClick( "#32770", "", "Edit1")
Send("1234{Enter}") 
BlockInput(0)
Sleep(2000)
ControlClick( "会议控制台", "", "[ID:1057]", "left", 2, 98, 31)
Sleep(5000)
ControlClick( "会议控制台", "", "[ID:1057]", "left", 2, 96, 49)
Sleep(5000)

ControlClick( "会议控制台", "", "[ID:8]")
MsgBox(1,"退出脚本","确定退出脚本吗")
Func ShowMessage()   ;Func的意思创建自定义函数
    Dim $i=MsgBox(1,"退出脚本","确定退出脚本吗")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc