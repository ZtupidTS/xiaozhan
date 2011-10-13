#include <GuiListView.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <ListViewConstants.au3>
Opt("TrayMenuMode", 1)
GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
$dir = @ScriptDir & "\config.ini"
GUICreate("ListView������", 280, 270)
$ListView1 = GUICtrlCreateListView("�˺�           |����           |", 10, 10, 260, 150)
$But1 = GUICtrlCreateButton("���", 185, 178, 75, 25, $WS_GROUP)
$Input1 = GUICtrlCreateInput("", 60, 180, 120, 21)
$Input2 = GUICtrlCreateInput("", 60, 220, 120, 21)
GUICtrlCreateLabel("�˺ţ�", 20, 183, 36, 17)
GUICtrlCreateLabel("���룺", 20, 223, 36, 17)
GUICtrlCreateLabel("����", 200, 223, 36, 17)
$Label1 = GUICtrlCreateLabel("0", 230, 223, 36, 17)

;�Ҽ��˵�
$zhucaidan = GUICtrlCreateContextMenu($ListView1)
$add = GUICtrlCreateMenuItem("�������", $zhucaidan)
GUICtrlCreateMenuItem("", $zhucaidan)
$del = GUICtrlCreateMenuItem("ɾ������", $zhucaidan)
GUICtrlCreateMenuItem("", $zhucaidan)
$break = GUICtrlCreateMenuItem("ˢ������", $zhucaidan)
GUISetState(@SW_SHOW)
read()

While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
                Case - 3
                        Exit
                Case $But1, $add
                        add(GUICtrlRead($Input1), GUICtrlRead($Input2), GUICtrlRead($Label1))
                Case $del
                        Del()
                Case $break
                        read()
        EndSwitch
WEnd

Func read($z = 0)
        _GUICtrlListView_DeleteAllItems($ListView1)
        $read = IniReadSection($dir, "config")
        If Not @error Then
                For $i = 1 To $read[0][0]
                        GUICtrlCreateListViewItem($read[$i][0], $ListView1)
                        _GUICtrlListView_AddSubItem($ListView1, $z, $read[$i][1], 1, $z + 1)
                        GUICtrlSetData($Label1, $z + 1)
                        $z += 1
                Next
        EndIf
EndFunc   ;==>Read

Func add($a, $b, $z)
        If $a <> "" And $b <> "" Then
                IniWrite($dir, "config", $a, $b)
                GUICtrlCreateListViewItem($a & '|' & $b, $ListView1)
                MsgBox(0, "��ʾ", " �˺ţ� " & $a & " ���룺 " & $b & " ����ɹ� ")
                GUICtrlSetData($Input1, "")
                GUICtrlSetData($Input2, "")
                GUICtrlSetData($Label1, $z + 1)
                GUICtrlSetState($Input1, $GUI_FOCUS)
        EndIf
EndFunc   ;==>Add

Func Del()
        $a = _GUICtrlListView_GetSelectedIndices($ListView1)
        $b = _GUICtrlListView_GetItemTextString($ListView1, Number($a))
        If Not StringLen($a) Then Return
        $chaifen = StringSplit($b, "|")
        
        If MsgBox(32 + 1, "��ʾ", "��ȷ���Ƿ�ɾ����������" & @CRLF & @CRLF & "�˺ţ�" & $chaifen[1] & @CRLF & @CRLF & "���룺" & $chaifen[2]) = 1 Then
                _GUICtrlListView_DeleteItemsSelected($ListView1) ;ɾ��ѡ����Ŀ
                IniDelete($dir, 'config', $chaifen[1])
                $z = _GUICtrlListView_GetItemCount($ListView1)
                GUICtrlSetData($Label1, $z)
                ;MsgBox(48, "��ʾ", "����ɾ���ɹ�")
        EndIf
EndFunc   ;==>Del

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

                                Case $NM_DBLCLK ; ˫��
                                        $Index = _GUICtrlListView_GetSelectedIndices($ListView1)
                                        If Not StringLen($Index) Then Return; ���������ж��Ƿ�ѡ����ListViewItem
                                        _PairsClick()
                                Case $NM_RCLICK ; �һ�
                        EndSwitch
        EndSwitch
        Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY

Func _PairsClick()
        $a = _GUICtrlListView_GetSelectedIndices($ListView1)
        $b = _GUICtrlListView_GetItemTextString($ListView1, Number($a))
        $chaifen = StringSplit($b, "|")
        MsgBox(64, '�����������£�', "�˺ţ�" & $chaifen[1] & @CRLF & @CRLF & "���룺" & $chaifen[2])
EndFunc   ;==>_PairsClick