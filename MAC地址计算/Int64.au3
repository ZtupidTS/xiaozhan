#include-once

#include "Int32.au3"

#cs
@brief _Int64 Value Handle for AutoIt3

A collection of functions for compute of _Int64.

@author HongShe Liang <starofrainnight@gmail.com>, QuanFu Zhang <zhqf2013@163.com>
#ce

Func _Int64BitShift( $Value, $ShiftBits )
	Local $i

	if $ShiftBits >= 0 Then
		; 因为左移值作为 $i 的结束值时, 会比结束值大1
		For $i = 0 To $ShiftBits - 1
			$Value *= 2
		Next
	Else
		$ShiftBits = -$ShiftBits
		For $i = 0 To $ShiftBits - 1
			$Value = Int( Floor( $Value / 2 ) )
		Next
	EndIf

	Return $Value
EndFunc

#cs
十六进制的BitAND, 以后BitAND支持64位运算之后, _Int64BitAND需要去掉, 直接使用BitAND
#ce
Func _Int64BitAND( $Value1, $Value2 )
	Local $Temp ; 32位的临时变量

	$Temp = _Int32ToUint32( BitAND( $Value1, $Value2 ) )

	; 把高32位移到低32位
	$Value1 = _Int64BitShift( $Value1, -32 )
	$Value2 = _Int64BitShift( $Value2, -32 )

	$Temp += _Int64BitShift( _Int32ToUint32( BitAND( $Value1, $Value2 ) ), 32 ) ; 把或运算结果左移32位

	Return $Temp

	; 以后BitAND支持64位运算之后, 直接使用下面这一行代码, 前面所有代码都去掉
	; Return BitAND( $Value1, $Value2 )
EndFunc

Func _Int64BitOR( $Value1, $Value2 )
	Local $Temp ; 32位的临时变量

	$Temp = _Int32ToUint32( BitOR( $Value1, $Value2 ) )

	; 把高32位移到低32位
	$Value1 = _Int64BitShift( $Value1, -32 )
	$Value2 = _Int64BitShift( $Value2, -32 )
	$Temp += _Int64BitShift( BitOR( $Value1, $Value2 ), 32 ) ; 把或运算结果左移32位

	Return $Temp

	; 以后BitAND支持64位运算之后, 直接使用下面这一行代码, 前面所有代码都去掉
	; Return BitAND( $Value1, $Value2 )
EndFunc

#cs
转换十六进制的字符串到64位整数(就是16个数字的十六进制数)
#ce
Func _Int64Dec( $HexString )
	Local $Result = 0
	Local $Temp;
	Local $HexStringLength = StringLen( $HexString )

	if $HexStringLength > 8 Then
		; 此处转换64位
		$Temp = StringRight( $HexString, 8 )
		$Result = _Int32ToUint32( Dec( $Temp ) )
		$Temp = StringLeft( $HexString, $HexStringLength - 8 )

		$Result += _Int64BitShift( Dec($Temp), 32 )
	Else
		; 此处转换32位
		$Result = _Int32ToUint32( Dec( $HexString ) )
	EndIf

	Return $Result
EndFunc

