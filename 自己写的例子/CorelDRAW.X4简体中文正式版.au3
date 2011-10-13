#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=Preview_Extras.ico
#AutoIt3Wrapper_outfile=CorelDRAW.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
HotKeySet("!1", "ShowMessage")          ;ALT+a 注释符号（；）
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z


 Dim $i=MsgBox(1,"安装提示","请把本程序放到CorelDRAW.X4简体中文正式版安装文件夹中" & @CR & "点确定继续运行安装程序" & @CR & "点击取消退出程序" & @CR & "确定本程序放到CorelDRAW.X4简体中文正式版安装文件夹中在点确定")
    if  $i<>1  Then
    Exit 0
	EndIf
Run(@scriptdir & "\autorun.exe")

;$sj=IniRead(@scriptdir & "\安装路径.ini","sj","sj","")
;$mz=IniRead(@scriptdir & "\安装路径.ini","mz","mz","")
;$xlh=IniRead(@scriptdir & "\安装路径.ini","xlh","xlh","")
;$lj=IniRead(@scriptdir & "\安装路径.ini","lj","lj","")

WinWait("CorelDRAW Graphics Suite X4")
Sleep(3000)
ControlClick("CorelDRAW Graphics Suite X4","",59648,"left",2,387, 145)
If WinExists("CorelDRAW Graphics Suite X4") Then
	$begin = TimerInit()
 Sleep(40000)
$dif = TimerDiff($begin)
   
EndIf

ControlClick("CorelDRAW Graphics Suite X4","","[CLASS:Internet Explorer_Server; INSTANCE:1]","left",1,37, 536)
ControlClick("CorelDRAW Graphics Suite X4","","[CLASS:Internet Explorer_Server; INSTANCE:1]","left",1,572, 575)



WinWait("CorelDRAW Graphics Suite X4")

Sleep(1000)
ControlClick("CorelDRAW Graphics Suite X4","","[CLASS:Internet Explorer_Server; INSTANCE:1]","left",3,107, 249)
Sleep(1000)
Send("xiaoxiao")
Sleep(1000)
ControlClick("CorelDRAW Graphics Suite X4","","[CLASS:Internet Explorer_Server; INSTANCE:1]","left",1,257, 297)
Sleep(1000)
Send("DR14B41DM4LD83SJ77AKMKDN7C4YFQ6SS")
Sleep(3000)
ControlClick("CorelDRAW Graphics Suite X4","","[CLASS:Internet Explorer_Server; INSTANCE:1]","left",1,585, 575)
ControlClick("CorelDRAW Graphics Suite X4","","[CLASS:Internet Explorer_Server; INSTANCE:1]","left",3,408, 496)
Send("e:\Corel\CorelDRAW Graphics Suite X4\")
Sleep(3000)
ControlClick("CorelDRAW Graphics Suite X4","","[CLASS:Internet Explorer_Server; INSTANCE:1]","left",1,343, 127)
ControlClick("CorelDRAW Graphics Suite X4","","[CLASS:Internet Explorer_Server; INSTANCE:1]","left",1,35, 208)
ControlClick("CorelDRAW Graphics Suite X4","","[CLASS:Internet Explorer_Server; INSTANCE:1]","left",1,38, 274)
ControlClick("CorelDRAW Graphics Suite X4","","[CLASS:Internet Explorer_Server; INSTANCE:1]","left",1,673, 575)


Func ShowMessage()   ;Func的意思创建自定义函数
    Dim $i=MsgBox(1,"退出脚本","确定退出脚本吗")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc

;#Include <WinAPIEx.au3>
;_WinAPI_EnumChildWindows( $hWnd[, $fVisible] )