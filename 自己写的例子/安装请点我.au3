HotKeySet("!1", "ShowMessage")          ;ALT+a 注释符号（；）
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z


Run(@scriptdir & "\setup.exe")
$title=IniRead(@scriptdir & "\安装路径.ini","title","title","")
WinWait ( "安装 - 里诺进销存管理软件(单机版)V3.28", "下一步(&N) >")
ControlClick("安装 - 里诺进销存管理软件(单机版)V3.28","下一步(&N) >","[CLASS:TButton; INSTANCE:1]")
BlockInput(1)
Send ($title) 
BlockInput(0)
ControlClick("安装 - 里诺进销存管理软件(单机版)V3.28","下一步(&N) >","[CLASS:TButton; INSTANCE:3]")
If WinActive("文件夹存在","是(&Y)") Then
    ControlClick("文件夹存在","是(&Y)","[ID:6]")	
EndIf
ControlClick("安装 - 里诺进销存管理软件(单机版)V3.28","下一步(&N) >","[CLASS:TButton; INSTANCE:4]")
ControlClick("安装 - 里诺进销存管理软件(单机版)V3.28","下一步(&N) >","[CLASS:TButton; INSTANCE:4]")
ControlClick("安装 - 里诺进销存管理软件(单机版)V3.28","安装(&I)","[CLASS:TButton; INSTANCE:4]")
BlockInput(1)
Sleep(10*1000)
BlockInput(0)
If WinExists("确认","否(&N)") Then
   ControlClick("确认","否(&N)","[ID:7]")	
EndIf

Sleep(1000)

If WinExists("确认","否(&N)") Then
   ControlClick("确认","否(&N)","[ID:7]")	
EndIf

WinWait("安装 - 里诺进销存管理软件(单机版)V3.28","完成(&F)")
ControlClick("安装 - 里诺进销存管理软件(单机版)V3.28","完成(&F)","[CLASS:TButton; INSTANCE:4]")
WinWait("里诺进销存管理软件","注册(&R)")
WinActivate ("里诺进销存管理软件","注册(&R)")
WinClose("里诺进销存管理软件")

FileCopy ( "里诺进销存管理软件(单机版)V3.28+注册机.exe",$title,1 )
FileCopy ( "里诺进销存管理软件(单机版)V3.28+补丁.exe",$title,1 )
Sleep(1000)
ShellExecute("里诺进销存管理软件(单机版)V3.28+补丁.exe","",$title)
WinWait("里诺进销存管理软件(单机版)V3.28+补丁","应用补丁")
ControlClick("里诺进销存管理软件(单机版)V3.28+补丁","应用补丁","[ID:108]")
Sleep(1000)
WinClose("里诺进销存管理软件(单机版)V3.28+补丁","应用补丁")



ShellExecute("里诺进销存管理软件(单机版)V3.28+注册机.exe","",$title)
BlockInput(1)
Sleep(2000)
Send("{enter}")
BlockInput(0)
WinWait("里诺进销存管理软件","注册(&R)")
ControlClick("里诺进销存管理软件","注册(&R)","[CLASS:TBitBtn; INSTANCE:2]")
WinWait("软件注册")
ControlClick("软件注册","注册(&R)","[CLASS:TBitBtn; INSTANCE:3]")

BlockInput(1)
Send("^c")
Send("{enter}")
BlockInput(0)
ControlClick("软件注册","确定","[ID:2]")
ControlClick("软件注册","退出(&Q)","[CLASS:TBitBtn; INSTANCE:1]")
WinClose("里诺进销存管理软件")

Sleep(2000)
ShellExecute("jxc.exe","",$title)
WinWait("里诺进销存管理软件","注册(&R)")
ControlClick("里诺进销存管理软件","注册(&R)","[CLASS:TBitBtn; INSTANCE:2]")
WinWait("软件注册")
BlockInput(1)
Send("{tab}")
Send("^v")
BlockInput(0)
ControlClick("软件注册","注册(&R)","[CLASS:TBitBtn; INSTANCE:3]")
ControlClick("软件注册","确定","[ID:2]")
ControlClick("里诺进销存管理软件","退出(&Q)","[CLASS:TBitBtn; INSTANCE:1]")


;[title]
;title=0
;FileCopy ( "ThunderUI.xml","E:\Program Files\Thunder Network\Thunder\Program",1 )


Func ShowMessage()   ;Func的意思创建自定义函数
    Dim $i=MsgBox(1,"退出脚本","确定退出脚本吗")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc

;#Include <WinAPIEx.au3>
;_WinAPI_EnumChildWindows( $hWnd[, $fVisible] )