#Region ACNԤ����������(���ò���)
#PRE_Icon= 										;ͼ��,֧��EXE,DLL,ICO
#PRE_OutFile=									;����ļ���
#PRE_OutFile_Type=exe							;�ļ�����
#PRE_Compression=4								;ѹ���ȼ�
#PRE_UseUpx=y 									;ʹ��ѹ��
#PRE_Res_Comment= 								;����ע��
#PRE_Res_Description=							;��ϸ��Ϣ
#PRE_Res_Fileversion=							;�ļ��汾
#PRE_Res_FileVersion_AutoIncrement=p			;�Զ����°汾
#PRE_Res_LegalCopyright= 						;��Ȩ
#PRE_Change2CUI=N                   			;�޸�����ĳ���ΪCUI(����̨����)
;#PRE_Res_Field=AutoIt Version|%AutoItVer%		;�Զ�����Դ��
;#PRE_Run_Tidy=                   				;�ű�����
;#PRE_Run_Obfuscator=      						;�����Ի�
;#PRE_Run_AU3Check= 							;�﷨���
;#PRE_Run_Before= 								;����ǰ
;#PRE_Run_After=								;���к�
;#PRE_UseX64=n									;ʹ��64λ������
;#PRE_Compile_Both								;����˫ƽ̨����
#EndRegion ACNԤ�����������������
#cs �ߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣ�

 Au3 �汾: 
 �ű�����: 
 �����ʼ�: 
	QQ/TM: 
 �ű��汾: 
 �ű�����: 

#ce �ߣߣߣߣߣߣߣߣߣߣߣߣߣߣ߽ű���ʼ�ߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣ�

#include<MsgBoxDJS.au3>
#Include <GuiComboBox.au3>
WinActivate("Remote Setup(14)")
$CH = ControlGetHandle ("Remote Setup(14)","","ComboBox25")
_GUICtrlComboBox_SetCurSel($CH,0)
sl()
$C = ControlGetHandle ("Remote Setup(14)","","ComboBox32")
_GUICtrlComboBox_SetCurSel($C,1)
ControlCommand ( "Netviewer","","ComboBox32", "SetCurrentSelection", "")
sl()
save()
Sleep(1000)
$CH = ControlGetHandle ("Remote Setup(14)","","ComboBox25")
_GUICtrlComboBox_SetCurSel($CH,1)
sl()
$C = ControlGetHandle ("Remote Setup(14)","","ComboBox32")
_GUICtrlComboBox_SetCurSel($C,1)
$A = ControlGetHandle ("Remote Setup(14)","","ComboBox31")
_GUICtrlComboBox_SetCurSel($A,0)
ControlClick("Remote Setup(14)","Save","Button3")
WinWait("Warnning:","OK")
ControlClick("Warnning:","OK","Button1")
Sleep(1000)
;
#cs
$CH = ControlGetHandle ("Remote Setup(14)","","ComboBox25")
_GUICtrlComboBox_SetCurSel($CH,0)
$P = ControlGetHandle ("Remote Setup(14)","","ComboBox26")
_GUICtrlComboBox_SetCurSel($P,1)
$B = ControlGetHandle ("Remote Setup(14)","","ComboBox30")
_GUICtrlComboBox_SetCurSel($B,1)
$D = ControlGetHandle ("Remote Setup(14)","","ComboBox27")
_GUICtrlComboBox_SetCurSel($D,3)
$S = ControlGetHandle ("Remote Setup(14)","","ComboBox28")
_GUICtrlComboBox_SetCurSel($S,1)
$P = ControlGetHandle ("Remote Setup(14)","","ComboBox29")
_GUICtrlComboBox_SetCurSel($P,3)
$C = ControlGetHandle ("Remote Setup(14)","","ComboBox32")
_GUICtrlComboBox_SetCurSel($C,1)
$A = ControlGetHandle ("Remote Setup(14)","","ComboBox31")
_GUICtrlComboBox_SetCurSel($A,254)

copy()
save()
#ce

Func copy()
	ControlClick("Remote Setup(14)","","Button95")
	sl()
	Send("{tab 3}")
	Send("{space}")
	sl()
	Send("{enter}")
EndFunc

Func save()
	ControlClick("Remote Setup(14)","Save","Button3")
	sl()
	$var = ControlGetText("Remote Setup(14)", "Save PTZ Succeed!", "Static1");��ȡָ���ؼ��ϵ��ı�.
	$I=StringCompare($var,"Save PTZ Succeed!");��ѡ��Ƚ������ַ���.
 If $I = 0 Then   ; �ַ���1 ���� �ַ���2
	$msg = MsgBoxDJS(0 + 48 + 4, '�����Ѿ�����ɹ�', '��԰�ˣ�' & @CRLF & '�Ƿ������', 5, 2)
EndIf



EndFunc

Func sl()
	Sleep(500)
EndFunc	