HotKeySet("{ESC}", "Terminate")
local $n=1
;228
WinActivate( "Centaurus", "�ڵ���֯��")
;$hwnd = WinGetHandle("Centaurus","�ڵ���֯��")
ControlClick  ( "Centaurus", "�ڵ���֯��", "TToolBar4")
;MouseClick ( "left" , 32, 126, 1, $n)
send("{down 2}" )
send("{Enter}")
winwait("����豸")
ControlClick ( "����豸", "ALDVR", "[CLASS:TEdit; INSTANCE:4]","left", 2)
send("90")
ControlClick ( "����豸", "192.168.1.100", "[CLASS:TEdit; INSTANCE:5]","left", 2)
send("58.255.144.83")
ControlClick ( "����豸", "9000", "[CLASS:TSpinEdit; INSTANCE:1]","left", 2)
send("9600")
ControlClick ( "����豸", "", "[CLASS:TEdit; INSTANCE:2]","left", 2)
send("12345")
ControlClick ( "����豸", "���", "[CLASS:TButton; INSTANCE:2]","left", 2)

If Not WinActive("Centaurus", "ȷ��") Then 
	WinActivate("Centaurus", "ȷ��")
	WinClose("Centaurus", "ȷ��")
	WinClose( "����豸", "���")
endif

If Not WinWaitClose ("����豸", "���")Then 
	WinWaitClose ("����豸", "���")
endif
;252
MouseClick ( "left" , 32, 126, 1, $n)
send("{down 2}" )
send("{Enter}")
winwait("����豸")
ControlClick ( "����豸", "ALDVR", "[CLASS:TEdit; INSTANCE:4]","left", 2)
send("252")
ControlClick ( "����豸", "192.168.1.100", "[CLASS:TEdit; INSTANCE:5]","left", 2)
send("172.18.6.252")
ControlClick ( "����豸", "9000", "[CLASS:TSpinEdit; INSTANCE:1]","left", 2)
send("19011")
ControlClick ( "����豸", "", "[CLASS:TEdit; INSTANCE:2]","left", 2)
send("admin")
ControlClick ( "����豸", "���", "[CLASS:TButton; INSTANCE:2]","left", 2)


If Not WinActive("Centaurus", "ȷ��") Then 
	WinActivate("Centaurus", "ȷ��")
	WinClose("Centaurus", "ȷ��")
	WinClose( "����豸", "���")
endif

If Not WinWaitClose ("����豸", "���")Then 
	WinWaitClose ("����豸", "���")
endif

;204
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
send("admin")
ControlClick ( "����豸", "���", "[CLASS:TButton; INSTANCE:2]","left", 2)


If Not WinActive("Centaurus", "ȷ��") Then 
	WinActivate("Centaurus", "ȷ��")
	WinClose("Centaurus", "ȷ��")
	WinClose( "����豸", "���")
endif

If Not WinWaitClose ("����豸", "���")Then 
	WinWaitClose ("����豸", "���")
endif

;208
MouseClick ( "left" , 32, 126, 1, $n)
send("{down 2}" )
send("{Enter}")
winwait("����豸")
ControlClick ( "����豸", "ALDVR", "[CLASS:TEdit; INSTANCE:4]","left", 2)
send("204")
ControlClick ( "����豸", "192.168.1.100", "[CLASS:TEdit; INSTANCE:5]","left", 2)
send("172.18.6.204")
ControlClick ( "����豸", "9000", "[CLASS:TSpinEdit; INSTANCE:1]","left", 2)
send("9108")
ControlClick ( "����豸", "", "[CLASS:TEdit; INSTANCE:2]","left", 2)
send("admin")
ControlClick ( "����豸", "���", "[CLASS:TButton; INSTANCE:2]","left", 2)


If Not WinActive("Centaurus", "ȷ��") Then 
	WinActivate("Centaurus", "ȷ��")
	WinClose("Centaurus", "ȷ��")
	WinClose( "����豸", "���")
endif

If Not WinWaitClose ("����豸", "���")Then 
	WinWaitClose ("����豸", "���")
endif


;206
MouseClick ( "left" , 32, 126, 1, $n)
send("{down 2}" )
send("{Enter}")
winwait("����豸")
ControlClick ( "����豸", "ALDVR", "[CLASS:TEdit; INSTANCE:4]","left", 2)
send("206")
ControlClick ( "����豸", "192.168.1.100", "[CLASS:TEdit; INSTANCE:5]","left", 2)
send("172.18.6.206")
ControlClick ( "����豸", "9000", "[CLASS:TSpinEdit; INSTANCE:1]","left", 2)
send("6001")
ControlClick ( "����豸", "", "[CLASS:TEdit; INSTANCE:2]","left", 2)
send("admin")
ControlClick ( "����豸", "���", "[CLASS:TButton; INSTANCE:2]","left", 2)

If Not WinActive("Centaurus", "ȷ��") Then 
	WinActivate("Centaurus", "ȷ��")
	WinClose("Centaurus", "ȷ��")
	WinClose( "����豸", "���")
endif

If Not WinWaitClose ("����豸", "���")Then 
	WinWaitClose ("����豸", "���")
endif

Func Terminate()
    Exit 0
EndFunc