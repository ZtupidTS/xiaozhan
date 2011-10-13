;#NoTrayIcon
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Form1", 624, 276, 0, 0)
$Edit1 = GUICtrlCreateEdit("", 8, 8, 345, 233, BitOR($ES_AUTOVSCROLL,$ES_AUTOHSCROLL,$ES_WANTRETURN,$WS_VSCROLL))
$Button1 = GUICtrlCreateButton("停止", 488, 160, 113, 33)
$Label1 = GUICtrlCreateLabel("预设超时时间为100ms", 472, 216, 119, 17)
$Label2 = GUICtrlCreateLabel("只显示异常情况", 368, 216, 88, 17)
$Button2 = GUICtrlCreateButton("开始", 376, 160, 105, 33)
$Input1 = GUICtrlCreateInput("192.168.0.254", 440, 32, 153, 21)
$Input2 = GUICtrlCreateInput("www.baidu.com", 440, 96, 153, 21)
$Input3 = GUICtrlCreateInput("59.39.30.0", 440, 64, 153, 21)
$Label3 = GUICtrlCreateLabel("网吧网关", 384, 40, 52, 17)
$Label4 = GUICtrlCreateLabel("电信网关", 384, 72, 52, 17)
$Label5 = GUICtrlCreateLabel("互联网地址", 376, 104, 64, 17)
$data = GUICtrlCreateGroup("设置", 360, 8, 257, 233)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
$var1="192.168.0.254"
$var2="www.163.cc"
$timeout=200
$Timer = DllCallbackRegister("pingurl", "int","hwnd;uint;uint;dword")
$TimerDLL = DllCall("user32.dll", "uint", "SetTimer", "hwnd", 0, "uint", 0, "int", 1000, "ptr", DllCallbackGetPtr($Timer))
dim $res1 
dim $res2
dim $turn=0
While 1
        $nMsg = GUIGetMsg()
if $turn==1 then        
                if BitAND($res1,$res2) Then
        GUICtrlSetData ($Edit1,@MDAY&"日"&@HOUR&"时"&@MIN&"分"&@SEC&"秒-"&"全部测试成功"&@CRLF," ")
EndIf
        if $res1==0 AND $res2==0 Then
        GUICtrlSetData ($Edit1,@MDAY&"日"&@HOUR&"时"&@MIN&"分"&@SEC&"秒-"&"全部测试失败"&@CRLF," ")
EndIf
        if $res1==1 AND $res2==0 Then
        GUICtrlSetData ($Edit1,@MDAY&"日"&@HOUR&"时"&@MIN&"分"&@SEC&"秒-"&"内网正常！外网失败！"&@CRLF," ")
EndIf
        if $res1==0 AND $res2==1 Then
        GUICtrlSetData ($Edit1,@MDAY&"日"&@HOUR&"时"&@MIN&"分"&@SEC&"秒-"&"外网正常！内网失败！"&@CRLF," ")
EndIf
$turn=0
EndIf
        Switch $nMsg
                Case $GUI_EVENT_CLOSE
                        Exit
EndSwitch
WEnd

func pingurl($hWnd, $uiMsg, $idEvent, $dwTime)
        $res1=ping($var1,$timeout)
        $res2=ping($var2,$timeout)
        $turn=1
EndFunc