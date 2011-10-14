#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=128.ico
#AutoIt3Wrapper_outfile=登录固定投影宝参数设置.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#include <GUIListBox.au3>
#Include <GuiListView.au3>
#include <SQLite.au3>
#include <SQLite.dll.au3>
Opt("TrayIconHide", 1)
Opt('MustDeclareVars', 1)
Opt("GUICloseOnESC", 0)
Global $Form1, $Title, $SQLite_Data_Path, $GUI_ListBox ,$ListView1 ,$WS_GROUP
Global $Input1, $Input2, $Input3, $Input4, $Input5,$Label1,$Label2,$Label3,$Label4,$Label5,$Label6
Global $Button1, $Button2, $Button3, $Button4,$Button5
Global $Msg, $hQuery, $aRow
Global $Temp, $a, $b, $c
$Title = "SQLite操作实例..."
$SQLite_Data_Path = "SQLite.db"
_SQLite_Startup () ;加载 SQLite.dll
If Not FileExists($SQLite_Data_Path) Then
    SQLCreate()
EndIf

$Form1 = GUICreate("加班记录表", 343, 392, 228, 150)
$ListView1 = GUICtrlCreateListView("加班日期|开始时间|结束时间|加班所用时间|", 18, 10, 310, 150)
GUICtrlSendMsg($ListView1, $LVM_SETEXTENDEDLISTVIEWSTYLE, $LVS_EX_GRIDLINES, $LVS_EX_GRIDLINES)
$Button1 = GUICtrlCreateButton("添加", 249, 178, 75, 25, $WS_GROUP)
$Label3 = GUICtrlCreateLabel("数据", 256, 223, 36, 17)
$Label4 = GUICtrlCreateLabel("0", 286, 223, 44, 17)
$Label1 = GUICtrlCreateLabel("加班日期：", 28, 183, 76, 17)
$Input1 = GUICtrlCreateInput("", 108, 180, 129, 21)
$Label2 = GUICtrlCreateLabel("开始时间：", 28, 223, 68, 17)
$Input2 = GUICtrlCreateInput("", 108, 220, 129, 21)
$Label5 = GUICtrlCreateLabel("结束时间：", 28, 263, 76, 17)
$Input3 = GUICtrlCreateInput("", 108, 260, 129, 21)
$Button2 = GUICtrlCreateButton("查找", 24, 344, 65, 25)
$Button3 = GUICtrlCreateButton("删除列表", 184, 344, 65, 25)
$Button4 = GUICtrlCreateButton("退出", 264, 344, 65, 25)
$Button5 = GUICtrlCreateButton("读取", 104, 344, 65, 25)
GUISetState(@SW_SHOW)



While 1
  $Msg = GUIGetMsg()
  Select
   Case $Msg = $GUI_EVENT_CLOSE
             _SQLite_Shutdown () ;卸载 SQLite.dll
    ExitLoop
   Case $Msg =$Button5
    SQLiteRead()
   Case $Msg = $Button1
                SQLiteInsert(GUICtrlRead ($Input1), GUICtrlRead ($Input2), GUICtrlRead ($Input3))
                SQLiteRead()
   Case $Msg = $Button2
                SQLiteSelect(GUICtrlRead ($Input4))
   Case $Msg = $Button3 
    SQLiteDelete(GUICtrlRead ($Input5))
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



