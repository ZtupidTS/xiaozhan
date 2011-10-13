#Include <GuiToolBar.au3>
#Include <WinAPI.au3>
#Include <GuiListView.au3>

AutoItSetOption( "MustDeclareVars", 1 )
AutoItSetOption( "WinTitleMatchMode", 3 )

Local $TrayParentWindow
Local $TrayNotifyWindow
Local $TrayAreaWindow
Local $MiniThunderWindow
Local $i
Local $TrayButtonCount
Local $TrayButtonText
Local $TrayButtonCommandID

Local $MiniThunderWindowTitle = "[CLASS:#32770;TITLE:迷你迅雷]"

; search mini thunder window and activate it
$MiniThunderWindow = WinGetHandle( $MiniThunderWindowTitle )
If $MiniThunderWindow = 0 Then
	#cs

	$TrayParentWindow = WinGetHandle( "[CLASS:Shell_TrayWnd]" )
	$TrayNotifyWindow = ControlGetHandle( $TrayParentWindow, "", "[CLASS:TrayNotifyWnd]" )
	$TrayAreaWindow = ControlGetHandle( $TrayNotifyWindow, "", "[CLASS:ToolbarWindow32]" )
	$TrayButtonCount = _GUICtrlToolbar_ButtonCount($TrayAreaWindow)
	For $i = 0 To ( $TrayButtonCount - 1 )
		$TrayButtonCommandID = _GUICtrlToolbar_IndexToCommand( $TrayAreaWindow, $i )
		$TrayButtonText = _GUICtrlToolbar_GetButtonText( _
			$TrayAreaWindow, _
			$TrayButtonCommandID )

		If $TrayButtonText = "迷你迅雷" Then

			; double click
			_GUICtrlToolbar_ClickButton( _
				$TrayAreaWindow, _
				$TrayButtonCommandID )
			Sleep( 100 )
			_GUICtrlToolbar_ClickButton( _
				$TrayAreaWindow, _
				$TrayButtonCommandID )
			ExitLoop
		EndIf
	Next

	$MiniThunderWindow = WinWait( $MiniThunderWindowTitle, "", 5 )
	If $MiniThunderWindow = 0 Then
		MsgBox( 0, "错误", "打开 迷你迅雷 窗口失败!" )
		Exit
	EndIf

	#ce
	; it will not go here !!!
Else
	; @_@... the mini thunder hiding here !!!
	_WinAPI_ShowWindow($MiniThunderWindow, @SW_SHOW )
EndIf

WinActivate( $MiniThunderWindow )
WinWaitActive( $MiniThunderWindow, "" )

; change to history page
Local $MiniThunderWindowPos
Local $HistoryListWindow
Local $HistoryListItemCount
Local $Temp

$MiniThunderWindowPos = WinGetPos( $MiniThunderWindow )
if $MiniThunderWindowPos[0] = -32000 Then
	MsgBox( 0, "错误", "迷你迅雷 窗口最小化?!" )
	Exit
EndIf

MouseMove( _
	$MiniThunderWindowPos[0] + $MiniThunderWindowPos[2] - 14, _
	$MiniThunderWindowPos[1] + 123, _
	5 )
MouseClick( "left" )

; loop to remove all items
$HistoryListWindow = ControlGetHandle( $MiniThunderWindow, "", "[CLASS:SysListView32; INSTANCE:2]" )
While ( _GUICtrlListView_GetItemCount( $HistoryListWindow ) > 0  )
	_GUICtrlListView_ClickItem( $HistoryListWindow, 0 )
	Sleep( 50 )
	Send( "{DELETE}" )
	$Temp = WinWaitActive( "[CLASS:#32770;TITLE:提示]" )
	ControlClick( $Temp, "确定", "[CLASS:Button; INSTANCE:1]" )
	Sleep( 500 )
WEnd







