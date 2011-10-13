#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=update.ico
#AutoIt3Wrapper_outfile=Update.exe
#AutoIt3Wrapper_Res_Comment=在线更新程序
#AutoIt3Wrapper_Res_Description=在线更新程序
#AutoIt3Wrapper_Res_Fileversion=2.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=BY-Jycel
#AutoIt3Wrapper_Res_Field=程序作者|景勇
#AutoIt3Wrapper_Res_Field=源文件名|update.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#NoTrayIcon
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
$update=@ScriptDir & "\Ghostupdate.ini"
$tempupdate=@TempDir & "\Ghostupdate.ini"
#Region ### START Koda GUI section ### Form=C:\Documents and Settings\Administrator\桌面\Form2.kxf
$Form2 = GUICreate("在线更新程序", 316, 135, 336, 247)
GUISetIcon("D:\003.ico")
$GroupBox1 = GUICtrlCreateGroup("", 8, 1, 297, 89)
$Label1 = GUICtrlCreateLabel("正在检测最新版本……", 16, 24, 280, 17)
GUICtrlSetColor(-1, 0xff0000)
$Label2 = GUICtrlCreateLabel("", 16, 56, 280, 17)
GUICtrlSetColor(-1, 0xff0000)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button1 = GUICtrlCreateButton("确定(&O)", 9, 99, 75, 25, 0)
GUICtrlSetState (-1,$GUI_DISABLE)

$Button2 = GUICtrlCreateButton("退出(&C)", 226, 99, 75, 25, 0)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
If not FileExists($update) Then
		GUICtrlSetData($Label2,"未发现升级文件Ghostupdate.ini,初始化中.....")
		IniWrite("GhostUpdate.ini","ver","ver","1")
		Sleep(500)
		GUICtrlSetData($Label2,"初始化完毕!")
EndIf
$ver=IniRead($update,"ver","ver","")
GUICtrlSetData($Label2,"版本验证中,请稍等.....")
InetGet("http://www.mjbox.com/r/jy/jycel/Ghostupdate.ini",@TempDir & "\Ghostupdate.ini",1,0)
$newver=IniRead($tempupdate,"ver","ver","")
$down=IniRead($tempupdate,"update","update","")
if $ver<>$newver Then
GUICtrlSetData($Label1,"检测完毕")
GUICtrlSetData($Label2,"发现新版本"&$newver&"是否更新？")
GUICtrlSetState ($Button1,$GUI_ENABLE)
GUICtrlSetData($Button1,"更新(&O)")
GUICtrlSetData($Button2,"退出(&O)")
ElseIf $ver=$newver Then
GUICtrlSetData($Label1,"检测完毕")
GUICtrlSetData($Label2,"未发现新版本!暂不更新!")
EndIf
While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		case $Button1
			GUICtrlSetData($Label2,"正在更新中,请稍等.....")
			InetGet($down,$newver&".rar",1,0)
			GUICtrlSetData($Label2,"程序更新完毕!请退出!")
			GUICtrlSetState ($Button1,$GUI_DISABLE)
			FileMove($tempupdate,@ScriptDir&"\",1)
		case $Button2
			Exit	
	EndSwitch
WEnd
