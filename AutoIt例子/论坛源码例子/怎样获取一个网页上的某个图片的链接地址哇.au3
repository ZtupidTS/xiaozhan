#AutoIt3Wrapper_UseAnsi=n

#include <IE.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <ListViewConstants.au3>
#include <StaticConstants.au3>
#include <StatusBarConstants.au3>
#include <WindowsConstants.au3>
#include <GuiStatusBar.au3>


Dim $sn
Dim $urls[100]
Dim $item[100]


#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Form1", 579, 463, 193, 125)
$Input1 = GUICtrlCreateInput("", 8, 32, 450, 21)
$Label1 = GUICtrlCreateLabel("����������ı����������ַ", 8, 8, 160, 17)
$Button1 = GUICtrlCreateButton("��ʼ��ȡ", 465, 32, 65, 25, 0)
$button2 = GUICtrlCreateButton("����", 533, 32)
GUICtrlSetState($button2, $GUI_DISABLE)
$ListView1 = GUICtrlCreateListView("���|������  |��ַ                  ", 8, 64, 561, 361)
$StatusBar1 = _GUICtrlStatusBar_Create($Form1)
Dim $StatusBar1_PartsWidth[1] = [250]
_GUICtrlStatusBar_SetParts($StatusBar1, $StatusBar1_PartsWidth)
_GUICtrlStatusBar_SetText($StatusBar1, "δ��ʼ", 0)
_GUICtrlStatusBar_SetMinHeight($StatusBar1, 25)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
                Case $GUI_EVENT_CLOSE
                        Exit

                Case $Button1
                        If (GUICtrlRead($Input1) <> "") Then
                                work()
                        EndIf
                Case $button2
                        down()
        EndSwitch
WEnd


Func error($err)
        MsgBox(0, 0, $err)
EndFunc   ;==>error


Func work()
        $url = GUICtrlRead($Input1)
        _GUICtrlStatusBar_SetText($StatusBar1, "���ڴ������")
        $oIE = _IECreate($url, 0, 0, 1, 0)
        
        $doc = _IEFormGetCollection($oIE, 1)
        $elements = _IETagNameGetCollection($doc, "a")
        $n = 1

        Dim $SongName[100]
        $sn = 0;
        _GUICtrlStatusBar_SetText($StatusBar1, "���ڻ�ȡ��������Ϣ")
        For $i In $elements
                If (Mod($n, 6) = 1) Then
                        $SongName[$sn] = $i.innerHTML
                        $sn = $sn + 1
                EndIf
                
;### Tidy Error: If/ElseIf statement without a then..
                If ($n = 1) Then
                        $src = $i.href
                EndIf
                $n = $n + 1
        Next
        
        _GUICtrlStatusBar_SetText($StatusBar1, "���ڴ򿪲����б�")
        $oIE = _IECreate($src, 1, 0, 1, 0)
        $mp = _IEGetObjById($oIE, "MediaWrapper")
        $object = _IEGetObjById($mp, "MediaPlayer")
        $code = $object.innerHTML
        $sub = "wma"
        $code = StringMid($code, 26)
        $url = StringLeft($code, StringInStr($code, Chr(34)) - 1);��һ�׵ĵ�ַ

        $urlcomm = StringTrimRight($url, 6)
        _GUICtrlStatusBar_SetText($StatusBar1, "�������ɵ�ַ�б�")
        For $i = 1 To $sn
                $urls[$i - 1] = $urlcomm
                If ($i < 10) Then
                        $urls[$i - 1] = $urls[$i - 1] & "0"
                EndIf
                $urls[$i - 1] = $urls[$i - 1] & $i & ".wma"
        Next
        
        _GUICtrlStatusBar_SetText($StatusBar1, "���ڽ����ݼ����б�")
        For $i = 0 To $sn - 1
                $item[$i] = GUICtrlCreateListViewItem(String($i + 1), $ListView1)
                GUICtrlSetData($item[$i], "|" & $SongName[$i])
                GUICtrlSetData($item[$i], "||" & $urls[$i])
        Next
        
        _GUICtrlStatusBar_SetText($StatusBar1, "��ȡ�ɹ������Ե�����ذ�ť����")
        GUICtrlSetState($button2, $GUI_ENABLE)
EndFunc   ;==>work

Func down()
        $thunder = ObjCreate("ThunderAgent.Agent")
        ;AddTask4(URL,ע�����ƣ�Ŀ¼����������ʱ���ƣ�����ҳ��-1��0��-1��cookie��
        For $i = 0 To $sn - 1
                $thunder.AddTask4($urls[$i], String($i + 1) & ".wma", "d:\temp", "", "", -1, 0, -1, "", "", "")
        Next

        $thunder.CommitTasks2(1)
EndFunc   ;==>down