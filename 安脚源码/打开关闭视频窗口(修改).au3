HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")
Local $l=3
$i = 0
Do
WinActivate ("Centaurus")

ControlClick ( "Centaurus", "Net preview", "TPanel225", "left", 2,252, 205)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TPanel225", "left", 2,252, 205)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TToolBar6", "left", 1,150, 11)
sleep(2000)

ControlClick ( "Centaurus", "Net preview", "TPanel224", "left", 2,258, 204)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TPanel224", "left", 2,258, 204)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TToolBar6", "left", 1,150, 11)
sleep(2000)

ControlClick ( "Centaurus", "Net preview", "TPanel223", "left", 2,246, 204)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TPanel223", "left", 2,246, 204)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TToolBar6", "left", 1,150, 11)
sleep(2000)

ControlClick ( "Centaurus", "Net preview", "TPanel222", "left", 2,326, 197)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TPanel222", "left", 2,326, 197)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TToolBar6", "left", 1,150, 11)
sleep(2000)
;---------------------
ControlClick ( "Centaurus", "Net preview", "TPanel225", "left", 2,252, 205)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TPanel225", "left", 2,252, 205)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TToolBar6", "left", 1,123, 11)
sleep(2000)

ControlClick ( "Centaurus", "Net preview", "TPanel224", "left", 2,258, 204)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TPanel224", "left", 2,258, 204)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TToolBar6", "left", 1,123, 11)
sleep(2000)

ControlClick ( "Centaurus", "Net preview", "TPanel223", "left", 2,246, 204)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TPanel223", "left", 2,246, 204)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TToolBar6", "left", 1,123, 11)
sleep(2000)

ControlClick ( "Centaurus", "Net preview", "TPanel222", "left", 2,326, 197)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TPanel222", "left", 2,326, 197)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TToolBar6", "left", 1,123, 11)
sleep(2000)
;----------------
ControlClick ( "Centaurus", "Net preview", "TToolBar6", "left", 1,88, 13)
sleep(2000)
ControlClick ( "Centaurus", "Net preview", "TToolBar6", "left", 1,60, 11)
sleep(2000)

$i = $i + 1
Until $i = 300000000000000000000
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