#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=ico.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=gesgin dy www.hitmkc.cn
#AutoIt3Wrapper_Res_Description=����˵�
#AutoIt3Wrapper_Res_Fileversion=V1.0
#AutoIt3Wrapper_Res_LegalCopyright=http://www.hitmkc.cn
#EndRegion ;**** ���������� ACNWrapper_GUI ****
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
Opt("TrayMenuMode", 1) ;û��Ĭ�ϵģ���ͣ�ű����˳����˵�.
Opt("trayOnEventMode", 1) ;Ӧ�� OnEvent ������ϵͳ����.

$Command = IniReadSection("���Խű���ȫ.ini", "command")
$title=IniRead("���Խű���ȫ.ini","title","title","")
$shuzi=IniRead("���Խű���ȫ.ini","shuzi","shuzi","")
$xiaozi1=IniRead("���Խű���ȫ.ini","xiaozi1","xiaozi1","") ;���ǵ�һ�еĴ�С
$xiaozi2=IniRead("���Խű���ȫ.ini","xiaozi2","xiaozi2","");���ǵڶ��еĴ�С
$xiaozi3=IniRead("���Խű���ȫ.ini","xiaozi3","xiaozi3","");���ǵ����еĴ�С
$tupian=IniRead("���Խű���ȫ.ini","tupian","tupian","")

;INI�����÷���
;***********************************************
;[title]
;title=���Խű���ȫ
;[shuzi]
;shuzi=25
;[xiaozi1]
;xiaozi1=10  ���ǵ�һ�еĴ�С
;[xiaozi2]
;xiaozi1=20  ���ǵڶ��еĴ�С
;[xiaozi3]
;xiaozi1=30   ���ǵ����еĴ�С
;[tupian]
;tupian="D:\����ͶӰ���Խű�\ico\22.jpg"
;[command]
;iSpeak 6.5=N:\Program Files\Changetech\iSpeak6.5\iSpeak.exe
;***********************************************


$height2=$Command[0][0]*$shuzi

$Form1 = GUICreate($title, 620, $height2+20, 500, 125);,BitOR($WS_SYSMENU, $WS_CAPTION, $WS_POPUP, $WS_POPUPWINDOW, $WS_BORDER, $WS_CLIPSIBLINGS))


GUISetOnEvent( $GUI_EVENT_MINIMIZE, "suoxiao")

GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")


;*********************************************************************************************** 

 
;***********************************************************************************************  

TraySetOnEvent($TRAY_EVENT_PRIMARYDOUBLE,"xiaozhan") ;ע��������˫���¼�(ֻ���� TrayOnEventMode ����Ϊ 1 ʱ����ʹ��)
$Start = TrayCreateItem("����") ;������һ���˵���
TrayItemSetOnEvent(-1,"qiyong") ;ע���һ���˵���ģ������£��¼�  
;TrayItemSetOnEvent = ��ϵͳ���̷���һ�������¼���ִ��һ���û��Զ��庯��
TrayCreateItem("") ;����һ���հ׵Ĳ˵������б�ָܷ���� 
;TrayCreateItem = ��ϵͳ�������洴��һ���˵���Ŀ�ؼ�
$Quit = TrayCreateItem("�˳�") ;�����������˵���
TrayItemSetOnEvent(-1,"ExitScript") ;ע��ڶ����˵���ģ������£��¼�

TraySetClick(8)  ;���������ϵͳ����ͼ������ĵ��ģʽ - ������������Ż���ʾϵͳ���̵Ĳ˵�  8 = ��������Ҫ����(ͨ���Ҽ�) 
TraySetState()

;***********************************************************************************************  


For $I = 1 To $Command[0][0]
    Select
		case Not($I > $xiaozi1)  ;10  $xiaozi1=10 
			$Command[$I][0] = GUICtrlCreateButton($Command[$I][0], 16, 16+($I-1)*45, 129, 33)
		case $I >$xiaozi1 And Not($I > $xiaozi2)   ;����10��������20 $xiaozi2=20
			$Command[$I][0] = GUICtrlCreateButton($Command[$I][0], 168, 16+($I-11)*45, 129, 33)
		case  $I >$xiaozi2 And Not($I > $xiaozi3)  ;����20��������30  $xiaozi3=30
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

;if not��$I >10��Then
;else
 ;   if not ($I > 20) then
  ;  else
   ; endif
;endif 



;***********************************************************************************************

$Pic1 =GUICtrlCreatePic($tupian, -250, -250, 0, 0, BitOR($SS_NOTIFY,$WS_GROUP,$WS_CLIPSIBLINGS));��GUI�ϴ���һ��ͼƬ�ؼ�
GUICtrlSetResizing(-1, $GUI_DOCKAUTO) ;����ĳ���ؼ��Ĵ�С������ʽ
GUICtrlSetCursor (-1, 0)  ;�ض��ؼ�ָ��һ�����ָ��
GUISetState(@SW_SHOW)  ;�������ڵ�״̬

;***********************************************************************************************

While 1
        
    Sleep(1000)
        
WEnd
;***********************************************************************************************
Func Command()
        
    For $i = 1 To UBound($Command, 1) - 1
	
		if @GUI_CtrlId = $Command[$I][0] Then Run($Command[$I][1],StringLeft ( $Command[$I][1], StringInStr($Command[$I][1], "\",0,-1))) 

   Next

   DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 1000, "long", 0x00090000);����
   
 
  
EndFunc


;***********************************************************************************************
Func _Exit()
        
      DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 1000, "long", 0x00090000);����

        Exit
        
	EndFunc
	

	
Func xiaozhan()
   GUISetState(@SW_SHOW, $Form1)   ;�������ڵ�״̬
   GUISetState(@SW_RESTORE, $Form1)
 
EndFunc   ;==>����(˫�����)

Func suoxiao()
	GUISetState(@SW_HIDE,$Form1)
EndFunc

Func qiyong()
   GUISetState(@SW_SHOW, $Form1)    ;�������ڵ�״̬    
   GUISetState(@SW_RESTORE, $Form1)
  
EndFunc  ;==>����

Func ExitScript()
   Exit  ; $Quit
EndFunc ;==>�˳�
