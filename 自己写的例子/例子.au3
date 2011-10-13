#include <GuiListView.au3>
#include <GuiImageList.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <ListViewConstants.au3>
Opt("TrayMenuMode",1)
$dir = @ScriptDir&"\Database.ini"
$pei = @ScriptDir&"\config.ini"

$Form1 = GUICreate("�û����Ϲ���", 800, 600, -1, -1, BitOR($WS_MINIMIZEBOX,$WS_CAPTION,$WS_POPUP,$WS_GROUP,$WS_BORDER,$WS_CLIPSIBLINGS))
GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
$hListView = GUICtrlCreateListView("�������  |�����ͺ�  |���۲���|��������    |������Ա |�û����� |�û��绰  |�û��ֻ�  |�û���ַ                    |���۱�ע                    | ", _
10, 10, 780, 500,-1, BitOR($WS_EX_CLIENTEDGE,$LVS_EX_FULLROWSELECT,$LVS_REPORT))

$hImage = _GUIImageList_Create(1, 25)
_GUICtrlListView_SetImageList($hListView, $hImage, 1)

$Button1 = GUICtrlCreateButton("ˢ��", 600, 530, 70, 30, $WS_GROUP)
$Button2 = GUICtrlCreateButton("�˳�", 700, 530, 70, 30, $WS_GROUP)
$Button3 = GUICtrlCreateButton("��ʼ����", 483, 533, 60, 26, $WS_GROUP)
Dim $AccelKeys[1][2] = [["{Enter}", $Button3]]
GUISetAccelerators($AccelKeys)

$Input1 = GUICtrlCreateInput("������������", 302, 535, 180, 21)

$shuju = GUICtrlCreateLabel("Ŀǰ����0������", 10, 533, 180, 20)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")


$caidan = GUICtrlCreateMenu("����")
$daoru = GUICtrlCreateMenuItem("�������", $caidan)
$tuichu = GUICtrlCreateMenuItem("�رճ���", $caidan)
GUICtrlSetState(-1, $GUI_DEFBUTTON)

;�Ҽ��˵�
$zhucaidan = GUICtrlCreateContextMenu($hListView)
$tianjia = GUICtrlCreateMenuItem("�������        ", $zhucaidan)
$shanchu = GUICtrlCreateMenuItem("ɾ������", $zhucaidan)
$xiugai = GUICtrlCreateMenuItem("�޸�����", $zhucaidan)
$shuaxin = GUICtrlCreateMenuItem("ˢ������", $zhucaidan)
$sousuo = GUICtrlCreateMenuItem("��������", $zhucaidan)
GUICtrlCreateMenuItem("", $zhucaidan) 

$pailie = GUICtrlCreateMenu("���з�ʽ", $zhucaidan)
$plshijian = GUICtrlCreateMenuItem("¼��ʱ��", $pailie)
$plriqi = GUICtrlCreateMenuItem("��������", $pailie)

$fileitem = GUICtrlCreateMenuItem("�������", $zhucaidan)
GUICtrlCreateMenuItem("", $zhucaidan)    

$infoitem = GUICtrlCreateMenuItem("�رճ���", $zhucaidan)
;===>�Ҽ��˵�

;���̲˵�
$xscx = TrayCreateItem("��ʾ����")
$yccx = TrayCreateItem("���س���")
$gycx = TrayCreateItem("���ڳ���")
TrayCreateItem("")
$gbcx = TrayCreateItem("�رճ���")
;===>���̲˵�
GUISetState(@SW_SHOW)
xian()

While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
                Case -3,$Button2,$tuichu,$infoitem
                        Exit
                Case $tianjia
                        tianjia()                        
                Case $shanchu
                        shanchu()
                Case $Button1,$shuaxin
                        xian()
                Case $sousuo,$Button3
                        sousuo()
                Case $xiugai

        EndSwitch        
        
        $msg = TrayGetMsg()
        Switch $msg
                Case $xscx
                        GUISetState(@SW_SHOW)
                Case $yccx
                        GUISetState(@SW_HIDE)
                Case $gycx
                        MsgBox(64,"���ڳ���","���û����Ϲ����˳���Ϊ�ڽ�Ӣ�ع�˾ר�ã�")
                Case $gbcx
                        Exit
        EndSwitch

WEnd


Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

Func WM_NOTIFY($hWndGUI, $MsgID, $WParam, $LParam)

        Local $tagNMHDR, $Event, $hWndFrom, $IDFrom
        Local $tagNMHDR = DllStructCreate("int;int;int", $LParam)
        If @error Then Return $GUI_RUNDEFMSG
        $IDFrom = DllStructGetData($tagNMHDR, 2)
        $Event = DllStructGetData($tagNMHDR, 3)
        $tagNMHDR = 0
        Switch $IDFrom;ѡ������¼��Ŀؼ�

                        Case $hListView

                                Switch $Event; ѡ��������¼�

                                        Case $NM_CLICK ; ���
;~                                         ...
                                        Case $NM_DBLCLK ; ˫��
                                                        shuangji()
                                        Case $NM_RCLICK ; �һ�

                                EndSwitch
        EndSwitch 
        Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY


Func xian()
        $z = 0
        _GUICtrlListView_DeleteAllItems($hListView)
        $bianhao = IniReadSectionNames($dir)
        If Not @error Then        
                For $i = 1 To $bianhao[0]
                        GUICtrlCreateListViewItem($bianhao[$i], $hListView)
                
                        $xinghao = IniRead($dir,$bianhao[$i],"�����ͺ�","NotFound")
                        _GUICtrlListView_AddSubItem($hListView, $z, $xinghao, 1, $z+1)
                
                        $bumen = IniRead($dir,$bianhao[$i],"���۲���","NotFound")
                        _GUICtrlListView_AddSubItem($hListView, $z, $bumen, 2, $z+1)
                
                        $riqi = IniRead($dir,$bianhao[$i],"��������","NotFound")
                        _GUICtrlListView_AddSubItem($hListView, $z, $riqi, 3, $z+1)
                
                        $fuwu = IniRead($dir,$bianhao[$i],"������Ա","NotFound")
                        _GUICtrlListView_AddSubItem($hListView, $z, $fuwu, 4, $z+1)
                
                        $xingming = IniRead($dir,$bianhao[$i],"�û�����","NotFound")
                        _GUICtrlListView_AddSubItem($hListView, $z, $xingming, 5, $z+1)
                
                        $dianhua = IniRead($dir,$bianhao[$i],"�û��绰","NotFound")
                        _GUICtrlListView_AddSubItem($hListView, $z, $dianhua, 6, $z+1)
                
                        $shouji = IniRead($dir,$bianhao[$i],"�û��ֻ�","NotFound")
                        _GUICtrlListView_AddSubItem($hListView, $z, $shouji, 7, $z+1)
                
                        $dizhi = IniRead($dir,$bianhao[$i],"�û���ַ","NotFound")
                        _GUICtrlListView_AddSubItem($hListView, $z, $dizhi, 8, $z+1)
                
                        $beizhu = IniRead($dir,$bianhao[$i],"���۱�ע","NotFound")
                        _GUICtrlListView_AddSubItem($hListView, $z, $beizhu, 9, $z+1)
                        
                        GUICtrlSetData($shuju,"��ǰ����"&$z+1&"������")
                        $z += 1
                Next
        EndIf
EndFunc        

Func tianjia()
        GUISetState(@SW_DISABLE,$Form1)  
        $Form2 = GUICreate("��������Ҫ��ӵ�����", 400, 280, -1, -1, BitOR _
        ($WS_MINIMIZEBOX,$WS_CAPTION,$WS_POPUP,$WS_GROUP,$WS_BORDER,$WS_CLIPSIBLINGS))
        $Button11 = GUICtrlCreateButton("����", 200, 230, 80, 30, $WS_GROUP)
        $Button12 = GUICtrlCreateButton("�˳�", 300, 230, 80, 30, $WS_GROUP)

        $Label1 = GUICtrlCreateLabel("�������:", 20, 23, 55, 17)
        $Label2 = GUICtrlCreateLabel("�����ͺ�:", 20, 53, 55, 17)
        $Label3 = GUICtrlCreateLabel("�û�����:", 20, 83, 55, 17)
        $Label4 = GUICtrlCreateLabel("�û��绰:", 20, 113, 55, 17)
        $Label5 = GUICtrlCreateLabel("���۲���:", 200, 23, 55, 17)
        $Label6 = GUICtrlCreateLabel("��������:", 200, 53, 55, 17)
        $Label7 = GUICtrlCreateLabel("������Ա:", 200, 83, 55, 17)
        $Label8 = GUICtrlCreateLabel("�û��ֻ�:", 200, 113, 55, 17)
        $Label9 = GUICtrlCreateLabel("�û���ַ:", 20, 143, 55, 17)
        $Label10 = GUICtrlCreateLabel("���۱�ע:", 20, 173, 55, 17)

        $Input1 = GUICtrlCreateInput("", 80, 20, 100, 21)
        GUICtrlSetState(-1, $GUI_FOCUS)
        $Input2 = GUICtrlCreateInput("", 80, 50, 100, 21)
        $Input3 = GUICtrlCreateInput("", 80, 80, 100, 21)
        $Input4 = GUICtrlCreateInput("", 80, 110, 100, 21)
        $Input5 = GUICtrlCreateCombo("", 260, 20, 120, 21)
        GUICtrlSetData(-1, "����|�ݴ���|�ۺ�|��ҵ��", "����")
        $Input6 = GUICtrlCreateDate("", 260, 50, 120, 21)
        $Input7 = GUICtrlCreateCombo("", 260, 80, 120, 21)
        GUICtrlSetData(-1, "����|��Ӣ|����|�|СΤ", "����")
        $Input8 = GUICtrlCreateInput("", 260, 110, 120, 21)
        $Input9 = GUICtrlCreateInput("", 80, 140, 300, 21)
        $Input10 = GUICtrlCreateInput("", 80, 170, 300, 21)
        GUISetState(@SW_SHOW)

        While 1
                $nMsg = GUIGetMsg()
                Switch $nMsg
                        Case -3,$Button12
                                        GUISetState(@SW_ENABLE,$Form1)         ;���ø�����
                                        GUIDelete($Form2)                      ;;ɾ��ָ�����ں������������пؼ�.
                                        ExitLoop    
                                        ;Exit
                        Case $Button11
                                        $z = _GUICtrlListView_GetItemCount($hListView)
                                        $xuhao = GUICtrlRead($Input1)
                                        $xinghao = GUICtrlRead($Input2)
                                        $xingming = GUICtrlRead($Input3)
                        $dianhua = GUICtrlRead($Input4)
                                        $bumen = GUICtrlRead($Input5)
                        $riqi = GUICtrlRead($Input6)
                         $fuwu = GUICtrlRead($Input7)
                        $shouji = GUICtrlRead($Input8)
                        $dizhi = GUICtrlRead($Input9)
                        $beizhu = GUICtrlRead($Input10)
        
                                        If $xuhao <> "" And $xinghao <> "" Then
                                                IniWrite($dir,$xuhao,"�����ͺ�",$xinghao)
                                                IniWrite($dir,$xuhao,"���۲���",$bumen)
                            IniWrite($dir,$xuhao,"��������",$riqi)
                                                IniWrite($dir,$xuhao,"������Ա",$fuwu)
                                                IniWrite($dir,$xuhao,"�û�����",$xingming)
                            IniWrite($dir,$xuhao,"�û��绰",$dianhua)
                            IniWrite($dir,$xuhao,"�û��ֻ�",$shouji)
                                                IniWrite($dir,$xuhao,"�û���ַ",$dizhi)
                            IniWrite($dir,$xuhao,"���۱�ע",$beizhu&@CRLF)
                                                
                                                GUICtrlCreateListViewItem($xuhao, $hListView)
                                                _GUICtrlListView_AddSubItem($hListView, $z, $xinghao, 1, $z+1)                
                                                _GUICtrlListView_AddSubItem($hListView, $z, $bumen, 2, $z+1)                
                                                _GUICtrlListView_AddSubItem($hListView, $z, $riqi, 3, $z+1)
                                                _GUICtrlListView_AddSubItem($hListView, $z, $fuwu, 4, $z+1)
                                                _GUICtrlListView_AddSubItem($hListView, $z, $xingming, 5, $z+1)
                                                _GUICtrlListView_AddSubItem($hListView, $z, $dianhua, 6, $z+1)
                                                _GUICtrlListView_AddSubItem($hListView, $z, $shouji, 7, $z+1)
                                                _GUICtrlListView_AddSubItem($hListView, $z, $dizhi, 8, $z+1)
                                                _GUICtrlListView_AddSubItem($hListView, $z, $beizhu, 9, $z+1)
                                                GUICtrlSetData($shuju,"��ǰ����"&$z+1&"������")
        
                                                MsgBox(0,"����ɹ�","������ţ�"&$xuhao&@CRLF&@CRLF&"�����ͺţ�"&$xinghao&@CRLF&@CRLF& _
                                                "���۲��ţ�"&$bumen&@CRLF&@CRLF&"�������ڣ�"&$riqi&@CRLF&@CRLF&"������Ա��"&$fuwu&@CRLF&@CRLF& _
                                                "�û�������"&$xingming&@CRLF&@CRLF&"�û��绰��"&$dianhua&@CRLF&@CRLF&"�û��ֻ���"&$shouji&@CRLF&@CRLF& _
                                                "�û���ַ��"&$dizhi&@CRLF&@CRLF&"���۱�ע��"&$beizhu)
                                        Else
                                                MsgBox(64,"��ʾ","����ȷ����������ݣ������޷������Ŀ��")
                                        EndIf
                EndSwitch
        WEnd
EndFunc

Func shanchu()
        $a = _GUICtrlListView_GetSelectedIndices($hListView)
        $b = _GUICtrlListView_GetItemTextString($hListView, Number($a))
        $chaifen = StringSplit($b,"|")

        $a = MsgBox(32+1,"��ʾ","��ȷ���Ƿ�Ҫɾ����������        "&@CRLF&@CRLF&"������ţ�"&$chaifen[1]&@CRLF&@CRLF&"�����ͺţ�"&$chaifen[2]&@CRLF&@CRLF& _
        "���۲��ţ�"&$chaifen[3]&@CRLF&@CRLF&"�������ڣ�"&$chaifen[4]&@CRLF&@CRLF&"������Ա��"&$chaifen[5]&@CRLF&@CRLF& _
        "�û�������"&$chaifen[6]&@CRLF&@CRLF&"�û��绰��"&$chaifen[7]&@CRLF&@CRLF&"�û��ֻ���"&$chaifen[8]&@CRLF&@CRLF& _
        "�û���ַ��"&$chaifen[9]&@CRLF&@CRLF&"���۱�ע��"&$chaifen[10])
        If $a = 1 Then
                _GUICtrlListView_DeleteItemsSelected($hListView) ;ɾ��ѡ����Ŀ
                IniDelete($dir,$chaifen[1])
                $z = _GUICtrlListView_GetItemCount($hListView)
                GUICtrlSetData($shuju,"��ǰ����"&$z&"������")
                ;MsgBox(48, "��ʾ", "����ɾ���ɹ�")
        EndIf
EndFunc   ;==>shanchu

Func shuangji()
        $a = _GUICtrlListView_GetSelectedIndices($hListView)
        $b = _GUICtrlListView_GetItemTextString($hListView, Number($a))
        $chaifen = StringSplit($b,"|")
        If Not StringLen($a) Then; ���������ж��Ƿ�ѡ����ListViewItem
                ;MsgBox(48, "��ʾ", "��ѡ����Ҫɾ���ĺ���")
        Return
        EndIf
                $a = MsgBox(64,"���ݲ鿴","�����������£�                  "&@CRLF&@CRLF&"������ţ�"&$chaifen[1]&@CRLF&@CRLF&"�����ͺţ�"&$chaifen[2]&@CRLF&@CRLF& _
                "���۲��ţ�"&$chaifen[3]&@CRLF&@CRLF&"�������ڣ�"&$chaifen[4]&@CRLF&@CRLF&"������Ա��"&$chaifen[5]&@CRLF&@CRLF& _
                "�û�������"&$chaifen[6]&@CRLF&@CRLF&"�û��绰��"&$chaifen[7]&@CRLF&@CRLF&"�û��ֻ���"&$chaifen[8]&@CRLF&@CRLF& _
                "�û���ַ��"&$chaifen[9]&@CRLF&@CRLF&"���۱�ע��"&$chaifen[10])
EndFunc        
        
Func sousuo()        
        $a = GUICtrlRead($Input1)
        $sou = _GUICtrlListView_FindInText($hListView,$a)
        _GUICtrlListView_ClickItem($hListView,$sou)
        ;MsgBox(0,"",$sou)                
EndFunc                