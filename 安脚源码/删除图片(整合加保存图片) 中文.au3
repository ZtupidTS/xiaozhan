#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_outfile=..\..\���Խű�\ɾ��ͼƬ(���ϼӱ���ͼƬ) ����.exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")

;MouseClick ( "left" ,131, 202,1, 5) 
Local $m=0 ,$Paused 

$MSG=MsgBox ( 49, "ע��", "��ر�Ԥ�����ڲ������б�����")

Select

        Case $MSG=1

WinActivate ("Centaurus")
send("!v")
send("{down 3}")
send("{enter}")
ControlTreeView ("Centaurus", "�ڵ���֯��", "TTreeView4", "Expand", "sea")
BlockInput (1) 
MouseClickDrag ("left",65, 137,299, 192,$m)
MouseClickDrag ("left",66, 152,298, 275,$m)
BlockInput (0) 
ControlClick ( "Centaurus", "����(&S)", "TBitBtn1", "left", 1,35, 11)
Sleep(3000)
;228

$i = 0
Do

If Not FileExists("E:\CMSͼƬ������") Then
    DirCreate("E:\CMSͼƬ������")
EndIf

If Not FileExists("E:\CMSͼƬ������\228") Then
    DirCreate("E:\CMSͼƬ������\228")
EndIf

If Not FileExists(@ScriptDir & "\��������.ini") Then
    IniWrite(@ScriptDir & "\��������.ini", "����", "����", 1)
EndIf



$n = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
ControlClick ( "Centaurus", "�鿴ץ֡ͼƬ", "TToolBar6", "left", 1,13, 10)

WinWait("���Ϊ","",3)
If WinExists("���Ϊ") Then
;ControlClick ( "���Ϊ", "", "[ID:1148]", "left", 2)
Send("E:\CMSͼƬ������\228")
send("{enter}")
Sleep(1000)
Send($n)
Sleep(1000)
send("{enter}")
IniWrite(@ScriptDir & "\��������.ini", "����", "����", $n+1)

elseif Not WinExists("���Ϊ")  Then
	$n = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
	MsgBox ( 0, "����", "��������:   "  &  $n-1,1)
endif

Sleep(1000)
ControlClick ( "Centaurus", "�鿴ץ֡ͼƬ", "TToolBar6", "left", 1,210, 12)
Sleep(1000)
If  WinExists("Centaurus", "��(&Y)") Then
     send("{enter}")
	; $a = IniRead ( @ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����" ,"")
	 ;IniWrite(@ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����", $a+1) 
	$a = IniRead ( @ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����", $a+1) 
endif

Sleep(1000)

If  WinExists("Centaurus", "ȷ��") Then
	 send("{enter}")
elseif Not WinExists("Centaurus", "ȷ��")  then
	$a = IniRead ( @ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����" ,"")
	MsgBox ( 0, "����", "ɾ������:   "  &  $a,1)
	MouseClick( "right", 269, 256,1);( "Centaurus", "�鿴ץ֡ͼƬ", "TListView8", "right", 1,31, 15)
	send("{down}")
	send("{enter}")
	;MouseClickDrag ("left",35, 146,299, 192,$m)
	BlockInput (1) 
	MouseClickDrag ("left",66, 168,298, 275,$m)
	BlockInput (0) 
	ControlClick ( "Centaurus", "����(&S)", "TBitBtn1", "left", 1,35, 11)
	;ShellExecute("252.exe", "", @ScriptDir)	
	Exitloop
endif






$i = $i + 1
Until $i = 100000000


;252

$i = 0
Do
If Not FileExists("E:\CMSͼƬ������") Then
    DirCreate("E:\CMSͼƬ������")
EndIf

If Not FileExists("E:\CMSͼƬ������\252") Then
    DirCreate("E:\CMSͼƬ������\252")
EndIf	
	
$n = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
ControlClick ( "Centaurus", "�鿴ץ֡ͼƬ", "TToolBar6", "left", 1,13, 10)

WinWait("���Ϊ","",3)
If WinExists("���Ϊ") Then
;ControlClick ( "���Ϊ", "", "[ID:1148]", "left", 2)
Send("E:\CMSͼƬ������\252")
send("{enter}")
Sleep(1000)
Send($n)
Sleep(1000)
send("{enter}")
IniWrite(@ScriptDir & "\��������.ini", "����", "����", $n+1)

elseif Not WinExists("���Ϊ")  Then
	$n = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
	MsgBox ( 0, "����", "��������:   "  &  $n-1,1)
endif

Sleep(1000)
ControlClick ( "Centaurus", "�鿴ץ֡ͼƬ", "TToolBar6", "left", 1,210, 12)
Sleep(1000)
If  WinExists("Centaurus", "��(&Y)") Then
     send("{enter}")
	; $a = IniRead ( @ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����" ,"")
	; IniWrite(@ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����", $a+1) 
	$a = IniRead ( @ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����", $a+1) 
endif

Sleep(1000)

If  WinExists("Centaurus", "ȷ��") Then
	 send("{enter}")
elseif Not WinExists("Centaurus", "ȷ��")  then
	$a = IniRead ( @ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����" ,"")
	MsgBox ( 0, "����", "ɾ������:   "  &  $a,1)
	MouseClick( "right", 267, 258,1);( "Centaurus", "�鿴ץ֡ͼƬ", "TListView8", "right", 1,31, 15)
	send("{down}")
	send("{enter}")
	;MouseClickDrag ("left",35, 146,299, 192,$m)
	BlockInput (1) 
	MouseClickDrag ("left",66, 185,298, 275,0)
	BlockInput (0) 
	ControlClick ( "Centaurus", "����(&S)", "TBitBtn1", "left", 1,35, 11)
	;ShellExecute("208.exe", "", @ScriptDir)
	ExitLoop
endif





$i = $i + 1
Until $i = 100000000


;204
$i = 0
Do
If Not FileExists("E:\CMSͼƬ������") Then
    DirCreate("E:\CMSͼƬ������")
EndIf

If Not FileExists("E:\CMSͼƬ������\204") Then
    DirCreate("E:\CMSͼƬ������\204")
EndIf	
	
$n = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
ControlClick ( "Centaurus", "�鿴ץ֡ͼƬ", "TToolBar6", "left", 1,13, 10)

WinWait("���Ϊ","",3)
If WinExists("���Ϊ") Then
;ControlClick ( "���Ϊ", "", "[ID:1148]", "left", 2)
Send("E:\CMSͼƬ������\204")
send("{enter}")
Sleep(1000)
Send($n)
Sleep(1000)
send("{enter}")
IniWrite(@ScriptDir & "\��������.ini", "����", "����", $n+1)

elseif Not WinExists("���Ϊ")  Then
	$n = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
	MsgBox ( 0, "����", "��������:   "  &  $n-1,1)
endif

Sleep(1000)
ControlClick ( "Centaurus", "�鿴ץ֡ͼƬ", "TToolBar6", "left", 1,210, 12)
Sleep(1000)
If  WinExists("Centaurus", "��(&Y)") Then
     send("{enter}")
	 ;$a = IniRead ( @ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����" ,"")
	 ;IniWrite(@ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����", $a+1) 
	$a = IniRead ( @ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����", $a+1) 
endif

Sleep(1000)

If  WinExists("Centaurus", "ȷ��") Then
	 send("{enter}")
elseif Not WinExists("Centaurus", "ȷ��")  then
	$a = IniRead ( @ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����" ,"")
	MsgBox ( 0, "����", "ɾ������:   "  &  $a,1)
	MouseClick( "right", 269, 256,1);( "Centaurus", "�鿴ץ֡ͼƬ", "TListView8", "right", 1,31, 15)
	send("{down}")
	send("{enter}")
	;MouseClickDrag ("left",35, 146,299, 192,$m)
	BlockInput (1) 
	MouseClickDrag ("left",67, 201,298, 275,0)
	BlockInput (0) 
	ControlClick ( "Centaurus", "����(&S)", "TBitBtn1", "left", 1,35, 11)
	Exitloop
endif





$i = $i + 1
Until $i = 100000000


;208


$i = 0
Do
If Not FileExists("E:\CMSͼƬ������") Then
    DirCreate("E:\CMSͼƬ������")
EndIf

If Not FileExists("E:\CMSͼƬ������\208") Then
    DirCreate("E:\CMSͼƬ������\208")
EndIf	
	
$n = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
ControlClick ( "Centaurus", "�鿴ץ֡ͼƬ", "TToolBar6", "left", 1,13, 10)

WinWait("���Ϊ","",3)
If WinExists("���Ϊ") Then
;ControlClick ( "���Ϊ", "", "[ID:1148]", "left", 2)
Send("E:\CMSͼƬ������\208")
send("{enter}")
Sleep(1000)
Send($n)
Sleep(1000)
send("{enter}")
IniWrite(@ScriptDir & "\��������.ini", "����", "����", $n+1)

elseif Not WinExists("���Ϊ")  Then
	$n = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
	MsgBox ( 0, "����", "��������:   "  &  $n-1,1)
endif


Sleep(1000)
ControlClick ( "Centaurus", "�鿴ץ֡ͼƬ", "TToolBar6", "left", 1,210, 12)
Sleep(1000)
If  WinExists("Centaurus", "��(&Y)") Then
     send("{enter}")
	 ;$a = IniRead ( @ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����" ,"")
	 ;IniWrite(@ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����", $a+1) 
	$a = IniRead ( @ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����", $a+1) 
endif

Sleep(1000)

If  WinExists("Centaurus", "ȷ��") Then
	 send("{enter}")
elseif Not WinExists("Centaurus", "ȷ��")  then
	$a = IniRead ( @ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����" ,"")
	MsgBox ( 0, "����", "ɾ������:   "  &  $a,1)
	MouseClick( "right", 269, 256,1);( "Centaurus", "�鿴ץ֡ͼƬ", "TListView8", "right", 1,31, 15)
	send("{down}")
	send("{enter}")
	;MouseClickDrag ("left",35, 146,299, 192,$m)
	BlockInput (1) 
	MouseClickDrag ("left",68, 218,298, 275,0)
	BlockInput (0) 
	ControlClick ( "Centaurus", "����(&S)", "TBitBtn1", "left", 1,35, 11)
	ExitLoop
endif





$i = $i + 1
Until $i = 100000000

;206
$i = 0
Do
If Not FileExists("E:\CMSͼƬ������") Then
    DirCreate("E:\CMSͼƬ������")
EndIf

If Not FileExists("E:\CMSͼƬ������\203") Then
    DirCreate("E:\CMSͼƬ������\206")
EndIf	
	
$n = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
ControlClick ( "Centaurus", "�鿴ץ֡ͼƬ", "TToolBar6", "left", 1,13, 10)

WinWait("���Ϊ","",3)
If WinExists("���Ϊ") Then
;ControlClick ( "���Ϊ", "", "[ID:1148]", "left", 2)
Send("E:\CMSͼƬ������\206")
send("{enter}")
Sleep(1000)
Send($n)
Sleep(1000)
send("{enter}")
IniWrite(@ScriptDir & "\��������.ini", "����", "����", $n+1)

elseif Not WinExists("���Ϊ")  Then
	$n = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
	MsgBox ( 0, "����", "��������:   "  &  $n-1,1)
endif

Sleep(1000)
ControlClick ( "Centaurus", "�鿴ץ֡ͼƬ", "TToolBar6", "left", 1,210, 12)
Sleep(1000)
If  WinExists("Centaurus", "��(&Y)") Then
     send("{enter}")
	 ;$a = IniRead ( @ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����" ,"")
	 ;IniWrite(@ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����", $a+1) 
	$a = IniRead ( @ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����", $a+1) 
endif

Sleep(1000)

If  WinExists("Centaurus", "ȷ��") Then
	 send("{enter}")
elseif Not WinExists("Centaurus", "ȷ��")  then
	$a = IniRead ( @ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����" ,"")
	MsgBox ( 0, "����", "ɾ������:   "  &  $a)
	#cs
	MouseClick( "right", 269, 256,1);( "Centaurus", "�鿴ץ֡ͼƬ", "TListView8", "right", 1,31, 15)
	send("{down}")
	send("{enter}")
	;MouseClickDrag ("left",35, 146,299, 192,$m)
	BlockInput (1) 
	MouseClickDrag ("left",48, 213,298, 275,0)
	BlockInput (0) 
	ControlClick ( "Centaurus", "����(&S)", "TBitBtn1", "left", 1,35, 11)
	;ShellExecute("204.exe", "", @ScriptDir)
	#ce
	Exit 0
endif





$i = $i + 1
Until $i = 100000000


$n = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
	MsgBox ( 0, "����", "��������:   "  &  $n-1,1)
$a = IniRead ( @ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����" ,"")
    MsgBox ( 0, "����", "ɾ������:   "  &  $a)	
	
 Case $MSG=2

           Exit

        EndSelect	

Func Terminate()
    $a = IniRead ( @ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����" ,"")
	$n = IniRead ( @ScriptDir & "\��������.ini", "����", "����" ,"")
    MsgBox ( 0, "����", "ɾ������:   "  &  $a)	
	MsgBox ( 0, "����", "��������:   "  &  $n-1)
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