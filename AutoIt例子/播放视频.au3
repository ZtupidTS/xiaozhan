
HotKeySet("!a", "ShowMessage")          ;ALT+a ע�ͷ��ţ�����
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z

WinActivate ( "FT-200W","" );����ָ���Ĵ���(���ý��㵽�ô���,ʹ���Ϊ�����).
ControlClick( "FT-200W", "", "[ID:1004]")
Sleep(3000)
ControlClick( "�����б�", "", "[ID:1074]")
Sleep(3000)
WinActivate ( "��Ӳ����ļ�","" );����ָ���Ĵ���(���ý��㵽�ô���,ʹ���Ϊ�����).
BlockInput(1)
$var = ControlGetText("��Ӳ����ļ�", "", "Edit1")
ControlClick( "��Ӳ����ļ�", "", "Edit1")
Send("F:\testtools\files!o") ;ALT+a ע�ͷ��� �ÿ�ݷ�ʽ���ļ�
BlockInput(0)

WinActivate ( "��Ӳ����ļ�","" );����ָ���Ĵ���(���ý��㵽�ô���,ʹ���Ϊ�����).
BlockInput(1)
$var = ControlGetText("��Ӳ����ļ�", "", "Edit1")
ControlClick( "��Ӳ����ļ�", "", "Edit1")
Send("test.mpg!o")  ;ALT+a ע�ͷ��� �ÿ�ݷ�ʽ���ļ�
BlockInput(0)


MsgBox(1,"�˳��ű�","ȷ���˳��ű���")
Func ShowMessage()   ;Func����˼�����Զ��庯��
    Dim $i=MsgBox(1,"�˳��ű�","ȷ���˳��ű���")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc