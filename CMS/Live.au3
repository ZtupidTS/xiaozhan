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
;$1 = WinGetTitle("#32770", "Check All");��ȡ���ڱ���
;MsgBox(1,"@2",$1 )

;�ر�����ͨ��Ԥ��
$P = ControlGetHandle ("Remote Setup(14)","","ComboBox24")
_GUICtrlComboBox_SetCurSel($P,4)
$C = ControlGetHandle ("Remote Setup(14)","","ComboBox23")
_GUICtrlComboBox_SetCurSel($C,0)
$S = ControlGetHandle ("Remote Setup(14)","","ComboBox20")
_GUICtrlComboBox_SetCurSel($S,0)
$R = ControlGetHandle ("Remote Setup(14)","","ComboBox21")
_GUICtrlComboBox_SetCurSel($R,0)

copy()

save()

;������ͨ��Ԥ��
WinActivate("Remote Setup(14)")
$P = ControlGetHandle ("Remote Setup(14)","","ComboBox24")
_GUICtrlComboBox_SetCurSel($P,0)
$C = ControlGetHandle ("Remote Setup(14)","","ComboBox23")
_GUICtrlComboBox_SetCurSel($C,1)
$S = ControlGetHandle ("Remote Setup(14)","","ComboBox20")
_GUICtrlComboBox_SetCurSel($S,1)
$R = ControlGetHandle ("Remote Setup(14)","","ComboBox21")
_GUICtrlComboBox_SetCurSel($R,1)

copy()

save()

;����ͨ������
WinActivate("Remote Setup(14)")
;CH1
$C = ControlGetHandle ("Remote Setup(14)","","ComboBox22")
_GUICtrlComboBox_SetCurSel($C,0)
ControlClick("Remote Setup(14)","","Edit12","left",2)
Send("111")
sl()

save()

;CH2
$C = ControlGetHandle ("Remote Setup(14)","","ComboBox22")
_GUICtrlComboBox_SetCurSel($C,1)
ControlClick("Remote Setup(14)","","Edit12","left",2)
Send("222")
sl()
$P = ControlGetHandle ("Remote Setup(14)","","ComboBox24")
_GUICtrlComboBox_SetCurSel($P,1)
sl()

save()

;CH3
$C = ControlGetHandle ("Remote Setup(14)","","ComboBox22")
_GUICtrlComboBox_SetCurSel($C,2)
ControlClick("Remote Setup(14)","","Edit12","left",2)
Send("333")
sl()
$P = ControlGetHandle ("Remote Setup(14)","","ComboBox24")
_GUICtrlComboBox_SetCurSel($P,2)
sl()

save()

;CH4
$C = ControlGetHandle ("Remote Setup(14)","","ComboBox22")
_GUICtrlComboBox_SetCurSel($C,3)
ControlClick("Remote Setup(14)","","Edit12","left",2)
Send("444")
sl()
$P = ControlGetHandle ("Remote Setup(14)","","ComboBox24")
_GUICtrlComboBox_SetCurSel($P,3)
sl()

save()



Func copy()
	ControlClick("Remote Setup(14)","","Button94")
	sl()
	Send("{tab 3}")
	Send("{space}")
	sl()
	Send("{enter}")
EndFunc

Func save()
	ControlClick("Remote Setup(14)","Save","Button3")
	sl()
	$var = ControlGetText("Remote Setup(14)", "Save Live Succeed!", "Static1");��ȡָ���ؼ��ϵ��ı�.
	$I=StringCompare($var,"Save Live Succeed!");��ѡ��Ƚ������ַ���.
 If $I = 0 Then   ; �ַ���1 ���� �ַ���2
	$msg = MsgBoxDJS(0 + 48 + 4, '�����Ѿ�����ɹ�', '��԰�ˣ�' & @CRLF & '�Ƿ������', 5, 2)
 EndIf

EndFunc

Func sl()
	Sleep(500)
EndFunc	