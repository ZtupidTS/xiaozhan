#include-once

#cs
@brief Int32 Value Handle Extension for AutoIt3

A collection of functions for extension compute of Int32.

@author HongShe Liang <starofrainnight@gmail.com>, QuanFu Zhang <zhqf2013@163.com>
#ce

#cs
把有符号32位数修正为无符号32位数(依赖于AutoIt的64位数存储)
#ce
Func _Int32ToUint32( $Value )
	if $Value < 0 Then
		; 如果$Result 小于0 (即数值符号位置1情况下) 高32位加1
		return Int( $Value + 4294967296 )
	Else
		Return Int( $Value )
	EndIf
EndFunc

