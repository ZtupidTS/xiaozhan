#include <ButtonConstants.au3>
#include <GUIConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Include <GuiListView.au3>
#include <ListViewConstants.au3>
#include <GuiImageList.au3>

Opt('GUIResizeMode', 802)

$Version = "QQLoginV2.0_By_5i3p"
If WinExists($Version) Then Exit
AutoItWinSetTitle($Version)

;_CreatIni()        
Global $NumList[2], $List1, $List2
$IniFile = @ScriptDir&"\Config.ini"
$Window = GUICreate("QQ�Զ���¼��", 367, 300, 192, 114)
GUICtrlCreateGroup("��ѡ����Ҫ��½��QQ����:", 4, 8, 361, 289)
$List1 = GUICtrlCreateListView("      IP��ַ   |�ǳ�        |�ϴε�½ʱ��", 10, 32, 245, 233)
GUICtrlSendMsg($List1, $LVM_SETEXTENDEDLISTVIEWSTYLE, $LVS_EX_GRIDLINES, $LVS_EX_GRIDLINES)
GUICtrlSetTip(-1, "ˢ���б�󣬺�ɫ��ʾ�������ڱ�����½�ĺ���")
Dim $B_DESCENDING[_GUICtrlListView_GetColumnCount($List1)]
$Denglu = GUICtrlCreateButton("��½", 268, 26, 83, 25, 0)
$Refresh = GUICtrlCreateButton("ˢ���б�", 268, 60, 83, 25, 0)
$Run = GUICtrlCreateButton("����QQ", 268, 94, 83, 25, 0)
$Set = GUICtrlCreateButton("����", 268, 128, 83, 25, 0)
$ADD = GUICtrlCreateButton("���QQ", 268, 160, 83, 25, 0)
;GUICtrlSetColor(-1, 0x0000FF)
$Close = GUICtrlCreateButton("�ر�����QQ", 268, 192, 83, 25, 0)
$About = GUICtrlCreateButton("����(&A)", 268, 226, 83, 25, 0)
$Exit = GUICtrlCreateButton("�˳�(&X)", 268, 260, 83, 25, 0)
$Check = GUICtrlCreateCheckbox("��½��ɺ�رյ�¼��", 10, 272, 153, 17)
GUICtrlCreateLabel("By: ��ͳ.��", 189, 274, 78, 17)
GUICtrlSetState(-1, $GUI_DISABLE)
GUISetState(@SW_SHOW)

;regwrite

While 1
        $nMsg = GUIGetMsg()
		Switch $nMsg
                Case $GUI_EVENT_CLOSE
                        Exit
	EndSwitch
                        
WEnd