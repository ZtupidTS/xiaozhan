#include <Misc.au3>     ; _IsPressed()

#include <_ClipGetHTML.au3>
; ================================================================================================
; <HTMLClipBoardMonitor.au3>
;
; Simple program used to Monitor and Report on HTML formatted ClipBoard data
;
; Functions:
;   MemoWrite() ; from the AutoIT documentation examples
;
; Dependencies:
;   <_ClipGetHTML.au3>  ; _ClipGetHTML()
;
; See also:
;   <_ClipPutHTML.au3>
;
; Author: Ascend4nt, and [??] (whoever coded the AutoIT Help examples with MemoWrite())
; ================================================================================================

Global $iMemo

; MemoWrite and GUI creation courtesy of AutoIT Help Examples

; Write message to memo
Func MemoWrite($sMessage = "")
    GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite

Local $hGUI
Local $sHTMLStrPrev="",$aHTMLData
Local $sPlainText,$aHTMLLinks
 
; Create GUI
$hGUI = GUICreate("HTML ClipBoard Monitor ([F5] Forces Refresh)", 600, 400)
$iMemo = GUICtrlCreateEdit("", 2, 2, 596, 396, 0x200000)    ; $WS_VSCROLL=0x00200000
GUICtrlSetLimit($iMemo,1000000)
GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
GUISetState()
    
Do
    $aHTMLData=_ClipGetHTML()
    If Not @error And ($aHTMLData[0]<>$sHTMLStrPrev Or _IsPressed("74")) Then
        $sPlainText=ClipGet()
        ; Clear the Edit Control
        GUICtrlSetData($iMemo,"","")
        MemoWrite("==== New HTML Data received ("&@HOUR&':'&@MIN&":"&@SEC&") ===="&@CRLF&"Version #"&$aHTMLData[1]&@CRLF& _
          "Fragment Start:"&$aHTMLData[2]&", Fragment End:"&$aHTMLData[3]&@CRLF& _
          "Selection Start (optional [-1=unavailable]):"&$aHTMLData[4]& _
          ", Selection End (optional):"&$aHTMLData[5]&@CRLF& _
          "Source URL (optional string):"&$aHTMLData[6]&@CRLF& _
          "4 characters at Fragment Start:"&StringMid($aHTMLData[0],$aHTMLData[2],4)&@CRLF& _
          "4 characters at Fragment End:"&StringMid($aHTMLData[0],$aHTMLData[3],4)&@CRLF)
        If $aHTMLData[4]<>-1 Then
            MemoWrite("4 characters at Selection Start:"&StringMid($aHTMLData[0],$aHTMLData[4],4)&@CRLF& _
                "4 characters at Selection End:"&StringMid($aHTMLData[0],$aHTMLData[5],4))
        EndIf
        MemoWrite("----  CF_HTML Header (size="&StringLen($aHTMLData[7])&") ----"&@CRLF&$aHTMLData[7]&@CRLF)
        MemoWrite("----  RAW HTML Data (UTF-8 size="&StringLen($aHTMLData[0])&") ----"&@CRLF&BinaryToString($aHTMLData[0],4)&@CRLF)
        MemoWrite("---- Plain Text Variant (size="&StringLen($sPlainText)&") ----"&@CRLF&$sPlainText)
        
        #cs     
        ; Want to put it back just the way it came? This is one approach, but
        ;   the Offsets will not be placed properly
        ;_ClipPutHTML($aHTMLData[0],$sPlainText)
        
        ; This is the proper way:

        Local $sHTMLData=$aHTMLData[7]&$aHTMLData[0]
        _ClipBoard_SendHTML($sHTMLData,$sPlainText)
        #ce

        $sHTMLStrPrev=$aHTMLData[0]
    EndIf   
Until _IsPressed("1B") Or GUIGetMsg()=-3    ; $GUI_EVENT_CLOSE=-3
GUIDelete($hGUI)
