#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_outfile=..\..\���Խű�\DVR 216.exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
;252
local $n=1
WinActivate ("Centaurus")
WinActivate ("Centaurus")
MouseClick ( "left" , 32, 126, 1, $n)
send("{down 2}" )
send("{Enter}")
winwait("Add Device")
ControlClick ( "Add Device", "ALDVR", "[CLASS:TEdit; INSTANCE:4]","left", 2)
send("92(216)")
ControlClick ( "Add Device", "192.168.1.100", "[CLASS:TEdit; INSTANCE:5]","left", 2)
send("172.18.6.216")
ControlClick ( "Add Device", "9000", "[CLASS:TSpinEdit; INSTANCE:1]","left", 2)
send("9217")
ControlClick ( "Add Device", "", "[CLASS:TEdit; INSTANCE:2]","left", 2)
;send("admin")
ControlClick ( "Add Device", "Add", "[CLASS:TButton; INSTANCE:2]","left", 2)


If Not WinActive("Centaurus", "ȷ��") Then 
	WinActivate("Centaurus", "ȷ��")
	WinClose("Centaurus", "ȷ��")
	WinClose( "Add Device", "Add")
endif