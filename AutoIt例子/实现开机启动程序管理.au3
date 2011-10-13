#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
 
 AutoIt 版本: 33.2.12.0.1(第一版)
 脚本作者: 
    Email: 
    QQ/TM: 
 脚本版本: 
 脚本功能: 添加快捷方式到启动目录，实现开机启动程序。
 
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
 
#include <GUIConstants.au3>
#Include <Date.au3>
#include <ListboxConstants.au3>
#include <GUIListBox.au3>
#include <GuiConstantsEx.au3>
#Include <Array.au3>
#include <WindowsConstants.au3>
 
#Region     是否已运行
$g_szVersion = "开机启动程序管理 v1.0.0"
If WinExists($g_szVersion) Then
        WinActivate("开机启动程序管理")
 
        Exit ; 此脚本已经运行了
EndIf
AutoItWinSetTitle($g_szVersion)
#EndRegion
 
#Region    定义变量 
Opt('MustDeclareVars', 1)
Dim  $hwnd,$tabChoosePrograms ,$file,$search,$returnKey,   $tabversionInfo 
Dim  $msg ,$FindFullPath,$subStringProgramName
Dim  $Label1 , $Label2
Dim  $caption="提示信息", $captionNoFile="选择的文件出现错误，请重新选择！"
Global $fileArray[100],$j=0,$longString,$listID,$subExit,$inputPath,$buttonFind
; 定义的按钮变量
Dim  $buttonrefresh,$buttonDel,$readItem,$buttonAdd,$buttonDelAll,$buttonExit,$buttonSave,$buttonReset
#EndRegion 
 
#Region    绘制主界面
$hwnd = GUICreate("开机启动程序管理 v1.0.0  BY STEVEN ", 413, 318)
GUISetFont (9, 400)
GUICtrlCreateTab(5, 1, 400, 300)
$Label1 = GUICtrlCreateLabel("欢迎使用开机启动程序管理软件" & "  技术支持：[url]www.baidu.com[/url]", 8, 303)
#EndRegion
 
 
 
   #Region    绘制启动程序选项卡内容
   ;设置启动程序选项卡内容
   $tabChoosePrograms = GUICtrlCreateTabItem("设置启动程序") 
   GUICtrlCreateLabel("选择开机时的启动程序:", 10, 30,190,19)
   $inputPath = GUICtrlCreateInput("",10,50,250,19) 
   $buttonFind= GUICtrlCreateButton("浏览……", 260,50,50,19)
   ;GUICtrlSetBkColor($buttonFind, 0xff0000)
 
   GUICtrlCreateLabel("程序版本：v1.0.0", 120, 80, 120, 19)
   GUICtrlCreateLabel("制作日期：" & _Now(), 120, 100, 350, 19)
   GUICtrlCreateLabel("程序制作：ydpd ", 120, 120, 112, 19)
   GUICtrlCreateLabel("Email：     ", 120, 140, 350, 19)
   GUICtrlCreateLabel("QQ群：      ", 120, 160, 350, 19)
   $Label2 = GUICtrlCreateLabel("刚学习，请大家多指导", 120, 180, 153, 19)
   GUICtrlCreateGroup("直接选择创建启动程序",10, 200, 380, 90)
   GUICtrlCreateCheckbox("腾讯QQ",20, 220, 60, 24)
   GUICtrlCreatePic(@ScriptDir & "\90.gif",80, 220, 24, 24)      ;90.gif
   GUICtrlCreateCheckbox("飞信",20, 240, 60, 19)
   GUICtrlCreateCheckbox("网络连接",20, 260, 70, 19)
 
   #EndRegion 
 
 
#Region   绘制管理启动程序选项卡内容
 
;管理启动程序选项卡内容
$tabChoosePrograms = GUICtrlCreateTabItem("管理启动程序") 
GUICtrlCreateLabel("开机时的启动程序如下:",10, 25,190,19)
$listID = GUICtrlCreateList("",10,45,380,230,BitOR($LBS_STANDARD, $LBS_EXTENDEDSEL))
$buttonAdd = GUICtrlCreateButton("添加", 10,270,50,25)
$buttonDel = GUICtrlCreateButton("删除", 70,270,50,25)
$buttonDelAll = GUICtrlCreateButton("全部删除", 130,270,70,25)
$buttonSave = GUICtrlCreateButton("刷新", 220,270,50,25)
$buttonReset = GUICtrlCreateButton("恢复", 285,270,50,25)
$buttonExit = GUICtrlCreateButton("退出", 345,270,50,25)
_GUICtrlListBox_Dir($listID, @StartupDir & "\" & "*.*")
_GUICtrlListBox_SetSel($listID, 0)
 
#EndRegion
 
#Region    绘制版本信息选项卡内容
;版本信息选项卡内容
$tabversionInfo = GUICtrlCreateTabItem("实用小工具")
GUICtrlCreateLabel("程序版本：v1.0.0", 120, 176, 120, 19)
GUICtrlCreateLabel("制作日期：" & _Now(), 120, 200, 149, 19)
GUICtrlCreateLabel("程序制作：   ", 120, 224, 112, 19)
GUICtrlCreateLabel("Email：    ", 120, 248, 200, 10)
$Label2 = GUICtrlCreateLabel("制作：   ", 330, 303, 153, 17)
#EndRegion  
 
GUISetState(@SW_SHOW,$hwnd)
 
#Region    处理消息
While 1
$msg = GUIGetMsg()
 
 Select 
    Case $msg = $GUI_EVENT_CLOSE or $msg =$buttonExit
                                Exit
    Case $msg = $buttonFind
                                SetLnk()   ; 在@statrupdir创建LNK     
        Case $msg = $buttonReset
                 StartupReset()
          Case $msg = $buttonDelAll
                FileDelete(@StartupDir)  
                Listrefresh($listID)
                MsgBox(0,$caption,"删除全部启动程序成功！",1)   
        Case $msg = $buttonDel
                 $readItem =  GUICtrlRead($listID)         
                 ItemDel($readItem)
                       Listrefresh($listID)
        Case $msg = $buttonAdd   
                        SubMenu()                
 EndSelect
WEnd
#EndRegion
 
#Region    StartupReset()
Func   StartupReset()
Local $var 
$var = IniReadSection(@ScriptDir & "\StartUp.ini", "开机程序")
If @error Then 
    MsgBox(4096, $caption, "发生错误,可能目标文件并非标准的INI文件.",1)
Else
    For $i = 1 To $var[0][0]     
     FileCreateShortcut($var[$i][1],@StartupDir & "\" & $var[$i][0])
    Next
EndIf
Listrefresh($listID)
MsgBox(0,$caption,"开机启动程序恢复成功！",1)
EndFunc
#EndRegion
 
#Region  SaveToIni()
Func   SaveToIni($listID)
;判断配置文件是否存在
If FileExists(@ScriptDir & "\StartUp.ini")=0 Then  ;如果不存在
          CreateIni($listID)
Else
       CreateIni($listID)
EndIf
 
EndFunc
#EndRegion
 
#Region  创建ini文件
Func   CreateIni($listID)
Local  $iniFile,$listCount, $next=-1 ,$listItemData
 $iniFile = FileOpen(@ScriptDir & "\StartUp.ini", 10)
$listCount = _GUICtrlListBox_GetCount($listID)
For $next = 0 to $listCount-1 step 1 
 $listItemData =  _GUICtrlListBox_GetText($listID, $next)
IniWrite(@ScriptDir & "\StartUp.ini", "开机程序", $listItemData,   @StartupDir & "\" & $listItemData)
Next
EndFunc
#EndRegion
 
#Region            SubMenu()
Func  SubMenu()
Dim  $msg1,$addHwnd,$buttonFind1
        $addHwnd = GUICreate("选择开机时的启动程序:", 413, 318,@DesktopWidth/2-413,@DesktopHeight/2-318, -1, -1 )
        GUICtrlCreateLabel("选择开机时的启动程序:", 10, 30,190,19)
        $inputPath = GUICtrlCreateInput("",10,50,250,19) 
        $buttonFind1 = GUICtrlCreateButton("浏览……", 260,50,50,19)
 
 
GUICtrlCreateLabel("程序版本：v1.0.0", 120, 80, 120, 19)
GUICtrlCreateLabel("制作日期：" & _Now(), 120, 100, 350, 19)
GUICtrlCreateLabel("程序制作：steven ", 120, 120, 112, 19)
GUICtrlCreateLabel("Email：[email]ydpd@163.com[/email]", 120, 140, 350, 19)
$Label2 = GUICtrlCreateLabel("刚学习，请大家多指导", 120, 160, 153, 19)
$subExit= GUICtrlCreateButton("返回", 160,200,50,19)
GUISetState(@SW_SHOW,$addHwnd)
 
While 1
        $msg1 = GUIGetMsg()
        Select
                Case $msg1 = $buttonFind1
                                SetLnk()   ; 在@statrupdir创建LNK   
                Case  $msg1 = $subExit          
                                GUISetState(@SW_HIDE,$addHwnd)
                 ExitLoop
    EndSelect
WEnd      
GUIDelete($addHwnd)
EndFunc
#EndRegion
 
#Region   刷新列表
Func   Listrefresh($listID)
                        _GUICtrlListBox_BeginUpdate($listID)
                        _GUICtrlListBox_ResetContent($listID)
                        _GUICtrlListBox_Dir($listID, @StartupDir & "\" & "*.*")
                        _GUICtrlListBox_EndUpdate($listID)        
                         _GUICtrlListBox_SetSel($listID, 0)          
 
EndFunc
#EndRegion 
 
#Region   删除列表选中内容
 Func  ItemDel($readItem)
       Dim $flag=-1, $MsgBoxID=-1
        If _GUICtrlListBox_GetSelCount($readItem) >1 Then 
                        $MsgBoxID=MsgBox(1,$caption,"确定要删除全部记录吗？")
            If $MsgBoxID = 1 Then   ; 确定
                                $flag =  FileDelete(@StartupDir & "\" & $readItem)
                                If $flag = 1  Then
                                  MsgBox(0,$caption,"删除 " & $readItem & " 成功！",1)
                                Else 
                                        MsgBox(0,$caption,  " 已经删除！",1)
                                EndIf             
                        Else
                                Return
                        EndIf             
        Else   
                                $flag =  FileDelete(@StartupDir & "\" & $readItem)
                                If $flag = 1  Then
                                  MsgBox(0,$caption,"删除 " & $readItem & " 成功！",1)
                                Else 
                                        MsgBox(0,$caption,  " 已经删除！",1)
                                EndIf 
                EndIf
 EndFunc 
#EndRegion 
 
#Region    DisplayLnk()
Func DisplayLnk()
 GUICtrlSetLimit(-1, 200)    ; to limit horizontal scrolling
 
 For $j=0 to 100
    If $fileArray[$j] <> "" Then 
      GUICtrlSetData($listID,  $fileArray[$j])      
        Else 
      ExitLoop 
        EndIf 
 Next
EndFunc 
 
#EndRegion
 
#Region    SearchStatrUP(); 显示statrupdir文件夹下的内容
Func  SearchStatrUP(); 显示statrupdir文件夹下的内容
$search = FileFindFirstFile(@StartupDir & "\" & "*.*")  
 
; Check if the search was successful
        If $search = -1 Then
        MsgBox(0, $caption, "没有文件",1)
        Exit
        EndIf
        Dim $i=0  ; 循环变量
        While 1
         $file = FileFindNextFile($search) 
                 If @error Then 
                ExitLoop
                 Else
 
              $fileArray[$i] = $file         
              $i=$i+1
 
                 EndIf
        WEnd
; Close the search handle
FileClose($search)
EndFunc
#EndRegion
 
#Region    SetLnk()
Func   SetLnk()
 $FindFullPath =  FileOpenDialog("选择要开机启动的程序路径：",  _ 
            @WorkingDir & "\", "全部文件 (*.*)|可执行文件 (*.exe)", 1 + 2 )        
          If @error Then
      MsgBox(4096,$caption,$captionNoFile,1)
          Else
        $subStringProgramName= GetSubString ($FindFullPath,"\");StringSplit($FindFullPath,"\")     
           $returnKey =  FileCreateShortcut($FindFullPath,@StartupDir & "\" & $subStringProgramName & ".lnk")
             if $returnKey = 1 Then              
                  MsgBox(0,$caption,"创建" & $FindFullPath & "的启动快捷方式成功！",1)
                                  GUICtrlSetData($listID,  $subStringProgramName & ".lnk")  
                                        FileOpen(@ScriptDir & "\StartUp.ini", 1)
                                IniWrite(@ScriptDir & "\StartUp.ini", "开机程序", $subStringProgramName & ".lnk",  $FindFullPath)          
             Else
                MsgBox(0,$caption,"无法创建" & $FindFullPath & "的启动快捷方式！",1)
                     EndIf
      EndIf        
EndFunc           
#EndRegion
 
#Region    GetSubString (  $FindFullPath,  $separation);分隔字符，获得最后的字符串
Func GetSubString (  $FindFullPath,  $separation)
 Local   $subString,$i,$stringArray
    $stringArray =  StringSplit($FindFullPath,$separation)
   For $i = 1 To $stringArray[0]
       $subString = $stringArray[$i]         
   Next      
 Return  $subString
EndFunc
#EndRegion