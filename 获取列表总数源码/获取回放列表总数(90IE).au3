#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=..\工具\综合软件\3D风格ICO图标\IE.ico
#AutoIt3Wrapper_outfile=获取回放列表总数(90IE).exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#Include <GuiListView.au3>
Local $xiaozhan , $count  
 $title = WinGetTitle("[CLASS:IEFrame]", "")
	;MsgBox(4160, "Information" ,$title)
	WinActivate($title,"Playback")  ;激活指定的窗口(设置焦点到该窗口,使其成为活动窗口)
	$xiaozhan = ControlGetHandle ( $title, "", "SysListView322")  ;获取指定控件的内部句柄.
	$count = _GUICtrlListView_GetItemCount($xiaozhan) ;获取列表视图控件的项目数
	MsgBox(1, "获取回放列表总数" ,"获取回放列表总数:  " & $count)
	IniWrite(@ScriptDir & "\获取回放列表总数(90IE).ini", "列表", "总数", $count) 



