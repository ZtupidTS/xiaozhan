#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=c:\documents and settings\administrator\桌面\form1.kxf
Global $shinei= "luoyongqiang", $menkouji= "lyq"
$Form1 = GUICreate("可视对讲ini文件配置起", 321, 281, 369, 314)
$Group1 = GUICtrlCreateGroup("BIN文件路径", 16, 8, 273, 89)
$Radio1 = GUICtrlCreateRadio("室内机", 32, 32, 57, 17,$BS_NOTIFY)
GUICtrlSetState(-1, $GUI_CHECKED)
$Radio2 = GUICtrlCreateRadio("门口机", 32, 64, 57, 17)
$Input1 = GUICtrlCreateInput("", 88, 48, 161, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup(" tar 包文件全路径包括IP", 16, 104, 273, 105)
$Input2 = GUICtrlCreateInput("", 88, 168, 161, 21)
$Label1 = GUICtrlCreateLabel("输入 tar 包文件全路径包括IP", 88, 128, 165, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button1 = GUICtrlCreateButton("确定", 32, 232, 97, 25)
$Button2 = GUICtrlCreateButton("取消", 176, 232, 97, 25)
GUISetState(@SW_SHOW)

#EndRegion ### END Koda GUI section ###
While 1
 
  $msg = GUIGetMsg()
  Select 
	Case $msg =  $GUI_EVENT_CLOSE
		ExitLoop
	Case $msg = $Button2
		Exit
	Case $msg = $Button1
	If BitAnd(GUICtrlRead($Radio1), $GUI_CHECKED) Then ;BitAnd 比较前后两个值
		GUISetState($Radio2, $GUI_UNCHECKED)
		IniWrite(@scriptdir & "\aa.ini", "system","binary_image_path",  $shinei  & "/" & GUICtrlRead($Input1))
	Else	
		GUISetState($Radio1, $GUI_UNCHECKED)
		GUISetState($Radio2, $GUI_CHECKED)
	EndIf	
	
	If BitAnd(GUICtrlRead($Radio2), $GUI_CHECKED) Then 
		GUISetState($Radio1, $GUI_UNCHECKED)
		IniWrite(@scriptdir & "\aa.ini", "system","binary_image_path",  $menkouji  & "/" & GUICtrlRead($Input1))
	Else	
		GUISetState($Radio2, $GUI_UNCHECKED)
		GUISetState($Radio1, $GUI_CHECKED)
	EndIf	
	
	    IniWrite(@scriptdir & "\aa.ini", "system","tar_package_file_name", GUICtrlRead($Input2))
	
	ExitLoop

   EndSelect
 WEnd