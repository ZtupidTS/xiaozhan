
 #include <GUIConstants.au3> 
#include <ButtonConstants.au3> 
#include <EditConstants.au3> 
#include <GUIConstantsEx.au3> 
#include <StaticConstants.au3> 
#include <WindowsConstants.au3> 
#include <Array.au3> 
#Include <GuiStatusBar.au3> 

$sUsS = @UserName    ;������֤ȡֵ������ȡӲ������� 
$sUsN = "ggggggg"   ;������֤���� 
$sUsP = "00"   ;��֤Ȩ���������Լ����ã�������ö�̬�� 
;If $sUsS = $sUsN Then 
;Else 
  ;  $sUsPi = InputBox("Ȩ�޺˲�", "���������룺","", "#",200,80) 
    ;If $sUsPi = $sUsP Then 
         
   ; Else 
        MsgBox(0,"","��ѽ�����������!") 
  ;      Exit 
  ;  EndIf 
;EndIf 

#Region ### START Koda GUI section ### Form= 
$Form1_1 = GUICreate("TOOLS", 458, 221, 267, 128) 
$Group1 = GUICtrlCreateGroup("ϵͳ����", 8, 32, 193, 185) 
$Button1 = GUICtrlCreateButton("�Զ���½", 8, 48, 57, 25, 0) 
$Button2 = GUICtrlCreateButton("�û����", 8, 72, 57, 25, 0) 
$Button3 = GUICtrlCreateButton("��������", 8, 96, 57, 25, 0) 
$Button4 = GUICtrlCreateButton("ǧ������", 8, 120, 57, 25, 0) 
$Button5 = GUICtrlCreateButton("ע����", 8, 144, 57, 25, 0) 
$Button6 = GUICtrlCreateButton("ע�����", 8, 168, 57, 25, 0) 
$Button7 = GUICtrlCreateButton("�����Ҽ�", 72, 48, 57, 25, 0) 
$Button8 = GUICtrlCreateButton("SATAͼ��", 72, 72, 57, 25, 0) 
$Button9 = GUICtrlCreateButton("����^^", 72, 96, 57, 25, 0) 
$Button10 = GUICtrlCreateButton("�Ż���ʦ", 72, 120, 57, 25, 0) 
$Button11 = GUICtrlCreateButton("�Ż�����", 72, 144, 57, 25, 0) 
$Button12 = GUICtrlCreateButton("���ζ˿�", 72, 168, 57, 25, 0) 
$Button13 = GUICtrlCreateButton("ϵͳ����", 136, 48, 57, 25, 0) 
$Button14 = GUICtrlCreateButton("��������", 136, 72, 57, 25, 0) 
$Button15 = GUICtrlCreateButton("���̹���", 136, 96, 57, 25, 0) 
$Button16 = GUICtrlCreateButton("��ȫ��ʿ", 136, 120, 57, 25, 0) 
$Button17 = GUICtrlCreateButton("IME.����", 136, 144, 57, 25, 0) 
GUICtrlCreateGroup("", -99, -99, 1, 1) 
$Label1 = GUICtrlCreateLabel("Powerd by ȦȦ . ���ĵ���ɱ��...", 8, 8, 199, 17) 
GUICtrlSetColor(-1, 0x008000) 
$Group2 = GUICtrlCreateGroup("��������", 312, 32, 137, 89) 


;�������ÿ�ʼ��... 
dim $_key,$_ikb_num,$_server,$_icafe8 
$_ikb_num=iniread("config.ini","0","ikb_num","") 
$_key=iniread("config.ini","0","key","") 
$_server=iniread("config.ini","0","server","") 
$_icafe8=iniread("config.ini","0","icafe8","") 
;����������� 
$Input1 = GUICtrlCreateInput($_ikb_num, 320, 48, 49, 21) 
$Input3 = GUICtrlCreateInput($_key, 320, 72, 129, 21) 
GUICtrlSetBkColor(-1, 0xA6CAF0) 
$Input2 = GUICtrlCreateInput($_server, 366, 48, 82, 21) 
GUICtrlSetBkColor(-1, 0xD4D0C8) 
$Input4 = GUICtrlCreateInput($_icafe8, 320, 96, 129, 21) 
GUICtrlSetBkColor(-1, 0xC0DCC0) 
GUICtrlCreateGroup("", -99, -99, 1, 1) 
$Button18 = GUICtrlCreateButton("����", 400, 0, 43, 25, 0) 
$Button19 = GUICtrlCreateButton("��ά", 352, 0, 43, 25, 0) 
$Button20 = GUICtrlCreateButton("IKB", 304, 0, 43, 25, 0) 
;���϶���һ��İɣ�û����������棬�������ǺǺǴ�ʱ�� 


;IP�����������ÿ�ʼ��... 
dim $num=inputbox ("Powerd by ȦȦ","�����������","","") 
IniWrite("config.ini","00","num",$num) 
dim $num=Iniread("config.ini","00","num","") 
dim $ipmove=iniread("config.ini","00","IPMOVE","") 
dim $ip=iniread("config.ini","00","IP","")&$num+$IPMOVE 
dim $computername=iniread("config.ini","00","CNAME","")&$num 
dim $netmask=iniread("config.ini","00","NETMASK","") 
dim $gateway=Iniread("config.ini","00","GATEWAY","") 
dim $dns1=Iniread("config.ini","00","DNS1","") 
dim $dns2=Iniread("config.ini","00","DNS2","") 
dim $cdkey= iniread ("CDKEY.ini","CS-CDKEY",$num,"") ;CS-CDKEY 
dim $_cname=iniread("config.ini","00","CNAME","") 
dim $ipmove=iniread("config.ini","00","IPMOVE","") 

$Input5 = GUICtrlCreateInput($computername, 248, 72, 57, 21) 

$Input6 = GUICtrlCreateInput($ipmove, 248, 96, 57, 21) 

$Label2 = GUICtrlCreateLabel("����������", 240, 32, 64, 17) 
$Label3 = GUICtrlCreateLabel("λƫ��", 264, 48, 40, 17) 
$Group3 = GUICtrlCreateGroup("IP ����", 216, 120, 241, 97) 
$Input7 = GUICtrlCreateInput($ip, 312, 128, 137, 21) 

$Input8 = GUICtrlCreateInput($netmask, 312, 146, 137, 21) 

$Input9 = GUICtrlCreateInput($gateway, 312, 165, 137, 21) 

$Input11 = GUICtrlCreateInput($dns1, 340, 185, 109, 21) 

$Input10 = GUICtrlCreateInput($dns2, 232, 185, 109, 21) 

$Button21 = GUICtrlCreateButton("����", 270, 160, 42, 25, 0) 
$Button22 = GUICtrlCreateButton("ȷ��", 230, 160, 42, 25, 0) 
GUICtrlCreateGroup("", -99, -99, 1, 1) 
GUISetState(@SW_SHOW) 
#EndRegion ### END Koda GUI section ### 
;��һ������ա����� 

While 1 
    $nMsg = GUIGetMsg() 
    Switch $nMsg 
        Case $GUI_EVENT_CLOSE 
            Exit 

        Case $Form1_1 
        Case $Form1_1 
        Case $Form1_1 
        Case $Form1_1 
        Case $Button1 
            Run(@ComSpec & ' /c control userpasswords2',"", @SW_HIDE) 
        Case $Button2 
                Run(@ComSpec & ' /c lusrmgr.msc',"", @SW_HIDE) 
        Case $Button3 
        Case $Button4 
        Case $Button5 
        Case $Button6 
        Case $Button7 
            Run(@ComSpec & ' /c reg delete HKEY_CLASSES_ROOT\Directory\Background\shellex\ContextMenuHandlers /f',"", @SW_HIDE) 
            Run(@ComSpec & ' /c reg add HKEY_CLASSES_ROOT\Directory\Background\shellex\ContextMenuHandlers\new /ve /d ',"", @SW_HIDE) 
            Run(@ComSpec & ' /c reg delete HKEY_CLASSES_ROOT\Directory\Background\shellex\ContextMenuHandlers /f',"", @SW_HIDE) 
            Run(@ComSpec & ' /c reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v HotKeysCmds /f',"", @SW_HIDE) 
            Run(@ComSpec & ' /c reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v IgfxTray /f',"", @SW_HIDE) 
            msgbox(0,"����ɹ�","����ɹ�") 

        Case $Button8 
            Run(@ComSpec & ' /c reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\nvata /v DisableRemovable /t REG_DWORD /d 1 /f',"", @SW_HIDE) 
            Run(@ComSpec & ' /c reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\nvatabus /v DisableRemovable /t REG_DWORD /d 1 /f',"", @SW_HIDE) 
            msgbox(0,"����ɹ�","����ɹ�") 
             
        Case $Button9 
             
        Case $Button10 
            ShellExecuteWait("C:\Program Files\Wopti\WoptiUtilities.exe") 
             
        Case $Button11 
        Case $Button12 
        Case $Button13 
            Run(@ComSpec & ' /c sysdm.cpl',"", @SW_HIDE) 
             
        Case $Button14 
            ShellExecuteWait("::") 
        Case $Button15 
            Run(@ComSpec & ' /c taskmgr.exe',"", @SW_HIDE) 
        Case $Button16 
            ShellExecuteWait("C:\Program Files0safe0Safe.exe") 
             
        Case $Button17 
        Case $Label1 
        Case $Input1 
        Case $Input3 
        Case $Input2 
        Case $Input4 
             
        Case $nmsg=$Button18 ;IKB����ά 
             $_input1=GUICtrlRead($Input1) 
             $_input2=GUICtrlRead($Input2) 
             $_input3=GUICtrlRead($Input3) 
             $_input4=GUICtrlRead($Input4) 
             IniWrite("config.ini","0","ikb_num",$_input1) 
             IniWrite("config.ini","0","server",$_input2) 
             IniWrite("config.ini","0","key",$_input3) 
             IniWrite("config.ini","0","icafe8",$_input4) 
             
             
             
         
    Case $Button19 
         
    Case $Button20 
        $_input1=GUICtrlRead($Input1) 
             $_input2=GUICtrlRead($Input2) 
             $_input3=GUICtrlRead($Input3) 
             $_input4=GUICtrlRead($Input4) 
            runwait (".\ikb\setup.exe") 
WinWaitActive ("iKeeper���簲ȫ����ϵͳ ���ɰ� �Ʒѿͻ��� ��װ����","����: ����������������Ȩ���͹��ʹ�Լ�ı�����δ����Ȩ���Ը��ƻ�ɢ���������ȫ�����κβ��֣����ᵼ�����������º����³ͷ��������ܵ���������Χ�ڵ�����޶ȵ����ߡ�") 
send("") 
send("!A") 
send("") 
send("") 
send("") 

send($_input3) 
send("") 
send($_input1) 
send("") 
send("") 
send($_input2) 
ControlClick("iKeeper���簲ȫ����ϵͳ ���ɰ� �Ʒѿͻ��� ��װ����","���ɳ������ݷ�ʽ","Button5") 
send("") 
send("") 
send("") 
send("") 
send("") 
WinWaitActive ("iKeeper���簲ȫ����ϵͳ ���ɰ� �Ʒѿͻ��� ��װ����","iKeeper���簲ȫ����ϵͳ\�Ʒѿͻ���") 
send("") 
send("") 
sleep(10000) 
send("") 
send("") 

        Case $Input5 
        Case $Input6 
        Case $Label2 
        Case $Label3 
        Case $Input7 
        Case $Input8 
        Case $Input9 
        Case $Input11 
        Case $Input10 
        Case $Button21 ;����IP�����Ը������� 
            $_computername=GUICtrlRead($input5) 
            $_ipmove=GUICtrlRead($input6) 
            $_ip=GUICtrlRead($input7) 
            $_netmask=GUICtrlRead($input8) 
            $_gateway=GUICtrlRead($input9) 
            $_dns1=GUICtrlRead($input11) 
            $_dns2=GUICtrlRead($input10) 
            IniWrite("config.ini","00","CNAME",$_computername) 
            IniWrite("config.ini","00","IPMOVE",$_ipmove) 
            IniWrite("config.ini","00","ip",$_ip) 
            IniWrite("config.ini","00","netmask",$_netmask) 
            IniWrite("config.ini","00","gateway",$_gateway) 
            IniWrite("config.ini","00","dns1",$_dns1) 
            IniWrite("config.ini","00","dns2",$_dns2) 
            msgbox(0,"�������","�����������") 
             
             
        Case $nmsg=$Button22 ;IP���������������� 

;CS-CDKEY,IPX�� 
if $cdkey = -1 Then 
    msgbox(4064,"Wrong","�Ҳ���cskey.ini�ļ�") 
    Exit 
EndIf 
RegWrite ("HKEY_CURRENT_USER\Software\Valve\CounterStrike\Settings","KEY","REG_SZ",$cdkey) 
RegWrite ("HKEY_CURRENT_USER\Software\Valve\HALF-LIFE\Settings","KEY","REG_SZ",$cdkey) 
RegWrite ("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NwlnkIpx\Parameters","VirtualNetworkNumber", "REG_DWORD", $num) 

$_computername=GUICtrlRead($input5) 
$_ipmove=GUICtrlRead($input6) 
$_ip=GUICtrlRead($input7) 
$_netmask=GUICtrlRead($input8) 
$_gateway=GUICtrlRead($input9) 
$_dns1=GUICtrlRead($input11) 
$_dns2=GUICtrlRead($input10) 

;���û����� 
_SetComputerName($_computername) 
;IP���� 
_SetIpAddress($_ip, $_netmask, $_gateway) 
;DNS���� 
_DNS($_dns1, $_dns2) 
IniWrite("config.ini","00","CNAME",$_cname) 
DIM $ip1=IniRead("config.ini","00","ip1","") 
IniWrite("config.ini","00","ip",$ip1) 
msgbox(0,"�������","�����������") 


    EndSwitch 
WEnd 


;�Զ��庯�� 
Func _SetComputerName($_computername) 
$strComputer = "localhost" 
        $objWMIService = ObjGet("winmgmts:\" & $strComputer & "\root\cimv2") 
        $colComputers = $objWMIService.ExecQuery ("Select * from Win32_ComputerSystem") 
        For $objComputer In $colComputers 
                $objComputer.Rename ($_computername) 
            Next 
        EndFunc        ;===>_SetComputerName 
         
Func _SetIpAddress($_ip, $_netmask, $_gateway) 
    $objWMIService = ObjGet("winmgmts:\" & "." & "\root\CIMV2") 
    $colItems = $objWMIService.ExecQuery("Select * FROM Win32_NetworkAdapterConfiguration Where IPEnabled =TRUE") 
    $_IP = _ArrayCreate($_IP) 
    $_netmask = _ArrayCreate($_netmask) 
    $_gateway = _ArrayCreate($_gateway) 
    $GatewayMetric = _ArrayCreate("1") 
     
    For $objItem In $colItems 
        $errEnable = $objItem.EnableStatic($_ip, $_netmask) 
        $errGateways = $objItem.SetGateways($_gateway, $GatewayMetric) 
    Next 
EndFunc   ;==>_SetIpAddress 

Func _DNS($_dns1, $_dns2) 
    $objWMIService = ObjGet("winmgmts:\" & "." & "\root\CIMV2") 
    $colItems = $objWMIService.ExecQuery("Select * FROM Win32_NetworkAdapterConfiguration Where IPEnabled =TRUE") 
    $DNS = _ArrayCreate($_dns1, $_dns2) 
     
    For $objItem In $colItems 
        $strDNSServerSearchOrder = $objItem.SetDNSServerSearchOrder($dns) 
    Next 
EndFunc   ;==>_DNS 

