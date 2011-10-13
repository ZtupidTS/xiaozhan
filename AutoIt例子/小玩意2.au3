;HotKeySet("!a", "ShowMessage")          ;ALT+a 注释符号（；）
;HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z
#include <GUIConstants.au3> 
GUICreate ( "公告 - wglm.net", 200, 60) 
GUISetState (@SW_SHOW) 
GUICtrlCreateLabel("欢迎光临XX网吧",10,10,190,15) 
GUICtrlCreateLabel("本网吧网速过快，请看管好随身物品。",10,25,190,35) 
;While 1 
;$msg = GUIGetMsg() 
;If $msg = $GUI_EVENT_CLOSE Then ExitLoop 
;Wend 
;Func ShowMessage()   ;Func的意思创建自定义函数
  Dim $i=MsgBox(1,"退出公告","确定退出公告吗？你先了解一下本网吧的注意事项")
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
