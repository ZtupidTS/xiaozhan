#include <LocalSecurityAuthority.au3>

; ��ҪLocalSecurityAuthority.au3���ļ�֧�֡�
; ���ص�ַ - http://www.autoit.net.cn/viewthread.php?tid=7080&extra=page%3D2
; AU3 ��ȡADSL�������룬�������ADSL�����û����õ��Ľ��ǿ�ֵ(?)��
$pSid = _LookupAccountName(@UserName) ; ��ȡ�û�SIDָ�롣
$sSid = _ConvertSidToStringSid($pSid) ; ת��Ϊ�ַ���SID��
_HeapFree($pSid)

; ���������16��������
$bData = _LsaRetrievePrivateData("RasDialParams!" & $sSid & "#0")
$iSize = @extended ; @extended ����Ϊ���ݳ��ȡ�

; ���룬ת��Ϊ�������ݡ�
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
Msgbox(0, 'ADSL �˺�����', $sR)

;�����û����������ŵ�λ�ò�ͬ��ֻ���"RasDialParams!" & $sSid & "#0"��Ϊ"L$_RasDefaultCredentials#0"�Ϳ�����