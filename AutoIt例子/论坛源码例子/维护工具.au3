#NoTrayIcon        ;禁止系统通知区域（系统托盘）出现本程序图标
#cs
ACN论坛hynq2000的网管工具箱教程为样板，略作修改
修改原因：
1，建议尽可能使用事件模式，事件模式下，绝大部分操作后可以立即执行脚本中的下一步，而不会等待当前操作完成。
2，调用控制面板文件也不是必需用到RUNDOS，可以向控制面板主程序请教执行相应控制面板文件。
3，既然是网管工具箱，自然不可以随便给别人用，所以当加个密码控制，KiwiCsj个人提供简单加密码方案。
3，其它：hynq2000朋友说了是简单教程，所以此为思路扩展，其代码均可根据思路从汉化版帮助中查询：
    a,相关功能可以尝试使用右键菜单集成之，不必每样具体操作都做一个按钮在界面上
        b,...有事忙了，就这样吧，思路是人想出来的，只要你愿意，Au3也可以帮你把很多新鲜的花样玩出来。
#ce
Opt("GUIOnEventMode", 1)        ;声明使用事件模式
#include <GUIConstants.au3> 
;~ #include <Process.au3>        ;没使用_RunDos所以这个可以不用
 
_KiwiCsjOPSSWD()        ;密码检验过程
 
#Region ### START Koda GUI section ### Form= 
$Form1 = GUICreate("维护工具测试1B", 315, 204, 278, 206) 
$Button1 = GUICtrlCreateButton("系统属性", 8, 8, 75, 25, 0) 
$Button2 = GUICtrlCreateButton("显示属性", 8, 56, 75, 25, 0) 
$Button3 = GUICtrlCreateButton("进程管理", 8, 104, 75, 25, 0) 
$Button4 = GUICtrlCreateButton("控制面板", 112, 8, 75, 25, 0) 
$Button5 = GUICtrlCreateButton("命令行", 112, 56, 75, 25, 0) 
$Button6 = GUICtrlCreateButton("注册表", 112, 104, 75, 25, 0) 
$Button7 = GUICtrlCreateButton("Msconfig", 216, 56, 75, 25, 0) 
$Button8 = GUICtrlCreateButton("音量控制", 216, 104, 75, 25, 0) 
$Button9 = GUICtrlCreateButton("策略组", 216, 8, 75, 25, 0) 
$Input1 = GUICtrlCreateInput("", 8, 148, 121, 25) 
$Button10 = GUICtrlCreateButton("运行", 144, 148, 43, 25, 0) 
$Button11 = GUICtrlCreateButton("时间日期", 216, 144, 75, 25, 0) 
GUICtrlCreateLabel("", 184, 176, 4, 4) 
$Label1 = GUICtrlCreateLabel("小站工作室2009/9", 176, 186, 132, 17) 
GUISetState(@SW_SHOW) 
#EndRegion ### END Koda GUI section ### 
;######### 声明事件关联 始 ###########
GUISetOnEvent($GUI_EVENT_CLOSE, "kc_exit")        ;声明关闭操作要调用的函数
GUICtrlSetOnEvent($Button1, "KcTask")                ;声明每个按钮操作要调用的函数
GUICtrlSetOnEvent($Button2, "KcTask")
GUICtrlSetOnEvent($Button3, "KcTask")
GUICtrlSetOnEvent($Button4, "KcTask")
GUICtrlSetOnEvent($Button5, "KcTask")
GUICtrlSetOnEvent($Button6, "KcTask")
GUICtrlSetOnEvent($Button7, "KcTask")
GUICtrlSetOnEvent($Button8, "KcTask")
GUICtrlSetOnEvent($Button9, "KcTask")
GUICtrlSetOnEvent($Button10, "KcTask")
GUICtrlSetOnEvent($Button11, "KcTask")
GUICtrlSetOnEvent($Label1, "KcTask")                ;文字也可以声明点击时可调用的函数
;######### 声明事件关联 毕，进入主循环 ###########
While 1 
        Sleep(1)
WEnd
;######### 自定义一些前面要用到的函数 ###########
 
Func KcTask()        ;主体界面上的按钮类操作 ，以事件模式工作
        Switch @GUI_CtrlId
                Case $Button1 
                                Run(@SystemDir&"\control.exe sysdm.cpl")        ;打开系统属性 
                Case $Button2 
                                Run(@SystemDir&"\control.exe desk.cpl")                ;打开显示属性 
                Case $Button3 
                                Run(@SystemDir &"\taskmgr.exe")                                ;打开任务管理器        
                Case $Button4 
                                Run(@SystemDir &"\control.exe")                                ;打开控制面板        
                Case $Button5 
                                Run(@SystemDir &"\cmd.exe")                                        ;打开命令行 
                Case $Button6 
                                Run(@WindowsDir &"\regedit.exe")                        ;打开注册表 
                Case $Button7 
                                Run("C:\WINDOWS\pchealth\helpctr\binaries\Msconfig.exe");打开msconfig 
                Case $Button8 
                                Run(@SystemDir &"\Sndvol32.exe")                        ;打开音量控制程序 
                Case $Button9 
                                ShellExecute(@SystemDir &"\gpedit.msc")                ;打开策略组  另一种写法Run(@ComSpec&' /c gpedit.msc',@SystemDir,@SW_HIDE) 
                Case $Button10 
                                Run(@ComSpec &" /c "&GUICtrlRead($input1))        ;这里是这个作品的关键 读取文本框里的内容然后运行 
                Case $Button11 
                                Run(@SystemDir&"\control.exe timedate.cpl")        ;打开时间日期 
                Case $Label1         
                                Run(@ProgramFilesDir&"\Internet Explorer\IEXPLORE.EXE [url]http://www.autoit.net.cn/space.php?uid=418&sid=NEZ90P[/url]")
        EndSwitch
EndFunc ;==> KcTask
 
Func _KiwiCsjOPSSWD()        ;密码检验过程
        $kcps = "123456"        ;定义密码，如果有必要，你还可以再用别的办法重复加密一下
        $input=InputBox("愿与你望月共醉", "请回答口令：", "", ".",220,120,-1,-1,16)        ;研究一下InputBox的函数，它的参数很值得一用。
        if @error=0 Then
                If $kcps <> $input Then
                        MsgBox (262144+32,"真遗憾!!!","想不起来了？",9)
                        kc_exit()                ;调用退出
                Else                                ;密码检查通过
                        $input=""
                EndIf
        ElseIf @error=1 Then
                kc_exit()
        ElseIf @error=2 Then 
                MsgBox (262144+32,"真遗憾!!!","回答个口令有这么慢么？",9)
                kc_exit()
        ElseIf @error=3 Then 
                MsgBox (262144+16,"意外错误!!!","口令输入框显示失败！请重试！",9)
                kc_exit()
        Else
                kc_exit()
        EndIf
EndFunc ;==> _KiwiCsjOPSSWD
 
Func kc_exit()        ;退出时的动作定义
        Exit
EndFunc ;==> kc_exit