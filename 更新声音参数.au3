#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=D:\���\�ļ�ͼ���滻����\ICO\NET\CHECK.ICO
#AutoIt3Wrapper_outfile=������������.exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
$bt= IniRead(@scriptdir & "\������������.ini", "gxsycs","bt","")
$ip= IniRead(@scriptdir & "\������������.ini", "gxsycs","ip","")
$lj= IniRead(@scriptdir & "\������������.ini", "gxsycs","lj", "")
$tftp= IniRead(@scriptdir & "\������������.ini", "gxsycs","tftp", "")
$fz= IniRead(@scriptdir & "\������������.ini", "gxsycs","fz", "")
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

MsgBox(0, "��Ҫ�ϵ�����", "��Ҫ�ϵ�����������ȷ������������" & @CRLF &  @CRLF & "�����Ϣ�򽫻���ʾ10��", 10)

#cs
[gxsycs]
bt=Serial-COM1 - SecureCRT
ip=ifconfig eth0 192.168.8.10
lj=cd /var
tftp=tftp -g  -r fm1182parameter_bigdoor_2010_04_19.dat 192.168.8.113
fz=cp fm1182parameter_bigdoor_2010_04_19.dat /etc/fm1182parameter.dat
#ce
