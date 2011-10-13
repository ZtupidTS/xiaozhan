#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=D:\软件\文件图标替换工具\ICO\卡通\PM009\01.ICO
#AutoIt3Wrapper_outfile=通讯录.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <ListViewConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GuiListView.au3>
$ShuJu = @ScriptDir & "\TongXunLu.ini"
#Region ### START Koda GUI section ### Form=
;主窗口
$Form1 = GUICreate("通讯录", 330, 263, -1, -1)
$ListView1 = GUICtrlCreateListView("序号|姓名|性别|电话|QQ|好友度|备注", 8, 8, 314, 174)
$Button1 = GUICtrlCreateButton("添加", 8, 200, 60, 25)
$Button2 = GUICtrlCreateButton("编辑", 88, 200, 60, 25)
$Button3 = GUICtrlCreateButton("删除", 165, 232, 60, 25)
$Button4 = GUICtrlCreateButton("刷新", 88, 232, 60, 25)
$Button5 = GUICtrlCreateButton("全部删除", 165, 200, 84, 25)
$Button6 = GUICtrlCreateButton("复制", 8, 232, 60, 25)
$Button7 = GUICtrlCreateButton("退出", 265, 200, 60, 25)
$Label1 = GUICtrlCreateLabel("数量：", 247, 240, 40, 17)
$Label2 = GUICtrlCreateLabel("0", 290, 240, 40, 17)
;子窗口
$Form2 = GUICreate("", 363, 271, 192, 121)
$Label1_1 = GUICtrlCreateLabel("通讯录资料填写：", 35, 20, 100, 25)
$Label1_3 = GUICtrlCreateLabel("性别：", 8, 60, 40, 17)
$Label1_5 = GUICtrlCreateLabel("QQ:", 8, 90, 32, 17)
$Label1_4 = GUICtrlCreateLabel("电话：", 180, 56, 40, 17)
$Label1_6 = GUICtrlCreateLabel("好友度：", 180, 93, 50, 17)
$Label1_7 = GUICtrlCreateLabel("备注", 8, 128, 40, 17)
$Label1_2 = GUICtrlCreateLabel("姓名：", 180, 20, 40, 17)
$Button8 = GUICtrlCreateButton("确定", 280, 140, 60, 25)
$Button9 = GUICtrlCreateButton("取消", 280, 200, 60, 25)
$Input2 = GUICtrlCreateInput("", 230, 17, 120, 21)
$Combo1 = GUICtrlCreateCombo("请选择性别", 50, 56, 120, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "男|女")
$Input3 = GUICtrlCreateInput("", 230, 56, 120, 21)
$Input4 = GUICtrlCreateInput("", 50, 88, 120, 21)
$Edit1 = GUICtrlCreateEdit("", 48, 128, 220, 129)
GUICtrlSetData(-1, "")
$Combo2 = GUICtrlCreateCombo("请选译好友度", 230, 88, 120, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "很好|好|一般|差|很差")
GUISetState(@SW_SHOW, $Form1)
#EndRegion ### END Koda GUI section ###

ShuJu()



While 1
	$XingMing = GUICtrlRead($Input2)
	$DianHua = GUICtrlRead($Input3)
	$QQ = GUICtrlRead($Input4)
	$LieBiao = GUICtrlRead($ListView1)
	$XingBie = GUICtrlRead($Combo1)
	$HaoYouDu = GUICtrlRead($Combo2)
	$BieZhu = GUICtrlRead($Edit1)
	$NY = StringSplit(GUICtrlRead($LieBiao), "|", 0)
	$nMsg = GUIGetMsg(1)
	Select
		Case $nMsg[0] = $GUI_EVENT_CLOSE Or $nMsg[0] = $Button7
			Exit
		Case $nMsg[0] = $Button1
			GUISetState(@SW_SHOW, $Form2)   ;显示子窗口
			GUISetState(@SW_DISABLE, $Form1)  ;禁用主窗口
			WinSetTitle("", "", "添加资料")   ;修改子窗口标题
		Case $nMsg[0] = $Button2
			BianJi()
		Case $nMsg[0] = $Button4
			ShuJu()
		Case $nMsg[0] = $Button8
			TianJia()
		Case $nMsg[0] = $Button6
			FuZhi()
		Case $nMsg[0] = $Button9
			GUISetState(@SW_HIDE, $Form2)
			GUISetState(@SW_ENABLE, $Form1)
			WinActivate("通讯录")
		Case $nMsg[0] = $Button5
			ShanChuQuanBu()
		Case $nMsg[0] = $Button3
			ShanChu()
	EndSelect
WEnd

Func ShuJu()
	$z = 0
	_GUICtrlListView_DeleteAllItems($ListView1)  ;删除列表的内容
	$var = IniReadSection($ShuJu, "Data")   ;读取ini
	If Not @error Then
		For $i = 1 To $var[0][0]
			GUICtrlCreateListViewItem($var[$i][1], $ListView1)    ;把ini文件里的内容写入列表里
			GUICtrlSetData($Label2, $z + 1)
			$z += 1
		Next
	EndIf
EndFunc   ;==>ShuJu


Func TianJia()
	$XunHao = _GUICtrlListView_GetItemCount($ListView1)   ;获取列表的总行数
	$XunHao += 1
	$NY = StringSplit(GUICtrlRead($LieBiao), "|", 0)  ;把列表的内容用"|"分开
	$z = GUICtrlRead($Label2)
	If WinGetTitle($Form2) = "添加资料" Then   ;如果窗口的标题 = "添加资料"
		If $XingMing <> "" And $DianHua <> "" And $XingBie <> "" And $HaoYouDu <> "" Then
			GUICtrlCreateListViewItem($XunHao & "|" & $XingMing & "|" & $XingBie & "|" & $DianHua & "|" & $QQ & "|" & $HaoYouDu & "|" & $BieZhu, $ListView1) ;把内容写入列表
			IniWrite($ShuJu, "Data", $XunHao, $XunHao & "|" & $XingMing & "|" & $XingBie & "|" & $DianHua & "|" & $QQ & "|" & $HaoYouDu & "|" & $BieZhu)   ;把内容写入ini
			GUICtrlSetData($Input2, "")
			GUICtrlSetData($Input3, "")
			GUICtrlSetData($Input4, "")
			ControlCommand( "", "", $Combo1, "SetCurrentSelection", 0)   ;还原控件内容的第一个选项
			ControlCommand( "", "", $Combo2, "SetCurrentSelection", 0)
			GUICtrlSetData($Edit1, "")
		EndIf
	ElseIf WinGetTitle($Form2) = "编辑资料" Then
		GUICtrlSetData($LieBiao, $NY[1] & "|" & $XingMing & "|" & $XingBie & "|" & $DianHua & "|" & $QQ & "|" & $HaoYouDu & "|" & $BieZhu)
		IniWrite($ShuJu, "Data", $NY[1], $NY[1] & "|" & $XingMing & "|" & $XingBie & "|" & $DianHua & "|" & $QQ & "|" & $HaoYouDu & "|" & $BieZhu)
	EndIf
	GUISetState(@SW_HIDE, $Form2)
	GUISetState(@SW_ENABLE, $Form1)
	WinActivate("通讯录")
	GUICtrlSetData($Label2, $z + 1)
EndFunc   ;==>TianJia


Func BianJi()
	GUISetState(@SW_SHOW, $Form2)
	GUISetState(@SW_DISABLE, $Form1)
	WinSetTitle("", "", "编辑资料")
	$NY = StringSplit(GUICtrlRead($LieBiao), "|", 0)
	GUICtrlSetData($Input2, $NY[2])
	If $NY[3] = "男" Then
		ControlCommand("", "", $Combo1, "SetCurrentSelection", 1)
	Else
		ControlCommand("", "", $Combo1, "SetCurrentSelection", 2)
	EndIf
	GUICtrlSetData($Input3, $NY[4])
	GUICtrlSetData($Input4, $NY[5])
	If $NY[6] = "很好" Then
		ControlCommand("", "", $Combo2, "SelectString", "很好")
	ElseIf $NY[6] = "好" Then
		ControlCommand("", "", $Combo2, "SelectString", "好")
	ElseIf $NY[6] = "一般" Then
		ControlCommand("", "", $Combo2, "SelectString", "一般")
	ElseIf $NY[6] = "差" Then
		ControlCommand("", "", $Combo2, "SelectString", "差")
	ElseIf $NY[6] = "很差" Then
		ControlCommand("", "", $Combo2, "SelectString", "很差")
	EndIf
	GUICtrlSetData($Edit1, $NY[7])
EndFunc   ;==>BianJi


Func ShanChuQuanBu()
	_GUICtrlListView_DeleteAllItems($ListView1)  ;删除列表全部内容
	IniDelete($ShuJu, "Data")    ;删除ini里的全部内容
	GUICtrlSetData($Label2, "0")
EndFunc   ;==>ShanChuQuanBu


Func ShanChu()
	$ShanChu = _GUICtrlListView_GetSelectedIndices($ListView1)   ;1
	If Not StringLen($ShanChu) Then Return                       ;2
	_GUICtrlListView_DeleteItem($ListView1, $ShanChu)            ;3   ， 1，2，3是把列表中选中的内容删除

	If FileExists($ShuJu) Then FileDelete($ShuJu)             ;确认ini文件是否存在。。如果存在，就把Ini删除

	$x = _GUICtrlListView_GetColumnCount($ListView1) - 1     ;获取列表总列数
	$y = _GUICtrlListView_GetItemCount($ListView1) - 1       ;获取列表总行数
	Dim $NengYong
	For $yy = 0 To $y              
		For $xx = 0 To $x
			$WenBen = _GUICtrlListView_GetItemText($ListView1, $yy, $xx)   ;获取某一行与某一列的内容
			If $NengYong <> "" Then
				$NengYong = $NengYong & "|" & $WenBen
			Else
				$NengYong = $yy + 1
			EndIf
		Next
		IniWrite($ShuJu, "Data", $yy, $NengYong)
		$NengYong = ""
	Next
	$iniNengYong = IniReadSection($ShuJu, "Data")
	_GUICtrlListView_DeleteAllItems($ListView1)
	For $i = 1 To $iniNengYong[0][0]
		GUICtrlCreateListViewItem($iniNengYong[$i][1], $ListView1)
	Next
	$z = GUICtrlRead($Label2)
	GUICtrlSetData($Label2, $z - 1)
EndFunc   ;==>ShanChu

Func ShuaXin()
	$var = IniReadSection($ShuJu, "Data")
	If FileExists($ShuJu) And IniReadSection($ShuJu, "Data") <> 1 Then
		For $i = 1 To $var[0][0]
			GUICtrlCreateListViewItem($var[$i][1], $ListView1)
		Next
	EndIf
EndFunc   ;==>ShuaXin


Func FuZhi()
	_GUICtrlListView_CopyItems($ListView1, $ListView1)
	$z = GUICtrlRead($Label2)
	GUICtrlSetData($Label2, $z + 1)
EndFunc   ;==>FuZhi