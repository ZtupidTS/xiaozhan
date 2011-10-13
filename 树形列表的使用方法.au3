Run("雨过天晴极速恢复.exe")
WinWait("雨过天晴极速恢复","谢谢您选择")
ControlClick("雨过天晴极速恢复","谢谢您选择",'Button2')
WinWait("雨过天晴极速恢复","重要提示")
ControlClick("雨过天晴极速恢复","重要提示",'Button5')
DriveSetLabel('D:\','');把盘符的卷标改成默认
WinWait("雨过天晴极速恢复","目的文件夹")
Do
ControlClick("雨过天晴极速恢复","目的文件夹",'Button2')
Sleep(50)
Until WinExists("浏览文件夹","")
ControlTreeView ("浏览文件夹","","SysTreeView321",'Select',"桌面|我的电脑|本地磁盘 (D:)")
ControlClick("浏览文件夹","","Button1")
WinWaitActive("雨过天晴极速恢复","目的文件夹")
Sleep(500)
#cs
ControlClick("雨过天晴极速恢复","目的文件夹","Button7")
WinWait('雨过天晴极速恢复','当前设置')
ControlClick("雨过天晴极速恢复","当前设置","Button10")
#ce