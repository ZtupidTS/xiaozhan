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
  Dim $i=MsgBox(1,"真的退出吗","如果你真的点确定那么你电脑永远打不开")
  if  $i<>2  Then
    Exit 0
EndIf
;EndFunc
While 1 
$msg = GUIGetMsg() 
if $GUI_EVENT_CLOSE Then ExitLoop 
Wend
  Dim $i=MsgBox(1,"你电脑死了","你永远退出不了这个病毒了")
  ;if  $i<>2  Then
   ; Exit 0
;EndIf
;EndFunc
While 1 
$msg = GUIGetMsg() 
if 0 Then ExitLoop 
Wend
