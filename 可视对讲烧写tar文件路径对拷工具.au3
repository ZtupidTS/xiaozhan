#NoTrayIcon
#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=..\..\..\12.ico
#AutoIt3Wrapper_outfile=���ӶԽ���дtar�ļ�·���Կ�����.exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

$I1 = IniRead(@scriptdir & "\The programming copy tar package.ini", "tar","Need to copy","")
$I2 = IniRead(@scriptdir & "\The programming copy tar package.ini", "tar","Target path","")

$b = True
If $b = True Then 
      FileInstall( "C:\12.ico", @scriptdir & "\12.ico" , 1 );@TempDir �鿴����%temp%
EndIf

#Region ### START Koda GUI section ### Form=
$Form1_1 = GUICreate("���ӶԽ���дtar�ļ�·���Կ�����", 446, 291, 369, 314)
$Group1 = GUICtrlCreateGroup("������Ҫ���Ƶ�tar·��", 16, 8, 417, 89)
$Input1 = GUICtrlCreateInput("", 24, 48, 401, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("��д�ļ�tar��·��", 16, 104, 417, 89)
$Input2 = GUICtrlCreateInput($I2, 24, 144, 401, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button1 = GUICtrlCreateButton("����·��", 48, 248, 97, 25)
$Button2 = GUICtrlCreateButton("ȡ��", 304, 248, 97, 25)
;$Button3 = GUICtrlCreateButton("��ʼ����", 176, 248, 97, 25)
$Label1 = GUICtrlCreateLabel("�����Ѿ��������ʹ�������ļ�", 104, 208, 228, 17)
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
Need to copy=Y:\ȫҕͨ\qst_room_7.0inch_mainboard_2010_06_13_10_20.tar
Target path=F:\ȫ��ͨ\packages

#ce