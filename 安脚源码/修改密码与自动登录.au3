HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")


Local $m=0 ,$Paused
WinActivate ("Centaurus")

send("!s")
send("{down 4}")
send("{enter}")

WinWait("Change password","OK")
ControlClick ( "Change password", "", "TEdit2", "left")
send("system")
ControlClick ( "Change password", "OK", "TButton2", "left")
ControlClick ( "Centaurus", "ȷ��", "Button1", "left")

send("!s")
send("{down 2}")
send("{enter}")

WinWait("Auto user authorization","OK")
ControlClick ( "Auto user authorization", "Enable", "TCheckBox1", "left")
ControlClick ( "Auto user authorization", "OK", "TButton2", "left")


send("!s")
send("{enter}")
MouseClick( "left", 321, 63,1)
WinActivate ("Centaurus")
ControlClick ( "Centaurus", "Centaurus", "TLabeledEdit1", "left",2)
send("")
send("{enter}")







Func Terminate()
    ;$a = IniRead ( @ScriptDir & "\sctpzs.ini", "����", "����" ,"")
    ;MsgBox ( 0, "����", "����:   "  &  $a)	
	Exit 0
EndFunc

Func Togglepause()
    $Paused = NOT $Paused 
	
   While $Paused 
	tooltip("��ͣһ��",0,0)
	sleep(100)
   tooltip("")
   WEnd
EndFunc