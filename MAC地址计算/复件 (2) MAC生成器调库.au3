; 设定变量一定要先定义再使用
AutoItSetOption( "MustDeclareVars", 1 )

#include "MacAddress.au3"
#include <Excel.au3>
Local $i
Local $MacAddressValue

; ConsoleWrite( "Int64ToMacAddress : " & _MacAddressFromInt64( _MacAddressToInt64( "ff:aa:bb:cc:dd:ee" )) & @CRLF );
$MacAddressValue = _MacAddressToInt64( "00:01:01:03:00:00" );
Local $oExcel = _ExcelBookNew()
Local $y=1 
For $i = 0 To 94
	
     If $y<=47 Then
		 ;_ExcelWriteCell($oExcel, $y, $y, 1)
		_ExcelWriteCell($oExcel, _MacAddressFromInt64( $MacAddressValue ), $y, 2) ;д�뵥Ԫ��
		;_ExcelWriteCell($oExcel, _MacAddressFromInt64( $MacAddressValue ), $y, 2)
		$y=$y+1
	EndIf
	
	$MacAddressValue +=  1
	

Next

For $i = 48 To 94
	
     If $y<=47 Then
		 ;_ExcelWriteCell($oExcel, $y, $y, 1)
		_ExcelWriteCell($oExcel, _MacAddressFromInt64( $MacAddressValue ), $y, 3) ;д�뵥Ԫ��
		;_ExcelWriteCell($oExcel, _MacAddressFromInt64( $MacAddressValue ), $y, 2)
		$y=$y+1
	EndIf
	
	$MacAddressValue +=  1
	

Next


_ExcelBookSaveAs($oExcel, @scriptdir & "\Temp.xls");, "xls", 0, 1) ; ���䱣�浽��ʱ�ļ���; ����б�Ҫ�����Ѵ����ļ�
;_ExcelBookClose($oExcel) ; �ر��˳�
