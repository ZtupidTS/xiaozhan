#NoTrayIcon
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <SetupApi.au3>
#include<file.au3>

#Region ### START Koda GUI section ### Form=
Dim $szDrive, $szDir, $szFName, $szExt
$TestPath = _PathSplit(@ScriptFullPath, $szDrive, $szDir, $szFName, $szExt)
;MsgBox(0,0,$szDrive)
;�鿴��������·���Ƿ��ʱ���·�����ó����ڷǱ���·��ִ��ʱ���������
If StringLeft($szDrive, 2) = "\\" or DriveGetType($szDrive) = "Network"  Then 
        MsgBox(16,"error","pls copy it to the local path then run it again")
        Exit
EndIf

Global $state
$Form1 = GUICreate("PCC(GUI)", 340, 162, 192, 114)
$Checkbox1 = GUICtrlCreateCheckbox("Disable USB storage", 16, 16, 140, 17)
$Checkbox2 = GUICtrlCreateCheckbox("Disable Web Camera", 16, 48, 140, 17)
$Checkbox3 = GUICtrlCreateCheckbox("Disable 1394", 16, 80, 140, 17)
$Checkbox4 = GUICtrlCreateCheckbox("Disable SD/MMC Card", 185, 16, 140, 17)
$Checkbox5 = GUICtrlCreateCheckbox("Undefined", 185, 48, 140, 17)
$Checkbox6 = GUICtrlCreateCheckbox("Undefined", 185, 80, 140, 17)
$Button1 = GUICtrlCreateButton("Run", 120, 112, 105, 33, $WS_GROUP)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
                Case $GUI_EVENT_CLOSE
                        Exit
                Case $Button1 
                        stop1394();�����豸������ͣ�ö˿ڣ��й���ԱȨ�޵ĺ������ֶ����ö˿�
                        stopimage();���豸������ͣ�ã���ע�����á��������Ѵ��ڵ��豸��Ч��
                        stopusbstor();Ŀǰ������Щ��ӡ����װ�����󣬻Ὣ���ǹܿ��趨��ʹ��ʧЧ����������´˷�����Ч��
                        stopsff();ͣ��SFF Storage Class Driver��SD/MMC Card��
                        sleep(1000)
                        MsgBox(64,"Effective after reboot",$state)
                
        EndSwitch
WEnd


Func stop1394();�����豸������ͣ�ö˿�
        Dim  $hDevs, $tDevInfo, $sDeviceID,$devicename[1][2] = [[0]]
        $hDevs = _SetupDiGetClassDevs($DIGCF_PRESENT, "1394")
        ;MsgBox(0,0,$hDevs)
        If _SetupDiEnumDeviceInfo($hDevs, $devicename[0][0], $tDevInfo) = 0 Then $state = "1394 not found" 
        While _SetupDiEnumDeviceInfo($hDevs, $devicename[0][0], $tDevInfo)
                        $devicename[0][0] += 1
                        $sDescr = _SetupDiGetDeviceRegistryProperty($hDevs, $tDevInfo, $SPDRP_DEVICEDESC)
                        $sName = _SetupDiGetDeviceRegistryProperty($hDevs, $tDevInfo, $SPDRP_FRIENDLYNAME)
                        If $sName <> "" Then $sDescr = $sName
                        Redim $devicename[$devicename[0][0] + 1][2]
                        $devicename[$devicename[0][0]][0] = $sDescr        ; Ӳ��������Ϣ
                        $devicename[$devicename[0][0]][1] = _SetupDiGetDeviceInstanceID($hDevs, $tDevInfo) ; �豸����ID
                                    ;MsgBox(0,"1",$devicename[$devicename[0][0]][1])
                                        ;FileWriteLine(@DesktopDir&"\1.log",$devicename[$devicename[0][0]][1] & @CRLF)
                        $sDeviceID = $devicename[$devicename[0][0]][1]; Ӳ���豸����ID��
                        _SetupDiCreateDeviceDevs($sDeviceID, $hDevs, $tDevInfo)
                        If BitAND(GUICtrlRead($Checkbox3), $GUI_CHECKED) = $GUI_CHECKED  Then
                                $fResult = _SetupDiDisableDevice($hDevs, $tDevInfo, True) ; ���豸������ͣ������ͷ
                                If $fResult = True Then
                                                $state = "1394 was Disabled"
                                        Else
                                                $state = "1394�˿�ͣ�Õr�l���e�`�������룺" & @error 
                                EndIf
                                ;$fResult = _SetupDiDisableDevice($hDevs, $tDevInfo, False) ; ���á�
                        Else
                                $fResult = _SetupDiDisableDevice($hDevs, $tDevInfo, False) ; ���á�
                                If $fResult = True Then
                                                $state = "1394 was enabled"
                                Else
                                                $state = "1394�˿چ��Õr�l���e�`�������룺" & @error 
                                EndIf
                        EndIf
                                
                        ;_SetupDiDestroyDeviceInfoList($hDevs) ; �����豸��Ϣ����
                        
        WEnd 
        
EndFunc


Func stopimage()
                ;$testdata = InputBox("���","����һ�����Գ���","������Ҫ���Զ�����","")

                Local $hDevs, $tDevInfo, $sDeviceID,$devicename[1][2] = [[0]]
                $hDevs = _SetupDiGetClassDevs($DIGCF_PRESENT, "image")
                ;MsgBox(0,0,$hDevs)
                If _SetupDiEnumDeviceInfo($hDevs, $devicename[0][0], $tDevInfo) = 0 Then $state = $state& @CRLF &"Web Camera not found" 
                While _SetupDiEnumDeviceInfo($hDevs, $devicename[0][0], $tDevInfo)
                                $devicename[0][0] += 1
                                $sDescr = _SetupDiGetDeviceRegistryProperty($hDevs, $tDevInfo, $SPDRP_DEVICEDESC)
                                $sName = _SetupDiGetDeviceRegistryProperty($hDevs, $tDevInfo, $SPDRP_FRIENDLYNAME)
                                If $sName <> "" Then $sDescr = $sName
                                Redim $devicename[$devicename[0][0] + 1][2]
                                $devicename[$devicename[0][0]][0] = $sDescr        ; Ӳ��������Ϣ
                                $devicename[$devicename[0][0]][1] = _SetupDiGetDeviceInstanceID($hDevs, $tDevInfo) ; �豸����ID
                                ;MsgBox(0,"1",$devicename[$devicename[0][0]][1])
                                                ;FileWriteLine(@DesktopDir&"\1.log",$devicename[$devicename[0][0]][1] & @CRLF)
                                $sDeviceID = $devicename[$devicename[0][0]][1]; Ӳ���豸����ID��
                

                                If BitAND(GUICtrlRead($Checkbox2), $GUI_CHECKED) = $GUI_CHECKED  Then
                                        
                                        $fResult = _SetupDiDisableDevice($hDevs, $tDevInfo, True) ; ���豸������ͣ������ͷ
                                        If $fResult = True Then
                                                $state = $state& @CRLF &"Web Camera was Disabled"
                                        Else
                                                $state = $state& @CRLF &"�z���^ͣ�Õr�l���e�`�������룺" & @error 
                                        EndIf
                                Else
                                        $fResult = _SetupDiDisableDevice($hDevs, $tDevInfo, False) ; ���á�
                                        If $fResult = True Then
                                                $state = $state& @CRLF &"Web Camera was enabled"
                                        Else
                                                $state = $state& @CRLF &"�z���^���Õr�l���e�`�������룺" & @error 
                                        EndIf
                                EndIf
                        
                                ;_SetupDiDestroyDeviceInfoList($hDevs) ; �����豸��Ϣ����
                                
                        
                ;�]�Ա���Ôz���^
                        Dim  $i = 0 ,$j = 0,$var,$var1,$var2,$var3
                        While 1  ;����services�����Ӽ���
                                        $i+=1
                                        $var1 = RegEnumKey("HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services",$i);�Ӽ���
                                        If @error <> 0 then ExitLoop
                                        $j = 0 
                                        while 1;����ĳһ�Ӽ���������
                                                $j+=1
                                                $var2 = RegEnumVal("HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\"&$var1&"\Enum",$j);������
                                                If @error <> 0 then ExitLoop
                                                $var3 = RegRead("HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\"&$var1&"\Enum",$var2) ;����ֵ
                                                If stringcompare($var3 , $sDeviceID)= 0  Then ;��ؼ�һ�䣬��ȡ���豸����ID�ű����ȶ�
                                                        If BitAND(GUICtrlRead($Checkbox2), $GUI_CHECKED) = $GUI_CHECKED  Then
                                                                RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\"&$var1,"start","REG_DWORD",00000004)
                                                                ;MsgBox(0,"�Ӽ�Ϊ��"&$i&"λ,�Ӽ���Ϊ"&$var1&"������Ϊ����������","��"&$j&"������Ϊ��"&$var2&"��ֵΪ��"&$var3)
                                                                ;consolewrite("�Ӽ�Ϊ��"&$i&"λ,�Ӽ���Ϊ"&$var1& "����Ϊ����������"&"��"&$j&"������Ϊ��"&$var2&" & ֵΪ��"&$var3  & @crlf)
                                                        Else
                                                                RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\"&$var1,"start","REG_DWORD",00000003)
                                                        EndIf
                                                                
                                                EndIf        
                                                
                                        WEnd
                        
                        WEnd
                
                WEnd 
        
EndFunc                
                        

Func stopusbstor()
        
                ;����U�P���؆�����Ч
                If BitAND(GUICtrlRead($Checkbox1), $GUI_CHECKED) = $GUI_CHECKED  Then
                        FileMove(@WindowsDir&"\inf\usbstor.inf",@WindowsDir)  ;���Թܿ�ǰû��ʹ�ù�U�̣�������ִ��������
                        FileMove(@WindowsDir&"\inf\usbstor.pnf",@WindowsDir)
                        RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBSTOR","start","REG_DWORD",00000004)
                        ;FileWriteLine(@TempDir &"\file2.txt", "�ܿؠ�B3������USB�惦�O��" & @CRLF)
                        $state = $state& @CRLF &"USB storage was Disabled"        
                Else;����U�P���؆�����Ч
                        FileMove(@WindowsDir&"\usbstor.inf",@WindowsDir&"\inf")
                        FileMove(@WindowsDir&"\usbstor.pnf",@WindowsDir&"\inf")
                        RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBSTOR","start","REG_DWORD",00000003)
                        $state = $state& @CRLF &"USB storage was enabled"
                        ;FileWriteLine(@TempDir &"\file2.txt", "�ܿؠ�B4�����Sʹ��USB�惦�O��" & @CRLF)
                                
                EndIf 

EndFunc

Func stopsff()
                ;����SFF Storage Class Driver��SD/MMC Card��
                If BitAND(GUICtrlRead($Checkbox4), $GUI_CHECKED) = $GUI_CHECKED  Then 
                        If RegRead("HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\sffdisk","DisplayName") = "" Then
                                FileMove(@WindowsDir&"\inf\sffdisk.inf",@WindowsDir)  ;���Թܿ�ǰû��ʹ�ù�SFF����������ִ��������
                                FileMove(@WindowsDir&"\inf\sffdisk.PNF",@WindowsDir)
                        Else
                                FileMove(@WindowsDir&"\inf\sffdisk.inf",@WindowsDir)  
                                FileMove(@WindowsDir&"\inf\sffdisk.PNF",@WindowsDir)
                                RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\sffdisk","start","REG_DWORD",00000004)
                        EndIf
                        $state = $state& @CRLF &"SD/MMC Card was Disabled"        
                Else;����SFF Storage Class Driver��SD/MMC Card��
                        FileMove(@WindowsDir&"\sffdisk.inf",@WindowsDir&"\inf")
                        FileMove(@WindowsDir&"\sffdisk.PNF",@WindowsDir&"\inf")
                        RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\sffdisk","start","REG_DWORD",00000003)
                        $state = $state& @CRLF &"SD/MMC Card was enabled"
                                
                EndIf         

EndFunc