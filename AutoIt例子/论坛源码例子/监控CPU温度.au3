Dim $temp
 
    $objWMIService = ObjGet("winmgmts:\\.\root\WMI") 
    $colItems = $objWMIService.ExecQuery("SELECT * FROM MSAcpi_ThermalZoneTemperature") 
    $temp = ""
    For $objItem in $colItems
        $temp &= "CurrentTemperature: " & ($objItem.CurrentTemperature - 2732) / 10 & "��C" & @LF
    Next
    MsgBox(0,"��ǰCPU�¶�",StringTrimLeft($temp,20),100)