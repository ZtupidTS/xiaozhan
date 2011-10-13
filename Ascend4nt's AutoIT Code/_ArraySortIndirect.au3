#include-once
;#include <Array.au3>        ; _ArrayReverse() [plopped it right into the function instead]

; ===============================================================================================================================
; <_ArraySortIndirect.au3>
;
; Simple function(s) to 'sort' an array, indirectly.  In other words - it doesn't move data in the array around,
;    but instead moves indexes to the array around. (The array of course must match the # of items to be sorted)
;
; Functions:
;    _ArraySortIndirect()    ; indirect index sort: 1 1D array is Indexes, another array is Data
;                            ;    The Data isn't moved, but the Indexes are put in-order
;    _ArraySortIndexes()        ; in-array indirect index sort: a single 2D array with an Indexes Column
;                            ;    The entire row/data isn't moved, only the Indexes column is rearranged
;
; Internal DO-NOT-USE functions:
;    __ArrayQuickSortIndirect1D()
;    __ArrayQuickSortIndirect2D()
;    __ArrayQuickSortIndexes()
;
; See Also:
;    <_LinkedListFunctions.au3>    ; _LL_SortData() utilizes _ArraySortIndirect()
;    <_ArraySortIndirectwHistory.au3>    ; (with history)
;    <_LinkedListFunctionswHistory.au3>    ; (with history)
;
; Author: Ascend4nt*
;    *modified from v3.3 _ArraySort() UDF (and helper function), and _ArrayReverse() UDF code - authors of those:
;    _ArraySort() & __ArrayQuickSort1D() helper function: Jos van der Zande, LazyCoder, Tylo, Ultima
;    _ArrayReverse(): Brian Keene, Jos van der Zande, Tylo, Ultima
; ===============================================================================================================================

; ===============================================================================================================================
; Func _ArraySortIndirect(Const ByRef $aArrayToSort,ByRef $aIndexArray,$iDescending=0,$iDataStart=0, _
;    $iIndexStart=0,$iIndexEnd=-1,$iColumn=0,$bInitializeIndexes=True)
;
; Sorts an array of indexes that point to another array, while avoiding reordering of the main array.
;
; $aArrayToSort = the 1D or 2D array containing data that will be the basis of indirect reordering
; $aIndexArray = 1D array of indexes pointing into $aArrayToSort. This is the array that will be adjusted
; $iDescending = if non-zero, sorts in Descending order, otherwise it sorts in Ascending order
; $iDataStart = start point in $aArrayToSort (where sort compares begin) - needed when $bInitializeIndexes is TRUE
;     NOTE: set to 0 if $bInitializeIndexes is FALSE
;  *END point in $aArrayToSort [when $bInitializeIndexes is TRUE] is determined automatically by the
;    computed value of $iIndexEnd-$iIndexStart+1
; $iIndexStart = start point in $aIndexArray (where sorting begins)
; $iIndexEnd = end point in $aIndexArray (where sorting stops)
; $iColumn = [only used for 2D arrays]: column in 2D array to look at for sorting purposes
; $bInitializeIndexes = If TRUE, 1st initializes the $aIndexArray with sequential incrementing indexes, preparing
;    it for sorting
;
; Returns:
;    Success: True, with $aIndexArray now containing a sorted list
;    Failure: False, with @error = 1 (invalid params)
;
; Author: Ascend4nt, modified from v3.3 _ArraySort() UDF and _ArrayReverse() UDF code - authors of those:
;    _ArraySort(): Jos van der Zande, LazyCoder, Tylo, Ultima
;    _ArrayReverse(): Brian Keene, Jos van der Zande, Tylo, Ultima
; ===============================================================================================================================

Func _ArraySortIndirect(Const ByRef $aArrayToSort,ByRef $aIndexArray,$iDescending=0,$iDataStart=0, _
    $iIndexStart=0,$iIndexEnd=-1,$iColumn=0,$bInitializeIndexes=True)
    
    If Not IsArray($aArrayToSort) Or Not IsArray($aIndexArray) Or UBound($aIndexArray,0)>1 Then Return SetError(1,0,False)
    
    If $iIndexEnd=-1 Then $iIndexEnd=UBound($aIndexArray)-1
    
    If $iIndexStart<0 Or $iIndexStart>$iIndexEnd Or $iIndexEnd>UBound($aIndexArray)-1 Then Return SetError(1,0,False)
    If $iDataStart<0 Or $iDataStart+($iIndexEnd-$iIndexStart)>UBound($aArrayToSort)-1 Then Return SetError(1,0,False)
    
    If $bInitializeIndexes Then
        Local $iDest=$iDataStart
        For $i=$iIndexStart To $iIndexEnd
            $aIndexArray[$i]=$iDest
            $iDest+=1
        Next
    EndIf

    ; Sort
    Switch UBound($aArrayToSort, 0)
        Case 1
            __ArrayQuickSortIndirect1D($aArrayToSort,$aIndexArray,$iIndexStart,$iIndexEnd)
        Case 2
            If $iColumn<0 Or $iColumn>UBound($aArrayToSort,2)-1 Then Return SetError(1,0,False)
            __ArrayQuickSortIndirect2D($aArrayToSort,$aIndexArray,$iIndexStart,$iIndexEnd,$iColumn)
        Case Else
            Return SetError(1,0,False)
    EndSwitch
    ;If $iDescending Then _ArrayReverse($aIndexArray,$iIndexStart,$iIndexEnd)
    ; _ArrayReverse() code pulled out:
    If $iDescending Then
        Local $vTmp
        ; Reverse
        For $i = $iIndexStart To Int(($iIndexStart + $iIndexEnd - 1) / 2)
            $vTmp = $aIndexArray[$i]
            $aIndexArray[$i] = $aIndexArray[$iIndexEnd]
            $aIndexArray[$iIndexEnd] = $vTmp
            $iIndexEnd -= 1
        Next
    EndIf
    Return True    
EndFunc

; ===============================================================================================================================
; Func __ArrayQuickSortIndirect1D(Const ByRef $aArrayToSort,ByRef $aIndexArray,ByRef $iStart,ByRef $iEnd)
;
; Helper function for _ArraySortIndirect(). This is a modified version of __ArrayQuickSort1D().
;
; $aArrayToSort = the array to base sorting on
; $aIndexArray = the array of indexes (into $aArrayToSort) to sort
; $iStart = index in $aIndexArray to start sorting at
; $iEnd = index in $aIndexArray to stop sorting at
;
; Returns: Nothing
;
; Author: Ascend4nt, modified from v3.3 _ArraySort() UDF helper function __ArrayQuickSort1D() - authors of that:
;        Jos van der Zande, LazyCoder, Tylo, Ultima
; ===============================================================================================================================

Func __ArrayQuickSortIndirect1D(Const ByRef $aArrayToSort,ByRef $aIndexArray,ByRef $iStart,ByRef $iEnd)
    If $iEnd <= $iStart Then Return

    Local $vTmp
    ; InsertionSort (faster for smaller segments)
    If ($iEnd - $iStart) < 15 Then
        Local $i,$j,$vCur,$iTmp
        For $i = $iStart + 1 To $iEnd
            $iTmp=$aIndexArray[$i]
            $vTmp = $aArrayToSort[$iTmp]            

            If IsNumber($vTmp) Then
                For $j = $i - 1 To $iStart Step -1
                    $vCur = $aArrayToSort[$aIndexArray[$j]]
                    ; If $vTmp >= $vCur Then ExitLoop
                    If ($vTmp >= $vCur And IsNumber($vCur)) Or (Not IsNumber($vCur) And StringCompare($vTmp, $vCur) >= 0) Then ExitLoop
                    $aIndexArray[$j + 1] = $aIndexArray[$j]
                Next
            Else
                For $j = $i - 1 To $iStart Step -1
                    If (StringCompare($vTmp, $aArrayToSort[$aIndexArray[$j]]) >= 0) Then ExitLoop
                    $aIndexArray[$j + 1] = $aIndexArray[$j]
                Next
            EndIf

            $aIndexArray[$j + 1] = $iTmp
        Next
        Return
    EndIf

    ; QuickSort
    Local $L = $iStart, $R = $iEnd, $vPivot = $aArrayToSort[$aIndexArray[Int(($iStart + $iEnd) / 2)]], $fNum = IsNumber($vPivot)
    Do
        If $fNum Then
            ; While $avArray[$L] < $vPivot
            While ($aArrayToSort[$aIndexArray[$L]] < $vPivot And IsNumber($aArrayToSort[$aIndexArray[$L]])) Or (Not IsNumber($aArrayToSort[$aIndexArray[$L]]) And StringCompare($aArrayToSort[$aIndexArray[$L]], $vPivot) < 0)
                $L += 1
            WEnd
            ; While $avArray[$R] > $vPivot
            While ($aArrayToSort[$aIndexArray[$R]] > $vPivot And IsNumber($aArrayToSort[$aIndexArray[$R]])) Or (Not IsNumber($aArrayToSort[$aIndexArray[$R]]) And StringCompare($aArrayToSort[$aIndexArray[$R]], $vPivot) > 0)
                $R -= 1
            WEnd
        Else
            While (StringCompare($aArrayToSort[$aIndexArray[$L]], $vPivot) < 0)
                $L += 1
            WEnd
            While (StringCompare($aArrayToSort[$aIndexArray[$R]], $vPivot) > 0)
                $R -= 1
            WEnd
        EndIf

        ; Swap
        If $L <= $R Then
            $vTmp=$aIndexArray[$L]
            $aIndexArray[$L]=$aIndexArray[$R]
            $aIndexArray[$R]=$vTmp
            $L+=1
            $R-=1
        EndIf
    Until $L > $R

    __ArrayQuickSortIndirect1D($aArrayToSort,$aIndexArray,$iStart,$R)
    __ArrayQuickSortIndirect1D($aArrayToSort,$aIndexArray,$L,$iEnd)    
EndFunc

; ===============================================================================================================================
; Func __ArrayQuickSortIndirect2D(Const ByRef $aArrayToSort,ByRef $aIndexArray,ByRef $iStart,ByRef $iEnd, ByRef $iColumn)
;
; Helper function for _ArraySortIndirect(). This is a modified version of __ArrayQuickSort1D().
;
; $aArrayToSort = the 2D array to base sorting on
; $aIndexArray = the array of indexes (into $aArrayToSort) to sort
; $iStart = index in $aIndexArray to start sorting at
; $iEnd = index in $aIndexArray to stop sorting at
; $iColumn = column of 2D $aArrayToSort in which comparisons are based on
;
; Returns: Nothing
;
; Author: Ascend4nt, modified from v3.3 _ArraySort() UDF helper function __ArrayQuickSort1D() - authors of that:
;        Jos van der Zande, LazyCoder, Tylo, Ultima
; ===============================================================================================================================

Func __ArrayQuickSortIndirect2D(Const ByRef $aArrayToSort,ByRef $aIndexArray,ByRef $iStart,ByRef $iEnd,ByRef $iColumn)
    If $iEnd <= $iStart Then Return

    Local $vTmp
    ; InsertionSort (faster for smaller segments)
    If ($iEnd - $iStart) < 15 Then
        Local $i,$j,$vCur,$iTmp
        For $i = $iStart + 1 To $iEnd
            $iTmp=$aIndexArray[$i]
            $vTmp=$aArrayToSort[$iTmp][$iColumn]            

            If IsNumber($vTmp) Then
                For $j = $i - 1 To $iStart Step -1
                    $vCur = $aArrayToSort[$aIndexArray[$j]][$iColumn]
                    ; If $vTmp >= $vCur Then ExitLoop
                    If ($vTmp >= $vCur And IsNumber($vCur)) Or (Not IsNumber($vCur) And StringCompare($vTmp, $vCur) >= 0) Then ExitLoop
                    $aIndexArray[$j + 1] = $aIndexArray[$j]
                Next
            Else
                For $j = $i - 1 To $iStart Step -1
                    If (StringCompare($vTmp, $aArrayToSort[$aIndexArray[$j]][$iColumn]) >= 0) Then ExitLoop
                    $aIndexArray[$j + 1] = $aIndexArray[$j]
                Next
            EndIf

            $aIndexArray[$j + 1] = $iTmp
        Next
        Return
    EndIf

    ; QuickSort
    Local $L = $iStart, $R = $iEnd, $vPivot = $aArrayToSort[$aIndexArray[Int(($iStart + $iEnd) / 2)]][$iColumn], $fNum = IsNumber($vPivot)
    Do
        If $fNum Then
            ; While $avArray[$L] < $vPivot
            While ($aArrayToSort[$aIndexArray[$L]][$iColumn] < $vPivot And IsNumber($aArrayToSort[$aIndexArray[$L]][$iColumn])) Or (Not IsNumber($aArrayToSort[$aIndexArray[$L]][$iColumn]) And StringCompare($aArrayToSort[$aIndexArray[$L]][$iColumn], $vPivot) < 0)
                $L += 1
            WEnd
            ; While $avArray[$R] > $vPivot
            While ($aArrayToSort[$aIndexArray[$R]][$iColumn] > $vPivot And IsNumber($aArrayToSort[$aIndexArray[$R]][$iColumn])) Or (Not IsNumber($aArrayToSort[$aIndexArray[$R]][$iColumn]) And StringCompare($aArrayToSort[$aIndexArray[$R]][$iColumn], $vPivot) > 0)
                $R -= 1
            WEnd
        Else
            While (StringCompare($aArrayToSort[$aIndexArray[$L]][$iColumn], $vPivot) < 0)
                $L += 1
            WEnd
            While (StringCompare($aArrayToSort[$aIndexArray[$R]][$iColumn], $vPivot) > 0)
                $R -= 1
            WEnd
        EndIf

        ; Swap
        If $L <= $R Then
            $vTmp=$aIndexArray[$L]
            $aIndexArray[$L]=$aIndexArray[$R]
            $aIndexArray[$R]=$vTmp
            $L+=1
            $R-=1
        EndIf
    Until $L > $R

    __ArrayQuickSortIndirect2D($aArrayToSort,$aIndexArray,$iStart,$R,$iColumn)
    __ArrayQuickSortIndirect2D($aArrayToSort,$aIndexArray,$L,$iEnd,$iColumn)
EndFunc

; ===============================================================================================================================
; Func _ArraySortIndexes(ByRef $aArrayToSort,$iDescending=0,$iStart=0,$iEnd=-1,$iIndexColumn=0,$iDataColumn=1,$bInitializeIndexes=True)
;
; Sorts a column in a 2D array which is filled with indexes to itself. Doesn't actually move the rows, but
;    changes the values in this column to reflect a proper sorted order.
;
; $aArrayToSort = the 2D array containing data AND an index column, the latter of which will be sorted
; $iDescending = if non-zero, sorts in Descending order, otherwise it sorts in Ascending order
; $iStart = start point in $aArrayToSort (where sorting begins)
; $iEnd = end point in $aArrayToSort (where sorting stops)
; $iIndexColumn = column in 2D array where indexes are located (and rearranged)
; $iDataColumn = column in 2D array to look at for comparing/sorting
; $bInitializeIndexes = If TRUE, 1st initializes the $aArrayToSort[x][$iIndexColumn] with sequential incrementing indexes,
;    preparing it for sorting
;
; Returns:
;    Success: True, with $aArrayToSort[x][$iIndexColumn] now containing a sorted list of indexes
;    Failure: False, with @error = 1 (invalid params)
;
; Author: Ascend4nt, modified from v3.3 _ArraySort() UDF and _ArrayReverse() UDF code - authors of those:
;    _ArraySort(): Jos van der Zande, LazyCoder, Tylo, Ultima
;    _ArrayReverse(): Brian Keene, Jos van der Zande, Tylo, Ultima
; ===============================================================================================================================

Func _ArraySortIndexes(ByRef $aArrayToSort,$iDescending=0,$iStart=0,$iEnd=-1,$iIndexColumn=0,$iDataColumn=1,$bInitializeIndexes=True)
    If Not IsArray($aArrayToSort) Or UBound($aArrayToSort,0)<>2 Then Return SetError(1,0,False)
    
    If $iEnd=-1 Then $iEnd=UBound($aArrayToSort)-1
    
    If $iStart<0 Or $iStart>$iEnd Or $iEnd>UBound($aArrayToSort)-1 Then Return SetError(1,0,False)
    
    If $iIndexColumn<0 Or $iIndexColumn>UBound($aArrayToSort,2)-1 Then Return SetError(1,0,False)
    If $iDataColumn=$iIndexColumn Or $iDataColumn<0 Or $iDataColumn>UBound($aArrayToSort,2)-1 Then Return SetError(1,0,False)
    
    If $bInitializeIndexes Then
        For $i=$iStart To $iEnd
            $aArrayToSort[$i][$iIndexColumn]=$i
        Next
    EndIf

    ; Sort
    __ArrayQuickSortIndexes($aArrayToSort,$iStart,$iEnd,$iIndexColumn,$iDataColumn)
    ; _ArrayReverse() code pulled (and *slightly* modified):
    If $iDescending Then
        Local $vTmp
        ; Reverse
        For $i = $iStart To Int(($iStart + $iEnd - 1) / 2)
            $vTmp = $aArrayToSort[$i][$iIndexColumn]
            $aArrayToSort[$i][$iIndexColumn] = $aArrayToSort[$iEnd][$iIndexColumn]
            $aArrayToSort[$iEnd][$iIndexColumn] = $vTmp
            $iEnd -= 1
        Next
    EndIf
    Return True    
EndFunc

; ===============================================================================================================================
; Func __ArrayQuickSortIndexes(ByRef $aArrayToSort,ByRef $iStart,ByRef $iEnd,ByRef $iIndexColumn,ByRef $iDataColumn)
;
; Helper function for _ArraySortIndexes(). This is a modified version of __ArrayQuickSort1D().
;
; $aArrayToSort = the 2D array containing both Data and Index columns
; $iStart = index in $aArrayToSort to start sorting at
; $iEnd = index in $aArrayToSort to stop sorting at
; $iIndexColumn = column of 2D $aArrayToSort which contains indexes to rearrange
; $iDataColumn = column of 2D $aArrayToSort in which comparisons are based on
;
; Returns: Nothing
;
; Author: Ascend4nt, modified from v3.3 _ArraySort() UDF helper function __ArrayQuickSort1D() - authors of that:
;        Jos van der Zande, LazyCoder, Tylo, Ultima
; ===============================================================================================================================

Func __ArrayQuickSortIndexes(ByRef $aArrayToSort,ByRef $iStart,ByRef $iEnd,ByRef $iIndexColumn,ByRef $iDataColumn)
    If $iEnd <= $iStart Then Return
    ; QuickSort
    Local $vTmp

    ; InsertionSort (faster for smaller segments)
    If ($iEnd - $iStart) < 15 Then
        Local $i,$j,$vCur,$iTmp
        For $i = $iStart + 1 To $iEnd
            $iTmp=$aArrayToSort[$i][$iIndexColumn]
            $vTmp = $aArrayToSort[$iTmp][$iDataColumn]            

            If IsNumber($vTmp) Then
                For $j = $i - 1 To $iStart Step -1
                    $vCur = $aArrayToSort[$aArrayToSort[$j][$iIndexColumn]][$iDataColumn]
                    ; If $vTmp >= $vCur Then ExitLoop
                    If ($vTmp >= $vCur And IsNumber($vCur)) Or (Not IsNumber($vCur) And StringCompare($vTmp, $vCur) >= 0) Then ExitLoop
                    $aArrayToSort[$j+1][$iIndexColumn] = $aArrayToSort[$j][$iIndexColumn]
                Next
            Else
                For $j = $i - 1 To $iStart Step -1
                    If (StringCompare($vTmp, $aArrayToSort[$aArrayToSort[$j][$iIndexColumn]][$iDataColumn]) >= 0) Then ExitLoop
                    $aArrayToSort[$j+1][$iIndexColumn] = $aArrayToSort[$j][$iIndexColumn]
                Next
            EndIf

            $aArrayToSort[$j+1][$iIndexColumn] = $iTmp
        Next
        Return
    EndIf

    Local $L=$iStart,$R=$iEnd,$vPivot=$aArrayToSort[$aArrayToSort[Int(($iStart+$iEnd) / 2)][$iIndexColumn]][$iDataColumn]
    Local $fNum=IsNumber($vPivot)
    Do
        If $fNum Then
            ; While $avArray[$L] < $vPivot
            While ($aArrayToSort[$aArrayToSort[$L][$iIndexColumn]][$iDataColumn] < $vPivot And IsNumber($aArrayToSort[$aArrayToSort[$L][$iIndexColumn]][$iDataColumn])) Or (Not IsNumber($aArrayToSort[$aArrayToSort[$L][$iIndexColumn]][$iDataColumn]) And StringCompare($aArrayToSort[$aArrayToSort[$L][$iIndexColumn]][$iDataColumn], $vPivot) < 0)
                $L += 1
            WEnd
            ; While $avArray[$R] > $vPivot
            While ($aArrayToSort[$aArrayToSort[$R][$iIndexColumn]][$iDataColumn] > $vPivot And IsNumber($aArrayToSort[$aArrayToSort[$R][$iIndexColumn]][$iDataColumn])) Or (Not IsNumber($aArrayToSort[$aArrayToSort[$R][$iIndexColumn]][$iDataColumn]) And StringCompare($aArrayToSort[$aArrayToSort[$R][$iIndexColumn]][$iDataColumn], $vPivot) > 0)
                $R -= 1
            WEnd
        Else
            While (StringCompare($aArrayToSort[$aArrayToSort[$L][$iIndexColumn]][$iDataColumn], $vPivot) < 0)
                $L += 1
            WEnd
            While (StringCompare($aArrayToSort[$aArrayToSort[$R][$iIndexColumn]][$iDataColumn], $vPivot) > 0)
                $R -= 1
            WEnd
        EndIf

        ; Swap
        If $L <= $R Then
            $vTmp=$aArrayToSort[$L][$iIndexColumn]
            $aArrayToSort[$L][$iIndexColumn]=$aArrayToSort[$R][$iIndexColumn]
            $aArrayToSort[$R][$iIndexColumn]=$vTmp
            $L+=1
            $R-=1
        EndIf
    Until $L > $R

    __ArrayQuickSortIndexes($aArrayToSort,$iStart,$R,$iIndexColumn,$iDataColumn)
    __ArrayQuickSortIndexes($aArrayToSort,$L,$iEnd,$iIndexColumn,$iDataColumn)
EndFunc
