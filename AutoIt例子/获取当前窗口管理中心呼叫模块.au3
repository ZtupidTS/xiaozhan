hotKeySet("!a", "ShowMessage")          ;ALT+a 注释符号（；）
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z
Break(0)                                ;禁止用户从脚本程序的托盘菜单中退出
Opt("TrayIconHide", 1)                  ;隐藏 AutoIt 托盘图标.注意:托盘图标仍会在程序刚运行时出现大约 750 毫秒
While 1
WinWaitActive("[CLASS:#32770]")         ;等待窗口
$text = WinGetClassList("[CLASS:#32770]", "")   ;获取指定窗口的所有控件类的列表
Sleep(3000) 
ControlClick( "", "", "[ID:1050]")
Sleep(3000) 
ControlClick( "", "", "[ID:1051]")
Sleep(5000) 
ControlClick( "", "", "[ID:1050]")
Sleep(3000) 
WEnd
Func ShowMessage()   ;Func的意思创建自定义函数
    Dim $i=MsgBox(1,"退出脚本","确定退出脚本吗")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc

