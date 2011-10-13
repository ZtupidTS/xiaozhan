;ShellExecute(@DesktopDir & "\宽带连接.lnk")
;FileCreateShortcut ( "目标文件", "lnk文件" [, "工作目录" [, "参数" [, "描述" [, "图标文件" [, "快捷键" [, 图标编号 [, 状态]]]]]]] );如何给快捷方式添加快捷键
Run("F:\无线投影测试脚本\arp -d.bat","F:\无线投影测试脚本\", "")
#include <Process.au3>
#include <IE.au3>
#Include <WinAPI.au3>
_RunDos("start http://192.168.120.10/zh_CN/settings.asp");运行网站的方法
;sleep(5000)


Opt("WinTitleMatchMode", 4)
WinWait("连接到 192.168.120.10","",5)
SendKeepActive("连接到 192.168.120.10")
BlockInput(1)
$var = ControlGetText("连接到 192.168.120.10", "", "[ID:1003]")
ControlClick( "连接到 192.168.120.10", "", "[ID:1003]") ;向指定控件发送鼠标点击命令
WinActivate ( "连接到 192.168.120.10","" );激活指定的窗口(设置焦点到该窗口,使其成为活动窗口).
Send("admin")  ;
BlockInput(0)
Opt("WinTitleMatchMode", 4)
WinWait("连接到 192.168.120.10","",5)
BlockInput(1)
$var = ControlGetText("连接到 192.168.120.10", "", "[ID:1005]")
ControlClick( "连接到 192.168.120.10", "", "[ID:1005]") ;向指定控件发送鼠标点击命令
WinActivate ( "连接到 192.168.120.10","" );激活指定的窗口(设置焦点到该窗口,使其成为活动窗口).
Send("1234{Enter}")  ;
BlockInput(0)

Sleep(5000)
$handle = WinGetHandle("Wireless Projection Adapter - Microsoft Internet Explorer", "")
_WinAPI_ShowWindow($handle, @SW_SHOWMAXIMIZED)