#NoTrayIcon
FileInstall("E:\VidChng.exe",@SystemDir&"\VidChng.exe")
HotKeySet("!{F1}","v1")
HotKeySet("!{F2}","v2")
HotKeySet("!{F3}","v3")
HotKeySet("!{F4}","v4")
HotKeySet("!{F5}","v5")
HotKeySet("!{F6}","v6")
HotKeySet("!{F7}","v7")
HotKeySet("!{F8}","v8")
HotKeySet("!{F9}","v9")
HotKeySet("!{F10}","v10")
HotKeySet("!{F11}","v11")
HotKeySet("!{F12}","v12")
HotKeySet("{ESC}", "Terminate")

While 1
 sleep(1000)
 ToolTip("�밴Alt + F1~F12 ��������Ļ�ֱ���,��ESC���˳����ó���!"&@CR&"��ǰ�ֱ���Ϊ:"&@DesktopWidth&"*"&@DesktopHeight&" "&@DesktopDepth&"λɫ "&@DesktopRefresh&"����."&@CR&"Alt+F1 =640*480,16λɫ,60����      Alt+F2 =640*480,32λɫ,60����"&@CR&"Alt+F3 =640*480,32λɫ,85����      Alt+F4 =800*600,32λɫ,60����"&@CR&"Alt+F5 =800*600,16λɫ,85����      Alt+F6 =800*600,32λɫ,85����"&@CR&"Alt+F7 =1027*768,32λɫ,60����     Alt+F8 =1027*768,32λɫ,75����"&@CR&"Alt+F9 =1027*768,32λɫ,85����     Alt+F10=1280*1024,32λɫ,60����"&@CR&"Alt+F11=1280*1024,32λɫ,75����    Alt+F12=1280*1024,32λɫ,85����"&@CR&"                                          by LCMZX",200,200)

WEnd
Func v1()
 run("VidChng.exe 640x480x16@60 -q")
EndFunc
Func v2()
 run("VidChng.exe 640x480x32@60 -q")
EndFunc
Func v3()
 run("VidChng.exe 640x480x32@85 -q")
EndFunc
Func v4()
 run("VidChng.exe 800x600x32@60 -q")
EndFunc
Func v5()
 run("VidChng.exe 800x600x16@85 -q")
EndFunc
Func v6()
 run("VidChng.exe 800x600x32@85 -q")
EndFunc
Func v7()
 run("VidChng.exe 1024x768x32@60 -q")
EndFunc
Func v8()
 run("VidChng.exe 1024x768x32@75 -q")
EndFunc
Func v9()
 run("VidChng.exe 1024x768x32@85 -q")
EndFunc
Func v10()
 run("VidChng.exe 1280x1024x32@60 -q")
EndFunc
Func v11()
 run("VidChng.exe 1280x1024x32@75 -q")
EndFunc
Func v12()
 run("VidChng.exe 1280x1024x32@85 -q")
EndFunc

Func Terminate()
 FileDelete(@SystemDir&"\VidChng.exe")
 exit 0
EndFunc 

