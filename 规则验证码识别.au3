#include <ButtonConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <GDIPlus.au3>
#include <file.au3>
#include <Array.au3>
#NoTrayIcon
;~ $Open2  ���ļ�����
;~ $CodeDB  �ַ���������Ϣ
;~ $Row  $Cro    ����������
;~ $aRecords  ��¼����
Global $Open2=0,$CodeDB="",$Cro=0 ,$Row=0,$aRecords=""
Global $ResPicPos[4][4]
;~ $BackCorlor  ���屳����ɫ
Global $BackCorlor=0xf2eada
;~  ���ݿ��ж����߶ȣ���ȣ� ɫ��
Global $iWidth=IniRead(@ScriptDir&"\data.db","set","iwth","10"),$iHeight=IniRead(@ScriptDir&"\data.db","set","ihth","10"),$ColorToRemove=IniRead(@ScriptDir&"\data.db","set","remcolor","0xcccccc")
;�������ʼ��. ÿ���ַ�������
Func chushihua()
        $ResPicPos[0][0]=0    ;��1���ָ�ͼƬ���Ͻ�X����
        $ResPicPos[0][1]=0
        $ResPicPos[0][2]=$iWidth
        $ResPicPos[0][3]=$iHeight
        $ResPicPos[1][0]=$iWidth   ;��2���ָ�ͼƬ���Ͻ�X���� 
        $ResPicPos[1][1]=0  
        $ResPicPos[1][2]=$iWidth
        $ResPicPos[1][3]=$iHeight
        $ResPicPos[2][0]=$iWidth*2   ;��3���ָ�ͼƬ���Ͻ�X����
        $ResPicPos[2][1]=0
        $ResPicPos[2][2]=$iWidth
        $ResPicPos[2][3]=$iHeight
        $ResPicPos[3][0]=$iWidth*3   ;��4���ָ�ͼƬ���Ͻ�X����
        $ResPicPos[3][1]=0
        $ResPicPos[3][2]=$iWidth
        $ResPicPos[3][3]=$iHeight
EndFunc
chushihua()        
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=C:\Documents and Settings\Administrator\����\code\CodeRead.kxf
$Form1 = GUICreate("CodeReader", 520, 402, 92, 114)
GUISetBkColor($BackCorlor)
GUISetOnEvent($GUI_EVENT_CLOSE, "Form1Close")
$MainPic = GUICtrlCreatePic("", 24, 16, 153, 41)
$FirstPic = GUICtrlCreatePic("", 24, 80, 28, 28)
$LoadPic = GUICtrlCreateButton("����ͼƬ", 208, 24, 75, 25)
GUICtrlSetOnEvent(-1, "LoadPicClick")
$MoveLef1 = GUICtrlCreateButton("<", 8, 85, 11, 17)
GUICtrlSetOnEvent(-1, "MoveLef1Click")
$MoveRight1 = GUICtrlCreateButton(">", 56, 85, 11, 17)
GUICtrlSetOnEvent(-1, "MoveRight1Click")
$MoveDown1 = GUICtrlCreateButton("\/", 28, 111, 19, 10)
GUICtrlSetOnEvent(-1, "MoveDown1Click")
$MoveUp1 = GUICtrlCreateButton("/\", 28, 66, 19, 10)
GUICtrlSetOnEvent(-1, "MoveUp1Click")
$SecondPic = GUICtrlCreatePic("", 96, 80, 28, 28)
$MoveDown2 = GUICtrlCreateButton("\/", 100, 111, 19, 10)
GUICtrlSetOnEvent(-1, "MoveDown2Click")
$MoveLeft2 = GUICtrlCreateButton("<", 80, 85, 11, 17)
GUICtrlSetOnEvent(-1, "MoveLeft2Click")
$MoveUp2 = GUICtrlCreateButton("/\", 100, 66, 19, 10)
GUICtrlSetOnEvent(-1, "MoveUp2Click")
$MoveRight2 = GUICtrlCreateButton(">", 128, 85, 11, 17)
GUICtrlSetOnEvent(-1, "MoveRight2Click")
$ThirdPic = GUICtrlCreatePic("", 168, 80, 28, 28)
$MoveDown3 = GUICtrlCreateButton("\/", 172, 111, 19, 10)
GUICtrlSetOnEvent(-1, "MoveDown3Click")
$MoveLeft3 = GUICtrlCreateButton("<", 152, 85, 11, 17)
GUICtrlSetOnEvent(-1, "MoveLeft3Click")
$MoveUp3 = GUICtrlCreateButton("/\", 172, 66, 19, 10)
GUICtrlSetOnEvent(-1, "MoveUp3Click")
$MoveRight3 = GUICtrlCreateButton(">", 200, 85, 11, 17)
GUICtrlSetOnEvent(-1, "MoveRight3Click")
$FourthPic = GUICtrlCreatePic("", 240, 80, 28, 28)
$MoveDown4 = GUICtrlCreateButton("\/", 244, 111, 19, 10)
GUICtrlSetOnEvent(-1, "MoveDown4Click")
$MoveLeft4 = GUICtrlCreateButton("<", 224, 85, 11, 17)
GUICtrlSetOnEvent(-1, "MoveLeft4Click")
$MoveUp4 = GUICtrlCreateButton("/\", 244, 66, 19, 10)
GUICtrlSetOnEvent(-1, "MoveUp4Click")
$MoveRight4 = GUICtrlCreateButton(">", 272, 85, 11, 17)
GUICtrlSetOnEvent(-1, "MoveRight4Click")
$LogList = GUICtrlCreateList("", 304, 24, 209, 370,BitOR($LBS_NOTIFY,$LBS_DISABLENOSCROLL,$WS_HSCROLL,$WS_VSCROLL,$WS_BORDER))
$LogListcontext = GUICtrlCreateContextMenu($LogList)
$ClearMenu = GUICtrlCreateMenuItem("��ռ�¼", $LogListcontext)
GUICtrlSetOnEvent(-1, "ClearMenuClick")
$LogListLb = GUICtrlCreateLabel("������¼", 375, 6, 52, 17)
$FirstInput = GUICtrlCreateInput("", 8, 136, 57, 21)
$SecondInput = GUICtrlCreateInput("", 80, 136, 57, 21)
$ThirdInput = GUICtrlCreateInput("", 152, 136, 57, 21)
$FourthInput = GUICtrlCreateInput("", 224, 136, 57, 21)
$FirstBt = GUICtrlCreateButton("1���", 8, 176, 59, 25)
GUICtrlSetOnEvent($FirstBt, "FirstClick")
$SecondBt = GUICtrlCreateButton("2���", 80, 176, 59, 25)
GUICtrlSetOnEvent($SecondBt, "SecondClick")
$ThirdBt = GUICtrlCreateButton("3���", 152, 176, 59, 25)
GUICtrlSetOnEvent($ThirdBt, "ThirdClick")
$FourthBt = GUICtrlCreateButton("4���", 224, 176, 59, 25)
GUICtrlSetOnEvent($FourthBt, "FourthClick")
$CodeList = GUICtrlCreateList("", 8, 216, 201, 175,BitOR($LBS_NOTIFY,$LBS_DISABLENOSCROLL,$WS_BORDER))
$reload = GUICtrlCreateButton("����", 224, 312, 59, 25)
GUICtrlSetOnEvent($reload, "reloadclick")
$quitbt = GUICtrlCreateButton("�˳�", 224, 352, 59, 25)
GUICtrlSetOnEvent($quitbt, "form1close")
$ReadBt = GUICtrlCreateButton("ʶ��", 224, 272, 59, 25)
GUICtrlSetOnEvent($ReadBt, "ReadBtClick")
$ResultLb = GUICtrlCreateLabel("���", 238, 232, 52, 17)
$SetBt = GUICtrlCreateButton(">>", 491, 0, 21, 25)
GUICtrlSetBkColor(-1, $BackCorlor)
GUICtrlSetOnEvent($SetBt, "SetBtClick")
;----���ô�����ʾ
$SetForm = GUICreate("SetForm", 193, 279, 618, 114,"","",WinGetHandle($form1))
GUISetBkColor($BackCorlor)
GUISetOnEvent($GUI_EVENT_CLOSE, "SetCancelClick")
$SetOK = GUICtrlCreateButton("ȷ��", 16, 215, 67, 25)
GUICtrlSetOnEvent($SetOK, "SetOKClick")
$SetCancel = GUICtrlCreateButton("ȡ��", 112, 215, 67, 25)
GUICtrlSetOnEvent($SetCancel, "SetCancelClick")
$widthinput = GUICtrlCreateInput("", 48, 144, 41, 21)
$Heightinput = GUICtrlCreateInput("", 136, 144, 41, 21)
$widthlab = GUICtrlCreateLabel("���", 16, 147, 28, 17)
$Heightlab = GUICtrlCreateLabel("�߶�", 104, 147, 28, 17)
$Info = GUICtrlCreateGroup("", 4, -2, 185, 109)
$Label1 = GUICtrlCreateLabel("��֤����Ϣ", 64, 16, 77, 17)
$picwidth = GUICtrlCreateLabel("���:", 24, 37, 47, 17)
$picheight = GUICtrlCreateLabel("�߶�:", 103, 37, 47, 17)
$lettercount = GUICtrlCreateLabel("�ַ�����:", 24, 60, 72, 17)
$everywidth = GUICtrlCreateLabel("ÿ�ַ���:", 24, 84, 72, 17)
$everyheight = GUICtrlCreateLabel("ÿ�ַ���:", 103, 84, 72, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$msg = GUICtrlCreateLabel("����ÿ���ַ�����", 43, 117, 100, 17)
$Colorlab = GUICtrlCreateLabel("��ɫ", 16, 182, 28, 17)
$ColorInput = GUICtrlCreateInput("0XCCCCCC", 48, 178, 129, 21)
;-----
GUISwitch($form1)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
        Sleep(10000)
WEnd

Func ClearMenuClick()  ;�����ʷ��¼
        GUICtrlSetData($LogList,"")
EndFunc
Func Form1Close() ;����ر�  ɾ����ʱ�ļ�,�˳�.
        FileDelete(@ScriptDir&"\0.bmp")
        FileDelete(@ScriptDir&"\1.bmp")
        FileDelete(@ScriptDir&"\2.bmp")
        FileDelete(@ScriptDir&"\3.bmp")
        Exit
EndFunc
Func SetOKClick()  ;ȷ������, ���ж�3��ֵ�ǲ��ǿգ� ���Ϊ��,��־�б�д�������Ϣ ������.��Ϊ��,���3��ȫ�ֱ�����ֵ,Ȼ��������ݿ�.
        If GUICtrlRead($widthinput)="" Then
                _GUICtrlListBox_AddString($LogList,"����,��Ȳ���Ϊ��!")
                Return
        Else
                $iWidth=GUICtrlRead($widthinput)
        EndIf
        If GUICtrlRead($Heightinput)="" Then
                _GUICtrlListBox_AddString($LogList,"����,�߶Ȳ���Ϊ��!")
                Return
        Else
                $iHeight=GUICtrlRead($Heightinput)
        EndIf
        If GUICtrlRead($ColorInput)="" Then
                _GUICtrlListBox_AddString($LogList,"����,��ɫֵ����Ϊ��!")
                Return
        Else
                $ColorToRemove=GUICtrlRead($ColorInput)
        EndIf
        _GUICtrlListBox_AddString($LogList,"���ñ���,������ϢΪ:��"&$iWidth&",��"&$iHeight)
        _GUICtrlListBox_AddString($LogList,"��ɫֵΪ:"&$ColorToRemove)
        IniWrite(@ScriptDir&"\data.db","set","iwth",$iWidth)
        IniWrite(@ScriptDir&"\data.db","set","ihth",$iHeight)
        IniWrite(@ScriptDir&"\data.db","set","remcolor",$ColorToRemove)
        reloadclick()
        GUISwitch($SetForm)
        GUISetState(@SW_HIDE)
EndFunc
Func SetCancelClick()  ;ȡ����ť, ��־д����Ϣ, ��������
        _GUICtrlListBox_AddString($LogList,"ȡ������,����δ����!")
        GUISwitch($SetForm)
        GUISetState(@SW_HIDE)
EndFunc

Func SetBtClick()  ;���ð�ť. ���ô�����ʾ,��־д��ͼ����Ϣ.
        If $Open2="" Then Return _GUICtrlListBox_AddString($LogList,"δ����ͼ���ļ�,�������ã�")
        GUICtrlSetData($picwidth,"���:"&$Row)
        GUICtrlSetData($picheight,"�߶�:"&$Cro)
        _GUICtrlListBox_AddString($LogList,"ͼ����Ϣ��"&"���:"&$Row&",�߶�:"&$Cro)
        GUICtrlSetData($lettercount,"�ַ�����:4")
        GUICtrlSetData($everyheight,"ÿ�ַ���:"&$iHeight)
        GUICtrlSetData($everywidth,"ÿ�ַ���:"&$iWidth)
        _GUICtrlListBox_AddString($LogList,"�ַ�����:4,"&"ÿ�ַ���:"&$iWidth&",��:"&$iHeight)
        GUISwitch($SetForm)
        GUISetState(@SW_SHOW)        
EndFunc
Func ReadBtClick() ;ʶ��ť.   ��������ݿ��û�����ļ�,����־д�������Ϣ������.
        If Not(FileExists(@ScriptDir&"\data.db")) Then Return _GUICtrlListBox_AddString($LogList,"����,���ݿ��ļ������ڣ�")
        If $Open2="" Then Return _GUICtrlListBox_AddString($LogList,"δ����ͼ���ļ�,�޷�ʶ��")
        Local $String="",$tempstr="",$CheckNum=0,$dbstend=""
        ;��4��,��Ϊ��֤����4���ַ�.
        For $i=0 To 3 Step 1
                ;��ȡ������1,�����ж϶�ȡ���ǵڼ����ַ�.
                $CheckNum+=1
                ;��ʱ�ַ������ɺ���StartReadCode��ȡ����.
                $tempstr=StartReadCode(@ScriptDir&"\"&$i&".bmp",$ColorToRemove)
                For $j=0 To 9 Step 1
                        ;�����ݿ�.
                        $dbst=IniRead(@ScriptDir&"\data.db","data",$j,"")
                        ;�����ʱ�ַ��������ݿ��е�ĳ���ַ�����ͬ,������ҵ�������.
                        If $tempstr=$dbst Then
                                ;��λ�õ��ַ���Ϊѭ�����Ʊ���$J,
                                $String&=$j
                                ;�����ַ�����ֵ�����ս���ַ���,�����жϲ�ѯ�Ƿ�ɹ�.
                                $dbstend=IniRead(@ScriptDir&"\data.db","data",$j,"")
                                ExitLoop
                        EndIf
                Next
                Switch $CheckNum
                        Case 1
                                ;��ѯ���ǵ�һ���ַ�,��ʱ�ַ��������ղ��ҵ����ַ�����ͬ,����Ϊ���ҳɹ�,�������
                                If $tempstr=$dbstend Then
                                        GUICtrlSetData($FirstInput,$string)
                                        _GUICtrlListBox_AddString($LogList,"��ѯ��һ���ַ��ɹ����ַ�Ϊ:"&$string)
                                Else
                                        GUICtrlSetData($FirstInput,"-")
                                        _GUICtrlListBox_AddString($LogList,"��ѯ��һ���ַ�ʧ�ܣ����ݿ����޼�¼��")
                                EndIf
                        Case 2
                                If $tempstr=$dbstend Then
                                        GUICtrlSetData($SecondInput,StringRight($string,1))
                                    _GUICtrlListBox_AddString($LogList,"��ѯ�ڶ����ַ��ɹ����ַ�Ϊ:"&StringRight($string,1))
                                Else
                                        GUICtrlSetData($SecondInput,"-")
                                    _GUICtrlListBox_AddString($LogList,"��ѯ�ڶ����ַ�ʧ�ܣ����ݿ����޼�¼��")
                                EndIf
                        Case 3
                                If $tempstr=$dbstend Then
                                        GUICtrlSetData($ThirdInput,StringRight($string,1))
                                        _GUICtrlListBox_AddString($LogList,"��ѯ�������ַ��ɹ����ַ�Ϊ:"&StringRight($string,1))
                                Else
                                        GUICtrlSetData($ThirdInput,"-")
                                        _GUICtrlListBox_AddString($LogList,"��ѯ�������ַ�ʧ�ܣ����ݿ����޼�¼��")
                                EndIf
                        Case 4
                                If $tempstr=$dbstend Then
                                        GUICtrlSetData($FourthInput,StringRight($string,1))
                                        _GUICtrlListBox_AddString($LogList,"��ѯ���ĸ��ַ��ɹ����ַ�Ϊ:"&StringRight($string,1))
                                Else
                                    GUICtrlSetData($FourthInput,"-")
                                        _GUICtrlListBox_AddString($LogList,"��ѯ���ĸ��ַ�ʧ�ܣ����ݿ����޼�¼��")
                                EndIf
                EndSwitch
        Next
        GUICtrlSetData($ResultLb,$String)
        ;������֤�������.
        _GUICtrlListBox_AddString($LogList,"�����ɹ�����֤��Ϊ:"&$string)
EndFunc
Func LoadPicClick()  ;����ͼƬ
        chushihua()
        $message2 = "ѡ��ʶ����."
        $Open2 = FileOpenDialog($message2, "", "��֤�� (*.gif;*.jpg;*.bmp)", 1 )
        If @error Then
                _GUICtrlListBox_AddString($LogList,"����ͼƬ�ļ�ʧ��,ԭ��:û��ѡ���ļ�!")
        Else
                $Open2 = StringSplit($Open2, "|", @CRLF)
                If $Open2[0] = 1 Then GUICtrlSetImage ($MainPic,$Open2[1])
                _GUICtrlListBox_AddString($LogList,"����ͼƬ�ļ�:"&$Open2[1])
                ;�������е�������ϢΪ��ֵ�Ԫ,�ָ�ͼƬ,����ͼƬ��ʾ����ͼƬ��.
                myReadImageToArray(0,$Open2[1],$ResPicPos[0][0],$ResPicPos[0][1],$ResPicPos[0][2],$ResPicPos[0][3],False)  ;���
                ;myReadImageToArray($Num,$ImageFile,$ix0,$iy0,$iX,$iY,$b_Array2d=False)
                GUICtrlSetImage($FirstPic,@ScriptDir&"\0.bmp")
                myReadImageToArray(1,$Open2[1],$ResPicPos[1][0],$ResPicPos[1][1],$ResPicPos[1][2],$ResPicPos[1][3],False)
                GUICtrlSetImage($SecondPic,@ScriptDir&"\1.bmp")
                myReadImageToArray(2,$Open2[1],$ResPicPos[2][0],$ResPicPos[2][1],$ResPicPos[2][2],$ResPicPos[2][3],False)
                GUICtrlSetImage($ThirdPic,@ScriptDir&"\2.bmp")
                myReadImageToArray(3,$Open2[1],$ResPicPos[3][0],$ResPicPos[3][1],$ResPicPos[3][2],$ResPicPos[3][3],False)
                GUICtrlSetImage($FourthPic,@ScriptDir&"\3.bmp")
        EndIf
EndFunc
Func reloadclick()  ;����ͼƬ.
        If $Open2 = "" Then Return
        chushihua()
        If $Open2[0] = 1 Then GUICtrlSetImage ($MainPic,$Open2[1])
        _GUICtrlListBox_AddString($LogList,"����ͼƬ�ļ�:"&$Open2[1])
        myReadImageToArray(0,$Open2[1],$ResPicPos[0][0],$ResPicPos[0][1],$ResPicPos[0][2],$ResPicPos[0][3],False)  ;���
        GUICtrlSetImage($FirstPic,@ScriptDir&"\0.bmp")
        myReadImageToArray(1,$Open2[1],$ResPicPos[1][0],$ResPicPos[1][1],$ResPicPos[1][2],$ResPicPos[1][3],False)
        GUICtrlSetImage($SecondPic,@ScriptDir&"\1.bmp")
        myReadImageToArray(2,$Open2[1],$ResPicPos[2][0],$ResPicPos[2][1],$ResPicPos[2][2],$ResPicPos[2][3],False)
        GUICtrlSetImage($ThirdPic,@ScriptDir&"\2.bmp")
        myReadImageToArray(3,$Open2[1],$ResPicPos[3][0],$ResPicPos[3][1],$ResPicPos[3][2],$ResPicPos[3][3],False)
        GUICtrlSetImage($FourthPic,@ScriptDir&"\3.bmp")
EndFunc
;ͼƬ1  �ƶ���������  ��ʼ---
Func MoveUp1Click()  ;ͼƬ1����һ����
        If $Open2=0 Then Return
        $ResPicPos[0][0]=$ResPicPos[0][0]   ;ͼƬ���ƣ�����ͼƬ��Yֵ��1,�߶�ֵ-1
        $ResPicPos[0][2]=$ResPicPos[0][2]
        If $ResPicPos[0][1]=0 Then  ;���ͼƬ���϶�YֵΪ0,���п����Ǿ���������,��ʱͼ�θ߶�ֵС�����õĸ߶�.
                $ResPicPos[0][3]=$ResPicPos[0][3]+1  ;��ͼƬ�߶�+1
                If $ResPicPos[0][3]>$iHeight Then  ;���ͼƬ�߶ȴ������õĸ߶�,����Ϊͼ����ʾ����ȫ���߶�.
                        $ResPicPos[0][1]+=1  ;��ʱͼ�����ƾʹ���ͼ�ε��϶�Yֵ�����ƶ�һ����, ͼ�θ߶ȵ������ø߶ȼ�ȥ�ƶ�������ֵ.
                        $ResPicPos[0][3]=$iHeight-$ResPicPos[0][1]
                Else  ;���ͼ�θ߶Ȳ��������ø߶�,����Ϊͼ��ȷʵ�Ǿ���������, ͼ���϶�Yֵ����.
                        $ResPicPos[0][1]=$ResPicPos[0][1]
                EndIf
        Else  ;����϶˲�Ϊ0,����Ϊ����������,�������Ƽ���.
                If $ResPicPos[0][1]>=$iHeight Then  ;���ͼ�����϶�Yֵ����ͼ�θ߶�,����Ϊͼ���ƶ��������ϱ�, ͼ���������϶˺͸߶Ȼָ���ʼֵ.
                        $ResPicPos[0][1]=0
                        $ResPicPos[0][3]=$iHeight
                Else  ;������϶�����С��ͼ�θ߶�,���������
                        $ResPicPos[0][1]+=1
                        $ResPicPos[0][3]=$iHeight-$ResPicPos[0][1]
                EndIf
        EndIf
        ;���´�ԭʼͼƬ�в�ֳ������ƶ���������ͼ��,��־д�뵱ǰͼƬ������Ϣ,��ͼ�ο���ʾ��ǰ��ͼ��.
        myReadImageToArray(0,$Open2[1],$ResPicPos[0][0],$ResPicPos[0][1],$ResPicPos[0][2],$ResPicPos[0][3])  ;���
        _GUICtrlListBox_AddString($LogList,"�ַ�1����һ����:"&$ResPicPos[0][0]&","&$ResPicPos[0][1]&","&$ResPicPos[0][2]&","&$ResPicPos[0][3])
        GUICtrlSetImage($FirstPic,@ScriptDir&"\0.bmp")
        ;ͼ����ɫ������Ϣ�б���ʾ��ǰ����ͼƬ������������Ϣ.
        StartReadCode(@ScriptDir&"\0.bmp",$ColorToRemove)
EndFunc
Func MoveDown1Click()  ;ͼƬ1����һ����
        If $Open2=0 Then Return
        $ResPicPos[0][0]=$ResPicPos[0][0]
        If $ResPicPos[0][1]<>0 Then  ;���ͼƬ�϶����겻Ϊ0, �����ͼ�ξ��������ƶ�,
                $ResPicPos[0][1]=$ResPicPos[0][1] - 1  ;��ͼ�ε�Y����-1,ֱ��Y����Ϊ0.
                $ResPicPos[0][3]=$iHeight-$ResPicPos[0][1]  ;�߶�ֵ=10-�϶˵�Y����,����Ҫץȡ������Ϊ�϶�Y���굽�ײ�.
        Else   ;����϶�Y����Ϊ0,�����ͼ��������ʾ���Ǵ���˿�ʼ
                $ResPicPos[0][1]=$ResPicPos[0][1]  ;��ץȡ�����϶˲���, �¶������1,���߶ȼ�1..
                $ResPicPos[0][3]=$ResPicPos[0][3]-1
        EndIf
        $ResPicPos[0][2]=$ResPicPos[0][2]  ;�����ƶ���ʱ��,ͼ�ο�Ȳ���
        If $ResPicPos[0][3]<0 Then $ResPicPos[0][3]=$iHeight  ;����߶�С��0, ��λ.
        myReadImageToArray(0,$Open2[1],$ResPicPos[0][0],$ResPicPos[0][1],$ResPicPos[0][2],$ResPicPos[0][3])  ;���
        _GUICtrlListBox_AddString($LogList,"�ַ�1����һ����:"&$ResPicPos[0][0]&","&$ResPicPos[0][1]&","&$ResPicPos[0][2]&","&$ResPicPos[0][3])
        GUICtrlSetImage($FirstPic,@ScriptDir&"\0.bmp")
        StartReadCode(@ScriptDir&"\0.bmp",$ColorToRemove)
EndFunc
Func MoveRight1Click()   ;ͼƬ1����һ����
        If $Open2=0 Then Return
        $ResPicPos[0][0]=$ResPicPos[0][0] - 1 ;���Ƚ�ͼ����߽������1
        $ResPicPos[0][1]=$ResPicPos[0][1]   ;�϶�Y����
        If $ResPicPos[0][1]<0 Then $ResPicPos[0][1]=0  ;�϶�Y���С��0,����0.
        If $ResPicPos[0][0]<0 Then
                $ResPicPos[0][0]=0
                If $ResPicPos[0][2]>=0 Then  ;���ץͼ���С��0,��ץͼ��Ȼָ�.
                        $ResPicPos[0][2]=$ResPicPos[0][2] -1
                Else
                        $ResPicPos[0][2]=$iWidth
                EndIf
        Else
                $ResPicPos[0][2]=$ResPicPos[0][2]
        EndIf
        $ResPicPos[0][3]=$ResPicPos[0][3]
        myReadImageToArray(0,$Open2[1],$ResPicPos[0][0],$ResPicPos[0][1],$ResPicPos[0][2],$ResPicPos[0][3])  ;���
        GUICtrlSetImage($FirstPic,@ScriptDir&"\0.bmp")
        StartReadCode(@ScriptDir&"\0.bmp",$ColorToRemove)
        _GUICtrlListBox_AddString($LogList,"�ַ�1����һ����:"&$ResPicPos[0][0]&","&$ResPicPos[0][1]&","&$ResPicPos[0][2]&","&$ResPicPos[0][3])
EndFunc
Func MoveLef1Click()  ;ͼƬ1����һ����
        If $Open2=0 Then Return
        $ResPicPos[0][0]=$ResPicPos[0][0] +1
        If $ResPicPos[0][0]>$iWidth Then $ResPicPos[0][0]=0
        $ResPicPos[0][1]=$ResPicPos[0][1]
        If $ResPicPos[0][2]<$iWidth Then
                $ResPicPos[0][2]+=1
        Else
                $ResPicPos[0][2]=$ResPicPos[0][2]
        EndIf
        $ResPicPos[0][3]=$ResPicPos[0][3]
        myReadImageToArray(0,$Open2[1],$ResPicPos[0][0],$ResPicPos[0][1],$ResPicPos[0][2],$ResPicPos[0][3])  ;���
        GUICtrlSetImage($FirstPic,@ScriptDir&"\0.bmp")
        StartReadCode(@ScriptDir&"\0.bmp",$ColorToRemove)
        _GUICtrlListBox_AddString($LogList,"�ַ�1����һ����:"&$ResPicPos[0][0]&","&$ResPicPos[0][1]&","&$ResPicPos[0][2]&","&$ResPicPos[0][3])
EndFunc
;ͼƬ1  �ƶ���������

;ͼƬ2  �ƶ�����������ʼ---
Func MoveUp2Click()  ;ͼƬ2����һ����
        If $Open2=0 Then Return
        $ResPicPos[1][0]=$ResPicPos[1][0]   ;ͼƬ���ƣ�����ͼƬ��Yֵ��1,�߶�ֵ-1
        $ResPicPos[1][2]=$ResPicPos[1][2]
        If $ResPicPos[1][1]=0 Then
                $ResPicPos[1][3]=$ResPicPos[1][3]+1
                If $ResPicPos[1][3]>$iHeight Then
                        $ResPicPos[1][1]+=1
                        $ResPicPos[1][3]=$iHeight-$ResPicPos[1][1]
                Else
                        $ResPicPos[1][1]=$ResPicPos[1][1]
                EndIf
        Else
                If $ResPicPos[1][1]>=$iHeight Then
                        $ResPicPos[1][1]=0
                        $ResPicPos[1][3]=$iHeight
                Else
                        $ResPicPos[1][1]+=1
                        $ResPicPos[1][3]=$iHeight-$ResPicPos[1][1]
                EndIf
        EndIf
        myReadImageToArray(1,$Open2[1],$ResPicPos[1][0],$ResPicPos[1][1],$ResPicPos[1][2],$ResPicPos[1][3])  ;���
        _GUICtrlListBox_AddString($LogList,"�ַ�2����һ����:"&$ResPicPos[1][0]&","&$ResPicPos[1][1]&","&$ResPicPos[1][2]&","&$ResPicPos[1][3])
        GUICtrlSetImage($SecondPic,@ScriptDir&"\1.bmp")
        StartReadCode(@ScriptDir&"\1.bmp",$ColorToRemove)
EndFunc
Func MoveDown2Click()  ;ͼƬ2����һ����
        If $Open2=0 Then Return
        $ResPicPos[1][0]=$ResPicPos[1][0]
        If $ResPicPos[1][1]<>0 Then  ;���ͼƬ�϶����겻Ϊ0, �����ͼ�ξ��������ƶ�,
                $ResPicPos[1][1]=$ResPicPos[1][1] - 1  ;��ͼ�ε�Y����-1,ֱ��Y����Ϊ0.
                $ResPicPos[1][3]=$iHeight-$ResPicPos[1][1]  ;�߶�ֵ=10-�϶˵�Y����,����Ҫץȡ������Ϊ�϶�Y���굽�ײ�.
        Else   ;����϶�Y����Ϊ0,�����ͼ��������ʾ���Ǵ���˿�ʼ
                $ResPicPos[1][1]=$ResPicPos[1][1]  ;��ץȡ�����϶˲���, �¶������1,���߶ȼ�1..
                $ResPicPos[1][3]=$ResPicPos[1][3]-1
        EndIf
        $ResPicPos[1][2]=$ResPicPos[1][2]
        If $ResPicPos[1][3]<0 Then $ResPicPos[1][3]=$iHeight
        myReadImageToArray(1,$Open2[1],$ResPicPos[1][0],$ResPicPos[1][1],$ResPicPos[1][2],$ResPicPos[1][3])  ;���
        _GUICtrlListBox_AddString($LogList,"�ַ�2����һ����:"&$ResPicPos[1][0]&","&$ResPicPos[1][1]&","&$ResPicPos[1][2]&","&$ResPicPos[1][3])
        GUICtrlSetImage($SecondPic,@ScriptDir&"\1.bmp")
        StartReadCode(@ScriptDir&"\1.bmp",$ColorToRemove)
EndFunc
Func MoveRight2Click()  ;ͼƬ2����һ����
        If $Open2=0 Then Return
        $ResPicPos[1][0]=$ResPicPos[1][0] - 1
        $ResPicPos[1][1]=$ResPicPos[1][1]
        If $ResPicPos[1][1]<0 Then $ResPicPos[1][1]=0
        If $ResPicPos[1][0]>=0 Then
                $ResPicPos[1][0]=$ResPicPos[1][0]
        Else
                $ResPicPos[1][0]=$iWidth
        EndIf
        $ResPicPos[1][3]=$ResPicPos[1][3]
        myReadImageToArray(1,$Open2[1],$ResPicPos[1][0],$ResPicPos[1][1],$ResPicPos[1][2],$ResPicPos[1][3])  ;���
        GUICtrlSetImage($SecondPic,@ScriptDir&"\1.bmp")
        StartReadCode(@ScriptDir&"\1.bmp",$ColorToRemove)
        _GUICtrlListBox_AddString($LogList,"�ַ�2����һ����:"&$ResPicPos[1][0]&","&$ResPicPos[1][1]&","&$ResPicPos[1][2]&","&$ResPicPos[1][3])
EndFunc
Func MoveLeft2Click()  ;ͼƬ2����һ����
        If $Open2=0 Then Return
        $ResPicPos[1][0]=$ResPicPos[1][0] +1
        $ResPicPos[1][1]=$ResPicPos[1][1]
        If $ResPicPos[1][0]<$iWidth*2 Then
                $ResPicPos[1][0]=$ResPicPos[1][0]
        Else
                $ResPicPos[1][0]=$iWidth
        EndIf
        $ResPicPos[1][3]=$ResPicPos[1][3]
        myReadImageToArray(1,$Open2[1],$ResPicPos[1][0],$ResPicPos[1][1],$ResPicPos[1][2],$ResPicPos[1][3])  ;���
        GUICtrlSetImage($SecondPic,@ScriptDir&"\1.bmp")
        StartReadCode(@ScriptDir&"\1.bmp",$ColorToRemove)
        _GUICtrlListBox_AddString($LogList,"�ַ�2����һ����:"&$ResPicPos[1][0]&","&$ResPicPos[1][1]&","&$ResPicPos[1][2]&","&$ResPicPos[1][3])
EndFunc
;ͼƬ2  �ƶ�������������

;ͼƬ3  �ƶ�����������ʼ---
Func MoveUp3Click()   ;ͼƬ3����һ����
        If $Open2=0 Then Return
        $ResPicPos[2][0]=$ResPicPos[2][0]   ;ͼƬ���ƣ�����ͼƬ��Yֵ��1,�߶�ֵ-1
        $ResPicPos[2][2]=$ResPicPos[2][2]
        If $ResPicPos[2][1]=0 Then
                $ResPicPos[2][3]=$ResPicPos[2][3]+1
                If $ResPicPos[2][3]>$iHeight Then
                        $ResPicPos[2][1]+=1
                        $ResPicPos[2][3]=$iHeight-$ResPicPos[2][1]
                Else
                        $ResPicPos[2][1]=$ResPicPos[2][1]
                EndIf
        Else
                If $ResPicPos[2][1]>=$iHeight Then
                        $ResPicPos[2][1]=0
                        $ResPicPos[2][3]=$iHeight
                Else
                        $ResPicPos[2][1]+=1
                        $ResPicPos[2][3]=$iHeight-$ResPicPos[2][1]
                EndIf
        EndIf
        myReadImageToArray(2,$Open2[1],$ResPicPos[2][0],$ResPicPos[2][1],$ResPicPos[2][2],$ResPicPos[2][3])  ;���
        _GUICtrlListBox_AddString($LogList,"�ַ�3����һ����:"&$ResPicPos[2][0]&","&$ResPicPos[2][1]&","&$ResPicPos[2][2]&","&$ResPicPos[2][3])
        GUICtrlSetImage($ThirdPic,@ScriptDir&"\2.bmp")
        StartReadCode(@ScriptDir&"\2.bmp",$ColorToRemove)
EndFunc
Func MoveDown3Click()  ;ͼƬ3����һ����
        If $Open2=0 Then Return
        $ResPicPos[2][0]=$ResPicPos[2][0]
        If $ResPicPos[2][1]<>0 Then  ;���ͼƬ�϶����겻Ϊ0, �����ͼ�ξ��������ƶ�,
                $ResPicPos[2][1]=$ResPicPos[2][1] - 1  ;��ͼ�ε�Y����-1,ֱ��Y����Ϊ0.
                $ResPicPos[2][3]=$iHeight-$ResPicPos[2][1]  ;�߶�ֵ=10-�϶˵�Y����,����Ҫץȡ������Ϊ�϶�Y���굽�ײ�.
        Else   ;����϶�Y����Ϊ0,�����ͼ��������ʾ���Ǵ���˿�ʼ
                $ResPicPos[2][1]=$ResPicPos[2][1]  ;��ץȡ�����϶˲���, �¶������1,���߶ȼ�1..
                $ResPicPos[2][3]=$ResPicPos[2][3]-1
        EndIf
        $ResPicPos[2][2]=$ResPicPos[2][2]
        If $ResPicPos[2][3]<0 Then $ResPicPos[2][3]=$iHeight
        myReadImageToArray(2,$Open2[1],$ResPicPos[2][0],$ResPicPos[2][1],$ResPicPos[2][2],$ResPicPos[2][3])  ;���
        _GUICtrlListBox_AddString($LogList,"�ַ�3����һ����:"&$ResPicPos[2][0]&","&$ResPicPos[2][1]&","&$ResPicPos[2][2]&","&$ResPicPos[2][3])
        GUICtrlSetImage($ThirdPic,@ScriptDir&"\2.bmp")
        StartReadCode(@ScriptDir&"\2.bmp",$ColorToRemove)
EndFunc
Func MoveRight3Click()   ;ͼƬ3����һ����
        If $Open2=0 Then Return
        $ResPicPos[2][0]=$ResPicPos[2][0] - 1
        $ResPicPos[2][1]=$ResPicPos[2][1]
        If $ResPicPos[2][1]<0 Then $ResPicPos[2][1]=0
        If $ResPicPos[2][0]>=$iWidth Then
                $ResPicPos[2][0]=$ResPicPos[2][0]
        Else
                $ResPicPos[2][0]=$iWidth*2
        EndIf
        $ResPicPos[2][3]=$ResPicPos[2][3]
        myReadImageToArray(2,$Open2[1],$ResPicPos[2][0],$ResPicPos[2][1],$ResPicPos[2][2],$ResPicPos[2][3])  ;���
        GUICtrlSetImage($ThirdPic,@ScriptDir&"\2.bmp")
        _GUICtrlListBox_AddString($LogList,"�ַ�3����һ����:"&$ResPicPos[2][0]&","&$ResPicPos[2][1]&","&$ResPicPos[2][2]&","&$ResPicPos[2][3])
    StartReadCode(@ScriptDir&"\2.bmp",$ColorToRemove)
EndFunc
Func MoveLeft3Click()   ;ͼƬ3����һ����
        If $Open2=0 Then Return
        $ResPicPos[2][0]=$ResPicPos[2][0] +1
        $ResPicPos[2][1]=$ResPicPos[2][1]
        If $ResPicPos[2][0]<$iWidth*3 Then
                $ResPicPos[2][0]=$ResPicPos[2][0]
        Else
                $ResPicPos[2][0]=$iWidth*2
        EndIf
        $ResPicPos[2][3]=$ResPicPos[2][3]
        myReadImageToArray(2,$Open2[1],$ResPicPos[2][0],$ResPicPos[2][1],$ResPicPos[2][2],$ResPicPos[2][3])  ;���
        GUICtrlSetImage($ThirdPic,@ScriptDir&"\2.bmp")
        _GUICtrlListBox_AddString($LogList,"�ַ�3����һ����:"&$ResPicPos[2][0]&","&$ResPicPos[2][1]&","&$ResPicPos[2][2]&","&$ResPicPos[2][3])
    StartReadCode(@ScriptDir&"\2.bmp",$ColorToRemove)
EndFunc
;ͼƬ3  �ƶ�������������

;ͼƬ4  �ƶ�����������ʼ---
Func MoveUp4Click()   ;ͼƬ4����һ����
        If $Open2=0 Then Return
        $ResPicPos[3][0]=$ResPicPos[3][0]   ;ͼƬ���ƣ�����ͼƬ��Yֵ��1,�߶�ֵ-1
        $ResPicPos[3][2]=$ResPicPos[3][2]
        If $ResPicPos[3][1]=0 Then
                $ResPicPos[3][3]=$ResPicPos[3][3]+1
                If $ResPicPos[3][3]>$iHeight Then
                        $ResPicPos[3][1]+=1
                        $ResPicPos[3][3]=$iHeight-$ResPicPos[3][1]
                Else
                        $ResPicPos[3][1]=$ResPicPos[3][1]
                EndIf
        Else
                If $ResPicPos[3][1]>=$iHeight Then
                        $ResPicPos[3][1]=0
                        $ResPicPos[3][3]=$iHeight
                Else
                        $ResPicPos[3][1]+=1
                        $ResPicPos[3][3]=$iHeight-$ResPicPos[3][1]
                EndIf
        EndIf
        myReadImageToArray(3,$Open2[1],$ResPicPos[3][0],$ResPicPos[3][1],$ResPicPos[3][2],$ResPicPos[3][3])  ;���
        _GUICtrlListBox_AddString($LogList,"�ַ�4����һ����:"&$ResPicPos[3][0]&","&$ResPicPos[3][1]&","&$ResPicPos[3][2]&","&$ResPicPos[3][3])
        GUICtrlSetImage($FourthPic,@ScriptDir&"\3.bmp")
        StartReadCode(@ScriptDir&"\3.bmp",$ColorToRemove)
EndFunc
Func MoveDown4Click()  ;ͼƬ4����һ����
        If $Open2=0 Then Return
        $ResPicPos[3][0]=$ResPicPos[3][0]
        If $ResPicPos[3][1]<>0 Then  ;���ͼƬ�϶����겻Ϊ0, �����ͼ�ξ��������ƶ�,
                $ResPicPos[3][1]=$ResPicPos[3][1] - 1  ;��ͼ�ε�Y����-1,ֱ��Y����Ϊ0.
                $ResPicPos[3][3]=$iHeight-$ResPicPos[3][1]  ;�߶�ֵ=10-�϶˵�Y����,����Ҫץȡ������Ϊ�϶�Y���굽�ײ�.
        Else   ;����϶�Y����Ϊ0,�����ͼ��������ʾ���Ǵ���˿�ʼ
                $ResPicPos[3][1]=$ResPicPos[3][1]  ;��ץȡ�����϶˲���, �¶������1,���߶ȼ�1..
                $ResPicPos[3][3]=$ResPicPos[3][3]-1
        EndIf
        $ResPicPos[3][2]=$ResPicPos[3][2]
        If $ResPicPos[3][3]<0 Then $ResPicPos[3][3]=$iHeight
        myReadImageToArray(3,$Open2[1],$ResPicPos[3][0],$ResPicPos[3][1],$ResPicPos[3][2],$ResPicPos[3][3])  ;���
        _GUICtrlListBox_AddString($LogList,"�ַ�4����һ����:"&$ResPicPos[3][0]&","&$ResPicPos[3][1]&","&$ResPicPos[3][2]&","&$ResPicPos[3][3])
        GUICtrlSetImage($FourthPic,@ScriptDir&"\3.bmp")
    StartReadCode(@ScriptDir&"\3.bmp",$ColorToRemove)
EndFunc
Func MoveRight4Click()  ;ͼƬ4����һ����
        If $Open2=0 Then Return
        $ResPicPos[3][0]=$ResPicPos[3][0] - 1
        $ResPicPos[3][1]=$ResPicPos[3][1]
        If $ResPicPos[3][1]<0 Then $ResPicPos[3][1]=0
        If $ResPicPos[3][0]>=$iWidth*2 Then
                $ResPicPos[3][0]=$ResPicPos[3][0]
                If $ResPicPos[3][2]<10 Then $ResPicPos[3][2]+=1
        Else
                $ResPicPos[3][0]=$iWidth*3
        EndIf
        $ResPicPos[3][3]=$ResPicPos[3][3]
        myReadImageToArray(3,$Open2[1],$ResPicPos[3][0],$ResPicPos[3][1],$ResPicPos[3][2],$ResPicPos[3][3])  ;���
        GUICtrlSetImage($FourthPic,@ScriptDir&"\3.bmp")
        _GUICtrlListBox_AddString($LogList,"�ַ�4����һ����:"&$ResPicPos[3][0]&","&$ResPicPos[3][1]&","&$ResPicPos[3][2]&","&$ResPicPos[3][3])
    StartReadCode(@ScriptDir&"\3.bmp",$ColorToRemove)
EndFunc
Func MoveLeft4Click()  ;ͼƬ4����һ����
        If $Open2=0 Then Return
        $ResPicPos[3][0]=$ResPicPos[3][0] +1
        $ResPicPos[3][1]=$ResPicPos[3][1]
        
        If $ResPicPos[3][0]<$iWidth*40 Then
                $ResPicPos[3][0]=$ResPicPos[3][0]
                $ResPicPos[3][2]=40-$ResPicPos[3][0]
                If $ResPicPos[3][2]>$iWidth Then $ResPicPos[3][2]=$iWidth
        Else
                $ResPicPos[3][0]=$iWidth*3
        EndIf
        $ResPicPos[3][3]=$ResPicPos[3][3]
        ;myReadImageToArray($Num,$ImageFile,$ix0,$iy0,$iX,$iY,$b_Array2d=False)
        myReadImageToArray(3,$Open2[1],$ResPicPos[3][0],$ResPicPos[3][1],$ResPicPos[3][2],$ResPicPos[3][3])  ;���
        GUICtrlSetImage($FourthPic,@ScriptDir&"\3.bmp")
        _GUICtrlListBox_AddString($LogList,"�ַ�4����һ����:"&$ResPicPos[3][0]&","&$ResPicPos[3][1]&","&$ResPicPos[3][2]&","&$ResPicPos[3][3])
    StartReadCode(@ScriptDir&"\3.bmp",$ColorToRemove)
EndFunc
;ͼƬ4  �ƶ�������������

;ͼƬ��֤�����
Func FirstClick()  ;��һ��ʶ�������
        Local $Code=GUICtrlRead($FirstInput)  ;�ӵ�һ����֤��������ȡҪ�����������ĸ��ַ�
        $CodeDB=startreadcode(@ScriptDir&"\0.bmp",$ColorToRemove)
        If $Code="" Then
                _GUICtrlListBox_AddString($LogList,"��ʲô�����䣬�����ݿ�ѧʲô��")
                Return
        Else
                IniWrite(@ScriptDir&"\data.db","data",$Code,$CodeDB)
            _GUICtrlListBox_AddString($LogList,"�ַ�һ���ɹ�������Ϊ"&$Code&"="&$CodeDB)
        EndIf
EndFunc
Func SecondClick()  ;�ڶ�����֤��������Ϻ�,���
        Local $Code=GUICtrlRead($SecondInput)  ;�ӵ�һ����֤��������ȡҪ�����������ĸ��ַ�
        $CodeDB=startreadcode(@ScriptDir&"\1.bmp",$ColorToRemove)
        If $Code="" Then
                _GUICtrlListBox_AddString($LogList,"��ʲô�����䣬�����ݿ�ѧʲô��")
                Return
        Else
                IniWrite(@ScriptDir&"\data.db","data",$Code,$CodeDB)
            _GUICtrlListBox_AddString($LogList,"�ַ������ɹ�������Ϊ"&$Code&"="&$CodeDB)
        EndIf
EndFunc
Func ThirdClick()  ;��������֤��������Ϻ�,���
        Local $Code=GUICtrlRead($ThirdInput)  ;�ӵ�һ����֤��������ȡҪ�����������ĸ��ַ�
        $CodeDB=startreadcode(@ScriptDir&"\2.bmp",$ColorToRemove)
        If $Code="" Then
                _GUICtrlListBox_AddString($LogList,"��ʲô�����䣬�����ݿ�ѧʲô��")
                Return
        Else
                IniWrite(@ScriptDir&"\data.db","data",$Code,$CodeDB)
            _GUICtrlListBox_AddString($LogList,"�ַ������ɹ�������Ϊ"&$Code&"="&$CodeDB)
        EndIf
EndFunc
Func FourthClick()   ;���ĸ���֤��������Ϻ�,���
        Local $Code=GUICtrlRead($FourthInput)  ;�ӵ�һ����֤��������ȡҪ�����������ĸ��ַ�
        $CodeDB=startreadcode(@ScriptDir&"\3.bmp",$ColorToRemove)
        If $Code="" Then
                _GUICtrlListBox_AddString($LogList,"��ʲô�����䣬�����ݿ�ѧʲô��")
                Return
        Else
                IniWrite(@ScriptDir&"\data.db","data",$Code,$CodeDB)
            _GUICtrlListBox_AddString($LogList,"�ַ������ɹ�������Ϊ"&$Code&"="&$CodeDB)
        EndIf
EndFunc

Func myArrayChangeSC($func_array, $func_sc_type=0, $func_sc=0x777777, $func_bg=0xffffff);�����е���ɫֵ���ڰױ仯
        If Not IsArray($func_array) Or $func_sc_type<1 Or $func_sc_type>3 Or $func_sc_type=0 Then Return $func_array
        If UBound($func_array,2)>0 Then;��ά
                Local $i_width=UBound($func_array,1)
                Local $i_height=UBound($func_array,2)
                Local $a_return[$i_width][$i_height], $x, $y, $s
                For $y=0 To $i_height-1
                        For $x= 0 To $i_width-1
                                $a_return[$x][$y]= $func_array[$x][$y]
                                Select
                                Case $func_sc_type=1;�ڰ�
                                        If $a_return[$x][$y]>=$func_sc Then
                                                $a_return[$x][$y]=$func_bg
                                        Else
                                                $a_return[$x][$y]=0
                                        EndIf
                                Case $func_sc_type=2;����ڰ�
                                        If $a_return[$x][$y]<$func_sc Then
                                                $a_return[$x][$y]=$func_bg
                                        Else
                                                $a_return[$x][$y]=0
                                        EndIf
                                Case $func_sc_type=3;�൱��=1,����ɫ��ԭɫ����(���Ǳ���ԭɫ)
                                        If $a_return[$x][$y]>=$func_sc Then
                                                $a_return[$x][$y]=$func_bg
                                        EndIf
                                EndSelect
                        Next
                Next
        Else
                Local $i_height=UBound($func_array)
                Local $a_return[$i_height], $y
                For $y=0 To $i_height-1
                        $a_return[$y] = myChangeRegExpSC($func_array[$y], $func_sc_type, $func_sc, $func_bg);����仯
                Next
        EndIf
        Return $a_return
EndFunc

;���������������ǹ�myArrayChangeSCʹ�õ�,������ϸ������
Func myChangeRegExpSC($func_string, $func_sc_type=0, $func_sc=0xeeeeee, $func_bg=0xffffff);�������ڰױ仯
        If $func_string="" Or $func_sc_type<1 Or $func_sc_type>3 Or Mod(StringLen($func_string),6)<>0 Then Return $func_string
        $func_string = StringRegExpReplace($func_string, ".{6}", "$0,")
        $func_sc = myGetRegExpSC($func_sc)
        ;ConsoleWrite($func_sc&@CRLF)
        $func_string = StringRegExpReplace($func_string,$func_sc,"______")
        Select
        Case $func_sc_type=1
                $func_string = StringRegExpReplace($func_string,"[0-9A-F]{6},","000000")
                $func_string = StringReplace($func_string,"______,",Hex($func_bg,6))
        Case $func_sc_type=2
                $func_string = StringRegExpReplace($func_string,"[0-9A-F]{6},",Hex($func_bg,6))
                $func_string = StringReplace($func_string,"______,","000000")
        Case $func_sc_type=3
                $func_string = StringReplace($func_string,"______,",Hex($func_bg,6))
                $func_string = StringReplace($func_string,",", "")
        EndSelect 
        Return $func_string
EndFunc
Func myGetRegExpSC($func_sc=0x777777);��ȡ�仯�ڰ��ٽ�ֵ��������ʽ,��myChangeRegExpSC����
        $func_sc=Hex($func_sc,6)
        Local $i,$s,$s_RegExp
        For $i=1 To 6
                $s=StringLeft($func_sc,$i)
                If StringRight($s,1)<>"F" Then
                        Select
                        Case $i=6
                                $s_RegExp &= myRegExp(StringLeft($s,5)) & myRegExp(StringRight($s,1))
                        Case $i=5
                                $s_RegExp &=myRegExp(Hex(Number("0x"&$s)+1,$i))&"[0-9A-F]|"
                        Case Else
                                $s_RegExp &=myRegExp(Hex(Number("0x"&$s)+1,$i)) & "[0-9A-F]{"&6-$i&"}|"
                        EndSelect
                EndIf
        Next
        If StringRight($s_RegExp,1)="|" Then $s_RegExp=StringTrimRight($s_RegExp,1)
        Return $s_RegExp
EndFunc
Func myRegExp($func_string);��myGetRegExpSC����,���ַ�ת����
        If $func_string="" Then Return ""
        Local $s_RegExp="", $s_tmp=""
        For $i=1 To StringLen($func_string)
                $s_tmp=Number("0x"&StringMid($func_string, $i,1))
                Select
                Case $s_tmp<9
                        $s_RegExp &="["&$s_tmp &"-9A-F]"
                Case $s_tmp=9
                        $s_RegExp &="[9A-F]"
                Case $s_tmp=0xF
                        $s_RegExp &="[F]"
                Case Else
                        $s_RegExp &="["&Hex($s_tmp,1)&"-F]"
                EndSelect
        Next
        Return $s_RegExp
EndFunc

;����Ϊǰ���Ѿ�˵�����ĺ���,��ͼ���ļ������ά����
;-----------------------------------------------------------------------------------------------

Func myReadImageToArray($Num,$ImageFile,$ix0,$iy0,$iX,$iY,$b_Array2d=False);�ɹ��򷵻�����.ʧ�ܷ���0.$b_Array2d=True���ض�ά����,=False����һά����
    Local $hBitmap, $BitmapData, $i_width, $i_height, $Scan0, $pixelData, $s_BMPData, $i_Stride
        Local $hClone, $hImage
        _GDIPlus_Startup()
    $hBitmap = _GDIPlus_BitmapCreateFromFile($ImageFile)
        $i_width = _GDIPlus_ImageGetWidth($hBitmap)
        $i_height = _GDIPlus_ImageGetHeight($hBitmap)
        $Row=$i_width
        $Cro=$i_height
        $hClone = _GDIPlus_BitmapCloneArea($hBitmap, $ix0, $iy0, $iX, $iY)
        _GDIPlus_ImageSaveToFile($hClone, @ScriptDir&"\"&$Num &".bmp")
        If @error Then 
                MsgBox(0,"","wrong")
                _GDIPlus_ShutDown ()
                Return 0;��Ч��ͼ���ļ���δ�ҵ����ļ�
        EndIf
    $BitmapData = _GDIPlus_BitmapLockBits($hBitmap, 0, 0, $i_width, $i_height, $GDIP_ILMREAD, $GDIP_PXF24RGB)
    $i_Stride = DllStructGetData($BitmapData, "Stride");Stride - Offset, in bytes, between consecutive scan lines of the bitmap. If the stride is positive, the bitmap is top-down. If the stride is negative, the bitmap is bottom-up.
    $Scan0 = DllStructGetData($BitmapData, "Scan0");Scan0 - Pointer to the first (index 0) scan line of the bitmap.
    $pixelData = DllStructCreate("ubyte lData[" & (Abs($i_Stride) * $i_height) & "]", $Scan0)
    $s_BMPData = DllStructGetData($pixelData, "lData")
    $s_BMPData = StringTrimLeft($s_BMPData,2);ȥ��ͷ��"0x"
    _GDIPlus_BitmapUnlockBits($hBitmap, $BitmapData)
    _GDIPlus_ImageDispose($hBitmap)
        _GDIPlus_ImageDispose($hClone)
        _WinAPI_DeleteObject ($hBitmap)
        _GDIPlus_Shutdown()
       
        If $b_Array2d Then;Ҫ�󷵻ض�ά����
                Local $a_return[$i_width][$i_height], $x, $y, $s
                For $y=0 To $i_height-1
                $s=StringMid($s_BMPData, $y*($i_Stride*2)+1, $i_width*6)
                ;��Ҫʹ��һЩ�����������$s=StringMid($s_BMPData, $y*($i_width*6)+1, $i_width*6),��ʵ�ʲ���,�÷�ʽ�޷���ȷ����:
                ;GIF����,���������ݵ�ͼ���ļ�(һ�����ݼ��ܷ�ʽ),���߶�ҳͼ���ļ�,��Ȼ��Щ���αȽ��ټ�,��ͬ
                For $x= 0 To $i_width-1
                $a_return[$x][$y]= Number("0x"&StringMid($s,$x*6+1 ,6))
                Next
                Next
        Else;Ҫ�󷵻�һά����
                Local $a_return[$i_height], $y
                For $y=0 To $i_height-1
                        $a_return[$y]=StringMid($s_BMPData, $y*($i_Stride*2)+1, $i_width*6)
                        ;����˵��
                Next
        EndIf
        Return $a_return
EndFunc  ;==>myReadImageToArray

Func StartReadCode($FileName,$ColorFlg)
        $ResultString=""
        GUICtrlSetData($CodeList,"")
        ;myReadImageToArray($Num,$ImageFile,$ix0,$iy0,$iX,$iY,$b_Array2d=False)
        $a_Image = myReadImageToArray(0,$FileName,0,0,0,0,False)
        $a_Image = myArrayChangeSC($a_Image, 1, $ColorFlg, 0xffffff)  
        for $line=0 to $Cro-1 Step 1
                $a_Image[$line]=StringReplace($a_Image[$line],"FFFFFF","F")  ;���������е�6λ��ɫ��Ϣת��Ϊ1λ����ɫ��Ϣ
                $a_Image[$line]=StringReplace($a_Image[$line],"000000","0")
                _GUICtrlListBox_AddString($CodeList,$a_Image[$line])  ;������Ϣ����������б���.
                $ResultString&=$a_Image[$line]   ;ÿ�е���ɫ��Ϣ������ַ���,������������ݿ�.
        Next
        Return $ResultString
EndFunc