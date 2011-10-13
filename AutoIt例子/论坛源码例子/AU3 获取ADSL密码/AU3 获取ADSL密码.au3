#include <LocalSecurityAuthority.au3>

; 需要LocalSecurityAuthority.au3库文件支持。
; 下载地址 - http://www.autoit.net.cn/viewthread.php?tid=7080&extra=page%3D2
; AU3 截取ADSL拨号密码，如果不是ADSL上网用户，得到的将是空值(?)。
$pSid = _LookupAccountName(@UserName) ; 获取用户SID指针。
$sSid = _ConvertSidToStringSid($pSid) ; 转换为字符型SID。
_HeapFree($pSid)

; 返回密码的16进制数据
$bData = _LsaRetrievePrivateData("RasDialParams!" & $sSid & "#0")
$iSize = @extended ; @extended 被设为数据长度。

; 解码，转换为名文数据。
$tB = DllStructCreate("byte[" & $iSize & "]")
$pB = DllStructGetPtr($tB)
$tW = DllStructCreate("wchar[" & $iSize / 2 & "]", $pB)
DllStructSetData($tB, 1, $bData)
$sR = ""
For $i = 1 to $iSize / 2
        $sC = DllStructGetData($tW, 1, $i)
        If $sC = Chr(0) And StringRight($sR, 1) <> " " Then $sR &= " "
        If $sC <> Chr(0) Then $sR &= $sC
Next
Msgbox(0, 'ADSL 账号密码', $sR)

;所有用户”的密码存放的位置不同，只需把"RasDialParams!" & $sSid & "#0"改为"L$_RasDefaultCredentials#0"就可以了