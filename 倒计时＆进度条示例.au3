#Region ;**** ���������� AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=Change.ico
#EndRegion ;**** ���������� ACNWrapper_GUI ****
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <GUIConstantsEx.au3>

$Form = GUICreate("����ʱ��������ʾ��", 280, 230, 195, 125)
GUISetState(@SW_SHOW)

;����ʱ������
Global $time = 8
#Region ### START Koda GUI section ### Form=
$Label5 = GUICtrlCreateLabel($time & "����Զ���������!", 30, 168, 200,25)
GUICtrlSetColor($Label5, 0x8A2BE2)
GUICtrlSetFont($Label5, 10)
$Progress1 = GUICtrlCreateProgress(20, 195, 230, 10)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
AdlibRegister("_timer", 1000)


Func _timer()
        $time -= 1
        GUICtrlSetData($Label5,$time & "����Զ���������!!")
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
