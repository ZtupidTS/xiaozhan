#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_outfile=..\..\���Խű�\ɾ��ͼƬ(�޸�)����.exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")
Local $Paused,$k=0 ,$a=0

;$a = IniRead ( @ScriptDir & "\myfile.ini", "����", "����" ,"")
;��ʱ������һ����   7500��ͼƬ ��937�� �ֶ���4��
MsgBox ( 1, "��ʾ", "��Ѳ鿴ͼƬ���ڴ򿪣�������DVR�����ͼƬ" ,10)
WinActivate ("Centaurus")
#cs
send("!v")
send("{down 3}")
send("{enter}")
#ce
$i = 0
Do
WinActivate ("Centaurus")
;MouseClick ( "left" , 496, 138, 1, $k)
ControlClick ( "Centaurus", "�鿴ץ֡ͼƬ", "TToolBar6", "left", 1,210, 12)
ControlClick ( "Centaurus", "�鿴ץ֡ͼƬ", "TToolBar4", "left", 1,210, 12)

Sleep(1000)
If  WinExists("Centaurus", "��(&Y)") Then
     send("{enter}")
	 $a = IniRead ( @ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����" ,"")
	 IniWrite(@ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����", $a+1) 
 endif
 Sleep(1000)
If  WinExists("Centaurus", "ȷ��") Then
	 send("{enter}")
elseif Not WinExists("Centaurus", "ȷ��")  then
	$a = IniRead ( @ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����" ,"")
	MsgBox ( 0, "����", "����:   "  &  $a)
endif



$i = $i + 1
Until $i = 937



Func Terminate()
    $a = IniRead ( @ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����" ,"")
    MsgBox ( 0, "����", "����:   "  &  $a)	
	Exit 0
EndFunc

Func Togglepause()
    $Paused = NOT $Paused 
	
   While $Paused 
	tooltip("��ͣһ��",0,0)
	sleep(100)
   tooltip("")
   WEnd
EndFunc