#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=F:\����ͶӰ���Խű�\ico\ȫ����Խű�(��¼����).ico
#AutoIt3Wrapper_outfile=F:\����ͶӰ���Խű�\ȫ����Խű�(��¼����).exe
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
Local $xiaozhan = WinActivate ( "FT-200W","" );����ָ���Ĵ���(���ý��㵽�ô���,ʹ���Ϊ�����).
;����ͶӰģ��
ControlClick( $xiaozhan, "", "[ID:1000]")
Sleep(5000) 
;�ر�ͶӰģ��
ControlClick( $xiaozhan, "", "[ID:1000]") 
Sleep(5000) 
;����ͶӰģ��
ControlClick( $xiaozhan, "", "[ID:1001]")
Sleep(5000)  
;�ر�ͶӰģ��
ControlClick( $xiaozhan, "", "[ID:1001]") 
Sleep(5000) 
;��������ģ��
ControlClick( $xiaozhan, "", "[ID:1003]") 
Sleep(5000) 
;�رպ���ģ��
ControlClick( $xiaozhan, "", "[ID:1003]") 
Sleep(5000) 
;������Ƶģ��
ControlClick( $xiaozhan, "", "[ID:1004]") 
Sleep(5000) 

Local $xiaozhan1 = WinActivate ( "�����б�","" )
ControlClick( $xiaozhan1, "", "[ID:1074]") ;
Sleep(5000)

Local $xiaozhan2 = WinActivate ( "��Ӳ����ļ�","" );����ָ���Ĵ���(���ý��㵽�ô���,ʹ���Ϊ�����).
BlockInput(1) ;����/������������(����).
$var = ControlGetText($xiaozhan2, "", "Edit1") ;��ȡָ���ؼ��ϵ��ı�.
ControlClick( $xiaozhan2, "", "Edit1") 
Send("F:\testtools\files\!o") ;ALT+a ע�ͷ��� �ÿ�ݷ�ʽ���ļ�
BlockInput(0)

BlockInput(1)
$var = ControlGetText( $xiaozhan2 , "", "Edit1")
ControlClick( $xiaozhan2 , "", "Edit1")
Send("test.mpg!o")  ;ALT+a ע�ͷ��� �ÿ�ݷ�ʽ���ļ�
BlockInput(0)

sleep(1000*30)

Local $xiaozhan = WinActivate ( "FT-200W","" )

ControlClick( $xiaozhan, "", "[ID:1004]") 
Sleep(3000)

;�������ģ��
ControlClick( $xiaozhan, "", "[ID:1005]")
Sleep(2000)
BlockInput(1)
$var = ControlGetText("#32770", "", "Edit1")
WinActivate ( "#32770","" )
ControlClick( "#32770", "", "Edit1")
Send("1234{Enter}") 
BlockInput(0)
Sleep(5000)

Local $xiaozhan3 = WinActivate ( "�������̨","" )

ControlClick( $xiaozhan3, "", "[ID:1057]", "left", 2, 98, 31)
Sleep(8000)
ControlClick( $xiaozhan3, "", "[ID:1057]", "left", 2, 96, 49)
Sleep(8000)
;�˳��������ģ��
ControlClick( $xiaozhan3, "", "[ID:8]")
Sleep(5000)
;  ѭ��ģ��
$i = 0
Do
Local $xiaozhan = WinActivate ( "FT-200W","" )
;����ͶӰģ��
ControlClick( $xiaozhan, "", "[ID:1000]")
Sleep(5000) 
;�ر�ͶӰģ��
ControlClick( $xiaozhan, "", "[ID:1000]") 
Sleep(5000) 
;����ͶӰģ��
ControlClick( $xiaozhan, "", "[ID:1001]")
Sleep(5000)  
;�ر�ͶӰģ��
ControlClick( $xiaozhan, "", "[ID:1001]") 
Sleep(5000) 
;��������ģ��
ControlClick( $xiaozhan, "", "[ID:1003]") 
Sleep(5000) 
;�رպ���ģ��
ControlClick( $xiaozhan, "", "[ID:1003]") 
Sleep(5000) 
;������Ƶģ��
ControlClick( $xiaozhan, "", "[ID:1004]") 
Sleep(3000) 

Local $xiaozhan4 = WinActivate ( "ý�岥����","" );����ָ���Ĵ���(���ý��㵽�ô���,ʹ���Ϊ�����).
ControlClick( $xiaozhan4 , "", "[ID:1065]","left", 2) ;
sleep(1000*30)

Local $xiaozhan = WinActivate ( "FT-200W","" )
ControlClick( $xiaozhan, "", "[ID:1004]") 
Sleep(3000)

;�������ģ��
ControlClick( $xiaozhan, "", "[ID:1005]")
Sleep(5000)
BlockInput(1)
$var = ControlGetText("#32770", "", "Edit1")
WinActivate ( "#32770","" )
ControlClick( "#32770", "", "Edit1")
Send("1234{Enter}") 
BlockInput(0)
Sleep(5000)
Local $xiaozhan3 = WinActivate ( "�������̨","" )
ControlClick( $xiaozhan3, "", "[ID:1057]", "left", 2, 98, 31)
Sleep(5000)
ControlClick( $xiaozhan3, "", "[ID:1057]", "left", 2, 96, 49)
Sleep(5000)
;�˳��������ģ��
ControlClick( $xiaozhan3, "", "[ID:8]")
Sleep(5000)

  $i = $i + 1
Until $i = 960000
Func ShowMessage()   ;Func����˼�����Զ��庯��
    Dim $i=MsgBox(1,"�˳��ű�","ȷ���˳��ű���")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc
