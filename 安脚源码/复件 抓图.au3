HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")
Local $Paused,$k=0 ,$a=0

;$a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "次数" ,"")
;临时和永久一起跑   7500幅图片 跑937次 手动跑4次

WinActivate ("Centaurus")

;临时区域可保存大约5000幅图片  跑1250次

$i = 0
Do
WinActivate ("Centaurus")
MouseClick ( "left" , 505, 391, 1, $k)
MouseClick ( "left" , 474, 121, 1, $k)
WinWait("Image saving", "Cancel")
send("{Enter}")
sleep(1500)



If WinExists("Centaurus", "确定") Then
     $a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "次数" ,"")
     MsgBox ( 0, "计数", "次数:   "  &  $a)
elseif WinWaitClose ("Image saving", "OK") then
	$a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "次数" ,"")
	IniWrite(@ScriptDir & "\lsbc.ini", "计数", "次数", $a+1) 
endif


MouseClick ( "left" , 964, 323, 1, $k)
MouseClick ( "left" , 474, 121, 1, $k)
WinWait("Image saving", "Cancel")
send("{Enter}")
sleep(1500)



If WinExists("Centaurus", "确定") Then
     $a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "次数" ,"")
     MsgBox ( 0, "计数", "次数:   "  &  $a)
elseif WinWaitClose ("Image saving", "OK") then
	$a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "次数" ,"")
	IniWrite(@ScriptDir & "\lsbc.ini", "计数", "次数", $a+1) 
endif

MouseClick ( "left" , 1133, 732, 1, $k)
MouseClick ( "left" , 474, 121, 1, $k)
WinWait("Image saving", "Cancel")
send("{Enter}")
sleep(1500)



If WinExists("Centaurus", "确定") Then
     $a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "次数" ,"")
     MsgBox ( 0, "计数", "次数:   "  &  $a)
elseif WinWaitClose ("Image saving", "OK") then
	$a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "次数" ,"")
	IniWrite(@ScriptDir & "\lsbc.ini", "计数", "次数", $a+1) 
endif

MouseClick ( "left" , 512, 724, 1, $k)
MouseClick ( "left" , 474, 121, 1, $k)
WinWait("Image saving", "Cancel")
send("{Enter}")
sleep(1500)


If WinExists("Centaurus", "确定") Then
     $a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "次数" ,"")
     MsgBox ( 0, "计数", "次数:   "  &  $a)
elseif WinWaitClose ("Image saving", "OK") then
	$a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "次数" ,"")
	IniWrite(@ScriptDir & "\lsbc.ini", "计数", "次数", $a+1) 
endif

;----------------------------------------------------------------

;永久区域可保存大约2500幅图片    跑625次


#cs
MouseClick ( "left" , 505, 391, 1, $k)
MouseClick ( "left" , 474, 121, 1, $k)
winwait("Image saving","OK")
ControlClick ( "Image saving", "", "[CLASS:TComboBox; INSTANCE:1]","left", 1, 37, 7)
send("{down}")
send("{Enter}")
sleep(3000)
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "确定") Then
     $a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "次数" ,"")
     MsgBox ( 0, "计数", "次数:   "  &  $a)
elseif WinWaitClose ("Image saving", "OK") then
	$a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "次数" ,"")
	IniWrite(@ScriptDir & "\lsbc.ini", "计数", "次数", $a+1) 
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


If WinExists("Centaurus", "确定") Then
     $a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "次数" ,"")
     MsgBox ( 0, "计数", "次数:   "  &  $a)
elseif WinWaitClose ("Image saving", "OK") then
	$a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "次数" ,"")
	IniWrite(@ScriptDir & "\lsbc.ini", "计数", "次数", $a+1) 
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

If WinExists("Centaurus", "确定") Then
     $a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "次数" ,"")
     MsgBox ( 0, "计数", "次数:   "  &  $a)
elseif WinWaitClose ("Image saving", "OK") then
	$a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "次数" ,"")
	IniWrite(@ScriptDir & "\lsbc.ini", "计数", "次数", $a+1) 
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

If WinExists("Centaurus", "确定") Then
     $a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "次数" ,"")
     MsgBox ( 0, "计数", "次数:   "  &  $a)
elseif WinWaitClose ("Image saving", "OK") then
	$a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "次数" ,"")
	IniWrite(@ScriptDir & "\lsbc.ini", "计数", "次数", $a+1) 
endif
#ce
$i = $i + 1
Until $i = 1250

$a = IniRead ( @ScriptDir & "\lsbc.ini", "计数", "次数" ,"")
MsgBox ( 0, "计数", "次数:   "  &   $a )

Func Terminate()
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