#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <IE.au3>

$Form1 = GUICreate("验证码窗口演示   QQ:76594695  帅哥命苦 ", 333, 211)
$Label1 = GUICtrlCreateLabel("验证码：", 16,43, 70, 17)
GUICtrlSetFont(-1, 12, 400, 0, "黑体")
GUICtrlSetColor(-1, 0xFF0000)
$Button1 = GUICtrlCreateButton("更换验证码", 112, 150, 97, 33, 0)
$oIE_code = _IECreateEmbedded ()
$GUIActiveX = GUICtrlCreateObj($oIE_code, 80,24,150,50);定义内嵌IE 窗口大小
_IENavigate ($oIE_code, "about:blank",1)
;加载一个空白网页，可以自定一个网页，让验证码图片显示左左对齐，顶部对齐，如果你会HTML应该明白什么意思
$oBody = _IETagNameGetCollection($oIE_code, "body", 0)
_IEDocInsertHTML($oBody, 'IE加载中...', "afterbegin");在嵌入IE底部追加文字

GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
$oIE = _IECreate ("https://login.sina.com.cn/cgi/register/reg_sso.php");打开带验证码的网页，可以隐藏IE
Get_code()
While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
                Case $GUI_EVENT_CLOSE
                 _IEQuit ($oIE);退出脚本关闭IE
                        Exit
        Case $Button1
             _IELinkClickByText($oIE,"看不清？换一张")
             Sleep(300);如果不能同步网页中的图片这个延迟要大点，可能跟网速有关系吧
             Get_code()
        EndSwitch
WEnd

Func Get_code()
$oImg = _IEImgGetCollection ($oIE,4);返回IE文档内IMG 实际上就是第4+1张图
$oPic = $oIE.Document.body.createControlRange()
$oPic.Add($oImg)
$oPic.execCommand("Copy");复制到剪贴板
$ImageFilePath = ClipGet();获取路径，在临时文件里面
_IEAction ( $oIE_code,"refresh" );刷新嵌入IE页面
$oBody = _IETagNameGetCollection($oIE_code, "body", 0)
_IEDocInsertHTML($oBody, '<img src='& FileGetShortName($ImageFilePath) &'>', "afterbegin");在嵌入IE底部追加图片显示
EndFunc

