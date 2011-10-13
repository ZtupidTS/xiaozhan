Dim $objwmiservice = ObjGet('winmgmts:\\localhost\root\CIMV2'), $netn
$colitems = $objwmiservice.ExecQuery('SELECT * FROM Win32_NetworkAdapter', 'WQL', 0x10 + 0x20)
If IsObj($colitems) Then
        For $objitem In $colitems
                If $objitem.netconnectionid <> '' Then
                        $netn = $objitem.netconnectionid
                        MsgBox(0, '本地连接名：', $netn)
                EndIf
        Next
EndIf