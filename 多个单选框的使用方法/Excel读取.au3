#Include <Excel.au3>

$mac = IniRead (@scriptdir & "\11.ini", "mac","mac","")
$xlBook = _ExcelBookOpen(@scriptdir & "\MAC.xls")
$str= _ExcelReadCell($xlBook ,$mac,4)
$str1= _ExcelReadCell($xlBook ,$mac,10)


MsgBox (0,"",$str)
MsgBox (0,"",$str1)





