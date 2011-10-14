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
WinActivate("Remote Setup(14)")
ControlClick("Remote Setup(14)","","Static129","left",1,25, 11)
sl()
ControlClick("Remote Setup(14)","","Static130","left",1,29, 10)
sl()
ControlClick("Remote Setup(14)","Copy","Button105")
sl()
Send("{tab 6}")
copy()
ControlClick("Remote Setup(14)","Copy","Button103")
sl()
Send("{tab 3}")
copy()
save()

Func sl()
	Sleep(500)
EndFunc	


Func copy()	
	sl()
	Send("{space}")
	sl()
	Send("{enter}")
EndFunc


Func save()
	ControlClick("Remote Setup(14)","Save","Button3")
	sl()
	$var = ControlGetText("Remote Setup(14)", "Save Schedule Succeed!", "Static1");获取指定控件上的文本.
	$I=StringCompare($var,"Save Schedule Succeed!");按选项比较两个字符串.
 If $I = 0 Then   ; 字符串1 包含 字符串2
	$msg = MsgBoxDJS(0 + 48 + 4, '程序已经保存成功', '请对板端，' & @CRLF & '是否继续？', 5, 2)
EndIf

EndFunc