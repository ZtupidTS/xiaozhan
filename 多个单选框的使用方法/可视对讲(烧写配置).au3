#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=D:\4.3���׼��Ԫ�ſڻ�.ico
#AutoIt3Wrapper_outfile=���ӶԽ�(��д����).exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=C:\Documents and Settings\Administrator\����\ȫ���ǵ�ѡ��.kxf
;FileInstall("d:\4.3���׼��Ԫ�ſڻ�.ico", @scriptdir & "\4.3���׼��Ԫ�ſڻ�.ico")
;d:\4.3���׼��Ԫ�ſڻ�.ico :: Դ�ļ�·��------
;@scriptdir & "\4.3���׼��Ԫ�ſڻ�.ico" :: Ŀ��·��
Global $shinei4= "0", $shinei8= "1", $menkouji= "10"
$Form1 = GUICreate("���ӶԽ�(��д����)", 267, 208, 192, 124)
$Group1 = GUICtrlCreateGroup("ѡȡ��д������", 32, 16, 201, 121)
$Radio1 = GUICtrlCreateRadio("�҃Ȼ�2m dma 4m flash", 72, 40, 113, 17)
$Radio2 = GUICtrlCreateRadio("�҃Ȼ� 2m dma 8m flash", 72, 72, 113, 17)
$Radio3 = GUICtrlCreateRadio("�ſڻ�", 72, 104, 113, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button1 = GUICtrlCreateButton("ȷ��", 40, 160, 81, 25)
$Button2 = GUICtrlCreateButton("ȡ��", 144, 160, 81, 25)
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