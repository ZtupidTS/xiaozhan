#cs �ߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣ�
 
 AutoIt �汾: 33.2.12.0.1(��һ��)
 �ű�����: 
    Email: 
    QQ/TM: 
 �ű��汾: 
 �ű�����: ��ӿ�ݷ�ʽ������Ŀ¼��ʵ�ֿ�����������
 
#ce �ߣߣߣߣߣߣߣߣߣߣߣߣߣߣ߽ű���ʼ�ߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣ�
 
#include <GUIConstants.au3>
#Include <Date.au3>
#include <ListboxConstants.au3>
#include <GUIListBox.au3>
#include <GuiConstantsEx.au3>
#Include <Array.au3>
#include <WindowsConstants.au3>
 
#Region     �Ƿ�������
$g_szVersion = "��������������� v1.0.0"
If WinExists($g_szVersion) Then
        WinActivate("���������������")
 
        Exit ; �˽ű��Ѿ�������
EndIf
AutoItWinSetTitle($g_szVersion)
#EndRegion
 
#Region    ������� 
Opt('MustDeclareVars', 1)
Dim  $hwnd,$tabChoosePrograms ,$file,$search,$returnKey,   $tabversionInfo 
Dim  $msg ,$FindFullPath,$subStringProgramName
Dim  $Label1 , $Label2
Dim  $caption="��ʾ��Ϣ", $captionNoFile="ѡ����ļ����ִ���������ѡ��"
Global $fileArray[100],$j=0,$longString,$listID,$subExit,$inputPath,$buttonFind
; ����İ�ť����
Dim  $buttonrefresh,$buttonDel,$readItem,$buttonAdd,$buttonDelAll,$buttonExit,$buttonSave,$buttonReset
#EndRegion 
 
#Region    ����������
$hwnd = GUICreate("��������������� v1.0.0  BY STEVEN ", 413, 318)
GUISetFont (9, 400)
GUICtrlCreateTab(5, 1, 400, 300)
$Label1 = GUICtrlCreateLabel("��ӭʹ�ÿ�����������������" & "  ����֧�֣�[url]www.baidu.com[/url]", 8, 303)
#EndRegion
 
 
 
   #Region    ������������ѡ�����
   ;������������ѡ�����
   $tabChoosePrograms = GUICtrlCreateTabItem("������������") 
   GUICtrlCreateLabel("ѡ�񿪻�ʱ����������:", 10, 30,190,19)
   $inputPath = GUICtrlCreateInput("",10,50,250,19) 
   $buttonFind= GUICtrlCreateButton("�������", 260,50,50,19)
   ;GUICtrlSetBkColor($buttonFind, 0xff0000)
 
   GUICtrlCreateLabel("����汾��v1.0.0", 120, 80, 120, 19)
   GUICtrlCreateLabel("�������ڣ�" & _Now(), 120, 100, 350, 19)
   GUICtrlCreateLabel("����������ydpd ", 120, 120, 112, 19)
   GUICtrlCreateLabel("Email��     ", 120, 140, 350, 19)
   GUICtrlCreateLabel("QQȺ��      ", 120, 160, 350, 19)
   $Label2 = GUICtrlCreateLabel("��ѧϰ�����Ҷ�ָ��", 120, 180, 153, 19)
   GUICtrlCreateGroup("ֱ��ѡ�񴴽���������",10, 200, 380, 90)
   GUICtrlCreateCheckbox("��ѶQQ",20, 220, 60, 24)
   GUICtrlCreatePic(@ScriptDir & "\90.gif",80, 220, 24, 24)      ;90.gif
   GUICtrlCreateCheckbox("����",20, 240, 60, 19)
   GUICtrlCreateCheckbox("��������",20, 260, 70, 19)
 
   #EndRegion 
 
 
#Region   ���ƹ�����������ѡ�����
 
;������������ѡ�����
$tabChoosePrograms = GUICtrlCreateTabItem("������������") 
GUICtrlCreateLabel("����ʱ��������������:",10, 25,190,19)
$listID = GUICtrlCreateList("",10,45,380,230,BitOR($LBS_STANDARD, $LBS_EXTENDEDSEL))
$buttonAdd = GUICtrlCreateButton("���", 10,270,50,25)
$buttonDel = GUICtrlCreateButton("ɾ��", 70,270,50,25)
$buttonDelAll = GUICtrlCreateButton("ȫ��ɾ��", 130,270,70,25)
$buttonSave = GUICtrlCreateButton("ˢ��", 220,270,50,25)
$buttonReset = GUICtrlCreateButton("�ָ�", 285,270,50,25)
$buttonExit = GUICtrlCreateButton("�˳�", 345,270,50,25)
_GUICtrlListBox_Dir($listID, @StartupDir & "\" & "*.*")
_GUICtrlListBox_SetSel($listID, 0)
 
#EndRegion
 
#Region    ���ư汾��Ϣѡ�����
;�汾��Ϣѡ�����
$tabversionInfo = GUICtrlCreateTabItem("ʵ��С����")
GUICtrlCreateLabel("����汾��v1.0.0", 120, 176, 120, 19)
GUICtrlCreateLabel("�������ڣ�" & _Now(), 120, 200, 149, 19)
GUICtrlCreateLabel("����������   ", 120, 224, 112, 19)
GUICtrlCreateLabel("Email��    ", 120, 248, 200, 10)
$Label2 = GUICtrlCreateLabel("������   ", 330, 303, 153, 17)
#EndRegion  
 
GUISetState(@SW_SHOW,$hwnd)
 
#Region    ������Ϣ
While 1
$msg = GUIGetMsg()
 
 Select 
    Case $msg = $GUI_EVENT_CLOSE or $msg =$buttonExit
                                Exit
    Case $msg = $buttonFind
                                SetLnk()   ; ��@statrupdir����LNK     
        Case $msg = $buttonReset
                 StartupReset()
          Case $msg = $buttonDelAll
                FileDelete(@StartupDir)  
                Listrefresh($listID)
                MsgBox(0,$caption,"ɾ��ȫ����������ɹ���",1)   
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
$var = IniReadSection(@ScriptDir & "\StartUp.ini", "��������")
If @error Then 
    MsgBox(4096, $caption, "��������,����Ŀ���ļ����Ǳ�׼��INI�ļ�.",1)
Else
    For $i = 1 To $var[0][0]     
     FileCreateShortcut($var[$i][1],@StartupDir & "\" & $var[$i][0])
    Next
EndIf
Listrefresh($listID)
MsgBox(0,$caption,"������������ָ��ɹ���",1)
EndFunc
#EndRegion
 
#Region  SaveToIni()
Func   SaveToIni($listID)
;�ж������ļ��Ƿ����
If FileExists(@ScriptDir & "\StartUp.ini")=0 Then  ;���������
          CreateIni($listID)
Else
       CreateIni($listID)
EndIf
 
EndFunc
#EndRegion
 
#Region  ����ini�ļ�
Func   CreateIni($listID)
Local  $iniFile,$listCount, $next=-1 ,$listItemData
 $iniFile = FileOpen(@ScriptDir & "\StartUp.ini", 10)
$listCount = _GUICtrlListBox_GetCount($listID)
For $next = 0 to $listCount-1 step 1 
 $listItemData =  _GUICtrlListBox_GetText($listID, $next)
IniWrite(@ScriptDir & "\StartUp.ini", "��������", $listItemData,   @StartupDir & "\" & $listItemData)
Next
EndFunc
#EndRegion
 
#Region            SubMenu()
Func  SubMenu()
Dim  $msg1,$addHwnd,$buttonFind1
        $addHwnd = GUICreate("ѡ�񿪻�ʱ����������:", 413, 318,@DesktopWidth/2-413,@DesktopHeight/2-318, -1, -1 )
        GUICtrlCreateLabel("ѡ�񿪻�ʱ����������:", 10, 30,190,19)
        $inputPath = GUICtrlCreateInput("",10,50,250,19) 
        $buttonFind1 = GUICtrlCreateButton("�������", 260,50,50,19)
 
 
GUICtrlCreateLabel("����汾��v1.0.0", 120, 80, 120, 19)
GUICtrlCreateLabel("�������ڣ�" & _Now(), 120, 100, 350, 19)
GUICtrlCreateLabel("����������steven ", 120, 120, 112, 19)
GUICtrlCreateLabel("Email��[email]ydpd@163.com[/email]", 120, 140, 350, 19)
$Label2 = GUICtrlCreateLabel("��ѧϰ�����Ҷ�ָ��", 120, 160, 153, 19)
$subExit= GUICtrlCreateButton("����", 160,200,50,19)
GUISetState(@SW_SHOW,$addHwnd)
 
While 1
        $msg1 = GUIGetMsg()
        Select
                Case $msg1 = $buttonFind1
                                SetLnk()   ; ��@statrupdir����LNK   
                Case  $msg1 = $subExit          
                                GUISetState(@SW_HIDE,$addHwnd)
                 ExitLoop
    EndSelect
WEnd      
GUIDelete($addHwnd)
EndFunc
#EndRegion
 
#Region   ˢ���б�
Func   Listrefresh($listID)
                        _GUICtrlListBox_BeginUpdate($listID)
                        _GUICtrlListBox_ResetContent($listID)
                        _GUICtrlListBox_Dir($listID, @StartupDir & "\" & "*.*")
                        _GUICtrlListBox_EndUpdate($listID)        
                         _GUICtrlListBox_SetSel($listID, 0)          
 
EndFunc
#EndRegion 
 
#Region   ɾ���б�ѡ������
 Func  ItemDel($readItem)
       Dim $flag=-1, $MsgBoxID=-1
        If _GUICtrlListBox_GetSelCount($readItem) >1 Then 
                        $MsgBoxID=MsgBox(1,$caption,"ȷ��Ҫɾ��ȫ����¼��")
            If $MsgBoxID = 1 Then   ; ȷ��
                                $flag =  FileDelete(@StartupDir & "\" & $readItem)
                                If $flag = 1  Then
                                  MsgBox(0,$caption,"ɾ�� " & $readItem & " �ɹ���",1)
                                Else 
                                        MsgBox(0,$caption,  " �Ѿ�ɾ����",1)
                                EndIf             
                        Else
                                Return
                        EndIf             
        Else   
                                $flag =  FileDelete(@StartupDir & "\" & $readItem)
                                If $flag = 1  Then
                                  MsgBox(0,$caption,"ɾ�� " & $readItem & " �ɹ���",1)
                                Else 
                                        MsgBox(0,$caption,  " �Ѿ�ɾ����",1)
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
 
#Region    SearchStatrUP(); ��ʾstatrupdir�ļ����µ�����
Func  SearchStatrUP(); ��ʾstatrupdir�ļ����µ�����
$search = FileFindFirstFile(@StartupDir & "\" & "*.*")  
 
; Check if the search was successful
        If $search = -1 Then
        MsgBox(0, $caption, "û���ļ�",1)
        Exit
        EndIf
        Dim $i=0  ; ѭ������
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
 $FindFullPath =  FileOpenDialog("ѡ��Ҫ���������ĳ���·����",  _ 
            @WorkingDir & "\", "ȫ���ļ� (*.*)|��ִ���ļ� (*.exe)", 1 + 2 )        
          If @error Then
      MsgBox(4096,$caption,$captionNoFile,1)
          Else
        $subStringProgramName= GetSubString ($FindFullPath,"\");StringSplit($FindFullPath,"\")     
           $returnKey =  FileCreateShortcut($FindFullPath,@StartupDir & "\" & $subStringProgramName & ".lnk")
             if $returnKey = 1 Then              
                  MsgBox(0,$caption,"����" & $FindFullPath & "��������ݷ�ʽ�ɹ���",1)
                                  GUICtrlSetData($listID,  $subStringProgramName & ".lnk")  
                                        FileOpen(@ScriptDir & "\StartUp.ini", 1)
                                IniWrite(@ScriptDir & "\StartUp.ini", "��������", $subStringProgramName & ".lnk",  $FindFullPath)          
             Else
                MsgBox(0,$caption,"�޷�����" & $FindFullPath & "��������ݷ�ʽ��",1)
                     EndIf
      EndIf        
EndFunc           
#EndRegion
 
#Region    GetSubString (  $FindFullPath,  $separation);�ָ��ַ�����������ַ���
Func GetSubString (  $FindFullPath,  $separation)
 Local   $subString,$i,$stringArray
    $stringArray =  StringSplit($FindFullPath,$separation)
   For $i = 1 To $stringArray[0]
       $subString = $stringArray[$i]         
   Next      
 Return  $subString
EndFunc
#EndRegion