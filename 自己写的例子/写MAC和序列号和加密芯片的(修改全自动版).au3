
HotKeySet("!a", "ShowMessage")          ;ALT+a 注释符号（；）
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z
;登录模块
;Run("F:\无线投影宝\arp -d.bat","F:\无线投影宝\")
Run("C:\Documents and Settings\xiaozhan\桌面\testtools\tools\testtool写地址专用.exe","C:\Documents and Settings\xiaozhan\桌面\testtools\tools")
;Run("C:\Documents and Settings\Administrator\桌面\testtools\tools\testtool写地址专用.exe","C:\Documents and Settings\Administrator\桌面\testtools\tools")
;Sleep(2000)  ;使脚本暂停指定时间段.;(5000为5秒)

Local $title, $title1,$title2,$title3,$title4, $title5,$title6,$title7,$title8,$title9,$title10,$title11
;***************************************************************************************

$title=IniRead(@scriptdir & "\序列号和MAC.ini","title","title","")
$title1=IniRead(@scriptdir & "\序列号和MAC.ini","title1","title1","")
$title2=IniRead(@scriptdir & "\序列号和MAC.ini","title2","title2","")
$title3=IniRead(@scriptdir & "\序列号和MAC.ini","title3","title3","")
$title11=IniRead(@scriptdir & "\序列号和MAC.ini","title4","title4","") ;从ini文件读取title4中的值
$title11=$title11 & IniRead(@scriptdir & "\序列号和MAC.ini","title5","title5","");从ini文件读取title5中的值，并与刚读取的title4的值连在一起
$title11=$title11 & IniRead(@scriptdir & "\序列号和MAC.ini","title6","title6","");从ini文件读取title6中的值，并与刚读取的title5的值连在一起
$title11=$title11 & IniRead(@scriptdir & "\序列号和MAC.ini","title7","title7","");从ini文件读取title7中的值，并与刚读取的title6的值连在一起
$title11=$title11 & IniRead(@scriptdir & "\序列号和MAC.ini","title8","title8","");从ini文件读取title8中的值，并与刚读取的title7的值连在一起
$title11=$title11 & IniRead(@scriptdir & "\序列号和MAC.ini","title9","title9","");从ini文件读取title9中的值，并与刚读取的title8的值连在一起
$title11=$title11 & IniRead(@scriptdir & "\序列号和MAC.ini","title10","title10","");从ini文件读取title10中的值，并与刚读取的title9的值连在一起
;***************************************************************************************

opt("WinTitleMatchMode")
WinWait("testtool","",1)
BlockInput(1)
$var = ControlGetText("testtool", "", "[ID:1012]")
ControlClick("testtool", "", "[ID:1012]")
WinWaitActive("testtool")
ControlSend("testtool", "", "[ID:1012]", $title11);000f09
If stringlen($title11)= 0 then
 $title11= "000f09000000"
 ControlSend("testtool", "", "[ID:1012]", $title11);000f09
else
 $title11 = "000f09" & Hex(Dec(StringTrimLeft($title11, 6))+1, 6) ;将读取到的字符串前六位删除后转成十进制，然后加1，再转回6位数的16进制并和前面删除的原字符串的前六位合并
endif

BlockInput(0)
;***************************************************************************************

BlockInput(1)
$var = ControlGetText("testtool", "", "[ID:1016]")
ControlClick("testtool", "", "[ID:1016]")
WinWaitActive("testtool")
ControlSend("testtool", "", "[ID:1016]", $title);ControlSend不支持中文
ControlSend("testtool", "", "[ID:1016]", $title1)
ControlSend("testtool", "", "[ID:1016]", $title2)
ControlSend("testtool", "", "[ID:1016]", $title3)
;Send($title)
BlockInput(0)

;***************************************************************************************

If $title3="00" Then ;如果$title3="00"就输出$title3="01"如果不等于就+1
    $title3="01"
ElseIf $title3="01" Then 
    $title3="02"
ElseIf $title3="02" Then    
	$title3="03"
ElseIf $title3="03" Then 
    $title3="04"
ElseIf $title3="04" Then 
    $title3="05"
ElseIf $title3="05" Then    
	$title3="06"
ElseIf $title3="06" Then 
    $title3="07"
ElseIf $title3="07" Then    
	$title3="08"
ElseIf $title3="08" Then 
    $title3="09"
ElseIf $title3=99 Then
	$title3="00"
	$title1 =$title1+1
Else
	$title3=$title3+1
EndIf

;***************************************************************************************	

;***************************************************************************************

IniWrite(@scriptdir & "\序列号和MAC.ini", "title1", "title1", $title1)	
IniWrite(@scriptdir & "\序列号和MAC.ini", "title3", "title3", $title3)	
IniWrite(@scriptdir & "\序列号和MAC.ini", "title5", "title5", $title5)	
IniWrite(@scriptdir & "\序列号和MAC.ini","title4","title4", StringLeft($title11, 6));读取左边六个数，即000f09
IniWrite(@scriptdir & "\序列号和MAC.ini", "title5", "title5", StringMid($title11, 7, 1))	;从第7位开始读取，读取一个字符
IniWrite(@scriptdir & "\序列号和MAC.ini", "title6", "title6", StringMid($title11, 8, 1))	;从第8位开始读取，读取一个字符	
IniWrite(@scriptdir & "\序列号和MAC.ini", "title7", "title7", StringMid($title11, 9, 1))	;从第9位开始读取，读取一个字符
IniWrite(@scriptdir & "\序列号和MAC.ini", "title8", "title8", StringMid($title11, 10, 1)) ;从第10位开始读取，读取一个字符	
IniWrite(@scriptdir & "\序列号和MAC.ini", "title9", "title9", StringMid($title11, 11, 1));从第11位开始读取，读取一个字符	
IniWrite(@scriptdir & "\序列号和MAC.ini", "title10", "title10", StringRight($title11, 1))	;从右边开始读取，读取一个字符，即最后一个字符


Func ShowMessage()   ;Func的意思创建自定义函数
    Dim $i=MsgBox(1,"退出脚本","确定退出脚本吗")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc


;***************************************************************************************
;INN里面初始运行值为
#cs
[title]
title=0
[title1]
title1=3001001
[title2]
title2=120816
[title3]
title3=16
[title4]
title4=
[title5]
title5=
[title6]
title6=
[title7]
title7=
[title8]
title8=
[title9]
title9=
[title10]
title10=
#ce
;***************************************************************************************