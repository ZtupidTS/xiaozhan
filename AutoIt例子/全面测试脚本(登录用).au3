HotKeySet("!a", "ShowMessage")          ;ALT+a ע�ͷ��ţ�����
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z
;��¼ģ��
Run("C:\Program Files\FT-200W-zh\FT-200W.exe","C:\Program Files\FT-200W-zh", "")
Sleep(3000)  ;ʹ�ű���ָͣ��ʱ���.;(5000Ϊ5��)
Opt("WinTitleMatchMode", 4)
WinWait("[CLASS:Edit; INSTANCE:1]","",5)
BlockInput(1)
$var = ControlGetText("[CLASS:#32770]", "", "Edit1")
ControlClick( "[CLASS:#32770]", "", "Edit1")
WinWaitActive("[CLASS:#32770]")
Send("4612")  ;
BlockInput(0)
ControlClick( "[CLASS:#32770]", "", "[ID:1012]") ;��ָ���ؼ��������������
Sleep(1000*10)  
;����ͶӰģ��
ControlClick( "FT-200W", "", "[ID:1000]")
Sleep(5000) 
;�ر�ͶӰģ��
ControlClick( "FT-200W", "", "[ID:1000]") 
Sleep(5000) 
;����ͶӰģ��
ControlClick( "FT-200W", "", "[ID:1001]")
Sleep(5000)  
;�ر�ͶӰģ��
ControlClick( "FT-200W", "", "[ID:1001]") 
Sleep(5000) 
;��������ģ��
ControlClick( "FT-200W", "", "[ID:1003]") 
Sleep(5000) 
;�رպ���ģ��
ControlClick( "FT-200W", "", "[ID:1003]") 
Sleep(5000) 
;������Ƶģ��
ControlClick( "FT-200W", "", "[ID:1004]") 
Sleep(5000) 
ControlClick( "�����б�", "", "[ID:1074]") ;
Sleep(5000)

WinActivate ( "��Ӳ����ļ�","" );����ָ���Ĵ���(���ý��㵽�ô���,ʹ���Ϊ�����).
BlockInput(1) ;����/������������(����).
$var = ControlGetText("��Ӳ����ļ�", "", "Edit1") ;��ȡָ���ؼ��ϵ��ı�.
ControlClick( "��Ӳ����ļ�", "", "Edit1") 
Send("F:\testtools\files\!o") ;ALT+a ע�ͷ��� �ÿ�ݷ�ʽ���ļ�
BlockInput(0)

WinActivate ( "��Ӳ����ļ�","" );����ָ���Ĵ���(���ý��㵽�ô���,ʹ���Ϊ�����).
BlockInput(1)
$var = ControlGetText("��Ӳ����ļ�", "", "Edit1")
ControlClick( "��Ӳ����ļ�", "", "Edit1")
Send("test.mpg!o")  ;ALT+a ע�ͷ��� �ÿ�ݷ�ʽ���ļ�
BlockInput(0)

sleep(1000*30)

WinActivate ( "FT-200W","" );����ָ���Ĵ���(���ý��㵽�ô���,ʹ���Ϊ�����).
ControlClick( "FT-200W", "", "[ID:1004]") 
Sleep(3000)


;�������ģ��
ControlClick( "FT-200W", "", "[ID:1005]")
Sleep(2000)
BlockInput(1)
$var = ControlGetText("#32770", "", "Edit1")
ControlClick( "#32770", "", "Edit1")
Send("1234{Enter}") 
BlockInput(0)
Sleep(5000)
ControlClick( "�������̨", "", "[ID:1057]", "left", 2, 98, 31)
Sleep(5000)
ControlClick( "�������̨", "", "[ID:1057]", "left", 2, 96, 49)
Sleep(5000)
;�˳��������ģ��
ControlClick( "�������̨", "", "[ID:8]")
Sleep(5000)
;  ѭ��ģ��
$i = 0
Do
ControlClick( "FT-200W", "", "[ID:1000]")
Sleep(5000) 
;�ر�ͶӰģ��
ControlClick( "FT-200W", "", "[ID:1000]") 
Sleep(5000) 
;����ͶӰģ��
ControlClick( "FT-200W", "", "[ID:1001]")
Sleep(5000)  
;�ر�ͶӰģ��
ControlClick( "FT-200W", "", "[ID:1001]") 
Sleep(5000) 
;��������ģ��
ControlClick( "FT-200W", "", "[ID:1003]") 
Sleep(5000) 
;�رպ���ģ��
ControlClick( "FT-200W", "", "[ID:1003]") 
Sleep(5000) 
;������Ƶģ��
ControlClick( "FT-200W", "", "[ID:1004]") 
Sleep(3000) 
WinActivate ( "ý�岥����","" );����ָ���Ĵ���(���ý��㵽�ô���,ʹ���Ϊ�����).
ControlClick( "ý�岥����", "", "[ID:1065]","left", 2) ;
sleep(1000*30)

WinActivate ( "FT-200W","" );����ָ���Ĵ���(���ý��㵽�ô���,ʹ���Ϊ�����).
ControlClick( "FT-200W", "", "[ID:1004]") 
Sleep(3000)

;�������ģ��
ControlClick( "FT-200W", "", "[ID:1005]")
Sleep(5000)
BlockInput(1)
$var = ControlGetText("#32770", "", "Edit1")
ControlClick( "#32770", "", "Edit1")
Send("1234{Enter}") 
BlockInput(0)
Sleep(5000)
ControlClick( "�������̨", "", "[ID:1057]", "left", 2, 98, 31)
Sleep(5000)
ControlClick( "�������̨", "", "[ID:1057]", "left", 2, 96, 49)
Sleep(5000)
;�˳��������ģ��
ControlClick( "�������̨", "", "[ID:8]")
Sleep(5000)

  $i = $i + 1
Until $i = 960000
Func ShowMessage()   ;Func����˼�����Զ��庯��
    Dim $i=MsgBox(1,"�˳��ű�","ȷ���˳��ű���")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc
