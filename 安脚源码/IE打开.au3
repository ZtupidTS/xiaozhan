#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=..\工具\综合软件\3D风格ICO图标\IE.ico
#AutoIt3Wrapper_outfile=项目管理 IE.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#include <Process.au3>
#include <IE.au3>
$rc = _IECreate ("http://172.18.6.254/redmine/login")
Send("10111940")
Send("{TAB}")
Send("000000")
Send("{TAB}")
Send("{space}")
Send("{TAB}")
Send("{ENTER}")
If WinExists("自动完成密码") Then
    Send("{ENTER}")
EndIf

_IELoadWait ($rc)

