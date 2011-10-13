#include <LocalSecurityAuthority.au3>

#CS
修改进程加载的模块，使其有一个新的模块名称。
函数调用背景： 为了避免自己的某个dll模块被别人检测出来，有时候希望在自己加载一个dll之后，或者将dll注入到他人进程之后避免被检查出来。这就需要想办法抹掉这个dll的模块信息，使得EnumProcessModules等函数无法枚举到它。
注：用此功能修改的模块，不会被Tasklist.exe、Process Explorer、360等诸多进程工具检测出来，但不排除用直接读取内存的方法。此功能不会真地将模块替换掉，而是将显示出来的模块名称改为另一个名称。
纯属技术上的提高与交流，没兴趣写病毒木马之类的程序。

实现思路：
PEB - (Process Environment Block 进程环境块)
进程加载的模块信息存放在进程自身的PEB中，EnumProcessModules在枚举进程模块时，实际是进入了目标进程空间中的PEB中。一个进程的PEB结构如下：
        ubyte InheritedAddressSpace;
        ubyte ReadImageFileExecOptions;
        ubyte BeingDebugged;
        ubyte SpareBool;
        ptr Mutant;
        ptr ImageBaseAddress;
        ptr Ldr;
        ptr ProcessParameters;
其中的Ldr便是模块列表的地址了，指向在目标进程中真实的链表地址。Ldr指向的结构如下定义：
        uint Length;
        ulong Initialized;
        ulong SsHandle;
        MODULE_LIST
        ptr EntryInProcess
其中的MODULE_LIST 是一个结构（非指针），包含进程自身的路径，与加载的模块。定义如下：
        ptr LoadNext;
        ptr LoadPre;
        ptr MemNext;
        ptr MemPre;
        ptr IniNext;
        ptr IniPre;
        ptr DllBase;
        ptr EntryPoint;
        ulong SizeofImage;
        ushort FLength;
        ushort FMaxLength;
        ptr FDllName;
        ushort BLength;
        ushort BMaxLength;
        ptr BDllName;
        ulong Flags;
        ushort LoadCount;
        ushort TlsIndex
结构开头的6个成员都是指针类型，*Next指向模块链表中，当前节点的下一节点，*Pre指向当前节点的上一节点。FDllName、BDllName分别指向模块的全路径与模块文件名称。EnumProcessModules、GetModuleFileNameEx实际就是通过这两个成员中读取到模块名称的。只要修改FDllName、BDllName的数据，使其指向另外一个区域，便实现了模块名称的修改。

例如，进程a.exe加载了3个模块，分别为A、B、C，在模块链表中会显示如下：
a.exe ////////////////////////////////////////////
        uint Length;  - 此结构的长度，一般为40 bytes。
        ulong Initialized;
        ulong SsHandle;
        ptr LoadNext; 指向A模块的地址。
        ptr LoadPre; 指向最后一个模块C的地址。
        ptr MemNext;
        ptr MemPre;
        ptr IniNext;
        ptr IniPre;
        ptr EntryInProcess
Module A ////////////////////////////////////////
        ptr LoadNext; 指向B模块地址。
        ptr LoadPre; 指向a.exe 地址。
        ...
        ...
        ushort FLength; 模块全路径的长度。
        ushort FMaxLength; 模块全路径的长度，另加2个字节。
        ptr FDllName; ; 指向模块文件全路径。
        ushort BLength; 模块文件名称的长度。
        ushort BMaxLength; 模块文件名称的长度，另加2字节。
        ptr BDllName; 指向模块文件名称。
        ulong Flags;
        ...
        ...
Module B ////////////////////////////////////////
        ptr LoadNext; 指向C模块地址。
        ptr LoadPre; 指向A模块 地址。
        ...
        ...
        ushort FLength; 模块全路径的长度。
        ushort FMaxLength; 模块全路径的长度，另加2个字节。
        ptr FDllName; ; 指向模块文件全路径。
        ushort BLength; 模块文件名称的长度。
        ushort BMaxLength; 模块文件名称的长度，另加2字节。
        ptr BDllName; 指向模块文件名称。
        ulong Flags;
        ...
        ...

Module C ////////////////////////////////////////
        ptr LoadNext; 指向a.exe模块地址。
        ptr LoadPre; 指向B模块地址。
        ...
        ...
        ushort FLength; 模块全路径的长度。
        ushort FMaxLength; 模块全路径的长度，另加2个字节。
        ptr FDllName; ; 指向模块文件全路径。
        ushort BLength; 模块文件名称的长度。
        ushort BMaxLength; 模块文件名称的长度，另加2字节。
        ptr BDllName; 指向模块文件名称。
        ulong Flags;
        ...
        ...

通过如上链表可以看出，如果要更改A模块为一个其他文件，修改A模块区域中的FDllName、BDllName，使其指向另外一个区域即可，此区域包含新模块的文件路径与文件名。如果要隐藏B模块，修改A区域中的LoadNext，使其指向C，并修改C模块的LoadPre，使其指向A，即实现了B模块的隐藏（注，在实际测试中，如果隐藏了某个模块，此模块中的函数将不能正常工作。）
理解了此思路，实现起来就容易多了，问题回到原点，如何获取一个进程的PEB地址？NtQueryInformationProcess函数足矣，获取进程的各种信息，最终都会调用到这个函数，其中就包含了PEB所在自身空间中的位置。如果要修改其他进程的某个模块，必须进入其进程空间中，这就需要用到ReadProcessMemory、WriteProcessMemory实现。如果要修改AutoIt当前自身进程的，用DllStruct*函数族即可。为了可以修改其他进程的模块信息，这里使用ReadProcessMemory/WriteProcessMemory。

实现代码如下：
#CE



Const $tagPROCESS_BASIC_INFO = "dword ExitStatus;ptr PebBaseAddress;dword AffinityMask;dword BasePriority;ulong UniquePID;ulong ParentUniquePID"
Const $tagMODULE_LIST = "ptr LoadNext;ptr LoadPre;ptr MemNext;ptr MemPre;ptr IniNext;ptr IniPre"
Const $tagPEB_LDR = "uint Length;ulong Initialized;ulong SsHandle;" & $tagMODULE_LIST & ";ptr EntryInProcess"
Const $tagPEB = "ubyte InheritedAddressSpace;ubyte ReadImageFileExecOptions;ubyte BeingDebugged;ubyte SpareBool;ptr Mutant;ptr ImageBaseAddress;ptr Ldr;ptr ProcessParameters"
Const $tagLDR_DATA_ENTRY = $tagMODULE_LIST & ";ptr DllBase;ptr EntryPoint;ulong SizeofImage;ushort FLength;ushort FMaxLength;ptr FDllName;ushort BLength;ushort BMaxLength;ptr BDllName;ulong Flags;ushort LoadCount;ushort TlsIndex"

; 调用方法：将Notepad.exe加载的user32.dll替换为C:\Test.dll。
_ReplaceProcessModule("Notepad.exe", @SystemDir & "\user32.dll", "C:\Test.dll")

Func _ReplaceProcessModule($iProcessID, $sModuleBeReplaced, $sModuleReplaced)
        Local $hToken, $aPrivilege[1][2] = [[$SE_DEBUG_NAME, 2]]
        Local $pBufferW, $tBufferW, $pFirstEntry, $pEntry, $pBuffer, $tBuffer, $hProcess
        Local $pBasicInfo, $tBasicInfo, $pPeb, $tPeb, $pLdr, $tLdr, $sModule, $pModule, $tModule
        Local $iNameLength, $iPathLength, $sPath, $pEntrySelf, $tEntrySelf, $iSizeofBuffer, $pDllName

        $iProcessID = ProcessExists($iProcessID)
        If $iProcessID < 1 Then Return SetError(@error, 0, 0)

        ; 将自身进程提升至Debug权限。
        $hToken = _OpenProcessToken(-1)
        If Not _IsPrivilegeEnabled($hToken, $SE_DEBUG_NAME) Then
                _AdjustTokenPrivileges($hToken, $aPrivilege)
        EndIf
        _LsaCloseHandle($hToken)

        $hProcess = _OpenProcess($iProcessID) ; 获取进程句柄
        If $hProcess < 1 Then Return SetError(@error, 0, 0)

        ; 获取进程基本信息，其中包含了PEB地址。
        If _NtQueryInformationProcess($hProcess, 0, $pBasicInfo, 24) = 0 Then
                Return SetError(@error, _LsaCloseHandle($hProcess), 0)
        EndIf

        $tBasicInfo = DllStructCreate($tagPROCESS_BASIC_INFO, $pBasicInfo)
        $pPeb = DllStructGetData($tBasicInfo, "PebBaseAddress") ; 获取PEB地址。
        $pBuffer = _ReadProcessMemory($hProcess, $pPeb, 20) ; 通过PEB地址获取模块链表地址。
        $tPeb = DllStructCreate($tagPEB, $pBuffer)
        $pLdr = DllStructGetData($tPeb, "Ldr")
        _HeapFree($pBuffer)

        ; 获取第一个模块的地址。
        $pBuffer = _ReadProcessMemory($hProcess, $pLdr + 12, 24)
        $tLdr = DllStructCreate($tagMODULE_LIST, $pBuffer)
        $pEntry = DllStructGetData($tLdr, "LoadNext") 
        $pFirstEntry = DllStructGetData($tLdr, "LoadNext")
        _HeapFree($pBuffer)

        If Number($pFirstEntry) = 0 Then Return SetError(1, _LsaCloseHandle($hProcess), 0)

        ; 在目标进程中分配一个足够大的(1024字节足够)空间用于存放文件名。
        $pModule = _VirtualAllocEx($hProcess, 0, 1024)
        If Number($pModule) = 0 Then Return SetError(@error, _LsaCloseHandle($hProcess), 0)

        $tBuffer = DllStructCreate("wchar Module[512]")
        $pBuffer = DllStructGetPtr($tBuffer)
        DllStructSetData($tBuffer, "Module", $sModuleReplaced)

        ; 将用于替换的模块名称复制到目标空间内。
        If _WriteProcessMemory($hProcess, $pModule, $pBuffer, 1024) = 0 Then
                _AssignVariable($tBuffer, 0, 0, @error)
                Return SetError(@error, _LsaCloseHandle($hProcess), 0)
        EndIf
        _AssignVariable($tBuffer)


        ; 计算模块路径的长度，及文件名在文件路径中的偏移。
        $sPath = _PathFindFileName($sModuleReplaced)
        $iNameLength = StringLen($sPath) * 2
        $iPathLength = StringLen($sModuleReplaced) * 2
        $sPath = StringTrimRight($sModuleReplaced, StringLen($sPath))

        ; 将文件名长度、偏移、名称等信息写入自身空间中。
        $tBuffer = DllStructCreate("ushort;ushort;ptr;ushort;ushort;ptr")
        $pBuffer = DllStructGetPtr($tBuffer)

        DllStructSetData($tBuffer, 1, $iPathLength)
        DllStructSetData($tBuffer, 2, $iPathLength + 2)
        DllStructSetData($tBuffer, 3, $pModule) ; $pModule为目标进程中，模块$sModuleReplaced文件名的所在位置。
        DllStructSetData($tBuffer, 4, $iNameLength)
        DllStructSetData($tBuffer, 5, $iNameLength + 2)
        DllStructSetData($tBuffer, 6, $pModule + StringLen($sPath) * 2) ; $pModule + StringLen($sPath) * 2, 指向全路径中的文件名。

        ; 遍历目标进程的模块链表。 
        While ProcessExists($iProcessID)
                $pEntrySelf = _ReadProcessMemory($hProcess, $pEntry, 60)
                $tEntrySelf = DllStructCreate($tagLDR_DATA_ENTRY, $pEntrySelf)
                $pEntry = DllStructGetData($tEntrySelf, "LoadNext") ; 指向下一模块。
                If $pEntry = $pFirstEntry Then ExitLoop ; 判断是否循环完毕。


                ; 获取当前循环中枚举到的模块名称，不是目标模块则跳过。
                $iSizeofBuffer = DllStructGetData($tEntrySelf, "FMaxLength")
                $pDllName = DllStructGetData($tEntrySelf, "FDllName")
                $pBufferW = _ReadProcessMemory($hProcess, $pDllName, $iSizeofBuffer)
                $tBufferW = DllStructCreate("wchar DllName[" & $iSizeofBuffer & "]", $pBufferW)
                $sModule = DllStructGetData($tBufferW, "DllName")
                _AssignVariable($tBufferW, _HeapFree($pEntrySelf) * 0, _HeapFree($pBufferW), 1)
                If $sModule <> $sModuleBeReplaced Then ContinueLoop @error

                $pEntrySelf = _ReadProcessMemory($hProcess, $pEntry, 60)
                $tEntrySelf = DllStructCreate($tagLDR_DATA_ENTRY, $pEntrySelf)
                $pBufferW = DllStructGetData($tEntrySelf, "LoadPre") + 36

                ; 此时$pBufferW指向的结构（16字节）：
                ; ushort FLength;ushort FMaxLength;ptr FDllName;ushort BLength;ushort BMaxLength;ptr BDllName。

                ; 将自身空间$pBuffer中的数据写入目标空间$pBufferW处。
                _WriteProcessMemory($hProcess, $pBufferW, $pBuffer, 16)
                ExitLoop _AssignVariable($tEntrySelf, 0, 1, @extended, _HeapFree($pEntrySelf))
        WEnd
        _AssignVariable($tBuffer, 0, 0, @error, _LsaCloseHandle($hProcess))
        _AssignVariable($tBasicInfo, 0, 0, @error, _HeapFree($pBasicInfo))
        If @error = 16 Then Return 1
EndFunc        ;==>_ReplaceProcessModule

Func _AssignVariable(ByRef $vVariable, $vValue = 0, $vReturn = "", $iError = 0, $iExtended = 0)
        $vVariable = $vValue
        Return SetError($iError, $iExtended, $vReturn)
EndFunc        ;==>_AssignVariable

Func _PathFindFileName($sFilePath)
        Local $iResult
        $iResult = DllCall("Shlwapi.dll", "str", "PathFindFileName", "str", $sFilePath)
        Return $iResult[0]
EndFunc        ;==>_PathFindFileName

Func _VirtualAllocEx($hProcess, $pAddress, $iSize, $iType = 0x1000, $iProtect = 4)
        Local $iResult
        $iResult = DllCall("Kernel32.dll", "ptr", "VirtualAllocEx", "hWnd", $hProcess, _
                        "ptr", $pAddress, "dword", $iSize, "dword", $iType, "dword", $iProtect)
        Return SetError(_GetLastError(), 0, $iResult[0])
EndFunc        ;==>_VirtualAllocEx

Func _WriteProcessMemory($hProcess, $pBaseAddress, $pBuffer, $iSizeofBuffer = -1, $sBufferType = "ptr")
        Local $iResult

        If $iSizeofBuffer = -1 Then $pBuffer = _HeapSize($pBuffer)
        $iResult = DllCall("Kernel32.dll", "int", "WriteProcessMemory", "hWnd", $hProcess, _
                        "ptr", $pBaseAddress, $sBufferType, $pBuffer, _
                        "ulong", $iSizeofBuffer, "ulong*", 0)
        Return SetError(_GetLastError(), $iResult[5], $iResult[0])
EndFunc        ;==>_WriteProcessMemory

Func _ReadProcessMemory($hProcess, $pBaseAddress, $iBytesToRead)
        Local $pBuffer, $iResult

        $pBuffer = _HeapAlloc($iBytesToRead)
        $iResult = DllCall("Kernel32.dll", "int", "ReadProcessMemory", "hWnd", $hProcess, _
                        "ptr", $pBaseAddress, "ptr", $pBuffer, _
                        "ulong", $iBytesToRead, "ulong*", 0)
        If $iResult[0] = 0 Then _HeapFree($pBuffer)
        Return SetError(_GetLastError(), $iResult[5], $pBuffer)
EndFunc        ;==>_ReadProcessMemory

Func _NtQueryInformationProcess($hProcess, $iClass, ByRef $pBuffer, $iSizeofBuffer)
        Local $iResult

        $pBuffer = _HeapAlloc($iSizeofBuffer)
        $iResult = DllCall("Ntdll.dll", "dword", "NtQueryInformationProcess", "hWnd", $hProcess, _
                        "dword", $iClass, "ptr", $pBuffer, "ulong", $iSizeofBuffer, "ulong*", 0)
        If $iResult[0] Then _HeapFree($pBuffer)
        Return SetError(_LsaNtStatusToWinError($iResult[0]), 0, $iResult[0] = 0)
EndFunc        ;==>_NtQueryInformationProcess