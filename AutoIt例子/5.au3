#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_outfile_type=a3x
#AutoIt3Wrapper_outfile=1.a3x
#EndRegion ;**** ���������� ACNWrapper_GUI ****

HotKeySet("!a", "ShowMessage")          ;ALT+a ע�ͷ��ţ�����
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z


While 1
    MouseClick("left", 934, 533,2,100)
    Sleep(2000)
 WEnd

Func ShowMessage()   ;Func����˼�����Զ��庯��
    MsgBox(1,"�˳��ű�","ȷ���˳��ű���")
    Exit 0
   
EndFunc
