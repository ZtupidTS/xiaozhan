#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_outfile=..\..\测试脚本\抓图(永久保存) 中文.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****

;永久区域可保存大约2500幅图片    跑625次


HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")
Local $Paused,$k=0 ,$a=0

WinActivate ("Centaurus")

$i = 0
Do

WinActivate ("Centaurus")
ControlClick ( "Centaurus", "网络浏览", "TPanel226", "left", 2,252, 205)
sleep(1000)
ControlClick ( "Centaurus", "网络浏览", "TPanel226", "left", 2,252, 205)
ControlClick ( "Centaurus", "网络浏览", "TToolBar4", "left", 1,352, 10)
ControlClick ( "Centaurus", "网络浏览", "TToolBar6", "left", 1,352, 10)
winwait("抓帧保存","确定")
ControlClick ( "抓帧保存", "", "[CLASS:TComboBox; INSTANCE:1]","left", 1, 37, 7)
send("{down}")
send("{Enter}")
sleep(3000)
send("{Enter}")
sleep(1500)



If WinExists("Centaurus", "否(&N)") Then
     $a = IniRead ( @ScriptDir & "\永久保存张数.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a,1)
	 winwait("Centaurus", "否(&N)")
	 WinActivate ("Centaurus", "否(&N)")
	 ControlClick ( "Centaurus", "否(&N)","[ID:7]" )
	 WinClose("抓帧保存","取消")
	 ExitLoop
endif

If WinExists("Centaurus", "确定") Then
     $a = IniRead ( @ScriptDir & "\永久保存张数.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a,1)
	 winwait("Centaurus", "确定")
	 WinActivate ("Centaurus", "确定")
	 send("{Enter}")
	 WinClose("抓帧保存","取消")
	 ExitLoop
elseif WinWaitClose ("抓帧保存", "确定") then
	$a = IniRead ( @ScriptDir & "\永久保存张数.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\永久保存张数.ini", "计数", "张数", $a+1) 
endif

ControlClick ( "Centaurus", "网络浏览", "TPanel225", "left", 2,258, 204)
sleep(1000)
ControlClick ( "Centaurus", "网络浏览", "TPanel225", "left", 2,258, 204)
ControlClick ( "Centaurus", "网络浏览", "TToolBar4", "left", 1,352, 10)
ControlClick ( "Centaurus", "网络浏览", "TToolBar6", "left", 1,352, 10)
winwait("抓帧保存","确定")
ControlClick ( "抓帧保存", "", "[CLASS:TComboBox; INSTANCE:1]","left", 1, 37, 7)
send("{down}")
send("{Enter}")
sleep(3000)
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "否(&N)") Then
     $a = IniRead ( @ScriptDir & "\永久保存张数.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a,1)
	 winwait("Centaurus", "否(&N)")
	 WinActivate ("Centaurus", "否(&N)")
	 ControlClick ( "Centaurus", "否(&N)","[ID:7]" )
	 WinClose("抓帧保存","取消")
	 ExitLoop
 endif
 
If WinExists("Centaurus", "确定") Then
     $a = IniRead ( @ScriptDir & "\永久保存张数.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a,1)
	 winwait("Centaurus", "确定")
	 WinActivate ("Centaurus", "确定")
	 send("{Enter}")
	 WinClose("抓帧保存","取消")
	 ExitLoop
elseif WinWaitClose ("抓帧保存", "确定") then
	$a = IniRead ( @ScriptDir & "\永久保存张数.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\永久保存张数.ini", "计数", "张数", $a+1) 
endif

ControlClick ( "Centaurus", "网络浏览", "TPanel223", "left", 2,246, 204)
sleep(1000)
ControlClick ( "Centaurus", "网络浏览", "TPanel223", "left", 2,246, 204)
ControlClick ( "Centaurus", "网络浏览", "TToolBar4", "left", 1,352, 10)
ControlClick ( "Centaurus", "网络浏览", "TToolBar6", "left", 1,352, 10)
winwait("抓帧保存","确定")
ControlClick ( "抓帧保存", "", "[CLASS:TComboBox; INSTANCE:1]","left", 1, 37, 7)
send("{down}")
send("{Enter}")
sleep(3000)
send("{Enter}")
sleep(1500)


If WinExists("Centaurus", "否(&N)") Then
     $a = IniRead ( @ScriptDir & "\永久保存张数.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a,1)
	 winwait("Centaurus", "否(&N)")
	 WinActivate ("Centaurus", "否(&N)")
	 ControlClick ( "Centaurus", "否(&N)","[ID:7]" )
	 WinClose("抓帧保存","取消")
	 ExitLoop
 endif
 
If WinExists("Centaurus", "确定") Then
     $a = IniRead ( @ScriptDir & "\永久保存张数.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a,1)
	 winwait("Centaurus", "确定")
	 WinActivate ("Centaurus", "确定")
	 send("{Enter}")
	 WinClose("抓帧保存","取消")
	 ExitLoop
elseif WinWaitClose ("抓帧保存", "确定") then
	$a = IniRead ( @ScriptDir & "\永久保存张数.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\永久保存张数.ini", "计数", "张数", $a+1) 
endif

ControlClick ( "Centaurus", "网络浏览", "TPanel224", "left", 2,326, 197)
sleep(1000)
ControlClick ( "Centaurus", "网络浏览", "TPanel224", "left", 2,326, 197)
ControlClick ( "Centaurus", "网络浏览", "TToolBar4", "left", 1,352, 10)
ControlClick ( "Centaurus", "网络浏览", "TToolBar6", "left", 1,352, 10)
winwait("抓帧保存","确定")
ControlClick ( "抓帧保存", "", "[CLASS:TComboBox; INSTANCE:1]","left", 1, 37, 7)
send("{down}")
send("{Enter}")
sleep(3000)
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "否(&N)") Then
     $a = IniRead ( @ScriptDir & "\永久保存张数.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a,1)
	 winwait("Centaurus", "否(&N)")
	 WinActivate ("Centaurus", "否(&N)")
	 ControlClick ( "Centaurus", "否(&N)","[ID:7]" )
	 WinClose("抓帧保存","取消")
	 ExitLoop
 endif
 

If WinExists("Centaurus", "确定") Then
     $a = IniRead ( @ScriptDir & "\永久保存张数.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a,1)
	 winwait("Centaurus", "确定")
	 WinActivate ("Centaurus", "确定")
	 send("{Enter}")
	 WinClose("抓帧保存","取消")
	 ExitLoop
elseif WinWaitClose ("抓帧保存", "确定") then
	$a = IniRead ( @ScriptDir & "\永久保存张数.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\永久保存张数.ini", "计数", "张数", $a+1) 
endif

$i = $i + 1
Until $i = 937

$a = IniRead ( @ScriptDir & "\永久保存张数.ini", "计数", "张数" ,"")
MsgBox ( 0, "计数", "张数:   "  &   $a )

Func Terminate()
	$a = IniRead ( @ScriptDir & "\永久保存张数.ini", "计数", "张数" ,"")
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