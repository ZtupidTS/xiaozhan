#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=I:\�½��ļ��� (2)\���׳����ݹ���ϵͳV1.0.exe|-1
#AutoIt3Wrapper_outfile=e:\�ҵ��ĵ�\����\���׳����ݹ���ϵͳ.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=���׳����ݹ���ϵͳV1.0
#AutoIt3Wrapper_Res_Description=���׳����ݹ���ϵͳV1.0
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=www.bbinker.com   ����
#AutoIt3Wrapper_Res_Field=��ϵ����|QQ:1492162368
#AutoIt3Wrapper_Tidy_Stop_OnError=n
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/striponly
#EndRegion ;**** ���������� ACNWrapper_GUI ****
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
	MsgBox(0, "", "��������2010��8��26�� 12:55:54 �����������2050�� ����40�����ʷ������Ʒ���ҵĵ�һ����Ʒ���������������ˡ�лл��ҵ�֧�֣�")
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
$Tiaojianset = "����,�ɷѻ�ǰ����,�ɷ����"
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
$Formbz = GUICreate("��ע�鿴/�޸� (�޸ĺ�ֱ�ӹرռ����Զ�����)", 420, 317, -1, -1)
;~ _SkinGUI("SkinCrafterDll_31.dll", $bf, $Formbz )  ;����Ƥ��DLL
$bezhu = GUICtrlCreateEdit("", 0, 0, 417, 313, $ES_AUTOVSCROLL + $WS_VSCROLL)
#EndRegion ### END Koda GUI section ###
$Form1_1 = GUICreate("   ���׳����ݹ���ϵͳ   V1.0   BY:����", 778, 677, -1, -1)

$MenuItem1 = GUICtrlCreateMenu("�ļ�(&X)")
$MenuItem3 = GUICtrlCreateMenu("�༭(&Y)")
$MenuItem2 = GUICtrlCreateMenu("����(&Z)")
$Tab1 = GUICtrlCreateTab(8, 280, 761, 361)
$TabSheet1 = GUICtrlCreateTabItem("��ѯϵͳ")
$Group2 = GUICtrlCreateGroup("ѡ��", 16, 312, 737, 185)
$Checkbox[0] = GUICtrlCreateCheckbox("�û���", 40, 336, 90, 25)
$Checkbox[1] = GUICtrlCreateCheckbox("ˮ��", 40, 360, 90, 25)
$Checkbox[2] = GUICtrlCreateCheckbox("���", 40, 384, 90, 25)
$Checkbox[3] = GUICtrlCreateCheckbox("���ӷ�", 40, 408, 90, 25)
GUICtrlSetData($Progress1, 60)
Sleep(200)
$Group3 = GUICtrlCreateGroup("", 24, 328, 121, 161)
$Checkbox[4] = GUICtrlCreateCheckbox("������", 40, 432, 90, 25)
$Checkbox[5] = GUICtrlCreateCheckbox("����Ӧ�ɷ�", 28, 456, 100, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group4 = GUICtrlCreateGroup("", 176, 336, 113, 153)
$Checkbox[6] = GUICtrlCreateCheckbox("�Ա�", 192, 352, 90, 25)
$Checkbox[7] = GUICtrlCreateCheckbox("���û���", 192, 384, 90, 25)
$Checkbox[8] = GUICtrlCreateCheckbox("���֤����", 192, 416, 90, 25)
$Checkbox[9] = GUICtrlCreateCheckbox("������ַ", 192, 448, 90, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group5 = GUICtrlCreateGroup("", 320, 336, 121, 153)
$Checkbox[10] = GUICtrlCreateCheckbox("��ϵ�˵绰", 336, 352, 89, 25)
$Checkbox[11] = GUICtrlCreateCheckbox("��������", 336, 384, 89, 25)
$Checkbox[12] = GUICtrlCreateCheckbox("��ͬ��ʼ��", 336, 416, 97, 25)
$Checkbox[13] = GUICtrlCreateCheckbox("��ͬ������", 336, 448, 81, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group6 = GUICtrlCreateGroup("", 472, 336, 113, 153)
$Checkbox[14] = GUICtrlCreateCheckbox("��������", 488, 352, 89, 25)
$Checkbox[15] = GUICtrlCreateCheckbox("ˮ����X��", 488, 384, 81, 25)
$Checkbox[16] = GUICtrlCreateCheckbox("�絥��X��", 488, 416, 89, 25)
$Checkbox[17] = GUICtrlCreateCheckbox("�ⷿѺ��", 488, 448, 89, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group7 = GUICtrlCreateGroup("", 600, 320, 145, 169)
$Checkbox[18] = GUICtrlCreateCheckbox("����", 608, 336, 58, 25)
$Checkbox[19] = GUICtrlCreateCheckbox("ά�޷�", 608, 360, 58, 25)
$Checkbox[20] = GUICtrlCreateCheckbox("��ע", 608, 384, 129, 25)
$Checkbox[21] = GUICtrlCreateCheckbox("������ܺ�", 608, 408, 129, 25)
$Checkbox[22] = GUICtrlCreateCheckbox("��ˮ��", 608, 432, 129, 25)
$Checkbox[23] = GUICtrlCreateCheckbox("�õ���", 608, 456, 121, 25)
$Checkbox[24] = GUICtrlCreateCheckbox("����ˮ��", 672, 336, 65, 25)
$Checkbox[25] = GUICtrlCreateCheckbox("���ڵ���", 672, 360, 65, 25)
GUICtrlSetData($Progress1, 70)
Sleep(200)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group8 = GUICtrlCreateGroup("�Զ����ѯ", 16, 504, 609, 129)
$Label = GUICtrlCreateLabel("����:", 40, 568, 40, 24)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$Label = GUICtrlCreateLabel("����:", 40, 544, 40, 24)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$Group9 = GUICtrlCreateGroup("", 32, 528, 169, 97)
$Inputz[0] = GUICtrlCreateInput("", 88, 544, 97, 21)
$Inputz[1] = GUICtrlCreateInput("", 88, 568, 97, 21)
$Label = GUICtrlCreateLabel("ʱ��:", 40, 592, 40, 24)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$Inputz[2] = GUICtrlCreateInput("", 88, 592, 97, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group10 = GUICtrlCreateGroup("���ٲ�ѯ", 224, 520, 385, 105)
GUICtrlSetColor($Group10, 0x0000FF)
GUICtrlSetData($Progress1, 80)
Sleep(200)
$Radio[0] = GUICtrlCreateRadio("�г�δ�ɷ��û�", 240, 544, 110, 25)
$Radio[1] = GUICtrlCreateRadio("�г��ѽɷ��û�", 240, 576, 110, 25)
$Radio[2] = GUICtrlCreateRadio("δ����", 352, 544, 121, 25)
GUICtrlSetState($Radio[2], $GUI_DISABLE);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
$Radio[3] = GUICtrlCreateRadio("δ����", 352, 576, 120, 25)
GUICtrlSetState($Radio[3], $GUI_DISABLE);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
$Radio[4] = GUICtrlCreateRadio("δ����", 480, 544, 120, 25)
GUICtrlSetState($Radio[4], $GUI_DISABLE);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
$Radio[5] = GUICtrlCreateRadio("ȫ����ʾ", 480, 576, 120, 25)
GUICtrlSetState($Radio[5], $GUI_CHECKED);;;;;;;Ĭ��ѡ�� $radio5
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button1 = GUICtrlCreateButton("ȷ����ѯ", 632, 520, 129, 41)
$Button2 = GUICtrlCreateButton("��ѡ", 632, 576, 129, 41)
$TabSheet2 = GUICtrlCreateTabItem("���/�޸���Ϣ")
$Group12 = GUICtrlCreateGroup("", 16, 304, 745, 321)
$Group11 = GUICtrlCreateGroup("��һ��", 24, 312, 201, 305)
$CEdit = GUICtrlCreateEdit("Null", 80, 360, 115, 20, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL))
GUICtrlSetState($CEdit, $GUI_DISABLE)
$Label3 = GUICtrlCreateLabel("��Ϣ", 40, 360, 52, 24)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$Button3 = GUICtrlCreateButton("��ȡ", 40, 392, 161, 49)
$Group13 = GUICtrlCreateGroup("", 32, 336, 185, 113)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group14 = GUICtrlCreateGroup("", 32, 456, 185, 153)
$Label4 = GUICtrlCreateLabel("�û���", 40, 480, 52, 24)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$Label5 = GUICtrlCreateLabel("����", 40, 512, 36, 24)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$Inputc[0] = GUICtrlCreateInput("", 96, 480, 105, 21)
$Inputc[1] = GUICtrlCreateInput("", 96, 512, 105, 21)
$Button4 = GUICtrlCreateButton("���", 40, 544, 163, 49)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group15 = GUICtrlCreateGroup("�ڶ���", 240, 312, 513, 305)
$Group16 = GUICtrlCreateGroup("", 248, 328, 225, 281)
$Label6 = GUICtrlCreateLabel("�Ա�", 256, 344, 28, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Label7 = GUICtrlCreateLabel("��ϵ�˵绰", 256, 440, 64, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Label8 = GUICtrlCreateLabel("�ⷿѺ��", 256, 512, 52, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Label9 = GUICtrlCreateLabel("��ͬ��ʼ��", 256, 464, 64, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Label10 = GUICtrlCreateLabel("��ͬ������", 256, 488, 64, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Label11 = GUICtrlCreateLabel("���֤����", 256, 392, 64, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Label12 = GUICtrlCreateLabel("���û���", 256, 368, 52, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Label13 = GUICtrlCreateLabel("������ַ", 256, 416, 52, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Input[3] = GUICtrlCreateInput("", 328, 368, 121, 21)
$Input[4] = GUICtrlCreateInput("", 328, 392, 121, 21)
$Input[5] = GUICtrlCreateInput("", 328, 416, 121, 21)
$Input[6] = GUICtrlCreateInput("", 328, 440, 121, 21)
$Input[8] = GUICtrlCreateInput("", 328, 464, 121, 21)
$Input[9] = GUICtrlCreateInput("", 328, 488, 121, 21)
$Input[10] = GUICtrlCreateInput(IniRead("abuotset.ini", "Fixed", "Earnestmoney", "0"), 328, 512, 121, 21)
$Label28 = GUICtrlCreateLabel("��������", 256, 536, 52, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Input[7] = GUICtrlCreateInput(IniRead("abuotset.ini", "Fixed", "Monthly", "0"), 328, 536, 121, 21)
$Label14 = GUICtrlCreateLabel("�ɷѻ�ǰ����", 256, 560, 88, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Input[11] = GUICtrlCreateInput("", 344, 560, 121, 21)
$Label24 = GUICtrlCreateLabel("�ɷ���� ", 256, 584, 55, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Input[2] = GUICtrlCreateInput("", 328, 344, 121, 21)
$Input[12] = GUICtrlCreateInput("", 328, 584, 121, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group17 = GUICtrlCreateGroup("", 480, 328, 265, 289)
$Label15 = GUICtrlCreateLabel("���", 488, 464, 28, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x008000)
$Label18 = GUICtrlCreateLabel("���ӷ�", 488, 488, 40, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Label20 = GUICtrlCreateLabel("������", 488, 512, 40, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Label22 = GUICtrlCreateLabel("ˮ��", 488, 392, 28, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x008000)
$Label23 = GUICtrlCreateLabel("����", 488, 536, 40, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Label25 = GUICtrlCreateLabel("ά�޷�", 488, 560, 40, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Input[16] = GUICtrlCreateInput("", 544, 392, 57, 21)
$Input[20] = GUICtrlCreateInput("", 536, 464, 57, 21)
$Input[21] = GUICtrlCreateInput(IniRead("abuotset.ini", "Fixed", "TVfee", "0"), 536, 488, 57, 21)
$Input[22] = GUICtrlCreateInput(IniRead("abuotset.ini", "Fixed", "Garbagefee", "0"), 536, 512, 57, 21)
$Input[23] = GUICtrlCreateInput(IniRead("abuotset.ini", "Fixed", "Cleaningfee", "0"), 536, 536, 57, 21)
$Input[24] = GUICtrlCreateInput(IniRead("abuotset.ini", "Fixed", "Maintenance", "0"), 536, 560, 57, 21)
$Button5 = GUICtrlCreateButton("���浱ǰ��Ϣ", 483, 584, 85, 25)
$Buttonurl = GUICtrlCreateButton("����Ĭ��ֵ", 665, 584, 70, 25)
$Buttonmr = GUICtrlCreateButton("�޸�Ĭ��ֵ", 580, 584, 75, 25)
$Label16 = GUICtrlCreateLabel("�õ���", 488, 440, 40, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Label17 = GUICtrlCreateLabel("����ˮ��", 488, 344, 52, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Input[13] = GUICtrlCreateInput("", 544, 344, 57, 21)
$Input[14] = GUICtrlCreateInput("", 544, 368, 57, 21)
$Label19 = GUICtrlCreateLabel("��ˮ��", 488, 368, 40, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Input[18] = GUICtrlCreateInput("", 536, 440, 57, 21)
$Label26 = GUICtrlCreateLabel("���ڵ���", 488, 416, 52, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Input[17] = GUICtrlCreateInput("", 544, 416, 57, 21)
$Group18 = GUICtrlCreateGroup("", 616, 336, 121, 105)
$Label29 = GUICtrlCreateLabel("ˮ����X��", 648, 352, 59, 17)
$Input[15] = GUICtrlCreateInput(IniRead("abuotset.ini", "Fixed", "WaterPrice", "0"), 632, 368, 89, 21)
$Label30 = GUICtrlCreateLabel("�絥��X��", 648, 392, 59, 17)
$Input[19] = GUICtrlCreateInput(IniRead("abuotset.ini", "Fixed", "Powerunit", "0"), 632, 408, 89, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Label31 = GUICtrlCreateLabel("��������", 616, 448, 52, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Input[26] = GUICtrlCreateInput("", 672, 448, 65, 21)
$Label32 = GUICtrlCreateLabel("����Ӧ�ɷ�", 616, 472, 64, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x008000)
$Input[27] = GUICtrlCreateInput("", 680, 472, 57, 21)
$Group21 = GUICtrlCreateGroup("", 608, 496, 129, 81)
$Label33 = GUICtrlCreateLabel("����ɫ��ѡ������", 624, 520, 100, 17)
GUICtrlSetColor(-1, 0x008000)
$Label34 = GUICtrlCreateLabel("ϵͳ�����Զ�����", 616, 544, 100, 17)
GUICtrlSetColor(-1, 0x008000)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button6 = GUICtrlCreateButton("�޸�", 448, 264, 89, 33)
$Button8 = GUICtrlCreateButton("ɾ��", 544, 264, 89, 33)
$Button9 = GUICtrlCreateButton("��ע�鿴/�޸�", 640, 264, 100, 33)
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

Func checkboxget();;;;;��ȡ��ѡ���ı�
	For $i7 = 0 To 5
		$danxuan[$i7] = GUICtrlRead($Radio[$i7])
	Next
	;;;;;;;;;;;;;;;;;;;;;;;;;�����where����;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	If $danxuan[0] = $GUI_CHECKED Then
		$swhere = 'where �ɷ���� = "δ�ɷ�"';;;;�пո�
	ElseIf $danxuan[1] = $GUI_CHECKED Then
		$swhere = 'where �ɷ���� = "�ѽɷ�"';;;;�пո�
	Else
		$swhere = ""
	EndIf
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;~ ============================��ȡ��ѡ�����Ϣ=================================
	$Tiaojianset = "����,�ɷѻ�ǰ����,�ɷ����"
	For $ii = 0 To 25;;;;;;;;;;;;
		$ccr[$ii] = GUICtrlRead($Checkbox[$ii]);�ж��Ƿ���ѡ��
		$ccrtxt[$ii] = GUICtrlRead($Checkbox[$ii], 1)
	Next
	For $i = 0 To 25;;;;;;;;;;;;;
		If $ccr[$i] = $GUI_CHECKED Then
			$ttyyy = 1
			$Tiaojianset = $Tiaojianset & "," & $ccrtxt[$i];;;;��ѡ�е�txt����һ��
		EndIf
	Next
	$Tiaojianset = $Tiaojianset & "," & "AutoID"
	zidingyichaxun()
	If $ttyyy = 1 Then ;;;;;;���ȫ��û��ѡ���� listest�Ĳ���Ϊ*
		$ttyyy = 0
		listset($Tiaojianset)
	Else
		If $checkbutt1 = 1 Then GUICtrlDelete($ListView1);;;�ж��ǰ��Ǹ���ť�Ŵ�����
		Listset("*")
	EndIf

EndFunc   ;==>checkboxget
Func zidingyichaxun()
	For $i9 = 0 To 2 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		$Inputzzt[$i9] = GUICtrlRead($Inputz[$i9])
	Next
	$zdywhere = ""
	If $swhere = "" Then
		$swhere = 'where �û���<>"" '
		If $Inputzzt[0] <> "" And $swhere <> "" Then $zdywhere = $zdywhere & "and ���� like " & '"%"' & "&" & $Inputzzt[0] & "&" & '"%"' & " "
		If $Inputzzt[1] <> "" And $swhere <> "" Then $zdywhere = $zdywhere & "and �û��� like " & '"%' & $Inputzzt[1] & '%"' & " "
		If $Inputzzt[2] <> "" And $swhere <> "" Then $zdywhere = $zdywhere & "and �ɷѻ�ǰ���� like " & '"%' & $Inputzzt[2] & '%"' & " "
	Else
		If $Inputzzt[0] <> "" And $swhere <> "" Then $zdywhere = $zdywhere & "and ���� like " & '"%"' & "&" & $Inputzzt[0] & "&" & '"%"' & " "
		If $Inputzzt[1] <> "" And $swhere <> "" Then $zdywhere = $zdywhere & "and �û��� like " & '"%' & $Inputzzt[1] & '%"' & " "
		If $Inputzzt[2] <> "" And $swhere <> "" Then $zdywhere = $zdywhere & "and �ɷѻ�ǰ���� like " & '"%' & $Inputzzt[2] & '%"' & " "
	EndIf
	If StringIsInt($Inputzzt[0]) = 0 And $Inputzzt[0] <> "" Then ;;;;;;;�ж� �����Ƿ�������
		MsgBox(0, "����!", "��ȷ������ �Զ����ѯ-�����š��������������������뷵���޸ģ� ")
		$zdywhere = ""
	Else
		$yanzhenzhenshu = 1
	EndIf
	;;;===========================================================================================
EndFunc   ;==>zidingyichaxun
Func Listset($Tiaojian);;;;;;;;;;;;;�б��ֶεĶ�ȡ�봴��......$tiaojiao��������Ϊ*
	GUISetState(@SW_SHOW, $Form1_1)
	$clt = "";;;;;;;;;;;;;;
	$addfld = ObjCreate("ADODB.Connection");�������ݿ�
	$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & $mdb_data_path & ";Jet Oledb:Database Password=" & $mdb_data_pwd)
	$RS = ObjCreate("ADODB.Recordset")
	$RS.ActiveConnection = $addfld
	$RS.Open("Select " & $Tiaojian & " From " & $tblname & " " & $swhere & " " & $zdywhere);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	$zdsl = $RS.fields.count ;;;;ͳ���ֶ���Ŀ
	If $checkbutt1 = 1 Then;;;;;����ǲ���BUTTON�İ�ť������
		For $iii = 0 To $zdsl - 1
			$clt = $clt & String($RS.Fields($iii).name & "|");�ϲ��ֶ�
		Next
		GUICtrlDelete($ListView1)
		$ListView1 = GUICtrlCreateListView($clt, 16, 24, 745, 233)
		GUICtrlSendMsg($ListView1, $LVM_SETEXTENDEDLISTVIEWSTYLE, $LVS_EX_GRIDLINES, $LVS_EX_GRIDLINES)
		For $i8 = 0 To $zdsl - 1
			_GUICtrlListView_JustifyColumn(GUICtrlGetHandle($ListView1), $i8, 2)
		Next
		$xsItemset = "";;;;;;;;;;;;;;;;;;
		$zdsl = $RS.fields.count ;;;;ͳ���ֶ���Ŀ
		While Not $RS.eof And Not $RS.bof;;;;;д��item
			If @error = 1 Then ExitLoop
			$xsItemset = "";;;;;;;;;;
			For $iiii = 0 To $zdsl - 1
				$xsItemset = $xsItemset & $RS.Fields($iiii).value & "|";;д���Ӧ��list����

			Next
			$guiitem = GUICtrlCreateListViewItem($xsItemset, $ListView1)

			If $RS.Fields("�ɷ����" ).value = "δ�ɷ�" Then GUICtrlSetColor($guiitem, 0xff0000)
			$qqqq = GUICtrlRead($guiitem)
			$RS.movenext
		WEnd
		$checkbutt1 = 0
		$RS.close
		$addfld.Close
	Else;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;�����޸Ĺ����õ�
		duqulise()
	EndIf

EndFunc   ;==>Listset

Func paixu();;;;;����
	If $wihthy <> GUICtrlGetState($ListView1) Then _GUICtrlListView_SetColumnWidth($ListView1, $wihthy, 80)
	_GUICtrlListView_RegisterSortCallBack($ListView1)
	_GUICtrlListView_SortItems($ListView1, GUICtrlGetState($ListView1))
	_GUICtrlListView_SetColumnWidth($ListView1, GUICtrlGetState($ListView1), 200)
	$wihthy = GUICtrlGetState($ListView1)
EndFunc   ;==>paixu
Func hejiandtime();;;�ϼ� ˮ�� ��� �����ܺ� �ɷѻ�ǰ����Ӧ�� ����,�͸��µ�ǰʱ�䲢д�����ݿ�
	jindu()
	$addfld = ObjCreate("ADODB.Connection")
	$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & $mdb_data_path & ";Jet Oledb:Database Password=" & $mdb_data_pwd)
	$RS = ObjCreate("ADODB.Recordset")
	$RS.ActiveConnection = $addfld
	$RS.Open("Select * From " & $tblname)
	$zdsl = $RS.fields.count ;;;;ͳ���ֶ���Ŀ
	While Not $RS.eof And Not $RS.bof
		$gxtj = $RS.fields(0) .value;;;;��ȡ��ǰָ��ĵ�һ���ֶε�ֵ,�����ṩ�����WHEREʹ��.
		$hejsf = $RS.fields(14).value * $RS.fields(15).value
		If $RS.fields("ˮ��" ).value = "" And $RS.fields("�ɷ����") .value = "δ�ɷ�" Then $addfld.Execute("update " & $tblname & " set ˮ�� = " & $hejsf & " where ����=" & $gxtj)
		$hejdf = $RS.fields(18) .value * $RS.fields(19) .value
		If $RS.fields("���" ).value = "" And $RS.fields("�ɷ����") .value = "δ�ɷ�" Then $addfld.Execute("update " & $tblname & " set ��� = " & $hejdf & " where ����=" & $gxtj)
		$hejshf = $RS.fields(16) .value + $RS.fields(20) .value + $RS.fields(21) .value + $RS.fields(22) .value + $RS.fields(23) .value + $RS.fields(24) .value + $RS.fields(26) .value
		If $RS.fields("������ܺ�" ).value = "" And $RS.fields("�ɷ����") .value = "δ�ɷ�" Then $addfld.Execute("update " & $tblname & " set ������ܺ� = " & $hejshf & " where ����=" & $gxtj)
		$hejdqf = $RS.fields(7) .value + $RS.fields(25) .value
		If $RS.fields("����Ӧ�ɷ�" ).value = "" And $RS.fields("�ɷ����") .value = "δ�ɷ�" Then $addfld.Execute("update " & $tblname & " set ����Ӧ�ɷ� = " & $hejdqf & " where ����=" & $gxtj)
		If $RS.fields("�ɷ����") .value = "δ�ɷ�" Then $addfld.Execute("update " & $tblname & " set �ɷѻ�ǰ���� = " & $nowtime & " where ����=" & $gxtj)
		$RS.movenext
		$jidushu3 = $jidushu3 + $jidushu2
		GUICtrlSetData($Progress1, $jidushu3);;;�ı������
		Sleep(1000 / $zdsl)
	WEnd
	$RS.close
	$addfld.Close
	GUICtrlSetData($Progress1, 50)
	Sleep(500)

EndFunc   ;==>hejiandtime
Func jindu();;;;����������===��ȡ��¼����
	#Region ### START Koda GUI section ### Form=
	$Formjd = GUICreate("   ���׳����ݹ���ϵͳ", 389, 39, -1, -1)
	$Progress1 = GUICtrlCreateProgress(0, 1, 273, 35)
	$Label1 = GUICtrlCreateLabel("������������.....", 288, 8, 97, 20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	GUISetState(@SW_SHOW, $Formjd)
	#EndRegion ### END Koda GUI section ###
	$addfld = ObjCreate("ADODB.Connection")
	$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & $mdb_data_path & ";Jet Oledb:Database Password=" & $mdb_data_pwd)
	$RS = ObjCreate("ADODB.Recordset")
	$RS.ActiveConnection = $addfld
	$RS.Open("Select * From " & $tblname)
	While Not $RS.eof And Not $RS.bof;;ͳ�Ʊ����ж�������¼
		$jidushu += 1
		$RS.movenext
	WEnd
	$jidushu2 = Int($jidushu / 200);;��ȡÿ�μ� ���ٵ���ֵ
	$RS.close
	$addfld.Close
EndFunc   ;==>jindu
Func duqulise()
	$sfiafsfjlsf = 1
	$readlistid = GUICtrlRead($ListView1)
	$readlisttxt = String(GUICtrlRead($readlistid))
	$xsItemsety = "";;;;;;;;;;;;;;;;;;
	$zdsl = $RS.fields.count ;;;;ͳ���ֶ���Ŀ
	While Not $RS.eof And Not $RS.bof
		If @error = 1 Then ExitLoop
		$xsItemsety = "";;;;;;;;;;
		For $iiii = 0 To $zdsl - 1
			$xsItemsety = String($xsItemsety & $RS.Fields($iiii).value & "|")
		Next
		If StringCompare($readlisttxt, $xsItemsety) = 0 Then
			$AutoIDyz = $RS.Fields("AutoID" ).value

			$fanhaoyz = $RS.Fields("����" ).value
			$yhmyz = $RS.Fields("�û���" ).value
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
	$zdsl = $RS.fields.count ;;;;ͳ���ֶ���Ŀ
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
		$zdsl = $RS.fields.count ;;;;ͳ���ֶ���Ŀ
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
		MsgBox(0, "�ɹ�", "����ɹ�")
		$tishicg = 0
	Else
		MsgBox(0, "ʧ��", "����ʧ��")
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
			MsgBox(0, "����", "���ű�����������")
		EndIf
		If StringIsInt(GUICtrlRead($Inputc[1])) = 1 Then
			$addfld.Execute("insert into " & $tblname & " (�û���,����) values (" & $addusermane & "," & $addfanhao & ")")
			MsgBox(0, "�ɹ�", "��ӳɹ�!")
		EndIf
	Else
		MsgBox(0, "����", "����������")
	EndIf
EndFunc   ;==>tianjiaxinxi
Func checkINT()
	If GUICtrlRead($Input[7]) = "" Or StringIsFloat(GUICtrlRead($Input[7])) = 1 Or StringIsInt(GUICtrlRead($Input[7])) = 1 Then
		$suibian = 0
	Else
		MsgBox(0, "�������", "ֻ������������С��(������)")
		GUICtrlSetData($Input[7], "")
	EndIf
	If GUICtrlRead($Input[10]) = "" Or StringIsFloat(GUICtrlRead($Input[10])) Or StringIsInt(GUICtrlRead($Input[10])) Then
		$suibian = 0
	Else
		MsgBox(0, "�������", "ֻ������������С��(������)")
		GUICtrlSetData($Input[10], "")
	EndIf

	For $i11 = 13 To 27
		If GUICtrlRead($Input[$i11]) = "" Or StringIsFloat(GUICtrlRead($Input[$i11])) Or StringIsInt(GUICtrlRead($Input[$i11])) Then
			$suibian = 0
		Else
			MsgBox(0, "�������", "ֻ������������С��(������)")
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
	MsgBox(4096, "��ʾ- ", "����:" & $Strnspin[1] & "    ɾ���ɹ�!!!")
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
		GUICtrlSetData($bezhu, $RS.Fields("��ע" ).value)
		GUICtrlSetColor(-1, 0x4A8532)
		While 1
			$nMsg = GUIGetMsg()
			Switch $nMsg
				Case $GUI_EVENT_CLOSE
					$addfld.Execute("update " & $tblname & " set ��ע = " & '"��' & GUICtrlRead($bezhu) & '��"' & " " & "where AutoID = " & $Strnspin[$Strnspinshux])

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