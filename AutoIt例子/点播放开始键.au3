#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_outfile=1.exe
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Change2CUI=y
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=cs 1 
#EndRegion ;**** ���������� ACNWrapper_GUI ****

HotKeySet("!a", "ShowMessage")          ;ALT+a ע�ͷ��ţ�����
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z

$i = 0
Do
ControlClick( "ý�岥����", "", "[ID:1065]")
;Sleep(3000) 
$i = $i + 1
Until $i = 96000
Func ShowMessage()   ;Func����˼�����Զ��庯��
    Dim $i=MsgBox(1,"�˳��ű�","ȷ���˳��ű���")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc
