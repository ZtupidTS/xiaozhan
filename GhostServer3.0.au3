#NoTrayIcon
#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=moon_mycom.ico
#AutoIt3Wrapper_outfile=NetbarGhostServer.exe
#AutoIt3Wrapper_Res_Comment=����GHOST��������ù��ߣ�����ɨ�����
#AutoIt3Wrapper_Res_Description=����GHOST��������ù���
#AutoIt3Wrapper_Res_Fileversion=3.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=BY-Jycel QQ:472891322
#AutoIt3Wrapper_Res_Field=Դ�ļ���|NetbarGhostServer.exe
#AutoIt3Wrapper_Res_Field=��������|����
#EndRegion ;**** ���������� ACNWrapper_GUI ****
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiIPAddress.au3>
#include <GuiStatusBar.au3>
#include <ListViewConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>
#include <GuiImageList.au3>
$g_szVersion = "GhostServer3.0"
If WinExists($g_szVersion) Then
	MsgBox(16, "��ܰ��ʾ", "����������",3)
	Exit 
EndIf
AutoItWinSetTitle($g_szVersion)
If Not FileExists(@ScriptDir&"\Tool") Then
$tool=DirCreate(@ScriptDir&"\Tool")
If $tool=0 Then MsgBox(0,"","TOOLĿ¼����ʧ�������Ƿ��Ѵ��ڻ�Ȩ�޲���")
EndIf
GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
FileInstall("mdb.ini", @ScriptDir & "\mdb.ini", 0)
FileInstall("Update.exe", @ScriptDir & "\Update.exe", 0)
FileInstall("Ghostupdate.ini", @ScriptDir & "\Ghostupdate.ini", 0)
FileInstall("��������.exe", @ScriptDir & "\tool\��������.exe", 0)
Opt("TrayAutoPause",0)
Local $hIcons[2]
Local $SelectedItem[10]
$ini="mdb.ini"
$temp=@TempDir & "\temp.ini"
If FileExists($temp) Then
	FileDelete($temp)
EndIf
If Not FileExists($ini) Then
_Default()
EndIf
$info=_NetworkAdapterInfo()
#Region ### START Koda GUI section ### Form=c:\documents and settings\administrator\����\access���ݿ����\form1.kxf
$Form1 = GUICreate(" Ghost���ù��� - ����� V3.0", 825, 615, 143, 67)
$MenuItem1 = GUICtrlCreateMenu("�����˵�")
$MenuItem3 = GUICtrlCreateMenu("�������", $MenuItem1)
$server1 = GUICtrlCreateMenuItem("�������", $MenuItem3)
$server2 = GUICtrlCreateMenuItem("ɨ�����", $MenuItem3)
$server3 = GUICtrlCreateMenuItem("���ӳ���", $MenuItem3)
$MenuItem4 = GUICtrlCreateMenuItem("�ύ����", $MenuItem1)
$MenuItem5 = GUICtrlCreateMenuItem("���³���", $MenuItem1)
$MenuItem6 = GUICtrlCreateMenuItem("���߿ռ�", $MenuItem1)
$MenuItem7 = GUICtrlCreateMenuItem("���ڳ���", $MenuItem1)
$MenuItem8 = GUICtrlCreateMenuItem("�˳�����", $MenuItem1)

GUISetBkColor(0xA3AE110);0xEF379C)
DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00040010)
$ListView1 = GUICtrlCreateListView("MAC��ַ|�������|IP��ַ|IPX��ַ|��������|Ĭ������|��ѡDNS|����DNS|�ֱ���|��ԭ���|IDEͨ��", 8, 0, 809, 297,$LVS_EX_GRIDLINES)
_GUICtrlListView_SetExtendedListViewStyle ($ListView1, BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_GRIDLINES, $LVS_EX_SUBITEMIMAGES))
GUICtrlSetBkColor(-1, 0xA6CAF0)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 112)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 60)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 2, 92)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 3, 80)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 4, 92)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 5, 92)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 6, 92)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 7, 92)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 8, 110)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 9, 80)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 10, 60)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 11, 60)
$menu = GUICtrlCreateContextMenu($ListView1)
$e_menu = GUICtrlCreateMenuItem("�༭ѡ����Ŀ", $menu)
$d_menu = GUICtrlCreateMenuItem("ɾ��ѡ����Ŀ", $menu)
$c_menu = GUICtrlCreateMenuItem("�����������", $menu)
GUICtrlCreateMenuItem("", $menu)
$all_menu = GUICtrlCreateMenu("�����޸�����", $menu)
$all1_menu = GUICtrlCreateMenuItem("IPX ��ַ", $all_menu)
$all2_menu = GUICtrlCreateMenuItem("��������", $all_menu)
$all3_menu = GUICtrlCreateMenuItem("Ĭ������", $all_menu)
$all4_menu = GUICtrlCreateMenuItem("��ѡ DNS", $all_menu)
$all5_menu = GUICtrlCreateMenuItem("���� DNS", $all_menu)
$all6_menu = GUICtrlCreateMenuItem("�� �� ��", $all_menu)
$all7_menu = GUICtrlCreateMenuItem("��ԭ���", $all_menu)
$all8_menu = GUICtrlCreateMenuItem("IDE ͨ��", $all_menu)

$Group1 = GUICtrlCreateGroup("", 8, 300, 809, 40)
$Label1 = GUICtrlCreateLabel("׼�����������ú���������и��������ɨ��", 10, 308, 800, 30);,$ES_CENTER)
GUICtrlSetFont(-1, 18, 800, 0, "����_GB2312")
GUICtrlSetColor(-1, 0x000000);0xFF0000)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("������á��������²�������ɨ��-�����Զ�������б���", 8, 344, 697, 110)
$Label2 = GUICtrlCreateLabel("�������", 16, 366, 52, 17)
$Input1 = GUICtrlCreateInput(@ComputerName, 72, 360, 108, 21, BitOR($ES_CENTER,$ES_AUTOHSCROLL))
GUICtrlSetTip(-1,"����������޸���","��ʾ����",1)
GUICtrlSetState(-1,$GUI_DISABLE)
$Label3 = GUICtrlCreateLabel("I P ��ַ", 184, 366, 51, 17)
$Input2 = GUICtrlCreateInput($info[1][4], 240, 360, 108, 21, BitOR($ES_CENTER,$ES_AUTOHSCROLL))
GUICtrlSetTip(-1,"I P ��ַ�޸���","��ʾ����",1)
GUICtrlSetState(-1,$GUI_DISABLE)
$Label4 = GUICtrlCreateLabel("MAC��ַ", 360, 366, 51, 17)
$Input3 = GUICtrlCreateInput($info[1][8], 416, 360, 108, 21, BitOR($ES_CENTER,$ES_AUTOHSCROLL))
GUICtrlSetTip(-1,"��ֹ�޸�","��ʾ����",1)
GUICtrlSetState(-1,$GUI_DISABLE)
$Label5 = GUICtrlCreateLabel("IPX ��ַ", 528, 366, 51, 17)
GUICtrlSetTip(-1,"IP����-��IP���λ����"&@CRLF&"�������-8λ�����ȡֵ","��ʾ����",1)
$Combo1 = GUICtrlCreateCombo("", 584, 360, 108, 21)
GUICtrlSetData(-1,"IP����|�������","IP����")
$Label6 = GUICtrlCreateLabel("��������", 16, 398, 52, 17)
$Input5 = GUICtrlCreateInput($info[1][7], 72, 392, 108, 21,BitOR($ES_CENTER,$ES_AUTOHSCROLL))
GUICtrlSetTip(-1,"Ĭ�϶�ȡ���������޸ģ�","��ʾ����",1)
$Label7 = GUICtrlCreateLabel("Ĭ������", 184, 398, 52, 17)
$Input6 = GUICtrlCreateInput($info[1][2], 240, 392, 108, 21,BitOR($ES_CENTER,$ES_AUTOHSCROLL))
GUICtrlSetTip(-1,"Ĭ�϶�ȡ���������޸ģ�","��ʾ����",1)
$Label8 = GUICtrlCreateLabel("��ѡ DNS", 360, 398, 51, 17)
$Input7 = GUICtrlCreateInput($info[1][5], 416, 392, 108, 21,BitOR($ES_CENTER,$ES_AUTOHSCROLL))
GUICtrlSetTip(-1,"Ĭ�϶�ȡ���������޸ģ�","��ʾ����",1)
$Label9 = GUICtrlCreateLabel("���� DNS", 528, 398, 51, 17)
$Input8 = GUICtrlCreateInput($info[1][6], 584, 392, 108, 21,BitOR($ES_CENTER,$ES_AUTOHSCROLL))
GUICtrlSetTip(-1,"Ĭ�϶�ȡ���������޸ģ�","��ʾ����",1)
$Label10 = GUICtrlCreateLabel("��ԭ���", 16, 430, 52, 17)
$Input9 = GUICtrlCreateInput("��ά��ʦ.exe", 72, 424, 108, 21,BitOR($ES_CENTER,$ES_AUTOHSCROLL))
GUICtrlSetTip(-1,"�κο�ִ���ļ�����׺"&@CRLF&"���������ʹ�ñ�����","��ʾ����",1)
$Label11 = GUICtrlCreateLabel("�� �� ��", 184, 430, 51, 17)
GUICtrlSetTip(-1,"�����������ֶ��޸������ļ���ִ�У����޸ģ�","��ʾ����",1)
$Combo2 = GUICtrlCreateCombo("", 240, 424, 108, 21)
$fby = IniReadSection($ini, "�ֱ���")
For $i = 1 To $fby[0][0]
	GUICtrlSetData(-1,$fby[$i][0],$fby[2][0])
Next
$Label12 = GUICtrlCreateLabel("��������", 360, 430, 52, 17)
$Input10 = GUICtrlCreateInput(IniRead($ini,"����","��������",""), 416, 424, 108, 21,BitOR($ES_CENTER,$ES_AUTOHSCROLL))
GUICtrlSetTip(-1,"���ö��������˴���дӲ��ID��"&@CRLF&"�����������鿴ʹ��˵��","��ʾ����",1)
$Label13 = GUICtrlCreateLabel("IDE ͨ��", 528, 430, 52, 17)
GUICtrlSetTip(-1,"�Ƿ�رն���IDEͨ��","��ʾ����",1)
$Combo3 = GUICtrlCreateCombo("", 584, 424, 49, 25)
GUICtrlSetData(-1,"����|�ر�","����")
$Label14 = GUICtrlCreateLabel("T", 642, 430, 11, 17)
GUICtrlSetTip(-1,"����ʱ�����뿪ʼ����","��ʾ����",1)
$Input11 = GuiCtrlCreateInput("30", 656, 424, 36, 20)
GuiCtrlCreateUpDown(-1)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group3 = GUICtrlCreateGroup("", 8, 504, 697, 41)
$Button3 = GUICtrlCreateButton("��  ȡ  ��  ��", 16, 516, 160, 25, $WS_GROUP)
GUICtrlSetTip(-1,"��ȡ�����ļ���������ɨ�����ʹ��","��ʾ����",1)
$Button4 = GUICtrlCreateButton("��  ��  ��  ��", 188, 516, 160, 25, $WS_GROUP)
GUICtrlSetTip(-1,"����ɨ����Ϣ��ѡ����Ҫ�޸ĵ������Ҽ�ѡ���޸�����","��ʾ����",1)
$Button5 = GUICtrlCreateButton("Ԥ  ��  ��  ��", 362, 516, 160, 25, $WS_GROUP)
GUICtrlSetTip(-1,"Ԥ���ͻ��˳���"&@CRLF&"��ȷ���ͻ����ļ���ͬһĿ¼��","��ʾ����",1)
$Button6 = GUICtrlCreateButton("��  ��  ��  ��", 536, 516, 160, 25, $WS_GROUP)
GUICtrlSetTip(-1,"���浱ǰ��������","��ʾ����",1)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group4 = GUICtrlCreateGroup("ɨ��ͻ�����Ϣ��ɨ����Ϻ�ɸ���ʵ����������޸���ز���", 8, 456, 697, 49)

$Label15 = GUICtrlCreateLabel("��ʼ IP", 16, 478, 52, 17)
$IPAddress1 = _GUICtrlIpAddress_Create($Form1, 72, 472, 108, 21)
_GUICtrlIpAddress_Set($IPAddress1, @IPAddress1)

$Label16 = GUICtrlCreateLabel("���� IP", 184, 478, 52, 17)
$IPAddress2 = _GUICtrlIpAddress_Create($Form1, 240, 472, 108, 21)
_GUICtrlIpAddress_Set($IPAddress2, @IPAddress1)

$Label17 = GUICtrlCreateLabel("MAC��ַ�ָ��", 360, 478, 87, 17)
GUICtrlSetTip(-1,"���ʹ�ñ��������׿ͻ��ˣ���ѡ��Ĭ�Ϸָ���","��ʾ����",1)
$Combo4 = GUICtrlCreateCombo("", 456, 472, 65, 25)
GUICtrlSetData(-1,"-|:","-")

$Button1 = GUICtrlCreateCheckbox("��ʼɨ��", 536, 472, 72, 25, $BS_PUSHLIKE)
GUICtrlSetTip(-1,"ɨ��ǰ��������ɨ��"&@CRLF&"��ʼIP������IP���ͷָ���","��ʾ����",1)
$Button2 = GUICtrlCreateButton("�鿴����", 624, 472, 72, 25, $WS_GROUP)
GUICtrlSetTip(-1,"�������ļ�","��ʾ����",1)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$StatusBar1 = _GUICtrlStatusBar_Create($Form1)
_GUICtrlStatusBar_SetText ($StatusBar1, "��ӭʹ������ר�ù���! �������ʹ�ù��������κ����⣬����ϵ���߻���̳���ʣ�  E-mail:Jycel@qq.com      QQ:472891322      BY-Jycel")
$hIcons[0] = _WinAPI_LoadShell32Icon (13)
_GUICtrlStatusBar_SetIcon ($StatusBar1, 0, $hIcons[0])
GUISetState(@SW_SHOW)
$Progress1 = GUICtrlCreateProgress(8, 552, 809, 16)
$Group5 = GUICtrlCreateGroup("���ӳ����б�", 712, 344, 105, 201)
$ListView2 = GUICtrlCreateListView("", 720, 360, 90, 118,$LVS_EX_GRIDLINES)
_GUICtrlListView_SetExtendedListViewStyle ($ListView2, BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_GRIDLINES, $LVS_EX_SUBITEMIMAGES))
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 50)
_GUICtrlListView_InsertColumn($ListView2, 0, "����", 70)
$Combo5 = GUICtrlCreateCombo("", 720, 488, 70, 25)
_Runlist()
$jia = GUICtrlCreateButton("+", 792, 488, 20, 20)
$Button7 = GUICtrlCreateButton("���", 720, 520, 89, 20, $WS_GROUP)
GUICtrlSetTip(-1,"��ӵ�ǰѡ����������ӳ����б�"&@CRLF&"ע��:"&@CRLF&"��Ӻ����Ҽ��༩�����Զ�����","��ʾ����",1)
$menu2 = GUICtrlCreateContextMenu($ListView2)
$x_menu2 = GUICtrlCreateMenuItem("�༩", $menu2)
$d_menu2 = GUICtrlCreateMenuItem("ɾ��", $menu2)
$k_menu2 = GUICtrlCreateMenuItem("���", $menu2)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
_dulist2()
While 1
	
	$aIP0 = _GUICtrlIpAddress_GetArray($IPAddress1)
	$aIP1 = _GUICtrlIpAddress_GetArray($IPAddress2)
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00050010)
			If FileExists($temp) Then
				FileDelete($temp)
			EndIf
			Exit
		Case $Button1
			_sm()
		case $Button2
			ShellExecute($ini)			
		Case $Button3
			_du()
		Case $Button4
			$Index= _GUICtrlListView_GetSelectedIndices($ListView1)
			$Indexcj= StringSplit($Index, "|")
			If Not StringLen($Index) Then
				GUICtrlSetData($Label1,"��ʾ:��ѡ����ٽ����޸Ĳ���!")
			Else
			   For $k = 1 To $Indexcj[0]
				   $tempz=IniRead($temp,"Temp","�����޸�","")
				   If $tempz="IPX ��ַ" Then
							_GUICtrlListView_AddSubItem ($ListView1, $Indexcj[$k], GUICtrlRead($Combo1), 3, 3)
							GUICtrlSetData($Label1,"��ʾ:["&$tempz&"]�����޸ĳɹ����뼴ʱ��������")
							_jc()
					ElseIf $tempz="��������" Then
							_GUICtrlListView_AddSubItem ($ListView1, $Indexcj[$k], GUICtrlRead($Input5), 4, 4)
							GUICtrlSetData($Label1,"��ʾ:["&$tempz&"]�����޸ĳɹ����뼴ʱ��������")
							_jc()
					ElseIf $tempz="Ĭ������" Then
							_GUICtrlListView_AddSubItem ($ListView1, $Indexcj[$k], GUICtrlRead($Input6), 5, 5)
							GUICtrlSetData($Label1,"��ʾ:["&$tempz&"]�����޸ĳɹ����뼴ʱ��������")
							_jc()
					ElseIf $tempz="��ѡ DNS" Then
							_GUICtrlListView_AddSubItem ($ListView1, $Indexcj[$k], GUICtrlRead($Input7), 6, 6)
							GUICtrlSetData($Label1,"��ʾ:["&$tempz&"]�����޸ĳɹ����뼴ʱ��������")
							_jc()
					ElseIf $tempz="���� DNS" Then
							_GUICtrlListView_AddSubItem ($ListView1, $Indexcj[$k], GUICtrlRead($Input8), 7, 7)
							GUICtrlSetData($Label1,"��ʾ:["&$tempz&"]�����޸ĳɹ����뼴ʱ��������")
							_jc()
					ElseIf $tempz="�� �� ��" Then
							_GUICtrlListView_AddSubItem ($ListView1, $Indexcj[$k], GUICtrlRead($Combo2), 8, 8)
							GUICtrlSetData($Label1,"��ʾ:["&$tempz&"]�����޸ĳɹ����뼴ʱ��������")
							_jc()
					ElseIf $tempz="��ԭ���" Then
							_GUICtrlListView_AddSubItem ($ListView1, $Indexcj[$k], GUICtrlRead($Input9), 9, 9)
							GUICtrlSetData($Label1,"��ʾ:["&$tempz&"]�����޸ĳɹ����뼴ʱ��������")
							_jc()
					ElseIf $tempz="IDE ͨ��" Then
							_GUICtrlListView_AddSubItem ($ListView1, $Indexcj[$k], GUICtrlRead($Combo3), 10, 10)
							GUICtrlSetData($Label1,"��ʾ:["&$tempz&"]�����޸ĳɹ����뼴ʱ��������")
							_jc()
					EndIf		
			   Next			   
		   EndIf
		Case $Button5
			If FileExists("NetbarGhostClient.exe") Then 
					ShellExecute("NetbarGhostClient.exe")
			Else
				GUICtrlSetData($Label1,"��ʾ:δ�ҵ��ͻ��˳������������� ���ص�ַ:http://jycel.ys168.com")
			EndIf		   
		Case $Button6
			_xr()
			_save()
		case $Button7;���
			If _GUICtrlListView_FindInText($ListView2, GUICtrlRead($Combo5)) = -1 Then _GUICtrlListView_AddItem($ListView2, GUICtrlRead($Combo5), 2, 0)
			;_savelist2()
		case $jia
			$listjia=InputBox("�������","��������Ҫ�����ѡ����������"&@CRLF&@CRLF&"��Ӻ����Ҽ��༩�������Զ�����","","",-1,135,-1,-1,30)	
			If @error=0 Then
					IniWrite($ini,"Runlist",$listjia,"")
					GUICtrlSetData($Label1,"д��ɹ�"&$listjia)
			ElseIf @error=2 Then
					GUICtrlSetData($Label1,"��ӳ�ʱ�������µ��  ��ʾ:30��δ�����Զ��ر�")
			EndIf			
			_Runlist()
		case $server1
			MsgBox(64,"������ð���˵��","���������,�����Զ���ȡ������Ϣ"&@CRLF&@CRLF _
			&"��ԭ�������д����Ϊ���Լ��Ļ�ԭ��װ����[�Զ���װ����]"&@CRLF&@CRLF _
			&"�� �� �ʣ�ֱ��ѡ�������ʾ�����ͣ��鿴���ÿ��ֶ��޸�" &@CRLF&@CRLF _
			&"������������Ҫ���ö���������Ӳ��ID" &@CRLF&@CRLF _
			&"���ҷ���:�ҵĵ���-����-Ӳ��-�豸������-����������-ѡ����Ҫ���õ�����-����-��ϸ��Ϣ-������" &@CRLF&@CRLF _
			&"          ѡ��Ӳ��ID-ѡ��ֵ������һ����CTRL+C[�Ҽ��޷�����]-Ȼ��ճ�����ļ��м��ɲ鿴." &@CRLF&@CRLF _
			&"          ����PCI\VEN_11AB&DEV_4364&SUBSYS_00BA11AB&REV_14���е�DEV_4364��Ϊ�豸Ӳ��ID��"&@CRLF&@CRLF _
			&"I D Eͨ����[�ӿ쿪��]����ĸ�̲��Կͻ���ʱ�رձ����ܣ�������̺�������������"&@CRLF&@CRLF _
			&"T���ͻ��˵���ʱ����ʱ�䣬��λΪ�� Ĭ��30���ʼ���ã�")
 		case $server2
			MsgBox(64,"ɨ�����˵��","ɨ��ǰ���ڿ�ʼIP�ͽ���IP����д��ȷ��IP��ַ�������ڲ�ͬ����ȫ��ɨ��"&@CRLF&@crlf _
			& "������192.168.0.1����ɨ��192.168.0.1~255����192.168.1.1ɨ��192.168.1.1~255"&@CRLF&@crlf _
			& "MAC��ַ�ָ�������ɨ��MAC��Ϣʱ�����ɵĸ�ʽ��Ĭ��'-'��ʽ "&@CRLF&@crlf _
			& "�鿴���ã��Զ���mdb.ini�����ļ��������ֶ��޸ĺͲ鿴"&@CRLF&@crlf _
			& "��ע�������ͬ�����в�ͬ�ֱ��ʣ��ɷ�IPɨ�裬����������ò���ɨ��"&@CRLF&@crlf _
			& "      Ҳ��ȫ��ɨ���ʹ�������޸ķ��޸���ز������Ƽ�ʹ�������޸ģ�")
 		case $server3
			MsgBox(64,"���ӳ������˵��","������Ӱ�ť����ѡ�����Ҫ��ӵĸ��ӳ���   �����򸽴����������ۡ�����"&@CRLF&@crlf _
			&"���ӳ��������ú�IP�������Ϣ�󣬰�װ��ԭ���֮ǰ��װ��"&@CRLF&@crlf _
			&"Ҳ�ɵ��+����ѡ������ӳ����б����Ҽ�ִ�б༩��ɾ������ղ���"&@CRLF&@crlf _
			&"ע�⣺��ӳ�������Ҽ��༩�ó���Ȼ�����ö�Ӧִ�г�������ȷ�����Զ�����")
		case $MenuItem4
			Run(@ProgramFilesDir & "\Internet Explorer\iexplore.exe http://autoit.net.cn/viewthread.php?tid=9464&extra=page%3D1")
		Case $MenuItem5
			If FileExists("update.exe") Then
			ShellExecute("update.exe")
			Exit
		Else
			GUICtrlSetData($Label1,"δ�ҵ������ļ�-update.exe �뵽http://jycel.ys168.com����")
			EndIf
		Case $MenuItem6
			Run(@ProgramFilesDir & "\Internet Explorer\iexplore.exe http://472891322.qzone.qq.com")
		Case $MenuItem7 ;���ڳ���
			MsgBox(64,"���ڳ��� BY-Jycel","�������ʺϹ����������ͬ��ʹ��"&@CRLF _
			&@CRLF&"�������ǲ���Autoit3�ű����Ա�д������"&@CRLF _
			&@CRLF&"�����Ա��������κ����ʻ��飬����ϵ����"&@CRLF _
			&@CRLF&"���µ�ַ:  http://jycel.ys168.com")
		Case $MenuItem8
			DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00050010)
			If FileExists($temp) Then
				FileDelete($temp)
			EndIf
			Exit		
;===================================						
		case $x_menu2
			$Listv2 = _GUICtrlListView_GetSelectedIndices($ListView2)
			If Not StringLen($Listv2) Then
				GUICtrlSetData($Label1,"��ʾ:��ѡ����ٽ��б༩����!")
			Else
			$l2name=_GUICtrlListView_GetItemText($ListView2, Number($Listv2),0)
			$list2z=InputBox($l2name,"�����롾"&$l2name&"�����Ӧ��ִ�г�����"&@crlf&@crlf&"����:"&$l2name&".exe",$l2name&".*","",-1,135,-1,-1,30)	
			If @error=0 Then
					IniWrite($ini,"���ӳ���",$l2name,$list2z)
					GUICtrlSetData($Label1,"д��ɹ�����"&$l2name&"����"&$list2z)
			ElseIf @error=1 Then
					GUICtrlSetData($Label1,"��"&$l2name&"����ǰδ����")
			ElseIf @error=2 Then
					GUICtrlSetData($Label1,"д�볬ʱ�������±༩  ��ʾ:30��δ�����Զ��ر�")
			EndIf
		EndIf
		case $d_menu2;ɾ��
			_del2()
		case $k_menu2;	���
			_GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($ListView2))
			;_savelist2()
			IniDelete($ini,"���ӳ���")
			GUICtrlSetData($Label1,"��ʾ:������ճɹ���")
		Case $c_menu
			_GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($ListView1))
			GUICtrlSetData($Label1,"��ʾ:������ճɹ���")			
		case $e_menu;�༩
			$Index = _GUICtrlListView_GetSelectedIndices($ListView1)
			If Not StringLen($Index) Then
				GUICtrlSetData($Label1,"��ʾ:��ѡ����ٽ��б༩����!")
				Else
			GUICtrlSetData($Label1,"��ʾ:���ֶ��޸��������ú����������ݰ�ť!")
			EndIf
		case $d_menu;ɾ��
			_del()
		case $all1_menu
			_jz()
			$List_n=_GUICtrlListView_GetItemCount($ListView1)
			If Not $List_n Then
				GUICtrlSetData($Label1,"����:��ǰ���κ�����!��ɨ����ȡ���ٲ���")
				Else
					GUICtrlSetData($Label1,"��ʾ:����IPX��ַ��ѡ����������ٸ�������! �޸�����뱣������")
					GUICtrlSetState($Combo1,$GUI_ENABLE)
					IniWrite($temp,"Temp","�����޸�","IPX ��ַ")
			EndIf		
		case $all2_menu
			_jz()
			$List_n=_GUICtrlListView_GetItemCount($ListView1)
			If Not $List_n Then
				GUICtrlSetData($Label1,"����:��ǰ���κ�����!��ɨ����ȡ���ٲ���")
				Else			
			GUICtrlSetData($Label1,"��ʾ:���������������޸Ĳ����ٸ�������! �޸�����뱣������")
			GUICtrlSetState($Input5,$GUI_ENABLE)
			IniWrite($temp,"Temp","�����޸�","��������")
			EndIf
		case $all3_menu
			_jz()
			$List_n=_GUICtrlListView_GetItemCount($ListView1)
			If Not $List_n Then
				GUICtrlSetData($Label1,"����:��ǰ���κ�����!��ɨ����ȡ���ٲ���")
				Else			
			GUICtrlSetData($Label1,"��ʾ:����Ĭ���������޸Ĳ����ٸ�������! �޸�����뱣������")
			GUICtrlSetState($Input6,$GUI_ENABLE)
			IniWrite($temp,"Temp","�����޸�","Ĭ������")
			EndIf
		case $all4_menu
			_jz()
			$List_n=_GUICtrlListView_GetItemCount($ListView1)
			If Not $List_n Then
				GUICtrlSetData($Label1,"����:��ǰ���κ�����!��ɨ����ȡ���ٲ���")
				Else			
			GUICtrlSetData($Label1,"��ʾ:������ѡ DNS���޸Ĳ����ٸ�������! �޸�����뱣������")
			GUICtrlSetState($Input7,$GUI_ENABLE)
			IniWrite($temp,"Temp","�����޸�","��ѡ DNS")
			EndIf
		case $all5_menu
			_jz()
			$List_n=_GUICtrlListView_GetItemCount($ListView1)
			If Not $List_n Then
				GUICtrlSetData($Label1,"����:��ǰ���κ�����!��ɨ����ȡ���ٲ���")
				Else			
			GUICtrlSetData($Label1,"��ʾ:���ڱ��� DNS���޸Ĳ����ٸ�������! �޸�����뱣������")
			GUICtrlSetState($Input8,$GUI_ENABLE)
			IniWrite($temp,"Temp","�����޸�","���� DNS")
			EndIf
		case $all6_menu
			_jz()
			$List_n=_GUICtrlListView_GetItemCount($ListView1)
			If Not $List_n Then
				GUICtrlSetData($Label1,"����:��ǰ���κ�����!��ɨ����ȡ���ٲ���")
				Else
			GUICtrlSetData($Label1,"��ʾ:���ڷ� �� ����ѡ����������ٸ�������! �޸�����뱣������")
			GUICtrlSetState($Combo2,$GUI_ENABLE)
			IniWrite($temp,"Temp","�����޸�","�� �� ��")
			EndIf
		case $all7_menu
			_jz()
			$List_n=_GUICtrlListView_GetItemCount($ListView1)
			If Not $List_n Then
				GUICtrlSetData($Label1,"����:��ǰ���κ�����!��ɨ����ȡ���ٲ���")
				Else			
			GUICtrlSetData($Label1,"��ʾ:���ڻ�ԭ������޸Ĳ����ٸ�������! �޸�����뱣������")
			GUICtrlSetState($Input9,$GUI_ENABLE)
			IniWrite($temp,"Temp","�����޸�","��ԭ���")
			EndIf
		case $all8_menu
			_jz()
			$List_n=_GUICtrlListView_GetItemCount($ListView1)
			If Not $List_n Then
				GUICtrlSetData($Label1,"����:��ǰ���κ�����!��ɨ����ȡ���ٲ���")
				Else			
			GUICtrlSetData($Label1,"��ʾ:����IDE ͨ����ѡ����������ٸ�������! �޸�����뱣������")
			GUICtrlSetState($Combo3,$GUI_ENABLE)
			IniWrite($temp,"Temp","�����޸�","IDE ͨ��")
			EndIf	

	EndSwitch
WEnd
Func _xr()
IniWrite($ini,"����","��������",GUICtrlRead($Input10))
IniWrite($ini,"����","����ʱ��",GUICtrlRead($Input11))
GUICtrlSetData($Label1,"���ݸ��³ɹ�!")
EndFunc
Func _du()
	_jc()
_GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($ListView1))
Dim $var = IniReadSection($ini, "Maclist"), $item[1], $i
If @error Then
	GUICtrlSetData($Label1,"��ʾ:������δ�ҵ�������ݣ�����ɨ�裡")
	Else
For $i = 1 to $var[0][0]
     $item[$i-1] = GUICtrlCreateListViewItem($var[$i][0] & '|' & $var[$i][1], $ListView1)
     ReDim $item[$i+1]
next
GUICtrlSetData($Label1,"���ݶ�ȡ�ɹ�!")
EndIf
EndFunc

Func __TCPIpToName($sIp, $iOption = Default, $hDll_Ws2_32 = Default)
	Local $vbinIP, $vaDllCall, $vptrHostent, $vHostent, $sHostnames, $vh_aliases, $i
	Local $INADDR_NONE = 0xffffffff, $AF_INET = 2, $sSeperator = @CR
	If $iOption = Default Then $iOption = 0
	If $hDll_Ws2_32 = Default Then $hDll_Ws2_32 = "Ws2_32.dll"
	$vaDllCall = DllCall($hDll_Ws2_32, "long", "inet_addr", "str", $sIp)
	If @error Then Return SetError(1, 0, "") ; inet_addr DllCall Failed
	$vbinIP = $vaDllCall[0]
	If $vbinIP = $INADDR_NONE Then Return SetError(2, 0, "") ; inet_addr Failed
	$vaDllCall = DllCall($hDll_Ws2_32, "ptr", "gethostbyaddr", "long*", $vbinIP, "int", 4, "int", $AF_INET)
	If @error Then Return SetError(3, 0, "") ; gethostbyaddr DllCall Failed
	$vptrHostent = $vaDllCall[0]
	If $vptrHostent = 0 Then
		$vaDllCall = DllCall($hDll_Ws2_32, "int", "WSAGetLastError")
		If @error Then Return SetError(5, 0, "") ; gethostbyaddr Failed, WSAGetLastError Failed
		Return SetError(4, $vaDllCall[0], "") ; gethostbyaddr Failed, WSAGetLastError = @Extended
	EndIf
	$vHostent = DllStructCreate("ptr;ptr;short;short;ptr", $vptrHostent)
	$sHostnames = __TCPIpToName_szStringRead(DllStructGetData($vHostent, 1))
	If @error Then Return SetError(6, 0, $sHostnames) ; strlen/sZStringRead Failed
	If $iOption = 1 Then
		$sHostnames &= $sSeperator
		For $i = 0 To 63 ; up to 64 Aliases
			$vh_aliases = DllStructCreate("ptr", DllStructGetData($vHostent, 2) + ($i * 4))
			If DllStructGetData($vh_aliases, 1) = 0 Then ExitLoop ; Null Pointer
			$sHostnames &= __TCPIpToName_szStringRead(DllStructGetData($vh_aliases, 1))
			If @error Then
				SetError(7) ; Error reading array
				ExitLoop
			EndIf
		Next
		Return StringSplit(StringStripWS($sHostnames, 2), @CR)
	Else
		Return $sHostnames
	EndIf
EndFunc   ;==>__TCPIpToName
Func __TCPIpToName_szStringRead($iszPtr, $iLen = -1, $hDll_msvcrt = "msvcrt.dll")
	Local $aStrLen, $vszString
	If $iszPtr < 1 Then Return "" ; Null Pointer
	If $iLen < 0 Then
		$aStrLen = DllCall($hDll_msvcrt, "int:cdecl", "strlen", "ptr", $iszPtr)
		If @error Then Return SetError(1, 0, "") ; strlen Failed
		$iLen = $aStrLen[0] + 1
	EndIf
	$vszString = DllStructCreate("char[" & $iLen & "]", $iszPtr)
	If @error Then Return SetError(2, 0, "")
	Return SetError(0, $iLen, DllStructGetData($vszString, 1))
EndFunc   ;==>__TCPIpToName_szStringRead
Func _API_Get_NetworkAdapterMAC($sIp)
	Local $MAC, $MACSize
	Local $i, $s, $r, $iIP

	$MAC = DllStructCreate("byte[6]")
	$MACSize = DllStructCreate("int")

	DllStructSetData($MACSize, 1, 6)
	$r = DllCall("Ws2_32.dll", "int", "inet_addr", "str", $sIp)
	$iIP = $r[0]
	$r = DllCall("iphlpapi.dll", "int", "SendARP", "int", $iIP, "int", 0, "ptr", DllStructGetPtr($MAC), "ptr", DllStructGetPtr($MACSize))
	$s = ""
	For $i = 0 To 5
		If $i Then $s = $s & GUICtrlRead($Combo4)
		$s = $s & Hex(DllStructGetData($MAC, 1, $i + 1), 2)
	Next
	If $s = "00:00:00:00:00:00"  Then SetError(1)
	Return $s
EndFunc   ;==>_API_Get_NetworkAdapterMAC
Func _NetworkAdapterInfo()
	Local $colItems = ""
	Local $objWMIService
	Local $NetworkAdapterID = 0
	Local $NetworkAdapterName = ""
	Local $NetworkAdapterGateway = ""
	Local $NetworkAdapterHostName = ""
	Local $NetworkAdapterIPaddress = ""
	Local $NetworkAdapterDNS1 = ""
	Local $NetworkAdapterDNS2 = ""
	Local $NetworkAdapterSubnet = ""
	Local $NetworkAdapterMAC = ""
	Local $NetworkAdapterNetConnectionID = ""
	Local $NetworkAdapterInfo[10][10] ;���10������.
	$NetworkAdapterInfo[0][0] = 0
	$objWMIService = ObjGet("winmgmts:\\localhost\root\CIMV2")
	$colItems = $objWMIService.ExecQuery("SELECT * FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled != 0", "WQL", 0x10 + 0x20)
	$colItem2 = $objWMIService.ExecQuery('SELECT * FROM Win32_NetworkAdapter WHERE NetConnectionStatus >0', "WQL", 0x10 + 0x20)
	If IsObj($colItems) Then
		For $objItem In $colItems
			$NetworkAdapterName = $objItem.Description
			$NetworkAdapterGateway = $objItem.DefaultIPGateway(0)
			$NetworkAdapterHostName = $objItem.DNSHostName
			$NetworkAdapterIPaddress = $objItem.IPAddress(0)
			$NetworkAdapterDNS1 = $objItem.DNSServerSearchOrder(0)
			$NetworkAdapterDNS2 = $objItem.DNSServerSearchOrder(1)
			$NetworkAdapterSubnet = $objItem.IPSubnet(0)
			$NetworkAdapterMAC = $objItem.MACAddress
			$NetworkAdapterID += 1
			$NetworkAdapterInfo[0][0] = $NetworkAdapterID
			$NetworkAdapterInfo[$NetworkAdapterID][0] = $NetworkAdapterID
			$NetworkAdapterInfo[$NetworkAdapterID][1] = $NetworkAdapterName
			$NetworkAdapterInfo[$NetworkAdapterID][2] = $NetworkAdapterGateway
			$NetworkAdapterInfo[$NetworkAdapterID][3] = $NetworkAdapterHostName
			$NetworkAdapterInfo[$NetworkAdapterID][4] = $NetworkAdapterIPaddress
			$NetworkAdapterInfo[$NetworkAdapterID][5] = $NetworkAdapterDNS1
			$NetworkAdapterInfo[$NetworkAdapterID][6] = $NetworkAdapterDNS2
			$NetworkAdapterInfo[$NetworkAdapterID][7] = $NetworkAdapterSubnet
			$NetworkAdapterInfo[$NetworkAdapterID][8] = $NetworkAdapterMAC
		Next
	Else
		Return $NetworkAdapterInfo
	EndIf

	If IsObj($colItem2) Then
		$NetworkAdapterID = 0
		For $objItem2s In $colItem2
			$NetworkAdapterNetConnectionID = $objItem2s.NetConnectionID
			$NetworkAdapterID += 1
			$NetworkAdapterInfo[$NetworkAdapterID][9] = $NetworkAdapterNetConnectionID
		Next
		Return $NetworkAdapterInfo
	Else
		Return $NetworkAdapterInfo
	EndIf
EndFunc   ;==>_NetworkAdapterInfo
Func WM_NOTIFY($hWndGUI, $MsgID, $WParam, $LParam)
 
        Local $tagNMHDR, $Event, $hWndFrom, $IDFrom
        Local $tagNMHDR = DllStructCreate("int;int;int", $LParam)
        If @error Then Return $GUI_RUNDEFMSG
        $IDFrom = DllStructGetData($tagNMHDR, 2)
        $Event = DllStructGetData($tagNMHDR, 3)
        $tagNMHDR = 0
        Switch $IDFrom;ѡ������¼��Ŀؼ�
 
                Case $ListView1
 
                        Switch $Event; ѡ��������¼�

									Case $NM_CLICK ; ���
					                    $Index = _GUICtrlListView_GetSelectedIndices($ListView1)
                                        If Not StringLen($Index) Then; ���������ж��Ƿ�ѡ����ListViewItem
											$List_n=_GUICtrlListView_GetItemCount($ListView1)
													If Not $List_n Then
														GUICtrlSetData($Label1,"��ʾ:��ǰ���κ���������ɨ��")
													EndIf
                                               ;GUICtrlSetData($Label1,"��ʾ:����ѡ�������ٽ�����ز�����û����������ɨ��")
                                                Return
											EndIf
												GUICtrlSetData($Label1,"��ʾ:�����Ҽ�����[�༩����]|[ɾ����ť]|[�������]|[�����༩]")
                                    			GUICtrlSetData($Input1,_GUICtrlListView_GetItemText($ListView1, Number($Index),1))
												GUICtrlSetData($Input2,_GUICtrlListView_GetItemText($ListView1, Number($Index),2))
												GUICtrlSetData($Input3,_GUICtrlListView_GetItemText($ListView1, Number($Index),0))
												GUICtrlSetData($Combo1,_GUICtrlListView_GetItemText($ListView1, Number($Index),3))
												GUICtrlSetData($Input5,_GUICtrlListView_GetItemText($ListView1, Number($Index),4))
												GUICtrlSetData($Input6,_GUICtrlListView_GetItemText($ListView1, Number($Index),5))
												GUICtrlSetData($Input7,_GUICtrlListView_GetItemText($ListView1, Number($Index),6))
												GUICtrlSetData($Input8,_GUICtrlListView_GetItemText($ListView1, Number($Index),7))
												GUICtrlSetData($Input9,_GUICtrlListView_GetItemText($ListView1, Number($Index),9))
												GUICtrlSetData($Combo2,_GUICtrlListView_GetItemText($ListView1, Number($Index),8))
												GUICtrlSetData($Combo3,_GUICtrlListView_GetItemText($ListView1, Number($Index),10))									
                                 Case $NM_DBLCLK ; ˫��
					                    $Index = _GUICtrlListView_GetSelectedIndices($ListView1)
                                        If Not StringLen($Index) Then; ���������ж��Ƿ�ѡ����ListViewItem
                                               GUICtrlSetData($Label1,"��ʾ:����ѡ�������ٽ�����ز�����û����������ɨ��")
                                                Return
											EndIf
											GUICtrlSetData($Label1,"��ʾ:�����Ҽ�����[�༩����]|[ɾ����ť]|[�������]|[�����༩]")
                                    			GUICtrlSetData($Input1,_GUICtrlListView_GetItemText($ListView1, Number($Index),1))
												GUICtrlSetData($Input2,_GUICtrlListView_GetItemText($ListView1, Number($Index),2))
												GUICtrlSetData($Input3,_GUICtrlListView_GetItemText($ListView1, Number($Index),0))
												GUICtrlSetData($Combo1,_GUICtrlListView_GetItemText($ListView1, Number($Index),3))
												GUICtrlSetData($Input5,_GUICtrlListView_GetItemText($ListView1, Number($Index),4))
												GUICtrlSetData($Input6,_GUICtrlListView_GetItemText($ListView1, Number($Index),5))
												GUICtrlSetData($Input7,_GUICtrlListView_GetItemText($ListView1, Number($Index),6))
												GUICtrlSetData($Input8,_GUICtrlListView_GetItemText($ListView1, Number($Index),7))
												GUICtrlSetData($Input9,_GUICtrlListView_GetItemText($ListView1, Number($Index),9))
												GUICtrlSetData($Combo2,_GUICtrlListView_GetItemText($ListView1, Number($Index),8))
												GUICtrlSetData($Combo3,_GUICtrlListView_GetItemText($ListView1, Number($Index),10))									
                                Case $NM_RCLICK ; �һ�
;~                                         ...
                        EndSwitch
 
        EndSwitch
 
        Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY
Func _del()
			$Index = _GUICtrlListView_GetSelectedIndices($ListView1)
			If Not StringLen($Index) Then
				GUICtrlSetData($Label1,"��ʾ:��ѡ����ٽ���ɾ������!")
				Else
			_GUICtrlListView_DeleteItem(GUICtrlGetHandle($ListView1), $Index)
			GUICtrlSetData($Label1,"��ʾ:ɾ���ɹ�!")
		EndIf
EndFunc		

Func _del2()
			$Index1 = _GUICtrlListView_GetSelectedIndices($ListView2)
			If Not StringLen($Index1) Then
				GUICtrlSetData($Label1,"��ʾ:��ѡ����ٽ���ɾ������!")
				Else
			$l2name=_GUICtrlListView_GetItemText($ListView2, Number($Index1),0)
			_GUICtrlListView_DeleteItem(GUICtrlGetHandle($ListView2), $Index1)
			IniDelete($ini,"���ӳ���",$l2name)
			GUICtrlSetData($Label1,"��ʾ:���ӳ����б�"&$l2name&"��ɾ���ɹ�!")
		EndIf
EndFunc

Func _save()
       $List_n=_GUICtrlListView_GetItemCount($ListView1)
		If Not $List_n Then
				GUICtrlSetData($Label1,"����:����ɨ���֮���ٵ���б�񱣴棡����")
			Else
				IniWrite($ini, "ɨ����ʾ", "���ɨ��ʱ��", _
				StringFormat("%4d-%1d-%1d %1d:%02d:%02d", @YEAR, @MON, @MDAY, @HOUR, @MIN, @SEC)&@crlf)
					For $i = 0 To $List_n - 1
			            $MacItem = _GUICtrlListView_GetItemTextArray($ListView1, $i)
							If $MacItem[0] <> 11 Then ContinueLoop
							IniWrite($ini, "Maclist", $MacItem[1], $MacItem[2] & "|" & $MacItem[3] & "|" & $MacItem[4] & "|" & $MacItem[5] & "|" & $MacItem[6] & "|" & $MacItem[7] & "|" & $MacItem[8] & "|" & $MacItem[9] & "|" & $MacItem[10] & "|" & $MacItem[11])
					Next
			          GUICtrlSetData($Label1,"��ʾ:�������ݱ������!��"&$List_n&"����Ϣ")
		EndIf
EndFunc				  

Func _sm()
			Switch GUICtrlRead($Button1)
				Case 1
					$ws=$aIP1[3]-$aIP0[3]+1
					_GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($ListView1))
					TCPStartup()
					;���壺������IP����
					Local $iStep = 1, $gross, $n = 0
					$gross = $aIP0[3] - $aIP1[3]
					If $gross > 0 Then
						$iStep = -1
					Else
						$gross = Abs($gross)
					EndIf
					$gross += 1
					$aIP0[3] -= $iStep
					Do
						$aIP0[3] += $iStep 
							GUICtrlSetData($Progress1, Int(100 * ($gross - Abs($aIP1[3] - $aIP0[3])) / $gross));�������ٷֵ�
						$nIP = $aIP0[0] & "." & $aIP0[1] & "." & $aIP0[2] & "." & $aIP0[3]
						
						Ping($nIP, 5)
						If @error Then ContinueLoop
						$nHost = __TCPIpToName($nIP)
						$nMAC = _API_Get_NetworkAdapterMAC($nIP)
						If  @error Or Not $nHost Then ContinueLoop
						_GUICtrlListView_AddItem ($ListView1, $nMAC, $n)
						_GUICtrlListView_AddSubItem ($ListView1, $n, $nHost, 1, 1)
						_GUICtrlListView_AddSubItem ($ListView1, $n, $nIP, 2, 2)
						_GUICtrlListView_AddSubItem ($ListView1, $n, GUICtrlRead($Input5), 4, 4)
						_GUICtrlListView_AddSubItem ($ListView1, $n, GUICtrlRead($Combo1), 3, 3)
						_GUICtrlListView_AddSubItem ($ListView1, $n, GUICtrlRead($Input6), 5, 5)
						_GUICtrlListView_AddSubItem ($ListView1, $n, GUICtrlRead($Input7), 6, 6)
						_GUICtrlListView_AddSubItem ($ListView1, $n, GUICtrlRead($Input8), 7, 7)
						_GUICtrlListView_AddSubItem ($ListView1, $n, GUICtrlRead($Combo2), 8, 8)
						_GUICtrlListView_AddSubItem ($ListView1, $n, GUICtrlRead($Input9), 9, 9)
						_GUICtrlListView_AddSubItem ($ListView1, $n, GUICtrlRead($Combo3), 10, 10)
						
						$n += 1
						GUICtrlSetData($Label1,"����ɨ����,���Ժ򡭡� ["&$n&"/"&$ws&"]"&"  ��ǰIP:"&$nIP)
						;$ip4 =StringRegExpReplace(GUICtrlRead($IPAddress2),'(\d+\.){3}', '')
					Until GUICtrlRead($Button1) <> 1 Or $aIP0[3] = $aIP1[3]
					TCPStartup()
					GUICtrlSetState($Button1, 4)
					GUICtrlSetData($Progress1, 0)
				Case Else
					GUICtrlSetData($Progress1, 0)
			EndSwitch
					GUICtrlSetData($Label1,"��ʾ:[ɨ�����] һ��:"&$ws&"�� ���:"&$ws&"�� "&"�ɹ�:["&$n&"]�� ʧ��:["&$ws-$n&"]��")	
EndFunc				
				
Func _Default();����Ĭ�������ļ�
	MsgBox(48,"��ܰ������:", "δ�ҵ����������ļ�,�����Զ�����."& @CRLF &"��ʹ�÷���˹���ɨ��������Ϣ.",2)
	IniWrite($ini , "��Ȩ��Ϣ", "����QQ","472891322")
    IniWrite($ini , "��Ȩ��Ϣ", "E-mail","jycel@qq.com")
	IniWrite($ini, "��Ȩ��Ϣ", "���߿ռ�","http://472891322.qzone.qq.com/"&@CRLF)
	IniWrite($ini, "����", "����ʱ��","30")
	IniWrite($ini, "����", "��������","DEV_8139")
	IniWrite($ini, "����", "IE��ҳ","http://v.tfol.com/netbar.htm")
	IniWrite($ini, "����", "IE����","�w��W�j-������������!")
	IniWrite($ini, "����", "IE״̬����Ϣ","��ӭ�����w��W�j TEL:0816-2624067 ����QQ:472891322"&@CRLF)
	IniWrite($ini, "Maclist", "mac","����|IP")
	IniWrite($ini, "Maclist", "00-E0-61-15-C5-43", "A001|192.168.0.11|IP����|255.255.255.0|192.168.0.1|202.98.96.68|61.139.2.69|1440*900*32*75|��ά��ʦ|����")
	IniWrite($ini, "Maclist", "00-1D-0F-24-66-1E", "NetGame|192.168.0.254"&@CRLF)
	IniWrite($ini, "ʹ��˵��", "ʹ��˵��", "������ֻ֧������IP,����ϸ������,�޸Ķ�ӦIP����,��������ѯQQ472891322"&@CRLF)
	IniWrite($ini, "�ֱ���", "1024*768*32*85", "�˴���Ҫ��д������ֻ��ǰ��ؼ��֣����޸���������")
	IniWrite($ini, "�ֱ���", "1440*900*32*75", "ͬ��")
	IniWrite($ini, "�ֱ���", "1680*1050*32*75", "ͬ��"&@CRLF)
	IniWrite($ini, "Runlist", "��������", "")	
	IniWrite($ini, "Runlist", "�����Ż�", ""&@CRLF)	
	IniWrite($ini, "���ӳ���", "��������", ""&@CRLF)		
	IniWrite($ini, "Cs15Key", "1","6801563651288")
	IniWrite($ini, "Cs15Key", "2","3294345689725")
	IniWrite($ini, "Cs15Key", "3","2292823454228")
	IniWrite($ini, "Cs15Key", "4","7842715618877")
	IniWrite($ini, "Cs15Key", "5","3865568763903")
	IniWrite($ini, "Cs15Key", "6","5013955315983")
	IniWrite($ini, "Cs15Key", "7","3094945136861")
	IniWrite($ini, "Cs15Key", "8","2726631268402")
	IniWrite($ini, "Cs15Key", "9","1421339652155")
	IniWrite($ini, "Cs15Key", "10","2293026703085")
	IniWrite($ini, "Cs15Key", "11","1977560827768")
	IniWrite($ini, "Cs15Key", "12","2996620270749")
	IniWrite($ini, "Cs15Key", "13","0072430366426")
	IniWrite($ini, "Cs15Key", "14","7893392675840")
	IniWrite($ini, "Cs15Key", "15","2623436581467")
	IniWrite($ini, "Cs15Key", "16","2367234335487")
	IniWrite($ini, "Cs15Key", "17","5899430794142")
	IniWrite($ini, "Cs15Key", "18","6373906794557")
	IniWrite($ini, "Cs15Key", "19","0186166087129")
	IniWrite($ini, "Cs15Key", "20","9309282185282")
	IniWrite($ini, "Cs15Key", "21","9942810937876")
	IniWrite($ini, "Cs15Key", "22","2702926069367")
	IniWrite($ini, "Cs15Key", "23","2873922711009")
	IniWrite($ini, "Cs15Key", "24","3182452724788")
	IniWrite($ini, "Cs15Key", "25","2881320716061")
	IniWrite($ini, "Cs15Key", "26","3882348620722")
	IniWrite($ini, "Cs15Key", "27","2498521763020")
	IniWrite($ini, "Cs15Key", "28","9745406730972")
	IniWrite($ini, "Cs15Key", "29","3995846325049")
	IniWrite($ini, "Cs15Key", "30","3990645369061")
	IniWrite($ini, "Cs15Key", "31","3881442673780")
	IniWrite($ini, "Cs15Key", "32","4722953384569")
	IniWrite($ini, "Cs15Key", "33","5991335738183")
	IniWrite($ini, "Cs15Key", "34","0943252509979")
	IniWrite($ini, "Cs15Key", "35","0057329934856")
	IniWrite($ini, "Cs15Key", "36","7597026797903")
	IniWrite($ini, "Cs15Key", "37","1509899106786")
	IniWrite($ini, "Cs15Key", "38","9080368774300")
	IniWrite($ini, "Cs15Key", "39","2306437281560")
	IniWrite($ini, "Cs15Key", "40","8047751630688")
	IniWrite($ini, "Cs15Key", "41","2572265422347")
	IniWrite($ini, "Cs15Key", "42","2897524202721")
	IniWrite($ini, "Cs15Key", "43","9525803960507")
	IniWrite($ini, "Cs15Key", "44","3896321644454")
	IniWrite($ini, "Cs15Key", "45","2575508916775")
	IniWrite($ini, "Cs15Key", "46","3832845609762")
	IniWrite($ini, "Cs15Key", "47","5109677149369")
	IniWrite($ini, "Cs15Key", "48","2007224885708")
	IniWrite($ini, "Cs15Key", "49","2304525119809")
	IniWrite($ini, "Cs15Key", "50","0700233570541")
	IniWrite($ini, "Cs15Key", "51","3892248363021")
	IniWrite($ini, "Cs15Key", "52","3049152178425")
	IniWrite($ini, "Cs15Key", "53","0143005967914")
	IniWrite($ini, "Cs15Key", "54","5895638781104")
	IniWrite($ini, "Cs15Key", "55","5512355833199")
	IniWrite($ini, "Cs15Key", "56","2348134376448")
	IniWrite($ini, "Cs15Key", "57","3005789616110")
	IniWrite($ini, "Cs15Key", "58","2492629725023")
	IniWrite($ini, "Cs15Key", "59","7169336493198")
	IniWrite($ini, "Cs15Key", "60","5498338402186")
	IniWrite($ini, "Cs15Key", "61","2810029507117")
	IniWrite($ini, "Cs15Key", "62","8295771797102")
	IniWrite($ini, "Cs15Key", "63","1320904578028")
	IniWrite($ini, "Cs15Key", "64","5531764511342")
	IniWrite($ini, "Cs15Key", "65","5898238712127")
	IniWrite($ini, "Cs15Key", "66","5998632785122")
	IniWrite($ini, "Cs15Key", "67","0514846371932")
	IniWrite($ini, "Cs15Key", "68","0416231170064")
	IniWrite($ini, "Cs15Key", "69","3015038603991")
	IniWrite($ini, "Cs15Key", "70","2120338265425")
	IniWrite($ini, "Cs15Key", "71","9589846712664")
	IniWrite($ini, "Cs15Key", "72","3667588858575")
	IniWrite($ini, "Cs15Key", "73","5464829472848")
	IniWrite($ini, "Cs15Key", "74","2833689982865")
	IniWrite($ini, "Cs15Key", "75","3997145348020")
	IniWrite($ini, "Cs15Key", "76","2494731044643")
	IniWrite($ini, "Cs15Key", "77","1150596958039")
	IniWrite($ini, "Cs15Key", "78","3398042694766")
	IniWrite($ini, "Cs15Key", "79","3799042684746")
	IniWrite($ini, "Cs15Key", "80","2701338554560")
	IniWrite($ini, "Cs15Key", "81","4879687250041")
	IniWrite($ini, "Cs15Key", "82","2128042478263")
	IniWrite($ini, "Cs15Key", "83","3578243538587")
	IniWrite($ini, "Cs15Key", "84","3096244508581")
	IniWrite($ini, "Cs15Key", "85","4336435699588")
	IniWrite($ini, "Cs15Key", "86","2317233759548")
	IniWrite($ini, "Cs15Key", "87","2727132555486")
	IniWrite($ini, "Cs15Key", "88","6996551041203")
	IniWrite($ini, "Cs15Key", "89","0463262884916")
	IniWrite($ini, "Cs15Key", "90","2792231045626")
	IniWrite($ini, "Cs15Key", "91","1154247940716")
	IniWrite($ini, "Cs15Key", "92","2344284682451")
	IniWrite($ini, "Cs15Key", "93","2146333363483")
	IniWrite($ini, "Cs15Key", "94","7040402632368")
	IniWrite($ini, "Cs15Key", "95","5555142687861")
	IniWrite($ini, "Cs15Key", "96","3922648525588")
	IniWrite($ini, "Cs15Key", "97","2498020435749")
	IniWrite($ini, "Cs15Key", "98","8039436549949")
	IniWrite($ini, "Cs15Key", "99","2696734026608")
	IniWrite($ini, "Cs15Key", "100","2396032072643")
	IniWrite($ini, "Cs15Key", "101","5634030696618")
	IniWrite($ini, "Cs15Key", "102","8362321875446")
	IniWrite($ini, "Cs15Key", "103","9748585333927")
	IniWrite($ini, "Cs15Key", "104","9539130852949")
	IniWrite($ini, "Cs15Key", "105","9724143611498")
	IniWrite($ini, "Cs15Key", "106","9035730237150")
	IniWrite($ini, "Cs15Key", "107","1765628747642")
	IniWrite($ini, "Cs15Key", "108","8267335625064")
	IniWrite($ini, "Cs15Key", "109","9872308440938")
	IniWrite($ini, "Cs15Key", "110","0040945670291")
	IniWrite($ini, "Cs15Key", "111","7437120445097")
	IniWrite($ini, "Cs15Key", "112","2914557016520")
	IniWrite($ini, "Cs15Key", "113","5201939075592")
	IniWrite($ini, "Cs15Key", "114","7023459460265")
	IniWrite($ini, "Cs15Key", "115","0004084032358")
	IniWrite($ini, "Cs15Key", "116","2579488650504")
	IniWrite($ini, "Cs15Key", "117","1435403495605")
	IniWrite($ini, "Cs15Key", "118","5722891164576")
	IniWrite($ini, "Cs15Key", "119","5812923357220")
	IniWrite($ini, "Cs15Key", "120","0684570142794")
	IniWrite($ini, "Cs15Key", "121","9051295359780")
	IniWrite($ini, "Cs15Key", "122","0766160464649")
	IniWrite($ini, "Cs15Key", "123","6023089585711")
	IniWrite($ini, "Cs15Key", "124","7282726715071")
	IniWrite($ini, "Cs15Key", "125","6965198320844")
	IniWrite($ini, "Cs15Key", "126","0590638349985")
	IniWrite($ini, "Cs15Key", "127","4887920308855")
	IniWrite($ini, "Cs15Key", "128","6224273676938")
	IniWrite($ini, "Cs15Key", "129","0234070701672")
	IniWrite($ini, "Cs15Key", "130","6829133462999")
	IniWrite($ini, "Cs15Key", "131","1514397024359")
	IniWrite($ini, "Cs15Key", "132","0338114504295")
	IniWrite($ini, "Cs15Key", "133","9180097837863")
	IniWrite($ini, "Cs15Key", "134","5695926015450")
	IniWrite($ini, "Cs15Key", "135","3160620118964")
	IniWrite($ini, "Cs15Key", "136","1190096475687")
	IniWrite($ini, "Cs15Key", "137","8359933291311")
	IniWrite($ini, "Cs15Key", "138","2696985056117")
	IniWrite($ini, "Cs15Key", "139","7853809758364")
	IniWrite($ini, "Cs15Key", "140","2111724559521")
	IniWrite($ini, "Cs15Key", "141","0578332166402")
	IniWrite($ini, "Cs15Key", "142","5735257958665")
	IniWrite($ini, "Cs15Key", "143","7914860615387")
	IniWrite($ini, "Cs15Key", "144","4063606421917")
	IniWrite($ini, "Cs15Key", "145","3419830076512")
	IniWrite($ini, "Cs15Key", "146","7381489152175")
	IniWrite($ini, "Cs15Key", "147","1628431817077")
	IniWrite($ini, "Cs15Key", "148","2876552803407")
	IniWrite($ini, "Cs15Key", "149","8856983770314")
	IniWrite($ini, "Cs15Key", "150","7530358675181")
	IniWrite($ini, "Cs15Key", "151","5174560117316")
	IniWrite($ini, "Cs15Key", "152","7322581102730")
	IniWrite($ini, "Cs15Key", "153","0719965552707")
	IniWrite($ini, "Cs15Key", "154","5620798081913")
	IniWrite($ini, "Cs15Key", "155","3185381184427")
	IniWrite($ini, "Cs15Key", "156","8680457335754")
	IniWrite($ini, "Cs15Key", "157","9869960983369")
	IniWrite($ini, "Cs15Key", "158","6915151587317")
	IniWrite($ini, "Cs15Key", "159","1272066388570")
	IniWrite($ini, "Cs15Key", "160","9301433546382")
	IniWrite($ini, "Cs15Key", "161","5817471724979")
	IniWrite($ini, "Cs15Key", "162","7946642797514")
	IniWrite($ini, "Cs15Key", "163","3926072554435")
	IniWrite($ini, "Cs15Key", "164","9956746016428")
	IniWrite($ini, "Cs15Key", "165","0590651353471")
	IniWrite($ini, "Cs15Key", "166","1714170985947")
	IniWrite($ini, "Cs15Key", "167","5499802054656")
	IniWrite($ini, "Cs15Key", "168","1163480853697")
	IniWrite($ini, "Cs15Key", "169","3739923265822")
	IniWrite($ini, "Cs15Key", "170","3354655249230")
	IniWrite($ini, "Cs15Key", "171","1204514178341")
	IniWrite($ini, "Cs15Key", "172","8144711732971")
	IniWrite($ini, "Cs15Key", "173","8451579776433")
	IniWrite($ini, "Cs15Key", "174","8206536922064")
	IniWrite($ini, "Cs15Key", "175","7267404852062")
	IniWrite($ini, "Cs15Key", "176","6365487067597")
	IniWrite($ini, "Cs15Key", "177","4919689608720")
	IniWrite($ini, "Cs15Key", "178","2960547428824")
	IniWrite($ini, "Cs15Key", "179","0504759069059")
	IniWrite($ini, "Cs15Key", "180","3050776320471")
	IniWrite($ini, "Cs15Key", "181","0694888961606")
	IniWrite($ini, "Cs15Key", "182","9655746791606")
	IniWrite($ini, "Cs15Key", "183","9610972107773")
	IniWrite($ini, "Cs15Key", "184","7937556243769")
	IniWrite($ini, "Cs15Key", "185","5898414073778")
	IniWrite($ini, "Cs15Key", "186","8334441434100")
	IniWrite($ini, "Cs15Key", "187","5988643975322")
	IniWrite($ini, "Cs15Key", "188","3522855506549")
	IniWrite($ini, "Cs15Key", "189","2721837712087")
	IniWrite($ini, "Cs15Key", "190","0375939353208")
	IniWrite($ini, "Cs15Key", "191","8326908182312")
	IniWrite($ini, "Cs15Key", "192","0058411868073")
	IniWrite($ini, "Cs15Key", "193","7386866002317")
	IniWrite($ini, "Cs15Key", "194","9415036075966")
	IniWrite($ini, "Cs15Key", "195","9415034784963")
	IniWrite($ini, "Cs15Key", "196","9268017928447")
	IniWrite($ini, "Cs15Key", "197","2554301377411")
	IniWrite($ini, "Cs15Key", "198","6199709193805")
	IniWrite($ini, "Cs15Key", "199","6595690064434")
	IniWrite($ini, "Cs15Key", "200","8764101331054")
	IniWrite($ini, "Cs15Key", "201","8695699602249")
	IniWrite($ini, "Cs15Key", "202","3953514404409")
	IniWrite($ini, "Cs15Key", "203","6308441865835")
	IniWrite($ini, "Cs15Key", "204","5438918032640")
	IniWrite($ini, "Cs15Key", "205","3567485290466")
	IniWrite($ini, "Cs15Key", "206","8052441431786")
EndFunc

Func _jz()
	GUICtrlSetState($Input1,$GUI_DISABLE)
	GUICtrlSetState($Input2,$GUI_DISABLE)
	GUICtrlSetState($Combo1,$GUI_DISABLE)
	GUICtrlSetState($Input5,$GUI_DISABLE)
	GUICtrlSetState($Input6,$GUI_DISABLE)
	GUICtrlSetState($Input7,$GUI_DISABLE)
	GUICtrlSetState($Input8,$GUI_DISABLE)
	GUICtrlSetState($Combo2,$GUI_DISABLE)
	GUICtrlSetState($Input9,$GUI_DISABLE)
	GUICtrlSetState($Input10,$GUI_DISABLE)
	GUICtrlSetState($Combo3,$GUI_DISABLE)
EndFunc	
Func _jc()
	GUICtrlSetState($Input1,$GUI_ENABLE)
	GUICtrlSetState($Input2,$GUI_ENABLE)
	GUICtrlSetState($Combo1,$GUI_ENABLE)
	GUICtrlSetState($Input5,$GUI_ENABLE)
	GUICtrlSetState($Input6,$GUI_ENABLE)
	GUICtrlSetState($Input7,$GUI_ENABLE)
	GUICtrlSetState($Input8,$GUI_ENABLE)
	GUICtrlSetState($Combo2,$GUI_ENABLE)
	GUICtrlSetState($Input9,$GUI_ENABLE)
	GUICtrlSetState($Input10,$GUI_ENABLE)
	GUICtrlSetState($Combo3,$GUI_ENABLE)
EndFunc

Func _dulist2()
;=================��ȡ�����ļ��еĸ��ӳ������б���=================================
Dim $yylist=IniReadSection($ini,"���ӳ���")
If @error Then
	GUICtrlSetData($Label1,"��ʾ:���ӳ����б��ȡʧ�ܣ�ԭ��:δ�ҵ�������ݣ�")
	Else
For $l = 1 to $yylist[0][0]
    GUICtrlCreateListViewItem($yylist[$l][0], $ListView2)
next
EndIf
;=================��ȡ�����ļ��еĸ��ӳ������б���=================================
EndFunc
Func _savelist2();�����б���е����������������ļ���
			IniDelete($ini,"���ӳ���")
			$List2=_GUICtrlListView_GetItemCount($ListView2);ȡ����
				If Not $List2 Then
						GUICtrlSetData($Label1,"����:��δ����κθ��ӳ�������Ӻ��ٱ��棡")
				Else
						For $i = 0 To $List2 - 1
							$MacItem = _GUICtrlListView_GetItemTextArray($ListView2, $i)
							IniWrite($ini, "���ӳ���", $MacItem[1],"")
						Next
							GUICtrlSetData($Label1,"��ʾ:��Ӳ�����ɹ�!��"&$List2&"������")
				EndIf
EndFunc

Func _Runlist()
$Runlists = IniReadSection($ini, "Runlist")
For $R = 1 To $Runlists[0][0]
	GUICtrlSetData($Combo5,$Runlists[$R][0],$Runlists[1][0])
Next
EndFunc