; ===============================================================================================
; Func _WinGetAltTabWinList($sTitle="",$sText="",$bGetClassName=False)
;
; Returns list of visible Alt-Tab-able windows.
;
; $sTitle = (optional) Title of window, or window handle to send to initial WinList() call
; $sText = (optional) Visible text in window, same as WinList() call
; $bGetClassName = If True, a 3rd column will be created in the array containing the Window's class name
;
; Returns:
;   Success: An array of Windows in the same style as WinList, bottom element [0][0] = count,
;      with an optional 3rd column (depending on 3rd parameter)
;   Failure: A 1-element array same as WinList, with [0][0] = 0, and @error set
;      @error = 0 = WinList returned matches, but nothing matched Alt-Tab-able windows
;      @error = 1 = WinList return no matches
;      @error = 2 = DLLOpen failed
;
; Author: Authenticity, *very* slight modifications by Ascend4nt
; Original post @ http://www.autoitscript.com/forum/index.php?s=&showtopic=90149&view=findpost&p=648588
; ===============================================================================================

Func _WinGetAltTabWinList($sTitle="",$sText="",$bGetClassName=False)
    Dim $aReturnWinList[1][2]=[[0,0]],$aWinList

    ; Since passing an empty string or 'Default' keyword for 1st parameter
    ; causes WinList to return incorrect results, we test first
    If $sTitle<>"" Then
        $aWinList=WinList($sTitle,$sText)
    Else
        $aWinList=WinList()
    EndIf

    ; Check to see if any Windows matched, given the parameters. If not, return empty list
    If $aWinList[0][0]=0 Then Return SetError(1,0,$aReturnWinList)

    ; Open the DLL for faster calls.
    Local $hUser32 = DllOpen('user32.dll')
    If $hUser32==-1 Then Return SetError(2,0,$aReturnWinList)
   
    ; Does the caller want the Class name also?
    If $bGetClassName Then
        ; Set initial dimensions to match WinList's, +1 column
        Dim $aReturnWinList[$aWinList[0][0]+1][3]
    Else
        ; Set initial dimensions to match WinList's
        Dim $aReturnWinList[$aWinList[0][0]+1][2]
    EndIf
    ; Set the initial count to 0
    $aReturnWinList[0][0] = 0

    For $i = 1 To $aWinList[0][0]      
        ; If it's visible and *not* $GWL_EXSTYLE = WS_EX_TOOLWINDOW
        ;   (i.e. not a non-Alt-Tab-able window), then add it to the list
        If BitAND(WinGetState($aWinList[$i][1]), 2) And _
                Not BitAND(_INT_GetWindowLong($aWinList[$i][1],0xFFFFFFEC,$hUser32), 0x80) Then
            $aReturnWinList[0][0]+=1
            $aReturnWinList[$aReturnWinList[0][0]][0]=$aWinList[$i][0]
            $aReturnWinList[$aReturnWinList[0][0]][1]=$aWinList[$i][1]
            If $bGetClassName Then $aReturnWinList[$aReturnWinList[0][0]][2]=_INT_GetClassName($aWinList[$i][1],$hUser32)
        EndIf
    Next
    ; Close DLL handle
    DllClose($hUser32)
    ; Redimension array to results size
    If $bGetClassName Then
        ReDim $aReturnWinList[$aReturnWinList[0][0]+1][3]
    Else
        ReDim $aReturnWinList[$aReturnWinList[0][0]+1][2]
    EndIf
    Return $aReturnWinList
EndFunc

; Basically the same as _WinAPI_GetWindowLong() standard UDF, but w/error checking+handle option

Func _INT_GetWindowLong($hWnd, $iIndex, $hUser = 'user32.dll')
    Local $aRet = DllCall($hUser, 'int', 'GetWindowLong', 'hwnd', $hWnd, 'int', $iIndex)
    If Not @error Then Return $aRet[0]
    Return SetError(-1, 0, -1)
EndFunc

; _WinAPI_GetClassName() standard UDF function, but w/error checking+handle option

Func _INT_GetClassName($hWnd,$hUser='user32.dll')
    Local $aResult
    If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
    $aResult = DllCall($hUser, "int", "GetClassName", "hwnd", $hWnd, "str", "", "int", 4096)
    If @error Or Not IsArray($aResult) Then Return SetError(@error,0,"")
    Return $aResult[2]
EndFunc

; ===============================================================================================
; TEST
; ===============================================================================================

#cs
#include <Array.au3>
Local $aWindows=_WinGetAltTabWinList("","",True)
_ArrayDisplay($aWindows)
#ce
