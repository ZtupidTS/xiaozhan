;hotKeySet("!a", "ShowMessage")          ;ALT+a ע�ͷ��ţ�����
;HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z
#include <GUIConstants.au3> 
GUICreate ( "���� - wglm.net", 200, 60) 
GUISetState (@SW_SHOW) 
GUICtrlCreateLabel("��ӭ����ң��������µĲ���",10,10,190,15) 
GUICtrlCreateLabel("���ϵͳ�Ѿ�����װ���µĲ����ˡ�",10,25,190,35) 
;While 1 
;$msg = GUIGetMsg() 
;If $msg = $GUI_EVENT_CLOSE Then ExitLoop 
;Wend 
;Func ShowMessage()   ;Func����˼�����Զ��庯��
  Dim $i=MsgBox(1,"����ϵͳ��","ȷ������ϵͳ������������ù������°�װϵͳ����Ϊ���Ѿ�ɾ���������������ghost�ļ���ISO�ļ�")
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
While 1 
$msg = GUIGetMsg() 
if $GUI_EVENT_MINIMIZE Then ExitLoop 
Wend