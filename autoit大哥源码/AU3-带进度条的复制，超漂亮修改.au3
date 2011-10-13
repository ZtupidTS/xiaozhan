#include <GUIConstants.au3> 
#include <GuiConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <ProgressConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
$openfile = FileSelectFolder("请选择需要复制的文件夹", "", 4);显示一个文件夹选择对话框
If Not @error Then
	$savefile = FileSelectFolder("请选择需要保存的位置", "",7)
		If Not @error Then
				ProgressCopy($openfile, $savefile,1);要复制的文件 
		Else
			Exit
		EndIf
Else
	Exit
EndIf

Func ProgressCopy($current, $destination, $UseMultiColour=0, $attrib = "-R", $overwrite = 1 ,$Run1 = 0 )

;FirstTimeRun Get original DirSize and set up Gui 
If $Run1 = 0 Then 
Global $OverallQty, $Overall, $source, $overallpercent, $Progress0Text, $progressbar1, $Progress1Text, $progressbar2, $Progress2Text, $LocalPercent 
DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", 0) 
If not FileExists ($Destination) then DirCreate ($Destination); This is why it was failing, the dir did not exist 
$source = $current 
If StringRight($current, 1) = '\' Then $current = StringTrimRight($current, 1) 
If StringRight($destination, 1) <> '\' Then $destination = $destination & "\" 
$tosearch = $current 
$Overall = DirGetSize($tosearch, 1) 
$OverallQty = $Overall[1] 
Global Const $PrCopyGui = GUICreate("进度条", 420, 100, -1, -1, -1, $WS_EX_TOOLWINDOW + $WS_EX_TOPMOST) 
$Progress0Text = GUICtrlCreateLabel("Please Wait", 10, 5, 400, 20, $SS_LEFTNOWORDWRAP) 
$progressbar1 = GUICtrlCreateProgress(10, 20, 400, 20) 
GUICtrlSetColor(-1, 32250) 
$Progress1Text = GUICtrlCreateLabel("", 10, 44, 400, 20, $SS_LEFTNOWORDWRAP) 
$progressbar2 = GUICtrlCreateProgress(10, 60, 400, 20, $PBS_SMOOTH) 
$Progress2Text = GUICtrlCreateLabel("", 10, 82, 400, 20, $SS_LEFTNOWORDWRAP) 
GUISetFont(10, 600) 
;$Progress2Text2 = GUICtrlCreateLabel("", 150, 62, 400, 20) 
GUICtrlSetColor(-1, 32250); not working with Windows XP Style if not using windows classic style or dllcall above 
GUISetState(@SW_SHOW) 
GUICtrlSetData($Progress1Text, "Working Directory " & $tosearch) 
$Run1 = 1 
EndIf

$Size = DirGetSize($current, 3) 
$Qty = $Size[1] 
Local $search = FileFindFirstFile($current & "\*.*") 
While 1 
Dim $file = FileFindNextFile($search) 
If @error Or StringLen($file) < 1 Then ExitLoop 
If Not StringInStr(FileGetAttrib($current & "\" & $file), "D") And ($file <> "." Or $file <> "..") Then 
$Qty -= 1 
$LocalPercent = 100 - (($Qty / $Size[1]) * 100) 
$OverallQty -= 1 
$overallpercent = 100 - (($OverallQty / $Overall[1]) * 100) 
GUICtrlSetData($Progress0Text, "Total Progress " & Int($overallpercent) & "% completed") 
GUICtrlSetData($progressbar1, $overallpercent) 
GUICtrlSetData($progressbar2, $LocalPercent) 
GUICtrlSetData($Progress2Text, "Copying File " & $file)

If $useMultiColour then 
GUICtrlSetColor($Progressbar2, _ChangeColour($LocalPercent)) 
GUICtrlSetColor($Progressbar1, _ChangeColour($OverallPercent)) 
EndIf

FileCopy($current & "\" & $file, $destination & StringTrimLeft($current, StringLen($source)) & "\" & $file,$overwrite) 
FileSetAttrib($destination & StringTrimLeft($current, StringLen($source)) & "\" & $file, $attrib) 
EndIf 
If StringInStr(FileGetAttrib($current & "\" & $file), "D") And ($file <> "." Or $file <> "..") Then 
DirCreate($destination & StringTrimLeft($current, StringLen($source)) & "\" & $file) 
FileSetAttrib($destination & StringTrimLeft($current, StringLen($source)) & "\" & $file, $attrib) 
GUICtrlSetData($Progress1Text, $current & "\" & $file) 
ProgressCopy($current & "\" & $file, $destination, $UseMultiColour, $attrib, $overwrite,1) 
EndIf 
WEnd 
FileClose($search) 
;when overall percent = 100 set end gui text, delete gui and reset run1 to 0 
If $overallpercent = 100 Then 
GUICtrlSetData($Progress0Text, "Total Progress 100% completed") 
GUICtrlSetData($progressbar1, 100) 
GUICtrlSetData($progressbar2, 100) 
GUICtrlSetData($Progress2Text, "复制完毕!") 
Sleep(2000) 
GUIDelete($PRCopyGui) 
$Run1 = 0 
EndIf 
EndFunc ;==>ProgressCopy

Func _ChangeColour($start)

$Redness = Int(255 - ($start / 100 * 512)) 
If $Redness < 0 Then $Redness = 0

$Greeness = Int(($start / 100 * 512) - 257) 
If $Greeness < 0 Then $Greeness = 0

$Blueness = Int(255 - ($Redness + $Greeness))

Return ($Redness * 256 * 256) + ($Greeness * 256) + $Blueness

EndFunc