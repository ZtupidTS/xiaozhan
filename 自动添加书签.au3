#include <GuiConstantsEx.au3>
#include <GuiTab.au3>
Local $var

HotKeySet("{F2}", "C")
HotKeySet("{F3}", "N")
While 1
Sleep(100)
WEnd

Func C()
$va = ControlGetHandle ('AutoIt Help','','SysTabControl321') 
_GUICtrlTab_ClickTab( $va,3 , "left", False)
WinWaitActive("AutoIt Help", "List1") ;--------����Ŀ�괰��--------
controlclick("AutoIt Help", "List1","Button4" ) ;--------���Ŀ�갴ť--------
_GUICtrlTab_ClickTab( $va,0, "left", False)
TrayTip("���", "�Ѽ�����ǩ", 5, 1)
EndFunc

Func N()
$va = ControlGetHandle ('AutoIt Help','','SysTabControl321') 
_GUICtrlTab_ClickTab( $va,3 , "left", False)
WinWaitActive("AutoIt Help", "List1") ;--------����Ŀ�괰��--------
controlclick("AutoIt Help", "List1","Button4" ) ;--------���Ŀ�갴ť--------
_GUICtrlTab_ClickTab( $va,1, "left", False)
TrayTip("���", "�Ѽ�����ǩ", 5, 1)
EndFunc