#include <IE.au3>
$Name = 'zhqf2020' ;”√ªß√˚
$Pass = '19831012' ;√‹¬Î

$oIE = _IECreate("mail.126.com")
_IELoadWait($oIE)

$Input = _IEGetObjById($oIE, "iptUser")
$Input.value = $Name

$Input = _IEGetObjById($oIE, "iptPwd")
$Input.value = $Pass

$oSubmit = _IEGetObjByName ($oIE, "enter.x")
_IEAction ($oSubmit, "click")