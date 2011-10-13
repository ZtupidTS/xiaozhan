#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=D:\软件\文件图标替换工具\ICO\卡通\14.ICO
#AutoIt3Wrapper_outfile=OEM修改器.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#include <GUIConstants.au3>
#include <EditConstants.au3>
#include <array.au3>
Global $SFile
IniWrite(@SystemDir & "\oeminfo.ini", "Support Information", "", "")
GUICreate("OEM修改器", 325 ,300)
GUICtrlCreateGroup("", 5, 1, 315, 295)
GUICtrlCreateLabel("注册到:", 170, 15)
$oemwink1 = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion", "RegisteredOwner")
$oemInput = GUICtrlCreateInput("", 170, 30, 145,16)
GUICtrlSetData($oemInput, ($oemwink1))
$oemwink2 = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion", "RegisteredOrganization")
$oemInput2 = GUICtrlCreateInput("", 170, 50, 145,16)
GUICtrlSetData($oemInput2, ($oemwink2))
$oemwink3 = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion", "ProductId")
$oemInput3 = GUICtrlCreateInput("", 170, 70, 145,16)
GUICtrlSetData($oemInput3, ($oemwink3))
$oemwink4 = IniRead(@SystemDir & "\OemInfo.ini", "General", "Manufacturer", "")
GUICtrlCreateLabel("支持信息:", 170, 92)
$oemInput4 = GUICtrlCreateInput("", 170, 115, 145,16)
GUICtrlSetData($oemInput4, ($oemwink4))
$oemwink5 = IniRead(@SystemDir & "\OemInfo.ini", "General", "Model", "")
$oemInput5 = GUICtrlCreateInput("", 170, 140, 145,16)
GUICtrlSetData($oemInput5, ($oemwink5))
$oemInput6 = GUICtrlCreateEdit("", 10, 160, 305, 103, $ES_WANTRETURN)
$wink6 = IniReadSection(@SystemDir & "\oeminfo.ini", "Support Information")
    For $i = 1 To $wink6[0][0] 
GUICtrlSetData($oemInput6, $wink6[$i][1]&@CRLF,"1")
    Next
$oempic = FileGetShortName(@SystemDir & "\OemLogo.bmp")
GUICtrlCreatePic($oempic, 15, 15, 145, 115)
$openoem = GUICtrlCreateButton("查看OEM", 10, 138, 70, 20)
$openpic = GUICtrlCreateButton("自定义图片", 85, 138, 80, 20)        
$oemButton1 = GUICtrlCreateButton("删除OEM信息",65, 265 ,80 ,25)
$oemButton2 = GUICtrlCreateButton("确  定",150, 265 ,80 ,25)
$oemButton3 = GUICtrlCreateButton("关  闭",235, 265 ,80 ,25)
  
GUISetState(@SW_SHOW)
While 1
        $nmsg = GUIGEtMsg()
        Select
                Case $nmsg = $GUI_EVENT_CLOSE
                        ExitLoop
                                        Case $nmsg = $openpic
$message = "打开你所选的*.bmp格式"
$SFile = FileOpenDialog($message, @DesktopCommonDir & "", "不大于118X115的位图文件(*.bmp)", 1)
  IF $SFile Then
        GUICtrlCreatePic($SFile, 15, 15, 145, 115)
Sleep(500)
        $ok2oempic = GUICtrlCreatePic($SFile, 15, 15, 145, 115)
EndIf

                Case $nmsg = $openoem
        Run("rundll32.exe shell32.dll,Control_RunDLL sysdm.cpl ")
        
                Case $nmsg = $oemButton1
        FileDelete(@SystemDir & "\OemInfo.ini")
        FileDelete(@SystemDir & "\OemLogo.bmp")
                MsgBox(64, "", "已经删除了OEM信息！")
While 1
$nMsg = GUIGetMsg()
Switch $nMsg
Case $GUI_EVENT_CLOSE
Exit

EndSwitch
WEnd
        Case $nmsg = $oemButton2
                $oemokInput = GUICtrlRead ($oemInput)
                RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion", "RegisteredOwner", "REG_SZ", $oemokInput)
                $oemokInput2 = GUICtrlRead ($oemInput2)
                RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion", "RegisteredOrganization", "REG_SZ", $oemokInput2)
                $oemokInput3 = GUICtrlRead ($oemInput3)
                RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion", "ProductId", "REG_SZ", $oemokInput3)
                $oemokInput4 = GUICtrlRead ($oemInput4)
                $sIni =  @SystemDir & "\oeminfo.ini"
                IniWrite(@SystemDir & "\OemInfo.ini", "General", "Manufacturer",$oemokInput4)
                $oemokInput5 = GUICtrlRead ($oemInput5)
                IniWrite(@SystemDir & "\OemInfo.ini", "General", "Model",$oemokInput5)
                                $oemokInput6 = GUICtrlRead ($oemInput6)
                                $t = StringSplit($oemokinput6, @LF)
For $i = 1 To UBound($t) - 1
$t[$i] = 'Line' & $i & '=' & $t[$i]
Next
                IniWriteSection(@SystemDir & "\OemInfo.ini", "Support Information", _ArrayToString($t, @LF, 1))
FileCopy($SFile, @SystemDir & "\OemLogo.bmp")
        MsgBox(64, "", "OEM设置完毕，请点击 查看OEM")
        
                Case $nmsg = $oemButton3
 
         Exit
EndSelect
        WEnd 
