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
#Include <GuiListView.au3>
#include<MsgBoxDJS.au3>
#Include <GuiComboBox.au3>
Local $xiaozhan ,$xiaoxiao, $count ,$aList, $x 

WinActivate("Remote Setup(14)")

$xiaozhan = ControlGetHandle ( "Remote Setup(14)", "", "ListBox1")  ;��ȡָ���ؼ����ڲ����.


$xiaoxiao = _GUICtrlListView_GetISearchString($xiaozhan) ;��ȡ�ؼ������������ַ���
$count = _GUICtrlListView_GetItemCount($xiaozhan) ;��ȡ�б���ͼ�ؼ�����Ŀ��
$aList = _GUICtrlListView_GetItemText($xiaozhan,0)  ;��ȡ��Ŀ������Ŀ���ı�
MsgBox(4160, "Information", "Item Count: ", $xiaoxiao)
MsgBox(4160, "Information", "Item Count: ", $count)
MsgBox(4160, "Information", "Item Count: ", $aList)
MsgBox(4160, "Information", "Item Count: " & _GUICtrlListView_GetItemCount($xiaozhan))

For $x = 0 To $count-1
	$aList = _GUICtrlListView_GetItemText($xiaozhan,$x) ;��ȡ��Ŀ������Ŀ���ı�
	if $aList = "user1" Then		
		_GUICtrlListView_ClickItem( $xiaozhan, $x ,"left","",1)  ;���һ����Ŀ
		ConsoleWrite( $aList & @CRLF )  ;д�����ݵ� STDOUT ��.һЩ�ı��༭�����Զ�ȡ�������Ϊ��������ɽ��ܵ�����.
	EndIf
Next