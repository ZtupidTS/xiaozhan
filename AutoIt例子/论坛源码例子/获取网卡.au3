#include <Array.au3>
#cs
DWORD GetAdaptersInfo(
  __out    PIP_ADAPTER_INFO pAdapterInfo,        ; IP_ADAPTER_INFO 结构指针。
  __inout  PULONG pOutBufLen                ; IP_ADAPTER_INFO 结构大小。
);

PIP_ADAPTER_INFO        - IP_ADAPTER_INFO结构指针，结构定义如下：
typedef struct _IP_ADAPTER_INFO {
  struct _IP_ADAPTER_INFO *Next;        ; 下一块网卡信息的起始地址
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

IP_ADDR_STRING - 结构定义如下：
struct _IP_ADDR_STRING *Next;
  IP_ADDRESS_STRING      IpAddress;        ; IP 地址
  IP_MASK_STRING         IpMask;        ; 子网掩码
  DWORD                  Context;
}IP_ADDR_STRING, *PIP_ADDR_STRING;

AutoIt IP_ADDR_STRING 结构定义如下：
ptr Next;char IpAddr[16];char IpMask[16];dword Context


AutoIt IP_ADAPTER_INFO 结构定义如下：

ptr NextAdpt; dword ComboIndex; char AdptName[260]; char AdptDescr[132];uint AddrLength;byte MacAddr[8];dword Index;uint Type; uint DncpEnabled;ptr 

CurrentIpAddr;ptr NextIpAddr; char IpAddr[16];char IpAddrMask[16]; dword IpAddrCxt; ptr NextGateway; char GatewayAddr[16]; char GatewayAddrMask

[16];dword GatewayCxt; ptr NextDhcp; char DhcpAddr[16]; char DhcpAddrMask[16];dword DhcpCxt; int HaveWins; ptr NextPriWinsServer; char 

PriWinsServerAddr[16]; char PriWinsServerAddrMask[16]; dword PriWinsServerCxt; ptr NextSecWinsServer; char SecWinsServerAddr[16]; char 

SecWinsServerAddrMask[16]; dword LeaseObtained; dword LeaseExpires



PULONG                - IP_ADAPTER_INFO,结构大小.
#ce

Func _GetAdaptersInfo()
        Local $iResult, $tBuffer, $pBuffer, $aResult[1][9], $tagADPTINFO, $tAdpt

        ; 第一次调用传递空值，pOutBufLen ( $iResult[2] ) 设为结构所需大小，单位byte。
        $iResult = DllCall("iphlpapi.dll", "dword", "GetAdaptersInfo", "ptr", 0, "ulong*", 0)
        $tBuffer = DllStructCreate("byte[" & $iResult[2] & "]") ; 定义$iResult[2] 字节的缓存区域 (分配内存空间)。
        $pBuffer = DllStructGetPtr($tBuffer) ; 获取内存指针。

        ; 第二次调用，GetAdaptersInfo把网卡信息复制到指定的内存空间 ($tBuffer) 中。
        $iResult = DllCall("iphlpapi.dll", "dword", "GetAdaptersInfo", "ptr", $pBuffer, "ulong*", $iResult[2])
        ; $iResult[0]值为0则调用成功，否则为系统错误号。

        ; 数据转换， byte --> IP_ADAPTER_INFO

        $tagADPTINFO = "ptr NextAdpt; dword ComboIndex; char AdptName[260]; char AdptDescr[132];uint AddrLength;byte MacAddr[8];dword Index;uint Type; uint DncpEnabled;ptr CurrentIpAddr;ptr NextIpAddr; char IpAddr[16];char IpAddrMask[16]; dword IpAddrCxt; ptr NextGateway; char GatewayAddr[16]; char GatewayAddrMask[16];dword GatewayCxt; ptr NextDhcp; char DhcpAddr[16]; char DhcpAddrMask[16];dword DhcpCxt; int HaveWins; ptr NextPriWinsServer; char PriWinsServerAddr[16]; char PriWinsServerAddrMask[16]; dword PriWinsServerCxt; ptr NextSecWinsServer; char SecWinsServerAddr[16]; char SecWinsServerAddrMask[16]; dword LeaseObtained; dword LeaseExpires"

        While $pBuffer
                $tAdpt = DllStructCreate($tagADPTINFO, $pBuffer)
                $aResult[0][0] += 1
                Redim $aResult[$aResult[0][0] + 1][9]
                $aResult[$aResult[0][0]][0] = DllStructGetData($tAdpt, "AdptName") ; 网卡名称
                $aResult[$aResult[0][0]][1] = DllStructGetData($tAdpt, "AdptDescr") ; 网卡描述
                $aResult[$aResult[0][0]][2] = DllStructGetData($tAdpt, "MacAddr") ; 网卡MAC
                $aResult[$aResult[0][0]][3] = DllStructGetData($tAdpt, "Index") ; 网卡索引号
                $aResult[$aResult[0][0]][4] = DllStructGetData($tAdpt, "Type") ; 类型
                $aResult[$aResult[0][0]][5] = DllStructGetData($tAdpt, "DhcpEnabled") ; DHCP是否启用 true = 启用， false = 禁用
                $aResult[$aResult[0][0]][6] = DllStructGetData($tAdpt, "IpAddr") ; IP 地址
                $aResult[$aResult[0][0]][7] = DllStructGetData($tAdpt, "GatewayAddr") ; 网关地址
                $aResult[$aResult[0][0]][8] = DllStructGetData($tAdpt, "DhcpAddr") ; DHCP地址, 只有DhcpEnabled为true时，此值才有效。
                $pBuffer = DllStructGetData($tAdpt, "NextAdpt") ; [下一张网卡信息的内存地址。]
                $tAdpt = 0
        WEnd
        $tBuffer = 0
        Return SetError($iResult[0], 0, $aResult)
EndFunc        ;==>_GetAdaptersInfo


$a =_GetAdaptersInfo()
_arraydisplay($a, @error)