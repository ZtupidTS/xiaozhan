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
MouseClick ( "left" , 474, 121, 1, $k)
WinWait("Image saving", "Cancel")
send("{Enter}")
sleep(1500)



If WinExists("Centaurus", "ȷ��") Then
     $a = IniRead ( @ScriptDir & "\myfile.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a)
elseif WinWaitClose ("Image saving", "OK") then
	$a = IniRead ( @ScriptDir & "\myfile.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\myfile.ini", "����", "����", $a+1) 
endif


MouseClick ( "left" , 964, 323, 1, $k)
MouseClick ( "left" , 474, 121, 1, $k)
WinWait("Image saving", "Cancel")
send("{Enter}")
sleep(1500)



If WinExists("Centaurus", "ȷ��") Then
     $a = IniRead ( @ScriptDir & "\myfile.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a)
elseif WinWaitClose ("Image saving", "OK") then
	$a = IniRead ( @ScriptDir & "\myfile.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\myfile.ini", "����", "����", $a+1) 
endif

MouseClick ( "left" , 1133, 732, 1, $k)
MouseClick ( "left" , 474, 121, 1, $k)
WinWait("Image saving", "Cancel")
send("{Enter}")
sleep(1500)



If WinExists("Centaurus", "ȷ��") Then
     $a = IniRead ( @ScriptDir & "\myfile.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a)
elseif WinWaitClose ("Image saving", "OK") then
	$a = IniRead ( @ScriptDir & "\myfile.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\myfile.ini", "����", "����", $a+1) 
endif

MouseClick ( "left" , 512, 724, 1, $k)
MouseClick ( "left" , 474, 121, 1, $k)
WinWait("Image saving", "Cancel")
send("{Enter}")
sleep(1500)


If WinExists("Centaurus", "ȷ��") Then
     $a = IniRead ( @ScriptDir & "\myfile.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a)
elseif WinWaitClose ("Image saving", "OK") then
	$a = IniRead ( @ScriptDir & "\myfile.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\myfile.ini", "����", "����", $a+1) 
endif

;----------------------------------------------------------------

;��������ɱ����Լ2500��ͼƬ    ��625��



MouseClick ( "left" , 505, 391, 1, $k)
MouseClick ( "left" , 474, 121, 1, $k)
winwait("Image saving","OK")
ControlClick ( "Image saving", "", "[CLASS:TComboBox; INSTANCE:1]","left", 1, 37, 7)
send("{down}")
send("{Enter}")
sleep(3000)
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "ȷ��") Then
     $a = IniRead ( @ScriptDir & "\myfile.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a)
elseif WinWaitClose ("Image saving", "OK") then
	$a = IniRead ( @ScriptDir & "\myfile.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\myfile.ini", "����", "����", $a+1) 
endif

MouseClick ( "left" , 964, 323, 1, $k)
MouseClick ( "left" , 474, 121, 1, $k)
winwait("Image saving","OK")
ControlClick ( "Image saving", "", "[CLASS:TComboBox; INSTANCE:1]","left", 1, 37, 7)
send("{down}")
send("{Enter}")
sleep(3000)
send("{Enter}")
sleep(1500)


If WinExists("Centaurus", "ȷ��") Then
     $a = IniRead ( @ScriptDir & "\myfile.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a)
elseif WinWaitClose ("Image saving", "OK") then
	$a = IniRead ( @ScriptDir & "\myfile.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\myfile.ini", "����", "����", $a+1) 
endif

MouseClick ( "left" , 1133, 732, 1, $k)
MouseClick ( "left" , 474, 121, 1, $k)
winwait("Image saving","OK")
ControlClick ( "Image saving", "", "[CLASS:TComboBox; INSTANCE:1]","left", 1, 37, 7)
send("{down}")
send("{Enter}")
sleep(3000)
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "ȷ��") Then
     $a = IniRead ( @ScriptDir & "\myfile.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a)
elseif WinWaitClose ("Image saving", "OK") then
	$a = IniRead ( @ScriptDir & "\myfile.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\myfile.ini", "����", "����", $a+1) 
endif

MouseClick ( "left" , 512, 724, 1, $k)
MouseClick ( "left" , 474, 121, 1, $k)
winwait("Image saving","OK")
ControlClick ( "Image saving", "", "[CLASS:TComboBox; INSTANCE:1]","left", 1, 37, 7)
send("{down}")
send("{Enter}")
sleep(3000)
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "ȷ��") Then
     $a = IniRead ( @ScriptDir & "\myfile.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a)
elseif WinWaitClose ("Image saving", "OK") then
	$a = IniRead ( @ScriptDir & "\myfile.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\myfile.ini", "����", "����", $a+1) 
endif

$i = $i + 1
Until $i = 937

$a = IniRead ( @ScriptDir & "\myfile.ini", "����", "����" ,"")
MsgBox ( 0, "����", "����:   "  &   $a )

Func Terminate()
	$a = IniRead ( @ScriptDir & "\sctpzs.ini", "����", "����" ,"")
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