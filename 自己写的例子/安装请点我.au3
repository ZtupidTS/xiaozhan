HotKeySet("!1", "ShowMessage")          ;ALT+a ע�ͷ��ţ�����
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z


Run(@scriptdir & "\setup.exe")
$title=IniRead(@scriptdir & "\��װ·��.ini","title","title","")
WinWait ( "��װ - ��ŵ������������(������)V3.28", "��һ��(&N) >")
ControlClick("��װ - ��ŵ������������(������)V3.28","��һ��(&N) >","[CLASS:TButton; INSTANCE:1]")
BlockInput(1)
Send ($title) 
BlockInput(0)
ControlClick("��װ - ��ŵ������������(������)V3.28","��һ��(&N) >","[CLASS:TButton; INSTANCE:3]")
If WinActive("�ļ��д���","��(&Y)") Then
    ControlClick("�ļ��д���","��(&Y)","[ID:6]")	
EndIf
ControlClick("��װ - ��ŵ������������(������)V3.28","��һ��(&N) >","[CLASS:TButton; INSTANCE:4]")
ControlClick("��װ - ��ŵ������������(������)V3.28","��һ��(&N) >","[CLASS:TButton; INSTANCE:4]")
ControlClick("��װ - ��ŵ������������(������)V3.28","��װ(&I)","[CLASS:TButton; INSTANCE:4]")
BlockInput(1)
Sleep(10*1000)
BlockInput(0)
If WinExists("ȷ��","��(&N)") Then
   ControlClick("ȷ��","��(&N)","[ID:7]")	
EndIf

Sleep(1000)

If WinExists("ȷ��","��(&N)") Then
   ControlClick("ȷ��","��(&N)","[ID:7]")	
EndIf

WinWait("��װ - ��ŵ������������(������)V3.28","���(&F)")
ControlClick("��װ - ��ŵ������������(������)V3.28","���(&F)","[CLASS:TButton; INSTANCE:4]")
WinWait("��ŵ������������","ע��(&R)")
WinActivate ("��ŵ������������","ע��(&R)")
WinClose("��ŵ������������")

FileCopy ( "��ŵ������������(������)V3.28+ע���.exe",$title,1 )
FileCopy ( "��ŵ������������(������)V3.28+����.exe",$title,1 )
Sleep(1000)
ShellExecute("��ŵ������������(������)V3.28+����.exe","",$title)
WinWait("��ŵ������������(������)V3.28+����","Ӧ�ò���")
ControlClick("��ŵ������������(������)V3.28+����","Ӧ�ò���","[ID:108]")
Sleep(1000)
WinClose("��ŵ������������(������)V3.28+����","Ӧ�ò���")



ShellExecute("��ŵ������������(������)V3.28+ע���.exe","",$title)
BlockInput(1)
Sleep(2000)
Send("{enter}")
BlockInput(0)
WinWait("��ŵ������������","ע��(&R)")
ControlClick("��ŵ������������","ע��(&R)","[CLASS:TBitBtn; INSTANCE:2]")
WinWait("���ע��")
ControlClick("���ע��","ע��(&R)","[CLASS:TBitBtn; INSTANCE:3]")

BlockInput(1)
Send("^c")
Send("{enter}")
BlockInput(0)
ControlClick("���ע��","ȷ��","[ID:2]")
ControlClick("���ע��","�˳�(&Q)","[CLASS:TBitBtn; INSTANCE:1]")
WinClose("��ŵ������������")

Sleep(2000)
ShellExecute("jxc.exe","",$title)
WinWait("��ŵ������������","ע��(&R)")
ControlClick("��ŵ������������","ע��(&R)","[CLASS:TBitBtn; INSTANCE:2]")
WinWait("���ע��")
BlockInput(1)
Send("{tab}")
Send("^v")
BlockInput(0)
ControlClick("���ע��","ע��(&R)","[CLASS:TBitBtn; INSTANCE:3]")
ControlClick("���ע��","ȷ��","[ID:2]")
ControlClick("��ŵ������������","�˳�(&Q)","[CLASS:TBitBtn; INSTANCE:1]")


;[title]
;title=0
;FileCopy ( "ThunderUI.xml","E:\Program Files\Thunder Network\Thunder\Program",1 )


Func ShowMessage()   ;Func����˼�����Զ��庯��
    Dim $i=MsgBox(1,"�˳��ű�","ȷ���˳��ű���")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc

;#Include <WinAPIEx.au3>
;_WinAPI_EnumChildWindows( $hWnd[, $fVisible] )