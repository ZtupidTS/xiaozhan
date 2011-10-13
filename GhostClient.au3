#NoTrayIcon
#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=ghost.ico
#AutoIt3Wrapper_outfile=NetbarGhostClient.exe
#AutoIt3Wrapper_Res_Comment=根据MAC全自动修改:计算机名、IP、IPX、分辨率、网关、DNS、CS-CDKey、IE、IE标题、IE状态栏信息、禁用多余网卡、关闭闲置IDE通道、安装还原软件等
#AutoIt3Wrapper_Res_Description=网吧GHOST后全自动设置程序
#AutoIt3Wrapper_Res_Fileversion=3.0.0.6
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_LegalCopyright=Jycel制作  QQ:472891322
#AutoIt3Wrapper_Res_Field=作者|BY-JYCEL
#AutoIt3Wrapper_Res_Field=联系QQ|472891322
#AutoIt3Wrapper_Res_Field=出品公司|飞翔网络城
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#Region AutoIt3Wrapper 预编译参数(完整参数)
;** 这个列表中中的编译器定义是为 AutoIt3Wrapper.exe 使用的，同时也兼容ACN论坛的ACNWrapper.exe.
;** 注释行不需要您删除，这是一些描述信息，不会到最终的EXE中.
;===============================================================================================================
;** AUTOIT3 设置
#AutoIt3Wrapper_Run_Debug_Mode=                 ;(Y/N) 运行脚本于控制图调试. 默认=N
;===============================================================================================================
;** AUT2EXE 设置
;===============================================================================================================
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Process.au3>
RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run",@ScriptName,"REG_SZ",@AutoItExe);添加到启动项
HotKeySet("{ESC}", "quit")
Opt("TrayAutoPause",0)  ;0=不暂停, 1=暂停
Local $hIcons[2]
Dim $dns[2],$IPX,$disable[7]
$color="0xFF0000"
$MacSM = "mdb.ini"
$devcon= "devcon.exe"
$time = IniRead($MacSM, "配置", "倒计时间", "")
FileInstall("SkinCrafterDll.dll", @TempDir & "\SkinCrafterDll.dll", 1)
FileInstall("vista.skf", @TempDir & "\vista.skf", 1)
FileInstall("使用说明.txt",@ScriptDir & "\使用说明.txt")
FileInstall("devcon.exe",@ScriptDir & "\devcon.exe")
$Dll = DllOpen(@TempDir & "\SkinCrafterDll.dll")
If Not @OSType = "WIN32_NT" OR Not @OSLang = "0804" then;判断是否支持此系统
MsgBox(16, "错误", "本工具不支持此系统", 10)
Exit
EndIf
If Not FileExists($MacSm) Then
_Default()
MsgBox(64,"提示","默认配置生成完毕！请手动修改相关设置再将本程序加入启动项！",2)
ShellExecute(@ScriptDir&"\"&$MacSM)
ShellExecute(@ScriptDir&"\使用说明.txt")
Exit
EndIf
$Copyright01 = IniRead($MacSm, "版权信息", "技术QQ", "")
$Copyright02 = IniRead($MacSm, "版权信息", "作者空间", "")
$POST = "请勿随便修改版权,有需要请联系QQ:472891322 "& @CRLF &"欢迎光临作者QQ空间:http://472891322.qzone.qq.com"
If $Copyright01 <> "472891322" Or $Copyright02 <> "http://472891322.qzone.qq.com/" Then
	MsgBox(64, "温馨提醒您:", $POST)
	Exit
EndIf
#Region ### START Koda GUI section ### Form=c:\documents and settings\administrator\桌面\form1.kxf
$Form1 = GUICreate("网吧GHOST后全自动设置程序", 423, 323, 403, 198)
_SkinGUI(@TempDir & "\SkinCrafterDll.dll", @TempDir & "\vista.skf", $Form1)
;GUISetBkColor(0x00dd00)
$Group1 = GUICtrlCreateGroup("本机配置如下", 3, 0, 417, 297)
$Label1 = GUICtrlCreateLabel("计算机名:", 11, 22, 55, 17)
$Input1 = GUICtrlCreateInput("", 83, 16, 113, 21, BitOR($ES_AUTOHSCROLL,$ES_READONLY,$SS_CENTER))
$Label2 = GUICtrlCreateLabel("子网掩码:", 221, 46, 55, 17)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
$Input2 = GUICtrlCreateInput("", 299, 16, 113, 21, BitOR($ES_AUTOHSCROLL,$ES_READONLY,$SS_CENTER))
$Label3 = GUICtrlCreateLabel("I P 地址:", 221, 22, 55, 17)

$Input3 = GUICtrlCreateInput("", 83, 40, 113, 21, BitOR($ES_AUTOHSCROLL,$ES_READONLY,$SS_CENTER))
$Label4 = GUICtrlCreateLabel("默认网关:", 11, 46, 57, 17)
 
$Input4 = GUICtrlCreateInput("", 299, 40, 113, 21, BitOR($ES_AUTOHSCROLL,$ES_READONLY,$SS_CENTER))
$Label5 = GUICtrlCreateLabel("首选 DNS:", 11, 70, 55, 17)
 
$Input5 = GUICtrlCreateInput("", 83, 64, 113, 21, BitOR($ES_AUTOHSCROLL,$ES_READONLY,$SS_CENTER))
$Label6 = GUICtrlCreateLabel("备用 DNS:", 221, 70, 57, 17)

$Input6 = GUICtrlCreateInput("", 299, 64, 113, 21, BitOR($ES_AUTOHSCROLL,$ES_READONLY,$SS_CENTER))
$Label7 = GUICtrlCreateLabel("IPX 地址:", 11, 94, 55, 17)
 
$Input7 = GUICtrlCreateInput("", 83, 88, 113, 21, BitOR($ES_AUTOHSCROLL,$ES_READONLY,$SS_CENTER))
$Label8 = GUICtrlCreateLabel("禁用网卡:", 221, 94, 55, 17)
 
$Input8 = GUICtrlCreateInput("", 299, 88, 113, 21, BitOR($ES_AUTOHSCROLL,$ES_READONLY,$SS_CENTER))
$Label9 = GUICtrlCreateLabel("禁用 IDE:", 11, 118, 55, 17)

$Input9 = GUICtrlCreateInput("", 83, 112, 113, 21, BitOR($ES_AUTOHSCROLL,$ES_READONLY,$SS_CENTER))
$Label10 = GUICtrlCreateLabel("还原软件:", 221, 118, 55, 17)
 
$Input10 = GUICtrlCreateInput("", 299, 112, 113, 21, BitOR($ES_AUTOHSCROLL,$ES_READONLY,$SS_CENTER))
$Label11 = GUICtrlCreateLabel("分 辨 率:", 11, 142, 55, 17)
 
$Input11 = GUICtrlCreateInput("", 83, 136, 113, 21, BitOR($ES_AUTOHSCROLL,$ES_READONLY,$SS_CENTER))
$Label12 = GUICtrlCreateLabel("Cs-Key:", 221, 142, 55, 17)
 
$Input12 = GUICtrlCreateInput("", 299, 136, 113, 21, BitOR($ES_AUTOHSCROLL,$ES_READONLY,$SS_CENTER))
$Label13 = GUICtrlCreateLabel("I E 标题:", 11, 166, 55, 17)

$Input13 = GUICtrlCreateInput("", 83, 160, 329, 21, BitOR($ES_AUTOHSCROLL,$ES_READONLY,$SS_CENTER))
$Label14 = GUICtrlCreateLabel("I E 首页:", 11, 190, 55, 17)

$Input14 = GUICtrlCreateInput("", 83, 184, 329, 21, BitOR($ES_AUTOHSCROLL,$ES_READONLY,$SS_CENTER))
$Label15 = GUICtrlCreateLabel("状态栏信息:", 11, 214, 67, 17)
 
$Input15 = GUICtrlCreateInput("", 83, 208, 329, 21, BitOR($ES_AUTOHSCROLL,$ES_READONLY,$SS_CENTER))
$Labtime = GUICtrlCreateLabel("", 135, 262, 148, 30, $SS_CENTER)
GUICtrlSetColor(-1, $color)
$pro = GUICtrlCreateProgress(11, 240, 402, 17)
$Button1 = GUICtrlCreateButton("立即执行", 19, 264, 105, 25, $WS_GROUP, $WS_EX_STATICEDGE)

$Button2 = GUICtrlCreateButton("退出程序", 291, 264, 113, 25, $WS_GROUP, $WS_EX_STATICEDGE)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$StatusBar1 = _GUICtrlStatusBar_Create($Form1)
_GUICtrlStatusBar_SetText ($StatusBar1, "URL:http://jycel.ys168.com     E-mail:Jycel@qq.com       BY-Jycel")
$hIcons[0] = _WinAPI_LoadShell32Icon (13)
_GUICtrlStatusBar_SetIcon ($StatusBar1, 0, $hIcons[0])
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
;以下为倒计时设置
AdlibEnable("pro1", 10 * $time) ;启用 Adlib 功能,每隔10 * $time时间就调用函数一次
$wait = 0
Func pro1()
	$start6 = GUICtrlSetData($pro, $wait) ;设置进度条的初始值为0
	For $v = 0 To $time Step 1 ;从0开始，步进值为1
		If GUICtrlRead($pro) = $v * 10 / ($time / 10) Then GUICtrlSetData($Labtime, $time - $v )
		GUICtrlSetBkColor($Labtime, $GUI_BKCOLOR_TRANSPARENT) 
		GUICtrlSetFont($Labtime, 20, 800, 0, "")
		GUICtrlSetColor($Labtime, 0x0000FF)		 
	Next
	$wait = $wait + 1
	If $wait = 101 Then _setup()
EndFunc   ;==>pro1


$LocMAC = _GetLocalMAC()
If $LocMAC[0] = 0 Then
MsgBox(64, "错误", '找不到本机MAC地址，' & @CRLF & '请检查本机配置！', 15)
Exit
Else
For $m = 1 to $LocMAC[0]
   $info = IniRead($MacSM, "Maclist", $LocMAC[$m], "")
   If $info <> "" Then ExitLoop
Next
EndIf
$info = StringSplit($info, "|")

;==================
GUICtrlSetData($Input8,IniRead($MacSM,"配置","禁用网卡",""))
GUICtrlSetData($Input9,$info[10])
If $info[9]="" Then
	GUICtrlSetData($Input10,"未配置")
Else
	GUICtrlSetData($Input10,$info[9])
EndIf
GUICtrlSetData($Input13,IniRead($MacSm, "配置", "IE首页", ""))
GUICtrlSetData($Input14,IniRead($MacSm,"配置","IE标题",""))
GUICtrlSetData($Input15,IniRead($MacSm,"配置","IE状态栏信息",""))
;==============修改计算机名和IP地址==================
$PcName = _StringIsComputerName($info[1]);修改计算机名称
If @error Then
	GUICtrlSetData($Input1,"格式非法")
	GUICtrlSetColor($Input1, $color)
	Else
GUICtrlSetData($Input1,$info[1])
EndIf
$ipAdd = _StringIsIP($info[2])
If @error Then
	GUICtrlSetData($Input2,"格式非法")
	GUICtrlSetColor($Input2, $color)
	Else
GUICtrlSetData($Input2,$info[2])
EndIf
$Mask = _StringIsIP($info[4]);子网掩码
If @error Then
	GUICtrlSetData($Input4,"格式非法")
	GUICtrlSetColor($Input4, $color)
Else
	GUICtrlSetData($Input4,$Mask)
EndIf
$Gateway = _StringIsIP($info[5]);默认网关
If @error Then
	GUICtrlSetData($Input3,"格式非法")
	GUICtrlSetColor($Input3, $color)
Else
	GUICtrlSetData($Input3,$Gateway)
EndIf
$dns[0] = _StringIsIP($info[6]);首选DNS
If @error Then
	GUICtrlSetData($Input5,"格式非法")
	GUICtrlSetColor($Input5, $color)
Else
	GUICtrlSetData($Input5,$dns[0])
EndIf
$dns[1] = _StringIsIP($info[7]);备用DNS
If @error Then
	GUICtrlSetData($Input6,"格式非法")
	GUICtrlSetColor($Input6, $color)
Else
	GUICtrlSetData($Input6,$dns[1])
EndIf
;==============修改计算机名和IP地址==================

;==============修改IPX内部网络号==================
If $info[3]="IP规则" Then
	$ip4 = StringRegExpReplace($info[2],'(\d+\.){3}', '')
			if $IP4<100 Then
					$ipt="000000"
					GUICtrlSetData($Input7,$ipt&$ip4)
			ElseIf $IP4>=100 Then
					$ipt="00000"
					GUICtrlSetData($Input7,$ipt&$ip4)					
			EndIf
ElseIf $info[3]="随机规则" Then
$strComputer = "."
$IPX=Random(1,9999,1)
$IPX= StringFormat("%08d", $IPX)
$objWMIService = ObjGet("winmgmts:\\" & $strComputer & "\root\cimv2")
$objNetworkSettings = $objWMIService.Get("Win32_NetworkAdapterConfiguration")
$objNetworkSettings.SetIPXVirtualNetworkNumber(int($IPX))
GUICtrlSetData($Input7,$IPX)
EndIf	
			
;==============修改IPX内部网络号==================

;==============修改CD-CDK==================
$CsKey = IniReadSection($MacSM, "Cs15Key")
If @error Then
$CsKey = 0
Else
$n = Random(1, $CsKey[0][0], 1)
EndIf
GUICtrlSetData($Input12,IniRead($MacSM, "Cs15Key", $n, "1234567890123"))
;==============修改CD-CDK==================
;==============自动分析分辨率=============================
GUICtrlSetData($Input11,$info[8])
$disable[1]=GUICtrlRead($input1)
$disable[2]=GUICtrlRead($input2)
$disable[3]=GUICtrlRead($input3)
$disable[4]=GUICtrlRead($input4)
$disable[5]=GUICtrlRead($input5)
$disable[6]=GUICtrlRead($input6)
$inputtxt="格式非法"
If $disable[1]=$inputtxt Then
AdlibDisable()
EndIf
If $disable[2]=$inputtxt Then
AdlibDisable()
EndIf
If $disable[3]=$inputtxt Then
AdlibDisable()
EndIf
If $disable[4]=$inputtxt Then
AdlibDisable()
EndIf
If $disable[5]=$inputtxt Then
AdlibDisable()
EndIf
If $disable[6]=$inputtxt Then
AdlibDisable()
EndIf

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $Button1
			_setup()
		Case $Button2
			Exit
	EndSwitch
WEnd
Func _GetLocalMAC()
Dim $aNULL[1] = [0]
$MAC = Chr(13)
$strComputer = "localhost"
$objWMIService = ObjGet("winmgmts:\\" & $strComputer & "\root\cimv2")
$colNicConfigs = $objWMIService.ExecQuery ("SELECT * FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled = True")
If IsObj($colNicConfigs) Then
   For $objItem In $colNicConfigs
$objNic = $objWMIService.Get ("Win32_NetworkAdapter.DeviceID=" & $objItem.Index)
$MAC = $MAC & Chr(10) & $objNic.MACAddress
   Next
   $MAC = StringReplace($MAC, Chr(13) & Chr(10), "")
   If StringInStr($MAC, ":") = 0   Then
SetError(2)
Return $aNULL
   Else
$MAC = StringReplace($MAC, ":", "-")
Return StringSplit($MAC, Chr(10))
   EndIf
Else
   SetError(1)
   Return $aNULL
EndIf
EndFunc   ;_GetLocalMAC获取本地MAC地址

Func _setup()
AdlibDisable()
GUICtrlSetData($Labtime,"设置中……")
;==================禁用网卡================================
$jywk=GUICtrlRead ($Input8)
If $jywk="" Then
	$jywk=""
	Else
_RunDos("devcon disable *"&$jywk&"*" )
EndIf
;==================禁用网卡================================

;==================设置分辨率================================
$fenbianlu= StringSplit(GUICtrlRead($input11), "*")	;拆分分辨率
_ChangeScreenRes($fenbianlu[1], $fenbianlu[2], $fenbianlu[3], $fenbianlu[4]);设置分辨率
;==================设置分辨率================================

;==================设置计算机名================================
_SetComputerName(GUICtrlRead($Input1))
;==================设置计算机名================================

;==================设置Ip相关================================
$SetIpAdd = _SetIPAddress($ipAdd, $Mask, $Gateway);修改IP地址、网关、子掩网码、DNS
;==================设置Ip相关================================

;==================设置Ipx内部网络号================================
If $info[3]="IP规则" Then
	$ip4 = StringRegExpReplace($info[2],'(\d+\.){3}', '')
			if $IP4<100 Then
					$ipt="000000"
RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NwlnkIpx\Parameters","VirtualNetworkNumber","REG_DWORD",$ipt&$ip4+174);IPX内部网络号
			ElseIf $IP4>=100 Then
					$ipt="00000"
RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NwlnkIpx\Parameters","VirtualNetworkNumber","REG_DWORD",$ipt&$ip4+174);IPX内部网络号	
			EndIf
ElseIf $info[3]="随机规则" Then
$strComputer = "."
$IPX=Random(1,9999,1)
$IPX= StringFormat("%08d", $IPX)
$objWMIService = ObjGet("winmgmts:\\" & $strComputer & "\root\cimv2")
$objNetworkSettings = $objWMIService.Get("Win32_NetworkAdapterConfiguration")
$objNetworkSettings.SetIPXVirtualNetworkNumber(int($IPX))
RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NwlnkIpx\Parameters","VirtualNetworkNumber","REG_DWORD",$IPX);IPX内部网络号
EndIf
;==================设置Ipx内部网络号================================

;==================设置IDE通道================================
$ide=GUICtrlRead ($Input9);IDE通道检测
If $ide="开启" Then
	const $Hkey1="HKLM\SYSTEM\CurrentControlSet\Enum\PCIIDE\IDEChannel"
	const $Hkey2="HKLM\SYSTEM\CurrentControlSet\Control\Class"
	$driver=0
for $i=1 to 20
        $subkey1=RegEnumKey($Hkey1,$i)
        if @error=-1 then ExitLoop
        $subkey2=RegRead($Hkey1&"\"&$subkey1,"Driver")
        $name=RegRead($Hkey2&"\"&$subkey2,"DriverDesc")
        $master=RegRead($Hkey2&"\"&$subkey2,"MasterDeviceType")
                if $master=0 Then
                        RegWrite($Hkey2&"\"&$subkey2,"UserMasterDeviceType","REG_DWORD","3")
                ElseIf $master=1 Then
                        $driver=$driver+1
                EndIf
        $slave=RegRead($Hkey2&"\"&$subkey2,"SlaveDeviceType")
                if $slave=0 Then
                        RegWrite($Hkey2&"\"&$subkey2,"UserSlaveDeviceType","REG_DWORD","3")
                ElseIf $slave=1 Then
                        $driver=$driver+1
                EndIf
Next
Else
EndIf
;==================设置IDE通道================================
sleep(1000)
RegDelete("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run",@ScriptName);删除启动项
;==================开始安装附加程序===========================================
$fjlist = IniReadSection($MacSM, "附加程序")
	If @error Then 
		GUICtrlSetData($Labtime,"附加失败")
	Else
			For $l = 1 To $fjlist[0][0]
				$runlist=IniRead($MacSM,"附加程序",$fjlist[$l][0],"")
				If not @error Then
					ShellExecuteWait(@ScriptDir&"\tool\"&$runlist)
				EndIf
			Next
	EndIf
GUICtrlSetData($Labtime,"设置完毕")
Sleep(100)
GUICtrlSetData($Labtime,"检测还原")
;==================附加程序安装完毕===========================================
sleep(3000)
;==================安装还原软件开始================================
If $info[9]="" Then
	Exit
Else
	If FileExists($info[9]) Then 
			ShellExecute($info[9])
	Else
			Exit
	EndIf

EndIf
Exit
;==================安装还原软件结束================================
EndFunc;修改结束

Func _SetComputerName($strComputerName)
$SetKey1 = "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\"
$CtrlKey = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\"
$ie1 = "HKEY_CURRENT_USER\Software\Microsoft\";改IE
$ie2 = "HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30309D}\shell\";修改IE启动项
$ie3 = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\"
$Return = RegWrite ($SetKey1 & "Control\ComputerName\ComputerName", "ComputerName", "REG_SZ", $strComputerName)
RegWrite ($SetKey1 & "Services\Tcpip\Parameters", "NV Hostname", "REG_SZ", $strComputerName)
RegWrite ($SetKey1 & "Services\Tcpip\Parameters", "Hostname", "REG_SZ", $strComputerName)

RegWrite ($CtrlKey & "Control\ComputerName\ComputerName", "ComputerName", "REG_SZ", $strComputerName)
RegWrite ($CtrlKey & "Services\Tcpip\Parameters", "NV Hostname", "REG_SZ", $strComputerName)
RegWrite ($CtrlKey & "Services\Tcpip\Parameters", "Hostname", "REG_SZ", $strComputerName)
RegWrite ($ie1 & "Internet Explorer\Main", "Start Page", "REG_SZ", GUICtrlRead($Input13));改IE
RegWrite ($ie1 & "Internet Explorer\Main", "Default_Page_UR", "REG_SZ", GUICtrlRead($Input13));改IE
RegWrite ($ie1 & "Internet Explorer\Main", "Window Title", "REG_SZ", GUICtrlRead($Input14));改IE
RegWrite ($ie2 & "OpenHomePage\Command", "", "REG_SZ", "C:\Program Files\Internet Explorer\iexplore.exe "  & GUICtrlRead($Input13));设置IE启动参数
RegWrite ($ie1 & "Windows\CurrentVersion\Internet Settings\Zones\3","DisplayName","REG_SZ",GUICtrlRead($Input15));状态栏信息
RegWrite ($ie3 & "Windows\CurrentVersion\Internet Settings\Zones\3","DisplayName","REG_SZ",GUICtrlRead($Input15));状态栏信息
Return $Return
EndFunc   ;_SetComputerName修改计算机名

Func _SetIPAddress($ipAdd, $Mask = "255.255.255.0", $Gateway = "")
$Return = 0
$ipAdd = _StringIsIP($ipAdd)
If $ipAdd = "" Then $Return = $Return + 1
$Mask = _StringIsIP($Mask)
If $Mask = "" Then $Return = $Return + 2
$Gateway = _StringIsIP($Gateway)
If $Gateway = "" Then $Return = $Return + 4
$dns[0] = _StringIsIP($dns[0])
If $dns[0] = "" Then $Return = $Return + 8
$dns[1] = _StringIsIP($dns[1])
If $dns[1] = "" Then $Return = $Return + 16

Dim $LocalIPAddress[1] = [$ipAdd]
Dim $strSubnetMask[1] = [$Mask]
Dim $strGateway[1] = [$Gateway]
Dim $strGatewayMetric[1] = [1]

$strComputer = "localhost"
$objWMIService = ObjGet("winmgmts:\\" & $strComputer & "\root\cimv2")
$colNetAdapters = $objWMIService.ExecQuery ("Select * from Win32_NetworkAdapterConfiguration where IPEnabled=TRUE")
If IsObj($colNetAdapters) Then
   For $objNetAdapter in $colNetAdapters
If BitAND($Return, 1) = 0 AND BitAND($Return, 2) = 0 Then $objNetAdapter.EnableStatic($LocalIPAddress, $strSubnetMask)
If BitAND($Return, 4) = 0 Then $objNetAdapter.SetGateways($strGateway, $strGatewayMetric)
If BitAND($Return, 8) = 0 and BitAND($Return, 16) = 0 Then $objNetAdapter.SetDNSServerSearchOrder($dns)
   Next
EndIf
Return $Return
EndFunc   ;_SetIPAddress修改IP地址

Func _StringIsIP($strIP)
$str = StringSplit($strIP, ".")
If $str[0] <> 4 Then
   SetError(1)
   return ('')
ElseIf StringIsDigit($str[1]) <> 1 OR StringIsDigit($str[2]) <> 1 OR StringIsDigit($str[3]) <> 1 OR StringIsDigit($str[4]) <> 1 Then
   SetError(2)
   return ('')
ElseIf $str[1] > 255 OR $str[2] > 255 OR $str[3] > 255 OR $str[4] > 255 Then
   SetError(3)
   return ('')
Else
   return (Int($str[1]) & "." & Int($str[2]) & "." & Int($str[3]) & "." & Int($str[4]))
EndIf
EndFunc   ;_StringIsIP判断IP格式是否正确

Func _StringIsComputerName($strComputerName, $ShowMsgBox=1)
If $strComputerName = "" OR StringLen($strComputerName) > 63 Then
   $err = '输入的新计算机名格式不对。标准名称可以含有字母(a-z, A-Z)、数字(0-9)和连字符(-)，但不能含有空格或句号(.)。名称可能不完全是数字。'
   SetError(1)
   Return 0
ElseIf StringIsDigit($strComputerName) = 1 Then
   If @OSVersion = "WIN_2000" Then
$Title = "网络标识"
   Else
$Title = "计算机名更改"
   EndIf
   If $ShowMsgBox=1 Then GUICtrlSetData($Input1,"格式非法");MsgBox(48, $Title, '新计算机名 "' & $strComputerName & '" 是一个数字。名称不应是数字。')
   SetError(2)
   Return 0
EndIf
$NoText = '`~!@#$. ^&*()=+[]{}\|;:' & Chr(39) & '",<>/?'
For $i = 1 To StringLen($strComputerName)
   If StringInStr($NoText, StringMid($strComputerName, $i, 1)) <> 0 Then
If @OSVersion = "WIN_2000" Then
$Title = "网络标识"
$Text = '新计算机名 "' & $strComputerName & '" 包括非法的字符。'
Else
$Title = "计算机名更改"
$Text = '新计算机名 "' & $strComputerName & '" 包括不允许的字符。不允许的字符包括 ` ~ ! @ # $   ^ & * ( ) = + [ ] { } \ | ; : ' & Chr(39) & ' " , < > / 和 ?'
EndIf
If $ShowMsgBox = 1 Then GUICtrlSetData($Input1,"格式非法");MsgBox(48, $Title, $Text)
SetError(3)
Return 0
   EndIf
Next
If $ShowMsgBox <> 1 Then Return 1
$Text = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-"
For $i = 1 To StringLen($strComputerName)
   If StringInStr($Text, StringMid($strComputerName, $i, 1)) = 0 Then
If @OSVersion = "WIN_2000" Then
$Title = "网络标识"
Else
$Title = "计算机名更改"
EndIf
$iMsgBoxAnswer = GUICtrlSetData($Input1,"格式非法");MsgBox(48+4, $Title, '计算机名 "' & $strComputerName & '" 含有一个或一个以上非标准字符。标准字符包括字母(A-Z，a-z)、数字(0-9)和连字符(-)。如使用非标准字符名称，除非您所属网络使用 Microsoft DNS 服务器，否则其他用户就会在网络上找不到您的计算机。要使用这个非标准名称吗?')
If $iMsgBoxAnswer = 6 Then
Return 1
Else
SetError(4)
Return 0
EndIf
   EndIf
Next
EndFunc   ; _StringIsComputerName判断计算机名是否正确
Func _ChangeScreenRes($i_Width = @DesktopWidth, $i_Height = @DesktopHeight, $i_BitsPP = @DesktopDepth, $i_RefreshRate = @DesktopRefresh)
	Local Const $DM_PELSWIDTH = 0x00080000
	Local Const $DM_PELSHEIGHT = 0x00100000
	Local Const $DM_BITSPERPEL = 0x00040000
	Local Const $DM_DISPLAYFREQUENCY = 0x00400000
	Local Const $CDS_TEST = 0x00000002
	Local Const $CDS_UPDATEREGISTRY = 0x00000001
	Local Const $DISP_CHANGE_RESTART = 1
	Local Const $DISP_CHANGE_SUCCESSFUL = 0
	Local Const $HWND_BROADCAST = 0xffff
	Local Const $WM_DISPLAYCHANGE = 0x007E
	If $i_Width = "" Or $i_Width = -1 Then $i_Width = @DesktopWidth ; default to current setting
	If $i_Height = "" Or $i_Height = -1 Then $i_Height = @DesktopHeight ; default to current setting
	If $i_BitsPP = "" Or $i_BitsPP = -1 Then $i_BitsPP = @DesktopDepth ; default to current setting
	If $i_RefreshRate = "" Or $i_RefreshRate = -1 Then $i_RefreshRate = @DesktopRefresh ; default to current setting
	Local $DEVMODE = DllStructCreate("byte[32];int[10];byte[32];int[6]")
	Local $B = DllCall("user32.dll", "int", "EnumDisplaySettings", "ptr", 0, "long", 0, "ptr", DllStructGetPtr($DEVMODE))
	If @error Then
		$B = 0
		SetError(1)
		Return $B
	Else
		$B = $B[0]
	EndIf
	If $B <> 0 Then
		DllStructSetData($DEVMODE, 2, BitOR($DM_PELSWIDTH, $DM_PELSHEIGHT, $DM_BITSPERPEL, $DM_DISPLAYFREQUENCY), 5)
		DllStructSetData($DEVMODE, 4, $i_Width, 2)
		DllStructSetData($DEVMODE, 4, $i_Height, 3)
		DllStructSetData($DEVMODE, 4, $i_BitsPP, 1)
		DllStructSetData($DEVMODE, 4, $i_RefreshRate, 5)
		$B = DllCall("user32.dll", "int", "ChangeDisplaySettings", "ptr", DllStructGetPtr($DEVMODE), "int", $CDS_TEST)
		If @error Then
			$B = -1
		Else
			$B = $B[0]
		EndIf
		Select
			Case $B = $DISP_CHANGE_RESTART
				$DEVMODE = ""
				Return 2
			Case $B = $DISP_CHANGE_SUCCESSFUL
				DllCall("user32.dll", "int", "ChangeDisplaySettings", "ptr", DllStructGetPtr($DEVMODE), "int", $CDS_UPDATEREGISTRY)
				DllCall("user32.dll", "int", "SendMessage", "hwnd", $HWND_BROADCAST, "int", $WM_DISPLAYCHANGE, _
						"int", $i_BitsPP, "int", $i_Height * 2 ^ 16 + $i_Width)
				$DEVMODE = ""
				Return 1
			Case Else
				$DEVMODE = ""
				SetError(1)
				Return $B
		EndSelect
	EndIf
EndFunc  	
;定义皮肤函数
Func _SkinGUI($SkincrafterDll, $SkincrafterSkin, $Handle)
	$Dll = DllOpen($SkincrafterDll)
	DllCall($Dll, "int:cdecl", "InitLicenKeys", "wstr", "1", "wstr", "", "wstr", "1@1.com", "wstr", "1")
	DllCall($Dll, "int:cdecl", "InitDecoration", "int", 1)
	DllCall($Dll, "int:cdecl", "LoadSkinFromFile", "wstr", $SkincrafterSkin)
	DllCall($Dll, "int:cdecl", "DecorateAs", "int", $Handle, "int", 25)
	DllCall($Dll, "int:cdecl", "ApplySkin")
EndFunc   ;==>_SkinGUI

;皮肤退出
Func Quit()
	GUISetState(@SW_HIDE)
	DllCall($Dll, "int:cdecl", "DeInitDecoration")
	DllCall($Dll, "int:cdecl", "RemoveSkin")
	DllClose($Dll)
	FileDelete(@TempDir & "\SkinCrafterDll.dll")
	FileDelete(@TempDir & "\vista.skf")
	Exit
EndFunc   ;==>Quit
Func _Default();生成默认配置文件
	MsgBox(48,"温馨提醒您:", "未找到程序配置文件,程序将自动创建."& @CRLF &"请使用服务端工具扫描配置信息.",2)
	IniWrite($MacSm , "版权信息", "技术QQ","472891322")
    IniWrite($MacSm , "版权信息", "E-mail","jycel@qq.com")
	IniWrite($MacSm, "版权信息", "作者空间","http://472891322.qzone.qq.com/"&@CRLF)
	IniWrite($MacSm, "配置", "倒计时间","30")
	IniWrite($MacSm, "配置", "禁用网卡","DEV_8139")
	IniWrite($MacSm, "配置", "IE首页","http://v.tfol.com/netbar.htm")
	IniWrite($MacSm, "配置", "IE标题","飛翔網絡-将快乐网起来!")
	IniWrite($MacSm, "配置", "IE状态栏信息","欢迎光临飛翔網絡 TEL:0816-2624067 技术QQ:472891322"&@CRLF)
	IniWrite($MacSm, "Maclist", "mac","计算机名|IP地址|ipx地址|子网掩码|默认网关|首选DNS|备用DNS|分辨率|还原软件|IDE通道")
	IniWrite($MacSm, "Maclist", "00-E0-61-15-C5-43", "A001|192.168.0.11|IP规则|255.255.255.0|192.168.0.1|202.98.96.68|61.139.2.69|1440*900*32*75|网维大师|开启"&@CRLF)
	IniWrite($MacSm, "分辩率", "1024*768*32*85", "此处不要添写，程序只读前面关键字，可修改其中数据")
	IniWrite($MacSm, "分辩率", "1440*900*32*75", "同上")
	IniWrite($MacSm, "分辩率", "1680*1050*32*75", "同上"&@CRLF)
	IniWrite($MacSm, "Cs15Key", "1","6801563651288")
	IniWrite($MacSm, "Cs15Key", "2","3294345689725")
	IniWrite($MacSm, "Cs15Key", "3","2292823454228")
	IniWrite($MacSm, "Cs15Key", "4","7842715618877")
	IniWrite($MacSm, "Cs15Key", "5","3865568763903")
	IniWrite($MacSm, "Cs15Key", "6","5013955315983")
	IniWrite($MacSm, "Cs15Key", "7","3094945136861")
	IniWrite($MacSm, "Cs15Key", "8","2726631268402")
	IniWrite($MacSm, "Cs15Key", "9","1421339652155")
	IniWrite($MacSm, "Cs15Key", "10","2293026703085")
	IniWrite($MacSm, "Cs15Key", "11","1977560827768")
	IniWrite($MacSm, "Cs15Key", "12","2996620270749")
	IniWrite($MacSm, "Cs15Key", "13","0072430366426")
	IniWrite($MacSm, "Cs15Key", "14","7893392675840")
	IniWrite($MacSm, "Cs15Key", "15","2623436581467")
	IniWrite($MacSm, "Cs15Key", "16","2367234335487")
	IniWrite($MacSm, "Cs15Key", "17","5899430794142")
	IniWrite($MacSm, "Cs15Key", "18","6373906794557")
	IniWrite($MacSm, "Cs15Key", "19","0186166087129")
	IniWrite($MacSm, "Cs15Key", "20","9309282185282")
	IniWrite($MacSm, "Cs15Key", "21","9942810937876")
	IniWrite($MacSm, "Cs15Key", "22","2702926069367")
	IniWrite($MacSm, "Cs15Key", "23","2873922711009")
	IniWrite($MacSm, "Cs15Key", "24","3182452724788")
	IniWrite($MacSm, "Cs15Key", "25","2881320716061")
	IniWrite($MacSm, "Cs15Key", "26","3882348620722")
	IniWrite($MacSm, "Cs15Key", "27","2498521763020")
	IniWrite($MacSm, "Cs15Key", "28","9745406730972")
	IniWrite($MacSm, "Cs15Key", "29","3995846325049")
	IniWrite($MacSm, "Cs15Key", "30","3990645369061")
	IniWrite($MacSm, "Cs15Key", "31","3881442673780")
	IniWrite($MacSm, "Cs15Key", "32","4722953384569")
	IniWrite($MacSm, "Cs15Key", "33","5991335738183")
	IniWrite($MacSm, "Cs15Key", "34","0943252509979")
	IniWrite($MacSm, "Cs15Key", "35","0057329934856")
	IniWrite($MacSm, "Cs15Key", "36","7597026797903")
	IniWrite($MacSm, "Cs15Key", "37","1509899106786")
	IniWrite($MacSm, "Cs15Key", "38","9080368774300")
	IniWrite($MacSm, "Cs15Key", "39","2306437281560")
	IniWrite($MacSm, "Cs15Key", "40","8047751630688")
	IniWrite($MacSm, "Cs15Key", "41","2572265422347")
	IniWrite($MacSm, "Cs15Key", "42","2897524202721")
	IniWrite($MacSm, "Cs15Key", "43","9525803960507")
	IniWrite($MacSm, "Cs15Key", "44","3896321644454")
	IniWrite($MacSm, "Cs15Key", "45","2575508916775")
	IniWrite($MacSm, "Cs15Key", "46","3832845609762")
	IniWrite($MacSm, "Cs15Key", "47","5109677149369")
	IniWrite($MacSm, "Cs15Key", "48","2007224885708")
	IniWrite($MacSm, "Cs15Key", "49","2304525119809")
	IniWrite($MacSm, "Cs15Key", "50","0700233570541")
	IniWrite($MacSm, "Cs15Key", "51","3892248363021")
	IniWrite($MacSm, "Cs15Key", "52","3049152178425")
	IniWrite($MacSm, "Cs15Key", "53","0143005967914")
	IniWrite($MacSm, "Cs15Key", "54","5895638781104")
	IniWrite($MacSm, "Cs15Key", "55","5512355833199")
	IniWrite($MacSm, "Cs15Key", "56","2348134376448")
	IniWrite($MacSm, "Cs15Key", "57","3005789616110")
	IniWrite($MacSm, "Cs15Key", "58","2492629725023")
	IniWrite($MacSm, "Cs15Key", "59","7169336493198")
	IniWrite($MacSm, "Cs15Key", "60","5498338402186")
	IniWrite($MacSm, "Cs15Key", "61","2810029507117")
	IniWrite($MacSm, "Cs15Key", "62","8295771797102")
	IniWrite($MacSm, "Cs15Key", "63","1320904578028")
	IniWrite($MacSm, "Cs15Key", "64","5531764511342")
	IniWrite($MacSm, "Cs15Key", "65","5898238712127")
	IniWrite($MacSm, "Cs15Key", "66","5998632785122")
	IniWrite($MacSm, "Cs15Key", "67","0514846371932")
	IniWrite($MacSm, "Cs15Key", "68","0416231170064")
	IniWrite($MacSm, "Cs15Key", "69","3015038603991")
	IniWrite($MacSm, "Cs15Key", "70","2120338265425")
	IniWrite($MacSm, "Cs15Key", "71","9589846712664")
	IniWrite($MacSm, "Cs15Key", "72","3667588858575")
	IniWrite($MacSm, "Cs15Key", "73","5464829472848")
	IniWrite($MacSm, "Cs15Key", "74","2833689982865")
	IniWrite($MacSm, "Cs15Key", "75","3997145348020")
	IniWrite($MacSm, "Cs15Key", "76","2494731044643")
	IniWrite($MacSm, "Cs15Key", "77","1150596958039")
	IniWrite($MacSm, "Cs15Key", "78","3398042694766")
	IniWrite($MacSm, "Cs15Key", "79","3799042684746")
	IniWrite($MacSm, "Cs15Key", "80","2701338554560")
	IniWrite($MacSm, "Cs15Key", "81","4879687250041")
	IniWrite($MacSm, "Cs15Key", "82","2128042478263")
	IniWrite($MacSm, "Cs15Key", "83","3578243538587")
	IniWrite($MacSm, "Cs15Key", "84","3096244508581")
	IniWrite($MacSm, "Cs15Key", "85","4336435699588")
	IniWrite($MacSm, "Cs15Key", "86","2317233759548")
	IniWrite($MacSm, "Cs15Key", "87","2727132555486")
	IniWrite($MacSm, "Cs15Key", "88","6996551041203")
	IniWrite($MacSm, "Cs15Key", "89","0463262884916")
	IniWrite($MacSm, "Cs15Key", "90","2792231045626")
	IniWrite($MacSm, "Cs15Key", "91","1154247940716")
	IniWrite($MacSm, "Cs15Key", "92","2344284682451")
	IniWrite($MacSm, "Cs15Key", "93","2146333363483")
	IniWrite($MacSm, "Cs15Key", "94","7040402632368")
	IniWrite($MacSm, "Cs15Key", "95","5555142687861")
	IniWrite($MacSm, "Cs15Key", "96","3922648525588")
	IniWrite($MacSm, "Cs15Key", "97","2498020435749")
	IniWrite($MacSm, "Cs15Key", "98","8039436549949")
	IniWrite($MacSm, "Cs15Key", "99","2696734026608")
	IniWrite($MacSm, "Cs15Key", "100","2396032072643")
	IniWrite($MacSm, "Cs15Key", "101","5634030696618")
	IniWrite($MacSm, "Cs15Key", "102","8362321875446")
	IniWrite($MacSm, "Cs15Key", "103","9748585333927")
	IniWrite($MacSm, "Cs15Key", "104","9539130852949")
	IniWrite($MacSm, "Cs15Key", "105","9724143611498")
	IniWrite($MacSm, "Cs15Key", "106","9035730237150")
	IniWrite($MacSm, "Cs15Key", "107","1765628747642")
	IniWrite($MacSm, "Cs15Key", "108","8267335625064")
	IniWrite($MacSm, "Cs15Key", "109","9872308440938")
	IniWrite($MacSm, "Cs15Key", "110","0040945670291")
	IniWrite($MacSm, "Cs15Key", "111","7437120445097")
	IniWrite($MacSm, "Cs15Key", "112","2914557016520")
	IniWrite($MacSm, "Cs15Key", "113","5201939075592")
	IniWrite($MacSm, "Cs15Key", "114","7023459460265")
	IniWrite($MacSm, "Cs15Key", "115","0004084032358")
	IniWrite($MacSm, "Cs15Key", "116","2579488650504")
	IniWrite($MacSm, "Cs15Key", "117","1435403495605")
	IniWrite($MacSm, "Cs15Key", "118","5722891164576")
	IniWrite($MacSm, "Cs15Key", "119","5812923357220")
	IniWrite($MacSm, "Cs15Key", "120","0684570142794")
	IniWrite($MacSm, "Cs15Key", "121","9051295359780")
	IniWrite($MacSm, "Cs15Key", "122","0766160464649")
	IniWrite($MacSm, "Cs15Key", "123","6023089585711")
	IniWrite($MacSm, "Cs15Key", "124","7282726715071")
	IniWrite($MacSm, "Cs15Key", "125","6965198320844")
	IniWrite($MacSm, "Cs15Key", "126","0590638349985")
	IniWrite($MacSm, "Cs15Key", "127","4887920308855")
	IniWrite($MacSm, "Cs15Key", "128","6224273676938")
	IniWrite($MacSm, "Cs15Key", "129","0234070701672")
	IniWrite($MacSm, "Cs15Key", "130","6829133462999")
	IniWrite($MacSm, "Cs15Key", "131","1514397024359")
	IniWrite($MacSm, "Cs15Key", "132","0338114504295")
	IniWrite($MacSm, "Cs15Key", "133","9180097837863")
	IniWrite($MacSm, "Cs15Key", "134","5695926015450")
	IniWrite($MacSm, "Cs15Key", "135","3160620118964")
	IniWrite($MacSm, "Cs15Key", "136","1190096475687")
	IniWrite($MacSm, "Cs15Key", "137","8359933291311")
	IniWrite($MacSm, "Cs15Key", "138","2696985056117")
	IniWrite($MacSm, "Cs15Key", "139","7853809758364")
	IniWrite($MacSm, "Cs15Key", "140","2111724559521")
	IniWrite($MacSm, "Cs15Key", "141","0578332166402")
	IniWrite($MacSm, "Cs15Key", "142","5735257958665")
	IniWrite($MacSm, "Cs15Key", "143","7914860615387")
	IniWrite($MacSm, "Cs15Key", "144","4063606421917")
	IniWrite($MacSm, "Cs15Key", "145","3419830076512")
	IniWrite($MacSm, "Cs15Key", "146","7381489152175")
	IniWrite($MacSm, "Cs15Key", "147","1628431817077")
	IniWrite($MacSm, "Cs15Key", "148","2876552803407")
	IniWrite($MacSm, "Cs15Key", "149","8856983770314")
	IniWrite($MacSm, "Cs15Key", "150","7530358675181")
	IniWrite($MacSm, "Cs15Key", "151","5174560117316")
	IniWrite($MacSm, "Cs15Key", "152","7322581102730")
	IniWrite($MacSm, "Cs15Key", "153","0719965552707")
	IniWrite($MacSm, "Cs15Key", "154","5620798081913")
	IniWrite($MacSm, "Cs15Key", "155","3185381184427")
	IniWrite($MacSm, "Cs15Key", "156","8680457335754")
	IniWrite($MacSm, "Cs15Key", "157","9869960983369")
	IniWrite($MacSm, "Cs15Key", "158","6915151587317")
	IniWrite($MacSm, "Cs15Key", "159","1272066388570")
	IniWrite($MacSm, "Cs15Key", "160","9301433546382")
	IniWrite($MacSm, "Cs15Key", "161","5817471724979")
	IniWrite($MacSm, "Cs15Key", "162","7946642797514")
	IniWrite($MacSm, "Cs15Key", "163","3926072554435")
	IniWrite($MacSm, "Cs15Key", "164","9956746016428")
	IniWrite($MacSm, "Cs15Key", "165","0590651353471")
	IniWrite($MacSm, "Cs15Key", "166","1714170985947")
	IniWrite($MacSm, "Cs15Key", "167","5499802054656")
	IniWrite($MacSm, "Cs15Key", "168","1163480853697")
	IniWrite($MacSm, "Cs15Key", "169","3739923265822")
	IniWrite($MacSm, "Cs15Key", "170","3354655249230")
	IniWrite($MacSm, "Cs15Key", "171","1204514178341")
	IniWrite($MacSm, "Cs15Key", "172","8144711732971")
	IniWrite($MacSm, "Cs15Key", "173","8451579776433")
	IniWrite($MacSm, "Cs15Key", "174","8206536922064")
	IniWrite($MacSm, "Cs15Key", "175","7267404852062")
	IniWrite($MacSm, "Cs15Key", "176","6365487067597")
	IniWrite($MacSm, "Cs15Key", "177","4919689608720")
	IniWrite($MacSm, "Cs15Key", "178","2960547428824")
	IniWrite($MacSm, "Cs15Key", "179","0504759069059")
	IniWrite($MacSm, "Cs15Key", "180","3050776320471")
	IniWrite($MacSm, "Cs15Key", "181","0694888961606")
	IniWrite($MacSm, "Cs15Key", "182","9655746791606")
	IniWrite($MacSm, "Cs15Key", "183","9610972107773")
	IniWrite($MacSm, "Cs15Key", "184","7937556243769")
	IniWrite($MacSm, "Cs15Key", "185","5898414073778")
	IniWrite($MacSm, "Cs15Key", "186","8334441434100")
	IniWrite($MacSm, "Cs15Key", "187","5988643975322")
	IniWrite($MacSm, "Cs15Key", "188","3522855506549")
	IniWrite($MacSm, "Cs15Key", "189","2721837712087")
	IniWrite($MacSm, "Cs15Key", "190","0375939353208")
	IniWrite($MacSm, "Cs15Key", "191","8326908182312")
	IniWrite($MacSm, "Cs15Key", "192","0058411868073")
	IniWrite($MacSm, "Cs15Key", "193","7386866002317")
	IniWrite($MacSm, "Cs15Key", "194","9415036075966")
	IniWrite($MacSm, "Cs15Key", "195","9415034784963")
	IniWrite($MacSm, "Cs15Key", "196","9268017928447")
	IniWrite($MacSm, "Cs15Key", "197","2554301377411")
	IniWrite($MacSm, "Cs15Key", "198","6199709193805")
	IniWrite($MacSm, "Cs15Key", "199","6595690064434")
	IniWrite($MacSm, "Cs15Key", "200","8764101331054")
	IniWrite($MacSm, "Cs15Key", "201","8695699602249")
	IniWrite($MacSm, "Cs15Key", "202","3953514404409")
	IniWrite($MacSm, "Cs15Key", "203","6308441865835")
	IniWrite($MacSm, "Cs15Key", "204","5438918032640")
	IniWrite($MacSm, "Cs15Key", "205","3567485290466")
	IniWrite($MacSm, "Cs15Key", "206","8052441431786")
EndFunc