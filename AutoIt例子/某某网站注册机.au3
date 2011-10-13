#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#AutoIt3Wrapper_icon=D:\autoit3\Aut2Exe\Icons\Fetion.ico
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("星漫通行证注册机 QQ:76594695", 267, 196)
$Pic1 = GUICtrlCreatePic("key.gif", 8, 150, 93, 30,BitOR($SS_NOTIFY,$WS_GROUP))
$Input2 = GUICtrlCreateInput("", 140, 152, 57, 21)
$Group1 = GUICtrlCreateGroup("", 8, 6, 249, 129)
$Label1 = GUICtrlCreateLabel("注册账号：", 20, 32, 64, 17)
$Label2 = GUICtrlCreateLabel("注册邮箱：", 20, 67, 64, 17)
$Input3 = GUICtrlCreateInput("", 88, 28, 81, 21)
$Input4 = GUICtrlCreateInput("", 88, 63, 153, 21)
$Checkbox_zd = GUICtrlCreateCheckbox("自动生成", 176, 30, 65, 17)
$Label1 = GUICtrlCreateLabel("验证码加载中,请稍后...", 18, 101, 228, 15,$SS_CENTER)
GUICtrlSetColor(-1, 0xFF0000)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetFont(-1,11, 400, 0, "宋体")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button_ks = GUICtrlCreateButton("开始", 206, 151, 49, 25, 0)
GUICtrlSetState(-1,$GUI_DEFBUTTON)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
 
_sc()
_get_key()
While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
                Case $GUI_EVENT_CLOSE
                        Exit
                Case $Button_ks
            $yzm = GUICtrlRead($Input2)
            if $yzm = "" then
               GUICtrlSetData($Label1 ,"请手动输入验证码!!!")
             Else
               _post(GUICtrlRead($Input3),GUICtrlRead($Input4),"12345678",$yzm)
               _sc()
                        EndIf
        EndSwitch
WEnd
 
Func _get_key()
InetGet ("http://passport.7xingman.com/VerifyCode.ashx", "key.gif")
GUICtrlSetImage ($pic1,"key.gif")
GUICtrlSetData($Label1 ,"验证码获取完成,可以开始注册了")
EndFunc
 
Func _sc()
$name = _ran_dom(1,Random(1, 5, 1))&_ran_dom(0,Random(5, 7, 1))
GUICtrlSetData($Input3 ,$name)
$email = _ran_dom(1,Random(1, 5, 1))&_ran_dom(0,Random(5, 7, 1))&"@"&_ran_dom(1,Random(1, 5, 1))&".com"
GUICtrlSetData($Input4 ,$email)
EndFunc
 
 
Func _post($name,$email,$pass,$yzm)
$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("post","http://passport.7xingman.com/Server/Json/Controller.ashx ",false)
$oHTTP.setRequestHeader("Cache-Control", "no-cache")
$oHTTP.setRequestHeader("Content-Type","application/x-www-form-urlencoded")  
$oHTTP.setRequestHeader("Referer","http://passport.7xingman.com/account/register.aspx?zone=web&gameid=1")
$oHTTP.setRequestHeader("Content-Length","250")
$oHTTP.Send("user_account="&$name&"&user_password="&$pass&"&confirm_password="&$pass&"&user_email="&$email&"&verify_code="&$yzm&"&agree=1&MN=Register&zone=web&gameid=1")
$a = $oHTTP.responseText 
$a = _Search($a,'{"ReturnValue":(.*?),"Message":null,"Data":null}')
if $a = "0" then 
GUICtrlSetData($Label1,"["&$name&"]注册成功!!!")
FileWrite("log.txt",$name&@CRLF)
EndIf
EndFunc
 
Func _Search($IE_txt,$Condition)
        Local $Result
        $array = StringRegExp($IE_txt,$Condition, 2, 1)
        for $i = 0 to UBound($array) - 1
            $Result = $array[$i]
                Next
        Return $Result
EndFunc
 
Func _ran_dom($var,$n)
        $cdk = ""
        if $var = 1 then 
             FOR $i= 1 to $n
              $cdk = $cdk&Chr(Random(Asc("a"), Asc("z")))
             Next
         Else
             FOR $i= 1 to $n
              $cdk = $cdk&Chr(Random(Asc("1"), Asc("9")))
            Next
        EndIf 
        Return $cdk
EndFunc