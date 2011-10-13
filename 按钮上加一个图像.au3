#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>
#include <GuiButton.au3>
#include <GuiImageList.au3>
#Region ### START Koda GUI section ### Form=
Local $hImage, $iIcon = 125, $hImageSmall
$hImage = _GUIImageList_Create(32, 32, 5, 3, 6)
$Form1 = GUICreate("Form1", 354, 193, 192, 124)
$Button1 = GUICtrlCreateButton("Button1", 72, 56, 161, 57 ,$BS_PUSHLIKE)
_GUICtrlButton_SetImageList($Button1, _GetImageListHandle("11.ico", $iIcon, True))
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
WEnd


Func _GetImageListHandle($sFile, $nIconID = 0, $fLarge = False)
	Local $iSize = 16
	If $fLarge Then $iSize = 32
	
	Local $hImage = _GUIImageList_Create($iSize, $iSize, 5, 3)
	If StringUpper(StringMid($sFile, StringLen($sFile) - 2)) = "BMP" Then
		_GUIImageList_AddBitmap($hImage, $sFile)
	Else
		_GUIImageList_AddIcon($hImage, $sFile, $nIconID, $fLarge)
	EndIf
	Return $hImage
EndFunc 

