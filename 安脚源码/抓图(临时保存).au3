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
MouseClick ( "left" , 505, 391, 1, $k)
ControlClick ( "Centaurus", "Net preview", "TToolBar4", "left", 1,211, 11)
ControlClick ( "Centaurus", "Net preview", "TToolBar6", "left", 1,211, 11)
WinWait("Image saving", "Cancel")
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "��(&N)") Then
     $a = IniRead ( @ScriptDir & "\lsbc.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a,1)
	 winwait("Centaurus", "��(&N)")
	 WinActivate ("Centaurus", "��(&N)")
	 ControlClick ( "Centaurus", "��(&N)","[ID:7]" )
	 WinClose("Image saving","Cancel")
	 ExitLoop
endif

If WinExists("Centaurus", "ȷ��") Then
     $a = IniRead ( @ScriptDir & "\lsbc.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a,1)
	 winwait("Centaurus", "ȷ��")
	 WinActivate ("Centaurus", "ȷ��")
	 send("{Enter}")
	 WinClose("Image saving","Cancel")
	 ExitLoop
elseif WinWaitClose ("Image saving", "OK") then
	$a = IniRead ( @ScriptDir & "\lsbc.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\lsbc.ini", "����", "����", $a+1) 
endif


MouseClick ( "left" , 964, 323, 1, $k)
ControlClick ( "Centaurus", "Net preview", "TToolBar4", "left", 1,211, 11)
ControlClick ( "Centaurus", "Net preview", "TToolBar6", "left", 1,211, 11)
WinWait("Image saving", "Cancel")
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "��(&N)") Then
     $a = IniRead ( @ScriptDir & "\lsbc.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a,1)
	 winwait("Centaurus", "��(&N)")
	 WinActivate ("Centaurus", "��(&N)")
	 ControlClick ( "Centaurus", "��(&N)","[ID:7]" )
	 WinClose("Image saving","Cancel")
	 ExitLoop
endif

If WinExists("Centaurus", "ȷ��") Then
     $a = IniRead ( @ScriptDir & "\lsbc.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a,1)
	 winwait("Centaurus", "ȷ��")
	 WinActivate ("Centaurus", "ȷ��")
	 send("{Enter}")
	 WinClose("Image saving","Cancel")
	 ExitLoop
elseif WinWaitClose ("Image saving", "OK") then
	$a = IniRead ( @ScriptDir & "\lsbc.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\lsbc.ini", "����", "����", $a+1) 
endif

MouseClick ( "left" , 1133, 732, 1, $k)
ControlClick ( "Centaurus", "Net preview", "TToolBar4", "left", 1,211, 11)
ControlClick ( "Centaurus", "Net preview", "TToolBar6", "left", 1,211, 11)
WinWait("Image saving", "Cancel")
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "��(&N)") Then
     $a = IniRead ( @ScriptDir & "\lsbc.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a,1)
	 winwait("Centaurus", "��(&N)")
	 WinActivate ("Centaurus", "��(&N)")
	 ControlClick ( "Centaurus", "��(&N)","[ID:7]" )
	 WinClose("Image saving","Cancel")
	 ExitLoop
endif

If WinExists("Centaurus", "ȷ��") Then
     $a = IniRead ( @ScriptDir & "\lsbc.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a,1)
	 winwait("Centaurus", "ȷ��")
	 WinActivate ("Centaurus", "ȷ��")
	 send("{Enter}")
	 WinClose("Image saving","Cancel")
	 ExitLoop
elseif WinWaitClose ("Image saving", "OK") then
	$a = IniRead ( @ScriptDir & "\lsbc.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\lsbc.ini", "����", "����", $a+1) 
endif

MouseClick ( "left" , 512, 724, 1, $k)
ControlClick ( "Centaurus", "Net preview", "TToolBar4", "left", 1,211, 11)
ControlClick ( "Centaurus", "Net preview", "TToolBar6", "left", 1,211, 11)
WinWait("Image saving", "Cancel")
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "��(&N)") Then
     $a = IniRead ( @ScriptDir & "\lsbc.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a,1)
	 winwait("Centaurus", "��(&N)")
	 WinActivate ("Centaurus", "��(&N)")
	 ControlClick ( "Centaurus", "��(&N)","[ID:7]" )
	 WinClose("Image saving","Cancel")
	 ExitLoop
endif

If WinExists("Centaurus", "ȷ��") Then
     $a = IniRead ( @ScriptDir & "\lsbc.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a,1)
	 winwait("Centaurus", "ȷ��")
	 WinActivate ("Centaurus", "ȷ��")
	 send("{Enter}")
	 WinClose("Image saving","Cancel")
	 ExitLoop
elseif WinWaitClose ("Image saving", "OK") then
	$a = IniRead ( @ScriptDir & "\lsbc.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\lsbc.ini", "����", "����", $a+1) 
endif


$i = $i + 1
Until $i = 937

$a = IniRead ( @ScriptDir & "\lsbc.ini", "����", "����" ,"")
MsgBox ( 0, "����", "����:   "  &   $a )

Func Terminate()
	$a = IniRead ( @ScriptDir & "\lsbc.ini", "����", "����" ,"")
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
