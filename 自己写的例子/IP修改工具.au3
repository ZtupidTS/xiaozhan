;#NoTrayIcon
#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=ip.ico
#AutoIt3Wrapper_outfile=IP修改工具.exe
#AutoIt3Wrapper_Res_Comment=AUTOIT CN AutoIt中文论坛 http://www.autoitx.com/?fromuser=viplight
#AutoIt3Wrapper_Res_Description=IP修改工具
#AutoIt3Wrapper_Res_Fileversion=2010.3.30.3
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_LegalCopyright=AUTOIT CN AutoIt中文论坛 BY viplight
#AutoIt3Wrapper_Res_Field=viplight|QQ:530417369
#AutoIt3Wrapper_Res_Field=AUTOIT CN AutoIt中文论坛|http://www.autoitx.com/?fromuser=viplight
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#include <IPXSET.au3>
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>
#include <Laninformation.au3>
Dim $BHBUT,$Combo1,$IpSetBox,$config = "config.ini",$cfgzd = "ipsetting"
Global Const $NetworkAdapterInfo = _NetworkAdapterInfo()

If IniReadSection($config,$cfgzd) = 1 Then  _NOINIWRITEINI()
_IpSetBox()
Func _IpSetBox()
If IniReadSection($config,"cscdk") = 1 Then
        FileInstall("CSCDK",@TempDir&"\",1)
        $redcdk = IniReadSection(@TempDir&"\CSCDK","cscdk")
        For $i = 1 To $redcdk[0][0]
        IniWrite($config,"CSCDK",$redcdk[$i][0],$redcdk[$i][1])
        Next
EndIf
$IpSetBox = GUICreate("IP设置工具 10.03.30.1", 300, 240, -1, -1)
$wktslab = GUICtrlCreateLabel("", 100, 3, 134, 17)
$BHBUT = GUICtrlCreateInput("", 150, 153,48,30)
GUICtrlSetFont($BHBUT, 20, 800, 0, "楷体_GB2312")
GUICtrlSetColor($BHBUT, 0x990033)
$Combo1 = GUICtrlCreateCombo("", 0, 20, 300, 25,$CBS_DROPDOWNLIST)
$Group1 = GUICtrlCreateGroup("当前连接:", 1, 45, 300, 102)
;~ $DISABLELan = GUICtrlCreateButton("禁用此网卡", 175, 60, 88, 30)
$cmname = GUICtrlCreateLabel("计算机名: ", 10, 65, 160, 15)
$cmip = GUICtrlCreateLabel("IP地址  : ", 10, 78, 160, 15)
$cmzwym = GUICtrlCreateLabel("子网掩码: ", 10, 91, 160, 15)
$cmmrwg = GUICtrlCreateLabel("默认网关: ", 10, 104, 160, 15)
$cmdns = GUICtrlCreateLabel("DNS     : ", 10, 117, 263, 15)
$cmmac = GUICtrlCreateLabel("当前MAC : ", 10, 130, 263, 15)
$bhlabe = GUICtrlCreateLabel("请输入本机编号>", 15, 160, 128, 20)
GUICtrlSetFont($bhlabe,12, 800, 2, "楷体_GB2312")
GUICtrlSetColor($bhlabe, 0x990033)
$CFGBUT = GUICtrlCreateButton("配置", 10, 188, 88, 30)
$SETBUT = GUICtrlCreateButton("确定", 105, 188, 88, 30)
$exitbut = GUICtrlCreateButton("退出", 200, 188, 88, 30)
$btn1 = GUICtrlCreateLabel("当前时间:", 18, 225, 170, 15)

GUISetState()
$dd = "当前时间:" & @YEAR & "-" & @MON & "-" & @MDAY & " "
$q1 = ""
$q2 = ""
        For $i=1 To $NetworkAdapterInfo[0][0]
                GUICtrlSetData($wktslab,"发现("&$NetworkAdapterInfo[$i][0]&")块活动网卡^_^")
                GUICtrlSetData($Combo1,$NetworkAdapterInfo[$i][2] _
                &","&$NetworkAdapterInfo[$i][3] _
                &","&$NetworkAdapterInfo[$i][10] _
                &","&$NetworkAdapterInfo[$i][4] _
                &","&$NetworkAdapterInfo[$i][11],$NetworkAdapterInfo[1][2] _
                &","&$NetworkAdapterInfo[1][3] _
                &","&$NetworkAdapterInfo[1][10] _
                &","&$NetworkAdapterInfo[1][4] _
                &","&$NetworkAdapterInfo[1][11])
                GUICtrlSetData($Group1,"当前连接:"&$NetworkAdapterInfo[1][3])
                GUICtrlSetData($cmmac,"当前MAC : "&$NetworkAdapterInfo[1][4])
        Next 
        If $NetworkAdapterInfo[0][0] = 0 Then
                GUICtrlSetData($wktslab,"未发现网卡^_^")
                GUICtrlSetColor($wktslab, 0x990033)
        Else
                Dim $RedComBOX=GUICtrlRead($Combo1)
                Dim $SetLanName=StringTrimLeft($RedComBOX,2)
                Dim $RadCPNam = _RadCPName($NetworkAdapterInfo[1][10])
                Dim $ComPuterName = $RadCPNam[0]
                Dim $ComputerIP = $RadCPNam[1]
                Dim $ComputerZW = $RadCPNam[2]
                Dim $ComputerWG = $RadCPNam[3]
                Dim $ComputerDNS = $RadCPNam[4]
                Dim $ComputerIPX = $RadCPNam[5]

;=============================================将网卡信息写入GUI
        GUICtrlSetData($cmname,"计算机名: "&$ComPuterName)
        GUICtrlSetData($cmip,"IP地址  : "&$ComputerIP)
        GUICtrlSetData($cmzwym,"子网掩码: "&$ComputerZW)
        GUICtrlSetData($cmmrwg,"默认网关: "&$ComputerWG)
        GUICtrlSetData($cmdns,"DNS     : "&$ComputerDNS)
;=============================================将网卡信息写入GUI
        EndIf

While 1
        $q1 = @HOUR & ":" & @MIN & ":" & @SEC
        If $q1 <> $q2 Then
                $q2 = $q1
                GUICtrlSetData($btn1, $dd & @HOUR & ":" & @MIN & ":" & @SEC & "")
        EndIf
;=============================================读取INI文件信息
                Dim $BoxOneCpneq =  IniRead($config,$cfgzd,"机器前缀","")
                Dim $BoxOneIpduan = IniRead($config,$cfgzd,"IP段","")
                Dim $BoxOneResubmask =  IniRead($config,$cfgzd,"子网掩码","")
                Dim $BoxOneRegateway = IniRead($config,$cfgzd,"网关","")
                Dim $BoxOneRedns = IniRead($config,$cfgzd,"DNS","")
                Dim $BoxOneIP = IniRead($config,$cfgzd,"1号IP","")
                Dim $BoxOneIPdisplace = IniRead($config,$cfgzd,"IP偏移","")
                Dim $BoxOneMeshnumber = IniRead($config,$cfgzd,"网络号偏移","")
                Dim $BoxOneSetMeshno = IniRead($config,$cfgzd,"修改内部网络号","")                
                Dim $BoxOneSetCsCdk = IniRead($config,$cfgzd,"修改CSCDK","")                
;=============================================读取INI文件信息

;=============================================读取GUI信息
        Dim $RedComBOX=GUICtrlRead($Combo1)
        Dim $Rdbianhao=GUICtrlRead($BHBUT)
        Dim $ipmo = $Rdbianhao + $BoxOneIPdisplace
        If $Rdbianhao= 1 Then
                If $BoxOneIP <> "" Or $BoxOneIP <> 0 Then
                $Rdip = $BoxOneIpduan&"."&$BoxOneIP
                Else
                $Rdip = $BoxOneIpduan&"."&$ipmo        
                EndIf        
        Else
        $Rdip = $BoxOneIpduan&"."&$ipmo                
        EndIf
        Dim $Compname = $BoxOneCpneq&$Rdbianhao
        Dim $lanid = StringSplit($RedComBOX,",")
;=============================================读取GUI信息        




$nMsg = GUIGetMsg()
Switch $nMsg
                Case $GUI_EVENT_CLOSE,$exitbut
                        Exit
                Case $Combo1
                        Dim $RadCPNam = _RadCPName($lanid[3])
                        Dim $ComPuterName = $RadCPNam[0]
                        Dim $ComputerIP = $RadCPNam[1]
                        Dim $ComputerZW = $RadCPNam[2]
                        Dim $ComputerWG = $RadCPNam[3]
                        Dim $ComputerDNS = $RadCPNam[4]
                        Dim $ComputerIPX = $RadCPNam[5]
                        GUICtrlSetData($Group1,"当前连接:"&$lanid[2])
                        GUICtrlSetData($cmname,"计算机名: "&$ComPuterName)
                        GUICtrlSetData($cmip,"IP地址  : "&$ComputerIP)
                        GUICtrlSetData($cmzwym,"子网掩码: "&$ComputerZW)
                        GUICtrlSetData($cmmrwg,"默认网关: "&$ComputerWG)
                        GUICtrlSetData($cmdns,"DNS     : "&$ComputerDNS)
                        GUICtrlSetData($cmmac,"当前MAC : "&$lanid[4])
                Case $SETBUT
                        If $Rdbianhao > 0 And $Rdbianhao < 255 Then
                                $PDip = StringSplit($Rdip,".")
                                If $PDip[4] > 0 And $PDip[4] < 255 Then
                                        GUICtrlSetData($cmname,"计算机名: "&$Compname)
                                        GUICtrlSetData($cmip,"IP地址  : "&$Rdip)
                                        GUICtrlSetData($cmzwym,"子网掩码: "&$BoxOneResubmask)
                                        GUICtrlSetData($cmmrwg,"默认网关: "&$BoxOneRegateway)
                                        GUICtrlSetData($cmdns,"DNS     : "&$BoxOneRedns)
                                        _SetCmpNameAndIP($lanid[3],$Compname,$Rdip,$BoxOneResubmask,$BoxOneRegateway,$BoxOneRedns)
;~                                         判断IPX内部网络号
                                                        If $BoxOneSetMeshno = 1 Then
                                                                $IpxSet = $Rdbianhao + $BoxOneMeshnumber
                                                                _ipxwrite($IpxSet)
                                                        EndIf
;~                                         判断IPX内部网络号
;~                                         修改CSCDK
                                        If $BoxOneSetCsCdk = 1 Then
                                                $PDCSCDK = IniRead($config,"CSCDK","CDKey"&$PDip[4],"")
                                                RegWrite("HKEY_CURRENT_USER\Software\Valve\CounterStrike\Settings","Key","REG_SZ",$PDCSCDK)
                                        EndIf
;~                                         修改CSCDK
                                        MsgBox(0,"提示","修改完成")
                                Else        
                                        GUISetState(@SW_DISABLE,$IpSetBox)
                                        MsgBox(16,"IP运算错误!","IP必须为大于0小于255的数字,请检查IP偏移设置再重新输入")
                                        GUISetState(@SW_ENABLE,$IpSetBox)
                                EndIf
                        Else        
                                GUISetState(@SW_DISABLE,$IpSetBox)
                                MsgBox(16,"编号输入错误!","编号必须为大于0小于255的数字,请检查IP偏移设置或重新输入")
                                GUISetState(@SW_ENABLE,$IpSetBox)
                        EndIf
                Case $CFGBUT
                        _SettingBox()
EndSwitch
WEnd
EndFunc ;_IpSetBox()
Func _SettingBox()
        GUISetState(@SW_HIDE,$IpSetBox)
Dim $config = "config.ini",$cfgzd = "ipsetting"
Dim $Cpneq =  IniRead($config,$cfgzd,"机器前缀","")
Dim $ipduan = IniRead($config,$cfgzd,"IP段","")
Dim $resubmask =  IniRead($config,$cfgzd,"子网掩码","")
Dim $regateway = IniRead($config,$cfgzd,"网关","")
Dim $redns = IniRead($config,$cfgzd,"DNS","")
Dim $oneIP = IniRead($config,$cfgzd,"1号IP","")
Dim $IPdisplace = IniRead($config,$cfgzd,"IP偏移","")
Dim $Meshnumber = IniRead($config,$cfgzd,"网络号偏移","")
Dim $SetMeshno = IniRead($config,$cfgzd,"修改内部网络号","")
        $IpSetBox1 = GUICreate("修改配置", 280, 192, -1, -1)
        $exitbutt = GUICtrlCreateButton("返回", 140, 170, 130, 20)
        $Group1 = GUICtrlCreateGroup("网络配置", 10, 5, 260, 160)
        $Label1 = GUICtrlCreateLabel("机器名前缀: ", 15, 23, 67, 15)
        $Input1 = GUICtrlCreateInput($Cpneq, 80, 20,65,20)
        $Label2 = GUICtrlCreateLabel("IP段: ", 15, 49, 30, 15)
        $Input2 = GUICtrlCreateInput($ipduan, 45, 45, 100, 20)
        $Label3 = GUICtrlCreateLabel("掩码: ", 15, 73, 30, 15)
        $Input3 = GUICtrlCreateInput($resubmask, 45, 70, 100, 20)
        $Label4 = GUICtrlCreateLabel("网关: ", 15, 98, 30, 15)
        $Input4 = GUICtrlCreateInput($regateway, 45, 95, 100, 20)
        $Label5 = GUICtrlCreateLabel("DNS : ", 15, 123, 30, 15)
        $Input5 = GUICtrlCreateInput($redns, 45, 120, 220, 20)
        $Label6 = GUICtrlCreateLabel("1号机 IP  :", 155, 23, 66, 15)
        $Input6 = GUICtrlCreateInput($oneIP, 220, 20, 43, 20)
        GUICtrlSetTip($Input6,"当“1号机 IP”为空或是为“0”时，“1号机 IP”将为IP偏移加机器编号")
        $Label7 = GUICtrlCreateLabel("IP 偏移   :", 155, 49, 66, 15)
        $Input7 = GUICtrlCreateInput($IPdisplace, 220, 45, 43, 20)
        $Label8 = GUICtrlCreateLabel("网络号偏移:", 155, 97, 66, 15)
        $Input8 = GUICtrlCreateInput($Meshnumber, 220, 94, 43, 20)
        $Checkbox1 = GUICtrlCreateCheckbox("修改内部网络号", 155, 73, 100, 20)
        If IniRead($config,$cfgzd,"修改内部网络号","") = 0 Then
                GUICtrlSetState($Input8, $GUI_DISABLE)
                GUICtrlSetState($Checkbox1, $GUI_UNCHECKED)
        ElseIf  IniRead($config,$cfgzd,"修改内部网络号","") = 1 Then
                GUICtrlSetState($Checkbox1, $GUI_CHECKED)
                GUICtrlSetState($Input8, $GUI_ENABLE)
        EndIf
        $Checkbox3 = GUICtrlCreateCheckbox("解压预置CSCDK", 160, 142, 100, 20)
        GUICtrlSetTip($Checkbox3,"当配置文件里，没有CSCDK的关键字段，CSCDK配置才会解压")
        If IniRead($config,$cfgzd,"解压预置CSCDK","") = 0 Then
                GUICtrlSetState($Checkbox3, $GUI_UNCHECKED)
        ElseIf  IniRead($config,$cfgzd,"解压预置CSCDK","") = 1 Then
                GUICtrlSetState($Checkbox3, $GUI_CHECKED)
        EndIf
        $Checkbox2 = GUICtrlCreateCheckbox("修改CSCDK", 30, 142, 100, 20)
        If IniRead($config,$cfgzd,"修改CSCDK","") = 0 Then
                GUICtrlSetState($Checkbox3, $GUI_DISABLE)
                GUICtrlSetState($Checkbox2, $GUI_UNCHECKED)
        ElseIf  IniRead($config,$cfgzd,"修改CSCDK","") = 1 Then
                GUICtrlSetState($Checkbox2, $GUI_CHECKED)
                GUICtrlSetState($Checkbox3, $GUI_ENABLE)
        EndIf
        $setBUTt = GUICtrlCreateButton("确定", 10, 170, 130, 20)

        GUISetState()
        While 1
                $nMsg = GUIGetMsg()
                Switch $nMsg
                        Case $GUI_EVENT_CLOSE,$exitbutt
                                GUISetState(@SW_HIDE,$IpSetBox1)
                                _IpSetBox()
                        Case  $Checkbox1
                                        If GUICtrlRead($Checkbox1) = $GUI_UNCHECKED Then
                                                GUICtrlSetState($Input8, $GUI_DISABLE)
                                        ElseIf GUICtrlRead($Checkbox1) = $GUI_CHECKED Then
                                                GUICtrlSetState($Input8, $GUI_ENABLE)
                                        EndIf
                        Case  $Checkbox2
                                        If GUICtrlRead($Checkbox2) = $GUI_UNCHECKED Then
                                                GUICtrlSetState($Checkbox3, $GUI_DISABLE)
                                        ElseIf GUICtrlRead($Checkbox2) = $GUI_CHECKED Then
                                                GUICtrlSetState($Checkbox3, $GUI_ENABLE)
                                        EndIf
                        Case $setBUTt
                                        $redi1=GUICtrlRead($Input1)
                                        $redi2=GUICtrlRead($Input2)
                                        $redi3=GUICtrlRead($Input3)
                                        $redi4=GUICtrlRead($Input4)
                                        $redi5=GUICtrlRead($Input5)
                                        $redi6=GUICtrlRead($Input6)
                                        $redi7=GUICtrlRead($Input7)
                                        $redi8=GUICtrlRead($Input8)
                                        IniWrite($config,$cfgzd,"机器前缀",$redi1)
                                        IniWrite($config,$cfgzd,"IP段",$redi2)
                                        IniWrite($config,$cfgzd,"子网掩码",$redi3)
                                        IniWrite($config,$cfgzd,"网关",$redi4)
                                        IniWrite($config,$cfgzd,"DNS",$redi5)
                                        IniWrite($config,$cfgzd,"1号IP",$redi6)
                                        IniWrite($config,$cfgzd,"IP偏移",$redi7)
                                        IniWrite($config,$cfgzd,"网络号偏移",$redi8)
                                        If GUICtrlRead($Checkbox1) = $GUI_CHECKED Then
                                                IniWrite($config,$cfgzd,"修改内部网络号","1")
                                        ElseIf GUICtrlRead($Checkbox1) = $GUI_UNCHECKED Then
                                                IniWrite($config,$cfgzd,"修改内部网络号","0")
                                        EndIf
                                        If GUICtrlRead($Checkbox2) = $GUI_CHECKED Then
                                                IniWrite($config,$cfgzd,"修改CSCDK","1")
                                        ElseIf GUICtrlRead($Checkbox2) = $GUI_UNCHECKED Then
                                                IniWrite($config,$cfgzd,"修改CSCDK","0")
                                        EndIf
                                        If GUICtrlRead($Checkbox3) = $GUI_CHECKED Then
                                                IniWrite($config,$cfgzd,"解压预置CSCDK","1")
                                        ElseIf GUICtrlRead($Checkbox3) = $GUI_UNCHECKED Then
                                                IniWrite($config,$cfgzd,"解压预置CSCDK","0")
                                        EndIf
                                        GUISetState(@SW_HIDE,$IpSetBox1)
                                        _IpSetBox()
                EndSwitch
        WEnd
EndFunc


Func _RadCPName($AdapterID)
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

Func _NOINIWRITEINI()
IniWrite($config,$cfgzd,"机器前缀","PC")
IniWrite($config,$cfgzd,"IP段","192.168.0")
IniWrite($config,$cfgzd,"子网掩码","255.255.255.0")
IniWrite($config,$cfgzd,"网关","192.168.0.1")
IniWrite($config,$cfgzd,"DNS","61.128.128.68,221.5.203.98")
IniWrite($config,$cfgzd,"1号IP","201")
IniWrite($config,$cfgzd,"IP偏移","0")
IniWrite($config,$cfgzd,"网络号偏移","0")
IniWrite($config,$cfgzd,"修改内部网络号","1")
IniWrite($config,$cfgzd,"修改CSCDK","1")
IniWrite($config,$cfgzd,"解压预置CSCDK","1")
EndFunc ;_NOINIWRITEINI()