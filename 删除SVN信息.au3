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
#AutoIt3Wrapper_Run_Debug_Mode=y                ;调试输出模式
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

Dim $h=MsgBox(1, "请注意", "确定要删除SVN信息,是否在副本下运行本程序，不是点取消，请复制成副本，在运行")
    if  $h<>1  Then
    Exit 0
EndIf

DirRemove(@ScriptDir & "\.svn",1)
DirRemove(@ScriptDir & "\Aut2Exe\.svn",1)
DirRemove(@ScriptDir & "\Aut2Exe\Icons\.svn",1)
DirRemove(@ScriptDir & "\AutoItX\.svn",1)
DirRemove(@ScriptDir & "\AutoItX\StandardDLL\.svn",1)
DirRemove(@ScriptDir & "\AutoItX\StandardDLL\DevC\.svn",1)
DirRemove(@ScriptDir & "\AutoItX\StandardDLL\VC6\.svn",1)
DirRemove(@ScriptDir & "\AutoItX\StandardDLL\VC6\Example\.svn",1)
DirRemove(@ScriptDir & "\AutoItX\StandardDLL\VC6\Example\bin\.svn",1)
DirRemove(@ScriptDir & "\AutoItX\ActiveX\.svn",1)
DirRemove(@ScriptDir & "\AutoItX\ActiveX\VBScript\.svn",1)
DirRemove(@ScriptDir & "\Examples\.svn",1)
DirRemove(@ScriptDir & "\Examples\ACN_BlockInputEx\.svn",1)
DirRemove(@ScriptDir & "\Examples\ACN_MSXML\.svn",1)
DirRemove(@ScriptDir & "\Examples\COM\.svn",1)
DirRemove(@ScriptDir & "\Examples\GUI\.svn",1)
DirRemove(@ScriptDir & "\Examples\GUI\Advanced\.svn",1)
DirRemove(@ScriptDir & "\Examples\GUI\Advanced\Images\.svn",1)
DirRemove(@ScriptDir & "\Examples\Helpfile\.svn",1)
DirRemove(@ScriptDir & "\Examples\WinAPIEx\.svn",1)
DirRemove(@ScriptDir & "\Examples\WinAPIEx\Extras\.svn",1)
DirRemove(@ScriptDir & "\Examples\WinINet\.svn",1)
DirRemove(@ScriptDir & "\Extras\.svn",1)
DirRemove(@ScriptDir & "\Extras\Au3Record\.svn",1)
DirRemove(@ScriptDir & "\Extras\AutoUpdateIt\.svn",1)
DirRemove(@ScriptDir & "\Extras\File2script\.svn",1)
DirRemove(@ScriptDir & "\Extras\OLEview\.svn",1)
DirRemove(@ScriptDir & "\Extras\OtherEXE\.svn",1)
DirRemove(@ScriptDir & "\Extras\Otherfile\.svn",1)
DirRemove(@ScriptDir & "\Extras\PCRE\.svn",1)
DirRemove(@ScriptDir & "\Extras\Spy++\.svn",1)
DirRemove(@ScriptDir & "\Extras\SQLite\.svn",1)
DirRemove(@ScriptDir & "\Include\.svn",1)
DirRemove(@ScriptDir & "\SciTe\.svn",1)
DirRemove(@ScriptDir & "\SciTe\ACNLua\.svn",1)
DirRemove(@ScriptDir & "\SciTe\ACNWrapper\.svn",1)
DirRemove(@ScriptDir & "\SciTe\api\.svn",1)
DirRemove(@ScriptDir & "\SciTe\api\batch\.svn",1)
DirRemove(@ScriptDir & "\SciTe\cSnippet\.svn",1)
DirRemove(@ScriptDir & "\SciTe\cSnippet\includes\.svn",1)
DirRemove(@ScriptDir & "\SciTe\cSnippet\Snips\.svn",1)
DirRemove(@ScriptDir & "\SciTe\css\.svn",1)
DirRemove(@ScriptDir & "\SciTe\FuncPopUp\.svn",1)
DirRemove(@ScriptDir & "\SciTe\Koda\.svn",1)
DirRemove(@ScriptDir & "\SciTe\Koda\Extras\.svn",1)
DirRemove(@ScriptDir & "\SciTe\Koda\Extras\Control Templates\.svn",1)
DirRemove(@ScriptDir & "\SciTe\Koda\Extras\Default Names Fix\.svn",1)
DirRemove(@ScriptDir & "\SciTe\Koda\Extras\Import\.svn",1)
DirRemove(@ScriptDir & "\SciTe\Koda\Language\.svn",1)
DirRemove(@ScriptDir & "\SciTe\Koda\Templates\.svn",1)
DirRemove(@ScriptDir & "\SciTe\Koda\Templates\您自己的模板\.svn",1)
DirRemove(@ScriptDir & "\SciTe\Obfuscator\.svn",1)
DirRemove(@ScriptDir & "\SciTe\SciTEConfig\.svn",1)
DirRemove(@ScriptDir & "\SciTe\Tidy\.svn",1)
DirRemove(@ScriptDir & "\SciTe\UserHome\.svn",1)
DirRemove(@ScriptDir & "\SciTe\属性文件\.svn",1)
DirRemove(@ScriptDir & "\SciTe\属性文件2\.svn",1)
DirRemove(@ScriptDir & "\SciTe\属性文件2\LUA\.svn",1)
DirRemove(@ScriptDir & "\SciTe\属性文件2\OTHER\.svn",1)
DirRemove(@ScriptDir & "\SciTe\相关说明\.svn",1)
DirRemove(@ScriptDir & "\UserInclude\.svn",1)