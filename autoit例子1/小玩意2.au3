;HotKeySet("!a", "ShowMessage")          ;ALT+a ע�ͷ��ţ�����
;HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z
#include <GUIConstants.au3> 
GUICreate ( "���� - wglm.net", 200, 60) 
GUISetState (@SW_SHOW) 
GUICtrlCreateLabel("��ӭ����XX����",10,10,190,15) 
GUICtrlCreateLabel("���������ٹ��죬�뿴�ܺ�������Ʒ��",10,25,190,35) 
;While 1 
;$msg = GUIGetMsg() 
;If $msg = $GUI_EVENT_CLOSE Then ExitLoop 
;Wend 
;Func ShowMessage()   ;Func����˼�����Զ��庯��
  Dim $i=MsgBox(1,"�˳�����","ȷ���˳������������˽�һ�±����ɵ�ע������")
  if  $i<>2  Then
    Exit 0
  EndIf
;EndFunc
While 1 
$msg = GUIGetMsg() 
if $msg = $GUI_EVENT_CLOSE Then ExitLoop 
Wend 
;Func ShowMessage()   ;Func����˼�����Զ��庯��
  Dim $i=MsgBox(1,"�˳�����","ȷ���˳������������˽�һ�±����ɵ�ע������")
  if  $i<>2  Then
    Exit 0
  EndIf
;EndFunc
