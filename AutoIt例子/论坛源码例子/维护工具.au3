#NoTrayIcon        ;��ֹϵͳ֪ͨ����ϵͳ���̣����ֱ�����ͼ��
#cs
ACN��̳hynq2000�����ܹ�����̳�Ϊ���壬�����޸�
�޸�ԭ��
1�����龡����ʹ���¼�ģʽ���¼�ģʽ�£����󲿷ֲ������������ִ�нű��е���һ����������ȴ���ǰ������ɡ�
2�����ÿ�������ļ�Ҳ���Ǳ����õ�RUNDOS�����������������������ִ����Ӧ��������ļ���
3����Ȼ�����ܹ����䣬��Ȼ���������������ã����Ե��Ӹ�������ƣ�KiwiCsj�����ṩ�򵥼����뷽����
3��������hynq2000����˵���Ǽ򵥽̳̣����Դ�Ϊ˼·��չ���������ɸ���˼·�Ӻ���������в�ѯ��
    a,��ع��ܿ��Գ���ʹ���Ҽ��˵�����֮������ÿ�������������һ����ť�ڽ�����
        b,...����æ�ˣ��������ɣ�˼·����������ģ�ֻҪ��Ը�⣬Au3Ҳ���԰���Ѻܶ����ʵĻ����������
#ce
Opt("GUIOnEventMode", 1)        ;����ʹ���¼�ģʽ
#include <GUIConstants.au3> 
;~ #include <Process.au3>        ;ûʹ��_RunDos����������Բ���
 
_KiwiCsjOPSSWD()        ;����������
 
#Region ### START Koda GUI section ### Form= 
$Form1 = GUICreate("ά�����߲���1B", 315, 204, 278, 206) 
$Button1 = GUICtrlCreateButton("ϵͳ����", 8, 8, 75, 25, 0) 
$Button2 = GUICtrlCreateButton("��ʾ����", 8, 56, 75, 25, 0) 
$Button3 = GUICtrlCreateButton("���̹���", 8, 104, 75, 25, 0) 
$Button4 = GUICtrlCreateButton("�������", 112, 8, 75, 25, 0) 
$Button5 = GUICtrlCreateButton("������", 112, 56, 75, 25, 0) 
$Button6 = GUICtrlCreateButton("ע���", 112, 104, 75, 25, 0) 
$Button7 = GUICtrlCreateButton("Msconfig", 216, 56, 75, 25, 0) 
$Button8 = GUICtrlCreateButton("��������", 216, 104, 75, 25, 0) 
$Button9 = GUICtrlCreateButton("������", 216, 8, 75, 25, 0) 
$Input1 = GUICtrlCreateInput("", 8, 148, 121, 25) 
$Button10 = GUICtrlCreateButton("����", 144, 148, 43, 25, 0) 
$Button11 = GUICtrlCreateButton("ʱ������", 216, 144, 75, 25, 0) 
GUICtrlCreateLabel("", 184, 176, 4, 4) 
$Label1 = GUICtrlCreateLabel("Сվ������2009/9", 176, 186, 132, 17) 
GUISetState(@SW_SHOW) 
#EndRegion ### END Koda GUI section ### 
;######### �����¼����� ʼ ###########
GUISetOnEvent($GUI_EVENT_CLOSE, "kc_exit")        ;�����رղ���Ҫ���õĺ���
GUICtrlSetOnEvent($Button1, "KcTask")                ;����ÿ����ť����Ҫ���õĺ���
GUICtrlSetOnEvent($Button2, "KcTask")
GUICtrlSetOnEvent($Button3, "KcTask")
GUICtrlSetOnEvent($Button4, "KcTask")
GUICtrlSetOnEvent($Button5, "KcTask")
GUICtrlSetOnEvent($Button6, "KcTask")
GUICtrlSetOnEvent($Button7, "KcTask")
GUICtrlSetOnEvent($Button8, "KcTask")
GUICtrlSetOnEvent($Button9, "KcTask")
GUICtrlSetOnEvent($Button10, "KcTask")
GUICtrlSetOnEvent($Button11, "KcTask")
GUICtrlSetOnEvent($Label1, "KcTask")                ;����Ҳ�����������ʱ�ɵ��õĺ���
;######### �����¼����� �ϣ�������ѭ�� ###########
While 1 
        Sleep(1)
WEnd
;######### �Զ���һЩǰ��Ҫ�õ��ĺ��� ###########
 
Func KcTask()        ;��������ϵİ�ť����� �����¼�ģʽ����
        Switch @GUI_CtrlId
                Case $Button1 
                                Run(@SystemDir&"\control.exe sysdm.cpl")        ;��ϵͳ���� 
                Case $Button2 
                                Run(@SystemDir&"\control.exe desk.cpl")                ;����ʾ���� 
                Case $Button3 
                                Run(@SystemDir &"\taskmgr.exe")                                ;�����������        
                Case $Button4 
                                Run(@SystemDir &"\control.exe")                                ;�򿪿������        
                Case $Button5 
                                Run(@SystemDir &"\cmd.exe")                                        ;�������� 
                Case $Button6 
                                Run(@WindowsDir &"\regedit.exe")                        ;��ע��� 
                Case $Button7 
                                Run("C:\WINDOWS\pchealth\helpctr\binaries\Msconfig.exe");��msconfig 
                Case $Button8 
                                Run(@SystemDir &"\Sndvol32.exe")                        ;���������Ƴ��� 
                Case $Button9 
                                ShellExecute(@SystemDir &"\gpedit.msc")                ;�򿪲�����  ��һ��д��Run(@ComSpec&' /c gpedit.msc',@SystemDir,@SW_HIDE) 
                Case $Button10 
                                Run(@ComSpec &" /c "&GUICtrlRead($input1))        ;�����������Ʒ�Ĺؼ� ��ȡ�ı����������Ȼ������ 
                Case $Button11 
                                Run(@SystemDir&"\control.exe timedate.cpl")        ;��ʱ������ 
                Case $Label1         
                                Run(@ProgramFilesDir&"\Internet Explorer\IEXPLORE.EXE [url]http://www.autoit.net.cn/space.php?uid=418&sid=NEZ90P[/url]")
        EndSwitch
EndFunc ;==> KcTask
 
Func _KiwiCsjOPSSWD()        ;����������
        $kcps = "123456"        ;�������룬����б�Ҫ���㻹�������ñ�İ취�ظ�����һ��
        $input=InputBox("Ը�������¹���", "��ش���", "", ".",220,120,-1,-1,16)        ;�о�һ��InputBox�ĺ��������Ĳ�����ֵ��һ�á�
        if @error=0 Then
                If $kcps <> $input Then
                        MsgBox (262144+32,"���ź�!!!","�벻�����ˣ�",9)
                        kc_exit()                ;�����˳�
                Else                                ;������ͨ��
                        $input=""
                EndIf
        ElseIf @error=1 Then
                kc_exit()
        ElseIf @error=2 Then 
                MsgBox (262144+32,"���ź�!!!","�ش����������ô��ô��",9)
                kc_exit()
        ElseIf @error=3 Then 
                MsgBox (262144+16,"�������!!!","�����������ʾʧ�ܣ������ԣ�",9)
                kc_exit()
        Else
                kc_exit()
        EndIf
EndFunc ;==> _KiwiCsjOPSSWD
 
Func kc_exit()        ;�˳�ʱ�Ķ�������
        Exit
EndFunc ;==> kc_exit