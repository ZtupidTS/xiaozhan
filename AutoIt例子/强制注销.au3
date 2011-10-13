#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=D:\无线投影测试脚本\ico\shell32.dll-45-9.ICO
#AutoIt3Wrapper_outfile=强制注销.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
Opt("TrayIconHide", 1) 
Dim $i=MsgBox(1, "注销", "确定要强制注销想的点确定，不想的点取消", "")
if  $i<>2  Then
	Shutdown(0)
    Exit 0
EndIf
MsgBox(1, "想重新注销", "请重新点击强制注销","")