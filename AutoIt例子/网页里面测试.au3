;投影设置
WinActivate ( "Wireless Projection Adapter - Microsoft Internet Explorer","" )
ControlClick( "Wireless Projection Adapter - Microsoft Internet Explorer", "", "Internet Explorer_Server1","left", 1, 51, 185)
sleep(5000)
;无线设置 
WinActivate ( "Wireless Projection Adapter - Microsoft Internet Explorer","" )
ControlClick( "Wireless Projection Adapter - Microsoft Internet Explorer", "", "Internet Explorer_Server1","left", 1, 48, 206)
sleep(5000)
;网络设置
WinActivate ( "Wireless Projection Adapter - Microsoft Internet Explorer","" )
ControlClick( "Wireless Projection Adapter - Microsoft Internet Explorer", "", "Internet Explorer_Server1","left", 1, 49, 231)
sleep(5000) 
;自动休眠设置 
WinActivate ( "Wireless Projection Adapter - Microsoft Internet Explorer","" )
ControlClick( "Wireless Projection Adapter - Microsoft Internet Explorer", "", "Internet Explorer_Server1","left", 1, 46, 272)
sleep(5000)
;输出端口设置
WinActivate ( "Wireless Projection Adapter - Microsoft Internet Explorer","" )
ControlClick( "Wireless Projection Adapter - Microsoft Internet Explorer", "", "Internet Explorer_Server1","left", 1, 43, 291)
sleep(5000)
;修改密码
WinActivate ( "Wireless Projection Adapter - Microsoft Internet Explorer","" )
ControlClick( "Wireless Projection Adapter - Microsoft Internet Explorer", "", "Internet Explorer_Server1","left", 1, 52, 320)
sleep(5000)
;备份设置
WinActivate ( "Wireless Projection Adapter - Microsoft Internet Explorer","" )
ControlClick( "Wireless Projection Adapter - Microsoft Internet Explorer", "", "Internet Explorer_Server1","left", 1, 48, 338)
sleep(5000)
;还原备份
WinActivate ( "Wireless Projection Adapter - Microsoft Internet Explorer","" )
ControlClick( "Wireless Projection Adapter - Microsoft Internet Explorer", "", "Internet Explorer_Server1","left", 1, 719, 262)
sleep(5000)

WinActivate ( "选择文件","" );激活指定的窗口(设置焦点到该窗口,使其成为活动窗口).
SendKeepActive("选择文件")
BlockInput(1) ;屏蔽/启用鼠标与键盘(输入).
$var = ControlGetText("选择文件", "", "[ID:1148]") ;获取指定控件上的文本.
ControlClick( "选择文件", "", "[ID:1148]") 
;ControlSend("添加播放文件", "", "[ID:1148]", "F:\testtools\files\!o");ControlSend不支持中文
Send("F:\无线投影测试脚本\Projection.cfg!o") ;ALT+a 注释符号 用快捷方式打开文件
BlockInput(0)

Sleep(3000)

WinActivate ( "Wireless Projection Adapter - Microsoft Internet Explorer","" )
ControlClick( "Wireless Projection Adapter - Microsoft Internet Explorer", "", "Internet Explorer_Server1","left", 1, 437 ,299)
sleep(5000)

WinActivate ( "Microsoft Internet Explorer","" )
ControlClick( "Microsoft Internet Explorer", "", "[ID:1]")
sleep(3000)

WinActivate ( "Microsoft Internet Explorer","" )
ControlClick( "Microsoft Internet Explorer", "", "[ID:2]")
sleep(3000)

WinActivate ( "Wireless Projection Adapter - Microsoft Internet Explorer","" )
WinClose( "Wireless Projection Adapter - Microsoft Internet Explorer","" )


