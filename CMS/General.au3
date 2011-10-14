#Region ACN预处理程序参数(常用参数)
#PRE_Icon= 										;图标,支持EXE,DLL,ICO
#PRE_OutFile=									;输出文件名
#PRE_OutFile_Type=exe							;文件类型
#PRE_Compression=4								;压缩等级
#PRE_UseUpx=y 									;使用压缩
#PRE_Res_Comment= 								;程序注释
#PRE_Res_Description=							;详细信息
#PRE_Res_Fileversion=							;文件版本
#PRE_Res_FileVersion_AutoIncrement=p			;自动更新版本
#PRE_Res_LegalCopyright= 						;版权
#PRE_Change2CUI=N                   			;修改输出的程序为CUI(控制台程序)
;#PRE_Res_Field=AutoIt Version|%AutoItVer%		;自定义资源段
;#PRE_Run_Tidy=                   				;脚本整理
;#PRE_Run_Obfuscator=      						;代码迷惑
;#PRE_Run_AU3Check= 							;语法检查
;#PRE_Run_Before= 								;运行前
;#PRE_Run_After=								;运行后
;#PRE_UseX64=n									;使用64位解释器
;#PRE_Compile_Both								;进行双平台编译
#EndRegion ACN预处理程序参数设置完成
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿

 Au3 版本: 
 脚本作者: 
 电子邮件: 
	QQ/TM: 
 脚本版本: 
 脚本功能: 

#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿

#include<MsgBoxDJS.au3>
#Include <GuiComboBox.au3>

WinActivate("Remote Setup(14)","")

;12
$D = ControlGetHandle ("Remote Setup(14)","","ComboBox50")
_GUICtrlComboBox_SetCurSel($D,1)
$TF = ControlGetHandle ("Remote Setup(14)","","ComboBox49")
_GUICtrlComboBox_SetCurSel($TF,1)
$M = ControlGetHandle ("Remote Setup(14)","","ComboBox61")
_GUICtrlComboBox_SetCurSel($M,5)
;夏令时
ControlClick("Remote Setup(14)","Daylight Saving Time","Button107")
$TO = ControlGetHandle ("Remote Setup(14)","","ComboBox52")
_GUICtrlComboBox_SetCurSel($TO,1)
sl()
;week ;单数为开始时间，双数为结束时间
$1 = ControlGetHandle ("Remote Setup(14)","","ComboBox53")
_GUICtrlComboBox_SetCurSel($1,0)
sl()
$2 = ControlGetHandle ("Remote Setup(14)","","ComboBox56")
_GUICtrlComboBox_SetCurSel($2,11)
sl()
$3 = ControlGetHandle ("Remote Setup(14)","","ComboBox54")
_GUICtrlComboBox_SetCurSel($3,2)
sl()
$4 = ControlGetHandle ("Remote Setup(14)","","ComboBox57")
_GUICtrlComboBox_SetCurSel($4,3)
sl()
$5 = ControlGetHandle ("Remote Setup(14)","","ComboBox55")
_GUICtrlComboBox_SetCurSel($5,1)
sl()
$6 = ControlGetHandle ("Remote Setup(14)","","ComboBox58")
_GUICtrlComboBox_SetCurSel($6,6)
sl()

;开始时间
ControlClick("Remote Setup(14)","","SysDateTimePick327","left",2,12, 11)
Send("12")
sl()
Send("{right}")
sl()
Send("12")
sl()
Send("{right}")
sl()
Send("12")
sl()
;结束时间
ControlClick("Remote Setup(14)","","SysDateTimePick328","left",2,12, 11)
Send("22")
sl()
Send("{right}")
sl()
Send("22")
sl()
Send("{right}")
sl()
Send("22")
sl()
save()

;24
$D = ControlGetHandle ("Remote Setup(14)","","ComboBox50")
_GUICtrlComboBox_SetCurSel($D,2)
$T = ControlGetHandle ("Remote Setup(14)","","ComboBox49")
_GUICtrlComboBox_SetCurSel($T,0)



ControlClick("Remote Setup(14)","","ComboBox51","left",2)
Send("{down}")
;开始时间11
;年
sl()
ControlClick("Remote Setup(14)","","SysDateTimePick322","left",2,14, 13)
Send("2015")
sl()
Send("{right}")
sl()
Send("10")
sl()
Send("{right}")
sl()
Send("10")
sl()
;时间
ControlClick("Remote Setup(14)","","SysDateTimePick323","left",2,12, 12)
Send("12")
sl()
Send("{right}")
sl()
Send("12")
sl()
Send("{right}")
sl()
Send("12")
sl()

;结束时间
;年
ControlClick("Remote Setup(14)","","SysDateTimePick324","left",2,14, 11)
Send("2036")
sl()
Send("{right}")
sl()
Send("11")
sl()
Send("{right}")
sl()
Send("11")
sl()

;时间
ControlClick("Remote Setup(14)","","SysDateTimePick325","left",2,14, 12)
Send("22")
sl()
Send("{right}")
sl()
Send("22")
sl()
Send("{right}")
sl()
Send("22")
sl()
save()


$D = ControlGetHandle ("Remote Setup(14)","","ComboBox50")
_GUICtrlComboBox_SetCurSel($D,0)
ControlClick("Remote Setup(14)","Enable NTP","Button112")
$D = ControlGetHandle ("Remote Setup(14)","","ComboBox59")
_GUICtrlComboBox_SetCurSel($D,0)
save()





Func save()
	ControlClick("Remote Setup(14)","Save","Button3")
	sl()
	$var = ControlGetText("Remote Setup(14)", "Save General Succeed!", "Static1");获取指定控件上的文本.
	$I=StringCompare($var,"Save General Succeed!");按选项比较两个字符串.
 If $I = 0 Then   ; 字符串1 包含 字符串2
	$msg = MsgBoxDJS(0 + 48 + 4, '程序已经保存成功', '请对板端，' & @CRLF & '是否继续？', 5, 2)
 EndIf

EndFunc

Func sl()
	Sleep(500)
EndFunc	