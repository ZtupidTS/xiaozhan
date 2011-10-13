#include <Array.au3>
#cs
DWORD GetAdaptersInfo(
  __out    PIP_ADAPTER_INFO pAdapterInfo,        ; IP_ADAPTER_INFO �ṹָ�롣
  __inout  PULONG pOutBufLen                ; IP_ADAPTER_INFO �ṹ��С��
);

PIP_ADAPTER_INFO        - IP_ADAPTER_INFO�ṹָ�룬�ṹ�������£�
typedef struct _IP_ADAPTER_INFO {
  struct _IP_ADAPTER_INFO *Next;        ; ��һ��������Ϣ����ʼ��ַ
  DWORD                   ComboIndex;
  char                    AdapterName[MAX_ADAPTER_NAME_LENGTH + 4];
  char                    Description[MAX_ADAPTER_DESCRIPTION_LENGTH + 4];
  UINT                    AddressLength;
  BYTE                    Address[MAX_ADAPTER_ADDRESS_LENGTH];
  DWORD                   Index;
  UINT                    Type;
  UINT                    DhcpEnabled;
  PIP_ADDR_STRING         CurrentIpAddress;
  IP_ADDR_STRING          IpAddressList;
  IP_ADDR_STRING          GatewayList;
  IP_ADDR_STRING          DhcpServer;
  BOOL                    HaveWins;
  IP_ADDR_STRING          PrimaryWinsServer;
  IP_ADDR_STRING          SecondaryWinsServer;
  time_t                  LeaseObtained;
  time_t                  LeaseExpires;
}IP_ADAPTER_INFO, *PIP_ADAPTER_INFO;

IP_ADDR_STRING - �ṹ�������£�
struct _IP_ADDR_STRING *Next;
  IP_ADDRESS_STRING      IpAddress;        ; IP ��ַ
  IP_MASK_STRING         IpMask;        ; ��������
  DWORD                  Context;
}IP_ADDR_STRING, *PIP_ADDR_STRING;

AutoIt IP_ADDR_STRING �ṹ�������£�
ptr Next;char IpAddr[16];char IpMask[16];dword Context


AutoIt IP_ADAPTER_INFO �ṹ�������£�

ptr NextAdpt; dword ComboIndex; char AdptName[260]; char AdptDescr[132];uint AddrLength;byte MacAddr[8];dword Index;uint Type; uint DncpEnabled;ptr 

CurrentIpAddr;ptr NextIpAddr; char IpAddr[16];char IpAddrMask[16]; dword IpAddrCxt; ptr NextGateway; char GatewayAddr[16]; char GatewayAddrMask

[16];dword GatewayCxt; ptr NextDhcp; char DhcpAddr[16]; char DhcpAddrMask[16];dword DhcpCxt; int HaveWins; ptr NextPriWinsServer; char 

PriWinsServerAddr[16]; char PriWinsServerAddrMask[16]; dword PriWinsServerCxt; ptr NextSecWinsServer; char SecWinsServerAddr[16]; char 

SecWinsServerAddrMask[16]; dword LeaseObtained; dword LeaseExpires



PULONG                - IP_ADAPTER_INFO,�ṹ��С.
#ce

Func _GetAdaptersInfo()
        Local $iResult, $tBuffer, $pBuffer, $aResult[1][9], $tagADPTINFO, $tAdpt

        ; ��һ�ε��ô��ݿ�ֵ��pOutBufLen ( $iResult[2] ) ��Ϊ�ṹ�����С����λbyte��
        $iResult = DllCall("iphlpapi.dll", "dword", "GetAdaptersInfo", "ptr", 0, "ulong*", 0)
        $tBuffer = DllStructCreate("byte[" & $iResult[2] & "]") ; ����$iResult[2] �ֽڵĻ������� (�����ڴ�ռ�)��
        $pBuffer = DllStructGetPtr($tBuffer) ; ��ȡ�ڴ�ָ�롣

        ; �ڶ��ε��ã�GetAdaptersInfo��������Ϣ���Ƶ�ָ�����ڴ�ռ� ($tBuffer) �С�
        $iResult = DllCall("iphlpapi.dll", "dword", "GetAdaptersInfo", "ptr", $pBuffer, "ulong*", $iResult[2])
        ; $iResult[0]ֵΪ0����óɹ�������Ϊϵͳ����š�

        ; ����ת���� byte --> IP_ADAPTER_INFO

        $tagADPTINFO = "ptr NextAdpt; dword ComboIndex; char AdptName[260]; char AdptDescr[132];uint AddrLength;byte MacAddr[8];dword Index;uint Type; uint DncpEnabled;ptr CurrentIpAddr;ptr NextIpAddr; char IpAddr[16];char IpAddrMask[16]; dword IpAddrCxt; ptr NextGateway; char GatewayAddr[16]; char GatewayAddrMask[16];dword GatewayCxt; ptr NextDhcp; char DhcpAddr[16]; char DhcpAddrMask[16];dword DhcpCxt; int HaveWins; ptr NextPriWinsServer; char PriWinsServerAddr[16]; char PriWinsServerAddrMask[16]; dword PriWinsServerCxt; ptr NextSecWinsServer; char SecWinsServerAddr[16]; char SecWinsServerAddrMask[16]; dword LeaseObtained; dword LeaseExpires"

        While $pBuffer
                $tAdpt = DllStructCreate($tagADPTINFO, $pBuffer)
                $aResult[0][0] += 1
                Redim $aResult[$aResult[0][0] + 1][9]
                $aResult[$aResult[0][0]][0] = DllStructGetData($tAdpt, "AdptName") ; ��������
                $aResult[$aResult[0][0]][1] = DllStructGetData($tAdpt, "AdptDescr") ; ��������
                $aResult[$aResult[0][0]][2] = DllStructGetData($tAdpt, "MacAddr") ; ����MAC
                $aResult[$aResult[0][0]][3] = DllStructGetData($tAdpt, "Index") ; ����������
                $aResult[$aResult[0][0]][4] = DllStructGetData($tAdpt, "Type") ; ����
                $aResult[$aResult[0][0]][5] = DllStructGetData($tAdpt, "DhcpEnabled") ; DHCP�Ƿ����� true = ���ã� false = ����
                $aResult[$aResult[0][0]][6] = DllStructGetData($tAdpt, "IpAddr") ; IP ��ַ
                $aResult[$aResult[0][0]][7] = DllStructGetData($tAdpt, "GatewayAddr") ; ���ص�ַ
                $aResult[$aResult[0][0]][8] = DllStructGetData($tAdpt, "DhcpAddr") ; DHCP��ַ, ֻ��DhcpEnabledΪtrueʱ����ֵ����Ч��
                $pBuffer = DllStructGetData($tAdpt, "NextAdpt") ; [��һ��������Ϣ���ڴ��ַ��]
                $tAdpt = 0
        WEnd
        $tBuffer = 0
        Return SetError($iResult[0], 0, $aResult)
EndFunc        ;==>_GetAdaptersInfo


$a =_GetAdaptersInfo()
_arraydisplay($a, @error)