;#NoTrayIcon
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Form1", 384, 168, 192, 114)
$Input1 = GUICtrlCreateInput("Input1", 72, 96, 241, 21)
GUICtrlSetState (-1,$GUI_Disable)
$Checkbox1 = GUICtrlCreateCheckbox("≤‚ ‘", 104, 40, 177, 25)
$Checkbox2 = GUICtrlCreateCheckbox("≤‚ ‘", 104, 60, 177, 25)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
                Case $GUI_EVENT_CLOSE
                        Exit
        Case $Checkbox1
                        IF BitAND (GUICtrlRead ($Checkbox1),$GUI_CHECKED) Then 
                                GUICtrlSetState ($Input1,$GUI_Enable)
                        Else
                                GUICtrlSetState ($Input1,$GUI_Disable)
                        EndIf
        EndSwitch
WEnd