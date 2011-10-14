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
#Include <GuiListView.au3>
#include<MsgBoxDJS.au3>
#Include <GuiComboBox.au3>
Local $xiaozhan ,$xiaoxiao, $count ,$aList, $x 

WinActivate("Remote Setup(14)")

$xiaozhan = ControlGetHandle ( "Remote Setup(14)", "", "ListBox1")  ;获取指定控件的内部句柄.


$xiaoxiao = _GUICtrlListView_GetISearchString($xiaozhan) ;获取控件的增字搜索字符串
$count = _GUICtrlListView_GetItemCount($xiaozhan) ;获取列表视图控件的项目数
$aList = _GUICtrlListView_GetItemText($xiaozhan,0)  ;获取项目或子项目的文本
MsgBox(4160, "Information", "Item Count: ", $xiaoxiao)
MsgBox(4160, "Information", "Item Count: ", $count)
MsgBox(4160, "Information", "Item Count: ", $aList)
MsgBox(4160, "Information", "Item Count: " & _GUICtrlListView_GetItemCount($xiaozhan))

For $x = 0 To $count-1
	$aList = _GUICtrlListView_GetItemText($xiaozhan,$x) ;获取项目或子项目的文本
	if $aList = "user1" Then		
		_GUICtrlListView_ClickItem( $xiaozhan, $x ,"left","",1)  ;点击一个项目
		ConsoleWrite( $aList & @CRLF )  ;写入数据到 STDOUT 流.一些文本编辑器可以读取这个流作为其它程序可接受的数据.
	EndIf
Next