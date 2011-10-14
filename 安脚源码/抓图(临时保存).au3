HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")
Local $Paused,$k=0 ,$a=0

;$a = IniRead ( @ScriptDir & "\myfile.ini", "计数", "张数" ,"")
;临时和永久一起跑   7500幅图片 跑937次 手动跑4次

WinActivate ("Centaurus")

;临时区域可保存大约5000幅图片  跑1250次

$i = 0
Do
WinActivate ("Centaurus")
MouseClick ( "left" , 505, 391, 1, $k)
ControlClick ( "Centaurus", "Net preview", "TToolBar4", "left", 1,211, 11)
ControlClick ( "Centaurus", "Net preview", "TToolBar6", "left", 1,211, 11)
WinWait("Image saving", "Cancel")
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "否(&N)") Then
     $a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a,1)
	 winwait("Centaurus", "否(&N)")
	 WinActivate ("Centaurus", "否(&N)")
	 ControlClick ( "Centaurus", "否(&N)","[ID:7]" )
	 WinClose("Image saving","Cancel")
	 ExitLoop
endif

If WinExists("Centaurus", "确定") Then
     $a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a,1)
	 winwait("Centaurus", "确定")
	 WinActivate ("Centaurus", "确定")
	 send("{Enter}")
	 WinClose("Image saving","Cancel")
	 ExitLoop
elseif WinWaitClose ("Image saving", "OK") then
	$a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\lsbc.ini", "计数", "张数", $a+1) 
endif


MouseClick ( "left" , 964, 323, 1, $k)
ControlClick ( "Centaurus", "Net preview", "TToolBar4", "left", 1,211, 11)
ControlClick ( "Centaurus", "Net preview", "TToolBar6", "left", 1,211, 11)
WinWait("Image saving", "Cancel")
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "否(&N)") Then
     $a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a,1)
	 winwait("Centaurus", "否(&N)")
	 WinActivate ("Centaurus", "否(&N)")
	 ControlClick ( "Centaurus", "否(&N)","[ID:7]" )
	 WinClose("Image saving","Cancel")
	 ExitLoop
endif

If WinExists("Centaurus", "确定") Then
     $a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a,1)
	 winwait("Centaurus", "确定")
	 WinActivate ("Centaurus", "确定")
	 send("{Enter}")
	 WinClose("Image saving","Cancel")
	 ExitLoop
elseif WinWaitClose ("Image saving", "OK") then
	$a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\lsbc.ini", "计数", "张数", $a+1) 
endif

MouseClick ( "left" , 1133, 732, 1, $k)
ControlClick ( "Centaurus", "Net preview", "TToolBar4", "left", 1,211, 11)
ControlClick ( "Centaurus", "Net preview", "TToolBar6", "left", 1,211, 11)
WinWait("Image saving", "Cancel")
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "否(&N)") Then
     $a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a,1)
	 winwait("Centaurus", "否(&N)")
	 WinActivate ("Centaurus", "否(&N)")
	 ControlClick ( "Centaurus", "否(&N)","[ID:7]" )
	 WinClose("Image saving","Cancel")
	 ExitLoop
endif

If WinExists("Centaurus", "确定") Then
     $a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a,1)
	 winwait("Centaurus", "确定")
	 WinActivate ("Centaurus", "确定")
	 send("{Enter}")
	 WinClose("Image saving","Cancel")
	 ExitLoop
elseif WinWaitClose ("Image saving", "OK") then
	$a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\lsbc.ini", "计数", "张数", $a+1) 
endif

MouseClick ( "left" , 512, 724, 1, $k)
ControlClick ( "Centaurus", "Net preview", "TToolBar4", "left", 1,211, 11)
ControlClick ( "Centaurus", "Net preview", "TToolBar6", "left", 1,211, 11)
WinWait("Image saving", "Cancel")
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "否(&N)") Then
     $a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a,1)
	 winwait("Centaurus", "否(&N)")
	 WinActivate ("Centaurus", "否(&N)")
	 ControlClick ( "Centaurus", "否(&N)","[ID:7]" )
	 WinClose("Image saving","Cancel")
	 ExitLoop
endif

If WinExists("Centaurus", "确定") Then
     $a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a,1)
	 winwait("Centaurus", "确定")
	 WinActivate ("Centaurus", "确定")
	 send("{Enter}")
	 WinClose("Image saving","Cancel")
	 ExitLoop
elseif WinWaitClose ("Image saving", "OK") then
	$a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\lsbc.ini", "计数", "张数", $a+1) 
endif


$i = $i + 1
Until $i = 937

$a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "张数" ,"")
MsgBox ( 0, "计数", "张数:   "  &   $a )

Func Terminate()
	$a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "张数" ,"")
	MsgBox ( 0, "计数", "张数:   "  &  $a)
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

;----------------------------------------------------------------
