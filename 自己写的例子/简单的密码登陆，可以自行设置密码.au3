#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <MD5.au3>
$mm = RegRead("HKLM\Software\set", "password")

If @error Then
        $mm1 = MD5("admin")
        $mm2 = RegWrite("HKLM\Software\set", "password", "reg_sz", $mm1)
        MsgBox(0, "提示", "默认密码admin")
        Exit
EndIf

GUISetIcon("D:\autoit3\Aut2Exe\Icons\tc.ico")
$EnterPassLabel = GUICtrlCreateLabel("请输入密码：", 8, 12, 76, 17)

Local $bq1, $tab0, $ButtonOk, $PasswordEdit, $ButtonCancel, $mm1, $mm2, $mm
Local $bq2, $gpsw, $msg, $jpsw, $npsw1, $npsw2, $mm1, $mm2, $mm
GUICreate("简单的密码修改", 400, 250) ; will create a dialog box that when displayed is centered
GUISetFont(9, 300)
$bq1 = GUICtrlCreateTab(10, 10, 300, 200)
GUICtrlSetState(-1, $GUI_SHOW)
$tab0 = GUICtrlCreateTabItem("登陆")
GUICtrlCreateLabel("密码", 35, 50, 90, 20)
$ButtonOk = GUICtrlCreateButton("确定(&O)", 30, 80, 75, 25)
GUICtrlSetState(-1, $GUI_DEFBUTTON)
$ButtonCancel = GUICtrlCreateButton("取消(&C)", 30, 140, 75, 25, 0)
$PasswordEdit = GUICtrlCreateInput("", 80, 50, 200, 20, 0x0020)
GUICtrlSetLimit(-1, 18)

$bq2 = GUICtrlCreateTabItem("修改密码")
GUICtrlCreateLabel("旧密码", 30, 80, 90, 20)
GUICtrlCreateLabel("新密码", 30, 120, 90, 20)
GUICtrlCreateLabel("确认新密码", 30, 160, 90, 20)
$gpsw = GUICtrlCreateButton("修改密码", 210, 170, 70, 30)
$jpsw = GUICtrlCreateInput("", 100, 80, 100, 20, 0x0020)
$npsw1 = GUICtrlCreateInput("", 100, 120, 100, 20, 0x0020)
$npsw2 = GUICtrlCreateInput("", 100, 160, 100, 20, 0x0020)
GUICtrlCreateTabItem("")
GUISetState()

While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
                Case $GUI_EVENT_CLOSE, $ButtonCancel
                        Exit
                Case $ButtonOk
                        $psw = GUICtrlRead($PasswordEdit)
                        If md5($psw) <> $mm Then
                                MsgBox(16, "密码错误", '请重新输入密码')
                                ControlSetText("", "", $PasswordEdit, "")
                        Else
                                ExitLoop
                        EndIf
                        
                Case $gpsw
                        
                        $yzpsw = GUICtrlRead($jpsw)
                        
                        If md5($yzpsw) <> $mm Then
                                MsgBox(16, "密码错误", '请重新输入密码')
                        EndIf
                        
                        If md5($yzpsw) = $mm Then
                                If GUICtrlRead($npsw1) <> GUICtrlRead($npsw2) Then
                                        MsgBox(0, 0, "两次密码不一致")
                                EndIf
                        EndIf
                        
                        If md5($yzpsw) = $mm Then
                                If GUICtrlRead($npsw1) = GUICtrlRead($npsw2) Then
                                        $xpsw = md5(GUICtrlRead($npsw1))
                                        RegWrite("HKLM\Software\set", "password", "reg_sz", $xpsw)
                                        MsgBox(0, 0, "密码修改成功,请重新登陆")
                                        Exit
                                EndIf
                        EndIf
        EndSwitch
WEnd
MsgBox(64, "通过", "验证通过")