#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=..\..\强制关机.exe|-1
#AutoIt3Wrapper_outfile=..\..\强制关机.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
Opt("TrayIconHide", 1) 
Dim $i=MsgBox(1, "关机", "确定要强制关机 想的点确定，不想的点取消", "")
if  $i<>2  Then
	Shutdown(13)
    Exit 0
EndIf