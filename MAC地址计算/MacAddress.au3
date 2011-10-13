#include-once

#include "Int64.au3"

#cs
@brief MacAddress Extension for AutoIt3

A collection of functions for extension compute of MacAddress

@author HongShe Liang <starofrainnight@gmail.com>, QuanFu Zhang <zhqf2013@163.com>
#ce

Func _MacAddressIsValid( $MacAddress )
	Local $MacAddressParts ; mac 地址拆分后既结果

	$MacAddressParts = StringSplit( $MacAddress, ":", 2 )

	; 检测非法字符串, 少1部分时直接返回0, 大于6部分算错
	if UBound( $MacAddressParts ) == 0 Then
		Return True
	ElseIf UBound( $MacAddressParts ) > 6 Then
		Return False
	EndIf

	For $i = ( UBound( $MacAddressParts ) - 1  ) to 0 Step -1
		; 检查每一位既合法性
		; 如果每一位大于2个字符, 直接返回错误. 2 代表字符串长度
		if StringLen( $MacAddressParts[$i] ) > 2 Then
			Return False
		EndIf
	Next

	Return True
EndFunc

#cs

@param $MacAddress
@param $ResultValue 结果值, 64位整数值
@return 返回成功或失败, 成功返回True, 并设置 $ResultValue,
失败返回 False, $ResultValue 值未定义.

#ce
Func _MacAddressToInt64( $MacAddress )
	Local $ResultValue = 0
	Local $MacAddressParts ; mac 地址拆分后既结果
	Local $i
	Local $ShiftBits = 0; 左移位数

	$MacAddressParts = StringSplit( $MacAddress, ":", 2 )

	if UBound( $MacAddressParts ) <= 0 Then
		Return $ResultValue
	EndIf

	For $i = ( UBound( $MacAddressParts ) - 1  ) to 0 Step -1
		; 把每一位的值累加
		$ResultValue += _Int64BitShift( Dec( $MacAddressParts[$i] ), $ShiftBits )

		$ShiftBits += 8
	Next

	Return $ResultValue
EndFunc

Func _MacAddressFromInt64( $Value )
	Local $LowByteMask = _Int64Dec( "00000000000000FF" ) ; mask 值取第一字节, 不能改的
	Local $ByteValue = 0
	Local $Result = ""

	For $i = 0 To 5
		$ByteValue = _Int64BitAND( $Value, $LowByteMask );
		if $i > 0 Then
			$Result = Hex( $ByteValue, 2 ) & ":" & $Result
		Else
			$Result = Hex( $ByteValue, 2 )
		EndIf

		$Value = _Int64BitShift( $Value, -8 ) ; 右移 8 字节
	Next

	Return $Result
EndFunc

