HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")

;MouseClick ( "left" ,131, 202,1, 5) 
Local $m=0 ,$Paused 

$MSG=MsgBox ( 49, "注意", "请关闭预览窗口才能运行本程序")

Select

        Case $MSG=1

WinActivate ("Centaurus")
send("!v")
send("{down 3}")
send("{enter}")
ControlTreeView ("Centaurus", "Nodes", "TTreeView4", "Expand", "sea")
BlockInput (1) 
MouseClickDrag ("left",35, 146,357, 200,$m)
MouseClickDrag ("left",65, 163,381, 260,$m)
BlockInput (0) 
ControlClick ( "Centaurus", "Search", "TBitBtn1", "left", 1,35, 11)
Sleep(3000)
;228

$i = 0
Do

If Not FileExists("E:\CMS图片保存区") Then
    DirCreate("E:\CMS图片保存区")
EndIf

If Not FileExists("E:\CMS图片保存区\228") Then
    DirCreate("E:\CMS图片保存区\228")
EndIf

If Not FileExists(@ScriptDir & "\bczs.ini") Then
    IniWrite(@ScriptDir & "\bczs.ini", "计数", "张数", 1)
EndIf



$n = IniRead ( @ScriptDir & "\bczs.ini", "计数", "张数" ,"")
ControlClick ( "Centaurus", "View capture frame", "TToolBar6", "left", 1,13, 10)

WinWait("另存为","",3)
If WinExists("另存为") Then
;ControlClick ( "另存为", "", "[ID:1148]", "left", 2)
Send("E:\CMS图片保存区\228")
send("{enter}")
Sleep(1000)
Send($n)
Sleep(1000)
send("{enter}")
IniWrite(@ScriptDir & "\bczs.ini", "计数", "张数", $n+1)

elseif Not WinExists("另存为")  Then
	$n = IniRead ( @ScriptDir & "\bczs.ini", "计数", "张数" ,"")
	MsgBox ( 0, "计数", "保存张数:   "  &  $n-1,1)
endif

Sleep(1000)
ControlClick ( "Centaurus", "View capture frame", "TToolBar6", "left", 1,210, 12)
Sleep(1000)
If  WinExists("Centaurus", "是(&Y)") Then
     send("{enter}")
	; $a = IniRead ( @ScriptDir & "\sctpzs.ini", "计数", "张数" ,"")
	 ;IniWrite(@ScriptDir & "\sctpzs.ini", "计数", "张数", $a+1) 
	$a = IniRead ( @ScriptDir & "\sctpzs.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\sctpzs.ini", "计数", "张数", $a+1) 
endif

Sleep(1000)

If  WinExists("Centaurus", "确定") Then
	 send("{enter}")
elseif Not WinExists("Centaurus", "确定")  then
	$a = IniRead ( @ScriptDir & "\sctpzs.ini", "计数", "张数" ,"")
	MsgBox ( 0, "计数", "删除张数:   "  &  $a,1)
	MouseClick( "right", 315, 257,1);( "Centaurus", "View capture frame", "TListView8", "right", 1,31, 15)
	send("{down}")
	send("{enter}")
	;MouseClickDrag ("left",35, 146,357, 200,$m)
	BlockInput (1) 
	MouseClickDrag ("left",66, 180,381, 260,$m)
	BlockInput (0) 
	ControlClick ( "Centaurus", "Search", "TBitBtn1", "left", 1,35, 11)
	;ShellExecute("252.exe", "", @ScriptDir)	
	Exitloop
endif


Sleep(1000)



$i = $i + 1
Until $i = 100000000


;252

$i = 0
Do
If Not FileExists("E:\CMS图片保存区") Then
    DirCreate("E:\CMS图片保存区")
EndIf

If Not FileExists("E:\CMS图片保存区\252") Then
    DirCreate("E:\CMS图片保存区\252")
EndIf	
	
$n = IniRead ( @ScriptDir & "\bczs.ini", "计数", "张数" ,"")
ControlClick ( "Centaurus", "View capture frame", "TToolBar6", "left", 1,13, 10)

WinWait("另存为","",3)
If WinExists("另存为") Then
;ControlClick ( "另存为", "", "[ID:1148]", "left", 2)
Send("E:\CMS图片保存区\252")
send("{enter}")
Sleep(1000)
Send($n)
Sleep(1000)
send("{enter}")
IniWrite(@ScriptDir & "\bczs.ini", "计数", "张数", $n+1)

elseif Not WinExists("另存为")  Then
	$n = IniRead ( @ScriptDir & "\bczs.ini", "计数", "张数" ,"")
	MsgBox ( 0, "计数", "保存张数:   "  &  $n-1,1)
endif

Sleep(1000)
ControlClick ( "Centaurus", "View capture frame", "TToolBar6", "left", 1,210, 12)
Sleep(1000)
If  WinExists("Centaurus", "是(&Y)") Then
     send("{enter}")
	; $a = IniRead ( @ScriptDir & "\sctpzs.ini", "计数", "张数" ,"")
	; IniWrite(@ScriptDir & "\sctpzs.ini", "计数", "张数", $a+1) 
	$a = IniRead ( @ScriptDir & "\sctpzs.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\sctpzs.ini", "计数", "张数", $a+1) 
endif

Sleep(1000)

If  WinExists("Centaurus", "确定") Then
	 send("{enter}")
elseif Not WinExists("Centaurus", "确定")  then
	$a = IniRead ( @ScriptDir & "\sctpzs.ini", "计数", "张数" ,"")
	MsgBox ( 0, "计数", "删除张数:   "  &  $a,1)
	MouseClick( "right", 315, 257,1);( "Centaurus", "View capture frame", "TListView8", "right", 1,31, 15)
	send("{down}")
	send("{enter}")
	;MouseClickDrag ("left",35, 146,357, 200,$m)
	BlockInput (1) 
	MouseClickDrag ("left",66, 195,325, 269,0)
	BlockInput (0) 
	ControlClick ( "Centaurus", "Search", "TBitBtn1", "left", 1,35, 11)
	;ShellExecute("208.exe", "", @ScriptDir)
	ExitLoop
endif


Sleep(1000)


$i = $i + 1
Until $i = 100000000


;204
$i = 0
Do
If Not FileExists("E:\CMS图片保存区") Then
    DirCreate("E:\CMS图片保存区")
EndIf

If Not FileExists("E:\CMS图片保存区\204") Then
    DirCreate("E:\CMS图片保存区\204")
EndIf	
	
$n = IniRead ( @ScriptDir & "\bczs.ini", "计数", "张数" ,"")
ControlClick ( "Centaurus", "View capture frame", "TToolBar6", "left", 1,13, 10)

WinWait("另存为","",3)
If WinExists("另存为") Then
;ControlClick ( "另存为", "", "[ID:1148]", "left", 2)
Send("E:\CMS图片保存区\204")
send("{enter}")
Sleep(1000)
Send($n)
Sleep(1000)
send("{enter}")
IniWrite(@ScriptDir & "\bczs.ini", "计数", "张数", $n+1)

elseif Not WinExists("另存为")  Then
	$n = IniRead ( @ScriptDir & "\bczs.ini", "计数", "张数" ,"")
	MsgBox ( 0, "计数", "保存张数:   "  &  $n-1,1)
endif

Sleep(1000)
ControlClick ( "Centaurus", "View capture frame", "TToolBar6", "left", 1,210, 12)
Sleep(1000)
If  WinExists("Centaurus", "是(&Y)") Then
     send("{enter}")
	 ;$a = IniRead ( @ScriptDir & "\sctpzs.ini", "计数", "张数" ,"")
	 ;IniWrite(@ScriptDir & "\sctpzs.ini", "计数", "张数", $a+1) 
	$a = IniRead ( @ScriptDir & "\sctpzs.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\sctpzs.ini", "计数", "张数", $a+1) 
endif

Sleep(1000)

If  WinExists("Centaurus", "确定") Then
	 send("{enter}")
elseif Not WinExists("Centaurus", "确定")  then
	$a = IniRead ( @ScriptDir & "\sctpzs.ini", "计数", "张数" ,"")
	MsgBox ( 0, "计数", "删除张数:   "  &  $a,1)
	MouseClick( "right", 315, 257,1);( "Centaurus", "View capture frame", "TListView8", "right", 1,31, 15)
	send("{down}")
	send("{enter}")
	;MouseClickDrag ("left",35, 146,357, 200,$m)
	BlockInput (1) 
	MouseClickDrag ("left",67, 211,325, 269,0)
	BlockInput (0) 
	ControlClick ( "Centaurus", "Search", "TBitBtn1", "left", 1,35, 11)
	Exitloop
endif


Sleep(1000)


$i = $i + 1
Until $i = 100000000


;208


$i = 0
Do
If Not FileExists("E:\CMS图片保存区") Then
    DirCreate("E:\CMS图片保存区")
EndIf

If Not FileExists("E:\CMS图片保存区\208") Then
    DirCreate("E:\CMS图片保存区\208")
EndIf	
	
$n = IniRead ( @ScriptDir & "\bczs.ini", "计数", "张数" ,"")
ControlClick ( "Centaurus", "View capture frame", "TToolBar6", "left", 1,13, 10)

WinWait("另存为","",3)
If WinExists("另存为") Then
;ControlClick ( "另存为", "", "[ID:1148]", "left", 2)
Send("E:\CMS图片保存区\208")
send("{enter}")
Sleep(1000)
Send($n)
Sleep(1000)
send("{enter}")
IniWrite(@ScriptDir & "\bczs.ini", "计数", "张数", $n+1)

elseif Not WinExists("另存为")  Then
	$n = IniRead ( @ScriptDir & "\bczs.ini", "计数", "张数" ,"")
	MsgBox ( 0, "计数", "保存张数:   "  &  $n-1,1)
endif


Sleep(1000)
ControlClick ( "Centaurus", "View capture frame", "TToolBar6", "left", 1,210, 12)
Sleep(1000)
If  WinExists("Centaurus", "是(&Y)") Then
     send("{enter}")
	 ;$a = IniRead ( @ScriptDir & "\sctpzs.ini", "计数", "张数" ,"")
	 ;IniWrite(@ScriptDir & "\sctpzs.ini", "计数", "张数", $a+1) 
	$a = IniRead ( @ScriptDir & "\sctpzs.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\sctpzs.ini", "计数", "张数", $a+1) 
endif

Sleep(1000)

If  WinExists("Centaurus", "确定") Then
	 send("{enter}")
elseif Not WinExists("Centaurus", "确定")  then
	$a = IniRead ( @ScriptDir & "\sctpzs.ini", "计数", "张数" ,"")
	MsgBox ( 0, "计数", "删除张数:   "  &  $a,1)
	MouseClick( "right", 315, 257,1);( "Centaurus", "View capture frame", "TListView8", "right", 1,31, 15)
	send("{down}")
	send("{enter}")
	;MouseClickDrag ("left",35, 146,357, 200,$m)
	BlockInput (1) 
	MouseClickDrag ("left",68, 227,325, 269,0)
	BlockInput (0) 
	ControlClick ( "Centaurus", "Search", "TBitBtn1", "left", 1,35, 11)
	ExitLoop
endif


Sleep(1000)


$i = $i + 1
Until $i = 100000000

;206
$i = 0
Do
If Not FileExists("E:\CMS图片保存区") Then
    DirCreate("E:\CMS图片保存区")
EndIf

If Not FileExists("E:\CMS图片保存区\203") Then
    DirCreate("E:\CMS图片保存区\206")
EndIf	
	
$n = IniRead ( @ScriptDir & "\bczs.ini", "计数", "张数" ,"")
ControlClick ( "Centaurus", "View capture frame", "TToolBar6", "left", 1,13, 10)

WinWait("另存为","",3)
If WinExists("另存为") Then
;ControlClick ( "另存为", "", "[ID:1148]", "left", 2)
Send("E:\CMS图片保存区\206")
send("{enter}")
Sleep(1000)
Send($n)
Sleep(1000)
send("{enter}")
IniWrite(@ScriptDir & "\bczs.ini", "计数", "张数", $n+1)

elseif Not WinExists("另存为")  Then
	$n = IniRead ( @ScriptDir & "\bczs.ini", "计数", "张数" ,"")
	MsgBox ( 0, "计数", "保存张数:   "  &  $n-1,1)
endif

Sleep(1000)
ControlClick ( "Centaurus", "View capture frame", "TToolBar6", "left", 1,210, 12)
Sleep(1000)
If  WinExists("Centaurus", "是(&Y)") Then
     send("{enter}")
	 ;$a = IniRead ( @ScriptDir & "\sctpzs.ini", "计数", "张数" ,"")
	 ;IniWrite(@ScriptDir & "\sctpzs.ini", "计数", "张数", $a+1) 
	$a = IniRead ( @ScriptDir & "\sctpzs.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\sctpzs.ini", "计数", "张数", $a+1) 
endif

Sleep(1000)

If  WinExists("Centaurus", "确定") Then
	 send("{enter}")
elseif Not WinExists("Centaurus", "确定")  then
	$a = IniRead ( @ScriptDir & "\sctpzs.ini", "计数", "张数" ,"")
	MsgBox ( 0, "计数", "删除张数:   "  &  $a)
	#cs
	MouseClick( "right", 315, 257,1);( "Centaurus", "View capture frame", "TListView8", "right", 1,31, 15)
	send("{down}")
	send("{enter}")
	;MouseClickDrag ("left",35, 146,357, 200,$m)
	BlockInput (1) 
	MouseClickDrag ("left",48, 213,325, 269,0)
	BlockInput (0) 
	ControlClick ( "Centaurus", "Search", "TBitBtn1", "left", 1,35, 11)
	;ShellExecute("204.exe", "", @ScriptDir)
	#ce
	Exit 0
endif


Sleep(1000)


$i = $i + 1
Until $i = 100000000


$n = IniRead ( @ScriptDir & "\bczs.ini", "计数", "张数" ,"")
	MsgBox ( 0, "计数", "保存张数:   "  &  $n-1,1)
$a = IniRead ( @ScriptDir & "\sctpzs.ini", "计数", "张数" ,"")
    MsgBox ( 0, "计数", "删除张数:   "  &  $a)	
	
 Case $MSG=2

           Exit

        EndSelect	

Func Terminate()
    $a = IniRead ( @ScriptDir & "\sctpzs.ini", "计数", "张数" ,"")
	$n = IniRead ( @ScriptDir & "\bczs.ini", "计数", "张数" ,"")
    MsgBox ( 0, "计数", "删除张数:   "  &  $a)	
	MsgBox ( 0, "计数", "保存张数:   "  &  $n-1)
	Exit 0
EndFunc

Func Togglepause()
    $Paused = NOT $Paused 
	
   While $Paused 
	tooltip("暂停一会",0,0)
	sleep(100)
   tooltip("")
   WEnd
EndFunc