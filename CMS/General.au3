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

WinActivate("Remote Setup(14)","")

;12
$D = ControlGetHandle ("Remote Setup(14)","","ComboBox50")
_GUICtrlComboBox_SetCurSel($D,1)
$TF = ControlGetHandle ("Remote Setup(14)","","ComboBox49")
_GUICtrlComboBox_SetCurSel($TF,1)
$M = ControlGetHandle ("Remote Setup(14)","","ComboBox61")
_GUICtrlComboBox_SetCurSel($M,5)
;����ʱ
ControlClick("Remote Setup(14)","Daylight Saving Time","Button107")
$TO = ControlGetHandle ("Remote Setup(14)","","ComboBox52")
_GUICtrlComboBox_SetCurSel($TO,1)
sl()
;week ;����Ϊ��ʼʱ�䣬˫��Ϊ����ʱ��
$1 = ControlGetHandle ("Remote Setup(14)","","ComboBox53")
_GUICtrlComboBox_SetCurSel($1,0)
sl()
$2 = ControlGetHandle ("Remote Setup(14)","","ComboBox56")
_GUICtrlComboBox_SetCurSel($2,11)
sl()
$3 = ControlGetHandle ("Remote Setup(14)","","ComboBox54")
_GUICtrlComboBox_SetCurSel($3,2)
sl()
$4 = ControlGetHandle ("Remote Setup(14)","","ComboBox57")
_GUICtrlComboBox_SetCurSel($4,3)
sl()
$5 = ControlGetHandle ("Remote Setup(14)","","ComboBox55")
_GUICtrlComboBox_SetCurSel($5,1)
sl()
$6 = ControlGetHandle ("Remote Setup(14)","","ComboBox58")
_GUICtrlComboBox_SetCurSel($6,6)
sl()

;��ʼʱ��
ControlClick("Remote Setup(14)","","SysDateTimePick327","left",2,12, 11)
Send("12")
sl()
Send("{right}")
sl()
Send("12")
sl()
Send("{right}")
sl()
Send("12")
sl()
;����ʱ��
ControlClick("Remote Setup(14)","","SysDateTimePick328","left",2,12, 11)
Send("22")
sl()
Send("{right}")
sl()
Send("22")
sl()
Send("{right}")
sl()
Send("22")
sl()
save()

;24
$D = ControlGetHandle ("Remote Setup(14)","","ComboBox50")
_GUICtrlComboBox_SetCurSel($D,2)
$T = ControlGetHandle ("Remote Setup(14)","","ComboBox49")
_GUICtrlComboBox_SetCurSel($T,0)



ControlClick("Remote Setup(14)","","ComboBox51","left",2)
Send("{down}")
;��ʼʱ��11
;��
sl()
ControlClick("Remote Setup(14)","","SysDateTimePick322","left",2,14, 13)
Send("2015")
sl()
Send("{right}")
sl()
Send("10")
sl()
Send("{right}")
sl()
Send("10")
sl()
;ʱ��
ControlClick("Remote Setup(14)","","SysDateTimePick323","left",2,12, 12)
Send("12")
sl()
Send("{right}")
sl()
Send("12")
sl()
Send("{right}")
sl()
Send("12")
sl()

;����ʱ��
;��
ControlClick("Remote Setup(14)","","SysDateTimePick324","left",2,14, 11)
Send("2036")
sl()
Send("{right}")
sl()
Send("11")
sl()
Send("{right}")
sl()
Send("11")
sl()

;ʱ��
ControlClick("Remote Setup(14)","","SysDateTimePick325","left",2,14, 12)
Send("22")
sl()
Send("{right}")
sl()
Send("22")
sl()
Send("{right}")
sl()
Send("22")
sl()
save()


$D = ControlGetHandle ("Remote Setup(14)","","ComboBox50")
_GUICtrlComboBox_SetCurSel($D,0)
ControlClick("Remote Setup(14)","Enable NTP","Button112")
$D = ControlGetHandle ("Remote Setup(14)","","ComboBox59")
_GUICtrlComboBox_SetCurSel($D,0)
save()





Func save()
	ControlClick("Remote Setup(14)","Save","Button3")
	sl()
	$var = ControlGetText("Remote Setup(14)", "Save General Succeed!", "Static1");��ȡָ���ؼ��ϵ��ı�.
	$I=StringCompare($var,"Save General Succeed!");��ѡ��Ƚ������ַ���.
 If $I = 0 Then   ; �ַ���1 ���� �ַ���2
	$msg = MsgBoxDJS(0 + 48 + 4, '�����Ѿ�����ɹ�', '��԰�ˣ�' & @CRLF & '�Ƿ������', 5, 2)
 EndIf

EndFunc

Func sl()
	Sleep(500)
EndFunc	