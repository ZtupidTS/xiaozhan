HotKeySet("{ESC}", "Terminate")
local $n=1
;228
WinActivate( "Centaurus", "节点组织树")
;$hwnd = WinGetHandle("Centaurus","节点组织树")
ControlClick  ( "Centaurus", "节点组织树", "TToolBar4")
;MouseClick ( "left" , 32, 126, 1, $n)
send("{down 2}" )
send("{Enter}")
winwait("添加设备")
ControlClick ( "添加设备", "ALDVR", "[CLASS:TEdit; INSTANCE:4]","left", 2)
send("90")
ControlClick ( "添加设备", "192.168.1.100", "[CLASS:TEdit; INSTANCE:5]","left", 2)
send("58.255.144.83")
ControlClick ( "添加设备", "9000", "[CLASS:TSpinEdit; INSTANCE:1]","left", 2)
send("9600")
ControlClick ( "添加设备", "", "[CLASS:TEdit; INSTANCE:2]","left", 2)
send("12345")
ControlClick ( "添加设备", "添加", "[CLASS:TButton; INSTANCE:2]","left", 2)

If Not WinActive("Centaurus", "确定") Then 
	WinActivate("Centaurus", "确定")
	WinClose("Centaurus", "确定")
	WinClose( "添加设备", "添加")
endif

If Not WinWaitClose ("添加设备", "添加")Then 
	WinWaitClose ("添加设备", "添加")
endif
;252
MouseClick ( "left" , 32, 126, 1, $n)
send("{down 2}" )
send("{Enter}")
winwait("添加设备")
ControlClick ( "添加设备", "ALDVR", "[CLASS:TEdit; INSTANCE:4]","left", 2)
send("252")
ControlClick ( "添加设备", "192.168.1.100", "[CLASS:TEdit; INSTANCE:5]","left", 2)
send("172.18.6.252")
ControlClick ( "添加设备", "9000", "[CLASS:TSpinEdit; INSTANCE:1]","left", 2)
send("19011")
ControlClick ( "添加设备", "", "[CLASS:TEdit; INSTANCE:2]","left", 2)
send("admin")
ControlClick ( "添加设备", "添加", "[CLASS:TButton; INSTANCE:2]","left", 2)


If Not WinActive("Centaurus", "确定") Then 
	WinActivate("Centaurus", "确定")
	WinClose("Centaurus", "确定")
	WinClose( "添加设备", "添加")
endif

If Not WinWaitClose ("添加设备", "添加")Then 
	WinWaitClose ("添加设备", "添加")
endif

;204
MouseClick ( "left" , 32, 126, 1, $n)
send("{down 2}" )
send("{Enter}")
winwait("添加设备")
ControlClick ( "添加设备", "ALDVR", "[CLASS:TEdit; INSTANCE:4]","left", 2)
send("204")
ControlClick ( "添加设备", "192.168.1.100", "[CLASS:TEdit; INSTANCE:5]","left", 2)
send("172.18.6.204")
ControlClick ( "添加设备", "9000", "[CLASS:TSpinEdit; INSTANCE:1]","left", 2)
send("9104")
ControlClick ( "添加设备", "", "[CLASS:TEdit; INSTANCE:2]","left", 2)
send("admin")
ControlClick ( "添加设备", "添加", "[CLASS:TButton; INSTANCE:2]","left", 2)


If Not WinActive("Centaurus", "确定") Then 
	WinActivate("Centaurus", "确定")
	WinClose("Centaurus", "确定")
	WinClose( "添加设备", "添加")
endif

If Not WinWaitClose ("添加设备", "添加")Then 
	WinWaitClose ("添加设备", "添加")
endif

;208
MouseClick ( "left" , 32, 126, 1, $n)
send("{down 2}" )
send("{Enter}")
winwait("添加设备")
ControlClick ( "添加设备", "ALDVR", "[CLASS:TEdit; INSTANCE:4]","left", 2)
send("204")
ControlClick ( "添加设备", "192.168.1.100", "[CLASS:TEdit; INSTANCE:5]","left", 2)
send("172.18.6.204")
ControlClick ( "添加设备", "9000", "[CLASS:TSpinEdit; INSTANCE:1]","left", 2)
send("9108")
ControlClick ( "添加设备", "", "[CLASS:TEdit; INSTANCE:2]","left", 2)
send("admin")
ControlClick ( "添加设备", "添加", "[CLASS:TButton; INSTANCE:2]","left", 2)


If Not WinActive("Centaurus", "确定") Then 
	WinActivate("Centaurus", "确定")
	WinClose("Centaurus", "确定")
	WinClose( "添加设备", "添加")
endif

If Not WinWaitClose ("添加设备", "添加")Then 
	WinWaitClose ("添加设备", "添加")
endif


;206
MouseClick ( "left" , 32, 126, 1, $n)
send("{down 2}" )
send("{Enter}")
winwait("添加设备")
ControlClick ( "添加设备", "ALDVR", "[CLASS:TEdit; INSTANCE:4]","left", 2)
send("206")
ControlClick ( "添加设备", "192.168.1.100", "[CLASS:TEdit; INSTANCE:5]","left", 2)
send("172.18.6.206")
ControlClick ( "添加设备", "9000", "[CLASS:TSpinEdit; INSTANCE:1]","left", 2)
send("6001")
ControlClick ( "添加设备", "", "[CLASS:TEdit; INSTANCE:2]","left", 2)
send("admin")
ControlClick ( "添加设备", "添加", "[CLASS:TButton; INSTANCE:2]","left", 2)

If Not WinActive("Centaurus", "确定") Then 
	WinActivate("Centaurus", "确定")
	WinClose("Centaurus", "确定")
	WinClose( "添加设备", "添加")
endif

If Not WinWaitClose ("添加设备", "添加")Then 
	WinWaitClose ("添加设备", "添加")
endif

Func Terminate()
    Exit 0
EndFunc