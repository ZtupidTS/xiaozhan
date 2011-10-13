

Local $title=0
Local $title1=3001000
Local $title2=120816
Local $title3="00"
Local $quan=$title & $title1 & $title2 &$title3
;***************************************************************************************
For $title3 = "00" To 800
	
If	$title3="00" Then ;如果$title3="00"就输出$title3="01"如果不等于就+1
    $title3="01"
ElseIf $title3="01" Then 
    $title3="02"
ElseIf $title3="02" Then    
	$title3="03"
ElseIf $title3="03" Then 
    $title3="04"
ElseIf $title3="04" Then 
    $title3="05"
ElseIf $title3="05" Then    
	$title3="06"
ElseIf $title3="06" Then 
    $title3="07"
ElseIf $title3="07" Then    
	$title3="08"
ElseIf $title3="08" Then 
    $title3="09"
ElseIf $title3=99 Then
	$title3="00"
	$title1 =$title1+1
Else
	$title3=$title3+1
EndIf

	ConsoleWrite( "Int64ToMacAddress : " & $quan & @CRLF )
Next


;MsgBox(1,"Int64ToMacAddress : " ,$quan); & @CRLF)
;ConsoleWrite( "Int64ToMacAddress : " & $quan & @CRLF )