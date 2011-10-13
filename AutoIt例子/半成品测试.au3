#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=F:\无线投影测试脚本\ico\全面测试脚本(登录后用).ico
#AutoIt3Wrapper_outfile=F:\无线投影测试脚本\半成品测试.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
HotKeySet("!a", "ShowMessage")          ;ALT+a 注释符号（；）
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z


	  
;登录模块
;Run("C:\Program Files\FT-200W-zh\FT-200W.exe","C:\Program Files\FT-200W-zh", "")
;Sleep(3000)  ;使脚本暂停指定时间段.;(5000为5秒)
;Opt("WinTitleMatchMode", 4)
;WinWait("[CLASS:Edit; INSTANCE:1]","",5)
;BlockInput(1)
;$var = ControlGetText("[CLASS:#32770]", "", "Edit1")
;ControlClick( "[CLASS:#32770]", "", "Edit1")
;WinWaitActive("[CLASS:#32770]")
;Send("4612")  ;
;BlockInput(0)
;ControlClick( "[CLASS:#32770]", "", "[ID:1012]") ;向指定控件发送鼠标点击命令
;Sleep(1000*10)  
WinActivate ( "FT-200W","" );激活指定的窗口(设置焦点到该窗口,使其成为活动窗口).
;开启投影模块
ControlClick( "FT-200W", "", "[ID:1000]")
Sleep(3000) 
;关闭投影模块
WinActivate ( "FT-200W","" )
ControlClick( "FT-200W", "", "[ID:1000]") 
Sleep(5000) 
;开启投影模块
WinActivate ( "FT-200W","" )
ControlClick( "FT-200W", "", "[ID:1001]")
Sleep(3000)  
;关闭投影模块
WinActivate ( "FT-200W","" )
ControlClick( "FT-200W", "", "[ID:1001]") 
Sleep(3000) 
;开启黑屏模块
WinActivate ( "FT-200W","" )
ControlClick( "FT-200W", "", "[ID:1003]") 
Sleep(3000) 
;关闭黑屏模块
WinActivate ( "FT-200W","" )
ControlClick( "FT-200W", "", "[ID:1003]") 
Sleep(3000) 
;播放视频模块
WinActivate ( "FT-200W","" )
ControlClick( "FT-200W", "", "[ID:1004]") 
Sleep(3000) 
ControlClick( "播放列表", "", "[ID:1074]") ;
Sleep(3000)

WinActivate ( "添加播放文件","" );激活指定的窗口(设置焦点到该窗口,使其成为活动窗口).
BlockInput(1) ;屏蔽/启用鼠标与键盘(输入).
$var = ControlGetText("添加播放文件", "", "[ID:1148]") ;获取指定控件上的文本.
ControlClick( "添加播放文件", "", "[ID:1148]") 
;ControlSend("添加播放文件", "", "[ID:1148]", "F:\testtools\files\!o");ControlSend不支持中文
Send("F:\testtools\files\!o") ;ALT+a 注释符号 用快捷方式打开文件
BlockInput(0)

WinActivate ( "添加播放文件","" );激活指定的窗口(设置焦点到该窗口,使其成为活动窗口).
BlockInput(1)
$var = ControlGetText("添加播放文件", "", "Edit1")
WinActivate ( "添加播放文件","" )
ControlClick( "添加播放文件", "", "Edit1")
;ControlSend("添加播放文件", "", "[ID:1148]", "test.mpg!o");ControlSend不支持中文
Send("test.mpg!o")  ;ALT+a 注释符号 用快捷方式打开文件
BlockInput(0)

sleep(1000*25)

WinActivate ( "FT-200W","" );激活指定的窗口(设置焦点到该窗口,使其成为活动窗口).
ControlClick( "FT-200W", "", "[ID:1004]") 
Sleep(3000)

;会议控制模块
WinActivate ( "FT-200W","" )
ControlClick( "FT-200W", "", "[ID:1005]")
Sleep(2000)
BlockInput(1)
$var = ControlGetText("CLASS:#32770", "", "Edit1")
WinActivate ( "CLASS:#32770","" )
ControlClick( "CLASS:#32770", "", "Edit1")
;ControlSend("CLASS:#32770", "", "[ID:1014]", "1234{Enter}")
Send("1234{Enter}") 
BlockInput(0)
Sleep(3000)
WinActivate ( "会议控制台","" )
ControlClick( "会议控制台", "", "[ID:1057]", "left", 2, 98, 31)
Sleep(1000*10)
WinActivate ( "会议控制台","" )
ControlClick( "会议控制台", "", "[ID:1057]", "left", 2, 96, 49)
Sleep(1000*10)
;  循环模块


WinActivate ( "会议控制台","" )
ControlClick( "会议控制台", "", "[ID:8]")
Sleep(3000)
WinActivate ( "FT-200W","" );激活指定的窗口(设置焦点到该窗口,使其成为活动窗口).
;关闭PC端
ControlClick( "FT-200W", "", "[ID:1011]")


Func ShowMessage()   ;Func的意思创建自定义函数
    Dim $i=MsgBox(1,"退出脚本","确定退出脚本吗")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc
