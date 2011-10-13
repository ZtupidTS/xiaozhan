#include <LocalSecurityAuthority.au3>

$sUserAccount = "Guest" ; 要禁用的账户名称。
$pUserFlags = _LsaLocalUserGetInfo($sUserAccount, 1)
$tBuffer = DllStructCreate("dword Flags", $pUserFlags + 24)
$iUserFlags = DllStructGetData($tBuffer, "Flags")
_FreeVariable($tBuffer, 0, _LsaApiBufferFree($pUserFlags))

$iUserFlags = bitOR($iUserFlags, 2) ; 禁用
; If bitAnd($iUserFlags, 2) Then $iUserFlags = bitXOR($iUserFlags, 2) ; 启用

$fResult = _LsaLocalUserSetInfo($sUserAccount, 1008, $iUserFlags, "dword*")
If ($fResult) Then
        Msgbox(64, "", "Done~")
Else
        Msgbox(48, "", "Failed, error code: " & @error)
EndIf