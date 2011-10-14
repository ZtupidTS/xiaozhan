#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_outfile=..\..\测试脚本\修改密码与自动登录 中文.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")


Local $m=0 ,$Paused
WinActivate ("Centaurus")

send("!s")
send("{down 4}")
send("{enter}")

WinWait("更改密码","确定")
ControlClick ( "更改密码", "", "TEdit2", "left")
Sleep(100)
send("system")
ControlClick ( "更改密码", "确定", "TButton2", "left")
ControlClick ( "Centaurus", "确定", "Button1", "left")
Sleep(100)

send("!s")
send("{down 2}")
send("{enter}")

WinWait("自动用户校验","确定")
ControlClick ( "自动用户校验", "启用", "TCheckBox1", "left")
ControlClick ( "自动用户校验", "确定", "TButton2", "left")


ControlClick ( "Centaurus", "tbWindows", "TToolBar5", "left",1,512, 21)
MouseClick( "left", 512, 63,1)
WinActivate ("Centaurus")
ControlClick ( "Centaurus", "Centaurus", "TLabeledEdit1", "left",2)
send("")
send("{enter}")







Func Terminate()
    ;$a = IniRead ( @ScriptDir & "\sctpzs.ini", "计数", "张数" ,"")
    ;MsgBox ( 0, "计数", "张数:   "  &  $a)	
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