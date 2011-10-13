
Global $sModule = @SystemDir & "\ping.exe"

Global $hModule = FileOpen($sModule, 16)
Global $bBinary = FileRead($hModule)
FileClose($hModule)


Global $iNewPID = _RunExeFromMemory($bBinary)

If @error Then
	MsgBox(48, 'Error occurred', "Error number: " & @error)
Else
	ConsoleWrite($iNewPID & @CRLF)
EndIf




Func _RunExeFromMemory($bBinaryImage, $iCompressed = 0)

	#Region 1. PREPROCESSING PASSED
	Local $tInput = DllStructCreate("byte[" & BinaryLen($bBinaryImage) & "]")
	DllStructSetData($tInput, 1, $bBinaryImage)

	Local $pPointer

	If $iCompressed Then
		; Buffer for decompressed data
		Local $tBuffer = DllStructCreate("byte[" & 16 * DllStructGetSize($tInput) & "]") ; oversizing it

		; Decompression follows:
		Local $aCall = DllCall("ntdll.dll", "int", "RtlDecompressBuffer", _
				"ushort", 2, _
				"ptr", DllStructGetPtr($tBuffer), _
				"dword", DllStructGetSize($tBuffer), _
				"ptr", DllStructGetPtr($tInput), _
				"dword", DllStructGetSize($tInput), _
				"dword*", 0)

		If @error Or $aCall[0] Then ; If any troubles try original data anyway
			$pPointer = DllStructGetPtr($tInput)
		Else
			$pPointer = DllStructGetPtr($tBuffer)
		EndIf
	Else
		; Not compressed
		$pPointer = DllStructGetPtr($tInput)
	EndIf

	#Region 2. CREATING NEW PROCESS
	; STARTUPINFO structure (actually all that really matters is allocaed space)
	Local $tSTARTUPINFO = DllStructCreate("dword  cbSize;" & _
			"ptr Reserved;" & _
			"ptr Desktop;" & _
			"ptr Title;" & _
			"dword X;" & _
			"dword Y;" & _
			"dword XSize;" & _
			"dword YSize;" & _
			"dword XCountChars;" & _
			"dword YCountChars;" & _
			"dword FillAttribute;" & _
			"dword Flags;" & _
			"ushort ShowWindow;" & _
			"ushort Reserved2;" & _
			"ptr Reserved2;" & _
			"ptr hStdInput;" & _
			"ptr hStdOutput;" & _
			"ptr hStdError")

	; This is much important. This structure will hold some very important data.
	Local $tPROCESS_INFORMATION = DllStructCreate("ptr Process;" & _
			"ptr Thread;" & _
			"dword ProcessId;" & _
			"dword ThreadId")

	; Create new process
	$aCall = DllCall("kernel32.dll", "int", "CreateProcessW", _
			"wstr", @AutoItExe, _
			"wstr", " google.com", _ ; <-- This!!!
			"ptr", 0, _
			"ptr", 0, _
			"int", 0, _
			"dword", 4, _ ; CREATE_SUSPENDED ; <- this is essential
			"ptr", 0, _
			"ptr", 0, _
			"ptr", DllStructGetPtr($tSTARTUPINFO), _
			"ptr", DllStructGetPtr($tPROCESS_INFORMATION))

	If @error Or Not $aCall[0] Then
		Return SetError(2, 0, 0) ; CreateProcess function or call to it failed
	EndIf

	; New process and thread handles:
	Local $hProcess = DllStructGetData($tPROCESS_INFORMATION, "Process")
	Local $hThread = DllStructGetData($tPROCESS_INFORMATION, "Thread")

	#Region 3. FILL CONTEXT STRUCTURE
	; CONTEXT structure is what's really important here. It's very 'misterious'
	Local $tCONTEXT = DllStructCreate("dword ContextFlags;" & _
			"dword Dr0;" & _
			"dword Dr1;" & _
			"dword Dr2;" & _
			"dword Dr3;" & _
			"dword Dr6;" & _
			"dword Dr7;" & _
			"dword ControlWord;" & _
			"dword StatusWord;" & _
			"dword TagWord;" & _
			"dword ErrorOffset;" & _
			"dword ErrorSelector;" & _
			"dword DataOffset;" & _
			"dword DataSelector;" & _
			"byte RegisterArea[80];" & _
			"dword Cr0NpxState;" & _
			"dword SegGs;" & _
			"dword SegFs;" & _
			"dword SegEs;" & _
			"dword SegDs;" & _
			"dword Edi;" & _
			"dword Esi;" & _
			"dword Ebx;" & _ ; this is pointer to another structure whose third element will be altered
			"dword Edx;" & _
			"dword Ecx;" & _
			"dword Eax;" & _ ; another manipulation point (will set address of entry point here)
			"dword Ebp;" & _
			"dword Eip;" & _
			"dword SegCs;" & _
			"dword EFlags;" & _
			"dword Esp;" & _
			"dword SegS")

	DllStructSetData($tCONTEXT, "ContextFlags", 0x10002) ; CONTEXT_INTEGER

	; Fill tCONTEXT structure:
	$aCall = DllCall("kernel32.dll", "int", "GetThreadContext", _
			"ptr", $hThread, _
			"ptr", DllStructGetPtr($tCONTEXT))

	If @error Or Not $aCall[0] Then
		DllCall("kernel32.dll", "int", "TerminateProcess", "ptr", $hProcess, "dword", 0)
		Return SetError(3, 0, 0) ; GetThreadContext function or call to it failed
	EndIf

	#Region 4. READ PE-FORMAT
	; Start processing passed binary data. 'Reading' PE format follows.
	Local $tIMAGE_DOS_HEADER = DllStructCreate("char Magic[2];" & _
			"ushort BytesOnLastPage;" & _
			"ushort Pages;" & _
			"ushort Relocations;" & _
			"ushort SizeofHeader;" & _
			"ushort MinimumExtra;" & _
			"ushort MaximumExtra;" & _
			"ushort SS;" & _
			"ushort SP;" & _
			"ushort Checksum;" & _
			"ushort IP;" & _
			"ushort CS;" & _
			"ushort Relocation;" & _
			"ushort Overlay;" & _
			"char Reserved[8];" & _
			"ushort OEMIdentifier;" & _
			"ushort OEMInformation;" & _
			"char Reserved2[20];" & _
			"dword AddressOfNewExeHeader", _
			$pPointer)

	; Move pointer
	$pPointer += DllStructGetData($tIMAGE_DOS_HEADER, "AddressOfNewExeHeader") ; move to PE file header

	Local $sMagic = DllStructGetData($tIMAGE_DOS_HEADER, "Magic")

	; Check if it's valid format
	If Not ($sMagic == "MZ") Then
		DllCall("kernel32.dll", "int", "TerminateProcess", "ptr", $hProcess, "dword", 0)
		Return SetError(4, 0, 0) ; MS-DOS header missing. Btw 'MZ' are the initials of Mark Zbikowski in case you didn't know.
	EndIf

	Local $tIMAGE_NT_SIGNATURE = DllStructCreate("dword Signature", $pPointer)

	; Move pointer
	$pPointer += 4 ; size of $tIMAGE_NT_SIGNATURE structure

	; Check signature
	If DllStructGetData($tIMAGE_NT_SIGNATURE, "Signature") <> 17744 Then ; IMAGE_NT_SIGNATURE
		DllCall("kernel32.dll", "int", "TerminateProcess", "ptr", $hProcess, "dword", 0)
		Return SetError(5, 0, 0) ; wrong signature. For PE image should be "PE\0\0" or 17744 dword.
	EndIf

	Local $tIMAGE_FILE_HEADER = DllStructCreate("ushort Machine;" & _
			"ushort NumberOfSections;" & _
			"dword TimeDateStamp;" & _
			"dword PointerToSymbolTable;" & _
			"dword NumberOfSymbols;" & _
			"ushort SizeOfOptionalHeader;" & _
			"ushort Characteristics", _
			$pPointer)

	; Get number of sections
	Local $iNumberOfSections = DllStructGetData($tIMAGE_FILE_HEADER, "NumberOfSections")

	; Move pointer
	$pPointer += 20 ; size of $tIMAGE_FILE_HEADER structure

	Local $tIMAGE_OPTIONAL_HEADER = DllStructCreate("ushort Magic;" & _
			"ubyte MajorLinkerVersion;" & _
			"ubyte MinorLinkerVersion;" & _
			"dword SizeOfCode;" & _
			"dword SizeOfInitializedData;" & _
			"dword SizeOfUninitializedData;" & _
			"dword AddressOfEntryPoint;" & _
			"dword BaseOfCode;" & _
			"dword BaseOfData;" & _
			"dword ImageBase;" & _
			"dword SectionAlignment;" & _
			"dword FileAlignment;" & _
			"ushort MajorOperatingSystemVersion;" & _
			"ushort MinorOperatingSystemVersion;" & _
			"ushort MajorImageVersion;" & _
			"ushort MinorImageVersion;" & _
			"ushort MajorSubsystemVersion;" & _
			"ushort MinorSubsystemVersion;" & _
			"dword Win32VersionValue;" & _
			"dword SizeOfImage;" & _
			"dword SizeOfHeaders;" & _
			"dword CheckSum;" & _
			"ushort Subsystem;" & _
			"ushort DllCharacteristics;" & _
			"dword SizeOfStackReserve;" & _
			"dword SizeOfStackCommit;" & _
			"dword SizeOfHeapReserve;" & _
			"dword SizeOfHeapCommit;" & _
			"dword LoaderFlags;" & _
			"dword NumberOfRvaAndSizes", _
			$pPointer)

	; Move pointer
	$pPointer += 96 ; size of $tIMAGE_OPTIONAL_HEADER

	Local $iMagic = DllStructGetData($tIMAGE_OPTIONAL_HEADER, "Magic")

	; Check if it's 32-bit application
	If $iMagic <> 267 Then
		DllCall("kernel32.dll", "int", "TerminateProcess", "ptr", $hProcess, "dword", 0)
		Return SetError(6, 0, 0) ; not 32-bit application. Structures (and sizes) are for 32-bit apps.
	EndIf

	; Extract entry point address
	Local $iEntryPointNEW = DllStructGetData($tIMAGE_OPTIONAL_HEADER, "AddressOfEntryPoint") ; if loaded binary image would start executing at this address

	; Move pointer
	$pPointer += 128 ; size of the structures before IMAGE_SECTION_HEADER (16 of them - find PE specification if you are interested).

	Local $pOptionalHeaderImageBaseNEW = DllStructGetData($tIMAGE_OPTIONAL_HEADER, "ImageBase") ; address of the first byte of the image when it's loaded in memory
	Local $iOptionalHeaderSizeOfImageNEW = DllStructGetData($tIMAGE_OPTIONAL_HEADER, "SizeOfImage") ; the size of the image including all headers

	#Region 5. GET AND THEN CHANGE BASE ADDRESS
	; Read base address
	$aCall = DllCall("kernel32.dll", "int", "ReadProcessMemory", _
			"ptr", $hProcess, _
			"ptr", DllStructGetData($tCONTEXT, "Ebx") + 8, _
			"ptr*", 0, _
			"dword", 4, _
			"dword*", 0)

	If @error Or Not $aCall[0] Then
		DllCall("kernel32.dll", "int", "TerminateProcess", "ptr", $hProcess, "dword", 0)
		Return SetError(7, 0, 0) ; ReadProcessMemory function or call to it failed while reading base address of the process
	EndIf

	Local $hBaseAddress = $aCall[3]

	; Write new base address
	$aCall = DllCall("kernel32.dll", "int", "WriteProcessMemory", _
			"ptr", $hProcess, _
			"ptr", DllStructGetData($tCONTEXT, "Ebx") + 8, _
			"ptr*", $pOptionalHeaderImageBaseNEW, _
			"dword", 4, _
			"dword*", 0)

	If @error Or Not $aCall[0] Then
		DllCall("kernel32.dll", "int", "TerminateProcess", "ptr", $hProcess, "dword", 0)
		Return SetError(8, 0, 0) ; WriteProcessMemory function or call to it failed while writting new base address
	EndIf

	#Region 6. CLEAR EVERYTHING THAT THIS NEW PROCESS HAVE MAPPED
	; Clear old data.
	$aCall = DllCall("ntdll.dll", "int", "NtUnmapViewOfSection", _
			"ptr", $hProcess, _
			"ptr", $hBaseAddress)

	If @error Or $aCall[0] Then
		DllCall("kernel32.dll", "int", "TerminateProcess", "ptr", $hProcess, "dword", 0)
		Return SetError(9, 0, 0) ; NtUnmapViewOfSection function or call to it failed
	EndIf

	#Region 7. ALLOCATE 'NEW' MEMORY SPACE
	; Allocate proper size of memory at the proper place.
	$aCall = DllCall("kernel32.dll", "ptr", "VirtualAllocEx", _
			"ptr", $hProcess, _
			"ptr", $pOptionalHeaderImageBaseNEW, _
			"dword", $iOptionalHeaderSizeOfImageNEW, _
			"dword", 12288, _ ; MEM_COMMIT|MEM_RESERVE
			"dword", 64) ; PAGE_EXECUTE_READWRITE

	If @error Or Not $aCall[0] Then
		DllCall("kernel32.dll", "int", "TerminateProcess", "ptr", $hProcess, "dword", 0)
		Return SetError(10, 0, 0) ; VirtualAllocEx function or call to it failed
	EndIf

	Local $pRemoteCode = $aCall[0] ; from now on this is zero-point

	#Region 8. GET AND WRITE NEW PE-HEADERS
	Local $pHEADERS_NEW = DllStructGetPtr($tIMAGE_DOS_HEADER) ; starting address of binary image headers
	Local $iOptionalHeaderSizeOfHeadersNEW = DllStructGetData($tIMAGE_OPTIONAL_HEADER, "SizeOfHeaders") ; the size of the MS-DOS stub, the PE header, and the section headers

	; Write NEW headers
	$aCall = DllCall("kernel32.dll", "int", "WriteProcessMemory", _
			"ptr", $hProcess, _
			"ptr", $pRemoteCode, _
			"ptr", $pHEADERS_NEW, _
			"dword", $iOptionalHeaderSizeOfHeadersNEW, _
			"dword*", 0)

	If @error Or Not $aCall[0] Then
		DllCall("kernel32.dll", "int", "TerminateProcess", "ptr", $hProcess, "dword", 0)
		Return SetError(11, 0, 0) ; WriteProcessMemory function or call to it while writting new PE headers failed
	EndIf

	#Region 9. WRITE SECTIONS
	; Dealing with sections. Will write them too as they hold all needed data that PE loader reads
	Local $tIMAGE_SECTION_HEADER
	Local $iSizeOfRawData, $pPointerToRawData
	Local $iVirtualAddress

	For $i = 1 To $iNumberOfSections

		$tIMAGE_SECTION_HEADER = DllStructCreate("char Name[8];" & _
				"dword UnionOfVirtualSizeAndPhysicalAddress;" & _
				"dword VirtualAddress;" & _
				"dword SizeOfRawData;" & _
				"dword PointerToRawData;" & _
				"dword PointerToRelocations;" & _
				"dword PointerToLinenumbers;" & _
				"ushort NumberOfRelocations;" & _
				"ushort NumberOfLinenumbers;" & _
				"dword Characteristics", _
				$pPointer)

		$iSizeOfRawData = DllStructGetData($tIMAGE_SECTION_HEADER, "SizeOfRawData")
		$pPointerToRawData = DllStructGetPtr($tIMAGE_DOS_HEADER) + DllStructGetData($tIMAGE_SECTION_HEADER, "PointerToRawData")
		$iVirtualAddress = DllStructGetData($tIMAGE_SECTION_HEADER, "VirtualAddress")

		; If there is data to write, write it where is should be written
		If $iSizeOfRawData Then

			$aCall = DllCall("kernel32.dll", "int", "WriteProcessMemory", _
					"ptr", $hProcess, _
					"ptr", $pRemoteCode + $iVirtualAddress, _
					"ptr", $pPointerToRawData, _
					"dword", $iSizeOfRawData, _
					"dword*", 0)

			If @error Or Not $aCall[0] Then
				DllCall("kernel32.dll", "int", "TerminateProcess", "ptr", $hProcess, "dword", 0)
				Return SetError(12, $i, 0) ; WriteProcessMemory function or call to it while writting new sections failed
			EndIf

		EndIf

		; Move pointer
		$pPointer += 40 ; size of $tIMAGE_SECTION_HEADER structure

	Next

	#Region 10. NEW ENTRY POINT
	; Entry point manipulation
	DllStructSetData($tCONTEXT, "Eax", $pRemoteCode + $iEntryPointNEW) ; $iEntryPointNEW was relative address

	#Region 11. SET NEW CONTEXT
	; New context:
	$aCall = DllCall("kernel32.dll", "int", "SetThreadContext", _
			"ptr", $hThread, _
			"ptr", DllStructGetPtr($tCONTEXT))

	If @error Or Not $aCall[0] Then
		DllCall("kernel32.dll", "int", "TerminateProcess", "ptr", $hProcess, "dword", 0)
		Return SetError(13, 0, 0) ; SetThreadContext function or call to it failed
	EndIf

	#Region 12. RESUME THREAD
	; And that's it!. Continue execution
	$aCall = DllCall("kernel32.dll", "int", "ResumeThread", "ptr", $hThread)

	If @error Or $aCall[0] = -1 Then
		DllCall("kernel32.dll", "int", "TerminateProcess", "ptr", $hProcess, "dword", 0)
		Return SetError(14, 0, 0) ; ResumeThread function or call to it failed
	EndIf

	#Region 13. RETURN SUCCESS
	; All went well. Return, for example, new PID:
	Return DllStructGetData($tPROCESS_INFORMATION, "ProcessId")

EndFunc   ;==>_RunExeFromMemory




