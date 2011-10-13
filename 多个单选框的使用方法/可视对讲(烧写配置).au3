#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=D:\4.3寸标准单元门口机.ico
#AutoIt3Wrapper_outfile=可视对讲(烧写配置).exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=C:\Documents and Settings\Administrator\桌面\全部是单选框.kxf
;FileInstall("d:\4.3寸标准单元门口机.ico", @scriptdir & "\4.3寸标准单元门口机.ico")
;d:\4.3寸标准单元门口机.ico :: 源文件路径------
;@scriptdir & "\4.3寸标准单元门口机.ico" :: 目标路径
Global $shinei4= "0", $shinei8= "1", $menkouji= "10"
$Form1 = GUICreate("可视对讲(烧写配置)", 267, 208, 192, 124)
$Group1 = GUICtrlCreateGroup("选取烧写的内容", 32, 16, 201, 121)
$Radio1 = GUICtrlCreateRadio("室內机2m dma 4m flash", 72, 40, 113, 17)
$Radio2 = GUICtrlCreateRadio("室內机 2m dma 8m flash", 72, 72, 113, 17)
$Radio3 = GUICtrlCreateRadio("门口机", 72, 104, 113, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button1 = GUICtrlCreateButton("确定", 40, 160, 81, 25)
$Button2 = GUICtrlCreateButton("取消", 144, 160, 81, 25)
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
		GUISetState($Radio3, $GUI_UNCHECKED)
		IniWrite(@scriptdir & "\burning.ini", "system","machine_type",  $shinei4)
	Else	
		GUISetState($Radio1, $GUI_UNCHECKED)
		GUISetState($Radio2, $GUI_CHECKED)
		GUISetState($Radio3, $GUI_CHECKED)
	EndIf	
	
	If BitAnd(GUICtrlRead($Radio2), $GUI_CHECKED) Then 
		GUISetState($Radio3, $GUI_UNCHECKED)
		GUISetState($Radio2, $GUI_UNCHECKED)
		IniWrite(@scriptdir & "\burning.ini", "system","machine_type",  $shinei8)
	Else	
		GUISetState($Radio2, $GUI_UNCHECKED)
		GUISetState($Radio1, $GUI_CHECKED)
		GUISetState($Radio3, $GUI_CHECKED)
	EndIf	
	
		If BitAnd(GUICtrlRead($Radio3), $GUI_CHECKED) Then 
		GUISetState($Radio1, $GUI_UNCHECKED)
		GUISetState($Radio2, $GUI_UNCHECKED)
		IniWrite(@scriptdir & "\burning.ini", "system","machine_type",  $menkouji)
	Else	
		GUISetState($Radio3, $GUI_UNCHECKED)
		GUISetState($Radio1, $GUI_CHECKED)
		GUISetState($Radio2, $GUI_CHECKED)
	EndIf	
	
	ExitLoop

   EndSelect
 WEnd