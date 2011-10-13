#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=I:\新建文件夹 (2)\简易出租屋管理系统V1.0.exe|-1
#AutoIt3Wrapper_outfile=e:\我的文档\桌面\简易出租屋管理系统.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=简易出租屋管理系统V1.0
#AutoIt3Wrapper_Res_Description=简易出租屋管理系统V1.0
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=www.bbinker.com   林少
#AutoIt3Wrapper_Res_Field=联系作者|QQ:1492162368
#AutoIt3Wrapper_Tidy_Stop_OnError=n
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/striponly
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListView.au3>
#include <ListViewConstants.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <ProgressConstants.au3>
#include <ie.au3>
AutoItSetOption("TrayIconHide", 1)
If @YEAR = 2050 Then
	MsgBox(0, "", "本程序在2010年8月26日 12:55:54 制作完成至今2050年 已有40年的历史！此作品是我的第一个作品，现在它该退休了。谢谢大家的支持！")
	Exit
EndIf
FileDelete("start.dll")
FileInstall("startin.dll", "start.dll")
If Not FileExists("sqltest.mdb") Then FileCopy("start.dll", "sqltest.mdb")
FileDelete("start.dll")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FileDelete("abuotset.dll")
FileInstall("abuotsetbak.dll", "abuotset.dll")
If Not FileExists("abuotset.ini") Then FileCopy("abuotset.dll", "abuotset.ini")
FileDelete("abuotset.dll")
Dim $ii, $Tiaojian, $zdsl, $clt, $i, $ListView1, $iiii, $xsItemset, $ttyyy, $hejiset, $i6, $Progress1, $Formjd, $i7, $i9, $i8, $zdywhere
Dim $guiitem, $xsItemsety, $RS, $addfld, $AutoIDyz, $inputtxt, $addEditbztxt, $addEditbz, $addbeizhuyzcfsl, $addbeizhuyzcf, $Formbz, $addFormbz
Dim $Inputc[2]
Dim $Input[29]
Dim $swhere = ""
Dim $wihthy, $addf1
Dim $checkbutt1 = 1
Dim $yanzhenzhenshu = 0
Dim $jidushu = 0
Dim $jidushu2 = 0
Dim $jidushu3 = 0
$Tiaojianset = "房号,缴费或当前日期,缴费情况"
Dim $Inputz[3]
Dim $Inputzzt[3]
Dim $danxuan[6];;;;;;;;;;
Dim $Radio[6];;;;;;;;
Dim $ccr[26];;;;;;;
Dim $Checkbox[26];;;;;;;
Dim $ccrtxt[26];;;;;;;;
Dim $hejiset[26];;;;;;;;;
$mdb_data_path = "sqltest.mdb"
$tblname = "keku"
$mdb_data_pwd = "SQl25831sql"
$nowtime = "date()"
#Region ### START Koda GUI section ### Form=c:\documents and settings\administrator\my documents\auto\form1.kxf
hejiandtime()
#Region ### START Koda GUI section ### Form=
$Formbz = GUICreate("备注查看/修改 (修改后直接关闭即可自动保存)", 420, 317, -1, -1)
;~ _SkinGUI("SkinCrafterDll_31.dll", $bf, $Formbz )  ;调用皮肤DLL
$bezhu = GUICtrlCreateEdit("", 0, 0, 417, 313, $ES_AUTOVSCROLL + $WS_VSCROLL)
#EndRegion ### END Koda GUI section ###
$Form1_1 = GUICreate("   简易出租屋管理系统   V1.0   BY:林少", 778, 677, -1, -1)

$MenuItem1 = GUICtrlCreateMenu("文件(&X)")
$MenuItem3 = GUICtrlCreateMenu("编辑(&Y)")
$MenuItem2 = GUICtrlCreateMenu("帮助(&Z)")
$Tab1 = GUICtrlCreateTab(8, 280, 761, 361)
$TabSheet1 = GUICtrlCreateTabItem("查询系统")
$Group2 = GUICtrlCreateGroup("选项", 16, 312, 737, 185)
$Checkbox[0] = GUICtrlCreateCheckbox("用户名", 40, 336, 90, 25)
$Checkbox[1] = GUICtrlCreateCheckbox("水费", 40, 360, 90, 25)
$Checkbox[2] = GUICtrlCreateCheckbox("电费", 40, 384, 90, 25)
$Checkbox[3] = GUICtrlCreateCheckbox("电视费", 40, 408, 90, 25)
GUICtrlSetData($Progress1, 60)
Sleep(200)
$Group3 = GUICtrlCreateGroup("", 24, 328, 121, 161)
$Checkbox[4] = GUICtrlCreateCheckbox("垃圾费", 40, 432, 90, 25)
$Checkbox[5] = GUICtrlCreateCheckbox("本次应缴费", 28, 456, 100, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group4 = GUICtrlCreateGroup("", 176, 336, 113, 153)
$Checkbox[6] = GUICtrlCreateCheckbox("性别", 192, 352, 90, 25)
$Checkbox[7] = GUICtrlCreateCheckbox("副用户名", 192, 384, 90, 25)
$Checkbox[8] = GUICtrlCreateCheckbox("身份证号码", 192, 416, 90, 25)
$Checkbox[9] = GUICtrlCreateCheckbox("出生地址", 192, 448, 90, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group5 = GUICtrlCreateGroup("", 320, 336, 121, 153)
$Checkbox[10] = GUICtrlCreateCheckbox("联系人电话", 336, 352, 89, 25)
$Checkbox[11] = GUICtrlCreateCheckbox("基本月租", 336, 384, 89, 25)
$Checkbox[12] = GUICtrlCreateCheckbox("合同开始日", 336, 416, 97, 25)
$Checkbox[13] = GUICtrlCreateCheckbox("合同结束日", 336, 448, 81, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group6 = GUICtrlCreateGroup("", 472, 336, 113, 153)
$Checkbox[14] = GUICtrlCreateCheckbox("其他费用", 488, 352, 89, 25)
$Checkbox[15] = GUICtrlCreateCheckbox("水单价X吨", 488, 384, 81, 25)
$Checkbox[16] = GUICtrlCreateCheckbox("电单价X度", 488, 416, 89, 25)
$Checkbox[17] = GUICtrlCreateCheckbox("租房押金", 488, 448, 89, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group7 = GUICtrlCreateGroup("", 600, 320, 145, 169)
$Checkbox[18] = GUICtrlCreateCheckbox("清洁费", 608, 336, 58, 25)
$Checkbox[19] = GUICtrlCreateCheckbox("维修费", 608, 360, 58, 25)
$Checkbox[20] = GUICtrlCreateCheckbox("备注", 608, 384, 129, 25)
$Checkbox[21] = GUICtrlCreateCheckbox("生活费总和", 608, 408, 129, 25)
$Checkbox[22] = GUICtrlCreateCheckbox("用水量", 608, 432, 129, 25)
$Checkbox[23] = GUICtrlCreateCheckbox("用电量", 608, 456, 121, 25)
$Checkbox[24] = GUICtrlCreateCheckbox("今期水量", 672, 336, 65, 25)
$Checkbox[25] = GUICtrlCreateCheckbox("今期电量", 672, 360, 65, 25)
GUICtrlSetData($Progress1, 70)
Sleep(200)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group8 = GUICtrlCreateGroup("自定义查询", 16, 504, 609, 129)
$Label = GUICtrlCreateLabel("姓名:", 40, 568, 40, 24)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$Label = GUICtrlCreateLabel("房号:", 40, 544, 40, 24)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$Group9 = GUICtrlCreateGroup("", 32, 528, 169, 97)
$Inputz[0] = GUICtrlCreateInput("", 88, 544, 97, 21)
$Inputz[1] = GUICtrlCreateInput("", 88, 568, 97, 21)
$Label = GUICtrlCreateLabel("时间:", 40, 592, 40, 24)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$Inputz[2] = GUICtrlCreateInput("", 88, 592, 97, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group10 = GUICtrlCreateGroup("快速查询", 224, 520, 385, 105)
GUICtrlSetColor($Group10, 0x0000FF)
GUICtrlSetData($Progress1, 80)
Sleep(200)
$Radio[0] = GUICtrlCreateRadio("列出未缴费用户", 240, 544, 110, 25)
$Radio[1] = GUICtrlCreateRadio("列出已缴费用户", 240, 576, 110, 25)
$Radio[2] = GUICtrlCreateRadio("未定义", 352, 544, 121, 25)
GUICtrlSetState($Radio[2], $GUI_DISABLE);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
$Radio[3] = GUICtrlCreateRadio("未定义", 352, 576, 120, 25)
GUICtrlSetState($Radio[3], $GUI_DISABLE);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
$Radio[4] = GUICtrlCreateRadio("未定义", 480, 544, 120, 25)
GUICtrlSetState($Radio[4], $GUI_DISABLE);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
$Radio[5] = GUICtrlCreateRadio("全部显示", 480, 576, 120, 25)
GUICtrlSetState($Radio[5], $GUI_CHECKED);;;;;;;默认选中 $radio5
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button1 = GUICtrlCreateButton("确定查询", 632, 520, 129, 41)
$Button2 = GUICtrlCreateButton("重选", 632, 576, 129, 41)
$TabSheet2 = GUICtrlCreateTabItem("添加/修改信息")
$Group12 = GUICtrlCreateGroup("", 16, 304, 745, 321)
$Group11 = GUICtrlCreateGroup("第一步", 24, 312, 201, 305)
$CEdit = GUICtrlCreateEdit("Null", 80, 360, 115, 20, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL))
GUICtrlSetState($CEdit, $GUI_DISABLE)
$Label3 = GUICtrlCreateLabel("信息", 40, 360, 52, 24)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$Button3 = GUICtrlCreateButton("读取", 40, 392, 161, 49)
$Group13 = GUICtrlCreateGroup("", 32, 336, 185, 113)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group14 = GUICtrlCreateGroup("", 32, 456, 185, 153)
$Label4 = GUICtrlCreateLabel("用户名", 40, 480, 52, 24)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$Label5 = GUICtrlCreateLabel("房号", 40, 512, 36, 24)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$Inputc[0] = GUICtrlCreateInput("", 96, 480, 105, 21)
$Inputc[1] = GUICtrlCreateInput("", 96, 512, 105, 21)
$Button4 = GUICtrlCreateButton("添加", 40, 544, 163, 49)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group15 = GUICtrlCreateGroup("第二步", 240, 312, 513, 305)
$Group16 = GUICtrlCreateGroup("", 248, 328, 225, 281)
$Label6 = GUICtrlCreateLabel("性别", 256, 344, 28, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Label7 = GUICtrlCreateLabel("联系人电话", 256, 440, 64, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Label8 = GUICtrlCreateLabel("租房押金", 256, 512, 52, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Label9 = GUICtrlCreateLabel("合同开始日", 256, 464, 64, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Label10 = GUICtrlCreateLabel("合同结束日", 256, 488, 64, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Label11 = GUICtrlCreateLabel("身份证号码", 256, 392, 64, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Label12 = GUICtrlCreateLabel("副用户名", 256, 368, 52, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Label13 = GUICtrlCreateLabel("出生地址", 256, 416, 52, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Input[3] = GUICtrlCreateInput("", 328, 368, 121, 21)
$Input[4] = GUICtrlCreateInput("", 328, 392, 121, 21)
$Input[5] = GUICtrlCreateInput("", 328, 416, 121, 21)
$Input[6] = GUICtrlCreateInput("", 328, 440, 121, 21)
$Input[8] = GUICtrlCreateInput("", 328, 464, 121, 21)
$Input[9] = GUICtrlCreateInput("", 328, 488, 121, 21)
$Input[10] = GUICtrlCreateInput(IniRead("abuotset.ini", "Fixed", "Earnestmoney", "0"), 328, 512, 121, 21)
$Label28 = GUICtrlCreateLabel("基本月租", 256, 536, 52, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Input[7] = GUICtrlCreateInput(IniRead("abuotset.ini", "Fixed", "Monthly", "0"), 328, 536, 121, 21)
$Label14 = GUICtrlCreateLabel("缴费或当前日期", 256, 560, 88, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Input[11] = GUICtrlCreateInput("", 344, 560, 121, 21)
$Label24 = GUICtrlCreateLabel("缴费情况 ", 256, 584, 55, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Input[2] = GUICtrlCreateInput("", 328, 344, 121, 21)
$Input[12] = GUICtrlCreateInput("", 328, 584, 121, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group17 = GUICtrlCreateGroup("", 480, 328, 265, 289)
$Label15 = GUICtrlCreateLabel("电费", 488, 464, 28, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x008000)
$Label18 = GUICtrlCreateLabel("电视费", 488, 488, 40, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Label20 = GUICtrlCreateLabel("垃圾费", 488, 512, 40, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Label22 = GUICtrlCreateLabel("水费", 488, 392, 28, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x008000)
$Label23 = GUICtrlCreateLabel("清洁费", 488, 536, 40, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Label25 = GUICtrlCreateLabel("维修费", 488, 560, 40, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Input[16] = GUICtrlCreateInput("", 544, 392, 57, 21)
$Input[20] = GUICtrlCreateInput("", 536, 464, 57, 21)
$Input[21] = GUICtrlCreateInput(IniRead("abuotset.ini", "Fixed", "TVfee", "0"), 536, 488, 57, 21)
$Input[22] = GUICtrlCreateInput(IniRead("abuotset.ini", "Fixed", "Garbagefee", "0"), 536, 512, 57, 21)
$Input[23] = GUICtrlCreateInput(IniRead("abuotset.ini", "Fixed", "Cleaningfee", "0"), 536, 536, 57, 21)
$Input[24] = GUICtrlCreateInput(IniRead("abuotset.ini", "Fixed", "Maintenance", "0"), 536, 560, 57, 21)
$Button5 = GUICtrlCreateButton("保存当前信息", 483, 584, 85, 25)
$Buttonurl = GUICtrlCreateButton("载入默认值", 665, 584, 70, 25)
$Buttonmr = GUICtrlCreateButton("修改默认值", 580, 584, 75, 25)
$Label16 = GUICtrlCreateLabel("用电量", 488, 440, 40, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Label17 = GUICtrlCreateLabel("今期水量", 488, 344, 52, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Input[13] = GUICtrlCreateInput("", 544, 344, 57, 21)
$Input[14] = GUICtrlCreateInput("", 544, 368, 57, 21)
$Label19 = GUICtrlCreateLabel("用水量", 488, 368, 40, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Input[18] = GUICtrlCreateInput("", 536, 440, 57, 21)
$Label26 = GUICtrlCreateLabel("今期电量", 488, 416, 52, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Input[17] = GUICtrlCreateInput("", 544, 416, 57, 21)
$Group18 = GUICtrlCreateGroup("", 616, 336, 121, 105)
$Label29 = GUICtrlCreateLabel("水单价X吨", 648, 352, 59, 17)
$Input[15] = GUICtrlCreateInput(IniRead("abuotset.ini", "Fixed", "WaterPrice", "0"), 632, 368, 89, 21)
$Label30 = GUICtrlCreateLabel("电单价X度", 648, 392, 59, 17)
$Input[19] = GUICtrlCreateInput(IniRead("abuotset.ini", "Fixed", "Powerunit", "0"), 632, 408, 89, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Label31 = GUICtrlCreateLabel("其他费用", 616, 448, 52, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Input[26] = GUICtrlCreateInput("", 672, 448, 65, 21)
$Label32 = GUICtrlCreateLabel("本次应缴费", 616, 472, 64, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x008000)
$Input[27] = GUICtrlCreateInput("", 680, 472, 57, 21)
$Group21 = GUICtrlCreateGroup("", 608, 496, 129, 81)
$Label33 = GUICtrlCreateLabel("若绿色的选项留空", 624, 520, 100, 17)
GUICtrlSetColor(-1, 0x008000)
$Label34 = GUICtrlCreateLabel("系统将会自动计算", 616, 544, 100, 17)
GUICtrlSetColor(-1, 0x008000)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button6 = GUICtrlCreateButton("修改", 448, 264, 89, 33)
$Button8 = GUICtrlCreateButton("删除", 544, 264, 89, 33)
$Button9 = GUICtrlCreateButton("备注查看/修改", 640, 264, 100, 33)
Listset("*")
GUICtrlSetData($Progress1, 100)
Sleep(1500)
GUISetState(@SW_HIDE, $Formjd)
GUISetState(@SW_SHOW, $Form1_1)
#EndRegion ### END Koda GUI section ###

While 1
	Sleep(2)
	checkINT()
	$nMsg = GUIGetMsg()

	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			_GUICtrlListView_UnRegisterSortCallBack($ListView1)
			FileDelete("start.dll")

			Exit
		Case $Button1
			$checkbutt1 = 1
			checkboxget()
		Case $ListView1
			paixu()

		Case $Button3
			checkboxget()
		Case $Button5
			savexx()
			$checkbutt1 = 1
			checkboxget()
		Case $Button4
			tianjiaxinxi()
			$checkbutt1 = 1
			checkboxget()
		Case $Button6
			GUICtrlSetState($TabSheet2, $GUI_SHOW)
		Case $Button8
			del()
			$checkbutt1 = 1
			checkboxget()
		Case $Button9
			chakanbeizhu()
			$checkbutt1 = 1
			checkboxget()
		Case $Buttonmr
			ShellExecuteWait("abuotset.ini")
		Case $Buttonurl
			zairumoren()
	EndSwitch

WEnd

Func checkboxget();;;;;读取复选框文本
	For $i7 = 0 To 5
		$danxuan[$i7] = GUICtrlRead($Radio[$i7])
	Next
	;;;;;;;;;;;;;;;;;;;;;;;;;待添加where条件;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	If $danxuan[0] = $GUI_CHECKED Then
		$swhere = 'where 缴费情况 = "未缴费"';;;;有空格
	ElseIf $danxuan[1] = $GUI_CHECKED Then
		$swhere = 'where 缴费情况 = "已缴费"';;;;有空格
	Else
		$swhere = ""
	EndIf
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;~ ============================获取复选框的信息=================================
	$Tiaojianset = "房号,缴费或当前日期,缴费情况"
	For $ii = 0 To 25;;;;;;;;;;;;
		$ccr[$ii] = GUICtrlRead($Checkbox[$ii]);判断是否已选中
		$ccrtxt[$ii] = GUICtrlRead($Checkbox[$ii], 1)
	Next
	For $i = 0 To 25;;;;;;;;;;;;;
		If $ccr[$i] = $GUI_CHECKED Then
			$ttyyy = 1
			$Tiaojianset = $Tiaojianset & "," & $ccrtxt[$i];;;;把选中的txt并在一起
		EndIf
	Next
	$Tiaojianset = $Tiaojianset & "," & "AutoID"
	zidingyichaxun()
	If $ttyyy = 1 Then ;;;;;;如果全部没有选中则 listest的参数为*
		$ttyyy = 0
		listset($Tiaojianset)
	Else
		If $checkbutt1 = 1 Then GUICtrlDelete($ListView1);;;判断是按那个按钮才触发的
		Listset("*")
	EndIf

EndFunc   ;==>checkboxget
Func zidingyichaxun()
	For $i9 = 0 To 2 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		$Inputzzt[$i9] = GUICtrlRead($Inputz[$i9])
	Next
	$zdywhere = ""
	If $swhere = "" Then
		$swhere = 'where 用户名<>"" '
		If $Inputzzt[0] <> "" And $swhere <> "" Then $zdywhere = $zdywhere & "and 房号 like " & '"%"' & "&" & $Inputzzt[0] & "&" & '"%"' & " "
		If $Inputzzt[1] <> "" And $swhere <> "" Then $zdywhere = $zdywhere & "and 用户名 like " & '"%' & $Inputzzt[1] & '%"' & " "
		If $Inputzzt[2] <> "" And $swhere <> "" Then $zdywhere = $zdywhere & "and 缴费或当前日期 like " & '"%' & $Inputzzt[2] & '%"' & " "
	Else
		If $Inputzzt[0] <> "" And $swhere <> "" Then $zdywhere = $zdywhere & "and 房号 like " & '"%"' & "&" & $Inputzzt[0] & "&" & '"%"' & " "
		If $Inputzzt[1] <> "" And $swhere <> "" Then $zdywhere = $zdywhere & "and 用户名 like " & '"%' & $Inputzzt[1] & '%"' & " "
		If $Inputzzt[2] <> "" And $swhere <> "" Then $zdywhere = $zdywhere & "and 缴费或当前日期 like " & '"%' & $Inputzzt[2] & '%"' & " "
	EndIf
	If StringIsInt($Inputzzt[0]) = 0 And $Inputzzt[0] <> "" Then ;;;;;;;判断 房号是否整数！
		MsgBox(0, "错误!", "请确定您在 自定义查询-【房号】输入框处输入的是整数！请返回修改！ ")
		$zdywhere = ""
	Else
		$yanzhenzhenshu = 1
	EndIf
	;;;===========================================================================================
EndFunc   ;==>zidingyichaxun
Func Listset($Tiaojian);;;;;;;;;;;;;列表字段的读取与创建......$tiaojiao变量不能为*
	GUISetState(@SW_SHOW, $Form1_1)
	$clt = "";;;;;;;;;;;;;;
	$addfld = ObjCreate("ADODB.Connection");连接数据库
	$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & $mdb_data_path & ";Jet Oledb:Database Password=" & $mdb_data_pwd)
	$RS = ObjCreate("ADODB.Recordset")
	$RS.ActiveConnection = $addfld
	$RS.Open("Select " & $Tiaojian & " From " & $tblname & " " & $swhere & " " & $zdywhere);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	$zdsl = $RS.fields.count ;;;;统计字段数目
	If $checkbutt1 = 1 Then;;;;;检查是不按BUTTON的按钮而触发
		For $iii = 0 To $zdsl - 1
			$clt = $clt & String($RS.Fields($iii).name & "|");合并字段
		Next
		GUICtrlDelete($ListView1)
		$ListView1 = GUICtrlCreateListView($clt, 16, 24, 745, 233)
		GUICtrlSendMsg($ListView1, $LVM_SETEXTENDEDLISTVIEWSTYLE, $LVS_EX_GRIDLINES, $LVS_EX_GRIDLINES)
		For $i8 = 0 To $zdsl - 1
			_GUICtrlListView_JustifyColumn(GUICtrlGetHandle($ListView1), $i8, 2)
		Next
		$xsItemset = "";;;;;;;;;;;;;;;;;;
		$zdsl = $RS.fields.count ;;;;统计字段数目
		While Not $RS.eof And Not $RS.bof;;;;;写入item
			If @error = 1 Then ExitLoop
			$xsItemset = "";;;;;;;;;;
			For $iiii = 0 To $zdsl - 1
				$xsItemset = $xsItemset & $RS.Fields($iiii).value & "|";;写入对应的list列数

			Next
			$guiitem = GUICtrlCreateListViewItem($xsItemset, $ListView1)

			If $RS.Fields("缴费情况" ).value = "未缴费" Then GUICtrlSetColor($guiitem, 0xff0000)
			$qqqq = GUICtrlRead($guiitem)
			$RS.movenext
		WEnd
		$checkbutt1 = 0
		$RS.close
		$addfld.Close
	Else;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;用来修改功能用的
		duqulise()
	EndIf

EndFunc   ;==>Listset

Func paixu();;;;;排序
	If $wihthy <> GUICtrlGetState($ListView1) Then _GUICtrlListView_SetColumnWidth($ListView1, $wihthy, 80)
	_GUICtrlListView_RegisterSortCallBack($ListView1)
	_GUICtrlListView_SortItems($ListView1, GUICtrlGetState($ListView1))
	_GUICtrlListView_SetColumnWidth($ListView1, GUICtrlGetState($ListView1), 200)
	$wihthy = GUICtrlGetState($ListView1)
EndFunc   ;==>paixu
Func hejiandtime();;;合计 水费 电费 生活总和 缴费或当前日期应缴 功能,和跟新当前时间并写入数据库
	jindu()
	$addfld = ObjCreate("ADODB.Connection")
	$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & $mdb_data_path & ";Jet Oledb:Database Password=" & $mdb_data_pwd)
	$RS = ObjCreate("ADODB.Recordset")
	$RS.ActiveConnection = $addfld
	$RS.Open("Select * From " & $tblname)
	$zdsl = $RS.fields.count ;;;;统计字段数目
	While Not $RS.eof And Not $RS.bof
		$gxtj = $RS.fields(0) .value;;;;获取当前指针的第一个字段的值,用来提供下面的WHERE使用.
		$hejsf = $RS.fields(14).value * $RS.fields(15).value
		If $RS.fields("水费" ).value = "" And $RS.fields("缴费情况") .value = "未缴费" Then $addfld.Execute("update " & $tblname & " set 水费 = " & $hejsf & " where 房号=" & $gxtj)
		$hejdf = $RS.fields(18) .value * $RS.fields(19) .value
		If $RS.fields("电费" ).value = "" And $RS.fields("缴费情况") .value = "未缴费" Then $addfld.Execute("update " & $tblname & " set 电费 = " & $hejdf & " where 房号=" & $gxtj)
		$hejshf = $RS.fields(16) .value + $RS.fields(20) .value + $RS.fields(21) .value + $RS.fields(22) .value + $RS.fields(23) .value + $RS.fields(24) .value + $RS.fields(26) .value
		If $RS.fields("生活费总和" ).value = "" And $RS.fields("缴费情况") .value = "未缴费" Then $addfld.Execute("update " & $tblname & " set 生活费总和 = " & $hejshf & " where 房号=" & $gxtj)
		$hejdqf = $RS.fields(7) .value + $RS.fields(25) .value
		If $RS.fields("本次应缴费" ).value = "" And $RS.fields("缴费情况") .value = "未缴费" Then $addfld.Execute("update " & $tblname & " set 本次应缴费 = " & $hejdqf & " where 房号=" & $gxtj)
		If $RS.fields("缴费情况") .value = "未缴费" Then $addfld.Execute("update " & $tblname & " set 缴费或当前日期 = " & $nowtime & " where 房号=" & $gxtj)
		$RS.movenext
		$jidushu3 = $jidushu3 + $jidushu2
		GUICtrlSetData($Progress1, $jidushu3);;;改变进度条
		Sleep(1000 / $zdsl)
	WEnd
	$RS.close
	$addfld.Close
	GUICtrlSetData($Progress1, 50)
	Sleep(500)

EndFunc   ;==>hejiandtime
Func jindu();;;;创建进度条===获取记录个数
	#Region ### START Koda GUI section ### Form=
	$Formjd = GUICreate("   简易出租屋管理系统", 389, 39, -1, -1)
	$Progress1 = GUICtrlCreateProgress(0, 1, 273, 35)
	$Label1 = GUICtrlCreateLabel("正在载入数据.....", 288, 8, 97, 20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	GUISetState(@SW_SHOW, $Formjd)
	#EndRegion ### END Koda GUI section ###
	$addfld = ObjCreate("ADODB.Connection")
	$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & $mdb_data_path & ";Jet Oledb:Database Password=" & $mdb_data_pwd)
	$RS = ObjCreate("ADODB.Recordset")
	$RS.ActiveConnection = $addfld
	$RS.Open("Select * From " & $tblname)
	While Not $RS.eof And Not $RS.bof;;统计表里有多少条记录
		$jidushu += 1
		$RS.movenext
	WEnd
	$jidushu2 = Int($jidushu / 200);;获取每次加 多少的数值
	$RS.close
	$addfld.Close
EndFunc   ;==>jindu
Func duqulise()
	$sfiafsfjlsf = 1
	$readlistid = GUICtrlRead($ListView1)
	$readlisttxt = String(GUICtrlRead($readlistid))
	$xsItemsety = "";;;;;;;;;;;;;;;;;;
	$zdsl = $RS.fields.count ;;;;统计字段数目
	While Not $RS.eof And Not $RS.bof
		If @error = 1 Then ExitLoop
		$xsItemsety = "";;;;;;;;;;
		For $iiii = 0 To $zdsl - 1
			$xsItemsety = String($xsItemsety & $RS.Fields($iiii).value & "|")
		Next
		If StringCompare($readlisttxt, $xsItemsety) = 0 Then
			$AutoIDyz = $RS.Fields("AutoID" ).value

			$fanhaoyz = $RS.Fields("房号" ).value
			$yhmyz = $RS.Fields("用户名" ).value
			GUICtrlSetData($CEdit, $fanhaoyz & "-----" & $yhmyz)
			GUICtrlSetColor($CEdit, 0xff0000)
			duqulise2()
			ExitLoop
		Else
			$RS.movenext
		EndIf
	WEnd
	If Not $sfiafsfjlsf = 1 Then
		$RS.close
		$addfld.Close
	EndIf

EndFunc   ;==>duqulise
Func duqulise2()
	$addfld = ObjCreate("ADODB.Connection")
	$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & $mdb_data_path & ";Jet Oledb:Database Password=" & $mdb_data_pwd)
	$RS = ObjCreate("ADODB.Recordset")
	$RS.ActiveConnection = $addfld
	$RS.Open("Select * From " & $tblname & " " & "where AutoID = " & $AutoIDyz)
	$zdsl = $RS.fields.count ;;;;统计字段数目
	For $i10 = 0 To $zdsl - 3
		If $i10 <> 25 And $i10 <> 28 And $i10 <> 29 And $i10 <> 0 And $i10 <> 1 Then
			$inputtxt = $RS.Fields($i10).value
			GUICtrlSetData($Input[$i10], $inputtxt)
		EndIf
	Next
	$sfiafsfjlsf = 1
	$RS.close
	$addfld.Close
EndFunc   ;==>duqulise2
Func savexx()
	If GUICtrlRead($CEdit) <> "Null" Then
		$addfld = ObjCreate("ADODB.Connection")
		$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & $mdb_data_path & ";Jet Oledb:Database Password=" & $mdb_data_pwd)
		$RS = ObjCreate("ADODB.Recordset")
		$RS.ActiveConnection = $addfld
		$RS.Open("Select * From " & $tblname & " " & "where AutoID = " & $AutoIDyz)
		$zdsl = $RS.fields.count ;;;;统计字段数目
		For $i10 = 0 To $zdsl - 3
			If $i10 <> 25 And $i10 <> 28 And $i10 <> 29 And $i10 <> 0 And $i10 <> 1 Then
				If StringIsInt(GUICtrlRead($Input[$i10])) = 1 And GUICtrlRead($Input[$i10]) <> "" Then
;~ 					MsgBox(0, "", "update " & $tblname & " set " & $RS.Fields($i10).name & "=" & GUICtrlRead($Input[$i10]) & " where AutoID = " & $AutoIDyz)
					$addfld.Execute("update " & $tblname & " set " & $RS.Fields($i10).name & "=" & GUICtrlRead($Input[$i10]) & " where AutoID = " & $AutoIDyz)
					$tishicg = 1
				ElseIf StringIsInt(GUICtrlRead($Input[$i10])) = 0 And GUICtrlRead($Input[$i10]) <> "" Then
;~ 					MsgBox(0, "", "update " & $tblname & " set " & $RS.Fields($i10).name & "=" & '"' & GUICtrlRead($Input[$i10]) & '"' & " where AutoID = " & $AutoIDyz)
					$addfld.Execute("update " & $tblname & " set " & $RS.Fields($i10).name & "=" & '"' & GUICtrlRead($Input[$i10]) & '"' & " where AutoID = " & $AutoIDyz)
					$tishicg = 1
				EndIf
			EndIf
		Next
	EndIf
	If $tishicg = 1 Then
		MsgBox(0, "成功", "保存成功")
		$tishicg = 0
	Else
		MsgBox(0, "失败", "保存失败")
		$tishicg = 0
	EndIf
	$RS.close
	$addfld.Close
EndFunc   ;==>savexx
Func tianjiaxinxi()
	If GUICtrlRead($Inputc[0]) <> "" Or GUICtrlRead($Inputc[1]) <> "" Then
		$addfld = ObjCreate("ADODB.Connection")
		$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & $mdb_data_path & ";Jet Oledb:Database Password=" & $mdb_data_pwd)
		If StringIsInt(GUICtrlRead($Inputc[0])) = 1 Then
			$addusermane = GUICtrlRead($Inputc[0])
		Else
			$addusermane = '"' & GUICtrlRead($Inputc[0]) & '"'
		EndIf

		If StringIsInt(GUICtrlRead($Inputc[1])) = 1 Then
			$addfanhao = GUICtrlRead($Inputc[1])
		Else
			MsgBox(0, "错误", "房号必须是正整数")
		EndIf
		If StringIsInt(GUICtrlRead($Inputc[1])) = 1 Then
			$addfld.Execute("insert into " & $tblname & " (用户名,房号) values (" & $addusermane & "," & $addfanhao & ")")
			MsgBox(0, "成功", "添加成功!")
		EndIf
	Else
		MsgBox(0, "错误", "请输入数据")
	EndIf
EndFunc   ;==>tianjiaxinxi
Func checkINT()
	If GUICtrlRead($Input[7]) = "" Or StringIsFloat(GUICtrlRead($Input[7])) = 1 Or StringIsInt(GUICtrlRead($Input[7])) = 1 Then
		$suibian = 0
	Else
		MsgBox(0, "输入错误", "只能输入整数或小数(浮点数)")
		GUICtrlSetData($Input[7], "")
	EndIf
	If GUICtrlRead($Input[10]) = "" Or StringIsFloat(GUICtrlRead($Input[10])) Or StringIsInt(GUICtrlRead($Input[10])) Then
		$suibian = 0
	Else
		MsgBox(0, "输入错误", "只能输入整数或小数(浮点数)")
		GUICtrlSetData($Input[10], "")
	EndIf

	For $i11 = 13 To 27
		If GUICtrlRead($Input[$i11]) = "" Or StringIsFloat(GUICtrlRead($Input[$i11])) Or StringIsInt(GUICtrlRead($Input[$i11])) Then
			$suibian = 0
		Else
			MsgBox(0, "输入错误", "只能输入整数或小数(浮点数)")
			GUICtrlSetData($Input[$i11], "")
		EndIf
	Next
EndFunc   ;==>checkINT
Func del()
	$Strn = GUICtrlRead(GUICtrlRead($ListView1))
	$Strnspin = StringSplit($Strn, "|")
	$Strnspinshux = $Strnspin[0] - 1
	$addfld = ObjCreate("ADODB.Connection")
	$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & $mdb_data_path & ";Jet Oledb:Database Password=" & $mdb_data_pwd)
	$sQuery = "DELETE FROM " & $tblname & " IN '" & $mdb_data_path & "' WHERE AutoID" & " = " & $Strnspin[$Strnspinshux]
	$addfld.execute($sQuery)
	$addfld.close
	MsgBox(4096, "提示- ", "房号:" & $Strnspin[1] & "    删除成功!!!")
EndFunc   ;==>del
Func chakanbeizhu()
	If GUICtrlRead($ListView1) <> 0 And GUICtrlRead($ListView1) <> "" Then
		GUISetState(@SW_SHOW, $Formbz)
		$Strn = GUICtrlRead(GUICtrlRead($ListView1))
		$Strnspin = StringSplit($Strn, "|")
		$Strnspinshux = $Strnspin[0] - 1
		$addfld = ObjCreate("ADODB.Connection")
		$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & $mdb_data_path & ";Jet Oledb:Database Password=" & $mdb_data_pwd)
		$RS = ObjCreate("ADODB.Recordset")
		$RS.ActiveConnection = $addfld
		$RS.Open("Select * From " & $tblname & " " & "where AutoID = " & $Strnspin[$Strnspinshux])
		GUICtrlSetData($bezhu, $RS.Fields("备注" ).value)
		GUICtrlSetColor(-1, 0x4A8532)
		While 1
			$nMsg = GUIGetMsg()
			Switch $nMsg
				Case $GUI_EVENT_CLOSE
					$addfld.Execute("update " & $tblname & " set 备注 = " & '"【' & GUICtrlRead($bezhu) & '】"' & " " & "where AutoID = " & $Strnspin[$Strnspinshux])

					GUISetState(@SW_HIDE, $Formbz)
					$RS.close
					$addfld.Close
					ExitLoop
			EndSwitch
		WEnd
	EndIf
EndFunc   ;==>chakanbeizhu
Func zairumoren()
	GUICtrlSetData($Input[10], IniRead("abuotset.ini", "Fixed", "Earnestmoney", "0"))
	GUICtrlSetData($Input[7], IniRead("abuotset.ini", "Fixed", "Monthly", "0"))
	GUICtrlSetData($Input[21], IniRead("abuotset.ini", "Fixed", "TVfee", "0"))
	GUICtrlSetData($Input[22], IniRead("abuotset.ini", "Fixed", "Garbagefee", "0"))
	GUICtrlSetData($Input[23], IniRead("abuotset.ini", "Fixed", "Cleaningfee", "0"))
	GUICtrlSetData($Input[24], IniRead("abuotset.ini", "Fixed", "Maintenance", "0"))
	GUICtrlSetData($Input[15], IniRead("abuotset.ini", "Fixed", "WaterPrice", "0"))
	GUICtrlSetData($Input[19], IniRead("abuotset.ini", "Fixed", "Powerunit", "0"))
EndFunc   ;==>zairumoren