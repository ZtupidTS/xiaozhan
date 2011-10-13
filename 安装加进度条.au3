$g_Version = "888" 
If WinExists($g_Version) Then Exit 
AutoItWinSetTitle($g_Version) 
Opt("TrayIconHide", 1) 
#include <ButtonConstants.au3> 
#include <GUIConstantsEx.au3> 
#include <StaticConstants.au3> 
#include <WindowsConstants.au3> 
If not FileExists(@ScriptDir&"\soft.ini") then 
msgbox(0,"","配置文件不存在,程序正在退出...") 
Exit 
Endif 
$ckbt=IniReadSection(@ScriptDir&"\soft.ini", "窗口标题") 
$picpath=IniReadSection(@ScriptDir&"\soft.ini", "图像") 
$ljpath=IniReadSection(@ScriptDir&"\soft.ini", "路径") 
if $picpath[1][1]="" Then 
$piclj=@ScriptDir&"\AA.jpg[/email]" 
Else 
$piclj=$picpath[1][1] 
EndIf 
Dim $Checkbox[9] 
$Form1 = GUICreate($ckbt[1][1], 482, 324, 247, 154) 
WinActive($ckbt[1][1]) 
WinSetOnTop ($ckbt[1][1], "",1 ) 

$Pic1 = GUICtrlCreatePic($piclj, 0, 0, 482, 70, BitOR($SS_NOTIFY,$WS_GROUP,$WS_CLIPSIBLINGS)) 
$Group1 = GUICtrlCreateGroup("常用软件+", 15, 74, 451, 89) 
$Checkbox[1] = GUICtrlCreateCheckbox($ljpath[1][0], 24, 90, 137, 30) 
GUICtrlSetFont(-1, 11, 400, 0, "MS Sans Serif") 
GUICtrlSetState ( $Checkbox[1], $GUI_CHECKED) 
$Checkbox[2] = GUICtrlCreateCheckbox($ljpath[2][0], 24, 122, 137, 30) 
GUICtrlSetFont(-1, 11, 400, 0, "MS Sans Serif") 
GUICtrlSetState ( $Checkbox[2], $GUI_CHECKED) 
$Checkbox[3] = GUICtrlCreateCheckbox($ljpath[3][0], 163, 89, 137, 30) 
GUICtrlSetFont(-1, 11, 400, 0, "MS Sans Serif") 
GUICtrlSetState ( $Checkbox[3], $GUI_CHECKED) 
$Checkbox[4] = GUICtrlCreateCheckbox($ljpath[4][0], 163, 128, 137, 30) 
GUICtrlSetFont(-1, 11, 400, 0, "MS Sans Serif") 
GUICtrlSetState ( $Checkbox[4], $GUI_CHECKED) 
$Checkbox[5] = GUICtrlCreateCheckbox($ljpath[5][0], 317, 90, 137, 30) 
GUICtrlSetFont(-1, 11, 400, 0, "MS Sans Serif") 
GUICtrlSetState ( $Checkbox[5], $GUI_CHECKED) 
$Checkbox[6] = GUICtrlCreateCheckbox($ljpath[6][0], 317, 126, 137, 30) 
GUICtrlSetFont(-1, 11, 400, 0, "MS Sans Serif") 
GUICtrlSetState ( $Checkbox[6], $GUI_CHECKED) 
GUICtrlCreateGroup("", -99, -99, 1, 1) 
$Group2 = GUICtrlCreateGroup("系统美化+", 15, 178, 451, 46) 
$Checkbox[7] = GUICtrlCreateCheckbox($ljpath[7][0], 24, 190, 177, 30) 
GUICtrlSetFont(-1, 11, 400, 0, "MS Sans Serif") 
GUICtrlSetState ( $Checkbox[7], $GUI_CHECKED) 
$Checkbox[8] = GUICtrlCreateCheckbox($ljpath[8][0], 206, 190, 177, 30) 
GUICtrlSetFont(-1, 11, 400, 0, "MS Sans Serif") 
GUICtrlSetState ( $Checkbox[8], $GUI_CHECKED) 
GUICtrlCreateGroup("", -99, -99, 1, 1) 
$Label1 = GUICtrlCreateLabel(" 说明：[N]为全选/全不选，Y安装，[Esc]取消", 56, 230, 385, 17) 
$Progress1 = GUICtrlCreateProgress(15, 254, 451, 12, -1,-1) 
$Button1 = GUICtrlCreateButton("安装所选软件", 80, 280, 137, 33, 0) 
GUICtrlSetState ( $Button1, $GUI_FOCUS ) 
$Button2 = GUICtrlCreateButton("不安装软件[Esc]", 260, 280, 137, 33, 0) 
DllCall("user32.dll", "int", "AnimateWindow", "hwnd",$form1, "int", 500, "long", 0x00000010) 
GUISetState(@SW_SHOW) 
$wsj = 10 ;等待的时间 
$all=10 ;时间*这个变量就是100 
AdlibRegister("mytime",1000) ;AdlibRegister代替AdlibEnable
HotKeySet("ESC", "csesc") 
HotKeySet("y", "setup") 
HotKeySet("n", "setup") 
While 1 
$nMsg = GUIGetMsg() 
Switch $nMsg 

case $Button1 
setup() 

case $Button2 
csesc() 


Case $GUI_EVENT_CLOSE 
AdlibUnRegister() ;AdlibUnRegister代替AdlibDisable
DllCall("user32.dll", "int", "AnimateWindow", "hwnd",$form1, "int", 500, "long", 0x00090000);退出效果 
Exit 
EndSwitch 
WEnd 
func csesc() 
Exit 
EndFunc 
func nosetup() 
Exit 
EndFunc 
Func error($s) 
MsgBox(0,"错误!",$s) 
Exit 
EndFunc 

Func mytime() 
if $wsj < 0 Then 
if GUICtrlRead ($Checkbox[1])=$GUI_CHECKED Then 
RunWait ($ljpath[1][1]) 
endif 
if GUICtrlRead ($Checkbox[2])=$GUI_CHECKED Then 
RunWait ($ljpath[2][1]) 
endif 
if GUICtrlRead ($Checkbox[3])=$GUI_CHECKED Then 
RunWait ($ljpath[3][1]) 
endif 

if GUICtrlRead ($Checkbox[4])=$GUI_CHECKED Then 
RunWait ($ljpath[4][1]) 
endif 

if GUICtrlRead ($Checkbox[5])=$GUI_CHECKED Then 
RunWait ($ljpath[5][1]) 
endif 

if GUICtrlRead ($Checkbox[6])=$GUI_CHECKED Then 
RunWait ($ljpath[6][1]) 
endif 

if GUICtrlRead ($Checkbox[7])=$GUI_CHECKED Then 
RunWait ($ljpath[7][1]) 
endif 


if GUICtrlRead ($Checkbox[8])=$GUI_CHECKED Then 
RunWait ($ljpath[8][1]) 
endif 

Exit 
Else 
GUICtrlSetData ($Progress1,100-$wsj * $all) 
if GUICtrlRead ($Checkbox[1])=$GUI_UNCHECKED Then 
AdlibUnRegister() 
endif 
if GUICtrlRead ($Checkbox[2])=$GUI_UNCHECKED Then 
AdlibUnRegister() 
endif 
if GUICtrlRead ($Checkbox[3])=$GUI_UNCHECKED Then 
AdlibUnRegister() 
endif 
if GUICtrlRead ($Checkbox[4])=$GUI_UNCHECKED Then 
AdlibUnRegister() 
endif 
if GUICtrlRead ($Checkbox[5])=$GUI_UNCHECKED Then 
AdlibUnRegister() 
endif 
if GUICtrlRead ($Checkbox[6])=$GUI_UNCHECKED Then 
AdlibUnRegister() 
endif 
if GUICtrlRead ($Checkbox[7])=$GUI_UNCHECKED Then 
AdlibUnRegister() 
endif 
if GUICtrlRead ($Checkbox[8])=$GUI_UNCHECKED Then 
AdlibUnRegister() 
endif 
GUICtrlSetData($Button1,""&$wsj&"秒后安装所选软件") 
$wsj=$wsj-1 
;Sleep(500) 
EndIf 
EndFunc 


func setup() 
AdlibUnRegister() 
if GUICtrlRead ($Checkbox[1])=$GUI_CHECKED Then 
RunWait ($ljpath[1][1]) 
endif 
if GUICtrlRead ($Checkbox[2])=$GUI_CHECKED Then 
RunWait ($ljpath[2][1]) 
endif 
if GUICtrlRead ($Checkbox[3])=$GUI_CHECKED Then 
RunWait ($ljpath[3][1]) 
endif 

if GUICtrlRead ($Checkbox[4])=$GUI_CHECKED Then 
RunWait ($ljpath[4][1]) 
endif 

if GUICtrlRead ($Checkbox[5])=$GUI_CHECKED Then 
RunWait ($ljpath[5][1]) 
endif 

if GUICtrlRead ($Checkbox[6])=$GUI_CHECKED Then 
RunWait ($ljpath[6][1]) 
endif 

if GUICtrlRead ($Checkbox[7])=$GUI_CHECKED Then 
RunWait ($ljpath[7][1]) 
endif 


if GUICtrlRead ($Checkbox[8])=$GUI_CHECKED Then 
RunWait ($ljpath[8][1]) 
endif 
exit 

EndFunc 

Func allrj() 
for $i=1 to 8 
if GUICtrlRead ($Checkbox[$i])=$GUI_CHECKED Then 
okrj() 
ExitLoop 
Else 
norj() 
ExitLoop 
EndIf 
Next 
EndFunc 

Func okrj() 
for $i=1 to 8 
GUICtrlSetState ( $Checkbox[$i], $GUI_UNCHECKED ) 
next 
EndFunc 
Func norj() 
for $i=1 to 8 
GUICtrlSetState ( $Checkbox[$i], $GUI_CHECKED ) 
next 
EndFunc 
;------------------------------------------------------------------------------------------- 


#cs
soft.ini
;配置文件
[路径]
迅雷5="notepad.exe"
暴风影音3="c:\windows\Storm.exe"
酷我音乐盒="c:\windows\runonce\software\KWMUSIC.exe"
腾讯QQ2008="c:\windows\runonce\software\QQ2008.exe"
PPS网络电视="c:\windows\runonce\software\PPstream.exe"
Maxthon="d:\wenqq\qq\qq.exe"
精美桌面主题="c:\windows\runonce\software\Themes.exe"
梦幻水族馆屏保="c:\windows\runonce\software\pingbao.exe"
;左边的文字显在选框中的 右边为安装的路径。程序要做成自动安装方式。
[窗口标题]
标题=软件自动安装 
[图像]
图像=
;图像路径为空时。在程序目录下的AA.jpg为logo
#ce
