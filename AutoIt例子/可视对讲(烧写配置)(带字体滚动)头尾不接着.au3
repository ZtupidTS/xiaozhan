#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=D:\дMAC������\4.3���׼��Ԫ�ſڻ�.ico
#AutoIt3Wrapper_outfile=���ӶԽ�(��д����).exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Include <WinAPIEx.au3>
#Region ### START Koda GUI section ### Form=C:\Documents and Settings\Administrator\����\ȫ���ǵ�ѡ��.kxf
;FileInstall("d:\4.3���׼��Ԫ�ſڻ�.ico", @scriptdir & "\4.3���׼��Ԫ�ſڻ�.ico")
;d:\4.3���׼��Ԫ�ſڻ�.ico :: Դ�ļ�·��------
;@scriptdir & "\4.3���׼��Ԫ�ſڻ�.ico" :: Ŀ��·��
Global $shinei4= "0", $shinei8= "1", $menkouji= "10", $jb= "1", $jxhjb= "0" ,$i =1, $j =1, $label6, $text,$timer = TimerInit()
$Form1_1 = GUICreate("���ӶԽ�(��д����)", 524, 294, 192, 124)
$Group1 = GUICtrlCreateGroup("ѡȡ��д������", 32, 16, 217, 156)
$Radio1 = GUICtrlCreateRadio("�҃Ȼ�2m dma 4m flash", 72, 40, 145, 17)
$Radio2 = GUICtrlCreateRadio("�҃Ȼ� 2m dma 8m flash", 72, 72, 145, 17)
$Radio3 = GUICtrlCreateRadio("�ſڻ�", 72, 104, 113, 17)
$Checkbox1 = GUICtrlCreateCheckbox("ֻ���", 72, 136, 161, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button1 = GUICtrlCreateButton("����", 96, 248, 89, 25)
$Button2 = GUICtrlCreateButton("ȡ��", 336, 248, 89, 25)
$Group2 = GUICtrlCreateGroup("�߼�ѡ��", 272, 16, 217, 156)
$Label1 = GUICtrlCreateLabel("���� bootloader ������ ip", 312, 40, 139, 17)
$Input1 = GUICtrlCreateInput("192.168.18.168", 312, 72, 145, 21)
$Label2 = GUICtrlCreateLabel("���� bootloader ���� ip", 312, 104, 151, 17)
$Input2 = GUICtrlCreateInput("192.168.18.15", 312, 136, 145, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Label3 = GUICtrlCreateLabel("mac��ַ", 352, 184, 48, 17)
$Input3 = GUICtrlCreateInput("", 296, 208, 169, 21)
$Label4 = GUICtrlCreateLabel("��·��", 144, 184, 48, 17)
$Label5 = GUICtrlCreateLabel("tftp://", 40, 208, 40, 15)
$Input4 = GUICtrlCreateInput("", 88, 208, 161, 21)
$Label6 = GUICtrlCreateLabel("", 200, 248, 175, 12)
$text = "�����Ѿ��������ʹ�������ļ���������������������������"
;AdlibRegister("_scroll", 200)
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
		If  BitAnd(GUICtrlRead($Radio1), $GUI_CHECKED) Then ;BitAnd �Ƚ�ǰ������ֵ
			GUISetState($Radio2, $GUI_UNCHECKED)
			GUISetState($Radio3, $GUI_UNCHECKED)
			IniWrite(@scriptdir & "\burning.ini", "system","machine_type",  $shinei4)
		Else	
			GUISetState($Radio1, $GUI_UNCHECKED)
			GUISetState($Radio2, $GUI_CHECKED)
			GUISetState($Radio3, $GUI_CHECKED)
		EndIf	
		
		If  BitAnd(GUICtrlRead($Radio2), $GUI_CHECKED) Then 
			GUISetState($Radio3, $GUI_UNCHECKED)
			GUISetState($Radio2, $GUI_UNCHECKED)
			IniWrite(@scriptdir & "\burning.ini", "system","machine_type",  $shinei8)
		Else	
			GUISetState($Radio2, $GUI_UNCHECKED)
			GUISetState($Radio1, $GUI_CHECKED)
			GUISetState($Radio3, $GUI_CHECKED)
		EndIf	
		
		If  BitAnd(GUICtrlRead($Radio3), $GUI_CHECKED) Then 
			GUISetState($Radio1, $GUI_UNCHECKED)
			GUISetState($Radio2, $GUI_UNCHECKED)
			IniWrite(@scriptdir & "\burning.ini", "system","machine_type",  $menkouji)
		Else	
			GUISetState($Radio3, $GUI_UNCHECKED)
			GUISetState($Radio1, $GUI_CHECKED)
			GUISetState($Radio2, $GUI_CHECKED)
		EndIf	
		
		IF  BitAND (GUICtrlRead ($Checkbox1),$GUI_CHECKED) Then 
			IniWrite(@scriptdir & "\burning.ini", "system","is_unpack_only",  $jb)
		Else
			IniWrite(@scriptdir & "\burning.ini", "system","is_unpack_only",  $jxhjb)
		EndIf
		IniWrite(@scriptdir & "\burning.ini", "system","bootloader_server_ip", GUICtrlRead($Input1))
		IniWrite(@scriptdir & "\burning.ini", "system","bootloader_local_ip", GUICtrlRead($Input2))
		IniWrite(@scriptdir & "\burning.ini", "system","mac_address", GUICtrlRead($Input3))
		IniWrite(@scriptdir & "\burning.ini", "system","tar_package_path", GUICtrlRead($Label5) & "" & GUICtrlRead($Input4));ͬʱ���2��ֵ
		AdlibRegister("_scroll", 200)
		 ;MsgBox(0,"��ʾ","�Ѿ���������")
		;ExitLoop
   EndSelect
 WEnd
Func _scroll()
	If TimerDiff($timer) < 160000 Then
 		If StringLen(GUICtrlRead($label6)) < StringLen($text) Then
			GUICtrlSetData($label6, $text);��̬Ч��
			;GUICtrlSetData($label6, StringLeft($text, $i))
		    ;$i += 1
		Else
           	GUICtrlSetData($label6, StringTrimLeft(GUICtrlRead($label6), 1) & StringLeft(GUICtrlRead($label6), 1))
		EndIf
	Else
		GUICtrlSetData($label6, '')
	EndIf
EndFunc