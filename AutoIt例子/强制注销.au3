#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=D:\����ͶӰ���Խű�\ico\shell32.dll-45-9.ICO
#AutoIt3Wrapper_outfile=ǿ��ע��.exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
Opt("TrayIconHide", 1) 
Dim $i=MsgBox(1, "ע��", "ȷ��Ҫǿ��ע����ĵ�ȷ��������ĵ�ȡ��", "")
if  $i<>2  Then
	Shutdown(0)
    Exit 0
EndIf
MsgBox(1, "������ע��", "�����µ��ǿ��ע��","")