#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=c:\documents and settings\administrator\����\form1.kxf
Global $shinei= "luoyongqiang", $menkouji= "lyq"
$Form1 = GUICreate("���ӶԽ�ini�ļ�������", 321, 281, 369, 314)
$Group1 = GUICtrlCreateGroup("BIN�ļ�·��", 16, 8, 273, 89)
$Radio1 = GUICtrlCreateRadio("���ڻ�", 32, 32, 57, 17,$BS_NOTIFY)
GUICtrlSetState(-1, $GUI_CHECKED)
$Radio2 = GUICtrlCreateRadio("�ſڻ�", 32, 64, 57, 17)
$Input1 = GUICtrlCreateInput("", 88, 48, 161, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup(" tar ���ļ�ȫ·������IP", 16, 104, 273, 105)
$Input2 = GUICtrlCreateInput("", 88, 168, 161, 21)
$Label1 = GUICtrlCreateLabel("���� tar ���ļ�ȫ·������IP", 88, 128, 165, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button1 = GUICtrlCreateButton("ȷ��", 32, 232, 97, 25)
$Button2 = GUICtrlCreateButton("ȡ��", 176, 232, 97, 25)
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
	If BitAnd(GUICtrlRead($Radio1), $GUI_CHECKED) Then ;BitAnd �Ƚ�ǰ������ֵ
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