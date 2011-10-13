#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_Version=Beta
#AutoIt3Wrapper_icon=F:\AU3\ѧϰ\au3\��ͼ00.ico
#AutoIt3Wrapper_Res_Fileversion=0.0.0.2
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#EndRegion ;**** ���������� ACNWrapper_GUI ****
#include<GUIConstants.au3>
#include<Array.au3>

Global $child,$input
;�˽ű��������غ���ʾ����,�����ļ�,��Ϸ�Ĵ��ڶ�����
Opt("GUIOnEventMode",1)
Global $parent=GUICreate("���ع���",180,300)
GUISetState(@SW_SHOW)
GUISetOnEvent($GUI_EVENT_CLOSE,"_Close")
GUICtrlCreateLabel("ѡ�񴰿�:",10,10)
GUICtrlCreateButton("����",80,5,40,20)
GUICtrlSetOnEvent(-1,"_Hide")
GUICtrlCreateButton("ˢ��",30,30,40,20)
GUICtrlSetOnEvent(-1,"_Flush")
GUICtrlCreateButton("��ʾ����..",80,30,70,20)
GUICtrlSetOnEvent(-1,"_ShowWin")
GUICtrlCreateGroup("",5,50,170,245)	;GROUP����װ������
GUICtrlCreateGroup("",-99,-99,1,1)
Global $count=0 	;��¼�ɼ�������Ŀ
Global $wdhd[16]    	;���ھ��
Global $wdnm[16]	;��������
Global $ckbx[16]	;��Ӧ�ĸ�ѡ��
Global $hd_count=0	;���صĴ�����Ŀ
Global $hd_wdhd[1]	;���صĴ��ھ��
Global $hd_wdnm[1]	;���صĴ�������
Global $hd_ckbx[16]	;���صĴ��ڶ�Ӧ�ĸ�ѡ��
_Flush()
While 1
	Sleep(1000)
WEnd

;ˢ�º���
Func _Flush() 
	For $i=1 To 15
		If $ckbx[$i]<>"" Then GUICtrlDelete($ckbx[$i])
	Next
	$count=0
	Local $wdls=WinList()	
	For $i=1 To $wdls[0][0]      ;[1][0]������,[1][1]���
		If $wdls[$i][0] <> "" AND IsVisible($wdls[$i][1]) AND $wdls[$i][0] <> "MBIme" AND $wdls[$i][0] <> "Program Manager" AND $wdls[$i][0] <> "���ع���" Then
			$count+=1
			$ckbx[$count]=GUICtrlCreateCheckbox($wdls[$i][0],10,38+$count*20)  
			$wdhd[$count]=$wdls[$i][1]
			$wdnm[$count]=$wdls[$i][0]                                    		
		EndIf
	Next
EndFunc

Func _Hide()
	For $i=1 To 15
		If GUICtrlRead($ckbx[$i])=1 Then    
			WinSetState($wdhd[$i],"",@SW_HIDE)
			$hd_count+=1
			_ArrayAdd($hd_wdhd,$wdhd[$i])
			_ArrayAdd($hd_Wdnm,$wdnm[$i])
		EndIf
	Next
	_Flush()
EndFunc

Func _ShowWin()
	$pos=WinGetPos($parent)
	Global $child=GUICreate("��ʾ����",180,300,$pos[0]+60,$pos[1]+60,-1,-1,$parent)
	GUISetState(@SW_SHOW)
	GUISetOnEvent($GUI_EVENT_CLOSE,"_ExitChildWin")
	GUICtrlCreateLabel("ѡ�񴰿�:",10,10)
	GUICtrlCreateButton("��ʾ",80,5)
	GUICtrlSetOnEvent(-1,"_Show")
	GUICtrlCreateLabel("�� �ض���ʾ:",10,35)
	Global $input=GUICtrlCreateInput("",80,30)
	GUICtrlCreateButton("->",160,28)
	GUICtrlSetOnEvent(-1,"_InputShow")
	GUICtrlCreateGroup("",5,50,170,245)
	GUICtrlCreateGroup("",-99,-99,1,1)
	If $hd_count>0 Then
		For $i=1 To $hd_count
			$hd_ckbx[$i]=GUICtrlCreateCheckbox($hd_wdnm[$i],10,37+$i*20)
		Next	
	EndIf
EndFunc

Func _Show()
	If $hd_count>0 Then		 
		For $i=$hd_count To 1 Step -1
			If GUICtrlRead($hd_ckbx[$i])=1 Then
				$hd_count-=1
				WinSetState($hd_wdhd[$i],"",@SW_SHOW)
				_ArrayDelete($hd_wdhd,$i)
				_ArrayDelete($hd_wdnm,$i)		
			EndIf
		Next
		GUISwitch($child)
		GUIDelete()
		_Flush()
	EndIf
EndFunc

Func _InputShow()
	Local $getinput=GUICtrlRead($input)
	If $getinput="" Then return
	Local $wdls=WinList()
	For $i=1 To $wdls[0][0]
		If StringInStr($wdls[$i][0],$getinput)>0 Then 
			WinSetState($wdls[$i][1],"",@SW_SHOW)
		EndIf
	Next
	GUISwitch($child)
	GUIDelete()
	_Flush()
EndFunc	

Func IsVisible($handle)
  If BitAnd( WinGetState($handle), 2 ) Then 
    Return 1
  Else
    Return 0
  EndIf
EndFunc

Func _Close()
	Exit
EndFunc

Func _ExitChildWin()
	GUISwitch($child)
	GUIDelete()
EndFunc
