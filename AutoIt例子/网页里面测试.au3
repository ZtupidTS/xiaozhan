;ͶӰ����
WinActivate ( "Wireless Projection Adapter - Microsoft Internet Explorer","" )
ControlClick( "Wireless Projection Adapter - Microsoft Internet Explorer", "", "Internet Explorer_Server1","left", 1, 51, 185)
sleep(5000)
;�������� 
WinActivate ( "Wireless Projection Adapter - Microsoft Internet Explorer","" )
ControlClick( "Wireless Projection Adapter - Microsoft Internet Explorer", "", "Internet Explorer_Server1","left", 1, 48, 206)
sleep(5000)
;��������
WinActivate ( "Wireless Projection Adapter - Microsoft Internet Explorer","" )
ControlClick( "Wireless Projection Adapter - Microsoft Internet Explorer", "", "Internet Explorer_Server1","left", 1, 49, 231)
sleep(5000) 
;�Զ��������� 
WinActivate ( "Wireless Projection Adapter - Microsoft Internet Explorer","" )
ControlClick( "Wireless Projection Adapter - Microsoft Internet Explorer", "", "Internet Explorer_Server1","left", 1, 46, 272)
sleep(5000)
;����˿�����
WinActivate ( "Wireless Projection Adapter - Microsoft Internet Explorer","" )
ControlClick( "Wireless Projection Adapter - Microsoft Internet Explorer", "", "Internet Explorer_Server1","left", 1, 43, 291)
sleep(5000)
;�޸�����
WinActivate ( "Wireless Projection Adapter - Microsoft Internet Explorer","" )
ControlClick( "Wireless Projection Adapter - Microsoft Internet Explorer", "", "Internet Explorer_Server1","left", 1, 52, 320)
sleep(5000)
;��������
WinActivate ( "Wireless Projection Adapter - Microsoft Internet Explorer","" )
ControlClick( "Wireless Projection Adapter - Microsoft Internet Explorer", "", "Internet Explorer_Server1","left", 1, 48, 338)
sleep(5000)
;��ԭ����
WinActivate ( "Wireless Projection Adapter - Microsoft Internet Explorer","" )
ControlClick( "Wireless Projection Adapter - Microsoft Internet Explorer", "", "Internet Explorer_Server1","left", 1, 719, 262)
sleep(5000)

WinActivate ( "ѡ���ļ�","" );����ָ���Ĵ���(���ý��㵽�ô���,ʹ���Ϊ�����).
SendKeepActive("ѡ���ļ�")
BlockInput(1) ;����/������������(����).
$var = ControlGetText("ѡ���ļ�", "", "[ID:1148]") ;��ȡָ���ؼ��ϵ��ı�.
ControlClick( "ѡ���ļ�", "", "[ID:1148]") 
;ControlSend("��Ӳ����ļ�", "", "[ID:1148]", "F:\testtools\files\!o");ControlSend��֧������
Send("F:\����ͶӰ���Խű�\Projection.cfg!o") ;ALT+a ע�ͷ��� �ÿ�ݷ�ʽ���ļ�
BlockInput(0)

Sleep(3000)

WinActivate ( "Wireless Projection Adapter - Microsoft Internet Explorer","" )
ControlClick( "Wireless Projection Adapter - Microsoft Internet Explorer", "", "Internet Explorer_Server1","left", 1, 437 ,299)
sleep(5000)

WinActivate ( "Microsoft Internet Explorer","" )
ControlClick( "Microsoft Internet Explorer", "", "[ID:1]")
sleep(3000)

WinActivate ( "Microsoft Internet Explorer","" )
ControlClick( "Microsoft Internet Explorer", "", "[ID:2]")
sleep(3000)

WinActivate ( "Wireless Projection Adapter - Microsoft Internet Explorer","" )
WinClose( "Wireless Projection Adapter - Microsoft Internet Explorer","" )


