#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_outfile=..\..\测试脚本\抓图(修改)中文.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")
Local $Paused,$k=0 ,$a=0

;$a = IniRead ( @ScriptDir & "\保存张数.ini", "计数", "张数" ,"")
;临时和永久一起跑   7500幅图片 跑937次 手动跑4次

WinActivate ("Centaurus")

;临时区域可保存大约5000幅图片  跑1250次

$i = 0
Do
WinActivate ("Centaurus")
;MouseClick ( "left" , 505, 377, 1, $k)
ControlClick ( "Centaurus", "网络浏览", "TPanel226", "left", 2,349, 83)
sleep(1000)
ControlClick ( "Centaurus", "网络浏览", "TPanel226", "left", 2,349, 83)
ControlClick ( "Centaurus", "网络浏览", "TToolBar6", "left", 1,352, 10)
WinWait("抓帧保存", "取消")
send("{Enter}")
sleep(1500)



If WinExists("Centaurus", "确定") Then
     $a = IniRead ( @ScriptDir & "\保存张数.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a)
elseif WinWaitClose ("抓帧保存", "确定") then
	$a = IniRead ( @ScriptDir & "\保存张数.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\保存张数.ini", "计数", "张数", $a+1) 
endif

ControlClick ( "Centaurus", "网络浏览", "TPanel225", "left", 2,824, 83)
sleep(1000)
ControlClick ( "Centaurus", "网络浏览", "TPanel225", "left", 2,824, 83)
;MouseClick ( "left" , 1080, 410, 1, $k)
ControlClick ( "Centaurus", "网络浏览", "TToolBar6", "left", 1,352, 10)
WinWait("抓帧保存", "取消")
send("{Enter}")
sleep(1500)



If WinExists("Centaurus", "确定") Then
     $a = IniRead ( @ScriptDir & "\保存张数.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a)
elseif WinWaitClose ("抓帧保存", "确定") then
	$a = IniRead ( @ScriptDir & "\保存张数.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\保存张数.ini", "计数", "张数", $a+1) 
endif

ControlClick ( "Centaurus", "网络浏览", "TPanel223", "left", 2,824, 439)
sleep(1000)
ControlClick ( "Centaurus", "网络浏览", "TPanel223", "left", 2,824, 439)
;MouseClick ( "left" , 1050, 768, 1, $k)
ControlClick ( "Centaurus", "网络浏览", "TToolBar6", "left", 1,352, 10)
WinWait("抓帧保存", "取消")
send("{Enter}")
sleep(1500)



If WinExists("Centaurus", "确定") Then
     $a = IniRead ( @ScriptDir & "\保存张数.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a)
elseif WinWaitClose ("抓帧保存", "确定") then
	$a = IniRead ( @ScriptDir & "\保存张数.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\保存张数.ini", "计数", "张数", $a+1) 
endif


ControlClick ( "Centaurus", "网络浏览", "TPanel224", "left", 2,349, 439)
sleep(1000)
ControlClick ( "Centaurus", "网络浏览", "TPanel224", "left", 2,349, 439)
;MouseClick ( "left" , 501, 759, 1, $k)
ControlClick ( "Centaurus", "网络浏览", "TToolBar6", "left", 1,352, 10)
WinWait("抓帧保存", "取消")
send("{Enter}")
sleep(1500)


If WinExists("Centaurus", "确定") Then
     $a = IniRead ( @ScriptDir & "\保存张数.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a)
elseif WinWaitClose ("抓帧保存", "确定") then
	$a = IniRead ( @ScriptDir & "\保存张数.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\保存张数.ini", "计数", "张数", $a+1) 
endif

;----------------------------------------------------------------

;永久区域可保存大约2500幅图片    跑625次



;MouseClick ( "left" , 505, 377, 1, $k)
ControlClick ( "Centaurus", "网络浏览", "TPanel226", "left", 2,252, 205)
sleep(1000)
ControlClick ( "Centaurus", "网络浏览", "TPanel226", "left", 2,252, 205)
ControlClick ( "Centaurus", "网络浏览", "TToolBar6", "left", 1,352, 10)
winwait("抓帧保存","确定")
ControlClick ( "抓帧保存", "", "[CLASS:TComboBox; INSTANCE:1]","left", 1, 37, 7)
send("{down}")
send("{Enter}")
sleep(3000)
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "确定") Then
     $a = IniRead ( @ScriptDir & "\保存张数.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a)
elseif WinWaitClose ("抓帧保存", "确定") then
	$a = IniRead ( @ScriptDir & "\保存张数.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\保存张数.ini", "计数", "张数", $a+1) 
endif

;MouseClick ( "left" , 1080, 410, 1, $k)
ControlClick ( "Centaurus", "网络浏览", "TPanel225", "left", 2,258, 204)
sleep(1000)
ControlClick ( "Centaurus", "网络浏览", "TPanel225", "left", 2,258, 204)
ControlClick ( "Centaurus", "网络浏览", "TToolBar6", "left", 1,352, 10)
winwait("抓帧保存","确定")
ControlClick ( "抓帧保存", "", "[CLASS:TComboBox; INSTANCE:1]","left", 1, 37, 7)
send("{down}")
send("{Enter}")
sleep(3000)
send("{Enter}")
sleep(1500)


If WinExists("Centaurus", "确定") Then
     $a = IniRead ( @ScriptDir & "\保存张数.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a)
elseif WinWaitClose ("抓帧保存", "确定") then
	$a = IniRead ( @ScriptDir & "\保存张数.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\保存张数.ini", "计数", "张数", $a+1) 
endif

;MouseClick ( "left" , 1050, 768, 1, $k)
ControlClick ( "Centaurus", "网络浏览", "TPanel224", "left", 2,246, 204)
sleep(1000)
ControlClick ( "Centaurus", "网络浏览", "TPanel224", "left", 2,246, 204)
ControlClick ( "Centaurus", "网络浏览", "TToolBar6", "left", 1,352, 10)
winwait("抓帧保存","确定")
ControlClick ( "抓帧保存", "", "[CLASS:TComboBox; INSTANCE:1]","left", 1, 37, 7)
send("{down}")
send("{Enter}")
sleep(3000)
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "确定") Then
     $a = IniRead ( @ScriptDir & "\保存张数.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a)
elseif WinWaitClose ("抓帧保存", "确定") then
	$a = IniRead ( @ScriptDir & "\保存张数.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\保存张数.ini", "计数", "张数", $a+1) 
endif

;MouseClick ( "left" ,  501, 759, 1, $k)
ControlClick ( "Centaurus", "网络浏览", "TPanel223", "left", 2,326, 197)
sleep(1000)
ControlClick ( "Centaurus", "网络浏览", "TPanel223", "left", 2,326, 197)
ControlClick ( "Centaurus", "网络浏览", "TToolBar6", "left", 1,352, 10)
winwait("抓帧保存","确定")
ControlClick ( "抓帧保存", "", "[CLASS:TComboBox; INSTANCE:1]","left", 1, 37, 7)
send("{down}")
send("{Enter}")
sleep(3000)
send("{Enter}")
sleep(1500)

If WinExists("Centaurus", "确定") Then
     $a = IniRead ( @ScriptDir & "\保存张数.ini", "计数", "张数" ,"")
     MsgBox ( 0, "计数", "张数:   "  &  $a)
elseif WinWaitClose ("抓帧保存", "确定") then
	$a = IniRead ( @ScriptDir & "\保存张数.ini", "计数", "张数" ,"")
	IniWrite(@ScriptDir & "\保存张数.ini", "计数", "张数", $a+1) 
endif

$i = $i + 1
Until $i = 937

$a = IniRead ( @ScriptDir & "\保存张数.ini", "计数", "张数" ,"")
MsgBox ( 0, "计数", "张数:   "  &   $a )

Func Terminate()
	$a = IniRead ( @ScriptDir & "\保存张数.ini", "计数", "张数" ,"")
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