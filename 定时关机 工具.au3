#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=D:\���\�ļ�ͼ���滻����\ICO\OTHER\BLUEB~56.ICO
#AutoIt3Wrapper_outfile=��ʱ�ػ� ����.exe
#AutoIt3Wrapper_Res_Fileversion=0.0.0.0
#EndRegion ;**** ���������� ACNWrapper_GUI ****
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <GUIConstants.au3>
#include <DateTimeConstants.au3>
#Include <Constants.au3>
$Exists = "�ػ�����";�ж��Ƿ�ֻ����һ������
If WinExists($Exists) Then 
        MsgBox(32,"��ܰ������:","�����Ѿ�����!")
        Exit 
EndIf
        
;AutoItWinSetTitle($Exists);�޸ĳ��򴰿ڵı�����
FileCreateShortcut(@AutoItExe,@DesktopCommonDir&"\��ʱ����");�Զ������洴����ݷ�ʽ!
$Combo1 = GUICtrlCreateCombo("", 120, 95, 80, 25);����б�
$R1 = ""
$T1 = ""
$T2 = ""
$T3 = ""
$T4 = ""
$S1 = ""
$W1="0"
$W2="0"
$W3="0"
$W4="0"
$W5="0"
$W6="0"
$W7="0"

$Form0= GUICreate("�ػ�����", 420, 380, 500, 300);ǰ������Ǵ�С���������������
$Group1 = GUICtrlCreateGroup("�ػ�ʱ���趨��Ĭ��Ϊÿ�죩", 20, 110, 380, 95);ǰ������ǿ�����,�����Ǵ�С
GUICtrlSetColor(-1,0x666666)
$Checkbox1 = GUICtrlCreateCheckbox("����һ", 40, 130, 65, 25);ǰ�����������,�������Լ�ռ�ô�С
$Checkbox2 = GUICtrlCreateCheckbox("���ڶ�", 110, 130, 65, 25)
$Checkbox3 = GUICtrlCreateCheckbox("������", 180, 130, 65, 25)
$Checkbox4 = GUICtrlCreateCheckbox("������", 250, 130, 65, 25)
$Checkbox5 = GUICtrlCreateCheckbox("������", 320, 130, 65, 25)
$Checkbox6 = GUICtrlCreateCheckbox("������", 40, 170, 65, 25)
$Checkbox7 = GUICtrlCreateCheckbox("������", 110, 170, 65, 25)
$Checkbox8 = GUICtrlCreateCheckbox("ÿ��", 180, 170, 50, 25)
$Label1 = GUICtrlCreateLabel("ʱ���趨��", 240, 175, 65, 25)
GUICtrlSetState($Checkbox8, $GUI_CHECKED)
$Date1 = GUICtrlCreateDate("", 290, 170, 80, 20, BitOR($DTS_UPDOWN,$DTS_TIMEFORMAT,$WS_TABSTOP));ʱ��ѡ��ؼ�
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("�ػ�������Ĭ��ǿ��������", 20, 210, 380, 50)
GUICtrlSetColor(-1,0x666666)
$Radio1 = GUICtrlCreateRadio("����", 60, 230, 65, 25)
$Radio2 = GUICtrlCreateRadio("�ػ�", 140, 230, 65, 25)
$Radio3 = GUICtrlCreateRadio("ǿ������", 210, 230, 65, 25)
$Radio4 = GUICtrlCreateRadio("ǿ�ƹػ�", 285, 230, 65, 25)
GUICtrlSetState($Radio3, $GUI_CHECKED)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group3 = GUICtrlCreateGroup("", 20, 13, 380, 90)
$Label2 = GUICtrlCreateLabel("�ػ����֡�Сվ��", 140, 0, 120, 17)
GUICtrlSetColor(-1,0xbb0033);����������ɫ
$Label3 = GUICtrlCreateLabel("", 290, 0, 108, 18)
GUICtrlSetColor(-1,0x440011)
$Label4 = GUICtrlCreateLabel("ÿ�ܣ�", 30, 30, 360, 30)

$Label5 = GUICtrlCreateLabel("ÿ�죺", 30, 50, 100, 20)

$Label6 = GUICtrlCreateLabel("ִ�У�", 30, 70, 80, 20)

GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button1 = GUICtrlCreateButton("Ӧ���趨", 120, 270, 65, 25)
GUICtrlSetColor(-1,0x110033)
$Button2 = GUICtrlCreateButton("�����趨", 250, 270, 65, 25)
GUICtrlSetColor(-1,0x110033)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group4 = GUICtrlCreateGroup("", 20, 295, 380, 75)
$Button3 = GUICtrlCreateButton("��������", 27, 310, 65, 25)
$Button4 = GUICtrlCreateButton("�������", 102, 310, 65, 25)
$Button5 = GUICtrlCreateButton("��������", 177, 310, 65, 25)
$Button6 = GUICtrlCreateButton("�رջ���", 252, 310, 65, 25)
$Button7 = GUICtrlCreateButton("��������", 327, 310, 65, 25)
$Button8 = GUICtrlCreateButton("���ش���", 27, 340, 65, 25)
$Button9 = GUICtrlCreateButton("�Զ���½", 102, 340, 65, 25)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
HotKeySet("^!f", "hotkey")
Opt("TrayAutoPause",0)
If RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","ʱ��") <> "" Then;��ȡע���ָ����ֵ
        Opt("TrayMenuMode",0)
                Opt("TrayIconHide",0) 
        
EndIf

While 1
        $Tray = TrayGetMsg();�õ�һ��ϵͳ����ͼ����Ŀ�������¼�.
        $msg = GUIGetMsg(1);���񴰿���
        Select
        Case $msg[0] = $GUI_EVENT_CLOSE And $msg[1] = $Form0;������µ���$GUI_EVENT_CLOSE(�ر�)
                Exit
                Case $msg[0] = $Button3
                RegRun();����Func RegRun()�趨�¼�
                MsgBox(0,"��ܰ������:","�Ѿ���ע���д�뿪��������,�����ƶ������򵽱��λ��.")
                Case $msg[0] = $Button4
                RegDelete("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run","��ʱ����")
                        MsgBox(0,"��ܰ������:","�����Զ������Ѵ�ע������Ƴ�")        
        Case $msg[0] = $Button5
                Shutdown(1);�ػ�
        Case $msg[0] = $Button6
                Shutdown(2);����        
                Case $msg[0] = $Button7
                MsgBox(32,"��ܰ������:","���򿪷���!")        
                Case $msg[0] = $Button8
                Opt("TrayIconHide", 1) ;����������ͼ��
                                Opt("TrayMenuMode",1)
                                GUISetState(@SW_HIDE,$Form0)
                Case $msg[0] = $Button9
                                Run("rundll32.exe netplwiz.dll,UsersRunDll") 
                                Run("control userpasswords2")
        Case $msg[0] = $GUI_EVENT_MINIMIZE;�Ի��򴰿ڱ���С��
                Opt("TrayMenuMode",1)
                GUISetState(@SW_HIDE,$Form0)
                TrayTip("�ػ�����","�����ԭ!",5,1)
        Case $msg[0] = $Button2
                RegDelete("HKEY_LOCAL_MACHINE\SOFTWARE\TIME")
                GUICtrlSetData($Label4,"ִ��ʱ��: ��ʱδ���ö�ʱ����")
                TrayTip("֪ͨ","��ǰ�����Ѿ��������,�������趨.",1,2)
                Case $msg[0] = $Button1
                                RegDelete("HKEY_LOCAL_MACHINE\SOFTWARE\TIME")
        $SET = GUICtrlRead($Date1)
                        If StringLen($SET) = 7 Then
                        $SET = "0"&$SET
            EndIf
                        If GUICtrlRead($Radio1,0)=1 Then
                                $S1="����"
                        ElseIf GUICtrlRead($Radio2,0)=1 Then
                                $S1="�ػ�"                                
                        ElseIf GUICtrlRead($Radio3,0)=1 Then
                                $S1="ǿ������"
                        ElseIf GUICtrlRead($Radio4,0)=1 Then
                                $S1="ǿ�ƹػ�"        
                        ElseIf GUICtrlRead($Radio1,0)<>1 Or GUICtrlRead($Radio2,0)<>1 Or GUICtrlRead($Radio3,0)<>1 Or GUICtrlRead($Radio3,0)<>1 Then
                                $S1="ǿ������"                
                        EndIf
                $W1=GUICtrlRead($Checkbox1,1)
                $W2=GUICtrlRead($Checkbox2,0)
                $W3=GUICtrlRead($Checkbox3,0)
                $W4=GUICtrlRead($Checkbox4,0)
                $W5=GUICtrlRead($Checkbox5,0)
                $W6=GUICtrlRead($Checkbox6,0)
                $W7=GUICtrlRead($Checkbox7,0)
                $W8=GUICtrlRead($Checkbox8,0)        
                ToolTip("1" & $W1 & "2" & $W2 & "3"  & $W3 & "4" & $W4 & "5"& $W5&  "6"& $W6 & "7"& $W7& "8" & $W8 & "......",0,0)
                Sleep(1000)
                If $W8=1 And ($W1=1 Or $W2=1 Or $W3=1 Or $W4=1 Or $W5=1 Or $W6=1 Or $W7=1 ) then
                    $WEEK8="ÿ��"
                        RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","ÿ��","REG_SZ",$WEEK8)         
                Else
                        $WEEK8="ÿ��"                
                        RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","ÿ��","REG_SZ",$WEEK8) 
                EndIf
                 If $W1=1 Then
                        $WEEK1="����һ"
                        RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","����һ","REG_SZ",$WEEK1) 
                  EndIf
                  If $W2=1 Then
                        $WEEK2="���ڶ�"
                        RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","���ڶ�","REG_SZ",$WEEK2) 
                  EndIf
                  If  $W3=1 Then
                        $WEEK3="������"
                        RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","������","REG_SZ",$WEEK3) 
                  EndIf
                 If  $W4=1 Then 
                    $WEEK4="������"
                        RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","������","REG_SZ",$WEEK4) 
                  EndIf
                 If $W5=1 Then
                    $WEEK5="������"
                        RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","������","REG_SZ",$WEEK5) 
                  EndIf
                 If $W6=1=1 Then
                    $WEEK6="������"
                        RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","������","REG_SZ",$WEEK6) 
                 EndIf
                 If $W7=1=1 Then
                    $WEEK7="������"
                        RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","������","REG_SZ",$WEEK7)                         
                 EndIf
                
                RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","ʱ��","REG_SZ",$SET)
                RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","�¼�","REG_SZ",$S1)
                
                
                TrayTip("֪ͨ","�Ѿ��趨���!����رճ���,�����趨����������.",1,2)
EndSelect
                
        Switch $Tray
                Case $TRAY_EVENT_PRIMARYDOWN;������������
                        GUISetState(@SW_SHOW);����ָ�����ڲ�ʹ���Ե�ǰ��С��λ����Ϣ��ʾ
        EndSwitch
        $T1 = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","ʱ��")
        $R0 = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","�¼�")
                $WK1 = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","����һ") 
                $WK2 = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","���ڶ�") 
                $WK3 = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","������") 
                $WK4 = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","������") 
                $WK5 = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","������") 
                $WK6 = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","������") 
                $WK7 = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","������") 
                $WK8 = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","ÿ��") 
                
        If $T2 <> $T1 Or $R0 <> $R1 Then;"<>"�Ƚ��Ƿ����,����ȸñ�ﷵ��1���򷵻�0
                $R1 = $R0
                $T2 = $T1
                                If $WK8="ÿ��" Then 
                                GUICtrlSetData($Label4,"ÿ��:"&$WK8&"  "&$T1&"("&$R0&")")
                                Else
                GUICtrlSetData($Label4,"ÿ��: "&$WK1&" "&$WK2&" "&$WK3&" "&$WK4&" "&$WK5&" "&$WK6&" "&$WK7&"  "&$T1&"("&$R0&")")
                                EndIf
        EndIf
        $T3 = @HOUR&":"&@MIN&":"&@SEC;$T3���ڵ�ǰʱ��
        If $T3 <> $T4 then
                $T4 = $T3
                GUICtrlSetData($Label3,""&@MON&"��"&@MDAY&"�� "&@HOUR&":"&@MIN&":"&@SEC&"  ");�޸�ָ���ؼ����������
        EndIf
        If $T1 = $T3 Then
                If $R0 = "�ػ�" Then;��ȡע���ֵ,��$ROֵ��������б�"�ػ�"ʱ,��ִ��$RNOW = 1
                        $RNOW = 1;�ػ��¼�
                ElseIf $R0 = "����" Then
                        $RNOW = 2;�����¼�
                ElseIf $R0 = "����" Then
                        $RNOW = 32;�����¼�
                ElseIf $R0 = "����" Then
                        $RNOW = 64;�����¼�
                ElseIf $R0 = "ǿ�ƹػ�" Then
                        $RNOW = 5;ǿ�йػ�
                ElseIf $R0 = "ǿ������" Then
                        $RNOW = 6;ǿ������
                EndIf
                Shutdown($RNOW);shutdown�ػ��¼�
        EndIf
        If RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\TIME","ʱ��") <> "" Then
        $T5 = StringReplace($T1,":","");�滻�ַ����е�ָ���Ӵ�
        $T6 = StringReplace($T3,":","")
        If StringMid($T5,1,2)-StringMid($T6,1,2) = 0 Then
                If StringMid($T5,3,2) - StringMid($T6,3,2) = 0  Then
                        If $T5-$T6 > 0 Then
                        TrayTip("��ܰ������:","����"&$T5-$T6&"�뿪ʼִ�йػ�����.....",10,1)
                        EndIf
                Elseif StringMid($T5,3,2)-StringMid($T6,3,2) = 1  Then
                If StringMid($T5,5,2)+60-StringMid($T6,5,2) > 0 Then
                TrayTip("��ܰ������:","����"&StringMid($T5,5,2)+60-StringMid($T6,5,2)&"�뿪ʼִ�йػ�����.....",10,1)
                EndIf
        EndIf
EndIf
EndIf
WEnd

Func RegRun();�޸�ע���,��ӳ��򿪻���������
dim $Run='HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run'
RegWrite($Run,'��ʱ����','REG_SZ',@AutoItExe);@AutoItExe��ǰ�ű�������·��.
EndFunc;

Func hotkey()
Opt("TrayIconHide", 0) ;����������ͼ��
Opt("TrayMenuMode",0)
GUISetState(@SW_SHOW,$Form0)
EndFunc;