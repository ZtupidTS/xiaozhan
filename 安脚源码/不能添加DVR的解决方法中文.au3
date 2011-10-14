local $n=1
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
send("519070")
ControlClick ( "添加设备", "添加", "[CLASS:TButton; INSTANCE:2]","left", 2)
;MsgBox ( 0, "计数", "次数:   "  &  1)
#cs
if WinWaitClose ("Centaurus", "确定") Then
     MsgBox ( 0, "计数", "次数: 0 " ,1)
elseif not WinWaitClose ("添加设备", "添加") 
WinClose("Centaurus", "确定")

endif
#ce

If Not WinActive("Centaurus", "确定") Then 
	WinActivate("Centaurus", "确定")
	WinClose("Centaurus", "确定")
endif
#cs
MouseClick ( "left" , 32, 126, 1, $n)
send("{down 2}" )
send("{Enter}")
winwait("添加设备")
#ce