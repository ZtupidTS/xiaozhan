#NoTrayIcon
#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=D:\Program Files\AutoIt3\Aut2Exe\Icons\FOLDER.ico
#AutoIt3Wrapper_outfile=�������ĺ������ڻ�.exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
HotKeySet("!a","showmessage")
HotKeySet("^!z","showmessage")



#include <Process.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiConstants.au3>

$I1= IniRead(@scriptdir & "\�������ĺ������ڻ�.ini", "glzxhjsnj","bt","")
$I2= IniRead(@scriptdir & "\�������ĺ������ڻ�.ini", "glzxhjsnj","gjl","")
$I3= IniRead(@scriptdir & "\�������ĺ������ڻ�.ini", "glzxhjsnj","sl","")
$I4= IniRead(@scriptdir & "\�������ĺ������ڻ�.ini", "glzxhjsnj","slw","")

Global $I5=1000

$Form1 = GUICreate("���йҶ���ʱ", 330, 164, 751, 231)
$Group1 = GUICtrlCreateGroup("����������Ҫ������", 24, 16, 280, 95)
$Label1 = GUICtrlCreateLabel("���к���ʱ(��)", 32, 45, 100, 17)
$Input1 = GUICtrlCreateInput($I3, 139, 40, 135, 21)
$Label3 = GUICtrlCreateLabel("�ҶϺ���ʱ(��)", 30, 76, 100, 17)
$Input2 = GUICtrlCreateInput($I4, 139, 72, 135, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button1 = GUICtrlCreateButton("ȷ��", 48, 125, 97, 25, $BS_OWNERDRAW);��Button����ΪĬ��״̬$BS_OWNERDRAW
$Button2 = GUICtrlCreateButton("ȡ��", 190, 125, 97, 25)
GUISetState(@SW_SHOW)

While 1
 
    $msg = GUIGetMsg()
	Select
		Case $msg = $GUI_EVENT_CLOSE
		Exit
	Case $msg = $Button2
		Exit
   Case $msg = $Button1
    IniWrite(@scriptdir & "\�������ĺ������ڻ�.ini", "glzxhjsnj","sl", GUICtrlRead ($Input1))
	IniWrite(@scriptdir & "\�������ĺ������ڻ�.ini", "glzxhjsnj","slw", GUICtrlRead ($Input2))	
	GUISetState(@SW_HIDE, $Form1)
	 ;do()
   ; Will Run/Open Notepad
    ExitLoop
  EndSelect
 WEnd


;Func do()
$i = 0
Do

WinActivate("����С������ϵͳ")
ControlClick($I1,"",$I2,"left",1,83,437)
Sleep($I3*$I5)
ControlClick($I1,"",$I2,"left",1,246,429)
Sleep($I4*$I5)

$i = $i + 1
Until $i = 10000000000000000000000000000000
;EndFunc

Func showmessage()
	Dim $i=MsgBox(1,"�˳��ű�","ȷ���˳�") 
	   If $i<>2 Then
		   Exit 0
	   EndIf
   EndFunc	   


#cs
[glzxhjsnj]
bt=����С������ϵͳ
gjl=[CLASS:TPanel; INSTANCE:4]
sl=5
slw=5
#ce
