;DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00040003);���
;DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00040002);�ҽ�
;DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00040004);�Ͻ�
;DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00040005);���Ͻǽ�
;DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00040006);���Ͻǽ�
;DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00040008);�½�
;DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00040009);���½ǽ�
;DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00050001);�ҳ�
;DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00050002);���
;DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00050008);�ϳ�
;DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00050004);�³�
;DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00050005);���½ǳ�
;DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00050006);���½ǳ�
;DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00050009);���Ͻǳ�

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