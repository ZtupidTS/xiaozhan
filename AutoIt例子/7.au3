#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=E:\AutoIt\Aut2Exe\Icons\strawberry.ico
#AutoIt3Wrapper_outfile=1.exe
#AutoIt3Wrapper_Run_Obfuscator=y
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****

HotKeySet("!a", "ShowMessage")          ;ALT+a 注释符号（；）
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z

While 1
    MouseClick("left", 932, 532,2,100)
    Sleep(3000)
    MouseClick("left", 921, 546,2,100)
    Sleep(3000)
    MouseClick("left", 921, 563,2,100)
    Sleep(3000)
    MouseClick("left", 934, 580,2,100)
    Sleep(3000)
 WEnd

Func ShowMessage()   ;Func的意思创建自定义函数
    Dim $i=MsgBox(1,"退出脚本","确定退出脚本吗")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc
