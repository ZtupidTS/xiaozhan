HotKeySet("!a", "ShowMessage")          ;ALT+a ע�ͷ��ţ�����
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z

WinActivate ( "FT-200W","" );����ָ���Ĵ���(���ý��㵽�ô���,ʹ���Ϊ�����).
ControlClick( "FT-200W", "", "[ID:1005]")
Sleep(2000)
BlockInput(1)
$var = ControlGetText("#32770", "", "Edit1")
ControlClick( "#32770", "", "Edit1")
Send("1234{Enter}") 
BlockInput(0)
Sleep(2000)
ControlClick( "�������̨", "", "[ID:1057]", "left", 2, 98, 31)
Sleep(5000)
ControlClick( "�������̨", "", "[ID:1057]", "left", 2, 96, 49)
Sleep(5000)

ControlClick( "�������̨", "", "[ID:8]")
MsgBox(1,"�˳��ű�","ȷ���˳��ű���")
Func ShowMessage()   ;Func����˼�����Զ��庯��
    Dim $i=MsgBox(1,"�˳��ű�","ȷ���˳��ű���")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc