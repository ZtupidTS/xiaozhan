#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=ico.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=gesgin dy www.hitmkc.cn
#AutoIt3Wrapper_Res_Description=软件菜单
#AutoIt3Wrapper_Res_Fileversion=V1.0
#AutoIt3Wrapper_Res_LegalCopyright=http://www.hitmkc.cn
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
HotKeySet("!1", "xiaozhan") 
HotKeySet("!2", "suoxiao") 
HotKeySet("!3", "ExitScript") 
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Constants.au3>
#include <array.au3>

Global $Form

Opt("GUIOnEventMode", 1)
Opt("TrayIconHide", 0)
Opt("TrayMenuMode", 1) ;没有默认的（暂停脚本和退出）菜单.
Opt("trayOnEventMode", 1) ;应用 OnEvent 函数于系统托盘.

$Command = IniReadSection("测试脚本大全.ini", "command")
$title=IniRead("测试脚本大全.ini","title","title","")
$shuzi=IniRead("测试脚本大全.ini","shuzi","shuzi","")
$xiaozi1=IniRead("测试脚本大全.ini","xiaozi1","xiaozi1","") ;这是第一列的大小
$xiaozi2=IniRead("测试脚本大全.ini","xiaozi2","xiaozi2","");这是第二列的大小
$xiaozi3=IniRead("测试脚本大全.ini","xiaozi3","xiaozi3","");这是第三列的大小
$tupian=IniRead("测试脚本大全.ini","tupian","tupian","")

;INI的设置方法
;***********************************************
;[title]
;title=测试脚本大全
;[shuzi]
;shuzi=25
;[xiaozi1]
;xiaozi1=10  这是第一列的大小
;[xiaozi2]
;xiaozi1=20  这是第二列的大小
;[xiaozi3]
;xiaozi1=30   这是第三列的大小
;[tupian]
;tupian="D:\无线投影测试脚本\ico\22.jpg"
;[command]
;iSpeak 6.5=N:\Program Files\Changetech\iSpeak6.5\iSpeak.exe
;***********************************************


$height2=$Command[0][0]*$shuzi

$Form1 = GUICreate($title, 620, $height2+20, 500, 125);,BitOR($WS_SYSMENU, $WS_CAPTION, $WS_POPUP, $WS_POPUPWINDOW, $WS_BORDER, $WS_CLIPSIBLINGS))


GUISetOnEvent( $GUI_EVENT_MINIMIZE, "suoxiao")

GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")


;*********************************************************************************************** 

 
;***********************************************************************************************  

TraySetOnEvent($TRAY_EVENT_PRIMARYDOUBLE,"xiaozhan") ;注册鼠标左键双击事件(只能在 TrayOnEventMode 设置为 1 时才能使用)
$Start = TrayCreateItem("启用") ;创建第一个菜单项
TrayItemSetOnEvent(-1,"qiyong") ;注册第一个菜单项的（被点下）事件  
;TrayItemSetOnEvent = 当系统托盘发生一个特殊事件就执行一个用户自定义函数
TrayCreateItem("") ;创建一个空白的菜单项（即横斜杠分割符） 
;TrayCreateItem = 在系统托盘上面创建一个菜单项目控件
$Quit = TrayCreateItem("退出") ;创建第三个菜单项
TrayItemSetOnEvent(-1,"ExitScript") ;注册第二个菜单项的（被点下）事件

TraySetClick(8)  ;设置鼠标在系统托盘图标里面的点击模式 - 怎样的鼠标点击才会显示系统托盘的菜单  8 = 按下鼠标次要按键(通常右键) 
TraySetState()

;***********************************************************************************************  


For $I = 1 To $Command[0][0]
    Select
		case Not($I > $xiaozi1)  ;10  $xiaozi1=10 
			$Command[$I][0] = GUICtrlCreateButton($Command[$I][0], 16, 16+($I-1)*45, 129, 33)
		case $I >$xiaozi1 And Not($I > $xiaozi2)   ;大于10但不大于20 $xiaozi2=20
			$Command[$I][0] = GUICtrlCreateButton($Command[$I][0], 168, 16+($I-11)*45, 129, 33)
		case  $I >$xiaozi2 And Not($I > $xiaozi3)  ;大于20但不大于30  $xiaozi3=30
			$Command[$I][0] = GUICtrlCreateButton($Command[$i][0], 320, 16+($i-21)*45, 129, 33)
		case  $I >$xiaozi3  ;$xiaozi3=30
	        $Command[$i][0] = GUICtrlCreateButton($Command[$i][0], 472, 16+($i-31)*45, 129, 33)
    EndSelect  
    GUICtrlSetOnEvent($Command[$I][0], "Command")
Next
	
DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 1000, "long", 0x00080000)

GUISetState()



;***********************************************************************************************


;For $I = 1 To $Command[0][0]
 ;   Switch $I
	;	case 1 to 10
	;		$Command[$I][0] = GUICtrlCreateButton($Command[$I][0], 16, 16+($I-1)*45, 129, 33)
	;	case 10 to 20
	;		$Command[$I][0] = GUICtrlCreateButton($Command[$I][0], 168, 16+($I-11)*45, 129, 33)
	;	case  20 to 30
	;		$Command[$I][0] = GUICtrlCreateButton($Command[$i][0], 320, 16+($i-21)*45, 129, 33)
	;	case  30
	 ;       $Command[$i][0] = GUICtrlCreateButton($Command[$i][0], 472, 16+($i-31)*45, 129, 33)
    ;EndSwitch 
    ;GUICtrlSetOnEvent($Command[$I][0], "Command")
;Next
	
;DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 1000, "long", 0x00080000)

;GUISetState()

;if not（$I >10）Then
;else
 ;   if not ($I > 20) then
  ;  else
   ; endif
;endif 



;***********************************************************************************************

$Pic1 =GUICtrlCreatePic($tupian, -250, -250, 0, 0, BitOR($SS_NOTIFY,$WS_GROUP,$WS_CLIPSIBLINGS));在GUI上创建一个图片控件
GUICtrlSetResizing(-1, $GUI_DOCKAUTO) ;设置某个控件的大小调整方式
GUICtrlSetCursor (-1, 0)  ;特定控件指定一个鼠标指针
GUISetState(@SW_SHOW)  ;调整窗口的状态

;***********************************************************************************************

While 1
        
    Sleep(1000)
        
WEnd
;***********************************************************************************************
Func Command()
        
    For $i = 1 To UBound($Command, 1) - 1
	
		if @GUI_CtrlId = $Command[$I][0] Then Run($Command[$I][1],StringLeft ( $Command[$I][1], StringInStr($Command[$I][1], "\",0,-1))) 

   Next

   DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 1000, "long", 0x00090000);渐隐
   
 
  
EndFunc


;***********************************************************************************************
Func _Exit()
        
      DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 1000, "long", 0x00090000);渐隐

        Exit
        
	EndFunc
	

	
Func xiaozhan()
   GUISetState(@SW_SHOW, $Form1)   ;调整窗口的状态
   GUISetState(@SW_RESTORE, $Form1)
 
EndFunc   ;==>启用(双击鼠标)

Func suoxiao()
	GUISetState(@SW_HIDE,$Form1)
EndFunc

Func qiyong()
   GUISetState(@SW_SHOW, $Form1)    ;调整窗口的状态    
   GUISetState(@SW_RESTORE, $Form1)
  
EndFunc  ;==>启用

Func ExitScript()
   Exit  ; $Quit
EndFunc ;==>退出
