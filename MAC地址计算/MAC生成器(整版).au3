; 设定变量一定要先定义再使用
;Ҫ��UTF-8���ܿ���ע��
AutoItSetOption( "MustDeclareVars", 1 )



#cs
@brief Int32 Value Handle Extension for AutoIt3

A collection of functions for extension compute of Int32.

@author HongShe Liang <starofrainnight@gmail.com>, QuanFu Zhang <zhqf2013@163.com>
#ce

#cs
把有符号32位数修正为无符号32位数(依赖于AutoIt�?4位数存储)
#ce
Func _Int32ToUint32( $Value )
	if $Value < 0 Then
		; 如果$Result 小于0 (即数值符号位�?情况�? �?2位加1
		return Int( $Value + 4294967296 )
	Else
		Return Int( $Value )
	EndIf
EndFunc


#cs
@brief _Int64 Value Handle for AutoIt3

A collection of functions for compute of _Int64.

@author HongShe Liang <starofrainnight@gmail.com>, QuanFu Zhang <zhqf2013@163.com>
#ce

Func _Int64BitShift( $Value, $ShiftBits )
	Local $i

	if $ShiftBits >= 0 Then
		; 因为左移值作�?$i 的结束值时, 会比结束值大1
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
十六进制的BitAND, 以后BitAND支持64位运算之�? _Int64BitAND需要去�? 直接使用BitAND
#ce
Func _Int64BitAND( $Value1, $Value2 )
	Local $Temp ; 32位的临时变量

	$Temp = _Int32ToUint32( BitAND( $Value1, $Value2 ) )

	; 把高32位移到低32�?
	$Value1 = _Int64BitShift( $Value1, -32 )
	$Value2 = _Int64BitShift( $Value2, -32 )

	$Temp += _Int64BitShift( _Int32ToUint32( BitAND( $Value1, $Value2 ) ), 32 ) ; 把或运算结果左移32�?

	Return $Temp

	; 以后BitAND支持64位运算之�? 直接使用下面这一行代�? 前面所有代码都去掉
	; Return BitAND( $Value1, $Value2 )
EndFunc

Func _Int64BitOR( $Value1, $Value2 )
	Local $Temp ; 32位的临时变量

	$Temp = _Int32ToUint32( BitOR( $Value1, $Value2 ) )

	; 把高32位移到低32�?
	$Value1 = _Int64BitShift( $Value1, -32 )
	$Value2 = _Int64BitShift( $Value2, -32 )
	$Temp += _Int64BitShift( BitOR( $Value1, $Value2 ), 32 ) ; 把或运算结果左移32�?

	Return $Temp

	; 以后BitAND支持64位运算之�? 直接使用下面这一行代�? 前面所有代码都去掉
	; Return BitAND( $Value1, $Value2 )
EndFunc

#cs
转换十六进制的字符串�?4位整�?就是16个数字的十六进制�?
#ce
Func _Int64Dec( $HexString )
	Local $Result = 0
	Local $Temp;
	Local $HexStringLength = StringLen( $HexString )

	if $HexStringLength > 8 Then
		; 此处转换64�?
		$Temp = StringRight( $HexString, 8 )
		$Result = _Int32ToUint32( Dec( $Temp ) )
		$Temp = StringLeft( $HexString, $HexStringLength - 8 )

		$Result += _Int64BitShift( Dec($Temp), 32 )
	Else
		; 此处转换32�?
		$Result = _Int32ToUint32( Dec( $HexString ) )
	EndIf

	Return $Result
EndFunc


#cs
@brief MacAddress Extension for AutoIt3

A collection of functions for extension compute of MacAddress

@author HongShe Liang <starofrainnight@gmail.com>, QuanFu Zhang <zhqf2013@163.com>
#ce

Func _MacAddressIsValid( $MacAddress )
	Local $MacAddressParts ; mac 地址拆分后既结果

	$MacAddressParts = StringSplit( $MacAddress, ":", 2 )

	; 检测非法字符串, �?部分时直接返�?, 大于6部分算错
	if UBound( $MacAddressParts ) == 0 Then
		Return True
	ElseIf UBound( $MacAddressParts ) > 6 Then
		Return False
	EndIf

	For $i = ( UBound( $MacAddressParts ) - 1  ) to 0 Step -1
		; 检查每一位既合法�?
		; 如果每一位大�?个字�? 直接返回错误. 2 代表字符串长�?
		if StringLen( $MacAddressParts[$i] ) > 2 Then
			Return False
		EndIf
	Next

	Return True
EndFunc

#cs

@param $MacAddress
@param $ResultValue 结果�? 64位整数�?
@return 返回成功或失�? 成功返回True, 并设�?$ResultValue,
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
		; 把每一位的值累�?
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


Local $i
Local $MacAddressValue

; ConsoleWrite( "Int64ToMacAddress : " & _MacAddressFromInt64( _MacAddressToInt64( "ff:aa:bb:cc:dd:ee" )) & @CRLF );
$MacAddressValue = _MacAddressToInt64( "00:01:01:03:00:00" );
For $i = 0 To 0
	ConsoleWrite( "mac address : " & _MacAddressFromInt64( $MacAddressValue ) & @CRLF )

	$MacAddressValue +=  1
Next


#cs
把有符号32位数修正为无符号32位数(依赖于AutoIt的64位数存储)

Func Int32ToUint32( $Value )
	if $Value < 0 Then
		; 如果$Result 小于0 (即数值符号位置1情况下) 高32位加1
		return Int( $Value + 4294967296 )
	Else
		Return Int( $Value )
	EndIf
EndFunc



@param $MacAddress
@param $ResultValue 结果值, 64位整数值
@return 返回成功或失败, 成功返回True, 并设置 $ResultValue,
失败返回 False, $ResultValue 值未定义.


Func MacAddressToInt64( $MacAddress, ByRef $ResultValue )
	Local $MacAddressParts ; mac 地址拆分后既结果
	Local $i
	Local $ShiftBits = 0; 左移位数

	$MacAddressParts = StringSplit( $MacAddress, ":", 2 )
	$ResultValue = 0;

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

		; 把每一位的值累加
		; $ResultValue =
		; ConsoleWrite( $MacAddressParts[$i] & @CRLF )
		$ResultValue += Int64BitShift( Dec( $MacAddressParts[$i] ), $ShiftBits )

		$ShiftBits += 8
	Next

	Return True
EndFunc


十六进制的BitAND, 以后BitAND支持64位运算之后, Int64BitAND需要去掉, 直接使用BitAND

Func Int64BitAND( $Value1, $Value2 )
	Local $Temp ; 32位的临时变量

	$Temp = Int32ToUint32( BitAND( $Value1, $Value2 ) )

	; 把高32位移到低32位
	$Value1 = Int64BitShift( $Value1, -32 )
	$Value2 = Int64BitShift( $Value2, -32 )

	$Temp += Int32ToUint32( Int64BitShift( BitAND( $Value1, $Value2 ), 32 ) ) ; 把或运算结果左移32位

	Return $Temp

	; 以后BitAND支持64位运算之后, 直接使用下面这一行代码, 前面所有代码都去掉
	; Return BitAND( $Value1, $Value2 )
EndFunc

Func Int64BitOR( $Value1, $Value2 )
	Local $Temp ; 32位的临时变量

	$Temp = Int32ToUint32( BitOR( $Value1, $Value2 ) )

	; 把高32位移到低32位
	$Value1 = Int64BitShift( $Value1, -32 )
	$Value2 = Int64BitShift( $Value2, -32 )
	$Temp += Int64BitShift( BitOR( $Value1, $Value2 ), 32 ) ; 把或运算结果左移32位

	Return $Temp

	; 以后BitAND支持64位运算之后, 直接使用下面这一行代码, 前面所有代码都去掉
	; Return BitAND( $Value1, $Value2 )
EndFunc

转换十六进制的字符串到64位整数(就是16个数字的十六进制数)

Func Int64Dec( $HexString )
	Local $Result = 0
	Local $Temp;
	Local $HexStringLength = StringLen( $HexString )

	if $HexStringLength > 8 Then
		; 此处转换64位
		$Temp = StringRight( $HexString, 8 )
		$Result = Int32ToUint32( Dec( $Temp ) )
		$Temp = StringLeft( $HexString, $HexStringLength - 8 )

		$Result += Int64BitShift( Dec($Temp), 32 )
	Else
		; 此处转换32位
		$Result = Int32ToUint32( Dec( $HexString ) )
	EndIf

	Return $Result
EndFunc

Func Int64ToMacAddress( $Value )
	Local $LowByteMask = Int64Dec( "00000000000000FF" ) ; mask 值取第一字节, 不能改的
	Local $ByteValue = 0
	Local $Result = ""


	For $i = 0 To 8
		$ByteValue = BitAND( $Value, $LowByteMask )
		ConsoleWrite( "byte : " & $ByteValue & " value : " & $Value & " mask : " & $LowByteMask & @CRLF )
		if $i > 0 Then
			$Result = Hex( $ByteValue, 2 ) & ":" & $Result
		Else
			$Result = Hex( $ByteValue, 2 )
		EndIf

		$Value = Int64BitShift( $Value, -8 ) ; 右移 8 字节
	Next

	Return $Result
EndFunc


Local $ResultValue

;MacAddressToInt64( "00:00:00:00:02:01" ) ; 01 为1部分,亦为1位
;MacAddressToInt64( "ae:cf:88:7e:00:00", $ResultValue )
;MacAddressToInt64( "ae:cf:88:7e:02:01", $ResultValue )
;
;ConsoleWrite( "final result value : " & Int64Dec( "7fFFFFFF7fFFFFFF" ) &  @CRLF );
#ce

;ConsoleWrite( "final result value : " & Int64ToMacAddress( $ResultValue )&  @CRLF );
;ConsoleWrite( "int64dec : " & Int64Dec( "fffaaaafde223425" ) & @CRLF );
;ConsoleWrite( "int64dec : " & Int64Dec( "fffaaaaf00000000" ) & @CRLF );
;ConsoleWrite( "int64dec : " & Int64Dec(  "f000000000223425" ) & @CRLF );
;ConsoleWrite( "dec : " & Int64BitShift( 251658240, -1 ) & @CRLF );
;ConsoleWrite( "dec : " & Int64BitShift( Dec( "0f000000" ), 1 ) &  "int64dec : " & Int64Dec( "fffaaaaff0000000" ) & @CRLF );
;ConsoleWrite( "BitAND result : " & Int64BitAND( Int64Dec( "fffaaaafde223425" ), Int64Dec( "FF000000FF00" ) ) & @CRLF )