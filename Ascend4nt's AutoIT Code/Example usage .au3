;_ArraySortIndirect 
#include <Array.au3>
#include <_ArraySortIndirect.au3>

Local $iTimer
Dim $aRandomNumArray1D[400]
Dim $aRandomNumArray2D[400][4]
Dim $aSortedIndexes[400]

For $i=1 To 399
    ; Put same random value in each array (in column 3 for 2D array)
    $aRandomNumArray2D[$i][2]=Random(10,1000,1) 
    $aRandomNumArray1D[$i]=$aRandomNumArray2D[$i][2]
Next

; Indirect 2D sort
$iTimer=TimerInit()
_ArraySortIndirect($aRandomNumArray2D,$aSortedIndexes,0,1,1,-1,2,True)
ConsoleWrite("Indirect 2D sort time:"&TimerDiff($iTimer)&" ms"&@CRLF)


For $i=1 To 399
    ; Set the 2D array's 1st column to show sorted indirect indexes 
    $aRandomNumArray2D[$i][0]=$aSortedIndexes[$i]
    ; Set the 2D array's 4th column to reflect correct order
    $aRandomNumArray2D[$i][3]=$aRandomNumArray2D[$aSortedIndexes[$i]][2]
Next

; Indirect 1D sort
$iTimer=TimerInit()
_ArraySortIndirect($aRandomNumArray1D,$aSortedIndexes,0,1,1)
ConsoleWrite("Indirect 1D sort time:"&TimerDiff($iTimer)&" ms"&@CRLF)

For $i=1 To 399
    ; Set the 2nd column of the 2D array to show sorted indirect indexes for 1D array of same values
    $aRandomNumArray2D[$i][1]=$aSortedIndexes[$i]
Next
; Set 'Headers'
$aRandomNumArray2D[0][0] = "Sorted 2D indexes"
$aRandomNumArray2D[0][1] = "Sorted 1D indexes"
$aRandomNumArray2D[0][2] = "Original unsorted values"
$aRandomNumArray2D[0][3] = "Values in sorted order"

_ArrayDisplay($aRandomNumArray2D,"_ArraySortIndirect Results")


; In-array indirect sort
$iTimer=TimerInit()
_ArraySortIndexes($aRandomNumArray2D,0,1,-1,0,2)
ConsoleWrite("In-array indirect sort time:"&TimerDiff($iTimer)&" ms"&@CRLF)

_ArrayDisplay($aRandomNumArray2D,"_ArraySortIndexes [in-array sort] Results")

; *Direct* _ArraySort() routines comparison:
$iTimer=TimerInit()
_ArraySort($aRandomNumArray2D,0,1,UBound($aRandomNumArray2D)-1,2)
ConsoleWrite("_ArraySort 2D time:"&TimerDiff($iTimer)&" ms"&@CRLF)

$iTimer=TimerInit()
_ArraySort($aRandomNumArray1D,0,1)
ConsoleWrite("_ArraySort 1D time:"&TimerDiff($iTimer)&" ms"&@CRLF)
