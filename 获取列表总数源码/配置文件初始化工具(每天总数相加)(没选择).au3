#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("�����ļ���ʼ������(ÿ���������)", 315, 172, 187, 124)
$Input2 = GUICtrlCreateInput("", 112, 88, 169, 21)
$Button1 = GUICtrlCreateButton("ȷ��", 64, 128, 65, 25)
$Button2 = GUICtrlCreateButton("ȡ��", 188, 128, 65, 25)
$Label1 = GUICtrlCreateLabel("         ��ѱ�����ŵ������ļ�����ʹ�û���" & @CRLF & "         �ŵ���ÿ��������ӡ���������ʹ��",  0, 8, 308, 25)
;$Input1 = GUICtrlCreateInput("", 112, 56, 169, 21)
;$Label2 = GUICtrlCreateLabel("��������", 32, 60, 52, 17)
$Label3 = GUICtrlCreateLabel("���������", 28, 92, 72, 17)
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
			csh()
			Exit
	EndSelect
WEnd

Func csh()
	$I = IniRead(@ScriptDir & "\��ȡ�ط��б�����(ÿ���������)(Netviewer).ini", "�б�", "���������","")
	$J = IniRead(@ScriptDir & "\��ȡ�ط��б�����(ÿ���������)(91IE).ini", "�б�", "���������","")
	$K = IniRead(@ScriptDir & "\��ȡ�ط��б�����(ÿ���������)(90IE).ini", "�б�", "���������","")
If $I > 0 Then
	IniWrite(@ScriptDir & "\��ȡ�ط��б�����(ÿ���������)(Netviewer).ini", "�б�", "���������", GUICtrlRead ($Input2)) 
	
ElseIf $J > 0 Then
	IniWrite(@ScriptDir & "\��ȡ�ط��б�����(ÿ���������)(91IE).ini", "�б�", "���������",GUICtrlRead ($Input2)) 
	
ElseIf $K > 0 Then
	IniWrite(@ScriptDir & "\��ȡ�ط��б�����(ÿ���������)(90IE).ini", "�б�", "���������",GUICtrlRead ($Input2)) 
EndIf

EndFunc