Run("C:\Users\LXL\Desktop\testtools\tools\testtoolд��ַר��.exe","C:\Users\LXL\Desktop\testtools\tools")
$title=IniRead("C:\Users\LXL\Desktop\���кź�MAC1.ini","title4","title4","") ;��ini�ļ���ȡtitle4�е�ֵ
$title=$title & IniRead("C:\Users\LXL\Desktop\���кź�MAC1.ini","title5","title5","") ;��ini�ļ���ȡtitle5�е�ֵ������ն�ȡ��title4��ֵ����һ��
$title=$title & IniRead("C:\Users\LXL\Desktop\���кź�MAC1.ini","title6","title6","") ;��ini�ļ���ȡtitle6�е�ֵ������ն�ȡ��title5��ֵ����һ��
$title=$title & IniRead("C:\Users\LXL\Desktop\���кź�MAC1.ini","title7","title7","") ;��ini�ļ���ȡtitle7�е�ֵ������ն�ȡ��title6��ֵ����һ��
$title=$title & IniRead("C:\Users\LXL\Desktop\���кź�MAC1.ini","title8","title8","") ;��ini�ļ���ȡtitle8�е�ֵ������ն�ȡ��title7��ֵ����һ��
$title=$title & IniRead("C:\Users\LXL\Desktop\���кź�MAC1.ini","title9","title9","") ;��ini�ļ���ȡtitle9�е�ֵ������ն�ȡ��title8��ֵ����һ��
$title=$title & IniRead("C:\Users\LXL\Desktop\���кź�MAC1.ini","title10","title10","") ;��ini�ļ���ȡtitle10�е�ֵ������ն�ȡ��title9��ֵ����һ��
Opt("WinTitleMatchMode")
WinWait("testtool","",1)
BlockInput(1)
$var = ControlGetText("testtool", "", "[ID:1012]")
ControlClick("testtool", "", "[ID:1012]")
WinWaitActive("testtool")
ControlSend("testtool", "", "[ID:1012]", $title);000f09
If StringLen($title) = 0 Then
	$title= "000f090000000"
    ControlSend("testtool", "", "[ID:1012]", $title);000f09
Else
$title = "000f09" & Hex(Dec(StringTrimLeft($title, 6))+1, 6) ;����ȡ�����ַ���ǰ��λɾ����ת��ʮ���ƣ�Ȼ���1����ת��6λ����16���Ʋ���ǰ��ɾ����ԭ�ַ�����ǰ��λ�ϲ�
EndIf
;Send($title)
BlockInput(0)
IniWrite("C:\Users\LXL\Desktop\���кź�MAC1.ini","title4","title4", StringLeft($title, 6))     ;��ȡ�������������000f09
IniWrite("C:\Users\LXL\Desktop\���кź�MAC1.ini", "title5", "title5", StringMid($title, 7, 1))	;�ӵ�7λ��ʼ��ȡ����ȡһ���ַ�
IniWrite("C:\Users\LXL\Desktop\���кź�MAC1.ini", "title6", "title6", StringMid($title, 8, 1))	;�ӵ�8λ��ʼ��ȡ����ȡһ���ַ�	
IniWrite("C:\Users\LXL\Desktop\���кź�MAC1.ini", "title7", "title7", StringMid($title, 9, 1))	;�ӵ�9λ��ʼ��ȡ����ȡһ���ַ�	
IniWrite("C:\Users\LXL\Desktop\���кź�MAC1.ini", "title8", "title8", StringMid($title, 10, 1))	;�ӵ�10λ��ʼ��ȡ����ȡһ���ַ�
IniWrite("C:\Users\LXL\Desktop\���кź�MAC1.ini", "title9", "title9", StringMid($title, 11, 1))	;�ӵ�11λ��ʼ��ȡ����ȡһ���ַ�
IniWrite("C:\Users\LXL\Desktop\���кź�MAC1.ini", "title10", "title10", StringRight($title, 1))	;���ұ߿�ʼ��ȡ����ȡһ���ַ��������һ���ַ�
