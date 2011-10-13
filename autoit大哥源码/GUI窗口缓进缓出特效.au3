;DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00040003);左进
;DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00040002);右进
;DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00040004);上进
;DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00040005);左上角进
;DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00040006);右上角进
;DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00040008);下进
;DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00040009);左下角进
;DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00050001);右出
;DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00050002);左出
;DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00050008);上出
;DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00050004);下出
;DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00050005);右下角出
;DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00050006);左下角出
;DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00050009);右上角出

#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Form1", 250, 155, 192, 124)
DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00040007)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
While 1
$nMsg = GUIGetMsg()
Switch $nMsg
  Case $GUI_EVENT_CLOSE
   DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00050009)
   Exit
EndSwitch
WEnd 