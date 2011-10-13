#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
$Win = GUICreate("Form1", 420, 253, -1, -1)
$Button1 = GUICtrlCreateButton("¶¶Ò»ÏÂ", 296, 200, 73, 33, $WS_GROUP)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
 $nMsg = GUIGetMsg()
 Switch $nMsg
  Case $GUI_EVENT_CLOSE
   Exit
  Case $Button1
   _Jitter()
 EndSwitch
WEnd

Func _Jitter()
 $sCoor = WinGetPos($Win)
 For $i = 1 To 4
 WinMove($Win, "", $sCoor[0] + 3, $sCoor[1] - 3, Default, Default, 1)
 WinMove($Win, "", $sCoor[0], $sCoor[1] - 6, Default, Default, 1)
 WinMove($Win, "", $sCoor[0] - 3, $sCoor[1] - 3, Default, Default, 1)
 WinMove($Win, "", $sCoor[0], $sCoor[1], Default, Default, 1)
 Next
EndFunc   ;==>_Jitter