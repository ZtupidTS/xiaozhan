#include <ButtonConstants.au3>
#include <GUIConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Include <GuiListView.au3>
#include <ListViewConstants.au3>
#include <GuiImageList.au3>
;#include <QQpswd.au3>
#include <File.au3>
#include <string.au3>
#include <Process.au3>



#Region ### START Koda GUI section ### Form=e:\autoit\qqlogin.kxf
$Form1 = GUICreate("Form1", 370, 442, 363, 124)
$Group1 = GUICtrlCreateGroup("请选择登陆的帐号", 8, 105, 256, 305)
$List1 = GUICtrlCreateListView(" QQ号码  |   昵称   |上次登陆时间",  20, 127, 233, 279,$LVS_EDITLABELS, $LVS_EX_GRIDLINES)
;GUICtrlCreateGroup("", -99, -99, 1, 1)
$Pic1 = GUICtrlCreatePic("C:\Documents and Settings\Administrator\桌面\logo.jpg", 0, 0, 370, 105, BitOR($SS_NOTIFY,$WS_GROUP,$WS_CLIPSIBLINGS))
$Button1 = GUICtrlCreateButton("启动选中", 280, 126, 73, 25)
$Button2 = GUICtrlCreateButton("启动所有", 280, 168, 73, 25)
$Button3 = GUICtrlCreateButton("添加帐号", 280, 208, 73, 25)
$Button4 = GUICtrlCreateButton("删除帐号", 280, 248, 73, 25)
$Button5 = GUICtrlCreateButton("程序设置", 280, 288, 73, 25)
$Button6 = GUICtrlCreateButton("帮助", 280, 327, 73, 25)
$Button7 = GUICtrlCreateButton("检测更新", 280, 368, 73, 25)
$IniFile = @ScriptDir&"\Config.ini"
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###



While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $Button3
			tianjia()
        Case $Button5 
			lujing()
	EndSwitch
WEnd

Func Tianjia()
        $AddWindow = GUICreate("添加QQ号码", 281, 178, 565, 516)
        GUICtrlCreateGroup("请输入QQ账号信息", 2, 8, 276, 125)
        GUICtrlCreateLabel("QQ号码:", 16, 33, 47, 16)
        GUICtrlCreateLabel("QQ密码:", 16, 59, 47, 16)
        GUICtrlCreateLabel("重复密码:", 16, 84, 55, 16)
        $UseNick = GUICtrlCreateCheckbox("使用自定义昵称:", 16, 110, 113, 17)
        $QQ = GUICtrlCreateInput("", 72, 30, 137, 21, $ES_NUMBER,$WS_EX_STATICEDGE)
        GUICtrlSetLimit(-1, 10)
        $Mima = GUICtrlCreateInput("", 72, 56, 193, 20, $ES_PASSWORD,$WS_EX_STATICEDGE)
        $Remima = GUICtrlCreateInput("", 72, 81, 193, 20, $ES_PASSWORD,$WS_EX_STATICEDGE)
        $NickName = GUICtrlCreateInput("", 128, 107, 137, 20)
        GUICtrlSetState(-1, $GUI_DISABLE)
        GUICtrlSetLimit(-1, 4)
        $Yinshen = GUICtrlCreateCheckbox("隐身", 224, 32, 41, 17)
        $Save = GUICtrlCreateButton("保存(&S)", 50, 145, 65, 25, 0)
        $Cancel = GUICtrlCreateButton("取消(&C)", 160, 145, 65, 25, 0)
        ControlFocus("添加QQ号码", "", "Edit1")
        GUISetState(@SW_SHOW)
        
    While 1
                Switch GUIGetMsg()
                        Case $GUI_EVENT_CLOSE
                                GUIDelete($AddWindow)
                                ExitLoop
                        Case $Cancel
                                GUIDelete($AddWindow)
                                ExitLoop
                        Case $UseNick
                                If GUICtrlRead($UseNick) = $GUI_CHECKED        Then
                                        GUICtrlSetState($NickName, $GUI_ENABLE)
                                Else
                                        GUICtrlSetState($NickName, $GUI_DISABLE)
                                EndIf
                        Case $Save
                                if GUICtrlRead($QQ)="" then
                           MsgBox(64, "提示", "请输入QQ号码!")
                                   ContinueLoop
                                EndIf
                                If GUICtrlRead($Mima) = GUICtrlRead($Remima) Then
                                                If GUICtrlRead($Yinshen) = $gui_checked Then
                                                        IniWrite($IniFile, "QQ列表", GUICtrlRead($QQ), "隐身")
                                                Else
                                                        IniWrite($IniFile, "QQ列表", GUICtrlRead($QQ), "在线")
                                                EndIf
                                                IniWrite($IniFile, GUICtrlRead($QQ), "密码", _Password(1, GUICtrlRead($Mima), '用户保存的QQ密码',5))
                                                if  GUICtrlRead($UseNick) = $gui_checked Then
                                                        IniWrite($IniFile,GUICtrlRead($QQ),"昵称",GUICtrlRead($NickName))
                                                EndIf
                                                ;_ShowQQ()
                                Else
                                                MsgBox(64, "注意", "两次输入的密码不一样，请重输！")
                                                ContinueLoop
                                EndIf
                                GUIDelete($AddWindow)
                                ExitLoop
                EndSwitch
                ;_ReduceMemory(@AutoItPID)
        WEnd
        GUICtrlSendMsg($List1, $LVM_DeleteALLITEMS, 0, 0)
        ;_ShowList()
EndFunc;<==添加号码窗口

Func lujing()
$Form1_2 = GUICreate("添加QQ号", 293, 240, 775, 235)
$Label5 = GUICtrlCreateLabel("QQ程序版本：", 21, 30, 80, 17)
$Radio1 = GUICtrlCreateRadio("QQ2008版", 48, 52, 113, 17)
$Radio2 = GUICtrlCreateRadio("QQ2009版", 48, 75, 113, 17)
$Label6 = GUICtrlCreateLabel("QQ程序路径：", 21, 108, 80, 17)
;$Input5 = GUICtrlCreateInput("", 24, 135, 153, 21)
$Input6 = GUICtrlCreateInput(IniRead($IniFile, "腾讯QQ", "安装路径", ""), 24, 135, 153, 21)
$Zidong = GUICtrlCreateButton("自动查找", 20, 175,65,25, 0)
$Shoudong = GUICtrlCreateButton("手动指定", 200, 175, 65, 25, 0)
$Button9 = GUICtrlCreateButton("浏览", 177, 135, 49, 22)
$Button10 = GUICtrlCreateButton("更新配置", 112, 175, 65, 25)
GUISetState(@SW_SHOW)

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
         GUIDelete($Form1_2)
         ExitLoop
		; Case $Button9
		; qq_browse() 
		 
       Case $Shoudong
		$Value = FileOpenDialog("请选择QQ所在的目录...", @ProgramFilesDir, "可执行文件(*.exe)")
			GUICtrlSetData($Input6, $Value)
            IniWrite($IniFile, "腾讯QQ", "安装路径", $Value)
         Case $Zidong
        $Value = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\TENCENT\QQ", "install")
         GUICtrlSetData($Input6, $Value &"QQ.exe")
           IniWrite($IniFile, "腾讯QQ", "安装路径", $Value &"QQ.exe")
	EndSwitch
WEnd

EndFunc
;Func qq_browse() ;浏览QQ。exe程序路径
;	GUICtrlSetData($Input5, FileOpenDialog("选择QQ程序文件", "C:\Program Files\", "可执行文件(*.EXE)", 1, "QQ.exe"))

;EndFunc 


Func _PassWord($jiami_lp, $jiami_txt,$jiami_pas,$jiami_lev)
    Local $tlev,$bhb,$jjxc =1,$Num
    Local $jh[100]
    If $jiami_txt='' Or $jiami_pas='' Or StringLen ($jiami_pas) > 100 _
        Or $jiami_lev > 9 Or Int($jiami_lev)<>$jiami_lev Or $jiami_lev < 0 Then Return -1    
    If $jiami_lp = 1 Then
        $sosu=StringLen ($jiami_pas)
        For $pa_s=1 To $sosu
            $jh[$pa_s]=Asc(StringMid($jiami_pas,$pa_s,1))
            $Num=$Num&$jh[$pa_s]
            If $jjxc > 3 Then $jjxc=1
            If $jjxc=1 Then
                $bhb=Int($bhb+$jh[$pa_s])
            ElseIf    $jjxc=2 Then
                $bhb=Int($bhb*$jh[$pa_s])
            ElseIf    $jjxc=3 Then
                $bhb=Int($bhb-$jh[$pa_s])
            EndIf        
            $jjxc +=1
        Next
        $Num=StringLeft($Num, $jiami_lev)&$bhb&StringRight($Num, $jiami_lev)
        $jiami_txt=StringTrimLeft(StringToBinary($jiami_txt,2),2)
        $y_si=$sosu
        $j_si=1
        Do    
            $vi=StringMid($jh[$j_si],1,1)+StringMid($jh[$y_si],StringLen ($jh[$y_si]),1)
            $tempa=StringMid($jiami_txt,1,$vi-1)
            $tempb=StringMid($jiami_txt,$vi)
            $jiami_txt=$tempa&$jh[$j_si]&$tempb
            $y_si -=1
            $j_si +=1
        Until $y_si <= 0 And $j_si >= $sosu
        $st=StringLen ($Num)
        $txtshi=StringLen ($jiami_txt)
        For $kl=1 To $st
            $rtemp=''
            For $vn=1 To $txtshi Step StringMid($Num,$kl,1)+30
                $rtemp = StringMid($jiami_txt,$vn,StringMid($Num,$kl,1)+30)&$rtemp
            Next    
            $jiami_txt=$rtemp
        Next    
        Return $jiami_txt
    ElseIf $jiami_lp = 0 Then
        $sosu=StringLen ($jiami_pas)
        For $pa_s=1 To $sosu
            $jh[$pa_s]=Asc(StringMid($jiami_pas,$pa_s,1))
            $Num=$Num&$jh[$pa_s]
            If $jjxc > 3 Then $jjxc=1
            If $jjxc=1 Then
                $bhb=Int($bhb+$jh[$pa_s])
            ElseIf    $jjxc=2 Then
                $bhb=Int($bhb*$jh[$pa_s])
            ElseIf    $jjxc=3 Then
                $bhb=Int($bhb-$jh[$pa_s])
            EndIf        
            $jjxc +=1            
        Next
        $Num=StringLeft($Num, $jiami_lev)&$bhb&StringRight($Num, $jiami_lev)
        $st=StringLen ($Num)
        Do     
            $txtshi=StringLen ($jiami_txt)
            $rtemp=''
            Do     
                $rtemp =$rtemp&StringRight ($jiami_txt, StringMid($Num,$st,1)+30)
                $jiami_txt=StringTrimRight ($jiami_txt, StringMid($Num,$st,1)+30)
                $txtshi -= StringMid($Num,$st,1)+30    
            Until $txtshi <= 0
            $jiami_txt=$rtemp
            $st -=1
        Until $st <= 0    
        $y_si=$sosu
        $j_si=1
        Do
            $vi=StringMid($jh[$y_si],1,1)+StringMid($jh[$j_si],StringLen ($jh[$j_si]),1)
            $tempa=StringMid($jiami_txt,1,$vi-1)
            $tempb=StringMid($jiami_txt,$vi+StringLen ($jh[$y_si]))
            $jiami_txt=$tempa&$tempb    
            $y_si -=1
            $j_si +=1            
        Until $y_si <= 0
        $jiami_txt='0x'&$jiami_txt
        $jiami_txt = BinaryToString($jiami_txt,2)
        Return $jiami_txt
    Else
        Return -1
    EndIf
EndFunc
