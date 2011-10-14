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
WinActivate("Remote Setup(14)")
$CH = ControlGetHandle ("Remote Setup(14)","","ComboBox25")
_GUICtrlComboBox_SetCurSel($CH,0)
sl()
$C = ControlGetHandle ("Remote Setup(14)","","ComboBox32")
_GUICtrlComboBox_SetCurSel($C,1)
ControlCommand ( "Netviewer","","ComboBox32", "SetCurrentSelection", "")
sl()
save()
Sleep(1000)
$CH = ControlGetHandle ("Remote Setup(14)","","ComboBox25")
_GUICtrlComboBox_SetCurSel($CH,1)
sl()
$C = ControlGetHandle ("Remote Setup(14)","","ComboBox32")
_GUICtrlComboBox_SetCurSel($C,1)
$A = ControlGetHandle ("Remote Setup(14)","","ComboBox31")
_GUICtrlComboBox_SetCurSel($A,0)
ControlClick("Remote Setup(14)","Save","Button3")
WinWait("Warnning:","OK")
ControlClick("Warnning:","OK","Button1")
Sleep(1000)
;
#cs
$CH = ControlGetHandle ("Remote Setup(14)","","ComboBox25")
_GUICtrlComboBox_SetCurSel($CH,0)
$P = ControlGetHandle ("Remote Setup(14)","","ComboBox26")
_GUICtrlComboBox_SetCurSel($P,1)
$B = ControlGetHandle ("Remote Setup(14)","","ComboBox30")
_GUICtrlComboBox_SetCurSel($B,1)
$D = ControlGetHandle ("Remote Setup(14)","","ComboBox27")
_GUICtrlComboBox_SetCurSel($D,3)
$S = ControlGetHandle ("Remote Setup(14)","","ComboBox28")
_GUICtrlComboBox_SetCurSel($S,1)
$P = ControlGetHandle ("Remote Setup(14)","","ComboBox29")
_GUICtrlComboBox_SetCurSel($P,3)
$C = ControlGetHandle ("Remote Setup(14)","","ComboBox32")
_GUICtrlComboBox_SetCurSel($C,1)
$A = ControlGetHandle ("Remote Setup(14)","","ComboBox31")
_GUICtrlComboBox_SetCurSel($A,254)

copy()
save()
#ce

Func copy()
	ControlClick("Remote Setup(14)","","Button95")
	sl()
	Send("{tab 3}")
	Send("{space}")
	sl()
	Send("{enter}")
EndFunc

Func save()
	ControlClick("Remote Setup(14)","Save","Button3")
	sl()
	$var = ControlGetText("Remote Setup(14)", "Save PTZ Succeed!", "Static1");获取指定控件上的文本.
	$I=StringCompare($var,"Save PTZ Succeed!");按选项比较两个字符串.
 If $I = 0 Then   ; 字符串1 包含 字符串2
	$msg = MsgBoxDJS(0 + 48 + 4, '程序已经保存成功', '请对板端，' & @CRLF & '是否继续？', 5, 2)
EndIf



EndFunc

Func sl()
	Sleep(500)
EndFunc	