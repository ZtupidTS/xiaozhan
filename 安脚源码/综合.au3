HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")
Local $j=3 ,$k=0,$l=5,$m=0,$Paused 
$i = 0
Do

WinActivate ("Centaurus")
;˫���Ŵ���С����
MouseClick ( "left" , 321, 62, 2, $j)
winwait("Centaurus","Ok")
send("{Enter}")
MouseClick ( "left" , 505, 391, 2, $j)
MouseClick ( "left" , 505, 391, 2, $j)
MouseClick ( "right" , 505, 391, 1, $j)
MouseClick ( "right" , 432, 215, 1, $j)
MouseClick ( "right" , 432, 215, 1, $j)
MouseClick ( "left" , 591, 101, 2, $j)


MouseClick ( "left" , 964, 323, 2, $j)
MouseClick ( "left" , 964, 323, 2, $j)
MouseClick ( "right" , 964, 323, 1, $j)
MouseClick ( "right" , 703, 197, 1, $j)
MouseClick ( "right" , 703, 197, 1, $j)
MouseClick ( "left" , 591, 101, 2, $j)


MouseClick ( "left" , 1133, 732, 2, $j)
MouseClick ( "left" , 1133, 732, 2, $j)
MouseClick ( "right" , 1133, 732, 1, $j)
MouseClick ( "right" , 693, 432, 1, $j)
MouseClick ( "right" , 693, 432, 1, $j)
MouseClick ( "left" , 591, 101, 2, $j)


MouseClick ( "left" , 512, 724, 2, $j)
MouseClick ( "left" , 512, 724, 2, $j)
MouseClick ( "right" , 512, 724, 1, $j)
MouseClick ( "right" , 430, 415, 1, $j)
MouseClick ( "right" , 430, 415, 1, $j)
MouseClick ( "left" , 591, 101, 2, $j)

;�����ק����

MouseClickDrag ("left",744, 527,784, 535,$m)
MouseClickDrag ("left",784, 535,790, 575,$m)
MouseClickDrag ("left",790, 575,748, 575,$m)
MouseClickDrag ("left",748, 575,744, 527,$m)

;�򿪹ر���Ƶ����
WinActivate ("Centaurus")

MouseClick ( "left" , 505, 391, 1, $l)
MouseClick ( "left" , 411, 120, 1, $l)

MouseClick ( "left" , 964, 323, 1, $l)
MouseClick ( "left" , 411, 120, 1, $l)

MouseClick ( "left" , 1133, 732, 1, $l)
MouseClick ( "left" , 411, 120, 1, $l)

MouseClick ( "left" , 512, 724, 1, $l)
MouseClick ( "left" , 411, 120, 1, $l)

;---------------------
MouseClick ( "left" , 505, 391, 1, $l)
MouseClick ( "left" , 384, 119, 1, $l)

MouseClick ( "left" , 964, 323, 1, $l)
MouseClick ( "left" , 384, 119, 1, $l)

MouseClick ( "left" , 1133, 732, 1, $l)
MouseClick ( "left" , 384, 119, 1, $l)

MouseClick ( "left" , 512, 724, 1, $l)
MouseClick ( "left" , 384, 119, 1, $l)
sleep(2000)
;----------------
MouseClick ( "left" , 351, 121, 1, $l)
sleep(2000)
MouseClick ( "left" , 322, 120, 1, $l)
sleep(4000)


;ץͼ
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
     $a = IniRead ( @ScriptDir & "\myfile.ini", "����", "����" ,"")
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