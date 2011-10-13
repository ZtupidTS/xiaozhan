; 设定变量一定要先定义再使用
AutoItSetOption( "MustDeclareVars", 1 )

#include "MacAddress.au3"
#include <Excel.au3>
Local $i
Local $MacAddressValue

; ConsoleWrite( "Int64ToMacAddress : " & _MacAddressFromInt64( _MacAddressToInt64( "ff:aa:bb:cc:dd:ee" )) & @CRLF );
$MacAddressValue = _MacAddressToInt64( "00:01:01:03:00:00" );
Local $oExcel = _ExcelBookNew() ;�½�������, ��ʹ֮�ɼ�
Local $page = 0
Local $ColumnPerPage = 3;һҳ������
Local $RowPerPage = 47 ; һҳ������
Local $x 
Local $y

For $i = 0 To 200
	;_ExcelWriteCell($oExcel, _MacAddressFromInt64( $MacAddressValue ), Mod($i,48) + 1, 1) ;д�뵥Ԫ��
	$y = ( ( Mod( Int( Floor($i/$RowPerPage) ), $ColumnPerPage ) +1  ) - 1 )  * 3 + 1
	$x = Mod($i,$RowPerPage) + $page * $RowPerPage + 1  ;  ( 2 * $y )������3��
	
	_ExcelWriteCell( $oExcel, _MacAddressFromInt64( $MacAddressValue ), $x, $y ) ;д�뵥Ԫ��
    _ExcelWriteCell( $oExcel, _MacAddressFromInt64( $MacAddressValue ), $x, $y + 2 ) ;д�뵥Ԫ��
	
	If Mod( $i, $RowPerPage * $ColumnPerPage) == ($RowPerPage* $ColumnPerPage - 1) Then                          ;x
		$page += 1
	EndIf
	$MacAddressValue +=  1
Next


_ExcelBookSaveAs($oExcel, @ScriptDir & "\Temp.xls", "xls", 0, 1) ; ���䱣�浽��ʱ�ļ���; ����б�Ҫ�����Ѵ����ļ�
;_ExcelBookClose($oExcel) ; �ر��˳�
