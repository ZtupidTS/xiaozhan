#include <ie.au3>
#include <GUIConstants.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("����׿", 420, 147, 192, 124)
$Button1 = GUICtrlCreateButton("�򿪹ȸ�", 56, 48, 113, 41, $WS_GROUP)
$Button2 = GUICtrlCreateButton("��ȡ��ǰԪ��", 248, 48, 113, 41, $WS_GROUP)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
                Case $GUI_EVENT_CLOSE
                        Exit

                Case $Button1
                        $oIE = _IECreate("www.g.cn")
                        $oDoc= _IEDocGetObj($oIE)
                Case $Button2
                        MsgBox(0,"����׿","��ǰ��������Ԫ��Ϊ��" & $oDoc.activeElement.outerHTML)
        EndSwitch
WEnd