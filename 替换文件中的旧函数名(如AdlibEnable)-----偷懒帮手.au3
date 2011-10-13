Local $txt, $i
For $i = 1 To $CmdLine[0]
        $txt &= Replace($CmdLine[$i])
Next
If $txt <> '' Then MsgBox(64, '替换旧函数名-偷懒成功~！', $txt)

Func Replace($File)
        $File = FileGetLongName($File)
        Local $Str = FileRead($File), $txt, $extended, $ii
        If $Str = '' Then Return SetError(1, 0, '')
        $key = IniReadSection(@ScriptDir & '\Replace.ini', '替换')
        If @error Then Return SetError(2, 0, '')
        For $ii = 1 To $key[0][0]
                $Replace = StringRegExpReplace($Str, $key[$ii][0], $key[$ii][1])
                If @extended >= 1 Then
                        $txt &= '文件 "' & $File & '" 被成功替换 "' & $key[$ii][0] & '" 为 "' & $key[$ii][1] & '"  ' & @CRLF
                        $Str = $Replace
                        $extended += @extended
                EndIf
        Next
        If $extended >= 1 Then
                FileCopy($File, $File & '.bak')
                $FO = FileOpen($File, 2)
                FileWrite($FO, $Replace)
                FileClose($FO)
                $txt &= '-----------------------------------------------------' & @CRLF
                Return $txt
        Else
                Return SetError(3, 0, '')
        EndIf
	EndFunc   ;==>Replace
#cs
Replace.ini 
[替换]
AdlibEnable=AdlibRegister
AdlibDisable=AdlibUnRegister
#ce