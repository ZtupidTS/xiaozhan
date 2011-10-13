Dim $MAC = "", $strComputer = "localhost"
$objWMIService = ObjGet("winmgmts:\\" & $strComputer & "\root\cimv2")
$colNicConfigs = $objWMIService.ExecQuery("SELECT * FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled = True")
If IsObj($colNicConfigs) Then
        For $objItem In $colNicConfigs
                $objNic = $objWMIService.Get("Win32_NetworkAdapter.DeviceID=" & $objItem.Index)
                $MAC = $MAC & $objNic.MACAddress & @CRLF
        Next
        $MAC = StringReplace($MAC, ':', '-') 
Else
        SetError(1)
EndIf
MsgBox(0, "MACµÿ÷∑£∫", $MAC)