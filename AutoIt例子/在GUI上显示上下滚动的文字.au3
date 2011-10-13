#include <GUIConstants.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
Opt("GuiOnEventMode", 1)
Dim $LeftPos
Global $GUIHWND, $TITLE_LABEL
$GuihWnd = _GuiDragableCreate("公 告", 300, 300, -1, -1)
GUISetBkColor(0xffffff)

$ExampleLabel = GUICtrlCreateLabel("", 0, 20, 250, 140)
GUICtrlSetFont(-1, 12, 800, 0, "宋体")
GUICtrlSetColor(-1, 0xDD0000)

AdlibRegister("Example", 50)

DllCall("User32.dll", "long", "AnimateWindow", "hwnd", $GuihWnd, "long", 800, "long", 0x10)
GUISetState()

While 1
Sleep(10)
WEnd

Func Example()
GUICtrlSetData($ExampleLabel,"正在读取数据，请耐心等待！！！"&@CRLF&"显示出来的公告！！！")
$LeftPos += -1
GUICtrlSetPos($ExampleLabel, 30, 200+$LeftPos);;;调整某控件在窗口中的坐标位置。
If $LeftPos <= -160 Then 
DllCall("User32.dll", "long", "AnimateWindow", "hwnd", $GuihWnd, "long", 1500, "long", 0x10+0x10000)
Exit 
EndIf 
EndFunc

Func _GuiDragableCreate($Title="", $Width=300, $Height=200, $Left=-1, $Top=-1, $Style=-1, $exStyle=-1, $Parent=0)
Local $SetStyle = $WS_POPUPWINDOW+$Style, $SetExStyle = $WS_EX_DLGMODALFRAME+$exStyle
If $Style = -1 Then $SetStyle = $WS_POPUPWINDOW
If $exStyle = -1 Then $SetExStyle = $WS_EX_DLGMODALFRAME
Local $hWnd = GUICreate($Title, $Width, $Height, $Left, $Top, $SetStyle, $SetexStyle, $Parent)
$Title_Label = GUICtrlCreateLabel($Title, 0, 0, 300, 20, $SS_CENTER)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetFont(-1, 18, 700, 0, "Courier New")
If Not BitAND($SetStyle, $WS_MAXIMIZEBOX) Then GUICtrlSetState(-1, $GUI_DISABLE)
Return $hWnd
EndFunc
