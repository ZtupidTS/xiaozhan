#cs
#include <IE.au3>
$oIE = _IECreate ("http://mail.163.com")
$oForm = _IEFormGetObjByName ($oIE, "login163")
$oQuery = _IEFormElementGetObjByName ($oForm, "username")
_IEFormElementSetValue ($oQuery, "�û���")
$oQuery = _IEFormElementGetObjByName ($oForm, "password")
_IEFormElementSetValue ($oQuery, "����")
$oQuery = _IEFormElementGetObjByName ($oForm, "selType")
_IEFormElementOptionSelect ($oQuery , 1, 1, "byIndex")
_IEFormElementCheckboxSelect ($oForm, 0, "", 0, "byIndex")
_IEFormElementCheckboxSelect ($oForm, 1, "", 0, "byIndex") 
$oQuery = _IEFormElementGetObjByName ($oForm, "��¼")
_IEAction($oQuery ,"click")
sleep(2000)
_IEAction ($oIE, "visible")
#ce
#include <IE.au3>
$Name = 'zhqf2020' ;�û���
$Pass = '19831012' ;����

$oIE = _IECreate("mail.163.com")
_IELoadWait($oIE)

$Input = _IEGetObjByName($oIE, "username")
$Input.value = $Name

$Input =_IEGetObjByName($oIE, "password")
$Input.value = $Pass

;$oSubmit = _IEGetObjByName ($oIE, "remUser")
;_IEAction ($oSubmit, "click")

_IELinkClickByText ($oIE, "��½")

_IELinkClickByIndex ($oIE, 6)

