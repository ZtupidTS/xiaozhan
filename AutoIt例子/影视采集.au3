#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_UseAnsi=y
#EndRegion ;**** ���������� ACNWrapper_GUI ****
#include <GuiEdit.au3>
#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#include <IE.au3> 
#Include <GuiListBox.au3>
#Include <GuiImageList.au3>

If FileExists(@ScriptDir&'\temp\') = 0 then DirCreate(@ScriptDir&'\temp\')
If FileExists(@ScriptDir&'\img\') = 0 then DirCreate(@ScriptDir&'\img\')
If FileExists(@ScriptDir&'\small\') = 0 then DirCreate(@ScriptDir&'\small\')
$AForm1 = GUICreate("Ӱ��ͼ�Ĳɼ�V1.0 ����:˧������ ��ϵQQ:76594695", 644, 432, 206, 119)
GUICtrlSetResizing(-1, $GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
GUICtrlCreateLabel("˵����Ŀ��վ��ͼƬ�����˷�����,����ɼ�����ͼƬ,���Գ����ظ��ɼ�����,�ɼ��ٶȸ������ٶ�������������ϵ��", 10, 10, 630, 17)
GUICtrlSetColor(-1, 0xFF0000)
$Group1 = GUICtrlCreateGroup("", 16, 27, 611, 222)
$Group2 = GUICtrlCreateGroup("", 24, 35, 151, 206)
$Pic1 = GUICtrlCreatePic("", 30, 48, 139, 187)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Label1 = GUICtrlCreateLabel("��Ӱ����:", 186, 47, 55, 17)
$Label2 = GUICtrlCreateLabel("ӰƬ����:", 186, 107, 55, 17)
$Label3 = GUICtrlCreateLabel("ӰƬ����:", 186, 137, 55, 17)
$Label4 = GUICtrlCreateLabel("ӰƬ����:", 186, 77, 55, 17)
$Input1 = GUICtrlCreateInput("�������Ӱ����", 251, 42, 191, 21)
$Input2 = GUICtrlCreateInput("", 251, 72, 281, 21)
$Input3 = GUICtrlCreateInput("", 251, 102, 281, 21)
$Input4 = GUICtrlCreateInput("", 251, 132, 281, 21)
$Edit1 = GUICtrlCreateEdit("", 186, 160, 431, 81,$ES_AUTOVSCROLL)
GUICtrlSetData(-1, "ӰƬ��飺")
$Checkbox1 = GUICtrlCreateCheckbox("����", 560, 42, 61, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group3 = GUICtrlCreateGroup("", 16, 250, 611, 101)
$Edit2 = GUICtrlCreateEdit("", 20, 260, 602, 87,$ES_AUTOVSCROLL)
GUICtrlSetColor(-1, 0x008000)
GUICtrlSetData(-1, "")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Label5 = GUICtrlCreateLabel("ѡ��ɼ�Ŀ�꣺", 20, 370, 88, 17)
$Combo1 = GUICtrlCreateCombo("�й�Ӱ�ӿ�:www.mdbchina.com", 110, 367, 221, 21, 0x0003)
GUICtrlSetData(-1, "��Ŀ��վ,�붨��|��Ŀ��վ,�붨��|��Ŀ��վ,�붨�� |��Ŀ��վ,�붨�� |��Ŀ��վ,�붨�� ")
$Button1 = GUICtrlCreateButton("����Ŀ��",340, 367, 61, 21, 0)
$Checkbox2 = GUICtrlCreateCheckbox("ֱ�����(��������������ݿ����ӱ�֤�޴���!!!����ϸ�Ķ������ļ�)", 20, 393, 421, 21)
$Button2 = GUICtrlCreateButton("��    ʼ", 530, 370, 91, 41, 0)
GUICtrlCreateTabItem("")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
;~ -----------------------------------------------------------------------------------

While 1
$nMsg1 = GUIGetMsg()
Select
    Case $nMsg1 = $GUI_EVENT_CLOSE
     ExitLoop
    Case $nMsg1 = $Button2
       $dy_name = GUICtrlRead($Input1) 
     if $dy_name = '' or $dy_name = '�������Ӱ����' then 
                MsgBox (0,'��ʾ:',"���������Ӱ����!!!")
       else
     GUICtrlSetData($Input2, '������')
     GUICtrlSetData($Input3, '������')
     GUICtrlSetData($Input4, '������')
     GUICtrlSetData($Edit1, '������')
     GUICtrlSetData($Edit2, '')
            caiji($dy_name)
    EndIf
            Case $nMsg1 = $Button1
                MsgBox (0,"Ӱ��ͼ�Ĳɼ�V1.0 QQ:76594695","�Զ���Ŀ�깦�ܺ���⹦�������У�����")   
EndSelect
WEnd

;~ ------------------------------------------------------------------------------------
func caiji($dy_name);������ҳ��ȡ����,���ص�TEMP�ļ���
$nOffset = 1
$kaishi = '<div id="MovieBlock"><div id="RecordPost"><a href="' ;��ʼ��ַ
$jieshu = '" target="_blank">'                   ;������ַ
$url = ''                    ;������������
$oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
$oHTTP.Open("GET","http://so.mdbchina.com/query/"&$dy_name)
GUICtrlSetData($Edit2, "����Ŀ�꣺http://www.mdbchina.com/"&@CRLF, 1)
$oHTTP.Send()
$HTMLContents = $oHTTP.Responsetext
if $HTMLContents <> "" then 
$array = StringRegExp($HTMLContents, $kaishi&'[^\<]+'&$jieshu, 2, $nOffset)
        If @error = 0 Then
   $nOffset = @extended
   EndIf
        for $i = 0 to UBound($array) - 1
            $url=$array[$i]
     Next
     $url=StringReplace($url,$kaishi,"")
        $url=StringReplace($url,$jieshu,"")
   if $url ="" then 
   GUICtrlSetData($Edit2, "��Ӱ���ƴ������Ŀ��վû�иõ�Ӱ������"&@CRLF, 1)
else
   GUICtrlSetData($Edit2, "��ȡ���ӣ�"&$url&@CRLF, 1)
   InetGet($url,'temp\temp.tmp',0,0)
     caiji_img($url,$dy_name)
        caiji_zy($url,$dy_name)
        caiji_dy($url,$dy_name)
   caiji_dq($url,$dy_name)
   caiji_jj($url,$dy_name)
   ;FileDelete(@ScriptDir&'\temp\*.tmp')
   EndIf
Else
GUICtrlSetData($Edit2, "����Ŀ��ʧ��,������������!!!"&@CRLF, 1) 
EndIf
EndFunc

func caiji_img($url,$dy_name);�ɼ�ӰƬͼƬ+����ͼ����
$nOffset = 1
$kaishi = 'src="'   ;��ʼ��ַ
$jieshu = '" width="98" border="0"></A></div>'   ;������ַ
$img = ''    ;������������
;-----------------------------------------------------------------------------
$HTMLContents=FileRead('temp\temp.tmp')
$array = StringRegExp($HTMLContents, $kaishi&'[^\<]+'&$jieshu, 2, $nOffset)
        If @error = 0 Then
   $nOffset = @extended
        EndIf
        for $i = 0 to UBound($array) - 1
            $img=$array[$i]
     Next
     $img=StringReplace($img,$kaishi,"")
        $img=StringReplace($img,$jieshu,"")
  
        if $img ="" or $img = "http://image.mdbchina.com/image/nopic.jpg" then 
   GUICtrlSetData($Edit2, '�ɼ���'&$dy_name&'��ͼƬʧ�ܻ���Ŀ��վ�޸õ�ӰͼƬ������'&@CRLF, 1)
else
   GUICtrlSetData($Edit2, "����ͼ��ַ��"&$img&@CRLF, 1)
        caiji_hb($url,$dy_name,$img)  
   EndIf
EndFunc

func caiji_hb($url,$dy_name,$img);�ɼ�ӰƬͼƬ+����ͼ����
$nOffset = 1
$kaishi = '<div class="photo_border"><A href="'   ;��ʼ��ַ
$jieshu = '"><IMG height="140" alt="'   ;������ַ
$hb_url = ''    ;��Ӱ������ַ
;-----------------------------------------------------------------------------
$HTMLContents=FileRead('temp\temp.tmp')
$array = StringRegExp($HTMLContents, $kaishi&'[^\<]+'&$jieshu, 2, $nOffset)
        If @error = 0 Then
   $nOffset = @extended
        EndIf
        for $i = 0 to UBound($array) - 1
            $hb=$array[$i]
        Next
        $hb=StringReplace($hb,$kaishi,"")
        $hb=StringReplace($hb,$jieshu,"")
        if $hb ="" then 
   GUICtrlSetData($Edit2, '�ɼ���'&$dy_name&'����Ӱ����ʧ��!!!'&@CRLF, 1)
else
   $hb_url = "http://www.mdbchina.com"&$hb
     $a = StringRegExp($img, "small/[^\.]+", 2, 1)
   for $i = 0 to UBound($array) - 1
            $http_img_url=$a[$i]
     Next
   $http_img_url = $hb_url&StringReplace($http_img_url,"small/","")&'.html'
   GUICtrlSetData($Edit2, '�������ӣ�'&$http_img_url&@CRLF, 1)
   $img_url = StringReplace( $img, "/small/" ,"/" )
   GUICtrlSetData($Edit2, '������ַ��'&$img_url&@CRLF, 1)
   GUICtrlSetData($Edit2, '��������ͼƬ,���Ժ�...^..^!!!'&@CRLF, 1)
   $oIE =_IECreate ($http_img_url, 0, 0, 0)
   Sleep(5000)
   InetGet($img,@ScriptDir&'\small\'& $dy_name&'.jpg',0,0);����ͼ����
   InetGet($img_url,@ScriptDir&'\img\'& $dy_name&'.jpg',0,0);��Ӱ��������
   _IEQuit ($oIE)
   GUICtrlSetData($Edit2, 'ͼƬ���سɹ�...^_^'&@CRLF, 1)
   GUICtrlSetImage($pic1,@ScriptDir&'\img\'&$dy_name&'.jpg')
   EndIf
EndFunc 

func caiji_zy($url,$dy_name);�ɼ�ӰƬ���ݺ���
$nOffset = 1
$kaishi='���ݣ�'
$jieshu='</li>'
$zy=''
;-----------------------------------------------------------------------------
$HTMLContents=FileRead('temp\temp.tmp')
$array = StringRegExp($HTMLContents, $kaishi&'[^\n]+'&$jieshu, 2, $nOffset)
        for $i = 0 to UBound($array) - 1
            $zy=$array[$i]
     Next
     $zy=StringReplace($zy,$kaishi,"")
        $zy=StringReplace($zy,$jieshu,"")
        if $zy ="" then 
   GUICtrlSetData($Edit2, '�ɼ���'&$dy_name&'����������ʧ��!!!'&@CRLF, 1)
   GUICtrlSetData($Input3, '��������ʧ��')
     else
   $zy = StringRegExpReplace ( $zy, '<a[^>]+>'," ");�滻<a>������Ϊ�ո�
   $zy = StringRegExpReplace ( $zy, '<[^>]+>',"");�滻<>������
   GUICtrlSetData($Input3, $zy)
   GUICtrlSetData($Edit2, '�ɼ���'&$dy_name&'���������ϳɹ�!!!'&@CRLF, 1)
EndIf
EndFunc

func caiji_jj($url,$dy_name);�ɼ�ӰƬ��麯��
$nOffset = 1
$kaishi='<p class="page_view">'
$jieshu='</p>'
$jj=''
;-----------------------------------------------------------------------------
$HTMLContents=FileRead('temp\temp.tmp')
$array = StringRegExp($HTMLContents, $kaishi&'[^\<]+', 2, $nOffset)
        for $i = 0 to UBound($array) - 1
            $jj=$array[$i]
     Next
     $jj=StringReplace($jj,$kaishi,"")
        $jj=StringReplace($jj,"[","")
        if $jj ="" then 
   GUICtrlSetData($Edit2, '�ɼ���'&$dy_name&'���������ʧ��!!!'&@CRLF, 1)
   GUICtrlSetData($Edit1, '��������ʧ��')
   else
     GUICtrlSetData($Edit1, $jj)
        GUICtrlSetData($Edit2, '�ɼ���'&$dy_name&'��������ϳɹ�!!!'&@CRLF, 1)  
EndIf
EndFunc

Func caiji_dy($url,$dy_name);�ɼ�ӰƬ���ݺ���
$nOffset = 1
$kaishi='���ݣ�'
$jieshu='</li>'
$dy=''
;-----------------------------------------------------------------------------
$HTMLContents=FileRead('temp\temp.tmp')
$array = StringRegExp($HTMLContents, $kaishi&'[^\n]+'&$jieshu, 2, $nOffset)
        for $i = 0 to UBound($array) - 1
            $dy=$array[$i]
                Next
     $dy=StringReplace($dy,$kaishi,"")
        $dy=StringReplace($dy,$jieshu,"")
        if $dy ="" then 
   GUICtrlSetData($Input2, '��������ʧ��')
   GUICtrlSetData($Edit2, '�ɼ���'&$dy_name&'����������ʧ��!!!'&@CRLF, 1)
else
   $dy = StringRegExpReplace ( $dy, '<a[^>]+>'," ");�滻<a>������Ϊ�ո�
   $dy = StringRegExpReplace ( $dy, '<[^>]+>',"");�滻<>������
   if StringInStr ( $dy, ">",0,1) <> 0 then 
   $a=StringSplit ($dy, ">",0 )
   $dy = $a[2]
     EndIf
     GUICtrlSetData($Edit2, '�ɼ���'&$dy_name&'���������ϳɹ�!!!'&@CRLF, 1)
     GUICtrlSetData($Input2, $dy)    
EndIf
EndFunc

Func caiji_dq($url,$dy_name);�ɼ�ӰƬ���ݺ���
$nOffset = 1
$kaishi='������'
$jieshu='</li>'
$dq=''
;-----------------------------------------------------------------------------
$HTMLContents=FileRead('temp\temp.tmp')
$array = StringRegExp($HTMLContents, $kaishi&'[^\n]+'&$jieshu, 2, $nOffset)
        for $i = 0 to UBound($array) - 1
            $dq=$array[$i]
     Next
     $dq=StringReplace($dq,$kaishi,"")
        $dq=StringReplace($dq,$jieshu,"")
        if $dq ="" then
        GUICtrlSetData($Input4, '��������ʧ��')   
   GUICtrlSetData($Edit2, '�ɼ���'&$dy_name&'����������ʧ��!!!'&@CRLF, 1)
else
   $dq = StringRegExpReplace ( $dq, '<a[^>]+>'," ");�滻<a>������Ϊ�ո�
   $dq = StringRegExpReplace ( $dq, '<[^>]+>',"");�滻<>������
   if StringInStr ( $dq, ">",0,1) <> 0 then 
   $a=StringSplit ($dq, ">",0 )
   $dq = $a[2]
     EndIf
     GUICtrlSetData($Edit2, '�ɼ���'&$dy_name&'���������ϳɹ�!!!'&@CRLF, 1)
     GUICtrlSetData($Input4, $dq)     
EndIf
EndFunc