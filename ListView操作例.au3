#include <GuiListView.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <ListViewConstants.au3>
Opt("TrayMenuMode", 1)
GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
$dir = @ScriptDir & "\config.ini"
GUICreate("ListView操作例", 280, 270)
$ListView1 = GUICtrlCreateListView("账号           |密码           |", 10, 10, 260, 150)
$But1 = GUICtrlCreateButton("添加", 185, 178, 75, 25, $WS_GROUP)
$Input1 = GUICtrlCreateInput("", 60, 180, 120, 21)
$Input2 = GUICtrlCreateInput("", 60, 220, 120, 21)
GUICtrlCreateLabel("账号：", 20, 183, 36, 17)
GUICtrlCreateLabel("密码：", 20, 223, 36, 17)
GUICtrlCreateLabel("数据", 200, 223, 36, 17)
$Label1 = GUICtrlCreateLabel("0", 230, 223, 36, 17)

;右键菜单
$zhucaidan = GUICtrlCreateContextMenu($ListView1)
$add = GUICtrlCreateMenuItem("添加数据", $zhucaidan)
GUICtrlCreateMenuItem("", $zhucaidan)
$del = GUICtrlCreateMenuItem("删除数据", $zhucaidan)
GUICtrlCreateMenuItem("", $zhucaidan)
$break = GUICtrlCreateMenuItem("刷新数据", $zhucaidan)
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
                MsgBox(0, "提示", " 账号： " & $a & " 密码： " & $b & " 保存成功 ")
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
        
        If MsgBox(32 + 1, "提示", "请确认是否删除以下数据" & @CRLF & @CRLF & "账号：" & $chaifen[1] & @CRLF & @CRLF & "密码：" & $chaifen[2]) = 1 Then
                _GUICtrlListView_DeleteItemsSelected($ListView1) ;删除选定项目
                IniDelete($dir, 'config', $chaifen[1])
                $z = _GUICtrlListView_GetItemCount($ListView1)
                GUICtrlSetData($Label1, $z)
                ;MsgBox(48, "提示", "数据删除成功")
        EndIf
EndFunc   ;==>Del

Func WM_NOTIFY($hWndGUI, $MsgID, $WParam, $LParam)
        Local $tagNMHDR, $Event, $hWndFrom, $IDFrom
        Local $tagNMHDR = DllStructCreate("int;int;int", $LParam)
        If @error Then Return $GUI_RUNDEFMSG
        $IDFrom = DllStructGetData($tagNMHDR, 2)
        $Event = DllStructGetData($tagNMHDR, 3)
        $tagNMHDR = 0
        Switch $IDFrom;选择产生事件的控件
                Case $ListView1
                        Switch $Event; 选择产生的事件
                                Case $NM_CLICK ; 左击

                                Case $NM_DBLCLK ; 双击
                                        $Index = _GUICtrlListView_GetSelectedIndices($ListView1)
                                        If Not StringLen($Index) Then Return; 这里用以判断是否选定了ListViewItem
                                        _PairsClick()
                                Case $NM_RCLICK ; 右击
                        EndSwitch
        EndSwitch
        Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY

Func _PairsClick()
        $a = _GUICtrlListView_GetSelectedIndices($ListView1)
        $b = _GUICtrlListView_GetItemTextString($ListView1, Number($a))
        $chaifen = StringSplit($b, "|")
        MsgBox(64, '本行数据如下：', "账号：" & $chaifen[1] & @CRLF & @CRLF & "密码：" & $chaifen[2])
EndFunc   ;==>_PairsClick