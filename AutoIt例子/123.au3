
;--- AutoIt Macro Generator V 0.21 beta ---
HotKeySet("!a", "ShowMessage")          ;ALT+a ע�ͷ��ţ�����
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z

$i = 0
Do
Opt("WinTitleMatchMode", 4)
WinWait("FT-200W","")
;AutoIt supports no Owner drawn Buttons (or CheckBoxes, RadioButtons and Groupboxes: only ControlClick is possible...
ControlClick("FT-200W","","Button7")
WinWait("��","���ҷ�Χ(&I):")
$CLVItem = ControlListView("��","���ҷ�Χ(&I):","SysListView321","FindItem","Stormchasers_Demo.wmv")
ControlListView("��","���ҷ�Χ(&I):","SysListView321","SelectClear")
ControlListView("��","���ҷ�Χ(&I):","SysListView321","Select",$CLVItem)
ControlClick("��","���ҷ�Χ(&I):","Button2")
Sleep(60000)
WinWait("FT-200W","")
;AutoIt supports no Owner drawn Buttons (or CheckBoxes, RadioButtons and Groupboxes: only ControlClick is possible...
ControlClick("FT-200W","","Button7")
Sleep(5000)
$i = $i + 1
Until $i = 960
Func ShowMessage()   ;Func����˼�����Զ��庯��
    Dim $i=MsgBox(1,"�˳��ű�","ȷ���˳��ű���")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc

;--- End ---