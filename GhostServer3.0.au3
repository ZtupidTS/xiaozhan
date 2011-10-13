#NoTrayIcon
#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=moon_mycom.ico
#AutoIt3Wrapper_outfile=NetbarGhostServer.exe
#AutoIt3Wrapper_Res_Comment=网吧GHOST服务端配置工具（附代扫描程序）
#AutoIt3Wrapper_Res_Description=网吧GHOST服务端配置工具
#AutoIt3Wrapper_Res_Fileversion=3.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=BY-Jycel QQ:472891322
#AutoIt3Wrapper_Res_Field=源文件名|NetbarGhostServer.exe
#AutoIt3Wrapper_Res_Field=程序作者|景勇
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiIPAddress.au3>
#include <GuiStatusBar.au3>
#include <ListViewConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>
#include <GuiImageList.au3>
$g_szVersion = "GhostServer3.0"
If WinExists($g_szVersion) Then
	MsgBox(16, "温馨提示", "程序已运行",3)
	Exit 
EndIf
AutoItWinSetTitle($g_szVersion)
If Not FileExists(@ScriptDir&"\Tool") Then
$tool=DirCreate(@ScriptDir&"\Tool")
If $tool=0 Then MsgBox(0,"","TOOL目录创建失败请检查是否已存在或权限不足")
EndIf
GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
FileInstall("mdb.ini", @ScriptDir & "\mdb.ini", 0)
FileInstall("Update.exe", @ScriptDir & "\Update.exe", 0)
FileInstall("Ghostupdate.ini", @ScriptDir & "\Ghostupdate.ini", 0)
FileInstall("病毒免役.exe", @ScriptDir & "\tool\病毒免役.exe", 0)
Opt("TrayAutoPause",0)
Local $hIcons[2]
Local $SelectedItem[10]
$ini="mdb.ini"
$temp=@TempDir & "\temp.ini"
If FileExists($temp) Then
	FileDelete($temp)
EndIf
If Not FileExists($ini) Then
_Default()
EndIf
$info=_NetworkAdapterInfo()
#Region ### START Koda GUI section ### Form=c:\documents and settings\administrator\桌面\access数据库操作\form1.kxf
$Form1 = GUICreate(" Ghost配置工具 - 服务端 V3.0", 825, 615, 143, 67)
$MenuItem1 = GUICtrlCreateMenu("帮助菜单")
$MenuItem3 = GUICtrlCreateMenu("界面帮助", $MenuItem1)
$server1 = GUICtrlCreateMenuItem("相关配置", $MenuItem3)
$server2 = GUICtrlCreateMenuItem("扫描程序", $MenuItem3)
$server3 = GUICtrlCreateMenuItem("附加程序", $MenuItem3)
$MenuItem4 = GUICtrlCreateMenuItem("提交建议", $MenuItem1)
$MenuItem5 = GUICtrlCreateMenuItem("更新程序", $MenuItem1)
$MenuItem6 = GUICtrlCreateMenuItem("作者空间", $MenuItem1)
$MenuItem7 = GUICtrlCreateMenuItem("关于程序", $MenuItem1)
$MenuItem8 = GUICtrlCreateMenuItem("退出程序", $MenuItem1)

GUISetBkColor(0xA3AE110);0xEF379C)
DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00040010)
$ListView1 = GUICtrlCreateListView("MAC地址|计算机名|IP地址|IPX地址|子网掩码|默认网关|首选DNS|备用DNS|分辩率|还原软件|IDE通道", 8, 0, 809, 297,$LVS_EX_GRIDLINES)
_GUICtrlListView_SetExtendedListViewStyle ($ListView1, BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_GRIDLINES, $LVS_EX_SUBITEMIMAGES))
GUICtrlSetBkColor(-1, 0xA6CAF0)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 112)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 60)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 2, 92)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 3, 80)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 4, 92)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 5, 92)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 6, 92)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 7, 92)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 8, 110)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 9, 80)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 10, 60)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 11, 60)
$menu = GUICtrlCreateContextMenu($ListView1)
$e_menu = GUICtrlCreateMenuItem("编辑选中项目", $menu)
$d_menu = GUICtrlCreateMenuItem("删除选中项目", $menu)
$c_menu = GUICtrlCreateMenuItem("清空所有数据", $menu)
GUICtrlCreateMenuItem("", $menu)
$all_menu = GUICtrlCreateMenu("批量修改数据", $menu)
$all1_menu = GUICtrlCreateMenuItem("IPX 地址", $all_menu)
$all2_menu = GUICtrlCreateMenuItem("子网掩码", $all_menu)
$all3_menu = GUICtrlCreateMenuItem("默认网关", $all_menu)
$all4_menu = GUICtrlCreateMenuItem("首选 DNS", $all_menu)
$all5_menu = GUICtrlCreateMenuItem("备用 DNS", $all_menu)
$all6_menu = GUICtrlCreateMenuItem("分 辩 率", $all_menu)
$all7_menu = GUICtrlCreateMenuItem("还原软件", $all_menu)
$all8_menu = GUICtrlCreateMenuItem("IDE 通道", $all_menu)

$Group1 = GUICtrlCreateGroup("", 8, 300, 809, 40)
$Label1 = GUICtrlCreateLabel("准备就绪！设置好相关配置中各项参数再扫描", 10, 308, 800, 30);,$ES_CENTER)
GUICtrlSetFont(-1, 18, 800, 0, "楷体_GB2312")
GUICtrlSetColor(-1, 0x000000);0xFF0000)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("相关配置≥配置以下参数后再扫描-程序自动添加至列表中", 8, 344, 697, 110)
$Label2 = GUICtrlCreateLabel("计算机名", 16, 366, 52, 17)
$Input1 = GUICtrlCreateInput(@ComputerName, 72, 360, 108, 21, BitOR($ES_CENTER,$ES_AUTOHSCROLL))
GUICtrlSetTip(-1,"计算机名称修改栏","提示帮助",1)
GUICtrlSetState(-1,$GUI_DISABLE)
$Label3 = GUICtrlCreateLabel("I P 地址", 184, 366, 51, 17)
$Input2 = GUICtrlCreateInput($info[1][4], 240, 360, 108, 21, BitOR($ES_CENTER,$ES_AUTOHSCROLL))
GUICtrlSetTip(-1,"I P 地址修改栏","提示帮助",1)
GUICtrlSetState(-1,$GUI_DISABLE)
$Label4 = GUICtrlCreateLabel("MAC地址", 360, 366, 51, 17)
$Input3 = GUICtrlCreateInput($info[1][8], 416, 360, 108, 21, BitOR($ES_CENTER,$ES_AUTOHSCROLL))
GUICtrlSetTip(-1,"禁止修改","提示帮助",1)
GUICtrlSetState(-1,$GUI_DISABLE)
$Label5 = GUICtrlCreateLabel("IPX 地址", 528, 366, 51, 17)
GUICtrlSetTip(-1,"IP规则-按IP最后位生成"&@CRLF&"随机规则-8位数随机取值","提示帮助",1)
$Combo1 = GUICtrlCreateCombo("", 584, 360, 108, 21)
GUICtrlSetData(-1,"IP规则|随机规则","IP规则")
$Label6 = GUICtrlCreateLabel("子网掩码", 16, 398, 52, 17)
$Input5 = GUICtrlCreateInput($info[1][7], 72, 392, 108, 21,BitOR($ES_CENTER,$ES_AUTOHSCROLL))
GUICtrlSetTip(-1,"默认读取本机，可修改！","提示帮助",1)
$Label7 = GUICtrlCreateLabel("默认网关", 184, 398, 52, 17)
$Input6 = GUICtrlCreateInput($info[1][2], 240, 392, 108, 21,BitOR($ES_CENTER,$ES_AUTOHSCROLL))
GUICtrlSetTip(-1,"默认读取本机，可修改！","提示帮助",1)
$Label8 = GUICtrlCreateLabel("首选 DNS", 360, 398, 51, 17)
$Input7 = GUICtrlCreateInput($info[1][5], 416, 392, 108, 21,BitOR($ES_CENTER,$ES_AUTOHSCROLL))
GUICtrlSetTip(-1,"默认读取本机，可修改！","提示帮助",1)
$Label9 = GUICtrlCreateLabel("备用 DNS", 528, 398, 51, 17)
$Input8 = GUICtrlCreateInput($info[1][6], 584, 392, 108, 21,BitOR($ES_CENTER,$ES_AUTOHSCROLL))
GUICtrlSetTip(-1,"默认读取本机，可修改！","提示帮助",1)
$Label10 = GUICtrlCreateLabel("还原软件", 16, 430, 52, 17)
$Input9 = GUICtrlCreateInput("网维大师.exe", 72, 424, 108, 21,BitOR($ES_CENTER,$ES_AUTOHSCROLL))
GUICtrlSetTip(-1,"任何可执行文件含后缀"&@CRLF&"如果留空则不使用本功能","提示帮助",1)
$Label11 = GUICtrlCreateLabel("分 辩 率", 184, 430, 51, 17)
GUICtrlSetTip(-1,"根据自身请手动修改配置文件再执行，可修改！","提示帮助",1)
$Combo2 = GUICtrlCreateCombo("", 240, 424, 108, 21)
$fby = IniReadSection($ini, "分辨率")
For $i = 1 To $fby[0][0]
	GUICtrlSetData(-1,$fby[$i][0],$fby[2][0])
Next
$Label12 = GUICtrlCreateLabel("禁用网卡", 360, 430, 52, 17)
$Input10 = GUICtrlCreateInput(IniRead($ini,"配置","禁用网卡",""), 416, 424, 108, 21,BitOR($ES_CENTER,$ES_AUTOHSCROLL))
GUICtrlSetTip(-1,"禁用多余网卡此处添写硬件ID号"&@CRLF&"如果不明白请查看使用说明","提示帮助",1)
$Label13 = GUICtrlCreateLabel("IDE 通道", 528, 430, 52, 17)
GUICtrlSetTip(-1,"是否关闭多余IDE通道","提示帮助",1)
$Combo3 = GUICtrlCreateCombo("", 584, 424, 49, 25)
GUICtrlSetData(-1,"开启|关闭","开启")
$Label14 = GUICtrlCreateLabel("T", 642, 430, 11, 17)
GUICtrlSetTip(-1,"倒计时多少秒开始设置","提示帮助",1)
$Input11 = GuiCtrlCreateInput("30", 656, 424, 36, 20)
GuiCtrlCreateUpDown(-1)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group3 = GUICtrlCreateGroup("", 8, 504, 697, 41)
$Button3 = GUICtrlCreateButton("读  取  配  置", 16, 516, 160, 25, $WS_GROUP)
GUICtrlSetTip(-1,"读取配置文件！建议先扫描后再使用","提示帮助",1)
$Button4 = GUICtrlCreateButton("更  新  配  置", 188, 516, 160, 25, $WS_GROUP)
GUICtrlSetTip(-1,"请先扫描信息再选择你要修改的数据右键选择修改类型","提示帮助",1)
$Button5 = GUICtrlCreateButton("预  览  程  序", 362, 516, 160, 25, $WS_GROUP)
GUICtrlSetTip(-1,"预览客户端程序"&@CRLF&"请确保客户端文件在同一目录下","提示帮助",1)
$Button6 = GUICtrlCreateButton("保  存  配  置", 536, 516, 160, 25, $WS_GROUP)
GUICtrlSetTip(-1,"保存当前所有设置","提示帮助",1)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group4 = GUICtrlCreateGroup("扫描客户机信息≥扫描完毕后可根据实际情况批量修改相关参数", 8, 456, 697, 49)

$Label15 = GUICtrlCreateLabel("开始 IP", 16, 478, 52, 17)
$IPAddress1 = _GUICtrlIpAddress_Create($Form1, 72, 472, 108, 21)
_GUICtrlIpAddress_Set($IPAddress1, @IPAddress1)

$Label16 = GUICtrlCreateLabel("结束 IP", 184, 478, 52, 17)
$IPAddress2 = _GUICtrlIpAddress_Create($Form1, 240, 472, 108, 21)
_GUICtrlIpAddress_Set($IPAddress2, @IPAddress1)

$Label17 = GUICtrlCreateLabel("MAC地址分格符", 360, 478, 87, 17)
GUICtrlSetTip(-1,"如果使用本程序配套客户端，请选择默认分隔符","提示帮助",1)
$Combo4 = GUICtrlCreateCombo("", 456, 472, 65, 25)
GUICtrlSetData(-1,"-|:","-")

$Button1 = GUICtrlCreateCheckbox("开始扫描", 536, 472, 72, 25, $BS_PUSHLIKE)
GUICtrlSetTip(-1,"扫描前请先设置扫描"&@CRLF&"开始IP、结束IP、和分隔符","提示帮助",1)
$Button2 = GUICtrlCreateButton("查看配置", 624, 472, 72, 25, $WS_GROUP)
GUICtrlSetTip(-1,"打开配置文件","提示帮助",1)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$StatusBar1 = _GUICtrlStatusBar_Create($Form1)
_GUICtrlStatusBar_SetText ($StatusBar1, "欢迎使用网吧专用工具! 如果您在使用过程中有任何问题，请联系作者或到论坛提问！  E-mail:Jycel@qq.com      QQ:472891322      BY-Jycel")
$hIcons[0] = _WinAPI_LoadShell32Icon (13)
_GUICtrlStatusBar_SetIcon ($StatusBar1, 0, $hIcons[0])
GUISetState(@SW_SHOW)
$Progress1 = GUICtrlCreateProgress(8, 552, 809, 16)
$Group5 = GUICtrlCreateGroup("附加程序列表", 712, 344, 105, 201)
$ListView2 = GUICtrlCreateListView("", 720, 360, 90, 118,$LVS_EX_GRIDLINES)
_GUICtrlListView_SetExtendedListViewStyle ($ListView2, BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_GRIDLINES, $LVS_EX_SUBITEMIMAGES))
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 50)
_GUICtrlListView_InsertColumn($ListView2, 0, "程序", 70)
$Combo5 = GUICtrlCreateCombo("", 720, 488, 70, 25)
_Runlist()
$jia = GUICtrlCreateButton("+", 792, 488, 20, 20)
$Button7 = GUICtrlCreateButton("添加", 720, 520, 89, 20, $WS_GROUP)
GUICtrlSetTip(-1,"添加当前选择程序至附加程序列表"&@CRLF&"注意:"&@CRLF&"添加后需右键编缉程序将自动保存","提示帮助",1)
$menu2 = GUICtrlCreateContextMenu($ListView2)
$x_menu2 = GUICtrlCreateMenuItem("编缉", $menu2)
$d_menu2 = GUICtrlCreateMenuItem("删除", $menu2)
$k_menu2 = GUICtrlCreateMenuItem("清空", $menu2)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
_dulist2()
While 1
	
	$aIP0 = _GUICtrlIpAddress_GetArray($IPAddress1)
	$aIP1 = _GUICtrlIpAddress_GetArray($IPAddress2)
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00050010)
			If FileExists($temp) Then
				FileDelete($temp)
			EndIf
			Exit
		Case $Button1
			_sm()
		case $Button2
			ShellExecute($ini)			
		Case $Button3
			_du()
		Case $Button4
			$Index= _GUICtrlListView_GetSelectedIndices($ListView1)
			$Indexcj= StringSplit($Index, "|")
			If Not StringLen($Index) Then
				GUICtrlSetData($Label1,"提示:请选择后再进行修改操作!")
			Else
			   For $k = 1 To $Indexcj[0]
				   $tempz=IniRead($temp,"Temp","批量修改","")
				   If $tempz="IPX 地址" Then
							_GUICtrlListView_AddSubItem ($ListView1, $Indexcj[$k], GUICtrlRead($Combo1), 3, 3)
							GUICtrlSetData($Label1,"提示:["&$tempz&"]批量修改成功！请即时保存配置")
							_jc()
					ElseIf $tempz="子网掩码" Then
							_GUICtrlListView_AddSubItem ($ListView1, $Indexcj[$k], GUICtrlRead($Input5), 4, 4)
							GUICtrlSetData($Label1,"提示:["&$tempz&"]批量修改成功！请即时保存配置")
							_jc()
					ElseIf $tempz="默认网关" Then
							_GUICtrlListView_AddSubItem ($ListView1, $Indexcj[$k], GUICtrlRead($Input6), 5, 5)
							GUICtrlSetData($Label1,"提示:["&$tempz&"]批量修改成功！请即时保存配置")
							_jc()
					ElseIf $tempz="首选 DNS" Then
							_GUICtrlListView_AddSubItem ($ListView1, $Indexcj[$k], GUICtrlRead($Input7), 6, 6)
							GUICtrlSetData($Label1,"提示:["&$tempz&"]批量修改成功！请即时保存配置")
							_jc()
					ElseIf $tempz="备用 DNS" Then
							_GUICtrlListView_AddSubItem ($ListView1, $Indexcj[$k], GUICtrlRead($Input8), 7, 7)
							GUICtrlSetData($Label1,"提示:["&$tempz&"]批量修改成功！请即时保存配置")
							_jc()
					ElseIf $tempz="分 辩 率" Then
							_GUICtrlListView_AddSubItem ($ListView1, $Indexcj[$k], GUICtrlRead($Combo2), 8, 8)
							GUICtrlSetData($Label1,"提示:["&$tempz&"]批量修改成功！请即时保存配置")
							_jc()
					ElseIf $tempz="还原软件" Then
							_GUICtrlListView_AddSubItem ($ListView1, $Indexcj[$k], GUICtrlRead($Input9), 9, 9)
							GUICtrlSetData($Label1,"提示:["&$tempz&"]批量修改成功！请即时保存配置")
							_jc()
					ElseIf $tempz="IDE 通道" Then
							_GUICtrlListView_AddSubItem ($ListView1, $Indexcj[$k], GUICtrlRead($Combo3), 10, 10)
							GUICtrlSetData($Label1,"提示:["&$tempz&"]批量修改成功！请即时保存配置")
							_jc()
					EndIf		
			   Next			   
		   EndIf
		Case $Button5
			If FileExists("NetbarGhostClient.exe") Then 
					ShellExecute("NetbarGhostClient.exe")
			Else
				GUICtrlSetData($Label1,"提示:未找到客户端程序请重新下载 下载地址:http://jycel.ys168.com")
			EndIf		   
		Case $Button6
			_xr()
			_save()
		case $Button7;添加
			If _GUICtrlListView_FindInText($ListView2, GUICtrlRead($Combo5)) = -1 Then _GUICtrlListView_AddItem($ListView2, GUICtrlRead($Combo5), 2, 0)
			;_savelist2()
		case $jia
			$listjia=InputBox("程序添加","请输入需要添加至选择栏的名称"&@CRLF&@CRLF&"添加后请右键编缉，程序自动保存","","",-1,135,-1,-1,30)	
			If @error=0 Then
					IniWrite($ini,"Runlist",$listjia,"")
					GUICtrlSetData($Label1,"写入成功"&$listjia)
			ElseIf @error=2 Then
					GUICtrlSetData($Label1,"添加超时！请重新点击  提示:30秒未设置自动关闭")
			EndIf			
			_Runlist()
		case $server1
			MsgBox(64,"相关配置帮助说明","启动服务端,程序自动读取本机信息"&@CRLF&@CRLF _
			&"还原软件：填写参数为你自己的还原安装程序[自动安装程序]"&@CRLF&@CRLF _
			&"分 辨 率：直接选择多数显示器类型，查看配置可手动修改" &@CRLF&@CRLF _
			&"禁用网卡：需要禁用多余网卡的硬件ID" &@CRLF&@CRLF _
			&"查找方法:我的电脑-属性-硬件-设备管理器-网络适配器-选中你要禁用的网卡-属性-详细信息-属性中" &@CRLF&@CRLF _
			&"          选择硬件ID-选中值中任意一个按CTRL+C[右键无法复制]-然后粘贴至文件中即可查看." &@CRLF&@CRLF _
			&"          例：PCI\VEN_11AB&DEV_4364&SUBSYS_00BA11AB&REV_14其中的DEV_4364就为设备硬件ID号"&@CRLF&@CRLF _
			&"I D E通道：[加快开机]请在母盘测试客户端时关闭本功能，否则克盘后会造成蓝屏现像！"&@CRLF&@CRLF _
			&"T：客户端倒计时设置时间，单位为秒 默认30秒后开始设置！")
 		case $server2
			MsgBox(64,"扫描帮助说明","扫描前请在开始IP和结束IP中填写正确的IP地址，建议在不同网段全部扫描"&@CRLF&@crlf _
			& "例：在192.168.0.1网断扫描192.168.0.1~255和在192.168.1.1扫描192.168.1.1~255"&@CRLF&@crlf _
			& "MAC地址分隔符：在扫描MAC信息时所生成的格式，默认'-'格式 "&@CRLF&@crlf _
			& "查看配置：自动打开mdb.ini配置文件，方便手动修改和查看"&@CRLF&@crlf _
			& "另注：如果在同网段有不同分辨率，可分IP扫描，保存后再配置参数扫描"&@CRLF&@crlf _
			& "      也可全部扫描后，使用批量修改法修改相关参数（推荐使用批量修改）")
 		case $server3
			MsgBox(64,"附加程序帮助说明","请在添加按钮上面选择的需要添加的附加程序   本程序附带【病毒免役】程序"&@CRLF&@crlf _
			&"附加程序将在设置好IP等相关信息后，安装还原软件之前安装！"&@CRLF&@crlf _
			&"也可点击+号向选择栏添加程序，列表内右键执行编缉、删除、清空操作"&@CRLF&@crlf _
			&"注意：添加程序后请右键编缉该程序，然后配置对应执行程序名，确定后自动保存")
		case $MenuItem4
			Run(@ProgramFilesDir & "\Internet Explorer\iexplore.exe http://autoit.net.cn/viewthread.php?tid=9464&extra=page%3D1")
		Case $MenuItem5
			If FileExists("update.exe") Then
			ShellExecute("update.exe")
			Exit
		Else
			GUICtrlSetData($Label1,"未找到升级文件-update.exe 请到http://jycel.ys168.com下载")
			EndIf
		Case $MenuItem6
			Run(@ProgramFilesDir & "\Internet Explorer\iexplore.exe http://472891322.qzone.qq.com")
		Case $MenuItem7 ;关于程序
			MsgBox(64,"关于程序 BY-Jycel","本程序适合广大网吧网管同胞使用"&@CRLF _
			&@CRLF&"本程序是采用Autoit3脚本语言编写出来的"&@CRLF _
			&@CRLF&"如果你对本程序有任何疑问或建议，请联系作者"&@CRLF _
			&@CRLF&"更新地址:  http://jycel.ys168.com")
		Case $MenuItem8
			DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 500, "long", 0x00050010)
			If FileExists($temp) Then
				FileDelete($temp)
			EndIf
			Exit		
;===================================						
		case $x_menu2
			$Listv2 = _GUICtrlListView_GetSelectedIndices($ListView2)
			If Not StringLen($Listv2) Then
				GUICtrlSetData($Label1,"提示:请选择后再进行编缉操作!")
			Else
			$l2name=_GUICtrlListView_GetItemText($ListView2, Number($Listv2),0)
			$list2z=InputBox($l2name,"请输入【"&$l2name&"】相对应的执行程序名"&@crlf&@crlf&"例如:"&$l2name&".exe",$l2name&".*","",-1,135,-1,-1,30)	
			If @error=0 Then
					IniWrite($ini,"附加程序",$l2name,$list2z)
					GUICtrlSetData($Label1,"写入成功！【"&$l2name&"】→"&$list2z)
			ElseIf @error=1 Then
					GUICtrlSetData($Label1,"【"&$l2name&"】当前未配置")
			ElseIf @error=2 Then
					GUICtrlSetData($Label1,"写入超时！请重新编缉  提示:30秒未设置自动关闭")
			EndIf
		EndIf
		case $d_menu2;删除
			_del2()
		case $k_menu2;	清空
			_GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($ListView2))
			;_savelist2()
			IniDelete($ini,"附加程序")
			GUICtrlSetData($Label1,"提示:数据清空成功！")
		Case $c_menu
			_GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($ListView1))
			GUICtrlSetData($Label1,"提示:数据清空成功！")			
		case $e_menu;编缉
			$Index = _GUICtrlListView_GetSelectedIndices($ListView1)
			If Not StringLen($Index) Then
				GUICtrlSetData($Label1,"提示:请选择后再进行编缉操作!")
				Else
			GUICtrlSetData($Label1,"提示:请手动修改下面设置后点击更新数据按钮!")
			EndIf
		case $d_menu;删除
			_del()
		case $all1_menu
			_jz()
			$List_n=_GUICtrlListView_GetItemCount($ListView1)
			If Not $List_n Then
				GUICtrlSetData($Label1,"错误:当前夫任何数据!请扫描或读取后再操作")
				Else
					GUICtrlSetData($Label1,"提示:请在IPX地址栏选择参数规则再更新数据! 修改完毕请保存配置")
					GUICtrlSetState($Combo1,$GUI_ENABLE)
					IniWrite($temp,"Temp","批量修改","IPX 地址")
			EndIf		
		case $all2_menu
			_jz()
			$List_n=_GUICtrlListView_GetItemCount($ListView1)
			If Not $List_n Then
				GUICtrlSetData($Label1,"错误:当前夫任何数据!请扫描或读取后再操作")
				Else			
			GUICtrlSetData($Label1,"提示:请在子网掩码栏修改参数再更新数据! 修改完毕请保存配置")
			GUICtrlSetState($Input5,$GUI_ENABLE)
			IniWrite($temp,"Temp","批量修改","子网掩码")
			EndIf
		case $all3_menu
			_jz()
			$List_n=_GUICtrlListView_GetItemCount($ListView1)
			If Not $List_n Then
				GUICtrlSetData($Label1,"错误:当前夫任何数据!请扫描或读取后再操作")
				Else			
			GUICtrlSetData($Label1,"提示:请在默认网关栏修改参数再更新数据! 修改完毕请保存配置")
			GUICtrlSetState($Input6,$GUI_ENABLE)
			IniWrite($temp,"Temp","批量修改","默认网关")
			EndIf
		case $all4_menu
			_jz()
			$List_n=_GUICtrlListView_GetItemCount($ListView1)
			If Not $List_n Then
				GUICtrlSetData($Label1,"错误:当前夫任何数据!请扫描或读取后再操作")
				Else			
			GUICtrlSetData($Label1,"提示:请在首选 DNS栏修改参数再更新数据! 修改完毕请保存配置")
			GUICtrlSetState($Input7,$GUI_ENABLE)
			IniWrite($temp,"Temp","批量修改","首选 DNS")
			EndIf
		case $all5_menu
			_jz()
			$List_n=_GUICtrlListView_GetItemCount($ListView1)
			If Not $List_n Then
				GUICtrlSetData($Label1,"错误:当前夫任何数据!请扫描或读取后再操作")
				Else			
			GUICtrlSetData($Label1,"提示:请在备用 DNS栏修改参数再更新数据! 修改完毕请保存配置")
			GUICtrlSetState($Input8,$GUI_ENABLE)
			IniWrite($temp,"Temp","批量修改","备用 DNS")
			EndIf
		case $all6_menu
			_jz()
			$List_n=_GUICtrlListView_GetItemCount($ListView1)
			If Not $List_n Then
				GUICtrlSetData($Label1,"错误:当前夫任何数据!请扫描或读取后再操作")
				Else
			GUICtrlSetData($Label1,"提示:请在分 辩 率栏选择参数规则再更新数据! 修改完毕请保存配置")
			GUICtrlSetState($Combo2,$GUI_ENABLE)
			IniWrite($temp,"Temp","批量修改","分 辩 率")
			EndIf
		case $all7_menu
			_jz()
			$List_n=_GUICtrlListView_GetItemCount($ListView1)
			If Not $List_n Then
				GUICtrlSetData($Label1,"错误:当前夫任何数据!请扫描或读取后再操作")
				Else			
			GUICtrlSetData($Label1,"提示:请在还原软件栏修改参数再更新数据! 修改完毕请保存配置")
			GUICtrlSetState($Input9,$GUI_ENABLE)
			IniWrite($temp,"Temp","批量修改","还原软件")
			EndIf
		case $all8_menu
			_jz()
			$List_n=_GUICtrlListView_GetItemCount($ListView1)
			If Not $List_n Then
				GUICtrlSetData($Label1,"错误:当前夫任何数据!请扫描或读取后再操作")
				Else			
			GUICtrlSetData($Label1,"提示:请在IDE 通道栏选择参数规则再更新数据! 修改完毕请保存配置")
			GUICtrlSetState($Combo3,$GUI_ENABLE)
			IniWrite($temp,"Temp","批量修改","IDE 通道")
			EndIf	

	EndSwitch
WEnd
Func _xr()
IniWrite($ini,"配置","禁用网卡",GUICtrlRead($Input10))
IniWrite($ini,"配置","倒计时间",GUICtrlRead($Input11))
GUICtrlSetData($Label1,"数据更新成功!")
EndFunc
Func _du()
	_jc()
_GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($ListView1))
Dim $var = IniReadSection($ini, "Maclist"), $item[1], $i
If @error Then
	GUICtrlSetData($Label1,"提示:配置中未找到相关数据！请先扫描！")
	Else
For $i = 1 to $var[0][0]
     $item[$i-1] = GUICtrlCreateListViewItem($var[$i][0] & '|' & $var[$i][1], $ListView1)
     ReDim $item[$i+1]
next
GUICtrlSetData($Label1,"数据读取成功!")
EndIf
EndFunc

Func __TCPIpToName($sIp, $iOption = Default, $hDll_Ws2_32 = Default)
	Local $vbinIP, $vaDllCall, $vptrHostent, $vHostent, $sHostnames, $vh_aliases, $i
	Local $INADDR_NONE = 0xffffffff, $AF_INET = 2, $sSeperator = @CR
	If $iOption = Default Then $iOption = 0
	If $hDll_Ws2_32 = Default Then $hDll_Ws2_32 = "Ws2_32.dll"
	$vaDllCall = DllCall($hDll_Ws2_32, "long", "inet_addr", "str", $sIp)
	If @error Then Return SetError(1, 0, "") ; inet_addr DllCall Failed
	$vbinIP = $vaDllCall[0]
	If $vbinIP = $INADDR_NONE Then Return SetError(2, 0, "") ; inet_addr Failed
	$vaDllCall = DllCall($hDll_Ws2_32, "ptr", "gethostbyaddr", "long*", $vbinIP, "int", 4, "int", $AF_INET)
	If @error Then Return SetError(3, 0, "") ; gethostbyaddr DllCall Failed
	$vptrHostent = $vaDllCall[0]
	If $vptrHostent = 0 Then
		$vaDllCall = DllCall($hDll_Ws2_32, "int", "WSAGetLastError")
		If @error Then Return SetError(5, 0, "") ; gethostbyaddr Failed, WSAGetLastError Failed
		Return SetError(4, $vaDllCall[0], "") ; gethostbyaddr Failed, WSAGetLastError = @Extended
	EndIf
	$vHostent = DllStructCreate("ptr;ptr;short;short;ptr", $vptrHostent)
	$sHostnames = __TCPIpToName_szStringRead(DllStructGetData($vHostent, 1))
	If @error Then Return SetError(6, 0, $sHostnames) ; strlen/sZStringRead Failed
	If $iOption = 1 Then
		$sHostnames &= $sSeperator
		For $i = 0 To 63 ; up to 64 Aliases
			$vh_aliases = DllStructCreate("ptr", DllStructGetData($vHostent, 2) + ($i * 4))
			If DllStructGetData($vh_aliases, 1) = 0 Then ExitLoop ; Null Pointer
			$sHostnames &= __TCPIpToName_szStringRead(DllStructGetData($vh_aliases, 1))
			If @error Then
				SetError(7) ; Error reading array
				ExitLoop
			EndIf
		Next
		Return StringSplit(StringStripWS($sHostnames, 2), @CR)
	Else
		Return $sHostnames
	EndIf
EndFunc   ;==>__TCPIpToName
Func __TCPIpToName_szStringRead($iszPtr, $iLen = -1, $hDll_msvcrt = "msvcrt.dll")
	Local $aStrLen, $vszString
	If $iszPtr < 1 Then Return "" ; Null Pointer
	If $iLen < 0 Then
		$aStrLen = DllCall($hDll_msvcrt, "int:cdecl", "strlen", "ptr", $iszPtr)
		If @error Then Return SetError(1, 0, "") ; strlen Failed
		$iLen = $aStrLen[0] + 1
	EndIf
	$vszString = DllStructCreate("char[" & $iLen & "]", $iszPtr)
	If @error Then Return SetError(2, 0, "")
	Return SetError(0, $iLen, DllStructGetData($vszString, 1))
EndFunc   ;==>__TCPIpToName_szStringRead
Func _API_Get_NetworkAdapterMAC($sIp)
	Local $MAC, $MACSize
	Local $i, $s, $r, $iIP

	$MAC = DllStructCreate("byte[6]")
	$MACSize = DllStructCreate("int")

	DllStructSetData($MACSize, 1, 6)
	$r = DllCall("Ws2_32.dll", "int", "inet_addr", "str", $sIp)
	$iIP = $r[0]
	$r = DllCall("iphlpapi.dll", "int", "SendARP", "int", $iIP, "int", 0, "ptr", DllStructGetPtr($MAC), "ptr", DllStructGetPtr($MACSize))
	$s = ""
	For $i = 0 To 5
		If $i Then $s = $s & GUICtrlRead($Combo4)
		$s = $s & Hex(DllStructGetData($MAC, 1, $i + 1), 2)
	Next
	If $s = "00:00:00:00:00:00"  Then SetError(1)
	Return $s
EndFunc   ;==>_API_Get_NetworkAdapterMAC
Func _NetworkAdapterInfo()
	Local $colItems = ""
	Local $objWMIService
	Local $NetworkAdapterID = 0
	Local $NetworkAdapterName = ""
	Local $NetworkAdapterGateway = ""
	Local $NetworkAdapterHostName = ""
	Local $NetworkAdapterIPaddress = ""
	Local $NetworkAdapterDNS1 = ""
	Local $NetworkAdapterDNS2 = ""
	Local $NetworkAdapterSubnet = ""
	Local $NetworkAdapterMAC = ""
	Local $NetworkAdapterNetConnectionID = ""
	Local $NetworkAdapterInfo[10][10] ;最高10块网卡.
	$NetworkAdapterInfo[0][0] = 0
	$objWMIService = ObjGet("winmgmts:\\localhost\root\CIMV2")
	$colItems = $objWMIService.ExecQuery("SELECT * FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled != 0", "WQL", 0x10 + 0x20)
	$colItem2 = $objWMIService.ExecQuery('SELECT * FROM Win32_NetworkAdapter WHERE NetConnectionStatus >0', "WQL", 0x10 + 0x20)
	If IsObj($colItems) Then
		For $objItem In $colItems
			$NetworkAdapterName = $objItem.Description
			$NetworkAdapterGateway = $objItem.DefaultIPGateway(0)
			$NetworkAdapterHostName = $objItem.DNSHostName
			$NetworkAdapterIPaddress = $objItem.IPAddress(0)
			$NetworkAdapterDNS1 = $objItem.DNSServerSearchOrder(0)
			$NetworkAdapterDNS2 = $objItem.DNSServerSearchOrder(1)
			$NetworkAdapterSubnet = $objItem.IPSubnet(0)
			$NetworkAdapterMAC = $objItem.MACAddress
			$NetworkAdapterID += 1
			$NetworkAdapterInfo[0][0] = $NetworkAdapterID
			$NetworkAdapterInfo[$NetworkAdapterID][0] = $NetworkAdapterID
			$NetworkAdapterInfo[$NetworkAdapterID][1] = $NetworkAdapterName
			$NetworkAdapterInfo[$NetworkAdapterID][2] = $NetworkAdapterGateway
			$NetworkAdapterInfo[$NetworkAdapterID][3] = $NetworkAdapterHostName
			$NetworkAdapterInfo[$NetworkAdapterID][4] = $NetworkAdapterIPaddress
			$NetworkAdapterInfo[$NetworkAdapterID][5] = $NetworkAdapterDNS1
			$NetworkAdapterInfo[$NetworkAdapterID][6] = $NetworkAdapterDNS2
			$NetworkAdapterInfo[$NetworkAdapterID][7] = $NetworkAdapterSubnet
			$NetworkAdapterInfo[$NetworkAdapterID][8] = $NetworkAdapterMAC
		Next
	Else
		Return $NetworkAdapterInfo
	EndIf

	If IsObj($colItem2) Then
		$NetworkAdapterID = 0
		For $objItem2s In $colItem2
			$NetworkAdapterNetConnectionID = $objItem2s.NetConnectionID
			$NetworkAdapterID += 1
			$NetworkAdapterInfo[$NetworkAdapterID][9] = $NetworkAdapterNetConnectionID
		Next
		Return $NetworkAdapterInfo
	Else
		Return $NetworkAdapterInfo
	EndIf
EndFunc   ;==>_NetworkAdapterInfo
Func WM_NOTIFY($hWndGUI, $MsgID, $WParam, $LParam)
 
        Local $tagNMHDR, $Event, $hWndFrom, $IDFrom
        Local $tagNMHDR = DllStructCreate("int;int;int", $LParam)
        If @error Then Return $GUI_RUNDEFMSG
        $IDFrom = DllStructGetData($tagNMHDR, 2)
        $Event = DllStructGetData($tagNMHDR, 3)
        $tagNMHDR = 0
        Switch $IDFrom;选择产生事件的控件
 
                Case $ListView1
 
                        Switch $Event; 选择产生的事件

									Case $NM_CLICK ; 左击
					                    $Index = _GUICtrlListView_GetSelectedIndices($ListView1)
                                        If Not StringLen($Index) Then; 这里用以判断是否选定了ListViewItem
											$List_n=_GUICtrlListView_GetItemCount($ListView1)
													If Not $List_n Then
														GUICtrlSetData($Label1,"提示:当前无任何数据请先扫描")
													EndIf
                                               ;GUICtrlSetData($Label1,"提示:请先选中数据再进行相关操作，没有数据请先扫描")
                                                Return
											EndIf
												GUICtrlSetData($Label1,"提示:请点击右键操作[编缉数据]|[删除按钮]|[清空数据]|[批量编缉]")
                                    			GUICtrlSetData($Input1,_GUICtrlListView_GetItemText($ListView1, Number($Index),1))
												GUICtrlSetData($Input2,_GUICtrlListView_GetItemText($ListView1, Number($Index),2))
												GUICtrlSetData($Input3,_GUICtrlListView_GetItemText($ListView1, Number($Index),0))
												GUICtrlSetData($Combo1,_GUICtrlListView_GetItemText($ListView1, Number($Index),3))
												GUICtrlSetData($Input5,_GUICtrlListView_GetItemText($ListView1, Number($Index),4))
												GUICtrlSetData($Input6,_GUICtrlListView_GetItemText($ListView1, Number($Index),5))
												GUICtrlSetData($Input7,_GUICtrlListView_GetItemText($ListView1, Number($Index),6))
												GUICtrlSetData($Input8,_GUICtrlListView_GetItemText($ListView1, Number($Index),7))
												GUICtrlSetData($Input9,_GUICtrlListView_GetItemText($ListView1, Number($Index),9))
												GUICtrlSetData($Combo2,_GUICtrlListView_GetItemText($ListView1, Number($Index),8))
												GUICtrlSetData($Combo3,_GUICtrlListView_GetItemText($ListView1, Number($Index),10))									
                                 Case $NM_DBLCLK ; 双击
					                    $Index = _GUICtrlListView_GetSelectedIndices($ListView1)
                                        If Not StringLen($Index) Then; 这里用以判断是否选定了ListViewItem
                                               GUICtrlSetData($Label1,"提示:请先选中数据再进行相关操作，没有数据请先扫描")
                                                Return
											EndIf
											GUICtrlSetData($Label1,"提示:请点击右键操作[编缉数据]|[删除按钮]|[清空数据]|[批量编缉]")
                                    			GUICtrlSetData($Input1,_GUICtrlListView_GetItemText($ListView1, Number($Index),1))
												GUICtrlSetData($Input2,_GUICtrlListView_GetItemText($ListView1, Number($Index),2))
												GUICtrlSetData($Input3,_GUICtrlListView_GetItemText($ListView1, Number($Index),0))
												GUICtrlSetData($Combo1,_GUICtrlListView_GetItemText($ListView1, Number($Index),3))
												GUICtrlSetData($Input5,_GUICtrlListView_GetItemText($ListView1, Number($Index),4))
												GUICtrlSetData($Input6,_GUICtrlListView_GetItemText($ListView1, Number($Index),5))
												GUICtrlSetData($Input7,_GUICtrlListView_GetItemText($ListView1, Number($Index),6))
												GUICtrlSetData($Input8,_GUICtrlListView_GetItemText($ListView1, Number($Index),7))
												GUICtrlSetData($Input9,_GUICtrlListView_GetItemText($ListView1, Number($Index),9))
												GUICtrlSetData($Combo2,_GUICtrlListView_GetItemText($ListView1, Number($Index),8))
												GUICtrlSetData($Combo3,_GUICtrlListView_GetItemText($ListView1, Number($Index),10))									
                                Case $NM_RCLICK ; 右击
;~                                         ...
                        EndSwitch
 
        EndSwitch
 
        Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY
Func _del()
			$Index = _GUICtrlListView_GetSelectedIndices($ListView1)
			If Not StringLen($Index) Then
				GUICtrlSetData($Label1,"提示:请选择后再进行删除操作!")
				Else
			_GUICtrlListView_DeleteItem(GUICtrlGetHandle($ListView1), $Index)
			GUICtrlSetData($Label1,"提示:删除成功!")
		EndIf
EndFunc		

Func _del2()
			$Index1 = _GUICtrlListView_GetSelectedIndices($ListView2)
			If Not StringLen($Index1) Then
				GUICtrlSetData($Label1,"提示:请选择后再进行删除操作!")
				Else
			$l2name=_GUICtrlListView_GetItemText($ListView2, Number($Index1),0)
			_GUICtrlListView_DeleteItem(GUICtrlGetHandle($ListView2), $Index1)
			IniDelete($ini,"附加程序",$l2name)
			GUICtrlSetData($Label1,"提示:附加程序列表【"&$l2name&"】删除成功!")
		EndIf
EndFunc

Func _save()
       $List_n=_GUICtrlListView_GetItemCount($ListView1)
		If Not $List_n Then
				GUICtrlSetData($Label1,"错误:请先扫描好之后再点击列表格保存！！！")
			Else
				IniWrite($ini, "扫描提示", "最后扫描时间", _
				StringFormat("%4d-%1d-%1d %1d:%02d:%02d", @YEAR, @MON, @MDAY, @HOUR, @MIN, @SEC)&@crlf)
					For $i = 0 To $List_n - 1
			            $MacItem = _GUICtrlListView_GetItemTextArray($ListView1, $i)
							If $MacItem[0] <> 11 Then ContinueLoop
							IniWrite($ini, "Maclist", $MacItem[1], $MacItem[2] & "|" & $MacItem[3] & "|" & $MacItem[4] & "|" & $MacItem[5] & "|" & $MacItem[6] & "|" & $MacItem[7] & "|" & $MacItem[8] & "|" & $MacItem[9] & "|" & $MacItem[10] & "|" & $MacItem[11])
					Next
			          GUICtrlSetData($Label1,"提示:所有数据保存完毕!共"&$List_n&"个信息")
		EndIf
EndFunc				  

Func _sm()
			Switch GUICtrlRead($Button1)
				Case 1
					$ws=$aIP1[3]-$aIP0[3]+1
					_GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($ListView1))
					TCPStartup()
					;定义：步进、IP总数
					Local $iStep = 1, $gross, $n = 0
					$gross = $aIP0[3] - $aIP1[3]
					If $gross > 0 Then
						$iStep = -1
					Else
						$gross = Abs($gross)
					EndIf
					$gross += 1
					$aIP0[3] -= $iStep
					Do
						$aIP0[3] += $iStep 
							GUICtrlSetData($Progress1, Int(100 * ($gross - Abs($aIP1[3] - $aIP0[3])) / $gross));进度条百分点
						$nIP = $aIP0[0] & "." & $aIP0[1] & "." & $aIP0[2] & "." & $aIP0[3]
						
						Ping($nIP, 5)
						If @error Then ContinueLoop
						$nHost = __TCPIpToName($nIP)
						$nMAC = _API_Get_NetworkAdapterMAC($nIP)
						If  @error Or Not $nHost Then ContinueLoop
						_GUICtrlListView_AddItem ($ListView1, $nMAC, $n)
						_GUICtrlListView_AddSubItem ($ListView1, $n, $nHost, 1, 1)
						_GUICtrlListView_AddSubItem ($ListView1, $n, $nIP, 2, 2)
						_GUICtrlListView_AddSubItem ($ListView1, $n, GUICtrlRead($Input5), 4, 4)
						_GUICtrlListView_AddSubItem ($ListView1, $n, GUICtrlRead($Combo1), 3, 3)
						_GUICtrlListView_AddSubItem ($ListView1, $n, GUICtrlRead($Input6), 5, 5)
						_GUICtrlListView_AddSubItem ($ListView1, $n, GUICtrlRead($Input7), 6, 6)
						_GUICtrlListView_AddSubItem ($ListView1, $n, GUICtrlRead($Input8), 7, 7)
						_GUICtrlListView_AddSubItem ($ListView1, $n, GUICtrlRead($Combo2), 8, 8)
						_GUICtrlListView_AddSubItem ($ListView1, $n, GUICtrlRead($Input9), 9, 9)
						_GUICtrlListView_AddSubItem ($ListView1, $n, GUICtrlRead($Combo3), 10, 10)
						
						$n += 1
						GUICtrlSetData($Label1,"正在扫描中,请稍候…… ["&$n&"/"&$ws&"]"&"  当前IP:"&$nIP)
						;$ip4 =StringRegExpReplace(GUICtrlRead($IPAddress2),'(\d+\.){3}', '')
					Until GUICtrlRead($Button1) <> 1 Or $aIP0[3] = $aIP1[3]
					TCPStartup()
					GUICtrlSetState($Button1, 4)
					GUICtrlSetData($Progress1, 0)
				Case Else
					GUICtrlSetData($Progress1, 0)
			EndSwitch
					GUICtrlSetData($Label1,"提示:[扫描完毕] 一共:"&$ws&"个 完成:"&$ws&"个 "&"成功:["&$n&"]个 失败:["&$ws-$n&"]个")	
EndFunc				
				
Func _Default();生成默认配置文件
	MsgBox(48,"温馨提醒您:", "未找到程序配置文件,程序将自动创建."& @CRLF &"请使用服务端工具扫描配置信息.",2)
	IniWrite($ini , "版权信息", "技术QQ","472891322")
    IniWrite($ini , "版权信息", "E-mail","jycel@qq.com")
	IniWrite($ini, "版权信息", "作者空间","http://472891322.qzone.qq.com/"&@CRLF)
	IniWrite($ini, "配置", "倒计时间","30")
	IniWrite($ini, "配置", "禁用网卡","DEV_8139")
	IniWrite($ini, "配置", "IE首页","http://v.tfol.com/netbar.htm")
	IniWrite($ini, "配置", "IE标题","飛翔網絡-将快乐网起来!")
	IniWrite($ini, "配置", "IE状态栏信息","欢迎光临飛翔網絡 TEL:0816-2624067 技术QQ:472891322"&@CRLF)
	IniWrite($ini, "Maclist", "mac","机名|IP")
	IniWrite($ini, "Maclist", "00-E0-61-15-C5-43", "A001|192.168.0.11|IP规则|255.255.255.0|192.168.0.1|202.98.96.68|61.139.2.69|1440*900*32*75|网维大师|开启")
	IniWrite($ini, "Maclist", "00-1D-0F-24-66-1E", "NetGame|192.168.0.254"&@CRLF)
	IniWrite($ini, "使用说明", "使用说明", "本程序只支持三组IP,请仔细看例子,修改对应IP即可,不明请咨询QQ472891322"&@CRLF)
	IniWrite($ini, "分辨率", "1024*768*32*85", "此处不要添写，程序只读前面关键字，可修改其中数据")
	IniWrite($ini, "分辨率", "1440*900*32*75", "同上")
	IniWrite($ini, "分辨率", "1680*1050*32*75", "同上"&@CRLF)
	IniWrite($ini, "Runlist", "病毒免役", "")	
	IniWrite($ini, "Runlist", "服务优化", ""&@CRLF)	
	IniWrite($ini, "附加程序", "病毒免役", ""&@CRLF)		
	IniWrite($ini, "Cs15Key", "1","6801563651288")
	IniWrite($ini, "Cs15Key", "2","3294345689725")
	IniWrite($ini, "Cs15Key", "3","2292823454228")
	IniWrite($ini, "Cs15Key", "4","7842715618877")
	IniWrite($ini, "Cs15Key", "5","3865568763903")
	IniWrite($ini, "Cs15Key", "6","5013955315983")
	IniWrite($ini, "Cs15Key", "7","3094945136861")
	IniWrite($ini, "Cs15Key", "8","2726631268402")
	IniWrite($ini, "Cs15Key", "9","1421339652155")
	IniWrite($ini, "Cs15Key", "10","2293026703085")
	IniWrite($ini, "Cs15Key", "11","1977560827768")
	IniWrite($ini, "Cs15Key", "12","2996620270749")
	IniWrite($ini, "Cs15Key", "13","0072430366426")
	IniWrite($ini, "Cs15Key", "14","7893392675840")
	IniWrite($ini, "Cs15Key", "15","2623436581467")
	IniWrite($ini, "Cs15Key", "16","2367234335487")
	IniWrite($ini, "Cs15Key", "17","5899430794142")
	IniWrite($ini, "Cs15Key", "18","6373906794557")
	IniWrite($ini, "Cs15Key", "19","0186166087129")
	IniWrite($ini, "Cs15Key", "20","9309282185282")
	IniWrite($ini, "Cs15Key", "21","9942810937876")
	IniWrite($ini, "Cs15Key", "22","2702926069367")
	IniWrite($ini, "Cs15Key", "23","2873922711009")
	IniWrite($ini, "Cs15Key", "24","3182452724788")
	IniWrite($ini, "Cs15Key", "25","2881320716061")
	IniWrite($ini, "Cs15Key", "26","3882348620722")
	IniWrite($ini, "Cs15Key", "27","2498521763020")
	IniWrite($ini, "Cs15Key", "28","9745406730972")
	IniWrite($ini, "Cs15Key", "29","3995846325049")
	IniWrite($ini, "Cs15Key", "30","3990645369061")
	IniWrite($ini, "Cs15Key", "31","3881442673780")
	IniWrite($ini, "Cs15Key", "32","4722953384569")
	IniWrite($ini, "Cs15Key", "33","5991335738183")
	IniWrite($ini, "Cs15Key", "34","0943252509979")
	IniWrite($ini, "Cs15Key", "35","0057329934856")
	IniWrite($ini, "Cs15Key", "36","7597026797903")
	IniWrite($ini, "Cs15Key", "37","1509899106786")
	IniWrite($ini, "Cs15Key", "38","9080368774300")
	IniWrite($ini, "Cs15Key", "39","2306437281560")
	IniWrite($ini, "Cs15Key", "40","8047751630688")
	IniWrite($ini, "Cs15Key", "41","2572265422347")
	IniWrite($ini, "Cs15Key", "42","2897524202721")
	IniWrite($ini, "Cs15Key", "43","9525803960507")
	IniWrite($ini, "Cs15Key", "44","3896321644454")
	IniWrite($ini, "Cs15Key", "45","2575508916775")
	IniWrite($ini, "Cs15Key", "46","3832845609762")
	IniWrite($ini, "Cs15Key", "47","5109677149369")
	IniWrite($ini, "Cs15Key", "48","2007224885708")
	IniWrite($ini, "Cs15Key", "49","2304525119809")
	IniWrite($ini, "Cs15Key", "50","0700233570541")
	IniWrite($ini, "Cs15Key", "51","3892248363021")
	IniWrite($ini, "Cs15Key", "52","3049152178425")
	IniWrite($ini, "Cs15Key", "53","0143005967914")
	IniWrite($ini, "Cs15Key", "54","5895638781104")
	IniWrite($ini, "Cs15Key", "55","5512355833199")
	IniWrite($ini, "Cs15Key", "56","2348134376448")
	IniWrite($ini, "Cs15Key", "57","3005789616110")
	IniWrite($ini, "Cs15Key", "58","2492629725023")
	IniWrite($ini, "Cs15Key", "59","7169336493198")
	IniWrite($ini, "Cs15Key", "60","5498338402186")
	IniWrite($ini, "Cs15Key", "61","2810029507117")
	IniWrite($ini, "Cs15Key", "62","8295771797102")
	IniWrite($ini, "Cs15Key", "63","1320904578028")
	IniWrite($ini, "Cs15Key", "64","5531764511342")
	IniWrite($ini, "Cs15Key", "65","5898238712127")
	IniWrite($ini, "Cs15Key", "66","5998632785122")
	IniWrite($ini, "Cs15Key", "67","0514846371932")
	IniWrite($ini, "Cs15Key", "68","0416231170064")
	IniWrite($ini, "Cs15Key", "69","3015038603991")
	IniWrite($ini, "Cs15Key", "70","2120338265425")
	IniWrite($ini, "Cs15Key", "71","9589846712664")
	IniWrite($ini, "Cs15Key", "72","3667588858575")
	IniWrite($ini, "Cs15Key", "73","5464829472848")
	IniWrite($ini, "Cs15Key", "74","2833689982865")
	IniWrite($ini, "Cs15Key", "75","3997145348020")
	IniWrite($ini, "Cs15Key", "76","2494731044643")
	IniWrite($ini, "Cs15Key", "77","1150596958039")
	IniWrite($ini, "Cs15Key", "78","3398042694766")
	IniWrite($ini, "Cs15Key", "79","3799042684746")
	IniWrite($ini, "Cs15Key", "80","2701338554560")
	IniWrite($ini, "Cs15Key", "81","4879687250041")
	IniWrite($ini, "Cs15Key", "82","2128042478263")
	IniWrite($ini, "Cs15Key", "83","3578243538587")
	IniWrite($ini, "Cs15Key", "84","3096244508581")
	IniWrite($ini, "Cs15Key", "85","4336435699588")
	IniWrite($ini, "Cs15Key", "86","2317233759548")
	IniWrite($ini, "Cs15Key", "87","2727132555486")
	IniWrite($ini, "Cs15Key", "88","6996551041203")
	IniWrite($ini, "Cs15Key", "89","0463262884916")
	IniWrite($ini, "Cs15Key", "90","2792231045626")
	IniWrite($ini, "Cs15Key", "91","1154247940716")
	IniWrite($ini, "Cs15Key", "92","2344284682451")
	IniWrite($ini, "Cs15Key", "93","2146333363483")
	IniWrite($ini, "Cs15Key", "94","7040402632368")
	IniWrite($ini, "Cs15Key", "95","5555142687861")
	IniWrite($ini, "Cs15Key", "96","3922648525588")
	IniWrite($ini, "Cs15Key", "97","2498020435749")
	IniWrite($ini, "Cs15Key", "98","8039436549949")
	IniWrite($ini, "Cs15Key", "99","2696734026608")
	IniWrite($ini, "Cs15Key", "100","2396032072643")
	IniWrite($ini, "Cs15Key", "101","5634030696618")
	IniWrite($ini, "Cs15Key", "102","8362321875446")
	IniWrite($ini, "Cs15Key", "103","9748585333927")
	IniWrite($ini, "Cs15Key", "104","9539130852949")
	IniWrite($ini, "Cs15Key", "105","9724143611498")
	IniWrite($ini, "Cs15Key", "106","9035730237150")
	IniWrite($ini, "Cs15Key", "107","1765628747642")
	IniWrite($ini, "Cs15Key", "108","8267335625064")
	IniWrite($ini, "Cs15Key", "109","9872308440938")
	IniWrite($ini, "Cs15Key", "110","0040945670291")
	IniWrite($ini, "Cs15Key", "111","7437120445097")
	IniWrite($ini, "Cs15Key", "112","2914557016520")
	IniWrite($ini, "Cs15Key", "113","5201939075592")
	IniWrite($ini, "Cs15Key", "114","7023459460265")
	IniWrite($ini, "Cs15Key", "115","0004084032358")
	IniWrite($ini, "Cs15Key", "116","2579488650504")
	IniWrite($ini, "Cs15Key", "117","1435403495605")
	IniWrite($ini, "Cs15Key", "118","5722891164576")
	IniWrite($ini, "Cs15Key", "119","5812923357220")
	IniWrite($ini, "Cs15Key", "120","0684570142794")
	IniWrite($ini, "Cs15Key", "121","9051295359780")
	IniWrite($ini, "Cs15Key", "122","0766160464649")
	IniWrite($ini, "Cs15Key", "123","6023089585711")
	IniWrite($ini, "Cs15Key", "124","7282726715071")
	IniWrite($ini, "Cs15Key", "125","6965198320844")
	IniWrite($ini, "Cs15Key", "126","0590638349985")
	IniWrite($ini, "Cs15Key", "127","4887920308855")
	IniWrite($ini, "Cs15Key", "128","6224273676938")
	IniWrite($ini, "Cs15Key", "129","0234070701672")
	IniWrite($ini, "Cs15Key", "130","6829133462999")
	IniWrite($ini, "Cs15Key", "131","1514397024359")
	IniWrite($ini, "Cs15Key", "132","0338114504295")
	IniWrite($ini, "Cs15Key", "133","9180097837863")
	IniWrite($ini, "Cs15Key", "134","5695926015450")
	IniWrite($ini, "Cs15Key", "135","3160620118964")
	IniWrite($ini, "Cs15Key", "136","1190096475687")
	IniWrite($ini, "Cs15Key", "137","8359933291311")
	IniWrite($ini, "Cs15Key", "138","2696985056117")
	IniWrite($ini, "Cs15Key", "139","7853809758364")
	IniWrite($ini, "Cs15Key", "140","2111724559521")
	IniWrite($ini, "Cs15Key", "141","0578332166402")
	IniWrite($ini, "Cs15Key", "142","5735257958665")
	IniWrite($ini, "Cs15Key", "143","7914860615387")
	IniWrite($ini, "Cs15Key", "144","4063606421917")
	IniWrite($ini, "Cs15Key", "145","3419830076512")
	IniWrite($ini, "Cs15Key", "146","7381489152175")
	IniWrite($ini, "Cs15Key", "147","1628431817077")
	IniWrite($ini, "Cs15Key", "148","2876552803407")
	IniWrite($ini, "Cs15Key", "149","8856983770314")
	IniWrite($ini, "Cs15Key", "150","7530358675181")
	IniWrite($ini, "Cs15Key", "151","5174560117316")
	IniWrite($ini, "Cs15Key", "152","7322581102730")
	IniWrite($ini, "Cs15Key", "153","0719965552707")
	IniWrite($ini, "Cs15Key", "154","5620798081913")
	IniWrite($ini, "Cs15Key", "155","3185381184427")
	IniWrite($ini, "Cs15Key", "156","8680457335754")
	IniWrite($ini, "Cs15Key", "157","9869960983369")
	IniWrite($ini, "Cs15Key", "158","6915151587317")
	IniWrite($ini, "Cs15Key", "159","1272066388570")
	IniWrite($ini, "Cs15Key", "160","9301433546382")
	IniWrite($ini, "Cs15Key", "161","5817471724979")
	IniWrite($ini, "Cs15Key", "162","7946642797514")
	IniWrite($ini, "Cs15Key", "163","3926072554435")
	IniWrite($ini, "Cs15Key", "164","9956746016428")
	IniWrite($ini, "Cs15Key", "165","0590651353471")
	IniWrite($ini, "Cs15Key", "166","1714170985947")
	IniWrite($ini, "Cs15Key", "167","5499802054656")
	IniWrite($ini, "Cs15Key", "168","1163480853697")
	IniWrite($ini, "Cs15Key", "169","3739923265822")
	IniWrite($ini, "Cs15Key", "170","3354655249230")
	IniWrite($ini, "Cs15Key", "171","1204514178341")
	IniWrite($ini, "Cs15Key", "172","8144711732971")
	IniWrite($ini, "Cs15Key", "173","8451579776433")
	IniWrite($ini, "Cs15Key", "174","8206536922064")
	IniWrite($ini, "Cs15Key", "175","7267404852062")
	IniWrite($ini, "Cs15Key", "176","6365487067597")
	IniWrite($ini, "Cs15Key", "177","4919689608720")
	IniWrite($ini, "Cs15Key", "178","2960547428824")
	IniWrite($ini, "Cs15Key", "179","0504759069059")
	IniWrite($ini, "Cs15Key", "180","3050776320471")
	IniWrite($ini, "Cs15Key", "181","0694888961606")
	IniWrite($ini, "Cs15Key", "182","9655746791606")
	IniWrite($ini, "Cs15Key", "183","9610972107773")
	IniWrite($ini, "Cs15Key", "184","7937556243769")
	IniWrite($ini, "Cs15Key", "185","5898414073778")
	IniWrite($ini, "Cs15Key", "186","8334441434100")
	IniWrite($ini, "Cs15Key", "187","5988643975322")
	IniWrite($ini, "Cs15Key", "188","3522855506549")
	IniWrite($ini, "Cs15Key", "189","2721837712087")
	IniWrite($ini, "Cs15Key", "190","0375939353208")
	IniWrite($ini, "Cs15Key", "191","8326908182312")
	IniWrite($ini, "Cs15Key", "192","0058411868073")
	IniWrite($ini, "Cs15Key", "193","7386866002317")
	IniWrite($ini, "Cs15Key", "194","9415036075966")
	IniWrite($ini, "Cs15Key", "195","9415034784963")
	IniWrite($ini, "Cs15Key", "196","9268017928447")
	IniWrite($ini, "Cs15Key", "197","2554301377411")
	IniWrite($ini, "Cs15Key", "198","6199709193805")
	IniWrite($ini, "Cs15Key", "199","6595690064434")
	IniWrite($ini, "Cs15Key", "200","8764101331054")
	IniWrite($ini, "Cs15Key", "201","8695699602249")
	IniWrite($ini, "Cs15Key", "202","3953514404409")
	IniWrite($ini, "Cs15Key", "203","6308441865835")
	IniWrite($ini, "Cs15Key", "204","5438918032640")
	IniWrite($ini, "Cs15Key", "205","3567485290466")
	IniWrite($ini, "Cs15Key", "206","8052441431786")
EndFunc

Func _jz()
	GUICtrlSetState($Input1,$GUI_DISABLE)
	GUICtrlSetState($Input2,$GUI_DISABLE)
	GUICtrlSetState($Combo1,$GUI_DISABLE)
	GUICtrlSetState($Input5,$GUI_DISABLE)
	GUICtrlSetState($Input6,$GUI_DISABLE)
	GUICtrlSetState($Input7,$GUI_DISABLE)
	GUICtrlSetState($Input8,$GUI_DISABLE)
	GUICtrlSetState($Combo2,$GUI_DISABLE)
	GUICtrlSetState($Input9,$GUI_DISABLE)
	GUICtrlSetState($Input10,$GUI_DISABLE)
	GUICtrlSetState($Combo3,$GUI_DISABLE)
EndFunc	
Func _jc()
	GUICtrlSetState($Input1,$GUI_ENABLE)
	GUICtrlSetState($Input2,$GUI_ENABLE)
	GUICtrlSetState($Combo1,$GUI_ENABLE)
	GUICtrlSetState($Input5,$GUI_ENABLE)
	GUICtrlSetState($Input6,$GUI_ENABLE)
	GUICtrlSetState($Input7,$GUI_ENABLE)
	GUICtrlSetState($Input8,$GUI_ENABLE)
	GUICtrlSetState($Combo2,$GUI_ENABLE)
	GUICtrlSetState($Input9,$GUI_ENABLE)
	GUICtrlSetState($Input10,$GUI_ENABLE)
	GUICtrlSetState($Combo3,$GUI_ENABLE)
EndFunc

Func _dulist2()
;=================读取配置文件中的附加程序至列表中=================================
Dim $yylist=IniReadSection($ini,"附加程序")
If @error Then
	GUICtrlSetData($Label1,"提示:附加程序列表读取失败！原因:未找到相关数据！")
	Else
For $l = 1 to $yylist[0][0]
    GUICtrlCreateListViewItem($yylist[$l][0], $ListView2)
next
EndIf
;=================读取配置文件中的附加程序至列表中=================================
EndFunc
Func _savelist2();保存列表二中的所有数据至配置文件中
			IniDelete($ini,"附加程序")
			$List2=_GUICtrlListView_GetItemCount($ListView2);取行数
				If Not $List2 Then
						GUICtrlSetData($Label1,"错误:您未添加任何附加程序！请添加后再保存！")
				Else
						For $i = 0 To $List2 - 1
							$MacItem = _GUICtrlListView_GetItemTextArray($ListView2, $i)
							IniWrite($ini, "附加程序", $MacItem[1],"")
						Next
							GUICtrlSetData($Label1,"提示:添加并保存成功!共"&$List2&"个数据")
				EndIf
EndFunc

Func _Runlist()
$Runlists = IniReadSection($ini, "Runlist")
For $R = 1 To $Runlists[0][0]
	GUICtrlSetData($Combo5,$Runlists[$R][0],$Runlists[1][0])
Next
EndFunc