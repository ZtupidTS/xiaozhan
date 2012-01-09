#include-once
#cs===========================================
;_EnvCreate(名称,值)
_EnvCreate("test","This is test")
;_EnvSet(名称,值)
_EnvSet("test","is trim")
;_EnvDel(名称)
_EnvSet("test")
#ce===========================================

Func _EnvCreate($_EnvName,$_EnvValue)
$strComputer = "."
$objWMIService = ObjGet("winmgmts:\\" & $strComputer & "\root\cimv2")
$objVariable = $objWMIService.Get("Win32_Environment").SpawnInstance_   ;使用spawninstance_方法，创建空白环境变量
;设置环境变量属性
$objVariable.Name = $_EnvName
$objVariable.UserName = "<System>"
$objVariable.VariableValue = $_EnvValue
$objVariable.Put_  ;提交完成
Return SetError(-1)
EndFunc

Func _EnvSet($_EnvName,$_EnvValue)
RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Environment",$_EnvName,"REG_SZ",$_EnvValue)
Return SetError(@error)
EndFunc

Func _EnvDel($_EnvName)
RegDelete("HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Environment",$_EnvName)
Return SetError(@error)
EndFunc