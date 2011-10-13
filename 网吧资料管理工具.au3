#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_Icon=2.ico
#AutoIt3Wrapper_Res_Description=�������Ϲ�����
#AutoIt3Wrapper_Res_Fileversion=0.0.0.2
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=y
#AutoIt3Wrapper_Res_LegalCopyright=��������
#AutoIt3Wrapper_Res_Icon_Add=TLB.ico
#EndRegion ;**** ���������� ACNWrapper_GUI ****
#include <ButtonConstants.au3>
#include <DateTimeConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include<Access.au3>   ;access��UDF
#include<array.au3>    ;�����UDF
#include <Date.au3>   ;����ʱ���UDF

;װ�� mstsc.exe mstsccx.dll�������ĳ���
FileInstall("mstsc.exe", "mstsc.exe", 1)
FileInstall("mstscax.dll", "mstscax.dll", 1)
FileInstall("mstsc.exe", "TLB.ico", 1)
FileSetAttrib("mstsc.exe", "+H")
FileSetAttrib("mstscax.dll", "+H")


;���ʹ������
$passw = GUICreate("Form1", 220, 21, 400, 400, $WS_POPUP)
$passwin = GUICtrlCreateInput("��������", 0, 0, 170, 20, $ES_PASSWORD)
GUICtrlSetTip($passwin, "��������")
$passw_ok = GUICtrlCreateButton("ok", 170, 0, 20, 20, $GUI_DEFBUTTON)
$passw_esc = GUICtrlCreateButton("esc", 190, 0, 25, 20)
GUISetState(@SW_SHOW)

While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
                Case $passw_ok
                        $pwd = GUICtrlRead($passwin)
                        If $pwd <> "123" Then
                                MsgBox(0, "", "�������")
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

$zl[2] = "��������"
$zl[4] = "��ϵ��1"
$zl[5] = "�绰1"
$zl[6] = "�绰2"
$zl[7] = "��ϵ��2"
$zl[8] = "�绰3"
$zl[9] = "QQ"
$zl[10] = "����"
$zl[11] = "���ñ�ע"
$zl[12] = "PUBWIN"
$zl[13] = "�Ļ�����"
$zl[14] = "��ע"
$zl[15] = "CNCIP:255.255.255.255\rMask:255.255.255.255\rGateway:255.255.255.255"
$zl[16] = "TELIP:255.255.255.255\rMask:255.255.255.255\rGateway:255.255.255.255"
$zl[17] = "��ά��ʦID"
$zl[18] = "����"
$zl[19] = "���ɵ�ַ"
;;=======================================================================
;�жϳ���Ŀ¼�Ƿ��� oo.mdb�����ݿ��ļ���û���򴴽�����������Ϊ oo�� ��
;;======================================================================
$find = FileExists("oo.mdb")
If $find = 0 Then
        _accessCreateDB("oo.mdb")
        _accessCreateTable("oo.mdb", "oo", " id INTEGER | wbmc TEXT(255) | sysj DATETIME | lxr1 TEXT(255) | dh1 TEXT(255) | dh2 TEXT(255) | lxr2 TEXT(255) | dh3 TEXT(255) | qq TEXT(255) | fy TEXT(255) | fybz TEXT(255) | pub TEXT(255) | net TEXT(255) | bz TEXT(255) | cncip TEXT(255) | telip TEXT(255) | icafe TEXT(255) |pw TEXT(255) | dz TEXT(255)")
        ;             ��������; TEXT(��ֵ1-255)=�ı�, MEMO=��ע, COUNTER=�Զ����, INTEGER=����,
        ;                       YESNO=��/��, DATETIME=����ʱ��, CURRENCY=���ң�OLEOBJECT=OLE ����
        ;             ��ͷ���Ʋ��ܰ����ո񣬵�������һ���ո���Ϊ�ָ��ֶ�����
        ;             Ҫ���õ��ı��ֶ���ʹ���ı�������ַ���(<��ֵ>) ���� <��ֵ> �����255��.
        ;===============================================================================
EndIf


;=============================
;;;����Ϊ��������
;=============================
;�������� $A_***Ϊ���ݿ��ڵı�����$***Ϊ������۱���
;$zl �������ɵ��������ϵ����飬$zl[0]����$zl[1]��ţ�$zl[2]��������,$zl[3]ʹ��ʱ��$zl[4]��ϵ��1$zl[5]�绰1$zl[6]�绰2$z
;$zl[7]��ϵ��2 $zl[8]�绰3 $zl[9] QQ $zl[10] ���� $zl[11] pub $zl[12]netbar $zl[13] ��ע $zl[14] ��ͨIP
;$zl[15]����IP $zl[16]  icafe $zl[17] Զ������
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("�������Ϲ���", 401, 24, 235, 264, $WS_POPUP, $WS_EX_LAYERED)
GUISetBkColor(0xABCDEF) ;������ɫ
GUICtrlSetImage($Form1, "TLB.ico")
_API_SetLayeredWindowAttributes($Form1, 0xABCDEF) ;_API_SetLayeredWindowAttributes($Form1, 0x010101)��͸������
$Label1 = GUICtrlCreateLabel("", 0, 0, 10, 25, -1, $GUI_WS_EX_PARENTDRAG);���ı��ı�ǩ�������ƶ�����
GUICtrlSetTip(-1, "����˴����϶����ڡ�") ;���Ͼ���ϣ��ƶ�����
$Combo1 = GUICtrlCreateCombo("��������", 20, 0, 100, 20)
$nameall = _accessQueryLike("oo.mdb", "oo", "wbmc", "", 1) ;��������������Ϣ���б�
$jl = _accessCountRecords("oo.mdb", "oo") ;��ѯ���ܹ��ж�������¼
;����Ϊ��ѯ���ݿ��е��������Ʋ���GUICtrlCreateCombo����ʾ����
Local $name_list ;��ѯ���ݿ��еļ�¼��
For $i = $jl To 1 Step -1
        $c = StringSplit($nameall[$i], Chr(28)) ;$c��һ������!!������
        $name_list = $c[2] & "|" & $name_list
Next
GUICtrlSetData(-1, $name_list)
;����ΪΪ��ѯ���ݿ��е��������Ʋ���GUICtrlCreateCombo����ʾ����
GUICtrlSetFont(-1, 6, 400, 0, "MS Sans Serif")
$mstsc = GUICtrlCreateButton("Զ", 125, 0, 25, 20)
$xiang = GUICtrlCreateButton("��", 155, 0, 25, 20)
$xiu = GUICtrlCreateButton("��", 185, 0, 25, 20, 0)
$jia = GUICtrlCreateButton("��", 215, 0, 25, 20, 0)
$shan = GUICtrlCreateButton("ɾ", 245, 0, 25, 20, 0)
$exit = GUICtrlCreateButton("��", 275, 0, 25, 20, 0)
GUISetState(@SW_SHOW)
#EndRegion ### START Koda GUI section ### Form=
;;����Ϊ��������


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
                                                GUIDelete($xxi) ;�ر�������Ϣ����
                                                ExitLoop ;����ѭ��*******��Ҫ
                                        Case $edit
                                                GUIDelete($xxi) ;�ر�������Ϣ����
                                                ExitLoop ;����ѭ��*******��Ҫ
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
                                MsgBox(0, "", "ɾ��  " & $zl[2] & " �ɹ�")
                        EndIf
                Case $mstsc
                        shou()
                        mstsc()
        EndSwitch
WEnd

;;---------------------
;  ����͸��
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
;     ��ѯ���ݿ���һ�����ɵ���Ϣ
;;=============================

Func shou() ;�����ݿ�������һ��������Ϣ������ֵ������$ZL[20]
        ;ͨ��GUICtrlCreateCombo��ѡ���������������ѯ������Ϣ
        $A_name = GUICtrlRead($Combo1) ;cuictrlread�Ƕ�ȡ combo�б���˵ѡ����ı�
        $nameall = _accessQueryLike("oo.mdb", "oo", "wbmc", $A_name) ;��������������Ϣ���б��õ���nameall��һ����ά����
        If $nameall = 1 Or $nameall = 2 Then
                Return $Form1
        EndIf
        $jl = _accessCountRecords("oo.mdb", "oo") ;��ѯ���ܹ��ж�������¼
        $zl = StringSplit($nameall[1], Chr(28)) ;$nameall_x[0]���ǿ���Ϣ������$nameall[1]����Ҫ�õ�����Ϣ������$nameall_x[1]��һ������19�����ݵ����顣
EndFunc   ;==>shou

Func cha()
        ;��ϸ���ϵĽ���
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
        $quit = GUICtrlCreateButton("�˳�", 390, 300, 30, 45)
        $edit = GUICtrlCreateButton("����", 350, 300, 30, 45, 0)
        $ok = GUICtrlCreateButton("ȷ��", 310, 300, 30, 45)
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


        ;$zl �������ɵ��������ϵ����飬$zl[0]����$zl[1]��ţ�$zl[2]��������,$zl[3]ʹ��ʱ��$zl[4]��ϵ��1$zl[5]�绰1$zl[6]�绰2$z
        ;$zl[7]��ϵ��2 $zl[8]�绰3 $zl[9] QQ $zl[10] ���� $zl[11] ���ñ�ע $zl[12]pubwin $zl[13] netbar $zl[14] ��ע
        ;$zl[15]��ͨIP $zl[16]  ����IP $zl[17] ICAFE8 $zl[18] password $zl[19] ��ַ

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
        $pw_gui_k = GUICtrlCreateInput("�������룬OK���棬ESCȡ��", 0, 0, 170, 20)
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
        MsgBox(0, "", "��Ϣ�Ѿ�����")
EndFunc   ;==>add

;=======================
;��CNCIP��Ϣ���ȡIP��ַ
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