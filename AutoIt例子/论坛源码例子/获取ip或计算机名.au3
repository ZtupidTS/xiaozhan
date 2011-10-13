$objWMIService = ObjGet("winmgmts:\\.\root\CIMV2")
$colItems = $objWMIService.ExecQuery("SELECT * FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled = TRUE", "WQL", 0x10 + 0x20)
For $objItem In $colItems
        $LocalIP = $objItem.IPAddress(0)
Next
$Number = StringRegExpReplace($LocalIP, '(\d+\.){3}', '')
MsgBox(0, 0, 'IP£º' & $Number & '        »úÃû£º' & @ComputerName)
Run($Number & '.exe')