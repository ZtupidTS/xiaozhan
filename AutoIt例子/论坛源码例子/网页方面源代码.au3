#include <IE.au3>
$oIE = _IECreate ("http://mail.163.com")
$oForm = _IEFormGetObjByName ($oIE, "login163")
$oQuery = _IEFormElementGetObjByName ($oForm, "username")
_IEFormElementSetValue ($oQuery, "girlHLJ2866")
$oQuery = _IEFormElementGetObjByName ($oForm, "password")
_IEFormElementSetValue ($oQuery, "tt163163")
$oQuery = _IEFormElementGetObjByName ($oForm, "��¼����")
_IEAction($oQuery ,"click")


While 1;��ѭ��ÿ��100�����ж���ַ�Ƿ�ı䲢����Ӧ����

           if StringInStr(_IEPropertyGet($oIE,"locationurl"),"js3/main.jsp?sid") Then 
                          _IELoadWait($oIE)
                            
                                        $oFrame = _IEFrameGetCollection ($oIE, 0);��һ�����������ҳ����
                                        ;MsgBox(0, "Frame Info", _IEPropertyGet ($oFrame, "locationurl"))
                                    $oFrame2 = _IEFrameGetCollection ($oFrame, 0);��һ�������ĵ�һ��������ı��༭��
                                        ;MsgBox(0, "Frame Info", _IEPropertyGet ($oFrame2, "locationurl"))
                                        ;MsgBox(0, "Frame Info", _IEPropertyGet ($oFrame2, "innerhtml"))
                                        $edithtml=_IEPropertyGet ($oFrame2, "innerhtml");����༭���Ĵ���
                                        FileWrite("edithtml.html",$edithtml)
                                    _IELinkClickByText ($oFrame , "д��")
                                        $oForm = _IEFormGetCollection ($oFrame, 0);��һ��form���Է�������
                                    $oQuery = _IEFormElementGetCollection ($oForm, 0);��һ��input
                                        _IEFormElementSetValue ($oQuery, "10000@qq.com;sina@163.com")
                                        ;��һ��input�����ռ���
                                        ;�ڶ���input���볭��
                                        ;������input��������
                                        ;���ĸ�input��������
                                        $oQuery = _IEFormElementGetCollection ($oForm, 3);���ĸ�input
                                        _IEFormElementSetValue ($oQuery, "���ϣ�")
                                        
                                        $oLinks = _IELinkGetCollection ($oFrame2)
                                        $iNumLinks = @extended
                                        ;MsgBox(0, "Link Info", $iNumLinks & " links found")
                                        $i=0
                                        For $oLink In $oLinks
                                                ;MsgBox(0, "Link Info"&$linki, $oLink.title)
                                                ;_IELinkClickByIndex ($oFrame2, $linki)
                                                if $i=12 then ;
                                                        MsgBox(0, "Link Info", $oLink.title)
                                                _IEAction($oLink,"click");���ȫ������  ��Ч��
                                            EndIf
                                            if $i=35 then
                                                        MsgBox(0, "Link Info", $oLink.title)
                                                _IEAction($oLink,"click");����༭Դ��  ��Ч��
                                            EndIf
                                                $i+=1
                                        Next
                                    ; _IENavigate ($oFrame2,"javascript:fToggleToolbar();")
                                        ;_IENavigate ($oFrame,"javascript:fToggleToolbar();")
                                        ;_IENavigate ($oIE,"javascript:fToggleToolbar();return false;") ;ֱ������js ��Ч��

                                        
                                        _IELinkClickByIndex ($oFrame2, 12)  ;���ȫ������  ��Ч��
                                        _IELinkClickByIndex ($oFrame2, 35)  ;����༭Դ��  ��Ч��
                          ExitLoop
           EndIf
           Sleep(100)           
WEnd
   