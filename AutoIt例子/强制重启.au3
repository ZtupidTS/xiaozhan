#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=..\..\ǿ������.exe|-1
#AutoIt3Wrapper_outfile=..\..\ǿ������.exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
Opt("TrayIconHide", 1) 
Dim $i=MsgBox(1, "����", "ȷ��Ҫǿ������ ��ĵ�ȷ��������ĵ�ȡ��", "")
if  $i<>2  Then
	Shutdown(6)
    Exit 0
EndIf