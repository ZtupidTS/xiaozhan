;ShellExecute(@DesktopDir & "\�������.lnk")
;FileCreateShortcut ( "Ŀ���ļ�", "lnk�ļ�" [, "����Ŀ¼" [, "����" [, "����" [, "ͼ���ļ�" [, "��ݼ�" [, ͼ���� [, ״̬]]]]]]] );��θ���ݷ�ʽ��ӿ�ݼ�
Run("F:\����ͶӰ���Խű�\arp -d.bat","F:\����ͶӰ���Խű�\", "")
#include <Process.au3>
#include <IE.au3>
#Include <WinAPI.au3>
_RunDos("start http://192.168.120.10/zh_CN/settings.asp");������վ�ķ���
;sleep(5000)


Opt("WinTitleMatchMode", 4)
WinWait("���ӵ� 192.168.120.10","",5)
SendKeepActive("���ӵ� 192.168.120.10")
BlockInput(1)
$var = ControlGetText("���ӵ� 192.168.120.10", "", "[ID:1003]")
ControlClick( "���ӵ� 192.168.120.10", "", "[ID:1003]") ;��ָ���ؼ��������������
WinActivate ( "���ӵ� 192.168.120.10","" );����ָ���Ĵ���(���ý��㵽�ô���,ʹ���Ϊ�����).
Send("admin")  ;
BlockInput(0)
Opt("WinTitleMatchMode", 4)
WinWait("���ӵ� 192.168.120.10","",5)
BlockInput(1)
$var = ControlGetText("���ӵ� 192.168.120.10", "", "[ID:1005]")
ControlClick( "���ӵ� 192.168.120.10", "", "[ID:1005]") ;��ָ���ؼ��������������
WinActivate ( "���ӵ� 192.168.120.10","" );����ָ���Ĵ���(���ý��㵽�ô���,ʹ���Ϊ�����).
Send("1234{Enter}")  ;
BlockInput(0)

Sleep(5000)
$handle = WinGetHandle("Wireless Projection Adapter - Microsoft Internet Explorer", "")
_WinAPI_ShowWindow($handle, @SW_SHOWMAXIMIZED)