#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=..\��ȡ�ط��б�����(ÿ���������)(91IE).exe|-1
#AutoIt3Wrapper_outfile=..\��ȡ�ط��б�����(ÿ���������)(91IE).exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
#Include <GuiListView.au3>
Local $xiaozhan , $count  
 $title = WinGetTitle("[CLASS:IEFrame]", "")
	;MsgBox(4160, "Information" ,$title)
	WinActivate($title,"Playback")  ;����ָ���Ĵ���(���ý��㵽�ô���,ʹ���Ϊ�����)
	$xiaozhan = ControlGetHandle ( $title, "", "SysListView321")  ;��ȡָ���ؼ����ڲ����.
	$count = _GUICtrlListView_GetItemCount($xiaozhan) ;��ȡ�б���ͼ�ؼ�����Ŀ��
	MsgBox(1, "��ȡ�ط��б�����" ,"��ȡ�ط��б�������:  " & $count)
	IniWrite(@ScriptDir & "\��ȡ�ط��б�����(ÿ���������)(91IE).ini", "�б�", "��������", $count);����һ�����Ŀ����
	$R = IniRead(@ScriptDir & "\��ȡ�ط��б�����(ÿ���������)(91IE).ini", "�б�", "���������","");��ȡ��Ӻ��������
	IniWrite(@ScriptDir & "\��ȡ�ط��б�����(ÿ���������)(91IE).ini", "�б�", "���������", $count + $R) ;��Ҫ�ѵ���һ�����Ŀ���� + ��Ӻ������
	$Z = IniRead(@ScriptDir & "\��ȡ�ط��б�����(ÿ���������)(91IE).ini", "�б�", "���������","");$count+$H�������
	MsgBox(1, "��ȡ�ط��б�����" ,"��ȡ�ط��б��������:  " & $Z);$count+$H��ʾ����



