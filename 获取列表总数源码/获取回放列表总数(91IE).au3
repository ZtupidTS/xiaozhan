#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=..\����\�ۺ����\3D���ICOͼ��\IE.ico
#AutoIt3Wrapper_outfile=��ȡ�ط��б�����(91IE).exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
#Include <GuiListView.au3>
Local $xiaozhan , $count  
 $title = WinGetTitle("[CLASS:IEFrame]", "")
	;MsgBox(4160, "Information" ,$title)
	WinActivate($title,"Playback")  ;����ָ���Ĵ���(���ý��㵽�ô���,ʹ���Ϊ�����)
	$xiaozhan = ControlGetHandle ( $title, "", "SysListView321")  ;��ȡָ���ؼ����ڲ����.
	$count = _GUICtrlListView_GetItemCount($xiaozhan) ;��ȡ�б���ͼ�ؼ�����Ŀ��
	MsgBox(1, "��ȡ�ط��б�����" ,"��ȡ�ط��б�����:  " & $count)
	IniWrite(@ScriptDir & "\��ȡ�ط��б�����(91IE).ini", "�б�", "����", $count) 



