#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=D:\���\�ļ�ͼ���滻����\ICO\��ͨ\PM009\01.ICO
#AutoIt3Wrapper_outfile=ͨѶ¼.exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <ListViewConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GuiListView.au3>
$ShuJu = @ScriptDir & "\TongXunLu.ini"
#Region ### START Koda GUI section ### Form=
;������
$Form1 = GUICreate("ͨѶ¼", 330, 263, -1, -1)
$ListView1 = GUICtrlCreateListView("���|����|�Ա�|�绰|QQ|���Ѷ�|��ע", 8, 8, 314, 174)
$Button1 = GUICtrlCreateButton("���", 8, 200, 60, 25)
$Button2 = GUICtrlCreateButton("�༭", 88, 200, 60, 25)
$Button3 = GUICtrlCreateButton("ɾ��", 165, 232, 60, 25)
$Button4 = GUICtrlCreateButton("ˢ��", 88, 232, 60, 25)
$Button5 = GUICtrlCreateButton("ȫ��ɾ��", 165, 200, 84, 25)
$Button6 = GUICtrlCreateButton("����", 8, 232, 60, 25)
$Button7 = GUICtrlCreateButton("�˳�", 265, 200, 60, 25)
$Label1 = GUICtrlCreateLabel("������", 247, 240, 40, 17)
$Label2 = GUICtrlCreateLabel("0", 290, 240, 40, 17)
;�Ӵ���
$Form2 = GUICreate("", 363, 271, 192, 121)
$Label1_1 = GUICtrlCreateLabel("ͨѶ¼������д��", 35, 20, 100, 25)
$Label1_3 = GUICtrlCreateLabel("�Ա�", 8, 60, 40, 17)
$Label1_5 = GUICtrlCreateLabel("QQ:", 8, 90, 32, 17)
$Label1_4 = GUICtrlCreateLabel("�绰��", 180, 56, 40, 17)
$Label1_6 = GUICtrlCreateLabel("���Ѷȣ�", 180, 93, 50, 17)
$Label1_7 = GUICtrlCreateLabel("��ע", 8, 128, 40, 17)
$Label1_2 = GUICtrlCreateLabel("������", 180, 20, 40, 17)
$Button8 = GUICtrlCreateButton("ȷ��", 280, 140, 60, 25)
$Button9 = GUICtrlCreateButton("ȡ��", 280, 200, 60, 25)
$Input2 = GUICtrlCreateInput("", 230, 17, 120, 21)
$Combo1 = GUICtrlCreateCombo("��ѡ���Ա�", 50, 56, 120, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "��|Ů")
$Input3 = GUICtrlCreateInput("", 230, 56, 120, 21)
$Input4 = GUICtrlCreateInput("", 50, 88, 120, 21)
$Edit1 = GUICtrlCreateEdit("", 48, 128, 220, 129)
GUICtrlSetData(-1, "")
$Combo2 = GUICtrlCreateCombo("��ѡ����Ѷ�", 230, 88, 120, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "�ܺ�|��|һ��|��|�ܲ�")
GUISetState(@SW_SHOW, $Form1)
#EndRegion ### END Koda GUI section ###

ShuJu()



While 1
	$XingMing = GUICtrlRead($Input2)
	$DianHua = GUICtrlRead($Input3)
	$QQ = GUICtrlRead($Input4)
	$LieBiao = GUICtrlRead($ListView1)
	$XingBie = GUICtrlRead($Combo1)
	$HaoYouDu = GUICtrlRead($Combo2)
	$BieZhu = GUICtrlRead($Edit1)
	$NY = StringSplit(GUICtrlRead($LieBiao), "|", 0)
	$nMsg = GUIGetMsg(1)
	Select
		Case $nMsg[0] = $GUI_EVENT_CLOSE Or $nMsg[0] = $Button7
			Exit
		Case $nMsg[0] = $Button1
			GUISetState(@SW_SHOW, $Form2)   ;��ʾ�Ӵ���
			GUISetState(@SW_DISABLE, $Form1)  ;����������
			WinSetTitle("", "", "�������")   ;�޸��Ӵ��ڱ���
		Case $nMsg[0] = $Button2
			BianJi()
		Case $nMsg[0] = $Button4
			ShuJu()
		Case $nMsg[0] = $Button8
			TianJia()
		Case $nMsg[0] = $Button6
			FuZhi()
		Case $nMsg[0] = $Button9
			GUISetState(@SW_HIDE, $Form2)
			GUISetState(@SW_ENABLE, $Form1)
			WinActivate("ͨѶ¼")
		Case $nMsg[0] = $Button5
			ShanChuQuanBu()
		Case $nMsg[0] = $Button3
			ShanChu()
	EndSelect
WEnd

Func ShuJu()
	$z = 0
	_GUICtrlListView_DeleteAllItems($ListView1)  ;ɾ���б������
	$var = IniReadSection($ShuJu, "Data")   ;��ȡini
	If Not @error Then
		For $i = 1 To $var[0][0]
			GUICtrlCreateListViewItem($var[$i][1], $ListView1)    ;��ini�ļ��������д���б���
			GUICtrlSetData($Label2, $z + 1)
			$z += 1
		Next
	EndIf
EndFunc   ;==>ShuJu


Func TianJia()
	$XunHao = _GUICtrlListView_GetItemCount($ListView1)   ;��ȡ�б��������
	$XunHao += 1
	$NY = StringSplit(GUICtrlRead($LieBiao), "|", 0)  ;���б��������"|"�ֿ�
	$z = GUICtrlRead($Label2)
	If WinGetTitle($Form2) = "�������" Then   ;������ڵı��� = "�������"
		If $XingMing <> "" And $DianHua <> "" And $XingBie <> "" And $HaoYouDu <> "" Then
			GUICtrlCreateListViewItem($XunHao & "|" & $XingMing & "|" & $XingBie & "|" & $DianHua & "|" & $QQ & "|" & $HaoYouDu & "|" & $BieZhu, $ListView1) ;������д���б�
			IniWrite($ShuJu, "Data", $XunHao, $XunHao & "|" & $XingMing & "|" & $XingBie & "|" & $DianHua & "|" & $QQ & "|" & $HaoYouDu & "|" & $BieZhu)   ;������д��ini
			GUICtrlSetData($Input2, "")
			GUICtrlSetData($Input3, "")
			GUICtrlSetData($Input4, "")
			ControlCommand( "", "", $Combo1, "SetCurrentSelection", 0)   ;��ԭ�ؼ����ݵĵ�һ��ѡ��
			ControlCommand( "", "", $Combo2, "SetCurrentSelection", 0)
			GUICtrlSetData($Edit1, "")
		EndIf
	ElseIf WinGetTitle($Form2) = "�༭����" Then
		GUICtrlSetData($LieBiao, $NY[1] & "|" & $XingMing & "|" & $XingBie & "|" & $DianHua & "|" & $QQ & "|" & $HaoYouDu & "|" & $BieZhu)
		IniWrite($ShuJu, "Data", $NY[1], $NY[1] & "|" & $XingMing & "|" & $XingBie & "|" & $DianHua & "|" & $QQ & "|" & $HaoYouDu & "|" & $BieZhu)
	EndIf
	GUISetState(@SW_HIDE, $Form2)
	GUISetState(@SW_ENABLE, $Form1)
	WinActivate("ͨѶ¼")
	GUICtrlSetData($Label2, $z + 1)
EndFunc   ;==>TianJia


Func BianJi()
	GUISetState(@SW_SHOW, $Form2)
	GUISetState(@SW_DISABLE, $Form1)
	WinSetTitle("", "", "�༭����")
	$NY = StringSplit(GUICtrlRead($LieBiao), "|", 0)
	GUICtrlSetData($Input2, $NY[2])
	If $NY[3] = "��" Then
		ControlCommand("", "", $Combo1, "SetCurrentSelection", 1)
	Else
		ControlCommand("", "", $Combo1, "SetCurrentSelection", 2)
	EndIf
	GUICtrlSetData($Input3, $NY[4])
	GUICtrlSetData($Input4, $NY[5])
	If $NY[6] = "�ܺ�" Then
		ControlCommand("", "", $Combo2, "SelectString", "�ܺ�")
	ElseIf $NY[6] = "��" Then
		ControlCommand("", "", $Combo2, "SelectString", "��")
	ElseIf $NY[6] = "һ��" Then
		ControlCommand("", "", $Combo2, "SelectString", "һ��")
	ElseIf $NY[6] = "��" Then
		ControlCommand("", "", $Combo2, "SelectString", "��")
	ElseIf $NY[6] = "�ܲ�" Then
		ControlCommand("", "", $Combo2, "SelectString", "�ܲ�")
	EndIf
	GUICtrlSetData($Edit1, $NY[7])
EndFunc   ;==>BianJi


Func ShanChuQuanBu()
	_GUICtrlListView_DeleteAllItems($ListView1)  ;ɾ���б�ȫ������
	IniDelete($ShuJu, "Data")    ;ɾ��ini���ȫ������
	GUICtrlSetData($Label2, "0")
EndFunc   ;==>ShanChuQuanBu


Func ShanChu()
	$ShanChu = _GUICtrlListView_GetSelectedIndices($ListView1)   ;1
	If Not StringLen($ShanChu) Then Return                       ;2
	_GUICtrlListView_DeleteItem($ListView1, $ShanChu)            ;3   �� 1��2��3�ǰ��б���ѡ�е�����ɾ��

	If FileExists($ShuJu) Then FileDelete($ShuJu)             ;ȷ��ini�ļ��Ƿ���ڡ���������ڣ��Ͱ�Iniɾ��

	$x = _GUICtrlListView_GetColumnCount($ListView1) - 1     ;��ȡ�б�������
	$y = _GUICtrlListView_GetItemCount($ListView1) - 1       ;��ȡ�б�������
	Dim $NengYong
	For $yy = 0 To $y              
		For $xx = 0 To $x
			$WenBen = _GUICtrlListView_GetItemText($ListView1, $yy, $xx)   ;��ȡĳһ����ĳһ�е�����
			If $NengYong <> "" Then
				$NengYong = $NengYong & "|" & $WenBen
			Else
				$NengYong = $yy + 1
			EndIf
		Next
		IniWrite($ShuJu, "Data", $yy, $NengYong)
		$NengYong = ""
	Next
	$iniNengYong = IniReadSection($ShuJu, "Data")
	_GUICtrlListView_DeleteAllItems($ListView1)
	For $i = 1 To $iniNengYong[0][0]
		GUICtrlCreateListViewItem($iniNengYong[$i][1], $ListView1)
	Next
	$z = GUICtrlRead($Label2)
	GUICtrlSetData($Label2, $z - 1)
EndFunc   ;==>ShanChu

Func ShuaXin()
	$var = IniReadSection($ShuJu, "Data")
	If FileExists($ShuJu) And IniReadSection($ShuJu, "Data") <> 1 Then
		For $i = 1 To $var[0][0]
			GUICtrlCreateListViewItem($var[$i][1], $ListView1)
		Next
	EndIf
EndFunc   ;==>ShuaXin


Func FuZhi()
	_GUICtrlListView_CopyItems($ListView1, $ListView1)
	$z = GUICtrlRead($Label2)
	GUICtrlSetData($Label2, $z + 1)
EndFunc   ;==>FuZhi