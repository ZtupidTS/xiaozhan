#include-once
#cs===========================================
;_EnvCreate(����,ֵ)
_EnvCreate("test","This is test")
;_EnvSet(����,ֵ)
_EnvSet("test","is trim")
;_EnvDel(����)
_EnvSet("test")
#ce===========================================

Func _EnvCreate($_EnvName,$_EnvValue)
$strComputer = "."
$objWMIService = ObjGet("winmgmts:\\" & $strComputer & "\root\cimv2")
$objVariable = $objWMIService.Get("Win32_Environment").SpawnInstance_   ;ʹ��spawninstance_�����������հ׻�������
;���û�����������
$objVariable.Name = $_EnvName
$objVariable.UserName = "<System>"
$objVariable.VariableValue = $_EnvValue
$objVariable.Put_  ;�ύ���
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