#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_UseAnsi=y
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#include <GuiEdit.au3>
#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#include <IE.au3> 
#Include <GuiListBox.au3>
#Include <GuiImageList.au3>

If FileExists(@ScriptDir&'\temp\') = 0 then DirCreate(@ScriptDir&'\temp\')
If FileExists(@ScriptDir&'\img\') = 0 then DirCreate(@ScriptDir&'\img\')
If FileExists(@ScriptDir&'\small\') = 0 then DirCreate(@ScriptDir&'\small\')
$AForm1 = GUICreate("影视图文采集V1.0 作者:帅哥命苦 联系QQ:76594695", 644, 432, 206, 119)
GUICtrlSetResizing(-1, $GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
GUICtrlCreateLabel("说明：目标站的图片采用了防盗链,如果采集不到图片,可以尝试重复采集几次,采集速度根据网速而定。有问题联系我", 10, 10, 630, 17)
GUICtrlSetColor(-1, 0xFF0000)
$Group1 = GUICtrlCreateGroup("", 16, 27, 611, 222)
$Group2 = GUICtrlCreateGroup("", 24, 35, 151, 206)
$Pic1 = GUICtrlCreatePic("", 30, 48, 139, 187)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Label1 = GUICtrlCreateLabel("电影名称:", 186, 47, 55, 17)
$Label2 = GUICtrlCreateLabel("影片主演:", 186, 107, 55, 17)
$Label3 = GUICtrlCreateLabel("影片地区:", 186, 137, 55, 17)
$Label4 = GUICtrlCreateLabel("影片导演:", 186, 77, 55, 17)
$Input1 = GUICtrlCreateInput("请输入电影名称", 251, 42, 191, 21)
$Input2 = GUICtrlCreateInput("", 251, 72, 281, 21)
$Input3 = GUICtrlCreateInput("", 251, 102, 281, 21)
$Input4 = GUICtrlCreateInput("", 251, 132, 281, 21)
$Edit1 = GUICtrlCreateEdit("", 186, 160, 431, 81,$ES_AUTOVSCROLL)
GUICtrlSetData(-1, "影片简介：")
$Checkbox1 = GUICtrlCreateCheckbox("批量", 560, 42, 61, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group3 = GUICtrlCreateGroup("", 16, 250, 611, 101)
$Edit2 = GUICtrlCreateEdit("", 20, 260, 602, 87,$ES_AUTOVSCROLL)
GUICtrlSetColor(-1, 0x008000)
GUICtrlSetData(-1, "")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Label5 = GUICtrlCreateLabel("选择采集目标：", 20, 370, 88, 17)
$Combo1 = GUICtrlCreateCombo("中国影视库:www.mdbchina.com", 110, 367, 221, 21, 0x0003)
GUICtrlSetData(-1, "无目标站,请定义|无目标站,请定义|无目标站,请定义 |无目标站,请定义 |无目标站,请定义 ")
$Button1 = GUICtrlCreateButton("定义目标",340, 367, 61, 21, 0)
$Checkbox2 = GUICtrlCreateCheckbox("直接入库(请务必先设置数据库连接保证无错误!!!请详细阅读帮助文件)", 20, 393, 421, 21)
$Button2 = GUICtrlCreateButton("开    始", 530, 370, 91, 41, 0)
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
     if $dy_name = '' or $dy_name = '请输入电影名称' then 
                MsgBox (0,'提示:',"请先输入电影名称!!!")
       else
     GUICtrlSetData($Input2, '搜索中')
     GUICtrlSetData($Input3, '搜索中')
     GUICtrlSetData($Input4, '搜索中')
     GUICtrlSetData($Edit1, '搜索中')
     GUICtrlSetData($Edit2, '')
            caiji($dy_name)
    EndIf
            Case $nMsg1 = $Button1
                MsgBox (0,"影视图文采集V1.0 QQ:76594695","自定义目标功能和入库功能制作中！！！")   
EndSelect
WEnd

;~ ------------------------------------------------------------------------------------
func caiji($dy_name);分析网页获取连接,下载到TEMP文件夹
$nOffset = 1
$kaishi = '<div id="MovieBlock"><div id="RecordPost"><a href="' ;开始地址
$jieshu = '" target="_blank">'                   ;结束地址
$url = ''                    ;分析到的连接
$oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
$oHTTP.Open("GET","http://so.mdbchina.com/query/"&$dy_name)
GUICtrlSetData($Edit2, "连接目标：http://www.mdbchina.com/"&@CRLF, 1)
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
   GUICtrlSetData($Edit2, "电影名称错误或者目标站没有该电影！！！"&@CRLF, 1)
else
   GUICtrlSetData($Edit2, "获取链接："&$url&@CRLF, 1)
   InetGet($url,'temp\temp.tmp',0,0)
     caiji_img($url,$dy_name)
        caiji_zy($url,$dy_name)
        caiji_dy($url,$dy_name)
   caiji_dq($url,$dy_name)
   caiji_jj($url,$dy_name)
   ;FileDelete(@ScriptDir&'\temp\*.tmp')
   EndIf
Else
GUICtrlSetData($Edit2, "连接目标失败,请检查网络连接!!!"&@CRLF, 1) 
EndIf
EndFunc

func caiji_img($url,$dy_name);采集影片图片+缩略图函数
$nOffset = 1
$kaishi = 'src="'   ;开始地址
$jieshu = '" width="98" border="0"></A></div>'   ;结束地址
$img = ''    ;分析到的连接
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
   GUICtrlSetData($Edit2, '采集『'&$dy_name&'』图片失败或者目标站无该电影图片！！！'&@CRLF, 1)
else
   GUICtrlSetData($Edit2, "缩略图地址："&$img&@CRLF, 1)
        caiji_hb($url,$dy_name,$img)  
   EndIf
EndFunc

func caiji_hb($url,$dy_name,$img);采集影片图片+缩略图函数
$nOffset = 1
$kaishi = '<div class="photo_border"><A href="'   ;开始地址
$jieshu = '"><IMG height="140" alt="'   ;结束地址
$hb_url = ''    ;电影海报地址
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
   GUICtrlSetData($Edit2, '采集『'&$dy_name&'』电影海报失败!!!'&@CRLF, 1)
else
   $hb_url = "http://www.mdbchina.com"&$hb
     $a = StringRegExp($img, "small/[^\.]+", 2, 1)
   for $i = 0 to UBound($array) - 1
            $http_img_url=$a[$i]
     Next
   $http_img_url = $hb_url&StringReplace($http_img_url,"small/","")&'.html'
   GUICtrlSetData($Edit2, '海报链接：'&$http_img_url&@CRLF, 1)
   $img_url = StringReplace( $img, "/small/" ,"/" )
   GUICtrlSetData($Edit2, '海报地址：'&$img_url&@CRLF, 1)
   GUICtrlSetData($Edit2, '正在下载图片,请稍后...^..^!!!'&@CRLF, 1)
   $oIE =_IECreate ($http_img_url, 0, 0, 0)
   Sleep(5000)
   InetGet($img,@ScriptDir&'\small\'& $dy_name&'.jpg',0,0);缩略图下载
   InetGet($img_url,@ScriptDir&'\img\'& $dy_name&'.jpg',0,0);电影海报下载
   _IEQuit ($oIE)
   GUICtrlSetData($Edit2, '图片下载成功...^_^'&@CRLF, 1)
   GUICtrlSetImage($pic1,@ScriptDir&'\img\'&$dy_name&'.jpg')
   EndIf
EndFunc 

func caiji_zy($url,$dy_name);采集影片主演函数
$nOffset = 1
$kaishi='主演：'
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
   GUICtrlSetData($Edit2, '采集『'&$dy_name&'』主演资料失败!!!'&@CRLF, 1)
   GUICtrlSetData($Input3, '搜索资料失败')
     else
   $zy = StringRegExpReplace ( $zy, '<a[^>]+>'," ");替换<a>的内容为空格
   $zy = StringRegExpReplace ( $zy, '<[^>]+>',"");替换<>的内容
   GUICtrlSetData($Input3, $zy)
   GUICtrlSetData($Edit2, '采集『'&$dy_name&'』主演资料成功!!!'&@CRLF, 1)
EndIf
EndFunc

func caiji_jj($url,$dy_name);采集影片简介函数
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
   GUICtrlSetData($Edit2, '采集『'&$dy_name&'』简介资料失败!!!'&@CRLF, 1)
   GUICtrlSetData($Edit1, '搜索资料失败')
   else
     GUICtrlSetData($Edit1, $jj)
        GUICtrlSetData($Edit2, '采集『'&$dy_name&'』简介资料成功!!!'&@CRLF, 1)  
EndIf
EndFunc

Func caiji_dy($url,$dy_name);采集影片导演函数
$nOffset = 1
$kaishi='导演：'
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
   GUICtrlSetData($Input2, '搜索资料失败')
   GUICtrlSetData($Edit2, '采集『'&$dy_name&'』导演资料失败!!!'&@CRLF, 1)
else
   $dy = StringRegExpReplace ( $dy, '<a[^>]+>'," ");替换<a>的内容为空格
   $dy = StringRegExpReplace ( $dy, '<[^>]+>',"");替换<>的内容
   if StringInStr ( $dy, ">",0,1) <> 0 then 
   $a=StringSplit ($dy, ">",0 )
   $dy = $a[2]
     EndIf
     GUICtrlSetData($Edit2, '采集『'&$dy_name&'』导演资料成功!!!'&@CRLF, 1)
     GUICtrlSetData($Input2, $dy)    
EndIf
EndFunc

Func caiji_dq($url,$dy_name);采集影片导演函数
$nOffset = 1
$kaishi='地区：'
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
        GUICtrlSetData($Input4, '搜索资料失败')   
   GUICtrlSetData($Edit2, '采集『'&$dy_name&'』地区资料失败!!!'&@CRLF, 1)
else
   $dq = StringRegExpReplace ( $dq, '<a[^>]+>'," ");替换<a>的内容为空格
   $dq = StringRegExpReplace ( $dq, '<[^>]+>',"");替换<>的内容
   if StringInStr ( $dq, ">",0,1) <> 0 then 
   $a=StringSplit ($dq, ">",0 )
   $dq = $a[2]
     EndIf
     GUICtrlSetData($Edit2, '采集『'&$dy_name&'』地区资料成功!!!'&@CRLF, 1)
     GUICtrlSetData($Input4, $dq)     
EndIf
EndFunc