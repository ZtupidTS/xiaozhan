#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_outfile=..\..\���Խű�\ɾ��ͼƬ(����)����.exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")

;MouseClick ( "left" ,131, 202,1, 5) 
Local $m=0 ,$Paused
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

;228
$i = 0
Do

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
	MouseClickDrag ("left",66, 184,298, 275,0)
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


$a = $a = IniRead ( @ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����" ,"")
    MsgBox ( 0, "����", "ɾ������:   "  &  $a)	

Func Terminate()
    $a = IniRead ( @ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����" ,"")
    MsgBox ( 0, "����", "ɾ������:   "  &  $a)	
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