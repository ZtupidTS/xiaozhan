#cs �ߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣ�

 Au3 �汾:
 �ű�����: 
	Email: 
	QQ/TM: 
 �ű��汾: 
 �ű�����: ������缫�ٻָ�

#ce �ߣߣߣߣߣߣߣߣߣߣߣߣߣߣ߽ű���ʼ�ߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣ�
If FileExists("������缫�ٻָ�.exe")<>1 Then Exit
Run("������缫�ٻָ�.exe")
$titile="������缫�ٻָ�"
WinWait($titile,"лл��ѡ��������缫�ٻָ�")
ControlSend($titile,"лл��ѡ��������缫�ٻָ�","Button2",'!n')

WinWait($titile,"��PAGE DOWN���Բ鿴Э���ʣ�ಿ�֡�")
ControlSend($titile,"��PAGE DOWN���Բ鿴Э���ʣ�ಿ�֡�","Button7",'!n')

WinWait($titile,"��װ�����������ļ����а�װ������缫�ٻָ���")
ControlClick($titile,"��װ�����������ļ����а�װ������缫�ٻָ���","Button2")

WinWait("����ļ���","��ѡ��װ�ļ��У�")
ControlSend("����ļ���","��ѡ��װ�ļ��У�","SysTreeView321","{home}")

While 1
	;Sleep(100)
	$text=ControlGetText("����ļ���","��ѡ��װ�ļ��У�","Static2")
	If $text="D:\" Then 
	ControlSend("����ļ���","��ѡ��װ�ļ��У�","SysTreeView321","{numpadadd}")
	;----------------
	While 1
		;Sleep(100)
	$text=ControlGetText("����ļ���","��ѡ��װ�ļ��У�","Static2")
	If $text="D:\Program Files" Then 
	ControlClick("����ļ���","��ѡ��װ�ļ��У�","Button1")
	ExitLoop
Else
	ControlSend("����ļ���","��ѡ��װ�ļ��У�","SysTreeView321","{down}")
	EndIf

WEnd
;-----------------------
	ExitLoop
Else
	ControlSend("����ļ���","��ѡ��װ�ļ��У�","SysTreeView321","{down}")
	EndIf

WEnd
ControlSend($titile,"��װ�����������ļ����а�װ������缫�ٻָ���","Button7",'!n')
WinWait($titile,"�����г�����ǰ�����İ�װ����")
ControlSend($titile,"�����г�����ǰ�����İ�װ����","Button10",'!n')

WinWait($titile,"�ļ��������")
ControlClick($titile,"�ļ��������","Button2")
ControlClick($titile,"�ļ��������","Button13")

