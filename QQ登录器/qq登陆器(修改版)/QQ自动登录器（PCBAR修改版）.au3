#Region ACNԤ����������(���ò���)
#PRE_Icon= 										;ͼ��,֧��EXE,DLL,ICO
#PRE_OutFile=									;����ļ���
#PRE_OutFile_Type=exe							;�ļ�����
#PRE_Compression=4								;ѹ���ȼ�
#PRE_UseUpx=y 									;ʹ��ѹ��
#PRE_Res_Comment= 								;����ע��
#PRE_Res_Description=							;��ϸ��Ϣ
#PRE_Res_Fileversion=							;�ļ��汾
#PRE_Res_FileVersion_AutoIncrement=p			;�Զ����°汾
#PRE_Res_LegalCopyright= 						;��Ȩ
#PRE_Change2CUI=N                   			;�޸�����ĳ���ΪCUI(����̨����)
;#PRE_Res_Field=AutoIt Version|%AutoItVer%		;�Զ�����Դ��
;#PRE_Run_Tidy=                   				;�ű�����
;#PRE_Run_Obfuscator=      						;�����Ի�
;#PRE_Run_AU3Check= 							;�﷨���
;#PRE_Run_Before= 								;����ǰ
;#PRE_Run_After=								;���к�
;#PRE_UseX64=n									;ʹ��64λ������
;#PRE_Compile_Both								;����˫ƽ̨����
#EndRegion ACNԤ�����������������
#cs �ߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣ�

 Au3 �汾: 
 �ű�����: 
 �����ʼ�: 
	QQ/TM: 
 �ű��汾: 
 �ű�����: 

#ce �ߣߣߣߣߣߣߣߣߣߣߣߣߣߣ߽ű���ʼ�ߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣ�

#NoTrayIcon
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
#include <QQPwd.au3>
 
Opt('GUIResizeMode', 802)
 
$Version = "QQLoginV2.0_By_5i3p"
If WinExists($Version) Then Exit
AutoItWinSetTitle($Version)
 
If Not FileExists(@ScriptDir&"\Config.ini") Then RegDelete("HKCU\Software\QQLogin", "NeedPWD")
 
If RegRead("HKCU\Software\QQLogin", "NeedPWD") = "1" Then
        $setpwd = RegRead("HKCU\Software\QQLogin", "PassWord")
        For $i = 1 To 3
                $pwd_00 = InputBox("Ȩ����֤:", '������ѱ�����Ϊ��Ҫ������ܽ���!' &@LF&@LF& '����������:', "", "*M30", "-1", "150", "-1", "-1")
                If @error = 1 Then Exit
                If $pwd_00 <> $setpwd Then
                        If $i = 3 Then
                                MsgBox(16, "���棡", "���ζ����ԣ���϶��ǷǷ��û���" &@LF&@LF& "�����ٳ��ԣ������Զ���ͨ�绰������110��")
                                Exit
                        EndIf
                        MsgBox(48, "��ʾ", "���벻�ԣ������䣡", 2)
                Else
                        ExitLoop
                EndIf
        Next
EndIf
 
FileInstall("Hide.ico", @ScriptDir & "\Hide.ico")
FileInstall("Online.ico", @ScriptDir & "\Online.ico")
_CreatIni()     
Global $NumList[2]
$IniFile = @ScriptDir&"\Config.ini"
$Window = GUICreate("QQ�Զ���¼��", 367, 300, 192, 114)
GUICtrlCreateGroup("��ѡ����Ҫ��½��QQ����:", 4, 8, 361, 289)
$List1 = GUICtrlCreateListView("      QQ����   |�ǳ�        |�ϴε�½ʱ��", 10, 32, 245, 233)
GUICtrlSendMsg($List1, $LVM_SETEXTENDEDLISTVIEWSTYLE, $LVS_EX_GRIDLINES, $LVS_EX_GRIDLINES)
GUICtrlSetTip(-1, "ˢ���б�󣬺�ɫ��ʾ�������ڱ�����½�ĺ���")
Dim $B_DESCENDING[_GUICtrlListView_GetColumnCount($List1)]
$Denglu = GUICtrlCreateButton("��½", 268, 32, 83, 25, 0)
$Refresh = GUICtrlCreateButton("ˢ���б�", 268, 68, 83, 25, 0)
$Run = GUICtrlCreateButton("����QQ", 268, 104, 83, 25, 0)
$Set = GUICtrlCreateButton("���á�", 268, 140, 83, 25, 0)
GUICtrlSetColor(-1, 0x0000FF)
$Close = GUICtrlCreateButton("�ر�����QQ", 268, 193, 83, 25, 0)
$About = GUICtrlCreateButton("����(&A)", 268, 226, 83, 25, 0)
$Exit = GUICtrlCreateButton("�˳�(&X)", 268, 260, 83, 25, 0)
$Check = GUICtrlCreateCheckbox("��½��ɺ�رյ�¼��", 10, 272, 153, 17)
GUICtrlCreateLabel("By: ��ͳ.��", 189, 274, 78, 17)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateGroup("��������", 4, 312, 361, 97)
GUICtrlCreateLabel("QQ��������·��:", 12, 340, 95, 17)
$Input = GUICtrlCreateInput(IniRead($IniFile, "��ѶQQ", "��װ·��", ""), 112, 336, 241, 21)
$Zidong = GUICtrlCreateButton("�Զ�����", 168, 372, 89, 25, 0)
$Shoudong = GUICtrlCreateButton("�ֶ�ָ��", 265, 372, 89, 25, 0)
GUICtrlCreateGroup("QQ����༭", 4, 424, 361, 150)
$NeedCheck = GUICtrlCreateCheckbox("���õ�½�������Ҫ����", 167, 455, 150, 17)
If RegRead("HKCU\Software\QQLogin", "NeedPWD") = "1" Then
        GUICtrlSetState($NeedCheck, $GUI_CHECKED)
Else
        GUICtrlSetState($NeedCheck, $GUI_UNCHECKED)
EndIf
$List2 = GUICtrlCreateList("", 12, 444, 135, 128, BitOR($WS_BORDER, $WS_VSCROLL, $LBS_NOTIFY))
$Tianjia = GUICtrlCreateButton("���", 167, 504, 83, 25, 0)
$Shanchu = GUICtrlCreateButton("ɾ��", 262, 504, 83, 25, 0)
$Bianji = GUICtrlCreateButton("�༭", 167, 540, 83, 25, 0)
$Shuaxin = GUICtrlCreateButton("ˢ��", 262, 540, 83, 25, 0)
GUISetState(@SW_SHOW)
_ShowList()
 
Dim $savemima = RegRead("HKCU\Software\QQLogin", "PassWord")
While 1
        If GUICtrlRead($NeedCheck) = $GUI_CHECKED Then                              
                RegWrite("HKCU\Software\QQLogin", "NeedPWD", "REG_SZ", "1")
                RegWrite("HKCU\Software\QQLogin", "PassWord", "REG_SZ", $savemima)
        Else
                RegWrite("HKCU\Software\QQLogin", "NeedPWD", "REG_SZ", "0")
                RegWrite("HKCU\Software\QQLogin", "PassWord", "REG_SZ", "")
        EndIf   
        $QQFile = IniRead($IniFile, "��ѶQQ", "��װ·��", "")
    $QQPath = _Getpath($QQFile)
        $nMsg = GUIGetMsg()
        Switch $nMsg
                Case $GUI_EVENT_CLOSE
                        Exit
                Case $Exit
                        Exit
                Case $NeedCheck
                        If GUICtrlRead($NeedCheck) = $GUI_CHECKED Then
                                $setpwd_tmp = InputBox("��������:", "����������:", "", "*M30", "-1", "120", "-1", "-1")
                                If @error = 1 Then
                                        GUICtrlSetState($NeedCheck, $GUI_UNCHECKED)
                                Else
                                        $setpwd = InputBox("�ظ�����:", "��������һ������:", "", "*M30", "-1", "120", "-1", "-1")
                                        If $setpwd <> $setpwd_tmp Then
                                                MsgBox(64, "��ʾ", "��������������벻һ�����������趨��")
                                                GUICtrlSetState($NeedCheck, $GUI_UNCHECKED)
                                        Else 
                                                $savemima = $setpwd
                                        EndIf
                                EndIf
                        EndIf                   
                Case $Shoudong
                        $Value = FileOpenDialog("��ѡ��QQ���ڵ�Ŀ¼...", @ProgramFilesDir, "��ִ���ļ�(*.exe)")
                        GUICtrlSetData($Input, $Value)
                        IniWrite($IniFile, "��ѶQQ", "��װ·��", $Value)
                Case $Zidong
                        $Value = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\TENCENT\QQ", "install")
                        GUICtrlSetData($Input, $Value &"QQ.exe")
                        IniWrite($IniFile, "��ѶQQ", "��װ·��", $Value &"QQ.exe")
                Case $Set
                        $pos = WinGetPos("QQ�Զ���½��","")
                        If GUICtrlRead($Set) = "���á�" Then
                                WinMove  ($Window,"", Default, Default, Default , 605)
                                GUICtrlSetData($Set,"���á�")
                        ElseIf GUICtrlRead($Set) = "���á�" Then
                                WinMove  ($Window,"", Default, Default,Default , 326)
                                GUICtrlSetData($Set,"���á�")
                        EndIf
;~                         _ShowQQ()
                Case $Tianjia
                        _Tianjia()
                Case $About
                        _About()
                Case $Check
                        If GUICtrlRead($Check) = $GUI_CHECKED Then
                                IniWrite($IniFile, "�������", "��½���˳�", "��")
                        Else
                                IniWrite($IniFile, "�������", "��½���˳�", "��")
                        EndIf
                Case $Close
                        _CloseAllQQ()
                Case $Denglu                    
                        If _GUICtrlListView_GetSelectedCount($List1) = 0 Then
                           MsgBox(64, "��ʾ", "����ѡ����Ҫ��½��QQ��������ԣ�")
                           ContinueLoop
                        ElseIf StringRight($QQFile, 7) <> "\QQ.exe" Then
                                MsgBox(64, "", "�����õ�QQ·�������ڣ��������ô���"&@CRLF&@CRLF&"������õ���ɫ��QQ���ֶ�ָ��·����·������ΪQQ.exe��β��"&@CRLF&@CRLF&"��������á���ť���ú�·�������ԣ�")
                        Else
                                $Num = _GUICtrlListView_GetItemText($List1, Int(_GUICtrlListView_GetSelectedIndices($List1)))
                                $PassTemp = IniRead($IniFile, $Num, "����", "")
                                $Pass = _Password(0, $PassTemp, '�û������QQ����',5)
                                $StatTemp = IniRead($IniFile, "QQ�б�", $Num, "")
                                If $StatTemp = "����" Then 
                                        $Status = 40
                                Else
                                        $Status = 41
                                EndIf
                                Run($QQFile & " /START QQUIN:" & $Num & " PWDHASH:" & Str2QQPwdHash($Pass) & " /STAT:" & $Status)
                                IniWrite($IniFile, $Num, "�ϴε�½ʱ��", @YEAR & @MON & @MDAY)
                        EndIf
                        If GUICtrlRead($Check) = $GUI_CHECKED Then Exit
                Case $Bianji
                        If GUICtrlRead($List2) = "" Then
                                MsgBox(64, "��ʾ", "����ѡ����Ҫ�༭��QQ��������ԣ�")
                        Else
                                _EditQQ()
                        EndIf
                Case $Shuaxin
                        _ShowQQ()
                Case $Run
                        Run($QQFile, $QQPath)
                Case $Refresh
                        GUICtrlSendMsg($List1, $LVM_DeleteALLITEMS, 0, 0)
                        _ShowList()
                Case $Shanchu
                        If  GUICtrlRead($List2) = "" Then
                                MsgBox(64, "��ʾ", "����ѡ����Ҫ�༭��QQ��������ԣ�")
                        Else
                                IniDelete(@ScriptDir&"\config.ini",GUICtrlRead($List2))
                            IniDelete(@ScriptDir&"\config.ini","QQ�б�",GUICtrlRead($List2))
                                _ShowQQ()
                                MsgBox(64, "��ʾ", "ɾ���ɹ���")
                        EndIf
                        GUICtrlSendMsg($List1, $LVM_DeleteALLITEMS, 0, 0)
                        _ShowList()
                Case $List1
                        _GUICtrlListView_SimpleSort($List1, $B_DESCENDING, GUICtrlGetState($List1))     
        EndSwitch
 
        _ReduceMemory(@AutoItPID)
WEnd
 
Func _About()
        GUISetState(@SW_DISABLE, $Window)
        $AboutWindow = GUICreate("����...", 235, 240, 565, 114)
        GUICtrlCreateIcon (@AutoItExe,-1,22,40)
        GUICtrlCreateGroup("", 8, 4, 220, 195)
        $Label1 = GUICtrlCreateLabel("QQ�Զ���½�� V2.0", 70, 40, 142, 17, $WS_GROUP)
        GUICtrlSetFont(-1, 10, 800, 0, "����")
        GUICtrlCreateLabel("��ͳ.��(�޸İ�)", 70, 80, 100, 17)
        $Mail = GUICtrlCreateLabel("5i3p@sina.com", 70, 102, 100, 17)
        GuiCtrlSetCursor($Mail,0)
    GUICtrlSetColor(-1, 0x0000FF)
        GUICtrlCreateLabel("��ȨΪPCBar���У������Ų�����", 20, 144, 200, 17, $WS_GROUP)
        GUICtrlCreateLabel("��ӭ����QQȺ227200 (AU3��������)", 20, 168, 194, 17)
        GUICtrlCreateGroup("", -99, -99, 1, 1)
        $OK = GUICtrlCreateButton("ȷ��(&O)", 90, 208, 75, 25)
        GUISetState(@SW_SHOW)
 
        While 1
                Switch GUIGetMsg()
                        Case $GUI_EVENT_CLOSE
                                        GUISetState(@SW_ENABLE,$Window)
                                        GUIDelete($AboutWindow)
                                        ExitLoop
                        Case $OK
                                        GUISetState(@SW_ENABLE,$Window)
                                        GUIDelete($AboutWindow)
                                        ExitLoop
                        Case $Mail
                                        Run(@ComSpec & " /c " & 'start mailto:5i3p@sina.com?subject=Something', "", @SW_HIDE)
                EndSwitch
                _ReduceMemory(@AutoItPID)
        WEnd
EndFunc;<==���ڴ���
 
Func _Tianjia()
        GUISetState(@SW_DISABLE, $Window)
        $AddWindow = GUICreate("���QQ����", 281, 178, 565, 516)
        GUICtrlCreateGroup("������QQ�˺���Ϣ", 2, 8, 276, 125)
        GUICtrlCreateLabel("QQ����:", 16, 33, 47, 16)
        GUICtrlCreateLabel("QQ����:", 16, 59, 47, 16)
        GUICtrlCreateLabel("�ظ�����:", 16, 84, 55, 16)
        $UseNick = GUICtrlCreateCheckbox("ʹ���Զ����ǳ�:", 16, 110, 113, 17)
        $QQ = GUICtrlCreateInput("", 72, 30, 137, 21, $ES_NUMBER,$WS_EX_STATICEDGE)
        GUICtrlSetLimit(-1, 10)
        $Mima = GUICtrlCreateInput("", 72, 56, 193, 20, $ES_PASSWORD,$WS_EX_STATICEDGE)
        $Remima = GUICtrlCreateInput("", 72, 81, 193, 20, $ES_PASSWORD,$WS_EX_STATICEDGE)
        $NickName = GUICtrlCreateInput("", 128, 107, 137, 20)
        GUICtrlSetState(-1, $GUI_DISABLE)
        GUICtrlSetLimit(-1, 4)
        $Yinshen = GUICtrlCreateCheckbox("����", 224, 32, 41, 17)
        $Save = GUICtrlCreateButton("����(&S)", 50, 145, 65, 25, 0)
        $Cancel = GUICtrlCreateButton("ȡ��(&C)", 160, 145, 65, 25, 0)
        ControlFocus("���QQ����", "", "Edit1")
        GUISetState(@SW_SHOW)
        
    While 1
                Switch GUIGetMsg()
                        Case $GUI_EVENT_CLOSE
                                GUISetState(@SW_ENABLE,$Window)
                                GUIDelete($AddWindow)
                                ExitLoop
                        Case $Cancel
                                GUISetState(@SW_ENABLE,$Window)
                                GUIDelete($AddWindow)
                                ExitLoop
                        Case $UseNick
                                If GUICtrlRead($UseNick) = $GUI_CHECKED Then
                                        GUICtrlSetState($NickName, $GUI_ENABLE)
                                Else
                                        GUICtrlSetState($NickName, $GUI_DISABLE)
                                EndIf
                        Case $Save
                                if GUICtrlRead($QQ)="" then
                           MsgBox(64, "��ʾ", "������QQ����!")
                                   ContinueLoop
                                EndIf
                                If GUICtrlRead($Mima) = GUICtrlRead($Remima) Then
                                                If GUICtrlRead($Yinshen) = $gui_checked Then
                                                        IniWrite($IniFile, "QQ�б�", GUICtrlRead($QQ), "����")
                                                Else
                                                        IniWrite($IniFile, "QQ�б�", GUICtrlRead($QQ), "����")
                                                EndIf
                                                IniWrite($IniFile, GUICtrlRead($QQ), "����", _Password(1, GUICtrlRead($Mima), '�û������QQ����',5))
                                                if  GUICtrlRead($UseNick) = $gui_checked Then
                                                        IniWrite($IniFile,GUICtrlRead($QQ),"�ǳ�",GUICtrlRead($NickName))
                                                EndIf
                                                _ShowQQ()
                                Else
                                                MsgBox(64, "ע��", "������������벻һ���������䣡")
                                                ContinueLoop
                                EndIf
                                GUISetState(@SW_ENABLE,$Window)
                                GUIDelete($AddWindow)
                                ExitLoop
                EndSwitch
                _ReduceMemory(@AutoItPID)
        WEnd
        GUICtrlSendMsg($List1, $LVM_DeleteALLITEMS, 0, 0)
        _ShowList()
EndFunc;<==��Ӻ��봰��
 
Func _EditQQ()
        GUISetState(@SW_DISABLE, $Window)
        $AddWindow = GUICreate("�༭QQ����", 281, 178, 565, 516)
        GUICtrlCreateGroup("������QQ�˺���Ϣ", 2, 8, 276, 125)
        GUICtrlCreateLabel("QQ����:", 16, 33, 47, 16)
        GUICtrlCreateLabel("QQ����:", 16, 59, 47, 16)
        GUICtrlCreateLabel("�ظ�����:", 16, 84, 55, 16)
        $UseNick = GUICtrlCreateCheckbox("ʹ���Զ����ǳ�:", 16, 110, 113, 17)
        $QQ = GUICtrlCreateInput("", 72, 30, 137, 21, $ES_NUMBER,$WS_EX_STATICEDGE)
        GUICtrlSetLimit(-1,10)
        $Mima = GUICtrlCreateInput("", 72, 56, 193, 20, $ES_PASSWORD,$WS_EX_STATICEDGE)
        $Remima = GUICtrlCreateInput("", 72, 81, 193, 20, $ES_PASSWORD,$WS_EX_STATICEDGE)
        $NickName = GUICtrlCreateInput("", 128, 107, 137, 20)
        GUICtrlSetState(-1, $GUI_DISABLE)
        GUICtrlSetLimit(-1, 4)
        $Yinshen = GUICtrlCreateCheckbox("����", 224, 32, 41, 17)
        $Save = GUICtrlCreateButton("����(&S)", 50, 145, 65, 25, 0)
        $Cancel = GUICtrlCreateButton("ȡ��(&C)", 160, 145, 65, 25, 0)
    $tempmima = IniRead($IniFile, _GUICtrlListBox_GetText($List2, _GUICtrlListBox_GetCurSel($List2)), "����", "")
        GUICtrlSetData($QQ,  _GUICtrlListBox_GetText($List2, _GUICtrlListBox_GetCurSel($List2)))
        GUICtrlSetState($QQ, $GUI_DISABLE)
        GUICtrlSetData($Mima, _password(0, $tempmima, "�û������QQ����", 5))
        GUICtrlSetData($Remima, _password(0, $tempmima, "�û������QQ����", 5))
        If IniRead($IniFile, _GUICtrlListBox_GetText($List2, _GUICtrlListBox_GetCurSel($List2)), "�ǳ�", "") <> "" Then 
                GUICtrlSetState($UseNick, $GUI_CHECKED)
                GUICtrlSetState($NickName, $GUI_ENABLE)
            GUICtrlSetData($NickName, IniRead($IniFile, _GUICtrlListBox_GetText($List2, _GUICtrlListBox_GetCurSel($List2)), "�ǳ�", ""))
        EndIf
        
        If IniRead($IniFile, "QQ�б�", _GUICtrlListBox_GetText($List2, _GUICtrlListBox_GetCurSel($List2)), "") = "����" Then
                GUICtrlSetState($Yinshen, $GUI_CHECKED)
        Else
                GUICtrlSetState($Yinshen, $GUI_UNCHECKED)
        EndIf
        ControlFocus("�༭QQ����", "", "Edit2")
        GUISetState(@SW_SHOW)
        
    While 1
                Switch GUIGetMsg()
                        Case $GUI_EVENT_CLOSE
                                GUISetState(@SW_ENABLE,$Window)
                                GUIDelete($AddWindow)
                                ExitLoop
                        Case $Cancel
                                GUISetState(@SW_ENABLE,$Window)
                                GUIDelete($AddWindow)
                                ExitLoop
                        Case $UseNick
                                If GUICtrlRead($UseNick) = $GUI_CHECKED Then
                                        GUICtrlSetState($NickName, $GUI_ENABLE)
                                Else
                                        GUICtrlSetState($NickName, $GUI_DISABLE)
                                EndIf
                        Case $Save
                                if GUICtrlRead($QQ)="" then
                           MsgBox(64, "��ʾ", "������QQ����!")
                                   ContinueLoop
                            EndIf
                                If GUICtrlRead($Mima) = GUICtrlRead($Remima) Then
                                                If GUICtrlRead($Yinshen) = $gui_checked Then
                                                        IniWrite($IniFile, "QQ�б�", GUICtrlRead($QQ), "����")
                                                Else
                                                        IniWrite($IniFile, "QQ�б�", GUICtrlRead($QQ), "����")
                                                EndIf
                                                IniWrite($IniFile, GUICtrlRead($QQ), "����", _Password(1, GUICtrlRead($Mima), '�û������QQ����',5))
                                                if  GUICtrlRead($UseNick) = $gui_checked Then
                                                        IniWrite($IniFile,GUICtrlRead($QQ),"�ǳ�",GUICtrlRead($NickName))
                                                EndIf
                                        _ShowQQ()
                                Else
                                                MsgBox(64, "ע��", "������������벻һ���������䣡")
                                                ContinueLoop
                                EndIf
                                GUISetState(@SW_ENABLE,$Window)
                                GUIDelete($AddWindow)
                                ExitLoop
                EndSwitch
                _ReduceMemory(@AutoItPID)
        WEnd
        GUICtrlSendMsg($List1, $LVM_DeleteALLITEMS, 0, 0)
        _ShowList()
EndFunc;<==�༭���봰��
 
Func _CreatIni()
        If Not FileExists(@ScriptDir&"\Config.ini") Then
                $file = FileOpen(@ScriptDir&"\Config.ini", 1)
                FileWriteLine($file, "[�������]")
                FileWriteLine($file, "��½���˳�=��"& @CRLF & @CRLF)
                FileWriteLine($file, "[��ѶQQ]")
                FileWriteLine($file, "��װ·��="& @CRLF & @CRLF)
                FileClose($file)
        EndIf
EndFunc;<==����Config.ini�����ļ�
 
Func _Getpath($x)
        If Not FileExists($x) Then
                Return ""
        EndIf
        Local $tmp
        $tmp = StringInStr($x, "\", 0, -1)
        Return StringLeft($x, $tmp - 1)
EndFunc ;<==��ò���"\"��β��·��
 
Func _CloseAllQQ()
        If Not ProcessExists("QQ.exe") Then
                MsgBox(262144, "��ʾ", "ûQQ��������رո�ʲô����Ŷ��", 2)
        Else
                $QQlist = ProcessList("QQ.exe")
                If @error Then Return
                If IsArray($QQlist) Then
                        For $i = 1 To $QQlist[0][0]
                                ProcessClose($QQlist[$i][1])
                        Next
                EndIf
                MsgBox(262144, "��ʾ", "���е�QQ���ѹرա�", 2)
        EndIf
        GUICtrlSendMsg($List1, $LVM_DeleteALLITEMS, 0, 0)
        _ShowList()
EndFunc ;<==�ر�����QQ
 
Func _ShowQQ()
        GUICtrlSetData($List2, "")
        Local $QQNumbers
        $QQNumbers = IniReadSection($IniFile, "QQ�б�")
        If IsArray($QQNumbers) Then
                For $i = 1 To $QQNumbers[0][0]
                        _GUICtrlListBox_AddString($List2, $QQNumbers[$i][0])
                Next
        Else
                Return
        EndIf
EndFunc;<==ˢ��List2���QQ�б�
 
Func _ShowList()
        $Number = IniReadSection($IniFile, "QQ�б�")
        If IsArray($Number) Then 
                ReDim $NumList[$Number[0][0]]
                For $i = 1 To $Number[0][0]
                        $NumList[$i - 1] = $Number[$i][0]
                        $Stat = IniRead($IniFile, "QQ�б�", $Number[$i][0], "")
                        $LastDate = _MyDate(IniRead($IniFile, $Number[$i][0], "�ϴε�½ʱ��", "Never Logined"))
                        $Name = IniRead($IniFile, $Number[$i][0], "�ǳ�", "Default")
                        $item = GUICtrlCreateListViewItem($Number[$i][0]&"|"&$Name&"|"&$LastDate, $List1)
                        If Round($i/2) <> $i/2 Then GUICtrlSetBkColor($item, 0xEEEEEE)
                        If $Stat = "����" Then
                           GUICtrlSetImage($item, @ScriptDir&"\Hide.ico")
                    Else
                           GUICtrlSetImage($item, @ScriptDir&"\Online.ico")
                        EndIf
            $var = WinList()
                        For $e = 1 to $var[0][0]
                                If $var[$e][0] <> "" Then
                                $s = StringInStr ($var[$e][0], "_QQMusic_SmallClient")
                                        if $s <> 0 then 
                                                $ms = StringLeft ( $var[$e][0], $s-1)
                                                if $Number[$i][0] = $ms Then GUICtrlSetColor(-1, 0xFF0000)
                                        EndIf
                                EndIf
                        Next
                Next
        EndIf
        If IniRead($IniFile, "�������", "��½���˳�", "") = "��" Then
                GUICtrlSetState($Check, $GUI_CHECKED)
        Else
                GUICtrlSetState($Check, $GUI_UNCHECKED)
        EndIf
EndFunc   ;==>��ʾ��ˢ��List1
 
Func _MyDate($tmpdate)
        If StringIsDigit($tmpdate) Then
                $t1 = StringLeft($tmpdate, 4) & "." & StringMid($tmpdate, 5, 2) & "." & StringMid($tmpdate, 7, 2)
                Return $t1
        Else
                Return $tmpdate
        EndIf
EndFunc ;<==�ϴε�½ʱ��
 
Func _ReduceMemory($i_PID = -1)
        If $i_PID <> -1 Then
                Local $ai_Handle = DllCall("kernel32.dll", 'int', 'OpenProcess', 'int', 0x1f0fff, 'int', False, 'int', $i_PID)
                Local $ai_Return = DllCall("psapi.dll", 'int', 'EmptyWorkingSet', 'long', $ai_Handle[0])
                DllCall('kernel32.dll', 'int', 'CloseHandle', 'int', $ai_Handle[0])
        Else
                Local $ai_Return = DllCall("psapi.dll", 'int', 'EmptyWorkingSet', 'long', -1)
        EndIf
    Return $ai_Return[0]
EndFunc ;<==�ͷ��ڴ�
        
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
EndFunc ;<==���ܽ��ܺ���
 
;δʵ�֣�
;3���������ͬʱ��½
