HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")

Local  $Paused 

$i = 0
Do
WinActivate ("NetViewer","Area")
;MsgBox(1,"","1",1)
Sleep(1000)
ControlClick("NetViewer","Area","Button145")
;MsgBox(1,"","1",4)
Sleep(1000)
WinActivate ("NetViewer","")
ControlClick("NetViewer","","Button150")
Sleep(1000)

$a = IniRead ( @ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����" ,"")
	IniWrite(@ScriptDir & "\ɾ��ͼƬ����.ini", "����", "����", $a+1) 
	
$i = $i + 1
Until $i = 100000000

Func Terminate()
   
	Exit 0
EndFunc

Func Togglepause()
    $Paused = NOT $Paused 
	
   While $Paused 
	tooltip("��ͣһ��",0,0)
	sleep(100)
   tooltip("")
   WEnd
EndFunc