#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=E:\AutoIt\Aut2Exe\Icons\strawberry.ico
#AutoIt3Wrapper_outfile=1.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****

HotKeySet("!a", "ShowMessage")          ;ALT+a 注释符号（；）
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z

While 1
    MouseClick("left", 1203, 790,2,100)
    Sleep(8000)
    MouseClick("left", 1190, 806,2,100)
    Sleep(8000)
    MouseClick("left", 1175, 822,2,100)
    Sleep(8000)
    MouseClick("left", 1186, 836,2,100)
    Sleep(8000)
    MouseClick("left", 1162, 853,2,100)
    Sleep(8000)
    MouseClick("left", 1174, 869,2,100)
    Sleep(8000)
    MouseClick("left", 1162, 883,2,100)
    Sleep(8000)
    MouseClick("left", 1164, 901,2,100)
    Sleep(8000)
    MouseClick("left", 1190, 918,2,100)
    Sleep(4000)
 WEnd

Func ShowMessage()   ;Func的意思创建自定义函数
    Dim $i=MsgBox(1,"退出脚本","确定退出脚本吗")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc
