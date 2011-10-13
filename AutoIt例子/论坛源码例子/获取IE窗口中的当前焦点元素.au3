#include <ie.au3>
#include <GUIConstants.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("秦勇卓", 420, 147, 192, 124)
$Button1 = GUICtrlCreateButton("打开网易邮箱", 56, 48, 113, 41, $WS_GROUP)
$Button2 = GUICtrlCreateButton("获取当前表单", 248, 48, 113, 41, $WS_GROUP)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
                Case $GUI_EVENT_CLOSE
                        Exit

                Case $Button1
                        $oIE = _IECreate("http://mail.163.com/")
                        $oDoc= _IEDocGetObj($oIE)
                Case $Button2
                        MsgBox(0,"秦勇卓","当前表单名为：" & $oDoc.activeElement.form.name)
                        MsgBox(0,"秦勇卓","当前表单HTML：" & $oDoc.activeElement.form.outerHTML)
        EndSwitch
WEnd