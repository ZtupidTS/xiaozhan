#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=D:\无线投影测试脚本\ico\shell32.dll-45-9.ICO
#AutoIt3Wrapper_outfile=强制注销.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
Opt("TrayIconHide", 1) 
Dim $i=MsgBox(1, "切换用户", "确定要强制切换用户想的点确定，不想的点取消", "")
if  $i<>2  Then
	Send("#l")
    Exit 0
EndIf
MsgBox(4096, "想重新切换用户", "请重新点击强制切换用户","")