#Include <SendMessage.au3>

HotKeySet("{ESC}", "Terminate")
local $n=1
;228
WinActivate( "Centaurus", "Nodes")
;$hwnd = WinGetHandle("Centaurus","节点组织树")
ControlCommand  ( "Centaurus", "Nodes", "TToolBar4","ShowDropDown", "")

;MouseClick ( "left" , 32, 126, 1, $n)
send("{down 2}" )
send("{Enter}")
winwait("Add Device")
ControlClick ( "Add Device", "ALDVR", "[CLASS:TEdit; INSTANCE:4]","left", 2)
send("bp-filtri.dyndns.org")
ControlClick ( "Add Device", "192.168.1.100", "[CLASS:TEdit; INSTANCE:5]","left", 2)
send("bp-filtri.dyndns.org")
ControlClick ( "Add Device", "9000", "[CLASS:TSpinEdit; INSTANCE:1]","left", 2)
send("9000")
ControlClick ( "Add Device", "", "[CLASS:TEdit; INSTANCE:2]","left", 2)
;send("admin")
ControlClick ( "Add Device", "Add", "[CLASS:TButton; INSTANCE:2]","left", 2)

If Not WinActive("Centaurus", "确定") Then 
	WinActivate("Centaurus", "确定")
	WinClose("Centaurus", "确定")
	WinClose( "Add Device", "Add")
endif

If Not WinWaitClose ("Add Device", "Add")Then 
	WinWaitClose ("Add Device", "Add")
endif
;252
MouseClick ( "left" , 32, 126, 1, $n)
send("{down 2}" )
send("{Enter}")
winwait("Add Device")
ControlClick ( "Add Device", "ALDVR", "[CLASS:TEdit; INSTANCE:4]","left", 2)
send("252")
ControlClick ( "Add Device", "192.168.1.100", "[CLASS:TEdit; INSTANCE:5]","left", 2)
send("172.18.6.252")
ControlClick ( "Add Device", "9000", "[CLASS:TSpinEdit; INSTANCE:1]","left", 2)
send("19011")
ControlClick ( "Add Device", "", "[CLASS:TEdit; INSTANCE:2]","left", 2)
send("admin")
ControlClick ( "Add Device", "Add", "[CLASS:TButton; INSTANCE:2]","left", 2)


If Not WinActive("Centaurus", "确定") Then 
	WinActivate("Centaurus", "确定")
	WinClose("Centaurus", "确定")
	WinClose( "Add Device", "Add")
endif

If Not WinWaitClose ("Add Device", "Add")Then 
	WinWaitClose ("Add Device", "Add")
endif

;204
MouseClick ( "left" , 32, 126, 1, $n)
send("{down 2}" )
send("{Enter}")
winwait("Add Device")
ControlClick ( "Add Device", "ALDVR", "[CLASS:TEdit; INSTANCE:4]","left", 2)
send("204")
ControlClick ( "Add Device", "192.168.1.100", "[CLASS:TEdit; INSTANCE:5]","left", 2)
send("172.18.6.204")
ControlClick ( "Add Device", "9000", "[CLASS:TSpinEdit; INSTANCE:1]","left", 2)
send("9104")
ControlClick ( "Add Device", "", "[CLASS:TEdit; INSTANCE:2]","left", 2)
send("admin")
ControlClick ( "Add Device", "Add", "[CLASS:TButton; INSTANCE:2]","left", 2)


If Not WinActive("Centaurus", "确定") Then 
	WinActivate("Centaurus", "确定")
	WinClose("Centaurus", "确定")
	WinClose( "Add Device", "Add")
endif

If Not WinWaitClose ("Add Device", "Add")Then 
	WinWaitClose ("Add Device", "Add")
endif

;208
MouseClick ( "left" , 32, 126, 1, $n)
send("{down 2}" )
send("{Enter}")
winwait("Add Device")
ControlClick ( "Add Device", "ALDVR", "[CLASS:TEdit; INSTANCE:4]","left", 2)
send("208")
ControlClick ( "Add Device", "192.168.1.100", "[CLASS:TEdit; INSTANCE:5]","left", 2)
send("172.18.6.208")
ControlClick ( "Add Device", "9000", "[CLASS:TSpinEdit; INSTANCE:1]","left", 2)
send("9108")
ControlClick ( "Add Device", "", "[CLASS:TEdit; INSTANCE:2]","left", 2)
send("admin")
ControlClick ( "Add Device", "Add", "[CLASS:TButton; INSTANCE:2]","left", 2)


If Not WinActive("Centaurus", "确定") Then 
	WinActivate("Centaurus", "确定")
	WinClose("Centaurus", "确定")
	WinClose( "Add Device", "Add")
endif

If Not WinWaitClose ("Add Device", "Add")Then 
	WinWaitClose ("Add Device", "Add")
endif


;206
MouseClick ( "left" , 32, 126, 1, $n)
send("{down 2}" )
send("{Enter}")
winwait("Add Device")
ControlClick ( "Add Device", "ALDVR", "[CLASS:TEdit; INSTANCE:4]","left", 2)
send("206")
ControlClick ( "Add Device", "192.168.1.100", "[CLASS:TEdit; INSTANCE:5]","left", 2)
send("172.18.6.206")
ControlClick ( "Add Device", "9000", "[CLASS:TSpinEdit; INSTANCE:1]","left", 2)
send("6001")
ControlClick ( "Add Device", "", "[CLASS:TEdit; INSTANCE:2]","left", 2)
send("admin")
ControlClick ( "Add Device", "Add", "[CLASS:TButton; INSTANCE:2]","left", 2)

If Not WinActive("Centaurus", "确定") Then 
	WinActivate("Centaurus", "确定")
	WinClose("Centaurus", "确定")
	WinClose( "Add Device", "Add")
endif

If Not WinWaitClose ("Add Device", "Add")Then 
	WinWaitClose ("Add Device", "Add")
endif

Func Terminate()
    Exit 0
EndFunc


