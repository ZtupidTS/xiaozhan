#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=..\����\�ۺ����\3D���ICOͼ��\f2.ico
#AutoIt3Wrapper_outfile=��ȡ�ط��б�����(Netviewer).exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Include <GuiListView.au3>
#NoTrayIcon
#Region ### START Koda GUI section ### Form=

$I= IniRead(@scriptdir & "\��ȡ�ط��б�����(Netviewer).ini", "Netviewer","����","")

$Form1_1 = GUICreate("��ȡ�ط��б�����(Netviewer)", 291, 143, 192, 124,$WS_THICKFRAME)
$Input1 = GUICtrlCreateInput($I, 24, 48, 241, 21)
$Label1 = GUICtrlCreateLabel("������Netviewer�ı�������", 24, 16, 244, 17)
$Button1 = GUICtrlCreateButton("ȷ��", 48, 82, 81, 25,$WS_GROUP)
GUICtrlSetState(-1, $GUI_DEFBUTTON)
$Button2 = GUICtrlCreateButton("ȡ��", 160, 82, 81, 25)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Select 
		Case $nMsg = $GUI_EVENT_CLOSE
			Exit
		Case $nMsg = $Button2
			Exit
		Case $nMsg = $Button1
			IniWrite(@ScriptDir & "\��ȡ�ط��б�����(Netviewer).ini", "Netviewer", "����", GUICtrlRead ($Input1)) 
			_hqzs()
			Exit
	EndSelect
WEnd

Func _hqzs()
	$I= IniRead(@scriptdir & "\��ȡ�ط��б�����(Netviewer).ini", "Netviewer","����","")
	WinActivate($I,"Playback")  ;����ָ���Ĵ���(���ý��㵽�ô���,ʹ���Ϊ�����)
	$xiaozhan = ControlGetHandle ( $I, "", "SysListView321")  ;��ȡָ���ؼ����ڲ����.
	$count = _GUICtrlListView_GetItemCount($xiaozhan) ;��ȡ�б���ͼ�ؼ�����Ŀ��
	MsgBox(1, "��ȡ�ط��б�����" ,"��ȡ�ط��б�������:  " & $count)
	IniWrite(@ScriptDir & "\��ȡ�ط��б�����(Netviewer).ini", "�б�", "��������", $count);����һ�����Ŀ����
	;$R = IniRead(@ScriptDir & "\��ȡ�ط��б�����(Netviewer).ini", "�б�", "���������","");��ȡ��Ӻ��������
	;IniWrite(@ScriptDir & "\��ȡ�ط��б�����(Netviewer).ini", "�б�", "���������", $count + $R) ;��Ҫ�ѵ���һ�����Ŀ���� + ��Ӻ������
	;$Z = IniRead(@ScriptDir & "\��ȡ�ط��б�����(Netviewer).ini", "�б�", "���������","");$count+$H�������
	;MsgBox(1, "��ȡ�ط��б�����" ,"��ȡ�ط��б��������:  " & $Z);$count+$H��ʾ����
EndFunc