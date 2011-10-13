$g_szVersion2 = "我的窗口"
HotKeySet('!z','huifu')
if WinExists($g_szVersion2) and not @SW_MINIMIZE  Then ;WinExists(检查指定的窗口是否存在)
mini()
Else
huifu()
EndIf

func huifu()
winSetState($g_szVersion2,'',@SW_RESTORE) ;winSetState(显示、隐藏、最小化、最大化或还原某个窗口) SW_RESTORE(撤销窗口的最小化或最大化状态)
EndFunc

func mini()
winSetState($g_szVersion2,'',@SW_MINIMIZE) ;winSetState(显示、隐藏、最小化、最大化或还原某个窗口) SW_MINIMIZE(最小化窗口)
EndFunc