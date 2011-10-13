#NoTrayIcon
#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=D:\软件\文件图标替换工具\ICO\电脑\摄象头\USB-Blueberry.ico
#AutoIt3Wrapper_outfile=查找无线投影宝是那种网卡.exe
#AutoIt3Wrapper_Add_Constants=n
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#include <Process.au3>

Dim $i=MsgBox(1,"确认IP","请确认无线投影宝的IP是不是192.168.10.1，如果不是请联系技术人员，如果没有192.168.10.1IP就点取消")
if  $i=2  Then
Exit 0
EndIf

Dim $i=MsgBox(1,"确认升级状态","请确认无线投影宝是不是升级模式状态，请在升级状态下才按确定")
if  $i=2  Then
Exit 0
EndIf
BlockInput(1)
_RunDOS("start cmd")
Sleep(1000)
Send("telnet 192.168.10.1{enter}")
Sleep(2000)
Send("root{enter}")
Sleep(3000)
Send("FreeView{enter}")
Sleep(2000)
Send("ls /etc{enter}")
Sleep(3000)
Send("ls /etc/Wireless/RT61AP/{enter}")
Sleep(3000)
send("{PRINTSCREEN}")
Run("C:\WINDOWS\system32\mspaint.exe","C:\WINDOWS\system32")
WinWait("未命名 - 画图")
Send("^v")
Sleep(2000)
Send("^s")
WinWait("保存为")
WinActivate("保存为")
Send("D:\xiaozhan")
WinWait("保存为")
ControlClick("保存为","","[ID:1136]","left",2)
WinActivate("保存为")
Send("j")
Sleep(1000)
Send("!s")
WinWait("保存为","是(&Y)",5)
WinActivate("保存为","是(&Y)")
ControlClick("保存为","是(&Y)","[ID:6]")
Sleep(2000)
WinClose("xiaozhan.JPG - 画图")
WinClose("Telnet 192.168.10.1")
BlockInput(0)





