#Region ;**** 参数创建于 AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=Change.ico
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <GUIConstantsEx.au3>

$Form = GUICreate("倒计时＆进度条示例", 280, 230, 195, 125)
GUISetState(@SW_SHOW)

;倒计时进度条
Global $time = 8
#Region ### START Koda GUI section ### Form=
$Label5 = GUICtrlCreateLabel($time & "秒后自动放弃操作!", 30, 168, 200,25)
GUICtrlSetColor($Label5, 0x8A2BE2)
GUICtrlSetFont($Label5, 10)
$Progress1 = GUICtrlCreateProgress(20, 195, 230, 10)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
AdlibRegister("_timer", 1000)


Func _timer()
        $time -= 1
        GUICtrlSetData($Label5,$time & "秒后自动放弃操作!!")
        GUICtrlSetData($Progress1, (10 - $time) / 0.1)
        If $time <= 0 Then Exit
EndFunc   ;==>_timer


While 1
        $nMsg = GUIGetMsg()
        Select
                Case $nMsg = $GUI_EVENT_CLOSE 
                        DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form, "int", 500, "long", 0x00090000)
                        Exit
                Case $nMsg = $GUI_EVENT_PRIMARYDOWN
                        AdlibUnRegister()
                        GUICtrlSetState($Progress1,$GUI_DISABLE )
        EndSelect
WEnd
