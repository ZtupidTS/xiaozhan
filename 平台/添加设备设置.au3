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
#include <GuiListView.au3>


HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")

Local $j =10001 , $Paused 
$i = 0
Do

WinActivate("����(RaySee) -- ����ͻ���")
$hListView1 = ControlGetHandle ( "����(RaySee) -- ����ͻ���", "List1", "SysListView3223")
_GUICtrlListView_ClickItem($hListView1, 1, "right", True, 1)
Send("{down}")
Send("{enter}")
WinWait("ҵ����Ӵ���","","Edit2")

WinActivate("ҵ����Ӵ���")
ControlClick("ҵ����Ӵ���","","Edit2")
Send($j)
$hListView = ControlGetHandle ( "ҵ����Ӵ���", "List1", "SysListView321")
 _GUICtrlListView_SetItemChecked($hListView, 0);�б�������checkbox��ѡ����
 ControlClick("ҵ����Ӵ���","ȷ��","Button1")
 
 $j=$j+1
 
  $i = $i + 1
Until $i = 5

Func Terminate()
	Exit 0
EndFunc

Func Togglepause()
    $Paused = NOT $Paused 
	
   While $Paused 
	tooltip("��ͣһ��",0,0)
	sleep(100)
   tooltip("")
   WEnd
EndFunc
