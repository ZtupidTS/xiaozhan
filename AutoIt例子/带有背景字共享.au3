#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=网上邻居.ico
#AutoIt3Wrapper_outfile=网上邻居.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#include <Process.au3>
;#include <IE.au3>
;#Include <WinAPI.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiConstants.au3>

Global $MARk_1     = 0
Global $DEFAULTINPUTDATA_1   = "请输入你要找的共享IP"
Global $NONEAACTIVECOLOR    = 0x989898

$GUI = GUICreate("请输入IP地址", 200, 95)
$Input1 = GUICtrlCreateInput($DEFAULTINPUTDATA_1, 15, 20, 170, 20)
GUICtrlSetColor(-1, $NONEAACTIVECOLOR)

$Button1 = GUICtrlCreateButton("确定", 50, 50, 100, 35, $WS_GROUP)
GUICtrlSetState(-1, $GUI_DEFBUTTON)

GUISetState()


Sleep(3000)

While 1
	_CheckInput($GUI, $Input1, "请输入你要找的共享IP", $DEFAULTINPUTDATA_1, $MARK_1)
		$msg = GUIGetMsg()
		Select
			Case $msg = $GUI_EVENT_CLOSE
				ExitLoop
			Case $msg = $Button1
				ShellExecute(GUICtrlRead ($Input1))				; Will Run/Open Notepad
				ExitLoop
		EndSelect
	WEnd

Func _CheckInput($hWnd, $ID, $InputDefText, ByRef $DefaultInputData, ByRef $Mark)
    If $Mark = 0 And _IsFocused($hWnd, $ID) And $DefaultInputData = $InputDefText Then
        $Mark = 1
        GUICtrlSetData($ID, "")
        GUICtrlSetColor($ID, 0x000000)
        $DefaultInputData = ""
    ElseIf $Mark = 1 And Not _IsFocused($hWnd, $ID) And $DefaultInputData = "" And GUICtrlRead($ID) = "" Then
        $Mark = 0
        $DefaultInputData = $InputDefText
        GUICtrlSetData($ID, $DefaultInputData)
        GUICtrlSetColor($ID, $NONEAACTIVECOLOR)
    EndIf
EndFunc

Func _IsFocused($hWnd, $nCID)
    Return ControlGetHandle($hWnd, '', $nCID) = ControlGetHandle($hWnd, '', ControlGetFocus($hWnd))
EndFunc
