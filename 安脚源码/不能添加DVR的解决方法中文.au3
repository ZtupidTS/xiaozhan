local $n=1
MouseClick ( "left" , 32, 126, 1, $n)
send("{down 2}" )
send("{Enter}")
winwait("����豸")
ControlClick ( "����豸", "ALDVR", "[CLASS:TEdit; INSTANCE:4]","left", 2)
send("204")
ControlClick ( "����豸", "192.168.1.100", "[CLASS:TEdit; INSTANCE:5]","left", 2)
send("172.18.6.204")
ControlClick ( "����豸", "9000", "[CLASS:TSpinEdit; INSTANCE:1]","left", 2)
send("9104")
ControlClick ( "����豸", "", "[CLASS:TEdit; INSTANCE:2]","left", 2)
send("519070")
ControlClick ( "����豸", "���", "[CLASS:TButton; INSTANCE:2]","left", 2)
;MsgBox ( 0, "����", "����:   "  &  1)
#cs
if WinWaitClose ("Centaurus", "ȷ��") Then
     MsgBox ( 0, "����", "����: 0 " ,1)
elseif not WinWaitClose ("����豸", "���") 
WinClose("Centaurus", "ȷ��")

endif
#ce

If Not WinActive("Centaurus", "ȷ��") Then 
	WinActivate("Centaurus", "ȷ��")
	WinClose("Centaurus", "ȷ��")
endif
#cs
MouseClick ( "left" , 32, 126, 1, $n)
send("{down 2}" )
send("{Enter}")
winwait("����豸")
#ce