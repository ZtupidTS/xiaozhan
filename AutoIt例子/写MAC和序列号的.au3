HotKeySet("!a", "ShowMessage")          ;ALT+a ע�ͷ��ţ�����
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z
;��¼ģ��
Run("C:\Documents and Settings\Administrator\����\testtools\tools\testtool.exe","C:\Documents and Settings\Administrator\����\testtools\tools", "")
Sleep(2000)  ;ʹ�ű���ָͣ��ʱ���.;(5000Ϊ5��)
Opt("WinTitleMatchMode", 4)
WinWait("testtool","",5)
BlockInput(1)
$var = ControlGetText("testtool", "", "[ID:1012]")
ControlClick("testtool", "", "[ID:1012]")
WinWaitActive("testtool")
ControlSend("testtool", "", "[ID:1012]", "000f090001");ControlSend��֧������
;Send("000f090001")  ;
BlockInput(0)

BlockInput(1)
$var = ControlGetText("testtool", "", "[ID:1016]")
ControlClick("testtool", "", "[ID:1016]")
WinWaitActive("testtool")
ControlSend("testtool", "", "[ID:1016]", "030009021108")
;Send("030009021108")  ;
BlockInput(0)



Func ShowMessage()   ;Func����˼�����Զ��庯��
    Dim $i=MsgBox(1,"�˳��ű�","ȷ���˳��ű���")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc
