#Include <GuiTreeView.au3>

HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")

WinActivate ("Centaurus")
Local $h,$Paused
ControlClick("Centaurus","tbWindows","TToolBar5","left",1,150, 16)
send("{down}")
send("{enter}")
MouseClickDrag("left", 28, 146, 342, 174)
WinActivate ("Centaurus","Setup storage center")
ControlTreeView ("Centaurus", "Setup storage center", "TTreeView5", "Expand", "sea")

$h = ControlGetHandle("Centaurus","Setup storage center","TTreeView5")
_GUICtrlTreeView_Expand($h)
;_GUICtrlTreeView_ClickItem($h, 228, "left", true, 2)
MouseClick ( "left" , 449, 268, 15 , 0 )
MouseClick ( "left" , 339, 266, 1 , 0 )
send("{down 2}")
;MsgBox(0,"1","1")
MouseClick ( "right" , 678, 226, 1 , 0 )
;MsgBox(0,"","")
;ControlClick("Centaurus","Setup storage center","TScrollBox1","right",1,326, 46)
;MsgBox(0,"1","1")
send("{down}")
send("{enter}")
Sleep(500)
ControlClick("Centaurus","Setup storage center","TCheckBox2","left",1,39, 8)
send("{tab 5}")
Send("23")
Sleep(500)
send("{right}")
Send("59")
Sleep(500)
send("{right}")
Send("59")
Sleep(500)
send("{tab}")
Send("00")
Sleep(500)
send("{right}")
Send("00")
Sleep(500)
send("{right}")
Send("00")
Sleep(500)
send("{enter}")

ControlClick("Centaurus","Setup storage center","TToolBar7","left",1,96, 12)
;1
MouseClick ( "left" , 747, 258, 1 , 0 )
ControlClick("Centaurus","Setup storage center","TToolBar7","left",1,120, 12)
;2
MouseClick ( "left" , 738, 301, 1 , 0 )
ControlClick("Centaurus","Setup storage center","TToolBar7","left",1,120, 12)
;3
MouseClick ( "left" , 725, 339, 1 , 0 )
ControlClick("Centaurus","Setup storage center","TToolBar7","left",1,120, 12)
;4
MouseClick ( "left" , 702, 379, 1 , 0 )
ControlClick("Centaurus","Setup storage center","TToolBar7","left",1,120, 12)
;5
MouseClick ( "left" , 787, 424, 1 , 0 )
ControlClick("Centaurus","Setup storage center","TToolBar7","left",1,120, 12)
;6
MouseClick ( "left" , 717, 460, 1 , 0 )
ControlClick("Centaurus","Setup storage center","TToolBar7","left",1,120, 12)

ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,56, 10)
send("{tab 2}")
;228
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

send("{down}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

send("{down}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

send("{down}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

;252
send("{down 2}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

send("{down}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

send("{down}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

send("{down}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

send("{down}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

send("{down}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

send("{down}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

send("{down}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

;204
send("{down 2}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

send("{down}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

send("{down}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

send("{down}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

;208
send("{down 2}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

send("{down}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

send("{down}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

send("{down}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

send("{down}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

send("{down}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

send("{down}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

send("{down}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

;206
send("{down 2}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

send("{down}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

send("{down}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

send("{down}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

send("{down}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

send("{down}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

send("{down}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)

send("{down}")
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,80, 10)
Sleep(500)
ControlClick("Centaurus","Setup storage center","TToolBar6","left",1,10, 10)


Func Terminate()
	Exit 0
EndFunc

Func Togglepause()
    $Paused = NOT $Paused 
	
   While $Paused 
	tooltip("ÔÝÍ£Ò»»á",0,0)
	sleep(100)
   tooltip("")
   WEnd
EndFunc
