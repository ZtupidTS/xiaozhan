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
WinActivate("Remote Setup(14)")
ControlClick("Remote Setup(14)","","Static129","left",1,25, 11)
sl()
ControlClick("Remote Setup(14)","","Static130","left",1,29, 10)
sl()
ControlClick("Remote Setup(14)","Copy","Button105")
sl()
Send("{tab 6}")
copy()
ControlClick("Remote Setup(14)","Copy","Button103")
sl()
Send("{tab 3}")
copy()
save()

Func sl()
	Sleep(500)
EndFunc	


Func copy()	
	sl()
	Send("{space}")
	sl()
	Send("{enter}")
EndFunc


Func save()
	ControlClick("Remote Setup(14)","Save","Button3")
	sl()
	$var = ControlGetText("Remote Setup(14)", "Save Schedule Succeed!", "Static1");��ȡָ���ؼ��ϵ��ı�.
	$I=StringCompare($var,"Save Schedule Succeed!");��ѡ��Ƚ������ַ���.
 If $I = 0 Then   ; �ַ���1 ���� �ַ���2
	$msg = MsgBoxDJS(0 + 48 + 4, '�����Ѿ�����ɹ�', '��԰�ˣ�' & @CRLF & '�Ƿ������', 5, 2)
EndIf

EndFunc