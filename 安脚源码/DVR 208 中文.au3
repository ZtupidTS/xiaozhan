#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_outfile=..\..\���Խű�\DVR 208 ����.exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
;208
local $n=1
WinActivate ("Centaurus")
WinActivate ("Centaurus")
MouseClick ( "left" , 32, 126, 1, $n)
send("{down 2}" )
send("{Enter}")
winwait("����豸")
ControlClick ( "����豸", "ALDVR", "[CLASS:TEdit; INSTANCE:4]","left", 2)
send("91(208)")
ControlClick ( "����豸", "192.168.1.100", "[CLASS:TEdit; INSTANCE:5]","left", 2)
send("172.18.6.208")
ControlClick ( "����豸", "9000", "[CLASS:TSpinEdit; INSTANCE:1]","left", 2)
send("9009")
ControlClick ( "����豸", "", "[CLASS:TEdit; INSTANCE:2]","left", 2)
send("admin")
ControlClick ( "����豸", "���", "[CLASS:TButton; INSTANCE:2]","left", 2)


If Not WinActive("Centaurus", "ȷ��") Then 
	WinActivate("Centaurus", "ȷ��")
	WinClose("Centaurus", "ȷ��")
	WinClose( "����豸", "���")
endif
