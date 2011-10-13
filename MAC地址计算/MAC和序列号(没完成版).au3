; 璁惧畾鍙橀噺涓�瀹氳鍏堝畾涔夊啀浣跨敤
AutoItSetOption( "MustDeclareVars", 1 )

#include "MacAddress.au3"
#include <Excel.au3>
Local $i
Local $MacAddressValue

; ConsoleWrite( "Int64ToMacAddress : " & _MacAddressFromInt64( _MacAddressToInt64( "ff:aa:bb:cc:dd:ee" )) & @CRLF );
$MacAddressValue = _MacAddressToInt64( "00:01:01:03:00:00" );
Local $oExcel = _ExcelBookNew() ;新建工作簿, 并使之可见
Local $page = 0
Local $ColumnPerPage = 3;一页多少列
Local $RowPerPage = 47 ; 一页多少行
Local $x 
Local $y

For $i = 0 To 200
	;_ExcelWriteCell($oExcel, _MacAddressFromInt64( $MacAddressValue ), Mod($i,48) + 1, 1) ;写入单元格
	$y = ( ( Mod( Int( Floor($i/$RowPerPage) ), $ColumnPerPage ) +1  ) - 1 )  * 3 + 1
	$x = Mod($i,$RowPerPage) + $page * $RowPerPage + 1  ;  ( 2 * $y )跳到第3列
	
	_ExcelWriteCell( $oExcel, _MacAddressFromInt64( $MacAddressValue ), $x, $y ) ;写入单元格
    _ExcelWriteCell( $oExcel, _MacAddressFromInt64( $MacAddressValue ), $x, $y + 2 ) ;写入单元格
	
	If Mod( $i, $RowPerPage * $ColumnPerPage) == ($RowPerPage* $ColumnPerPage - 1) Then                          ;x
		$page += 1
	EndIf
	$MacAddressValue +=  1
Next


_ExcelBookSaveAs($oExcel, @ScriptDir & "\Temp.xls", "xls", 0, 1) ; 将其保存到临时文件夹; 如果有必要覆盖已存在文件
;_ExcelBookClose($oExcel) ; 关闭退出
