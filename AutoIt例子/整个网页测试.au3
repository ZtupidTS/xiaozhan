#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=..\Program Files\AutoIt3\Aut2Exe\Icons\Bridge.ico
#AutoIt3Wrapper_outfile=F:\����ͶӰ���Խű�\������ҳ����.exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
HotKeySet("!a", "ShowMessage")          ;ALT+a ע�ͷ��ţ�����
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z

;ShellExecute(@DesktopDir & "\�������.lnk")
;FileCreateShortcut ( "Ŀ���ļ�", "lnk�ļ�" [, "����Ŀ¼" [, "����" [, "����" [, "ͼ���ļ�" [, "��ݼ�" [, ͼ���� [, ״̬]]]]]]] );��θ���ݷ�ʽ��ӿ�ݼ�
Run("F:\����ͶӰ���Խű�\arp -d.bat","F:\����ͶӰ���Խű�\", "")
#include <Process.au3>
#include <IE.au3>
#Include <WinAPI.au3>
_RunDos("start http://192.168.10.1/zh_CN/settings.asp");������վ�ķ���
;sleep(5000)


Opt("WinTitleMatchMode", 4)
WinWait("���ӵ� 192.168.10.1","",5)
SendKeepActive("���ӵ� 192.168.10.1")
BlockInput(1)
$var = ControlGetText("���ӵ� 192.168.10.1", "", "[ID:1003]")
ControlClick( "���ӵ� 192.168.10.1", "", "[ID:1003]") ;��ָ���ؼ��������������
WinActivate ( "���ӵ� 192.168.10.1","" );����ָ���Ĵ���(���ý��㵽�ô���,ʹ���Ϊ�����).
Send("admin")  ;
BlockInput(0)
Opt("WinTitleMatchMode", 4)
WinWait("���ӵ� 192.168.10.1","",5)
BlockInput(1)
$var = ControlGetText("���ӵ� 192.168.10.1", "", "[ID:1005]")
ControlClick( "���ӵ� 192.168.10.1", "", "[ID:1005]") ;��ָ���ؼ��������������1234

WinActivate ( "���ӵ� 192.168.10.1","" );����ָ���Ĵ���(���ý��㵽�ô���,ʹ���Ϊ�����).
Send("1234{Enter}")  ;
BlockInput(0)

Sleep(5000)
$handle = WinGetHandle("Wireless Projection Adapter - Microsoft Internet Explorer", "")
_WinAPI_ShowWindow($handle, @SW_SHOWMAXIMIZED)

Sleep(3000)



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
$var = ControlGetText("ѡ���ļ�", "", "[ID:1148]") ;��ȡָ���ؼ��ϵ��ı�.1234
ControlClick( "ѡ���ļ�", "", "[ID:1148]") 
;ControlSend("��Ӳ����ļ�", "", "[ID:1148]", "F:\testtools\files\!o");ControlSend��֧������
Send("F:\testtools\Projection.cfg!o") ;ALT+a ע�ͷ��� �ÿ�ݷ�ʽ���ļ�
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



Func ShowMessage()   ;Func����˼�����Զ��庯��
    Dim $i=MsgBox(1,"�˳��ű�","ȷ���˳��ű���")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc
