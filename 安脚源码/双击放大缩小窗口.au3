HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")
Local $j=0
$i = 0
Do
WinActivate ("Centaurus")

MouseClick ( "left" , 505, 391, 2, $j)
MouseClick ( "left" , 505, 391, 2, $j)
;MouseClick ( "right" , 505, 391, 1, $j)
;MouseClick ( "right" , 432, 215, 1, $j)
;MouseClick ( "right" , 432, 215, 1, $j)
;MouseClick ( "left" , 591, 101, 2, $j)

MouseClick ( "left" , 964, 323, 2, $j)
MouseClick ( "left" , 964, 323, 2, $j)
;MouseClick ( "right" , 964, 323, 1, $j)
;MouseClick ( "right" , 703, 197, 1, $j)
;MouseClick ( "right" , 703, 197, 1, $j)
;MouseClick ( "left" , 591, 101, 2, $j)

MouseClick ( "left" , 1133, 732, 2, $j)
MouseClick ( "left" , 1133, 732, 2, $j)
;MouseClick ( "right" , 1133, 732, 1, $j)
;MouseClick ( "right" , 693, 432, 1, $j)
;MouseClick ( "right" , 693, 432, 1, $j)
;MouseClick ( "left" , 591, 101, 2, $j)

MouseClick ( "left" , 512, 724, 2, $j)
MouseClick ( "left" , 512, 724, 2, $j)
;MouseClick ( "right" , 512, 724, 1, $j)
;MouseClick ( "right" , 430, 415, 1, $j)
;MouseClick ( "right" , 430, 415, 1, $j)
;MouseClick ( "left" , 591, 101, 2, $j)

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