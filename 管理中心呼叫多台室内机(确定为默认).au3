#NoTrayIcon
#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=..\Program Files\AutoIt3\Aut2Exe\Icons\kde.ico
#AutoIt3Wrapper_outfile=管理中心呼叫多台室内机.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
HotKeySet("!1","showmessage")
HotKeySet("^!z","showmessage")



#include <Process.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiConstants.au3>

$I1= IniRead(@scriptdir & "\管理中心呼叫多台室内机.ini", "glzxhjsnj","bt","")
$I2= IniRead(@scriptdir & "\管理中心呼叫多台室内机.ini", "glzxhjsnj","gjl","")
$I3= IniRead(@scriptdir & "\管理中心呼叫多台室内机.ini", "glzxhjsnj","srfh","")
$I4= IniRead(@scriptdir & "\管理中心呼叫多台室内机.ini", "glzxhjsnj","sl","")
$I5= IniRead(@scriptdir & "\管理中心呼叫多台室内机.ini", "glzxhjsnj","slw","")
$jq1= IniRead(@scriptdir & "\管理中心呼叫多台室内机.ini", "glzxhjsnj","jq1","")
$jq2= IniRead(@scriptdir & "\管理中心呼叫多台室内机.ini", "glzxhjsnj","jq2","")
$jq3= IniRead(@scriptdir & "\管理中心呼叫多台室内机.ini", "glzxhjsnj","jq3","")
$jq4= IniRead(@scriptdir & "\管理中心呼叫多台室内机.ini", "glzxhjsnj","jq4","")
$jq5= IniRead(@scriptdir & "\管理中心呼叫多台室内机.ini", "glzxhjsnj","jq5","")
$jq6= IniRead(@scriptdir & "\管理中心呼叫多台室内机.ini", "glzxhjsnj","jq6","")
$jq7= IniRead(@scriptdir & "\管理中心呼叫多台室内机.ini", "glzxhjsnj","jq7","")
$jq8= IniRead(@scriptdir & "\管理中心呼叫多台室内机.ini", "glzxhjsnj","jq8","")
$I6= IniRead(@scriptdir & "\管理中心呼叫多台室内机.ini", "glzxhjsnj","xrzlys","")

Global $J1=1000

$Form1_1 = GUICreate("呼叫挂断延时", 331, 467, 396, 268)
$Group1 = GUICtrlCreateGroup("请输入你需要的秒数", 24, 16, 280, 351)
$Label1 = GUICtrlCreateLabel("呼叫后延时(秒)", 32, 45, 100, 17)
$Input1 = GUICtrlCreateInput($I4, 139, 40, 135, 21)
$Label3 = GUICtrlCreateLabel("挂断后延时(秒)", 30, 76, 100, 17)
$Input2 = GUICtrlCreateInput($I5, 139, 72, 135, 21)
$Label2 = GUICtrlCreateLabel(" 机器1房号", 30, 108, 100, 17)
$Label4 = GUICtrlCreateLabel(" 机器2房号", 30, 140, 100, 17)
$Label5 = GUICtrlCreateLabel(" 机器3房号", 30, 172, 100, 17)
$Label6 = GUICtrlCreateLabel(" 机器4房号", 30, 204, 100, 17)
$Label7 = GUICtrlCreateLabel(" 机器5房号", 30, 236, 100, 17)
$Label8 = GUICtrlCreateLabel(" 机器6房号", 30, 268, 100, 17)
$Label9 = GUICtrlCreateLabel(" 机器7房号", 30, 300, 100, 17)
$Label10 = GUICtrlCreateLabel(" 机器8房号", 30, 332, 100, 17)
$Input3 = GUICtrlCreateInput($jq1, 139, 104, 135, 21)
$Input4 = GUICtrlCreateInput($jq2, 139, 136, 135, 21)
$Input5 = GUICtrlCreateInput($jq3, 139, 168, 135, 21)
$Input6 = GUICtrlCreateInput($jq4, 139, 200, 135, 21)
$Input7 = GUICtrlCreateInput($jq5, 139, 232, 135, 21)
$Input8 = GUICtrlCreateInput($jq6, 139, 264, 135, 21)
$Input9 = GUICtrlCreateInput($jq7, 139, 296, 135, 21)
$Input10 = GUICtrlCreateInput($jq8, 139, 328, 135, 21)
$Label11 = GUICtrlCreateLabel("如果机器不够请重复输入房号谢谢", 80, 384, 184, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button1 = GUICtrlCreateButton("确定", 48, 421, 97, 25, $BS_OWNERDRAW);把Button设置为默认状态$BS_OWNERDRAW)
$Button2 = GUICtrlCreateButton("取消", 190, 421, 97, 25)
GUISetState(@SW_SHOW)

While 1
 
    $msg = GUIGetMsg()
	Select
		Case $msg = $GUI_EVENT_CLOSE
		Exit
	Case $msg = $Button2
		Exit
   Case $msg = $Button1
    IniWrite(@scriptdir & "\管理中心呼叫多台室内机.ini", "glzxhjsnj","sl", GUICtrlRead ($Input1))
	IniWrite(@scriptdir & "\管理中心呼叫多台室内机.ini", "glzxhjsnj","slw", GUICtrlRead ($Input2))	
	IniWrite(@scriptdir & "\管理中心呼叫多台室内机.ini", "glzxhjsnj","jq1", GUICtrlRead ($Input3))
	IniWrite(@scriptdir & "\管理中心呼叫多台室内机.ini", "glzxhjsnj","jq2", GUICtrlRead ($Input4))	
	IniWrite(@scriptdir & "\管理中心呼叫多台室内机.ini", "glzxhjsnj","jq3", GUICtrlRead ($Input5))
	IniWrite(@scriptdir & "\管理中心呼叫多台室内机.ini", "glzxhjsnj","jq4", GUICtrlRead ($Input6))	
	IniWrite(@scriptdir & "\管理中心呼叫多台室内机.ini", "glzxhjsnj","jq5", GUICtrlRead ($Input7))
	IniWrite(@scriptdir & "\管理中心呼叫多台室内机.ini", "glzxhjsnj","jq6", GUICtrlRead ($Input8))	
	IniWrite(@scriptdir & "\管理中心呼叫多台室内机.ini", "glzxhjsnj","jq7", GUICtrlRead ($Input9))
	IniWrite(@scriptdir & "\管理中心呼叫多台室内机.ini", "glzxhjsnj","jq8", GUICtrlRead ($Input10))	
	GUISetState(@SW_HIDE, $Form1_1)
	Sleep($I6*$J1)
	;写入资料延时
	 ;do()
   ; Will Run/Open Notepad
    ExitLoop
  EndSelect
 WEnd


$i = 0
Do

WinActivate($I1)
ControlClick($I1,"",$I3,"left",2,170,23)
BlockInput(1)
Send($jq1)
BlockInput(0)
ControlClick($I1,"",$I2,"left",1,83,437)
Sleep($I4*$J1)
ControlClick($I1,"",$I2,"left",1,246,429)
Sleep($I5*$J1)

WinActivate($I1)
ControlClick($I1,"",$I3,"left",2,170,23)
BlockInput(1)
Send($jq2)
BlockInput(0)
ControlClick($I1,"",$I2,"left",1,83,437)
Sleep($I4*$J1)
ControlClick($I1,"",$I2,"left",1,246,429)
Sleep($I5*$J1)

WinActivate($I1)
ControlClick($I1,"",$I3,"left",2,170,23)
BlockInput(1)
Send($jq3)
BlockInput(0)
ControlClick($I1,"",$I2,"left",1,83,437)
Sleep($I4*$J1)
ControlClick($I1,"",$I2,"left",1,246,429)
Sleep($I5*$J1)

WinActivate($I1)
ControlClick($I1,"",$I3,"left",2,170,23)
BlockInput(1)
Send($jq4)
BlockInput(0)
ControlClick($I1,"",$I2,"left",1,83,437)
Sleep($I4*$J1)
ControlClick($I1,"",$I2,"left",1,246,429)
Sleep($I5*$J1)

WinActivate($I1)
ControlClick($I1,"",$I3,"left",2,170,23)
BlockInput(1)
Send($jq5)
BlockInput(0)
ControlClick($I1,"",$I2,"left",1,83,437)
Sleep($I4*$J1)
ControlClick($I1,"",$I2,"left",1,246,429)
Sleep($I5*$J1)

WinActivate($I1)
ControlClick($I1,"",$I3,"left",2,170,23)
BlockInput(1)
Send($jq6)
BlockInput(0)
ControlClick($I1,"",$I2,"left",1,83,437)
Sleep($I4*$J1)
ControlClick($I1,"",$I2,"left",1,246,429)
Sleep($I5*$J1)

WinActivate($I1)
ControlClick($I1,"",$I3,"left",2,170,23)
BlockInput(1)
Send($jq7)
BlockInput(0)
ControlClick($I1,"",$I2,"left",1,83,437)
Sleep($I4*$J1)
ControlClick($I1,"",$I2,"left",1,246,429)
Sleep($I5*$J1)

WinActivate($I1)
ControlClick($I1,"",$I3,"left",2,170,23)
BlockInput(1)
Send($jq8)
BlockInput(0)
ControlClick($I1,"",$I2,"left",1,83,437)
Sleep($I4*$J1)
ControlClick($I1,"",$I2,"left",1,246,429)
Sleep($I5*$J1)


$i = $i + 1
Until $i = 10000000000000000000000000000000


Func showmessage()
	Dim $i=MsgBox(1,"退出脚本","确定退出") 
	   If $i<>2 Then
		   Exit 0
	   EndIf
   EndFunc	   


#cs
[glzxhjsnj]
bt=北京位元数字楼宇对讲管理中心
gjl=[CLASS:TPanel; INSTANCE:4]
srfh=[CLASS:TEdit; INSTANCE:1]
sl=4
slw=1
xrzlys=5
jq1=010110301
jq2=010110201
jq3=010110301
jq4=010110301
jq5=010110301
jq6=010110301
jq7=010110301
#ce
