#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=D:\写MAC和序列\4.3寸标准单元门口机.ico
#AutoIt3Wrapper_outfile=可视对讲(烧写配置).exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Include <WinAPIEx.au3>
#Region ### START Koda GUI section ### Form=C:\Documents and Settings\Administrator\桌面\全部是单选框.kxf
;FileInstall("d:\4.3寸标准单元门口机.ico", @scriptdir & "\4.3寸标准单元门口机.ico")
;d:\4.3寸标准单元门口机.ico :: 源文件路径------
;@scriptdir & "\4.3寸标准单元门口机.ico" :: 目标路径
Global $shinei4= "0", $shinei8= "1", $menkouji= "10", $jb= "1", $jxhjb= "0" ,$i =1, $j =1, $label6, $text,$timer = TimerInit()
$Form1_1 = GUICreate("可视对讲(烧写配置)", 524, 294, 192, 124)
$Group1 = GUICtrlCreateGroup("选取烧写的内容", 32, 16, 217, 156)
$Radio1 = GUICtrlCreateRadio("室內机2m dma 4m flash", 72, 40, 145, 17)
$Radio2 = GUICtrlCreateRadio("室內机 2m dma 8m flash", 72, 72, 145, 17)
$Radio3 = GUICtrlCreateRadio("门口机", 72, 104, 113, 17)
$Checkbox1 = GUICtrlCreateCheckbox("只解包", 72, 136, 161, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button1 = GUICtrlCreateButton("保存", 96, 248, 89, 25)
$Button2 = GUICtrlCreateButton("取消", 336, 248, 89, 25)
$Group2 = GUICtrlCreateGroup("高级选项", 272, 16, 217, 156)
$Label1 = GUICtrlCreateLabel("设置 bootloader 服务器 ip", 312, 40, 139, 17)
$Input1 = GUICtrlCreateInput("192.168.18.168", 312, 72, 145, 21)
$Label2 = GUICtrlCreateLabel("设置 bootloader 本地 ip", 312, 104, 151, 17)
$Input2 = GUICtrlCreateInput("192.168.18.15", 312, 136, 145, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Label3 = GUICtrlCreateLabel("mac地址", 352, 184, 48, 17)
$Input3 = GUICtrlCreateInput("", 296, 208, 169, 21)
$Label4 = GUICtrlCreateLabel("包路径", 144, 184, 48, 17)
$Label5 = GUICtrlCreateLabel("tftp://", 40, 208, 40, 15)
$Input4 = GUICtrlCreateInput("", 88, 208, 161, 21)
$Label6 = GUICtrlCreateLabel("", 200, 248, 175, 12)
$text = "资料已经保存可以使用配置文件　　　　　　　　　　　　　"
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
		If  BitAnd(GUICtrlRead($Radio1), $GUI_CHECKED) Then ;BitAnd 比较前后两个值
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
		IniWrite(@scriptdir & "\burning.ini", "system","tar_package_path", GUICtrlRead($Label5) & "" & GUICtrlRead($Input4));同时输出2个值
		AdlibRegister("_scroll", 200)
		 ;MsgBox(0,"提示","已经保存资料")
		;ExitLoop
   EndSelect
 WEnd
Func _scroll()
	If TimerDiff($timer) < 160000 Then
 		If StringLen(GUICtrlRead($label6)) < StringLen($text) Then
			GUICtrlSetData($label6, $text);静态效果
			;GUICtrlSetData($label6, StringLeft($text, $i))
		    ;$i += 1
		Else
           	GUICtrlSetData($label6, StringTrimLeft(GUICtrlRead($label6), 1) & StringLeft(GUICtrlRead($label6), 1))
		EndIf
	Else
		GUICtrlSetData($label6, '')
	EndIf
EndFunc