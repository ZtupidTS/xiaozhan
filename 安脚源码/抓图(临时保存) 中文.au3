#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_outfile=..\..\测试脚本\抓图(临时保存) 中文.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
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
ControlClick ( "Centaurus", "网络浏览", "TPanel226", "left", 2,349, 83)
sleep(1000)
ControlClick ( "Centaurus", "网络浏览", "TPanel226", "left", 2,349, 83)
ControlClick ( "Centaurus", "网络浏览", "TToolBar4", "left", 1,352, 10)
ControlClick ( "Centaurus", "网络浏览", "TToolBar6", "left", 1,352, 10)
WinWait("抓帧保存", "取消")
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "否(&N)") Then
     $a = IniRead ( @ScriptDir & "\临时保存张数.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a,1)
	 winwait("Centaurus", "否(&N)")
	 WinActivate ("Centaurus", "否(&N)")
	 ControlClick ( "Centaurus", "否(&N)","[ID:7]" )
	 WinClose("抓帧保存","取消")
	 ExitLoop
endif

If WinExists("Centaurus", "确定") Then
     $a = IniRead ( @ScriptDir & "\临时保存张数.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a,1)
	 winwait("Centaurus", "确定")
	 WinActivate ("Centaurus", "确定")
	 send("{Enter}")
	 WinClose("抓帧保存","取消")
	 ExitLoop
elseif WinWaitClose ("抓帧保存", "OK") then
	$a = IniRead ( @ScriptDir & "\临时保存张数.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\临时保存张数.ini", "计数", "张数", $a+1) 
endif


ControlClick ( "Centaurus", "网络浏览", "TPanel225", "left", 2,824, 83)
sleep(1000)
ControlClick ( "Centaurus", "网络浏览", "TPanel225", "left", 2,824, 83)
ControlClick ( "Centaurus", "网络浏览", "TToolBar4", "left", 1,352, 10)
ControlClick ( "Centaurus", "网络浏览", "TToolBar6", "left", 1,352, 10)
WinWait("抓帧保存", "取消")
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "否(&N)") Then
     $a = IniRead ( @ScriptDir & "\临时保存张数.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a,1)
	 winwait("Centaurus", "否(&N)")
	 WinActivate ("Centaurus", "否(&N)")
	 ControlClick ( "Centaurus", "否(&N)","[ID:7]" )
	 WinClose("抓帧保存","取消")
	 ExitLoop
endif

If WinExists("Centaurus", "确定") Then
     $a = IniRead ( @ScriptDir & "\临时保存张数.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a,1)
	 winwait("Centaurus", "确定")
	 WinActivate ("Centaurus", "确定")
	 send("{Enter}")
	 WinClose("抓帧保存","取消")
	 ExitLoop
elseif WinWaitClose ("抓帧保存", "OK") then
	$a = IniRead ( @ScriptDir & "\临时保存张数.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\临时保存张数.ini", "计数", "张数", $a+1) 
endif

ControlClick ( "Centaurus", "网络浏览", "TPanel223", "left", 2,824, 439)
sleep(1000)
ControlClick ( "Centaurus", "网络浏览", "TPanel223", "left", 2,824, 439)
ControlClick ( "Centaurus", "网络浏览", "TToolBar4", "left", 1,352, 10)
ControlClick ( "Centaurus", "网络浏览", "TToolBar6", "left", 1,352, 10)
WinWait("抓帧保存", "取消")
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "否(&N)") Then
     $a = IniRead ( @ScriptDir & "\临时保存张数.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a,1)
	 winwait("Centaurus", "否(&N)")
	 WinActivate ("Centaurus", "否(&N)")
	 ControlClick ( "Centaurus", "否(&N)","[ID:7]" )
	 WinClose("抓帧保存","取消")
	 ExitLoop
endif

If WinExists("Centaurus", "确定") Then
     $a = IniRead ( @ScriptDir & "\临时保存张数.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a,1)
	 winwait("Centaurus", "确定")
	 WinActivate ("Centaurus", "确定")
	 send("{Enter}")
	 WinClose("抓帧保存","取消")
	 ExitLoop
elseif WinWaitClose ("抓帧保存", "OK") then
	$a = IniRead ( @ScriptDir & "\临时保存张数.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\临时保存张数.ini", "计数", "张数", $a+1) 
endif

ControlClick ( "Centaurus", "网络浏览", "TPanel224", "left", 2,349, 439)
sleep(1000)
ControlClick ( "Centaurus", "网络浏览", "TPanel224", "left", 2,349, 439)
ControlClick ( "Centaurus", "网络浏览", "TToolBar4", "left", 1,352, 10)
ControlClick ( "Centaurus", "网络浏览", "TToolBar6", "left", 1,352, 10)
WinWait("抓帧保存", "取消")
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "否(&N)") Then
     $a = IniRead ( @ScriptDir & "\临时保存张数.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a,1)
	 winwait("Centaurus", "否(&N)")
	 WinActivate ("Centaurus", "否(&N)")
	 ControlClick ( "Centaurus", "否(&N)","[ID:7]" )
	 WinClose("抓帧保存","取消")
	 ExitLoop
endif

If WinExists("Centaurus", "确定") Then
     $a = IniRead ( @ScriptDir & "\临时保存张数.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a,1)
	 winwait("Centaurus", "确定")
	 WinActivate ("Centaurus", "确定")
	 send("{Enter}")
	 WinClose("抓帧保存","取消")
	 ExitLoop
elseif WinWaitClose ("抓帧保存", "OK") then
	$a = IniRead ( @ScriptDir & "\临时保存张数.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\临时保存张数.ini", "计数", "张数", $a+1) 
endif


$i = $i + 1
Until $i = 937

$a = IniRead ( @ScriptDir & "\临时保存张数.ini", "计数", "张数" ,"")
MsgBox ( 0, "计数", "张数:   "  &   $a )

Func Terminate()
	$a = IniRead ( @ScriptDir & "\临时保存张数.ini", "计数", "张数" ,"")
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
