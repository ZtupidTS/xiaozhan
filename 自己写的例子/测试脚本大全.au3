HotKeySet("!a", "ShowMessage")          ;ALT+a ע�ͷ��ţ�����
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z

#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Constants.au3>
#Region ### START Koda GUI section ### Form=CD:\AutoIt3\Ƥ��Ч��Ԥ������\Gonza.skf
Opt("TrayIconHide", 0)
Opt("TrayMenuMode", 1) ;û��Ĭ�ϵģ���ͣ�ű����˳����˵�.
Opt("trayOnEventMode", 1) ;Ӧ�� OnEvent ������ϵͳ����.
$Form1 = GUICreate("���Խű���ȫ", 620, 477, 607, 175)
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
$Start = TrayCreateItem("����") ;������һ���˵���
TrayItemSetOnEvent($Start, "TrayMsg") ;ע���һ���˵���ģ������£��¼�
TrayCreateItem("") ;����һ���հ׵Ĳ˵������б�ָܷ����
$Quit = TrayCreateItem("�˳�") ;�����������˵���
TrayItemSetOnEvent($Quit, "TrayMsg") ;ע��ڶ����˵���ģ������£��¼�
TraySetOnEvent($TRAY_EVENT_PRIMARYDOUBLE, "TrayMsg") ;ע��������˫���¼�(ֻ���� TrayOnEventMode ����Ϊ 1 ʱ����ʹ��)
TraySetOnEvent($TRAY_EVENT_SECONDARYUP, "TrayMsg") ;ע������Ҽ�˫���¼�(ֻ���� TrayOnEventMode ����Ϊ 1 ʱ����ʹ��)
TraySetState()
GUISetState(@SW_SHOW)
	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $Button1
				GUISetState(@SW_HIDE, $Form1)
				
				;ShellExecute("notepad.exe")
				; MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button2
				GUISetState(@SW_HIDE, $Form1)
				ShellExecute("notepad.exe")
				;MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button3
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button4
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button5
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button6
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button7
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button8
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button9
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button10
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button11
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button12
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button13
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button14
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button15
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button16
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button17
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button18
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button19
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button20
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button21
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button22
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button23
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button24
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button25
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button26
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button27
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button28
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button29
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button30
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button31
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $Button32
				GUISetState(@SW_HIDE, $Form1)
				MsgBox(4096, "����", "�����Ϣ�򽫻���ʾ10��")
			Case $GUI_EVENT_CLOSE
				Exit

		EndSwitch
	WEnd
	
	
Func TrayMsg()
	Switch @TRAY_ID ;ѡ�������Ϣ�� TrayItem �����������¼�����������˫���¼���
		Case $Start
			GUISetState(@SW_SHOW, $Form1)
			;Eval($Button1);$nMsgҪ���ص�$nMsg
		Case $Quit, $TRAY_EVENT_SECONDARYUP
			Exit
	EndSwitch
EndFunc   ;==>TrayMsg




Func ShowMessage() ;Func����˼�����Զ��庯��
	Dim $i = MsgBox(1, "�˳��ű�", "ȷ���˳��ű���")
	If $i <> 2 Then
		Exit 0
	EndIf
EndFunc   ;==>ShowMessage