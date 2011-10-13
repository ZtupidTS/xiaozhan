#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=D:\AutoIt3\Aut2Exe\Icons\Fonts6.ico
#AutoIt3Wrapper_outfile=C:\Documents and Settings\xiaozhan\桌面\飞翔娱乐挤房间.exe
#AutoIt3Wrapper_Res_Fileversion=0.0.0.0
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
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
        ToolTip('脚本暂停中',0,0)
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
 If WinActive("错误","确定") Then
	ControlClick("错误","确定","[ID:2]")
ElseIf WinActive("系统提示","确定") Then
	ControlClick("系统提示","确定","[ID:2]")
 ElseIf WinActive("#32770","此房间已满") Then
	ControlClick("#32770","此房间已满","[ID:1137]")
EndIf

 ContinueLoop
 
 WEnd

EndFunc 