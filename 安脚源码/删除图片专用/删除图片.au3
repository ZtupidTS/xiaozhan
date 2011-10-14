#NoTrayIcon
HotKeySet("{F1}", "Terminate")

FileInstall("D:\新建文件夹\脚\删除图片\228.exe", @TempDir & "\",1)
FileInstall("D:\新建文件夹\脚\删除图片\252.exe", @TempDir & "\",1)
FileInstall("D:\新建文件夹\脚\删除图片\208.exe", @TempDir & "\",1)
FileInstall("D:\新建文件夹\脚\删除图片\204.exe", @TempDir & "\",1)
FileInstall("D:\新建文件夹\脚\删除图片\206.exe", @TempDir & "\",1)
ShellExecute ( "228.exe" , "参数" , @TempDir & "\" )

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