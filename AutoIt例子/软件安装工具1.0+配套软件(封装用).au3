#NoTrayIcon
#include <GUIConstants.au3>
#include <WindowsConstants.au3>
Opt("TrayOnEventMode", 1)
Opt("guicloseonesc", 0)
;����Ϊ��������ļ�����
$soft_ini = FileOpen("Soft.ini", 0)
If $soft_ini = -1 Then
MsgBox(16, "����", '���������ļ�' & @ScriptDir & '\"Soft.ini"�Ƿ����!') ;@ScriptDirΪ�ű�����Ŀ¼
Exit
EndIf
$chars = FileReadLine($soft_ini, 2)
If $soft_ini <> -1 Then
If $chars <> ";����������г��QQ:918766818" Then
  MsgBox(16, "����", "�뱣�����ߵ���Ϣ��" & @CRLF & "���򣬳����ܼ������У�")
  MsgBox(64, "�뱣�����ߵ���Ϣ", '���ߵ���ϢΪ��' & @CRLF & ';����������г��QQ:918766818' & @CRLF & '�㼺���޸�Ϊ��' & @CRLF & $chars)
  Exit
EndIf
EndIf
FileClose($soft_ini)
;����Ϊ��������ͳ���
Const $N = 11, $s = 5
Dim $softname[$N], $softPath[$N], $soft[$N], $radio[$s], $InstallPath
;����Ϊ��ȡsoft.ini�����ļ��ĺ���
$title = IniRead("soft.ini", "form", "title", "")
$top_pic = IniRead("soft.ini", "form", "Top_pic", "")
$time = IniRead("soft.ini", "form", "time", "")
$state = IniRead("soft.ini", "form", "state", "")
;����Ϊ���δ������ļ���ȡ�������·����ѭ��
For $i = 0 To $N - 1
$softname[$i] = IniRead("soft.ini", $i, "softname", "��")
$softPath[$i] = IniRead("soft.ini", $i, "softpath", "��")
;msgbox(4096,"���Ա�������",$softname[$i]&$softPath[$i])
Next
;����Ϊ����������
$form = GUICreate($title, 480, 360, -1, -1)
$top_pic = GUICtrlCreatePic($top_pic, 0, 0, 480, 90)
$Group1 = GUICtrlCreateGroup("", 10, 90, 460, 120)
;��GUI�ϴ���10����ѡ��Checkbox���ؼ���������ƴ������ļ����ȡ
$soft[1] = GUICtrlCreateCheckbox("&1 " & $softname[1], 15, 100, 225, 20)
$soft[2] = GUICtrlCreateCheckbox("&2 " & $softname[2], 15, 120, 225, 20)
$soft[3] = GUICtrlCreateCheckbox("&3 " & $softname[3], 15, 140, 225, 20)
$soft[4] = GUICtrlCreateCheckbox("&4 " & $softname[4], 15, 160, 225, 20)
$soft[5] = GUICtrlCreateCheckbox("&5 " & $softname[5], 15, 180, 225, 20)
$soft[6] = GUICtrlCreateCheckbox("&6 " & $softname[6], 240, 100, 225, 20)
$soft[7] = GUICtrlCreateCheckbox("&7 " & $softname[7], 240, 120, 225, 20)
$soft[8] = GUICtrlCreateCheckbox("&8 " & $softname[8], 240, 140, 225, 20)
$soft[9] = GUICtrlCreateCheckbox("&9 " & $softname[9], 240, 160, 225, 20)
$soft[10] = GUICtrlCreateCheckbox("&0 " & $softname[10], 240, 180, 225, 20)
For $i = 0 To $N - 1
$start1 = GUICtrlSetState($soft[$i], $GUI_DISABLE)
Next
$Group2 = GUICtrlCreateGroup("��װ��ʽ", 10, 215, 200, 70)
;�������ļ����ȡ��װ������
$setA = IniRead("soft.ini", "select", "A", "")
$chooseA = IniRead("soft.ini", "select", "ChooseA", "")
$setB = IniRead("soft.ini", "select", "B", "")
$chooseB = IniRead("soft.ini", "select", "ChooseB", "")
$setC = IniRead("soft.ini", "select", "C", "")
$chooseC = IniRead("soft.ini", "select", "ChooseC", "")
$setD = IniRead("soft.ini", "select", "D", "")
$chooseD = IniRead("soft.ini", "select", "ChooseD", "")
;����4����ѡ��ť,���ƴ������ļ����ȡ
$radio[1] = GUICtrlCreateRadio($setA & "(&A)", 20, 230, 70, 20)
$radio[2] = GUICtrlCreateRadio($setB & "(&B)", 20, 260, 70, 20)
$radio[3] = GUICtrlCreateRadio($setC & "(&C)", 120, 230, 70, 20)
$silent = GUICtrlSetState($radio[3], $GUI_CHECKED)
$silent = propose()
$radio[4] = GUICtrlCreateRadio($setD & "(&D)", 120, 260, 70, 20)
For $i = 0 To $s - 1
$start2 = GUICtrlSetState($radio[$i], $GUI_DISABLE)
Next
$Group3 = GUICtrlCreateGroup("��װĿ¼", 215, 215, 255, 70)
$InstallPath = "C:\Program Files"
$input1 = GUICtrlCreateInput($InstallPath, 220, 245, 160, 20)
$start3 = GUICtrlSetState($input1, $GUI_DISABLE)
$Button1 = GUICtrlCreateButton("���(&O)", 400, 245, 60, 20)
$start4 = GUICtrlSetState($Button1, $GUI_DISABLE)
$Labtime = GUICtrlCreateLabel("", 10, 295, 165, 20, $WS_EX_STATICEDGE)
$pro = GUICtrlCreateProgress(10, 310, 280, 20)
$Button2 = GUICtrlCreateButton("�ֶ�ѡ��(&X)", 300, 310, 80, 20)
$Button3 = GUICtrlCreateButton("��ʼ��װ(&S)", 390, 310, 80, 20)
$copyright = GUICtrlCreateLabel("������ռ�����̳(Http://Www.FreeSkyCD.Cn/)", 220, 345, 300, 20)
$start5 = GUICtrlSetState($copyright, $GUI_DISABLE)
If $state = 1 Or $state = "" Then
GUISetState(@SW_SHOW)
ElseIf $state = 0 Then
GUISetState(@SW_HIDE)
EndIf
;����Ϊ����ʱ����
AdlibEnable("pro1", 10 * $time)
$wait = 0
Func pro1()
$start6 = GUICtrlSetData($pro, $wait)
For $v = 0 To $time Step 1
  If GUICtrlRead($pro) = $v * 10 / ($time / 10) Then GUICtrlSetData($Labtime, $time - $v & "����Զ���װ��ѡ��")
Next
$wait = $wait + 1
If $wait = 101 Then AZ()
EndFunc   ;==>pro1
;����Ϊ���ô����¼�
While 1
$nMsg = GUIGetMsg()
Select
  Case $nMsg = $GUI_EVENT_CLOSE
   AdlibDisable()
   ExitLoop
  Case $nMsg = $radio[1] And BitAND(GUICtrlRead($radio[1]), $GUI_CHECKED) = $GUI_CHECKED
   $all = all()
  Case $nMsg = $radio[2] And BitAND(GUICtrlRead($radio[2]), $GUI_CHECKED) = $GUI_CHECKED
   $none = none()
  Case $nMsg = $radio[3] And BitAND(GUICtrlRead($radio[3]), $GUI_CHECKED) = $GUI_CHECKED
   $propose = propose()
  Case $nMsg = $radio[4] And BitAND(GUICtrlRead($radio[4]), $GUI_CHECKED) = $GUI_CHECKED
   $small = small()
  Case $nMsg = $Button1
   $open = open()
  Case $nMsg = $Button2
   $XZ = XZ()
  Case $nMsg = $Button3
   $AZ = AZ()
EndSelect
WEnd
;ȫ��ѡ��
Func all()
AdlibDisable()
For $i = 0 To $N - 1
  If $softname[$i] And $softPath[$i] <> "" Then
   GUICtrlSetState($soft[$i], $GUI_CHECKED)
  Else
   GUICtrlSetState($soft[$i], $GUI_UNCHECKED)
  EndIf
Next
EndFunc   ;==>all
;ȫ����ѡ
Func none()
AdlibDisable()
For $i = 0 To $N - 1
  If $softname[$i] And $softPath[$i] <> "" Then
   GUICtrlSetState($soft[$i], $GUI_UNCHECKED)
  Else
   GUICtrlSetState($soft[$i], $GUI_UNCHECKED)
  EndIf
Next
EndFunc   ;==>none
;�Ƽ���װ
Func propose()
AdlibDisable()
For $i = 0 To $N - 1
  If StringInStr(String($chooseC), $i) Then
   If $softname[$i] And $softPath[$i] <> "" Then
    GUICtrlSetState($soft[$i], $GUI_CHECKED)
   Else
    GUICtrlSetState($soft[$i], $GUI_UNCHECKED)
   EndIf
  Else
   GUICtrlSetState($soft[$i], $GUI_UNCHECKED)
  EndIf
Next
EndFunc   ;==>propose
;���ٰ�װ
Func small()
AdlibDisable()
none()
For $i = 0 To $N - 1
  If StringInStr(String($chooseD), $i) Then
   If $softname[$i] And $softPath[$i] <> "" Then
    GUICtrlSetState($soft[$i], $GUI_CHECKED)
   Else
    GUICtrlSetState($soft[$i], $GUI_UNCHECKED)
   EndIf
  EndIf
Next
EndFunc   ;==>small
;���ð�װĿ¼
Func open()
AdlibDisable()
$InstallPath = FileSelectFolder("ѡ��װĿ¼", "")
If Not @error Then
  If StringRight($InstallPath, 1) = "\" Then
   GUICtrlSetData($input1, $InstallPath & "")
  Else
   GUICtrlSetData($input1, $InstallPath & "\")
  EndIf
  ;MsgBox(4096, "����", $InstallPath)
EndIf
EndFunc   ;==>open
;����ѡ��
Func XZ()
AdlibDisable()
GUICtrlSetData($Labtime, "*�ֶ�ѡ��*")
For $i = 0 To $N - 1
  GUICtrlSetState($soft[$i], $GUI_ENABLE)
  GUICtrlSetState($input1, $GUI_ENABLE)
  GUICtrlSetState($Button1, $GUI_ENABLE)
  GUICtrlSetState($radio[1], $GUI_ENABLE)
  GUICtrlSetState($radio[2], $GUI_ENABLE)
  GUICtrlSetState($radio[3], $GUI_ENABLE)
  GUICtrlSetState($radio[4], $GUI_ENABLE)
Next
EndFunc   ;==>XZ
;���ð�װ
Func AZ()
AdlibDisable()
GUICtrlSetData($Labtime, "*��װ��ѡ*")
For $i = 0 To $N - 1
  If $softPath[$i] <> "" And GUICtrlRead($soft[$i]) = $GUI_CHECKED Then
   RunWait(@ScriptDir & "\" & $softPath[$i] & " " & $InstallPath)
   ;MsgBox(4096, "����",@ScriptDir & "\" & $softPath[$i]&$InstallPath)
  Else
   GUICtrlSetState($soft[$i], $GUI_DISABLE)
  EndIf
Next
Exit
EndFunc   ;==>AZ