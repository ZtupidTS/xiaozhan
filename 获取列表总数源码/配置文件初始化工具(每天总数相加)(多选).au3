#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
$I = IniRead(@ScriptDir & "\��ȡ�ط��б�����(ÿ���������)(Netviewer).ini", "�б�", "���������","")
$J = IniRead(@ScriptDir & "\��ȡ�ط��б�����(ÿ���������)(91IE).ini", "�б�", "���������","")
$K = IniRead(@ScriptDir & "\��ȡ�ط��б�����(ÿ���������)(90IE).ini", "�б�", "���������","")
$Form1 = GUICreate("�����ļ���ʼ������(ÿ���������)", 319, 240, 187, 124)
$Input2 = GUICtrlCreateInput("", 112, 152, 169, 21,$ES_READONLY)
$Button1 = GUICtrlCreateButton("ȷ��", 64, 192, 65, 25)
$Button2 = GUICtrlCreateButton("ȡ��", 188, 192, 65, 25)
$Label1 = GUICtrlCreateLabel("         ��ѱ�����ŵ������ļ�����ʹ�û���" & @CRLF & "         �ŵ���ÿ��������ӡ���������ʹ��",  0, 8, 308, 25)
$Label3 = GUICtrlCreateLabel("���������", 28, 156, 72, 17)
$Checkbox1 = GUICtrlCreateCheckbox($I, 152, 48, 161, 17)
$Checkbox2 = GUICtrlCreateCheckbox($J, 152, 80, 161, 17)
$Checkbox3 = GUICtrlCreateCheckbox($K, 152, 112, 161, 17)
$Label2 = GUICtrlCreateLabel("Netviewer���������", 32, 51, 120, 17)
$Label4 = GUICtrlCreateLabel("91IE���������", 64, 83, 86, 17)
$Label6 = GUICtrlCreateLabel("90IE���������", 64, 115, 86, 17)
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
	If BitAND(GUICtrlRead($Checkbox1), $GUI_CHECKED) Then
		IniWrite(@ScriptDir & "\��ȡ�ط��б�����(ÿ���������)(Netviewer).ini", "�б�", "���������", GUICtrlRead ($Input2)) 
	ElseIf BitAND(GUICtrlRead($Checkbox2), $GUI_CHECKED) Then
		IniWrite(@ScriptDir & "\��ȡ�ط��б�����(ÿ���������)(91IE).ini", "�б�", "���������",GUICtrlRead ($Input2))
	ElseIf BitAND(GUICtrlRead($Checkbox3), $GUI_CHECKED) Then	
		IniWrite(@ScriptDir & "\��ȡ�ط��б�����(ÿ���������)(90IE).ini", "�б�", "���������",GUICtrlRead ($Input2)) 
	EndIf
	
	If BitAND(GUICtrlRead($Checkbox1), $GUI_CHECKED) And BitAND(GUICtrlRead($Checkbox2), $GUI_CHECKED) Then ;BitAnd �Ƚ�ǰ������ֵ
				GUISetState($Checkbox3, $GUI_UNCHECKED)
				IniWrite(@ScriptDir & "\��ȡ�ط��б�����(ÿ���������)(Netviewer).ini", "�б�", "���������", GUICtrlRead ($Input2)) 
				IniWrite(@ScriptDir & "\��ȡ�ط��б�����(ÿ���������)(91IE).ini", "�б�", "���������",GUICtrlRead ($Input2))
			Else
				GUISetState($Checkbox1, $GUI_UNCHECKED)
				GUISetState($Checkbox2, $GUI_UNCHECKED)
				GUISetState($Checkbox3, $GUI_CHECKED)
			EndIf

			If BitAND(GUICtrlRead($Checkbox2), $GUI_CHECKED) And BitAND(GUICtrlRead($Checkbox3), $GUI_CHECKED) Then
				GUISetState($Checkbox1, $GUI_UNCHECKED)
				IniWrite(@ScriptDir & "\��ȡ�ط��б�����(ÿ���������)(91IE).ini", "�б�", "���������",GUICtrlRead ($Input2))
				IniWrite(@ScriptDir & "\��ȡ�ط��б�����(ÿ���������)(90IE).ini", "�б�", "���������",GUICtrlRead ($Input2))
			Else
				GUISetState($Checkbox2, $GUI_UNCHECKED)
				GUISetState($Checkbox1, $GUI_CHECKED)
				GUISetState($Checkbox3, $GUI_UNCHECKED)
			EndIf

			If BitAND(GUICtrlRead($Checkbox3), $GUI_CHECKED) And BitAND(GUICtrlRead($Checkbox1), $GUI_CHECKED)Then
				GUISetState($Checkbox2, $GUI_UNCHECKED)
				IniWrite(@ScriptDir & "\��ȡ�ط��б�����(ÿ���������)(Netviewer).ini", "�б�", "���������", GUICtrlRead ($Input2))
				IniWrite(@ScriptDir & "\��ȡ�ط��б�����(ÿ���������)(90IE).ini", "�б�", "���������",GUICtrlRead ($Input2)) 
			Else
				GUISetState($Checkbox3, $GUI_UNCHECKED)
				GUISetState($Checkbox1, $GUI_UNCHECKED)
				GUISetState($Checkbox2, $GUI_CHECKED)
			EndIf


EndFunc