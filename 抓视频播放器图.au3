HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")

Local $Paused 
$i = 0
Do
WinActivate("Night Owl Watermark Player","Capture")
ControlClick("Night Owl Watermark Player","Capture","Button11")
sel()
;win7
WinActivate("Capture")
ControlClick("Capture","","ScrollBar2","left",1,9, 369)
;xp
WinActivate("C:\Capture")
MouseWheel ("down" , 2)
sel()


 $i = $i + 1
Until $i = 10000000000000


Func sel()
	Sleep(1000)
EndFunc

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
