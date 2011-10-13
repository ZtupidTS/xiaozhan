#NoTrayIcon
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Include <Array.au3>

Global Const $NetworkAdapterInfo = _NetworkAdapterInfo()
Global $hIcons[2]

$Form1 = GUICreate("IP 地址修改器 v2.0.1.9 修正版本", 455, 257, -1, -1)
$Group1 = GUICtrlCreateGroup("手动设置", 6, 8, 441, 185)
$Label1 = GUICtrlCreateLabel("网卡选择：", 22, 32, 64, 17)
$Combo1 = GUICtrlCreateCombo("", 86, 28, 345, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
$Label2 = GUICtrlCreateLabel("计算机名：", 22, 64, 64, 17)
$Input1 = GUICtrlCreateInput("", 86, 60, 345, 21)
$Label3 = GUICtrlCreateLabel("IP地址：", 22, 96, 50, 17)
$Input2 = GUICtrlCreateInput("", 86, 92, 137, 21)
$Label4 = GUICtrlCreateLabel("子网掩码：", 230, 96, 64, 17)
$Input3 = GUICtrlCreateInput("", 294, 90, 137, 21)
$Label5 = GUICtrlCreateLabel("网关地址：", 22, 128, 64, 17)
$Input4 = GUICtrlCreateInput("", 86, 124, 137, 21)
$Label6 = GUICtrlCreateLabel("首选DNS：", 22, 160, 63, 17)
$Input5 = GUICtrlCreateInput("", 86, 156, 137, 21)
$Label7 = GUICtrlCreateLabel("备用DNS：", 230, 160, 63, 17)
$Input6 = GUICtrlCreateInput("", 294, 156, 137, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button1 = GUICtrlCreateButton("Windows自动登录设置...(&W)", 6, 202, 179, 25)
$Button2 = GUICtrlCreateButton("确定(&O)", 288, 202, 75, 25)
$Button3 = GUICtrlCreateButton("取消(&C)", 372, 202, 75, 25)
GUISetState(@SW_SHOW)
$hStatus = _GUICtrlStatusBar_Create ($Form1)
Global $aParts[2] = [350, -1]
_GUICtrlStatusBar_SetParts ($hStatus, $aParts)
_GUICtrlStatusBar_SetText ($hStatus, " IP 地址修改器 v2.0.1.9 修正版本",0)
_GUICtrlStatusBar_SetText ($hStatus, " 世纪预言", 1)
;_GUICtrlStatusBar_SetIcon ($hStatus, 0, -19, "shell32.dll")
;_GUICtrlStatusBar_SetIcon ($hStatus, 1, 221, "shell32.dll")
$hIcons[0] = _WinAPI_LoadShell32Icon (-19)
$hIcons[1] = _WinAPI_LoadShell32Icon (221)
_GUICtrlStatusBar_SetIcon ($hStatus, 0, $hIcons[0])
_GUICtrlStatusBar_SetIcon ($hStatus, 1, $hIcons[1])


For $i=1 To $NetworkAdapterInfo[0][0]
        GUICtrlSetData($Combo1,$NetworkAdapterInfo[$i][2],$NetworkAdapterInfo[$i][2])
If $NetworkAdapterInfo[$i][0] = 0 Then
        GUICtrlSetData($Combo1,"没有找到可用的网卡信息^_^")
Else
        GUICtrlSetData($Input1,@ComputerName)
        GUICtrlSetData($Input2,$NetworkAdapterInfo[$i][5])
        GUICtrlSetData($Input3,$NetworkAdapterInfo[$i][7])
        GUICtrlSetData($Input4,$NetworkAdapterInfo[$i][6])
        GUICtrlSetData($Input5,$NetworkAdapterInfo[$i][8])
        GUICtrlSetData($Input6,$NetworkAdapterInfo[$i][9])
EndIf
Next

While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
                Case $GUI_EVENT_CLOSE
                        Exit
                Case $Combo1
                        $ipset = GUICtrlRead($Combo1)
                        For $i=1 To $NetworkAdapterInfo[0][0]
                                If $NetworkAdapterInfo[$i][2] = $ipset Then
                                        GUICtrlSetData($Input1,@ComputerName)
                                        GUICtrlSetData($Input2,$NetworkAdapterInfo[$i][5])
                                        GUICtrlSetData($Input3,$NetworkAdapterInfo[$i][7])
                                        GUICtrlSetData($Input4,$NetworkAdapterInfo[$i][6])
                                        GUICtrlSetData($Input5,$NetworkAdapterInfo[$i][8])
                                        GUICtrlSetData($Input6,$NetworkAdapterInfo[$i][9])
                                EndIf
                        Next
                Case $Button1
                        Run(@ComSpec & " /c control userpasswords2","",@SW_HIDE)
                Case $Button2
                        If $NetworkAdapterInfo[0][0] = 0 Then
                                MsgBox(16,"错误","没有找到相应的网卡!")
                                Exit
                        EndIf
                        $ipset = GUICtrlRead($Combo1)
                        For $i=1 To $NetworkAdapterInfo[0][0]
                                If $NetworkAdapterInfo[$i][2] = $ipset Then
                                        _GUICtrlStatusBar_SetText($hStatus," 正在为您修改指定网吧的IP信息，请稍等...",0)
                                        ;_GUICtrlStatusBar_SetIcon ($hStatus, 0, -19, "shell32.dll")
                                        $hIcons[0] = _WinAPI_LoadShell32Icon (-19)
                                        _GUICtrlStatusBar_SetIcon ($hStatus, 0, $hIcons[0])
                                        $computer = GUICtrlRead($Input1)
                                        $readip = GUICtrlRead($Input2)
                                        $readzw = GUICtrlRead($Input3)
                                        $readwg = GUICtrlRead($Input4)
                                        $readdns1 = GUICtrlRead($Input5)
                                        $readdns2 = GUICtrlRead($Input6)
                                        _SetCmpNameAndIP($NetworkAdapterInfo[$i][10],$computer,$readip,$readzw,$readwg,$readdns1&","&$readdns2)
                                        _GUICtrlStatusBar_SetText($hStatus," 指定网卡信息已修改完毕,请重启电脑!",0)
                                        $hIcons[0] = _WinAPI_LoadShell32Icon (-19)
                                        _GUICtrlStatusBar_SetIcon ($hStatus, 0, $hIcons[0])
                                        ;_GUICtrlStatusBar_SetIcon ($hStatus, 0, -19, "shell32.dll")                                                                        
                                        $windows = MsgBox(32+4,"提示","设置完成，是否重启电脑！")
                                        If $windows = 6 Then
                                                Shutdown(6)
                                                Exit
                                        EndIf
                                EndIf
                        Next
                Case $Button3
                        Exit
                        
        EndSwitch
WEnd


Func _NetworkAdapterInfo()
    Local $colItem
    Local $objItem
    Local $colItems 
    Local $objItems
    Local $objWMIService 
    Local $Adapters[1][12]
    $Adapters[0][0] = 0
    $objWMIService = ObjGet("winmgmts:\\localhost\root\CIMV2")
    $colItem  = $objWMIService.ExecQuery("Select * FROM Win32_NetworkAdapter Where NetConnectionStatus >0", "WQL", 0x30)
    If IsObj($colItem) Then
        For $objItem In $colItem
            If $objItem.MACAddress = "00:00:00:00:00:00" Then ContinueLoop
            $Adapters[0][0] += 1
            ReDim $Adapters[UBound($Adapters) + 1][12]
            $Adapters[$Adapters[0][0]][0] += $Adapters[0][0]
            $Adapters[$Adapters[0][0]][1] = $objItem.NetConnectionStatus
            $Adapters[$Adapters[0][0]][2] = $objItem.Description
            $Adapters[$Adapters[0][0]][3] = $objItem.NetConnectionID
            $Adapters[$Adapters[0][0]][4] = $objItem.MACAddress 
                        $Adapters[$Adapters[0][0]][11] = $objItem.PNPDeviceID 
            $colItems  = $objWMIService.ExecQuery('Select * FROM Win32_NetworkAdapterConfiguration Where MACAddress = "'&$Adapters[$Adapters[0][0]][4]&'" And IPEnabled = True ' , "WQL", 0x30)                     
            If IsObj($colItems) Then
                For $objItems In $colItems
                    $Adapters[$Adapters[0][0]][5] = $objItems.IPAddress(0)
                    $Adapters[$Adapters[0][0]][6] = $objItems.DefaultIPGateway(0)
                    $Adapters[$Adapters[0][0]][7] = $objItems.IPSubnet(0)
                    $Adapters[$Adapters[0][0]][8] = $objItems.DNSServerSearchOrder(0)
                    $Adapters[$Adapters[0][0]][9] = $objItems.DNSServerSearchOrder(1)
                    $Adapters[$Adapters[0][0]][10] = $objItems.SettingID
                Next    
            EndIf
        Next
    EndIf
Return $Adapters
EndFunc

Func _SetCmpNameAndIP($LanID,$strComputerName,$setIP,$setZW,$setWG,$setDNS) 
$SetKey1 = "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\"
$SetKey2 = "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\"
$CtrlKey = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\"
$LanReg1 = $SetKey1 & "Services\Tcpip\Parameters\Interfaces\" & $LanID
$LanReg2 = $SetKey2 & "Services\Tcpip\Parameters\Interfaces\" & $LanID
$LanReg3 = $CtrlKey & "Services\Tcpip\Parameters\Interfaces\" & $LanID
RegWrite ($SetKey1 & "Services\Tcpip\Parameters", "NV Hostname", "REG_SZ", $strComputerName)
RegWrite ($SetKey1 & "Services\Tcpip\Parameters", "Hostname", "REG_SZ", $strComputerName)
RegWrite ($CtrlKey & "Control\ComputerName\ComputerName", "ComputerName", "REG_SZ", $strComputerName)
RegWrite ($CtrlKey & "Services\Tcpip\Parameters", "NV Hostname", "REG_SZ", $strComputerName)
RegWrite ($CtrlKey & "Services\Tcpip\Parameters", "Hostname", "REG_SZ", $strComputerName)
RegWrite($LanReg1,"IPAddress","REG_MULTI_SZ",$setIP) 
RegWrite($LanReg2,"IPAddress","REG_MULTI_SZ",$setIP) 
RegWrite($LanReg3,"IPAddress","REG_MULTI_SZ",$setIP)
RegWrite($LanReg1,"SubnetMask","REG_MULTI_SZ",$setZW) 
RegWrite($LanReg2,"SubnetMask","REG_MULTI_SZ",$setZW) 
RegWrite($LanReg3,"SubnetMask","REG_MULTI_SZ",$setZW)
RegWrite($LanReg1,"DefaultGateway","REG_MULTI_SZ",$setWG) 
RegWrite($LanReg2,"DefaultGateway","REG_MULTI_SZ",$setWG) 
RegWrite($LanReg3,"DefaultGateway","REG_MULTI_SZ",$setWG)
RegWrite($LanReg1,"NameServer","REG_SZ",$setDNS) 
RegWrite($LanReg2,"NameServer","REG_SZ",$setDNS) 
RegWrite($LanReg3,"NameServer","REG_SZ",$setDNS)
RegWrite($LanReg3,"EnableDHCP","REG_DWORD","0")
EndFunc 