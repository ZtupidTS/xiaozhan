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
$S = ControlGetHandle ("Remote Setup(14)","","ComboBox11")
_GUICtrlComboBox_SetCurSel($S,0)
$P = ControlGetHandle ("Remote Setup(14)","","ComboBox13")
_GUICtrlComboBox_SetCurSel($P,3)
ControlClick("Remote Setup(14)","Alarm Out","Button83")
$L = ControlGetHandle ("Remote Setup(14)","","ComboBox14")
_GUICtrlComboBox_SetCurSel($L,3)
$B = ControlGetHandle ("Remote Setup(14)","","ComboBox12")
_GUICtrlComboBox_SetCurSel($B,4)
sl()
ControlClick("Remote Setup(14)","Show Message","Button85")
sl()
ControlClick("Remote Setup(14)","Send Email","Button86")
sl()
ControlClick("Remote Setup(14)","Full Screen","Button84")
sl()
ControlClick("Remote Setup(14)","Check All","Button91")
sl()
ControlClick("Remote Setup(14)","Record Channel","Button65")
sl()
ControlClick("Remote Setup(14)","Enable","Button63")

copy()
save()

Func copy()
	ControlClick("Remote Setup(14)","","Button87")
	sl()
	Send("{tab 3}")
	Send("{space}")
	sl()
	Send("{enter}")
EndFunc


Func save()
	ControlClick("Remote Setup(14)","Save","Button3")
	sl()
	$var = ControlGetText("Remote Setup(14)", "Save Motion Succeed!", "Static1");��ȡָ���ؼ��ϵ��ı�.
	$I=StringCompare($var,"Save Motion Succeed!");��ѡ��Ƚ������ַ���.
 If $I = 0 Then   ; �ַ���1 ���� �ַ���2
	$msg = MsgBoxDJS(0 + 48 + 4, '�����Ѿ�����ɹ�', '��԰�ˣ�' & @CRLF & '�Ƿ������', 5, 2)
 EndIf

EndFunc

Func sl()
	Sleep(500)
EndFunc	