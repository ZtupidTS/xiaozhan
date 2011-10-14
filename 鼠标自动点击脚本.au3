
Global $Paused
HotKeySet("{F2}", "TogglePause")
HotKeySet("{ESC}", "Terminate")
HotKeySet("{F1}", "MouseC")

While 1
   Sleep(500)
WEnd

Func TogglePause()
    $Paused = NOT $Paused
    While $Paused
        sleep(100)
        ToolTip('½Å±¾ÔÝÍ£ÖÐ',0,0)
    WEnd
    ToolTip("")
EndFunc

Func Terminate()
    Exit 0
EndFunc 

Func MouseC()
 while 1
 MouseClick("left")
 sleep(200)
 WEnd
EndFunc 

