Run("������缫�ٻָ�.exe")
WinWait("������缫�ٻָ�","лл��ѡ��")
ControlClick("������缫�ٻָ�","лл��ѡ��",'Button2')
WinWait("������缫�ٻָ�","��Ҫ��ʾ")
ControlClick("������缫�ٻָ�","��Ҫ��ʾ",'Button5')
DriveSetLabel('D:\','');���̷��ľ��ĳ�Ĭ��
WinWait("������缫�ٻָ�","Ŀ���ļ���")
Do
ControlClick("������缫�ٻָ�","Ŀ���ļ���",'Button2')
Sleep(50)
Until WinExists("����ļ���","")
ControlTreeView ("����ļ���","","SysTreeView321",'Select',"����|�ҵĵ���|���ش��� (D:)")
ControlClick("����ļ���","","Button1")
WinWaitActive("������缫�ٻָ�","Ŀ���ļ���")
Sleep(500)
#cs
ControlClick("������缫�ٻָ�","Ŀ���ļ���","Button7")
WinWait('������缫�ٻָ�','��ǰ����')
ControlClick("������缫�ٻָ�","��ǰ����","Button10")
#ce