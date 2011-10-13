#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=..\Program Files\AutoIt3\Aut2Exe\Icons\Bridge.ico
#AutoIt3Wrapper_outfile=F:\无线投影测试脚本\整个网页测试.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
HotKeySet("!a", "ShowMessage")          ;ALT+a 注释符号（；）
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z

;ShellExecute(@DesktopDir & "\宽带连接.lnk")
;FileCreateShortcut ( "目标文件", "lnk文件" [, "工作目录" [, "参数" [, "描述" [, "图标文件" [, "快捷键" [, 图标编号 [, 状态]]]]]]] );如何给快捷方式添加快捷键
Run("F:\无线投影测试脚本\arp -d.bat","F:\无线投影测试脚本\", "")
#include <Process.au3>
#include <IE.au3>
#Include <WinAPI.au3>
_RunDos("start http://192.168.10.1/zh_CN/settings.asp");运行网站的方法
;sleep(5000)


Opt("WinTitleMatchMode", 4)
WinWait("连接到 192.168.10.1","",5)
SendKeepActive("连接到 192.168.10.1")
BlockInput(1)
$var = ControlGetText("连接到 192.168.10.1", "", "[ID:1003]")
ControlClick( "连接到 192.168.10.1", "", "[ID:1003]") ;向指定控件发送鼠标点击命令
WinActivate ( "连接到 192.168.10.1","" );激活指定的窗口(设置焦点到该窗口,使其成为活动窗口).
Send("admin")  ;
BlockInput(0)
Opt("WinTitleMatchMode", 4)
WinWait("连接到 192.168.10.1","",5)
BlockInput(1)
$var = ControlGetText("连接到 192.168.10.1", "", "[ID:1005]")
ControlClick( "连接到 192.168.10.1", "", "[ID:1005]") ;向指定控件发送鼠标点击命令1234

WinActivate ( "连接到 192.168.10.1","" );激活指定的窗口(设置焦点到该窗口,使其成为活动窗口).
Send("1234{Enter}")  ;
BlockInput(0)

Sleep(5000)
$handle = WinGetHandle("Wireless Projection Adapter - Microsoft Internet Explorer", "")
_WinAPI_ShowWindow($handle, @SW_SHOWMAXIMIZED)

Sleep(3000)



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
$var = ControlGetText("选择文件", "", "[ID:1148]") ;获取指定控件上的文本.1234
ControlClick( "选择文件", "", "[ID:1148]") 
;ControlSend("添加播放文件", "", "[ID:1148]", "F:\testtools\files\!o");ControlSend不支持中文
Send("F:\testtools\Projection.cfg!o") ;ALT+a 注释符号 用快捷方式打开文件
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



Func ShowMessage()   ;Func的意思创建自定义函数
    Dim $i=MsgBox(1,"退出脚本","确定退出脚本吗")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc
