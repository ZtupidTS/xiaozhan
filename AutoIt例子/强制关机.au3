#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=..\..\ǿ�ƹػ�.exe|-1
#AutoIt3Wrapper_outfile=..\..\ǿ�ƹػ�.exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
Opt("TrayIconHide", 1) 
Dim $i=MsgBox(1, "�ػ�", "ȷ��Ҫǿ�ƹػ� ��ĵ�ȷ��������ĵ�ȡ��", "")
if  $i<>2  Then
	Shutdown(13)
    Exit 0
EndIf