#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=D:\AutoIt3\Aut2Exe\Icons\k-notify.ico
#AutoIt3Wrapper_outfile=临时.exe
#AutoIt3Wrapper_Res_Fileversion=0.0.0.0
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
HotKeySet("!a", "ShowMessage")          ;ALT+a 注释符号（；）
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z

$i = 0
Do

WinWait("Microsoft Internet Explorer")
WinActivate ("Microsoft Internet Explorer","确定")
ControlClick("Microsoft Internet Explorer","确定","[ID:2]")
WinActivate ("Microsoft Internet Explorer","确定")
WinClose("午夜激情电影网 - Microsoft Internet Explorer")


$i = $i + 1
Until $i = 960000000000000000000000000

Func ShowMessage()   ;Func的意思创建自定义函数
    Dim $i=MsgBox(1,"退出脚本","确定退出脚本吗")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc