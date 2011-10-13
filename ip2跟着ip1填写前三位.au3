#include <GUIConstantsEx.au3>
#include <GuiIPAddress.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
$Form2 = GUICreate("´°Ìו1", 232, 201, 276, 196)
$IPAddress1 = _GUICtrlIpAddress_Create($Form2, 40, 40, 130, 21)
_GUICtrlIpAddress_Set($IPAddress1, "0.0.0.0")
$IPAddress2 = _GUICtrlIpAddress_Create($Form2, 40, 88, 130, 21)

GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
AdlibRegister ( "auo" ,1000 )

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
WEnd

Func auo()
	$ip1=_GUICtrlIpAddress_Get1 ($IPAddress1)
	$ip2=_GUICtrlIpAddress_Get1 ($IPAddress2)
	If $ip1<>$ip2 Then
		$ip24=_GUICtrlIpAddress_Get2 ($IPAddress2)
	;MsgBox(0,"",$ip1)
_GUICtrlIpAddress_Set($IPAddress2, $ip1&"."&$ip24)	
EndIf
EndFunc


Func _GUICtrlIpAddress_Get1($hWnd)
	If $Debug_IP Then __UDF_ValidateClassName($hWnd, $__IPADDRESSCONSTANT_ClassName)

	Local $tIP = _GUICtrlIpAddress_GetEx($hWnd)

	If @error Then Return SetError(2, 2, "")
	Return StringFormat("%d.%d.%d", DllStructGetData($tIP, "Field1"), _
			DllStructGetData($tIP, "Field2"), _
			DllStructGetData($tIP, "Field3"))
		EndFunc   ;==>_GUICtrlIpAddress_Get
Func _GUICtrlIpAddress_Get2($hWnd)
	If $Debug_IP Then __UDF_ValidateClassName($hWnd, $__IPADDRESSCONSTANT_ClassName)

	Local $tIP = _GUICtrlIpAddress_GetEx($hWnd)

	If @error Then Return SetError(2, 2, "")
	Return StringFormat("%d", DllStructGetData($tIP, "Field4"))
EndFunc   ;==>_GUICtrlIpAddress_Get