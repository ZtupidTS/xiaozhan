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
$A = ControlGetHandle ("Remote Setup(14)","","ComboBox6")
_GUICtrlComboBox_SetCurSel($A,2)
sl()
$L = ControlGetHandle ("Remote Setup(14)","","ComboBox9")
_GUICtrlComboBox_SetCurSel($L,3)
sl()
$B = ControlGetHandle ("Remote Setup(14)","","ComboBox7")
_GUICtrlComboBox_SetCurSel($B,4)
sl()
$P = ControlGetHandle ("Remote Setup(14)","","ComboBox8")
_GUICtrlComboBox_SetCurSel($P,3)
sl()

ControlClick("Remote Setup(14)","Record Channel","Button20")
sl()
ControlClick("Remote Setup(14)","Check All","Button61")
sl()
ControlClick("Remote Setup(14)","Alarm Out","Button37")
sl()
ControlClick("Remote Setup(14)","Show Message","Button39")
sl()
ControlClick("Remote Setup(14)","Send Email","Button40")
sl()
ControlClick("Remote Setup(14)","Full Screen","Button38")
sl()

copy()
save()

Func copy()
	ControlClick("Remote Setup(14)","","Button41")
	sl()
	Send("{tab 3}")
	Send("{space}")
	sl()
	Send("{enter}")
EndFunc


Func save()
	ControlClick("Remote Setup(14)","Save","Button3")
	sl()
	$var = ControlGetText("Remote Setup(14)", "Save Alarm Succeed!", "Static1");��ȡָ���ؼ��ϵ��ı�.
	$I=StringCompare($var,"Save Alarm Succeed!");��ѡ��Ƚ������ַ���.
 If $I = 0 Then   ; �ַ���1 ���� �ַ���2
	$msg = MsgBoxDJS(0 + 48 + 4, '�����Ѿ�����ɹ�', '��԰�ˣ�' & @CRLF & '�Ƿ������', 5, 2)
 EndIf

EndFunc

Func sl()
	Sleep(500)
EndFunc	