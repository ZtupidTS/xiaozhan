#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=..\����\�ۺ����\3D���ICOͼ��\IE.ico
#AutoIt3Wrapper_outfile=��Ŀ���� IE.exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
#include <Process.au3>
#include <IE.au3>
$rc = _IECreate ("http://172.18.6.254/redmine/login")
Send("10111940")
Send("{TAB}")
Send("000000")
Send("{TAB}")
Send("{space}")
Send("{TAB}")
Send("{ENTER}")
If WinExists("�Զ��������") Then
    Send("{ENTER}")
EndIf

_IELoadWait ($rc)

