#cs
#include<Laninformation.au3>
$test = _NetworkAdapterInfo()
For $i = 1 To $test[0][0]
MsgBox(0,"", "��" & $i & "�������ı�־:         "&$test[$i][0] _
&@CRLF& "��" & $i & "��������״̬:         " &$test[$i][1] _
&@CRLF&"��״̬˵����7Ϊ����δ������,2Ϊ������������" _
&@CRLF&@CRLF& "��" & $i & "����������������:         " &$test[$i][2] _
&@CRLF& "��" & $i & "����������������:         " &$test[$i][3] _
&@CRLF& "��" & $i & "��������MAC��ַ:         " &$test[$i][4] _
&@CRLF& "��" & $i & "��������IP��ַ:         "&$test[$i][5]  _
&@CRLF& "��" & $i & "��������Ĭ������:         " &$test[$i][6] _
&@CRLF& "��" & $i & "����������������:         " &$test[$i][7] _
&@CRLF& "��" & $i & "����������DNS:         " &$test[$i][8] _
&@CRLF& "��" & $i & "�������Ĵ�DNS:         " &$test[$i][9] _
&@CRLF& "��" & $i & "��������ID:         " &$test[$i][10] _
&@CRLF& "��" & $i & "������PCI��Ϣ:         "&$test[$i][11] )
Next
$IPSET = MsgBox(4,"��ʾ","���濪ʼ���ԣ�ͨ��ע������õ�һ������IP��ѡ�ע�����XP�в�����Ч��")
If $IPSET = 7 Then Exit
_SetCmpNameAndIP($test[1][10],"PC88","192.168.0.88","255.255.255.0","192.168.0.1","6.2.3.9,7.8.9.88,221.5.2.3")
$red = MsgBox(4,"��ʾ","���濪ʼ���ԣ�ͨ��ע�����ȡ�ո����õ���Ϣ��ע�����XP�в�����Ч��")
If $red = 7 Then Exit
$redtest = _Radnum($test[1][10])
MsgBox(0,"","��������"&$redtest[0] _
&@CRLF& "IP��ַ:" &$redtest[1] _
&@CRLF& "��������:" &$redtest[2] _
&@CRLF& "Ĭ������:" &$redtest[3] _
&@CRLF& "DNS:" &$redtest[4])
&@CRLF& "DNS:" &$redtest[4])
#ce
Func _NetworkAdapterInfo()
;======================================================
;
; ��������:        _NetworkAdapterInfo()
; ��ϸ��Ϣ:        ��ȡϵͳ����������Ϣ
; ����ֵ˵��:
; �Զ�ά���鷽ʽ����.���� $info=_NetworkAdapterInfo()
; $info[0][0] ��������
; $info[1][0] ��һ�������ı�־
; $info[1][1] ��һ��������״̬ 
; ״̬˵����7Ϊ����δ������,2Ϊ������������
; $info[1][2] ��һ����������������
; $info[1][3] ��һ����������������
; $info[1][4] ��һ��������MAC��ַ
; $info[1][5] ��һ��������IP��ַ
; $info[1][6] ��һ��������Ĭ������
; $info[1][7] ��һ����������������
; $info[1][8] ��һ����������DNS
; $info[1][9] ��һ�������Ĵ�DNS
; $info[1][10] ��һ��������ID
; $info[1][11] ��һ������PCI��Ϣ
; �ڶ���������
; $info[2][0] �ڶ��������ı�־1
; $info[2][10] �ڶ���������ID

; ����������Ϣ�������ơ�����
; ע�⣬��UDF�����ȡ�Ѿ����õ�������
; ����:      Sanhen (gxbeiliu@163.com)
; ��վ: www.lunhui.net.cn  www.autoit.net.cn
; viplight�޸�
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
; ��������:       _SetCmpNameAndIP($AdapterID,$strComputerName,$setIP,$setZW,$setWG,$setDNS) 
; ��ϸ��Ϣ:        �޸Ļ���IP,�ͻ�����
; $AdapterID ����ID
; $strComputerName �������
; $setIP ����IP
; $setZW ��������
; $setWG Ĭ������
; $setDNS DNS
; ����:      viplight (viplight@qq.com)
; QQ: 530417369
;======================================================
$SetKey1 = "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\"
$SetKey2 = "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\"
$CtrlKey = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\"
$LanReg1 = $SetKey1 & "Services\Tcpip\Parameters\Interfaces\" & $LanID
$LanReg2 = $SetKey2 & "Services\Tcpip\Parameters\Interfaces\" & $LanID
$LanReg3 = $CtrlKey & "Services\Tcpip\Parameters\Interfaces\" & $LanID
;ͨ��ע����޸ļ������
RegWrite ($SetKey1 & "Services\Tcpip\Parameters", "NV Hostname", "REG_SZ", $strComputerName)
RegWrite ($SetKey1 & "Services\Tcpip\Parameters", "Hostname", "REG_SZ", $strComputerName)
RegWrite ($CtrlKey & "Control\ComputerName\ComputerName", "ComputerName", "REG_SZ", $strComputerName)
RegWrite ($CtrlKey & "Services\Tcpip\Parameters", "NV Hostname", "REG_SZ", $strComputerName)
RegWrite ($CtrlKey & "Services\Tcpip\Parameters", "Hostname", "REG_SZ", $strComputerName)
;��ͨ��ע����޸ļ������

;ͨ��ע����޸�IP 
RegWrite($LanReg1,"IPAddress","REG_MULTI_SZ",$setIP) 
RegWrite($LanReg2,"IPAddress","REG_MULTI_SZ",$setIP) 
RegWrite($LanReg3,"IPAddress","REG_MULTI_SZ",$setIP)
;��ͨ��ע����޸�IP

;ͨ��ע����޸��������� 
RegWrite($LanReg1,"SubnetMask","REG_MULTI_SZ",$setZW) 
RegWrite($LanReg2,"SubnetMask","REG_MULTI_SZ",$setZW) 
RegWrite($LanReg3,"SubnetMask","REG_MULTI_SZ",$setZW)
;��ͨ��ע����޸��������� 

;ͨ��ע����޸�����
RegWrite($LanReg1,"DefaultGateway","REG_MULTI_SZ",$setWG) 
RegWrite($LanReg2,"DefaultGateway","REG_MULTI_SZ",$setWG) 
RegWrite($LanReg3,"DefaultGateway","REG_MULTI_SZ",$setWG)
;��ͨ��ע����޸�����

;ͨ��ע����޸�DNS 
RegWrite($LanReg1,"NameServer","REG_SZ",$setDNS) 
RegWrite($LanReg2,"NameServer","REG_SZ",$setDNS) 
RegWrite($LanReg3,"NameServer","REG_SZ",$setDNS)
;��ͨ��ע����޸�DNS

;ͨ��ע��������Զ���ȡIPΪ�̶���ȡIP
RegWrite($LanReg3,"EnableDHCP","REG_DWORD","0")
;��ͨ��ע��������Զ���ȡIPΪ�̶���ȡIP
EndFunc   ;==>_SetCmpNameAndIP 

Func _Radnum($AdapterID)
;=============================================����ip��ַ��Ϣ��ȡ
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
;=============================================����ip��ַ��Ϣ��ȡ
EndFunc

