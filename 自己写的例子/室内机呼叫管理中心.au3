#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=D:\Autoit3\Aut2Exe\Icons\favorites2.ico
#AutoIt3Wrapper_outfile=室内机呼叫管理中心.exe
#AutoIt3Wrapper_Res_Fileversion=0.0.0.0
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
HotKeySet("!1","showmessage")
HotKeySet("^!2","showmessage")

$xiao= IniRead ( "参数.ini", "xiao", "xiao", "" )
$xiao1= IniRead ( "参数.ini", "xiao1", "xiao1", "" )
$xiao2= IniRead ( "参数.ini", "xiao2", "xiao2", "" )
$xiao3= IniRead ( "参数.ini", "xiao3", "xiao3", "" )
$xiao4= IniRead ( "参数.ini", "xiao4", "xiao4", "" )

$i = 0
Do

WinWait($xiao)
ControlClick($xiao,$xiao1,$xiao2)
Sleep($xiao4)
ControlClick($xiao,$xiao3,$xiao2)
	
    $i = $i + 1
Until $i = 9600000000000000000

Func showmessage()
	Dim $i=MsgBox(1,"退出脚本","确定退出") 
	   If $i<>2 Then
		   Exit 0
	   EndIf
   EndFunc	   
   
   
   #cs
   [xiao]
xiao=对方号码: 01期01栋1单元01层01房01号室内机
[xiao1]
xiao1=接听
[xiao2]
xiao2=[ID:1050]
[xiao3]
xiao3=挂断
[xiao4]
xiao4=5000
   #ce