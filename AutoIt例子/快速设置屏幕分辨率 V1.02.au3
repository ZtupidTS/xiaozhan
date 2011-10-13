#include <GUIConstants.au3>
#include <GuiStatusBar.au3>
#include <ChangeScreenRes.au3>
#include <Array.au3>
Global $wbemFlagReturnImmediately = 0x10
Global $wbemFlagForwardOnly = 0x20
Global $strComputer = "localhost"
Global $colItems = ""
Local $a_PartsRightEdge[3] = [100, 280, -1]
Local $a_PartsText[3] = ["    ���ߣ�������     ", "    ��ַ��[url]http://www.autoit.net.cn[/url]    ", "      QQ��88888888"]
$gui = GUICreate("����������Ļ�ֱ��� V1.02", 400, 300)
_GUICtrlStatusBarCreate($gui, $a_PartsRightEdge, $a_PartsText)
FileInstall("Sunny.jpg", @TempDir & "\")
GUICtrlCreatePic(@TempDir & "\Sunny.jpg", 0, 0, 0, 0)
FileDelete(@TempDir & "\Sunny.jpg")
Func _RunDOS($sCommand)
        Return RunWait(@ComSpec & " /C " & $sCommand, "", @SW_HIDE)
EndFunc   ;==>_RunDOS
$tab = GUICtrlCreateTab(1, 100, 400, 1080)
GUICtrlCreateGroup("�ֱ�������", 20, 130, 360, 130)
GUICtrlCreateGroup("CRT��ʾ��", 30, 150, 80, 80)
GUICtrlCreateGroup("Һ����ʾ��", 120, 150, 80, 80)
GUICtrlCreateGroup("����Һ��", 210, 150, 80, 80)
$tab0radio1 = GUICtrlCreateRadio("800*600", 35, 165)
$tab0radio2 = GUICtrlCreateRadio("1024*768", 35, 185)
$tab0radio3 = GUICtrlCreateRadio("1280*1024", 35, 205)
$tab0radio4 = GUICtrlCreateRadio("15�� LCD", 130, 165)
$tab0radio5 = GUICtrlCreateRadio("17�� LCD", 130, 185)
$tab0radio6 = GUICtrlCreateRadio("19�� LCD", 130, 205)
$tab0radio7 = GUICtrlCreateRadio("17�����", 220, 165)
$tab0radio8 = GUICtrlCreateRadio("19�����", 220, 185)
$tab0radio9 = GUICtrlCreateRadio("22�����", 220, 205)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateLabel("�ֱ������ù����ܸ���ɺ���,����CTRL+R�ɿ��ٽ��ͷֱ���", 50, 240)
GUICtrlSetColor(-1, 0xff0000)
$tab0button = GUICtrlCreateButton("�� ��", 305, 160, 60, 25)
HotKeySet("^r", "DefaultRes")
$tab0button1 = GUICtrlCreateButton("�� ��", 305, 200, 60, 25)
GUICtrlSetTip(-1, "�˳�")
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
 
������
#include-once
;===============================================================================
;
; ��������:    _ChangeScreenRes()
; ��ϸ��Ϣ:    �޸� ��Ļ�ֱ���,ˢ����.
; �汾:          1.0.0.1
; ����:     $i_Width - ��Ļ���(��1024X768 �е� 1024)
;             $i_Height - ��Ļ�߶�(��1024X768 �е� 768)
;             $i_BitsPP -������ɫ���(�� 32BIT,32λ)
;             $i_RefreshRate - ��Ļˢ����(�� 75 MHZ).
; ����      AutoIt ���԰� > 3.1 ����
; ����ֵ  :      �ɹ�,��Ļ����,@ERROR = 0
;                   ʧ��,��Ļ������, @ERROR = 1
; ��̳:         [url]http://www.autoitscript.com/forum/index.php?showtopic=20121[/url]
; ����:        Original code - psandu.ro
;                Modifications - PartyPooper
; ����:        thesnow
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