#NoTrayIcon
#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=..\..\..\12.ico
#AutoIt3Wrapper_outfile=可视对讲烧写tar文件路径对拷工具.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

$I1 = IniRead(@scriptdir & "\The programming copy tar package.ini", "tar","Need to copy","")
$I2 = IniRead(@scriptdir & "\The programming copy tar package.ini", "tar","Target path","")

$b = True
If $b = True Then 
      FileInstall( "C:\12.ico", @scriptdir & "\12.ico" , 1 );@TempDir 查看方法%temp%
EndIf

#Region ### START Koda GUI section ### Form=
$Form1_1 = GUICreate("可视对讲烧写tar文件路径对拷工具", 446, 291, 369, 314)
$Group1 = GUICtrlCreateGroup("输入需要复制的tar路径", 16, 8, 417, 89)
$Input1 = GUICtrlCreateInput("", 24, 48, 401, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("烧写文件tar包路径", 16, 104, 417, 89)
$Input2 = GUICtrlCreateInput($I2, 24, 144, 401, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button1 = GUICtrlCreateButton("保存路径", 48, 248, 97, 25)
$Button2 = GUICtrlCreateButton("取消", 304, 248, 97, 25)
;$Button3 = GUICtrlCreateButton("开始复制", 176, 248, 97, 25)
$Label1 = GUICtrlCreateLabel("资料已经保存可以使用配置文件", 104, 208, 228, 17)
GUICtrlSetState(-1, $GUI_HIDE)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###


While 1
  $msg = GUIGetMsg()
  Select 
	Case $msg =  $GUI_EVENT_CLOSE
		ExitLoop
	Case $msg = $Button2
		FileDelete (@ScriptDir & "\12.ico" )
		Exit
	Case $msg = $Button1
		Save_Path()	
	;Case $msg = $Button3
	;	Start_Copy()	
	ExitLoop

   EndSelect
 WEnd
 

 Func Save_Path()
	 IniWrite(@scriptdir & "\The programming copy tar package.ini", "tar","Need to copy", GUICtrlRead($Input1))
	 FileCopy(GUICtrlRead($Input1),$I2 , 9) 
	 ;GUICtrlSetState($Label1, $gui_show)		
	 ;AdlibRegister("_scroll", 6000)
	 FileDelete (@ScriptDir & "\12.ico" )
 EndFunc
 
;Func Start_Copy()
;	 FileCopy($I1,$I2 , 9) 
;EndFunc

;Func _scroll()
;	GUICtrlSetState($Label1,$gui_hide)
;EndFunc

#cs
The programming copy tar package.ini
[tar]
Need to copy=Y:\全視通\qst_room_7.0inch_mainboard_2010_06_13_10_20.tar
Target path=F:\全视通\packages

#ce