#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=ico.ico
#AutoIt3Wrapper_outfile=网络电视.exe
#AutoIt3Wrapper_Compression=4
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
Opt('MustDeclareVars', 1)
Local $oIE,$Form1,$GUIActiveX,$M1,$M2,$M3,$M4,$M5,$M6,$M7,$M8,$M9,$M10,$nMsg,$M11,$exit,$M12,$M13,$M14,$Radio1 ,$Radio2,$qj,$blog,$szzd,$qxzd,$sz
Local $M20,$c6,$c5,$c8,$M21,$M22,$M23,$M24,$M25,$M26,$M27,$M28,$M29,$M210,$M211,$M212,$M213,$M214,$M215,$M216,$m217
Local $m30,$m311,$m312,$m313,$m314,$m315,$m316,$m317,$m318,$m319,$m320,$m321,$m322,$m323,$m324,$m325
Local $m40,$M411,$m412,$m413,$m414,$m415,$m416,$m417,$m418,$m419,$m420,$m421,$m422,$m423,$m424,$m425,$m426
$oIE = ObjCreate("Shell.Explorer.2")
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("CCTV网络电视播放器", 622, 534,(@DesktopWidth - 640) / 2, (@DesktopHeight - 580) / 2, BitOR($WS_OVERLAPPEDWINDOW, $WS_CLIPSIBLINGS, $WS_CLIPCHILDREN))
$GUIActiveX = GUICtrlCreateObj ($oIE, 0, 0, 622, 534)
$M1 = GUICtrlCreateMenu("文件操作")
$blog=GUICtrlCreateMenuItem("注意事项", $M1)
$qj=GUICtrlCreateMenuItem("央视插件", $M1)
$exit=GUICtrlCreateMenuItem("退出软件", $M1)
;---------------标清开始---------------------------
$M2 = GUICtrlCreateMenu("央视标清")
$M3 = GUICtrlCreateMenuItem("标清CCTV-1", $M2)
$M4 = GUICtrlCreateMenuItem("标清CCTV-2", $M2)
$M5 = GUICtrlCreateMenuItem("标清CCTV-3", $M2)
$M6 = GUICtrlCreateMenuItem("标清CCTV-4", $M2)
$c5 = GUICtrlCreateMenuItem("标清CCTV-5", $M2)
$c6 = GUICtrlCreateMenuItem("标清CCTV-6", $M2)
$M7 = GUICtrlCreateMenuItem("标清CCTV-7", $M2)
$c8 = GUICtrlCreateMenuItem("标清CCTV-8", $M2)
$M8 = GUICtrlCreateMenuItem("标清CCTV-9", $M2)
$M9 = GUICtrlCreateMenuItem("标清CCTV-10", $M2)
$M10 = GUICtrlCreateMenuItem("标清CCTV-11", $M2)
$M11 = GUICtrlCreateMenuItem("标清CCTV-12", $M2)
$M12 = GUICtrlCreateMenuItem("标清CCTV新闻", $M2)
$M13 = GUICtrlCreateMenuItem("标清CCTV音乐", $M2)
$M14 = GUICtrlCreateMenuItem("标清CCTV少儿", $M2)
;---------------标清结束---------------------------
;---------------高清开始---------------------------
$M20 = GUICtrlCreateMenu("央视高清")
$M21 = GUICtrlCreateMenuItem("高清CCTV-1", $M20)
$M22 = GUICtrlCreateMenuItem("高清CCTV-2", $M20)
$M23 = GUICtrlCreateMenuItem("高清CCTV-3", $M20)
$M24 = GUICtrlCreateMenuItem("高清CCTV-4", $M20)
$M25 = GUICtrlCreateMenuItem("高清CCTV-5", $M20)
$M26 = GUICtrlCreateMenuItem("高清CCTV-6", $M20)
$M27 = GUICtrlCreateMenuItem("高清CCTV-7", $M20)
$M28 = GUICtrlCreateMenuItem("高清CCTV-8", $M20)
$M29 = GUICtrlCreateMenuItem("高清CCTV-9", $M20)
$M210 = GUICtrlCreateMenuItem("高清CCTV-10", $M20)
$M211 = GUICtrlCreateMenuItem("高清CCTV-12", $M20)
$M212 = GUICtrlCreateMenuItem("高清CCTV-12", $M20)
$M213 = GUICtrlCreateMenuItem("高清CCTV新闻", $M20)
$M214 = GUICtrlCreateMenuItem("高清CCTV音乐", $M20)
$M215 = GUICtrlCreateMenuItem("高清东方卫视", $M20)
$M216 = GUICtrlCreateMenuItem("高清CCTV少儿", $M20)
$M217 = GUICtrlCreateMenuItem("CCTV高清频道", $M20)
;---------------高清结束---------------------------
;---------------其他频道高清---------------------------
$M30 = GUICtrlCreateMenu("频道-1")
$M311 = GUICtrlCreateMenuItem("安徽卫视", $M30)
$M312 = GUICtrlCreateMenuItem("北京卫视", $M30)
$M313 = GUICtrlCreateMenuItem("重庆卫视", $M30)
$M314 = GUICtrlCreateMenuItem("东南卫视", $M30)
$M315 = GUICtrlCreateMenuItem("甘肃卫视", $M30)
$M316 = GUICtrlCreateMenuItem("广东卫视", $M30)
$M317 = GUICtrlCreateMenuItem("广西卫视", $M30)
$M318 = GUICtrlCreateMenuItem("贵州卫视", $M30)
$M319 = GUICtrlCreateMenuItem("河北卫视", $M30)
$M320 = GUICtrlCreateMenuItem("河南卫视", $M30)
$M321 = GUICtrlCreateMenuItem("黑龙江卫视", $M30)
$M322 = GUICtrlCreateMenuItem("湖北卫视", $M30)
$M323 = GUICtrlCreateMenuItem("湖南卫视", $M30)
$M324 = GUICtrlCreateMenuItem("吉林卫视", $M30)
$M325 = GUICtrlCreateMenuItem("江苏卫视", $M30)
;---------------其他频道结束---------------------------
;---------------其他频道高清---------------------------
$M40 = GUICtrlCreateMenu("频道-2")
$M411 = GUICtrlCreateMenuItem("江西卫视", $M40)
$M412 = GUICtrlCreateMenuItem("辽宁卫视", $M40)
$M413 = GUICtrlCreateMenuItem("旅游卫视", $M40)
$M414 = GUICtrlCreateMenuItem("内蒙古卫视", $M40)
$M415 = GUICtrlCreateMenuItem("宁夏卫视", $M40)
$M416 = GUICtrlCreateMenuItem("青海卫视", $M40)
$M417 = GUICtrlCreateMenuItem("山东卫视", $M40)
$M418 = GUICtrlCreateMenuItem("山西卫视", $M40)
$M419 = GUICtrlCreateMenuItem("陕西卫视", $M40)
$M420 = GUICtrlCreateMenuItem("四川卫视", $M40)
$M421 = GUICtrlCreateMenuItem("天津卫视", $M40)
$M422 = GUICtrlCreateMenuItem("西藏卫视", $M40)
$M423 = GUICtrlCreateMenuItem("夏门卫视", $M40)
$M424 = GUICtrlCreateMenuItem("新疆卫视", $M40)
$M425 = GUICtrlCreateMenuItem("云南卫视", $M40)
$M426 = GUICtrlCreateMenuItem("浙江卫视", $M40)
;---------------其他频道结束---------------------------
$sz = GUICtrlCreateMenu("窗口设置")
$szzd = GUICtrlCreateMenuItem("设置置顶",$sz)
$qxzd = GUICtrlCreateMenuItem("取消置顶",$sz)
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
                        MsgBox(64,"注意","首次使用请安装央视插件，否则无法播放！")
                Case $szzd
                        WinSetOnTop("CCTV网络电视播放器", "", 1)
                Case $qxzd
                        WinSetOnTop("CCTV网络电视播放器", "", 0)
        ;--------标清开始-----------------------------------------------------------------------------------------------------------
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
        ;--------标清结束-----------------------------------------------------------------------------------------------------------
        ;--------高清开始-----------------------------------------------------------------------------------------------------------
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
    ;--------高清结束-----------------------------------------------------------------------------------------------------------                        
        ;--------其他-1开始-----------------------------------------------------------------------------------------------------------                
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
        ;--------其他-1结束-----------------------------------------------------------------------------------------------------------        
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