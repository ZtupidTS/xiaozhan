; Written by Simucal
#include <GuiConstants.au3>
#include <array.au3>
GuiCreate("Auto Convert", 425, 322,300, 200); create the gui window

$eOutput = GuiCtrlCreateEdit("", 0, 10, 423, 300)
GuiSetState()

$SystemDrives = DriveGetDrive("Fixed"); store the string names of all the fixed drives on the system in $SystemDrives array
_ArraySort($SystemDrives, 0, 1); arrays should be sorted before using binary search
$DriveC = _ArrayBinarySearch ($SystemDrives, "c:",1); search to see if there is a C:\ drive
If $DriveC <> "" Then; if there is, delete it from the array as it will already be NTFS
    _ArrayDelete($SystemDrives,$DriveC)
    $SystemDrives[0] = $SystemDrives[0] - 1
EndIf

For $ArraySize = UBound($SystemDrives) to 2 Step -1; this for loop then checks the remaining drives to see if they are NTFS or not, and modifies the array so only non-ntfs are left
    GUICtrlSetData($eOutput,"Checking filesystem of drive:  " & $SystemDrives[$ArraySize - 1] & "\" & @CRLF, 1)
    If DriveGetFileSystem($SystemDrives[$ArraySize - 1]&"\") = "NTFS" Then
        GUICtrlSetData($eOutput,"   Drive: " & $SystemDrives[$ArraySize - 1] & "\" & " is already NTFS." & @CRLF, 1)
        _ArrayDelete($SystemDrives, ($ArraySize - 1))
        $SystemDrives[0] = $SystemDrives[0] - 1
    Else
        GUICtrlSetData($eOutput,"   Drive: " & $SystemDrives[$ArraySize - 1] & "\" & " needs to be converted." & @CRLF, 1)
    EndIf
Next

If $SystemDrives[0] > 0 Then
    GUICtrlSetData($eOutput,"The following drives on the system need to be converted to NTFS:  " & _ArrayToString($SystemDrives, ",",1)&@CRLF, 1)
    For $i = 1 To $SystemDrives[0]; repeat the convert loop as many times as their are drives to be converted
        GUICtrlSetData($eOutput,"Starting to convert drive:  " & $SystemDrives[$i] & "\" & @CRLF, 1)
        $ourProcess = Run("convert " &  $SystemDrives[$i] & "/fs:ntfs /x", @SystemDir, @SW_HIDE, 3); run convert with the array variable that holds the drive letter
        While 1
            If $ourProcess Then
                $charsWaiting = StdoutRead($ourProcess, 0 , 1); capture the output of convert and store it into a variable
                If @error = -1 Then; If the convert has finished and exited, this will error, having it exit the while loop and check the for loop to see if there is another drive to be done.
                    $ourProcess = 0
                    GUICtrlSetData($eOutput,"Finished converting drive:  " & $SystemDrives[$i] & "\" & @CRLF, 1)
                    ExitLoop
                EndIf
                If $charsWaiting Then
                    $currentRead = StdoutRead($ourProcess); take the captured characters and store them in the $currentread variable
                    GUICtrlSetData($eOutput, $currentRead, 1); make it dump this to the GUI edit box
                    If StringInStr($currentRead, "Enter current volume label for drive") <> 0 Then; if any of those characters have the string "Enter current volume label for drive" then
                        StdinWrite($ourProcess, DriveGetLabel($SystemDrives[$i]&"\") & @CRLF); write the appropriate drive label to the program
                    EndIf
                EndIf
            EndIf
            $msg = GuiGetMsg()
            Select
                Case $msg = $GUI_EVENT_CLOSE
                    ExitLoop
                Case Else
        ;;;
            EndSelect
        WEnd
    Next
    GUICtrlSetData($eOutput,"Auto convert is finished converting all non-ntfs drives!"& @CRLF, 1)
Else
    MsgBox(0,"Error", "No other drives on the system need to be converted to NTFS!")
EndIf
Exit
