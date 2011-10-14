HotKeySet("{ESC}", "Terminate")
HotKeySet("{F2}", "Togglepause")
#Include <Date.au3>
Local  $a=0 ,$Paused 
Dim $K = 1

$i = 0
Do
;BlockInput(1)
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
WinActivate("NetViewer","Login")
Sleep(500)
ControlClick("NetViewer","Login","Button9")

WinActivate("NetViewer","Login")
$var = ControlGetText("NetViewer", "Login Failed!", "Static11");获取指定控件上的文本.
$I=StringCompare($var,"Login Failed!");按选项比较两个字符串.
If $I = 1 Then   ; 字符串1 包含 字符串2
	_write208($K)
	$K+=1
	Sleep(1000)
EndIf	

Sleep(30*1000)
WinWait("NetViewer","Logout")
WinActivate("NetViewer","Logout")
ControlClick("NetViewer","Logout","Button6")

$tCur = _Date_Time_GetLocalTime()
MemoWrite("当前日期/时间 : " & _Date_Time_SystemTimeToDateTimeStr($tCur))


 
  $a = IniRead ("d:\保存时间.ini", "保存", "次数" ,"")
 IniWrite("d:\保存时间.ini", "保存", "次数" , $a+1) 
 
WinWait("NetViewer","Login")

;BlockInput(0)

$i = $i + 1
Until $i = 100000000



Func MemoWrite($sMessage)
     IniWrite("d:\保存时间.ini", "保存时间", "时间", $sMessage);(@ScriptDir &
 EndFunc 
 
Func _write208($K)
  $file = FileOpen('d:\登录不上208.ini', 1)
  FileWrite($file , $K & '次登录不上时间:     ' & @year & "/" & @MON & "/"   & @mday & " " & @HOUR & ":" & @MIN & ":" & @SEC & @CRLF)
  FileClose($file )
EndFunc
 
Func Terminate()
   
	Exit 0
EndFunc

Func Togglepause()
    $Paused = NOT $Paused 
	
   While $Paused 
	tooltip("暂停一会",0,0)
	sleep(100)
   tooltip("")
   WEnd
EndFunc
