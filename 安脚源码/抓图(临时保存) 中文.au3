#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_outfile=..\..\���Խű�\ץͼ(��ʱ����) ����.exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")
Local $Paused,$k=0 ,$a=0

;$a = IniRead ( @ScriptDir & "\myfile.ini", "����", "����" ,"")
;��ʱ������һ����   7500��ͼƬ ��937�� �ֶ���4��

WinActivate ("Centaurus")

;��ʱ����ɱ����Լ5000��ͼƬ  ��1250��

$i = 0
Do
WinActivate ("Centaurus")
ControlClick ( "Centaurus", "�������", "TPanel226", "left", 2,349, 83)
sleep(1000)
ControlClick ( "Centaurus", "�������", "TPanel226", "left", 2,349, 83)
ControlClick ( "Centaurus", "�������", "TToolBar4", "left", 1,352, 10)
ControlClick ( "Centaurus", "�������", "TToolBar6", "left", 1,352, 10)
WinWait("ץ֡����", "ȡ��")
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "��(&N)") Then
     $a = IniRead ( @ScriptDir & "\��ʱ��������.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a,1)
	 winwait("Centaurus", "��(&N)")
	 WinActivate ("Centaurus", "��(&N)")
	 ControlClick ( "Centaurus", "��(&N)","[ID:7]" )
	 WinClose("ץ֡����","ȡ��")
	 ExitLoop
endif

If WinExists("Centaurus", "ȷ��") Then
     $a = IniRead ( @ScriptDir & "\��ʱ��������.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a,1)
	 winwait("Centaurus", "ȷ��")
	 WinActivate ("Centaurus", "ȷ��")
	 send("{Enter}")
	 WinClose("ץ֡����","ȡ��")
	 ExitLoop
elseif WinWaitClose ("ץ֡����", "OK") then
	$a = IniRead ( @ScriptDir & "\��ʱ��������.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\��ʱ��������.ini", "����", "����", $a+1) 
endif


ControlClick ( "Centaurus", "�������", "TPanel225", "left", 2,824, 83)
sleep(1000)
ControlClick ( "Centaurus", "�������", "TPanel225", "left", 2,824, 83)
ControlClick ( "Centaurus", "�������", "TToolBar4", "left", 1,352, 10)
ControlClick ( "Centaurus", "�������", "TToolBar6", "left", 1,352, 10)
WinWait("ץ֡����", "ȡ��")
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "��(&N)") Then
     $a = IniRead ( @ScriptDir & "\��ʱ��������.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a,1)
	 winwait("Centaurus", "��(&N)")
	 WinActivate ("Centaurus", "��(&N)")
	 ControlClick ( "Centaurus", "��(&N)","[ID:7]" )
	 WinClose("ץ֡����","ȡ��")
	 ExitLoop
endif

If WinExists("Centaurus", "ȷ��") Then
     $a = IniRead ( @ScriptDir & "\��ʱ��������.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a,1)
	 winwait("Centaurus", "ȷ��")
	 WinActivate ("Centaurus", "ȷ��")
	 send("{Enter}")
	 WinClose("ץ֡����","ȡ��")
	 ExitLoop
elseif WinWaitClose ("ץ֡����", "OK") then
	$a = IniRead ( @ScriptDir & "\��ʱ��������.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\��ʱ��������.ini", "����", "����", $a+1) 
endif

ControlClick ( "Centaurus", "�������", "TPanel223", "left", 2,824, 439)
sleep(1000)
ControlClick ( "Centaurus", "�������", "TPanel223", "left", 2,824, 439)
ControlClick ( "Centaurus", "�������", "TToolBar4", "left", 1,352, 10)
ControlClick ( "Centaurus", "�������", "TToolBar6", "left", 1,352, 10)
WinWait("ץ֡����", "ȡ��")
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "��(&N)") Then
     $a = IniRead ( @ScriptDir & "\��ʱ��������.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a,1)
	 winwait("Centaurus", "��(&N)")
	 WinActivate ("Centaurus", "��(&N)")
	 ControlClick ( "Centaurus", "��(&N)","[ID:7]" )
	 WinClose("ץ֡����","ȡ��")
	 ExitLoop
endif

If WinExists("Centaurus", "ȷ��") Then
     $a = IniRead ( @ScriptDir & "\��ʱ��������.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a,1)
	 winwait("Centaurus", "ȷ��")
	 WinActivate ("Centaurus", "ȷ��")
	 send("{Enter}")
	 WinClose("ץ֡����","ȡ��")
	 ExitLoop
elseif WinWaitClose ("ץ֡����", "OK") then
	$a = IniRead ( @ScriptDir & "\��ʱ��������.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\��ʱ��������.ini", "����", "����", $a+1) 
endif

ControlClick ( "Centaurus", "�������", "TPanel224", "left", 2,349, 439)
sleep(1000)
ControlClick ( "Centaurus", "�������", "TPanel224", "left", 2,349, 439)
ControlClick ( "Centaurus", "�������", "TToolBar4", "left", 1,352, 10)
ControlClick ( "Centaurus", "�������", "TToolBar6", "left", 1,352, 10)
WinWait("ץ֡����", "ȡ��")
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "��(&N)") Then
     $a = IniRead ( @ScriptDir & "\��ʱ��������.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a,1)
	 winwait("Centaurus", "��(&N)")
	 WinActivate ("Centaurus", "��(&N)")
	 ControlClick ( "Centaurus", "��(&N)","[ID:7]" )
	 WinClose("ץ֡����","ȡ��")
	 ExitLoop
endif

If WinExists("Centaurus", "ȷ��") Then
     $a = IniRead ( @ScriptDir & "\��ʱ��������.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a,1)
	 winwait("Centaurus", "ȷ��")
	 WinActivate ("Centaurus", "ȷ��")
	 send("{Enter}")
	 WinClose("ץ֡����","ȡ��")
	 ExitLoop
elseif WinWaitClose ("ץ֡����", "OK") then
	$a = IniRead ( @ScriptDir & "\��ʱ��������.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\��ʱ��������.ini", "����", "����", $a+1) 
endif


$i = $i + 1
Until $i = 937

$a = IniRead ( @ScriptDir & "\��ʱ��������.ini", "����", "����" ,"")
MsgBox ( 0, "����", "����:   "  &   $a )

Func Terminate()
	$a = IniRead ( @ScriptDir & "\��ʱ��������.ini", "����", "����" ,"")
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

;----------------------------------------------------------------
