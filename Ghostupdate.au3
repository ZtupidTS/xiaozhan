#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=update.ico
#AutoIt3Wrapper_outfile=Update.exe
#AutoIt3Wrapper_Res_Comment=���߸��³���
#AutoIt3Wrapper_Res_Description=���߸��³���
#AutoIt3Wrapper_Res_Fileversion=2.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=BY-Jycel
#AutoIt3Wrapper_Res_Field=��������|����
#AutoIt3Wrapper_Res_Field=Դ�ļ���|update.exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
#NoTrayIcon
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
$update=@ScriptDir & "\Ghostupdate.ini"
$tempupdate=@TempDir & "\Ghostupdate.ini"
#Region ### START Koda GUI section ### Form=C:\Documents and Settings\Administrator\����\Form2.kxf
$Form2 = GUICreate("���߸��³���", 316, 135, 336, 247)
GUISetIcon("D:\003.ico")
$GroupBox1 = GUICtrlCreateGroup("", 8, 1, 297, 89)
$Label1 = GUICtrlCreateLabel("���ڼ�����°汾����", 16, 24, 280, 17)
GUICtrlSetColor(-1, 0xff0000)
$Label2 = GUICtrlCreateLabel("", 16, 56, 280, 17)
GUICtrlSetColor(-1, 0xff0000)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button1 = GUICtrlCreateButton("ȷ��(&O)", 9, 99, 75, 25, 0)
GUICtrlSetState (-1,$GUI_DISABLE)

$Button2 = GUICtrlCreateButton("�˳�(&C)", 226, 99, 75, 25, 0)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
If not FileExists($update) Then
		GUICtrlSetData($Label2,"δ���������ļ�Ghostupdate.ini,��ʼ����.....")
		IniWrite("GhostUpdate.ini","ver","ver","1")
		Sleep(500)
		GUICtrlSetData($Label2,"��ʼ�����!")
EndIf
$ver=IniRead($update,"ver","ver","")
GUICtrlSetData($Label2,"�汾��֤��,���Ե�.....")
InetGet("http://www.mjbox.com/r/jy/jycel/Ghostupdate.ini",@TempDir & "\Ghostupdate.ini",1,0)
$newver=IniRead($tempupdate,"ver","ver","")
$down=IniRead($tempupdate,"update","update","")
if $ver<>$newver Then
GUICtrlSetData($Label1,"������")
GUICtrlSetData($Label2,"�����°汾"&$newver&"�Ƿ���£�")
GUICtrlSetState ($Button1,$GUI_ENABLE)
GUICtrlSetData($Button1,"����(&O)")
GUICtrlSetData($Button2,"�˳�(&O)")
ElseIf $ver=$newver Then
GUICtrlSetData($Label1,"������")
GUICtrlSetData($Label2,"δ�����°汾!�ݲ�����!")
EndIf
While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		case $Button1
			GUICtrlSetData($Label2,"���ڸ�����,���Ե�.....")
			InetGet($down,$newver&".rar",1,0)
			GUICtrlSetData($Label2,"����������!���˳�!")
			GUICtrlSetState ($Button1,$GUI_DISABLE)
			FileMove($tempupdate,@ScriptDir&"\",1)
		case $Button2
			Exit	
	EndSwitch
WEnd
