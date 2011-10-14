HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")

Local $Paused ,$f = 1,$file
$i = 0
Do
WinActivate("Night Owl Watermark Player")

sen(1)
sel()
sel1()

sen(2)
sel()
sel1()

sen(3)
sel()
sel1()

sen(4)
sel()
sel1()


sen1(1)
sel()
sel1()

sen1(2)
sel()
sel1()



sen1(3)
sel()
sel1()

sen1(4)
sel()
sel1()

_write208($f)
	$f+=1
	Sleep(1000)

 $i = $i + 1
Until $i = 10000000000000


func  sen($num)
for $k = 1 to $num
  ControlClick("Night Owl Watermark Player","F.F.","Button8","left")
  Sleep(200)
next
endfunc


func  sen1($num)
for $l= 1 to $num
  ControlClick("Night Owl Watermark Player","SLOW","Button7")
  Sleep(200)
next
endfunc

Func sel()
	Sleep(1000)
EndFunc

Func sel1()
	ControlClick("Night Owl Watermark Player","NEXT","Button9")
	sel()
	ControlClick("Night Owl Watermark Player","Capture","Button11")
	sel()
	sen2(2)
	sel()
	sen3(2)
	sel()
	ControlClick("Night Owl Watermark Player","PLAY","Button4")
	sel()
	ControlClick("Night Owl Watermark Player","PAUSE","Button5")
	sel()
	ControlClick("Night Owl Watermark Player","STOP","Button6")
	Sleep(3000)
	ControlClick("Night Owl Watermark Player","PLAY","Button4")
	sel()
EndFunc


func  sen2($num)
for $m= 1 to $num
  ControlClick("Night Owl Watermark Player","WM","Button12")
  Sleep(500)
next
endfunc

func  sen3($num)
for $n= 1 to $num
  ControlClick("Night Owl Watermark Player","","Button10")
  Sleep(500)
next
endfunc


Func _write208($f)
  $file = FileOpen(@ScriptDir & "\运行次数.ini", 1)
  FileWrite($file , $f & '次运行:     ' & @year & "/" & @MON & "/"   & @mday & " " & @HOUR & ":" & @MIN & ":" & @SEC & @CRLF)
  FileClose($file )
EndFunc

Func Terminate()
	Exit 0
EndFunc

Func Togglepause()
    $Paused = NOT $Paused 
	
   While $Paused 
	tooltip("暂停一会",0,0)
	sleep(100)
   tooltip("")
   WEnd
EndFunc