#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_outfile_type=a3x
#AutoIt3Wrapper_outfile=1.a3x
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****

HotKeySet("!a", "ShowMessage")          ;ALT+a 注释符号（；）
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z

While 1
    MouseClick("left", 934, 533,2,100)
    Sleep(3000)
 WEnd

Func ShowMessage()   ;Func的意思创建自定义函数
    Dim $i=MsgBox(1,"退出脚本","确定退出脚本吗")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc

