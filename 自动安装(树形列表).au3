#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿

 Au3 版本:
 脚本作者: 
	Email: 
	QQ/TM: 
 脚本版本: 
 脚本功能: 雨过天晴极速恢复

#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
If FileExists("雨过天晴极速恢复.exe")<>1 Then Exit
Run("雨过天晴极速恢复.exe")
$titile="雨过天晴极速恢复"
WinWait($titile,"谢谢您选择雨过天晴极速恢复")
ControlSend($titile,"谢谢您选择雨过天晴极速恢复","Button2",'!n')

WinWait($titile,"按PAGE DOWN键以查看协议的剩余部分。")
ControlSend($titile,"按PAGE DOWN键以查看协议的剩余部分。","Button7",'!n')

WinWait($titile,"安装程序将在以下文件夹中安装雨过天晴极速恢复。")
ControlClick($titile,"安装程序将在以下文件夹中安装雨过天晴极速恢复。","Button2")

WinWait("浏览文件夹","请选择安装文件夹！")
ControlSend("浏览文件夹","请选择安装文件夹！","SysTreeView321","{home}")

While 1
	;Sleep(100)
	$text=ControlGetText("浏览文件夹","请选择安装文件夹！","Static2")
	If $text="D:\" Then 
	ControlSend("浏览文件夹","请选择安装文件夹！","SysTreeView321","{numpadadd}")
	;----------------
	While 1
		;Sleep(100)
	$text=ControlGetText("浏览文件夹","请选择安装文件夹！","Static2")
	If $text="D:\Program Files" Then 
	ControlClick("浏览文件夹","请选择安装文件夹！","Button1")
	ExitLoop
Else
	ControlSend("浏览文件夹","请选择安装文件夹！","SysTreeView321","{down}")
	EndIf

WEnd
;-----------------------
	ExitLoop
Else
	ControlSend("浏览文件夹","请选择安装文件夹！","SysTreeView321","{down}")
	EndIf

WEnd
ControlSend($titile,"安装程序将在以下文件夹中安装雨过天晴极速恢复。","Button7",'!n')
WinWait($titile,"下面列出了您前几步的安装设置")
ControlSend($titile,"下面列出了您前几步的安装设置","Button10",'!n')

WinWait($titile,"文件拷贝完毕")
ControlClick($titile,"文件拷贝完毕","Button2")
ControlClick($titile,"文件拷贝完毕","Button13")

