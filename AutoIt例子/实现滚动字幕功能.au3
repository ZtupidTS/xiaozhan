#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
Global $hFgui, $hSgui, $Label1, $Label2, $Texta, $zb, $za

_Example1()

Func _Example1()
        $za = -180
        $zb = 300
        $Texta = '          滚动字幕开始' & @CRLF & @CRLF & _
                        '    这里是很长很长的测试文字' & @CRLF & @CRLF & _
                        '    这里是很长很长的测试文字' & @CRLF & @CRLF & _
                        '    这里是很长很长的测试文字' & @CRLF & @CRLF & _
                        '    这里是很长很长的测试文字' & @CRLF & @CRLF & _
                        '    这里是很长很长的测试文字' & @CRLF & @CRLF & _
                        '    这里是很长很长的测试文字' & @CRLF & @CRLF & _
                        '    这里是很长很长的测试文字' & @CRLF & @CRLF & _
                        '    这里是很长很长的测试文字' & @CRLF & @CRLF & _
                        '          滚动字幕结束'

        $hFgui = GUICreate('滚动字幕', 450, 300)
        GUISetState()
        $hSgui = GUICreate("", 200, 260, 230, 40, $WS_POPUP, $WS_EX_MDICHILD, $hFgui)
        GUISetBkColor('0x008ACC', $hSgui)

        $Label1 = GUICtrlCreateLabel("", -180, 15, 190, 250)
        $Label2 = GUICtrlCreateLabel("", 5, 300, 190, 250)
        GUICtrlSetData($Label1, $Texta)
        GUICtrlSetData($Label2, $Texta)
        GUISetState()
        AdlibRegister('Scrolla', 20)
EndFunc   ;==>_Example1

While GUIGetMsg() <> -3
WEnd

Func Scrolla()
        ControlMove($hSgui, '', $Label2, 5, $zb)
        If $zb = -250 Then
                $zb = 300
                AdlibUnRegister('Scrolla')
                AdlibRegister('Scrollb', 20)
        ElseIf $zb = 15 Then
                Sleep(3000)
        EndIf
        $zb -= 1
EndFunc   ;==>Scrolla

Func Scrollb()
        ControlMove($hSgui, '', $Label1, $za, 15)
        If $za = 250 Then
                $za = -180
                AdlibUnRegister('Scrollb')
                AdlibRegister('Scrolla', 20)
        ElseIf $za = 5 Then
                Sleep(3000)
        EndIf
        $za += 1
EndFunc   ;==>Scrollb