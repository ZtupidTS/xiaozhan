; 设定变量一定要先定义再使用
AutoItSetOption( "MustDeclareVars", 1 )

#include "MacAddress.au3"
#include <Excel.au3>
Local $i
Local $MacAddressValue

; ConsoleWrite( "Int64ToMacAddress : " & _MacAddressFromInt64( _MacAddressToInt64( "ff:aa:bb:cc:dd:ee" )) & @CRLF );
$MacAddressValue = _MacAddressToInt64( "00:01:01:03:00:00" );
For $i = 0 To 1

	ConsoleWrite( "mac address : " & _MacAddressFromInt64( $MacAddressValue ) & @CRLF )

	$MacAddressValue +=  1
Next


