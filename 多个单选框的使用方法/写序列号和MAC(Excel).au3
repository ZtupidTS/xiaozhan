#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Include <Excel.au3>
#Region ### START Koda GUI section ### Form=C:\Documents and Settings\xiaozhan\����\��ȡExcel.kxf
$MM=IniRead(@scriptdir & "\���кź�MAC(Excel).ini","MM","MM","")
$pass=InputBox ( "������Ȩ", "������MAC�����кźͼ���оƬ������Ȩ���롣" , "" );,"O")
if $pass= $MM then
	
$Form1 = GUICreate("���кź�MAC(Excel)", 266, 196, 192, 124)
$Group1 = GUICtrlCreateGroup("�������Ӧ�����", 40, 32, 185, 129)
$Label1 = GUICtrlCreateLabel("���������кź�MAC��Ӧ���", 56, 56, 159, 17)
$Input1 = GUICtrlCreateInput("", 88, 88, 89, 21)
$Button1 = GUICtrlCreateButton("ȷ��", 64, 120, 57, 25)
$Button2 = GUICtrlCreateButton("ȡ��", 144, 120, 57, 25)
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
			IniWrite(@scriptdir & "\���кź�MAC(Excel).ini", "mac","mac",GUICtrlRead($Input1))
			;GUICtrlSetData($Input1, "")
			  $mac = IniRead (@scriptdir & "\���кź�MAC(Excel).ini", "mac","mac","")
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
$DZ=IniRead(@scriptdir & "\���кź�MAC(Excel).ini","DZ","DZ","")
$CX=IniRead(@scriptdir & "\���кź�MAC(Excel).ini","CX","CX","")
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

ControlClick("testtool","����","[ID:1001]")

WinWait("testtool","������")
Sleep(800)
ControlClick("testtool","дMAC","[ID:1013]")

Opt("WinTitleMatchMode")
WinWait("testtool","")    ;��ͣ�ű���ִ��ֱ��ָ�����ڴ���(����)Ϊֹ.
WinWaitActive("testtool", "ȷ��")    ;��ͣ�ű���ִ��ֱ��ָ�����ڱ�����(��Ϊ�״̬)Ϊֹ
If WinExists("testtool", "ȷ��") Then   ;���ָ���Ĵ����Ƿ����
 Sleep(1000)
    ControlClick("testtool", "ȷ��", "[ID:2]")
EndIf

ControlClick("testtool","д���к�","[ID:1017]")

Opt("WinTitleMatchMode")
WinWait("testtool","")    ;��ͣ�ű���ִ��ֱ��ָ�����ڴ���(����)Ϊֹ.
WinWaitActive("testtool", "ȷ��")    ;��ͣ�ű���ִ��ֱ��ָ�����ڱ�����(��Ϊ�״̬)Ϊֹ
If WinExists("testtool", "ȷ��") Then   ;���ָ���Ĵ����Ƿ����
 Sleep(1000)
    ControlClick("testtool", "ȷ��", "[ID:2]")
EndIf

ControlClick("testtool","оƬ����","[ID:1014]")

Opt("WinTitleMatchMode")
WinWait("testtool","")    ;��ͣ�ű���ִ��ֱ��ָ�����ڴ���(����)Ϊֹ.
WinWaitActive("testtool", "ȷ��")    ;��ͣ�ű���ִ��ֱ��ָ�����ڱ�����(��Ϊ�״̬)Ϊֹ
If WinExists("testtool", "ȷ��") Then   ;���ָ���Ĵ����Ƿ����
 Sleep(1000)
    ControlClick("testtool", "ȷ��", "[ID:2]")
EndIf


ProcessClose($CX)

else
msgbox(16,"��ʾ","����")
endif


#cs
���кź�MAC(Excel)
[mac]
mac=100

[DZ]
DZ=C:\Documents and Settings\xiaozhan\����\testtools\tools
[CX]
CX=testtoolд��ַר��.exe


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