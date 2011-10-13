#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=D:\软件\文件图标替换工具\ICO\OTHER\BLUEB~56.ICO
#AutoIt3Wrapper_outfile=定时关机 工具.exe
#AutoIt3Wrapper_Res_Fileversion=0.0.0.0
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <GUIConstants.au3>
#include <DateTimeConstants.au3>
#Include <Constants.au3>
$Exists = "关机助手";判断是否只运行一个程序
If WinExists($Exists) Then 
        MsgBox(32,"温馨提醒您:","程序已经运行!")
        Exit 
EndIf
        
;AutoItWinSetTitle($Exists);修改程序窗口的标题名
FileCreateShortcut(@AutoItExe,@DesktopCommonDir&"\定时工具");自动在桌面创建快捷方式!
$Combo1 = GUICtrlCreateCombo("", 120, 95, 80, 25);组合列表
$R1 = ""
$T1 = ""
$T2 = ""
$T3 = ""
$T4 = ""
$S1 = ""
$W1="0"
$W2="0"
$W3="0"
$W4="0"
$W5="0"
$W6="0"
$W7="0"

$Form0= GUICreate("关机助手", 420, 380, 500, 300);前面二个是大小，后面二个是坐标
$Group1 = GUICtrlCreateGroup("关机时间设定（默认为每天）", 20, 110, 380, 95);前面二个是框坐标,后面是大小
GUICtrlSetColor(-1,0x666666)
$Checkbox1 = GUICtrlCreateCheckbox("星期一", 40, 130, 65, 25);前面二个是坐标,后面是自己占用大小
$Checkbox2 = GUICtrlCreateCheckbox("星期二", 110, 130, 65, 25)
$Checkbox3 = GUICtrlCreateCheckbox("星期三", 180, 130, 65, 25)
$Checkbox4 = GUICtrlCreateCheckbox("星期四", 250, 130, 65, 25)
$Checkbox5 = GUICtrlCreateCheckbox("星期五", 320, 130, 65, 25)
$Checkbox6 = GUICtrlCreateCheckbox("星期六", 40, 170, 65, 25)
$Checkbox7 = GUICtrlCreateCheckbox("星期日", 110, 170, 65, 25)
$Checkbox8 = GUICtrlCreateCheckbox("每日", 180, 170, 50, 25)
$Label1 = GUICtrlCreateLabel("时间设定：", 240, 175, 65, 25)
GUICtrlSetState($Checkbox8, $GUI_CHECKED)
$Date1 = GUICtrlCreateDate("", 290, 170, 80, 20, BitOR($DTS_UPDOWN,$DTS_TIMEFORMAT,$WS_TABSTOP));时间选择控件
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("关机操作（默认强制重启）", 20, 210, 380, 50)
GUICtrlSetColor(-1,0x666666)
$Radio1 = GUICtrlCreateRadio("重启", 60, 230, 65, 25)
$Radio2 = GUICtrlCreateRadio("关机", 140, 230, 65, 25)
$Radio3 = GUICtrlCreateRadio("强制重启", 210, 230, 65, 25)
$Radio4 = GUICtrlCreateRadio("强制关机", 285, 230, 65, 25)
GUICtrlSetState($Radio3, $GUI_CHECKED)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group3 = GUICtrlCreateGroup("", 20, 13, 380, 90)
$Label2 = GUICtrlCreateLabel("关机助手《小站》", 140, 0, 120, 17)
GUICtrlSetColor(-1,0xbb0033);美化字体颜色
$Label3 = GUICtrlCreateLabel("", 290, 0, 108, 18)
GUICtrlSetColor(-1,0x440011)
$Label4 = GUICtrlCreateLabel("每周：", 30, 30, 360, 30)

$Label5 = GUICtrlCreateLabel("每天：", 30, 50, 100, 20)

$Label6 = GUICtrlCreateLabel("执行：", 30, 70, 80, 20)

GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button1 = GUICtrlCreateButton("应用设定", 120, 270, 65, 25)
GUICtrlSetColor(-1,0x110033)
$Button2 = GUICtrlCreateButton("重新设定", 250, 270, 65, 25)
GUICtrlSetColor(-1,0x110033)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group4 = GUICtrlCreateGroup("", 20, 295, 380, 75)
$Button3 = GUICtrlCreateButton("开机运行", 27, 310, 65, 25)
$Button4 = GUICtrlCreateButton("清除运行", 102, 310, 65, 25)
$Button5 = GUICtrlCreateButton("重启机器", 177, 310, 65, 25)
$Button6 = GUICtrlCreateButton("关闭机器", 252, 310, 65, 25)
$Button7 = GUICtrlCreateButton("锁定程序", 327, 310, 65, 25)
$Button8 = GUICtrlCreateButton("隐藏窗口", 27, 340, 65, 25)
$Button9 = GUICtrlCreateButton("自动登陆", 102, 340, 65, 25)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
HotKeySet("^!f", "hotkey")
Opt("TrayAutoPause",0)
If RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","时间") <> "" Then;读取注册表指定的值
        Opt("TrayMenuMode",0)
                Opt("TrayIconHide",0) 
        
EndIf

While 1
        $Tray = TrayGetMsg();得到一个系统托盘图标项目产生的事件.
        $msg = GUIGetMsg(1);捕获窗口消
        Select
        Case $msg[0] = $GUI_EVENT_CLOSE And $msg[1] = $Form0;如果点下的是$GUI_EVENT_CLOSE(关闭)
                Exit
                Case $msg[0] = $Button3
                RegRun();操作Func RegRun()设定事件
                MsgBox(0,"温馨提醒您:","已经在注册表写入开机自启动,请勿移动本程序到别的位置.")
                Case $msg[0] = $Button4
                RegDelete("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run","定时工具")
                        MsgBox(0,"温馨提醒您:","开机自动启动已从注册表中移除")        
        Case $msg[0] = $Button5
                Shutdown(1);关机
        Case $msg[0] = $Button6
                Shutdown(2);重启        
                Case $msg[0] = $Button7
                MsgBox(32,"温馨提醒您:","程序开发中!")        
                Case $msg[0] = $Button8
                Opt("TrayIconHide", 1) ;隐藏托盘区图标
                                Opt("TrayMenuMode",1)
                                GUISetState(@SW_HIDE,$Form0)
                Case $msg[0] = $Button9
                                Run("rundll32.exe netplwiz.dll,UsersRunDll") 
                                Run("control userpasswords2")
        Case $msg[0] = $GUI_EVENT_MINIMIZE;对话框窗口被最小化
                Opt("TrayMenuMode",1)
                GUISetState(@SW_HIDE,$Form0)
                TrayTip("关机助手","点击还原!",5,1)
        Case $msg[0] = $Button2
                RegDelete("HKEY_LOCAL_MACHINE\SOFTWARE\TIME")
                GUICtrlSetData($Label4,"执行时间: 暂时未设置定时任务")
                TrayTip("通知","当前任务已经清理完毕,可重新设定.",1,2)
                Case $msg[0] = $Button1
                                RegDelete("HKEY_LOCAL_MACHINE\SOFTWARE\TIME")
        $SET = GUICtrlRead($Date1)
                        If StringLen($SET) = 7 Then
                        $SET = "0"&$SET
            EndIf
                        If GUICtrlRead($Radio1,0)=1 Then
                                $S1="重启"
                        ElseIf GUICtrlRead($Radio2,0)=1 Then
                                $S1="关机"                                
                        ElseIf GUICtrlRead($Radio3,0)=1 Then
                                $S1="强制重启"
                        ElseIf GUICtrlRead($Radio4,0)=1 Then
                                $S1="强制关机"        
                        ElseIf GUICtrlRead($Radio1,0)<>1 Or GUICtrlRead($Radio2,0)<>1 Or GUICtrlRead($Radio3,0)<>1 Or GUICtrlRead($Radio3,0)<>1 Then
                                $S1="强制重启"                
                        EndIf
                $W1=GUICtrlRead($Checkbox1,1)
                $W2=GUICtrlRead($Checkbox2,0)
                $W3=GUICtrlRead($Checkbox3,0)
                $W4=GUICtrlRead($Checkbox4,0)
                $W5=GUICtrlRead($Checkbox5,0)
                $W6=GUICtrlRead($Checkbox6,0)
                $W7=GUICtrlRead($Checkbox7,0)
                $W8=GUICtrlRead($Checkbox8,0)        
                ToolTip("1" & $W1 & "2" & $W2 & "3"  & $W3 & "4" & $W4 & "5"& $W5&  "6"& $W6 & "7"& $W7& "8" & $W8 & "......",0,0)
                Sleep(1000)
                If $W8=1 And ($W1=1 Or $W2=1 Or $W3=1 Or $W4=1 Or $W5=1 Or $W6=1 Or $W7=1 ) then
                    $WEEK8="每日"
                        RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","每日","REG_SZ",$WEEK8)         
                Else
                        $WEEK8="每日"                
                        RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","每日","REG_SZ",$WEEK8) 
                EndIf
                 If $W1=1 Then
                        $WEEK1="星期一"
                        RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","星期一","REG_SZ",$WEEK1) 
                  EndIf
                  If $W2=1 Then
                        $WEEK2="星期二"
                        RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","星期二","REG_SZ",$WEEK2) 
                  EndIf
                  If  $W3=1 Then
                        $WEEK3="星期三"
                        RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","星期三","REG_SZ",$WEEK3) 
                  EndIf
                 If  $W4=1 Then 
                    $WEEK4="星期四"
                        RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","星期四","REG_SZ",$WEEK4) 
                  EndIf
                 If $W5=1 Then
                    $WEEK5="星期五"
                        RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","星期五","REG_SZ",$WEEK5) 
                  EndIf
                 If $W6=1=1 Then
                    $WEEK6="星期六"
                        RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","星期六","REG_SZ",$WEEK6) 
                 EndIf
                 If $W7=1=1 Then
                    $WEEK7="星期日"
                        RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","星期日","REG_SZ",$WEEK7)                         
                 EndIf
                
                RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","时间","REG_SZ",$SET)
                RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","事件","REG_SZ",$S1)
                
                
                TrayTip("通知","已经设定完成!请勿关闭程序,否则设定将不起作用.",1,2)
EndSelect
                
        Switch $Tray
                Case $TRAY_EVENT_PRIMARYDOWN;按下了鼠标左键
                        GUISetState(@SW_SHOW);激活指定窗口并使其以当前大小和位置信息显示
        EndSwitch
        $T1 = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","时间")
        $R0 = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","事件")
                $WK1 = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","星期一") 
                $WK2 = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","星期二") 
                $WK3 = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","星期三") 
                $WK4 = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","星期四") 
                $WK5 = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","星期五") 
                $WK6 = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","星期六") 
                $WK7 = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","星期日") 
                $WK8 = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","每日") 
                
        If $T2 <> $T1 Or $R0 <> $R1 Then;"<>"比较是否不相等,不相等该表达返回1否则返回0
                $R1 = $R0
                $T2 = $T1
                                If $WK8="每日" Then 
                                GUICtrlSetData($Label4,"每周:"&$WK8&"  "&$T1&"("&$R0&")")
                                Else
                GUICtrlSetData($Label4,"每周: "&$WK1&" "&$WK2&" "&$WK3&" "&$WK4&" "&$WK5&" "&$WK6&" "&$WK7&"  "&$T1&"("&$R0&")")
                                EndIf
        EndIf
        $T3 = @HOUR&":"&@MIN&":"&@SEC;$T3等于当前时间
        If $T3 <> $T4 then
                $T4 = $T3
                GUICtrlSetData($Label3,""&@MON&"月"&@MDAY&"日 "&@HOUR&":"&@MIN&":"&@SEC&"  ");修改指定控件的相关数据
        EndIf
        If $T1 = $T3 Then
                If $R0 = "关机" Then;读取注册表值,当$RO值等于组合列表"关机"时,则执行$RNOW = 1
                        $RNOW = 1;关机事件
                ElseIf $R0 = "重启" Then
                        $RNOW = 2;重启事件
                ElseIf $R0 = "待机" Then
                        $RNOW = 32;待机事件
                ElseIf $R0 = "休眠" Then
                        $RNOW = 64;休眠事件
                ElseIf $R0 = "强制关机" Then
                        $RNOW = 5;强行关机
                ElseIf $R0 = "强制重启" Then
                        $RNOW = 6;强行重启
                EndIf
                Shutdown($RNOW);shutdown关机事件
        EndIf
        If RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","时间") <> "" Then
        $T5 = StringReplace($T1,":","");替换字符串中的指定子串
        $T6 = StringReplace($T3,":","")
        If StringMid($T5,1,2)-StringMid($T6,1,2) = 0 Then
                If StringMid($T5,3,2) - StringMid($T6,3,2) = 0  Then
                        If $T5-$T6 > 0 Then
                        TrayTip("温馨提醒您:","还有"&$T5-$T6&"秒开始执行关机程序.....",10,1)
                        EndIf
                Elseif StringMid($T5,3,2)-StringMid($T6,3,2) = 1  Then
                If StringMid($T5,5,2)+60-StringMid($T6,5,2) > 0 Then
                TrayTip("温馨提醒您:","还有"&StringMid($T5,5,2)+60-StringMid($T6,5,2)&"秒开始执行关机程序.....",10,1)
                EndIf
        EndIf
EndIf
EndIf
WEnd

Func RegRun();修改注册表,添加程序开机自启动项
dim $Run='HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run'
RegWrite($Run,'定时工具','REG_SZ',@AutoItExe);@AutoItExe当前脚本的完整路径.
EndFunc;

Func hotkey()
Opt("TrayIconHide", 0) ;隐藏托盘区图标
Opt("TrayMenuMode",0)
GUISetState(@SW_SHOW,$Form0)
EndFunc;