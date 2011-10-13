#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Include <Excel.au3>
#Region ### START Koda GUI section ### Form=C:\Documents and Settings\xiaozhan\桌面\读取Excel.kxf
$MM=IniRead(@scriptdir & "\序列号和MAC(Excel).ini","MM","MM","")
$pass=InputBox ( "运行授权", "请输入MAC和序列号和加密芯片运行授权密码。" , "" );,"O")
if $pass= $MM then
	
$Form1 = GUICreate("序列号和MAC(Excel)", 266, 196, 192, 124)
$Group1 = GUICtrlCreateGroup("请输入对应的序号", 40, 32, 185, 129)
$Label1 = GUICtrlCreateLabel("请输入序列号和MAC对应序号", 56, 56, 159, 17)
$Input1 = GUICtrlCreateInput("", 88, 88, 89, 21)
$Button1 = GUICtrlCreateButton("确定", 64, 120, 57, 25)
$Button2 = GUICtrlCreateButton("取消", 144, 120, 57, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)
Dim $Form1_AccelTable[1][2] = [["{Enter}", $Button1]]
GUISetAccelerators($Form1_AccelTable)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

Do
	$nMsg = GUIGetMsg()
	Select 
		Case $nMsg = $GUI_EVENT_CLOSE
			ExitLoop
        Case $nMsg=$Button2
			Exit
		Case $nMsg=$Button1
			IniWrite(@scriptdir & "\序列号和MAC(Excel).ini", "mac","mac",GUICtrlRead($Input1))
			;GUICtrlSetData($Input1, "")
			  $mac = IniRead (@scriptdir & "\序列号和MAC(Excel).ini", "mac","mac","")
			$xlBook = _ExcelBookOpen(@scriptdir & "\MAC.xls")
			$str= _ExcelReadCell($xlBook ,$mac,4)
			$str1= _ExcelReadCell($xlBook ,$mac,10)
			 _ExcelBookClose($xlBook)

			ExitLoop
		EndSelect
		Until $nMsg = -3
;WEnd

Local $shinei = "0"

$xiaoxiao = StringReplace($str1,":", "")
$DZ=IniRead(@scriptdir & "\序列号和MAC(Excel).ini","DZ","DZ","")
$CX=IniRead(@scriptdir & "\序列号和MAC(Excel).ini","CX","CX","")
ShellExecute($CX, "", $DZ)	

BlockInput(1)
WinWait("testtool","",1)
BlockInput(1)
$var = ControlGetText("testtool", "", "[ID:1012]")
ControlClick("testtool", "", "[ID:1012]")
WinWaitActive("testtool")
ControlSend("testtool", "", "[ID:1012]", $xiaoxiao)
BlockInput(0)

BlockInput(1)
$var = ControlGetText("testtool", "", "[ID:1016]")
ControlClick("testtool", "", "[ID:1016]")
WinWaitActive("testtool")
ControlSend("testtool", "", "[ID:1016]", $shinei  & "" & $str)
BlockInput(0)

ControlClick("testtool","连接","[ID:1001]")

WinWait("testtool","已连接")
Sleep(800)
ControlClick("testtool","写MAC","[ID:1013]")

Opt("WinTitleMatchMode")
WinWait("testtool","")    ;暂停脚本的执行直至指定窗口存在(出现)为止.
WinWaitActive("testtool", "确定")    ;暂停脚本的执行直至指定窗口被激活(成为活动状态)为止
If WinExists("testtool", "确定") Then   ;检查指定的窗口是否存在
 Sleep(1000)
    ControlClick("testtool", "确定", "[ID:2]")
EndIf

ControlClick("testtool","写序列号","[ID:1017]")

Opt("WinTitleMatchMode")
WinWait("testtool","")    ;暂停脚本的执行直至指定窗口存在(出现)为止.
WinWaitActive("testtool", "确定")    ;暂停脚本的执行直至指定窗口被激活(成为活动状态)为止
If WinExists("testtool", "确定") Then   ;检查指定的窗口是否存在
 Sleep(1000)
    ControlClick("testtool", "确定", "[ID:2]")
EndIf

ControlClick("testtool","芯片加密","[ID:1014]")

Opt("WinTitleMatchMode")
WinWait("testtool","")    ;暂停脚本的执行直至指定窗口存在(出现)为止.
WinWaitActive("testtool", "确定")    ;暂停脚本的执行直至指定窗口被激活(成为活动状态)为止
If WinExists("testtool", "确定") Then   ;检查指定的窗口是否存在
 Sleep(1000)
    ControlClick("testtool", "确定", "[ID:2]")
EndIf


ProcessClose($CX)

else
msgbox(16,"提示","错啦")
endif


#cs
序列号和MAC(Excel)
[mac]
mac=100

[DZ]
DZ=C:\Documents and Settings\xiaozhan\桌面\testtools\tools
[CX]
CX=testtool写地址专用.exe


[MM]
MM=1

[NN1]
NN1=1
[NN2]
NN2=2
[NN3]
NN3=3
[NN4]
NN4=4
[NN5]
NN5=5
#ce