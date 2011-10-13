
;--- AutoIt Macro Generator V 0.21 beta ---
HotKeySet("!a", "ShowMessage")          ;ALT+a 注释符号（；）
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z

$i = 0
Do
Opt("WinTitleMatchMode", 4)
WinWait("FT-200W","")
;AutoIt supports no Owner drawn Buttons (or CheckBoxes, RadioButtons and Groupboxes: only ControlClick is possible...
ControlClick("FT-200W","","Button7")
WinWait("打开","查找范围(&I):")
$CLVItem = ControlListView("打开","查找范围(&I):","SysListView321","FindItem","Stormchasers_Demo.wmv")
ControlListView("打开","查找范围(&I):","SysListView321","SelectClear")
ControlListView("打开","查找范围(&I):","SysListView321","Select",$CLVItem)
ControlClick("打开","查找范围(&I):","Button2")
Sleep(60000)
WinWait("FT-200W","")
;AutoIt supports no Owner drawn Buttons (or CheckBoxes, RadioButtons and Groupboxes: only ControlClick is possible...
ControlClick("FT-200W","","Button7")
Sleep(5000)
$i = $i + 1
Until $i = 960
Func ShowMessage()   ;Func的意思创建自定义函数
    Dim $i=MsgBox(1,"退出脚本","确定退出脚本吗")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc

;--- End ---