#NoTrayIcon
#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=D:\���\�ļ�ͼ���滻����\ICO\����\����ͷ\USB-Blueberry.ico
#AutoIt3Wrapper_outfile=��������ͶӰ������������.exe
#AutoIt3Wrapper_Add_Constants=n
#EndRegion ;**** ���������� ACNWrapper_GUI ****
#include <Process.au3>

Dim $i=MsgBox(1,"ȷ��IP","��ȷ������ͶӰ����IP�ǲ���192.168.10.1�������������ϵ������Ա�����û��192.168.10.1IP�͵�ȡ��")
if  $i=2  Then
Exit 0
EndIf

Dim $i=MsgBox(1,"ȷ������״̬","��ȷ������ͶӰ���ǲ�������ģʽ״̬����������״̬�²Ű�ȷ��")
if  $i=2  Then
Exit 0
EndIf
BlockInput(1)
_RunDOS("start cmd")
Sleep(1000)
Send("telnet 192.168.10.1{enter}")
Sleep(2000)
Send("root{enter}")
Sleep(3000)
Send("FreeView{enter}")
Sleep(2000)
Send("ls /etc{enter}")
Sleep(3000)
Send("ls /etc/Wireless/RT61AP/{enter}")
Sleep(3000)
send("{PRINTSCREEN}")
Run("C:\WINDOWS\system32\mspaint.exe","C:\WINDOWS\system32")
WinWait("δ���� - ��ͼ")
Send("^v")
Sleep(2000)
Send("^s")
WinWait("����Ϊ")
WinActivate("����Ϊ")
Send("D:\xiaozhan")
WinWait("����Ϊ")
ControlClick("����Ϊ","","[ID:1136]","left",2)
WinActivate("����Ϊ")
Send("j")
Sleep(1000)
Send("!s")
WinWait("����Ϊ","��(&Y)",5)
WinActivate("����Ϊ","��(&Y)")
ControlClick("����Ϊ","��(&Y)","[ID:6]")
Sleep(2000)
WinClose("xiaozhan.JPG - ��ͼ")
WinClose("Telnet 192.168.10.1")
BlockInput(0)





