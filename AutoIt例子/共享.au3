#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=..\网上邻居.ico
#AutoIt3Wrapper_outfile=..\共享.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#include <Process.au3>
;#include <IE.au3>
;#Include <WinAPI.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
Example()

Func Example()
Local $Button1, $Button, $msg ,$Form1 ,$xiaozhan
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("请输入IP地址", 178, 83, 192, 124)
;$Label1 = GUICtrlCreateLabel("\\", 8, 20, 30, 17)
$Input1 = GUICtrlCreateInput("请输入你要找的共享IP", 24, 16, 129, 21)
$Button1 = GUICtrlCreateButton("确定", 48, 48, 65, 17, $WS_GROUP)
;$xiaozhan = GUICtrlRead ($Label1,$Input1)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
While 1
		$msg = GUIGetMsg()
		Select
			Case $msg = $GUI_EVENT_CLOSE
				ExitLoop
			Case $msg = $Button1
				;_RunDos("start $xiaozhan");
				ShellExecute(GUICtrlRead ($Input1))			; Will Run/Open Notepad
				;ShellExecute(\\GUICtrlRead ($Input1))
		EndSelect
	WEnd
	;MsgBox(4096, "drag drop file", GUICtrlRead($Input1))
EndFunc   ;==>Example

;_RunDos("start \\$Input1 ");

