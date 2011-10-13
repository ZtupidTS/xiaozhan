#include <GuiListView.au3>
#include <GuiImageList.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <ListViewConstants.au3>
Opt("TrayMenuMode",1)
$dir = @ScriptDir&"\Database.ini"
$pei = @ScriptDir&"\config.ini"

$Form1 = GUICreate("用户资料管理", 800, 600, -1, -1, BitOR($WS_MINIMIZEBOX,$WS_CAPTION,$WS_POPUP,$WS_GROUP,$WS_BORDER,$WS_CLIPSIBLINGS))
GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
$hListView = GUICtrlCreateListView("主机序号  |主机型号  |销售部门|销售日期    |服务人员 |用户姓名 |用户电话  |用户手机  |用户地址                    |销售备注                    | ", _
10, 10, 780, 500,-1, BitOR($WS_EX_CLIENTEDGE,$LVS_EX_FULLROWSELECT,$LVS_REPORT))

$hImage = _GUIImageList_Create(1, 25)
_GUICtrlListView_SetImageList($hListView, $hImage, 1)

$Button1 = GUICtrlCreateButton("刷新", 600, 530, 70, 30, $WS_GROUP)
$Button2 = GUICtrlCreateButton("退出", 700, 530, 70, 30, $WS_GROUP)
$Button3 = GUICtrlCreateButton("开始搜索", 483, 533, 60, 26, $WS_GROUP)
Dim $AccelKeys[1][2] = [["{Enter}", $Button3]]
GUISetAccelerators($AccelKeys)

$Input1 = GUICtrlCreateInput("输入搜索内容", 302, 535, 180, 21)

$shuju = GUICtrlCreateLabel("目前共有0条数据", 10, 533, 180, 20)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")


$caidan = GUICtrlCreateMenu("设置")
$daoru = GUICtrlCreateMenuItem("控制面板", $caidan)
$tuichu = GUICtrlCreateMenuItem("关闭程序", $caidan)
GUICtrlSetState(-1, $GUI_DEFBUTTON)

;右键菜单
$zhucaidan = GUICtrlCreateContextMenu($hListView)
$tianjia = GUICtrlCreateMenuItem("添加数据        ", $zhucaidan)
$shanchu = GUICtrlCreateMenuItem("删除数据", $zhucaidan)
$xiugai = GUICtrlCreateMenuItem("修改数据", $zhucaidan)
$shuaxin = GUICtrlCreateMenuItem("刷新数据", $zhucaidan)
$sousuo = GUICtrlCreateMenuItem("搜索数据", $zhucaidan)
GUICtrlCreateMenuItem("", $zhucaidan) 

$pailie = GUICtrlCreateMenu("排列方式", $zhucaidan)
$plshijian = GUICtrlCreateMenuItem("录入时间", $pailie)
$plriqi = GUICtrlCreateMenuItem("销售日期", $pailie)

$fileitem = GUICtrlCreateMenuItem("控制面板", $zhucaidan)
GUICtrlCreateMenuItem("", $zhucaidan)    

$infoitem = GUICtrlCreateMenuItem("关闭程序", $zhucaidan)
;===>右键菜单

;托盘菜单
$xscx = TrayCreateItem("显示程序")
$yccx = TrayCreateItem("隐藏程序")
$gycx = TrayCreateItem("关于程序")
TrayCreateItem("")
$gbcx = TrayCreateItem("关闭程序")
;===>托盘菜单
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
                        MsgBox(64,"关于程序","《用户资料管理》此程序为内江英特公司专用！")
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
        Switch $IDFrom;选择产生事件的控件

                        Case $hListView

                                Switch $Event; 选择产生的事件

                                        Case $NM_CLICK ; 左击
;~                                         ...
                                        Case $NM_DBLCLK ; 双击
                                                        shuangji()
                                        Case $NM_RCLICK ; 右击

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
                
                        $xinghao = IniRead($dir,$bianhao[$i],"主机型号","NotFound")
                        _GUICtrlListView_AddSubItem($hListView, $z, $xinghao, 1, $z+1)
                
                        $bumen = IniRead($dir,$bianhao[$i],"销售部门","NotFound")
                        _GUICtrlListView_AddSubItem($hListView, $z, $bumen, 2, $z+1)
                
                        $riqi = IniRead($dir,$bianhao[$i],"销售日期","NotFound")
                        _GUICtrlListView_AddSubItem($hListView, $z, $riqi, 3, $z+1)
                
                        $fuwu = IniRead($dir,$bianhao[$i],"服务人员","NotFound")
                        _GUICtrlListView_AddSubItem($hListView, $z, $fuwu, 4, $z+1)
                
                        $xingming = IniRead($dir,$bianhao[$i],"用户姓名","NotFound")
                        _GUICtrlListView_AddSubItem($hListView, $z, $xingming, 5, $z+1)
                
                        $dianhua = IniRead($dir,$bianhao[$i],"用户电话","NotFound")
                        _GUICtrlListView_AddSubItem($hListView, $z, $dianhua, 6, $z+1)
                
                        $shouji = IniRead($dir,$bianhao[$i],"用户手机","NotFound")
                        _GUICtrlListView_AddSubItem($hListView, $z, $shouji, 7, $z+1)
                
                        $dizhi = IniRead($dir,$bianhao[$i],"用户地址","NotFound")
                        _GUICtrlListView_AddSubItem($hListView, $z, $dizhi, 8, $z+1)
                
                        $beizhu = IniRead($dir,$bianhao[$i],"销售备注","NotFound")
                        _GUICtrlListView_AddSubItem($hListView, $z, $beizhu, 9, $z+1)
                        
                        GUICtrlSetData($shuju,"当前共有"&$z+1&"条数据")
                        $z += 1
                Next
        EndIf
EndFunc        

Func tianjia()
        GUISetState(@SW_DISABLE,$Form1)  
        $Form2 = GUICreate("请输入需要添加的数据", 400, 280, -1, -1, BitOR _
        ($WS_MINIMIZEBOX,$WS_CAPTION,$WS_POPUP,$WS_GROUP,$WS_BORDER,$WS_CLIPSIBLINGS))
        $Button11 = GUICtrlCreateButton("保存", 200, 230, 80, 30, $WS_GROUP)
        $Button12 = GUICtrlCreateButton("退出", 300, 230, 80, 30, $WS_GROUP)

        $Label1 = GUICtrlCreateLabel("主机序号:", 20, 23, 55, 17)
        $Label2 = GUICtrlCreateLabel("主机型号:", 20, 53, 55, 17)
        $Label3 = GUICtrlCreateLabel("用户姓名:", 20, 83, 55, 17)
        $Label4 = GUICtrlCreateLabel("用户电话:", 20, 113, 55, 17)
        $Label5 = GUICtrlCreateLabel("销售部门:", 200, 23, 55, 17)
        $Label6 = GUICtrlCreateLabel("销售日期:", 200, 53, 55, 17)
        $Label7 = GUICtrlCreateLabel("服务人员:", 200, 83, 55, 17)
        $Label8 = GUICtrlCreateLabel("用户手机:", 200, 113, 55, 17)
        $Label9 = GUICtrlCreateLabel("用户地址:", 20, 143, 55, 17)
        $Label10 = GUICtrlCreateLabel("销售备注:", 20, 173, 55, 17)

        $Input1 = GUICtrlCreateInput("", 80, 20, 100, 21)
        GUICtrlSetState(-1, $GUI_FOCUS)
        $Input2 = GUICtrlCreateInput("", 80, 50, 100, 21)
        $Input3 = GUICtrlCreateInput("", 80, 80, 100, 21)
        $Input4 = GUICtrlCreateInput("", 80, 110, 100, 21)
        $Input5 = GUICtrlCreateCombo("", 260, 20, 120, 21)
        GUICtrlSetData(-1, "天津店|惠川店|售后部|行业组", "天津店")
        $Input6 = GUICtrlCreateDate("", 260, 50, 120, 21)
        $Input7 = GUICtrlCreateCombo("", 260, 80, 120, 21)
        GUICtrlSetData(-1, "罗庆|吴英|何利|李娇|小韦", "罗庆")
        $Input8 = GUICtrlCreateInput("", 260, 110, 120, 21)
        $Input9 = GUICtrlCreateInput("", 80, 140, 300, 21)
        $Input10 = GUICtrlCreateInput("", 80, 170, 300, 21)
        GUISetState(@SW_SHOW)

        While 1
                $nMsg = GUIGetMsg()
                Switch $nMsg
                        Case -3,$Button12
                                        GUISetState(@SW_ENABLE,$Form1)         ;启用父窗口
                                        GUIDelete($Form2)                      ;;删除指定窗口和它包含的所有控件.
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
                                                IniWrite($dir,$xuhao,"主机型号",$xinghao)
                                                IniWrite($dir,$xuhao,"销售部门",$bumen)
                            IniWrite($dir,$xuhao,"销售日期",$riqi)
                                                IniWrite($dir,$xuhao,"服务人员",$fuwu)
                                                IniWrite($dir,$xuhao,"用户姓名",$xingming)
                            IniWrite($dir,$xuhao,"用户电话",$dianhua)
                            IniWrite($dir,$xuhao,"用户手机",$shouji)
                                                IniWrite($dir,$xuhao,"用户地址",$dizhi)
                            IniWrite($dir,$xuhao,"销售备注",$beizhu&@CRLF)
                                                
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
                                                GUICtrlSetData($shuju,"当前共有"&$z+1&"条数据")
        
                                                MsgBox(0,"保存成功","主机序号："&$xuhao&@CRLF&@CRLF&"主机型号："&$xinghao&@CRLF&@CRLF& _
                                                "销售部门："&$bumen&@CRLF&@CRLF&"销售日期："&$riqi&@CRLF&@CRLF&"服务人员："&$fuwu&@CRLF&@CRLF& _
                                                "用户姓名："&$xingming&@CRLF&@CRLF&"用户电话："&$dianhua&@CRLF&@CRLF&"用户手机："&$shouji&@CRLF&@CRLF& _
                                                "用户地址："&$dizhi&@CRLF&@CRLF&"销售备注："&$beizhu)
                                        Else
                                                MsgBox(64,"提示","请正确输入相关内容，否则无法添加项目！")
                                        EndIf
                EndSwitch
        WEnd
EndFunc

Func shanchu()
        $a = _GUICtrlListView_GetSelectedIndices($hListView)
        $b = _GUICtrlListView_GetItemTextString($hListView, Number($a))
        $chaifen = StringSplit($b,"|")

        $a = MsgBox(32+1,"提示","请确认是否要删除以下数据        "&@CRLF&@CRLF&"主机序号："&$chaifen[1]&@CRLF&@CRLF&"主机型号："&$chaifen[2]&@CRLF&@CRLF& _
        "销售部门："&$chaifen[3]&@CRLF&@CRLF&"销售日期："&$chaifen[4]&@CRLF&@CRLF&"服务人员："&$chaifen[5]&@CRLF&@CRLF& _
        "用户姓名："&$chaifen[6]&@CRLF&@CRLF&"用户电话："&$chaifen[7]&@CRLF&@CRLF&"用户手机："&$chaifen[8]&@CRLF&@CRLF& _
        "用户地址："&$chaifen[9]&@CRLF&@CRLF&"销售备注："&$chaifen[10])
        If $a = 1 Then
                _GUICtrlListView_DeleteItemsSelected($hListView) ;删除选定项目
                IniDelete($dir,$chaifen[1])
                $z = _GUICtrlListView_GetItemCount($hListView)
                GUICtrlSetData($shuju,"当前共有"&$z&"条数据")
                ;MsgBox(48, "提示", "数据删除成功")
        EndIf
EndFunc   ;==>shanchu

Func shuangji()
        $a = _GUICtrlListView_GetSelectedIndices($hListView)
        $b = _GUICtrlListView_GetItemTextString($hListView, Number($a))
        $chaifen = StringSplit($b,"|")
        If Not StringLen($a) Then; 这里用以判断是否选定了ListViewItem
                ;MsgBox(48, "提示", "请选择你要删除的号码")
        Return
        EndIf
                $a = MsgBox(64,"数据查看","本行数据如下：                  "&@CRLF&@CRLF&"主机序号："&$chaifen[1]&@CRLF&@CRLF&"主机型号："&$chaifen[2]&@CRLF&@CRLF& _
                "销售部门："&$chaifen[3]&@CRLF&@CRLF&"销售日期："&$chaifen[4]&@CRLF&@CRLF&"服务人员："&$chaifen[5]&@CRLF&@CRLF& _
                "用户姓名："&$chaifen[6]&@CRLF&@CRLF&"用户电话："&$chaifen[7]&@CRLF&@CRLF&"用户手机："&$chaifen[8]&@CRLF&@CRLF& _
                "用户地址："&$chaifen[9]&@CRLF&@CRLF&"销售备注："&$chaifen[10])
EndFunc        
        
Func sousuo()        
        $a = GUICtrlRead($Input1)
        $sou = _GUICtrlListView_FindInText($hListView,$a)
        _GUICtrlListView_ClickItem($hListView,$sou)
        ;MsgBox(0,"",$sou)                
EndFunc                