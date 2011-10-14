#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_outfile=..\..\测试脚本\删除图片(整合)中文.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")

;MouseClick ( "left" ,131, 202,1, 5) 
Local $m=0 ,$Paused
WinActivate ("Centaurus")

send("!v")
send("{down 3}")
send("{enter}")
ControlTreeView ("Centaurus", "节点组织树", "TTreeView4", "Expand", "sea")
BlockInput (1) 
MouseClickDrag ("left",65, 137,299, 192,$m)
MouseClickDrag ("left",66, 152,298, 275,$m)
BlockInput (0) 
ControlClick ( "Centaurus", "搜索(&S)", "TBitBtn1", "left", 1,35, 11)

;228
$i = 0
Do

ControlClick ( "Centaurus", "查看抓帧图片", "TToolBar6", "left", 1,210, 12)
Sleep(1000)
If  WinExists("Centaurus", "是(&Y)") Then
     send("{enter}")
	; $a = IniRead ( @ScriptDir & "\删除图片张数.ini", "计数", "张数" ,"")
	 ;IniWrite(@ScriptDir & "\删除图片张数.ini", "计数", "张数", $a+1) 
	$a = IniRead ( @ScriptDir & "\删除图片张数.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\删除图片张数.ini", "计数", "张数", $a+1) 
endif

Sleep(1000)

If  WinExists("Centaurus", "确定") Then
	 send("{enter}")
elseif Not WinExists("Centaurus", "确定")  then
	$a = IniRead ( @ScriptDir & "\删除图片张数.ini", "计数", "张数" ,"")
	MsgBox ( 0, "计数", "删除张数:   "  &  $a,1)
	MouseClick( "right", 269, 256,1);( "Centaurus", "查看抓帧图片", "TListView8", "right", 1,31, 15)
	send("{down}")
	send("{enter}")
	;MouseClickDrag ("left",35, 146,299, 192,$m)
	BlockInput (1) 
	MouseClickDrag ("left",66, 168,298, 275,$m)
	BlockInput (0) 
	ControlClick ( "Centaurus", "搜索(&S)", "TBitBtn1", "left", 1,35, 11)
	;ShellExecute("252.exe", "", @ScriptDir)	
	Exitloop
endif






$i = $i + 1
Until $i = 100000000

;252

$i = 0
Do

ControlClick ( "Centaurus", "查看抓帧图片", "TToolBar6", "left", 1,210, 12)
Sleep(1000)
If  WinExists("Centaurus", "是(&Y)") Then
     send("{enter}")
	; $a = IniRead ( @ScriptDir & "\删除图片张数.ini", "计数", "张数" ,"")
	; IniWrite(@ScriptDir & "\删除图片张数.ini", "计数", "张数", $a+1) 
	$a = IniRead ( @ScriptDir & "\删除图片张数.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\删除图片张数.ini", "计数", "张数", $a+1) 
endif

Sleep(1000)

If  WinExists("Centaurus", "确定") Then
	 send("{enter}")
elseif Not WinExists("Centaurus", "确定")  then
	$a = IniRead ( @ScriptDir & "\删除图片张数.ini", "计数", "张数" ,"")
	MsgBox ( 0, "计数", "删除张数:   "  &  $a,1)
	MouseClick( "right", 267, 258,1);( "Centaurus", "查看抓帧图片", "TListView8", "right", 1,31, 15)
	send("{down}")
	send("{enter}")
	;MouseClickDrag ("left",35, 146,299, 192,$m)
	BlockInput (1) 
	MouseClickDrag ("left",66, 184,298, 275,0)
	BlockInput (0) 
	ControlClick ( "Centaurus", "搜索(&S)", "TBitBtn1", "left", 1,35, 11)
	;ShellExecute("208.exe", "", @ScriptDir)
	ExitLoop
endif





$i = $i + 1
Until $i = 100000000


;204
$i = 0
Do

ControlClick ( "Centaurus", "查看抓帧图片", "TToolBar6", "left", 1,210, 12)
Sleep(1000)
If  WinExists("Centaurus", "是(&Y)") Then
     send("{enter}")
	 ;$a = IniRead ( @ScriptDir & "\删除图片张数.ini", "计数", "张数" ,"")
	 ;IniWrite(@ScriptDir & "\删除图片张数.ini", "计数", "张数", $a+1) 
	$a = IniRead ( @ScriptDir & "\删除图片张数.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\删除图片张数.ini", "计数", "张数", $a+1) 
endif

Sleep(1000)

If  WinExists("Centaurus", "确定") Then
	 send("{enter}")
elseif Not WinExists("Centaurus", "确定")  then
	$a = IniRead ( @ScriptDir & "\删除图片张数.ini", "计数", "张数" ,"")
	MsgBox ( 0, "计数", "删除张数:   "  &  $a,1)
	MouseClick( "right", 269, 256,1);( "Centaurus", "查看抓帧图片", "TListView8", "right", 1,31, 15)
	send("{down}")
	send("{enter}")
	;MouseClickDrag ("left",35, 146,299, 192,$m)
	BlockInput (1) 
	MouseClickDrag ("left",67, 201,298, 275,0)
	BlockInput (0) 
	ControlClick ( "Centaurus", "搜索(&S)", "TBitBtn1", "left", 1,35, 11)
	Exitloop
endif




$i = $i + 1
Until $i = 100000000


;208


$i = 0
Do

ControlClick ( "Centaurus", "查看抓帧图片", "TToolBar6", "left", 1,210, 12)
Sleep(1000)
If  WinExists("Centaurus", "是(&Y)") Then
     send("{enter}")
	 ;$a = IniRead ( @ScriptDir & "\删除图片张数.ini", "计数", "张数" ,"")
	 ;IniWrite(@ScriptDir & "\删除图片张数.ini", "计数", "张数", $a+1) 
	$a = IniRead ( @ScriptDir & "\删除图片张数.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\删除图片张数.ini", "计数", "张数", $a+1) 
endif

Sleep(1000)

If  WinExists("Centaurus", "确定") Then
	 send("{enter}")
elseif Not WinExists("Centaurus", "确定")  then
	$a = IniRead ( @ScriptDir & "\删除图片张数.ini", "计数", "张数" ,"")
	MsgBox ( 0, "计数", "删除张数:   "  &  $a,1)
	MouseClick( "right", 269, 256,1);( "Centaurus", "查看抓帧图片", "TListView8", "right", 1,31, 15)
	send("{down}")
	send("{enter}")
	;MouseClickDrag ("left",35, 146,299, 192,$m)
	BlockInput (1) 
	MouseClickDrag ("left",68, 218,298, 275,0)
	BlockInput (0) 
	ControlClick ( "Centaurus", "搜索(&S)", "TBitBtn1", "left", 1,35, 11)
	ExitLoop
endif





$i = $i + 1
Until $i = 100000000

;206
$i = 0
Do

ControlClick ( "Centaurus", "查看抓帧图片", "TToolBar6", "left", 1,210, 12)
Sleep(1000)
If  WinExists("Centaurus", "是(&Y)") Then
     send("{enter}")
	 ;$a = IniRead ( @ScriptDir & "\删除图片张数.ini", "计数", "张数" ,"")
	 ;IniWrite(@ScriptDir & "\删除图片张数.ini", "计数", "张数", $a+1) 
	$a = IniRead ( @ScriptDir & "\删除图片张数.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\删除图片张数.ini", "计数", "张数", $a+1) 
endif

Sleep(1000)

If  WinExists("Centaurus", "确定") Then
	 send("{enter}")
elseif Not WinExists("Centaurus", "确定")  then
	$a = IniRead ( @ScriptDir & "\删除图片张数.ini", "计数", "张数" ,"")
	MsgBox ( 0, "计数", "删除张数:   "  &  $a)
	#cs
	MouseClick( "right", 269, 256,1);( "Centaurus", "查看抓帧图片", "TListView8", "right", 1,31, 15)
	send("{down}")
	send("{enter}")
	;MouseClickDrag ("left",35, 146,299, 192,$m)
	BlockInput (1) 
	MouseClickDrag ("left",48, 213,298, 275,0)
	BlockInput (0) 
	ControlClick ( "Centaurus", "搜索(&S)", "TBitBtn1", "left", 1,35, 11)
	;ShellExecute("204.exe", "", @ScriptDir)
	#ce
	Exit 0
endif





$i = $i + 1
Until $i = 100000000


$a = $a = IniRead ( @ScriptDir & "\删除图片张数.ini", "计数", "张数" ,"")
    MsgBox ( 0, "计数", "删除张数:   "  &  $a)	

Func Terminate()
    $a = IniRead ( @ScriptDir & "\删除图片张数.ini", "计数", "张数" ,"")
    MsgBox ( 0, "计数", "删除张数:   "  &  $a)	
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