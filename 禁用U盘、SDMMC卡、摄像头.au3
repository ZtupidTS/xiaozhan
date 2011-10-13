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
;查看程序所在路径是否问本地路径，该程序在非本地路径执行时会产生错误
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
                        stop1394();仅从设备管理器停用端口，有管理员权限的很容易手动启用端口
                        stopimage();从设备管理器停用，从注册表禁用。但仅对已存在的设备生效，
                        stopusbstor();目前发现有些打印机安装驱动后，会将覆盖管控设定，使其失效，其它情况下此方法有效。
                        stopsff();停用SFF Storage Class Driver（SD/MMC Card）
                        sleep(1000)
                        MsgBox(64,"Effective after reboot",$state)
                
        EndSwitch
WEnd


Func stop1394();仅从设备管理器停用端口
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
                        $devicename[$devicename[0][0]][0] = $sDescr        ; 硬件描述信息
                        $devicename[$devicename[0][0]][1] = _SetupDiGetDeviceInstanceID($hDevs, $tDevInfo) ; 设备范例ID
                                    ;MsgBox(0,"1",$devicename[$devicename[0][0]][1])
                                        ;FileWriteLine(@DesktopDir&"\1.log",$devicename[$devicename[0][0]][1] & @CRLF)
                        $sDeviceID = $devicename[$devicename[0][0]][1]; 硬件设备范例ID。
                        _SetupDiCreateDeviceDevs($sDeviceID, $hDevs, $tDevInfo)
                        If BitAND(GUICtrlRead($Checkbox3), $GUI_CHECKED) = $GUI_CHECKED  Then
                                $fResult = _SetupDiDisableDevice($hDevs, $tDevInfo, True) ; 从设备管理器停用摄像头
                                If $fResult = True Then
                                                $state = "1394 was Disabled"
                                        Else
                                                $state = "1394端口停用時發生錯誤，错误码：" & @error 
                                EndIf
                                ;$fResult = _SetupDiDisableDevice($hDevs, $tDevInfo, False) ; 启用。
                        Else
                                $fResult = _SetupDiDisableDevice($hDevs, $tDevInfo, False) ; 启用。
                                If $fResult = True Then
                                                $state = "1394 was enabled"
                                Else
                                                $state = "1394端口啟用時發生錯誤，错误码：" & @error 
                                EndIf
                        EndIf
                                
                        ;_SetupDiDestroyDeviceInfoList($hDevs) ; 销毁设备信息集。
                        
        WEnd 
        
EndFunc


Func stopimage()
                ;$testdata = InputBox("你好","这是一个测试程序","请输入要测试对象名","")

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
                                $devicename[$devicename[0][0]][0] = $sDescr        ; 硬件描述信息
                                $devicename[$devicename[0][0]][1] = _SetupDiGetDeviceInstanceID($hDevs, $tDevInfo) ; 设备范例ID
                                ;MsgBox(0,"1",$devicename[$devicename[0][0]][1])
                                                ;FileWriteLine(@DesktopDir&"\1.log",$devicename[$devicename[0][0]][1] & @CRLF)
                                $sDeviceID = $devicename[$devicename[0][0]][1]; 硬件设备范例ID。
                

                                If BitAND(GUICtrlRead($Checkbox2), $GUI_CHECKED) = $GUI_CHECKED  Then
                                        
                                        $fResult = _SetupDiDisableDevice($hDevs, $tDevInfo, True) ; 从设备管理器停用摄像头
                                        If $fResult = True Then
                                                $state = $state& @CRLF &"Web Camera was Disabled"
                                        Else
                                                $state = $state& @CRLF &"攝像頭停用時發生錯誤，错误码：" & @error 
                                        EndIf
                                Else
                                        $fResult = _SetupDiDisableDevice($hDevs, $tDevInfo, False) ; 启用。
                                        If $fResult = True Then
                                                $state = $state& @CRLF &"Web Camera was enabled"
                                        Else
                                                $state = $state& @CRLF &"攝像頭啟用時發生錯誤，错误码：" & @error 
                                        EndIf
                                EndIf
                        
                                ;_SetupDiDestroyDeviceInfoList($hDevs) ; 销毁设备信息集。
                                
                        
                ;註冊表禁用攝像頭
                        Dim  $i = 0 ,$j = 0,$var,$var1,$var2,$var3
                        While 1  ;遍历services所有子键名
                                        $i+=1
                                        $var1 = RegEnumKey("HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services",$i);子键名
                                        If @error <> 0 then ExitLoop
                                        $j = 0 
                                        while 1;遍历某一子键所有子项
                                                $j+=1
                                                $var2 = RegEnumVal("HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\"&$var1&"\Enum",$j);子项名
                                                If @error <> 0 then ExitLoop
                                                $var3 = RegRead("HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\"&$var1&"\Enum",$var2) ;子项值
                                                If stringcompare($var3 , $sDeviceID)= 0  Then ;最关键一句，获取的设备范例ID号遍历比对
                                                        If BitAND(GUICtrlRead($Checkbox2), $GUI_CHECKED) = $GUI_CHECKED  Then
                                                                RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\"&$var1,"start","REG_DWORD",00000004)
                                                                ;MsgBox(0,"子键为第"&$i&"位,子键名为"&$var1&"，以下为其子项数据","第"&$j&"子项名为："&$var2&"，值为："&$var3)
                                                                ;consolewrite("子键为第"&$i&"位,子键名为"&$var1& "以下为其子项数据"&"第"&$j&"子项名为："&$var2&" & 值为："&$var3  & @crlf)
                                                        Else
                                                                RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\"&$var1,"start","REG_DWORD",00000003)
                                                        EndIf
                                                                
                                                EndIf        
                                                
                                        WEnd
                        
                        WEnd
                
                WEnd 
        
EndFunc                
                        

Func stopusbstor()
        
                ;禁用U盤，重啟后生效
                If BitAND(GUICtrlRead($Checkbox1), $GUI_CHECKED) = $GUI_CHECKED  Then
                        FileMove(@WindowsDir&"\inf\usbstor.inf",@WindowsDir)  ;电脑管控前没有使用过U盘，必须再执行这两句
                        FileMove(@WindowsDir&"\inf\usbstor.pnf",@WindowsDir)
                        RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBSTOR","start","REG_DWORD",00000004)
                        ;FileWriteLine(@TempDir &"\file2.txt", "管控狀態3：禁用USB存儲設備" & @CRLF)
                        $state = $state& @CRLF &"USB storage was Disabled"        
                Else;啟用U盤，重啟后生效
                        FileMove(@WindowsDir&"\usbstor.inf",@WindowsDir&"\inf")
                        FileMove(@WindowsDir&"\usbstor.pnf",@WindowsDir&"\inf")
                        RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBSTOR","start","REG_DWORD",00000003)
                        $state = $state& @CRLF &"USB storage was enabled"
                        ;FileWriteLine(@TempDir &"\file2.txt", "管控狀態4：允許使用USB存儲設備" & @CRLF)
                                
                EndIf 

EndFunc

Func stopsff()
                ;禁用SFF Storage Class Driver（SD/MMC Card）
                If BitAND(GUICtrlRead($Checkbox4), $GUI_CHECKED) = $GUI_CHECKED  Then 
                        If RegRead("HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\sffdisk","DisplayName") = "" Then
                                FileMove(@WindowsDir&"\inf\sffdisk.inf",@WindowsDir)  ;电脑管控前没有使用过SFF卡，必须再执行这两句
                                FileMove(@WindowsDir&"\inf\sffdisk.PNF",@WindowsDir)
                        Else
                                FileMove(@WindowsDir&"\inf\sffdisk.inf",@WindowsDir)  
                                FileMove(@WindowsDir&"\inf\sffdisk.PNF",@WindowsDir)
                                RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\sffdisk","start","REG_DWORD",00000004)
                        EndIf
                        $state = $state& @CRLF &"SD/MMC Card was Disabled"        
                Else;啟用SFF Storage Class Driver（SD/MMC Card）
                        FileMove(@WindowsDir&"\sffdisk.inf",@WindowsDir&"\inf")
                        FileMove(@WindowsDir&"\sffdisk.PNF",@WindowsDir&"\inf")
                        RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\sffdisk","start","REG_DWORD",00000003)
                        $state = $state& @CRLF &"SD/MMC Card was enabled"
                                
                EndIf         

EndFunc