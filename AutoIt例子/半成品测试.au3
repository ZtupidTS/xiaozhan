#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=F:\����ͶӰ���Խű�\ico\ȫ����Խű�(��¼����).ico
#AutoIt3Wrapper_outfile=F:\����ͶӰ���Խű�\���Ʒ����.exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
HotKeySet("!a", "ShowMessage")          ;ALT+a ע�ͷ��ţ�����
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z


	  
;��¼ģ��
;Run("C:\Program Files\FT-200W-zh\FT-200W.exe","C:\Program Files\FT-200W-zh", "")
;Sleep(3000)  ;ʹ�ű���ָͣ��ʱ���.;(5000Ϊ5��)
;Opt("WinTitleMatchMode", 4)
;WinWait("[CLASS:Edit; INSTANCE:1]","",5)
;BlockInput(1)
;$var = ControlGetText("[CLASS:#32770]", "", "Edit1")
;ControlClick( "[CLASS:#32770]", "", "Edit1")
;WinWaitActive("[CLASS:#32770]")
;Send("4612")  ;
;BlockInput(0)
;ControlClick( "[CLASS:#32770]", "", "[ID:1012]") ;��ָ���ؼ��������������
;Sleep(1000*10)  
WinActivate ( "FT-200W","" );����ָ���Ĵ���(���ý��㵽�ô���,ʹ���Ϊ�����).
;����ͶӰģ��
ControlClick( "FT-200W", "", "[ID:1000]")
Sleep(3000) 
;�ر�ͶӰģ��
WinActivate ( "FT-200W","" )
ControlClick( "FT-200W", "", "[ID:1000]") 
Sleep(5000) 
;����ͶӰģ��
WinActivate ( "FT-200W","" )
ControlClick( "FT-200W", "", "[ID:1001]")
Sleep(3000)  
;�ر�ͶӰģ��
WinActivate ( "FT-200W","" )
ControlClick( "FT-200W", "", "[ID:1001]") 
Sleep(3000) 
;��������ģ��
WinActivate ( "FT-200W","" )
ControlClick( "FT-200W", "", "[ID:1003]") 
Sleep(3000) 
;�رպ���ģ��
WinActivate ( "FT-200W","" )
ControlClick( "FT-200W", "", "[ID:1003]") 
Sleep(3000) 
;������Ƶģ��
WinActivate ( "FT-200W","" )
ControlClick( "FT-200W", "", "[ID:1004]") 
Sleep(3000) 
ControlClick( "�����б�", "", "[ID:1074]") ;
Sleep(3000)

WinActivate ( "��Ӳ����ļ�","" );����ָ���Ĵ���(���ý��㵽�ô���,ʹ���Ϊ�����).
BlockInput(1) ;����/������������(����).
$var = ControlGetText("��Ӳ����ļ�", "", "[ID:1148]") ;��ȡָ���ؼ��ϵ��ı�.
ControlClick( "��Ӳ����ļ�", "", "[ID:1148]") 
;ControlSend("��Ӳ����ļ�", "", "[ID:1148]", "F:\testtools\files\!o");ControlSend��֧������
Send("F:\testtools\files\!o") ;ALT+a ע�ͷ��� �ÿ�ݷ�ʽ���ļ�
BlockInput(0)

WinActivate ( "��Ӳ����ļ�","" );����ָ���Ĵ���(���ý��㵽�ô���,ʹ���Ϊ�����).
BlockInput(1)
$var = ControlGetText("��Ӳ����ļ�", "", "Edit1")
WinActivate ( "��Ӳ����ļ�","" )
ControlClick( "��Ӳ����ļ�", "", "Edit1")
;ControlSend("��Ӳ����ļ�", "", "[ID:1148]", "test.mpg!o");ControlSend��֧������
Send("test.mpg!o")  ;ALT+a ע�ͷ��� �ÿ�ݷ�ʽ���ļ�
BlockInput(0)

sleep(1000*25)

WinActivate ( "FT-200W","" );����ָ���Ĵ���(���ý��㵽�ô���,ʹ���Ϊ�����).
ControlClick( "FT-200W", "", "[ID:1004]") 
Sleep(3000)

;�������ģ��
WinActivate ( "FT-200W","" )
ControlClick( "FT-200W", "", "[ID:1005]")
Sleep(2000)
BlockInput(1)
$var = ControlGetText("CLASS:#32770", "", "Edit1")
WinActivate ( "CLASS:#32770","" )
ControlClick( "CLASS:#32770", "", "Edit1")
;ControlSend("CLASS:#32770", "", "[ID:1014]", "1234{Enter}")
Send("1234{Enter}") 
BlockInput(0)
Sleep(3000)
WinActivate ( "�������̨","" )
ControlClick( "�������̨", "", "[ID:1057]", "left", 2, 98, 31)
Sleep(1000*10)
WinActivate ( "�������̨","" )
ControlClick( "�������̨", "", "[ID:1057]", "left", 2, 96, 49)
Sleep(1000*10)
;  ѭ��ģ��


WinActivate ( "�������̨","" )
ControlClick( "�������̨", "", "[ID:8]")
Sleep(3000)
WinActivate ( "FT-200W","" );����ָ���Ĵ���(���ý��㵽�ô���,ʹ���Ϊ�����).
;�ر�PC��
ControlClick( "FT-200W", "", "[ID:1011]")


Func ShowMessage()   ;Func����˼�����Զ��庯��
    Dim $i=MsgBox(1,"�˳��ű�","ȷ���˳��ű���")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc
