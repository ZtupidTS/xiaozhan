MsgBox(0,"连接状态",WLZK_ljzt(),2)
MsgBox(0,"上网状态",WLZK_swzt(),2)

Func WLZK_ljzt()
        #region configure VB-Code ($VBCode)
                        Local $VBCode ='Public Function Rljzt()' & @CRLF
                        $VBCode &= 'Dim ljzt'& @CRLF
                        $VBCode &= ' strComputer = "."'& @CRLF
                        $VBCode &= ' Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")'& @CRLF
                        $VBCode &= ' Set IPConfigSet = objWMIService.ExecQuery("Select   *   from   Win32_NetworkAdapter   where   NetConnectionStatus=2")'& @CRLF
                        $VBCode &= ' If IPConfigSet.Count = 0 Then'& @CRLF
                        $VBCode &= '    ljzt = "电缆断开"'& @CRLF
                        $VBCode &= ' End If'& @CRLF
                        $VBCode &= ' If IPConfigSet.Count = 1 Then'& @CRLF
                        $VBCode &= '    ljzt = "电缆接通"'& @CRLF
                        $VBCode &= ' End If'& @CRLF
                        $VBCode &= 'Rljzt=ljzt'& @CRLF
                        $VBCode &= 'End Function' & @CRLF
                #endregion
        Local $vbscript = ObjCreate('ScriptControl')
        $vbscript.language='vbscript'
        $vbscript.addcode($VBCode)        
        Return $vbscript.run('Rljzt')
EndFunc

;获取网络状况并更新配置文件内的上网状态
Func WLZK_swzt()
        #region configure VB-Code ($VBCode)
                        Local $VBCode ='Public Function Rswzt()' & @CRLF
                        $VBCode &= 'Dim ljzt'& @CRLF
                        $VBCode &= ' Dim swzt'& @CRLF    
                        $VBCode &= ' strComputer = "."'& @CRLF
                        $VBCode &= ' Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")'& @CRLF
                        $VBCode &= ' Set IPConfigSet = objWMIService.ExecQuery("Select   *   from   Win32_NetworkAdapterConfiguration   where   ipenabled=true")'& @CRLF
                        $VBCode &= ' If IPConfigSet.Count = 1 Then'& @CRLF
                        $VBCode &= '    swzt = "未上网"'& @CRLF
                        $VBCode &= ' End If'& @CRLF
                        $VBCode &= ' If IPConfigSet.Count = 2 Then'& @CRLF
                        $VBCode &= '     swzt = "已上网"'& @CRLF
                        $VBCode &= ' End If'& @CRLF
                        $VBCode &= 'Rswzt=swzt'& @CRLF
                        $VBCode &= 'End Function' & @CRLF
                #endregion
        Local $vbscript = ObjCreate('ScriptControl')
        $vbscript.language='vbscript'
        $vbscript.addcode($VBCode)
        Return $vbscript.run('Rswzt')
EndFunc