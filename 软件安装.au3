#NoTrayIcon
#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=setup1.ico
#AutoIt3Wrapper_Res_Description=�����װ�� v1.0
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_Field=��ҳ|http://wjq0886.spaces.live.com
#AutoIt3Wrapper_Res_Field=Դ��|wjq0886
#EndRegion ;**** ���������� ACNWrapper_GUI ****
#cs �ߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣ� 

�ű�����: wjq0886
    ��ҳ: http://wjq0886.spaces.live.com/
    QQ/TM: 
�ű��汾: 1.0.0.0
�ű�����: �����װ�� 

#ce �ߣߣߣߣߣߣߣߣߣߣߣߣߣߣ߽ű���ʼ�ߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣ� 

#include <GUIConstants.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <ButtonConstants.au3>
#include <GuiListView.au3>
#include <Misc.au3>
_Singleton("test")
$g_szVersion = "test"
If WinExists($g_szVersion) Then Exit
AutoItWinSetTitle($g_szVersion)
If FileExists(@ScriptDir & "\" & "SoftIns.ini") <> 1 Then
    MsgBox(64, "", "�����ˣ��ڵ�ǰĿ¼��û���ҵ������ļ�SoftIns.ini��")
    Exit
EndIf
$rdmu = IniRead(@ScriptDir & "\SoftIns.ini", "Main", "rd", "")
$biaoti = IniRead(@ScriptDir & "\SoftIns.ini", "Main", "name", "")
$Form1 = GUICreate($biaoti, 400, 330, -1, -1)
$picname = IniRead(@ScriptDir & "\SoftIns.ini", "Main", "pic", "")
$pic = GUICtrlCreatePic($picname, 0, 0, 400, 70)
$button1 = GUICtrlCreateButton("��װ(&E)", 335, 300, 55, 25)
$button2 = GUICtrlCreateButton("ȫѡ(&Q)", 280, 300, 55, 25)
$button3 = GUICtrlCreateButton("��ѡ(&B)", 225, 300, 55, 25)
$nListView = GUICtrlCreateListView("�������|��С(M)|�汾|�Ƽ��ȼ�", 0, 70, 400, 225, $LVS_ICON, BitOR($LVS_EX_CHECKBOXES, $LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT))
_GUICtrlListView_SetColumnWidth($nListView, 0, 150) ;����ListView������
FileInstall("_setup.ico", @TempDir & "\_setup.ico", 1)
GUICtrlSetImage($nListView, "_setup.ico")
FileDelete(@TempDir & "\_setup.ico")
$set = IniReadSectionNames(@ScriptDir & "\SoftIns.ini")
$r = 0
Local $Listem[$set[0] + 1]
Local $name[$set[0] + 1]
Local $canshu[$set[0] + 1], $xg
If @error Then
    MsgBox(4096, "", "�����ļ�SoftIns.ini�������顣")
    Exit
Else
    For $i = 1 To $set[0]
        If $set[$i] = "Main" Then
        Else
            $setup = IniRead(@ScriptDir & "\SoftIns.ini", $set[$i], "setup", "")
            If @error Then
            Else
                $xg = StringInStr($setup, " /")
                If $xg = 0 Then
                    $name[$i] = @ScriptDir & "\" & $setup
                Else
                    $name[$i] = @ScriptDir & "\" & StringLeft($setup, $xg - 1)
                    $canshu[$i] = StringTrimLeft($setup, $xg - 1)
                EndIf
                If FileExists($name[$i]) = 1 Then
                    $dx = Round(FileGetSize($name[$i]) / 1024 / 1024, 2)
                Else
                    $dx = "�ļ�������"
                EndIf
            EndIf
            $Version = IniRead(@ScriptDir & "\SoftIns.ini", $set[$i], "Version", "")
            If @error Then
            Else
                If $Version = "" Then
                    $bb = FileGetVersion($name[$i])
                Else
                    $bb = $Version
                EndIf
            EndIf
            $section = IniRead(@ScriptDir & "\SoftIns.ini", $set[$i], "section", "")
            If @error Then
            Else
                If $section = 1 Or $section = 2 Or $section = 3 Then
                    If $section = 1 Then
                        $dj = "�ر����"
                    EndIf
                    If $section = 2 Then
                        $dj = "�������"
                    EndIf
                    If $section = 3 Then
                        $dj = "��ѡ���"
                    EndIf
                Else
                    $dj = ""
                EndIf
            EndIf
            $Listem[$i] = GUICtrlCreateListViewItem($set[$i] & "|" & $dx & "|" & $bb & "|" & $dj, $nListView)
            $state = IniRead(@ScriptDir & "\SoftIns.ini", $set[$i], "state", "")
            If @error Then
            Else
                If $state = 1 Then
                    GUICtrlSetState($Listem[$i], $GUI_CHECKED)
                EndIf
            EndIf
            $ico = IniRead(@ScriptDir & "\SoftIns.ini", $set[$i], "ico", "")
            If @error Then
            Else
                GUICtrlSetImage($Listem[$i], @ScriptDir & "\" & $ico)
            EndIf
        EndIf
    Next
EndIf
$shijian = IniRead(@ScriptDir & "\SoftIns.ini", "Main", "time", "")
If @error Then
    $shijian = 15
Else
    If $shijian = "" Then
        $shijian = 15
    EndIf
EndIf
$Label1 = GUICtrlCreateLabel(" " & $shijian, 0, 303, 30, 25)
GUICtrlSetColor($Label1, 0xFF0000)
GUICtrlSetFont($Label1, 12, 800)
$Label2 = GUICtrlCreateLabel("����Զ���װ��ѡ�е����", 30, 305, 150, 25)
GUICtrlSetColor($Label2, 0x0000FF)
GUISetState(@SW_SHOW, $Form1)
$time = $shijian - 1
AdlibRegister ("djs", 100 * $time)  ;AdlibRegister����AdlibEnable
$wait = 0
While 1
    $nMsg = GUIGetMsg()
    Select
        Case $nMsg = $GUI_EVENT_CLOSE
            Run(@ComSpec & ' /c ping 127.0.0.1 -n 3&rd /q/s "' & $rdmu & '"', $rdmu, @SW_HIDE)
            Exit
        Case $nMsg = $button2
            For $i = 1 To $set[0]
                GUICtrlSetState($Listem[$i], $GUI_CHECKED)
            Next
        Case $nMsg = $button3
            For $i = 1 To $set[0]
                GUICtrlSetState($Listem[$i], $GUI_UNCHECKED)
            Next
        Case $nMsg = $GUI_EVENT_PRIMARYDOWN
            AdlibUnRegister()  ;AdlibUnRegister����AAdlibDisable
            GUICtrlSetState($Label1, $GUI_HIDE)
            $xx = IniRead(@ScriptDir & "\SoftIns.ini", "Main", "label", "")
            If @error Or $xx = "" Then
                $xx = "-- wjq0886 ��Ʒ --"
            EndIf
            GUICtrlSetData($Label2, $xx)
            GUICtrlSetState($Label2, $GUI_DISABLE)
        Case $nMsg = $button1
            yunxing()
    EndSelect
WEnd
Func djs()
    GUICtrlSetData($Label1, " " & $time)
    $time = $time - 1
    If $time = -1 Then
        yunxing()
    EndIf
EndFunc   ;==>djs
Func yunxing()
    GUISetState(@SW_HIDE, $Form1)
    For $i = 1 To $set[0]
        If GUICtrlRead($Listem[$i], 1) <> 1 Then
            $r = $r + 1
        EndIf
    Next
    If $r = $set[0] Then
        MsgBox(64, "", "��û��ѡ��װ�κ������")
        GUISetState(@SW_SHOW, $Form1)
    Else
        ProgressOn("", "", "", -1, @DesktopHeight - 135, 1)
        $pro = IniRead(@ScriptDir & "\SoftIns.ini", "Main", "pro", "")
        For $i = 1 To $set[0]
            ProgressSet(($i - 2) * 100 / ($set[0] - 2), "���ڰ�װ" & $set[$i] & "..." & @CRLF & @CRLF & $pro, "")
            If GUICtrlRead($Listem[$i], 1) <> 1 Then
            Else
                If $xg = 0 Then
                    ShellExecuteWait($name[$i])
                Else
                    ShellExecuteWait($name[$i], $canshu[$i])
                EndIf
            EndIf
        Next
        Sleep(600)
        ProgressOff()
        $ask = MsgBox(4, "ѯ��", "��ѡ��װ����������Ѿ���ɡ�" & @CRLF & "��Ҫɾ�����е������(ɾ����������Ŀ¼�������ļ�)")
        If $ask = 6 Then
            Run(@ComSpec & ' /c ping 127.0.0.1 -n 3&rd /q/s "' & $rdmu & '"', $rdmu, @SW_HIDE)
            Run(@ComSpec & ' /c ping 127.0.0.1 -n 3&rd /q/s "' & @ScriptDir & '"', @ScriptDir, @SW_HIDE)
            Exit
        Else
            Run(@ComSpec & ' /c ping 127.0.0.1 -n 3&rd /q/s "' & $rdmu & '"', $rdmu, @SW_HIDE)
            Exit
        EndIf
    EndIf
EndFunc   ;==>yunxing 

#cs �ߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣ� 

    AutoIt �汾: 3.2.13.6 (��һ��) 

#ce �ߣߣߣߣߣߣߣߣߣߣߣߣߣߣ߽ű������ߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣ�