
#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=qq.ico
#AutoIt3Wrapper_outfile=Ҽ��QQ���߼�.exe
#AutoIt3Wrapper_Res_Comment=����Ҽ��QQ���߼�
#AutoIt3Wrapper_Res_Description=�˳����Ϊ��������,�Ͻ�����!
#AutoIt3Wrapper_Res_Fileversion=1.0.0.1
#AutoIt3Wrapper_Res_LegalCopyright=����Ҽ��
#EndRegion ;**** ���������� ACNWrapper_GUI ****
; *******************************************************
; Example 1 - Trap COM errors so that 'Back' and 'Forward' 
;               outside of history bounds does not abort script 
;               (expect COM errors to be sent to the console)
; *******************************************************
;
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <StaticConstants.au3>
#include <GuiMenu.au3>
#include <IE.au3>
TraySetState (2 ) 
_IEErrorHandlerRegister ()
$oIE = _IECreateEmbedded ()
$Form1 =GUICreate("����Ҽ��QQС���߼�", 371, 213)
DllCall("user32.dll", "int", "AnimateWindow", "hwnd",$Form1, "int", 1000, "long",0x00040010) 
Dim $Dll
FileInstall("SkinCrafterDll.dll", @TempDir& "\SkinCrafterDll.dll",1)  ;�˶�Ϊ��ѹ��ʱĿ¼
FileInstall("Tranquill.skf", @TempDir& "\Tranquill.skf",1);�˶�Ϊ��ѹ��ʱĿ¼
$Dll = DllOpen(@TempDir& "\SkinCrafterDll.dll");�˶�Ϊ����DLL�ļ�
DllCall($Dll, "int:cdecl", "InitLicenKeys", "wstr", "1", "wstr", "", "wstr", "1@1.com", "wstr", "1") ;�����������ξ�ΪƤ������
DllCall($Dll, "int:cdecl", "InitDecoration", "int", 1) 
DllCall($Dll, "int:cdecl", "LoadSkinFromFile", "wstr", @TempDir& "\Tranquill.skf") ;�˴���Ҫд��Ƥ���ļ���
DllCall($Dll, "int:cdecl", "DecorateAs", "int", $Form1, "int", 25) 
DllCall($Dll, "int:cdecl", "ApplySkin") ;�˶��Ժ�Ϊ����ؼ�
$GUIActiveX = GUICtrlCreateObj($oIE, 0, 1, 140, 145)
$qqtx = GUICtrlCreateButton("QQͷ��",  8, 190, 60, 25)
$qqkj = GUICtrlCreateButton("QQ�ռ�ͷ��", 82, 190, 62, 25)
$qqx = GUICtrlCreateButton("QQ��",156, 190, 60, 25)
$qqcw= GUICtrlCreateButton("QQ����", 230, 190, 60, 25)
$qqlt = GUICtrlCreateButton("ǿ������", 304, 190, 60, 25)
$QQNumber = GUICtrlCreateInput("296336789", 35, 152, 97, 21)
$Label1 = GUICtrlCreateLabel("QQ��:", 2, 157, 30, 17)
$QQ = GUICtrlCreateGroup("QQ���е���", 144, 0, 225, 93)
$Q = GUICtrlCreateButton("QQ�ռ�", 216, 26, 57, 22)
$Button5 = GUICtrlCreateButton("QQ���", 280, 26, 57, 22)
$Button7 = GUICtrlCreateButton("QQVideo", 152, 58, 57, 22)
$Button8 = GUICtrlCreateButton("QQ����", 216, 58, 57, 22)
$Button9 = GUICtrlCreateButton("QQ����", 152, 26, 57, 22)
$Button11 = GUICtrlCreateButton("QQ����", 280, 58, 57, 22)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("QQ���ι���", 144, 100, 225, 73)
$Button12 = GUICtrlCreateButton("��Խ����", 216, 116, 57, 22)
$Button13 = GUICtrlCreateButton("QQ����", 280, 116, 57, 22)
$Button14 = GUICtrlCreateButton("Ѱ�ɹ���", 152, 148, 57, 22)
$Button15 = GUICtrlCreateButton("QQ����", 216, 148, 57, 22)
$Button18 = GUICtrlCreateButton("DNF����", 152, 116, 57, 22)
$Button19 = GUICtrlCreateButton("QQ����", 280, 148, 57, 22)
GUISetState()       ;Show GUI
_IENavigate ($oIE, "http://www.timedate.cn/worldclock/ti.asp")
$sText = _IEBodyReadText ($oIE)
Sleep(1000)
dim $deathdate="2022��01��29��",$now=$sText
$result = StringCompare($deathdate,$now,1)
If $result<0 Then
        MsgBox(16,"����������ѹ���","�뵽www.wm0739.cn�������°汾!",3)
        Exit
        EndIf 
        ;�������
        MsgBox(64,"��ܰ��ʾ��","���������ɹ�",3)
_IENavigate ($oIE, "http://www.wm0739.cn/gonggao.html")
$gonggao = _IEBodyReadText ($oIE)
Sleep(1000)
$Label22 = GUICtrlCreateLabel($gonggao,2, 175,350, 15)
_IENavigate ($oIE, "http://www.wm0739.cn/gx.htm")
While 1
    $msg = GUIGetMsg()
    Select
        Case $msg = $GUI_EVENT_CLOSE
            ExitLoop
   Exit
   Case $msg = $qqtx
            _IENavigate ($oIE, "http://face4.qun.qq.com/cgi/svr/face/getface?type=1&me=3691174&uin="& GUICtrlRead($QQNumber) &"")
        Case $msg =$qqlt
           $rul= GUICtrlRead($QQNumber) 
           ConsoleWrite($rul) 
          $bxwl="http://wpa.qq.com/msgrd?V=1&Uin=" & $rul &"site=ioshenmue&Menu=yes" 
          run(@ProgramFilesDir & "\Internet Explorer\IEXPLORE.EXE -new " &  $bxwl) 
        Case $msg = $qqx
            _IENavigate ($oIE, "http://qqshow-user.tencent.com/"& GUICtrlRead($QQNumber) &"/10/00")
   Case $msg = $qqcw
         _IENavigate ($oIE, "http://im.qq.com/client/info/qq_pet_info.html?clientuin=296336789&clientkey=827ABD1AA7A7C281D9617D2DAF60516D5B497B68CA892EB266D61B0ED3F7F5F3&frienduin="& GUICtrlRead($QQNumber) &"&ADUIN=296336789&ADSESSION=1262598251&ADTAG=CLIENT.QQ.1881_FriendInfo.0")
   Sleep(1000)
   $Txt = _IEBodyReadText ($oIE)
  SplashTextOn("QQ��������---5����Զ��ر�---",$Txt,340,260,339,153,0,"Fixedsys",5)
     Sleep(5000)
  SplashOff ( )
        Case $msg = $qqkj
            _IENavigate ($oIE, "http://qlogo2.store.qq.com/qzonelogo/"& GUICtrlRead($QQNumber) &"/1/1256226711/")
  Case $msg =$Button9
   _IECreate ("http://www.qq.com/", 1, 1, 0) 
  Case $msg =$Q
   _IECreate ("http://qzone.qq.com/", 1, 1, 0)  
  Case $msg =$Button5
   _IECreate ("http://pc.qq.com/", 1, 1, 0)  
  Case $msg =$Button7
   _IECreate ("http://video.qq.com/", 1, 1, 0) 
  Case $msg =$Button8
   _IECreate ("http://music.qq.com/", 1, 1, 0)   
  Case $msg =$Button11
   _IECreate ("http://music.qq.com/", 1, 1, 0)   
  Case $msg =$Button18
   _IECreate ("http://dnf.qq.com/?ADTAG=IED.InnerCop.qqcom.word01", 1, 1, 0)
  Case $msg =$Button12
   _IECreate ("http://cf.qq.com/?ADTAG=IED.InnerCop.qqcom.word01", 1, 1, 0) 
  Case $msg =$Button13
   _IECreate ("http://x5.qq.com/?ADTAG=IED.InnerCop.qqcom.word01", 1, 1, 0) 
  Case $msg =$Button14
   _IECreate ("http://xx.qq.com/?ADTAG=IED.InnerCop.QQcom.home01", 1, 1, 0) 
  Case $msg =$Button15
   _IECreate ("http://r2.qq.com/", 1, 1, 0) 
  Case $msg =$Button19
   _IECreate ("http://sg.qq.com/?ADTAG=IED.InnerCop.QQcom.home01", 1, 1, 0) 
    EndSelect
WEnd
GUIDelete()
Exit