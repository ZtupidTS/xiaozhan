$g_szVersion2 = "�ҵĴ���"
HotKeySet('!z','huifu')
if WinExists($g_szVersion2) and not @SW_MINIMIZE  Then ;WinExists(���ָ���Ĵ����Ƿ����)
mini()
Else
huifu()
EndIf

func huifu()
winSetState($g_szVersion2,'',@SW_RESTORE) ;winSetState(��ʾ�����ء���С������󻯻�ԭĳ������) SW_RESTORE(�������ڵ���С�������״̬)
EndFunc

func mini()
winSetState($g_szVersion2,'',@SW_MINIMIZE) ;winSetState(��ʾ�����ء���С������󻯻�ԭĳ������) SW_MINIMIZE(��С������)
EndFunc