#include <IE.au3>
$oIE = _IECreate ("http://mail.163.com")
$oForm = _IEFormGetObjByName ($oIE, "login163")
$oQuery = _IEFormElementGetObjByName ($oForm, "username")
_IEFormElementSetValue ($oQuery, "girlHLJ2866")
$oQuery = _IEFormElementGetObjByName ($oForm, "password")
_IEFormElementSetValue ($oQuery, "tt163163")
$oQuery = _IEFormElementGetObjByName ($oForm, "登录邮箱")
_IEAction($oQuery ,"click")


While 1;此循环每隔100毫秒判断网址是否改变并做相应处理

           if StringInStr(_IEPropertyGet($oIE,"locationurl"),"js3/main.jsp?sid") Then 
                          _IELoadWait($oIE)
                            
                                        $oFrame = _IEFrameGetCollection ($oIE, 0);第一个框架里是网页内容
                                        ;MsgBox(0, "Frame Info", _IEPropertyGet ($oFrame, "locationurl"))
                                    $oFrame2 = _IEFrameGetCollection ($oFrame, 0);第一个框架里的第一个框架是文本编辑器
                                        ;MsgBox(0, "Frame Info", _IEPropertyGet ($oFrame2, "locationurl"))
                                        ;MsgBox(0, "Frame Info", _IEPropertyGet ($oFrame2, "innerhtml"))
                                        $edithtml=_IEPropertyGet ($oFrame2, "innerhtml");输出编辑器的代码
                                        FileWrite("edithtml.html",$edithtml)
                                    _IELinkClickByText ($oFrame , "写信")
                                        $oForm = _IEFormGetCollection ($oFrame, 0);第一个form可以发送内容
                                    $oQuery = _IEFormElementGetCollection ($oForm, 0);第一个input
                                        _IEFormElementSetValue ($oQuery, "10000@qq.com;sina@163.com")
                                        ;第一个input输入收件人
                                        ;第二个input输入抄送
                                        ;第三个input输入密送
                                        ;第四个input输入主题
                                        $oQuery = _IEFormElementGetCollection ($oForm, 3);第四个input
                                        _IEFormElementSetValue ($oQuery, "锵锵！")
                                        
                                        $oLinks = _IELinkGetCollection ($oFrame2)
                                        $iNumLinks = @extended
                                        ;MsgBox(0, "Link Info", $iNumLinks & " links found")
                                        $i=0
                                        For $oLink In $oLinks
                                                ;MsgBox(0, "Link Info"&$linki, $oLink.title)
                                                ;_IELinkClickByIndex ($oFrame2, $linki)
                                                if $i=12 then ;
                                                        MsgBox(0, "Link Info", $oLink.title)
                                                _IEAction($oLink,"click");点击全部功能  无效！
                                            EndIf
                                            if $i=35 then
                                                        MsgBox(0, "Link Info", $oLink.title)
                                                _IEAction($oLink,"click");点击编辑源码  无效！
                                            EndIf
                                                $i+=1
                                        Next
                                    ; _IENavigate ($oFrame2,"javascript:fToggleToolbar();")
                                        ;_IENavigate ($oFrame,"javascript:fToggleToolbar();")
                                        ;_IENavigate ($oIE,"javascript:fToggleToolbar();return false;") ;直接运行js 无效！

                                        
                                        _IELinkClickByIndex ($oFrame2, 12)  ;点击全部功能  无效！
                                        _IELinkClickByIndex ($oFrame2, 35)  ;点击编辑源码  无效！
                          ExitLoop
           EndIf
           Sleep(100)           
WEnd
   