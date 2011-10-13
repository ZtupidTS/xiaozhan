#include <GUIConstantsEx.au3>
#include <TreeViewConstants.au3>
#include <WindowsConstants.au3>
#Include <GuiTreeView.au3>
#Include <File.au3>
 
$gui = GUICreate("File Browser", 362, 378, -1, -1)
$tree = GUICtrlCreateTreeView(0, 0, 361, 377)
GUICtrlSetFont(-1,10)
GUICtrlSetColor($tree, 0x00FF00)
GUICtrlSetBkColor($tree,0x000000)
 
$hImage = _GUIImageList_Create(16, 16, 5, 2)
_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 4)
_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 54)
_GUICtrlTreeView_SetNormalImageList($tree, $hImage)
 
GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
 
$root = _GUICtrlTreeView_AddChild($tree,"","C:\",0)
$root = _GUICtrlTreeView_AddChild($tree,"","D:\",0)
GUISetState(@SW_SHOW)
$folder = DriveGetDrive( "all" )
 
 
While 1
    $msg = GUIGetMsg()
    If $msg= -3 Then ExitLoop
WEnd
 
Func _SearchFolder($folder,$parent,$level=0)
    If $level >= 1 Then Return
    $files = _FileListToArray($folder,"*",1)
    $folders = _FileListToArray($folder,"*",2)
    _FolderFunc($folders,$folder,$parent,$level)
    _FileFunc($files,$parent)
EndFunc
 
Func _FileFunc($files,$parent)
    For $i = 1 To UBound($files)-1
        _GUICtrlTreeView_AddChild($tree,$parent,$files[$i],1,1)
    Next
EndFunc
 
Func _FolderFunc($folders,$folder,$parent,$level)
    For $i = 1 To UBound($folders)-1
        $parentitem = _GUICtrlTreeView_AddChild($tree,$parent,$folders[$i],0)
        _SearchFolder($folder & "\" & $folders[$i],$parentitem,$level+1)
    Next   
EndFunc
 
Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
    Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR
    $hWndTreeView = GUICtrlGetHandle($tree)
    $tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
    $hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
    $iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
    $iCode = DllStructGetData($tNMHDR, "Code")
    Switch $hWndFrom
        Case $hWndTreeView
            Switch $iCode
                Case -451
                    $item = _GUICtrlTreeView_GetSelection($hWndTreeView)
                    $root = $item
                    If _GUICtrlTreeView_GetChildCount($hWndTreeView,$item) <= 0 Then
                        $txt = _GUICtrlTreeView_GetText($hWndTreeView,$item)
                        Do
                            $parent = _GUICtrlTreeView_GetParentHandle($hWndTreeView,$item)
                            If $parent <> 0 Then
                                $txt = _GUICtrlTreeView_GetText($hWndTreeView,$parent) & "\" & $txt
                                $item = $parent
                            EndIf
                        Until $parent = 0
                        _SearchFolder($txt,$root)
                    EndIf
            EndSwitch
    EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc
