#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

$Form = GUICreate("��¼��", 259, 69, 192, 124)
$Button = GUICtrlCreateButton("��¼", 80, 16, 81, 33)
GUISetState(@SW_SHOW)
Dim $i , $txt, $Paused,$record,$Edit
HotKeySet("{F1}", "Pause")
HotKeySet("{ESC}", "ESC")

While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
                Case $GUI_EVENT_CLOSE
                        Exit
        Case $Button 
                        GUICtrlSetData($Button,'ֹͣ')
                    _ClipGet()
                
        EndSwitch
WEnd

Func _ClipGet()
        $txt = ''
        $Clip= ''
        For $i = 1 To 10000
                Sleep(2000)
                Send("^c") 
                If ClipGet()<>$Clip Then
                $Clip =ClipGet()
                $txt =  $txt& @CRLF&ClipGet()
       ToolTip($txt,0,0)
        Else
                ContinueLoop
        EndIf
        Next
        EndFunc 


Func Pause()
    $Paused = NOT $Paused
    While $Paused
        sleep(100)
                TrayTip("��ͣ��¼","",0)
    WEnd

EndFunc

Func ESC()
        ClipPut($txt)
        MsgBox(0, "����������:",$txt )
        Exit
EndFunc