; 以下为自动设置样本，您也可以根据您的需求来设置导入
;版权归所有ACN爱好者所有。。。。。。。
;各位有好的软件也一起研究学习，多多指点  QQ：530417369
Func _ipxwrite($ipxzh = "0")
        $ipxxiang='"VirtualNetworkNumber"'
        $ipxregxiangset="HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NwlnkIpx\Parameters"
        $ipxhao="dword:"&$ipxzh
        FileWrite(@TempDir&"\ipx.reg",_IPXSET())
        IniWrite(@TempDir&"\ipx.reg",$ipxregxiangset,$ipxxiang,$ipxhao)
        RunWait(@WindowsDir &"\regedit.exe /s "&@TempDir&"\ipx.reg")
        FileDelete(@TempDir&"\ipx.reg")
EndFunc
;以下是IPX注册表项，请勿修改，XP测试有效！
Func _ipxSET()
Local $FileBin=""
$FileBin &="52454745444954340D0A0D0A5B484B45595F4C4F43414C5F4D414348494E455C53595354454D5C43757272656E74436F6E74726F6C5365745C53657276696365735C4E776C6E6B4970785C506172616D65746572735D0D0A225669727475616C4E657477"
$FileBin &="6F726B4E756D626572223D64776F72643A32320D0A"
Return Binary("0x" & $FileBin)
EndFunc