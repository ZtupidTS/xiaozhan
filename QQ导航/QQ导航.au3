
#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=qq.ico
#AutoIt3Wrapper_outfile=壹生QQ工具集.exe
#AutoIt3Wrapper_Res_Comment=完美壹生QQ工具集
#AutoIt3Wrapper_Res_Description=此程序仅为技术交流,严禁反编!
#AutoIt3Wrapper_Res_Fileversion=1.0.0.1
#AutoIt3Wrapper_Res_LegalCopyright=完美壹生
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
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
$Form1 =GUICreate("完美壹生QQ小工具集", 371, 213)
DllCall("user32.dll", "int", "AnimateWindow", "hwnd",$Form1, "int", 1000, "long",0x00040010) 
Dim $Dll
FileInstall("SkinCrafterDll.dll", @TempDir& "\SkinCrafterDll.dll",1)  ;此段为解压临时目录
FileInstall("Tranquill.skf", @TempDir& "\Tranquill.skf",1);此段为解压临时目录
$Dll = DllOpen(@TempDir& "\SkinCrafterDll.dll");此段为加载DLL文件
DllCall($Dll, "int:cdecl", "InitLicenKeys", "wstr", "1", "wstr", "", "wstr", "1@1.com", "wstr", "1") ;包括以下三段均为皮肤参数
DllCall($Dll, "int:cdecl", "InitDecoration", "int", 1) 
DllCall($Dll, "int:cdecl", "LoadSkinFromFile", "wstr", @TempDir& "\Tranquill.skf") ;此处需要写明皮肤文件名
DllCall($Dll, "int:cdecl", "DecorateAs", "int", $Form1, "int", 25) 
DllCall($Dll, "int:cdecl", "ApplySkin") ;此段以后为各类控件
$GUIActiveX = GUICtrlCreateObj($oIE, 0, 1, 140, 145)
$qqtx = GUICtrlCreateButton("QQ头像",  8, 190, 60, 25)
$qqkj = GUICtrlCreateButton("QQ空间头像", 82, 190, 62, 25)
$qqx = GUICtrlCreateButton("QQ秀",156, 190, 60, 25)
$qqcw= GUICtrlCreateButton("QQ宠物", 230, 190, 60, 25)
$qqlt = GUICtrlCreateButton("强制聊天", 304, 190, 60, 25)
$QQNumber = GUICtrlCreateInput("296336789", 35, 152, 97, 21)
$Label1 = GUICtrlCreateLabel("QQ号:", 2, 157, 30, 17)
$QQ = GUICtrlCreateGroup("QQ休闲导航", 144, 0, 225, 93)
$Q = GUICtrlCreateButton("QQ空间", 216, 26, 57, 22)
$Button5 = GUICtrlCreateButton("QQ软件", 280, 26, 57, 22)
$Button7 = GUICtrlCreateButton("QQVideo", 152, 58, 57, 22)
$Button8 = GUICtrlCreateButton("QQ音乐", 216, 58, 57, 22)
$Button9 = GUICtrlCreateButton("QQ官网", 152, 26, 57, 22)
$Button11 = GUICtrlCreateButton("QQ播客", 280, 58, 57, 22)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("QQ网游官网", 144, 100, 225, 73)
$Button12 = GUICtrlCreateButton("穿越火线", 216, 116, 57, 22)
$Button13 = GUICtrlCreateButton("QQ炫舞", 280, 116, 57, 22)
$Button14 = GUICtrlCreateButton("寻仙官网", 152, 148, 57, 22)
$Button15 = GUICtrlCreateButton("QQ音速", 216, 148, 57, 22)
$Button18 = GUICtrlCreateButton("DNF官网", 152, 116, 57, 22)
$Button19 = GUICtrlCreateButton("QQ三国", 280, 148, 57, 22)
GUISetState()       ;Show GUI
_IENavigate ($oIE, "http://www.timedate.cn/worldclock/ti.asp")
$sText = _IEBodyReadText ($oIE)
Sleep(1000)
dim $deathdate="2022年01月29日",$now=$sText
$result = StringCompare($deathdate,$now,1)
If $result<0 Then
        MsgBox(16,"软件试用期已过！","请到www.wm0739.cn下载最新版本!",3)
        Exit
        EndIf 
        ;软件主体
        MsgBox(64,"温馨提示！","程序启动成功",3)
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
  SplashTextOn("QQ宠物资料---5秒后自动关闭---",$Txt,340,260,339,153,0,"Fixedsys",5)
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