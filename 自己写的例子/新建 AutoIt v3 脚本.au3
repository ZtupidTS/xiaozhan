Run("C:\Documents and Settings\xiaozhan\桌面\testtools\tools\testtool写地址专用.exe","C:\Documents and Settings\xiaozhan\桌面\testtools\tools")

$title4=IniRead("C:\Documents and Settings\xiaozhan\桌面\序列号和MAC1.ini","title4","title4","")
$title5=IniRead("C:\Documents and Settings\xiaozhan\桌面\序列号和MAC1.ini","title5","title5","")
$title6= IniRead("C:\Documents and Settings\xiaozhan\桌面\序列号和MAC1.ini","title6","title6","")
$title7= IniRead("C:\Documents and Settings\xiaozhan\桌面\序列号和MAC1.ini","title7","title7","")
$title8=IniRead("C:\Documents and Settings\xiaozhan\桌面\序列号和MAC1.ini","title8","title8","")
$title9=IniRead("C:\Documents and Settings\xiaozhan\桌面\序列号和MAC1.ini","title9","title9","")
$title10= IniRead("C:\Documents and Settings\xiaozhan\桌面\序列号和MAC1.ini","title10","title10","")
local $IsAdd = 1

BlockInput(1)
$var = ControlGetText("testtool", "", "[ID:1012]")
ControlClick("testtool", "", "[ID:1012]")
WinWaitActive("testtool")
ControlSend("testtool", "", "[ID:1012]", $title4);ControlSend不支持中文
ControlSend("testtool", "", "[ID:1012]", $title5)
ControlSend("testtool", "", "[ID:1012]", $title6)
ControlSend("testtool", "", "[ID:1012]", $title7)
ControlSend("testtool", "", "[ID:1012]", $title8)
ControlSend("testtool", "", "[ID:1012]", $title9)
ControlSend("testtool", "", "[ID:1012]", $title10)
;Send($title)
BlockInput(0)


Func mac( ByRef $hight, ByRef $low, byRef $IsAdd )
	IF $IsAdd = 1 THEN
		$low += 1
	ENDIF

	$IsAdd = 0

	IF $low = 16 THEN
		$low = 0
		$hight += 1
		IF $hight = 16 THEN
			$hight = 0
			$IsAdd = 1		
		ENDIF
	ENDIF
EndFunc 

mac( $title10,$title9,$IsAdd)
mac ($title8, $title7,$IsAdd)

IniWrite("C:\Documents and Settings\xiaozhan\桌面\序列号和MAC1.ini","title4","title4", $title4)
IniWrite("C:\Documents and Settings\xiaozhan\桌面\序列号和MAC1.ini", "title5", "title5", $title5)	
IniWrite("C:\Documents and Settings\xiaozhan\桌面\序列号和MAC1.ini", "title6", "title6", $title6)	
IniWrite("C:\Documents and Settings\xiaozhan\桌面\序列号和MAC1.ini", "title7", "title7", $title7)	
IniWrite("C:\Documents and Settings\xiaozhan\桌面\序列号和MAC1.ini", "title8", "title8", $title8)	
IniWrite("C:\Documents and Settings\xiaozhan\桌面\序列号和MAC1.ini", "title9", "title9", $title9)	
IniWrite("C:\Documents and Settings\xiaozhan\桌面\序列号和MAC1.ini", "title10", "title10", $title10)