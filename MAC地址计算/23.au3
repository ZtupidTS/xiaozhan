#include <Excel.au3>

Local $oExcel = _ExcelBookNew() ;�½�������, ��ʹ֮�ɼ�

;��������
Local $aArray[5][2] = [["LocoDarwin", 1],["Jon", 2],["big_daddy", 3],["DaleHolm", 4],["GaryFrost", 5]] ;0������
_ExcelWriteSheetFromArray($oExcel, $aArray, 1, 1, 0, 0) ;0���������

MsgBox(0, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; ���䱣������ʱĿ¼; ��Ҫʱ�����Ѵ��ڵ��ļ�
;_ExcelBookClose($oExcel) ; �ر��˳�