#NoTrayIcon
#AutoIt3Wrapper_icon=D:\Program Files\实用程序\autoit3\Aut2Exe\Icons\home2.ico
#AutoIt3Wrapper_outfile=搜索工具条.exe
#AutoIt3Wrapper_Res_Comment=搜索工具条--很好用的哦。
#AutoIt3Wrapper_Res_Description=王彬拙作，多多指教。
#AutoIt3Wrapper_Res_Fileversion=1.0.0.2
#AutoIt3Wrapper_Res_LegalCopyright=王彬拙作，多多指教。
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
 
#include "Misc.au3"
If _Singleton("搜索工具条.exe", 1) = 0 Then Exit
If WinExists("搜索","透") Then Exit
 
 
 
Global $MARk_1 = 0
Global $DEFAULTINPUTDATA_1   = "输入关键词"
Global $NONEAACTIVECOLOR    = 0x989898
 
 
 
$sIni = @ScriptDir & "\sousuo.ini"
 
$var = IniReadSection($sIni, "moren")
If @error Then 
IniWrite($sIni, "moren", "moren", "1")
EndIf
$var = IniRead($sIni, "moren","moren","1")
if IsNumber ( $var ) Then
sleep(1)
Else
IniWrite($sIni, "moren", "moren", "1")
EndIf
$var = IniRead($sIni, "moren","moren","1")
 
$vabc = IniReadSection($sIni, "sousuo")
If @error Then 
Dim $abc[4][2] = [ [ "百 度", "http://www.baidu.com/s?wd=" ], [ "谷 歌","http://www.google.cn/search?hl=zh-CN&q=" ], [ "百度mp3","http://mp3.baidu.com/m?ct=134217728&word=" ],["迅 雷","http://search.gougou.com/search?search="]]
IniWriteSection($sIni, "sousuo", $abc, 0)
$vabc = IniReadSection($sIni, "sousuo")
EndIf
 
$vabcd = IniReadSection($sIni, "weizhi")
If @error Then 
Dim $abcd[2][2] = [ [ "w", "200" ], [ "h","0" ]]
IniWriteSection($sIni, "weizhi", $abcd, 0)
$vabcd = IniReadSection($sIni, "weizhi")
EndIf
 
 
$vdd = IniReadSection($sIni, "shezhi")
If @error Then 
Dim $ddc[2][2] = [ [ "touming", "0" ], [ "shousuo","0" ]]
IniWriteSection($sIni, "shezhi", $ddc, 0)
$vdd = IniReadSection($sIni, "shezhi")
EndIf
 
$Form1 = GUICreate("搜索", @DesktopWidth/4, 20, $vabcd[1][1], $vabcd[2][1], $WS_POPUP, $WS_EX_LAYERED+$WS_EX_TOPMOST+$WS_EX_TOOLWINDOW)
GUISetBkColor(0xABCDEF)
_API_SetLayeredWindowAttributes($Form1, 0x010101)
 
$Label1 = GUICtrlCreateLabel(" ", 0, 0, 20, 20, -1, $GUI_WS_EX_PARENTDRAG)
GUICtrlSetTip(-1, "点击此处可拖动窗口。")
$Checkbox1 = GUICtrlCreateCheckbox("透", 20, 0, 30, 20)
if $vdd[1][1] = 1 Then
GUICtrlSetState ($Checkbox1, $GUI_CHECKED )
_API_SetLayeredWindowAttributes($Form1, 0xABCDEF)
EndIf
 
$Checkbox2 = GUICtrlCreateCheckbox("缩", 50, 0, 30, 20)
if $vdd[2][1] = 1 Then
GUICtrlSetState ($Checkbox2, $GUI_CHECKED )
EndIf
$Button1 = GUICtrlCreateButton("退", 80, 0, 25, 20, 0)
 
$Input_1 = GUICtrlCreateInput($DEFAULTINPUTDATA_1, 110,0,@DesktopWidth/4-200,20)
GUICtrlSetColor(-1, $NONEAACTIVECOLOR)
$Button2 = GUICtrlCreateButton($vabc[$var][0], @DesktopWidth/4-85,0,70, 20)
GUICtrlSetState($Button2, $GUI_DEFBUTTON)
$Button3 = GUICtrlCreateButton("v", @DesktopWidth/4-15,0,15, 20)
 
 
GUISetState(@SW_SHOW)
 
#EndRegion ### START Koda GUI section ### Form=
While 1
GUICtrlSetState($Button2, $GUI_DEFBUTTON)
        $nMsg = GUIGetMsg()
        Switch $nMsg
                Case $GUI_EVENT_CLOSE
                        Exit
                Case $Checkbox1
SoundPlay(@WindowsDir & "\media\Windows XP 开始.wav",0)
                        If BitAND(GUICtrlRead($Checkbox1), $GUI_CHECKED) = $GUI_CHECKED Then
IniWrite($sIni, "shezhi", "touming", "1")
                                _API_SetLayeredWindowAttributes($Form1, 0xABCDEF)
 
                        Else
IniWrite($sIni, "shezhi", "touming", "0")
                                _API_SetLayeredWindowAttributes($Form1, 0x010101)
                        EndIf
                Case $Button1
SoundPlay(@WindowsDir & "\media\Windows XP 开始.wav",0)
                        Exit
                Case $Button2
SoundPlay(@WindowsDir & "\media\Windows XP 开始.wav",0)
if GUICtrlRead ( $Input_1, 0) = $DEFAULTINPUTDATA_1 Then
ShellExecute($vabc[$var][1])
Else
ShellExecute($vabc[$var][1] & GUICtrlRead ( $Input_1, 0))
EndIf
Case $Button3
if $var = $vabc[0][0] then 
$var = 1 
Else
$var = $var + 1
EndIf
IniWrite($sIni, "moren", "moren", $var)
$vabc = IniReadSection($sIni, "sousuo")
GUICtrlSetData ( $Button2, $vabc[$var][0])
        EndSwitch
IniWrite($sIni, "moren", "moren", $var)
$size = WinGetPos($Form1)
$pos = MouseGetPos()
if $size[0] < 15 And $size[0] <> 0 then 
                WinMove ( $Form1, "", 0, $size[1], @DesktopWidth/4, 20,1 )
        ElseIf $size[1] < 15 And $size[1] <> 0 then 
                WinMove ( $Form1, "", $size[0], 0,@DesktopWidth/4, 20, 1 )
        Elseif @DesktopHeight-$size[1]-$size[3] < 15 And @DesktopHeight-$size[1]-$size[3] <> 0 then 
                WinMove ( $Form1, "", $size[0], @DesktopHeight-20,@DesktopWidth/4, 20, 1 )
EndIf
 
 
If BitAND(GUICtrlRead($Checkbox2), $GUI_CHECKED) = $GUI_CHECKED Then
IniWrite($sIni, "shezhi", "shousuo", "1")
        if  Abs ( $pos[0] - $size[0] - $size[2]/2 ) < $size[2]/2 + 15 And Abs ( $pos[1] - $size[1] - $size[3]/2) < $size[3]/2 + 15 Then
                If $size[0]=0 or $size[1]=0 Then
                WinMove ( $Form1, "", $size[0], $size[1], @DesktopWidth/4, 20,1 )
                ElseIf $size[0]+15 = @DesktopWidth and $size[2]=15 Then
                WinMove ( $Form1, "", $size[0]-$var[0][0]*50-115+15, $size[1], @DesktopWidth/4, 20,1 )
                ElseIf $size[1]+3=@DesktopHeight and $size[3]=3 Then
                WinMove ( $Form1, "", $size[0], $size[1]-17, @DesktopWidth/4, 20,1 )
                EndIf
        Elseif $size[0] < 15 then 
                WinMove ( $Form1, "", 0, $size[1], 15, 20,1 )
        ElseIf $size[1] < 15 then 
                WinMove ( $Form1, "", $size[0], 0,@DesktopWidth/4, 3, 1 )
        Elseif @DesktopWidth-$size[0]-$size[2] < 15 then 
                WinMove ( $Form1, "", @DesktopWidth-15, $size[1], 15, 20,1 )
        Elseif @DesktopHeight-$size[1]-$size[3] < 15 then 
                WinMove ( $Form1, "", $size[0], @DesktopHeight-3,@DesktopWidth/4, 3, 1 )
        EndIf
Else
IniWrite($sIni, "shezhi", "shousuo", "0")
EndIf
 
 
Dim $abcd[2][2] = [ [ "w", $size[0]], [ "h",$size[1]]]
IniWriteSection($sIni, "weizhi", $abcd, 0)
_CheckInput($Form1, $Input_1, "输入关键词", $DEFAULTINPUTDATA_1, $MARK_1)
WEnd
 
Func _API_SetLayeredWindowAttributes($hwnd, $i_transcolor, $Transparency = 255, $isColorRef = False)
 
        Local Const $AC_SRC_ALPHA = 1
        Local Const $ULW_ALPHA = 2
        Local Const $LWA_ALPHA = 0x2
        Local Const $LWA_COLORKEY = 0x1
        If Not $isColorRef Then
                $i_transcolor = Hex(String($i_transcolor), 6)
                $i_transcolor = Execute('0x00' & StringMid($i_transcolor, 5, 2) & StringMid($i_transcolor, 3, 2) & StringMid($i_transcolor, 1, 2))
        EndIf
        Local $Ret = DllCall("user32.dll", "int", "SetLayeredWindowAttributes", "hwnd", $hwnd, "long", $i_transcolor, "byte", $Transparency, "long", $LWA_COLORKEY + $LWA_ALPHA)
        Select
                Case @error
                        Return SetError(@error, 0, 0)
                Case $Ret[0] = 0
                        Return SetError(4, 0, 0)
                Case Else
                        Return 1
        EndSelect
EndFunc   ;==>_API_SetLayeredWindowAttributes
 
Func _CheckInput($hWnd, $ID, $InputDefText, ByRef $DefaultInputData, ByRef $Mark)
    If $Mark = 0 And _IsFocused($hWnd, $ID) And $DefaultInputData = $InputDefText Then
        $Mark = 1
        GUICtrlSetData($ID, "")
        GUICtrlSetColor($ID, 0x000000)
        $DefaultInputData = ""
    ElseIf $Mark = 1 And Not _IsFocused($hWnd, $ID) And $DefaultInputData = "" And GUICtrlRead($ID) = "" Then
        $Mark = 0
        $DefaultInputData = $InputDefText
        GUICtrlSetData($ID, $DefaultInputData)
        GUICtrlSetColor($ID, $NONEAACTIVECOLOR)
    EndIf
EndFunc
 
Func _IsFocused($hWnd, $nCID)
    Return ControlGetHandle($hWnd, '', $nCID) = ControlGetHandle($hWnd, '', ControlGetFocus($hWnd))
EndFunc