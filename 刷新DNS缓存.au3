#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_Icon=L:\����\�ۺ����\3D���ICOͼ��\rainmeter.ico
#AutoIt3Wrapper_Outfile=ˢ��DNS����.exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
Run(@ComSpec & " /k ipconfig /flushdns")
Sleep(6000)
ProcessClose("cmd.exe")