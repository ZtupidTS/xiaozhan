#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=..\..\强制重启.exe|-1
#AutoIt3Wrapper_outfile=..\..\强制重启.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
Opt("TrayIconHide", 1) 
Dim $i=MsgBox(1, "重启", "确定要强制重启 想的点确定，不想的点取消", "")
if  $i<>2  Then
	Shutdown(6)
    Exit 0
EndIf