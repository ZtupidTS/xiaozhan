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
Global $shinei4= "0", $shinei8= "1", $shnj4= "2", $mkj7= "3", $mkj4= "4",  $menkouji= "10", $jb= "1", $jxhjb= "0" ,  $i =1, $label6, $text,$timer = TimerInit()
;$mkj4 $shnj4 4.3寸

;********************************************************************************************

HotKeySet("^s", "doit")

;********************************************************************************************

$I1= IniRead(@scriptdir & "\burning.ini", "system","bootloader_server_ip","")
$I2= IniRead(@scriptdir & "\burning.ini", "system","bootloader_local_ip","")
$I3= IniRead(@scriptdir & "\burning.ini", "system","mac_address", "")
$I4= IniRead(@scriptdir & "\burning.ini", "system","tar_package_path", "")
$I4= StringReplace($I4,"tftp://", "")
$R1= IniRead(@scriptdir & "\burning.ini", "system","machine_type","")
$R2= IniRead(@scriptdir & "\burning.ini", "system","machine_type","")
$R3= IniRead(@scriptdir & "\burning.ini", "system","machine_type","")
$R4= IniRead(@scriptdir & "\burning.ini", "system","machine_type","")
$R5= IniRead(@scriptdir & "\burning.ini", "system","machine_type","")
$R6= IniRead(@scriptdir & "\burning.ini", "system","machine_type","")
$C1= IniRead(@scriptdir & "\burning.ini", "system","is_unpack_only", "")

;********************************************************************************************

$Form1_1 = GUICreate("可视对讲(烧写配置)", 529, 469, 318, 164)
$Group1 = GUICtrlCreateGroup("选取烧写的内容", 32, 16, 217, 244)
$Radio1 = GUICtrlCreateRadio("室內机 2m dma 4m flash", 72, 44, 153, 17)
$Radio2 = GUICtrlCreateRadio("室內机 2m dma 8m flash", 72, 72, 153, 17)
$Radio3 = GUICtrlCreateRadio("4.3寸室内机", 72, 102, 153, 17)
$Radio4 = GUICtrlCreateRadio("7寸大门口机", 72, 131, 153, 17)
$Radio5 = GUICtrlCreateRadio("4.3寸大门口机", 72, 161, 113, 17)
$Radio6 = GUICtrlCreateRadio("门口机", 72, 192, 113, 17)
$Checkbox1 = GUICtrlCreateCheckbox("只解包", 72, 224, 161, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("高级选项", 272, 16, 217, 244)
$Label1 = GUICtrlCreateLabel("设置 bootloader 服务器 ip", 312, 64, 139, 17)
$Input1 = GUICtrlCreateInput($I1, 312, 96, 145, 21)
$Label2 = GUICtrlCreateLabel("设置 bootloader 本地 ip", 312, 168, 151, 17)
$Input2 = GUICtrlCreateInput($I2, 312, 200, 145, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Label3 = GUICtrlCreateLabel("mac地址", 232, 352, 48, 17)
$Input3 = GUICtrlCreateInput($I3, 168, 376, 185, 21)
$Label4 = GUICtrlCreateLabel("包路径", 232, 296, 48, 17)
$Label5 = GUICtrlCreateLabel("tftp://", 32, 320, 40, 15)
$Input4 = GUICtrlCreateInput($I4, 80, 320, 425, 21)
$Button1 = GUICtrlCreateButton("保存(Ctrl+s)", 96, 416, 89, 25)
$Button2 = GUICtrlCreateButton("取消", 336, 416, 89, 25)
$Label6 = GUICtrlCreateLabel("资料已经保存可以使用配置文件", 200, 416, 124, 25)
GUICtrlSetState(-1, $GUI_HIDE)
GUISetState(@SW_SHOW)


;********************************************************************************************



;AdlibUnregister("_scroll")
;AdlibRegister("_scroll", 1000)

	If $R1 = $shinei4 Then
		GUICtrlSetState($Radio1, $GUI_CHECKED)
	ElseIf $R2 = $shinei8 Then
		GUICtrlSetState($Radio2, $GUI_CHECKED)
	ElseIf $R3 = $shnj4 Then ;4.3寸
		GUICtrlSetState($Radio3, $GUI_CHECKED)
	ElseIf $R4 = $mkj7 Then
		GUICtrlSetState($Radio4, $GUI_CHECKED)
	ElseIf $R5 = $mkj4 Then
		GUICtrlSetState($Radio5, $GUI_CHECKED)
	ElseIf $R6 = $menkouji Then
		GUICtrlSetState($Radio6, $GUI_CHECKED)
	EndIf	
	
	If $C1 = $jb Then
		GUICtrlSetState($Checkbox1, $GUI_CHECKED)
	EndIf	
	
;********************************************************************************************

#EndRegion ### END Koda GUI section ###

While 1

  $msg = GUIGetMsg()
  Select 
	Case $msg =  $GUI_EVENT_CLOSE
		ExitLoop
	Case $msg = $Button2
		Exit
	Case $msg = $Button1
		doit()
	EndSelect
WEnd
Func doit()
		If  BitAnd(GUICtrlRead($Radio1), $GUI_CHECKED) Then ;BitAnd 比较前后两个值
			GUISetState($Radio2, $GUI_UNCHECKED)
			GUISetState($Radio3, $GUI_UNCHECKED)
			GUISetState($Radio4, $GUI_UNCHECKED)
			GUISetState($Radio5, $GUI_UNCHECKED)
			GUISetState($Radio6, $GUI_UNCHECKED)
			IniWrite(@scriptdir & "\burning.ini", "system","machine_type",  $shinei4)
		Else	
			GUISetState($Radio1, $GUI_UNCHECKED)
			GUISetState($Radio2, $GUI_CHECKED)
			GUISetState($Radio3, $GUI_CHECKED)
			GUISetState($Radio4, $GUI_CHECKED)
			GUISetState($Radio5, $GUI_CHECKED)
			GUISetState($Radio6, $GUI_CHECKED)
		EndIf	
		
		If  BitAnd(GUICtrlRead($Radio2), $GUI_CHECKED) Then 
			GUISetState($Radio1, $GUI_UNCHECKED)
			GUISetState($Radio3, $GUI_UNCHECKED)
			GUISetState($Radio4, $GUI_UNCHECKED)
			GUISetState($Radio5, $GUI_UNCHECKED)
			GUISetState($Radio6, $GUI_UNCHECKED)
			IniWrite(@scriptdir & "\burning.ini", "system","machine_type",  $shinei8)
		Else	
			GUISetState($Radio2, $GUI_UNCHECKED)
			GUISetState($Radio1, $GUI_CHECKED)
			GUISetState($Radio3, $GUI_CHECKED)
			GUISetState($Radio4, $GUI_CHECKED)
			GUISetState($Radio5, $GUI_CHECKED)
			GUISetState($Radio6, $GUI_CHECKED)
		EndIf	
		
		If  BitAnd(GUICtrlRead($Radio3), $GUI_CHECKED) Then 
			GUISetState($Radio1, $GUI_UNCHECKED)
			GUISetState($Radio2, $GUI_UNCHECKED)
			GUISetState($Radio4, $GUI_UNCHECKED)
			GUISetState($Radio5, $GUI_UNCHECKED)
			GUISetState($Radio6, $GUI_UNCHECKED)
			IniWrite(@scriptdir & "\burning.ini", "system","machine_type",  $shnj4);4.3寸
		Else	
			GUISetState($Radio3, $GUI_UNCHECKED)
			GUISetState($Radio1, $GUI_CHECKED)
			GUISetState($Radio2, $GUI_CHECKED)
			GUISetState($Radio4, $GUI_CHECKED)
			GUISetState($Radio5, $GUI_CHECKED)
			GUISetState($Radio6, $GUI_CHECKED)
		EndIf	
		
		If  BitAnd(GUICtrlRead($Radio4), $GUI_CHECKED) Then 
			GUISetState($Radio1, $GUI_UNCHECKED)
			GUISetState($Radio2, $GUI_UNCHECKED)
			GUISetState($Radio3, $GUI_UNCHECKED)
			GUISetState($Radio5, $GUI_UNCHECKED)
			GUISetState($Radio6, $GUI_UNCHECKED)
			IniWrite(@scriptdir & "\burning.ini", "system","machine_type",  $mkj7)
		Else	
			GUISetState($Radio4, $GUI_UNCHECKED)
			GUISetState($Radio1, $GUI_CHECKED)
			GUISetState($Radio2, $GUI_CHECKED)
			GUISetState($Radio3, $GUI_CHECKED)
			GUISetState($Radio5, $GUI_CHECKED)
			GUISetState($Radio6, $GUI_CHECKED)
		EndIf	
		
		
		If  BitAnd(GUICtrlRead($Radio5), $GUI_CHECKED) Then ;BitAnd 比较前后两个值
			GUISetState($Radio1, $GUI_UNCHECKED)
			GUISetState($Radio2, $GUI_UNCHECKED)
			GUISetState($Radio3, $GUI_UNCHECKED)
			GUISetState($Radio4, $GUI_UNCHECKED)
			GUISetState($Radio6, $GUI_UNCHECKED)
			IniWrite(@scriptdir & "\burning.ini", "system","machine_type",  $mkj4)
		Else	
			GUISetState($Radio5, $GUI_UNCHECKED)
			GUISetState($Radio1, $GUI_CHECKED)
			GUISetState($Radio2, $GUI_CHECKED)
			GUISetState($Radio3, $GUI_CHECKED)
			GUISetState($Radio4, $GUI_CHECKED)
			GUISetState($Radio6, $GUI_CHECKED)
		EndIf	
		
		If  BitAnd(GUICtrlRead($Radio6), $GUI_CHECKED) Then ;BitAnd 比较前后两个值
			GUISetState($Radio1, $GUI_UNCHECKED)
			GUISetState($Radio2, $GUI_UNCHECKED)
			GUISetState($Radio3, $GUI_UNCHECKED)
			GUISetState($Radio4, $GUI_UNCHECKED)
			GUISetState($Radio5, $GUI_UNCHECKED)
			IniWrite(@scriptdir & "\burning.ini", "system","machine_type",  $menkouji)
		Else	
			GUISetState($Radio6, $GUI_UNCHECKED)
			GUISetState($Radio1, $GUI_CHECKED)
			GUISetState($Radio2, $GUI_CHECKED)
			GUISetState($Radio3, $GUI_CHECKED)
			GUISetState($Radio4, $GUI_CHECKED)
			GUISetState($Radio5, $GUI_CHECKED)
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
        GUICtrlSetState($Label6, $gui_show)		
		AdlibRegister("_scroll", 6000)
		 ;MsgBox(0,"提示","已经保存资料")
EndFunc		;ExitLoop

;********************************************************************************************
	
Func _scroll()
	;
guictrlsetstate($Label6,$gui_hide)


;		;静态效果
       	;GUICtrlSetData($label6, StringLeft($text,$i));动态效果
		;$i += 1
;	Else
;		GUICtrlSetData($label6, '')
;	EndIf
	;$i += 1
EndFunc

;********************************************************************************************

#cs
[system]
# 機器類型:
# 	(0) 室內機 2m dma 4m flash
# 	(1) 室內機 2m dma 8m flash
# 	(3) 4.3寸室内机
# 	(4) 7寸大門口機
# 	(5) 4.3寸門口機
# 	(10) 门口机
machine_type=1

# 是否仅解包
is_unpack_only=0

# 包路径
tar_package_path=tftp://192.168.18.88/4.3_bigdoor_mainboard_2010_04_17.tar

# mac 地址
mac_address=00:01:01:03:00:16

# === 高级选项 ===

# 设置 bootloader 服务器 ip
# bootloader_server_ip=192.168.18.168
bootloader_server_ip=192.168.18.169

# 设置 bootloader 本地 ip
# bootloader_local_ip=192.168.18.15
bootloader_local_ip=192.168.18.15

#ce