#include <GUIConstantsEx.au3>
 
GUICreate("内嵌控制面板例子", 451, 437, 224, 146)
GUICtrlCreateGroup("控制面板", 8, 0, 433, 425)
$control = ObjCreate("Shell.Explorer.2")
$Obj = GUICtrlCreateObj($control, 16, 24, 417, 393)
$control.navigate("file:///::%7B20D04FE0-3AEA-1069-A2D8-08002B30309D%7D%5C::%7B21EC2020-3AEA-1069-A2DD-08002B30309D%7D")
GUISetState(@SW_SHOW)
 
While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            exit
    EndSwitch
WEnd 