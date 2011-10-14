HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")

$i = 0
Do
WinActivate ("Centaurus")

ControlClick ( "Centaurus", "Net preview", "TPanel225", "left", 2,252, 205);父窗口为Centaurus，子窗口为Net preview（获取时必须放到名字那里），TPanel225为视频窗体
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TPanel225", "left", 2,252, 205)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TPanel225", "right", 1,252, 205)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TPanel225", "right", 1,130, 90)
sleep(1000)
MouseClick( "right", 302, 204,1)
MouseClick( "right", 302, 204,1)
sleep(1000)


ControlClick ( "Centaurus", "Net preview", "TPanel224", "left", 2,258, 204)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TPanel224", "left", 2,258, 204)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TPanel224", "right", 1,258, 204)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TPanel224", "right", 1,106, 108)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TPanel224", "right", 1,580, 245)
sleep(1000)
MouseClick( "right", 302, 204,1)
MouseClick( "right", 302, 204,1)
sleep(1000)

ControlClick ( "Centaurus", "Net preview", "TPanel223", "left", 2,246, 204)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TPanel223", "left", 2,246, 204)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TPanel223", "right", 1,246, 204)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TPanel223", "right", 1,113, 99)
sleep(1000)
MouseClick( "right", 302, 204,1)
MouseClick( "right", 302, 204,1)
sleep(1000)

ControlClick ( "Centaurus", "Net preview", "TPanel222", "left", 2,326, 197)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TPanel222", "left", 2,326, 197)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TPanel222", "right", 1,326, 197)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TPanel222", "right", 1,132, 101)
sleep(1000)
MouseClick( "right", 302, 204,1)
MouseClick( "right", 302, 204,1)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TNetPreviewForm1", "left", 2,282, 18)
sleep(1000)


$i = $i + 1
Until $i = 100000000000000000000
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