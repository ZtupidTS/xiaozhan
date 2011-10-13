#include <LocalSecurityAuthority.au3>

$sUserName = "NewAdmin"
$sPassword = "Password"

$pUserSid = _LsaAddLocalUser($sUserName, $sPassword)
_HeapFree($pUserSid)

$pAdminsSid = _AllocateAndInitializeSid(5, 32, $DOMAIN_ALIAS_RID_ADMINS)
$sAdminsGroup = _LookupAccountSid($pAdminsSid)
$sAdminsGroup = StringTrimLeft($sAdminsGroup, StringInStr($sAdminsGroup, "\"))
_FreeSid($pAdminsSid)

_LsaLocalGroupAddMembers($sAdminsGroup, $sUserName) ; Returns True if succeeds