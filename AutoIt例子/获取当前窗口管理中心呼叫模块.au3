hotKeySet("!a", "ShowMessage")          ;ALT+a ע�ͷ��ţ�����
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z
Break(0)                                ;��ֹ�û��ӽű���������̲˵����˳�
Opt("TrayIconHide", 1)                  ;���� AutoIt ����ͼ��.ע��:����ͼ���Ի��ڳ��������ʱ���ִ�Լ 750 ����
While 1
WinWaitActive("[CLASS:#32770]")         ;�ȴ�����
$text = WinGetClassList("[CLASS:#32770]", "")   ;��ȡָ�����ڵ����пؼ�����б�
Sleep(3000) 
ControlClick( "", "", "[ID:1050]")
Sleep(3000) 
ControlClick( "", "", "[ID:1051]")
Sleep(5000) 
ControlClick( "", "", "[ID:1050]")
Sleep(3000) 
WEnd
Func ShowMessage()   ;Func����˼�����Զ��庯��
    Dim $i=MsgBox(1,"�˳��ű�","ȷ���˳��ű���")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc

