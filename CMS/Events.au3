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

;Disk No Space
WinActivate("Remote Setup(14)")
$E = ControlGetHandle ("Remote Setup(14)","","ComboBox2")
_GUICtrlComboBox_SetCurSel($E,0)
sl()
ControlClick("Remote Setup(14)","Send Email","Button18")
sl()
ControlClick("Remote Setup(14)","Show Message","Button17")
sl()
$L = ControlGetHandle ("Remote Setup(14)","","ComboBox4")
_GUICtrlComboBox_SetCurSel($L,1)
sl()
$B = ControlGetHandle ("Remote Setup(14)","","ComboBox3")
_GUICtrlComboBox_SetCurSel($B,2)
sl()
ControlClick("Remote Setup(14)","Alarm Out","Button15")
sl()
ControlClick("Remote Setup(14)","Enable","Button14")
sl()
save()

;Disk Error
WinActivate("Remote Setup(14)")
$E = ControlGetHandle ("Remote Setup(14)","","ComboBox2")
_GUICtrlComboBox_SetCurSel($E,1)
	;$msg = MsgBoxDJS(0 + 48 + 4, '�����Ѿ�����ɹ�', '��԰�ˣ�' & @CRLF & '�Ƿ������', 5, 2)
sl()
ControlClick("Remote Setup(14)","Refresh","Button2")
sl()
;$msg = MsgBoxDJS(0 + 48 + 4, '�����Ѿ�����ɹ�', '��԰�ˣ�' & @CRLF & '�Ƿ������', 5, 2)
ControlClick("Remote Setup(14)","","ComboBox2","left",2)
Send("{down}")
sl()


ControlClick("Remote Setup(14)","Send Email","Button18")

ControlClick("Remote Setup(14)","Show Message","Button17")
sl()
$L = ControlGetHandle ("Remote Setup(14)","","ComboBox4")
_GUICtrlComboBox_SetCurSel($L,2)
sl()
$B = ControlGetHandle ("Remote Setup(14)","","ComboBox3")
_GUICtrlComboBox_SetCurSel($B,3)
sl()
ControlClick("Remote Setup(14)","Alarm Out","Button15")
sl()
ControlClick("Remote Setup(14)","Enable","Button14")
sl()
save()

;Video Loss
WinActivate("Remote Setup(14)")
$E = ControlGetHandle ("Remote Setup(14)","","ComboBox2")
_GUICtrlComboBox_SetCurSel($E,1)
	;$msg = MsgBoxDJS(0 + 48 + 4, '�����Ѿ�����ɹ�', '��԰�ˣ�' & @CRLF & '�Ƿ������', 5, 2)
sl()
ControlClick("Remote Setup(14)","Refresh","Button2")
sl()
;$msg = MsgBoxDJS(0 + 48 + 4, '�����Ѿ�����ɹ�', '��԰�ˣ�' & @CRLF & '�Ƿ������', 5, 2)
ControlClick("Remote Setup(14)","","ComboBox2","left",2)
Send("{down 2}")
sl()

ControlClick("Remote Setup(14)","Send Email","Button18")
sl()
ControlClick("Remote Setup(14)","Show Message","Button17")
sl()
$L = ControlGetHandle ("Remote Setup(14)","","ComboBox4")
_GUICtrlComboBox_SetCurSel($L,3)
sl()
$B = ControlGetHandle ("Remote Setup(14)","","ComboBox3")
_GUICtrlComboBox_SetCurSel($B,4)
sl()
ControlClick("Remote Setup(14)","Alarm Out","Button15")
sl()
ControlClick("Remote Setup(14)","Enable","Button14")
sl()
save()


Func save()
	ControlClick("Remote Setup(14)","Save","Button3")
	sl()
	$var = ControlGetText("Remote Setup(14)", "Save Events Succeed!", "Static1");��ȡָ���ؼ��ϵ��ı�.
	$I=StringCompare($var,"Save Events Succeed!");��ѡ��Ƚ������ַ���.
 If $I = 0 Then   ; �ַ���1 ���� �ַ���2
	$msg = MsgBoxDJS(0 + 48 + 4, '�����Ѿ�����ɹ�', '��԰�ˣ�' & @CRLF & '�Ƿ������', 5, 2)
 EndIf

EndFunc

Func sl()
	Sleep(500)
EndFunc	