;$answer = InputBox("Question", "Where were you born?", "BlockInput(1)", "", _
	;-1, -1, 0, 0)
;InputBox("��������Ҫ��ʱ�ػ���˫����", ""����Ϊ��λ", "Planet Earth", "")
$xiaozhan = InputBox("��������Ҫ��ʱ�ػ���ʱ��", "����Ϊ��λ", "����������", "", _
	-1, -1, 0, 0)

Opt("TrayIconHide", 1) 
Dim $i=MsgBox(1, "�ػ�", "��ʱ30��ػ�", "$xiaozhan")  ;30������Ϊ��λ��
if  $i<>2  Then
	 ;Shutdown(13)
	 MsgBox(1, "��������ʱ�ػ�", "���µ����ʱ�ػ�","")
    Exit 0
EndIf
MsgBox(1, "��������ʱ�ػ�", "�����µ����ʱ�ػ�","")
