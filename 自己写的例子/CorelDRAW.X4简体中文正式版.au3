#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=Preview_Extras.ico
#AutoIt3Wrapper_outfile=CorelDRAW.exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
HotKeySet("!1", "ShowMessage")          ;ALT+a ע�ͷ��ţ�����
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z


 Dim $i=MsgBox(1,"��װ��ʾ","��ѱ�����ŵ�CorelDRAW.X4����������ʽ�氲װ�ļ�����" & @CR & "��ȷ���������а�װ����" & @CR & "���ȡ���˳�����" & @CR & "ȷ��������ŵ�CorelDRAW.X4����������ʽ�氲װ�ļ������ڵ�ȷ��")
    if  $i<>1  Then
    Exit 0
	EndIf
Run(@scriptdir & "\autorun.exe")

;$sj=IniRead(@scriptdir & "\��װ·��.ini","sj","sj","")
;$mz=IniRead(@scriptdir & "\��װ·��.ini","mz","mz","")
;$xlh=IniRead(@scriptdir & "\��װ·��.ini","xlh","xlh","")
;$lj=IniRead(@scriptdir & "\��װ·��.ini","lj","lj","")

WinWait("CorelDRAW Graphics Suite X4")
Sleep(3000)
ControlClick("CorelDRAW Graphics Suite X4","",59648,"left",2,387, 145)
If WinExists("CorelDRAW Graphics Suite X4") Then
	$begin = TimerInit()
 Sleep(40000)
$dif = TimerDiff($begin)
   
EndIf

ControlClick("CorelDRAW Graphics Suite X4","","[CLASS:Internet Explorer_Server; INSTANCE:1]","left",1,37, 536)
ControlClick("CorelDRAW Graphics Suite X4","","[CLASS:Internet Explorer_Server; INSTANCE:1]","left",1,572, 575)



WinWait("CorelDRAW Graphics Suite X4")

Sleep(1000)
ControlClick("CorelDRAW Graphics Suite X4","","[CLASS:Internet Explorer_Server; INSTANCE:1]","left",3,107, 249)
Sleep(1000)
Send("xiaoxiao")
Sleep(1000)
ControlClick("CorelDRAW Graphics Suite X4","","[CLASS:Internet Explorer_Server; INSTANCE:1]","left",1,257, 297)
Sleep(1000)
Send("DR14B41DM4LD83SJ77AKMKDN7C4YFQ6SS")
Sleep(3000)
ControlClick("CorelDRAW Graphics Suite X4","","[CLASS:Internet Explorer_Server; INSTANCE:1]","left",1,585, 575)
ControlClick("CorelDRAW Graphics Suite X4","","[CLASS:Internet Explorer_Server; INSTANCE:1]","left",3,408, 496)
Send("e:\Corel\CorelDRAW Graphics Suite X4\")
Sleep(3000)
ControlClick("CorelDRAW Graphics Suite X4","","[CLASS:Internet Explorer_Server; INSTANCE:1]","left",1,343, 127)
ControlClick("CorelDRAW Graphics Suite X4","","[CLASS:Internet Explorer_Server; INSTANCE:1]","left",1,35, 208)
ControlClick("CorelDRAW Graphics Suite X4","","[CLASS:Internet Explorer_Server; INSTANCE:1]","left",1,38, 274)
ControlClick("CorelDRAW Graphics Suite X4","","[CLASS:Internet Explorer_Server; INSTANCE:1]","left",1,673, 575)


Func ShowMessage()   ;Func����˼�����Զ��庯��
    Dim $i=MsgBox(1,"�˳��ű�","ȷ���˳��ű���")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc

;#Include <WinAPIEx.au3>
;_WinAPI_EnumChildWindows( $hWnd[, $fVisible] )