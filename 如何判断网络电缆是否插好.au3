MsgBox(0,"����״̬",WLZK_ljzt(),2)
MsgBox(0,"����״̬",WLZK_swzt(),2)

Func WLZK_ljzt()
        #region configure VB-Code ($VBCode)
                        Local $VBCode ='Public Function Rljzt()' & @CRLF
                        $VBCode &= 'Dim ljzt'& @CRLF
                        $VBCode &= ' strComputer = "."'& @CRLF
                        $VBCode &= ' Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")'& @CRLF
                        $VBCode &= ' Set IPConfigSet = objWMIService.ExecQuery("Select   *   from   Win32_NetworkAdapter   where   NetConnectionStatus=2")'& @CRLF
                        $VBCode &= ' If IPConfigSet.Count = 0 Then'& @CRLF
                        $VBCode &= '    ljzt = "���¶Ͽ�"'& @CRLF
                        $VBCode &= ' End If'& @CRLF
                        $VBCode &= ' If IPConfigSet.Count = 1 Then'& @CRLF
                        $VBCode &= '    ljzt = "���½�ͨ"'& @CRLF
                        $VBCode &= ' End If'& @CRLF
                        $VBCode &= 'Rljzt=ljzt'& @CRLF
                        $VBCode &= 'End Function' & @CRLF
                #endregion
        Local $vbscript = ObjCreate('ScriptControl')
        $vbscript.language='vbscript'
        $vbscript.addcode($VBCode)        
        Return $vbscript.run('Rljzt')
EndFunc

;��ȡ����״�������������ļ��ڵ�����״̬
Func WLZK_swzt()
        #region configure VB-Code ($VBCode)
                        Local $VBCode ='Public Function Rswzt()' & @CRLF
                        $VBCode &= 'Dim ljzt'& @CRLF
                        $VBCode &= ' Dim swzt'& @CRLF    
                        $VBCode &= ' strComputer = "."'& @CRLF
                        $VBCode &= ' Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")'& @CRLF
                        $VBCode &= ' Set IPConfigSet = objWMIService.ExecQuery("Select   *   from   Win32_NetworkAdapterConfiguration   where   ipenabled=true")'& @CRLF
                        $VBCode &= ' If IPConfigSet.Count = 1 Then'& @CRLF
                        $VBCode &= '    swzt = "δ����"'& @CRLF
                        $VBCode &= ' End If'& @CRLF
                        $VBCode &= ' If IPConfigSet.Count = 2 Then'& @CRLF
                        $VBCode &= '     swzt = "������"'& @CRLF
                        $VBCode &= ' End If'& @CRLF
                        $VBCode &= 'Rswzt=swzt'& @CRLF
                        $VBCode &= 'End Function' & @CRLF
                #endregion
        Local $vbscript = ObjCreate('ScriptControl')
        $vbscript.language='vbscript'
        $vbscript.addcode($VBCode)
        Return $vbscript.run('Rswzt')
EndFunc