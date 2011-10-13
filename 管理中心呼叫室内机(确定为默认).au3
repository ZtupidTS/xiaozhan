#NoTrayIcon
#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=D:\Program Files\AutoIt3\Aut2Exe\Icons\FOLDER.ico
#AutoIt3Wrapper_outfile=管理中心呼叫室内机.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
HotKeySet("!a","showmessage")
HotKeySet("^!z","showmessage")



#include <Process.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiConstants.au3>

$I1= IniRead(@scriptdir & "\管理中心呼叫室内机.ini", "glzxhjsnj","bt","")
$I2= IniRead(@scriptdir & "\管理中心呼叫室内机.ini", "glzxhjsnj","gjl","")
$I3= IniRead(@scriptdir & "\管理中心呼叫室内机.ini", "glzxhjsnj","sl","")
$I4= IniRead(@scriptdir & "\管理中心呼叫室内机.ini", "glzxhjsnj","slw","")

Global $I5=1000

$Form1 = GUICreate("呼叫挂断延时", 330, 164, 751, 231)
$Group1 = GUICtrlCreateGroup("请输入你需要的秒数", 24, 16, 280, 95)
$Label1 = GUICtrlCreateLabel("呼叫后延时(秒)", 32, 45, 100, 17)
$Input1 = GUICtrlCreateInput($I3, 139, 40, 135, 21)
$Label3 = GUICtrlCreateLabel("挂断后延时(秒)", 30, 76, 100, 17)
$Input2 = GUICtrlCreateInput($I4, 139, 72, 135, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button1 = GUICtrlCreateButton("确定", 48, 125, 97, 25, $BS_OWNERDRAW);把Button设置为默认状态$BS_OWNERDRAW
$Button2 = GUICtrlCreateButton("取消", 190, 125, 97, 25)
GUISetState(@SW_SHOW)

While 1
 
    $msg = GUIGetMsg()
	Select
		Case $msg = $GUI_EVENT_CLOSE
		Exit
	Case $msg = $Button2
		Exit
   Case $msg = $Button1
    IniWrite(@scriptdir & "\管理中心呼叫室内机.ini", "glzxhjsnj","sl", GUICtrlRead ($Input1))
	IniWrite(@scriptdir & "\管理中心呼叫室内机.ini", "glzxhjsnj","slw", GUICtrlRead ($Input2))	
	GUISetState(@SW_HIDE, $Form1)
	 ;do()
   ; Will Run/Open Notepad
    ExitLoop
  EndSelect
 WEnd


;Func do()
$i = 0
Do

WinActivate("智能小区管理系统")
ControlClick($I1,"",$I2,"left",1,83,437)
Sleep($I3*$I5)
ControlClick($I1,"",$I2,"left",1,246,429)
Sleep($I4*$I5)

$i = $i + 1
Until $i = 10000000000000000000000000000000
;EndFunc

Func showmessage()
	Dim $i=MsgBox(1,"退出脚本","确定退出") 
	   If $i<>2 Then
		   Exit 0
	   EndIf
   EndFunc	   


#cs
[glzxhjsnj]
bt=智能小区管理系统
gjl=[CLASS:TPanel; INSTANCE:4]
sl=5
slw=5
#ce
