#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <WindowsConstants.au3>
 
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Form1", 633, 447)
$List1 = GUICtrlCreateList("", 40, 24, 553, 370)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
RunWait(@ComSpec & ' /c dir "' & @ProgramsDir & '"\*.* /a /s /b>dir.log')
For $i = 1 To 65535
        $string = FileReadLine("dir.log", $i)
        If @error Then ExitLoop
        $strings = StringRegExp($string, '.+\.lnk',1)
        If @error = 0 Then GUICtrlSetData($List1, $string)
Next
RunWait(@ComSpec & ' /c dir "' & @ProgramsCommonDir & '"\*.* /a /s /b>dir.log')
For $i = 1 To 65535
        $string = FileReadLine("dir.log", $i)
        If @error Then ExitLoop
        $strings = StringRegExp($string, '.+\.lnk',1)
        If @error = 0 Then GUICtrlSetData($List1, $string)
Next
FileDelete("dir.log")
 
While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
                Case $GUI_EVENT_CLOSE
                        Exit
 
        EndSwitch
WEnd