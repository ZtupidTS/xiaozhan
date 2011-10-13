#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=D:\软件\文件图标替换工具\ICO\NET\CHECK.ICO
#AutoIt3Wrapper_outfile=更新声音参数.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
$bt= IniRead(@scriptdir & "\更新声音参数.ini", "gxsycs","bt","")
$ip= IniRead(@scriptdir & "\更新声音参数.ini", "gxsycs","ip","")
$lj= IniRead(@scriptdir & "\更新声音参数.ini", "gxsycs","lj", "")
$tftp= IniRead(@scriptdir & "\更新声音参数.ini", "gxsycs","tftp", "")
$fz= IniRead(@scriptdir & "\更新声音参数.ini", "gxsycs","fz", "")
WinActivate($bt)
Send($ip)
Send("{enter}")
Sleep(1500)
Send($lj)
Send("{enter}")
Sleep(1500)
Send($tftp)
Send("{enter}")
Sleep(1500)
Send($fz)
Send("{enter}")
Sleep(1000)

MsgBox(0, "需要断电重启", "需要断电重启才能正确更新声音参数" & @CRLF &  @CRLF & "这个消息框将会显示10秒", 10)

#cs
[gxsycs]
bt=Serial-COM1 - SecureCRT
ip=ifconfig eth0 192.168.8.10
lj=cd /var
tftp=tftp -g  -r fm1182parameter_bigdoor_2010_04_19.dat 192.168.8.113
fz=cp fm1182parameter_bigdoor_2010_04_19.dat /etc/fm1182parameter.dat
#ce
