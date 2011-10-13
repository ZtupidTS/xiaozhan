#include <GUIConstantsEx.au3>
#include <GUIConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Include <Misc.au3> 

Global $start
Global $n = 0
Global $pos
Global $clickspeed = RegRead("HKEY_CURRENT_USER\Control Panel\Mouse", "DoubleClickSpeed")
Opt("GUIOnEventMode", 1)
$title = "mygui"
$title2="悬浮窗演示"
$AForm1 = GUICreate($title, 38, 38, 750, 100, BitOR($WS_SYSMENU, $WS_POPUP, $WS_POPUPWINDOW, $WS_BORDER), $WS_EX_TOOLWINDOW)
GUISetOnEvent($GUI_EVENT_CLOSE, "_exit", $AForm1)
GUISetOnEvent($GUI_EVENT_PRIMARYDOWN, '_PRIMARYdown', $AForm1)
GUISetOnEvent($GUI_EVENT_PRIMARYUP, '_PRIMARYup', $AForm1)
GUISetBkColor(0xBFDBFF)
$icon = GUICtrlCreateIcon(@WindowsDir & "\cursors\horse.ani", -1, 3, 3)
GUICtrlSetState(-1, $GUI_DISABLE)

$Rm = GUICtrlCreateContextMenu()
$title3 = GUICtrlCreateMenuItem("打开/隐藏主窗口", $Rm)
GUICtrlSetOnEvent(-1, "showhidemain")
GUICtrlCreateMenuItem("", $Rm)
$Help = GUICtrlCreateMenuItem("关于", $Rm)
GUICtrlSetOnEvent(-1, "about")
GUICtrlCreateMenuItem("", $Rm)
$exit = GUICtrlCreateMenuItem("退出", $Rm)
GUICtrlSetOnEvent(-1, "_exit")

$AForm2 = GUICreate($title2, 400, 300, -1, -1)
GUISetOnEvent($GUI_EVENT_CLOSE, "showhidemain", $AForm2)
$label1 = GUICtrlCreateLabel("这是主程序窗口", 50, 100)
GUISetState(@SW_SHOW, $AForm1)

WinSetOnTop($AForm1, "", 1)
WinSetTrans($AForm1, "", 200)
While 1
        Sleep(100)
WEnd

Func _exit()
        GUIDelete()
        Exit
EndFunc   ;==>_exit

Func about()
        MsgBox(262144, "关于：", "这是一个关于悬浮窗的演示程序。" & @CRLF & @CRLF & "     By Pcbar 2007.09.21")
EndFunc   ;==>about

Func Move()
        Dim $PosDiff[2], $MousePos, $WinPos
        $MousePos = MouseGetPos()
        $WinPos = WinGetPos($title, "")
        $PosDiff[0] = $WinPos[0] - $MousePos[0]
        $PosDiff[1] = $WinPos[1] - $MousePos[1]
        While _IsPressed("01", DllOpen("user32.dll"))
                $MousePos = MouseGetPos()
                WinMove($title, "", $MousePos[0] + $PosDiff[0], $MousePos[1] + $PosDiff[1])
                Sleep(10)
        WEnd
EndFunc   ;==>Move
Func _PRIMARYdown()
        Move()
        $pos = MouseGetPos()
        $guiPos = WinGetPos($AForm1, '')
        If ($pos[0] >= $guiPos[0] And $pos[0] <= $guiPos[0] + $guiPos[2]) And _
                        ($pos[1] >= $guiPos[1] And $pos[1] <= $guiPos[1] + $guiPos[3]) Then
                $n += 1
                If $n = 2 And (TimerDiff($start) < $clickspeed) Then
                        ShowHidemain()
                Else
                        $start = TimerInit()
                        $n = 1
                EndIf
        EndIf
EndFunc   ;==>_PRIMARYdown
Func _PRIMARYup()
        If $n = 2 Then
                $n = 0
        Else
                $start = TimerInit()
        EndIf
EndFunc   ;==>_PRIMARYup

Func ShowHidemain()
    If _WinIsVisible($AForm2) Then
        GUISetState(@SW_HIDE,$AForm2)
    Else
        GUISetState(@SW_SHOW,$AForm2)
                if BitAND(WinGetState($title2,""),16) then WinSetState($title2,"",@SW_RESTORE)
        WinActivate($AForm2)
    EndIf
EndFunc

Func _WinIsVisible($hWnd, $Text="")
    Return BitAND(WinGetState($hWnd, $Text), 2)
EndFunc