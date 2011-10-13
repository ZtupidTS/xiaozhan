#NoTrayIcon
#AutoIt3Wrapper_icon=D:\Program Files\实用程序\autoit3\Aut2Exe\Icons\home2.ico
#AutoIt3Wrapper_outfile=工具条.exe
#AutoIt3Wrapper_Res_Comment=工具条--很好用的哦。
#AutoIt3Wrapper_Res_Description=王彬拙作，多多指教。
#AutoIt3Wrapper_Res_Fileversion=5.0.0.2
#AutoIt3Wrapper_Res_LegalCopyright=王彬拙作，多多指教。
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
 
#include "Misc.au3"                          ;---增加检测是否重复运行程序
If _Singleton("工具条.exe", 1) = 0 Then Exit                         ;---增加检测本程序是否重复运行
If WinExists("快捷栏","透") Then Exit                         ;---双重检测本程序是否重复运行
 
 
$sIni = @ScriptDir & "\conn.ini"
 
$var = IniReadSection($sIni, "kuaijie")
If @error Then 
Dim $aData2[7][2] = [ [ "记事本", @SystemDir & "\Notepad.exe" ], [ "画  图", @SystemDir & "\mspaint.exe" ], [ "计算器", @SystemDir & "\calc.exe" ] , [ "记事本", @SystemDir & "\Notepad.exe" ]  , [ "记事本", @SystemDir & "\Notepad.exe" ] , [ "记事本", @SystemDir & "\Notepad.exe" ] , [ "记事本", @SystemDir & "\notepad.exe" ]]
IniWriteSection($sIni, "kuaijie", $aData2, 0)
$var = IniReadSection($sIni, "kuaijie")
EndIf
 
$vabc = IniReadSection($sIni, "weizhi")
If @error Then 
Dim $abc[2][2] = [ [ "w", "200" ], [ "h","0" ]]
IniWriteSection($sIni, "weizhi", $abc, 0)
$vabc = IniReadSection($sIni, "weizhi")
EndIf
 
$vdd = IniReadSection($sIni, "shezhi")
If @error Then 
Dim $ddc[2][2] = [ [ "touming", "0" ], [ "shousuo","0" ]]
IniWriteSection($sIni, "shezhi", $ddc, 0)
$vdd = IniReadSection($sIni, "shezhi")
EndIf
 
$Form1 = GUICreate("快捷栏", $var[0][0]*50+115, 20, $vabc[1][1], $vabc[2][1], $WS_POPUP, $WS_EX_LAYERED+$WS_EX_TOPMOST+$WS_EX_TOOLWINDOW)
GUISetBkColor(0xABCDEF)
_API_SetLayeredWindowAttributes($Form1, 0x010101)
 
$Label1 = GUICtrlCreateLabel(" ", 0, 0, 20, 20, -1, $GUI_WS_EX_PARENTDRAG)
GUICtrlSetTip(-1, "点击此处可拖动窗口。")
$Button1 = GUICtrlCreateButton("退", 80, 0, 25, 20, 0)
if $var[0][0] >= 1 then 
$Button2 = GUICtrlCreateButton($var[1][0], 115, 0, 50, 20, 0)
Else
$Button2 = GUICtrlCreateButton("记事本", 115, 0, 50, 20, 0)
 
endif
if $var[0][0] >= 2 then 
$Button3 = GUICtrlCreateButton($var[2][0], 165, 0, 50, 20, 0)
Else
$Button3 = GUICtrlCreateButton("画  图", 165, 0, 50, 20, 0)
endif
if $var[0][0] >= 3 then 
$Button4 = GUICtrlCreateButton($var[3][0], 215, 0, 50, 20, 0)
Else
$Button4 = GUICtrlCreateButton("计算器", 215, 0, 50, 20, 0)
endif
if $var[0][0] >= 4 then 
$Button5 = GUICtrlCreateButton($var[4][0], 265, 0, 50, 20, 0)
Else
$Button5 = GUICtrlCreateButton("空 缺", 265, 0, 50, 20, 0)
endif
if $var[0][0] >= 5 then 
$Button6 = GUICtrlCreateButton($var[5][0], 315, 0, 50, 20, 0)
Else
$Button6 = GUICtrlCreateButton("空缺", 315, 0, 50, 20, 0)
endif
if $var[0][0] >= 6 then 
$Button7 = GUICtrlCreateButton($var[6][0], 365, 0, 50, 20, 0)
Else
$Button7 = GUICtrlCreateButton("空缺", 365, 0, 50, 20, 0)
endif
if $var[0][0] >= 7 then 
$Button8 = GUICtrlCreateButton($var[7][0], 415, 0, 50, 20, 0)
Else
$Button8 = GUICtrlCreateButton("空缺", 415, 0, 50, 20, 0)
endif
if $var[0][0] >= 8 then 
$Button9 = GUICtrlCreateButton($var[8][0], 465, 0, 50, 20, 0)
Else
$Button9 = GUICtrlCreateButton("空缺", 465, 0, 50, 20, 0)
endif
if $var[0][0] >= 9 then 
$Button10 = GUICtrlCreateButton($var[9][0], 515, 0, 50, 20, 0)
Else
$Button10 = GUICtrlCreateButton("空缺", 515, 0, 50, 20, 0)
endif
 
 
$Checkbox1 = GUICtrlCreateCheckbox("透", 20, 0, 30, 20)
if $vdd[1][1] = 1 Then
GUICtrlSetState ($Checkbox1, $GUI_CHECKED )
_API_SetLayeredWindowAttributes($Form1, 0xABCDEF)
EndIf
 
$Checkbox2 = GUICtrlCreateCheckbox("缩", 50, 0, 30, 20)
if $vdd[2][1] = 1 Then
GUICtrlSetState ($Checkbox2, $GUI_CHECKED )
EndIf
GUISetState(@SW_SHOW)
 
#EndRegion ### START Koda GUI section ### Form=
While 1
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
                        If FileExists($var[1][1]) Then
    Run($var[1][1])
Else
    MsgBox(4096,"出错了！", "找不到该程序！")
EndIf
                Case $Button3
SoundPlay(@WindowsDir & "\media\Windows XP 开始.wav",0)
                        If FileExists($var[2][1]) Then
    Run($var[2][1])
Else
    MsgBox(4096,"出错了！", "找不到该程序！")
EndIf
                Case $Button4
SoundPlay(@WindowsDir & "\media\Windows XP 开始.wav",0)
                        If FileExists($var[3][1]) Then
    Run($var[3][1])
Else
    MsgBox(4096,"出错了！", "找不到该程序！")
EndIf
                Case $Button5
SoundPlay(@WindowsDir & "\media\Windows XP 开始.wav",0)
                        If FileExists($var[4][1]) Then
    Run($var[4][1])
Else
    MsgBox(4096,"出错了！", "找不到该程序！")
EndIf
                Case $Button6
SoundPlay(@WindowsDir & "\media\Windows XP 开始.wav",0)
                        If FileExists($var[5][1]) Then
    Run($var[5][1])
Else
    MsgBox(4096,"出错了！", "找不到该程序！")
EndIf
                Case $Button7
SoundPlay(@WindowsDir & "\media\Windows XP 开始.wav",0)
                        If FileExists($var[6][1]) Then
    Run($var[6][1])
Else
    MsgBox(4096,"出错了！", "找不到该程序！")
EndIf
                Case $Button8
SoundPlay(@WindowsDir & "\media\Windows XP 开始.wav",0)
                        If FileExists($var[7][1]) Then
    Run($var[7][1])
Else
    MsgBox(4096,"出错了！", "找不到该程序！")
EndIf
Case $Button9
SoundPlay(@WindowsDir & "\media\Windows XP 开始.wav",0)
                        If FileExists($var[8][1]) Then
    Run($var[8][1])
Else
    MsgBox(4096,"出错了！", "找不到该程序！")
EndIf
Case $Button10
SoundPlay(@WindowsDir & "\media\Windows XP 开始.wav",0)
                        If FileExists($var[9][1]) Then
    Run($var[9][1])
Else
    MsgBox(4096,"出错了！", "找不到该程序！")
EndIf
        EndSwitch
 
$size = WinGetPos($Form1)
$pos = MouseGetPos()
if $size[0] < 15 And $size[0] <> 0 then 
                WinMove ( $Form1, "", 0, $size[1], $var[0][0]*50+115, 20,1 )
        ElseIf $size[1] < 15 And $size[1] <> 0 then 
                WinMove ( $Form1, "", $size[0], 0,$var[0][0]*50+115, 20, 1 )
        Elseif @DesktopHeight-$size[1]-$size[3] < 15 And @DesktopHeight-$size[1]-$size[3] <> 0 then 
                WinMove ( $Form1, "", $size[0], @DesktopHeight-20,$var[0][0]*50+115, 20, 1 )
EndIf
 
 
If BitAND(GUICtrlRead($Checkbox2), $GUI_CHECKED) = $GUI_CHECKED Then
IniWrite($sIni, "shezhi", "shousuo", "1")
        if  Abs ( $pos[0] - $size[0] - $size[2]/2 ) < $size[2]/2 + 15 And Abs ( $pos[1] - $size[1] - $size[3]/2) < $size[3]/2 + 15 Then
                If $size[0]=0 or $size[1]=0 Then
                WinMove ( $Form1, "", $size[0], $size[1], $var[0][0]*50+115, 20,1 )
                ElseIf $size[0]+15 = @DesktopWidth and $size[2]=15 Then
                WinMove ( $Form1, "", $size[0]-$var[0][0]*50-115+15, $size[1], $var[0][0]*50+115, 20,1 )
                ElseIf $size[1]+3=@DesktopHeight and $size[3]=3 Then
                WinMove ( $Form1, "", $size[0], $size[1]-17, $var[0][0]*50+115, 20,1 )
                EndIf
        Elseif $size[0] < 15 then 
                WinMove ( $Form1, "", 0, $size[1], 15, 20,1 )
        ElseIf $size[1] < 15 then 
                WinMove ( $Form1, "", $size[0], 0,$var[0][0]*50+115, 3, 1 )
        Elseif @DesktopWidth-$size[0]-$size[2] < 15 then 
                WinMove ( $Form1, "", @DesktopWidth-15, $size[1], 15, 20,1 )
        Elseif @DesktopHeight-$size[1]-$size[3] < 15 then 
                WinMove ( $Form1, "", $size[0], @DesktopHeight-3,$var[0][0]*50+115, 3, 1 )
        EndIf
Else
IniWrite($sIni, "shezhi", "shousuo", "0")
EndIf
 
 
Dim $abcd[2][2] = [ [ "w", $size[0]], [ "h",$size[1]]]
IniWriteSection($sIni, "weizhi", $abcd, 0)
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