#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <IE.au3>

$Form1 = GUICreate("��֤�봰����ʾ   QQ:76594695  ˧������ ", 333, 211)
$Label1 = GUICtrlCreateLabel("��֤�룺", 16,43, 70, 17)
GUICtrlSetFont(-1, 12, 400, 0, "����")
GUICtrlSetColor(-1, 0xFF0000)
$Button1 = GUICtrlCreateButton("������֤��", 112, 150, 97, 33, 0)
$oIE_code = _IECreateEmbedded ()
$GUIActiveX = GUICtrlCreateObj($oIE_code, 80,24,150,50);������ǶIE ���ڴ�С
_IENavigate ($oIE_code, "about:blank",1)
;����һ���հ���ҳ�������Զ�һ����ҳ������֤��ͼƬ��ʾ������룬�������룬������HTMLӦ������ʲô��˼
$oBody = _IETagNameGetCollection($oIE_code, "body", 0)
_IEDocInsertHTML($oBody, 'IE������...', "afterbegin");��Ƕ��IE�ײ�׷������

GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
$oIE = _IECreate ("https://login.sina.com.cn/cgi/register/reg_sso.php");�򿪴���֤�����ҳ����������IE
Get_code()
While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
                Case $GUI_EVENT_CLOSE
                 _IEQuit ($oIE);�˳��ű��ر�IE
                        Exit
        Case $Button1
             _IELinkClickByText($oIE,"�����壿��һ��")
             Sleep(300);�������ͬ����ҳ�е�ͼƬ����ӳ�Ҫ��㣬���ܸ������й�ϵ��
             Get_code()
        EndSwitch
WEnd

Func Get_code()
$oImg = _IEImgGetCollection ($oIE,4);����IE�ĵ���IMG ʵ���Ͼ��ǵ�4+1��ͼ
$oPic = $oIE.Document.body.createControlRange()
$oPic.Add($oImg)
$oPic.execCommand("Copy");���Ƶ�������
$ImageFilePath = ClipGet();��ȡ·��������ʱ�ļ�����
_IEAction ( $oIE_code,"refresh" );ˢ��Ƕ��IEҳ��
$oBody = _IETagNameGetCollection($oIE_code, "body", 0)
_IEDocInsertHTML($oBody, '<img src='& FileGetShortName($ImageFilePath) &'>', "afterbegin");��Ƕ��IE�ײ�׷��ͼƬ��ʾ
EndFunc

