#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_outfile=..\..\���Խű�\ץͼ(���ñ���) ����.exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****

;��������ɱ����Լ2500��ͼƬ    ��625��


HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")
Local $Paused,$k=0 ,$a=0

WinActivate ("Centaurus")

$i = 0
Do

WinActivate ("Centaurus")
ControlClick ( "Centaurus", "�������", "TPanel226", "left", 2,252, 205)
sleep(1000)
ControlClick ( "Centaurus", "�������", "TPanel226", "left", 2,252, 205)
ControlClick ( "Centaurus", "�������", "TToolBar4", "left", 1,352, 10)
ControlClick ( "Centaurus", "�������", "TToolBar6", "left", 1,352, 10)
winwait("ץ֡����","ȷ��")
ControlClick ( "ץ֡����", "", "[CLASS:TComboBox; INSTANCE:1]","left", 1, 37, 7)
send("{down}")
send("{Enter}")
sleep(3000)
send("{Enter}")
sleep(1500)



If WinExists("Centaurus", "��(&N)") Then
     $a = IniRead ( @ScriptDir & "\���ñ�������.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a,1)
	 winwait("Centaurus", "��(&N)")
	 WinActivate ("Centaurus", "��(&N)")
	 ControlClick ( "Centaurus", "��(&N)","[ID:7]" )
	 WinClose("ץ֡����","ȡ��")
	 ExitLoop
endif

If WinExists("Centaurus", "ȷ��") Then
     $a = IniRead ( @ScriptDir & "\���ñ�������.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a,1)
	 winwait("Centaurus", "ȷ��")
	 WinActivate ("Centaurus", "ȷ��")
	 send("{Enter}")
	 WinClose("ץ֡����","ȡ��")
	 ExitLoop
elseif WinWaitClose ("ץ֡����", "ȷ��") then
	$a = IniRead ( @ScriptDir & "\���ñ�������.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\���ñ�������.ini", "����", "����", $a+1) 
endif

ControlClick ( "Centaurus", "�������", "TPanel225", "left", 2,258, 204)
sleep(1000)
ControlClick ( "Centaurus", "�������", "TPanel225", "left", 2,258, 204)
ControlClick ( "Centaurus", "�������", "TToolBar4", "left", 1,352, 10)
ControlClick ( "Centaurus", "�������", "TToolBar6", "left", 1,352, 10)
winwait("ץ֡����","ȷ��")
ControlClick ( "ץ֡����", "", "[CLASS:TComboBox; INSTANCE:1]","left", 1, 37, 7)
send("{down}")
send("{Enter}")
sleep(3000)
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "��(&N)") Then
     $a = IniRead ( @ScriptDir & "\���ñ�������.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a,1)
	 winwait("Centaurus", "��(&N)")
	 WinActivate ("Centaurus", "��(&N)")
	 ControlClick ( "Centaurus", "��(&N)","[ID:7]" )
	 WinClose("ץ֡����","ȡ��")
	 ExitLoop
 endif
 
If WinExists("Centaurus", "ȷ��") Then
     $a = IniRead ( @ScriptDir & "\���ñ�������.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a,1)
	 winwait("Centaurus", "ȷ��")
	 WinActivate ("Centaurus", "ȷ��")
	 send("{Enter}")
	 WinClose("ץ֡����","ȡ��")
	 ExitLoop
elseif WinWaitClose ("ץ֡����", "ȷ��") then
	$a = IniRead ( @ScriptDir & "\���ñ�������.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\���ñ�������.ini", "����", "����", $a+1) 
endif

ControlClick ( "Centaurus", "�������", "TPanel223", "left", 2,246, 204)
sleep(1000)
ControlClick ( "Centaurus", "�������", "TPanel223", "left", 2,246, 204)
ControlClick ( "Centaurus", "�������", "TToolBar4", "left", 1,352, 10)
ControlClick ( "Centaurus", "�������", "TToolBar6", "left", 1,352, 10)
winwait("ץ֡����","ȷ��")
ControlClick ( "ץ֡����", "", "[CLASS:TComboBox; INSTANCE:1]","left", 1, 37, 7)
send("{down}")
send("{Enter}")
sleep(3000)
send("{Enter}")
sleep(1500)


If WinExists("Centaurus", "��(&N)") Then
     $a = IniRead ( @ScriptDir & "\���ñ�������.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a,1)
	 winwait("Centaurus", "��(&N)")
	 WinActivate ("Centaurus", "��(&N)")
	 ControlClick ( "Centaurus", "��(&N)","[ID:7]" )
	 WinClose("ץ֡����","ȡ��")
	 ExitLoop
 endif
 
If WinExists("Centaurus", "ȷ��") Then
     $a = IniRead ( @ScriptDir & "\���ñ�������.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a,1)
	 winwait("Centaurus", "ȷ��")
	 WinActivate ("Centaurus", "ȷ��")
	 send("{Enter}")
	 WinClose("ץ֡����","ȡ��")
	 ExitLoop
elseif WinWaitClose ("ץ֡����", "ȷ��") then
	$a = IniRead ( @ScriptDir & "\���ñ�������.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\���ñ�������.ini", "����", "����", $a+1) 
endif

ControlClick ( "Centaurus", "�������", "TPanel224", "left", 2,326, 197)
sleep(1000)
ControlClick ( "Centaurus", "�������", "TPanel224", "left", 2,326, 197)
ControlClick ( "Centaurus", "�������", "TToolBar4", "left", 1,352, 10)
ControlClick ( "Centaurus", "�������", "TToolBar6", "left", 1,352, 10)
winwait("ץ֡����","ȷ��")
ControlClick ( "ץ֡����", "", "[CLASS:TComboBox; INSTANCE:1]","left", 1, 37, 7)
send("{down}")
send("{Enter}")
sleep(3000)
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "��(&N)") Then
     $a = IniRead ( @ScriptDir & "\���ñ�������.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a,1)
	 winwait("Centaurus", "��(&N)")
	 WinActivate ("Centaurus", "��(&N)")
	 ControlClick ( "Centaurus", "��(&N)","[ID:7]" )
	 WinClose("ץ֡����","ȡ��")
	 ExitLoop
 endif
 

If WinExists("Centaurus", "ȷ��") Then
     $a = IniRead ( @ScriptDir & "\���ñ�������.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a,1)
	 winwait("Centaurus", "ȷ��")
	 WinActivate ("Centaurus", "ȷ��")
	 send("{Enter}")
	 WinClose("ץ֡����","ȡ��")
	 ExitLoop
elseif WinWaitClose ("ץ֡����", "ȷ��") then
	$a = IniRead ( @ScriptDir & "\���ñ�������.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\���ñ�������.ini", "����", "����", $a+1) 
endif

$i = $i + 1
Until $i = 937

$a = IniRead ( @ScriptDir & "\���ñ�������.ini", "����", "����" ,"")
MsgBox ( 0, "����", "����:   "  &   $a )

Func Terminate()
	$a = IniRead ( @ScriptDir & "\���ñ�������.ini", "����", "����" ,"")
	MsgBox ( 0, "����", "����:   "  &  $a)
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