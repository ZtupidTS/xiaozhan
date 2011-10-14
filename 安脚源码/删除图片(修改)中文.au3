#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_outfile=..\..\测试脚本\删除图片(修改)中文.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
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
ControlClick ( "Centaurus", "查看抓帧图片", "TToolBar6", "left", 1,210, 12)
ControlClick ( "Centaurus", "查看抓帧图片", "TToolBar4", "left", 1,210, 12)

Sleep(1000)
If  WinExists("Centaurus", "是(&Y)") Then
     send("{enter}")
	 $a = IniRead ( @ScriptDir & "\删除图片张数.ini", "计数", "张数" ,"")
	 IniWrite(@ScriptDir & "\删除图片张数.ini", "计数", "张数", $a+1) 
 endif
 Sleep(1000)
If  WinExists("Centaurus", "确定") Then
	 send("{enter}")
elseif Not WinExists("Centaurus", "确定")  then
	$a = IniRead ( @ScriptDir & "\删除图片张数.ini", "计数", "张数" ,"")
	MsgBox ( 0, "计数", "张数:   "  &  $a)
endif



$i = $i + 1
Until $i = 937



Func Terminate()
    $a = IniRead ( @ScriptDir & "\删除图片张数.ini", "计数", "张数" ,"")
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