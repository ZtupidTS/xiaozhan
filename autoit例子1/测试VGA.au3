#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=E:\AutoIt\Aut2Exe\Icons\strawberry.ico
#AutoIt3Wrapper_outfile=1.exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****

HotKeySet("!a", "ShowMessage")          ;ALT+a ע�ͷ��ţ�����
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z

While 1
    MouseClick("left", 1179, 771,2,100)
    Sleep(8000)
    MouseClick("left", 1171, 787,2,100)
    Sleep(5000)
 WEnd

Func ShowMessage()   ;Func����˼�����Զ��庯��
    Dim $i=MsgBox(1,"�˳��ű�","ȷ���˳��ű���")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc
