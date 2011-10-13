Dim $temp
 
    $objWMIService = ObjGet("winmgmts:\\.\root\WMI") 
    $colItems = $objWMIService.ExecQuery("SELECT * FROM MSAcpi_ThermalZoneTemperature") 
    $temp = ""
    For $objItem in $colItems
        $temp &= "CurrentTemperature: " & ($objItem.CurrentTemperature - 2732) / 10 & "¡ãC" & @LF
    Next
    MsgBox(0,"µ±Ç°CPUÎÂ¶È",StringTrimLeft($temp,20),100)