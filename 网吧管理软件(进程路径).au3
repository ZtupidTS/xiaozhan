#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Process.au3>
#Include <WinAPIEx.au3>
#Include <array.au3>
Opt("TrayMenuMode",1)
#Region ### START Koda GUI section ### Form=d:\desk\ew.kxf
$Form1_1 = GUICreate("", 623, 443, 192, 114);��߿�
$Group1 = GUICtrlCreateGroup("", 8, 72, 609, 345);
$Group2 = GUICtrlCreateGroup("", 17, 336, 151, 73)
$Ipconfig = GUICtrlCreateButton("Ipconfig", 16, 88, 75, 25);ipconfig
$cmd = GUICtrlCreateButton("CMD", 104, 88, 75, 25);msconfig
$Button1 = GUICtrlCreateButton("����", 24, 376, 59, 25);ע�������
$Button2 = GUICtrlCreateButton("����", 96, 376, 59, 25);ע������
$Label4 = GUICtrlCreateLabel("ע�������/����", 48, 352, 93, 17);ע������
GUICtrlCreateGroup("", -99, -99, 1, 1)

$Pic1 = GUICtrlCreatePic(".\ew.jpg", 24, 8, 164, 60);Logo
FileInstall(".\ew.jpg","",1);LogoͼƬ·��
$Label1 = GUICtrlCreateLabel("������������",  216, 16, 284, 49);����
GUICtrlSetFont(-1,30,"����");��������
$Label2 = GUICtrlCreateLabel("������W������޹�˾  http://www.ew58.com", 16, 424, 277, 17);ע��
GUICtrlSetFont(-1,10,4,4,"����");ע������
GUICtrlSetColor($Label2,0x3F3FE2)
GUICtrlSetCursor($Label2,0)
$Label3 = GUICtrlCreateLabel("Style.J", 384, 424, 132, 17);ע��
GUICtrlSetFont(-1,10,4,4,"����");ע������
GUICtrlSetColor($Label3,0x3F3FE2)
GUICtrlSetCursor($Label3,0)
GUISetState(@SW_SHOW);ע��

$Combo1 = GUICtrlCreateCombo("", 176, 344, 121, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL));Ping��д������
$pingdate = GUICtrlSetData(-1,"192.168.0.1|192.168.1.1|218.85.152.99");Ping��ѡ����
$Ping = GUICtrlCreateButton("Ping", 304, 344, 43, 25);Ping-OKѡ��

$Group3 = GUICtrlCreateGroup("�޸ļ������", 176, 368, 169, 41);�޸ļ������-�߿�
$name = RegRead("HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName","ComputerName");�޸ļ������-��ȡ�ɼ������
$Input1 = GUICtrlCreateInput($name, 184, 384, 113, 21);�޸ļ������-��д�������
$Button3 = GUICtrlCreateButton("OK", 304, 384, 35, 25);�޸ļ������-ȷ��:OK

$qidong = GUICtrlCreateButton("������", 16, 120, 75, 25)
$xitong = GUICtrlCreateButton("ϵͳ����", 104, 120, 75, 25)
$yunxing = GUICtrlCreateButton("����", 16, 152, 75, 25)
$kongzhimianban = GUICtrlCreateButton("�������", 104, 152, 75, 25)
$jsjgl = GUICtrlCreateButton("���������", 16, 184, 75, 25)
$diskgl = GUICtrlCreateButton("���̹���", 104, 184, 75, 25)
$xtser = GUICtrlCreateButton("ϵͳ����", 16, 216, 75, 25)
$zucelie = GUICtrlCreateButton("�����", 104, 216, 75, 25)
$regedit = GUICtrlCreateButton("ע���", 16, 248, 75, 25)
$appwiz = GUICtrlCreateButton("���ɾ������", 104, 248, 75, 25)
$setlan = GUICtrlCreateButton("��������", 16, 280, 75, 25)
$explorer = GUICtrlCreateButton("����Explorer", 104, 280, 75, 25)
$shutdown = GUICtrlCreateButton("�ػ�", 16, 312, 75, 25)
$restart = GUICtrlCreateButton("����", 104, 312, 75, 25)




$Group4 = GUICtrlCreateGroup("���̹���", 192, 88, 409, 249)

$shuaxin = GUICtrlCreateButton("ˢ��", 216, 312, 67, 25)
$jieshu = GUICtrlCreateButton("����", 304, 312, 67, 25)
$Button18 = GUICtrlCreateButton("Button18", 392, 312, 67, 25)
$Button19 = GUICtrlCreateButton("Button19", 480, 312, 67, 25)

Dim $ListView1
$ListView1 = list()



$Group5 = GUICtrlCreateGroup("ϵͳ�Զ���¼", 352, 344, 249, 65)
$Label5 = GUICtrlCreateLabel("����Ա�˻�:", 360, 360, 68, 17)
$Label6 = GUICtrlCreateLabel("����Ա����:", 360, 384, 68, 17)
$user = GUICtrlCreateInput(@UserName, 432, 360, 89, 21)
$pass = GUICtrlCreateInput("", 432, 384, 89, 21)
$ok = GUICtrlCreateButton("ȷ������", 528, 352, 67, 25)
$no = GUICtrlCreateButton("ȡ������", 528, 384, 67, 25)







#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
        Select
			Case $nmsg = $GUI_EVENT_CLOSE
        Exit
		    Case $nmsg = $Button1;ע�������
				RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System", "DisableRegistryTools", "REG_DWORD", "00000001")
				MsgBox(4096,"��ʾ","ע��������ɹ�!")
			Case $nmsg = $Button2;ע������
				RegDelete("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System", "DisableRegistryTools")
				MsgBox(4096,"��ʾ","ע�������ɹ�!");ע�����ʾ
			Case $nmsg = $Ipconfig
				Run(@ComSpec & " /k ipconfig/all");Ipconfig
			Case $nmsg = $cmd
				Run(@ComSpec & " /k");CMD
		    Case $nMsg = $Ping
				Run(@ComSpec & " /k ping " &GUICtrlRead($Combo1)& " -t")
			Case $nmsg = $Button3;�޸ļ������
				RegWrite("HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName","ComputerName","REG_SZ",$Input1)
                RegWrite("HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters","NV Hostname","REG_SZ",$Input1)
				RegWrite("HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters","Hostname","REG_SZ",$Input1)
				
			Case $nmsg = $qidong
				Run("msconfig.exe")
			Case $nmsg = $xitong
				_RunDOS("sysdm.cpl")
			Case $nmsg = $Label2
				ShellExecute("http://www.ew58.com")
			Case $nmsg = $Label3
				ShellExecute("www.baidu.com")
			Case $nmsg = $yunxing
				Send("#r")
			Case $nmsg = $kongzhimianban
				_RunDOS("rundll32.exe shell32.dll,Control_RunDLL")
			Case $nmsg = $jsjgl
		        _RunDOS("compmgmt.msc")
			Case $nmsg = $diskgl
				_RunDOS("diskmgmt.msc")
			Case $nmsg = $xtser
				_RunDOS("services.msc")
			Case $nmsg = $zucelie
				_RunDOS("gpedit.msc")
			Case $nmsg = $regedit
				_RunDOS("regedit.exe")
			Case $nmsg = $appwiz
				_RunDOS("appwiz.cpl")
			Case $nmsg = $setlan
				_RunDOS("%windir%\explorer.exe ::{7007ACC7-3202-11D1-AAD2-00805FC1270E}")
			Case $nmsg = $explorer
				ProcessClose("explorer.exe")
				Sleep(1000)
				_RunDOS("explorer.exe")
			Case $nmsg = $shutdown
				Shutdown(8)
			Case $nmsg = $restart
				Shutdown(2)
				
				
				
			Case $nmsg = $ok
				RegWrite('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon','DefaultUserName','REG_SZ',GUICtrlRead($user))
				RegWrite('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon','DefaultPassword','REG_SZ',GUICtrlRead($pass))
		        RegWrite('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon','AutoAdminLogon','REG_SZ',1)
		        MsgBox(0,"��ʾ","���óɹ�")
	        Case $nmsg = $no
				RegWrite('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon','AutoAdminLogo','REG_SZ',0)
		        MsgBox(0,"��ʾ","���óɹ�")
			
			
			
			Case $nmsg = $GUI_EVENT_CLOSE
                        ExitLoop
			Case $nmsg = $jieshu
                        proclose()
			Case $nmsg = $shuaxin
                        $ListView1 = list()
			
			
          
				
				
        Endselect
WEnd
	
	




Func list()
	Local $aAdjust,$hToken ,$ListView1
	$hToken = _WinAPI_OpenProcessToken(BitOR($TOKEN_ADJUST_PRIVILEGES, $TOKEN_QUERY))
	_WinAPI_AdjustTokenPrivileges($hToken, $SE_DEBUG_NAME, $SE_PRIVILEGE_ENABLED, $aAdjust)
	If $ListView1 Then GUICtrlDelete($ListView1)
	Local $list = ProcessList()
	$ListView1 = GUICtrlCreateListView("������          |PID |·��                                                                     ", 200, 104, 393, 201)
	
	;$aList = ProcessList()
	For $i = 1 To $List[0][0]
		;$aList[$i][1] = _WinAPI_GetProcessCommandLine($aList[$i][1])
		GUICtrlCreateListViewItem($list[$i][0] & "|" & $list[$i][1] & "|" & _WinAPI_GetProcessCommandLine($list[$i][1]), $ListView1)
	Next
	_WinAPI_AdjustTokenPrivileges($hToken, $SE_DEBUG_NAME, 0, $aAdjust)
	_WinAPI_CloseHandle($hToken)
	Return $ListView1
EndFunc   ;==>list


Func proclose()
        $pro = StringSplit(GUICtrlRead(GUICtrlRead($ListView1)), "|")
        If $pro[0] >= 2 Then
                If ProcessExists($pro[2]) Then ProcessClose($pro[2]) ;;runwait(@ComSpec & " /c taskkill /f /t /pid " & $pro[2],"",@sw_hide)
        Else
                MsgBox(4096, "����", "�޷���ֹ���̣�")
                Return
        EndIf
        Sleep(1000)
        If ProcessExists($pro[2]) Then
                MsgBox(4096, "����", "�޷���ֹ���̣�")
                Return
        Else
                list()
        EndIf
EndFunc   ;==>proclose