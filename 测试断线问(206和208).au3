HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")
#Include <Date.au3>
Local   $Paused ,$a,$b
Dim  $K=1,$H=1

$i = 0 
Do
;BlockInput(1)
;208
ShellExecute("NetViewer.exe","","C:\Program Files\NetViewer")
WinWait("NetViewer","Login")
WinActivate("NetViewer","Login")
ControlClick("NetViewer","","Edit4")
WinActivate("NetViewer","Login")
Send("125.89.62.187")
WinActivate("NetViewer","Login")
ControlClick("NetViewer","","Edit3","left",2)
WinActivate("NetViewer","Login")
Send("9009")
WinActivate("NetViewer","Login")
ControlClick("NetViewer","","Edit1","left",2)
WinActivate("NetViewer","Login")
Send("admin")
Sleep(500)
WinActivate("NetViewer","Login")
ControlClick("NetViewer","Login","Button9")

WinActivate("NetViewer","Login")
$var = ControlGetText("NetViewer", "Login Failed!", "Static11");��ȡָ���ؼ��ϵ��ı�.
$I=StringCompare($var,"Login Failed!");��ѡ��Ƚ������ַ���.
If $I = 1 Then   ; �ַ���1 ���� �ַ���2
	 _write208($K)
	$K+=1
	Sleep(1000)
EndIf	

Sleep(120*1000)
;WinWait("NetViewer","Logout")
;WinActivate("NetViewer","Logout")
;ControlClick("NetViewer","Logout","Button6")

$tCur = _Date_Time_GetLocalTime()
MemoWrite("��ǰ����/ʱ�� : " & _Date_Time_SystemTimeToDateTimeStr($tCur))


 
  $a = IniRead ("d:\����ʱ��.ini", "����208", "����" ,"")
 IniWrite("d:\����ʱ��.ini", "����208", "����" , $a+1) 
 
ProcessClose("NetViewer.exe")

Sleep(3000)


;BlockInput(0)

;206
ShellExecute("NetViewer.exe","","C:\Program Files\NetViewer")
WinWait("NetViewer","Login")
WinActivate("NetViewer","Login")
ControlClick("NetViewer","","Edit4")
WinActivate("NetViewer","Login")
Send("125.89.62.187")
WinActivate("NetViewer","Login")
ControlClick("NetViewer","","Edit3","left",2)
WinActivate("NetViewer","Login")
Send("9105")
WinActivate("NetViewer","Login")
ControlClick("NetViewer","","Edit1","left",2)
WinActivate("NetViewer","Login")
Send("admin")
Sleep(500)
WinActivate("NetViewer","Login")
ControlClick("NetViewer","Login","Button9")

WinActivate("NetViewer","Login")
$var = ControlGetText("NetViewer", "Login Failed!", "Static11");��ȡָ���ؼ��ϵ��ı�.
$I=StringCompare($var,"Login Failed!");��ѡ��Ƚ������ַ���.
If $I = 1 Then   ; �ַ���1 ���� �ַ���2
	 _write206($H)
	$H+=1
	Sleep(1000)
EndIf	


Sleep(60*1000)
;WinWait("NetViewer","Logout")
;WinActivate("NetViewer","Logout")
;ControlClick("NetViewer","Logout","Button6")

$tCur = _Date_Time_GetLocalTime()
MemoWrite("��ǰ����/ʱ�� : " & _Date_Time_SystemTimeToDateTimeStr($tCur))


 
  $b = IniRead ("d:\����ʱ��.ini", "����206", "����" ,"")
 IniWrite("d:\����ʱ��.ini", "����206", "����" , $b+1) 
 
ProcessClose("NetViewer.exe")

Sleep(3000)

$i = $i + 1
Until $i = 100000000



Func MemoWrite($sMessage)
     IniWrite("d:\����ʱ��.ini", "����ʱ��", "ʱ��", $sMessage);(@ScriptDir &
 EndFunc 

Func _write208($K)
  $file = FileOpen('d:\��¼����208.ini', 1)
  FileWrite($file , $K & '�ε�¼����ʱ��:     ' & @year & "/" & @MON & "/"   & @mday & " " & @HOUR & ":" & @MIN & ":" & @SEC & @CRLF)
  FileClose($file )
EndFunc

Func _write206($H)
  $file = FileOpen('d:\��¼����206.ini', 1)
  FileWrite($file , $H & '�ε�¼����ʱ��:     ' & @year & "/" & @MON & "/"   & @mday & " " & @HOUR & ":" & @MIN & ":" & @SEC & @CRLF)
  FileClose($file )
EndFunc

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
