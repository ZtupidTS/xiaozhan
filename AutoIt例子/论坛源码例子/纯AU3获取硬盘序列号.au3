#include <WinAPI.au3>

Const $IOCTL_STORAGE_BASE = 0x2D
Const $IOCTL_STORAGE_QUERY_PROPERTY = _MakeCtrlCode($IOCTL_STORAGE_BASE, 0x500)
Const $DFP_RECEIVE_DRIVE_DATA = 0x7C088

Const $tagSTORAGEPROPERTYQUERY = "int PropertyId;int QueryType;byte AdditionalParams"
Const $tagSTORAGEDEVICEDESCRIPTOR = "ulong Version;ulong Size;byte DeviceType;" & _
                        "byte DeviceTypeModifier;byte RemovableMedia;" & _
                        "byte CommandQueueing;ulong VendorIdOffset;" & _
                        "ulong ProductIdOffset;ulong ProductRevisionOffset;" & _
                        "ulong SerialNumberOffset;int BusType;" & _
                        "ulong RawPropertiesLength;byte RawDeviceProperties"
Const $tagDRIVERSTATUS = "byte DriverError;byte IDEStatus;byte Reserved1[2];dword Reserved2[2]"
Const $tagIDEREGS = "byte Features;byte SectorCount;byte SectorNumber;byte CylLow;" & _
                        "byte CylHigh;byte DriveHead;byte Command;byte Reserved"
Const $tagSENDCMDOUTPARAMS = "dword Size;" & $tagDRIVERSTATUS
Const $tagSENDCMDINPARAMS = "dword Size;" & $tagIDEREGS & ";byte DriveNumber;" & _
                        "byte Reserved1[3];dword Reserved2[4];byte Buffer"

$sPhysDisk = "\\.\PhysicalDrive0"
$hDisk = _WinAPI_CreateFile($sPhysDisk, 2, 6, 6, 1)
If $hDisk = -1 Then
        Exit(ConsoleWrite("_WinAPI_CreateFile fails, error code: " & _WinAPI_GetLastError() & @CRLF))
EndIf

$tSCIP = DllStructCreate($tagSENDCMDINPARAMS)
$tSCOP = DllStructCreate($tagSENDCMDOUTPARAMS & ";char Buffer[1024]")
$tQuery = DllStructCreate($tagSTORAGEPROPERTYQUERY)
$tDescr = DllStructCreate($tagSTORAGEDEVICEDESCRIPTOR)
DllStructSetData($tQuery, "PropertyId", 0)
DllStructSetData($tQuery, "QueryType", 0)

$iResult = _DeviceIoControl($hDisk, $IOCTL_STORAGE_QUERY_PROPERTY, _
                $tQuery, DllStructGetSize($tQuery), _
                $tDescr, DllStructGetSize($tDescr))
If $iResult = 0 Then
        Exit(ConsoleWrite("_DeviceIoControl fails, error code: " & @error & @CRLF))
EndIf

If DllStructGetData($tDescr, "BusType") = 2 Then
        DllStructSetData($tSCIP, "Command", 0xA1)
Else
        DllStructSetData($tSCIP, "Command", 0xEC)
EndIf

$iResult = _DeviceIoControl($hDisk, $DFP_RECEIVE_DRIVE_DATA, _
                $tSCIP, DllStructGetSize($tSCIP), _
                $tSCOP, DllStructGetSize($tSCOP))
If $iResult = 0 Then
        Exit(ConsoleWrite("_DeviceIoControl fails, error code: " & @error & @CRLF))
EndIf

Dim $sSerialNum
For $i = 21 to 40 Step 2
        $sSerialNum &= DllStructGetData($tSCOP, "Buffer", $i + 1)
        $sSerialNum &= DllStructGetData($tSCOP, "Buffer", $i)
Next
$sSerialNum = StringReplace($sSerialNum, " ", "")
Msgbox(0, "", $sPhysDisk & "'s serial number: " & $sSerialNum)

$tSCIP = 0
$tSCOP = 0
$tQuery = 0
$tDescr = 0
_WinAPI_CloseHandle($hDisk)

Func _MakeCtrlCode($iDevType, $iFunction, $iMethod = 0, $iAccess = 0)
        Return bitOR(bitShift($iDevType,-16),bitShift($iAccess, -14),bitShift($iFunction, -2), $iMethod)
EndFunc        ;==>_MakeCtrlCode

Func _DeviceIoControl($hDevice, $iCtrlCode, $pIn, $iIn, $pOut, $iOut, $pOverlapped = 0)
        Local $iResult

        If IsDllStruct($pIn) Then $pIn = DllStructGetPtr($pIn)
        If IsDllStruct($pOut) Then $pOut = DllStructGetPtr($pOut)
        If IsDllStruct($pOverlapped) Then $pOverlapped = DllStructGetPtr($pOverLapped)
        $iResult = DllCall("Kernel32.dll", "int", "DeviceIoControl", "ptr", $hDevice, _
                        "dword", $iCtrlCode, "ptr", $pIn, "dword", $iIn, _
                        "ptr", $pOut, "dword", $iOut, "int*", 0, "ptr", $pOverlapped)
        Return SetError(_WinAPI_GetLastError(), $iResult[7], $iResult[0])
EndFunc        ;==>_DeviceIoControl