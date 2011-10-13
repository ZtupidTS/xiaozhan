#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_Icon=2.ico
#AutoIt3Wrapper_Res_Description=网吧资料管理工具
#AutoIt3Wrapper_Res_Fileversion=0.0.0.2
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=y
#AutoIt3Wrapper_Res_LegalCopyright=文起网络
#AutoIt3Wrapper_Res_Icon_Add=TLB.ico
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#include <ButtonConstants.au3>
#include <DateTimeConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include<Access.au3>   ;access的UDF
#include<array.au3>    ;数组的UDF
#include <Date.au3>   ;日期时间的UDF

;装载 mstsc.exe mstsccx.dll到编译后的程序
FileInstall("mstsc.exe", "mstsc.exe", 1)
FileInstall("mstscax.dll", "mstscax.dll", 1)
FileInstall("mstsc.exe", "TLB.ico", 1)
FileSetAttrib("mstsc.exe", "+H")
FileSetAttrib("mstscax.dll", "+H")


;软件使用密码
$passw = GUICreate("Form1", 220, 21, 400, 400, $WS_POPUP)
$passwin = GUICtrlCreateInput("输入密码", 0, 0, 170, 20, $ES_PASSWORD)
GUICtrlSetTip($passwin, "输入密码")
$passw_ok = GUICtrlCreateButton("ok", 170, 0, 20, 20, $GUI_DEFBUTTON)
$passw_esc = GUICtrlCreateButton("esc", 190, 0, 25, 20)
GUISetState(@SW_SHOW)

While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
                Case $passw_ok
                        $pwd = GUICtrlRead($passwin)
                        If $pwd <> "123" Then
                                MsgBox(0, "", "密码错误")
                                Exit
                        ElseIf $pwd = "123" Then
                                GUIDelete()
                                ExitLoop
                        EndIf
                Case $passw_esc
                        Exit
        EndSwitch
WEnd

Dim $zl[20], $wbmc, $wbdz, $sysj, $lxr1, $lxr2, $dh1, $dh2, $dh3, $qq, $fy, $fybz, $cncip, $telip, $net, $pub, $bz, $icafe, $pass, $quit, $edit, $mstscip, $xxi
Dim $exit, $Form1, $Form2, $mstsc, $xiang, $jia, $xiu, $shan, $A_name, $Combo1, $jl

$zl[2] = "网吧名称"
$zl[4] = "联系人1"
$zl[5] = "电话1"
$zl[6] = "电话2"
$zl[7] = "联系人2"
$zl[8] = "电话3"
$zl[9] = "QQ"
$zl[10] = "费用"
$zl[11] = "费用备注"
$zl[12] = "PUBWIN"
$zl[13] = "文化资料"
$zl[14] = "备注"
$zl[15] = "CNCIP:255.255.255.255\rMask:255.255.255.255\rGateway:255.255.255.255"
$zl[16] = "TELIP:255.255.255.255\rMask:255.255.255.255\rGateway:255.255.255.255"
$zl[17] = "网维大师ID"
$zl[18] = "密码"
$zl[19] = "网吧地址"
;;=======================================================================
;判断程序目录是否有 oo.mdb的数据库文件，没有则创建，并创建名为 oo的 表
;;======================================================================
$find = FileExists("oo.mdb")
If $find = 0 Then
        _accessCreateDB("oo.mdb")
        _accessCreateTable("oo.mdb", "oo", " id INTEGER | wbmc TEXT(255) | sysj DATETIME | lxr1 TEXT(255) | dh1 TEXT(255) | dh2 TEXT(255) | lxr2 TEXT(255) | dh3 TEXT(255) | qq TEXT(255) | fy TEXT(255) | fybz TEXT(255) | pub TEXT(255) | net TEXT(255) | bz TEXT(255) | cncip TEXT(255) | telip TEXT(255) | icafe TEXT(255) |pw TEXT(255) | dz TEXT(255)")
        ;             工作类型; TEXT(数值1-255)=文本, MEMO=备注, COUNTER=自动编号, INTEGER=数字,
        ;                       YESNO=是/否, DATETIME=日期时间, CURRENCY=货币，OLEOBJECT=OLE 对象
        ;             标头名称不能包含空格，但必须以一个空格作为分隔字段类型
        ;             要设置的文本字段中使用文本的最大字符数(<数值>) 其中 <数值> 最大是255个.
        ;===============================================================================
EndIf


;=============================
;;;以下为程序的外观
;=============================
;变量定义 $A_***为数据库内的变量，$***为程序外观变量
;$zl 单个网吧的所有资料的数组，$zl[0]？？$zl[1]编号，$zl[2]网吧名称,$zl[3]使用时间$zl[4]联系人1$zl[5]电话1$zl[6]电话2$z
;$zl[7]联系人2 $zl[8]电话3 $zl[9] QQ $zl[10] 费用 $zl[11] pub $zl[12]netbar $zl[13] 备注 $zl[14] 网通IP
;$zl[15]电信IP $zl[16]  icafe $zl[17] 远程密码
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("网吧资料管理", 401, 24, 235, 264, $WS_POPUP, $WS_EX_LAYERED)
GUISetBkColor(0xABCDEF) ;窗口颜色
GUICtrlSetImage($Form1, "TLB.ico")
_API_SetLayeredWindowAttributes($Form1, 0xABCDEF) ;_API_SetLayeredWindowAttributes($Form1, 0x010101)，透明窗口
$Label1 = GUICtrlCreateLabel("", 0, 0, 10, 25, -1, $GUI_WS_EX_PARENTDRAG);无文本的标签，用来移动窗口
GUICtrlSetTip(-1, "点击此处可拖动窗口。") ;和上句配合，移动窗口
$Combo1 = GUICtrlCreateCombo("网吧名称", 20, 0, 100, 20)
$nameall = _accessQueryLike("oo.mdb", "oo", "wbmc", "", 1) ;包含所有网吧信息的列表
$jl = _accessCountRecords("oo.mdb", "oo") ;查询表总共有多少条记录
;以下为查询数据库中的网吧名称并在GUICtrlCreateCombo中显示出来
Local $name_list ;查询数据库中的记录数
For $i = $jl To 1 Step -1
        $c = StringSplit($nameall[$i], Chr(28)) ;$c是一个数组!!？？？
        $name_list = $c[2] & "|" & $name_list
Next
GUICtrlSetData(-1, $name_list)
;以上为为查询数据库中的网吧名称并在GUICtrlCreateCombo中显示出来
GUICtrlSetFont(-1, 6, 400, 0, "MS Sans Serif")
$mstsc = GUICtrlCreateButton("远", 125, 0, 25, 20)
$xiang = GUICtrlCreateButton("详", 155, 0, 25, 20)
$xiu = GUICtrlCreateButton("修", 185, 0, 25, 20, 0)
$jia = GUICtrlCreateButton("加", 215, 0, 25, 20, 0)
$shan = GUICtrlCreateButton("删", 245, 0, 25, 20, 0)
$exit = GUICtrlCreateButton("退", 275, 0, 25, 20, 0)
GUISetState(@SW_SHOW)
#EndRegion ### START Koda GUI section ### Form=
;;以上为程序的外观


While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
                Case $exit
                        FileDelete("mstsc.exe")
                        FileDelete("mstscax.dll")
                        Exit
                Case $xiang
                        shou()
                        cha()
                        While 1
                                $nMsg = GUIGetMsg()
                                Switch $nMsg
                                        Case $quit
                                                GUIDelete($xxi) ;关闭网吧信息窗口
                                                ExitLoop ;跳出循环*******重要
                                        Case $edit
                                                GUIDelete($xxi) ;关闭网吧信息窗口
                                                ExitLoop ;跳出循环*******重要
                                EndSwitch
                        WEnd


                Case $jia
                        cha()
                        While 1
                                $nMsg = GUIGetMsg()
                                Switch $nMsg
                                        Case $quit
                                                GUIDelete($xxi)
                                                ExitLoop
                                        Case $edit
                                                fuzi()
                                                pw()
                                                _accessAddRecord("oo.mdb", "oo", $zl)
                                EndSwitch
                        WEnd
                Case $xiu
                        shou()
                        cha()
                        While 1
                                $nMsg = GUIGetMsg()
                                Switch $nMsg
                                        Case $quit
                                                GUIDelete($xxi)
                                                ExitLoop
                                        Case $edit
                                                shan()
                                                fuzi()
                                                pw()
                                                add()


                                EndSwitch
                        WEnd

                Case $shan
                        shou()
                        shan()
                        If @error = 0 Then
                                MsgBox(0, "", "删除  " & $zl[2] & " 成功")
                        EndIf
                Case $mstsc
                        shou()
                        mstsc()
        EndSwitch
WEnd

;;---------------------
;  窗口透明
;;---------------------
Func _API_SetLayeredWindowAttributes($hwnd, $i_transcolor, $Transparency = 255, $isColorRef = False)

        Local Const $AC_SRC_ALPHA = 1
        Local Const $ULW_ALPHA = 2
        Local Const $LWA_ALPHA = 0x2
        Local Const $LWA_COLORKEY = 0x1
        If Not $isColorRef Then
                $i_transcolor = Hex(String($i_transcolor), 6)
                $i_transcolor = Execute('0x00' & StringMid($i_transcolor, 5, 2) & StringMid($i_transcolor, 3, 2) & StringMid($i_transcolor, 1, 2))
        EndIf
        Local $Ret = DllCall("user32.dll", "int", "SetLayeredWindowAttributes", "hwnd", $hwnd, "long", $i_transcolor, "byte", $Transparency, "long", $LWA_COLORKEY + $LWA_ALPHA)
        Select
                Case @error
                        Return SetError(@error, 0, 0)
                Case $Ret[0] = 0
                        Return SetError(4, 0, 0)
                Case Else
                        Return 1
        EndSelect
EndFunc   ;==>_API_SetLayeredWindowAttributes

;;=============================
;     查询数据库中一个网吧的信息
;;=============================

Func shou() ;在数据库中搜索一个网吧信息，并赋值给数组$ZL[20]
        ;通过GUICtrlCreateCombo上选择的网吧名称来查询网吧信息
        $A_name = GUICtrlRead($Combo1) ;cuictrlread是读取 combo列表里说选择的文本
        $nameall = _accessQueryLike("oo.mdb", "oo", "wbmc", $A_name) ;包含所有网吧信息的列表，得到的nameall是一个二维数组
        If $nameall = 1 Or $nameall = 2 Then
                Return $Form1
        EndIf
        $jl = _accessCountRecords("oo.mdb", "oo") ;查询表总共有多少条记录
        $zl = StringSplit($nameall[1], Chr(28)) ;$nameall_x[0]，是空信息？？，$nameall[1]是想要得到的信息。其中$nameall_x[1]是一个包含19个数据的数组。
EndFunc   ;==>shou

Func cha()
        ;详细资料的界面
        $xxi = GUICreate("xxi", 438, 380, 346, 214, BitOR($WS_POPUP, $WS_CLIPSIBLINGS), 0)
        GUISetBkColor(0xE3E3E3)
        $wbmc = GUICtrlCreateInput($zl[2], 20, 20, 70, 21, $WS_BORDER, 0)
        GUICtrlSetColor(-1, 0x000000)
        $wbdz = GUICtrlCreateInput($zl[19], 110, 20, 180, 21, $WS_BORDER, 0)
        GUICtrlSetColor(-1, 0x000000)
        $dh1 = GUICtrlCreateInput($zl[5], 110, 50, 120, 21, $WS_BORDER, 0)
        GUICtrlSetColor(-1, 0x000000)
        $lxr1 = GUICtrlCreateInput($zl[4], 20, 50, 70, 21, $WS_BORDER, 0)
        GUICtrlSetColor(-1, 0x000000)
        $sysj = GUICtrlCreateDate($zl[3], 310, 20, 110, 20)
        $dh2 = GUICtrlCreateInput($zl[6], 250, 50, 120, 21, $WS_BORDER, 0)
        GUICtrlSetColor(-1, 0x000000)
        $lx2 = GUICtrlCreateInput($zl[7], 20, 80, 70, 21, $WS_BORDER, 0)
        GUICtrlSetColor(-1, 0x000000)
        $qq = GUICtrlCreateInput($zl[9], 250, 80, 120, 21, $WS_BORDER, 0)
        GUICtrlSetColor(-1, 0x000000)
        $dh3 = GUICtrlCreateInput($zl[8], 110, 80, 120, 21, $WS_BORDER, 0)
        GUICtrlSetColor(-1, 0x000000)
        $fy = GUICtrlCreateInput($zl[10], 20, 110, 70, 21, $WS_BORDER, 0)
        GUICtrlSetColor(-1, 0x000000)
        $fybz = GUICtrlCreateInput($zl[11], 110, 110, 300, 21, $WS_BORDER, 0)
        GUICtrlSetColor(-1, 0x000000)
        $cncip = GUICtrlCreateEdit("", 20, 290, 90, 85, $WS_BORDER, 0)
        GUICtrlSetData($cncip, StringFormat($zl[15]))
        $telip = GUICtrlCreateEdit("", 110, 290, 90, 85, $WS_BORDER, 0)
        GUICtrlSetData($telip, StringFormat($zl[16]))
        $pub = GUICtrlCreateEdit("", 20, 140, 130, 140, BitOR($WS_GROUP, $WS_BORDER), 0)
        GUICtrlSetData($pub, StringFormat($zl[12]))
        $net = GUICtrlCreateEdit("", 160, 140, 130, 140, $WS_BORDER, 0)
        GUICtrlSetData($net, $zl[13])
        $quit = GUICtrlCreateButton("退出", 390, 300, 30, 45)
        $edit = GUICtrlCreateButton("保存", 350, 300, 30, 45, 0)
        $ok = GUICtrlCreateButton("确定", 310, 300, 30, 45)
        $bz = GUICtrlCreateEdit("", 300, 140, 130, 140, $WS_BORDER, 0)
        GUICtrlSetData($bz, $zl[14])
        $icafe = GUICtrlCreateEdit("", 200, 290, 90, 85, $WS_BORDER, 0)
        GUICtrlSetData($icafe, StringFormat($zl[17]))
        GUISetState(@SW_SHOW)
        #EndRegion ### END Koda GUI section ###

EndFunc   ;==>cha


Func shan()
        _accessDeleteRecord("oo.mdb", "oo", "wbmc ", $zl[2], 1)

EndFunc   ;==>shan



Func fuzi()


        ;$zl 单个网吧的所有资料的数组，$zl[0]？？$zl[1]编号，$zl[2]网吧名称,$zl[3]使用时间$zl[4]联系人1$zl[5]电话1$zl[6]电话2$z
        ;$zl[7]联系人2 $zl[8]电话3 $zl[9] QQ $zl[10] 费用 $zl[11] 费用备注 $zl[12]pubwin $zl[13] netbar $zl[14] 备注
        ;$zl[15]网通IP $zl[16]  电信IP $zl[17] ICAFE8 $zl[18] password $zl[19] 地址

        $zl[0] = 0
        $zl[1] = $jl + 1
        $zl[2] = GUICtrlRead($wbmc)
        $zl[3] = GUICtrlRead($sysj)
        $zl[4] = GUICtrlRead($lxr1)
        $zl[5] = GUICtrlRead($dh1)
        $zl[6] = GUICtrlRead($dh2)
        $zl[7] = GUICtrlRead($lxr2)
        $zl[8] = GUICtrlRead($dh3)
        $zl[9] = GUICtrlRead($qq)
        $zl[10] = GUICtrlRead($fy)
        $zl[11] = GUICtrlRead($fybz)
        $zl[12] = GUICtrlRead($pub)
        $zl[13] = GUICtrlRead($net)
        $zl[14] = GUICtrlRead($bz)
        $zl[15] = GUICtrlRead($cncip)
        $zl[16] = GUICtrlRead($telip)
        $zl[17] = GUICtrlRead($icafe)
        $zl[19] = GUICtrlRead($wbdz)
EndFunc   ;==>fuzi
Func pw()
        $Form2 = GUICreate("Form1", 220, 21, 400, 400, $WS_POPUP)
        $pw_gui_k = GUICtrlCreateInput("输入密码，OK保存，ESC取消", 0, 0, 170, 20)
        $pw_ok = GUICtrlCreateButton("ok", 170, 0, 20, 20)
        $pw_esc = GUICtrlCreateButton("esc", 190, 0, 25, 20)
        GUISetState(@SW_SHOW)
        While 1
                $nMsg = GUIGetMsg()
                Switch $nMsg
                        Case $pw_ok

                                $zl[18] = GUICtrlRead($pw_gui_k)
                                GUIDelete($Form2)
                                ExitLoop
                        Case $pw_esc
                                GUIDelete($Form2)
                                ExitLoop
                EndSwitch
        WEnd
EndFunc   ;==>pw

Func add()
        _accessAddRecord("oo.mdb", "oo", $zl)
        MsgBox(0, "", "信息已经保存")
EndFunc   ;==>add

;=======================
;从CNCIP信息里获取IP地址
;=======================
Func mstscip()

        $mstscip = StringStripCR($zl[15])
        $mstscip = StringStripWS($mstscip, 8)
        $t = StringInStr($mstscip, "\r", 2, 1) - 1
        $mstscip = StringLeft($mstscip, $t)
        $mstscip = StringTrimLeft($mstscip, 6)
EndFunc   ;==>mstscip

Func mstsc()
        Run("mstsc.exe")
        Sleep(500)
        Send("!o")
        Sleep(500)
        Send("{TAB}")
        Sleep(500)
        Send("{TAB}")
        Sleep(500)
        Send($mstscip)
        Sleep(500)
        Send("{TAB}")
        Send("administrator")
        Sleep(500)
        Send("{TAB}")
        Send($zl[18])
        Sleep(500)
        Send("{TAB}")
        Send("!n")

EndFunc   ;==>mstsc