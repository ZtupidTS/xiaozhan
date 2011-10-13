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
WinWaitActive("AutoIt Help", "List1") ;--------激活目标窗口--------
controlclick("AutoIt Help", "List1","Button4" ) ;--------点击目标按钮--------
_GUICtrlTab_ClickTab( $va,0, "left", False)
TrayTip("完毕", "已加入书签", 5, 1)
EndFunc

Func N()
$va = ControlGetHandle ('AutoIt Help','','SysTabControl321') 
_GUICtrlTab_ClickTab( $va,3 , "left", False)
WinWaitActive("AutoIt Help", "List1") ;--------激活目标窗口--------
controlclick("AutoIt Help", "List1","Button4" ) ;--------点击目标按钮--------
_GUICtrlTab_ClickTab( $va,1, "left", False)
TrayTip("完毕", "已加入书签", 5, 1)
EndFunc