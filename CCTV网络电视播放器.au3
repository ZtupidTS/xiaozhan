#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=ico.ico
#AutoIt3Wrapper_outfile=�������.exe
#AutoIt3Wrapper_Compression=4
#EndRegion ;**** ���������� ACNWrapper_GUI ****
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
Opt('MustDeclareVars', 1)
Local $oIE,$Form1,$GUIActiveX,$M1,$M2,$M3,$M4,$M5,$M6,$M7,$M8,$M9,$M10,$nMsg,$M11,$exit,$M12,$M13,$M14,$Radio1 ,$Radio2,$qj,$blog,$szzd,$qxzd,$sz
Local $M20,$c6,$c5,$c8,$M21,$M22,$M23,$M24,$M25,$M26,$M27,$M28,$M29,$M210,$M211,$M212,$M213,$M214,$M215,$M216,$m217
Local $m30,$m311,$m312,$m313,$m314,$m315,$m316,$m317,$m318,$m319,$m320,$m321,$m322,$m323,$m324,$m325
Local $m40,$M411,$m412,$m413,$m414,$m415,$m416,$m417,$m418,$m419,$m420,$m421,$m422,$m423,$m424,$m425,$m426
$oIE = ObjCreate("Shell.Explorer.2")
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("CCTV������Ӳ�����", 622, 534,(@DesktopWidth - 640) / 2, (@DesktopHeight - 580) / 2, BitOR($WS_OVERLAPPEDWINDOW, $WS_CLIPSIBLINGS, $WS_CLIPCHILDREN))
$GUIActiveX = GUICtrlCreateObj ($oIE, 0, 0, 622, 534)
$M1 = GUICtrlCreateMenu("�ļ�����")
$blog=GUICtrlCreateMenuItem("ע������", $M1)
$qj=GUICtrlCreateMenuItem("���Ӳ��", $M1)
$exit=GUICtrlCreateMenuItem("�˳����", $M1)
;---------------���忪ʼ---------------------------
$M2 = GUICtrlCreateMenu("���ӱ���")
$M3 = GUICtrlCreateMenuItem("����CCTV-1", $M2)
$M4 = GUICtrlCreateMenuItem("����CCTV-2", $M2)
$M5 = GUICtrlCreateMenuItem("����CCTV-3", $M2)
$M6 = GUICtrlCreateMenuItem("����CCTV-4", $M2)
$c5 = GUICtrlCreateMenuItem("����CCTV-5", $M2)
$c6 = GUICtrlCreateMenuItem("����CCTV-6", $M2)
$M7 = GUICtrlCreateMenuItem("����CCTV-7", $M2)
$c8 = GUICtrlCreateMenuItem("����CCTV-8", $M2)
$M8 = GUICtrlCreateMenuItem("����CCTV-9", $M2)
$M9 = GUICtrlCreateMenuItem("����CCTV-10", $M2)
$M10 = GUICtrlCreateMenuItem("����CCTV-11", $M2)
$M11 = GUICtrlCreateMenuItem("����CCTV-12", $M2)
$M12 = GUICtrlCreateMenuItem("����CCTV����", $M2)
$M13 = GUICtrlCreateMenuItem("����CCTV����", $M2)
$M14 = GUICtrlCreateMenuItem("����CCTV�ٶ�", $M2)
;---------------�������---------------------------
;---------------���忪ʼ---------------------------
$M20 = GUICtrlCreateMenu("���Ӹ���")
$M21 = GUICtrlCreateMenuItem("����CCTV-1", $M20)
$M22 = GUICtrlCreateMenuItem("����CCTV-2", $M20)
$M23 = GUICtrlCreateMenuItem("����CCTV-3", $M20)
$M24 = GUICtrlCreateMenuItem("����CCTV-4", $M20)
$M25 = GUICtrlCreateMenuItem("����CCTV-5", $M20)
$M26 = GUICtrlCreateMenuItem("����CCTV-6", $M20)
$M27 = GUICtrlCreateMenuItem("����CCTV-7", $M20)
$M28 = GUICtrlCreateMenuItem("����CCTV-8", $M20)
$M29 = GUICtrlCreateMenuItem("����CCTV-9", $M20)
$M210 = GUICtrlCreateMenuItem("����CCTV-10", $M20)
$M211 = GUICtrlCreateMenuItem("����CCTV-12", $M20)
$M212 = GUICtrlCreateMenuItem("����CCTV-12", $M20)
$M213 = GUICtrlCreateMenuItem("����CCTV����", $M20)
$M214 = GUICtrlCreateMenuItem("����CCTV����", $M20)
$M215 = GUICtrlCreateMenuItem("���嶫������", $M20)
$M216 = GUICtrlCreateMenuItem("����CCTV�ٶ�", $M20)
$M217 = GUICtrlCreateMenuItem("CCTV����Ƶ��", $M20)
;---------------�������---------------------------
;---------------����Ƶ������---------------------------
$M30 = GUICtrlCreateMenu("Ƶ��-1")
$M311 = GUICtrlCreateMenuItem("��������", $M30)
$M312 = GUICtrlCreateMenuItem("��������", $M30)
$M313 = GUICtrlCreateMenuItem("��������", $M30)
$M314 = GUICtrlCreateMenuItem("��������", $M30)
$M315 = GUICtrlCreateMenuItem("��������", $M30)
$M316 = GUICtrlCreateMenuItem("�㶫����", $M30)
$M317 = GUICtrlCreateMenuItem("��������", $M30)
$M318 = GUICtrlCreateMenuItem("��������", $M30)
$M319 = GUICtrlCreateMenuItem("�ӱ�����", $M30)
$M320 = GUICtrlCreateMenuItem("��������", $M30)
$M321 = GUICtrlCreateMenuItem("����������", $M30)
$M322 = GUICtrlCreateMenuItem("��������", $M30)
$M323 = GUICtrlCreateMenuItem("��������", $M30)
$M324 = GUICtrlCreateMenuItem("��������", $M30)
$M325 = GUICtrlCreateMenuItem("��������", $M30)
;---------------����Ƶ������---------------------------
;---------------����Ƶ������---------------------------
$M40 = GUICtrlCreateMenu("Ƶ��-2")
$M411 = GUICtrlCreateMenuItem("��������", $M40)
$M412 = GUICtrlCreateMenuItem("��������", $M40)
$M413 = GUICtrlCreateMenuItem("��������", $M40)
$M414 = GUICtrlCreateMenuItem("���ɹ�����", $M40)
$M415 = GUICtrlCreateMenuItem("��������", $M40)
$M416 = GUICtrlCreateMenuItem("�ຣ����", $M40)
$M417 = GUICtrlCreateMenuItem("ɽ������", $M40)
$M418 = GUICtrlCreateMenuItem("ɽ������", $M40)
$M419 = GUICtrlCreateMenuItem("��������", $M40)
$M420 = GUICtrlCreateMenuItem("�Ĵ�����", $M40)
$M421 = GUICtrlCreateMenuItem("�������", $M40)
$M422 = GUICtrlCreateMenuItem("��������", $M40)
$M423 = GUICtrlCreateMenuItem("��������", $M40)
$M424 = GUICtrlCreateMenuItem("�½�����", $M40)
$M425 = GUICtrlCreateMenuItem("��������", $M40)
$M426 = GUICtrlCreateMenuItem("�㽭����", $M40)
;---------------����Ƶ������---------------------------
$sz = GUICtrlCreateMenu("��������")
$szzd = GUICtrlCreateMenuItem("�����ö�",$sz)
$qxzd = GUICtrlCreateMenuItem("ȡ���ö�",$sz)
$oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?")
GUISetState(@SW_SHOW)

#EndRegion ### END Koda GUI section ###

While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
                Case $GUI_EVENT_CLOSE
                        Exit
                Case $exit
                        exit
                Case $qj
                        $oIE.navigate("http://t.live.cctv.com/ieocx/CCTVRegOcx.exe")
                Case $blog
                        MsgBox(64,"ע��","�״�ʹ���밲װ���Ӳ���������޷����ţ�")
                Case $szzd
                        WinSetOnTop("CCTV������Ӳ�����", "", 1)
                Case $qxzd
                        WinSetOnTop("CCTV������Ӳ�����", "", 0)
        ;--------���忪ʼ-----------------------------------------------------------------------------------------------------------
        Case $M3
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_cctv1")
                Case $M4
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_cctv2")
                Case $M5
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_c3#toyota@cctv_3")
                Case $M6
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_cctv4#haier_kfc@cctv_4")
                Case $c5
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_ec_c5")
                Case $c6
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_cctv6")
                case $M7
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_cctv7")
                Case $c8
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_cctv8")
                case $M8
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_cctv9")
                Case $M9
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_cctv10")
                Case $M10
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_cctv11")
                case $M11
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_cctv12#haier_kfc@cctv_12")
                Case $M12
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_cctvnews#haier_kfc@cctv_new")
                Case $M13
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_cctvmusic#haier_kfc@cctv_song")
                Case $M14
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_cctvkids#haier_kfc@cctv_yang")
        ;--------�������-----------------------------------------------------------------------------------------------------------
        ;--------���忪ʼ-----------------------------------------------------------------------------------------------------------
                case $M21
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdcctv1")        
                case $M22
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdcctv2")        
                case $M23
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdcctv3")
                case $M24
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdcctv4")
                case $M25
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdcctv5")        
                case $M26
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdcctv6")                
                case $M27
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdcctv7")        
                case $M28
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdcctv8")        
                case $M29
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdcctv9")
                case $M210
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdcctv10")
                case $M211
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdcctv11")
                case $M212
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdcctv12")
                case $M213
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdcctvnews")
                case $M214
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdcctvmusic")                
                case $M215
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdshanghaikatong")
                case $M216
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdcctvkids")
                case $M217
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hd700_cctvgaoqing")
    ;--------�������-----------------------------------------------------------------------------------------------------------                        
        ;--------����-1��ʼ-----------------------------------------------------------------------------------------------------------                
                Case $m311
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdanhui")
            Case $m312
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdbeijing")
                Case $m313
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdchongqing")
                Case $m314
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hddongnan")
                Case $m315
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdgansu")  
                Case $m316
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdguangdong")
                Case $m317
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdguangxi")
                Case $m318
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdguizhou")
                Case $m319
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdhebei")
                Case $m320
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdhenan")
                Case $m321
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdheilongjiang")
                Case $m322
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdhubei")
                Case $m323
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdhunan")
                Case $m324
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdjilin")
                Case $m325
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdjiangsu")
        ;--------����-1����-----------------------------------------------------------------------------------------------------------        
            Case $m411
                $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdjiangxi")
                Case $m412
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdliaoning")
                Case $m413
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdlvyou")
                Case $m414
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdneimeng")
                Case $m415
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdningxia")
                Case $m416
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdqinghai")
                Case $m417
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdshandong")
                Case $m418
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdshan-xi")
                Case $m419
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdshanvxi")
                Case $m420
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdsichuan")
                Case $m421
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdtianjin")
                Case $m422
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdxizang2")
                Case $m423
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_xiamenweishi")
                Case $m424
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdxinjiang")
                Case $m425
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdyunnan")
                Case $m426
                        $oIE.navigate("http://t.live.cctv.com/cctvwebplay/cctvplayer.html?channel=cctv_p2p_hdzhejiang")
                
        EndSwitch
WEnd