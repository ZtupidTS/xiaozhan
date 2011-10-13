#include "md5.au3"
;=========================================================================================
;=========================================================================================
Func Hex2Bin($HexStr1)
dim $q1
Select
Case $HexStr1="0"
$q1 = "0000"
Case $HexStr1="1"
$q1 = "0001"
Case $HexStr1="2"
$q1 = "0010"
Case $HexStr1="3"
$q1 = "0011"
Case $HexStr1="4"
$q1 = "0100"
Case $HexStr1="5"
$q1 = "0101"
Case $HexStr1="6"
$q1 = "0110"
Case $HexStr1="7"
$q1 = "0111"
Case $HexStr1="8"
$q1 = "1000"
Case $HexStr1="9"
$q1 = "1001"
Case $HexStr1="A"
$q1 = "1010"
Case $HexStr1="B"
$q1 = "1011"
Case $HexStr1="C"
$q1 = "1100"
Case $HexStr1="D"
$q1 = "1101"
Case $HexStr1="E"
$q1 = "1110"
Case $HexStr1="F"
$q1 = "1111"
EndSelect
$Hex2Bin=$q1
Return $Hex2Bin
EndFunc

Func Hex2Bin1($HexStr2)
$q1 = Hex2Bin(stringMid($HexStr2, 1, 1))
$q2 = Hex2Bin(stringMid($HexStr2, 2, 1))
$q3 = Hex2Bin(stringMid($HexStr2, 3, 1))
$q4 = Hex2Bin(stringMid($HexStr2, 4, 1))
$q5 = Hex2Bin(stringMid($HexStr2, 5, 1))
$q6 = Hex2Bin(stringMid($HexStr2, 6, 1))
$q7 = Hex2Bin(stringMid($HexStr2, 7, 1))
$q8 = Hex2Bin(stringMid($HexStr2, 8, 1))
$q9 = Hex2Bin(stringMid($HexStr2, 9, 1))
$q10 = Hex2Bin(stringMid($HexStr2, 10, 1))
$q11 = Hex2Bin(stringMid($HexStr2, 11, 1))
$q12 = Hex2Bin(stringMid($HexStr2, 12, 1))
$Hex2Bin1 = $q1&$q2&$q3&$q4&$q5&$q6&$q7&$q8&$q9&$q10&$q11&$q12
Return $Hex2Bin1
EndFunc

Func Bin324($BinCode1)
$q1 = stringMid($BinCode1, 1, 6)
$q2 = stringMid($BinCode1, 7, 6)
$q3 = stringMid($BinCode1, 13, 6)
$q4 = stringMid($BinCode1, 19, 6)
$q5 = stringMid($BinCode1, 25, 6)
$q6 = stringMid($BinCode1, 31, 6)
$q7 = stringMid($BinCode1, 37, 6)
$q8 = stringMid($BinCode1, 43, 6)
$Bin324 = "00"&$q1&"00"&$q2&"00"&$q3&"00"&$q4&"00"&$q5&"00"&$q6&"00"&$q7&"00"&$q8
Return $Bin324
EndFunc

Func Bin2Hex($BinCode2)
	Dim $q1
Select 
Case $BinCode2="0000"
$q1 = "0"
Case $BinCode2="0001"
$q1 = "1"
Case $BinCode2="0010"
$q1 = "2"
Case $BinCode2="0011"
$q1 = "3"
Case $BinCode2="0100"
$q1 = "4"
Case $BinCode2="0101"
$q1 = "5"
Case $BinCode2="0110"
$q1 = "6"
Case $BinCode2="0111"
$q1 = "7"
Case $BinCode2="1000"
$q1 = "8"
Case $BinCode2="1001"
$q1 = "9"
Case $BinCode2="1010"
$q1 = "A"
Case $BinCode2="1011"
$q1 = "B"
Case $BinCode2="1100"
$q1 = "C"
Case $BinCode2="1101"
$q1 = "D"
Case $BinCode2="1110"
$q1 = "E"
Case $BinCode2="1111"
$q1 = "F"
EndSelect
$Bin2Hex = $q1
Return $Bin2Hex
EndFunc

Func Bin2Hex2($BinCode)
$q1 = Bin2Hex(stringMid($BinCode, 1, 4))
$q2 = Bin2Hex(stringMid($BinCode, 5, 4))
$q3 = Bin2Hex(stringMid($BinCode, 9, 4))
$q4 = Bin2Hex(stringMid($BinCode, 13, 4))
$Bin2Hex2 =$q1&$q2&$q3&$q4
Return $Bin2Hex2
EndFunc

Func Bin2Hex3($BinCode3)
$q1 = Bin2Hex2(stringMid($BinCode3, 1, 16))
$q2 = Bin2Hex2(stringMid($BinCode3, 17, 16))
$q3 = Bin2Hex2(stringMid($BinCode3, 33, 16))
$q4 = Bin2Hex2(stringMid($BinCode3, 49, 16))
$Bin2Hex3 =$q1&$q2&$q3&$q4
Return $Bin2Hex3
EndFunc

Func HexBase64($HexString)
$HexBase64 = HexBase64_2(Bin2Hex3(Bin324(Hex2Bin1($HexString))))
Return $HexBase64
EndFunc

Func HexBase64_1($HexString)
	Dim $q1
Select
Case $HexString="00"
$q1 = "A"
Case $HexString="01"
$q1 = "B"
Case $HexString="02"
$q1 = "C"
Case $HexString="03"
$q1 = "D"
Case $HexString="04"
$q1 ="E"
Case $HexString="05"
$q1 = "F"
Case $HexString="06"
$q1 = "G"
Case $HexString="07"
$q1 = "H"
Case $HexString="08"
$q1 = "I"
Case $HexString="09"
$q1 = "J"
Case $HexString="0A"
$q1 = "K"
Case $HexString="0B"
$q1 = "L"
Case $HexString="0C"
$q1 = "M"
Case $HexString="0D"
$q1 = "N"
Case $HexString="0E"
$q1 = "O"
Case $HexString="0F"
$q1 = "P"
Case $HexString="10"
$q1 = "Q"
Case $HexString="11"
$q1 = "R"
Case $HexString="12"
$q1 = "S"
Case $HexString="13"
$q1 = "T"
Case $HexString="14"
$q1 = "U"
Case $HexString="15"
$q1 = "V"
Case $HexString="16"
$q1 = "W"
Case $HexString="17"
$q1 = "X"
Case $HexString="18"
$q1 = "Y"
Case $HexString="19"
$q1 = "Z"
Case $HexString="1A"
$q1 = "a"
Case $HexString="1B"
$q1 = "b"
Case $HexString="1C"
$q1 = "c"
Case $HexString="1D"
$q1 = "d"
Case $HexString="1E"
$q1 = "e"
Case $HexString="1F"
$q1 = "f"
Case $HexString="20"
$q1 = "g"
Case $HexString="21"
$q1 = "h"
Case $HexString="22"
$q1 = "i"
Case $HexString="23"
$q1 = "j"
Case $HexString="24"
$q1 = "k"
Case $HexString="25"
$q1 = "l"
Case $HexString="26"
$q1 = "m"
Case $HexString="27"
$q1 = "n"
Case $HexString="28"
$q1 = "o"
Case $HexString="29"
$q1 = "p"
Case $HexString="2A"
$q1 = "q"
Case $HexString="2B"
$q1 = "r"
Case $HexString="2C"
$q1 = "s"
Case $HexString="2D"
$q1 = "t"
Case $HexString="2E"
$q1 = "u"
Case $HexString="2F"
$q1 = "v"
Case $HexString="30"
$q1 = "w"
Case $HexString="31"
$q1 = "x"
Case $HexString="32"
$q1 = "y"
Case $HexString="33"
$q1 = "z"
Case $HexString="34"
$q1 = "0"
Case $HexString="35"
$q1 = "1"
Case $HexString="36"
$q1 = "2"
Case $HexString="37"
$q1 = "3"
Case $HexString="38"
$q1 = "4"
Case $HexString="39"
$q1 = "5"
Case $HexString="3A"
$q1 = "6"
Case $HexString="3B"
$q1 = "7"
Case $HexString="3C"
$q1 = "8"
Case $HexString="3D"
$q1 = "9"
Case $HexString="3E"
$q1 = "+"
Case $HexString="3F"
$q1 = "/"
EndSelect
$HexBase64_1 = $q1
Return $HexBase64_1
EndFunc

Func HexBase64_2($HexString)
$q1 = HexBase64_1(stringMid($HexString, 1, 2))
$q2 = HexBase64_1(stringMid($HexString, 3, 2))
$q3 = HexBase64_1(stringMid($HexString, 5, 2))
$q4 = HexBase64_1(stringMid($HexString, 7, 2))
$q5 = HexBase64_1(stringMid($HexString, 9, 2))
$q6 = HexBase64_1(stringMid($HexString, 11, 2))
$q7 = HexBase64_1(stringMid($HexString, 13, 2))
$q8 = HexBase64_1(stringMid($HexString, 15, 2))
$HexBase64_2 =$q1&$q2&$q3&$q4&$q5&$q6&$q7&$q8
Return $HexBase64_2
EndFunc

Func Hex2Base64($HexCode)
	Dim $q1
For $i = 0 To stringLen($HexCode) Step 12
$q1 = $q1&HexBase64(stringMid($HexCode, $i+1, 12))
Next
$Hex2Base64 = $q1
Return $Hex2Base64
EndFunc



Func Str2QQPwdHash($Str1)
$Str2QQPwdHash = Hex2Base64(_StringMD5($Str1)) & "=="
Return $Str2QQPwdHash
EndFunc


