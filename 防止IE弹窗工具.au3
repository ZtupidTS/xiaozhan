#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=D:\AutoIt3\Aut2Exe\Icons\k-notify.ico
#AutoIt3Wrapper_outfile=��ʱ.exe
#AutoIt3Wrapper_Res_Fileversion=0.0.0.0
#EndRegion ;**** ���������� ACNWrapper_GUI ****
HotKeySet("!a", "ShowMessage")          ;ALT+a ע�ͷ��ţ�����
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z

$i = 0
Do

WinWait("Microsoft Internet Explorer")
WinActivate ("Microsoft Internet Explorer","ȷ��")
ControlClick("Microsoft Internet Explorer","ȷ��","[ID:2]")
WinActivate ("Microsoft Internet Explorer","ȷ��")
WinClose("��ҹ�����Ӱ�� - Microsoft Internet Explorer")


$i = $i + 1
Until $i = 960000000000000000000000000

Func ShowMessage()   ;Func����˼�����Զ��庯��
    Dim $i=MsgBox(1,"�˳��ű�","ȷ���˳��ű���")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc