#NoTrayIcon
#include <GUIConstants.au3>
#include <WindowsConstants.au3>
Opt("TrayOnEventMode", 1)
Opt("guicloseonesc", 0)
;以下为检查配置文件设置
$soft_ini = FileOpen("Soft.ini", 0)
If $soft_ini = -1 Then
MsgBox(16, "错误", '请检查配置文件' & @ScriptDir & '\"Soft.ini"是否存在!') ;@ScriptDir为脚本所在目录
Exit
EndIf
$chars = FileReadLine($soft_ini, 2)
If $soft_ini <> -1 Then
If $chars <> ";制作：卫和谐，QQ:918766818" Then
  MsgBox(16, "警告", "请保留作者的信息！" & @CRLF & "否则，程序不能继续运行！")
  MsgBox(64, "请保留作者的信息", '作者的信息为：' & @CRLF & ';制作：卫和谐，QQ:918766818' & @CRLF & '你己经修改为：' & @CRLF & $chars)
  Exit
EndIf
EndIf
FileClose($soft_ini)
;以下为定义变量和常量
Const $N = 11, $s = 5
Dim $softname[$N], $softPath[$N], $soft[$N], $radio[$s], $InstallPath
;以下为读取soft.ini配置文件的函数
$title = IniRead("soft.ini", "form", "title", "")
$top_pic = IniRead("soft.ini", "form", "Top_pic", "")
$time = IniRead("soft.ini", "form", "time", "")
$state = IniRead("soft.ini", "form", "state", "")
;以下为依次从配置文件读取软件名、路径的循环
For $i = 0 To $N - 1
$softname[$i] = IniRead("soft.ini", $i, "softname", "空")
$softPath[$i] = IniRead("soft.ini", $i, "softpath", "空")
;msgbox(4096,"测试变量传递",$softname[$i]&$softPath[$i])
Next
;以下为创建主窗体
$form = GUICreate($title, 480, 360, -1, -1)
$top_pic = GUICtrlCreatePic($top_pic, 0, 0, 480, 90)
$Group1 = GUICtrlCreateGroup("", 10, 90, 460, 120)
;在GUI上创建10个复选框（Checkbox）控件，软件名称从配置文件里读取
$soft[1] = GUICtrlCreateCheckbox("&1 " & $softname[1], 15, 100, 225, 20)
$soft[2] = GUICtrlCreateCheckbox("&2 " & $softname[2], 15, 120, 225, 20)
$soft[3] = GUICtrlCreateCheckbox("&3 " & $softname[3], 15, 140, 225, 20)
$soft[4] = GUICtrlCreateCheckbox("&4 " & $softname[4], 15, 160, 225, 20)
$soft[5] = GUICtrlCreateCheckbox("&5 " & $softname[5], 15, 180, 225, 20)
$soft[6] = GUICtrlCreateCheckbox("&6 " & $softname[6], 240, 100, 225, 20)
$soft[7] = GUICtrlCreateCheckbox("&7 " & $softname[7], 240, 120, 225, 20)
$soft[8] = GUICtrlCreateCheckbox("&8 " & $softname[8], 240, 140, 225, 20)
$soft[9] = GUICtrlCreateCheckbox("&9 " & $softname[9], 240, 160, 225, 20)
$soft[10] = GUICtrlCreateCheckbox("&0 " & $softname[10], 240, 180, 225, 20)
For $i = 0 To $N - 1
$start1 = GUICtrlSetState($soft[$i], $GUI_DISABLE)
Next
$Group2 = GUICtrlCreateGroup("安装方式", 10, 215, 200, 70)
;从配置文件里读取安装的名称
$setA = IniRead("soft.ini", "select", "A", "")
$chooseA = IniRead("soft.ini", "select", "ChooseA", "")
$setB = IniRead("soft.ini", "select", "B", "")
$chooseB = IniRead("soft.ini", "select", "ChooseB", "")
$setC = IniRead("soft.ini", "select", "C", "")
$chooseC = IniRead("soft.ini", "select", "ChooseC", "")
$setD = IniRead("soft.ini", "select", "D", "")
$chooseD = IniRead("soft.ini", "select", "ChooseD", "")
;创建4个单选按钮,名称从配置文件里读取
$radio[1] = GUICtrlCreateRadio($setA & "(&A)", 20, 230, 70, 20)
$radio[2] = GUICtrlCreateRadio($setB & "(&B)", 20, 260, 70, 20)
$radio[3] = GUICtrlCreateRadio($setC & "(&C)", 120, 230, 70, 20)
$silent = GUICtrlSetState($radio[3], $GUI_CHECKED)
$silent = propose()
$radio[4] = GUICtrlCreateRadio($setD & "(&D)", 120, 260, 70, 20)
For $i = 0 To $s - 1
$start2 = GUICtrlSetState($radio[$i], $GUI_DISABLE)
Next
$Group3 = GUICtrlCreateGroup("安装目录", 215, 215, 255, 70)
$InstallPath = "C:\Program Files"
$input1 = GUICtrlCreateInput($InstallPath, 220, 245, 160, 20)
$start3 = GUICtrlSetState($input1, $GUI_DISABLE)
$Button1 = GUICtrlCreateButton("浏览(&O)", 400, 245, 60, 20)
$start4 = GUICtrlSetState($Button1, $GUI_DISABLE)
$Labtime = GUICtrlCreateLabel("", 10, 295, 165, 20, $WS_EX_STATICEDGE)
$pro = GUICtrlCreateProgress(10, 310, 280, 20)
$Button2 = GUICtrlCreateButton("手动选择(&X)", 300, 310, 80, 20)
$Button3 = GUICtrlCreateButton("开始安装(&S)", 390, 310, 80, 20)
$copyright = GUICtrlCreateLabel("自由天空技术论坛(Http://Www.FreeSkyCD.Cn/)", 220, 345, 300, 20)
$start5 = GUICtrlSetState($copyright, $GUI_DISABLE)
If $state = 1 Or $state = "" Then
GUISetState(@SW_SHOW)
ElseIf $state = 0 Then
GUISetState(@SW_HIDE)
EndIf
;以下为倒计时设置
AdlibEnable("pro1", 10 * $time)
$wait = 0
Func pro1()
$start6 = GUICtrlSetData($pro, $wait)
For $v = 0 To $time Step 1
  If GUICtrlRead($pro) = $v * 10 / ($time / 10) Then GUICtrlSetData($Labtime, $time - $v & "秒后自动安装所选项")
Next
$wait = $wait + 1
If $wait = 101 Then AZ()
EndFunc   ;==>pro1
;以下为设置窗口事件
While 1
$nMsg = GUIGetMsg()
Select
  Case $nMsg = $GUI_EVENT_CLOSE
   AdlibDisable()
   ExitLoop
  Case $nMsg = $radio[1] And BitAND(GUICtrlRead($radio[1]), $GUI_CHECKED) = $GUI_CHECKED
   $all = all()
  Case $nMsg = $radio[2] And BitAND(GUICtrlRead($radio[2]), $GUI_CHECKED) = $GUI_CHECKED
   $none = none()
  Case $nMsg = $radio[3] And BitAND(GUICtrlRead($radio[3]), $GUI_CHECKED) = $GUI_CHECKED
   $propose = propose()
  Case $nMsg = $radio[4] And BitAND(GUICtrlRead($radio[4]), $GUI_CHECKED) = $GUI_CHECKED
   $small = small()
  Case $nMsg = $Button1
   $open = open()
  Case $nMsg = $Button2
   $XZ = XZ()
  Case $nMsg = $Button3
   $AZ = AZ()
EndSelect
WEnd
;全部选中
Func all()
AdlibDisable()
For $i = 0 To $N - 1
  If $softname[$i] And $softPath[$i] <> "" Then
   GUICtrlSetState($soft[$i], $GUI_CHECKED)
  Else
   GUICtrlSetState($soft[$i], $GUI_UNCHECKED)
  EndIf
Next
EndFunc   ;==>all
;全部不选
Func none()
AdlibDisable()
For $i = 0 To $N - 1
  If $softname[$i] And $softPath[$i] <> "" Then
   GUICtrlSetState($soft[$i], $GUI_UNCHECKED)
  Else
   GUICtrlSetState($soft[$i], $GUI_UNCHECKED)
  EndIf
Next
EndFunc   ;==>none
;推荐安装
Func propose()
AdlibDisable()
For $i = 0 To $N - 1
  If StringInStr(String($chooseC), $i) Then
   If $softname[$i] And $softPath[$i] <> "" Then
    GUICtrlSetState($soft[$i], $GUI_CHECKED)
   Else
    GUICtrlSetState($soft[$i], $GUI_UNCHECKED)
   EndIf
  Else
   GUICtrlSetState($soft[$i], $GUI_UNCHECKED)
  EndIf
Next
EndFunc   ;==>propose
;最少安装
Func small()
AdlibDisable()
none()
For $i = 0 To $N - 1
  If StringInStr(String($chooseD), $i) Then
   If $softname[$i] And $softPath[$i] <> "" Then
    GUICtrlSetState($soft[$i], $GUI_CHECKED)
   Else
    GUICtrlSetState($soft[$i], $GUI_UNCHECKED)
   EndIf
  EndIf
Next
EndFunc   ;==>small
;设置安装目录
Func open()
AdlibDisable()
$InstallPath = FileSelectFolder("选择安装目录", "")
If Not @error Then
  If StringRight($InstallPath, 1) = "\" Then
   GUICtrlSetData($input1, $InstallPath & "")
  Else
   GUICtrlSetData($input1, $InstallPath & "\")
  EndIf
  ;MsgBox(4096, "测试", $InstallPath)
EndIf
EndFunc   ;==>open
;设置选择
Func XZ()
AdlibDisable()
GUICtrlSetData($Labtime, "*手动选择*")
For $i = 0 To $N - 1
  GUICtrlSetState($soft[$i], $GUI_ENABLE)
  GUICtrlSetState($input1, $GUI_ENABLE)
  GUICtrlSetState($Button1, $GUI_ENABLE)
  GUICtrlSetState($radio[1], $GUI_ENABLE)
  GUICtrlSetState($radio[2], $GUI_ENABLE)
  GUICtrlSetState($radio[3], $GUI_ENABLE)
  GUICtrlSetState($radio[4], $GUI_ENABLE)
Next
EndFunc   ;==>XZ
;设置安装
Func AZ()
AdlibDisable()
GUICtrlSetData($Labtime, "*安装所选*")
For $i = 0 To $N - 1
  If $softPath[$i] <> "" And GUICtrlRead($soft[$i]) = $GUI_CHECKED Then
   RunWait(@ScriptDir & "\" & $softPath[$i] & " " & $InstallPath)
   ;MsgBox(4096, "测试",@ScriptDir & "\" & $softPath[$i]&$InstallPath)
  Else
   GUICtrlSetState($soft[$i], $GUI_DISABLE)
  EndIf
Next
Exit
EndFunc   ;==>AZ