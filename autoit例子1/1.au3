;hotKeySet("!a", "ShowMessage")          ;ALT+a 注释符号（；）
;HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z
#include <GUIConstants.au3> 
GUICreate ( "病毒 - wglm.net", 200, 60) 
GUISetState (@SW_SHOW) 
GUICtrlCreateLabel("欢迎点击我，我是最新的病毒",10,10,190,15) 
GUICtrlCreateLabel("你的系统已经被安装最新的病毒了。",10,25,190,35) 
;While 1 
;$msg = GUIGetMsg() 
;If $msg = $GUI_EVENT_CLOSE Then ExitLoop 
;Wend 
;Func ShowMessage()   ;Func的意思创建自定义函数
  Dim $i=MsgBox(1,"重启系统吗？","确定重启系统吗？重启后必须用光盘重新安装系统，因为我已经删除电脑里面的所有ghost文件和ISO文件")
  if  $i<>2  Then
    Exit 0
  EndIf
;EndFunc
While 1 
$msg = GUIGetMsg() 
if $msg = $GUI_EVENT_CLOSE Then ExitLoop 
Wend 
;Func ShowMessage()   ;Func的意思创建自定义函数
  Dim $i=MsgBox(1,"退出公告","确定退出公告吗？你先了解一下本网吧的注意事项")
  if  $i<>2  Then
    Exit 0
EndIf
;EndFunc
While 1 
$msg = GUIGetMsg() 
if $GUI_EVENT_MINIMIZE Then ExitLoop 
Wend