#NoTrayIcon
#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=..\..\..\WINDOWS\system32\SHELL32.dll|-48
#AutoIt3Wrapper_outfile=һֱ������.exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
#include<HideProcess.au3>
HotKeySet("!1","showmessage")
HotKeySet("^!z","showmessage")
opt ('TrayIconHide',1)

$I1= IniRead(@scriptdir & "\aa.ini", "system","bt","")

$i = 0
Do

WinWait($I1)
WinActivate($I1)
ControlClick($I1,"����","[ID:1050]")
Sleep(5*1000)

$i = $i + 1
Until $i = 1000000000000000000000000

$i = 0
Do

ControlClick($I1,"","[CLASS:Button; INSTANCE:2]","left",1,28, 11)
Sleep(2*1000)


$i = $i + 1
Until $i = 1000000000000000000000000


Func showmessage()
	Dim $i=MsgBox(1,"�˳��ű�","ȷ���˳�") 
	   If $i<>2 Then
		   Exit 0
	   EndIf
   EndFunc	   
   
   
   
#cs

[system]
bt=

#ce