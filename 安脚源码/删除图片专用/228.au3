HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")

;MouseClick ( "left" ,131, 202,1, 5) 
Local $m=0 ,$Paused
WinActivate ("Centaurus")

send("!v")
send("{down 3}")
send("{enter}")
ControlTreeView ("Centaurus", "Nodes", "TTreeView4", "Expand", "sea")
MouseClickDrag ("left",35, 146,357, 200,$m)
MouseClickDrag ("left",65, 163,381, 260,$m)
ControlClick ( "Centaurus", "Search", "TBitBtn1", "left", 1,35, 11)


$i = 0
Do

ControlClick ( "Centaurus", "View capture frame", "TToolBar6", "left", 1,210, 12)
Sleep(1000)
If  WinExists("Centaurus", "��(&Y)") Then
     send("{enter}")
	; $a = IniRead ( @ScriptDir & "\sctpzs.ini", "����", "����" ,"")
	 ;IniWrite(@ScriptDir & "\sctpzs.ini", "����", "����", $a+1) 
	$a = IniRead ( "D:\�½��ļ���\��\sctpzs.ini", "����", "����" ,"")
	IniWrite( "D:\�½��ļ���\��\sctpzs.ini", "����", "����", $a+1) 
endif

Sleep(1000)

If  WinExists("Centaurus", "ȷ��") Then
	 send("{enter}")
elseif Not WinExists("Centaurus", "ȷ��")  then
	$a = IniRead ( "D:\�½��ļ���\��\sctpzs.ini", "����", "����" ,"")
	MsgBox ( 0, "����", "����:   "  &  $a,1)
	MouseClick( "right", 315, 257,1);( "Centaurus", "View capture frame", "TListView8", "right", 1,31, 15)
	send("{down}")
	send("{enter}")
	;MouseClickDrag ("left",35, 146,357, 200,$m)
	MouseClickDrag ("left",47, 178,381, 260,$m)
	ControlClick ( "Centaurus", "Search", "TBitBtn1", "left", 1,35, 11)
	ShellExecute("252.exe", "", @ScriptDir)	
	Exit 0
endif


Sleep(1000)



$i = $i + 1
Until $i = 100000000



Func Terminate()
    $a = IniRead ( "D:\�½��ļ���\��\sctpzs.ini", "����", "����" ,"")
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
