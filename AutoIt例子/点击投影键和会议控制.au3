#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_outfile=1.exe
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Change2CUI=y
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=cs 1 
#EndRegion ;**** ���������� ACNWrapper_GUI ****

HotKeySet("!a", "ShowMessage")          ;ALT+a ע�ͷ��ţ�����
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z

;$i = 0
;Do
;ControlClick( "FT-200W", "", "[ID:1000]")
;Sleep(5000) 
;ControlClick( "FT-200W", "", "[ID:1003]")
;Sleep(3000) 
;$i = $i + 1
;Until $i = 96000
While 1
ControlClick("FT-200W", "", "[ID:1000]", "left", 2, 24, 18)
Sleep(5000)
ExitLoop
WEnd

While 1
WinWait("FT-200W","")
ControlClick("FT-200W", "", "[ID:1000]", "left", 2, 24, 18)
Sleep(3000) 
ControlClick( "�������̨", "", "[ID:1057]", "left", 2, 93, 30)
Sleep(3000)
ControlClick( "�������̨", "", "[ID:1057]", "left", 2, 93, 47)
Sleep(3000)
;MouseClick("left", 1167, 763,2,100)
;Sleep(3000)
;MouseClick("left", 1158, 780,2,100)
;Sleep(6000)
ControlClick("FT-200W", "", "[ID:1000]", "left", 2, 24, 18)
Sleep(3000) 
WEnd


Func ShowMessage()   ;Func����˼�����Զ��庯��
    Dim $i=MsgBox(1,"�˳��ű�","ȷ���˳��ű���")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc
