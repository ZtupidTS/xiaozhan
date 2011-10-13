HotKeySet("!a", "ShowMessage")          ;ALT+a 注释符号（；）
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z
;登录模块
Run("C:\Documents and Settings\Administrator\桌面\testtools\tools\testtool.exe","C:\Documents and Settings\Administrator\桌面\testtools\tools", "")
Sleep(2000)  ;使脚本暂停指定时间段.;(5000为5秒)
Opt("WinTitleMatchMode", 4)
WinWait("testtool","",5)
BlockInput(1)
$var = ControlGetText("testtool", "", "[ID:1012]")
ControlClick("testtool", "", "[ID:1012]")
WinWaitActive("testtool")
ControlSend("testtool", "", "[ID:1012]", "000f090001");ControlSend不支持中文
;Send("000f090001")  ;
BlockInput(0)

BlockInput(1)
$var = ControlGetText("testtool", "", "[ID:1016]")
ControlClick("testtool", "", "[ID:1016]")
WinWaitActive("testtool")
ControlSend("testtool", "", "[ID:1016]", "030009021108")
;Send("030009021108")  ;
BlockInput(0)



Func ShowMessage()   ;Func的意思创建自定义函数
    Dim $i=MsgBox(1,"退出脚本","确定退出脚本吗")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc
