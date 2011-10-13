HotKeySet("!a", "ShowMessage")          ;ALT+a 注释符号（；）
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z
;登录模块
Run("C:\Program Files\FT-200W-zh\FT-200W.exe","C:\Program Files\FT-200W-zh", "")
Sleep(3000)  ;使脚本暂停指定时间段.;(5000为5秒)
Opt("WinTitleMatchMode", 4)
WinWait("[CLASS:Edit; INSTANCE:1]","",5)
BlockInput(1)
$var = ControlGetText("[CLASS:#32770]", "", "Edit1")
ControlClick( "[CLASS:#32770]", "", "Edit1")
WinWaitActive("[CLASS:#32770]")
Send("4612")  ;
BlockInput(0)
ControlClick( "[CLASS:#32770]", "", "[ID:1012]") ;向指定控件发送鼠标点击命令
Sleep(1000*10)  
;开启投影模块
ControlClick( "FT-200W", "", "[ID:1000]")
Sleep(5000) 
;关闭投影模块
ControlClick( "FT-200W", "", "[ID:1000]") 
Sleep(5000) 
;开启投影模块
ControlClick( "FT-200W", "", "[ID:1001]")
Sleep(5000)  
;关闭投影模块
ControlClick( "FT-200W", "", "[ID:1001]") 
Sleep(5000) 
;开启黑屏模块
ControlClick( "FT-200W", "", "[ID:1003]") 
Sleep(5000) 
;关闭黑屏模块
ControlClick( "FT-200W", "", "[ID:1003]") 
Sleep(5000) 
;播放视频模块
ControlClick( "FT-200W", "", "[ID:1004]") 
Sleep(5000) 
ControlClick( "播放列表", "", "[ID:1074]") ;
Sleep(5000)

WinActivate ( "添加播放文件","" );激活指定的窗口(设置焦点到该窗口,使其成为活动窗口).
BlockInput(1) ;屏蔽/启用鼠标与键盘(输入).
$var = ControlGetText("添加播放文件", "", "Edit1") ;获取指定控件上的文本.
ControlClick( "添加播放文件", "", "Edit1") 
Send("F:\testtools\files\!o") ;ALT+a 注释符号 用快捷方式打开文件
BlockInput(0)

WinActivate ( "添加播放文件","" );激活指定的窗口(设置焦点到该窗口,使其成为活动窗口).
BlockInput(1)
$var = ControlGetText("添加播放文件", "", "Edit1")
ControlClick( "添加播放文件", "", "Edit1")
Send("test.mpg!o")  ;ALT+a 注释符号 用快捷方式打开文件
BlockInput(0)

sleep(1000*30)

WinActivate ( "FT-200W","" );激活指定的窗口(设置焦点到该窗口,使其成为活动窗口).
ControlClick( "FT-200W", "", "[ID:1004]") 
Sleep(3000)


;会议控制模块
ControlClick( "FT-200W", "", "[ID:1005]")
Sleep(2000)
BlockInput(1)
$var = ControlGetText("#32770", "", "Edit1")
ControlClick( "#32770", "", "Edit1")
Send("1234{Enter}") 
BlockInput(0)
Sleep(5000)
ControlClick( "会议控制台", "", "[ID:1057]", "left", 2, 98, 31)
Sleep(5000)
ControlClick( "会议控制台", "", "[ID:1057]", "left", 2, 96, 49)
Sleep(5000)
;退出会议控制模块
ControlClick( "会议控制台", "", "[ID:8]")
Sleep(5000)
;  循环模块
$i = 0
Do
ControlClick( "FT-200W", "", "[ID:1000]")
Sleep(5000) 
;关闭投影模块
ControlClick( "FT-200W", "", "[ID:1000]") 
Sleep(5000) 
;开启投影模块
ControlClick( "FT-200W", "", "[ID:1001]")
Sleep(5000)  
;关闭投影模块
ControlClick( "FT-200W", "", "[ID:1001]") 
Sleep(5000) 
;开启黑屏模块
ControlClick( "FT-200W", "", "[ID:1003]") 
Sleep(5000) 
;关闭黑屏模块
ControlClick( "FT-200W", "", "[ID:1003]") 
Sleep(5000) 
;播放视频模块
ControlClick( "FT-200W", "", "[ID:1004]") 
Sleep(3000) 
WinActivate ( "媒体播放器","" );激活指定的窗口(设置焦点到该窗口,使其成为活动窗口).
ControlClick( "媒体播放器", "", "[ID:1065]","left", 2) ;
sleep(1000*30)

WinActivate ( "FT-200W","" );激活指定的窗口(设置焦点到该窗口,使其成为活动窗口).
ControlClick( "FT-200W", "", "[ID:1004]") 
Sleep(3000)

;会议控制模块
ControlClick( "FT-200W", "", "[ID:1005]")
Sleep(5000)
BlockInput(1)
$var = ControlGetText("#32770", "", "Edit1")
ControlClick( "#32770", "", "Edit1")
Send("1234{Enter}") 
BlockInput(0)
Sleep(5000)
ControlClick( "会议控制台", "", "[ID:1057]", "left", 2, 98, 31)
Sleep(5000)
ControlClick( "会议控制台", "", "[ID:1057]", "left", 2, 96, 49)
Sleep(5000)
;退出会议控制模块
ControlClick( "会议控制台", "", "[ID:8]")
Sleep(5000)

  $i = $i + 1
Until $i = 960000
Func ShowMessage()   ;Func的意思创建自定义函数
    Dim $i=MsgBox(1,"退出脚本","确定退出脚本吗")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc
