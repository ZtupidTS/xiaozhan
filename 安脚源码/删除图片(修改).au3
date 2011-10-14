HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")
Local $Paused,$k=0 ,$a=0

;$a = IniRead ( @ScriptDir & "\myfile.ini", "计数", "张数" ,"")
;临时和永久一起跑   7500幅图片 跑937次 手动跑4次
MsgBox ( 1, "提示", "请把查看图片窗口打开，搜索好DVR里面的图片" ,10)
WinActivate ("Centaurus")
#cs
send("!v")
send("{down 3}")
send("{enter}")
#ce
$i = 0
Do
WinActivate ("Centaurus")
;MouseClick ( "left" , 496, 138, 1, $k)
ControlClick ( "Centaurus", "View capture frame", "TToolBar6", "left", 1,210, 12)

Sleep(1000)
If  WinExists("Centaurus", "是(&Y)") Then
     send("{enter}")
	 $a = IniRead ( @ScriptDir & "\sctpzs.ini", "计数", "张数" ,"")
	 IniWrite(@ScriptDir & "\sctpzs.ini", "计数", "张数", $a+1) 
endif
If  WinExists("Centaurus", "确定") Then
	 send("{enter}")
elseif Not WinExists("Centaurus", "确定")  then
	$a = IniRead ( @ScriptDir & "\sctpzs.ini", "计数", "张数" ,"")
	MsgBox ( 0, "计数", "张数:   "  &  $a)
endif

Sleep(1000)

$i = $i + 1
Until $i = 937



Func Terminate()
    $a = IniRead ( @ScriptDir & "\sctpzs.ini", "计数", "张数" ,"")
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