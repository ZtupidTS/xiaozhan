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
;MouseClick ( "left" , 505, 377, 1, $k)
ControlClick ( "Centaurus", "Net preview", "TPanel225", "left", 2,252, 205)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TPanel225", "left", 2,252, 205)
ControlClick ( "Centaurus", "Net preview", "TToolBar6", "left", 1,211, 11)
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

ControlClick ( "Centaurus", "Net preview", "TPanel224", "left", 2,258, 204)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TPanel224", "left", 2,258, 204)
;MouseClick ( "left" , 1080, 410, 1, $k)
ControlClick ( "Centaurus", "Net preview", "TToolBar6", "left", 1,211, 11)
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

ControlClick ( "Centaurus", "Net preview", "TPanel223", "left", 2,246, 204)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TPanel223", "left", 2,246, 204)
;MouseClick ( "left" , 1050, 768, 1, $k)
ControlClick ( "Centaurus", "Net preview", "TToolBar6", "left", 1,211, 11)
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


ControlClick ( "Centaurus", "Net preview", "TPanel222", "left", 2,326, 197)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TPanel222", "left", 2,326, 197)
;MouseClick ( "left" , 501, 759, 1, $k)
ControlClick ( "Centaurus", "Net preview", "TToolBar6", "left", 1,211, 11)
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



;MouseClick ( "left" , 505, 377, 1, $k)
ControlClick ( "Centaurus", "Net preview", "TPanel225", "left", 2,252, 205)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TPanel225", "left", 2,252, 205)
ControlClick ( "Centaurus", "Net preview", "TToolBar6", "left", 1,211, 11)
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

;MouseClick ( "left" , 1080, 410, 1, $k)
ControlClick ( "Centaurus", "Net preview", "TPanel224", "left", 2,258, 204)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TPanel224", "left", 2,258, 204)
ControlClick ( "Centaurus", "Net preview", "TToolBar6", "left", 1,211, 11)
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

;MouseClick ( "left" , 1050, 768, 1, $k)
ControlClick ( "Centaurus", "Net preview", "TPanel223", "left", 2,246, 204)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TPanel223", "left", 2,246, 204)
ControlClick ( "Centaurus", "Net preview", "TToolBar6", "left", 1,211, 11)
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

;MouseClick ( "left" ,  501, 759, 1, $k)
ControlClick ( "Centaurus", "Net preview", "TPanel222", "left", 2,326, 197)
sleep(1000)
ControlClick ( "Centaurus", "Net preview", "TPanel222", "left", 2,326, 197)
ControlClick ( "Centaurus", "Net preview", "TToolBar6", "left", 1,211, 11)
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