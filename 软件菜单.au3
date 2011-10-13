#include <Misc.au3>
#include <Array.au3>
#include <Constants.au3>
#include <GuiListView.au3>
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

HotKeySet('{Enter}', 'Enter')
AdlibRegister('Memory', 6000)
Opt("TrayMenuMode", 1)
Opt("GUICloseOnESC", 0)
Opt("TrayOnEventMode", 1)

Global $hListView[6], $hType, $Combo1, $Radio1, $Radio2, $Radio3, $Radio4, $iPage, $id
Global $Dll = DllOpen(@ScriptDir & '\Skin\Skin.dll')
Global Const $WM_DROPFILES = 0x0233
Global $aDroppedFiles[1]
Global $iGroupID
Local $avArray[6] = ['全部', '娱乐', '影音', '办公', '工具', '其他']

$Path = @ScriptDir & '\config1.8.ini'
$hGUI = GUICreate("软件菜单 — Beta 1.8.1", 800, 600, -1, -1, -1, $WS_EX_ACCEPTFILES) ;$WS_OVERLAPPEDWINDOW = 最大化可用

GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
GUIRegisterMsg($WM_DROPFILES, "WM_DROPFILES")
TraySetOnEvent($TRAY_EVENT_PRIMARYUP, "SpecialEvent")

For $i = 0 To 5
        $hListView[$i] = GUICtrlCreateListView("", 115, 5, 680, 500, -1, $WS_EX_CLIENTEDGE)
        GUICtrlSendMsg(-1, $LVM_SETEXTENDEDLISTVIEWSTYLE, $LVS_EX_HEADERDRAGDROP, $LVS_EX_HEADERDRAGDROP)
        GUICtrlSetState(-1, $GUI_DROPACCEPTED)
        GUICtrlSetColor(-1, 0x0080C0);设置控件中的文本色

        $nBkColor = Number(IniRead($Path, 'BkColor', $i, '12639424'))
        _GUICtrlListView_SetColumnWidth($hListView[$i], 0, 200)
        _GUICtrlListView_SetExtendedListViewStyle($hListView[$i], BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_DOUBLEBUFFER))
        _GUICtrlListView_SetBkColor($hListView[$i], $nBkColor);设置控件背景色
        _GUICtrlListView_SetTextBkColor($hListView[$i], $nBkColor);设置控件中文本的背景色
        _GUICtrlListView_SetOutlineColor($hListView[$i], $nBkColor);设置边框色
        _GUICtrlListView_SetView($hListView[$i], 1)
        GUICtrlSetState($hListView[$i], $GUI_HIDE)
Next

$id_LV = $hListView[0]
Switcha($hListView[0], $avArray[0])
GUICtrlSetState($hListView[0], $GUI_SHOW)


$Combo1 = GUICtrlCreateCombo($avArray[1], 60, 540, 80, 21, $CBS_DROPDOWNLIST) ;$CBS_DROPDOWNLIST = 控件不可编辑
GUICtrlSetData(-1, $avArray[2] & '|' & $avArray[3] & '|' & $avArray[4] & '|' & $avArray[5])
$Input1 = GUICtrlCreateInput("", 210, 540, 230, 21)
$Input2 = GUICtrlCreateInput("", 620, 540, 100, 21)

$Buta = GUICtrlCreateButton("添加", 720, 538, 60, 25, $WS_GROUP)
$Butb = GUICtrlCreateButton("浏览", 440, 538, 50, 25, $WS_GROUP)

GUICtrlCreateGroup("", 5, 2, 100, 280)
$But0 = GUICtrlCreateButton($avArray[0], 15, 15, 80, 30, $WS_GROUP)
GUICtrlSetFont(-1, 12, 800)
$id = $But0
$But1 = GUICtrlCreateButton($avArray[1], 15, 60, 80, 30, $WS_GROUP)
$But2 = GUICtrlCreateButton($avArray[2], 15, 105, 80, 30, $WS_GROUP)
$But3 = GUICtrlCreateButton($avArray[3], 15, 150, 80, 30, $WS_GROUP)
$But4 = GUICtrlCreateButton($avArray[4], 15, 195, 80, 30, $WS_GROUP)
$But5 = GUICtrlCreateButton($avArray[5], 15, 240, 80, 30, $WS_GROUP)

GUICtrlCreateGroup("图标排列方式", 5, 300, 100, 135)
$Radio1 = GUICtrlCreateRadio("大 图 标", 20, 325, 68, 17)
$Radio2 = GUICtrlCreateRadio("小 图 标", 20, 350, 68, 17)
$Radio3 = GUICtrlCreateRadio("平    铺", 20, 375, 68, 17)
$Radio4 = GUICtrlCreateRadio("列    表", 20, 400, 68, 17)
GUICtrlSetState($Radio1, $GUI_CHECKED)

GUICtrlCreateGroup("皮肤设置", 5, 445, 100, 60)
$sDefaultSkin = IniRead($Path, 'Skin', 'Default', '去掉皮肤')
Local $search = FileFindFirstFile(@ScriptDir & '\Skin\*.she')
Local $Skin = '去掉皮肤' & '|'
While 1
        $file = FileFindNextFile($search)
        If @error Then ExitLoop
        $Skin &= StringRegExpReplace($file, '\.she', '') & '|'
WEnd
$hSkin = GUICtrlCreateCombo('', 15, 470, 80, 21, BitOR(0x2, 0x40, 0x00200000, 0x3, $CBS_DROPDOWNLIST))
GUICtrlSetData(-1, $Skin, $sDefaultSkin)

Dim $aItem[9] = ['运行程序', '程序目录', '刷新图标', '修改名称', '删除项目', '', '设置当页背景色', '设置当页文本色', '恢复当页默认色']
$nNumber = UBound($aItem)
Dim $aMenuItem0[$nNumber]
Dim $aMenuItem1[$nNumber]
Dim $aMenuItem2[$nNumber]
Dim $aMenuItem3[$nNumber]
Dim $aMenuItem4[$nNumber]
Dim $aMenuItem5[$nNumber]
Dim $aMenuItem6[$nNumber]
Dim $aMenuItem61[$nNumber]
Dim $aMenuItem62[$nNumber]
Dim $aMenuItem63[$nNumber]

$aMenuItem0[0] = GUICtrlCreateContextMenu($hListView[0])
$aMenuItem0[1] = GUICtrlCreateContextMenu($hListView[1])
$aMenuItem0[2] = GUICtrlCreateContextMenu($hListView[2])
$aMenuItem0[3] = GUICtrlCreateContextMenu($hListView[3])
$aMenuItem0[4] = GUICtrlCreateContextMenu($hListView[4])
$aMenuItem0[5] = GUICtrlCreateContextMenu($hListView[5])

For $i = 0 To 8
        $aMenuItem1[$i] = GUICtrlCreateMenuItem($aItem[$i], $aMenuItem0[0])
        $aMenuItem2[$i] = GUICtrlCreateMenuItem($aItem[$i], $aMenuItem0[1])
        $aMenuItem3[$i] = GUICtrlCreateMenuItem($aItem[$i], $aMenuItem0[2])
        $aMenuItem4[$i] = GUICtrlCreateMenuItem($aItem[$i], $aMenuItem0[3])
        $aMenuItem5[$i] = GUICtrlCreateMenuItem($aItem[$i], $aMenuItem0[4])
        $aMenuItem6[$i] = GUICtrlCreateMenuItem($aItem[$i], $aMenuItem0[5])
Next

GUICtrlCreateGroup("添加程序", 5, 515, 790, 60)
GUICtrlCreateLabel("类型：", 20, 543, 40, 24)
GUICtrlCreateLabel("目录：", 170, 543, 40, 24)
GUICtrlCreateLabel("软件名(可省略)：", 515, 543, 100, 24)

GUICtrlCreateLabel("查看位置：", 10, 583, 62, 17)
$hType = GUICtrlCreateLabel($avArray[0], 70, 583, 60, 17)
GUICtrlCreateLabel("系统版本：" & @OSVersion, 250, 583, 150, 17)
GUICtrlCreateLabel("系统日期：" & @YEAR & "-" & @MON & "-" & @MDAY, 450, 583, 150, 17)
GUICtrlCreateLabel("By：水木子", 720, 583, 80, 17)

Read()
Readall()
Skin(IniRead($Path, 'Skin', 'Default', ''))
GUISetState()

While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
                Case -3
                        Exit
                Case $hSkin
                        Skin(GUICtrlRead($nMsg))
                        IniWrite($Path, 'Skin', 'Default', GUICtrlRead($hSkin))
                Case $But0 To $But5
                        GUICtrlSetFont($id, 9, 400)
                        GUICtrlSetFont($nMsg, 12, 800)
                        $id = $nMsg
                        $iControlID = $nMsg - 15
                        If $iPage <> $iControlID Then
                                Switcha($iPage, $avArray[$iControlID]) 
                                Switchb($iControlID) 
                                $iPage = $iControlID
                        EndIf
                Case $Buta
                        Add(GUICtrlRead($Combo1), GUICtrlRead($Input1), GUICtrlRead($Input2))
                Case $Butb
                        $Folder = FileOpenDialog("查找", '', "可执行文件(*.*)")
                        If Not @error Then GUICtrlSetData($Input1, $Folder)
                Case $Radio1 To $Radio4
                        _GUICtrlListView_SetView($hListView[$iPage], $nMsg - 21)
                Case $GUI_EVENT_DROPPED
                        For $i = 1 To UBound($aDroppedFiles) - 1
                                $SoftwareName = StringRegExpReplace($aDroppedFiles[$i], '.*\\|\.\w{3}', '')
                                $SoftwareType = GUICtrlRead($Combo1)
                                If Detect($SoftwareName) = True Then
                                        MsgBox(48, '提示！', '程序 “' & $SoftwareName & '” 已经存在，为避免出错，请检查！')
                                Else
                                        AddItem($SoftwareType, $SoftwareName, $aDroppedFiles[$i])
                                EndIf
                        Next
                        GUICtrlSendMsg($hListView[$iPage], $LVM_SETCOLUMNWIDTH, 0, -1)
                Case $aMenuItem1[0] To $aMenuItem6[0]
                        RunProgram(1)
                Case $aMenuItem1[1] To $aMenuItem6[1]
                        RunProgram(2)
                Case $aMenuItem1[2] To $aMenuItem6[2]
                        Refresh()
                Case $aMenuItem1[3] To $aMenuItem6[3]
                        Rename()
                Case $aMenuItem1[4] To $aMenuItem6[4]
                        Delete()
                Case $aMenuItem1[6] To $aMenuItem6[6]
                        $nBkColor = _ChooseColor(0, 255, 0, $hGUI)
                        If $nBkColor <> -1 Then
                                _GUICtrlListView_BeginUpdate($hListView[$iPage])
                                _GUICtrlListView_SetBkColor($hListView[$iPage], $nBkColor)
                                _GUICtrlListView_SetTextBkColor($hListView[$iPage], $nBkColor)
                                _GUICtrlListView_EndUpdate($hListView[$iPage])
                                IniWrite($Path, 'BkColor', $hListView[$iPage] - 3, $nBkColor)
                        EndIf
                Case $aMenuItem1[7] To $aMenuItem6[7]
                        $nTextColor = _ChooseColor(0, 255, 0, $hGUI)
                        If $nTextColor <> -1 Then
                                _GUICtrlListView_SetTextColor($hListView[$iPage], $nTextColor)
                                IniWrite($Path, 'BkColor', 'TextColor', $nTextColor)
                        EndIf
                Case $aMenuItem1[8] To $aMenuItem6[8]
                        _GUICtrlListView_SetTextColor($hListView[$iPage], 12615680)
                        _GUICtrlListView_BeginUpdate($hListView[$iPage])
                        _GUICtrlListView_SetBkColor($hListView[$iPage], $CLR_MONEYGREEN)
                        _GUICtrlListView_SetTextBkColor($hListView[$iPage], $CLR_MONEYGREEN)
                        _GUICtrlListView_SetOutlineColor($hListView[$iPage], $CLR_MONEYGREEN)
                        _GUICtrlListView_EndUpdate($hListView[$iPage])
                        IniWrite($Path, 'BkColor', $hListView[$iPage] - 3, '12639424')
                        IniWrite($Path, 'BkColor', 'TextColor', '12615680')
        EndSwitch
WEnd

Func Readall()
        _GUICtrlListView_DeleteAllItems($hListView[0])
        For $i = 1 To UBound($avArray) - 1
                $iNumber = IniReadSection($Path, $avArray[$i])
                If Not @error Then
                        For $ii = 1 To $iNumber[0][0]
                                CreateGroup($hListView[0], $i, $avArray[$i], $iNumber[$ii][0], $iNumber[$ii][1])
                        Next
                EndIf
        Next
EndFunc   ;==>Readall

Func Read()
        For $i = 1 To UBound($avArray) - 1
                _GUICtrlListView_DeleteAllItems($hListView[$i])
                $iNumber = IniReadSection($Path, $avArray[$i])
                If Not @error Then
                        For $ii = 1 To $iNumber[0][0]
                                CreateGroup($hListView[$i], 1, $avArray[$i], $iNumber[$ii][0], $iNumber[$ii][1])
                        Next
                EndIf
        Next
EndFunc   ;==>Read

Func Add($SoftwareType, $SoftwarePath, $SoftwareName)
        If $SoftwareType <> '' And $SoftwarePath <> '' Then
                GUICtrlSetData($Input1, '')
                GUICtrlSetData($Input2, '')
                If $SoftwareName = '' Then $SoftwareName = StringRegExpReplace($SoftwarePath, '.*\\|\.\w{3}', '')
                If Detect($SoftwareName) = True Then
                        MsgBox(48, '提示！', '程序名 “' & $SoftwareName & '” 已经存在，为避免出错，请修改！')
                        Return
                Else
                        AddItem($SoftwareType, $SoftwareName, $SoftwarePath)
                EndIf
        Else
                MsgBox(48, '提示！', '请设置程序所在目录！')
        EndIf
EndFunc   ;==>Add

Func AddItem($SoftwareType, $SoftwareName, $SoftwarePath)
        If StringRegExp($SoftwarePath, '\.lnk') Then
                $aShortcut = FileGetShortcut($SoftwarePath)
                $SoftwarePath = $aShortcut[0]
        EndIf

        Select
                Case $SoftwareType = $avArray[1]
                        $iGroupID = 1
                Case $SoftwareType = $avArray[2]
                        $iGroupID = 2
                Case $SoftwareType = $avArray[3]
                        $iGroupID = 3
                Case $SoftwareType = $avArray[4]
                        $iGroupID = 4
                Case $SoftwareType = $avArray[5]
                        $iGroupID = 5
        EndSelect

        CreateGroup($hListView[0], $iGroupID, $SoftwareType, $SoftwareName, $SoftwarePath)
        CreateGroup($hListView[$iGroupID], 1, $SoftwareType, $SoftwareName, $SoftwarePath)
        IniWrite($Path, $SoftwareType, $SoftwareName, $SoftwarePath)
EndFunc   ;==>AddItem

Func RunProgram($nEvent)
        $iIndex = _GUICtrlListView_GetSelectedIndices($hListView[$iPage])
        If $iIndex <> '' Then
                $sItemText = _GUICtrlListView_GetItemText($hListView[$iPage], Number($iIndex))
                $aSoftPath = StringRegExp(FileRead($Path), $sItemText & '=(.+?)\r', 3)
                $aWorkPath = StringRegExp($aSoftPath[0], '(.+)\\', 3)

                If $nEvent = 1 Then ShellExecute($aSoftPath[0], '', $aWorkPath[0])
                If $nEvent = 2 Then ShellExecute($aWorkPath[0])
                If $nEvent = 3 Then Return $sItemText
        EndIf
EndFunc   ;==>RunProgram

Func Refresh()
        Readall()
        Read()
        $sFileText = FileRead($Path)
        FileOpen($Path, 2)
        FileWrite($Path, StringRegExpReplace($sFileText, '\n\r', ''))
EndFunc   ;==>Refresh

Func Rename()
        $iIndex = _GUICtrlListView_GetSelectedIndices($hListView[$iPage])
        If $iIndex <> '' Then
                $sItemText = _GUICtrlListView_GetItemText($hListView[$iPage], Number($iIndex))
                $sNewName = InputBox('程序 ' & $sItemText & ' 重命名', '请输入新的命名！')
                If $sNewName <> '' Then
                        If Detect($sNewName) = True Then
                                MsgBox(48, '提示！', '程序名 “' & $sNewName & '” 已经存在，为避免出错，请修改！')
                        Else
                                $sOldName = RunProgram(3)
                                _GUICtrlListView_SetItemText($hListView[$iPage], $iIndex, $sNewName)
                                $sFileText = FileRead($Path)
                                FileOpen($Path, 2)
                                $sReplace = StringRegExpReplace($sFileText, $sOldName & '=', $sNewName & '=')
                                FileWrite($Path, StringRegExpReplace($sReplace, '\n\r', ''))
                                If $hListView[$iPage] = $hListView[0] Then
                                        Read()
                                Else
                                        Readall()
                                EndIf
                        EndIf
                EndIf
        EndIf
EndFunc   ;==>Rename

Func Delete()
        $iGroupID = _GUICtrlListView_GetSelectedIndices($hListView[$iPage])
        $sItemText = _GUICtrlListView_GetItemText($hListView[$iPage], Number($iGroupID))
        If StringLen($iGroupID) <> 0 And MsgBox(32 + 1, '温馨提示！', '你确定要删除  《' & $sItemText & '》  吗？') = 1 Then
                If $iPage = 0 Then
                        $sText = FileRead($Path)
                        _GUICtrlListView_DeleteItemsSelected($hListView[$iPage])
                        $hText = FileOpen($Path, 2)
                        FileWrite($Path, StringRegExpReplace($sText, $sItemText & '=\w:\\.*|\n\r', ''))
                        Read()
                Else
                        _GUICtrlListView_DeleteItemsSelected($hListView[$iPage])
                        IniDelete($Path, GUICtrlRead($Combo1), $sItemText)
                        Readall()
                EndIf
        EndIf
EndFunc   ;==>Delete

Func CreateGroup($hWnd, $iGroupID, $sHeader, $sText, $sImageFile, $nIcoID = -1);创建分组，参数1控件句柄、参数2分组ID、参数3分组标题
        If StringRegExp($sImageFile, '(?i)[a-z]:\\.+\.\w{3}') = 0 Then
                $sImageFile = 'shell32.dll'
                $nIcoID = 4
        EndIf

        GUICtrlCreateListViewItem($sText, $hWnd)
        GUICtrlSetImage(-1, $sImageFile, $nIcoID)

        $iNumber = _GUICtrlListView_GetCounterPage($hWnd) - 1;计算在可视区域中可垂直显示的项目数量
        _GUICtrlListView_EnableGroupView($hWnd);启用控件中的项目分组显示
        _GUICtrlListView_InsertGroup($hWnd, -1, $iGroupID, $sHeader & ' ');插入分组
        _GUICtrlListView_SetItemGroupID($hWnd, $iNumber, $iGroupID);设置项目分组编号
EndFunc   ;==>CreateGroup

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
        Local $tNMTV, $iCode
        $tNMTV = DllStructCreate($tagNMTVDISPINFO, $ilParam)
        $iCode = DllStructGetData($tNMTV, "Code")
        If $iCode = $NM_DBLCLK Then RunProgram(1)
EndFunc   ;==>WM_NOTIFY

Func Switcha($hWnd, $Type)
        GUICtrlSetData($hType, $Type)
        If $Type <> $avArray[0] Then GUICtrlSetData($Combo1, $Type)
        ;ControlMove($hGUI, '', $hListView[$hWnd], 1000, Default)
        GUICtrlSetState($id_LV, $GUI_HIDE)
EndFunc   ;==>Switcha

Func Switchb($hWnd)
        $iView = _GUICtrlListView_GetView($hListView[$hWnd])
        Select
                Case $iView = 1
                        GUICtrlSetState($Radio1, $GUI_CHECKED)
                Case $iView = 2
                        GUICtrlSetState($Radio2, $GUI_CHECKED)
                Case $iView = 3
                        GUICtrlSetState($Radio3, $GUI_CHECKED)
                Case $iView = 4
                        GUICtrlSetState($Radio4, $GUI_CHECKED)
        EndSelect
        ;ControlMove($hGUI, '', $hListView[$hWnd], 115, Default)
        GUICtrlSetState($hListView[$hWnd], $GUI_SHOW)
        $id_LV = $hListView[$hWnd]
EndFunc   ;==>Switchb

Func Detect($iText)
        If StringInStr(FileRead($Path), $iText & '=') Then
                Return True
        Else
                Return False
        EndIf
EndFunc   ;==>Detect

Func WM_DROPFILES($hWnd, $msgID, $wParam, $lParam)
        Local $nSize, $pFileName
        Local $nAmt = DllCall("shell32.dll", "int", "DragQueryFile", "hwnd", $wParam, "int", 0xFFFFFFFF, "ptr", 0, "int", 255)
        $aDroppedFiles = 0
        Dim $aDroppedFiles[$nAmt[0] + 1]
        For $i = 0 To $nAmt[0] - 1
                $nSize = DllCall("shell32.dll", "int", "DragQueryFile", "hwnd", $wParam, "int", $i, "ptr", 0, "int", 0)
                $nSize = $nSize[0] + 1
                $pFileName = DllStructCreate("char[" & $nSize & "]")
                DllCall("shell32.dll", "int", "DragQueryFile", "hwnd", $wParam, "int", $i, "ptr", _
                                DllStructGetPtr($pFileName), "int", $nSize)

                $aDroppedFiles[0] += 1
                $aDroppedFiles[$aDroppedFiles[0]] = DllStructGetData($pFileName, 1)
                $pFileName = 0
        Next
        ReDim $aDroppedFiles[$aDroppedFiles[0] + 1]
EndFunc   ;==>WM_DROPFILES

Func SpecialEvent()
        If WinGetState($hGUI) = 7 Then
                GUISetState(@SW_MINIMIZE)
        Else
                GUISetState(@SW_RESTORE)
        EndIf
EndFunc   ;==>SpecialEvent

Func Enter()
        If Not WinActive($hGUI) Then
                HotKeySet('{Enter}')
                Send('{Enter}')
                HotKeySet('{Enter}', 'Enter')
        Else
                RunProgram(1)
        EndIf
EndFunc   ;==>Enter

Func Skin($She)
        If $She <> '去掉皮肤' Then
                If $Dll <> 1 Then $Dll = DllOpen(@ScriptDir & '\Skin\Skin.dll')
                DllCall($Dll, "int", "SkinH_AttachEx", "str", @ScriptDir & '\Skin\' & $She & '.she', "str", "mhgd")
                DllCall($Dll, "int", "SkinH_SetAero", "int", 1)
        Else
                DllClose($Dll)
                $Dll = 0
        EndIf
EndFunc   ;==>Skin

Func Memory()
        _ReduceMemory(@AutoItPID)
EndFunc   ;==>Memory

Func _ReduceMemory($i_PID = -1)
        If $i_PID <> -1 Then
                Local $ai_Handle = DllCall("kernel32.dll", 'int', 'OpenProcess', 'int', 0x1f0fff, 'int', False, 'int', $i_PID)
                Local $ai_Return = DllCall("psapi.dll", 'int', 'EmptyWorkingSet', 'long', $ai_Handle[0])
                DllCall('kernel32.dll', 'int', 'CloseHandle', 'int', $ai_Handle[0])
        Else
                Local $ai_Return = DllCall("psapi.dll", 'int', 'EmptyWorkingSet', 'long', -1)
        EndIf

        Return $ai_Return[0]
EndFunc   ;==>_ReduceMemory