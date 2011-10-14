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

;==========================================================================================
; 说明:　修改MsgBox窗口样式，动态显示倒计时。
; 语法:　MsgBoxDJS(msgbox样式标志, '标题', '提示文本'[, 倒计时长(秒)[, 动态控件的标志[, 句柄]]])
; 参数:　msgbox样式标志、'标题'、'提示文本'、句柄 均同MsgBox函数，详情请参阅MsgBox()函数说明。
;　　　　倒计时时长(秒) - [可选]单位为秒，默认为10。
;　　　　动态控件的标志 - [可选] 0 = 动态"标题", 1 = 动态"提示文本"(默认), 2 = 动态"按钮"。
; 注意:　在标题或消息框动态显示的时间默认显示在字符串前面，如需调整可在需要的位置标记 %s 。
;　　　　(如需显示“%s”字符串本身请使用“%\s”)
; 返回值:返回按下按钮的ID(同MsgBox函数)。
; 作者:　Afan -- http://www.autoit.net.cn （本udf借用了 guland 的思路，THX ~）
;=====================================================================================start
Func MsgBoxDJS($flag, $title, $text, $timeout = 10, $Cflag = 1, $hwnd = '')
	Global $Timer = DllCallbackRegister('Timer', 'int', 'hwnd;uint;uint;dword')
	If $timeout = '' Or $timeout = -1 Then $timeout = 10
	Global $_title = $title, $_text = $text, $_Cflag = $Cflag, $_ibj = 1, $_ttc = $timeout, $bttxtbj = 0
	Global $TimerDLL = DllCall('user32.dll', 'uint', 'SetTimer', 'hwnd', 0, 'uint', 0, 'int', 100, 'ptr', DllCallbackGetPtr($Timer))
	Local $Mkmsg
	If $Cflag = 0 Then
		If StringRegExp($title, '%s') = 0 Then
			$title = '%s' & $title
			$_title = $title
		EndIf
		$title = StringRegExpReplace($title, '%s', StringFormat('%03s', $_ttc))
		$title = StringRegExpReplace($title, '%\\s', '%s')
	EndIf
	If $Cflag = 1 Then
		If StringRegExp($text, '%s') = 0 Then
			$text = '%s' & $text
			$_text = $text
		EndIf
		$text = StringRegExpReplace($text, '%s', StringFormat('%03s', $_ttc))
		$text = StringRegExpReplace($text, '%\\s', '%s')
	EndIf
	$Mkmsg = MsgBox($flag, $title, $text, 0, $hwnd)

	DllClose($TimerDLL)
	DllCallbackFree($Timer)
	Return $Mkmsg
EndFunc   ;==>MsgBoxDJS
Func Timer($hwnd, $uiMsg, $idEvent, $dwTime)
	Global $TimerDLL, $bttxtbj, $_Cflag, $_title, $_ttc, $_text, $_ibj, $Timer, $_titleF, $TimerJS
	If $idEvent = $TimerDLL[0] Then
		Global $bttxt, $CtrlF, $Static
		If $bttxtbj = 0 Then
			WinActivate($_title)
			If $_Cflag = 0 Then
				$_titleF = StringRegExpReplace($_title, '%s', StringFormat('%03s', $_ttc))
				$_titleF = StringRegExpReplace($_titleF, '%\\s', '%s')
				$CtrlF = ControlGetFocus($_titleF)
			EndIf
			If $_Cflag = 1 Or $_Cflag = 2 Then $CtrlF = ControlGetFocus($_title)
			$bttxt = ControlGetText($_title, $_text, $CtrlF)
			If $_Cflag = 1 Then
				$Static = 'Static1'
				ControlGetText($_title, StringRegExpReplace($_text, '%s', StringFormat('%03s', $_ttc)), 'Static1')
				If @error Then $Static = 'Static2'
			EndIf
			$bttxtbj = 1
		EndIf
		If $TimerJS = 9 Then
			If $_Cflag = 0 Then
				$_title1 = StringRegExpReplace($_title, '%s', StringFormat('%03s', $_ttc - $_ibj + 1))
				$_title1 = StringRegExpReplace($_title1, '%\\s', '%s')
				$_title2 = StringRegExpReplace($_title, '%s', StringFormat('%03s', $_ttc - $_ibj))
				$_title2 = StringRegExpReplace($_title2, '%\\s', '%s')
				WinSetTitle($_title1, $_text, $_title2)
			ElseIf $_Cflag = 1 Then
				$_text1 = StringRegExpReplace($_text, '%s', StringFormat('%03s', $_ttc - $_ibj + 1))
				$_text1 = StringRegExpReplace($_text1, '%\\s', '%s')
				$_text2 = StringRegExpReplace($_text, '%s', StringFormat('%03s', $_ttc - $_ibj))
				$_text2 = StringRegExpReplace($_text2, '%\\s', '%s')
				ControlSetText($_title, $_text1, $Static, $_text2)
			ElseIf $_Cflag = 2 Then
				ControlSetText($_title, $_text, $CtrlF, $bttxt & StringFormat(' %03s', $_ttc - $_ibj))
			EndIf
			If $_ibj = $_ttc Then
				If $_Cflag = 0 Then $_title = $_title2
				If $_Cflag = 1 Then $_text = $_text2
				DllClose($TimerDLL)
				DllCallbackFree($Timer)
				ControlClick($_title, $_text, $CtrlF, '', 2)
			EndIf
			$_ibj += 1
			$TimerJS = 0
		Else
			$TimerJS += 1
		EndIf
	EndIf
EndFunc   ;==>Timer
;=========================================================================================end