#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_outfile=..\..\���Խű�\�޸��������Զ���¼ ����.exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")


Local $m=0 ,$Paused
WinActivate ("Centaurus")

send("!s")
send("{down 4}")
send("{enter}")

WinWait("��������","ȷ��")
ControlClick ( "��������", "", "TEdit2", "left")
Sleep(100)
send("system")
ControlClick ( "��������", "ȷ��", "TButton2", "left")
ControlClick ( "Centaurus", "ȷ��", "Button1", "left")
Sleep(100)

send("!s")
send("{down 2}")
send("{enter}")

WinWait("�Զ��û�У��","ȷ��")
ControlClick ( "�Զ��û�У��", "����", "TCheckBox1", "left")
ControlClick ( "�Զ��û�У��", "ȷ��", "TButton2", "left")


ControlClick ( "Centaurus", "tbWindows", "TToolBar5", "left",1,512, 21)
MouseClick( "left", 512, 63,1)
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