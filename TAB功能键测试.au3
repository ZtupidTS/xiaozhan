HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")
#Include <Date.au3>
Local $Paused,$a,$H = 1
$i = 0
Do

ShellExecute("NetViewer.exe","","C:\Program Files\NetViewer")
WinWait("NetViewer")
WinActivate("NetViewer")
ControlClick("NetViewer","","Edit1")
Send("172.18.6.14")
ControlClick("NetViewer","","Edit2")
Send("2053")
ControlClick("NetViewer","","Edit3")
Send("admin")
ControlClick("NetViewer","","Edit4")
Send("")
sen(4)

;Sen(5)

$j = 0
Do
	sen1(7)
	
$j = $j + 1
Until $j = 5

Send("{tab 5}")
Send("{enter}")
WinWait("NetViewer","","Static17")
Sleep(5*1000)
ControlClick("NetViewer","Remote Setting","Button3")
Sleep(500)	
;#cs
;display setup
WinActivate("NetViewer")
sen3()
sen(9)	
Sleep(500)	
sen4()


sen2()

;record setup

sen3()
sen(13)
Sleep(500)
sen4()

sen2()

;alarm parameters

sen3()
sen(5)
Sleep(500)
sen4()

sen2()

;basic

sen3()
sen(6)
Sleep(500)
sen4()

sen2()

;pppoe

sen3()
sen(3)
Sleep(500)
sen4()


sen2()

;ddns

sen3()
sen(7)
Sleep(500)
sen4()

sen2()

;email setting

sen3()
sen(10)
Sleep(500)
sen4()

sen2()

;hdd

sen3()
sen(2)
Sleep(500)
sen4()

sen2()

;ptz

sen3()
sen(11)
Sleep(500)
sen4()

sen2()

;mobile

sen3()
sen(4)
Sleep(500)
sen4()

sen2()

;motion

sen3()
sen(7)
Sleep(500)
sen4()

sen2()

;system

sen3()
sen(3)
Sleep(500)
sen4()

sen2()

;user

sen3()
sen(6)
Sleep(500)
sen4()

sen2()

;dst

sen3()
sen(13)
Sleep(500)
sen4()


sen2()

;information

sen3()
sen(10)
sen4()

;#ce
Sleep(3000)
ProcessClose ( "NetViewer.exe") 
;ControlClick("NetViewer","Logout","Button5")
;WinWait("NetViewer","User Login")
;Sleep(3000)

	 _write($H)
	$H+=1
	Sleep(1000)



$i = $i + 1
Until $i = 100000000000000000000000000000000000000



Func _write($H)
  $file = FileOpen(@ScriptDir & '\TAB功能.ini', 1)
  FileWrite($file , $H & '使用TAB功能:     ' & @year & "/" & @MON & "/"   & @mday & " " & @HOUR & ":" & @MIN & ":" & @SEC & @CRLF)
  FileClose($file )
EndFunc


func  sen($num)
for $k = 1 to $num
  winActivate("NetViewer")
  Send("{tab}")
  Sleep(800)
next
endfunc

func  sen2()
  WinActivate("NetViewer")
  Send("{tab}")
  Sleep(10*1000)

endfunc

func  sen3()
  WinActivate("NetViewer")
 send("^{RIGHT}")
Sleep(500)

endfunc

func  sen4()
WinActivate("NetViewer")
 send("^{left}")
Sleep(500)
endfunc

func  sen1($num)
for $k = 1 to $num
	WinActivate("NetViewer")
  Send("{tab}")
  ;Sleep(100)
next
endfunc


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