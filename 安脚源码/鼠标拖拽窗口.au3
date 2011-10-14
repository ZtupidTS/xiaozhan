HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")
Local $m=0
$i = 0
Do
WinActivate ("Centaurus")
MouseClickDrag ("left",744, 527,784, 535,$m)
MouseClickDrag ("left",784, 535,790, 575,$m)
MouseClickDrag ("left",790, 575,748, 575,$m)
MouseClickDrag ("left",748, 575,744, 527,$m)

$i = $i + 1
Until $i = 100000000000000000000
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