Run("C:\Documents and Settings\xiaozhan\桌面\testtools\tools\testtool写地址专用.exe","C:\Documents and Settings\xiaozhan\桌面\testtools\tools")
$title=IniRead("C:\Documents and Settings\xiaozhan\桌面\序列号和MAC1.ini","title4","title4","");从ini文件读取title4中的值
$title=$title & IniRead("C:\Documents and Settings\xiaozhan\桌面\序列号和MAC1.ini","title5","title5","");从ini文件读取title5中的值，并与刚读取的title4的值连在一起
$title=$title & IniRead("C:\Documents and Settings\xiaozhan\桌面\序列号和MAC1.ini","title6","title6","");从ini文件读取title6中的值，并与刚读取的title5的值连在一起
$title=$title & IniRead("C:\Documents and Settings\xiaozhan\桌面\序列号和MAC1.ini","title7","title7","");从ini文件读取title7中的值，并与刚读取的title6的值连在一起
$title=$title & IniRead("C:\Documents and Settings\xiaozhan\桌面\序列号和MAC1.ini","title8","title8","");从ini文件读取title8中的值，并与刚读取的title7的值连在一起
$title=$title & IniRead("C:\Documents and Settings\xiaozhan\桌面\序列号和MAC1.ini","title9","title9","");从ini文件读取title9中的值，并与刚读取的title8的值连在一起
$title=$title & IniRead("C:\Documents and Settings\xiaozhan\桌面\序列号和MAC1.ini","title10","title10","");从ini文件读取title10中的值，并与刚读取的title9的值连在一起
Opt("WinTitleMatchMode")
WinWait("testtool","",1)
BlockInput(1)
$var = ControlGetText("testtool", "", "[ID:1012]")
ControlClick("testtool", "", "[ID:1012]")
WinWaitActive("testtool")
ControlSend("testtool", "", "[ID:1012]", $title);000f09
If stringlen($title)= 0 then
 $title= "000f09000000"
 ControlSend("testtool", "", "[ID:1012]", $title);000f09
else
 $title = "000f09" & Hex(Dec(StringTrimLeft($title, 6))+1, 6) ;将读取到的字符串前六位删除后转成十进制，然后加1，再转回6位数的16进制并和前面删除的原字符串的前六位合并
endif
 

;Send($title)
BlockInput(0)
IniWrite("C:\Documents and Settings\xiaozhan\桌面\序列号和MAC1.ini","title4","title4", StringLeft($title, 6));读取左边六个数，即000f09
IniWrite("C:\Documents and Settings\xiaozhan\桌面\序列号和MAC1.ini", "title5", "title5", StringMid($title, 7, 1));从第7位开始读取，读取一个字符
IniWrite("C:\Documents and Settings\xiaozhan\桌面\序列号和MAC1.ini", "title6", "title6", StringMid($title, 8, 1))	;从第8位开始读取，读取一个字符
IniWrite("C:\Documents and Settings\xiaozhan\桌面\序列号和MAC1.ini", "title7", "title7", StringMid($title, 9, 1))	;从第9位开始读取，读取一个字符
IniWrite("C:\Documents and Settings\xiaozhan\桌面\序列号和MAC1.ini", "title8", "title8", StringMid($title, 10, 1))	;从第10位开始读取，读取一个字符
IniWrite("C:\Documents and Settings\xiaozhan\桌面\序列号和MAC1.ini", "title9", "title9", StringMid($title, 11, 1))	;从第11位开始读取，读取一个字符
IniWrite("C:\Documents and Settings\xiaozhan\桌面\序列号和MAC1.ini", "title10", "title10", StringRight($title, 1));从右边开始读取，读取一个字符，即最后一个字符

;***********************************************************************************************************************
;INN里面初始运行值为
#cs
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
