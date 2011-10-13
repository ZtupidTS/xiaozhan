#include <Date.au3>

$iDateCalc = _DateDiff( 'D', "2003/05/02","2010/02/18")
MsgBox( 4096, "", "计算经过的天数: " & $iDateCalc )