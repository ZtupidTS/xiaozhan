#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=D:\AutoIt3\Aut2Exe\Icons\Fonts6.ico
#EndRegion ;**** ���������� ACNWrapper_GUI ****
Global $Paused
HotKeySet("{F2}", "TogglePause")
HotKeySet("{ESC}", "Terminate")
HotKeySet("{F1}", "MouseC")

While 1
   Sleep(500)
WEnd

Func TogglePause()
    $Paused = NOT $Paused
    While $Paused
        sleep(100)
        ToolTip('�ű���ͣ��',0,0)
    WEnd
    ToolTip("")
EndFunc

Func Terminate()
    Exit 0
EndFunc 

Func MouseC()
 while 1
 MouseClick("left")
 sleep(200)
 If WinExists ("����","ȷ��") Then
	ControlClick("����","ȷ��","[ID:2]")
ElseIf WinExists ("ϵͳ��ʾ","ȷ��") Then
	ControlClick("ϵͳ��ʾ","ȷ��","[ID:2]")
 ElseIf WinExists ("#32770","�˷�������") Then
	ControlClick("#32770","�˷�������","[ID:1137]")
EndIf

 ContinueLoop
 
 WEnd

EndFunc 