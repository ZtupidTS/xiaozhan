
HotKeySet("!a", "ShowMessage")          ;ALT+a ע�ͷ��ţ�����
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z
;��¼ģ��
;Run("F:\����ͶӰ��\arp -d.bat","F:\����ͶӰ��\")
Run("C:\Documents and Settings\xiaozhan\����\testtools\tools\testtoolд��ַר��.exe","C:\Documents and Settings\xiaozhan\����\testtools\tools")
;Run("C:\Documents and Settings\Administrator\����\testtools\tools\testtoolд��ַר��.exe","C:\Documents and Settings\Administrator\����\testtools\tools")
;Sleep(2000)  ;ʹ�ű���ָͣ��ʱ���.;(5000Ϊ5��)

Local $title, $title1,$title2,$title3,$title4, $title5,$title6,$title7,$title8,$title9,$title10,$title11
;***************************************************************************************

$title=IniRead(@scriptdir & "\���кź�MAC.ini","title","title","")
$title1=IniRead(@scriptdir & "\���кź�MAC.ini","title1","title1","")
$title2=IniRead(@scriptdir & "\���кź�MAC.ini","title2","title2","")
$title3=IniRead(@scriptdir & "\���кź�MAC.ini","title3","title3","")
$title11=IniRead(@scriptdir & "\���кź�MAC.ini","title4","title4","") ;��ini�ļ���ȡtitle4�е�ֵ
$title11=$title11 & IniRead(@scriptdir & "\���кź�MAC.ini","title5","title5","");��ini�ļ���ȡtitle5�е�ֵ������ն�ȡ��title4��ֵ����һ��
$title11=$title11 & IniRead(@scriptdir & "\���кź�MAC.ini","title6","title6","");��ini�ļ���ȡtitle6�е�ֵ������ն�ȡ��title5��ֵ����һ��
$title11=$title11 & IniRead(@scriptdir & "\���кź�MAC.ini","title7","title7","");��ini�ļ���ȡtitle7�е�ֵ������ն�ȡ��title6��ֵ����һ��
$title11=$title11 & IniRead(@scriptdir & "\���кź�MAC.ini","title8","title8","");��ini�ļ���ȡtitle8�е�ֵ������ն�ȡ��title7��ֵ����һ��
$title11=$title11 & IniRead(@scriptdir & "\���кź�MAC.ini","title9","title9","");��ini�ļ���ȡtitle9�е�ֵ������ն�ȡ��title8��ֵ����һ��
$title11=$title11 & IniRead(@scriptdir & "\���кź�MAC.ini","title10","title10","");��ini�ļ���ȡtitle10�е�ֵ������ն�ȡ��title9��ֵ����һ��
;***************************************************************************************

opt("WinTitleMatchMode")
WinWait("testtool","",1)
BlockInput(1)
$var = ControlGetText("testtool", "", "[ID:1012]")
ControlClick("testtool", "", "[ID:1012]")
WinWaitActive("testtool")
ControlSend("testtool", "", "[ID:1012]", $title11);000f09
If stringlen($title11)= 0 then
 $title11= "000f09000000"
 ControlSend("testtool", "", "[ID:1012]", $title11);000f09
else
 $title11 = "000f09" & Hex(Dec(StringTrimLeft($title11, 6))+1, 6) ;����ȡ�����ַ���ǰ��λɾ����ת��ʮ���ƣ�Ȼ���1����ת��6λ����16���Ʋ���ǰ��ɾ����ԭ�ַ�����ǰ��λ�ϲ�
endif

BlockInput(0)
;***************************************************************************************

BlockInput(1)
$var = ControlGetText("testtool", "", "[ID:1016]")
ControlClick("testtool", "", "[ID:1016]")
WinWaitActive("testtool")
ControlSend("testtool", "", "[ID:1016]", $title);ControlSend��֧������
ControlSend("testtool", "", "[ID:1016]", $title1)
ControlSend("testtool", "", "[ID:1016]", $title2)
ControlSend("testtool", "", "[ID:1016]", $title3)
;Send($title)
BlockInput(0)

;***************************************************************************************

If $title3="00" Then ;���$title3="00"�����$title3="01"��������ھ�+1
    $title3="01"
ElseIf $title3="01" Then 
    $title3="02"
ElseIf $title3="02" Then    
	$title3="03"
ElseIf $title3="03" Then 
    $title3="04"
ElseIf $title3="04" Then 
    $title3="05"
ElseIf $title3="05" Then    
	$title3="06"
ElseIf $title3="06" Then 
    $title3="07"
ElseIf $title3="07" Then    
	$title3="08"
ElseIf $title3="08" Then 
    $title3="09"
ElseIf $title3=99 Then
	$title3="00"
	$title1 =$title1+1
Else
	$title3=$title3+1
EndIf

;***************************************************************************************	

;***************************************************************************************

IniWrite(@scriptdir & "\���кź�MAC.ini", "title1", "title1", $title1)	
IniWrite(@scriptdir & "\���кź�MAC.ini", "title3", "title3", $title3)	
IniWrite(@scriptdir & "\���кź�MAC.ini", "title5", "title5", $title5)	
IniWrite(@scriptdir & "\���кź�MAC.ini","title4","title4", StringLeft($title11, 6));��ȡ�������������000f09
IniWrite(@scriptdir & "\���кź�MAC.ini", "title5", "title5", StringMid($title11, 7, 1))	;�ӵ�7λ��ʼ��ȡ����ȡһ���ַ�
IniWrite(@scriptdir & "\���кź�MAC.ini", "title6", "title6", StringMid($title11, 8, 1))	;�ӵ�8λ��ʼ��ȡ����ȡһ���ַ�	
IniWrite(@scriptdir & "\���кź�MAC.ini", "title7", "title7", StringMid($title11, 9, 1))	;�ӵ�9λ��ʼ��ȡ����ȡһ���ַ�
IniWrite(@scriptdir & "\���кź�MAC.ini", "title8", "title8", StringMid($title11, 10, 1)) ;�ӵ�10λ��ʼ��ȡ����ȡһ���ַ�	
IniWrite(@scriptdir & "\���кź�MAC.ini", "title9", "title9", StringMid($title11, 11, 1));�ӵ�11λ��ʼ��ȡ����ȡһ���ַ�	
IniWrite(@scriptdir & "\���кź�MAC.ini", "title10", "title10", StringRight($title11, 1))	;���ұ߿�ʼ��ȡ����ȡһ���ַ��������һ���ַ�


Func ShowMessage()   ;Func����˼�����Զ��庯��
    Dim $i=MsgBox(1,"�˳��ű�","ȷ���˳��ű���")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc


;***************************************************************************************
;INN�����ʼ����ֵΪ
#cs
[title]
title=0
[title1]
title1=3001001
[title2]
title2=120816
[title3]
title3=16
[title4]
title4=
[title5]
title5=
[title6]
title6=
[title7]
title7=
[title8]
title8=
[title9]
title9=
[title10]
title10=
#ce
;***************************************************************************************