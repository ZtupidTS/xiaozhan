HotKeySet("!a", "ShowMessage")          ;ALT+a 注释符号（；）
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z

#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Constants.au3>
#Region ### START Koda GUI section ### Form=CD:\AutoIt3\皮肤效果预览程序\Gonza.skf
Opt("TrayIconHide", 0)
Opt("TrayMenuMode", 1) ;没有默认的（暂停脚本和退出）菜单.
Opt("trayOnEventMode", 1) ;应用 OnEvent 函数于系统托盘.
$Form1 = GUICreate("测试脚本大全", 620, 477, 607, 175)
$Button1 = GUICtrlCreateButton("1", 16, 24, 129, 33)
$Button2 = GUICtrlCreateButton("2", 168, 24, 129, 33)
$Button3 = GUICtrlCreateButton("3", 320, 24, 129, 33)
$Button4 = GUICtrlCreateButton("4", 472, 24, 129, 33)
$Button5 = GUICtrlCreateButton("5", 16, 80, 129, 33)
$Button6 = GUICtrlCreateButton("6", 168, 80, 129, 33)
$Button7 = GUICtrlCreateButton("7", 320, 80, 129, 33)
$Button8 = GUICtrlCreateButton("8", 472, 80, 129, 33)
$Button9 = GUICtrlCreateButton("9", 16, 136, 129, 33)
$Button10 = GUICtrlCreateButton("10", 168, 136, 129, 33)
$Button11 = GUICtrlCreateButton("11", 320, 136, 129, 33)
$Button12 = GUICtrlCreateButton("12", 472, 136, 129, 33)
$Button13 = GUICtrlCreateButton("13", 16, 192, 129, 33)
$Button14 = GUICtrlCreateButton("14", 168, 192, 129, 33)
$Button15 = GUICtrlCreateButton("15", 320, 192, 129, 33)
$Button16 = GUICtrlCreateButton("16", 472, 192, 129, 33)
$Button17 = GUICtrlCreateButton("17", 16, 248, 129, 33)
$Button18 = GUICtrlCreateButton("18", 168, 248, 129, 33)
$Button19 = GUICtrlCreateButton("19", 320, 248, 129, 33)
$Button20 = GUICtrlCreateButton("20", 472, 248, 129, 33)
$Button21 = GUICtrlCreateButton("21", 16, 304, 129, 33)
$Button22 = GUICtrlCreateButton("22", 168, 304, 129, 33)
$Button23 = GUICtrlCreateButton("23", 320, 304, 129, 33)
$Button24 = GUICtrlCreateButton("24", 472, 304, 129, 33)
$Button25 = GUICtrlCreateButton("25", 16, 360, 129, 33)
$Button26 = GUICtrlCreateButton("26", 168, 360, 129, 33)
$Button27 = GUICtrlCreateButton("27", 320, 360, 129, 33)
$Button28 = GUICtrlCreateButton("28", 472, 360, 129, 33)
$Button29 = GUICtrlCreateButton("29", 16, 416, 129, 33)
$Button30 = GUICtrlCreateButton("30", 168, 416, 129, 33)
$Button31 = GUICtrlCreateButton("31", 320, 416, 129, 33)
$Button32 = GUICtrlCreateButton("32", 472, 416, 129, 33)
$Start = TrayCreateItem("启用") ;创建第一个菜单项
TrayItemSetOnEvent($Start, "TrayMsg") ;注册第一个菜单项的（被点下）事件
TrayCreateItem("") ;创建一个空白的菜单项（即横斜杠分割符）
$Quit = TrayCreateItem("退出") ;创建第三个菜单项
TrayItemSetOnEvent($Quit, "TrayMsg") ;注册第二个菜单项的（被点下）事件
TraySetOnEvent($TRAY_EVENT_PRIMARYDOUBLE, "TrayMsg") ;注册鼠标左键双击事件(只能在 TrayOnEventMode 设置为 1 时才能使用)
TraySetOnEvent($TRAY_EVENT_SECONDARYUP, "TrayMsg") ;注册鼠标右键双击事件(只能在 TrayOnEventMode 设置为 1 时才能使用)
TraySetState()
GUISetState(@SW_SHOW)
	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $Button1
				GUISetState(@SW_HIDE, $Form1)
				
				;ShellExecute("notepad.exe")
				; MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button2
				GUISetState(@SW_HIDE, $Form1)
				ShellExecute("notepad.exe")
				;MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button3
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button4
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button5
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button6
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button7
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button8
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button9
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button10
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button11
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button12
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button13
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button14
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button15
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button16
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button17
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button18
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button19
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button20
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button21
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button22
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button23
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button24
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button25
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button26
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button27
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button28
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button29
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button30
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button31
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $Button32
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "测试", "这个消息框将会显示10秒")
			Case $GUI_EVENT_CLOSE
				Exit

		EndSwitch
	WEnd
	
	
Func TrayMsg()
	Switch @TRAY_ID ;选择产生消息的 TrayItem 或其它特殊事件（如鼠标左键双击事件）
		Case $Start
			GUISetState(@SW_SHOW, $Form1)
			;Eval($Button1);$nMsg要返回到$nMsg
		Case $Quit, $TRAY_EVENT_SECONDARYUP
			Exit
	EndSwitch
EndFunc   ;==>TrayMsg




Func ShowMessage() ;Func的意思创建自定义函数
	Dim $i = MsgBox(1, "退出脚本", "确定退出脚本吗")
	If $i <> 2 Then
		Exit 0
	EndIf
EndFunc   ;==>ShowMessage