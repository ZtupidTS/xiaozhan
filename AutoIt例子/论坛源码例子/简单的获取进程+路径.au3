$objWMIService = ObjGet("winmgmts:\\.\root\CIMV2:win32_process")
$colItems = $objWMIService.instances_
For $objItem In $colItems
$Pid =  "Pid: " & $objItem.ProcessId         
$Name = "Name: " & $objItem.Name 
$path = "Path: " & $objItem.executablepath
        MsgBox(0,'',$Pid&@LF _ 
        &$Name&@LF _ 
        &$path)
Next