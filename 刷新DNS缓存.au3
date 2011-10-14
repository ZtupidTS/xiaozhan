#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_Icon=L:\工具\综合软件\3D风格ICO图标\rainmeter.ico
#AutoIt3Wrapper_Outfile=刷新DNS缓存.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
Run(@ComSpec & " /k ipconfig /flushdns")
Sleep(6000)
ProcessClose("cmd.exe")