#cs
#include <IE.au3>
$oIE = _IECreate ("http://mail.163.com")
$oForm = _IEFormGetObjByName ($oIE, "login163")
$oQuery = _IEFormElementGetObjByName ($oForm, "username")
_IEFormElementSetValue ($oQuery, "用户名")
$oQuery = _IEFormElementGetObjByName ($oForm, "password")
_IEFormElementSetValue ($oQuery, "密码")
$oQuery = _IEFormElementGetObjByName ($oForm, "selType")
_IEFormElementOptionSelect ($oQuery , 1, 1, "byIndex")
_IEFormElementCheckboxSelect ($oForm, 0, "", 0, "byIndex")
_IEFormElementCheckboxSelect ($oForm, 1, "", 0, "byIndex") 
$oQuery = _IEFormElementGetObjByName ($oForm, "登录")
_IEAction($oQuery ,"click")
sleep(2000)
_IEAction ($oIE, "visible")
#ce
#include <IE.au3>
$Name = 'zhqf2020' ;用户名
$Pass = '19831012' ;密码

$oIE = _IECreate("mail.163.com")
_IELoadWait($oIE)

$Input = _IEGetObjByName($oIE, "username")
$Input.value = $Name

$Input =_IEGetObjByName($oIE, "password")
$Input.value = $Pass

;$oSubmit = _IEGetObjByName ($oIE, "remUser")
;_IEAction ($oSubmit, "click")

_IELinkClickByText ($oIE, "登陆")

_IELinkClickByIndex ($oIE, 6)

