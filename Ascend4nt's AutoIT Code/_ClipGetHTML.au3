#include-once
#include <Clipboard.au3>
#include <Memory.au3>       ; (for _Mem..() funcs) [actually included in <ClipBoard.au3>, but here for clarity]
; ================================================================================================
; <_ClipGetHTML.au3>
;
; Function to get HTML formatted text from the Clipboard.
;
; Functions:
;   _ClipGetHTML()          ; Function to get HTML code (in UTF-8 format) from the clipboard (if it exists in that format),
;                           ;   NOTE: The PlainText version (usually available) can also be gotten with a call to ClipGet()
;
; Requirements: AutoIT 3.3+ (or Unicode variant of 3.2.12.1)
;
; NOTES: ClipBoard DLL calls as of AutoIT 3.3 do not have error checking.
;
; Dependencies: <Clipboard.au3>,  <Memory.au3>
;
; See also:
;   <_ClipPutHTML.au3>
;
; Resources:
;   CF_HTML (# 49342) Format @ MSDN: http://msdn.microsoft.com/en-us/library/ms649015(VS.85).aspx
;   Clipboard Formats @ MSDN: http://msdn.microsoft.com/en-us/library/ms649013(VS.85).aspx
;
; Author: Ascend4nt, Paul Campbell (PaulIA) for _ClipBoard_GetData() portions of the code (<ClipBoard.au3> UDF)
; ================================================================================================

; ================================================================================================
; Func _ClipGetHTML()
;
; Method to get HTML data from the clipboard, and to place the different elements in an array.
;
; NOTE: PlainText variant of the ClipBoard data is NOT retrived (though it can be added to this function if you please)
;   Reason: Caller can simply do a call to ClipGet() right before/after a call to this function
;
; IMPORTANT: Returned HTML Data is in UTF-8 format. The offsets into the returned HTML Data string
;   should be used PRIOR to doing any types of Unicode conversions, as the offsets are based on
;   the # of characters (including the multiple characters required to produce certain Unicode characters)
;
; Returns:
;   Success: an array of data regarding the retrieved data, with @error = 0. Array format:
;       $array[0] = HTML Data String (in UTF-8 encoding)
;       $array[1] = Version # as a string (typically "0.9" or "1.0")
;       $array[2] = Fragment Start [where in the HTML Data String the actual copied portion fragment begins)
;       $array[3] = Fragment End (where "" "" fragment ends)
;       $array[4] = Selection Start (optional, -1 if unavailable): Where in the HTML Data String,
;          and also within the FragmentStart->FragmentEnd portion, where the *selection* starts
;       $array[5] = Section End (optional, -1 if unavailable): "" "" *selection* ends
;       $array[6] = Source URL (optional, "" if unavailable). For webpage data, this is typically a normal URL,
;           but for document editors, helpfiles, and such, it can be information that has to be interpreted differently
;           (you'll have to examine it to figure this part out)
;       $array[7] = The Original CF_HTML Header as it came from the ClipBoard.  This is mostly useful
;           only if the data needs to be sent BACK to the ClipBoard (adding this before the HTML Data String)
;           (Note that offsets in the CF_HTML Header string will not match those in the rest of the array,
;           due to adjustments needed (removing the size of the Header))
;
; Failure: "" with @error set:
;       @error = -1 = no HTML data in CilpBoard
;       @error = -2 = error opening ClipBoard
;       @error = -3 = error trying to retrieve ClipBoard data
;       @error = -4 = error locking the Memory Object
;       @error = -6 = StartHTML/EndHTML identifiers not found in ClipBoard's HTML Header
;       @error = -9 = error registering HTML Data Clipboard format (no attempt to get CF_HTML #)
;
; Author: Ascen4nt, Paul Campbell (PaulIA) for _ClipBoard_GetData() portions of the code (<ClipBoard.au3> UDF)
; ================================================================================================

Func _ClipGetHTML()
    ;  CF_HTML in experimentation is generally 49342, but we'll use the proper method here
    Local $iCF_HTMLFormat=_ClipBoard_RegisterFormat("HTML Format")
    
    If $iCF_HTMLFormat=0 Then Return SetError(-9,@error,"")

    If Not _ClipBoard_IsFormatAvailable($iCF_HTMLFormat) Then Return SetError(-1,@error,"")
    
    If Not _ClipBoard_Open(0) Then Return SetError(-2, 0, "")
    Local $hMemory=_ClipBoard_GetDataEx($iCF_HTMLFormat)


    If $hMemory=0 Then
        _ClipBoard_Close()
        Return SetError(-3, 0, "")
    EndIf

    Local $pMemoryBlock=_MemGlobalLock($hMemory)
    
    If $pMemoryBlock=0 Then
        _ClipBoard_Close()
        Return SetError(-4,0,"")
    EndIf   
    
#cs
    ; Proper way to get the actual memory size to use in creating a DLL Structure (in bytes):
    
    Local $iDataSize=DllCall("Kernel32.dll","int","GlobalSize","hwnd",$hMemory)
    
    If @error Or Not $iDataSize[0] Then
        _MemGlobalUnlock($hMemory)
        _ClipBoard_Close()
        Return SetError(-5,0,"")
    EndIf   
    $iDataSize=$iDataSize[0]
#ce
    
    ; Knowing the format, we are safe using this small Structure which is less than the minimum needed
    ;  for a full HTML ClipBoard data object. We only need to grab 2 fields, so the smaller, the faster 
    Local $stData=DllStructCreate("char[64]",$pMemoryBlock)

    Local $sHTMLHeader=DllStructGetData($stData,1)
    ; Get the actual size of data to retrieve
    Local $iHTMLEnd=StringRegExp($sHTMLHeader,"(?i)EndHTML:(\d+)",1)
    ; Also get the size of the header to make retrieving it less painful later (if the HTML data is huge)
    Local $iHTMLStart=StringRegExp($sHTMLHeader,"(?i)StartHTML:(\d+)",1)
    
    ; Were we successful in retrieving both?
    If Not IsArray($iHTMLStart) Or Not IsArray($iHTMLEnd) Then
        ; No 'StartHTML:####' and/or no 'EndHTML:####' found? Return failure
        _MemGlobalUnlock($hMemory)
        _ClipBoard_Close()
        Return SetError(-6,0,"")        
    Else
        ; Convert the 1-element arrays to numbers
        $iHTMLStart=Number($iHTMLStart[0])
        $iHTMLEnd=Number($iHTMLEnd[0])
    EndIf

    ; Now that we have the full HTML-Data size, we'll grab the whole thing
    $stData=DllStructCreate("char["&$iHTMLEnd&']',$pMemoryBlock)
    Local $sHTMLData=DllStructGetData($stData,1)
    
    ; Clear the structure
    $stData=0
    
    ; Unlock the memory & Close the clipboard now that we have grabbed what we needed
    _MemGlobalUnlock($hMemory)
    _ClipBoard_Close()
    
    ; Get the (now-FULL) Header
    $sHTMLHeader=StringLeft($sHTMLData,$iHTMLStart)
    ; Remove the header so that only the HTML data is left
    $sHTMLData=StringTrimLeft($sHTMLData,$iHTMLStart)
    
    ; Now gather the Header Data (some components are optional)
    Local $iFragmentStart=StringRegExp($sHTMLHeader,"(?i)StartFragment:(\d+)",1)
    Local $iFragmentEnd=StringRegExp($sHTMLHeader,"(?i)EndFragment:(\d+)",1)
    ; Though not optional, we'll treat them as such, and give them
    ;   defaults of HTMLStart/HTMLEnd
    If IsArray($iFragmentStart) Then
        ; Adjust +1 to rectify position
        $iFragmentStart=Number($iFragmentStart[0])+1
    Else
        $iFragmentStart=$iHTMLStart
    EndIf
    
    If IsArray($iFragmentEnd) Then
        $iFragmentEnd=Number($iFragmentEnd[0])
    Else
        $iFragmentEnd=$iHTMLEnd
    EndIf
                
    ; The following 3 are optional header fields
    Local $iSelectionStart=StringRegExp($sHTMLHeader,"(?i)StartSelection:(\d+)",1)
    Local $iSelectionEnd=StringRegExp($sHTMLHeader,"(?i)EndSelection:(\d+)",1)
    
    If IsArray($iSelectionEnd) Then
        $iSelectionEnd=Number($iSelectionEnd[0])
    Else
        $iSelectionEnd=-1
    EndIf
    
    If IsArray($iSelectionStart) Then
        ; Adjust +1 to rectify position
        $iSelectionStart=Number($iSelectionStart[0])+1
    ElseIf $iSelectionEnd=-1 Then
        $iSelectionStart=-1
    Else
        ; Selection End was found, but selection start not? Just set it to Fragment Start
        $iSelectionStart=$iFragmentStart
    EndIf
    
    Local $sSourceURL=StringRegExp($sHTMLHeader,"(?i)SourceURL:([^ \r\n\z]+)",1)
    If @error Then
        $sSourceURL=""
    Else
        $sSourceURL=$sSourceURL[0]
    EndIf
    
    Local $iVersion=StringRegExp($sHTMLHeader,"(?i)Version:([0-9.]+)",1)
    If @error Then
        ; Set it to the initial version if not found
        $iVersion="0.9"
    Else
        $iVersion=$iVersion[0]
    EndIf
            
    ; Make # adjustments based on header start (since it was removed)
    $iFragmentStart-=$iHTMLStart
    $iFragmentEnd-=$iHTMLStart
    If $iSelectionEnd<>-1 Then
        $iSelectionStart-=$iHTMLStart
        $iSelectionEnd-=$iHTMLStart
    EndIf
        
    ; $iHTMLStart can now be set to 1 (the start of the HTML string obviously) after the above adjustments
    ;$iHTMLStart=1  ; pointless, as the variable ceases to be of any more use
    
    ; -----------------------------------------------------------------------------------------
    ; This would convert the UTF-8 HTML data to Unicode, but it would screw up the Offsets in
    ;  data with any kind of Unicode characters in it.
    ;   This is why its important to do the conversions *outside* of this function, and only
    ;    *AFTER* the data has been grabbed at the given offsets!
    ;
    ;   $sUnicodeHTML=BinaryToString($sHTMLData,4)
    ; -----------------------------------------------------------------------------------------
    
    ; Put all the elements in the return array, and return!
    Dim $aReturnArray[8]=[$sHTMLData,$iVersion,$iFragmentStart,$iFragmentEnd,$iSelectionStart,$iSelectionEnd,$sSourceURL,$sHTMLHeader]
        
    Return $aReturnArray
EndFunc
