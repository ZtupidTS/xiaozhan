HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")
Local $l=3
$i = 0
Do
WinActivate ("Centaurus")

MouseClick ( "left" , 505, 391, 1, $l)
MouseClick ( "left" , 411, 120, 1, $l)

MouseClick ( "left" , 964, 323, 1, $l)
MouseClick ( "left" , 411, 120, 1, $l)

MouseClick ( "left" , 1133, 732, 1, $l)
MouseClick ( "left" , 411, 120, 1, $l)

MouseClick ( "left" , 512, 724, 1, $l)
MouseClick ( "left" , 411, 120, 1, $l)

;---------------------
MouseClick ( "left" , 505, 391, 1, $l)
MouseClick ( "left" , 384, 119, 1, $l)

MouseClick ( "left" , 964, 323, 1, $l)
MouseClick ( "left" , 384, 119, 1, $l)

MouseClick ( "left" , 1133, 732, 1, $l)
MouseClick ( "left" , 384, 119, 1, $l)

MouseClick ( "left" , 512, 724, 1, $l)
MouseClick ( "left" , 384, 119, 1, $l)
sleep(2000)
;----------------
MouseClick ( "left" , 351, 121, 1, $l)
sleep(2000)
MouseClick ( "left" , 322, 120, 1, $l)
sleep(2000)

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