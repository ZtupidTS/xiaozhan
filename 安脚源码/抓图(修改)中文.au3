#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_outfile=..\..\���Խű�\ץͼ(�޸�)����.exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")
Local $Paused,$k=0 ,$a=0

;$a = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
;��ʱ������һ����   7500��ͼƬ ��937�� �ֶ���4��

WinActivate ("Centaurus")

;��ʱ����ɱ����Լ5000��ͼƬ  ��1250��

$i = 0
Do
WinActivate ("Centaurus")
;MouseClick ( "left" , 505, 377, 1, $k)
ControlClick ( "Centaurus", "�������", "TPanel226", "left", 2,349, 83)
sleep(1000)
ControlClick ( "Centaurus", "�������", "TPanel226", "left", 2,349, 83)
ControlClick ( "Centaurus", "�������", "TToolBar6", "left", 1,352, 10)
WinWait("ץ֡����", "ȡ��")
send("{Enter}")
sleep(1500)



If WinExists("Centaurus", "ȷ��") Then
     $a = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a)
elseif WinWaitClose ("ץ֡����", "ȷ��") then
	$a = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\��������.ini", "����", "����", $a+1) 
endif

ControlClick ( "Centaurus", "�������", "TPanel225", "left", 2,824, 83)
sleep(1000)
ControlClick ( "Centaurus", "�������", "TPanel225", "left", 2,824, 83)
;MouseClick ( "left" , 1080, 410, 1, $k)
ControlClick ( "Centaurus", "�������", "TToolBar6", "left", 1,352, 10)
WinWait("ץ֡����", "ȡ��")
send("{Enter}")
sleep(1500)



If WinExists("Centaurus", "ȷ��") Then
     $a = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a)
elseif WinWaitClose ("ץ֡����", "ȷ��") then
	$a = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\��������.ini", "����", "����", $a+1) 
endif

ControlClick ( "Centaurus", "�������", "TPanel223", "left", 2,824, 439)
sleep(1000)
ControlClick ( "Centaurus", "�������", "TPanel223", "left", 2,824, 439)
;MouseClick ( "left" , 1050, 768, 1, $k)
ControlClick ( "Centaurus", "�������", "TToolBar6", "left", 1,352, 10)
WinWait("ץ֡����", "ȡ��")
send("{Enter}")
sleep(1500)



If WinExists("Centaurus", "ȷ��") Then
     $a = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a)
elseif WinWaitClose ("ץ֡����", "ȷ��") then
	$a = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\��������.ini", "����", "����", $a+1) 
endif


ControlClick ( "Centaurus", "�������", "TPanel224", "left", 2,349, 439)
sleep(1000)
ControlClick ( "Centaurus", "�������", "TPanel224", "left", 2,349, 439)
;MouseClick ( "left" , 501, 759, 1, $k)
ControlClick ( "Centaurus", "�������", "TToolBar6", "left", 1,352, 10)
WinWait("ץ֡����", "ȡ��")
send("{Enter}")
sleep(1500)


If WinExists("Centaurus", "ȷ��") Then
     $a = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a)
elseif WinWaitClose ("ץ֡����", "ȷ��") then
	$a = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\��������.ini", "����", "����", $a+1) 
endif

;----------------------------------------------------------------

;��������ɱ����Լ2500��ͼƬ    ��625��



;MouseClick ( "left" , 505, 377, 1, $k)
ControlClick ( "Centaurus", "�������", "TPanel226", "left", 2,252, 205)
sleep(1000)
ControlClick ( "Centaurus", "�������", "TPanel226", "left", 2,252, 205)
ControlClick ( "Centaurus", "�������", "TToolBar6", "left", 1,352, 10)
winwait("ץ֡����","ȷ��")
ControlClick ( "ץ֡����", "", "[CLASS:TComboBox; INSTANCE:1]","left", 1, 37, 7)
send("{down}")
send("{Enter}")
sleep(3000)
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "ȷ��") Then
     $a = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a)
elseif WinWaitClose ("ץ֡����", "ȷ��") then
	$a = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\��������.ini", "����", "����", $a+1) 
endif

;MouseClick ( "left" , 1080, 410, 1, $k)
ControlClick ( "Centaurus", "�������", "TPanel225", "left", 2,258, 204)
sleep(1000)
ControlClick ( "Centaurus", "�������", "TPanel225", "left", 2,258, 204)
ControlClick ( "Centaurus", "�������", "TToolBar6", "left", 1,352, 10)
winwait("ץ֡����","ȷ��")
ControlClick ( "ץ֡����", "", "[CLASS:TComboBox; INSTANCE:1]","left", 1, 37, 7)
send("{down}")
send("{Enter}")
sleep(3000)
send("{Enter}")
sleep(1500)


If WinExists("Centaurus", "ȷ��") Then
     $a = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a)
elseif WinWaitClose ("ץ֡����", "ȷ��") then
	$a = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\��������.ini", "����", "����", $a+1) 
endif

;MouseClick ( "left" , 1050, 768, 1, $k)
ControlClick ( "Centaurus", "�������", "TPanel224", "left", 2,246, 204)
sleep(1000)
ControlClick ( "Centaurus", "�������", "TPanel224", "left", 2,246, 204)
ControlClick ( "Centaurus", "�������", "TToolBar6", "left", 1,352, 10)
winwait("ץ֡����","ȷ��")
ControlClick ( "ץ֡����", "", "[CLASS:TComboBox; INSTANCE:1]","left", 1, 37, 7)
send("{down}")
send("{Enter}")
sleep(3000)
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "ȷ��") Then
     $a = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a)
elseif WinWaitClose ("ץ֡����", "ȷ��") then
	$a = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\��������.ini", "����", "����", $a+1) 
endif

;MouseClick ( "left" ,  501, 759, 1, $k)
ControlClick ( "Centaurus", "�������", "TPanel223", "left", 2,326, 197)
sleep(1000)
ControlClick ( "Centaurus", "�������", "TPanel223", "left", 2,326, 197)
ControlClick ( "Centaurus", "�������", "TToolBar6", "left", 1,352, 10)
winwait("ץ֡����","ȷ��")
ControlClick ( "ץ֡����", "", "[CLASS:TComboBox; INSTANCE:1]","left", 1, 37, 7)
send("{down}")
send("{Enter}")
sleep(3000)
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "ȷ��") Then
     $a = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
     MsgBox ( 0, "����", "����:   "  &  $a)
elseif WinWaitClose ("ץ֡����", "ȷ��") then
	$a = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\��������.ini", "����", "����", $a+1) 
endif

$i = $i + 1
Until $i = 937

$a = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
MsgBox ( 0, "����", "����:   "  &   $a )

Func Terminate()
	$a = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
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