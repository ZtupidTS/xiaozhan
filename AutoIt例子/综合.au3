#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_outfile=1.exe
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Change2CUI=y
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=cs 1 
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****

HotKeySet("!a", "ShowMessage")          ;ALT+a 注释符号（；）
HotKeySet("^!z", "ShowMessage")         ;CTRL+ALT+z

$i = 0
Do
ControlClick( "FT-200W", "", "[ID:1000]")
Sleep(8000) 
ControlClick( "FT-200W", "", "[ID:1001]")
Sleep(8000)
ControlClick( "FT-200W", "", "[ID:1001]")
Sleep(3000)
ControlClick( "FT-200W", "", "[ID:1003]")
Sleep(8000)
ControlClick( "FT-200W", "", "[ID:1003]")
Sleep(3000)
ControlClick( "FT-200W", "", "[ID:1000]")
Sleep(3000)
$i = $i + 1
Until $i = 960
Func ShowMessage()   ;Func的意思创建自定义函数
    Dim $i=MsgBox(1,"退出脚本","确定退出脚本吗")
    if  $i<>2  Then
    Exit 0
    EndIf
EndFunc
