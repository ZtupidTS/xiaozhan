
HotKeySet("!a", "ShowMessage")          ;ALT+a 注释符号（；）
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z

WinActivate ( "FT-200W","" );激活指定的窗口(设置焦点到该窗口,使其成为活动窗口).
ControlClick( "FT-200W", "", "[ID:1004]")
Sleep(3000)
ControlClick( "播放列表", "", "[ID:1074]")
Sleep(3000)
WinActivate ( "添加播放文件","" );激活指定的窗口(设置焦点到该窗口,使其成为活动窗口).
BlockInput(1)
$var = ControlGetText("添加播放文件", "", "Edit1")
ControlClick( "添加播放文件", "", "Edit1")
Send("F:\testtools\files!o") ;ALT+a 注释符号 用快捷方式打开文件
BlockInput(0)

WinActivate ( "添加播放文件","" );激活指定的窗口(设置焦点到该窗口,使其成为活动窗口).
BlockInput(1)
$var = ControlGetText("添加播放文件", "", "Edit1")
ControlClick( "添加播放文件", "", "Edit1")
Send("test.mpg!o")  ;ALT+a 注释符号 用快捷方式打开文件
BlockInput(0)


MsgBox(1,"退出脚本","确定退出脚本吗")
Func ShowMessage()   ;Func的意思创建自定义函数
    Dim $i=MsgBox(1,"退出脚本","确定退出脚本吗")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc