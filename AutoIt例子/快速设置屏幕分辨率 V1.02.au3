#include <GUIConstants.au3>
#include <GuiStatusBar.au3>
#include <ChangeScreenRes.au3>
#include <Array.au3>
Global $wbemFlagReturnImmediately = 0x10
Global $wbemFlagForwardOnly = 0x20
Global $strComputer = "localhost"
Global $colItems = ""
Local $a_PartsRightEdge[3] = [100, 280, -1]
Local $a_PartsText[3] = ["    作者：无名氏     ", "    网址：[url]http://www.autoit.net.cn[/url]    ", "      QQ：88888888"]
$gui = GUICreate("快速设置屏幕分辨率 V1.02", 400, 300)
_GUICtrlStatusBarCreate($gui, $a_PartsRightEdge, $a_PartsText)
FileInstall("Sunny.jpg", @TempDir & "\")
GUICtrlCreatePic(@TempDir & "\Sunny.jpg", 0, 0, 0, 0)
FileDelete(@TempDir & "\Sunny.jpg")
Func _RunDOS($sCommand)
        Return RunWait(@ComSpec & " /C " & $sCommand, "", @SW_HIDE)
EndFunc   ;==>_RunDOS
$tab = GUICtrlCreateTab(1, 100, 400, 1080)
GUICtrlCreateGroup("分辨率设置", 20, 130, 360, 130)
GUICtrlCreateGroup("CRT显示器", 30, 150, 80, 80)
GUICtrlCreateGroup("液晶显示器", 120, 150, 80, 80)
GUICtrlCreateGroup("宽屏液晶", 210, 150, 80, 80)
$tab0radio1 = GUICtrlCreateRadio("800*600", 35, 165)
$tab0radio2 = GUICtrlCreateRadio("1024*768", 35, 185)
$tab0radio3 = GUICtrlCreateRadio("1280*1024", 35, 205)
$tab0radio4 = GUICtrlCreateRadio("15寸 LCD", 130, 165)
$tab0radio5 = GUICtrlCreateRadio("17寸 LCD", 130, 185)
$tab0radio6 = GUICtrlCreateRadio("19寸 LCD", 130, 205)
$tab0radio7 = GUICtrlCreateRadio("17寸宽屏", 220, 165)
$tab0radio8 = GUICtrlCreateRadio("19寸宽屏", 220, 185)
$tab0radio9 = GUICtrlCreateRadio("22寸宽屏", 220, 205)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateLabel("分辨率设置过可能高造成黑屏,按下CTRL+R可快速降低分辨率", 50, 240)
GUICtrlSetColor(-1, 0xff0000)
$tab0button = GUICtrlCreateButton("设 置", 305, 160, 60, 25)
HotKeySet("^r", "DefaultRes")
$tab0button1 = GUICtrlCreateButton("退 出", 305, 200, 60, 25)
GUICtrlSetTip(-1, "退出")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState()
While 1
        $msg = GUIGetMsg()
        Select
                Case $msg = $GUI_EVENT_CLOSE
                        ExitLoop
                Case $msg = $tab0button
                        _res()
                Case $msg = $GUI_EVENT_CLOSE Or $msg = $tab0button1
                        ExitLoop
        EndSelect
WEnd
Func _res()
        If GUICtrlRead($tab0radio1) = $GUI_CHECKED Then
                _ChangeScreenRes (800, 600, 32, 85)
        EndIf
        If GUICtrlRead($tab0radio2) = $GUI_CHECKED Then
                _ChangeScreenRes (1024, 768, 32, 85)
        EndIf
        If GUICtrlRead($tab0radio3) = $GUI_CHECKED Then
                _ChangeScreenRes (1280, 1024, 32, 85)
        EndIf
        If GUICtrlRead($tab0radio4) = $GUI_CHECKED Then
                _ChangeScreenRes (1024, 768, 32, 60)
        EndIf
        If GUICtrlRead($tab0radio5) = $GUI_CHECKED Then
                _ChangeScreenRes (1024, 768, 32, 60)
        EndIf
        If GUICtrlRead($tab0radio6) = $GUI_CHECKED Then
                _ChangeScreenRes (1280, 1024, 32, 60)
        EndIf
        If GUICtrlRead($tab0radio7) = $GUI_CHECKED Then
                _ChangeScreenRes (1280, 720, 32, 60)
        EndIf
        If GUICtrlRead($tab0radio8) = $GUI_CHECKED Then
                _ChangeScreenRes (1440, 900, 32, 60)
        EndIf
        If GUICtrlRead($tab0radio9) = $GUI_CHECKED Then
                _ChangeScreenRes (1680, 1050, 32, 60)
        EndIf
EndFunc   ;==>_res
Func DefaultRes()
        _ChangeScreenRes (800, 600, 16, 60)
EndFunc   ;==>DefaultRes
 
辅助：
#include-once
;===============================================================================
;
; 函数名称:    _ChangeScreenRes()
; 详细信息:    修改 屏幕分辨率,刷新率.
; 版本:          1.0.0.1
; 参数:     $i_Width - 屏幕宽度(如1024X768 中的 1024)
;             $i_Height - 屏幕高度(如1024X768 中的 768)
;             $i_BitsPP -桌面颜色深度(如 32BIT,32位)
;             $i_RefreshRate - 屏幕刷新率(如 75 MHZ).
; 需求      AutoIt 测试版 > 3.1 以上
; 返回值  :      成功,屏幕更新,@ERROR = 0
;                   失败,屏幕不更新, @ERROR = 1
; 论坛:         [url]http://www.autoitscript.com/forum/index.php?showtopic=20121[/url]
; 作者:        Original code - psandu.ro
;                Modifications - PartyPooper
; 翻译:        thesnow
;
;===============================================================================
Func _ChangeScreenRes($i_Width = @DesktopWidth, $i_Height = @DesktopHeight, $i_BitsPP = @DesktopDepth, $i_RefreshRate = @DesktopRefresh)
Local Const $DM_PELSWIDTH = 0x00080000
Local Const $DM_PELSHEIGHT = 0x00100000
Local Const $DM_BITSPERPEL = 0x00040000
Local Const $DM_DISPLAYFREQUENCY = 0x00400000
Local Const $CDS_TEST = 0x00000002
Local Const $CDS_UPDATEREGISTRY = 0x00000001
Local Const $DISP_CHANGE_RESTART = 1
Local Const $DISP_CHANGE_SUCCESSFUL = 0
Local Const $HWND_BROADCAST = 0xffff
Local Const $WM_DISPLAYCHANGE = 0x007E
If $i_Width = "" Or $i_Width = -1 Then $i_Width = @DesktopWidth ; default to current setting
If $i_Height = "" Or $i_Height = -1 Then $i_Height = @DesktopHeight ; default to current setting
If $i_BitsPP = "" Or $i_BitsPP = -1 Then $i_BitsPP = @DesktopDepth ; default to current setting
If $i_RefreshRate = "" Or $i_RefreshRate = -1 Then $i_RefreshRate = @DesktopRefresh ; default to current setting
Local $DEVMODE = DllStructCreate("byte[32];int[10];byte[32];int[6]")
Local $B = DllCall("user32.dll", "int", "EnumDisplaySettings", "ptr", 0, "long", 0, "ptr", DllStructGetPtr($DEVMODE))
If @error Then
  $B = 0
  SetError(1)
  Return $B
Else
  $B = $B[0]
EndIf
If $B <> 0 Then
  DllStructSetData($DEVMODE, 2, BitOR($DM_PELSWIDTH, $DM_PELSHEIGHT, $DM_BITSPERPEL, $DM_DISPLAYFREQUENCY), 5)
  DllStructSetData($DEVMODE, 4, $i_Width, 2)
  DllStructSetData($DEVMODE, 4, $i_Height, 3)
  DllStructSetData($DEVMODE, 4, $i_BitsPP, 1)
  DllStructSetData($DEVMODE, 4, $i_RefreshRate, 5)
  $B = DllCall("user32.dll", "int", "ChangeDisplaySettings", "ptr", DllStructGetPtr($DEVMODE), "int", $CDS_TEST)
  If @error Then
   $B = -1
  Else
   $B = $B[0]
  EndIf
  Select
   Case $B = $DISP_CHANGE_RESTART
    $DEVMODE = ""
    Return 2
   Case $B = $DISP_CHANGE_SUCCESSFUL
    DllCall("user32.dll", "int", "ChangeDisplaySettings", "ptr", DllStructGetPtr($DEVMODE), "int", $CDS_UPDATEREGISTRY)
    DllCall("user32.dll", "int", "SendMessage", "hwnd", $HWND_BROADCAST, "int", $WM_DISPLAYCHANGE, _
      "int", $i_BitsPP, "int", $i_Height * 2 ^ 16 + $i_Width)
    $DEVMODE = ""
    Return 1
   Case Else
    $DEVMODE = ""
    SetError(1)
    Return $B
  EndSelect
EndIf
EndFunc ;==>_ChangeScreenRes