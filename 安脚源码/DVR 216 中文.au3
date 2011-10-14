#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_outfile=..\..\测试脚本\DVR 216 中文.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
;252
local $n=1
WinActivate ("Centaurus")
WinActivate ("Centaurus")
MouseClick ( "left" , 32, 126, 1, $n)
send("{down 2}" )
send("{Enter}")
winwait("添加设备")
ControlClick ( "添加设备", "ALDVR", "[CLASS:TEdit; INSTANCE:4]","left", 2)
send("92(216)")
ControlClick ( "添加设备", "192.168.1.100", "[CLASS:TEdit; INSTANCE:5]","left", 2)
send("172.18.6.216")
ControlClick ( "添加设备", "9000", "[CLASS:TSpinEdit; INSTANCE:1]","left", 2)
send("9217")
ControlClick ( "添加设备", "", "[CLASS:TEdit; INSTANCE:2]","left", 2)
;send("admin")
ControlClick ( "添加设备", "添加", "[CLASS:TButton; INSTANCE:2]","left", 2)


If Not WinActive("Centaurus", "确定") Then 
	WinActivate("Centaurus", "确定")
	WinClose("Centaurus", "确定")
	WinClose( "添加设备", "添加")
endif