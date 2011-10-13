#cs
#include<Laninformation.au3>
$test = _NetworkAdapterInfo()
For $i = 1 To $test[0][0]
MsgBox(0,"", "第" & $i & "块网卡的标志:         "&$test[$i][0] _
&@CRLF& "第" & $i & "块网卡的状态:         " &$test[$i][1] _
&@CRLF&"▲状态说明：7为网卡未插网线,2为网卡连接正常" _
&@CRLF&@CRLF& "第" & $i & "块网卡的网卡名称:         " &$test[$i][2] _
&@CRLF& "第" & $i & "块网卡的连接名称:         " &$test[$i][3] _
&@CRLF& "第" & $i & "块网卡的MAC地址:         " &$test[$i][4] _
&@CRLF& "第" & $i & "块网卡的IP地址:         "&$test[$i][5]  _
&@CRLF& "第" & $i & "块网卡的默认网关:         " &$test[$i][6] _
&@CRLF& "第" & $i & "块网卡的子网掩码:         " &$test[$i][7] _
&@CRLF& "第" & $i & "块网卡的主DNS:         " &$test[$i][8] _
&@CRLF& "第" & $i & "块网卡的次DNS:         " &$test[$i][9] _
&@CRLF& "第" & $i & "块网卡的ID:         " &$test[$i][10] _
&@CRLF& "第" & $i & "块网卡PCI信息:         "&$test[$i][11] )
Next
$IPSET = MsgBox(4,"提示","下面开始测试，通过注册表，设置第一张网卡IP的选项，注意此在XP中测试有效！")
If $IPSET = 7 Then Exit
_SetCmpNameAndIP($test[1][10],"PC88","192.168.0.88","255.255.255.0","192.168.0.1","6.2.3.9,7.8.9.88,221.5.2.3")
$red = MsgBox(4,"提示","下面开始测试，通过注册表，读取刚刚设置的信息，注意此在XP中测试有效！")
If $red = 7 Then Exit
$redtest = _Radnum($test[1][10])
MsgBox(0,"","机器名："&$redtest[0] _
&@CRLF& "IP地址:" &$redtest[1] _
&@CRLF& "子网掩码:" &$redtest[2] _
&@CRLF& "默认网关:" &$redtest[3] _
&@CRLF& "DNS:" &$redtest[4])
&@CRLF& "DNS:" &$redtest[4])
#ce
Func _NetworkAdapterInfo()
;======================================================
;
; 函数名称:        _NetworkAdapterInfo()
; 详细信息:        获取系统所有网卡信息
; 返回值说明:
; 以二维数组方式返回.例如 $info=_NetworkAdapterInfo()
; $info[0][0] 网卡数量
; $info[1][0] 第一块网卡的标志
; $info[1][1] 第一块网卡的状态 
; 状态说明：7为网卡未插网线,2为网卡连接正常
; $info[1][2] 第一块网卡的网卡名称
; $info[1][3] 第一块网卡的连接名称
; $info[1][4] 第一块网卡的MAC地址
; $info[1][5] 第一块网卡的IP地址
; $info[1][6] 第一块网卡的默认网关
; $info[1][7] 第一块网卡的子网掩码
; $info[1][8] 第一块网卡的主DNS
; $info[1][9] 第一块网卡的次DNS
; $info[1][10] 第一块网卡的ID
; $info[1][11] 第一块网卡PCI信息
; 第二块网卡：
; $info[2][0] 第二块网卡的标志1
; $info[2][10] 第二块网卡的ID

; 其他网卡信息依次类推。。。
; 注意，此UDF不会获取已经禁用的网卡。
; 作者:      Sanhen (gxbeiliu@163.com)
; 网站: www.lunhui.net.cn  www.autoit.net.cn
; viplight修改
;======================================================
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
EndFunc ;_NetworkAdapterInfo()

Func _SetCmpNameAndIP($LanID,$strComputerName,$setIP,$setZW,$setWG,$setDNS) 
;======================================================
; 函数名称:       _SetCmpNameAndIP($AdapterID,$strComputerName,$setIP,$setZW,$setWG,$setDNS) 
; 详细信息:        修改机器IP,和机器名
; $AdapterID 网卡ID
; $strComputerName 计算机名
; $setIP 机器IP
; $setZW 子网掩码
; $setWG 默认网关
; $setDNS DNS
; 作者:      viplight (viplight@qq.com)
; QQ: 530417369
;======================================================
$SetKey1 = "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\"
$SetKey2 = "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\"
$CtrlKey = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\"
$LanReg1 = $SetKey1 & "Services\Tcpip\Parameters\Interfaces\" & $LanID
$LanReg2 = $SetKey2 & "Services\Tcpip\Parameters\Interfaces\" & $LanID
$LanReg3 = $CtrlKey & "Services\Tcpip\Parameters\Interfaces\" & $LanID
;通过注册表修改计算机名
RegWrite ($SetKey1 & "Services\Tcpip\Parameters", "NV Hostname", "REG_SZ", $strComputerName)
RegWrite ($SetKey1 & "Services\Tcpip\Parameters", "Hostname", "REG_SZ", $strComputerName)
RegWrite ($CtrlKey & "Control\ComputerName\ComputerName", "ComputerName", "REG_SZ", $strComputerName)
RegWrite ($CtrlKey & "Services\Tcpip\Parameters", "NV Hostname", "REG_SZ", $strComputerName)
RegWrite ($CtrlKey & "Services\Tcpip\Parameters", "Hostname", "REG_SZ", $strComputerName)
;▲通过注册表修改计算机名

;通过注册表修改IP 
RegWrite($LanReg1,"IPAddress","REG_MULTI_SZ",$setIP) 
RegWrite($LanReg2,"IPAddress","REG_MULTI_SZ",$setIP) 
RegWrite($LanReg3,"IPAddress","REG_MULTI_SZ",$setIP)
;▲通过注册表修改IP

;通过注册表修改子网掩码 
RegWrite($LanReg1,"SubnetMask","REG_MULTI_SZ",$setZW) 
RegWrite($LanReg2,"SubnetMask","REG_MULTI_SZ",$setZW) 
RegWrite($LanReg3,"SubnetMask","REG_MULTI_SZ",$setZW)
;▲通过注册表修改子网掩码 

;通过注册表修改网关
RegWrite($LanReg1,"DefaultGateway","REG_MULTI_SZ",$setWG) 
RegWrite($LanReg2,"DefaultGateway","REG_MULTI_SZ",$setWG) 
RegWrite($LanReg3,"DefaultGateway","REG_MULTI_SZ",$setWG)
;▲通过注册表修改网关

;通过注册表修改DNS 
RegWrite($LanReg1,"NameServer","REG_SZ",$setDNS) 
RegWrite($LanReg2,"NameServer","REG_SZ",$setDNS) 
RegWrite($LanReg3,"NameServer","REG_SZ",$setDNS)
;▲通过注册表修改DNS

;通过注册表网卡自动获取IP为固定获取IP
RegWrite($LanReg3,"EnableDHCP","REG_DWORD","0")
;▲通过注册表网卡自动获取IP为固定获取IP
EndFunc   ;==>_SetCmpNameAndIP 

Func _Radnum($AdapterID)
;=============================================网卡ip地址信息获取
Local $info[6]
Dim $CtrlKey = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\"
Dim $LanReg = $CtrlKey & "Services\Tcpip\Parameters\Interfaces\" & $AdapterID
                $Info[0] =  RegRead($CtrlKey & "Control\ComputerName\ComputerName", "ComputerName")
                $Info[1] = RegRead($LanReg,"IPAddress")
                $Info[2] = RegRead($LanReg,"SubnetMask")
                $Info[3] = RegRead($LanReg,"DefaultGateway")
                $Info[4] = RegRead($LanReg,"NameServer")
                $Info[5] = RegRead($CtrlKey & "Services\NwlnkIpx\Parameters","VirtualNetworkNumber")
Return $info
;=============================================网卡ip地址信息获取
EndFunc

