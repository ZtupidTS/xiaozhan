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
#Include <GuiComboBox.au3>
#include<MsgBoxDJS.au3>
WinActivate("Remote Setup(14)")
;�ر�¼����� ����15���ʱ��

$C = ControlGetHandle ("Remote Setup(14)","","ComboBox42")
_GUICtrlComboBox_SetCurSel($C,0)
$R = ControlGetHandle ("Remote Setup(14)","","ComboBox46")
_GUICtrlComboBox_SetCurSel($R,0)
sl()
$Pa = ControlGetHandle ("Remote Setup(14)","","ComboBox44")
_GUICtrlComboBox_SetCurSel($Pa,0)
sl()
$Pr = ControlGetHandle ("Remote Setup(14)","","ComboBox45")
_GUICtrlComboBox_SetCurSel($Pr,0)
sl()

copy()
save()

$C = ControlGetHandle ("Remote Setup(14)","","ComboBox42")
_GUICtrlComboBox_SetCurSel($C,0)
$R = ControlGetHandle ("Remote Setup(14)","","ComboBox46")
_GUICtrlComboBox_SetCurSel($R,1)
sl()
$Pa = ControlGetHandle ("Remote Setup(14)","","ComboBox44")
_GUICtrlComboBox_SetCurSel($Pa,1)
sl()
$Pr = ControlGetHandle ("Remote Setup(14)","","ComboBox45")
_GUICtrlComboBox_SetCurSel($Pr,1)
sl()

copy()
save()

$Pa = ControlGetHandle ("Remote Setup(14)","","ComboBox44")
_GUICtrlComboBox_SetCurSel($Pa,2)
sl()
save()

$Pa = ControlGetHandle ("Remote Setup(14)","","ComboBox44")
_GUICtrlComboBox_SetCurSel($Pa,3)
sl()
save()

Func sl()
	Sleep(500)
EndFunc	


Func copy()
	ControlClick("Remote Setup(14)","","Button102")
	sl()
	Send("{tab 3}")
	sl()
	Send("{space}")
	sl()
	Send("{enter}")
EndFunc

Func save()
	ControlClick("Remote Setup(14)","Save","Button3")
	sl()
	$var = ControlGetText("Remote Setup(14)", "Save Rec Para Succeed!", "Static1");��ȡָ���ؼ��ϵ��ı�.
	$I=StringCompare($var,"Save Rec Para Succeed!");��ѡ��Ƚ������ַ���.
 If $I = 0 Then   ; �ַ���1 ���� �ַ���2
	$msg = MsgBoxDJS(0 + 48 + 4, '�����Ѿ�����ɹ�', '��԰�ˣ�' & @CRLF & '�Ƿ������', 5, 2)
EndIf

EndFunc





;����ʹ�÷���
#cs

$C = ControlGetHandle ("Remote Setup(14)","","ComboBox42")
_GUICtrlComboBox_SetCurSel($C,0)
$R = ControlGetHandle ("Remote Setup(14)","","ComboBox46")
_GUICtrlComboBox_SetCurSel($R,0)
sl()
$Pa = ControlGetHandle ("Remote Setup(14)","","ComboBox44")
_GUICtrlComboBox_SetCurSel($Pa,0)
sl()
$Pr = ControlGetHandle ("Remote Setup(14)","","ComboBox45")
_GUICtrlComboBox_SetCurSel($Pr,0)
sl()
save()
;CH2
$C = ControlGetHandle ("Remote Setup(14)","","ComboBox42")
_GUICtrlComboBox_SetCurSel($C,1)
$R = ControlGetHandle ("Remote Setup(14)","","ComboBox46")
_GUICtrlComboBox_SetCurSel($R,0)
sl()
save()
;CH3
$C = ControlGetHandle ("Remote Setup(14)","","ComboBox42")
_GUICtrlComboBox_SetCurSel($C,2)
$R = ControlGetHandle ("Remote Setup(14)","","ComboBox46")
_GUICtrlComboBox_SetCurSel($R,0)
sl()
save()
;CH4
$C = ControlGetHandle ("Remote Setup(14)","","ComboBox42")
_GUICtrlComboBox_SetCurSel($C,3)
$R = ControlGetHandle ("Remote Setup(14)","","ComboBox46")
_GUICtrlComboBox_SetCurSel($R,0)
sl()

save()





;��¼����� ����30���ʱ��
;CH1

$C = ControlGetHandle ("Remote Setup(14)","","ComboBox42")
_GUICtrlComboBox_SetCurSel($C,0)
$R = ControlGetHandle ("Remote Setup(14)","","ComboBox46")
_GUICtrlComboBox_SetCurSel($R,1)
sl()
$Pa = ControlGetHandle ("Remote Setup(14)","","ComboBox44")
_GUICtrlComboBox_SetCurSel($Pa,1)
sl()
$Pr = ControlGetHandle ("Remote Setup(14)","","ComboBox45")
_GUICtrlComboBox_SetCurSel($Pr,1)
sl()
save()
;CH2
$C = ControlGetHandle ("Remote Setup(14)","","ComboBox42")
_GUICtrlComboBox_SetCurSel($C,1)
$R = ControlGetHandle ("Remote Setup(14)","","ComboBox46")
_GUICtrlComboBox_SetCurSel($R,1)
sl()
save()
;CH3
$C = ControlGetHandle ("Remote Setup(14)","","ComboBox42")
_GUICtrlComboBox_SetCurSel($C,2)
$R = ControlGetHandle ("Remote Setup(14)","","ComboBox46")
_GUICtrlComboBox_SetCurSel($R,1)
sl()
save()
;CH4
$C = ControlGetHandle ("Remote Setup(14)","","ComboBox42")
_GUICtrlComboBox_SetCurSel($C,3)
$R = ControlGetHandle ("Remote Setup(14)","","ComboBox46")
_GUICtrlComboBox_SetCurSel($R,1)
sl()

save()

$Pa = ControlGetHandle ("Remote Setup(14)","","ComboBox44")
_GUICtrlComboBox_SetCurSel($Pa,2)
sl()
save()

$Pa = ControlGetHandle ("Remote Setup(14)","","ComboBox44")
_GUICtrlComboBox_SetCurSel($Pa,3)
sl()
save()
#ce