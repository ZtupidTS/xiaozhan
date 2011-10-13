#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=qq.ico
#AutoIt3Wrapper_outfile=投影宝技术支持QQ.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
$QQkey="HKEY_LOCAL_MACHINE\SOFTWARE\TENCENT\QQ2009"
$QQpath=RegRead($QQkey,"Install")
Run($QQpath&"\bin\QQ.exe")
WinWait("QQ2010")
WinWaitActive("QQ2010")
$XY=wingetpos("QQ2010")
mouseclick("left",$XY[0]+215,$XY[1]+123) 
Send("1417718851",1)
mouseclick("left",$XY[0]+230,$XY[1]+154) 
Send("{BS 18}")
Send("zqf=ft-200w",1)
;mouseclick("left",$XY[0]+75,$XY[1]+190) 
;mouseclick("left",$XY[0]+112,$XY[1]+331) 
;mouseclick("left",$XY[0]+230,$XY[1]+154) 
Send("{enter}")