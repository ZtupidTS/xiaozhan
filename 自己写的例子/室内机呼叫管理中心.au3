#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=D:\Autoit3\Aut2Exe\Icons\favorites2.ico
#AutoIt3Wrapper_outfile=���ڻ����й�������.exe
#AutoIt3Wrapper_Res_Fileversion=0.0.0.0
#EndRegion ;**** ���������� ACNWrapper_GUI ****
HotKeySet("!1","showmessage")
HotKeySet("^!2","showmessage")

$xiao= IniRead ( "����.ini", "xiao", "xiao", "" )
$xiao1= IniRead ( "����.ini", "xiao1", "xiao1", "" )
$xiao2= IniRead ( "����.ini", "xiao2", "xiao2", "" )
$xiao3= IniRead ( "����.ini", "xiao3", "xiao3", "" )
$xiao4= IniRead ( "����.ini", "xiao4", "xiao4", "" )

$i = 0
Do

WinWait($xiao)
ControlClick($xiao,$xiao1,$xiao2)
Sleep($xiao4)
ControlClick($xiao,$xiao3,$xiao2)
	
    $i = $i + 1
Until $i = 9600000000000000000

Func showmessage()
	Dim $i=MsgBox(1,"�˳��ű�","ȷ���˳�") 
	   If $i<>2 Then
		   Exit 0
	   EndIf
   EndFunc	   
   
   
   #cs
   [xiao]
xiao=�Է�����: 01��01��1��Ԫ01��01��01�����ڻ�
[xiao1]
xiao1=����
[xiao2]
xiao2=[ID:1050]
[xiao3]
xiao3=�Ҷ�
[xiao4]
xiao4=5000
   #ce