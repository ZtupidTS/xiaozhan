#NoTrayIcon

#include <GUIListBox.au3>
#Include <GuiListView.au3>
#include <SQLite.au3>
#include <SQLite.dll.au3>

Opt("TrayIconHide", 1)
Opt('MustDeclareVars', 1)
Opt("GUICloseOnESC", 0)

Global $GUI_Form, $Title, $SQLite_Data_Path, $GUI_ListBox
Global $GUI_Input1, $GUI_Input2, $GUI_Input3, $GUI_Input4, $GUI_Input5
Global $GUI_Button1, $GUI_Button2, $GUI_Button3, $GUI_Button4
Global $Msg, $hQuery, $aRow
Global $Temp, $a, $b, $c

$Title = "SQLite操作实例..."

$SQLite_Data_Path = "SQLite.db"

_SQLite_Startup () ;加载 SQLite.dll

If Not FileExists($SQLite_Data_Path) Then
    SQLCreate()
EndIf

$GUI_Form = GUICreate($Title, 300, 435, -1, -1)
GUISetBkColor(0xECE9D8)  ; will change background color

$GUI_ListBox = GUICtrlCreateListView("", 2, 2, 296, 309, 0x0010)
_GUICtrlListView_AddColumn($GUI_ListBox, "编号", 100, 0)
_GUICtrlListView_AddColumn($GUI_ListBox, "姓名", 80, 1)
_GUICtrlListView_AddColumn($GUI_ListBox, "年龄", 80, 1)

GUICtrlCreateLabel("编号         姓名         年龄", 34, 325, 240, 15)

$GUI_Input1 = GUICtrlCreateInput("", 10, 341, 73, 20)
$GUI_Input2 = GUICtrlCreateInput("", 88, 341, 73, 20)
$GUI_Input3 = GUICtrlCreateInput("", 166, 341, 73, 20)
$GUI_Input4 = GUICtrlCreateInput("", 88, 366, 73, 20)
$GUI_Input5 = GUICtrlCreateInput("", 88, 391, 73, 20)

$GUI_Button1 = GUICtrlCreateButton("读取", 246, 315, 48, 22, 0)
$GUI_Button2 = GUICtrlCreateButton("写入", 246, 340, 48, 22, 0)
$GUI_Button3 = GUICtrlCreateButton("查找", 246, 365, 48, 22, 0)
$GUI_Button4 = GUICtrlCreateButton("删除", 246, 390, 48, 22, 0)

GUICtrlCreateGroup("", 2, 307, 296, 107)

GUICtrlCreateLabel("「江西樟树·仅此一仙·QQ:43848058」制作", 32, 419, 240, 15)
GUICtrlSetState(-1, $GUI_DISABLE)

GUISetState()

	While 1

		$Msg = GUIGetMsg()

		Select
			Case $Msg = $GUI_EVENT_CLOSE
	            _SQLite_Shutdown () ;卸载 SQLite.dll
				ExitLoop

			Case $Msg = $GUI_Button1
				SQLiteRead()

			Case $Msg = $GUI_Button2
                SQLiteInsert(GUICtrlRead ($GUI_Input1), GUICtrlRead ($GUI_Input2), GUICtrlRead ($GUI_Input3))
                SQLiteRead()

			Case $Msg = $GUI_Button3
                SQLiteSelect(GUICtrlRead ($GUI_Input4))

			Case $Msg = $GUI_Button4
				SQLiteDelete(GUICtrlRead ($GUI_Input5))
                SQLiteRead()

		EndSelect
		
	WEnd

Func SQLCreate()
    _SQLite_Open ($SQLite_Data_Path)
    _SQLite_Exec(-1, "Create Table IF NOT Exists TestTable (IDs Text PRIMARY KEY, Name Text, Age Text);")
    _SQLite_Close ()
EndFunc

Func SQLiteRead()
	_GUICtrlListView_DeleteAllItems ( GUICtrlGetHandle ($GUI_ListBox) )
    _SQLite_Open ($SQLite_Data_Path)
    _SQLite_Query(-1, "SELECT * FROM TestTable ORDER BY IDs DESC;",$hQuery)
	While _SQLite_FetchData ($hQuery, $aRow) = $SQLITE_OK
        _GUICtrlListView_AddItem($GUI_ListBox, $aRow[0])
        _GUICtrlListView_AddSubItem($GUI_ListBox, _GUICtrlListView_FindInText($GUI_ListBox, $aRow[0]), $aRow[1], 1)
        _GUICtrlListView_AddSubItem($GUI_ListBox, _GUICtrlListView_FindInText($GUI_ListBox, $aRow[0]), $aRow[2], 2)
    WEnd
    _SQLite_Close ()
EndFunc

Func SQLiteInsert($a, $b, $c)
    _SQLite_Open ($SQLite_Data_Path)
	_SQLite_QuerySingleRow(-1, "SELECT IDs FROM TestTable WHERE IDs = '" & $a & "';", $aRow)
    $Temp = $aRow[0]
	If $Temp = "" Then
		_SQLite_Exec(-1, "Insert into TestTable (IDs) values ('" & $a & "');")
	EndIf
	_SQLite_Exec(-1, "UPDATE TestTable SET Name = '" & $b & "' WHERE IDs = '" & $a & "';")
    _SQLite_Exec(-1, "UPDATE TestTable SET Age = '" & $c & "' WHERE IDs = '" & $a & "';")
    _SQLite_Close ()
EndFunc

Func SQLiteSelect($a)
    _SQLite_Open ($SQLite_Data_Path)
	_SQLite_QuerySingleRow(-1, "SELECT * FROM TestTable WHERE Name = '" & $a & "';", $aRow)
    $Temp = $aRow[0]
	If $Temp = "" Then
		MsgBox(262208, "查找结果...", "数据库中姓名为 [" & $a & "] 的员工记录不存在！")
    Else
		_GUICtrlListView_DeleteAllItems ( GUICtrlGetHandle ($GUI_ListBox) )
        _GUICtrlListView_AddItem($GUI_ListBox, $aRow[0])
        _GUICtrlListView_AddSubItem($GUI_ListBox, _GUICtrlListView_FindInText($GUI_ListBox, $aRow[0]), $aRow[1], 1)
        _GUICtrlListView_AddSubItem($GUI_ListBox, _GUICtrlListView_FindInText($GUI_ListBox, $aRow[0]), $aRow[2], 2)
        MsgBox(262208, "查找结果...", "找到记录: 编号[" & $aRow[0] & "] 姓名[" & $aRow[1] & "] 年龄[" & $aRow[2] & "] ！")
	EndIf
    _SQLite_Close ()
EndFunc

Func SQLiteDelete($a)
    _SQLite_Open ($SQLite_Data_Path)
    _SQLite_Exec(-1, "DELETE FROM  TestTable WHERE Name = '" & $a & "';")
    _SQLite_Close ()
	MsgBox(262208, "删除记录...", "删除数据库中姓名为 [" & $a & "] 的员工记录！")
EndFunc