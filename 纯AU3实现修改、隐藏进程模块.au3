#include <LocalSecurityAuthority.au3>

#CS
�޸Ľ��̼��ص�ģ�飬ʹ����һ���µ�ģ�����ơ�
�������ñ����� Ϊ�˱����Լ���ĳ��dllģ�鱻���˼���������ʱ��ϣ�����Լ�����һ��dll֮�󣬻��߽�dllע�뵽���˽���֮����ⱻ�������������Ҫ��취Ĩ�����dll��ģ����Ϣ��ʹ��EnumProcessModules�Ⱥ����޷�ö�ٵ�����
ע���ô˹����޸ĵ�ģ�飬���ᱻTasklist.exe��Process Explorer��360�������̹��߼������������ų���ֱ�Ӷ�ȡ�ڴ�ķ������˹��ܲ�����ؽ�ģ���滻�������ǽ���ʾ������ģ�����Ƹ�Ϊ��һ�����ơ�
���������ϵ�����뽻����û��Ȥд����ľ��֮��ĳ���

ʵ��˼·��
PEB - (Process Environment Block ���̻�����)
���̼��ص�ģ����Ϣ����ڽ��������PEB�У�EnumProcessModules��ö�ٽ���ģ��ʱ��ʵ���ǽ�����Ŀ����̿ռ��е�PEB�С�һ�����̵�PEB�ṹ���£�
        ubyte InheritedAddressSpace;
        ubyte ReadImageFileExecOptions;
        ubyte BeingDebugged;
        ubyte SpareBool;
        ptr Mutant;
        ptr ImageBaseAddress;
        ptr Ldr;
        ptr ProcessParameters;
���е�Ldr����ģ���б�ĵ�ַ�ˣ�ָ����Ŀ���������ʵ�������ַ��Ldrָ��Ľṹ���¶��壺
        uint Length;
        ulong Initialized;
        ulong SsHandle;
        MODULE_LIST
        ptr EntryInProcess
���е�MODULE_LIST ��һ���ṹ����ָ�룩���������������·��������ص�ģ�顣�������£�
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
�ṹ��ͷ��6����Ա����ָ�����ͣ�*Nextָ��ģ�������У���ǰ�ڵ����һ�ڵ㣬*Preָ��ǰ�ڵ����һ�ڵ㡣FDllName��BDllName�ֱ�ָ��ģ���ȫ·����ģ���ļ����ơ�EnumProcessModules��GetModuleFileNameExʵ�ʾ���ͨ����������Ա�ж�ȡ��ģ�����Ƶġ�ֻҪ�޸�FDllName��BDllName�����ݣ�ʹ��ָ������һ�����򣬱�ʵ����ģ�����Ƶ��޸ġ�

���磬����a.exe������3��ģ�飬�ֱ�ΪA��B��C����ģ�������л���ʾ���£�
a.exe ////////////////////////////////////////////
        uint Length;  - �˽ṹ�ĳ��ȣ�һ��Ϊ40 bytes��
        ulong Initialized;
        ulong SsHandle;
        ptr LoadNext; ָ��Aģ��ĵ�ַ��
        ptr LoadPre; ָ�����һ��ģ��C�ĵ�ַ��
        ptr MemNext;
        ptr MemPre;
        ptr IniNext;
        ptr IniPre;
        ptr EntryInProcess
Module A ////////////////////////////////////////
        ptr LoadNext; ָ��Bģ���ַ��
        ptr LoadPre; ָ��a.exe ��ַ��
        ...
        ...
        ushort FLength; ģ��ȫ·���ĳ��ȡ�
        ushort FMaxLength; ģ��ȫ·���ĳ��ȣ����2���ֽڡ�
        ptr FDllName; ; ָ��ģ���ļ�ȫ·����
        ushort BLength; ģ���ļ����Ƶĳ��ȡ�
        ushort BMaxLength; ģ���ļ����Ƶĳ��ȣ����2�ֽڡ�
        ptr BDllName; ָ��ģ���ļ����ơ�
        ulong Flags;
        ...
        ...
Module B ////////////////////////////////////////
        ptr LoadNext; ָ��Cģ���ַ��
        ptr LoadPre; ָ��Aģ�� ��ַ��
        ...
        ...
        ushort FLength; ģ��ȫ·���ĳ��ȡ�
        ushort FMaxLength; ģ��ȫ·���ĳ��ȣ����2���ֽڡ�
        ptr FDllName; ; ָ��ģ���ļ�ȫ·����
        ushort BLength; ģ���ļ����Ƶĳ��ȡ�
        ushort BMaxLength; ģ���ļ����Ƶĳ��ȣ����2�ֽڡ�
        ptr BDllName; ָ��ģ���ļ����ơ�
        ulong Flags;
        ...
        ...

Module C ////////////////////////////////////////
        ptr LoadNext; ָ��a.exeģ���ַ��
        ptr LoadPre; ָ��Bģ���ַ��
        ...
        ...
        ushort FLength; ģ��ȫ·���ĳ��ȡ�
        ushort FMaxLength; ģ��ȫ·���ĳ��ȣ����2���ֽڡ�
        ptr FDllName; ; ָ��ģ���ļ�ȫ·����
        ushort BLength; ģ���ļ����Ƶĳ��ȡ�
        ushort BMaxLength; ģ���ļ����Ƶĳ��ȣ����2�ֽڡ�
        ptr BDllName; ָ��ģ���ļ����ơ�
        ulong Flags;
        ...
        ...

ͨ������������Կ��������Ҫ����Aģ��Ϊһ�������ļ����޸�Aģ�������е�FDllName��BDllName��ʹ��ָ������һ�����򼴿ɣ������������ģ����ļ�·�����ļ��������Ҫ����Bģ�飬�޸�A�����е�LoadNext��ʹ��ָ��C�����޸�Cģ���LoadPre��ʹ��ָ��A����ʵ����Bģ������أ�ע����ʵ�ʲ����У����������ĳ��ģ�飬��ģ���еĺ���������������������
����˴�˼·��ʵ�����������׶��ˣ�����ص�ԭ�㣬��λ�ȡһ�����̵�PEB��ַ��NtQueryInformationProcess�������ӣ���ȡ���̵ĸ�����Ϣ�����ն�����õ�������������оͰ�����PEB��������ռ��е�λ�á����Ҫ�޸��������̵�ĳ��ģ�飬�����������̿ռ��У������Ҫ�õ�ReadProcessMemory��WriteProcessMemoryʵ�֡����Ҫ�޸�AutoIt��ǰ������̵ģ���DllStruct*�����弴�ɡ�Ϊ�˿����޸��������̵�ģ����Ϣ������ʹ��ReadProcessMemory/WriteProcessMemory��

ʵ�ִ������£�
#CE



Const $tagPROCESS_BASIC_INFO = "dword ExitStatus;ptr PebBaseAddress;dword AffinityMask;dword BasePriority;ulong UniquePID;ulong ParentUniquePID"
Const $tagMODULE_LIST = "ptr LoadNext;ptr LoadPre;ptr MemNext;ptr MemPre;ptr IniNext;ptr IniPre"
Const $tagPEB_LDR = "uint Length;ulong Initialized;ulong SsHandle;" & $tagMODULE_LIST & ";ptr EntryInProcess"
Const $tagPEB = "ubyte InheritedAddressSpace;ubyte ReadImageFileExecOptions;ubyte BeingDebugged;ubyte SpareBool;ptr Mutant;ptr ImageBaseAddress;ptr Ldr;ptr ProcessParameters"
Const $tagLDR_DATA_ENTRY = $tagMODULE_LIST & ";ptr DllBase;ptr EntryPoint;ulong SizeofImage;ushort FLength;ushort FMaxLength;ptr FDllName;ushort BLength;ushort BMaxLength;ptr BDllName;ulong Flags;ushort LoadCount;ushort TlsIndex"

; ���÷�������Notepad.exe���ص�user32.dll�滻ΪC:\Test.dll��
_ReplaceProcessModule("Notepad.exe", @SystemDir & "\user32.dll", "C:\Test.dll")

Func _ReplaceProcessModule($iProcessID, $sModuleBeReplaced, $sModuleReplaced)
        Local $hToken, $aPrivilege[1][2] = [[$SE_DEBUG_NAME, 2]]
        Local $pBufferW, $tBufferW, $pFirstEntry, $pEntry, $pBuffer, $tBuffer, $hProcess
        Local $pBasicInfo, $tBasicInfo, $pPeb, $tPeb, $pLdr, $tLdr, $sModule, $pModule, $tModule
        Local $iNameLength, $iPathLength, $sPath, $pEntrySelf, $tEntrySelf, $iSizeofBuffer, $pDllName

        $iProcessID = ProcessExists($iProcessID)
        If $iProcessID < 1 Then Return SetError(@error, 0, 0)

        ; ���������������DebugȨ�ޡ�
        $hToken = _OpenProcessToken(-1)
        If Not _IsPrivilegeEnabled($hToken, $SE_DEBUG_NAME) Then
                _AdjustTokenPrivileges($hToken, $aPrivilege)
        EndIf
        _LsaCloseHandle($hToken)

        $hProcess = _OpenProcess($iProcessID) ; ��ȡ���̾��
        If $hProcess < 1 Then Return SetError(@error, 0, 0)

        ; ��ȡ���̻�����Ϣ�����а�����PEB��ַ��
        If _NtQueryInformationProcess($hProcess, 0, $pBasicInfo, 24) = 0 Then
                Return SetError(@error, _LsaCloseHandle($hProcess), 0)
        EndIf

        $tBasicInfo = DllStructCreate($tagPROCESS_BASIC_INFO, $pBasicInfo)
        $pPeb = DllStructGetData($tBasicInfo, "PebBaseAddress") ; ��ȡPEB��ַ��
        $pBuffer = _ReadProcessMemory($hProcess, $pPeb, 20) ; ͨ��PEB��ַ��ȡģ�������ַ��
        $tPeb = DllStructCreate($tagPEB, $pBuffer)
        $pLdr = DllStructGetData($tPeb, "Ldr")
        _HeapFree($pBuffer)

        ; ��ȡ��һ��ģ��ĵ�ַ��
        $pBuffer = _ReadProcessMemory($hProcess, $pLdr + 12, 24)
        $tLdr = DllStructCreate($tagMODULE_LIST, $pBuffer)
        $pEntry = DllStructGetData($tLdr, "LoadNext") 
        $pFirstEntry = DllStructGetData($tLdr, "LoadNext")
        _HeapFree($pBuffer)

        If Number($pFirstEntry) = 0 Then Return SetError(1, _LsaCloseHandle($hProcess), 0)

        ; ��Ŀ������з���һ���㹻���(1024�ֽ��㹻)�ռ����ڴ���ļ�����
        $pModule = _VirtualAllocEx($hProcess, 0, 1024)
        If Number($pModule) = 0 Then Return SetError(@error, _LsaCloseHandle($hProcess), 0)

        $tBuffer = DllStructCreate("wchar Module[512]")
        $pBuffer = DllStructGetPtr($tBuffer)
        DllStructSetData($tBuffer, "Module", $sModuleReplaced)

        ; �������滻��ģ�����Ƹ��Ƶ�Ŀ��ռ��ڡ�
        If _WriteProcessMemory($hProcess, $pModule, $pBuffer, 1024) = 0 Then
                _AssignVariable($tBuffer, 0, 0, @error)
                Return SetError(@error, _LsaCloseHandle($hProcess), 0)
        EndIf
        _AssignVariable($tBuffer)


        ; ����ģ��·���ĳ��ȣ����ļ������ļ�·���е�ƫ�ơ�
        $sPath = _PathFindFileName($sModuleReplaced)
        $iNameLength = StringLen($sPath) * 2
        $iPathLength = StringLen($sModuleReplaced) * 2
        $sPath = StringTrimRight($sModuleReplaced, StringLen($sPath))

        ; ���ļ������ȡ�ƫ�ơ����Ƶ���Ϣд������ռ��С�
        $tBuffer = DllStructCreate("ushort;ushort;ptr;ushort;ushort;ptr")
        $pBuffer = DllStructGetPtr($tBuffer)

        DllStructSetData($tBuffer, 1, $iPathLength)
        DllStructSetData($tBuffer, 2, $iPathLength + 2)
        DllStructSetData($tBuffer, 3, $pModule) ; $pModuleΪĿ������У�ģ��$sModuleReplaced�ļ���������λ�á�
        DllStructSetData($tBuffer, 4, $iNameLength)
        DllStructSetData($tBuffer, 5, $iNameLength + 2)
        DllStructSetData($tBuffer, 6, $pModule + StringLen($sPath) * 2) ; $pModule + StringLen($sPath) * 2, ָ��ȫ·���е��ļ�����

        ; ����Ŀ����̵�ģ������ 
        While ProcessExists($iProcessID)
                $pEntrySelf = _ReadProcessMemory($hProcess, $pEntry, 60)
                $tEntrySelf = DllStructCreate($tagLDR_DATA_ENTRY, $pEntrySelf)
                $pEntry = DllStructGetData($tEntrySelf, "LoadNext") ; ָ����һģ�顣
                If $pEntry = $pFirstEntry Then ExitLoop ; �ж��Ƿ�ѭ����ϡ�


                ; ��ȡ��ǰѭ����ö�ٵ���ģ�����ƣ�����Ŀ��ģ����������
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

                ; ��ʱ$pBufferWָ��Ľṹ��16�ֽڣ���
                ; ushort FLength;ushort FMaxLength;ptr FDllName;ushort BLength;ushort BMaxLength;ptr BDllName��

                ; ������ռ�$pBuffer�е�����д��Ŀ��ռ�$pBufferW����
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