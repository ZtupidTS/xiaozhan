#include-once
#include <LocalSecurityAuthority.au3>

; #### HEADER INFORMATION ####
; ===============================================================================
; Title	: PnP Configuration Manager
; Description	: Plug and Play (PnP) Configuration Manager that are used by class installers, co-installers, or device installation applications.
; Functions	: 1 - Scaning device changes on a local or a remote system.
;		: 2 - Disable and enable an existing hardware device, on local or remote system.
;		: 3 - Install and remove device setup classes, devices and device interfaces.
;		: 4 - Create or remove resource descriptor (or get / set information) for a device instance.
;		: 5 - List the devices (or device interfaces) present in local or remote system.
;		: 6 - Read or write device interfaces.
;		: 7 - Else more ...
; Requirements	: AutoIt Version	: AutoIt v3 ++
;		: AutoIt Libraries	: Array.au3, LocalSecurityAuthority.au3
;		: Modules		: Advapi32.dll, Cfgmgr32.dll, Kernel32.dll, Newdev.dll, Setupapi.dll
;		: Minimum client	: Windows 2000 Professional
; Author	: Pusofalse @ 11/20/2009, kanxinqi@yahoo.com.cn
; ==============================================================================

; #### General size definitions ####
; ==============================================================================
Const $MAX_DEVICE_ID_LEN = 200
Const $MAX_DEVNODE_ID_LEN = $MAX_DEVICE_ID_LEN

Const $MAX_GUID_STRING_LEN = 39
Const $MAX_CLASS_NAME_LEN = 32
Const $MAX_PROFILE_LEN = 80

Const $MAX_CONFIG_VALUE = 9999
Const $MAX_INSTANCE_VALUE = 9999

Const $MAX_MEM_REGISTERS = 9 ; Win95 compatibility--not applicable to 32-bit ConfigMgr
Const $MAX_IO_PORTS = 20 ; Win95 compatibility--not applicable to 32-bit ConfigMgr
Const $MAX_IRQS = 7 ; Win95 compatibility--not applicable to 32-bit ConfigMgr
Const $MAX_DMA_CHANNELS = 7 ; Win95 compatibility--not applicable to 32-bit ConfigMgr

Const $CONFIGMG_VERSION = 0x0400
; ==============================================================================

; #### Device Node Status Constants ####
; ==============================================================================
Const $DN_ROOT_ENUMERATED = 0x00000001   ;  Was enumerated by ROOT
Const $DN_DRIVER_LOADED   = 0x00000002   ;  Has Register_Device_Driver
Const $DN_ENUM_LOADED = 0x00000004   ;  Has Register_Enumerator
Const $DN_STARTED = 0x00000008   ;  Is currently configured
Const $DN_MANUAL  = 0x00000010   ;  Manually installed
Const $DN_NEED_TO_ENUM    = 0x00000020   ;  May need reenumeration
Const $DN_NOT_FIRST_TIME  = 0x00000040   ;  Has received a config
Const $DN_HARDWARE_ENUM   = 0x00000080   ;  Enum generates hardware ID
Const $DN_LIAR    = 0x00000100   ;  Lied about can reconfig once
Const $DN_NEED_RESTART = $DN_LIAR	; Need a system restart
Const $DN_HAS_MARK    = 0x00000200   ;  Not CM_Create_DevInst lately
Const $DN_HAS_PROBLEM = 0x00000400   ;  Need device installer
Const $DN_FILTERED    = 0x00000800   ;  Is filtered
Const $DN_MOVED   = 0x00001000   ;  Has been moved
Const $DN_DISABLEABLE = 0x00002000   ;  Can be rebalanced
Const $DN_REMOVABLE   = 0x00004000   ;  Can be removed
Const $DN_PRIVATE_PROBLEM = 0x00008000   ;  Has a private problem
Const $DN_MF_PARENT   = 0x00010000   ;  Multi function parent
Const $DN_MF_CHILD    = 0x00020000   ;  Multi function child
Const $DN_WILL_BE_REMOVED = 0x00040000   ;  DevInst is being removed
Const $DN_NOT_FIRST_TIMEE  = 0x00080000  ;   Has received a config enumerate
Const $DN_STOP_FREE_RES    = 0x00100000  ;   When child is stopped, free resources
Const $DN_REBAL_CANDIDATE  = 0x00200000  ;   Don't skip during rebalance
Const $DN_BAD_PARTIAL      = 0x00400000  ;   This devnode's log_confs do not have same resources
Const $DN_NT_ENUMERATOR    = 0x00800000  ;   This devnode's is an NT enumerator
Const $DN_NT_DRIVER        = 0x01000000  ;   This devnode's is an NT driver
Const $DN_NEEDS_LOCKING    = 0x02000000  ;   Devnode need lock resume processing
Const $DN_ARM_WAKEUP        = 0x04000000  ;   Devnode can be the wakeup device
Const $DN_APM_ENUMERATOR    = 0x08000000  ;   APM aware enumerator
Const $DN_APM_DRIVER        = 0x10000000  ;   APM aware driver
Const $DN_SILENT_INSTALL    = 0x20000000  ;   Silent install
Const $DN_NO_SHOW_IN_DM    = 0x40000000  ;   No show in device manager
Const $DN_BOOT_LOG_PROB    = 0x80000000  ;   Had a problem during pre
; ==============================================================================

; SP_DEVINSTALL_PARAMS.Flags Constants
; ===============================================================================
Const $DI_SHOWOEM = 0x00000001 ; support Other... button
Const $DI_SHOWCOMPAT = 0x00000002 ; show compatibility list
Const $DI_SHOWCLASS = 0x00000004 ; show class list
Const $DI_SHOWALL = 0x00000007 ; both class & compat list shown
Const $DI_NOVCP = 0x00000008 ; don't create a new copy queue--use caller-supplied FileQueue
Const $DI_DIDCOMPAT = 0x00000010 ; Searched for compatible devices
Const $DI_DIDCLASS = 0x00000020 ; Searched for class devices
Const $DI_AUTOASSIGNRES = 0x00000040 ; No UI for resources if possible

; flags returned by DiInstallDevice to indicate need to reboot/restart
Const $DI_NEEDRESTART = 0x00000080 ; Reboot required to take effect
Const $DI_NEEDREBOOT = 0x00000100 ; Same as DI_NEEDRESTART

; flags for device installation
Const $DI_NOBROWSE = 0x00000200 ; no Browse... in InsertDisk

; Flags set by DiBuildDriverInfoList
Const $DI_MULTMFGS = 0x00000400 ; Set if multiple manufacturers in class driver list. Flag indicates that device is disabled
Const $DI_DISABLED = 0x00000800 ; Set if device disabled

; Flags for Device/Class Properties
Const $DI_GENERALPAGE_ADDED = 0x00001000
Const $DI_RESOURCEPAGE_ADDED = 0x00002000

; Flag to indicate the setting properties for this Device (or class) caused a change so the Dev Mgr UI probably needs to be updatd.
Const $DI_PROPERTIES_CHANGE = 0x00004000

; Flag to indicate that the sorting from the INF file should be used.
Const $DI_INF_IS_SORTED = 0x00008000

; Flag to indicate that only the INF specified by SP_DEVINSTALL_PARAMS.DriverPath should be searched.
Const $DI_ENUMSINGLEINF = 0x00010000

; Flag that prevents ConfigMgr from removing/re-enumerating devices during device registration, installation, and deletion.
Const $DI_DONOTCALLCONFIGMG = 0x00020000

; The following flag can be used to install a device disabled
Const $DI_INSTALLDISABLED = 0x00040000

; Flag that causes SetupDiBuildDriverInfoList to build a device's compatible driver list from its existing class driver list, instead of the normal INF search.
Const $DI_COMPAT_FROM_CLASS = 0x00080000

; This flag is set if the Class Install params should be used.
Const $DI_CLASSINSTALLPARAMS = 0x00100000

; This flag is set if the caller of DiCallClassInstaller does NOT want the internal default action performed if the Class installer returns ERROR_DI_DO_DEFAULT.
Const $DI_NODI_DEFAULTACTION = 0x00200000

; The setupx flag, DI_NOSYNCPROCESSING (0x00400000) is not support in the Setup APIs. Flags for device installation.
Const $DI_QUIETINSTALL = 0x00800000 ; don't confuse the user with questions or excess info
Const $DI_NOFILECOPY = 0x01000000 ; No file Copy necessary
Const $DI_FORCECOPY = 0x02000000 ; Force files to be copied from install path
Const $DI_DRIVERPAGE_ADDED = 0x04000000 ; Prop provider added Driver page.
Const $DI_USECI_SELECTSTRINGS = 0x08000000 ; Use Class Installer Provided strings in the Select Device Dlg.
Const $DI_OVERRIDE_INFFLAGS = 0x10000000 ; Override INF flags
Const $DI_PROPS_NOCHANGEUSAGE = 0x20000000 ; No Enable/Disable in General Props
Const $DI_NOSELECTICONS = 0x40000000 ; No small icons in select device dialogs
Const $DI_NOWRITE_IDS = 0x80000000 ; Don't write HW & Compat IDs on install
; ======================================================================================

; SP_DEVINSTALL_PARAMS.FlagsEx Constants
; ======================================================================================
Const $DI_FLAGSEX_USEOLDINFSEARCH = 0x00000001 ; Inf Search functions should not use Index Search
Const $DI_FLAGSEX_AUTOSELECTRANK0 = 0x00000002 ; SetupDiSelectDevice doesn't prompt user if rank 0 match
Const $DI_FLAGSEX_CI_FAILED = 0x00000004 ; Failed to Load/Call class installer
Const $DI_FLAGSEX_DIDINFOLIST = 0x00000010 ; Did the Class Info List
Const $DI_FLAGSEX_DIDCOMPATINFO = 0x00000020 ; Did the Compat Info List
Const $DI_FLAGSEX_FILTERCLASSES = 0x00000040
Const $DI_FLAGSEX_SETFAILEDINSTALL = 0x00000080
Const $DI_FLAGSEX_DEVICECHANGE = 0x00000100
Const $DI_FLAGSEX_ALWAYSWRITEIDS = 0x00000200
Const $DI_FLAGSEX_ALLOWEXCLUDEDDRVS = 0x00000800
Const $DI_FLAGSEX_NOUIONQUERYREMOVE = 0x00001000
Const $DI_FLAGSEX_USECLASSFORCOMPAT = 0x00002000 ; Use the device's class when building compat drv list.
 ; (Ignored if DI_COMPAT_FROM_CLASS flag is specified.)
Const $DI_FLAGSEX_OLDINF_IN_CLASSLIST = 0x00004000 ; Search legacy INFs when building class driver list.
Const $DI_FLAGSEX_NO_DRVREG_MODIFY = 0x00008000 ; Don't run AddReg and DelReg for device's software (driver) key.
Const $DI_FLAGSEX_IN_SYSTEM_SETUP = 0x00010000 ; Installation is occurring during initial system setup.
Const $DI_FLAGSEX_INET_DRIVER = 0x00020000 ; Driver came from Windows Update
Const $DI_FLAGSEX_APPENDDRIVERLIST = 0x00040000 ; Cause SetupDiBuildDriverInfoList to append
; ===================================================================================

; Values indicating a change in a devices' state
; ====================================================================================
Const $DICS_ENABLE = 0x00000001
Const $DICS_DISABLE = 0x00000002
Const $DICS_PROPCHANGE = 0x00000003
Const $DICS_START = 0x00000004
Const $DICS_STOP = 0x00000005
; =====================================================================================

; Values specifying the scope of a device property change
; ====================================================================================
Const $DICS_FLAG_GLOBAL = 0x00000001
Const $DICS_FLAG_CONFIGSPECIFIC = 0x00000002
Const $DICS_FLAG_CONFIGGENERAL = 0x00000004
; ====================================================================================

; ####  SetupDiGetClassDevs Constants ####
; ==============================================================================
Const $DIGCF_DEFAULT = 1
Const $DIGCF_PRESENT = 2
Const $DIGCF_ALLCLASSES = 4
Const $DIGCF_PROFILE = 8
Const $DIGCF_DEVICEINTERFACE = 16
; ==============================================================================

; #### SetupDiBuildDriverInfoList Constants (internal) ####
; ==============================================================================
Const $SPDIT_NODRIVER = 0x00000000
Const $SPDIT_CLASSDRIVER = 0x00000001
Const $SPDIT_COMPATDRIVER = 0x00000002
; ==============================================================================
Const $DIBCI_NOINSTALLCLASS = 1
Const $DIBCI_NODISPLAYCLASS = 2

 ; #### Value for SP_UNREMOVEDEVICE_PARAMS.Scope ####
; ==============================================================================
Const $DI_UNREMOVEDEVICE_CONFIGSPECIFIC = 2
; ==============================================================================

; #### Device Installation Structures ####
; ==============================================================================
Const $tagSP_DEVICEINFO_DATA = "dword Size;byte Guid[16];dword DevInst;ulong_ptr Reserved"
Const $tagSP_DEVINFO_LIST_DETAIL_DATA = "dword Size;byte ClassGUID[16];hWnd MachineHandle"

Const $tagSP_DEVINSTALL_PARAMS = "dword Size;dword Flags;dword FlagsEx;hWnd hWndParent;ptr InstallMsgHandler;ptr InstallMsgHandlerContext;ptr FileQueue;ulong_ptr ClassInstallReserved;dword Reserved;char DriverPath[260]"
Const $tagSP_DRVINFO_DATA = "dword Size;dword DriverType;ulong_ptr Reserved;char Descr[256];char MfgName[256];char ProviderName[256];dword FileTime[2];int Version"
Const $tagSP_DRVINFO_DETAIL_DATA = "dword Size;dword InfTime[2];dword CompatIDsOffset;dword CompatIDsLength;ulong_ptr Reserved;char SectionName[256];char InfFileName[260];char DrvDescr[256]"
Const $tagSP_CLASSINSTALL_HEADER = "dword Size;dword DIFCode"
Const $tagSP_DETECTDEVICE_PARAMS = $tagSP_CLASSINSTALL_HEADER & ";ptr NotifyCallback;ptr NotifyParam"
Const $tagSP_PROPCHANGE_PARAMS = $tagSP_CLASSINSTALL_HEADER & ";dword State;dword Scope;dword HwProfile"
Const $tagSP_POWERMESSAGEWAKE_PARAMS = $tagSP_CLASSINSTALL_HEADER & ";char Message[256]"
Const $tagSP_UNREMOVEDEVICE_PARAMS = $tagSP_CLASSINSTALL_HEADER & ";dword Scope;dword HWProfile"
Const $tagSP_DEV_INTERFACE_DATA = "dword Size;byte Guid[16];dword Flags;ulong_ptr Reserved"
Const $tagSP_DEV_INTERFACE_DETAIL_DATA = "dword Size;char DevicePath[512]"
Const $tagSP_CLASSIMAGE_DATA = "dword Size;hWnd ImageList;dword Reserved"
Const $tagSP_DRVINSTALL_PARAMS = "dword Size;dword Rank;dword Flags;long_ptr PrivateData;dword Reserved"
Const $tagSP_INF_SIGNER_INFO = "dword Size;wchar CatalogFile[260];wchar DigitalSigner[260];wchar DigitalSignerVersion[260]"
; ==============================================================================

; #### Device Interface Classes ####
; ==============================================================================
; #### Device Interface Classes for Modem Devices ####
; ==============================================================================
Const $GUID_DEVINTERFACE_MODEM = "{2C7089AA-2E0E-11D1-B114-00C04FC2AAE4}"
; ==============================================================================

; #### Device Interface Classes for Network Devices ####
; ==============================================================================
Const $GUID_DEVINTERFACE_NET = "{CAC88484-7515-4C03-82E6-71A87ABAC361}"
; ==============================================================================

; #### Device Interface Classes for Storage Devices ####
; ==============================================================================
Const $GUID_DEVINTERFACE_CDCHANGER = "{53F56312-B6BF-11D0-94F2-00A0C91EFB8B}"
Const $GUID_DEVINTERFACE_CDROM = "{53F56308-B6BF-11D0-94F2-00A0C91EFB8B}"
Const $GUID_DEVINTERFACE_DISK = "{53F56307-B6BF-11D0-94F2-00A0C91EFB8B}"
Const $GUID_DEVINTERFACE_FLOPPY = "{53F56311-B6BF-11D0-94F2-00A0C91EFB8B}"
Const $GUID_DEVINTERFACE_MEDIUMCHANGER = "{53F56310-B6BF-11D0-94F2-00A0C91EFB8B}"
Const $GUID_DEVINTERFACE_PARTITION = "{53F5630A-B6BF-11D0-94F2-00A0C91EFB8B}"
Const $GUID_DEVINTERFACE_STORAGEPORT = "{2ACCFE60-C130-11D2-B082-00A0C91EFB8B}"
Const $GUID_DEVINTERFACE_TAPE = "{53F5630B-B6BF-11D0-94F2-00A0C91EFB8B}"
Const $GUID_DEVINTERFACE_VOLUME = "{53F5630D-B6BF-11D0-94F2-00A0C91EFB8B}"
Const $GUID_DEVINTERFACE_WRITEONCEDISK = "{53F5630C-B6BF-11D0-94F2-00A0C91EFB8B}"
; ==============================================================================

; #### Device Interface Classes for USB Devices ####
; ==============================================================================
Const $GUID_DEVINTERFACE_USB_HUB = "{F18A0E88-C30C-11D0-8815-00A0C906BED8}"
Const $GUID_DEVINTERFACE_USB_HOST_CONTROLLER = "{3ABF6F2D-71C4-462A-8A92-1E6861E6AF27}"
Const $GUID_DEVINTERFACE_USB_DEVICE = "{A5DCBF10-6530-11D2-901F-00C04FB951ED}"
Const $GUID_DEVINTERFACE_USBSTOR = "{A5DCBF10-6530-11D2-901F-00C04FB951ED}"
; ==============================================================================

; #### Device Interface Classes for Display and Image Devices ####
; ==============================================================================
Const $GUID_DEVINTERFACE_BRIGHTNESS = "{FDE5BBA4-B3F9-46FB-BDAA-0728CE3100B4}"
Const $GUID_DEVINTERFACE_DISPLAY_ADAPTER = "{5B45201D-F2F2-4F3B-85BB-30FF1F953599}"
Const $GUID_DEVINTERFACE_I2C = "{2564AA4F-DDDB-4495-B497-6AD4A84163D7}"
Const $GUID_DEVINTERFACE_IMAGE = "{6BDD1FC6-810F-11D0-BEC7-08002BE2092F}"
Const $GUID_DEVINTERFACE_MONITOR = "{E6F07B5F-EE97-4a90-B076-33F57BF4EAA7}"
Const $GUID_DEVINTERFACE_OPM = "{BF4672DE-6B4E-4BE4-A325-68A91EA49C09}"
Const $GUID_DEVINTERFACE_VIDEO_OUTPUT_ARRIVAL = "{1AD9E4F0-F88D-4360-BAB9-4C2D55E564CD}"
; ==============================================================================

; #### Device Interface Classes for Interactive Input Devices ####
; ==============================================================================
Const $GUID_DEVINTERFACE_HID = "{4D1E55B2-F16F-11CF-88CB-001111000030}"
Const $GUID_DEVINTERFACE_KEYBOARD = "{884B96C3-56EF-11D1-BC8C-00A0C91405DD}"
Const $GUID_DEVINTERFACE_MOUSE = "{378DE44C-56EF-11D1-BC8C-00A0C91405DD}"
; ==============================================================================

; #### Device Interface Classes for Bluetooth Devices ####
; ==============================================================================
Const $GUID_BTHPORT_DEVICE_INTERFACE = "{0850302A-B344-4fda-9BE9-90576B8D46F0}"
; ==============================================================================

; #### Device Interface Classes for Battery, Disk Manager, 1394 Host Controller ... #### (??)
; ==============================================================================
Const $GUID_DEVINTERFACE_DVD = "{1186654d-47b8-48b9-beb9-7df113ae3c67}" ; ??
Const $GUID_DEVINTERFACE_FLASHMEDIA = "{2c9f2281-eb3c-11d6-80af-0001020c74d4}"
Const $GUID_DEVINTERFACE_SYSTEM_BUTTON = "{4afa3d53-74a7-11d0-be5e-00a0c9062857}"
Const $GUID_DEVINTERFACE_DISKDRIVE = "{53f5630e-b6bf-11d0-94f2-00a0c91efb8b}"
Const $GUID_DEVINTERFACE_HDAUDIO = "{54c9343c-2a17-42e8-b4fd-9f9da27b94d6}"
Const $GUID_DEVINTERFACE_AUDIO_ADAPTER = "{65E8773D-8F56-11D0-A3B9-00A0C9223196}"
Const $GUID_DEVINTERFACE_IEEE_1394_HOST_CONTROLLER = "{6bdd1fc1-810f-11d0-bec7-08002be2092f}"
Const $GUID_DEVINTERFACE_BATTERY = "{72631e54-78a4-11d0-bcf7-00aa00b7b32a}"
Const $GUID_DEVINTERFACE_STD_MODEM = "{86e0d1e0-8089-11d0-9ce4-08003e301f73}"
Const $GUID_DEVINTERFACE_PROCESSOR = "{97fadb10-4e33-40ae-359c-8bef029dbdd0}"
Const $GUID_DEVINTERFACE_NDIS = "{ad498944-762f-11d0-8dcb-00c04fc3358c}"
Const $GUID_DEVINTERFACE_HDAUDIO_MODEM = "{adb44c00-1b8d-11d4-8d5e-00a0c90d1c42}"

; ==============================================================================

; #### Device Interface Classes for Battery and ACPI Devices
; ==============================================================================
Const $GUID_DEVICE_APPLICATIONLAUNCH_BUTTON = "{629758EE-986E-4D9E-8E47-DE27F8AB054D}"
Const $GUID_DEVICE_BATTERY = "{72631E54-78A4-11D0-BCF7-00AA00B7B32A}"
Const $GUID_DEVICE_LID = "{4AFA3D52-74A7-11d0-be5e-00A0C9062857}"
Const $GUID_DEVICE_MEMORY = "{3FD0F03D-92E0-45FB-B75C-5ED8FFB01021}"
Const $GUID_DEVICE_MESSAGE_INDICATOR = "{CD48A365-FA94-4CE2-A232-A1B764E5D8B4}"
Const $GUID_DEVICE_PROCESSOR = "{97FADB10-4E33-40AE-359C-8BEF029DBDD0}"
Const $GUID_DEVICE_SYS_BUTTON = "{4AFA3D53-74A7-11d0-be5e-00A0C9062857}"
Const $GUID_DEVICE_THERMAL_ZONE = "{4AFA3D51-74A7-11d0-be5e-00A0C9062857}"
; ==============================================================================

; #### Resource Descriptor Structures ####
; ==============================================================================
Const $tagDMA_DES = "dword Count;dword Type;dword Flags;ulong AllocChannel"
Const $tagIO_DES = "dword Count;dword Type;int64 AllocBase;int64 AllocEnd;dword Flags"
Const $tagMEM_DES = $tagIO_DES & ";dword Reserved"
Const $tagIRQ_DES = "dword Count;dword Type;dword Flags;ulong AllocNum;ulong Affinity"
Const $tagBUSNUMBER_DES = "dword Count;dword Type;dword Flags;ulong AllocBase;ulong AllocEnd"
Const $tagMFCARD_DES = "dword Count;dword Type;dword Flags;byte ConfigOptions;byte IoResIndex;byte Reserved[2];dword ConfigRegisterBase"
Const $tagPCCARD_DES = "dword Count;dword Type;dword Flags;byte ConfigIndex;byte Reserved[3];dword MemCardBase1;dword MemCardBase2"
Const $tagCS_DES = "dword SignatureLength;dword LegacyDataOffset;dword LegacyDataSize;dword Flags;byte Guid[16]"
Const $tagCONFLICT_DETAILS = "ulong Size;ulong Mask;dword DevInst;int ResDes;ulong Flags;char Descr[260]"
; ==============================================================================

; #### Device Power State Constants ####
; ==============================================================================
Const $PDCAP_D0_SUPPORTED = 1
Const $PDCAP_D1_SUPPORTED = 2
Const $PDCAP_D2_SUPPORTED = 4
Const $PDCAP_D3_SUPPORTED = 8
Const $PDCAP_S0_SUPPORTED = 0x10000
Const $PDCAP_S1_SUPPORTED = 0x20000
Const $PDCAP_S2_SUPPORTED = 0x40000
Const $PDCAP_S3_SUPPORTED = 0x80000
Const $PDCAP_S4_SUPPORTED = 0x1000000
Const $PDCAP_S5_SUPPORTED = 0x2000000
Const $PDCAP_WAKE_FROM_D0_SUPPORTED = 0x10
Const $PDCAP_WAKE_FROM_D1_SUPPORTED = 0x20
Const $PDCAP_WAKE_FROM_D2_SUPPORTED = 0x40
Const $PDCAP_WAKE_FROM_D3_SUPPORTED = 0x80
Const $PDCAP_WAKE_FROM_S0_SUPPORTED = 0x100000
Const $PDCAP_WAKE_FROM_S1_SUPPORTED = 0x200000
Const $PDCAP_WAKE_FROM_S2_SUPPORTED = 0x400000
Const $PDCAP_WAKE_FROM_S3_SUPPORTED = 0x800000
Const $PDCAP_WARM_EJECT_SUPPORTED = 0x100
; ==============================================================================

; #### Flags for the SPDRP_CONFIGFLAGS in SetupDiGetDeviceRegistryProperty ####
; ==============================================================================
Const $CONFIGFLAG_DISABLED = 0x00000001 ; Set if disabled
Const $CONFIGFLAG_REMOVED = 0x00000002 ; Set if a present hardware enum device deleted
Const $CONFIGFLAG_MANUAL_INSTALL = 0x00000004 ; Set if the devnode was manually installed
Const $CONFIGFLAG_IGNORE_BOOT_LC = 0x00000008 ; Set if skip the boot config
Const $CONFIGFLAG_NET_BOOT = 0x00000010 ; Load this devnode when in net boot
Const $CONFIGFLAG_REINSTALL = 0x00000020 ; Redo install
Const $CONFIGFLAG_FAILEDINSTALL = 0x00000040 ; Failed the install
Const $CONFIGFLAG_CANTSTOPACHILD = 0x00000080 ; Can't stop/remove a single child
Const $CONFIGFLAG_OKREMOVEROM = 0x00000100 ; Can remove even if rom.
Const $CONFIGFLAG_NOREMOVEEXIT = 0x00000200 ; Don't remove at exit.
Const $CONFIGFLAG_FINISH_INSTALL = 0x00000400 ; Complete install for devnode running 'raw'
Const $CONFIGFLAG_NEEDS_FORCED_CONFIG = 0x00000800 ; This devnode requires a forced config

Const $CSCONFIGFLAG_BITS = 0x00000007 ; OR of below bits
Const $CSCONFIGFLAG_NONE = 0
Const $CSCONFIGFLAG_DISABLED = 0x00000001 ; Set if
Const $CSCONFIGFLAG_DO_NOT_CREATE = 0x00000002 ; Set if
Const $CSCONFIGFLAG_DO_NOT_START = 0x00000004 ; Set if
; ==============================================================================

; #### Device Registry Key Constants ####
; ==============================================================================
Const $REGKEY_HARDWARE_CS001_001 = "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Hardware Profiles\0001\System\CurrentControlSet\Enum\"
Const $REGKEY_HARDWARE_CS002_001 = "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Hardware Profiles\0001\System\CurrentControlSet\Enum\"
Const $REGKEY_HARDWARE_CS002_CURRENT = "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Hardware Profiles\Current\System\CurrentControlSet\Enum\"
Const $REGKEY_HARDWARE_CCS_001 = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Hardware Profiles\0001\System\CurrentControlSet\Enum\"
Const $REGKEY_HARDWARE_CCS_CURRENT = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Hardware Profiles\Current\System\CurrentControlSet\Enum\"
Const $REGKEY_HARDWARE_CS002_ENUM = "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Enum\"

; ==============================================================================

; #### Device Registry Property Structure(s) ####
; ==============================================================================
Const $tagCM_POWER_DATA = "ulong Size;int MostRecentPowerState;ulong Capabilities;ulong D1Latency;ulong D2Latency;ulong D3Latency;int PowerStateMapping[7];int DeepestSystemWake"
Const $tagHWPROFILE_INFO = "ulong HWProfile;char FriendlyName[80];dword Flags"
; ==============================================================================

; #### Configuration Priority Value ####
; ==============================================================================
Const $LCPRI_FORCECONFIG = 0x00000000 ; Coming from a forced config 
Const $LCPRI_BOOTCONFIG = 0x00000001  ; Coming from a boot config 
Const $LCPRI_DESIRED = 0x00002000  ; Preferable (better performance) 
Const $LCPRI_NORMAL = 0x00003000  ; Workable (acceptable performance) 
Const $LCPRI_LASTBESTCONFIG = 0x00003FFF  ; CM only--do not use 
Const $LCPRI_SUBOPTIMAL = 0x00005000 ;  Not desired, but will work 
Const $LCPRI_LASTSOFTCONFIG = 0x00007FFF  ; CM only--do not use 
Const $LCPRI_RESTART = 0x00008000 ;  Need to restart 
Const $LCPRI_REBOOT = 0x00009000  ; Need to reboot 
Const $LCPRI_POWEROFF = 0x0000A000 ;  Need to shutdown/power-off 
Const $LCPRI_HARDRECONFIG = 0x0000C000 ;  Need to change a jumper 
Const $LCPRI_HARDWIRED = 0x0000E000 ;   Cannot be changed 
Const $LCPRI_IMPOSSIBLE = 0x0000F000  ; Impossible configuration 
Const $LCPRI_DISABLED = 0x0000FFFF  ; Disabled configuration 
Const $MAX_LCPRI = 0x0000FFFF ;  Maximum known LC Priority
; ==============================================================================

; #### Device Manager Error Code ####
; ==============================================================================
Const $CM_PROB_NOT_CONFIGURED = 0x00000001 ; no config for device
Const $CM_PROB_DEVLOADER_FAILED = 0x00000002 ; service load failed
Const $CM_PROB_OUT_OF_MEMORY = 0x00000003 ; out of memory
Const $CM_PROB_ENTRY_IS_WRONG_TYPE = 0x00000004 ;
Const $CM_PROB_LACKED_ARBITRATOR = 0x00000005 ;
Const $CM_PROB_BOOT_CONFIG_CONFLICT = 0x00000006 ; boot config conflict
Const $CM_PROB_FAILED_FILTER = 0x00000007 ;
Const $CM_PROB_DEVLOADER_NOT_FOUND = 0x00000008 ; Devloader not found
Const $CM_PROB_INVALID_DATA = 0x00000009 ;
Const $CM_PROB_FAILED_START = 0x0000000A ;
Const $CM_PROB_LIAR = 0x0000000B ;
Const $CM_PROB_NORMAL_CONFLICT = 0x0000000C ; config conflict
Const $CM_PROB_NOT_VERIFIED = 0x0000000D ;
Const $CM_PROB_NEED_RESTART = 0x0000000E ; requires restart
Const $CM_PROB_REENUMERATION = 0x0000000F ;
Const $CM_PROB_PARTIAL_LOG_CONF = 0x00000010 ;
Const $CM_PROB_UNKNOWN_RESOURCE = 0x00000011 ; unknown res type
Const $CM_PROB_REINSTALL = 0x00000012 ;
Const $CM_PROB_REGISTRY = 0x00000013 ;
Const $CM_PROB_VXDLDR = 0x00000014 ; WINDOWS 95 ONLY
Const $CM_PROB_WILL_BE_REMOVED = 0x00000015 ; devinst will remove
Const $CM_PROB_DISABLED = 0x00000016 ; devinst is disabled
Const $CM_PROB_DEVLOADER_NOT_READY = 0x00000017 ; Devloader not ready
Const $CM_PROB_DEVICE_NOT_THERE = 0x00000018 ; device doesn't exist
Const $CM_PROB_MOVED = 0x00000019 ;
Const $CM_PROB_TOO_EARLY = 0x0000001A ;
Const $CM_PROB_NO_VALID_LOG_CONF = 0x0000001B ; no valid log config
Const $CM_PROB_FAILED_INSTALL = 0x0000001C ; install failed
Const $CM_PROB_HARDWARE_DISABLED = 0x0000001D ; device disabled
Const $CM_PROB_CANT_SHARE_IRQ = 0x0000001E ; can't share IRQ
Const $CM_PROB_FAILED_ADD = 0x0000001F ; driver failed add
Const $CM_PROB_DISABLED_SERVICE = 0x00000020 ; service's Start = 4
Const $CM_PROB_TRANSLATION_FAILED = 0x00000021 ; resource translation failed
Const $CM_PROB_NO_SOFTCONFIG = 0x00000022 ; no soft config
Const $CM_PROB_BIOS_TABLE = 0x00000023 ; device missing in BIOS table
Const $CM_PROB_IRQ_TRANSLATION_FAILED = 0x00000024 ; IRQ translator failed
Const $CM_PROB_FAILED_DRIVER_ENTRY = 0x00000025 ; DriverEntry() failed.
Const $CM_PROB_DRIVER_FAILED_PRIOR_UNLOAD = 0x00000026 ; Driver should have unloaded.
Const $CM_PROB_DRIVER_FAILED_LOAD = 0x00000027 ; Driver load unsuccessful.
Const $CM_PROB_DRIVER_SERVICE_KEY_INVALID = 0x00000028 ; Error accessing driver's service key
Const $CM_PROB_LEGACY_SERVICE_NO_DEVICES = 0x00000029 ; Loaded legacy service created no devices
Const $CM_PROB_DUPLICATE_DEVICE = 0x0000002A ; Two devices were discovered with the same name
Const $CM_PROB_FAILED_POST_START = 0x0000002B ; The drivers set the device state to failed
Const $CM_PROB_HALTED = 0x0000002C ; This device was failed post start via usermode
Const $CM_PROB_PHANTOM = 0x0000002D ; The devinst currently exists only in the registry
Const $CM_PROB_SYSTEM_SHUTDOWN = 0x0000002E ; The system is shutting down
Const $CM_PROB_HELD_FOR_EJECT = 0x0000002F ; The device is offline awaiting removal
Const $CM_PROB_DRIVER_BLOCKED = 0x00000030 ; One or more drivers is blocked from loading
Const $CM_PROB_REGISTRY_TOO_LARGE = 0x00000031 ; System hive has grown too large
Const $NUM_CM_PROB = 0x00000032;
; ==============================================================================

; #### Flags for _CM_Locate_DevNode ####
; ====================================================================================
Const $CM_LOCATE_DEVNODE_NORMAL = 0x00000000 
Const $CM_LOCATE_DEVNODE_PHANTOM = 0x00000001 
Const $CM_LOCATE_DEVNODE_CANCELREMOVE = 0x00000002 
Const $CM_LOCATE_DEVNODE_NOVALIDATION = 0x00000004 
Const $CM_LOCATE_DEVNODE_BITS = 0x00000007
Const $CM_LOCATE_DEVINST_NORMAL = $CM_LOCATE_DEVNODE_NORMAL
Const $CM_LOCATE_DEVINST_PHANTOM = $CM_LOCATE_DEVNODE_PHANTOM
Const $CM_LOCATE_DEVINST_CANCELREMOVE = $CM_LOCATE_DEVNODE_CANCELREMOVE
Const $CM_LOCATE_DEVINST_NOVALIDATION = $CM_LOCATE_DEVNODE_NOVALIDATION
Const $CM_LOCATE_DEVINST_BITS = $CM_LOCATE_DEVNODE_BITS
; ====================================================================================

; #### Flags for _CM_Get_Device_ID_List, _CM_Get_Device_ID_List_Size ####
; ====================================================================================
Const $CM_GETIDLIST_FILTER_NONE = 0x00000000
Const $CM_GETIDLIST_FILTER_ENUMERATOR = 0x00000001
Const $CM_GETIDLIST_FILTER_SERVICE = 0x00000002
Const $CM_GETIDLIST_FILTER_EJECTRELATIONS = 0x00000004
Const $CM_GETIDLIST_FILTER_REMOVALRELATIONS = 0x00000008
Const $CM_GETIDLIST_FILTER_POWERRELATIONS = 0x00000010
Const $CM_GETIDLIST_FILTER_BUSRELATIONS = 0x00000020
Const $CM_GETIDLIST_DONOTGENERATE = 0x10000040
Const $CM_GETIDLIST_FILTER_BITS = 0x1000007F
; ====================================================================================

; #### Flags for CM_Get_Device_Interface_List, CM_Get_Device_Interface_List_Size ####
; ====================================================================================
Const $CM_GET_DEVICE_INTERFACE_LIST_PRESENT = 0x00000000 ; only currently 'live' device interfaces
Const $CM_GET_DEVICE_INTERFACE_LIST_ALL_DEVICES = 0x00000001 ; all registered device interfaces
Const $CM_GET_DEVICE_INTERFACE_LIST_BITS = 0x00000001
; ====================================================================================

; #### Flags for _CM_Reenumerate_DevNode ####
; ====================================================================================
Const $CM_REENUMERATE_NORMAL = 0x00000000 
Const $CM_REENUMERATE_SYNCHRONOUS = 0x00000001 
Const $CM_REENUMERATE_BITS = 0x00000001
; ====================================================================================

; #### Flags for _CM_Query_And_Remove_SubTree ####
; ====================================================================================
Const $CM_REMOVE_UI_OK = 0x00000000
Const $CM_REMOVE_UI_NOT_OK = 0x00000001
Const $CM_REMOVE_NO_RESTART = 0x00000002
Const $CM_REMOVE_BITS = 0x00000003
; ====================================================================================

; #### Flags for _CM_Add_ID ####
; ====================================================================================
Const $CM_ADD_ID_HARDWARE = 0x00000000
Const $CM_ADD_ID_COMPATIBLE = 0x00000001
Const $CM_ADD_ID_BITS = 0x00000001
; ====================================================================================

; #### Flags for _CM_Get_First_Log_Conf ####
; ====================================================================================
Const $BASIC_LOG_CONF = 0x00000000 ; Specifies the req list.
Const $FILTERED_LOG_CONF = 0x00000001 ; Specifies the filtered req list.
Const $ALLOC_LOG_CONF = 0x00000002 ; Specifies the Alloc Element.
Const $BOOT_LOG_CONF = 0x00000003 ; Specifies the RM Alloc Element.
Const $FORCED_LOG_CONF = 0x00000004 ; Specifies the Forced Log Conf
Const $OVERRIDE_LOG_CONF = 0x00000005 ; Specifies the Override req list.
Const $NUM_LOG_CONF = 0x00000006 ; Number of Log Conf type
Const $LOG_CONF_BITS = 0x00000007 ; The bits of the log conf type.
; =====================================================================================

; #### Property for _SetupDiGetDeviceRegistryProperty ####
; ==============================================================================
Const $SPDRP_DEVICEDESC = 0x00000000 ; DeviceDesc (R/W)
Const $SPDRP_HARDWAREID = 0x00000001 ; HardwareID (R/W)
Const $SPDRP_COMPATIBLEIDS = 0x00000002 ; CompatibleIDs (R/W)
Const $SPDRP_NTDEVICEPATHS = 0x00000003 ; Unsupported, DO NOT USE
Const $SPDRP_SERVICE = 0x00000004 ; Service (R/W)
Const $SPDRP_CONFIGURATION = 0x00000005 ; Configuration (R)
Const $SPDRP_CONFIGURATIONVECTOR = 0x00000006 ; ConfigurationVector (R)
Const $SPDRP_CLASS = 0x00000007 ; Class (R)--tied to ClassGUID
Const $SPDRP_CLASSGUID = 0x00000008 ; ClassGUID (R/W)
Const $SPDRP_DRIVER = 0x00000009 ; Driver (R/W)
Const $SPDRP_CONFIGFLAGS = 0x0000000A ; ConfigFlags (R/W)
Const $SPDRP_MFG = 0x0000000B ; Mfg (R/W)
Const $SPDRP_FRIENDLYNAME = 0x0000000C ; FriendlyName (R/W)
Const $SPDRP_LOCATION_INFORMATION = 0x0000000D ; LocationInformation (R/W)
Const $SPDRP_PHYSICAL_DEVICE_OBJECT_NAME = 0x0000000E ; PhysicalDeviceObjectName (R)
Const $SPDRP_CAPABILITIES = 0x0000000F ; Capabilities (R)
Const $SPDRP_UI_NUMBER = 0x00000010 ; UiNumber (R)
Const $SPDRP_UPPERFILTERS = 0x00000011 ; UpperFilters (R/W)
Const $SPDRP_LOWERFILTERS = 0x00000012 ; LowerFilters (R/W)
Const $SPDRP_MAXIMUM_PROPERTY = 0x00000013 ; Upper bound on ordinals
Const $SPDRP_REMOVAL_POLICY = 0x1F
Const $SPDRP_REMOVAL_POLICY_HW_DEFAULT = 0x20
; ==============================================================================

; #### Removal policies (retrievable via _SetupDiGetDeviceRegistryProperty with 
; the SPDRP_REMOVAL_POLICY, or SPDRP_REMOVAL_POLICY_HW_DFAULT properties) ####
; ====================================================================================
Const $CM_REMOVAL_POLICY_EXPECT_NO_REMOVAL = 1
Const $CM_REMOVAL_POLICY_EXPECT_ORDERLY_REMOVAL = 2
Const $CM_REMOVAL_POLICY_EXPECT_SURPRISE_REMOVAL = 3
; ====================================================================================

; Re-enable and configuration actions (specified in call to _CM_Setup_DevInst)
; ===================================================================================
Const $CM_SETUP_DEVNODE_READY = 0x00000000; Reenable problem devinst
Const $CM_SETUP_DEVINST_READY = $CM_SETUP_DEVNODE_READY
Const $CM_SETUP_DOWNLOAD = 0x00000001; Get info about devinst
Const $CM_SETUP_WRITE_LOG_CONFS = 0x00000002
Const $CM_SETUP_PROP_CHANGE = 0x00000003
Const $CM_SETUP_DEVNODE_RESET = 0x00000004; Reset problem devinst without starting
Const $CM_SETUP_DEVINST_RESET = $CM_SETUP_DEVNODE_RESET
Const $CM_SETUP_BITS = 0x00000007
; ===================================================================================

; #### Flags for _CM_Set_DevNode_Problem ####
; ====================================================================================
Const $CM_SET_DEVNODE_PROBLEM_NORMAL = 0x00000000 ; only set problem if currently no problem
Const $CM_SET_DEVNODE_PROBLEM_OVERRIDE = 0x00000001 ; override current problem with new.
Const $CM_SET_DEVNODE_PROBLEM_BITS = 0x00000001
Const $CM_SET_DEVINST_PROBLEM_NORMAL = $CM_SET_DEVNODE_PROBLEM_NORMAL
Const $CM_SET_DEVINST_PROBLEM_OVERRIDE = $CM_SET_DEVNODE_PROBLEM_OVERRIDE
Const $CM_SET_DEVINST_PROBLEM_BITS = $CM_SET_DEVNODE_PROBLEM_BITS
; ====================================================================================

; #### DIF (device installation function) code ####
; ====================================================================================
Const $DIF_SELECTDEVICE   = 0x00000001
Const $DIF_INSTALLDEVICE           = 0x00000002
Const $DIF_ASSIGNRESOURCES         = 0x00000003
Const $DIF_PROPERTIES     = 0x00000004
Const $DIF_REMOVE         = 0x00000005
Const $DIF_FIRSTTIMESETUP          = 0x00000006
Const $DIF_FOUNDDEVICE    = 0x00000007
Const $DIF_SELECTCLASSDRIVERS      = 0x00000008
Const $DIF_VALIDATECLASSDRIVERS    = 0x00000009
Const $DIF_INSTALLCLASSDRIVERS     = 0x0000000A
Const $DIF_CALCDISKSPACE           = 0x0000000B
Const $DIF_DESTROYPRIVATEDATA      = 0x0000000C
Const $DIF_VALIDATEDRIVER          = 0x0000000D
Const $DIF_MOVEDEVICE     = 0x0000000E
Const $DIF_DETECT         = 0x0000000F
Const $DIF_INSTALLWIZARD           = 0x00000010
Const $DIF_DESTROYWIZARDDATA       = 0x00000011
Const $DIF_PROPERTYCHANGE          = 0x00000012
Const $DIF_ENABLECLASS    = 0x00000013
Const $DIF_DETECTVERIFY   = 0x00000014
Const $DIF_INSTALLDEVICEFILES      = 0x00000015
Const $DIF_UNREMOVE       = 0x00000016
Const $DIF_SELECTBESTCOMPATDRV     = 0x00000017
Const $DIF_ALLOW_INSTALL           = 0x00000018
Const $DIF_REGISTERDEVICE          = 0x00000019
Const $DIF_INSTALLINTERFACES       = 0x00000020
Const $DIF_DETECTCANCEL   = 0x00000021
Const $DIF_REGISTER_COINSTALLERS   = 0x00000022
Const $DIF_POWERMESSAGEWAKE = 0x27
; ====================================================================================

; #### Configuration Manager return status codes ####
; ====================================================================================
Const $CR_SUCCESS = 0x00000000
Const $CR_DEFAULT = 0x00000001
Const $CR_OUT_OF_MEMORY = 0x00000002
Const $CR_INVALID_POINTER = 0x00000003
Const $CR_INVALID_FLAG = 0x00000004
Const $CR_INVALID_DEVNODE = 0x00000005
Const $CR_INVALID_DEVINST = $CR_INVALID_DEVNODE
Const $CR_INVALID_RES_DES = 0x00000006
Const $CR_INVALID_LOG_CONF = 0x00000007
Const $CR_INVALID_ARBITRATOR = 0x00000008
Const $CR_INVALID_NODELIST = 0x00000009
Const $CR_DEVNODE_HAS_REQS = 0x0000000A
Const $CR_DEVINST_HAS_REQS = $CR_DEVNODE_HAS_REQS
Const $CR_INVALID_RESOURCEID = 0x0000000B
Const $CR_DLVXD_NOT_FOUND = 0x0000000C ; WIN 95 ONLY
Const $CR_NO_SUCH_DEVNODE = 0x0000000D
Const $CR_NO_SUCH_DEVINST = $CR_NO_SUCH_DEVNODE
Const $CR_NO_MORE_LOG_CONF = 0x0000000E
Const $CR_NO_MORE_RES_DES = 0x0000000F
Const $CR_ALREADY_SUCH_DEVNODE = 0x00000010
Const $CR_ALREADY_SUCH_DEVINST = $CR_ALREADY_SUCH_DEVNODE
Const $CR_INVALID_RANGE_LIST = 0x00000011
Const $CR_INVALID_RANGE = 0x00000012
Const $CR_FAILURE = 0x00000013
Const $CR_NO_SUCH_LOGICAL_DEV = 0x00000014
Const $CR_CREATE_BLOCKED = 0x00000015
Const $CR_NOT_SYSTEM_VM = 0x00000016 ; WIN 95 ONLY
Const $CR_REMOVE_VETOED = 0x00000017
Const $CR_APM_VETOED = 0x00000018
Const $CR_INVALID_LOAD_TYPE = 0x00000019
Const $CR_BUFFER_SMALL = 0x0000001A
Const $CR_NO_ARBITRATOR = 0x0000001B
Const $CR_NO_REGISTRY_HANDLE = 0x0000001C
Const $CR_REGISTRY_ERROR = 0x0000001D
Const $CR_INVALID_DEVICE_ID = 0x0000001E
Const $CR_INVALID_DATA = 0x0000001F
Const $CR_INVALID_API = 0x00000020
Const $CR_DEVLOADER_NOT_READY = 0x00000021
Const $CR_NEED_RESTART = 0x00000022
Const $CR_NO_MORE_HW_PROFILES = 0x00000023
Const $CR_DEVICE_NOT_THERE = 0x00000024
Const $CR_NO_SUCH_VALUE = 0x00000025
Const $CR_WRONG_TYPE = 0x00000026
Const $CR_INVALID_PRIORITY = 0x00000027
Const $CR_NOT_DISABLEABLE = 0x00000028
Const $CR_FREE_RESOURCES = 0x00000029
Const $CR_QUERY_VETOED = 0x0000002A
Const $CR_CANT_SHARE_IRQ = 0x0000002B
Const $CR_NO_DEPENDENT = 0x0000002C
Const $CR_SAME_RESOURCES = 0x0000002D
Const $CR_NO_SUCH_REGISTRY_KEY = 0x0000002E
Const $CR_INVALID_MACHINENAME = 0x0000002F ; NT ONLY
Const $CR_REMOTE_COMM_FAILURE = 0x00000030 ; NT ONLY
Const $CR_MACHINE_UNAVAILABLE = 0x00000031 ; NT ONLY
Const $CR_NO_CM_SERVICES = 0x00000032 ; NT ONLY
Const $CR_ACCESS_DENIED = 0x00000033 ; NT ONLY
Const $CR_CALL_NOT_IMPLEMENTED = 0x00000034
Const $CR_INVALID_PROPERTY = 0x00000035
Const $CR_DEVICE_INTERFACE_ACTIVE = 0x00000036
Const $CR_NO_SUCH_DEVICE_INTERFACE = 0x00000037
Const $CR_INVALID_REFERENCE_STRING = 0x00000038
Const $CR_INVALID_CONFLICT_LIST = 0x00000039
Const $CR_INVALID_INDEX = 0x0000003A
Const $CR_INVALID_STRUCTURE_SIZE = 0x0000003B
Const $NUM_CR_RESULTS = 0x0000003C
; ====================================================================================

; #### Resource Type for _CM_Get_Next_Res_Des ####
; ====================================================================================
Const $RESTYPE_ALL = 0x00000000 ; Return all resource types
Const $RESTYPE_NONE = 0x00000000 ; Arbitration always succeeded
Const $RESTYPE_MEM = 0x00000001 ; Physical address resource
Const $RESTYPE_IO = 0x00000002 ; Physical I/O address resource
Const $RESTYPE_DMA = 0x00000003 ; DMA channels resource
Const $RESTYPE_IRQ = 0x00000004 ; IRQ resource
Const $RESTYPE_DONOTUSE = 0x00000005 ; Used as spacer to sync subsequent ResTypes w/NT
Const $RESTYPE_BUSNUMBER = 0x00000006 ; bus number resource
Const $RESTYPE_MAX = 0x00000006 ; Maximum known (arbitrated ResType
Const $RESTYPE_IGNORED_BIT = 0x00008000 ; Ignore this resource
Const $RESTYPE_CLASSSPECIFIC = 0x0000FFFF ; class-specific resource
Const $RESTYPE_RESERVED = 0x00008000 ; reserved for internal use
Const $RESTYPE_DEVICEPRIVAT = 0x00008001 ; device private data
Const $RESTYPE_PCCARDCONFIG = 0x00008002 ; PC Card configuration data
Const $RESTYPE_MFCARDCONFIG = 0x00008003 ; MF Card configuration data
; ====================================================================================

; #### Registry properties for device instance ####
; =====================================================================================
Const $CM_DRP_DEVICEDESC = 0x00000001 ; DeviceDesc REG_SZ property (RW)
Const $CM_DRP_HARDWAREID = 0x00000002 ; HardwareID REG_MULTI_SZ property (RW)
Const $CM_DRP_COMPATIBLEIDS = 0x00000003 ; CompatibleIDs REG_MULTI_SZ property (RW)
Const $CM_DRP_UNUSED0 = 0x00000004 ; unused
Const $CM_DRP_SERVICE = 0x00000005 ; Service REG_SZ property (RW)
Const $CM_DRP_UNUSED1 = 0x00000006 ; unused
Const $CM_DRP_UNUSED2 = 0x00000007 ; unused
Const $CM_DRP_CLASS = 0x00000008 ; Class REG_SZ property (RW)
Const $CM_DRP_CLASSGUID = 0x00000009 ; ClassGUID REG_SZ property (RW)
Const $CM_DRP_DRIVER = 0x0000000A ; Driver REG_SZ property (RW)
Const $CM_DRP_CONFIGFLAGS = 0x0000000B ; ConfigFlags REG_DWORD property (RW)
Const $CM_DRP_MFG = 0x0000000C ; Mfg REG_SZ property (RW)
Const $CM_DRP_FRIENDLYNAME = 0x0000000D ; FriendlyName REG_SZ property (RW)
Const $CM_DRP_LOCATION_INFORMATION = 0x0000000E ; LocationInformation REG_SZ property (RW)
Const $CM_DRP_PHYSICAL_DEVICE_OBJECT_NAME = 0x0000000F ; PhysicalDeviceObjectName REG_SZ property (R)
Const $CM_DRP_CAPABILITIES = 0x00000010 ; Capabilities REG_DWORD property (R)
Const $CM_DRP_UI_NUMBER = 0x00000011 ; UiNumber REG_DWORD property (R)
Const $CM_DRP_UPPERFILTERS = 0x00000012 ; UpperFilters REG_MULTI_SZ property (RW)
Const $CM_DRP_LOWERFILTERS = 0x00000013 ; LowerFilters REG_MULTI_SZ property (RW)
Const $CM_DRP_BUSTYPEGUID = 0x00000014 ; Bus Type Guid, GUID, (R)
Const $CM_DRP_LEGACYBUSTYPE = 0x00000015 ; Legacy bus type, INTERFACE_TYPE, (R)
Const $CM_DRP_BUSNUMBER = 0x00000016 ; Bus Number, DWORD, (R)
Const $CM_DRP_ENUMERATOR_NAME = 0x00000017 ; Enumerator Name REG_SZ property (R)
Const $CM_DRP_SECURITY = 0x00000018 ; Security - Device override (RW)
Const $CM_CRP_SECURITY = $CM_DRP_SECURITY ; Class default security (RW)
Const $CM_DRP_SECURITY_SDS = 0x00000019 ; Security - Device override (RW)
Const $CM_CRP_SECURITY_SDS = $CM_DRP_SECURITY_SDS ; Class default security (RW)
Const $CM_DRP_DEVTYPE = 0x0000001A ; Device Type - Device override (RW)
Const $CM_CRP_DEVTYPE = $CM_DRP_DEVTYPE ; Class default Device-type (RW)
Const $CM_DRP_EXCLUSIVE = 0x0000001B ; Exclusivity - Device override (RW)
Const $CM_CRP_EXCLUSIVE = $CM_DRP_EXCLUSIVE ; Class default (RW)
Const $CM_DRP_CHARACTERISTICS = 0x0000001C ; Characteristics - Device Override (RW)
Const $CM_CRP_CHARACTERISTICS = $CM_DRP_CHARACTERISTICS ; Class default (RW)
Const $CM_DRP_ADDRESS = 0x0000001D ; Device Address (R)
Const $CM_DRP_UI_NUMBER_DESC_FORMAT = 0x0000001E ; UINumberDescFormat REG_SZ property (RW)
Const $CM_DRP_DEVICE_POWER_DATA = 0x0000001F ; CM_POWER_DATA REG_BINARY property (R)
Const $CM_DRP_REMOVAL_POLICY = 0x00000020 ; CM_DEVICE_REMOVAL_POLICY REG_DWORD (R)
Const $CM_DRP_REMOVAL_POLICY_HW_DEFAULT = 0x00000021 ; CM_DRP_REMOVAL_POLICY_HW_DEFAULT REG_DWORD (R)
Const $CM_DRP_REMOVAL_POLICY_OVERRIDE = 0x00000022 ; CM_DRP_REMOVAL_POLICY_OVERRIDE REG_DWORD (RW)
Const $CM_DRP_INSTALL_STATE = 0x00000023 ; CM_DRP_INSTALL_STATE REG_DWORD (R)
Const $CM_DRP_MIN = 0x00000001 ; First device register
Const $CM_CRP_MIN = $CM_DRP_MIN ; First class register
Const $CM_DRP_MAX = 0x00000023 ; Last device register
Const $CM_CRP_MAX = $CM_DRP_MAX ; Last class register
; =====================================================================================

; #### Flags for MEM_DES.Flags ####
; =====================================================================================
Const $MMD_MemoryType = 0x1 ; Bitmask, whether memory is writable
Const $FMD_MemoryType = $MMD_MemoryType ; compatibility
Const $FMD_ROM = 0x0 ; Memory range is read-only
Const $FMD_RAM = 0x1 ; Memory range may be written to

Const $MMD_32_24 = 0x2 ; Bitmask, memory is 24 or 32-bit
Const $FMD_32_24 = $MMD_32_24 ; compatibility
Const $FMD_24 = 0x0 ; Memory range is 24-bit
Const $FMD_32 = 0x2 ; Memory range is 32-bit

Const $MMD_Prefetchable = 0x4 ; Bitmask,whether memory prefetchable
Const $FMD_Prefetchable = $MMD_Prefetchable ; compatibility
Const $FMD_Pref = $MMD_Prefetchable ; compatibility
Const $FMD_PrefetchDisallowed = 0x0 ; Memory range is not prefetchable
Const $FMD_PrefetchAllowed = 0x4 ; Memory range is prefetchable

Const $MMD_Readable = 0x8 ; Bitmask,whether memory is readable
Const $FMD_Readable = $MMD_Readable ; compatibility
Const $FMD_ReadAllowed = 0x0 ; Memory range is readable
Const $FMD_ReadDisallowed = 0x8 ; Memory range is write-only

Const $MMD_CombinedWrite = 0x10 ; Bitmask,supports write-behind
Const $FMD_CombinedWrite = $MMD_CombinedWrite ; compatibility
Const $FMD_CombinedWriteDisallowed = 0x0 ; no combined-write caching
Const $FMD_CombinedWriteAllowed = 0x10 ; supports combined-write caching

Const $MMD_Cacheable = 0x20 ; Bitmask,whether memory is cacheable
Const $FMD_NonCacheable = 0x0 ; Memory range is non-cacheable
Const $FMD_Cacheable = 0x20 ; Memory range is cacheable
; =====================================================================================

; #### Flags for CONFLICT_DETAILS.Flags ####
; ====================================================================================
Const $CM_CDFLAGS_DRIVER = 1 ; CONF_DETAILS.Descr reports back legacy driver name
Const $CM_CDFLAGS_ROOT_OWNED = 2 ; CONF_DETAILS.Flags, root owned device
Const $CM_CDFLAGS_RESERVED = 4 ; CONF_DETAILS.Flags specified range is not available for use
; ====================================================================================

; #### Flags for IO_DES.Flags (Port Type Flags) (DWORD) ####
; ====================================================================================
Const $FIOD_MEMORY = 0 ; The device is accessed in memory address space.
Const $FIOD_IO = 1 ; The device is accessed in I/O address space.
; ====================================================================================

; #### Flags for IO_DES.Flags (Decode Flags) (DWORD) ####
; ====================================================================================
Const $FIOD_10_BIT_DECODE = 0x04 ; The device decodes 10 bits of the port address.
Const $FIOD_12_BIT_DECODE = 0x08 ; The device decodes 12 bits of the port address.
Const $FIOD_16_BIT_DECODE = 0x10 ; The device decodes 16 bits of the port address.
Const $FIOD_POSITIVE_DECODE = 0x20 ; The device uses "positive decode" instead of "subtractive decode."
Const $FIOD_DECODE = 0xFC ; Bitmask for the bits within IO_DES.Flags that specify the decode value.
; ====================================================================================

; #### Flags for IRQ_DES.Flags (Sharing Flags) (DWORD) ####
; ====================================================================================
Const $FIRQD_EXCLUSIVE = 0 ; The IRQ line cannot be shared.
Const $FIRQD_SHARE = 1 ; The IRQ line can be shared.
; ====================================================================================

; #### Flags for IRQ_DES.Flags (Triggering Flags) (DWORD) ####
; ====================================================================================
Const $FIRQD_LEVEL = 0 ; The IRQ line is level-triggered.
Const $FIRQD_EDGE = 2 ; The IRQ line is edge-triggered.
; ====================================================================================

; #### Flags for DMA_DES.Flags (DMA Channel Width) ####
; ==============================================================================
Const $MDD_WIDTH = 0x3  ; Bitmask, width of the DMA channel:
Const $FDD_BYTE = 0x0  ; 8-bit DMA channel
Const $FDD_WORD = 0x1  ; 16-bit DMA channel
Const $FDD_DWORD = 0x2  ; 32-bit DMA channel
Const $FDD_BYTE_AND_WORD = 0x3  ; 8-bit and 16-bit DMA channel
; ==============================================================================

; #### Flags for DMA_DES.Flags (Bus Mastering Flags) ####
; ==============================================================================
Const $MDD_BUSMASTER = 0x4  ; Bitmask, whether bus mastering is supported
Const $FDD_NOBUSMASTER = 0x0  ; no bus mastering
Const $FDD_BUSMASTER = 0x4  ; bus mastering
; ==============================================================================

; #### Flags for DMA_DES.Flags (DMA Type Flags) ####
; ==============================================================================
Const $MDD_TYPE = 0x18  ; Bitmask, specifies type of DMA
Const $FDD_TYPESTANDARD = 0x00  ; standard DMA
Const $FDD_TYPEA = 0x08  ; Type-A DMA
Const $FDD_TYPEB = 0x10  ; Type-B DMA
Const $FDD_TYPEF = 0x18  ; Type-F DMA
; ==============================================================================


; #### Return code for _SetupDiVerifyDigitalSinger ####
; ================================================================================
; Indicates that the publisher is trusted because the publisher's certificate is installed in the Trusted Publishers certificate store. 
Const $ERROR_AUTHENTICODE_TRUSTED_PUBLISHER = -536870335

; Indicates that trust cannot be automatically established because the publisher's signing certificate is not installed in the trusted publisher certificates store.
; However, this does not necessarily indicate an error. Instead it indicates that the caller must apply a caller-specific policy to establish trust in the publisher. 
Const $ERROR_AUTHENTICODE_TRUST_NOT_ESTABLISHED = -536870334
; ================================================================================

; #### Flags for SP_DRVINSTALL_PARAMS.Flags ####
; =================================================================================
; There are other providers supplying drivers that have the same description as this driver. This flag is READ-ONLY to installers.
Const $DNF_DUPDESC = 1

; This driver currently/previously controlled the associated device. This flag is READ-ONLY to installers.
Const $DNF_OLDDRIVER = 2

; Do not display this driver in any driver-select dialogs.
Const $DNF_EXCLUDEFROMLIST = 4

; Set if no physical driver is to be installed for this logical driver.
Const $DNF_NODRIVER = 8

; This driver comes from a legacy INF file. This flag is valid only for the NT-based operating system. This flag is READ-ONLY to installers.
Const $DNF_LEGACYINF = 0x10

; This driver is a class driver. This flag is read-only to installers.
Const $DNF_CLASS_DRIVER = 0x20

; This driver is a compatible driver. This flag is READ-ONLY to installers.
Const $DNF_COMPATIBLE_DRIVER = 0x40

; This driver came from the Internet or from Windows Update. This flag is READ-ONLY to installers.
Const $DNF_INET_DRIVER = 0x80

Const $DNF_UNUSED1 = 0x100

; This driver node is derived from an INF file that was included with this version of Windows. 
Const $DNF_INDEXED_DRIVER = 0x200

; This driver came from the Internet, but Setup does not currently have access to its source files. This flag is READ-ONLY to installers.
; The system will not install a driver marked with this flag because Setup does not have the source files and would end up prompting the user with an invalid,
; path. The INF for such a driver can be used for everything except for installing devices.
Const $DNF_OLD_INET_DRIVER = 0x400

; Do not use this driver. Installers can read and write this flag.
; If this flag is set, SetupDiSelectBestCompatDrv and SetupDiSelectDevice ignore this driver.
; A class installer or co-installer can set this flag to prevent Setup from listing the driver in the Select Driver dialog box.
; An installer might set this flag when it handles a DIF_SELECTDEVICE or DIF_SELECTBESTCOMPATDRV request, for example.
Const $DNF_BAD_DRIVER = 0x800

; There are other providers supplying drivers that have the same description as this driver.
; The only difference between this driver and its match is the driver date. This flag is read-only to installers.
; If this flag is set, Setup displays the driver date and driver version next to the driver so that the user can distinguish it from its match.
Const $DNF_DUPPROVIDER = 0x1000

; (Windows XP and later versions of Windows)
Const $DNF_INF_IS_SIGNED = 0x2000

; Reserved. (Windows XP and later versions of Windows)
Const $DNF_OEM_F6_INF = 0x4000

; (Windows XP and later versions of Windows)
Const $DNF_DUPDRIVERVER = 0x8000

; (Windows XP and later versions of Windows)
Const $DNF_BASIC_DRIVER = 0x10000

; This driver¡¯s INF file is signed by an Authenticode signature. This flag is read-only to installers. 
Const $DNF_AUTHENTICODE_SIGNED = 0x20000

; (Windows Vista and later versions of Windows)
; This driver node is currently installed for the device. This flag is read-only to installers.
Const $DNF_INSTALLEDDRIVER = 0x40000

; If set, this flag prevents the driver node from being enumerated, regardless of the client that is performing the enumeration.
Const $DNF_ALWAYSEXCLUEDFROMLIST = 0x80000
; =================================================================================

; #### Flags for SP_DRVINSTALL_PARAMS.Rank ####
; =================================================================================
Const $DRIVER_HARDWAREID_RANK = 0xFFF
Const $DRIVER_COMPATID_RANK = 0x3FFF
Const $DRIVER_UNTRUSTED_RANK = 0x8000
Const $DRIVER_UNTRUSTED_HARDWAREID_RANK = 0x8FFF
Const $DRIVER_UNTRUSTED_COMPATID_RANK = 0xBFFF
Const $DRIVER_W9X_SUSPECT_RANK = 0xC000
Const $DRIVER_W9X_SUSPECT_HARDWAREID_RANK = 0xCFFF
; =================================================================================

; #### Flags for HWPROFILE_INFO.Flags ####
; =================================================================================
Const $CM_HWPI_NOT_DOCKABLE = 0 ; Machine is not dockable
Const $CM_HWPI_UNDOCKED = 1 ; HW Profile for docked config
Const $CM_HWPI_DOCKED = 2 ; HW Profile for undocked config
; =================================================================================

; #### Flags for _CM_Bind_Device ####
; =================================================================================
Const $CM_BIND_UNUSED = 0
Const $CM_BIND_DEVINST_BIND_ID = 1
Const $CM_BIND_DEVINST_BIND_PHYSNAME = 2
Const $CM_BIND_PHYSNAME_BIND_DEVINST = 4
Const $CM_BIND_DEVINST_BIND_CLASS = 8
Const $CM_BIND_CLASS_BIND_DEVINST = 16
Const $CM_BIND_ENUMERATOR_BIND_DEVINST = 32
; =================================================================================

; ####### FUNCTIONS #######
; ==============================================================================
; _CM_Add_Empty_Log_Conf
; _CM_Add_Empty_Log_Conf_Ex
; _CM_Add_ID
; _CM_Add_ID_Ex
; _CM_Add_Res_Des
; _CM_Add_Res_Des_Ex
; _CM_Add_Res_Des_IO_Array_Ex
; _CM_Add_Res_Des_IRQ_Array_Ex
; _CM_Add_Res_Des_Mem_Array_Ex
; _CM_Assign_Var
; _CM_Cdrom_Known_Good_Digital_Playback
; _CM_Close_Handle
; _CM_Connect_Machine
; _CM_Create_Device_Devs
; _CM_Create_Device_Devs_Ex
; _CM_Create_File
; _CM_Device_IO_Control
; _CM_Disable_Cdrom_Digital_Playback
; _CM_Disable_DevNode
; _CM_Disable_DevNode_Ex
; _CM_Disconnect_Machine
; _CM_Duplicate_Buffer
; _CM_Enable_Cdrom_Digital_Playback
; _CM_Enable_DevNode
; _CM_Enable_DevNode_Ex
; _CM_Enable_Privileges
; _CM_Enum_Device_Info
; _CM_Enum_Device_Info_Ex
; _CM_Enum_Device_Info_Notify_Progress
; _CM_Enumerate_Children
; _CM_Enumerate_Children_Ex
; _CM_Enumerate_Classes
; _CM_Enumerate_Classes_Ex
; _CM_Enumerate_Enumerators
; _CM_Enumerate_Enumerators_Ex
; _CM_Enumerate_Physical_Disks
; _CM_Format_Error_Message
; _CM_Format_Problem_Message
; _CM_Free_Log_Conf
; _CM_Free_Log_Conf_Ex
; _CM_Free_Log_Conf_Handle
; _CM_Free_Res_Des
; _CM_Free_Res_Des_Ex
; _CM_Free_Res_Des_Handle
; _CM_Free_Resource_Conflict_Handle
; _CM_Free_Variable
; _CM_Get_Child
; _CM_Get_Child_By_Index
; _CM_Get_Child_By_Index_Ex
; _CM_Get_Child_Ex
; _CM_Get_Children_Count
; _CM_Get_Children_Count_Ex
; _CM_Get_Class_Registry_Property_Ex
; _CM_Get_Depth
; _CM_Get_Depth_Ex
; _CM_Get_Device_Driver_Files
; _CM_Get_Device_ID
; _CM_Get_Device_ID_By_Name_Ex
; _CM_Get_Device_ID_Ex
; _CM_Get_Device_ID_List
; _CM_Get_Device_ID_List_Ex
; _CM_Get_Device_ID_List_Size
; _CM_Get_Device_ID_List_Size_Ex
; _CM_Get_Device_ID_Size
; _CM_Get_Device_ID_Size_Ex
; _CM_Get_Device_Interface_List
; _CM_Get_Device_Interface_List_Ex
; _CM_Get_Device_Interface_List_Size
; _CM_Get_Device_Interface_List_Size_Ex
; _CM_Get_Device_Resources
; _CM_Get_Device_Resources_Ex
; _CM_Get_DevNode_Registry_Property
; _CM_Get_DevNode_Registry_Property_Ex
; _CM_Get_DevNode_Status
; _CM_Get_DevNode_Status_Ex
; _CM_Get_Drive_Disk_Number
; _CM_Get_Drive_Type
; _CM_Get_First_Log_Conf
; _CM_Get_First_Log_Conf_Ex
; _CM_Get_HW_Prof_Flags
; _CM_Get_HW_Prof_Flags_Ex
; _CM_Get_Last_Error
; _CM_Get_Log_Conf_Priority_Ex
; _CM_Get_Next_Log_Conf
; _CM_Get_Next_Log_Conf_Ex
; _CM_Get_Next_Res_Des
; _CM_Get_Next_Res_Des_Ex
; _CM_Get_Parent
; _CM_Get_Parent_Ex
; _CM_Get_Process_Heap
; _CM_Get_Res_Des_By_Index
; _CM_Get_Res_Des_By_Index_Ex
; _CM_Get_Res_Des_Data
; _CM_Get_Res_Des_Data_Ex
; _CM_Get_Res_Des_Data_Size
; _CM_Get_Res_Des_Data_Size_Ex
; _CM_Get_Resource_Conflict_Count
; _CM_Get_Resource_Conflict_Details
; _CM_Get_Sibling
; _CM_Get_Sibling_Ex
; _CM_Get_Version
; _CM_Get_Version_Ex
; _CM_Get_Volume_Name
; _CM_Get_Volume_Path
; _CM_GUID_From_String
; _CM_Heap_Alloc
; _CM_Heap_Free
; _CM_Heap_Size
; _CM_Install_Device_Driver
; _CM_Install_DevInst_Ex
; _CM_Install_New_Device
; _CM_Install_Selected_Device
; _CM_Install_Selected_Driver
; _CM_Is_Cdrom_Digital_Playback_Enabled
; _CM_Is_Device_Disabled
; _CM_Is_Dock_Station_Present
; _CM_Is_Dock_Station_Present_Ex
; _CM_Is_Version_Available
; _CM_Is_Version_Available_Ex
; _CM_Locate_DevNode
; _CM_Locate_DevNode_Ex
; _CM_Lock_Cdrom
; _CM_Modify_Res_Des
; _CM_Modify_Res_Des_Ex
; _CM_Query_And_Remove_SubTree
; _CM_Query_And_Remove_SubTree_Ex
; _CM_Query_Device_Problem
; _CM_Query_Device_Problem_Ex
; _CM_Query_DevNode_Resource_Conflicts_Ex
; _CM_Query_Resource_Conflict_List
; _CM_Reenumerate_DevNode
; _CM_Reenumerate_DevNode_Ex
; _CM_Request_Device_Eject
; _CM_Request_Device_Eject_Ex
; _CM_Request_Eject_PC
; _CM_Request_Eject_PC_Ex
; _CM_Safely_Eject_Disk
; _CM_Scan_Device_Changes
; _CM_Scan_Device_Changes_Ex
; _CM_Set_DevNode_CSConfigFlags
; _CM_Set_DevNode_Problem
; _CM_Set_DevNode_Problem_Ex
; _CM_Setup_DevNode
; _CM_String_From_GUID
; _CM_Uninstall_DevNode
; _CM_Update_PnP_Device
; _CM_Validate_Res_Des_Conflict_Ex
; _InstallNewDevice
; _SetupCloseInfFile
; _SetupDiApiBufferFree
; _SetupDiAskForOEMDisk
; _SetupDiBuildClassInfoList
; _SetupDiBuildDriverInfoList
; _SetupDiCallClassInstaller
; _SetupDiChangeState
; _SetupDiClassGuidsFromName
; _SetupDiClassNameFromGuid
; _SetupDiCreateDeviceDevs
; _SetupDiCreateDeviceDevsEx
; _SetupDiCreateDeviceInfo
; _SetupDiCreateDeviceInfoList
; _SetupDiCreateDeviceInfoListEx
; _SetupDiCreateDeviceInterface
; _SetupDiCreateDeviceInterfaceRegKey
; _SetupDiDeleteDeviceInfo
; _SetupDiDeleteDeviceInterfaceData
; _SetupDiDestroyClassImageList
; _SetupDiDestroyDeviceInfoList
; _SetupDiDestroyDriverInfoList
; _SetupDiDisableDevice
; _SetupDiEnumDeviceInfo
; _SetupDiEnumDeviceInterfaces
; _SetupDiEnumDriverInfo
; _SetupDiGetClassBitmapIndex
; _SetupDiGetClassDescription
; _SetupDiGetClassDescriptionEx
; _SetupDiGetClassDevs
; _SetupDiGetClassDevsEx
; _SetupDiGetClassImageIndex
; _SetupDiGetClassImageList
; _SetupDiGetDeviceInstallParams
; _SetupDiGetDeviceInstanceId
; _SetupDiGetDeviceInterfaceDetail
; _SetupDiGetDeviceInterfaceDevInst
; _SetupDiGetDeviceInterfaceDevs
; _SetupDiGetDeviceInterfaceDevsEx
; _SetupDiGetDevicePowerCapabilities
; _SetupDiGetDevicePowerMapping
; _SetupDiGetDevicePowerState
; _SetupDiGetDeviceRegistryProperty
; _SetupDiGetDevNodeStatus
; _SetupDiGetDriverInfoDetail
; _SetupDiGetDriverInstallParams
; _SetupDiGetDriverSigner
; _SetupDiGetHwProfileFriendlyName
; _SetupDiGetHwProfileList
; _SetupDiGetINFClass
; _SetupDiGetSelectedDriver
; _SetupDiInstallClass
; _SetupDiInstallClassEx
; _SetupDiInstallDevice
; _SetupDiInstallDeviceInterfaces
; _SetupDiLoadClassIcon
; _SetupDiLoadDeviceIcon
; _SetupDiOpenDeviceInfo
; _SetupDiOpenDeviceInterface
; _SetupDiOpenDeviceInterfaceRegKey
; _SetupDiOpenDevRegKey
; _SetupDiRegisterDeviceInfo
; _SetupDiRemoveDevice
; _SetupDiRemoveDeviceInterface
; _SetupDiSelectBestCompatDrv
; _SetupDiSelectDevice
; _SetupDiSelectOEMDrv
; _SetupDiSetClassInstallParams
; _SetupDiSetDeviceInstallParams
; _SetupDiSetDeviceInterfaceDefault
; _SetupDiSetDeviceRegistryProperty
; _SetupDiSetDriverInstallParams
; _SetupDiSetSelectedDevice
; _SetupDiSetSelectedDriver
; _SetupDiUnremoveDevice
; _SetupDiVerifyDigitalSigner
; _SetupGetLineByIndex
; _SetupGetLineCount
; _SetupGetLineText
; _SetupGetTargetPath
; _SetupOpenInfFile
; ==============================================================================

; #### Handle to the modules ####
; ==============================================================================================
Const $SETUPAPI_DllHandle = DllOpen("SetupApi.dll")
Const $KERNEL32_DllHandleA = DllOpen("Kernel32.dll")
Const $NEWDEV_DllHandle = DllOpen("Newdev.dll")
Const $DEVMGR_DllHandle = DllOpen("DevMgr.dll")
Const $STORP_DllHandle = DllOpen("StorProp.dll")
; ==============================================================================================

; #### FUNCTION ####
; ==============================================================================
; Name	: _SetupDiGetClassDevs
; Description	: Retrieves A handle to device information set.
; Parameter(s)	: $iFlags	- A value of type DWORD that specifies control options that filter the device information elements that are added to the device information set. This parameter can be a bitwise OR of zero or more of the following flags, can be a combination of the following values:
;		:	- $DIGCF_ALLCLASSES 
;		:	- Return a list of installed devices for all device setup classes or all device interface classes. 
;		:	- $DIGCF_DEVICEINTERFACE 
;		:	- Return devices that support device interfaces for the specified device interface classes. This flag must be set in the Flags parameter if the Enumerator parameter specifies a device instance ID. 
;		:	- $DIGCF_DEFAULT 
;		:	- Return only the device that is associated with the system default device interface, if one is set, for the specified device interface classes. 
;		:	- $DIGCF_PRESENT 
;		:	- Return only devices that are currently present in a system. 
;		:	- $DIGCF_PROFILE 
;		:	- Return only devices that are a part of the current hardware profile
;		: $vGuid	- An optional variable-type GUID value for a device setup class or a device interface class.
;		: $sEnumerator	- Enumerator for this device information set (PCI/SCSI/PCMCIA...).
; Return values	: If succeeds, returns a handle to device information set contains the control options. Otherwise, returns ERROR_INVALID_HANDLE (-1) and sets @error to a system error code.
; Author	: Pusofalse
; =========================================================================
Func _SetupDiGetClassDevs($iFlags, $vGuid = 0, $sEnumerator = "")
	Local $iResult, $tGuid, $pGuid = 0, $sType = "ptr"

	If $sEnumerator <> "" Then $sType = "str"
	If IsString($vGuid) Then
		If StringLeft($vGuid, 1) & StringRight($vGuid, 1) = "{}" Then
			$tGUID = _CM_GUID_From_String($vGuid)
			$pGuid = DllStructGetPtr($tGUID)
		ElseIf $vGuid <> "" Then
			$tGuid = _SetupDiClassGuidsFromName($vGuid)
			$pGuid = DllStructGetPtr($tGuid)
		EndIf
	ElseIf IsDllStruct($vGuid) Then
		$pGuid = DllStructGetPtr($vGuid)
	ElseIf IsPtr($vGuid) Then
		$pGuid = $vGuid
	Else
		$pGuid = 0
	EndIf
	$iResult = DllCall($SETUPAPI_DllHandle, "ptr", "SetupDiGetClassDevs", "ptr", $pGuid, _
			$sType, $sEnumerator, "hWnd", 0, "dword", $iFlags)
	Return SetError(_CM_Get_Last_Error(), _SetupDiApiBufferFree($tGuid), $iResult[0])
EndFunc	;==>_SetupDiGetClassDevs

; #### FUNCTION ####
; =========================================================================
; Name	: _SetupDiClassGuidsFromName
; Description	: Return the GUID of the specified device class.
; Parameter(s)	: $sClassName	- The name of the device class, (NET/Keyboard...).
; Return values	: If succeeds, returns a GUID structure (contains one member - Guid), and @extended is set to non-zero. If fails, returns a GUID structure either, but @extended is set to zero.
; Author	: Pusofalse
; =========================================================================
Func _SetupDiClassGuidsFromName($sClassName)
	Local $tGuid, $pGuid, $iResult

	$tGuid = DllStructCreate("byte Guid[16]")
	$pGuid = DllStructGetPtr($tGuid)
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiClassGuidsFromName", _
			"str", $sClassName, "ptr", $pGuid, "dword", 1, "int*", 0)
	Return SetError(_CM_Get_Last_Error(), $iResult[4], $tGuid)
EndFunc	;==>_SetupDiClassGuidsFromName

; #### FUNCTION ####
; =========================================================================
; Name	: _SetupDiApiBufferFree
; Description	: Frees a memory buffer, internal used only.
; Parameter(s)	: $vBuffer - Buffer to be freed.
; Return values	: None.
; Author	: Pusofalse
; =========================================================================
Func _SetupDiApiBufferFree(ByRef $vBuffer, $vValue = 0, $vReturn = "", _
			$iError = @error, $iExtended = @Extended)
	$vBuffer = $vValue
	Return SetError($iError, $iExtended, $vReturn)
EndFunc	;==>_SetupDiApiBufferFree

Func _SetupDiBuildClassInfoList($iFlags = 0)
	Local $iResult, $tBuffer, $pBuffer, $tagBuffer, $aResult[1][2] = [[0]]

	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiBuildClassInfoList", "dword", $iFlags, _
			"ptr", 0, "dword", 0, "dword*", 0)
	If $iResult[4] = 0 Then Return SetError(_CM_Get_Last_Error(), 0, $aResult)
	$aResult[0][0] = $iResult[4]
	Redim $aResult[$iResult[4] + 1][2]
	For $i = 1 to $iResult[4]
		$tagBuffer &= "ubyte[16];"
	Next
	$tBuffer = DllStructCreate($tagBuffer)
	$pBuffer = DllStructGetPtr($tBuffer)
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiBuildClassInfoList", "dword", $iFlags, _
			"ptr", $pBuffer, "dword", $iResult[4], "dword*", 0)
	For $i = 1 to $iResult[4]
		$pBuffer = DllStructGetPtr($tBuffer, $i)
		$aResult[$i][0] = _CM_String_From_GUID($pBuffer)
		$aResult[$i][1] = _SetupDiGetClassDescription($pBuffer)
	Next
	_SetupDiApiBufferFree($tBuffer)
	Return SetExtended($iResult[4], $aResult)
EndFunc	;==>_SetupDiBuildClassInfoList

; #### FUNCTION ####
; =========================================================================
; Name	: _SetupDiGetClassDescription
; Description	: Retrieves the class description associated with the specified setup class GUID.
; Parameter(s)	: $vGuid	- A variable-type Class-GUID value, can be in one of the following formats:
;		:	- Class name: NET/Display/Mouse...
;		:	- Class GUID string: {xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}.
;		:	- Class GUID structure.
;		:	- Class GUID pointer.
; Return values	: If succeeds, returns the class description, on failure, @extended is set to zero.
; Author	: Pusofalse
; =========================================================================
Func _SetupDiGetClassDescription($vGuid)
	Local $iResult, $pGuid

	If IsDllStruct($vGuid) Then
		$pGuid = DllStructGetPtr($vGuid)
	ElseIf IsString($vGuid) Then
		Local $tGUID = _CM_GUID_From_String($vGuid)
		$pGuid = DllStructGetPtr($tGUID)
	ElseIf IsPtr($vGuid) Then
		$pGuid = $vGuid
	EndIf

	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiGetClassDescription", _
			"ptr", $pGuid, "ptr", 0, "dword", 0, "dword*", 0)
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiGetClassDescription", _
			"ptr", $pGuid, "str", "", "dword", $iResult[4], "dword*", 0)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[2])
EndFunc	;==>_SetupDiGetClassDescription

; #### FUNCTION ####
; =========================================================================
; Name	: _SetupDiClassNameFromGuid
; Description	: Retrieves the class name associated with a class GUID.
; Parameter(s)	: $vGuid	- A variable-type Class-GUID value, can be in one of the following formats:
;		:	- Class GUID string: {xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}.
;		:	- Class GUID structure.
;		:	- Class GUID pointer.
; Return values	: If succeeds, return the class name and sets @extended to non-zero, else return NULL and sets @error.
; Author	: Pusofalse
; =========================================================================
Func _SetupDiClassNameFromGuid($vGuid)
	Local $pGuid, $iResult

	If IsDllStruct($vGuid) Then
		$pGuid = DllStructGetPtr($vGuid)
	ElseIf IsString($vGuid) Then
		Local $tGUID = _CM_GUID_From_String($vGuid)
		$pGuid = DllStructGetPtr($tGUID)
	ElseIf IsPtr($vGuid) Then
		$pGuid = $vGuid
	EndIf
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiClassNameFromGuid", _
			"ptr", $pGuid, "str", "", "dword", 64, "dword*", 0)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[2])
EndFunc	;==>_SetupDiClassNameFromGuid

; #### FUNCTION ####
; =========================================================================
; Name	: _SetupDiEnumDeviceInfo
; Description	: Enumerates a device information element in the device information set.
; Parameter(s)	: $hDevs	- A handle to the device information set.
;		: $iIndex	- The zero-based index of the device information element to retrieve.
;		: $tSP_DEVINFO_DATA	- A variable receives a SP_DEVINFO_DATA structure contains the device information element.
; Return values	: True indicates success, false to failure, in which case, @error is set to a system error code.
; Author	: Pusofalse
; =========================================================================
Func _SetupDiEnumDeviceInfo($hDevs, $iIndex, ByRef $tSP_DEVINFO_DATA)
	Local $iResult, $pSP_DEVINFO_DATA

	If Not IsDllStruct($tSP_DEVINFO_DATA) Then
		$tSP_DEVINFO_DATA = DllStructCreate($tagSP_DEVICEINFO_DATA)
		DllStructSetData($tSP_DEVINFO_DATA, "Size", 28)
	EndIf
	$pSP_DEVINFO_DATA = DllStructGetPtr($tSP_DEVINFO_DATA)
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiEnumDeviceInfo", _
			"ptr", $hDevs, "int", $iIndex, "ptr", $pSP_DEVINFO_DATA)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[0])
EndFunc	;==>_SetupDiEnumDeviceInfo

; #### FUNCTION ####
; =========================================================================
; Name	: _SetupDiGetDeviceRegistryProperty
; Description	: Retrieve the device registry property.
; Parameter(s)	: $hDevs	- A handle to a device information set, obtain the handle by using _SetupDiGetClassDevs function.
;		: $pSP_DEVINFO_DATA	- A pointer to/or a SP_DEVICEINFO_DATA structure contains the device information from which the property information is retrieved.
;		: $iProperty	- A value indicates the property required, see SPDRP_* constants for a value.
; Return values	: If success, returns the requested property. If failure, returns NULL and sets @error to a system error code, pass @error to FormatMessage for an explicit error message.
; Author	: Pusofalse
; =========================================================================
Func _SetupDiGetDeviceRegistryProperty($hDevs, $pSP_DEVINFO_DATA, $iProperty)
	Local $iResult, $pBuffer, $tBuffer, $sVal, $vVar, $iSysError

	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiGetDeviceRegistryProperty", _
			"ptr", $hDevs, "ptr", $pSP_DEVINFO_DATA, "dword", $iProperty, _
			"dword*", 0, "ptr", 0, "dword", 0, "dword*", 0)
	$pBuffer = _CM_Heap_Alloc($iResult[7])
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiGetDeviceRegistryProperty", _
			"ptr", $hDevs, "ptr", $pSP_DEVINFO_DATA, "dword", $iProperty, _
			"dword*", 0, "ptr", $pBuffer, "dword", $iResult[7], "dword*", 0)
	$iSysError = _CM_Get_Last_Error()
	Switch $iResult[4]
	Case 1, 2, 7
		$tBuffer = DllStructCreate("char Data[" & $iResult[7] & "]", $pBuffer)
	Case 4, 5
		$tBuffer = DllStructCreate("dword Data", $pBuffer)
	Case 6
		$tBuffer = DllStructCreate("wchar Data[" & $iResult[7] / 2 & "]", $pBuffer)
	Case Else
		$tBuffer = DllStructCreate("byte Data[" & $iResult[7] & "]", $pBuffer)
	EndSwitch
	If $iResult[4] <> 7 Then
		$vVar = DllStructGetData($tBuffer, "Data")
		_CM_Heap_Free($pBuffer)
		Return SetError($iSysError, _CM_Free_Variable($tBuffer) + $iResult[4], $vVar)
	EndIf
	For $i = 1 To $iResult[7]
		$sVal = DllStructGetData($tBuffer, "Data", $i)
		If $sVal = Chr(0) Then
			$vVar &= @LF
			ContinueLoop
		EndIf
		$vVar &= $sVal
	Next
	_CM_Heap_Free($pBuffer)
	Return SetError($iSysError, 7 + _CM_Free_Variable($tBuffer), $vVar)
EndFunc	;==>_SetupDiGetDeviceRegistryProperty

; #### FUNCTION #####
; =========================================================================
; Name	: _SetupDiSetDeviceRegistryProperty
; Description	: This function sets property for a device instance.
; Parameter(s)	: $hDevs	- Handle to the device information set.
;		: $pSP_DEVINFO_DATA - A pointer to an SP_DEVINFO_DATA structure contains the device information element.
;		: $iProperty - Property to be set.
;		: $pBuffer - Property value.
;		: $iBufferSize	- Size of $pBuffer.
;		: $sBufferType	- Variable type of $pBuffer parameter, default to recognize as a pointer (PTR).
; Return values	: True is returned if succeeds, otherwise returns false and sets @error to a system error code.
; Author	: Pusofalse
; =========================================================================
Func _SetupDiSetDeviceRegistryProperty($hDevs, $pSP_DEVINFO_DATA, $iProperty, $pBuffer, $iBufferSize, $sBufferType = "ptr")
	Local $iResult

	If IsDllStruct($pBuffer) Then $pBuffer = DllStructGetPtr($pBuffer)
	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiSetDeviceRegistryProperty", _
			"ptr", $hDevs, "ptr", $pSP_DEVINFO_DATA, "dword", $iProperty, _
			$sBufferType, $pBuffer, "dword", $iBufferSize)
	Return SetError(_CM_Get_Last_Error(), 0, $iResult[0])
EndFunc	;==>_SetupDiSetDeviceRegistryProperty

Func _SetupDiGetDevicePowerCapabilities($hDevs, $tDevInfo)
	Local $bData, $tData, $pData, $tPower, $iCapValue

	$bData = _SetupDiGetDeviceRegistryProperty($hDevs, $tDevInfo, 0x1E);, 0)
	If @error Then Return SetError(@error, 0, 0)

	$tData = DllStructCreate("byte Data[" & BinaryLen($bData) & "]")
	$pData = DllStructGetPtr($tData)
	$tPower = DllStructCreate($tagCM_POWER_DATA, $pData)
	DllStructSetData($tData, "Data", $bData)

	$iCapValue = "0x" & Hex(DllStructGetData($tPower, "Capabilities"))
	_CM_Free_Variable($tPower)
	Return SetExtended(_CM_Free_Variable($tData), $iCapValue)
EndFunc	;==>_SetupDiGetDevicePowerCapabilities

Func _SetupDiGetDevicePowerMapping($hDevs, $tDevInfo)
	Local $aResult[6], $bData, $tData, $pData, $tPower, $iValue

	$bData = _SetupDiGetDeviceRegistryProperty($hDevs, $tDevInfo, 0x1E);, 0)
	If @error Then Return SetError(@error, 0, $aResult)
	$tData = DllStructCreate("byte Data[" & BinaryLen($bData) & "]")
	$pData = DllStructGetPtr($tData)
	$tPower = DllStructCreate($tagCM_POWER_DATA, $pData)
	DllStructSetData($tData, "Data", $bData)

	For $i = 2 to 7
		$iValue = DllStructGetData($tPower, "PowerStateMapping", $i)
		Switch $iValue
		Case 0
			$iValue = "Unspecified"
		Case 1
			$iValue = "D0"
		Case 2
			$iValue = "D1"
		Case 3
			$iValue = "D2"
		Case 4
			$iValue = "D3"
		Case 5
			$iValue = "Maximum"
		Case Else
			$iValue = "Unknown"
		EndSwitch
		$aResult[$i - 2] = "S" & ($i - 2) & " -> " & $iValue
	Next
	_CM_Free_Variable($tPower)
	Return SetExtended(_CM_Free_Variable($tData), $aResult)
EndFunc	;==>_SetupDiGetDevicePowerMapping

Func _SetupDiGetDevicePowerState($hDevs, $tDevInfo)
	Local $bData, $tData, $pData, $tPower, $sValue

	$bData = _SetupDiGetDeviceRegistryProperty($hDevs, $tDevInfo, 0x1E);, 0)
	If @error Then Return SetError(@error, 0, "")

	$tData = DllStructCreate("byte Data[" & BinaryLen($bData) & "]")
	$pData = DllStructGetPtr($tData)
	$tPower = DllStructCreate($tagCM_POWER_DATA, $pData)
	DllStructSetData($tData, "Data", $bData)
	Switch DllStructGetData($tPower, "MostRecentPowerState")
	Case 0
		$sValue = "Unspecified"
	Case 1
		$sValue = "D0"
	Case 2
		$sValue = "D1"
	Case 3
		$sValue = "D2"
	Case 4
		$sValue = "D3"
	Case 5
		$sValue = "Maximum"
	Case Else
		$sValue = "Unknown"
	EndSwitch
	_CM_Free_Variable($tPower)
	Return SetExtended(_CM_Free_Variable($tData), $sValue)
EndFunc	;==>_SetupDiGetDevicePowerState

; #### FUNCTION ####
; =========================================================================
; Name	: _SetupDiGetDeviceInstanceId
; Description	: Retrieve the instance identifier of the specified device.
; Parameter(s)	: $hDevs	- A handle to a device information set.
;		: $pSP_DEVINFO_DATA	- A pointer to/or a SP_DEVICEINFO_DATA structure contains the device information.
; Return values	: If succeeds, returns an instance identifier string, else returns NULL and sets @error.
; Author	: Pusofalse
; =========================================================================
Func _SetupDiGetDeviceInstanceId($hDevs, $pSP_DEVINFO_DATA)
	Local $iResult
	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiGetDeviceInstanceId", _
			"ptr", $hDevs, "ptr", $pSP_DEVINFO_DATA, _
			"ptr", 0, "dword", 0, "dword*", 0)
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiGetDeviceInstanceId", _
			"ptr", $hDevs, "ptr", $pSP_DEVINFO_DATA, _
			"str", "", "dword", $iResult[5], "dword*", 0)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[3])
EndFunc	;==>_SetupDiGetDeviceInstanceId

; #### FUNCTION ####
; =========================================================================
; Name	: _SetupDiCreateDeviceInfoList
; Description	: This function creates an empty device information set.
; Parameter(s)	: $vGuid - GUID for device setup class, can be NULL.
;		: $hWnd - Parent window handle, can be NULL.
; Return values	: A valid handle is returned if succeeds, otherwise returns -1 and sets @error.
; Author	: Pusofalse
; =========================================================================
Func _SetupDiCreateDeviceInfoList($vGuid = "", $hWnd = 0)
	Local $iResult, $pGuid
	If IsString($vGuid) Then
		If (StringLeft($vGuid, 1) & StringRight($vGuid, 1) = "{}") Then
			$pGuid = DllStructGetPtr(_CM_GUID_From_String($vGuid))
		ElseIf $vGuid <> "" Then
			$tGuid = _SetupDiClassGuidsFromName($vGuid)
			$pGuid = DllStructGetPtr($tGuid)
		EndIf
	ElseIf IsDllStruct($vGuid) Then
		$pGuid = DllStructGetPtr($vGuid)
	ElseIf IsPtr($vGuid) Then
		$pGuid = $vGuid
	Else
		$pGuid = 0
	EndIf
	$iResult = DllCall($SETUPAPI_DllHandle, "ptr", "SetupDiCreateDeviceInfoList", _
			"ptr", $pGuid, "hWnd", $hWnd)
	Return SetError(_CM_Get_Last_Error(), $iResult[0] <> -1, $iResult[0])
EndFunc	;==>_SetupDiCreateDeviceInfoList

; #### FUNCTION ####
; =========================================================================
; Name	: _SetupDiSetSelectedDevice
; Description	: This function selectes a device element for a device information set.
; Parameter(s)	: $hDevs	- Handle to the device information set.
;		: $pSP_DEVINFO_DATA - A pointer to SP_DEVINFO_DATA contains the device information element.
; Return values	: True indicates success, False indicates failure, sets @error to a system error code.
; Author	: Pusofalse
; =========================================================================
Func _SetupDiSetSelectedDevice($hDevs, $pSP_DEVINFO_DATA)
	Local $iResult

	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiSetSelectedDevice", _
			"ptr", $hDevs, "ptr", $pSP_DEVINFO_DATA)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[0])
EndFunc	;==>_SetupDiSetSelectedDevice

; #### FUNCTION ####
; =========================================================================
; Name	: _SetupDiSetSelectedDriver
; Description	: The _SetupDiSetSelectedDriver function sets, or resets, the selected driver for a device information element or the selected class driver for a device information set.
; Parameter(s)	: $hDevs - Handle to the device information set.
;		: $pSP_DEVINFO_DATA - A pointer to an SP_DEVINFO_DATA structure contains the device information element.
;		: $tSP_DRVINFO_DATA - An SP_DRVINFO_DATA structure contains the driver to be selected.
; Return values	: True is returned if succeeds, otherwise returns False.
; Author	: Pusofalse
; =========================================================================
Func _SetupDiSetSelectedDriver($hDevs, $pSP_DEVINFO_DATA, ByRef $tSP_DRVINFO_DATA)
	Local $iResult, $pSP_DRVINFO_DATA

	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	$pSP_DRVINFO_DATA = DllStructGetPtr($tSP_DRVINFO_DATA)
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiSetSelectedDriver", _
			"ptr", $hDevs, "ptr", $pSP_DEVINFO_DATA, _
			"ptr", $pSP_DRVINFO_DATA)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[0])
EndFunc	;==>_SetupDiSetSelectedDriver

; #### FUNCTION ####
; =========================================================================
; Name	: _SetupDiOpenDeviceInfo
; Description	: This function adds a device information element for a device instance to a device information set, if one does not already exist in the device information set, and retrieves information that identifies the device information element for the device instance in the device information set.
; Parameter(s)	: $hDevs	- Supplies a handle to the device information set.
;		: $sInstanceID	- Supplies a device instance identifier, in string format.
;		: $tSP_DEVINFO_DATA - A variable receives a SP_DEVINFO_DATA that contains the specified device information element.
;		: $iFlags - A variable of DWORD type that controls how the device information element is opened, a value of zero is default.
; Return values	: If succeeds, returns True. Else returns False and sets @error to a system error code.
; Author	: Pusofalse
; =========================================================================
Func _SetupDiOpenDeviceInfo($hDevs, $sInstanceId, ByRef $tSP_DEVINFO_DATA, $iFlag = 0)
	Local $iResult, $pSP_DEVINFO_DATA

	If Not IsDllStruct($tSP_DEVINFO_DATA) Then
		$tSP_DEVINFO_DATA = DllStructCreate($tagSP_DEVICEINFO_DATA)
		DllStructSetData($tSP_DEVINFO_DATA, "Size", 28)
	EndIf
	$pSP_DEVINFO_DATA = DllStructGetPtr($tSP_DEVINFO_DATA)
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiOpenDeviceInfo", _
			"ptr", $hDevs, "str", $sInstanceId, "hWnd", 0, _
			"dword", $iFlag, "ptr", $pSP_DEVINFO_DATA)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[0])
EndFunc	;==>_SetupDiOpenDeviceInfo

; #### FUNCTION ####
; =========================================================================
; Name	: _SetupDiGetDeviceInstallParams
; Description	: This function is used to retrieve the device installation parameters for a selected device information element.
; Parameter(s)	: $hDevs	- Supplies a handle to the device information set.
;		: $pSP_DEVINFO_DATA - A pointer to an SP_DEVINFO_DATA structure contains the device information element from which the installation is retrieved.
;		: ByRef $tSP_DEVINST_PARAMS - Supplies a variable that receives an SP_DEVINSTALL_PARAMS structure fills with the requested data.
; Return values	: Returns TRUE if succeeds, FALSE otherwise, the logged error is set in @error.
; Author	: Pusofalse
; =========================================================================
Func _SetupDiGetDeviceInstallParams($hDevs, $pSP_DEVINFO_DATA, ByRef $tSP_DEVINST_PARAMS)
	Local $iResult, $pSP_DEVINST_PARAMS

	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	If Not IsDllStruct($tSP_DEVINST_PARAMS) Then
		$tSP_DEVINST_PARAMS = DllStructCreate($tagSP_DEVINSTALL_PARAMS)
		DllStructSetData($tSP_DEVINST_PARAMS, 1, DllStructGetSize($tSP_DEVINST_PARAMS))
	EndIf
	$pSP_DEVINST_PARAMS = DllStructGetPtr($tSP_DEVINST_PARAMS)
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiGetDeviceInstallParams", _
			"ptr", $hDevs, "ptr", $pSP_DEVINFO_DATA, _
			"ptr", $pSP_DEVINST_PARAMS)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[0])
EndFunc	;==>_SetupDiGetDeviceInstallParams

; #### FUNCTION ####
; =========================================================================
; Name	: _SetupDiBuildDriverInfoList
; Description	: This function is used to create the driver information set for a selected device information element.
; Parameter(s)	: $hDevs - Supplies a device information set handle.
;		: $pSP_DEVINFO_DATA - Supplies a pointer to an SP_DEVINFO_DATA contains the device information element.
; Return values	: Returns TRUE if succeeds, FALSE otherwise, the logged error is set in @error.
; Author	: Pusofalse
; =========================================================================
Func _SetupDiBuildDriverInfoList($hDevs, $pSP_DEVINFO_DATA)
	Local $iResult, $iType = $SPDIT_CLASSDRIVER

	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	If IsPtr($pSP_DEVINFO_DATA) Then $iType = $SPDIT_COMPATDRIVER 
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiBuildDriverInfoList", _
			"ptr", $hDevs, "ptr", $pSP_DEVINFO_DATA, "int", $iType)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[0])
EndFunc	;==>_SetupDiBuildDriverInfoList

; #### FUNCTION ####
; =========================================================================
; Name	: _SetupDiCallClassInstaller
; Description	: The function calls the appropriate class installer, and any registered co-installers, with the specified installation request (DIF code).
; Parameter(s)	: $hDevs	- A handle to the device information set.
;		: $pSP_DEVINFO_DATA - A pointer (or a structure) to an SP_DEVINFO_DATA contains the device information element.
;		: $iDIFCode - The device installation request (DIF request) to pass to the co-installers and class installer.
; Return values	: Returns TRUE if succeeds, FALSE otherwise, the error code is set to in @error.
; Author	: Pusofalse
; =========================================================================
Func _SetupDiCallClassInstaller($hDevs, $pSP_DEVINFO_DATA, $iDIFCode)
	Local $iResult

	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiCallClassInstaller", _
			"dword", $iDifCode, "ptr", $hDevs, "ptr", $pSP_DEVINFO_DATA)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[0])
EndFunc	;==>_SetupDiCallClassInstaller

Func _SetupDiGetSelectedDriver($hDevs, $pSP_DEVINFO_DATA, ByRef $tSP_DRVINFO_DATA)
	Local $iResult, $pSP_DRVINFO_DATA

	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	If Not IsDllStruct($tSP_DRVINFO_DATA) Then
		$tSP_DRVINFO_DATA = DllStructCreate($tagSP_DRVINFO_DATA)
		DllStructSetData($tSP_DRVINFO_DATA,1,DllStructGetSize($tSP_DRVINFO_DATA)-12)
	EndIf
	$pSP_DRVINFO_DATA = DllStructGetPtr($tSP_DRVINFO_DATA)
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiGetSelectedDriver", _
			"ptr", $hDevs, "ptr", $pSP_DEVINFO_DATA, _
			"ptr", $pSP_DRVINFO_DATA)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[0])
EndFunc	;==>_SetupDiGetSelectedDriver

Func _SetupDiGetDriverInfoDetail($hDevs, $pSP_DEVINFO_DATA, $pSP_DRVINFO_DATA, ByRef $tSP_DRVINFO_DETAIL_DATA)
	Local $iResult, $pSP_DRVINFO_DETAIL_DATA, $iLength, $tagBuffer

	Select
	Case IsDllStruct($pSP_DEVINFO_DATA)
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
		ContinueCase
	Case IsDllStruct($pSP_DRVINFO_DATA)
		$pSP_DRVINFO_DATA = DllStructGetPtr($pSP_DRVINFO_DATA)
		ContinueCase
	Case IsDllStruct($tSP_DRVINFO_DETAIL_DATA) = 0
		$tSP_DRVINFO_DETAIL_DATA = DllStructCreate($tagSP_DRVINFO_DETAIL_DATA)
	EndSelect
	$iLength = DllStructGetSize($tSP_DRVINFO_DETAIL_DATA)
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiGetDriverInfoDetail", _
			"ptr", $hDevs, "ptr", $pSP_DEVINFO_DATA, _
			"ptr", $pSP_DRVINFO_DATA, _
			"ptr", 0, "dword", 0, "dword*", 0)
	$iLength = $iResult[6] - $iLength
	If $iLength > 0 Then
		_SetupDiApiBufferFree($tSP_DRVINFO_DETAIL_DATA)
		$tagBuffer = $tagSP_DRVINFO_DETAIL_DATA & ";char HardwareId[" & $iLength & "]"
		$tSP_DRVINFO_DETAIL_DATA = DllStructCreate($tagBuffer)
		DllStructSetData($tSP_DRVINFO_DETAIL_DATA, 1, $iResult[6] - $iLength + 1)
	EndIf
	$pSP_DRVINFO_DETAIL_DATA = DllStructGetPtr($tSP_DRVINFO_DETAIL_DATA)
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiGetDriverInfoDetail", _
			"ptr", $hDevs, "ptr", $pSP_DEVINFO_DATA, _
			"ptr", $pSP_DRVINFO_DATA, _
			"ptr", $pSP_DRVINFO_DETAIL_DATA, _
			"dword", $iResult[6], "dword*", 0)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[0])
EndFunc	;==>_SetupDiGetDriverInfoDetail

; #### FUNCTION ####
; =================================================================================
; Name	: _SetupDiSetDriverInstallParams
; Description	: The function sets driver installation parameters for a driver information element.
; Parameter(s)	: $hDevs	- A handle to a device information set that contains a driver information element that represents the driver for which to set installation parameters.
;		: $pSP_DEVINFO_DATA - A pointer to an SP_DEVINFO_DATA structure that specifies a device information element in DeviceInfoSet. This parameter is optional and can be set to NULL. If this parameter is specified, _SetupDiSetDriverInstallParams sets the driver installation parameters for the specified device. If this parameter is NULL, SetupDiSetDriverInstallParams sets driver installation parameters for DeviceInfoSet ($hDevs).
;		: $pSP_DRVINFO_DATA - A pointer to an SP_DRVINFO_DATA structure that specifies the driver for which installation parameters are set. If DeviceInfoData is specified, this driver must be a member of a driver list that is associated with DeviceInfoData. If DeviceInfoData is NULL, this driver must be a member of the global class driver list for DeviceInfoSet ($hDevs).
;		: $pSP_DRVINSTALL_PARAMS - A pointer to an SP_DRVINSTALL_PARAMS structure that specifies the new driver install parameters.
; Return values	: The function returns TRUE if it is successful. Otherwise, it returns FALSE and the logged error can be retrieved in @error.
; Author	: Pusofalse
; =================================================================================
Func _SetupDiSetDriverInstallParams($hDevs, $pSP_DEVINFO_DATA, $pSP_DRVINFO_DATA, $pSP_DRVINSTALL_PARAMS)
	Local $iResult

	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	If IsDllStruct($pSP_DRVINFO_DATA) Then
		$pSP_DRVINFO_DATA = DllStructGetPtr($pSP_DRVINFO_DATA)
	EndIf
	If IsDllStruct($pSP_DRVINSTALL_PARAMS) Then
		$pSP_DRVINSTALL_PARAMS = DllStructGetPtr($pSP_DRVINSTALL_PARAMS)
	EndIf
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiSetDriverInstallParams", "ptr", $hDevs, _
			"ptr", $pSP_DEVINFO_DATA, "ptr", $pSP_DRVINFO_DATA, _
			"ptr", $pSP_DRVINSTALL_PARAMS)
	Return SetError(_CM_Get_Last_Error(), 0, $iResult[0])
EndFunc	;==>_SetupDiSetDriverInstallParams

; #### FUNCTION ####
; =================================================================================
; Name	: _SetupDiGetDriverInstallParams
; Description	: The _SetupDiGetDriverInstallParams function retrieves driver installation parameters for a device information set or a particular device information element.
; Parameter(s)	: $hDevs	- A handle to a device information set that contains a driver information element that represents the driver for which to retrieve installation parameters.
;		: $pSP_DEVINFO_DATA - A pointer to an SP_DEVINFO_DATA structure that contains a device information element that represents the device for which to retrieve installation parameters. This parameter is optional and can be NULL. If this parameter is specified, SetupDiGetDriverInstallParams retrieves information about a driver that is a member of a driver list for the specified device. If this parameter is NULL, SetupDiGetDriverInstallParams retrieves information about a driver that is a member of the global class driver list for DeviceInfoSet ($hDevs).
;		: $pSP_DRVINFO_DATA - A pointer to an SP_DRVINFO_DATA structure that specifies the driver information element that represents the driver for which to retrieve installation parameters. If DeviceInfoData is supplied, the driver must be a member of the driver list for the device that is specified by DeviceInfoData. Otherwise, the driver must be a member of the global class driver list for DeviceInfoSet ($hDevs).
;		: $tSP_DRVINSTALL_PARAMS - A variable that receives an SP_DRVINSTALL_PARAMS structure contains the driver installation parameters.
; Return values	: TRUE is returned if the function completed without an error. Otherwise, the function returns FALSE, the logged error is set in @error.
; Author	: Pusofalse
; =================================================================================
Func _SetupDiGetDriverInstallParams($hDevs, $pSP_DEVINFO_DATA, $pSP_DRVINFO_DATA, ByRef $tSP_DRVINSTALL_PARAMS)
	Local $iResult, $pSP_DRVINSTALL_PARAMS, $iSizeofParams

	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	If IsDllStruct($pSP_DRVINFO_DATA) Then
		$pSP_DRVINFO_DATA = DllStructGetPtr($pSP_DRVINFO_DATA)
	EndIf
	If Not IsDllStruct($tSP_DRVINSTALL_PARAMS) Then
		$tSP_DRVINSTALL_PARAMS = DllStructCreate($tagSP_DRVINSTALL_PARAMS)
		$iSizeofParams = DllStructGetSize($tSP_DRVINSTALL_PARAMS)
		DllStructSetData($tSP_DRVINSTALL_PARAMS, "Size", $iSizeofParams)
	EndIf
	$pSP_DRVINSTALL_PARAMS = DllStructGetPtr($tSP_DRVINSTALL_PARAMS)
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiGetDriverInstallParams", "ptr", $hDevs, _
			"ptr", $pSP_DEVINFO_DATA, "ptr", $pSP_DRVINFO_DATA, _
			"ptr", $pSP_DRVINSTALL_PARAMS)
	Return SetError(_CM_Get_Last_Error(), 0, $iResult[0])
EndFunc	;==>_SetupDiGetDriverInstallParams

; #### FUNCTION ####
; ================================================================================
; Name	: _SetupDiGetDriverSigner
; Description	: Retrieves the digital signature for a device instance.
; Parameter(s)	: $hDevs	- Handle to the device information set.
;		: $pSP_DEVINFO_DATA - A pointer to/or an SP_DEVINFO_DATA structure contains the device information element for which to retrieve the digital signature.
; Return values	: Returns signature if succeeds, in text format. Else returns NULL and sets @error to a system error code.
; Author	: Pusofalse
; ================================================================================
Func _SetupDiGetDriverSigner($hDevs, $pSP_DEVINFO_DATA)
	Local $aSigner, $tDrvInfo, $tDrvDetail, $sInf

	Select
	Case _SetupDiBuildDriverInfoList($hDevs, $pSP_DEVINFO_DATA) = 0
		Return SetError(@error, 0, "")
	Case _SetupDiSelectBestCompatDrv($hDevs, $pSP_DEVINFO_DATA) = 0
		Return SetError(@error, 0, "")
	Case _SetupDiGetSelectedDriver($hDevs, $pSP_DEVINFO_DATA, $tDrvInfo) = 0
		Return SetError(@error, 0, "")
	Case _SetupDiGetDriverInfoDetail($hDevs, $pSP_DEVINFO_DATA, $tDrvInfo, $tDrvDetail) = 0
		Return SetError(@error, 0, "")
	Case _SetupDiDestroyDriverInfoList($hDevs, $pSP_DEVINFO_DATA) = 0
		Return SetError(@error, 0, "")
	Case Else
		$sInf = DllStructGetData($tDrvDetail, "InfFileName")
		$aSigner = _SetupDiVerifyDigitalSigner($sInf)
		Return SetError(@error, 0, $aSigner[1])
	EndSelect
EndFunc	;==>_SetupDiGetDriverSigner

; #### FUNCTION ####
; ================================================================================
; Name	: _SetupDiVerifyDigitalSigner
; Description	: Verify an INF file and retrieves its digital signer.
; Parameter(s)	: $sInfFile	- INF file, may specify the full path.
; Return values	: An array in the form:
;		: $aArray[0] - Catalog file.
;		: $aArray[1] - Signature.
;		: $aArray[2] - Signature version.
;		: If fails, all elements of the array are set to NULL, the logged error is set in @error.
; Author	: Pusofalse
; ================================================================================
Func _SetupDiVerifyDigitalSigner($sInfFile)
	Local $iResult, $tBuffer, $aResult[3], $iSysError

	$tBuffer = DllStructCreate($tagSP_INF_SIGNER_INFO)
	DllStructSetData($tBuffer, "Size", DllStructGetSize($tBuffer))

	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupVerifyInfFileW", "wstr", $sInfFile, _
			"ptr", 0, "ptr", DllStructGetPtr($tBuffer))
	If $iResult[0] = 0 Then $iSysError = _CM_Get_Last_Error()
	$aResult[0] = DllStructGetData($tBuffer, "CatalogFile")
	$aResult[1] = DllStructGetData($tBuffer, "DigitalSigner")
	$aResult[2] = DllStructGetData($tBuffer, "DigitalSignerVersion")
	Return SetError($iSysError, _SetupDiApiBufferFree($tBuffer), $aResult)
EndFunc	;==>_SetupDiVerifyDigitalSigner

Func _CM_Update_PnP_Device($sDeviceID, $sInfPath, $iFlags, $hWnd = 0)
	Local $iResult
	$iResult = DllCall($NEWDEV_DllHandle, "int", "UpdateDriverForPlugAndPlayDevices", "hWnd", $hWnd, _
			"str", $sDeviceID, "str", $sInfPath, "dword", $iFlags, "int*", 0)
	Return SetError(_CM_Get_Last_Error(), $iResult[5], $iResult[0])
EndFunc	;==>_CM_Update_PnP_Device

; #### FUNCTION ####
; =========================================================================
; Name	: _CM_Install_Selected_Driver
; Description	: This function installs a selected driver on a selected device.
; Parameter(s)	: $hDevs	- A handle to a device information set that contains the device information element that represents a selected device and a selected driver for the device.
;		: $fBackup	- A BOOL value indicates the backup option, true indicates backs up the currently installed drivers for the selected device, default to true.
;		: $hWnd	- A handle to the top-level window that the this function uses to display user interface components that are associated with installing the driver, can be NULL.
; Return values	: Returns true if the driver was installed on the selected device, in this case, @extended is set to a DWORD value indicate whether a system restart is required to complete the installation. If system restart is required, the value is set to DI_NEEDREBOOT, application should prompt user to restart system to finish the installation.
; Author	: Pusofalse
; =========================================================================
Func _CM_Install_Selected_Driver($hDevs, $fBackup = True, $hWnd = 0)
	Local $iResult
	$iResult = DllCall($NEWDEV_DllHandle, "int", "InstallSelectedDriver", "hWnd", $hWnd, _
			"ptr", $hDevs, "str", "", "int", $fBackup, "dword*", 0)
	Return SetError(_CM_Get_Last_Error(), $iResult[5], $iResult[0])
EndFunc	;==>_CM_Install_Selected_Driver

; #### FUNCTION ####
; =========================================================================
; Name	: _CM_Install_Device_Driver
; Description	: This function updates or installs the device driver for a device instance.
; Parameter(s)	: $sDeviceInstID - Supplies a device instance identifier for which the driver files are installed.
;		: $fBackup - True indicates backup the file installed, False otheriwise, default is True.
;		: $hWnd - Parent window owns the user interface, can be NULL.
; Return values	: If succeeds, returns TRUE, if the device installation needs a system reboot, the function sets @extended to non-zero. If an error occured during the installation, function returns FALSE.
; Author	: Pusofalse
; =========================================================================
Func _CM_Install_Device_Driver($sDeviceInstID, $fBackup = True, $hWnd = 0)
	Local $iResult, $hDevs, $tDevInfo

	Select
	Case _SetupDiCreateDeviceDevs($sDeviceInstID, $hDevs, $tDevInfo) = 0
		Return SetError(@error, 0, 0)
	Case _SetupDiBuildDriverInfoList($hDevs, $tDevInfo) = 0
		Return SetError(@error, _SetupDiDestroyDeviceInfoList($hDevs) * 0, 0)
	Case _SetupDiSelectBestCompatDrv($hDevs, $tDevInfo) = 0
		Return SetError(@error, _SetupDiDestroyDeviceInfoList($hDevs) * 0, 0)
	Case _CM_Install_Selected_Driver($hDevs, $fBackup, $hWnd) = 0
		Return SetError(@error, _SetupDiDestroyDeviceInfoList($hDevs) * 0, 0)
	Case Else
		Return SetError(0, @extended + _SetupDiDestroyDeviceInfoList($hDevs) * 0, 1)
	EndSelect
EndFunc	;==>_CM_Install_Device_Driver

; #### FUNCTION ####
; =========================================================================
; Name	: _CM_Install_New_Device
; Description	: This function installs a new device.
; Parameter(s)	: $vGUID - An optional device class GUID.
;		: $hWnd - Window handle that owns the user interface, can be NULL.
; Return values	: True if succeeded, otherwise FALSE. If a system reboot is requested to finish the device installation, @extended is set to non-zero.
; Author	: Pusofalse
; =========================================================================
Func _CM_Install_New_Device($vGUID = "", $hWnd = 0)
	Local $pGUID, $iResult, $tGUID

	Select
	Case IsDllStruct($vGUID)
		$pGUID = DllStructGetPtr($vGUID)
	Case IsString($vGUID)
		If StringLeft($vGUID, 1) & StringRight($vGUID, 1) = "{}" Then
			$tGUID = _CM_GUID_From_String($vGUID)
		Else
			$tGUID = _SetupDiClassGuidsFromName($vGUID)
		EndIf
		$pGUID = DllStructGetPtr($tGUID)
	EndSelect
	$iResult = DllCall($NEWDEV_DllHandle, "int", "InstallNewDevice", "hWnd", $hWnd, _
			"ptr", $pGUID, "dword*", 0)
	Return SetError(_CM_Get_Last_Error(), $iResult[3], $iResult[0])
EndFunc	;==>_CM_Install_New_Device

; #### FUNCTION ####
; =================================================================================
; Name	: _CM_Install_Selected_Device
; Description	: This function installs a device instance selected in device information set.
; Parameter(s)	: $hDevs	- Supplies a handle to the device information set.
;		: $hWnd	- Window handle related to device installation, can be NULL.
; Return values	: TRUE if succeeds (does not mean the device was installed or updated), FALSE if fails, @error returns the winerror code. If the device installation needs a system reboot, @extended is set to non-zero.
; Author	: Pusofalse
; =================================================================================
Func _CM_Install_Selected_Device($hDevs, $hWnd = 0)
	Local $iResult
	$iResult = DllCall($NEWDEV_DllHandle, "int", "InstallSelectedDevice", "hWnd", $hWnd, _
			"ptr", $hDevs, "dword*", 0)
	Return SetError(_CM_Get_Last_Error(), $iResult[3], $iResult[0])
EndFunc	;==>_CM_Install_Selected_Device

; #### FUNCION ####
; =================================================================================
; Name	: _CM_Install_DevInst_Ex
; Description	: This function is used to install a device instance.
; Parameter(s)	: $sDeviceID	- Supplies the device instance identifier string.
;		: $fUpdateDriver	- TRUE only newer or higher rank drivers are installed.
;		: $fSilent	- TRUE means "Found new device" dialog will not be displayed, default to display (FALSE).
;		: $hWnd	- Window handle of the top-level window to use for any UI related to installing the device, can be NULL specified.
; Return values	: TRUE is returned if succeeds (does not mean the device was installed or updated). FALSE otherwise. If the installation needs a system restart, @extended is set to non-zero.
; Author	: Pusofalse
; =================================================================================
Func _CM_Install_DevInst_Ex($sDeviceID, $fUpdateDriver, $fSilent = False, $hWnd = 0)
	Local $iResult
	$iResult = DllCall($NEWDEV_DllHandle, "int", "InstallDevInstEx", "hWnd", $hWnd, _
			"wstr", $sDeviceID, "int", $fUpdateDriver, "dword*", 0, "int", $fSilent)
	Return SetError(_CM_Get_Last_Error(), $iResult[4], $iResult[0])
EndFunc	;==>_CM_Install_DevInst_Ex

; #### FUNCTION ####
; =========================================================================
; Name	: _InstallNewDevice, obsolete, call _CM_Install_New_Device instead.
; Description	: This function installs a new device. The user is prompted to select the device.
; Parameter(s)	: $vGuid	- A vaiable-type value, indicates the GUID of the device class to install. If NULL is specified for this parameter, the user starts at the detection choice page, if non-NULL for this parameter, it must be in one of the following formats:
;		:	- Class name: NET/Display/Mouse...
;		:	- Class GUID string: {xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}.
;		:	- Class GUID structure.
;		:	- Class GUID pointer.
;		: $hWndOwner	- A handle to the top-level window to be used for any required user interface, can set to NULL.
; Return values	: If no error is occurred, returns true and sets @extended to a DWORD value indicates a system restart whether is requird (DI_NEEDREBOOT indicates the restart behavior is required), else returns false and sets @error to a system code.
; Author	: Pusofalse
; =========================================================================
Func _InstallNewDevice($vGuid = 0, $hWndOwner = 0)
	Local $iResult, $pGuid
	If IsString($vGuid) Then
		If (StringLeft($vGuid, 1) & StringRight($vGuid, 1) = "{}") Then
			$pGuid = DllStructGetPtr(_CM_GUID_From_String($vGuid))
		ElseIf $vGuid <> "" Then
			$tGuid = _SetupDiClassGuidsFromName($vGuid)
			$pGuid = DllStructGetPtr($tGuid)
		EndIf
	ElseIf IsDllStruct($vGuid) Then
		$pGuid = DllStructGetPtr($vGuid)
	ElseIf IsPtr($vGuid) Then
		$pGuid = $vGuid
	Else
		$pGuid = 0
	EndIf

	$iResult = DllCall($NEWDEV_DllHandle, "int", "InstallNewDevice", "hWnd", $hWndOwner, _
			"ptr", $pGuid, "dword*", 0)
	Return SetError(_CM_Get_Last_Error(), $iResult[3], $iResult[0])
EndFunc	;==>_InstallNewDevice

Func _SetupDiCreateDeviceInfo($hDevs, $sDeviceName, $vClassGuid, $iCreationFlags, ByRef $tSP_DEVINFO_DATA, $sDescr = "", $hWndParent = 0)
	Local $iResult, $tClassGuid, $pClassGuid, $pSP_DEVINFO_DATA

	If IsString($vClassGuid) Then
		If (StringLeft($vClassGuid, 1) & StringRight($vClassGuid, 1) = "{}") Then
			$pClassGuid = DllStructGetPtr(_CM_GUID_From_String($vClassGuid))
		ElseIf ($vClassGuid) <> "" Then
			$tClassGuid = _SetupDiClassGuidsFromName($vClassGuid) 
			$pClassGuid = DllStructGetPtr($tClassGuid) 
		EndIf
	ElseIf IsDllStruct($vClassGuid) Then
		$pClassGuid = DllStructGetPtr($vClassGuid) 
	ElseIf IsPtr($vClassGuid) Then
		$pClassGuid = ($vClassGuid) 
	Else
		$pClassGuid = 0
	EndIf
	If $pClassGuid = 0 Then Return SetError(87, 0, 0)

	$tClassGuid = DllStructCreate("byte[16]", $pClassGuid)

	If Not IsDllStruct($tSP_DEVINFO_DATA) Then
		$tSP_DEVINFO_DATA = DllStructCreate($tagSP_DEVICEINFO_DATA)
		DllStructSetData($tSP_DEVINFO_DATA, "Size", 28)
		DllStructSetData($tSP_DEVINFO_DATA, "Guid", DllStructGetData($tClassGuid, 1))
	EndIf
	$pSP_DEVINFO_DATA = DllStructGetPtr($tSP_DEVINFO_DATA)
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiCreateDeviceInfo", _
			"ptr", $hDevs, "str", $sDeviceName, "ptr", $pClassGuid, _
			"str", $sDescr, "hWnd", $hWndParent, "dword", $iCreationFlags, _
			"ptr", $pSP_DEVINFO_DATA)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[0])
EndFunc	;==>_SetupDiCreateDeviceInfo

Func _SetupDiGetDevNodeStatus($hDevInst)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_DevNode_Status", _
			"ulong*", 0, "ulong*", 0, "dword", $hDevInst, "ulong", 0)
	Return SetError($iResult[0], $iResult[2], $iResult[1])
EndFunc	;==>_SetupDiGetDevNodeStatus

; #### FUNCTOIN ####
; =========================================================================
; Name	: _SetupDiChangeState
; Description	: Default handler of DIF_PROPERCHANGE.
; Parameter(s)	: $hDevs	- A pointer to a device information set that contains the device information element.
;		: $pSP_DEVINFO_DATA - A pointer to an SP_DEVINFO_DATA structure contains the device information element for which to change the state.
; Return values	: TRUE is returned if succeeds, FALSE otherwise, the logged error can be get in @error macro.
; Author	: Pusofalse
; =========================================================================
Func _SetupDiChangeState($hDevs, $pSP_DEVINFO_DATA)
	Local $iResult
	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiChangeState", "hWnd", $hDevs, _
			"ptr", $pSP_DEVINFO_DATA)
	Return SetError(_CM_Get_Last_Error(), 0, $iResult[0])
EndFunc	;==>_SetupDiChangeState

; ##### FUNCTION ####
; =========================================================================
; Name	: _SetupDiSetClassInstallParams
; Description	: Sets the installation parameters for a device class.
; Parameter(s)	: $hDevs	- Supplies a handle to the device information set.
;		: $pSP_DEVINFO_DATA - A pointer to an SP_DEVINFO_DATA structure contains the device information set.
;		: $pInst	- A pointer to an SP_CLASSINSTALL_PARAMS structure contains the data to be set.
;		: $iSizeInst	- Size of the $pInst.
; Return values	: TRUE is returned if succeeds, FALSE otherwise, in which case, @error is set to the reason of the failure.
; Author	: Pusofalse
; =========================================================================
Func _SetupDiSetClassInstallParams($hDevs, $pSP_DEVINFO_DATA, $pInst, $iSizeInst)
	Local $iResult

	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	If IsDllStruct($pInst) Then $pInst = DllStructGetPtr($pInst)
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiSetClassInstallParams", _
			"ptr", $hDevs, "ptr", $pSP_DEVINFO_DATA, _
			"ptr", $pInst, "dword", $iSizeInst)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[0])
EndFunc	;==>_SetupDiSetClassInstallParams

; #### FUNCTION ####
; =========================================================================
; Name	: _SetupDiDeviceInstallParams
; Description	: This function sets the installation parameters for a device instance.
; Parameter(s)	: $hDevs	- A handle to the device information set.
;		: $pSP_DEVINFO_DATA - A pointer to an SP_DEVINFO_DATA.
;		: $pSP_DEVINSTALL_PARAMS - A pointer to an SP_DEVINSTALL_PARAMS, contains the installation parameters.
; Return values	: True indicates success, False to failure, in this case, @error is set to a system error code.
; Author	: Pusofalse
; =========================================================================
Func _SetupDiSetDeviceInstallParams($hDevs, $pSP_DEVINFO_DATA, $pSP_DEVINSTALL_PARAMS)
	Local $iResult
	Select
	Case IsDllStruct($pSP_DEVINFO_DATA)
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
		ContinueCase
	Case IsDllStruct($pSP_DEVINSTALL_PARAMS)
		$pSP_DEVINSTALL_PARAMS = DllStructGetPtr($pSP_DEVINSTALL_PARAMS)
	EndSelect
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiSetDeviceInstallParams", _
			"ptr", $hDevs, "ptr", $pSP_DEVINFO_DATA, _
			"ptr", $pSP_DEVINSTALL_PARAMS)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[0])
EndFunc	;==>_SetupDiSetDeviceInstallParams

; #### FUNCTION ####
; =========================================================================
; Name	: _SetupDiEnumDeviceInterfaces
; Description	: This function enumerates the device interfaces for a device instance.
; Parameter(s)	: $hDevs	- A device information set handle.
;		: $pSP_DEVINFO_DATA - A pointer to an SP_DEVINFO_DATA, can be ZERO specified.
;		: $vGUID - GUID for device setup interface.
;		: $iIndex	- Specifies the index to enumerate, zero-based.
;		: $tSP_DEVIFINFO_DATA - Supplies a variable receives a SP_DEVINTERFACE_DATA structure contains the device interface.
; Return values	: TRUE is returned if succeeds, FALSE otherwise. If the enumeration is finished, @error is set to 259.
; Author	: Pusofalse
; =========================================================================
Func _SetupDiEnumDeviceInterfaces($hDevs, $pSP_DEVINFO_DATA, $vGuid, $iIndex, ByRef $tSP_DEVIFINFO_DATA)
	Local $iResult, $pSP_DEVIFINFO

	If IsString($vGuid) Then
		If StringLeft($vGuid, 1) & StringRight($vGuid, 1) = "{}" Then
			Local $tGUID = _CM_GUID_From_String($vGuid)
			$pGuid = DllStructGetPtr($tGUID)
		ElseIf $vGuid <> "" Then
			$tGuid = _SetupDiClassGuidsFromName($vGuid)
			$pGuid = DllStructGetPtr($tGuid)
		EndIf
	ElseIf IsDllStruct($vGuid) Then
		$pGuid = DllStructGetPtr($vGuid)
	ElseIf IsPtr($vGuid) Then
		$pGuid = $vGuid
	Else
		$pGuid = 0
	EndIf
	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	If Not IsDllStruct($tSP_DEVIFINFO_DATA) Then
		$tSP_DEVIFINFO_DATA = DllStructCreate($tagSP_DEV_INTERFACE_DATA)
		DllStructSetData($tSP_DEVIFINFO_DATA, "Size", 28)
	EndIf
	$pSP_DEVIFINFO = DllStructGetPtr($tSP_DEVIFINFO_DATA)

	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiEnumDeviceInterfaces", "hWnd", $hDevs, _
			"ptr", $pSP_DEVINFO_DATA, "ptr", $pGuid, "dword", $iIndex, _
			"ptr", $pSP_DEVIFINFO)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[0])
EndFunc	;==>_SetupDiEnumDeviceInterfaces

Func _SetupDiGetDeviceInterfaceDetail($hDevs, $pSP_DEVIFINFO_DATA, ByRef $tSP_DEVINFO_DATA)
	Local $iResult, $pBuffer, $tBuffer, $sDevicePath, $iSysError = 0, $pSP_DEVINFO_DATA

	Select
	Case Not IsDllStruct($tSP_DEVINFO_DATA)
		$tSP_DEVINFO_DATA = DllStructCreate($tagSP_DEVICEINFO_DATA)
		DllStructSetData($tSP_DEVINFO_DATA, "Size", 28)
		ContinueCase
	Case IsDllStruct($pSP_DEVIFINFO_DATA)
		$pSP_DEVIFINFO_DATA = DllStructGetPtr($pSP_DEVIFINFO_DATA)
	EndSelect

	$pSP_DEVINFO_DATA = DllStructGetPtr($tSP_DEVINFO_DATA)
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiGetDeviceInterfaceDetail", _
			"hWnd", $hDevs, "ptr", $pSP_DEVIFINFO_DATA, _
			"ptr", 0, "dword", 0, "dword*", 0, "ptr", $pSP_DEVINFO_DATA)
	$tBuffer = DllStructCreate("dword;char[" & $iResult[5] - 4 & "]")
	$pBuffer = DllStructGetPtr($tBuffer)
	DllStructSetData($tBuffer, 1, 5)
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiGetDeviceInterfaceDetail", _
			"hWnd", $hDevs, "ptr", $pSP_DEVIFINFO_DATA, _
			"ptr", $pBuffer, "dword", $iResult[5], "dword*", 0, _
			"ptr", $pSP_DEVINFO_DATA)
	If $iResult[0] = 0 Then
		$iSysError = _CM_Get_Last_Error()
	Else
		$sDevicePath = DllStructGetData($tBuffer, 2)
	EndIf
	Return SetError($iSysError, _SetupDiApiBufferFree($tBuffer) or $iResult[0], $sDevicePath)
EndFunc	;==>_SetupDiGetDeviceInterfaceDetail

; #### FUNCTION ####
; =========================================================================
; Name	: _SetupDiDestroyDeviceInfoList
; Description	: Release a device information set.
; Parameter(s)	: $hDevs	- Supplies a handle to the device information set, typically obtained by the following functions:
;		:		_SetupDiCreateDeviceDevs
;		:		_SetupDiCreateDeviceDevsEx
;		:		_SetupDiCreateDeviceInfo
;		:		_SetupDiCreateDeviceInfoEx
;		:		_SetupDiGetClassDevs
;		:		_SetupDiGetClassDevsEx
; Return values	: TRUE indicates success, FALSE indicates failure.
; Author	: Pusofalse
; =========================================================================
Func _SetupDiDestroyDeviceInfoList($hDevs)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiDestroyDeviceInfoList", "hWnd", $hDevs)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[0])
EndFunc	;==>_SetupDiDestroyDeviceInfoList


Func _SetupDiGetHwProfileList()
	Local $iResult, $tBuffer, $pBuffer, $aResult[1][2] = [[0]]

	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiGetHwProfileList", "ptr", 0, _
			"dword", 0, "dword*", 0, "dword*", 0)
	If $iResult[3] = 0 Then Return SetError(_CM_Get_Last_Error(), -1, $aResult)

	$tBuffer = DllStructCreate("dword ProfileID[" & $iResult[3] & "]")
	$pBuffer = DllStructGetPtr($tBuffer)

	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiGetHwProfileList", "ptr", $pBuffer, _
			"dword", $iResult[3], "dword*", 0, "dword*", 0)
	If $iResult[0] = 0 Then Return SetError(_CM_Get_Last_Error(), -1, $aResult)
	$aResult[0][0] = $iResult[3]
	Redim $aResult[$iResult[3] + 1][2]
	For $i = 1 to $iResult[3]
		$aResult[$i][0] = DllStructGetData($tBuffer, "ProfileID", $i)
		$aResult[$i][1] = _SetupDiGetHwProfileFriendlyName($aResult[$i][1])
	Next
	Return SetExtended(_SetupDiApiBufferFree($tBuffer) + $iResult[4], $aResult)
EndFunc	;==>_SetupDiGetHwProfileList

Func _SetupDiGetHwProfileFriendlyName($iProfileID = 0)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiGetHwProfileFriendlyName", _
			"dword", $iProfileID, "ptr", 0, "dword", 0, "dword*", 0)
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiGetHwProfileFriendlyName", _
			"dword", $iProfileID, "str", "", "dword", $iResult[4], "dword*", 0)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[2])
EndFunc	;==>_SetupDiGetHwProfileFriendlyName

; #### FUNCTION (internal used only) ####
; =========================================================================
; _CM_Free_Variable is used to free a dll-structure-typed variable.
; =========================================================================
Func _CM_Free_Variable(ByRef $vVariable)
	$vVariable = 0
EndFunc	;==>_CM_Free_Variable

; #### FUNCTION ####
; =========================================================================
; Name	: _CM_Get_Child
; Description	: Retrieves the first child device instance for a specified devnode, on local system.
; Parameter(s)	: $hDevInst	- A handle to the device instance.
; Return values	: Handle to the first child device instance is returned if success, or zero if failure.
; Related	: _CM_Get_Child_Ex, _CM_Get_Parent, _CM_Get_Sibling
; Author	: Pusofalse
; =========================================================================
Func _CM_Get_Child($hDevInst)
	Local $iResult

	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Child", "dword*", 0, _
			"dword", $hDevInst, "ulong", 0)
	Return SetError($iResult[0], $iResult[0] = 0, $iResult[1])
EndFunc	;==>_CM_Get_Child

; #### FUNCTION ####
; =========================================================================
; Name	: _CM_Get_Parent
; Description	: Retrieves the parent node for a device instance in device tree, on local system.
; Parameter(s)	: $hDevInst	- A device instance handle for which to retrieve the parent node.
; Return values	: Handle to the parent node is returned if success, otherwise returns a value less one.
; Author	: Pusofalse
; =========================================================================
Func _CM_Get_Parent($hDevInst)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Parent", "dword*", 0, _
			"dword", $hDevInst, "ulong", 0)
	Return SetError($iResult[0], $iResult[0] = 0, $iResult[1])
EndFunc	;==>_CM_Get_Parent

Func _CM_Get_Sibling($hDevInst)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Sibling", "dword*", 0, _
			"dword", $hDevInst, "ulong", 0)
	Return SetError($iResult[0], $iResult[0] = 0, $iResult[1])
EndFunc	;==>_CM_Get_Sibling

Func _CM_Get_Depth($hDevInst)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Depth", "dword*", 0, _
			"dword", $hDevInst, "ulong", 0)
	Return SetError($iResult[0], $iResult[0] = 0, $iResult[1])
EndFunc	;==>_CM_Get_Depth

Func _CM_Get_Device_ID($hDevInst)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Device_ID", "dword", $hDevInst, _
			"str", "", "dword", _CM_Get_Device_ID_Size($hDevInst) + 1, "ulong", 0)
	Return SetError(_CM_Get_Last_Error(), $iResult[0] = 0, $iResult[2])
EndFunc	;==>_CM_Get_Device_ID

Func _CM_Get_Device_ID_Size($hDevInst)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Device_ID_Size", "ulong*", 0, _
			"dword", $hDevInst, "ulong", 0)
	Return SetError($iResult[0], 0, $iResult[1])
EndFunc	;==>_CM_Get_Device_ID_Size

; #### FUNCTION ####
; ===================================================================================
; Name	: _CM_Get_Device_ID_List
; Description	: This function retrieves the device ID strings for the device instance in an array, on the local system.
; Parameter(s)	: See _CM_Get_Device_ID_List_Ex for details.
; Return values	: The return value is same to _CM_Get_Device_ID_List_Ex's.
; Author	: Pusofalse
; ===================================================================================
Func _CM_Get_Device_ID_List($sFilter = "", $iFlags = $CM_GETIDLIST_FILTER_NONE)
	Local $iResult, $iLength, $aResult[1] = [0], $pBuffer, $tBuffer, $iPointer, $pBuffer1, $iLength2

	$iLength = _CM_Get_Device_ID_List_Size($sFilter, $iFlags) + 1
	If $iLength < 2 Then Return SetError(@error, 0, $aResult)
	$pBuffer = _CM_Heap_Alloc($iLength)

	Do
		$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Device_ID_List", "str", $sFilter, _
				"ptr", $pBuffer, "ulong", $iLength, "ulong", $iFlags)
		If $iResult[0] = $CR_BUFFER_SMALL Then
			_CM_Heap_Free($pBuffer)
			$iLength += 2
			$pBuffer = _CM_Heap_Alloc($iLength + 128)
		EndIf
	Until	$iResult[0] <> $CR_BUFFER_SMALL
	$pBuffer1 = $pBuffer

	While $iPointer < $iLength
		$tBuffer = DllStructCreate("char DeviceID[512]", $pBuffer)
		$aResult[0] += 1
		Redim $aResult[$aResult[0] + 1]
		$aResult[$aResult[0]] = DllStructGetData($tBuffer, "DeviceID")
		If $aResult[$aResult[0]] = "" Then ExitLoop
		$iLength2 = StringLen($aResult[$aResult[0]]) + 1
		$iPointer += $iLength2
		$pBuffer += $iLength2
	WEnd

	_CM_Heap_Free($pBuffer1)
	If $aResult[0] = 0 Then Return SetError($iResult[0], 0, $aResult)
	$aResult[0] -= 1
	Redim $aResult[$aResult[0] + 1]
	Return SetError($iResult[0], 0, $aResult)
EndFunc	;==>_CM_Get_Device_ID_List

; #### FUNCTION ####
; ===================================================================================
; Name	: _CM_Get_Device_ID_List_Size
; Description	: Return the buffer length required to hold the device ID strings.
; Parameter(s)	: See _CM_Get_Device_ID_List_Size_Ex for details.
; Return values	: Length required.
; Author	: Pusofalse
; ===================================================================================
Func _CM_Get_Device_ID_List_Size($sFilter = "", $iFlags = $CM_GETIDLIST_FILTER_NONE)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Device_ID_List_Size", "ulong*", 0, _
			"str", $sFilter, "ulong", $iFlags)
	Return SetError($iResult[0], 0, $iResult[1])
EndFunc	;==>_CM_Get_Device_ID_List_Size

; #### FUNCTION ####
; ===================================================================================
; Name	: _CM_Enumerate_Enumerators
; Description	: Lists the device enumerators on the local system.
; Parameter(s)	: This function has no parameters.
; Return values	: If succeeds, returns an array with following format:
;		:	- $aArray[0] - The number of returned entries.
;		:	- $aArray[1] - 1st enumerator's name.
;		:	- $aArray[2] - 2nd enumerator's name.
;		:	- ... ...
; Author	: Pusofalse
; ===================================================================================
Func _CM_Enumerate_Enumerators()
	Local $aResult[1] = [0], $iResult

	While 1
		$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Enumerate_Enumerators", _
				"ulong", $aResult[0], "str", "", "ulong*", 32, "ulong", 0)
		If $iResult[0] Then ExitLoop
		$aResult[0] += 1
		Redim $aResult[$aResult[0] + 1]
		$aResult[$aResult[0]] = $iResult[2]
	WEnd
	Return SetError($iResult[0], 0, $aResult)
EndFunc	;==>_CM_Enumerate_Enumerators

; #### FUNCTION ####
; ===================================================================================
; Name	: _CM_Enumerate_Classes
; Description	: This function lists the device setup classes on the local system.
; Parameter(s)	: This function has no parameters.
; Return values	: An array in the following form:
;		:	- $aArray[0][0] - The number of returned classes.
;		:	- $aArray[1][0] - The GUID of 1st class, in string format.
;		:	- $aArray[1][1] - Description for 1st class.
;		:	- $aArray[2][0] - The GUID of 2nd class, in string format.
;		:	- $aArray[2][1] - Description for 2nd class.
;		:	- ... ...
; Author	: Pusofalse
; ===================================================================================
Func _CM_Enumerate_Classes()
	Local $iResult, $pGUID, $aResult[1][2] = [[0]]

	$pGUID = _CM_Heap_Alloc(32)
	While 1
		$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Enumerate_Classes", _
				"ulong", $aResult[0][0], "ptr", $pGUID, "ulong", 0)
		If $iResult[0] = $CR_NO_SUCH_VALUE Then ExitLoop
		$aResult[0][0] += 1
		Redim $aResult[$aResult[0][0] + 1][2]
		$aResult[$aResult[0][0]][0] = _CM_String_From_GUID($pGUID)
		$aResult[$aResult[0][0]][1] = _SetupDiGetClassDescription($pGUID)
	WEnd
	Return SetError($iResult[0], _CM_Heap_Free($pGUID), $aResult)
EndFunc	;==>_CM_Enumerate_Classes

Func _CM_Get_DevNode_Status($hDevInst)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_DevNode_Status", _
			"ulong*", 0, "ulong*", 0, "dword", $hDevInst, "ulong", 0)
	Return SetError($iResult[0], $iResult[2], $iResult[1])
EndFunc	;==>_CM_Get_DevNode_Status


Func _CM_Request_Device_Eject($hDevInst, ByRef $sVetoName)
	Local $iResult, $hToken
	Local $aPriv[2][2] = [[$SE_UNDOCK_NAME, 2], [$SE_LOAD_DRIVER_NAME, 2]]

	$hToken = _OpenProcessToken(-1)
	_AdjustTokenPrivileges($hToken, $aPriv)
	_LsaCloseHandle($hToken)

	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Request_Device_Eject", "dword", $hDevInst, _
			"int*", 0, "str", "", "ulong", 260, "ulong", 0)
	$sVetoName = $iResult[3]
	Return SetError($iResult[0], $iResult[2], $iResult[0] = 0)
EndFunc	;==>_CM_Request_Device_Eject

Func _CM_Query_And_Remove_SubTree($hDevInst, $iFlags, ByRef $sVeto)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Query_And_Remove_SubTree", _
			"dword", $hDevInst, "int*", 0, "str", "", "ulong", 260, "ulong", $iFlags)
	$sVeto = $iResult[3]
	Return SetError($iResult[0], $iResult[2], $iResult[0] = 0)
EndFunc	;==>_CM_Query_And_Remove_SubTree


Func _CM_Get_Device_Interface_List_Size($pInterfaceClassGuid, $sDevId = "", $iFlags = 0)
	Local $iResult

	If IsDllStruct($pInterfaceClassGuid) Then
		$pInterfaceClassGuid = DllStructGetPtr($pInterfaceClassGuid)
	ElseIf IsString($pInterfaceClassGuid) Then
		Local $tGUID = _CM_GUID_From_String($pInterfaceClassGuid)
		$pInterfaceClassGuid = DllStructGetPtr($tGUID)
	EndIf
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Device_Interface_List_Size", _
			"ulong*", 0, "ptr", $pInterfaceClassGuid, "str", $sDevId, "ulong", $iFlags)
	Return SetError($iResult[0], $iResult[0] = 0, $iResult[1])
EndFunc	;==>_CM_Get_Device_Interface_List_Size

Func _CM_Get_Device_Interface_List($pInterfaceClassGuid, $sDevId = "", $iFlags = 0)
	Local $iResult, $iLength, $tBuffer, $pBuffer, $pBuffer1, $aResult[1] = [0], $iLen

	If IsDllStruct($pInterfaceClassGuid) Then
		$pInterfaceClassGuid = DllStructGetPtr($pInterfaceClassGuid)
	ElseIf IsString($pInterfaceClassGuid) Then
		Local $tGUID = _CM_GUID_From_String($pInterfaceClassGuid)
		$pInterfaceClassGuid = DllStructGetPtr($tGUID)
	EndIf
	$iLength = _CM_Get_Device_Interface_List_Size($pInterfaceClassGuid, $sDevId, $iFlags)
	$tBuffer = DllStructCreate("char ID[" & $iLength & "]") - 1
	$pBuffer = DllStructGetPtr($tBuffer)
	$pBuffer1 = $pBuffer + $iLength

	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Device_Interface_List", _
			"ptr", $pInterfaceClassGuid, "str", $sDevId, "ptr", $pBuffer, _
			"ulong", $iLength, "ulong", $iFlags)

	While Number($pBuffer) < Number($pBuffer1) - 1
		$aResult[0] += 1
		Redim $aResult[$aResult[0] + 1]
		$aResult[$aResult[0]] = DllStructGetData($tBuffer, "ID")
		$pBuffer += StringLen($aResult[$aResult[0]]) + 1
		$iLength -= StringLen($aResult[$aResult[0]]) + 1
		$tBuffer = 0
		$tBuffer = DllStructCreate("char ID[" & $iLength & "]", $pBuffer)
	WEnd
	Return SetError($iResult[0], _CM_Free_Variable($tBuffer), $aResult)
EndFunc	;==>_CM_Get_Device_Interface_List


Func _CM_Get_Next_Res_Des(ByRef $iResDes, $iResourceID)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Next_Res_Des", _
			"long*", 0, "long", $iResDes, "long", $iResourceID, _
			"long*", 0, "ulong", 0)
	If $iResult[0] Then Return SetError($iResult[0], 0, 0)
	_CM_Free_Res_Des_Handle($iResDes)
	$iResDes = $iResult[1]
	Return SetExtended($iResult[4], 1)
EndFunc	;==>_CM_Get_Next_Res_Des

Func _CM_Get_Res_Des_Data_Size(ByRef $iResDes)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Res_Des_Data_Size", _
			"ulong*", 0, "long", $iResDes, "ulong", 0)
	Return SetError($iResult[0], $iResult[0] = 0, $iResult[1])
EndFunc	;==>_CM_Get_Res_Des_Data_Size

Func _CM_Get_Res_Des_Data(ByRef $iResDes)
	Local $pBuffer, $iLength, $iResult

	$iLength = _CM_Get_Res_Des_Data_Size($iResDes)
	$pBuffer = _CM_Heap_Alloc($iLength)

	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Res_Des_Data", _
			"long", $iResDes, "ptr", $pBuffer, "ulong", $iLength, "ulong", 0)
	Return SetError($iResult[0], ($iResult[0] = 0), $pBuffer)
EndFunc	;==>_CM_Get_Res_Des_Data

; #### FUNCTION ####
; ================================================================================
; Function		: Obsolete, do not use. Call _CM_Get_Device_Resources_Ex instead.
; ================================================================================
Func _CM_Get_Device_Resources($hDevInst, $iResourceType)
	Local $hConf, $aResult[1] = [0], $pBuffer, $tagStructure, $tBuffer

	Switch $iResourceType
	Case $RESTYPE_IO
		$tagStructure = $tagIO_DES
	Case $RESTYPE_MEM
		$tagStructure = $tagMEM_DES
	Case $RESTYPE_IRQ
		$tagStructure = $tagIRQ_DES
	Case $RESTYPE_DMA
		$tagStructure = $tagDMA_DES
	Case $RESTYPE_BUSNUMBER
		$tagStructure = $tagBUSNUMBER_DES
	Case Else
		Return SetError(50, 0, $aResult)
	EndSwitch

	$hConf = _CM_Get_First_Log_Conf($hDevInst, 2)
	If @error or $hConf = 0 Then Return SetError(@error, 0, $aResult)

	While _CM_Get_Next_Res_Des($hConf, $iResourceType)
		$aResult[0] += 1
		Redim $aResult[$aResult[0] + 1]
		$pBuffer = _CM_Get_Res_Des_Data($hConf)
		$tBuffer = DllStructCreate($tagStructure, $pBuffer)
		Switch $iResourceType
		Case $RESTYPE_MEM, $RESTYPE_IO, $RESTYPE_BUSNUMBER
			$aResult[$aResult[0]] &= "0x" & Hex(DllStructGetData($tBuffer, "AllocBase"))
			$aResult[$aResult[0]] &= " - 0x" & Hex(DllStructGetData($tBuffer, "AllocEnd"))
		Case $RESTYPE_IRQ
			$aResult[$aResult[0]] = DllStructGetData($tBuffer, "AllocNum")
		Case $RESTYPE_DMA
			$aResult[$aResult[0]] = DllStructGetData($tBuffer, "AllocChannel")
		EndSwitch
		_CM_Heap_Free($pBuffer)
		_CM_Free_Variable($tBuffer)
	WEnd
	Return $aResult
EndFunc	;==>_CM_Get_Device_Resources

Func _CM_Get_First_Log_Conf($hDevInst, $iFlags)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_First_Log_Conf", "long*", 0, _
			"dword", $hDevInst, "ulong", $iFlags)
	Return SetError($iResult[0], $iResult[0] = 0, $iResult[1])
EndFunc	;==>_CM_Get_First_Log_Conf

Func _CM_Get_Process_Heap()
	Local $iResult
	$iResult = DllCall($Kernel32_DllHandleA, "long", "GetProcessHeap")
	Return $iResult[0]
EndFunc	;==>_CM_Get_Process_Heap

Func _CM_Heap_Alloc($iLength, $iFlags = 8)
	If $iLength < 1 Then Return 0

	Local $pMem, $hHeap = _CM_Get_Process_Heap()
	$pMem = DllCall($Kernel32_DllHandleA, "ptr", "HeapAlloc", "hWnd", $hHeap, _
			"dword", $iFlags, "dword", $iLength)
	Return $pMem[0]
EndFunc	;==>_CM_Heap_Alloc

Func _CM_Heap_Free(ByRef $pMem)
	If $pMem < 1 Then Return SetError(87, 0, False)

	Local $iResult, $hHeap = _CM_Get_Process_Heap()
	$iResult = DllCall($Kernel32_DllHandleA, "int", "HeapFree", "hWnd", $hHeap, _
			"dword", 0, "ptr", $pMem)
	If $iResult[0] Then $pMem = Ptr(0)
	Return $iResult[0] <> 0
EndFunc	;==>_CM_Heap_Free

Func _CM_Heap_Size($pMem)
	If $pMem < 1 Then Return SetError(87, 0, 0)

	Local $iResult, $hHeap = _CM_Get_Process_Heap()
	$iResult = DllCall($Kernel32_DllHandleA, "long", "HeapSize", "hWnd", $hHeap, _
			"dword", 0, "ptr", $pMem)
	Return $iResult[0]
EndFunc	;==>_CM_Heap_Size

Func _CM_Modify_Res_Des($iResDes, $iResourceID, $pData, $iLength)
	Local $iResult

	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Modify_Res_Des", "long*", 0, _
			"long", $iResDes, "long", $iResourceID, "ptr", $pData, _
			"ulong", $iLength, "ulong", 0)
	Return SetError($iResult[0], $iResult[0] = 0, $iResult[0] = 0)
EndFunc	;==>_CM_Modify_Res_Des

Func _CM_Free_Res_Des(ByRef $iResDes)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Free_Res_Des", "long*", 0, _
			"ulong", $iResDes, "ulong", 0)
	Return SetError($iResult[0], $iResult[0] = 0, $iResult[1])
EndFunc	;==>_CM_Free_Res_Des

Func _CM_Free_Res_Des_Handle(ByRef $iResDes)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Free_Res_Des_Handle", "long", $iResDes)
	Return SetError($iResult[0], $iResult[0] = 0, $iResult[0] = 0)
EndFunc	;==>_CM_Free_Res_Des_Handle

Func _CM_Free_Log_Conf(ByRef $hLogConf)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Free_Log_Conf", "long", $hLogConf, "long", 0)
	Return SetError($iResult[0], $iResult[0] = 0, $iResult[0] = 0)
EndFunc	;==>_CM_Free_Log_Conf

Func _CM_Free_Log_Conf_Handle(ByRef $hLogConf)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Free_Log_Conf_Handle", "long", $hLogConf)
	Return SetError($iResult[0], $iResult[0] = 0, $iResult[0] = 0)
EndFunc	;==>_CM_Free_Log_Conf_Handle

Func _CM_Add_Res_Des(ByRef $hLogConf, $iResourceID, $pData, $iLength)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Add_Res_Des", "long*", 0, _
			"long", $hLogConf, "long", $iResourceID, "ptr", $pData, _
			"ulong", $iLength, "ulong", 0)
	Return SetError($iResult[0], $iResult[0] = 0, $iResult[1])
EndFunc	;==>_CM_Add_Res_Des

Func _CM_Get_Next_Log_Conf(ByRef $hLogConf)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Next_Log_Conf", "long*", 0, _
			"long", $hLogConf, "ulong", 0)
	If $iResult[0] Then Return SetError($iResult[0], 0, 0)
	_CM_Free_Log_Conf_Handle($hLogConf)
	$hLogConf = $iResult[1]
	Return SetExtended(1, 1)
EndFunc	;==>_CM_Get_Next_Log_Conf

Func _CM_Get_Last_Error()
	Local $iResult
	$iResult = DllCall($Kernel32_DllHandleA, "long", "GetLastError")
	Return $iResult[0]
EndFunc	;==>_CM_Get_Last_Error

Func _CM_GUID_From_String($sGUID)
	Local $tGUID = DllStructCreate("byte Guid[16]"), $iResult

	$iResult = DllCall("Ole32.dll", "int", "CLSIDFromString", "wstr", $sGUID, "ptr", DllStructGetPtr($tGUID))
	Return SetError($iResult[0], 0, $tGUID)
EndFunc	;==>_CM_GUID_From_String

Func _CM_String_From_GUID($pGUID)
	Local $iResult

	If IsDllStruct($pGUID) Then $pGUID = DllStructGetPtr($pGUID)
	$iResult = DllCall("Ole32.dll", "int", "StringFromGUID2", _
			"ptr", $pGUID, "wstr", "", "int", 128)
	Return $iResult[2]
EndFunc	;==>_CM_String_From_GUID

; #### FUNCTION ####
; ===================================================================================
; Name	: _CM_Device_IO_Control
; Description	: Control a device.
; Parameter(s)	: $hDevice	- Handle to the device, returned by _CM_Create_File.
;		: $iCtrlCode	- Control code.
;		: $pIn	- A pointer to a buffer as a IN parameter.
;		: $iSizeIn	- Size of $pIn.
;		: $pOut	- A pointer to a buffer as a OUT parameter.
;		: $iSizeOut	- Size of $pOut.
;		: $pOverlapped	- A pointer to a OVERLAPPED structure, if $hDevice is created without OVERLAPPED flag, this parameter can be NULL.
; Return values	: Returns TRUE if succeeds, otherwise returns FALSE.
; Author	: Pusofalse
; ===================================================================================
Func _CM_Device_IO_Control($hDevice, $iCtrlCode, $pIn, $iSizeIn, $pOut, $iSizeOut, $pOverlapped = 0)
	Local $iResult

	If IsDllStruct($pIn) Then $pIn = DllStructGetPtr($pIn)
	If IsDllStruct($pOut) Then $pOut = DllStructGetPtr($pOut)
	If IsDllStruct($pOverlapped) Then $pOverlapped = DllStructGetPtr($pOverLapped)
	$iResult = DllCall($Kernel32_DllHandleA, "int", "DeviceIoControl", "ptr", $hDevice, _
			"dword", $iCtrlCode, "ptr", $pIn, "dword", $iSizeIn, _
			"ptr", $pOut, "dword", $iSizeOut, "int*", 0, "ptr", $pOverlapped)
	Return SetError(_CM_Get_Last_Error(), $iResult[7], $iResult[0])
EndFunc	;==>_CM_Device_IO_Control

Func _CM_Write_Device($hFile, $pBuffer, $iSizeofBuffer, $pOverlap = 0, $sBufferType = "ptr")
	Local $iResult

	If IsDllStruct($pBuffer) Then $pBuffer = DllStructGetPtr($pBuffer)
	$iResult = DllCall($Kernel32_DllHandleA, "int", "WriteFile", "hWnd", $hFile, _
			$sBufferType, $pBuffer, "dword", $iSizeofBuffer, _
			"dword*", 0, "ptr", $pOverlap)
	If @error Then Return SetError(1, 0, 0)
	Return SetError(_CM_Get_Last_Error(), $iResult[4], $iResult[0])
EndFunc	;==>_CM_Write_Device

Func _CM_Read_Device($hFile, $pBuffer, $iSizeofBuffer, $pOverlap = 0)
	Local $iResult

	$iResult = DllCall($Kernel32_DllHandleA, "int", "ReadFile", "hWnd", $hFile, _
			"ptr", $pBuffer, "dword", $iSizeofBuffer, "dword*", 0, "ptr", $pOverlap)
	Return SetError(_CM_Get_Last_Error(), $iResult[4], $iResult[0])
EndFunc	;==>_CM_Read_Device

Func _CM_Create_File($sFile, $iAccess, $iShare, $pSecurAttr, $iCreation, $iFlags, $hTemplate = 0)
	Local $iResult

	$iResult = DllCall($Kernel32_DllHandleA, "long", "CreateFile", "str", $sFile, _
			"dword", $iAccess, "dword", $iShare, "ptr", $pSecurAttr, _
			"dword", $iCreation, "dword", $iFlags, "long", $hTemplate)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[0])
EndFunc	;==>_CM_Create_File

Func _CM_Open_File(Byref $hFile, $iDesiredAccess, $pObject, $iShareAccess, $iFlags)
	Local $iResult, $pIO = _CM_Heap_Alloc(16)

	$iResult = DllCall("Ntdll.dll", "dword", "NtOpenFile", "hWnd*", 0, "dword", $iDesiredAccess, _
			"ptr", $pObject, "ptr", $pIO, "ulong", $iShareAccess, "ulong", $iFlags)
	$hFile = $iResult[1]
	_CM_Heap_Free($pIO)
	Return SetError(_LsaNtStatusToWinError($iResult[0]), 0, $iResult[0] = 0)
EndFunc	;==>_CM_Open_File

Func _CM_Open_Device(ByRef $hDevice, $hDevInst, $iDesiredAccess, $iShareAccess, $iFlags)
	Local $sPhysName, $pObject, $tBuffer, $iSysError, $fResult, $pBufferW

	$sPhysName = _CM_Get_DevNode_Registry_Property($hDevInst, 0xF)
	If $sPhysName = "" Then Return SetError(@error, 0, 0)

	$pObject = _LsaInitializeObjectAttributes($sPhysName)
	$fResult = _CM_Open_File($hDevice, $iDesiredAccess, $pObject, $iShareAccess, $iFlags)
	$iSysError = @error
	$tBuffer = DllStructCreate($tagOBJECT_ATTRIBUTES, $pObject)
	$pBufferW = DllStructGetData($tBuffer, "BufferW")
	_CM_Heap_Free($pBufferW)
	_CM_Heap_Free($pObject)
	_CM_Free_Variable($tBuffer)
	Return SetError($iSysError, 0, $fResult)
EndFunc	;==>_CM_Open_Device

Func _CM_Close_Handle($hHandle)
	Local $iResult
	$iResult = DllCall($Kernel32_DllHandleA, "int", "CloseHandle", "long", $hHandle)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[0])
EndFunc	;==>_CM_Close_Handle

Func _CM_Assign_Var(ByRef $vVariable, $vValue = 0, $vReturn = "", $iError = 0, $iExtended = 0)
	$vVariable = $vValue
	Return SetError($iError, $iExtended, $vReturn)
EndFunc	;==>_CM_Assign_Var

Func _SetupDiOpenDeviceInterface($hDevs, $sDevicePath, ByRef $tSP_DEVIFINFO_DATA, $iFlags = 0)
	Local $iResult, $pSP_DEVIFINFO_DATA

	If Not IsDllStruct($tSP_DEVIFINFO_DATA) Then
		$tSP_DEVIFINFO_DATA = DllStructCreate($tagSP_DEV_INTERFACE_DATA)
		DllStructSetData($tSP_DEVIFINFO_DATA, "Size", 28)
	EndIf
	$pSP_DEVIFINFO_DATA = DllStructGetPtr($tSP_DEVIFINFO_DATA)
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiOpenDeviceInterface", _
			"hWnd", $hDevs, "str", $sDevicePath, "dword", $iFlags, _
			"ptr", $pSP_DEVIFINFO_DATA)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[0])
EndFunc	;==>_SetupDiOpenDeviceInterface


; #### FUNCTION ####
; ===================================================================================
; Name	: _SetupDiGetDeviceInterfaceDevInst
; Description	: Specifies the device path, retrieves the device instance handle.
; Parameter(s)	: $sDevicePath	- Device path, in string format.
; Return values	: A value of non-zero indicates the handle to the device instance if succeeds.
; Author	: Pusofalse
; ===================================================================================
Func _SetupDiGetDeviceInterfaceDevInst($sDevicePath)
	Local $iResult, $hDevs, $tDevIfInfo, $tDevInfo, $hDevInst

	$hDevs = _SetupDiGetClassDevs($DIGCF_ALLCLASSES)
	Select
	Case _SetupDiOpenDeviceInterface($hDevs, $sDevicePath, $tDevIfInfo) = 0
		Return SetError(@error, 0, _SetupDiDestroyDeviceInfoList($hDevs) * 0)
	Case _SetupDiGetDeviceInterfaceDetail($hDevs, $tDevIfInfo, $tDevInfo) <> $sDevicePath
		Return SetError(@error, 0, _SetupDiDestroyDeviceInfoList($hDevs) * 0)
	EndSelect
	$hDevInst = DllStructGetData($tDevInfo, "DevInst")
	_CM_Assign_Var($tDevInfo)
	_CM_Assign_Var($tDevIfInfo)
	_SetupDiDestroyDeviceInfoList($hDevs)
	Return $hDevInst
EndFunc	;==>_SetupDiGetDeviceInterfaceDevInst

; #### FUNCTION ####
; ===================================================================================
; Name	: _SetupDiRemoveDevice
; Description	: This function removes a device.
; Parameter(s)	: $hDevs	- Supplies a device information set handle.
;		: $pSP_DEVINFO_DATA - A pointer to a SP_DEVINFO_DATA structure contains the device information element to be removed.
;		: $fForce	- A BOOL value. If device information element specified in $pSP_DEVINFO_DATA is a non-removable device and this value is set  to FALSE, the function failed with ERROR_INVALID_PARAMETER. Otherwise, this parameter is ignored.
; Return values	: True indicates success, False indicates failure.
; Author	: Pusofalse
; ===================================================================================
Func _SetupDiRemoveDevice($hDevs, $pSP_DEVINFO_DATA, $fForce = False)
	Local $iResult, $hDevInst, $iNodeStat, $tDevInfo

	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	If Not IsPtr($pSP_DEVINFO_DATA) Then Return SetError(87, 0, 0)

	$tDevInfo = DllStructCreate($tagSP_DEVICEINFO_DATA, $pSP_DEVINFO_DATA)
	$hDevInst = DllStructGetData($tDevInfo, "DevInst")
	If $hDevInst = 0 Then Return SetError(87, 0, 0)
	$iNodeStat = _SetupDiGetDevNodeStatus($hDevInst)
	If $fForce = False AND bitAND($iNodeStat, $DN_REMOVABLE) <> $DN_REMOVABLE Then
		Return SetError(87, 0, 0)
	EndIf

	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiRemoveDevice", _
			"ptr", $hDevs, "ptr", $pSP_DEVINFO_DATA)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[0])
EndFunc	;==>_SetupDiRemoveDevice

Func _SetupDiUnremoveDevice($hDevs, $pSP_DEVINFO_DATA)
	Local $iResult

	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiUnremoveDevice", _
			"ptr", $hDevs, "ptr", $pSP_DEVINFO_DATA)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[0])
EndFunc	;==>_SetupDiUnremoveDevice

; #### FUNCTION ####
; ===================================================================================
; Name	: _SetupDiCreateDeviceDevs
; Description	: Creates a device information set for a device instance.
; Parameter(s)	: $sDeviceID	- Device instance identifier, in string format.
;		: $hDevs	- A variable receives the handle the device information set.
;		: $tDevInfo	- A variable receives an SP_DEVINFO_DATA structure that contains the device information element.
;		: $vGUID	- A device class GUID, can be NULL.
;		: $hWnd	- A window handle owns the handle the device information set, can be NULL.
; Return values	: True indicates success, False indicates failure, in which case, @error is set to a system error code.
; Author	: Pusofalse
; ===================================================================================
Func _SetupDiCreateDeviceDevs($sDeviceID, ByRef $hDevs, ByRef $tDevInfo, $vGuid = "", $hWnd = 0)
	$hDevs = _SetupDiCreateDeviceInfoList($vGuid, $hWnd)
	If Number($hDevs) < 1 Then Return SetError(@error, 0, 0)
	If _SetupDiOpenDeviceInfo($hDevs, $sDeviceID, $tDevInfo) = 0 Then
		Return SetError(@error, 0, _SetupDiDestroyDeviceInfoList($hDevs) * 0)
	ElseIf _SetupDiSetSelectedDevice($hDevs, $tDevInfo) = 0 Then
		Return SetError(@error, 0, _SetupDiDestroyDeviceInfoList($hDevs) * 0)
	EndIf
	Return 1
EndFunc	;==>_SetupDiCreateDeviceDevs

; #### FUNCTION ####
; ===================================================================================
; Name	: _SetupDiDisableDevice
; Description	: Disables or enables a device instance.
; Parameter(s)	: $hDevs	- Handle to the device information set.
;		: $pSP_DEVINFO_DATA - A pointer to a SP_DEVINFO_DATA structure contains the device information element to be disabled.
;		: $fDisable	- True to disable, False to enable, default to True.
; Return values	: If succeeds, returns true. Otherwise returns False and sets @error to a system error code.
; Author	: Pusofalse
; ===================================================================================
Func _SetupDiDisableDevice($hDevs, $pSP_DEVINFO_DATA, $fDisable = True)
	Local $hDevInst, $iDevNode, $tInstParam, $tDevInfo

	If $hDevs = 0 Then Return SetError(87, 0, 0)
	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf

	$tDevInfo = DllStructCreate($tagSP_DEVICEINFO_DATA, $pSP_DEVINFO_DATA)
	$hDevInst = DllStructGetData($tDevInfo, "DevInst")
	If $hDevInst = 0 Then Return SetError(87, 0, 0)

	$iDevNode = _CM_Get_DevNode_Status($hDevInst)
	If ($fDisable = (@extended = 22)) Then Return SetError(85, 0, 1)
	If bitAND($iDevNode, $DN_DISABLEABLE) <> $DN_DISABLEABLE Then
		Return SetError(50, 0, 0)
	EndIf

	$tInstParam = DllStructCreate($tagSP_PROPCHANGE_PARAMS)
	DllStructSetData($tInstParam, "Size", 8)
	DllStructSetData($tInstParam, "DIFCode", $DIF_PROPERTYCHANGE)
	DllStructSetData($tInstParam, "Scope", $DICS_FLAG_GLOBAL)
	DllStructSetData($tInstParam, "HWProfile", 0)
	If $fDisable = True Then
		DllStructSetData($tInstParam, "State", $DICS_DISABLE)
		_CM_Set_DevNode_CSConfigFlags($hDevInst, $CSCONFIGFLAG_DISABLED)
	Else
		DllStructSetData($tInstParam, "State", $DICS_ENABLE)
		_CM_Set_DevNode_CSConfigFlags($hDevInst, $CSCONFIGFLAG_NONE)
	EndIf

	Select
	Case _SetupDiSetClassInstallParams($hDevs, $pSP_DEVINFO_DATA, $tInstParam, 20) = 0
		Return SetError(@error, _CM_Free_Variable($tInstParam), 0)
	Case _SetupDiChangeState($hDevs, $pSP_DEVINFO_DATA) = 0
		Return SetError(@error, _CM_Free_Variable($tInstParam), 0)
	Case Else
		Return SetError(@error, _CM_Free_Variable($tInstParam), 1)
	EndSelect
EndFunc	;==>_SetupDiDisableDevice

; #### FUNCTION ####
; ===================================================================================
; Name	: _CM_Format_Problem_Message
; Description	: Retrieves the problem message text for a problem code.
; Parameter(s)	: $iProblemCode	- A value of problem code.
; Return values	: Error message, or NULL if failed.
; Author	: Pusofalse
; ===================================================================================
Func _CM_Format_Problem_Message($iProblemCode)
	Local $sErrMsgs, $aErrMsgs, $sMsg

	If $iProblemCode = 0 Then Return "This deivce is working properly."
	If $iProblemCode < 1 OR $iProblemCode > 50 Then Return ""
	$sErrMsgs = "This device is not configured correctly. (Code 1)" & @LF & _
"Windows could not load the driver for this device because the computer is reporting two <bustype> bus types. (Code 2)" & @LF & _
"The driver for this device might be corrupted, or your system may be running low on memory or other resources. (Code 3)" & @LF & _
"This device is not working properly because one of its drivers may be bad, or your registry may be bad. (Code 4)" & @LF & _
"The driver for this device requested a resource that Windows does not know how to handle. (Code 5)" & @LF & _
"Another device is using the resources this device needs. (Code 6)" & @LF & _
"The drivers for this device need to be reinstalled. (Code 7)" & @LF & _
"Device failure: Try changing the driver for this device. If that doesn't work, see your hardware documentation. (Code 8)" & @LF & _
"Windows cannot identify this hardware because it does not have a valid hardware identification number. (Code 9)" & @LF & _
"This device cannot start. (Code 10)" & @LF & _
"Windows stopped responding while attempting to start this device, and therefore will never attempt to start this device again. (Code 11)" & @LF & _
"This device cannot find enough free resources that it can use. (Code 12)" & @LF & _
"This device is either not present, not working properly, or does not have all the drivers installed. (Code 13)" & @LF & _
"This device cannot work properly until you restart your computer. (Code 14)" & @LF & _
"This device is causing a resource conflict. (Code 15)" & @LF & _
"Windows cannot identify all the resources this device uses. (Code 16)" & @LF & _
"The driver information file (INF-file-name) is telling this child device to use a resource that the parent device does not have or recognize. (Code 17)" & @LF & _
"Reinstall the drivers for this device. (Code 18)" & @LF & _
"Windows cannot start this hardware device because its configuration information (in the registry) is incomplete or damaged. (Code 19)" & @LF & _
"Windows could not load one of the drivers for this device. (Code 20)" & @LF & _
"Windows is removing this device. (Code 21)" & @LF & _
"This device is disabled. (Code 22)" & @LF & _
"This display adapter is functioning correctly. (Code 23)" & @LF & _
"This device is not present, is not working properly, or does not have all its drivers installed. (Code 24)" & @LF & _
"Windows is in the process of setting up this device. (Code 25)" & @LF & _
"Windows is in the process of setting up this device. (Code 26)" & @LF & _
"Windows can't specify the resources for this device. (Code 27)" & @LF & _
"The drivers for this device are not installed. (Code 28)" & @LF & _
"This device is disabled because the firmware of the device did not give it the required resources. (Code 29)" & @LF & _
"This device is using an Interrupt Request (IRQ) resource that is in use by another device and cannot be shared. You must change the conflicting setting or remove the real-mode driver causing the conflict. (Code 30)" & @LF & _
"This device is not working properly because Windows cannot load the drivers required for this device. (Code 31)" & @LF & _
"A driver (service) for this device has been disabled. An alternate driver may be providing this functionality. (Code 32)" & @LF & _
"Windows cannot determine which resources are required for this device. (Code 33)" & @LF & _
"Windows cannot determine the settings for this device. Consult the documentation that came with this device and use the Resource tab to set the configuration. (Code 34)" & @LF & _
"Your computer's system firmware does not include enough information to properly configure and use this device. To use this device, contact your computer manufacturer to obtain a firmware or BIOS update. (Code 35)" & @LF & _
"This device is requesting a PCI interrupt but is configured for an ISA interrupt (or vice versa). Please use the computer's system setup program to reconfigure the interrupt for this device. (Code 36)" & @LF & _
"Windows cannot initialize the device driver for this hardware. (Code 37)"

$sErrMsgs &= @LF &"Windows cannot load the device driver for this hardware because a previous instance of the device driver is still in memory. (Code 38)" & @LF & _
"Windows cannot load the device driver for this hardware. The driver may be corrupted or missing. (Code 39)" & @LF & _
"Windows cannot access this hardware because its service key information in the registry is missing or recorded incorrectly (Code 40)" & @LF & _
"Windows successfully loaded the device driver for this hardware but cannot find the hardware device. (Code 41)" & @LF & _
"Windows cannot load the device driver for this hardware becuse there is a duplicate device already running in the system. (Code 42)" & @LF & _
"Windows has stopped this device because it has reported problems. (Code 43)" & @LF & _
"An application or service has shut down this hardware device. (Code 44)" & @LF & _
"Currently, this hardware device is not connected to the computer. (Code 45)" & @LF & _
"Windows cannot gain access to this hardware device because the operating system is in the process of shutting down. (Code 46)" & @LF & _
"Windows cannot use this hardware device because it has been prepared for 'safe removal', but it has not been removed from the computer. (Code 47)" & @LF & _
"The software for this device has been blocked from starting because it is known to have problems with Windows. Contact the hardware vendor for a new driver. (Code 48)" & @LF & _
"Windows cannot start new hardware devices because the system hive is too large (exceeds the Registry Size Limit). (Code 49)" & @LF & _
"Windows cannot apply all of the properties for this device. Device properties may include information that describes the device's capabilities and settings (such as security settings for example). (Code 50)"
	$aErrMsgs = StringSplit($sErrMsgs, @LF)
	$sMsg = $aErrMsgs[$iProblemCode]
	_CM_Free_Variable($aErrMsgs)
	Return SetError(_CM_Assign_Var($sErrMsgs, ""), "", $sMsg)
EndFunc	;==>_CM_Format_Problem_Message

Func _CM_Get_Version()
	Local $iResult = DllCall($SETUPAPI_DllHandle, "ushort", "CM_Get_Version")
	Return $iResult[0]
EndFunc	;==>_CM_Get_Version

Func _CM_Is_Version_Available($wVersion)
	Local $iResult = DllCall($SETUPAPI_DllHandle, "int", "CM_Is_Version_Available", "short", $wVersion)
	Return $iResult[0] <> 0
EndFunc	;==>CM_Is_Version_Available

Func _CM_Locate_DevNode($sDeviceID, $iFlags = $CM_LOCATE_DEVNODE_NORMAL)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Locate_DevNode", "dword*", 0, _
			"str", $sDeviceID, "ulong", $iFlags)
	Return SetError($iResult[0], $iResult[0] = 0, $iResult[1])
EndFunc	;==>_CM_Locate_DevNode

Func _CM_Reenumerate_DevNode($hDevInst, $iFlags = $CM_REENUMERATE_NORMAL)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Reenumerate_DevNode", _
			"dword", $hDevInst, "ulong", $iFlags)
	Return SetError($iResult[0], $iResult[0] = 0, $iResult[0] = 0)
EndFunc	;==>_CM_Reenumerate_DevNode

Func _SetupDiSelectBestCompatDrv($hDevs, $pSP_DEVINFO_DATA)
	Local $iResult
	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiSelectBestCompatDrv", _
			"long", $hDevs, "ptr", $pSP_DEVINFO_DATA)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[0])
EndFunc	;==>_SetupDiSelectBestCompatDrv

Func _SetupDiSelectDevice($hDevs, $pSP_DEVINFO_DATA)
	Local $iResult
	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiSelectDevice", _
			"long", $hDevs, "ptr", $pSP_DEVINFO_DATA)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[0])
EndFunc	;==>SetupDiSelectDevice

Func _SetupDiInstallDevice($hDevs, $pSP_DEVINFO_DATA)
	Local $iResult
	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiInstallDevice", _
			"long", $hDevs, "ptr", $pSP_DEVINFO_DATA)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[0])
EndFunc	;==>_SetupDiInstallDevice

Func _SetupDiRegisterDeviceInfo($hDevs, $pSP_DEVINFO_DATA, $iFlags, ByRef $tSP_DEVINFO_DATA_DUP)
	Local $iResult, $pSP_DEVINFO_DATA_DUP

	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	If Not IsDllStruct($tSP_DEVINFO_DATA_DUP) Then
		$tSP_DEVINFO_DATA_DUP = DllStructCreate($tagSP_DEVICEINFO_DATA)
		DllStructSetData($tSP_DEVINFO_DATA_DUP, "Size", 28)
	EndIf
	$pSP_DEVINFO_DATA_DUP = DllStructGetPtr($tSP_DEVINFO_DATA_DUP)
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiRegisterDeviceInfo", "long", $hDevs, _
			"ptr", $pSP_DEVINFO_DATA, "dword", $iFlags, "ptr", 0, "ptr", 0, _
			"ptr", $pSP_DEVINFO_DATA_DUP)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[0])
EndFunc	;==>_SetupDiRegisterDeviceInfo

Func _CM_Set_DevNode_Problem($hDevInst, $iProblemCode)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Set_DevNode_Problem", _
			"dword", $hDevInst, "ulong", $iProblemCode, "ulong", 0)
	Return SetError($iResult[0], $iResult[0] = 0, $iResult[0] = 0)
EndFunc	;==>_CM_Set_DevNode_Problem

Func _SetupDiCreateDeviceInterface($hDevs, $pSP_DEVINFO_DATA, $vGUID, ByRef $tSP_DEVIFINFO_DATA, $sReference = "")
	Local $iResult, $pSP_DEVIFINFO_DATA, $tGUID, $pGUID
	If IsString($vGUID) Then
		If StringLeft($vGUID, 1) & StringRight($vGUID, 1) = "{}" Then
			$tGUID = _CM_GUID_From_String($vGUID)
			$pGUID = DllStructGetPtr($tGUID)
		ElseIf $vGuid <> "" Then
			$tGUID = _SetupDiClassGuidsFromName($vGUID)
			$pGUID = DllStructGetPtr($tGUID)
		EndIf
	ElseIf IsDllStruct($vGUID) Then
		$pGUID = DllStructGetPtr($vGUID)
	ElseIf IsPtr($vGUID) Then
		$pGUID = $vGUID
	Else
		$pGUID = 0
	EndIf
	If $pGUID = 0 Then Return SetError(87, 0, 0)

	Select
	Case IsDllStruct($pSP_DEVINFO_DATA)
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
		ContinueCase
	Case IsDllStruct($tSP_DEVIFINFO_DATA) = 0
		$tSP_DEVIFINFO_DATA = DllStructCreate($tagSP_DEV_INTERFACE_DATA)
		DllStructSetData($tSP_DEVIFINFO_DATA, "Size", 28)
	EndSelect
	If Not IsPtr($pSP_DEVINFO_DATA) Then Return SetError(87, 0, 0)
	$pSP_DEVIFINFO_DATA = DllStructGetPtr($tSP_DEVIFINFO_DATA)

	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiCreateDeviceInterface", _
			"long", $hDevs, "ptr", $pSP_DEVINFO_DATA, _
			"ptr", $pGUID, "str", $sReference, "dword", 0, _
			"ptr", $pSP_DEVIFINFO_DATA)
	Return SetError(_CM_Get_Last_Error(), _CM_Free_Variable($tGUID), $iResult[0])
EndFunc	;==>_SetupDiCreateDeviceInterface

Func _SetupDiEnumDriverInfo($hDevs, $pSP_DEVINFO_DATA, $iIndex, ByRef $tSP_DRVINFO_DATA)
	Local $iResult, $pSP_DRVINFO_DATA, $iType = $SPDIT_CLASSDRIVER

	Select
	Case IsDllStruct($pSP_DEVINFO_DATA)
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
		ContinueCase
	Case IsDllStruct($tSP_DRVINFO_DATA) = 0
		$tSP_DRVINFO_DATA = DllStructCreate($tagSP_DRVINFO_DATA)
		DllStructSetData($tSP_DRVINFO_DATA, 1, DllStructGetSize($tSP_DRVINFO_DATA) - 12)
	EndSelect
	$pSP_DRVINFO_DATA = DllStructGetPtr($tSP_DRVINFO_DATA)
	If IsPtr($pSP_DEVINFO_DATA) Then $iType = $SPDIT_COMPATDRIVER

	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiEnumDriverInfo", "long", $hDevs, _
			"ptr", $pSP_DEVINFO_DATA, "dword", $iType, _
			"dword", $iIndex, "ptr", $pSP_DRVINFO_DATA)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[0])
EndFunc	;==>_SetupDiEnumDriverInfo

Func _SetupDiDestroyDriverInfoList($hDevs, $pSP_DEVINFO_DATA)
	Local $iResult, $iType = $SPDIT_CLASSDRIVER

	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	If IsPtr($pSP_DEVINFO_DATA) Then $iType = $SPDIT_COMPATDRIVER
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiDestroyDriverInfoList", _
			"long", $hDevs, "ptr", $pSP_DEVINFO_DATA, "dword", $iType)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[0])
EndFunc	;==>_SetupDiDestroyDriverInfoList


Func _SetupDiGetClassBitmapIndex($vGUID)
	Local $iResult, $pGUID

	If IsString($vGUID) Then
		If StringLeft($vGUID, 1) & StringRight($vGUID, 1) = "{}" Then
			$tGUID = _CM_GUID_From_String($vGUID)
			$pGUID = DllStructGetPtr($tGUID)
		ElseIf $vGuid <> "" Then
			$tGUID = _SetupDiClassGuidsFromName($vGUID)
			$pGUID = DllStructGetPtr($tGUID)
		EndIf
	ElseIf IsDllStruct($vGUID) Then
		$pGUID = DllStructGetPtr($vGUID)
	ElseIf IsPtr($vGUID) Then
		$pGUID = $vGUID
	Else
		$pGUID = 0
	EndIf

	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiGetClassBitmapIndex", _
			"ptr", $pGUID, "uint*", 0)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[2])
EndFunc	;==>_SetupDiGetClassBitmapIndex

Func _SetupDiGetClassImageList(ByRef $tSP_CLASSIMAGE_DATA)
	Local $iResult, $pSP_CLASSIMAGE_DATA

	If Not IsDllStruct($tSP_CLASSIMAGE_DATA) Then
		$tSP_CLASSIMAGE_DATA = DllStructCreate($tagSP_CLASSIMAGE_DATA)
		DllStructSetData($tSP_CLASSIMAGE_DATA, "Size", 12)
	EndIf
	$pSP_CLASSIMAGE_DATA = DllStructGetPtr($tSP_CLASSIMAGE_DATA)
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiGetClassImageList", _
			"ptr", $pSP_CLASSIMAGE_DATA)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], DllStructGetData($tSP_CLASSIMAGE_DATA, 2))
EndFunc	;==>_SetupDiGetClassImageList

Func _SetupDiDestroyClassImageList($pSP_CLASSIMAGELIST_DATA)
	Local $iResult
	If IsDllStruct($pSP_CLASSIMAGELIST_DATA) Then
		$pSP_CLASSIMAGELIST_DATA = DllStructGetPtr($pSP_CLASSIMAGELIST_DATA)
	EndIf
	If Not IsPtr($pSP_CLASSIMAGELIST_DATA) Then Return SetError(87, 0, 0)
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiDestroyClassImageList", _
			"ptr", $pSP_CLASSIMAGELIST_DATA)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[0])
EndFunc	;==>_SetupDiDestroyClassImageList

Func _SetupDiGetClassImageIndex($vGUID, $pSP_CLASSIMAGE_DATA = 0)
	Local $iResult, $tSP_CLASSIMAGE_DATA, $pGUID, $iError, $tGUID

	If $pSP_CLASSIMAGE_DATA = 0 Then
		_SetupDiGetClassImageList($tSP_CLASSIMAGE_DATA)
		$pSP_CLASSIMAGE_DATA = DllStructGetPtr($tSP_CLASSIMAGE_DATA)
	ElseIf IsDllStruct($pSP_CLASSIMAGE_DATA) Then
		$pSP_CLASSIMAGE_DATA = DllStructGetPtr($pSP_CLASSIMAGE_DATA)
	EndIf
	If Not IsPtr($pSP_CLASSIMAGE_DATA) Then Return SetError(87, 0, -1)

	If IsString($vGUID) Then
		If StringLeft($vGUID, 1) & StringRight($vGUID, 1) = "{}" Then
			$tGUID = _CM_GUID_From_String($vGUID)
			$pGUID = DllStructGetPtr($tGUID)
		ElseIf $vGuid <> "" Then
			$tGUID = _SetupDiClassGuidsFromName($vGUID)
			$pGUID = DllStructGetPtr($tGUID)
		EndIf
	ElseIf IsDllStruct($vGUID) Then
		$pGUID = DllStructGetPtr($vGUID)
	ElseIf IsPtr($vGUID) Then
		$pGUID = $vGUID
	Else
		$pGUID = 0
	EndIf
	If $pGUID = 0 Then Return SetError(87, 0, -1)
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiGetClassImageIndex", _
			"ptr", $pSP_CLASSIMAGE_DATA, "ptr", $pGUID, "int*", -1)
	$iError = _CM_Get_Last_Error()
	If IsDllStruct($tSP_CLASSIMAGE_DATA) Then
		_SetupDiDestroyClassImageList($pSP_CLASSIMAGE_DATA)
	EndIf
	$tGUID = 0
	Return SetError($iError, $iResult[0], $iResult[3])
EndFunc	;==>_SetupDiGetClassImageIndex

Func _CM_Get_Volume_Path($sVolumeGUID)
	Local $iResult
	$iResult = DllCall($Kernel32_DllHandleA, "int", "GetVolumePathNamesForVolumeName", _
			"str", $sVolumeGUID, "str", "", "dword", 32, "dword*", 0)
	If StringRight($iResult[2], 1) = "\" Then $iResult[2] = StringTrimRight($iResult[2], 1)
	Return $iResult[2]
EndFunc	;==>_CM_Get_Volume_Path

Func _CM_Get_Volume_Name($sVolume)
	Local $iResult
	If StringRight($sVolume, 1) <> "\" Then $sVolume &= "\"
	$iResult = DllCall($Kernel32_DllHandleA, "int", "GetVolumeNameForVolumeMountPoint", _
			"str", $sVolume, "str", "", "dword", 260)
	Return SetError(_CM_Get_Last_Error(), 0, $iResult[2])
EndFunc	;==>_CM_Get_Volume_Name

Func _CM_Scan_Device_Changes($sDevNode = "")
	Local $hDevInst, $fResult

	$hDevInst = _CM_Locate_DevNode($sDevNode)
	If $hDevInst < 1 Then Return SetError(@error, 0, 0)
	$fResult = _CM_Reenumerate_DevNode($hDevInst)
	Return SetError(@error, 0, $fResult)
EndFunc	;==>_CM_Scan_Device_Changes

Func _CM_Scan_Device_Changes_Ex($hMachine, $sDevNode = "")
	Local $hDevIntst, $iResult

	$hDevInst = _CM_Locate_DevNode_Ex($sDevNode, $hMachine)
	If $hDevInst < 1 Then Return SetError(@error, 0, 0)
	$iResult = _CM_Reenumerate_DevNode_Ex($hDevInst, $hMachine)
	Return SetError(@error, 0, $iResult)
EndFunc	;==>_CM_Scan_Device_Changes_Ex


Func _CM_Query_Device_Problem($hDevInst)
	Return _CM_Query_Device_Problem_Ex($hDevInst, 0)
EndFunc	;==>_CM_Query_Device_Problem

Func _CM_Query_Device_Problem_Ex($hDevInst, $hMachine)
	Local $iDevNodeStat, $iProblemCode

	$iDevNodeStat = _CM_Get_DevNode_Status_Ex($hDevInst, $hMachine)
	$iProblemCode = @extended
	If bitAND($iDevNodeStat, $DN_HAS_PROBLEM) = $DN_HAS_PROBLEM Then
		Return _CM_Format_Problem_Message($iProblemCode)
	ElseIf bitAND($iDevNodeStat, $DN_NEED_RESTART) = $DN_NEED_RESTART Then
		Return "A system reboot is requested to finish with the device installation."
	EndIf
	Return "This device is working properly."
EndFunc	;==>_CM_Query_Device_Problem_Ex

Func _SetupDiGetINFClass($sInfFileName, ByRef $sGUID)
	Local $iResult, $pGUID = _CM_Heap_Alloc(16)

	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiGetINFClass", "str", $sInfFileName, _
			"ptr", $pGUID, "str", "", "dword", 0, "dword*", 0)
	If $iResult[5] = 0 Then Return SetError(_CM_Get_Last_Error(), 0, "")
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiGetINFClass", "str", $sInfFileName, _
			"ptr", $pGUID, "str", "", "dword", $iResult[5], "dword*", 0)
	$sGUID = _CM_String_From_GUID($pGUID)
	Return SetExtended(_CM_Heap_Free($pGuid), $iResult[3])
EndFunc	;==>_SetupDiGetINFClass

Func _SetupDiLoadDeviceIcon($hDevs, $pSP_DEVINFO_DATA, $iWidth = 32, $iHeight = 32)
	Local $iResult
	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiLoadDeviceIcon", "ptr", $hDevs, _
			"ptr", $pSP_DEVINFO_DATA, "uint", $iWidth, "uint", $iHeight, _
			"dword", 0, "hWnd*", 0)
	If @error Then Return SetError(1, 0, -1)
	Return SetError(_CM_Get_Last_Error(), 0, $iResult[6])
EndFunc	;==>_SetupDiLoadDeviceIcon

Func _SetupDiLoadClassIcon($vGUID)
	Local $iResult, $tGUID, $pGUID

	If IsString($vGUID) Then
		If StringLeft($vGUID, 1) & StringRight($vGUID, 1) = "{}" Then
			$tGUID = _CM_GUID_From_String($vGUID)
		Else
			$tGUID = _SetupDiClassGuidsFromName($vGUID)
		EndIf
		$pGUID = DllStructGetPtr($tGUID)
	ElseIf IsDllStruct($vGUID) Then
		$pGUID = DllStructGetPtr($vGUID)
	ElseIf IsPtr($vGUID) Then
		$pGUID = $vGUID
	Else
		Return SetError(87, 0, -1)
	EndIf
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiLoadClassIcon", "ptr", $pGUID, _
			"hWnd*", 0, "int*", 0)
	Return SetError(_CM_Get_Last_Error(), $iResult[3], $iResult[2])
EndFunc	;==>_SetupDiLoadClassIcon


Func _SetupDiOpenDevRegKey($hDevs, $pSP_DEVINFO_DATA, $iAccess, $iScope = 1, $iHwProfile = 0, $iKeyType = 1)
	Local $iResult
	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	$iResult = DllCall($SETUPAPI_DllHandle, "hWnd", "SetupDiOpenDevRegKey", "ptr", $hDevs, _
			"ptr", $pSP_DEVINFO_DATA, "dword", $iScope, "dword", $iHwProfile, _
			"dword", $iKeyType, "dword", $iAccess)
	If $iResult[0] = 0 Then Return SetError(_CM_Get_Last_Error(), 0, 0)
	Return $iResult[0]
EndFunc	;==>_SetupDiOpenDevRegKey

Func _CM_Create_Device_Devs($hDevInst, ByRef $hDevs, ByRef $tSP_DEVINFO_DATA)
	Local $sDevInstID = _CM_Get_Device_ID($hDevInst)
	If _SetupDiCreateDeviceDevs($sDevInstID, $hDevs, $tSP_DEVINFO_DATA) = 0 Then
		Return SetError(@error, 0, 0)
	EndIf
	Return 1
EndFunc	;==>_CM_Create_Device_Devs

Func _CM_Create_Device_Devs_Ex($hDevInst, ByRef $hDevs, ByRef $tSP_DEVINFO_DATA, $sMachine)
	Local $hMachine, $sDeviceID, $fResult

	$hMachine = _CM_Connect_Machine($sMachine)
	If @error Then Return SetError(@error, 0, 0)
	$sDeviceID = _CM_Get_Device_ID_Ex($hDevInst, $hMachine)
	If @error Then Return SetError(@error, _CM_Disconnect_Machine($hMachine), 0)
	_CM_Disconnect_Machine($hMachine)

	If _SetupDiCreateDeviceDevsEx($sDeviceID, $hDevs, $tSP_DEVINFO_DATA, $sMachine) Then
		Return 1
	Else
		Return SetError(@error, 0, _SetupDiApiBufferFree($tSP_DEVINFO_DATA) * 0)
	EndIf
EndFunc	;==>_CM_Create_Device_Devs_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _SetupDiGetClassDevsEx
; Description	: This function obtains a device information set on a local or a remote system.
; Parameter(s)	: $iFlags	- One or more of the following values:
;		: - DIGCF_ALLCLASSES: Return a list of installed devices for the specified device setup classes or device interface classes.
;		: - DIGCF_DEVICEINTERFACE: Return devices that support device interfaces for the specified device interface classes. This flag must be set in the $iFlags parameter if the $sEnumerator parameter specifies a device instance ID.
;		: - DIGCF_DEFAULT: Return only the device that is associated with the system default device interface, if one is set, for the specified device interface classes.
;		: - DIGCF_PRESENT: Return only devices that are currently present.
;		: - DIGCF_PROFILE: Return only devices that are a part of the current hardware profile.
;		: $vGUID	- Device class GUID, for examples, specifiy 'NET' for this parameter to retrieve the net adapters device information set.
;		: $sEnumerator -  A pointer to a NULL-terminated string that specifies: An identifier (ID) of a Plug and Play (PnP) enumerator. This ID can either be the enumerator¡¯s globally unique identifier (GUID) or symbolic name. For example, ¡°PCI¡± can be used to specify the PCI PnP enumerator. Other examples of symbolic names for PnP enumerators include ¡°USB¡±, ¡°PCMCIA¡±, and ¡°SCSI¡±. A PnP device instance IDs. When specifying a PnP device instance ID, DIGCF_DEVICEINTERFACE must be set in the $Flags parameter. This parameter is optional and can be set to NULL.
;		: $sMachine	- Specifies the system on which the function executes, default to local.
;		: $hDevs	- The handle to an existing device information set to which SetupDiGetClassDevsEx adds the requested device information elements. This parameter is optional and can be set to NULL.
; Return values	: Returns a handle to the device information set contains the device information elements, if succeeds; otherwise returns INVALID_HANDLE_VALUE (-1), in which case, @error is set to a system error code.
; Author	: Pusofalse
; ====================================================================================
Func _SetupDiGetClassDevsEx($iFlags, $vGUID = "", $sEnumerator = "", Const $sMachine = "", $hDevs = 0)
	Local $iResult, $tGUID, $pGUID, $sType = "ptr"

	If $sEnumerator <> "" Then $sType = "str"
	If IsString($vGUID) Then
		If StringLeft($vGUID, 1) & StringRight($vGUID, 1) = "{}" Then
			$tGUID = _CM_GUID_From_String($vGUID)
			$pGUID = DllStructGetPtr($tGUID)
		ElseIf $vGUID <> "" Then
			$tGUID = _SetupDiClassGUIDsFromName($vGUID)
			$pGUID = DllStructGetPtr($tGUID)
		EndIf
	ElseIf IsDllStruct($vGUID) Then
		$pGUID = DllStructGetPtr($vGUID)
	ElseIf IsPtr($vGUID) Then
		$pGUID = $vGUID
	Else
		$pGUID = 0
	EndIf

	$iResult = DllCall($SETUPAPI_DllHandle, "ptr", "SetupDiGetClassDevsEx", "ptr", $pGUID, _
			$sType, $sEnumerator, "hWnd", 0, "dword", $iFlags, _
			"ptr", $hDevs, "str", $sMachine, "ptr", 0)
	If $iResult[0] = 0xFFFFFFFF Then Return SetError(_CM_Get_Last_Error(), 0, -1)
	Return $iResult[0]
EndFunc	;==>_SetupDiGetClassDevsEx

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Connect_Machine
; Description	: The _CM_Connect_Machine function creates a connection to a remote machine.
; Parameter(s)	: $sUncSystem	- System name, in UNC format.
; Return values	: Returns a machine handle if success, else returns INVALID_HANDLE_VALUE (0xFFFFFFFF).
; Author	: Pusofalse
; ====================================================================================
Func _CM_Connect_Machine($sUncSystem)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Connect_Machine", "str", $sUncSystem, "ptr*", 0)
	Return SetError($iResult[0], 0, $iResult[2])
EndFunc	;==>_CM_Connect_Machine

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Disconnect_Machine
; Description	: The _CM_Disconnect_Machine function removes a connection to a remote machine.
; Parameter(s)	: $hMachine	- A machine handle, returned by _CM_Connect_Machine.
; Return values	: True indicates success, False otherwise.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Disconnect_Machine($hMachine)
	Local $iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Disconnect_Machine", "ptr", $hMachine)
	Return SetError($iResult[0], 0, $iResult[0] = $CR_SUCCESS)
EndFunc	;==>_CM_Disconnect_Machine

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Get_Child_Ex
; Description	: The _CM_Get_Child_Ex function is used to retrieve a device instance handle to the first child node of a specified device node (devnode) in a local or a remote machine's device tree.
; Parameter(s)	: $hDevInst	- A device instance handle under which the child node is retrieved.
;		: $hMachine	- A machine handle.
; Return values	: Returns the device node handle if succeeds, else returns zero and sets @error to a configuration manager error code.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Get_Child_Ex($hDevInst, $hMachine)
	Local $iResult
	$iResult  = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Child_Ex", "dword*", 0, _
			"dword", $hDevInst, "ulong", 0, "ptr", $hMachine)
	Return SetError($iResult[0], 0, $iResult[1])
EndFunc	;==>_CM_Get_Child_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Get_Depth_Ex
; Description	: The function is used to obtain the depth of a specified device node (devnode) within a local or a remote machine's device tree.
; Parameter(s)	: $hDevInst - A handle to a device instance.
;		: $hMachine	- A handle to a machine.
; Return values	: If success, returns the depth value, else @error is set to non-zero.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Get_Depth_Ex($hDevInst, $hMachine)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Depth_Ex", "ulong*", 0, _
			"dword", $hDevInst, "ulong", 0, "ptr", $hMachine)
	Return SetError($iResult[0], 0, $iResult[1])
EndFunc	;==>_CM_Get_Depth_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Get_Parent_Ex
; Description	: This function obtains a device instance handle to the parent node of a specified device node (devnode) in a local or a remote machine's device tree.
; Parameter(s)	: $hDevInst	- A device instance handle.
;		: $hMachine	- A machine handle.
; Return values	: Retrieves the parent device node handle if success, otherwise returns zero and sets @error to a configuration manager error code.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Get_Parent_Ex($hDevInst, $hMachine)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Parent_Ex", "dword*", 0, _
			"dword", $hDevInst, "ulong", 0, "ptr", $hMachine)
	Return SetError($iResult[0], 0, $iResult[1])
EndFunc	;==>_CM_Get_Parent_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Get_Sibling_Ex
; Description	: This function obtains a device instance handle to the sibling node of a specified device node (devnode) in a local or a remote machine's device tree.
; Parameter(s)	: $hDevInst	- A handle to a device instance.
;		: $hMachine	- A handle to a machine.
; Return values	: A device instance handle indicates success, else returns zero and sets @error to a CR_* value.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Get_Sibling_Ex($hDevInst, $hMachine)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Sibling_Ex", "dword*", 0, _
			"dword", $hDevInst, "ulong", 0, "ptr", $hMachine)
	Return SetError($iResult[0], 0, $iResult[1])
EndFunc	;==>_CM_Get_Sibling_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Get_Version_Ex
; Description	: The _CM_Get_Version_Ex function returns version 4.0 of the Plug and Play (PNP) Configuration Manager DLL (Cfgmgr32.dll) for a local or a remote machine. 
; Parameter(s)	: $hMachine	- Supplies a machine handle, returned by _CM_Connect_Machine.
; Return values	: If the function succeeds, it returns the major revision number in the high-order byte and the minor revision number in the low-order byte. Version 4.0 is returned as 0x0400. Version 4.0 is supported by default by Microsoft Windows NT 4.0 and later versions of Windows. If an internal error occurs, the function returns 0x0000. Call GetLastError to obtain the error code for the failure.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Get_Version_Ex($hMachine)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "short", "CM_Get_Version_Ex", "ptr", $hMachine)
	Return $iResult[0]
EndFunc	;==>_CM_Get_Version_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Locate_DevNode_Ex
; Description	: Obtains a device instance handle to the device node that is associated with a specified device instance identifier, on a local machine or a remote machine.
; Parameter(s)	: $sDevInstID - A device instance ID string on which the device instance handle is returned, a value of NULL indicates the root of the device tree.
;		: $hMachine	- A machine handle.
;		: $iFlags	- One of the following values:
;		:	- CM_LOCATE_DEVNODE_NORMAL: The function retrieves the device instance handle for the specified device only if the device is currently configured in the device tree.
;		:	- CM_LOCATE_DEVNODE_PHANTOM: The function retrieves a device instance handle for the specified device if the device is currently configured in the device tree or the device is a nonpresent device that is not currently configured in the device tree.
;		:	- CM_LOCATE_DEVNODE_CANCELREMOVE: The function retrieves a device instance handle for the specified device if the device is currently configured in the device tree or in the process of being removed for the device tree. If the device is in the process of being removed, the function cancels the removal of the device.
; Return values	: If succeeds, returns the specified device instance handle, else returns zero.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Locate_DevNode_Ex($sDevInstID, $hMachine, $iFlags = $CM_LOCATE_DEVNODE_NORMAL)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Locate_DevNode_Ex", "dword*", 0, _
			"str", $sDevInstID, "ulong", $iFlags, "ptr", $hMachine)
	Return SetError($iResult[0], 0, $iResult[1])
EndFunc	;==>_CM_Locate_DevNode_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Reenumerate_DevNode_Ex
; Description	:  The _CM_Reenumerate_DevNode_Ex function enumerates the devices identified by a specified device node and all of its children.
; Parameter(s)	: $hDevInst	- A device instance handle.
;		: $hMachine	- A machine handle.
;		: $iFlags - Can be a combination of the following values:
;		:	- CM_REENUMERATE_ASYNCHRONOUS: Reenumeration should occur asynchronously. The call to this function returns immediately after the PnP manager receives the reenumeration request. If this flag is set, the CM_REENUMERATE_SYNCHRONOUS flag should not also be set.
;		:	- CM_REENUMERATE_NORMAL: Specifies default reenumeration behavior, in which reenumeration occurs synchronously. This flag is currently equivalent to CM_REENUMERATE_SYNCHRONOUS.
;		:	- CM_REENUMERATE_RETRY_INSTALLATION: Specifies that Plug and Play should make another attempt to install any devices in the specified subtree that have been detected but are not yet configured, or are marked as needing reinstallation, or for which installation must be completed. This flag can be set along with either the CM_REENUMERATE_SYNCHRONOUS flag or the CM_REENUMERATE_ASYNCHRONOUS flag. This flag must be used with extreme caution, because it can cause the PnP manager to prompt the user to perform installation of any such devices. Currently, only components such as Device Manager and Hardware Wizard use this flag, to allow the user to retry installation of devices that might already have been detected but are not currently installed.
; Return values	: Returns True if success, else returns false, @error is set to the reason of the failure.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Reenumerate_DevNode_Ex($hDevInst, $hMachine, $iFlags = $CM_REENUMERATE_NORMAL)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Reenumerate_DevNode_Ex", _
			"dword", $hDevInst, "ulong", $iFlags, "ptr", $hMachine)
	Return SetError($iResult[0], 0, $iResult[0] = 0)
EndFunc	;==>_CM_Reenumerate_DevNode_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Is_Version_Available_Ex
; Description	: The function indicates whether a specified version of the Plug and Play (PNP) Configuration Manager DLL (Cfgmgr32.dll) is supported by a local or a remote machine.
; Parameter(s)	: $wVersion	- Identifies a version of the configuration manager. The supported version of the configuration manager corresponds directly to the operating system version. The major version is specified by the high-order byte and the minor version is specified by the low-order byte. For example, 0x0400 specifies version 4.0, which is supported by default by Microsoft Windows NT 4.0 and later versions of Windows. Version 0x0501 specifies version 5.1, which is supported by Windows XP and later versions of Windows. 
;		: $hMachine	- A machine handle.
; Return values	: The function returns TRUE if the function can connect to the specified machine and if the machine supports the specified version. Otherwise, the function returns FALSE.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Is_Version_Available_Ex($wVersion, $hMachine)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Is_Version_Available_Ex", _
			"short", $wVersion, "ptr", $hMachine)
	Return $iResult[0] <> 0
EndFunc	;==>_CM_Is_Version_Available_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Get_Device_ID_Ex
; Description	: The function retrieves the device instance ID for a specified device instance, on a local or a remote machine.
; Parameter(s)	: $hDevInst	- A handle to a device instance.
;		: $hMachine	- A handle to a machine.
; Return values	: A device instance ID string is returned if success, else returns NULL and sets @error to a CR_* error code.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Get_Device_ID_Ex($hDevInst, $hMachine)
	Local $iResult, $tBuffer, $pBuffer, $iLength

	$iLength = _CM_Get_Device_ID_Size_Ex($hDevInst, $hMachine) + 1
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Device_ID_Ex", "dword", $hDevInst, _
			"str", "", "ulong", $iLength, "ulong", 0, "ptr", $hMachine)
	Return SetError($iResult[0], 0, $iResult[2])
EndFunc	;==>_CM_Get_Device_ID_Ex

; #### FUNCTION ####
; ================================================================================
; Name	: _CM_Get_Device_ID_By_Name_Ex
; Description	: Specifies a device friendly name (or device description), retrieves the device instance ID binds to this name.
; Parameter(s)	: $sFriendlyName	- Specifies a device friendly name, or description.
;		: $fMatchAll	- A value of TRUE indicates the full words is matched, default to TRUE.
;		: $sDeviceID	- Device identifier string of the device from which the match is started, can be NULL.
;		: $hMachine	- Supplies a machine handle, on which the function to execute, default to local.
; Return values	: If a device instance is matched, the return value is set to the device instance identifier, otherwise returns NULL.
; Author	: Pusofalse
; ================================================================================
Func _CM_Get_Device_ID_By_Name_Ex($sFriendlyName, $fMatchAll = True, $sDeviceID = "", $hMachine = 0)
	Local $aChild, $sDescr, $sName, $hDevInst, $sVal

	If IsString($sDeviceID) = 0 Then
		$hDevInst = $sDeviceID
	Else
		$hDevInst = _CM_Locate_DevNode_Ex($sDeviceID, $hMachine)
	EndIf
	$aChild = _CM_Enumerate_Children_Ex($hDevInst, $hMachine)

	For $i = 1 To $aChild[0]
		$hDevInst = _CM_Locate_DevNode_Ex($aChild[$i], $hMachine)
		$sDescr = _CM_Get_DevNode_Registry_Property_Ex($hDevInst, 1, $hMachine)
		$sName = _CM_Get_DevNode_Registry_Property_Ex($hDevInst, 0xD, $hMachine)
		If $sName <> "" Then $sDescr = $sName
		If $sDescr = "" Then $sDescr = "[Unknown device]"
		If $fMatchAll Then
			If $sDescr = $sFriendlyName Then Return $aChild[$i]
		Else
			If StringInStr($sDescr, $sFriendlyName) Then Return $aChild[$i]
		EndIf
		$sVal = _CM_Get_Device_ID_By_Name_Ex($sFriendlyName, $fMatchAll, $hDevInst, $hMachine)
		If $sVal <> "" Then Return $sVal
	Next
	Return ""
EndFunc	;==>_CM_Get_Device_ID_By_Name_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Get_Device_ID_Size_Ex
; Description	: The function retrieves the buffer size required to hold a device instance identifier for a device instance on a local or a remote machine.
; Parameter(s)	: $hDevInst	- A device instance handle.
;		: $hMachine	- A machine handle.
; Return values	: Returns the buffer length required if success, else returns zero and sets @error to a CR_* error code.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Get_Device_ID_Size_Ex($hDevInst, $hMachine)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Device_ID_Size_Ex", "ulong*", 0, _
			"dword", $hDevInst, "ulong", 0, "ptr", $hMachine)
	Return SetError($iResult[0], 0, $iResult[1])
EndFunc	;==>_CM_Get_Device_ID_Size_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Get_Device_ID_List_Ex
; Description	: The function retrieves a list of device instance identifiers for the device instances on a local or a remote machine.
; Parameter(s)	: $hMachine	- Supplies a machine handle that is returned by _CM_Connect_Machine function.
;		: $sFilter	- See the following description of the $iFlags.
;		: $iFlags	- One of the following caller-supplied bit flags that specifies search filters:
;		: - CM_GETIDLIST_FILTER_BUSRELATIONS: If this flag is set, $sFilter must specify a device instance identifier. The function returns device instance IDs for the bus relations of the specified device instance.
;		: - CM_GETIDLIST_FILTER_CLASS (Windows 7 and later versions of Windows): If this flag is set, $sFilter contains a string that specifies a device setup class GUID. The returned list contains device instances for which the property (referenced by the CM_DRP_CLASSGUID constant) matches the specified device setup class GUID.
;		: - CM_GETIDLIST_FILTER_PRESENT (Windows 7 and later versions of Windows): If this flag is set, the returned list contains only device instances that are currently present on the system. This value can be combined with other ulFlags values, such as CM_GETIDLIST_FILTER_CLASS.
;		: - CM_GETIDLIST_FILTER_TRANSPORTRELATIONS (Windows 7 and later versions of Windows): If this flag is set, $sFilter must specify the device instance identifier of a composite devnode. The function returns the device instance identifiers of the devnodes that represent the transport relations of the specified composite devnode.
;		: - CM_GETIDLIST_DONOTGENERATE: Used only with CM_GETIDLIST_FILTER_SERVICE. If set, and if the device tree does not contain a devnode for the specified service, this flag prevents the function from creating a devnode for the service.
;		: - CM_GETIDLIST_FILTER_EJECTRELATIONS: If this flag is set, $sFilter must specify a device instance identifier. The function returns device instance IDs for the ejection relations of the specified device instance.
;		: - CM_GETIDLIST_FILTER_ENUMERATOR: If this flag is set, $sFilter must specify the name of a device enumerator, optionally followed by a device identifier (ID). The string format is EnumeratorName\<DeviceID>, such as ROOT or ROOT\*PNP0500. If $sFilter supplies only an enumerator name, the function returns device Instance IDs for the instances of each device associated with the enumerator. Enumerator names can be obtained by calling _CM_Enumerate_Enumerators. If $sFilter supplies both an enumerator and a device ID, the function returns device instance IDs only for the instances of the specified device that is associated with the enumerator.
;		: - CM_GETIDLIST_FILTER_NONE: If this flag is set, $sFilter is ignored, and a list of all devices on the system is returned.
;		: - CM_GETIDLIST_FILTER_POWERRELATIONS: If this flag is set, $sFilter must specify a device instance identifier. The function returns device instance IDs for the power relations of the specified device instance.
;		: - CM_GETIDLIST_FILTER_REMOVALRELATIONS: If this flag is set, $sFilter must specify a device instance identifier. The function returns device instance IDs for the removal relations of the specified device instance.
;		: - CM_GETIDLIST_FILTER_SERVICE: If this flag is set, $sFilter must specify the name of a Microsoft Windows service (typically a driver). The function returns device instance IDs for the device instances controlled by the specified service.
;		: - If no search filter flag is specified, the function returns all device instance IDs for all device instances, default is CM_GETIDLIST_FILTER_NONE.
; Return values	: A list contains the device instance IDs string, value of $aArray[0] is set to the number of entries.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Get_Device_ID_List_Ex($hMachine, $sFilter = "", $iFlags = $CM_GETIDLIST_FILTER_NONE)
	Local $iResult, $iLength, $tBuffer, $pBuffer, $iPointer, $aResult[1] = [0], $iLength2, $pBuffer1

	$iLength = _CM_Get_Device_ID_List_Size_Ex($hMachine, $sFilter, $iFlags) + 1
	$pBuffer = _CM_Heap_Alloc($iLength)

	Do
		$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Device_ID_List_Ex", "str", $sFilter, _
			"ptr", $pBuffer, "ulong", $iLength, "ulong", $iFlags, "ptr", $hMachine)
		If $iResult[0] = $CR_BUFFER_SMALL Then
			_CM_Heap_Free($pBuffer)
			$iLength += 2
			$pBuffer = _CM_Heap_Alloc($iLength + 128)
		EndIf
	Until	$iResult[0] <> $CR_BUFFER_SMALL
	$pBuffer1 = $pBuffer

	While $iPointer < $iLength
		$tBuffer = DllStructCreate("char DeviceID[512]", $pBuffer)
		$aResult[0] += 1
		Redim $aResult[$aResult[0] + 1]
		$aResult[$aResult[0]] = DllStructGetData($tBuffer, "DeviceID")
		If $aResult[$aResult[0]] = "" Then ExitLoop
		$iLength2 = StringLen($aResult[$aResult[0]]) + 1
		$pBuffer += $iLength2
		$iPointer += $iLength2
		$tBuffer = 0
	WEnd
	_CM_Heap_Free($pBuffer1)
	If $aResult[0] = 0 Then Return SetError($iResult[0], 0, $aResult)
	$aResult[0] -= 1
	Redim $aResult[$aResult[0] + 1]
	Return SetError($iResult[0], 0, $aResult)
EndFunc	;==>_CM_Get_Device_ID_List_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Get_Device_ID_List_Size_Ex
; Description	: Retrieves the buffer length required to hold a list of device instance identifiers for a local or remote system's device tree.
; Parameter(s)	: $hMachine	- A value of machine handle.
;		: $sFilter, $iFlags	- See _CM_Get_Device_ID_List_Ex function for details of these 2 parameters.
; Return values	: Returns the length required if success, else returns zero, @error is set to the reason of the failure.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Get_Device_ID_List_Size_Ex($hMachine, $sFilter = "", $iFlags = $CM_GETIDLIST_FILTER_NONE)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Device_ID_List_Size_Ex", "ulong*", 0, _
			"str", $sFilter, "ulong", $iFlags, "ptr", $hMachine)
	Return SetError($iResult[0], 0, $iResult[1])
EndFunc	;==>_CM_Get_Device_ID_List_Size_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Get_DevNode_Status_Ex
; Description	: The function obtains the status of a device instance from its device node (devnode) on a local or a remote machine's device tree.
; Parameter(s)	: $hDevInst	- Supplies a device instance handle.
;		: $hMachine	- Supplies a machine handle, that is returned by _CM_Connect_Machine.
; Return values	: A bitwise OR of DN_* constants is returned if success.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Get_DevNode_Status_Ex($hDevInst, $hMachine)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_DevNode_Status_Ex", "ulong*", 0, _
			"ulong*", 0, "dword", $hDevInst, "ulong", 0, "ptr", $hMachine)
	Return SetError($iResult[0], $iResult[2], $iResult[1])
EndFunc	;==>_CM_Get_DevNode_Status_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Enumerate_Classes_Ex
; Description	: This function lists a local or a remote machine's installed device classes.
; Parameter(s)	: $sMachine - A system name, in UNC format.
; Return values	: An array in the following form is returned if succeeds:
;		: $aArray[0][0] - The number of returned classes.
;		: $aArray[1][0] - GUID of 1st class entry, in string format.
;		: $aArray[1][1] - Description of 1st class entry.
;		: $aArray[2][0] - GUID of 2nd class entry.
;		: ... ...
; Author	: Pusofalse
; ====================================================================================
Func _CM_Enumerate_Classes_Ex($sMachine)
	Local $iResult, $aResult[1][2] = [[0]], $hMachine, $pGUID

	$hMachine = _CM_Connect_Machine($sMachine)
	If $hMachine = 0 Then Return SetError(@error, 0, $aResult)
	$pGUID = _CM_Heap_Alloc(16)
	While 1
		$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Enumerate_Classes_Ex", _
			"ulong", $aResult[0][0], "ptr", $pGUID, "ulong", 0, "ptr", $hMachine)
		If $iResult[0] Then ExitLoop
		$aResult[0][0] += 1
		Redim $aResult[$aResult[0][0] + 1][2]
		$aResult[$aResult[0][0]][0] = _CM_String_From_GUID($pGUID)
		$aResult[$aResult[0][0]][1] = _SetupDiGetClassDescriptionEx($pGUID, $sMachine)
	WEnd
	_CM_Disconnect_Machine($hMachine)
	Return SetError($iResult[0], _CM_Heap_Free($pGUID), $aResult)
EndFunc	;==>_CM_Enumerate_Classes_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Enumerate_Enumerators_Ex
; Description	: This function lists the device enumerators, by supplying each enumerator's name.
; Parameter(s)	: $hMachine	- Supplies a handle to a machine.
; Return values	: An array in the following form is returned if succeeds:
;		:	- $aArray[0] - The number of entries returned.
;		:	- $aArray[1] - 1st enumerator's name.
;		:	- $aArray[2] - 2nd enumerator's name.
;		:	- ... ...
; Author	: Pusofalse
; ====================================================================================
Func _CM_Enumerate_Enumerators_Ex($hMachine)
	Local $iResult, $aResult[1] = [0]

	While True
		$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Enumerate_Enumerators_Ex", _
			"ulong", $aResult[0], "str", "", "ulong*", 32, "ulong", 0, "ptr", $hMachine)
		If $iResult[0] Then ExitLoop
		$aResult[0] += 1
		Redim $aResult[$aResult[0] + 1]
		$aResult[$aResult[0]] = $iResult[2]
	WEnd
	Return SetError($iResult[0], 0, $aResult)
EndFunc	;==>_CM_Enumerate_Enumerators_Ex

; #### FUNCTION ####
; =====================================================================================
; Name	: _CM_Is_Device_Disabled
; Description	: Determines the specified devnode is whether disabled.
; Parameter(s)	: $hDevInst	- Supplies a device instance handle.
; Return values	: Returns True if the device is disabled; Returns False if not disabled or an error occured.
; Author	: Pusofalse
; =====================================================================================

Func _CM_Is_Device_Disabled($hDevInst)
	Local $iStatus, $iFlags, $sDeviceID, $sKey

	$iStatus = _CM_Get_DevNode_Status($hDevInst)
	$iFlags = @Extended
	If bitAND($iStatus, $DN_DISABLEABLE) <> $DN_DISABLEABLE Then
		Return SetError(50, 0, 0)
	ElseIf ($iFlags = 0) And (BitAnd($iStatus, $DN_NEED_RESTART) = 0 Or _
		BitAnd($iStatus, $DN_HAS_PROBLEM) = 0) Then
		Return SetError(0, 0, 0)
	ElseIf $iFlags = 22 Then
		Return SetError(0, 0, 1)
	EndIf

	$sDeviceID = _CM_Get_Device_ID($hDevInst)
	$sKey = $REGKEY_HARDWARE_CS001_001 & $sDeviceID
	$iFlags = RegRead($sKey, "CSConfigFlags")
	If bitAND($iFlags, $CSCONFIGFLAG_DISABLED) = $CSCONFIGFLAG_DISABLED Then
		Return 1
	EndIf
	$iFlags = _CM_Get_DevNode_Registry_Property($hDevInst, $CM_DRP_CONFIGFLAGS)
	If bitAND($iFlags, $CONFIGFLAG_DISABLED) = $CONFIGFLAG_DISABLED Then
		Return 1
	EndIf
	Return 0
EndFunc	;==>_CM_Is_Device_Disabled

; #### FUNCTION ####
; =====================================================================================
; Name	: _CM_Enum_Device_Info
; Description	: Supplies a device class, enumerates the devices present in the device class.
; Parameter(s)	: $vClassGuid	- Device setup class GUID.
;		: $sEnumerator	- Enumerator, can be NULL specified for this parameter.
; Return values	: An array in the following format:
;		: $aArray[0][0]	- The number of devices returned.
;		: $aArray[1][0]	- Description of 1st device.
;		: $aArray[1][1]	- Device instance ID of 1st device.
;		: $aArray[1][2]	- Device instance handle to 1st device.
;		: ... ...
; Author	: Pusofalse
; =====================================================================================
Func _CM_Enum_Device_Info($vClassGuid, $sEnumerator = "", $iMask = $DIGCF_PRESENT)
	Local $aResult[1][3], $sDescr, $sName, $tDevInfo, $hDevs

	$hDevs = _SetupDiGetClassDevs($iMask, $vClassGuid, $sEnumerator)
	While _SetupDiEnumDeviceInfo($hDevs, $aResult[0][0], $tDevInfo)
		$sName = _SetupDiGetDeviceRegistryProperty($hDevs, $tDevInfo, 0xC)
		If $sName = "" Then
			$sName = _SetupDiGetDeviceRegistryProperty($hDevs, $tDevInfo, 0)
			If $sName = "" Then $sName = "[Unknown device]"
		EndIf
		$aResult[0][0] += 1
		Redim $aResult[$aResult[0][0] + 1][3]
		$aResult[$aResult[0][0]][0] = $sName
		$aResult[$aResult[0][0]][1] = _SetupDiGetDeviceInstanceID($hDevs, $tDevInfo)
		$aResult[$aResult[0][0]][2] = DllStructGetData($tDevInfo, "DevInst")
	WEnd
	_CM_Assign_Var($tDevInfo, 0, @error)
	Return SetError(@error, _SetupDiDestroyDeviceInfoList($hDevs), $aResult)
EndFunc	;==>_CM_Enum_Device_Info

; #### FUNCTION ####
; =================================================================================
; Name	: _CM_Enum_Device_Info_Ex
; Description	: This function lists a set of specified class device, presents on local or remote system.
; Parameter(s)	: $sMachine	- Machine name, in UNC format.
;		: $vClassGuid	- Class setup device GUID.
;		: $sEnumerator	- Enumerator, can be NULL.
; Return values	: Returns an array in the following format:
;		: $aArray[0][0] - The number of enumerated devices.
;		: $aArray[1][0] - Description of 1st device instance.
;		: $aArray[1][1] - Device intance identifer for 1st entry.
;		: $aArray[1][2] - Handle to the device instance for 1st entry.
;		: $aArray[2][0] - Description of 2nd device instance.
;		:	... ...
;		: If no error occurs during the call, @error is set to 259 which indicates the enumeration is finished normally. Otherwise, @error is set to a system error code.
; Author	: Pusofalse
; =================================================================================
Func _CM_Enum_Device_Info_Ex($sMachine, $vClassGuid, $sEnumerator = "")
	Local $aResult[1][3], $sDescr, $sName, $tDevInfo, $hDevs

	$hDevs = _SetupDiGetClassDevsEx($DIGCF_PRESENT, $vClassGuid, $sEnumerator, $sMachine)
	While _SetupDiEnumDeviceInfo($hDevs, $aResult[0][0], $tDevInfo)
		$sDescr = _SetupDiGetDeviceRegistryProperty($hDevs, $tDevInfo, 0)
		$sName = _SetupDiGetDeviceRegistryProperty($hDevs, $tDevInfo, 0xC)
		If $sName <> "" Then $sDescr = $sName
		If $sDescr = "" Then $sDescr = "[Unknown device]"
		$aResult[0][0] += 1
		Redim $aResult[$aResult[0][0] + 1][3]
		$aResult[$aResult[0][0]][0] = $sDescr
		$aResult[$aResult[0][0]][1] = _SetupDiGetDeviceInstanceID($hDevs, $tDevInfo)
		$aResult[$aResult[0][0]][2] = DllStructGetData($tDevInfo, "DevInst")
	WEnd
	_CM_Assign_Var($tDevInfo, 0, @error)
	Return SetError(@error, _SetupDiDestroyDeviceInfoList($hDevs), $aResult)
EndFunc	;==>_CM_Enum_Device_Info_Ex

; #### FUNCTION ####
; =================================================================================
; Name	: _CM_Enum_Device_Info_Notify_Progress
; Description	: Enumerate a device instance set, and notify user the enumeration progress.
; Parameter(s)	: $vClassGuid	- Device setup class GUID, can not be NULL.
;		: $sEnumerator	- Enumerator for enumeration, can be NULL specified.
;		: $sFunction	- Name of the callback function, if the progress is not required, this parameter can be NULL. Otherwise, defines a function by the following:
;		:	Func _EnumDeviceNotifyProgressCallback($iIndex, $sDeviceID)
;		:	EndFunc	;==>_EnumDeviceNotifyProgressCallback
;		: $iIndex parameter is the index of the device in device set, one based. $sDeviceID parameter in the callback function indicates the identifier string of the enumerated device instance, in text format. The callback function can return a value.
;		: Return values	: If succeeds, returns a value in the following format:
;		:	$aArray[0][0] - The number of returned entries.
;		:	$aArray[1][0] - Description for 1st entry.
;		:	$aArray[1][1] - Device instance identifier string for 1st entry.
;		:	$aArray[1][2] - Device instance handle for 1st entry.
;		:	$aArray[1][3] - Return value of the user-defined callback function. If $sFunction is NULL, the value is NULL.
;		:	$aArray[2][0] - Description for 2nd entry.
;		: If the enumeration is finished without an error, @error is set to 259. Otherwise, is set to a system error code.
; Author	: Pusofalse
; Example	: _CM_Enum_Device_Info_Notify_Progress("Mouse")
; =================================================================================
Func _CM_Enum_Device_Info_Notify_Progress($vClassGuid, $sEnumerator = "", $sFunction = "")
	Local $aResult[1][4], $sDescr, $sName, $tDevInfo, $hDevs

	$hDevs = _SetupDiGetClassDevs($DIGCF_PRESENT, $vClassGuid, $sEnumerator)
	While _SetupDiEnumDeviceInfo($hDevs, $aResult[0][0], $tDevInfo)
		$sDescr = _SetupDiGetDeviceRegistryProperty($hDevs, $tDevInfo, 0)
		$sName = _SetupDiGetDeviceRegistryProperty($hDevs, $tDevInfo, 0xC)
		If $sName <> "" Then $sDescr = $sName
		If $sDescr = "" Then $sDescr = "[Unknown device]"
		$aResult[0][0] += 1
		Redim $aResult[$aResult[0][0] + 1][4]
		$aResult[$aResult[0][0]][0] = $sDescr
		$aResult[$aResult[0][0]][1] = _SetupDiGetDeviceInstanceID($hDevs, $tDevInfo)
		$aResult[$aResult[0][0]][2] = DllStructGetData($tDevInfo, "DevInst")
		If $sFunction <> "" Then
			$aResult[$aResult[0][0]][3] = Call($sFunction, $aResult[0][0], $aResult[$aResult[0][0]][1])
		EndIf
	WEnd
	_CM_Assign_Var($tDevInfo, 0, @error)
	Return SetError(@error, _SetupDiDestroyDeviceInfoList($hDevs), $aResult)
EndFunc	;==>_CM_Enum_Device_Info_Notify_Progress

; #### FUNCTION ####
; ====================================================================================
; Name	: _SetupDiGetClassDescriptionEx
; Description	: Retrieves the description of a device class from the specified remote system.
; Parameter(s)	: $vGUID	- Class GUID, or class name.
;		: $sMachine	- Machine name, in UNC format.
; Return values	: Returns the description string if succeeds, else returns NULL, and sets @error to a system error code.
; Author	: Pusofalse
; ====================================================================================
Func _SetupDiGetClassDescriptionEx($vGUID, $sMachine)
	Local $iResult, $tGUID, $pGUID
	If IsString($vGUID) Then
		If StringLeft($vGUID, 1) & StringRight($vGUID, 1) = "{}" Then
			$tGUID = _CM_GUID_From_String($vGUID)
			$pGUID = DllStructGetPtr($tGUID)
		ElseIf $vGUID <> "" Then
			$tGUID = _SetupDiClassGUIDsFromName($vGUID)
			$pGUID = DllStructGetPtr($tGUID)
		EndIf
	ElseIf IsDllStruct($vGUID) Then
		$pGUID = DllStructGetPtr($vGUID)
	ElseIf IsPtr($vGUID) Then
		$pGUID = $vGUID
	Else
		$pGUID = 0
	EndIf
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiGetClassDescriptionEx", "ptr", $pGUID, _
			"ptr", 0, "dword", 0, "dword*", 0, "str", $sMachine, "ptr", 0)
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiGetClassDescriptionEx", "ptr", $pGUID, _
			"str", "", "dword", $iResult[4], "dword*", 0, "str", $sMachine, "ptr", 0)
	Return SetError(_CM_Get_Last_Error(), 0, $iResult[2])
EndFunc	;==>_SetupDiGetClassDescriptionEx

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Request_Device_Eject_Ex
; Description	: This function prepares a local or a remote device instance for safe removal, if the device is removable. If the device can be physically ejected, it will be.
; Parameter(s)	: $hDevInst - Supplies a handle to a device instance.
;		: $hMachine - Supplies a machine handle, obtained by _CM_Connect_Machine.
;		: $sVetoName	- A variable receives a text string, dependent on the value of @extended.
; Return values	: Returns True if succeeds, else returns false. If the removal fails, @extended is set to the reason for the failure.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Request_Device_Eject_Ex($hDevInst, $hMachine, ByRef $sVetoName)
	Local $iResult, $hToken
	Local $aPriv[2][2] = [[$SE_UNDOCK_NAME, 2], [$SE_LOAD_DRIVER_NAME, 2]]

	$hToken = _OpenProcessToken(-1)
	_AdjustTokenPrivileges($hToken, $aPriv)
	_LsaCloseHandle($hToken)

	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Request_Device_Eject_Ex", "dword", $hDevInst, _
			"ulong*", 0, "str", "", "ulong", 260, "ulong", 0, "ptr", $hMachine)
	$sVetoName = $iResult[3]
	Return SetError($iResult[0], $iResult[2], $iResult[0] = $CR_SUCCESS)
EndFunc	;==>_CM_Request_Device_Eject_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Query_And_Remove_SubTree_Ex
; Description	: This function checks whether a device instance and its children can be removed and, if so, it removes them.
; Parameter(s)	: $hDevInst - A handle to the device instance handle.
;		: $hMachine - A handle to a machine on which the function executes.
;		: $sVetoName - A variable receives a text string, the type of information this string provides is dependent on the value of @extended.
;		: $iFlags - A bitwise OR of the caller-supplied flag constants, can be a combination of the following values:
;		:	- CM_REMOVE_UI_OK : The function allows a user dialog box to be displayed to indicate the reason for the veto (Default).
;		:	- CM_REMOVE_UI_NOT_OK: The function suppresses the display of a user dialog box that indicates the reason for the veto. 
;		:	- CM_REMOVE_NO_RESTART: If this flag is set, the function configures the device status such that the device cannot be restarted until after the device status is reset.
; Return values	: True indicates success, false to failure. If the removal request fails, @extended is set to the reason for the failure.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Query_And_Remove_SubTree_Ex($hDevInst, $hMachine, ByRef $sVetoName, $iFlags = $CM_REMOVE_UI_OK)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Query_And_Remove_SubTree_Ex", _
			"dword", $hDevInst, "ulong*", 0, "str", "", "ulong", 260, _
			"ulong", $iFlags, "ptr", $hMachine)
	$sVetoName = $iResult[3]
	Return SetError($iResult[0], $iResult[2], $iResult[0] = $CR_SUCCESS)
EndFunc	;==>_CM_Query_And_Remove_SubTree_Ex

; #### FUNCTION ####
; =================================================================================
; Name	: _CM_Is_Dock_Station_Present
; Description	: This function identifies whether a docking station is present in a local machine.
; Parameter(s)	: This function has no parameters.
; Return values	: If an error occured during the call or the docking station is not present in local system, the function returns FALSE and sets @error to a configuration manager error code. Otherwise, the function returns TRUE indicates the docking station is present in the local machine.
; Author	: Pusofalse
; =================================================================================
Func _CM_Is_Dock_Station_Present()
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Is_Dock_Station_Present", "int*", 0)
	Return SetError($iResult[0], 0, $iResult[1])
EndFunc	;==>_CM_Is_Dock_Station_Present

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Is_Dock_Station_Present_Ex
; Description	: This function identifies whether a docking station is present in a local or a remote machine.
; Parameter(s)	: $hMachine - Supplies a machine handle, that is returned by _CM_Connect_Machine.
; Return values	: Returns True if a docking station is present, False otherwise, or the function cannot connect to the specified machine.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Is_Dock_Station_Present_Ex($hMachine)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Is_Dock_Station_Present_Ex", _
			"int*", 0, "ptr", $hMachine)
	Return SetError($iResult[0], 0, $iResult[1] <> 0)
EndFunc	;==>_CM_Is_Dock_Station_Present_Ex

; #### FUNCTION ####
; =================================================================================
; Name	: _CM_Request_Eject_PC
; Description	: This function requests a portable PC, which is inserted in local docking station, be ejected.
; Parameter(s)	: This function has no parameters.
; Return values	: If the operation succeeds, the function returns TRUE. Otherwise, returns FALSE and sets @error to a CR_* error code.
; Author	: Pusofalse
; =================================================================================
Func _CM_Request_Eject_PC()
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Request_Eject_PC")
	Return SetError($iResult[0], 0, $iResult[0] = $CR_SUCCESS)
EndFunc	;==>_CM_Request_Eject_PC

; #### FUNCTION ####
; =================================================================================
; Name	: _CM_Request_Eject_PC_Ex
; Description	: The _CM_Request_Eject_PC_Ex function requests that a portable PC, which is inserted in a local or a remote docking station, be ejected.
; Parameter(s)	: $hMachine	- Supplies a handle that is returned by _CM_Connect_Machine.
; Return values	: TRUE is returned if succeeds. Otherwise, the function returns FALSE and sets @error to one of the CR_-prefixed error codes.
; Author	: Pusofalse
; =================================================================================
Func _CM_Request_Eject_PC_Ex($hMachine)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Request_Eject_PC_Ex", "ptr", $hMachine)
	Return SetError($iResult[0], 0, $iResult[0] = $CR_SUCCESS)
EndFunc	;==>_CM_Request_Eject_PC_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Setup_DevNode
; Description	: This function restarts a device instance that is not running, because of a problem with device configuration.
; Parameter(s)	: $hDevInst	- A handle to the device instance.
;		: $iFlags	- One of the following values:
;		: CM_SETUP_DEVNODE_READY: Restarts a device instance that is not running because of a problem with the device configuration.
;		: CM_SETUP_DEVNODE_RESET: Resets a device instance that has the no restart device status flag set. The no restart device status flag is set if a device is removed by calling _CM_Query_And_Remove_SubTree or _CM_Query_And_Remove_SubTree_Ex and specifying the CM_REMOVE_NO_RESTART flag. 
; Return values	: True indicates success, False otherwise, in which case, @error is set to the reason of the failure, see CR_* error constants.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Setup_DevNode($hDevInst, $iFlags)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Setup_DevNode", _
			"dword", $hDevInst, "ulong", $iFlags)
	Return SetError($iResult[0], 0, $iResult[0] = $CR_SUCCESS)
EndFunc	;==>_CM_Setup_DevNode

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Add_ID
; Description	: The CM_Add_ID function appends a specified device ID (if not already present) to a device instance's hardware ID list or compatible ID list.
; Parameter(s)	: $hDevInst	- A handle to a device instance.
;		: $sDeviceID	- A string contains the device ID to be appended to the list.
;		: $iFlags	- One of the following values:
;		:	- CM_ADD_ID_HARDWARE: The specified device ID should be appended to the specific device instance's hardware ID list.
;		:	- CM_ADD_ID_COMPATIBLE: The specified device ID should be appended to the specific device instance's compatible ID list.
; Return values	: True indicates success, false otherwise.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Add_ID($hDevInst, $sDeviceID, $iFlags = $CM_ADD_ID_HARDWARE)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Add_ID", "dword", $hDevInst, _
			"str", $sDeviceID, "ulong", $iFlags)
	Return SetError($iResult[0], 0, $iResult[0] = $CR_SUCCESS)
EndFunc	;==>_CM_Add_ID

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Add_ID_Ex
; Description	:  The function appends a device ID (if not already present) to a device instance's hardware ID list or compatible ID list, on either the local or a remote machine.
; Parameter(s)	: $hDevInst	- Supplies a device instance handle.
;		: $sDeviceID	- A device ID string to be appended to the list.
;		: $hMachine	- A machine handle.
;		: $iFlags	- One of the following values:
;		:	- CM_ADD_ID_HARDWARE: The specified device ID should be appended to the specific device instance's hardware ID list.
;		:	- CM_ADD_ID_COMPATIBLE: The specified device ID should be appended to the specific device instance's compatible ID list.
; Return values	: Returns True if success, otherwise returns False.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Add_ID_Ex($hDevInst, $sDeviceID, $hMachine, $iFlags = $CM_ADD_ID_HARDWARE)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Add_ID_Ex", "dword", $hDevInst, _
			"str", $sDeviceID, "ulong", $iFlags, "ptr", $hMachine)
	Return SetError($iResult[0], 0, $iResult[0] = $CR_SUCCESS)
EndFunc	;==>_CM_Add_ID_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Enumerate_Children_Ex
; Description	: This function lists all child device nodes (devnode) of the specified device instance on a local or a remote machine.
; Parameter(s)	: $hDevInst	- A handle to a device instance.
;		: $hMachine	- A handle to a machine.
; Return values	: Returns an array in the following format if succeess:
;		:	- $aArray[0] - The number of returned entries.
;		:	- $aArray[1] - 1st device instance ID, in string format.
;		:	- $aArray[2] - 2nd device instance ID.
;		:	- ... ...
; Author	: Pusofalse
; ====================================================================================
Func _CM_Enumerate_Children_Ex($hDevInst, $hMachine = 0)
	Local $aResult[1] = [0], $hChild, $hSibling, $sDevInst

	$hChild = _CM_Get_Child_Ex($hDevInst, $hMachine)
	If ($hChild = 0) Then Return SetError(@error, 0, $aResult)

	$hSibling = $hChild
	While 1
		$sDevInst &= _CM_Get_Device_ID($hSibling) & ","
		$hSibling = _CM_Get_Sibling_Ex($hSibling, $hMachine)
		If (@error) Or ($hSibling = 0) Then ExitLoop
	WEnd
	Return SetError(@error, 0, StringSplit(StringTrimRight($sDevInst, 1), ","))
EndFunc	;==>_CM_Enumerate_Children_Ex


; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Enumerate_Children
; Description	: This function lists the sub device nodes (devnode) for a device instance on local system.
; Parameter(s)	: $hDevInst - A handle to a device instance.
; Return values	: Returns an array in the following format if succeess:
;		:	- $aArray[0] - The number of returned entries.
;		:	- $aArray[1] - 1st device instance ID, in string format.
;		:	- $aArray[2] - 2nd device instance ID.
;		:	- ... ...
; Author	: Pusofalse
; ====================================================================================
Func _CM_Enumerate_Children($hDevInst)
	Return _CM_Enumerate_Children_Ex($hDevInst, 0)
EndFunc	;==>_CM_Enumerate_Children

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Get_Children_Count_Ex
; Description	: Return the number of the sub device nodes (devnode) for a device instance on a local or remote system.
; Parameter(s)	: $hDevInst	- Supplies a device instance handle.
;		: $hMachine	- Supplies a machine handle.
; Return values	: The number of sub device nodes.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Get_Children_Count_Ex($hDevInst, $hMachine)
	Local $aChildren = _CM_Enumerate_Children_Ex($hDevInst, $hMachine)
	Return $aChildren[0]
EndFunc	;==>_CM_Get_Children_Count_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Get_Children_Count
; Description	: Return the number of the sub device nodes (devnode) for a device instance on local system.
; Parameter(s)	: $hDevInst	- A device instance handle.
; Return values	: The number of the sub device nodes (devnode) of the $hDevInst.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Get_Children_Count($hDevInst)
	Return _CM_Get_Children_Count_Ex($hDevInst, 0)
EndFunc	;==>_CM_Get_Children_Count

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Get_Child_By_Index_Ex
; Description	: Returns the device instance ID on specified position by using the index caller specified, on local or a remote system.
; Parameter(s)	: $hDevInst	- A device instance handle under which the specified sub device instance is retrieved.
;		: $hMachine	- Supplies a machine, on which the function executes.
;		: $iIndex	- Zero-based index of device instants to retrieve, default to the first.
; Return values	: Returns the device instance handle if succeeds, else returns zero.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Get_Child_By_Index_Ex($hDevInst, $hMachine, $iIndex = 0)
	Local $aChildren = _CM_Enumerate_Children_Ex($hDevInst, $hMachine)

	If @error OR $aChildren[0] < 1 Then Return SetError(@error, 0, 0)
	If $iIndex < 0 Then Return SetError($CR_INVALID_DATA, 0, 0)
	If $iIndex > $aChildren[0] - 1 Then Return SetError($CR_NO_SUCH_DEVINST, 0, 0)
	Return _CM_Locate_DevNode_Ex($aChildren[$iIndex + 1], $hMachine)
EndFunc	;==>_CM_Get_Child_By_Index_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Get_Child_By_Index
; Description	: Returns the device instance ID on specified position by using the index caller specified, on local system.
; Parameter(s)	: $hDevInst	- A device instance handle under which the specified sub device instance is retrieved.
;		: $iIndex	- Zero-based index of device instants to retrieve, default to the first.
; Return values	: Returns the device instance handle if succeeds, else returns zero.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Get_Child_By_Index($hDevInst, $iIndex = 0)
	Local $hDevInst1
	$hDevInst1 = _CM_Get_Child_By_Index_Ex($hDevInst, 0, $iIndex)
	Return SetError(@error, 0, $hDevInst1)
EndFunc	;==>_CM_Get_Child_By_Index

; #### FUNCTION ####
; ==============================================================================
; Name	: _CM_Disable_DevNode
; Description	: This function disables a device node (devnode), on local system.
; Parameter(s)	: $hDevInst	- Supplies a device instance handle.
; Return values	: Returns True if succeeds; False otherwise, @error is set to a CR_* error code.
; Author	: Pusofalse
; ==============================================================================
Func _CM_Disable_DevNode($hDevInst)
	Local $iResult
	_CM_Set_DevNode_CSConfigFlags($hDevInst, $CSCONFIGFLAG_DISABLED)
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Disable_DevNode", _
			"dword", $hDevInst, "ulong", 0)
	Return SetError($iResult[0], 0, $iResult[0] = $CR_SUCCESS)
EndFunc	;==>_CM_Disable_DevNode

; #### FUNCTION ####
; ==============================================================================
; Name	: _CM_Enable_DevNode
; Description	: This function enables a device node (devnode) that has been disabled.
; Parameter(s)	: $hDevInst	- Handle to the device instance to enable.
; Return values	: Returns True if succeeds; False otherwise, @error is set to a CR_* error code.
; Author	: Pusofalse
; ==============================================================================
Func _CM_Enable_DevNode($hDevInst)
	Local $iResult
	_CM_Set_DevNode_CSConfigFlags($hDevInst, $CSCONFIGFLAG_NONE)
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Enable_DevNode", _
			"dword", $hDevInst, "ulong", 0)
	Return SetError($iResult[0], 0, $iResult[0] = $CR_SUCCESS)
EndFunc	;==>_CM_Enable_DevNode

; #### FUNCTION ####
; ==============================================================================
; Name	: _CM_Disable_DevNode_Ex
; Description	: Disables a device instance, on local or remote machine.
; Parameter(s)	: $hDevInst	- Handle to the device instance.
;		: $hMachine	- Handle to the machine, the function executes on this system.
; Return values	: True if succeeds, else False, extended error is stored in @error.
; Author	: Pusofalse
; ==============================================================================
Func _CM_Disable_DevNode_Ex($hDevInst, $hMachine)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Disable_DevNode_Ex", _
			"dword", $hDevInst, "ulong", 0, "ptr", $hMachine)
	Return SetError($iResult[0], 0, $iResult[0] = $CR_SUCCESS)
EndFunc	;==>_CM_Disable_DevNode_Ex

; #### FUNCTION ####
; ==============================================================================
; Name	: _CM_Enable_DevNode_Ex
; Description	: Enables a device instance that has been disabled, on local or remote system.
; Parameter(s)	: $hDevInst	- Handle to the device instance.
;		: $hMachine	- Handle to the machine, typically returned by _CM_Connect_Machine function.
; Return values	: True is returned if succeeds. Otherwise, False is returned, with that @error is set to the reason of the failure.
; Author	: Pusofalse
; ==============================================================================
Func _CM_Enable_DevNode_Ex($hDevInst, $hMachine)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Enable_DevNode_Ex", _
			"dword", $hDevInst, "ulong", 0, "ptr", $hMachine)
	Return SetError($iResult[0], 0, $iResult[0] = $CR_SUCCESS)
EndFunc	;==>_CM_Enable_DevNode_Ex

; #### FUNCTION ####
; ==============================================================================
; Name	: _CM_Uninstall_DevNode
; Description	: This function uninstalls a device node (devnode), on local system.
; Parameter(s)	: $hDevInst	- Device instance to be uninstalled.
; Return values	: True indicates success, False indicates failure, in which case, @error is set to a CR_* error code.
; Author	: Pusofalse
; Remarks	: If no error occur, the function returns True, but the device instance still works well, until the next system reboot.
; ==============================================================================
Func _CM_Uninstall_DevNode($hDevInst)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Uninstall_DevNode", _
			"dword", $hDevInst, "ulong", 0)
	Return SetError($iResult[0], 0, $iResult[0] = $CR_SUCCESS)
EndFunc	;==>_CM_Uninstall_DevNode

; #### FUNCTION ####
; ================================================================================
; Name	: _CM_Restart_Device
; Description	: This function restarts a device instance, on local system.
; Parameter(s)	: $hDevInst	- Handle to the device instance.
; Return values	: True is returned if succeeds, else False, the logged error is set in @error.
; Author	: Pusofalse
; ================================================================================
Func _CM_Restart_Device($hDevInst)
	Local $hDevs, $tDevInfo

	Select
	Case _CM_Create_Device_Devs($hDevInst, $hDevs, $tDevInfo) = 0
		Return SetError(@error, 0, 0)
	Case _SetupDiDisableDevice($hDevs, $tDevInfo, True) = 0
		Return SetError(@error, _SetupDiDestroyDeviceInfoList($hDevs), 0)
	Case _SetupDiDisableDevice($hDevs, $tDevInfo, False) = 0
		Return SetError(@error, _SetupDiDestroyDeviceInfoList($hDevs), 0)
	Case Else
		_CM_Assign_Var($tDevInfo, 0, @error)
		Return SetError(@error, _SetupDiDestroyDeviceInfoList($hDevs), 1)
	EndSelect
EndFunc	;==>_CM_Restart_Device

; #### FUNCTION ####
; ================================================================================
; Name	: _CM_Restart_Device_Ex
; Description	: This function restarts a device instance, on local or remote system.
; Parameter(s)	: $hDevInst	- Supplies a device instance handle, binding to the configuration manager on $sMachine system.
;		: $sMachine	- Supplies a string contains the system name on which the function to execute, in UNC format. If specifies NULL, local system is used. Note that this parameter is a string but not a handle.
; Return values	: Returns True if the function completes without an error, otherwise returns False, and the logged error can be retrieved from macro @error.
; Author	: Pusofalse
; ================================================================================
Func _CM_Restart_Device_Ex($hDevInst, $sMachine = "")
	Local $hDevs, $tDevInfo

	Select
	Case _CM_Create_Device_Devs_Ex($hDevInst, $hDevs, $tDevInfo, $sMachine) = 0
		Return SetError(@error, 0, 0)
	Case _SetupDiDisableDevice($hDevs, $tDevInfo, True) = 0
		Return SetError(@error, _SetupDiDestroyDeviceInfoList($hDevs), 0)
	Case _SetupDiDisableDevice($hDevs, $tDevInfo, False) = 0
		Return SetError(@error, _SetupDiDestroyDeviceInfoList($hDevs), 0)
	Case Else
		_CM_Assign_Var($tDevInfo, 0, @error)
		Return SetError(@error, _SetupDiDestroyDeviceInfoList($hDevs), 1)
	EndSelect
EndFunc	;==>_CM_Restart_Device_Ex


Func _CM_Set_DevNode_CSConfigFlags($hDevInst, $iFlags = 0)
	Local $fResult = 1, $sKey, $sDeviceID, $aKey[5]

	$sDeviceID = _CM_Get_Device_ID($hDevInst)
	If $sDeviceID = "" OR @error Then Return SetError(@error, 0, 0)

	$aKey[0] = $REGKEY_HARDWARE_CS001_001 & $sDeviceID
	$aKey[1] = $REGKEY_HARDWARE_CS002_001 & $sDeviceID
	$aKey[2] = $REGKEY_HARDWARE_CS002_CURRENT & $sDeviceID
	$aKey[3] = $REGKEY_HARDWARE_CCS_001 & $sDeviceID
	$aKey[4] = $REGKEY_HARDWARE_CCS_CURRENT & $sDeviceID

	For $i = 0 To 4
		$fResult = $fResult And RegWrite($aKey[$i], "CSConfigFlags", "REG_DWORD", $iFlags)
	Next
	Return SetError(@error, 0, $fResult)
EndFunc	;==>_CM_Set_DevNode_CSConfigFlags

; #### FUNCTION ####
; ====================================================================================
; Name	: _SetupDiCreateDeviceInfoListEx
; Description	: Creates an empty device information set on a remote or a local computer and optionally associates the set with a device setup class.
; Parameter(s)	: $sMachine	- Machine name, in UNC format, empty indicates local.
;		: $vGUID	- Class GUID.
;		: $hWnd - A handle to the top-level window to use for any user interface that is related to non-device-specific actions (such as a select-device dialog box that uses the global class driver list). This handle is optional and can be NULL. If a specific top-level window is not required, set to NULL.
; Return values	: A handle to the empty device information set is returned if succeeds, 0 or -1 otherwise.
; Author	: Pusofalse
; Remarks	: When finished with the device information set handle, call _SetupDiDestroyDeviceInfoList function to free it.
; ====================================================================================
Func _SetupDiCreateDeviceInfoListEx($sMachine, $vGUID = "", $hWnd = 0)
	Local $iResult, $pGuid
	If IsString($vGuid) Then
		If (StringLeft($vGuid, 1) & StringRight($vGuid, 1) = "{}") Then
			$pGuid = DllStructGetPtr(_CM_GUID_From_String($vGuid))
		ElseIf $vGuid <> "" Then
			$tGuid = _SetupDiClassGuidsFromName($vGuid)
			$pGuid = DllStructGetPtr($tGuid)
		EndIf
	ElseIf IsDllStruct($vGuid) Then
		$pGuid = DllStructGetPtr($vGuid)
	ElseIf IsPtr($vGuid) Then
		$pGuid = $vGuid
	Else
		$pGuid = 0
	EndIf
	$iResult = DllCall($SETUPAPI_DllHandle, "ptr", "SetupDiCreateDeviceInfoListEx", "ptr", $pGUID, _
			"hWnd", $hWnd, "str", $sMachine, "ptr", 0)
	Return SetError(_CM_Get_Last_Error(), 0, $iResult[0])
EndFunc	;==>_SetupDiCreateDeviceInfoListEx

; #### FUNCTION ####
; ====================================================================================
; Name	: _SetupDiCreateDeviceDevsEx
; Description	: Creates a device information set for a specified device instance on a local or a remote computer.
; Parameter(s)	: $sDevInstID	- Device instance identifier for which creates device information set.
;		: $hDevs	- A variable receives the handle to the device information set.
;		: $tSP_DEVINFO_DATA - A variable receives a SP_DEVICEINFO_DATA structure.
;		: $sMachine	- System on which the function to execute.
;		: $vGUID	- Class GUID.
;		: $hWnd	- An optional window handle.
; Author	: Pusofalse
; ====================================================================================
Func _SetupDiCreateDeviceDevsEx($sDevInstID, ByRef $hDevs, ByRef $tSP_DEVINFO_DATA, $sMachine, $vGUID = "", $hWnd = 0)
	Local $iResult

	$hDevs = _SetupDiCreateDeviceInfoListEx($sMachine, $vGUID, $hWnd)
	If $hDevs < 1 Then Return SetError(@error, 0, 0)

	Select
	Case _SetupDiOpenDeviceInfo($hDevs, $sDevInstID, $tSP_DEVINFO_DATA) = 0
		Return SetError(@error, _SetupDiDestroyDeviceInfoList($hDevs), 0)
	Case _SetupDiSetSelectedDevice($hDevs, $tSP_DEVINFO_DATA) = 0
		Return SetError(@error, _SetupDiDestroyDeviceInfoList($hDevs), 0)
	Case Else
		Return 1
	EndSelect
EndFunc	;==>_SetupDiCreateDeviceDevsEx

; #### FUNCTION ####
; ====================================================================================
; Name	: _SetupDiSelectOEMDrv
; Description	: This function selects a driver for a device information set or a particular device information element that uses an OEM path supplied by the user.
; Parameter(s)	: $hDevs	- A device information set handle.
;		: $pSP_DEVINFO_DATA - A pointer to an SP_DEVINFO_DATA structure that specifies a device information element in $hDevs.
;		: $hWnd	- Window owner, optional.
; Return values	: True indicates success, false to failure.
; Author	: Pusofalse
; Remarks	: _SetupDiSelectOEMDrv is primarily designed to select an OEM driver for a device on a local computer before installing the device on that computer. Although _SetupDiSelectOEMDrv will not fail if the device information set is for a remote computer, the result is of limited use because the device information set cannot subsequently be used with DIF_Xxx installation requests or _SetupDiXxx functions that do not support operations on a remote computer. In particular, the device information set cannot be used as input with a DIF_INSTALLDEVICE installation request to install a device on a remote computer. The selected driver can be retrieved in a call to _SetupDiGetDeviceInstallParams.
; ====================================================================================
Func _SetupDiSelectOEMDrv($hDevs, $pSP_DEVINFO_DATA, $hWnd = 0)
	Local $iResult
	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf

	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiSelectOEMDrv", "hWnd", $hWnd, _
			"ptr", $hDevs, "ptr", $pSP_DEVINFO_DATA)
	Return SetError(_CM_Get_Last_Error(), 0, $iResult[0])
EndFunc	;==>_SetupDiSelectOEMDrv

; #### FUNCTION ####
; ====================================================================================
; Name	: _SetupDiAskForOEMDisk
; Description	: The function displays a dialog that asks the user for the path of an OEM installation disk.
; Parameter(s)	: $hDevs	- A handle to a device information set for the local computer. This set contains a device information element that represents the device that is being installed. 
;		: $pSP_DEVINFO_DATA - A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in $hDevs.
; Return values	: True indicates success, false indicates failure.
; Author	: Pusofalse
; ====================================================================================
Func _SetupDiAskForOEMDisk($hDevs, $pSP_DEVINFO_DATA)
	Local $iResult
	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiAskForOEMDisk", "ptr", $hDevs, _
			"ptr", $pSP_DEVINFO_DATA)
	Return SetError(_CM_Get_Last_Error(), 0, $iResult[0])
EndFunc	;==>_SetupDiAskForOEMDisk	

; #### FUNCTION ####
; ====================================================================================
; Name	: _SetupDiSetDeviceInterfaceDefault
; Description	: Sets a device interface as the default interface for a device interface class.
; Parameter(s)	: $hDevs	- Supplies a handle to a device information set.
;		: $pSP_DEVIFINFO_DATA - A pointer to a SP_DEVICE_INTERFACE_DATA structure that specifies the device interface in $hDevs.
; Return values	: True indicate success, false indicates failure.
; Author	: Pusofalse
; ====================================================================================
Func _SetupDiSetDeviceInterfaceDefault($hDevs, $pSP_DEVIFINFO_DATA)
	Local $iResult
	If IsDllStruct($pSP_DEVIFINFO_DATA) Then
		$pSP_DEVIFINFO_DATA = DllStructGetPtr($pSP_DEVIFINFO_DATA)
	EndIf
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiSetDeviceInterfaceDefault", "ptr", $hDevs, _
			"ptr", $pSP_DEVIFINFO_DATA, "dword", 0, "ptr", 0)
	Return SetError(_CM_Get_Last_Error(), 0, $iResult[0])
EndFunc	;==>_SetupDiSetDeviceInterfaceDefault

; #### FUNCTION ####
; ====================================================================================
; Name	: _SetupDiRemoveDeviceInterface
; Description	: This function removes a device interface for a device interface class.
; Parameter(s)	: $hDevs	- A handle to the device information set.
;		: $pSP_DEVIFINFO_DATA - A pointer to a SP_DEVICE_INTERFACE_DATA that specifies the device interface in $hDevs.
; Return values	: True indicate success, False to failure, in which case, @error is set to a system error code.
; Author	: Pusofalse
; ====================================================================================
Func _SetupDiRemoveDeviceInterface($hDevs, $pSP_DEVIFINFO_DATA)

	Local $iResult
	If IsDllStruct($pSP_DEVIFINFO_DATA) Then
		$pSP_DEVIFINFO_DATA = DllStructGetPtr($pSP_DEVIFINFO_DATA)
	EndIf
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiRemoveDeviceInterface", "ptr", $hDevs, _
			"ptr", $pSP_DEVIFINFO_DATA)
	Return SetError(_CM_Get_Last_Error(), 0, $iResult[0])
EndFunc	;==>_SetupDiRemoveDeviceInterface

; #### FUNCTION ####
; ====================================================================================
; Name	: _SetupDiInstallDeviceInterfaces
; Description	: The function is the default handler for the DIF_INSTALLINTERFACES installation request. 
; Parameter(s)	: $hDevs	- A handle to a device information set.
;		: $pSP_DEVINFO_DATA - A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in $hDevs.
; Return values	: Returns True if the function completed without error, else False is returned, and the error code for the failure is set in @error.
; Author	: Pusofalse
; ====================================================================================
Func _SetupDiInstallDeviceInterfaces($hDevs, $pSP_DEVINFO_DATA)
	Local $iResult
	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiInstallDeviceInterfaces", "ptr", $hDevs, _
			"ptr", $pSP_DEVINFO_DATA)
	Return SetError(_CM_Get_Last_Error(), 0, $iResult[0])
EndFunc	;==>_SetupDiInstallDeviceInterfaces

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Get_First_Log_Conf_Ex
; Description	: This function retrieves handle to the first logical configuration for a device instance, on a local or remote system.
; Parameter(s)	: $hDevInst	- A device instance handle.
;		: $hMachine	- A machine handle.
;		: $iFlags	- See #### Flags for _CM_Get_First_Log_Conf #### for a value, default retrieves a handle that contains the resource allocation.
; Return values	: A handle to the first logical configuration is returned if succeeds, otherwise returned a value less one.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Get_First_Log_Conf_Ex($hDevInst, $hMachine, $iFlags = $ALLOC_LOG_CONF)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_First_Log_Conf_Ex", "long*", 0, _
			"dword", $hDevInst, "ulong", $iFlags, "ptr", $hMachine)
	Return SetError($iResult[0], 0, $iResult[1])
EndFunc	;==>_CM_Get_First_Log_Conf_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Add_Empty_Log_Conf_Ex
; Description	: This function adds an empty logical configuration for a device instance, on a local or remote system.
; Parameter(s)	: $hDevInst	- A handle to the device instance.
;		: $iPriority	- Priority for the new logical configuration, see LCPRI_* constants for a value.
;		: $iFlags	- Specify the type of the logical configuration, see #### Flags for _CM_Get_First_Log_Conf #### for a value.
;		: $hMachine	- System on which the function executes, a value of zero indicates local.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Add_Empty_Log_Conf_Ex($hDevInst, $iPriority, $iFlags, $hMachine)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Add_Empty_Log_Conf_Ex", "long*", 0, _
			"dword", $hDevInst, "ulong", $iPriority, "ulong", $iFlags, "ptr", $hMachine)
	Return SetError($iResult[0], 0, $iResult[1])
EndFunc	;==>_CM_Add_Empty_Log_Conf_Ex

; #### FUNCTION ####
; ================================================================================
; Name	: _CM_Add_Empty_Log_Conf
; Description	:  The _CM_Add_Empty_Log_Conf function creates an empty logical configuration, for a specified configuration type and a specified device instance, on the local machine.
; Parameter(s)	: $hDevInst	- Supplies a device instance handle that is bound to the local machine.
;		: $iPriority - Configuration priority value, see LCPRI_* constants for a possible value.
;		: $iFlags	- Flags for the logical configuration, see #### Flags for _CM_Get_First_Log_Conf #### for a possible value.
; Return values	: If succeeds, returns a handle the newly created logical configuration. Otherwise, returns a value of zero, and @error is set to a cofiguration management error code.
; Author	: Pusofalse
; ================================================================================
Func _CM_Add_Empty_Log_Conf($hDevInst, $iPriority, $iFlags)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Add_Empty_Log_Conf", "long*", 0, _
			"dword", $hDevInst, "dword", $iPriority, "ulong", $iFlags)
	Return SetError($iResult[0], 0, $iResult[1])
EndFunc	;==>_CM_Add_Empty_Log_Conf

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Get_Next_Log_Conf_Ex
; Description	: This function continues to enumerate the logical configurations for a device instance, on a local or remote system.
; Parameter(s)	: $hLogConf	- Handle to the logical configuration, typically returned by the following functions:
;		:	- _CM_Get_First_Log_Conf
;		:	- _CM_Get_First_Log_Conf_Ex
;		:	- _CM_Get_Next_Log_Conf
;		:	- _CM_Get_Next_Log_Conf_Ex
;		:	- _CM_Add_Empty_Log_Conf
;		:	- _CM_Add_Empty_Log_Conf_Ex
;		: $hMachine	- Handle to the machine.
; Return values	: True indicates success, false to failure, in which case, @error is set to a system error code.
; Author	: Pusofalse
; Remarks	: $hLogConf is an IN/OUT parameter in this function, because this function changes its value by using the handle to the new enumerated logical configuration, a value of zero indicates the enumeration is finished for the device instance.
; ====================================================================================
Func _CM_Get_Next_Log_Conf_Ex(ByRef $hLogConf, $hMachine)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Next_Log_Conf_Ex", "long*", 0, _
			"long", $hLogConf, "ulong", 0, "ptr", $hMachine)
	_CM_Free_Log_Conf_Handle($hLogConf)
	$hLogConf = $iResult[1]
	Return SetError($iResult[0], 0, $iResult[0] = $CR_SUCCESS)
EndFunc	;==>_CM_Get_Next_Log_Conf_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Get_Log_Conf_Priority_Ex
; Description	: Retrieve the priority for the logical configuration of the device instance, on local or remote system.
; Parameter(s)	: $hLogConf	- Handle to the logical configuration, typically returned by the following function:
;		:	_CM_Add_Empty_Log_Conf
;		:	_CM_Add_Empty_Log_Conf_Ex
;		:	_CM_Get_First_Log_Conf
;		:	_CM_Get_First_Log_Conf_Ex
;		:	_CM_Get_Next_Log_Conf
;		:	_CM_Get_Next_Log_Conf_Ex
;		: $hMachine	- Handle to the machine.
; Return values	: A priority value indicates success, or @error if non-zero, the function failed.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Get_Log_Conf_Priority_Ex($hLogConf, $hMachine)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Log_Conf_Priority_Ex", "long", $hLogConf, _
			"ulong*", 0, "ulong", 0, "ptr", $hMachine)
	Return SetError($iResult[0], 0, $iResult[2])
EndFunc	;==>_CM_Get_Log_Conf_Priority_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Free_Log_Conf_Ex
; Description	: This function frees a logical configuraton for a device instance, on local or remote system.
; Parameter(s)	: $hLogConf	- Handle to the logical configuration, typically returned by the following function:
;		:	_CM_Add_Empty_Log_Conf
;		:	_CM_Add_Empty_Log_Conf_Ex
;		:	_CM_Get_First_Log_Conf
;		:	_CM_Get_First_Log_Conf_Ex
;		:	_CM_Get_Next_Log_Conf
;		:	_CM_Get_Next_Log_Conf_Ex
;		: $hMachine	- Handle to the machine.
; Return values	: True indicates success, False indicates failure.
; Author	: Pusofalse
; Remarks	: This function frees a logical configuraton, but not a handle to the logical configuration, to free a handle, call _CM_Free_Log_Conf_Handle function. $hLogConf is an IN/OUT parameter, because that if the function executes successfully, its value will be set to zero.
; ====================================================================================
Func _CM_Free_Log_Conf_Ex(ByRef $hLogConf, $hMachine)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Free_Log_Conf_Ex", "long", $hLogConf, _
			"ulong", 0, "ptr", $hMachine)
	If $iResult[0] = $CR_SUCCESS Then $hLogConf = 0
	Return SetError($iResult[0], 0, $iResult[0] = $CR_SUCCESS)
EndFunc	;==>_CM_Free_Log_Conf_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Get_Next_Res_Des_Ex
; Description	: This function continues to enumerate the resource descriptor for a device instance.
; Parameter(s)	: $hResDes	- Handle to the resource descriptor, see Remarks section for detail.
;		: $iResourceID	- Resource type.
;		: $hMachine	- Handle to the machine.
; Return values	: True indicates success, False indicates failure, in this case, @error is set to a CR_* error code.
; Author	: Pusofalse
; Remarks	: The $hResDes parameter is an IN/OUT parameter. On the first call to this function, $hResDes is returned by _CM_Get_First_Log_Conf or _CM_Get_First_Log_Conf_Ex, then during the subsequent calls to the function, $hResDes is obtained by the previous call. On each call, $hResDes will be updated by using the handle to the new enumerated resource descriptor, if the value of $hResDes is set to zero, then the enumeration is finished.
; ====================================================================================
Func _CM_Get_Next_Res_Des_Ex(ByRef $hResDes, $iResourceID, $hMachine)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Next_Res_Des_Ex", "long*", 0, _
			"long", $hResDes, "int", $iResourceID, _
			"long*", 0, "ulong", 0, "ptr", $hMachine)
	If $iResult[0] Then Return SetError($iResult[0], 0, 0)
	_CM_Free_Res_Des_Handle($hResDes)
	$hResDes = $iResult[1]
	Return SetExtended($iResult[4], $iResult[0] = $CR_SUCCESS)
EndFunc	;==>_CM_Get_Next_Res_Des_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Get_Res_Des_By_Index
; Description	: Retrieves the specified resource descriptor in the logical configuration.
; Parameter(s)	: $hLogConf	- Handle to the logical configuration.
;		: $iIndex	- A DWORD value indicates the resource descriptor's position, zero based.
;		: $iResourceID	- Resource type.
; Return values	: Returns the handle to the specified resource descriptor if succeeds, or zero otherwise.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Get_Res_Des_By_Index($hLogConf, $iIndex, $iResourceID = $RESTYPE_ALL)
	Local $hResDes

	$hResDes = _CM_Get_Res_Des_By_Index_Ex($hLogConf, $iIndex, 0, $iResourceID)
	Return SetError(@error, @extended, $hResDes)
EndFunc	;==>_CM_Get_Res_Des_By_Index

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Get_Res_Des_By_Index_Ex
; Description	: Retrieves the specified resource descriptor in the logical configuration, on local or remote system.
; Parameter(s)	: $hLogConf	- Handle to the logical configuration.
;		: $iIndex	- A DWORD value indicates the resource descriptor's position, zero based.
;		: $hMachine	- A machine handle.
;		: $iResourceID	- Resource type.
; Return values	: Returns the handle to the specified resource descriptor if succeeds, or zero otherwise.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Get_Res_Des_By_Index_Ex($hLogConf, $iIndex, $hMachine = 0, $iResourceID = $RESTYPE_ALL)
	Local $iResult, $hResDes = $hLogConf, $iPointer = -1

	While _CM_Get_Next_Res_Des_Ex($hResDes, $iResourceID, $hMachine)
		$iPointer += 1
		If $iPointer = $iIndex Then Return SetExtended(@extended, $hResDes)
	WEnd
	Return SetError(@error, 0, 0)
EndFunc	;==>_CM_Get_Res_Des_By_Index_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Modify_Res_Des_Ex
; Description	: This function modifies a resource descriptor in a logical configuration for a device instance.
; Parameter(s)	: $hResDes	- Handle to the resource descriptor to modify.
;		: $iResourceID	- Resource type of the $hResDes.
;		: $pData	- A pointer to a buffer that contains the resource data.
;		: $iDataSize	- Specifies the size of the buffer.
;		: $hMachine	- A machine handle.
; Return values	: True indicates success, False indicates failure. If failure, @error is set to a CR_* error code.
; Author	: Pusofalse
; Remarks	: $hResDes is an IN/OUT parameter, because that the function will change its value by using the handle to the modified resource descriptor.
; ====================================================================================
Func _CM_Modify_Res_Des_Ex(ByRef $hResDes, $iResourceID, $pData, $iDataSize, $hMachine)
	Local $iResult

	If IsDllStruct($pData) Then $pData = DllStructGetPtr($pData)
	If Not IsPtr($pData) Then Return SetError($CR_INVALID_DATA, 0, 0)

	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Modify_Res_Des_Ex", "long*", 0, _
			"long", $hResDes, "int", $iResourceID, "ptr", $pData, _
			"ulong", $iDataSize, "ulong", 0, "ptr", $hMachine)
	_CM_Free_Res_Des_Handle($hResDes)
	$hResDes = $iResult[1]
	Return SetError($iResult[0], 0, $iResult[0] = $CR_SUCCESS)
EndFunc	;==>_CM_Modify_Res_Des_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Add_Res_Des_Ex
; Description	: This function creates a new resource descriptor for a logical configuration.
; Parameter(s)	: $hLogConf	- Handle to the logical configuration at which the new resource descriptor is created.
;		: $iResourceID	- Specifies the type of the new resource descriptor.
;		: $pData	- A pointer to a buffer contains the resource descriptor data.
;		: $iDataSize	- Size of the buffer.
;		: $hMachine	- Supplies a machine handle.
; Return values	: The handle to the newly created resource is returned if the function completed without error. Else, the reason code of the failure can be obtained in @error.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Add_Res_Des_Ex($hLogConf, $iResourceID, $pData, $iDataSize, $hMachine)
	Local $iResult
	If IsDllStruct($pData) Then $pData = DllStructGetPtr($pData)
	If Not IsPtr($pData) Then Return SetError($CR_INVALID_DATA, 0, -1)

	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Add_Res_Des_Ex", "long*", 0, _
			"long", $hLogConf, "int", $iResourceID, "ptr", $pData, _
			"ulong", $iDataSize, "ulong", 0, "ptr", $hMachine)
	Return SetError($iResult[0], 0, $iResult[1])
EndFunc	;==>_CM_Add_Res_Des_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Free_Res_Des_Ex
; Description	: This function frees a resource for a device instance, on local or remote system.
; Parameter(s)	: $hResDes	- Handle to the resource, this is an IN/OUT parameter, see remarks section.
;		: $hMachine	- Handle to the machine.
; Return values	: True indicates success, False indicates failure.
; Author	: Pusofalse
; Remarks	: This function frees a resource descriptor, but not a descriptor's handle, to free the handle, call _CM_Free_Res_Des_Handle function. $hResRes should be updated after the call, the new value of $hResRes is the handle to a resource descriptor that was previous. If $hResDes represented the resource descriptor located first in the logical configuration, $hResDes is set to the handle of the logical configuration.
; ====================================================================================
Func _CM_Free_Res_Des_Ex(ByRef $hResDes, $hMachine)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Free_Res_Des_Ex", "long*", 0, _
			"long", $hResDes, "ulong", 0, "ptr", $hMachine)
	_CM_Free_Res_Des_Handle($hResDes)
	$hResDes = $iResult[1]
	Return SetError($iResult[0], 0, $iResult[0] = $CR_SUCCESS)
EndFunc	;==>_CM_Free_Res_Des_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Duplicate_Buffer
; Description	: This function duplicates a memory block.
; Parameter(s)	: $pBuffer - A pointer to a memory block, typically returned by _CM_Heap_Alloc function.
; Return values	: A pointer to a duplicated buffer.
; Author	: Pusofalse
; Remarks	: If $pBuffer is not returned by _CM_Heap_Alloc, the function fails.
; ====================================================================================
Func _CM_Duplicate_Buffer($pBuffer)
	Local $pBuffer2, $tBuffer2, $iLength, $bData

	$iLength = _CM_Heap_Size($pBuffer)
	If $iLength < 1 Then Return SetError(@error, 0, 0)

	$tBuffer = DllStructCreate("byte Data[" & $iLength & "]", $pBuffer)
	$bData = DllStructGetData($tBuffer, "Data")
	$pBuffer2 = _CM_Heap_Alloc($iLength)
	$tBuffer2 = DllStructCreate("byte Data[" & $iLength & "]", $pBuffer2)
	DllStructSetData($tBuffer2, "Data", $bData)
	Return $pBuffer2
EndFunc	;==>_CM_Duplicate_Buffer

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Get_Device_Resources_Ex
; Description	: This function lists the device instance resources, on a local or a remote system.
; Parameter(s)	: $hDevInst	- A device instance handle.
;		: $hMachine	- A machine handle.
;		: $iResourceID	- Specifies the type of the resources to be retrieved, default to retrieve all.
; Return values	: An array in the following format:
;		:	- $aArray[0][0]	- The number of resource entries returned.
;		:	- $aArray[1][0]	- The type of the resource of 1st resource, for example, 'MEM' indicates a memory resource.
;		:	- $aArray[1][1]	- The configuration of the 1st resource.
;		:	- $aArray[2][0]	- 2nd resource type.
;		:	- $aArray[2][1]	- 2nd resource configuration.
;		:	... ...
; Author	: Pusofalse
; ====================================================================================
Func _CM_Get_Device_Resources_Ex($hDevInst, $hMachine = 0, $iResourceID = $RESTYPE_ALL, $hLogConf = -1)
	Local $iResult, $aResult[1][3] = [[0]], $hResDes, $iResType, $tagStruct, $tBuffer, $iIndex = -1

	If $hLogConf <> -1 Then
		$hResDes = $hLogConf
	Else
		$hResDes = _CM_Get_First_Log_Conf_Ex($hDevInst, $hMachine, $ALLOC_LOG_CONF)
		If @error Then $hResDes = _CM_Get_First_Log_Conf_Ex($hDevInst, $hMachine, $BOOT_LOG_CONF)
	EndIf
	If $hResDes < 1 Then Return SetError(@error, 0, $aResult)
	While _CM_Get_Next_Res_Des_Ex($hResDes, $iResourceID, $hMachine)
		$iIndex += 1
		If $iResourceID = $RESTYPE_ALL Then
			$iResType = @extended
		Else
			$iResType = $iResourceID
		EndIf

		Switch $iResType
		Case $RESTYPE_MEM
			$tagStruct = $tagMEM_DES
		Case $RESTYPE_IO
			$tagStruct = $tagIO_DES
		Case $RESTYPE_DMA
			$tagStruct = $tagDMA_DES
		Case $RESTYPE_IRQ
			$tagStruct = $tagIRQ_DES
		Case $RESTYPE_BUSNUMBER
			$tagStruct = $tagBUSNUMBER_DES
		Case $RESTYPE_PCCARDCONFIG
			$tagStruct = $tagPCCARD_DES
		Case $RESTYPE_MFCARDCONFIG
			$tagStruct = $tagMFCARD_DES
		Case $RESTYPE_CLASSSPECIFIC
			$tagStruct = $tagCS_DES
		Case Else
			ContinueLoop
		EndSwitch

		$aResult[0][0] += 1
		Redim $aResult[$aResult[0][0] + 1][3]
		$aResult[$aResult[0][0]][2] = $iIndex
		$pBuffer = _CM_Get_Res_Des_Data_Ex($hResDes, $hMachine)
		$tBuffer = DllStructCreate($tagStruct, $pBuffer)
		Switch $iResType
		Case $RESTYPE_MEM, $RESTYPE_IO
			$aResult[$aResult[0][0]][0] = "MEM"
			If $iResType = $RESTYPE_IO Then $aResult[$aResult[0][0]][0] = "IO"
			Local $tBinary = DllStructCreate("byte AllocBase[8];byte AllocEnd[8]", DllStructGetPtr($tBuffer, "AllocBase"))
			Local $bBase = String(DllStructGetData($tBinary, "AllocBase"))
			Local $bEnd = String(DllStructGetData($tBinary, "AllocEnd"))
			Local $sBase = "", $sEnd = ""
			For $i = 3 To 17 Step 2
				$sBase = StringMid($bBase, $i, 2) & $sBase
				$sEnd = StringMid($bEnd, $i, 2) & $sEnd
			Next
			$aResult[$aResult[0][0]][1] = "0x" & $sBase & " - 0x" & $sEnd
		Case $RESTYPE_BUSNUMBER
			$aResult[$aResult[0][0]][0] = "BUSNUMBER"
	$aResult[$aResult[0][0]][1] = "0x" & Hex(DllStructGetData($tBuffer, "AllocBase")) & " - 0x" & Hex(DllStructGetData($tBuffer, "AllocEnd"))
		Case $RESTYPE_IRQ
			$aResult[$aResult[0][0]][0] = "IRQ"
			$aResult[$aResult[0][0]][1] = "0x" & Hex(DllStructGetData($tBuffer, "AllocNum"))
		Case $RESTYPE_DMA
			$aResult[$aResult[0][0]][0] = "DMA"
			$aResult[$aResult[0][0]][1] = "0x" & Hex(DllStructGetData($tBuffer, "AllocChannel"))
		Case $RESTYPE_MFCARDCONFIG
			$aResult[$aResult[0][0]][0] = "MFCARD"
			$aResult[$aResult[0][0]][1] = "0x" & Hex(DllStructGetData($tBuffer, "ConfigRegisterBase"))
		Case $RESTYPE_PCCARDCONFIG
			$aResult[$aResult[0][0]][0] = "PCCARD"
$aResult[$aResult[0][0]][1] = "0x" & Hex(DllStructGetData($tBuffer, "MemCardBase1")) & " / 0x" & Hex(DllStructGetData($tBuffer, "MemCardBase2"))
		Case $RESTYPE_CLASSSPECIFIC
			$aResult[$aResult[0][0]][0] = "CS"
			Local $iSignatureLength, $tData, $pData, $iOffset, $iSizeofBuffer, $iLegacyLength
			$iOffset = DllStructGetData($tBuffer, "LegacyDataOffset")
			$iSignatureLength = DllStructGetData($tBuffer, "SignatureLength")
			$iLegacyLength = DllStructGetData($tBuffer, "LegacyDataSize")
			$tData = DllStructCreate($tagCS_DES & ";byte Signature[" & $iSignatureLength & "]", $pBuffer)
			$iSizeofBuffer = DllStructGetSize($tData)
			$pData = $pBuffer + $iSizeofBuffer + $iOffset
			$tData = DllStructCreate("byte LegacyData[" & $iLegacyLength & "]", $pData)
			$aResult[$aResult[0][0]][1] = DllStructGetData($tData, "LegacyData")
			_CM_Free_Variable($tData)
		EndSwitch
		_CM_Heap_Free($pBuffer)
		_CM_Free_Variable($tBuffer)
	WEnd
	Return SetError(@error, 0, $aResult)
EndFunc	;==>_CM_Get_Device_Resources_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Get_Res_Des_Data_Size_Ex
; Description	: Retrieves the buffer length requested to hold the resource data on a local or remote system.
; Parameter(s)	: $hResDes	- Handle to the resource.
;		: $hMachine	- Handle to the machine.
; Return values	: Length requested, or zero otherwise.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Get_Res_Des_Data_Size_Ex($hResDes, $hMachine)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Res_Des_Data_Size_Ex", _
			"ulong*", 0, "long", $hResDes, "ulong", 0, "ptr", $hMachine)
	Return SetError($iResult[0], 0, $iResult[1])
EndFunc	;==>_CM_Get_Res_Des_Data_Size_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Get_Res_Des_Data_Ex
; Description	: Retrieves the resource data for a device instance on a local or remote system.
; Parameter(s)	: $hResDes	- Handle to the device instance resource.
;		: $hMachine	- Handle to the machine, typically returned by _CM_Connect_Machine.
; Return values	: If succeeds, returns the pointer to the data of the device instance resource, or zero otherwise, @error is set to a CR_* error code. Must call _CM_Heap_Free function to free the pointer when finished with it.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Get_Res_Des_Data_Ex($hResDes, $hMachine)
	Local $iLength, $iResult, $pBuffer

	$iLength = _CM_Get_Res_Des_Data_Size_Ex($hResDes, $hMachine)
	If $iLength < 1 Then Return SetError(@error, 0, 0)

	$pBuffer = _CM_Heap_Alloc($iLength)
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Res_Des_Data_Ex", "long", $hResDes, _
			"ptr", $pBuffer, "ulong", $iLength, "ulong", 0, "ptr", $hMachine)
	If $iResult[0] Then Return SetError($iResult[0], 0 * _CM_Heap_Free($pBuffer), 0)
	Return $pBuffer
EndFunc	;==>_CM_Get_Res_Des_Data_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Get_Device_Interface_List_Ex
; Description	: This function lists the device interfaces for a device interface class.
; Parameter(s)	: $hMachine	- Supplies a machine handle.
;		: $vClassGuid	- Device interface class GUID.
;		: $sDeviceInstID	- An optional device instance ID string, if non-null, the function retrieves the device path associated with this device instance. If NULL, the function retrieves the device paths associcated the GUID specified in $vClassGUID.
;		: $iFlags	- CM_GET_DEVICE_INTERFACE_LIST_ALL_DEVICES: The function provides a list containing device interfaces associated with all devices that match the specified GUID and device instance ID, if any.
;		:	- CM_GET_DEVICE_INTERFACE_LIST_PRESENT: The function provides a list containing device interfaces associated with devices that are currently active, and which match the specified GUID and device instance ID, if any.
; Return values	: An array in the following format:
;		:	- $aArray[0]	- The number of returned entries.
;		:	- $aArray[1]	- 1st device path.
;		:	- $aArray[2]	- 2nd device path.
;		:	... ...
; Author	: Pusofalse
; ====================================================================================
Func _CM_Get_Device_Interface_List_Ex($hMachine, $vClassGuid, $sDeviceInstID = "", $iFlags = 0)
	Local $iResult, $iLength, $iPointer, $pBuffer, $tBuffer, $tClassGuid, $pClassGuid, $aResult[1] = [0]

	If IsDllStruct($vClassGuid) Then
		$vClassGuid = DllStructGetPtr($vClassGuid)
	ElseIf IsString($vClassGuid) Then
		$tClassGuid = _CM_GUID_From_String($vClassGuid)
		$pClassGuid = DllStructGetPtr($tClassGuid)
	Else
		$pClassGuid = $vClassGuid
	EndIf
	If Not IsPtr($pClassGuid) Then Return SetError($CR_INVALID_DATA, 0, 0)

	$iLength = _CM_Get_Device_Interface_List_Size_Ex($hMachine,$pClassGuid,$sDeviceInstID,$iFlags)
	If $iLength < 1 Then Return SetError(@error, 0, $aResult)
	$pBuffer = _CM_Heap_Alloc($iLength)
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Device_Interface_List_Ex", _
			"ptr", $pClassGuid, "str", $sDeviceInstID, "ptr", $pBuffer, _
			"ulong", $iLength, "ulong", $iFlags, "ptr", $hMachine)
	If $iResult[0] Then Return SetError($iResult[0], 0, $aResult)

	While $iPointer < $iLength - 1
		$tBuffer = DllStructCreate("char DevicePath[260]", $pBuffer)
		$aResult[0] += 1
		Redim $aResult[$aResult[0] + 1]
		$aResult[$aResult[0]] = DllStructGetData($tBuffer, "DevicePath")
		If $aResult[$aResult[0]] = "" Then ExitLoop
		$iResult = StringLen($aResult[$aResult[0]]) + 1
		$iPointer += $iResult
		$pBuffer += $iResult
	WEnd
	_CM_Heap_Free($pBuffer)
	_CM_Free_Variable($tBuffer)
	Return $aResult
EndFunc	;==>_CM_Get_Device_Interface_List_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Get_Device_Interface_List_Size_Ex
; Description	: Retrieves the buffer length requested to hold the device interfaces, on a local or remote system.
; Parameter(s)	: $hMachine	- Handle to the machine on which the function executes.
;		: $vClassGuid	- Device interface class GUID, must same as $vClassGuid parameter in _CM_Get_Device_Interface_List_Ex.
;		: $sDeviceInstID	- String contains a device instance ID, can be NULL.
;		: $iFlags	- See _CM_Get_Device_Interface_List_Ex.
; Return values	: Returns a value of non-zero indicates the buffer length requested, or zero otherwise.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Get_Device_Interface_List_Size_Ex($hMachine, $vClassGuid, $sDeviceInstID = "", $iFlags = 0)
	Local $iResult, $pClassGuid, $tClassGuid

	If IsDllStruct($vClassGuid) Then
		$vClassGuid = DllStructGetPtr($vClassGuid)
	ElseIf IsString($vClassGuid) Then
		$tClassGuid = _CM_GUID_From_String($vClassGuid)
		$pClassGuid = DllStructGetPtr($tClassGuid)
	Else
		$pClassGuid = $vClassGuid
	EndIf
	If Not IsPtr($pClassGuid) Then Return SetError($CR_INVALID_DATA, 0, 0)

	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Device_Interface_List_Size_Ex", "ulong*", 0, _
			"ptr", $pClassGuid, "str", $sDeviceInstID, "ulong", $iFlags, "ptr", $hMachine)
	Return SetError($iResult[0], _CM_Free_Variable($tClassGuid), $iResult[1])
EndFunc	;==>_CM_Get_Device_Interface_List_Size_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Get_DevNode_Registry_Property_Ex
; Description	: Retrieves the property of the specified device instance on a local or a remote system.
; Parameter(s)	: $hDevInst	- A handle to the device information set.
;		: $iProperty	- Property to be retrieved, see CM_DRP* constants for a value.
; Return values	: Requested property if succeeds, otherwise, @error is set to a configuration manager error code.
; Author: Pusofalse
; ====================================================================================
Func _CM_Get_DevNode_Registry_Property_Ex($hDevInst, $iProperty, $hMachine)
	Local $iResult, $tBuffer, $pBuffer, $vResult

	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_DevNode_Registry_Property_Ex", _
			"dword", $hDevInst, "ulong", $iProperty, "ulong*", 0, "ptr", 0, _
			"ulong*", 0, "ulong", 0, "ptr", $hMachine)
	If $iResult[5] = 0 Then Return SetError($iResult[0], 0, "")
	$pBuffer = _CM_Heap_Alloc($iResult[5])
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_DevNode_Registry_Property_Ex", _
			"dword", $hDevInst, "ulong", $iProperty, "ulong*", 0, "ptr", $pBuffer, _
			"ulong*", $iResult[5], "ulong", 0, "ptr", $hMachine)
	If $iResult[0] Then Return SetError($iResult[0], 0, "")

	Switch $iResult[3]
	Case 1, 2 ; REG_SZ, REG_EXPAND_SZ
		$tBuffer = DllStructCreate("char Data[" & $iResult[5] & "]", $pBuffer)
		$vResult = DllStructGetData($tBuffer, "Data")
	Case 3 ; REG_BINARY
		$tBuffer = DllStructCreate("byte Data[" & $iResult[5] & "]", $pBuffer)
		$vResult = DllStructGetData($tBuffer, "Data")
	Case 4, 5 ; REG_DWORD, REG_DWORD_BIG_ENDIAN
		$tBuffer = DllStructCreate("dword Data", $pBuffer)
		$vResult = DllStructGetData($tBuffer, "Data")
	Case 6 ; REG_LINK
		$tBuffer = DllStructCreate("wchar Data[" & $iResult[5] / 2 & "]", $pBuffer)
		$vResult = DllStructGetData($tBuffer, "Data")
	Case 7 ; REG_MULTI_SZ
		Local $sChr
		$tBuffer = DllStructCreate("char Data[" & $iResult[5] & "]", $pBuffer)
		For $i = 1 To $iResult[5]
			$sChr = DllStructGetData($tBuffer, "Data", $i)
			If $sChr = Chr(0) Then
				$vResult &= @LF
			Else
				$vResult &= $sChr
			EndIf
		Next
		If StringRight($vResult, 1) = Chr(0) Then $vResult = StringTrimRight($vResult, 1)
	Case Else
		$tBuffer = DllStructCreate("byte Data[" & $iResult[5] & "]", $pBuffer)
		$vResult = DllStructGetData($tBuffer, "Data")
	EndSwitch	
	_CM_Heap_Free($pBuffer)
	Return SetError(0, _CM_Free_Variable($tBuffer), $vResult)
EndFunc	;==>_CM_Get_DevNode_Registry_Property_Ex

; #### FUNCTION ####
; =================================================================================
; Name	: _CM_Get_Class_Registry_Property_Ex
; Description	: This function retrieves the device setup class property.
; Parameter(s)	: $vClassGuid	- Device setup class GUID.
;		: $iProperty	- Property requested, see CM_CRP_* contants for a value.
;		: $hMachine	- Supplies a machine handle, zero indicates on local system.
; Return values	: Property value is returned if succeeds, @extended is set to the type of the return value. Otherwise, returns NULL and sets @error to a configuration manager error code.
; Author	: Pusofalse
; Remarks	: _CM_Get_Class_Registry_Property_Ex function should only be used on Windows 2000 system.
; =================================================================================
Func _CM_Get_Class_Registry_Property_Ex($vClassGuid, $iProperty, $hMachine = 0)
	Local $pBuffer, $tBuffer, $iResult, $tClassGuid, $pClassGuid, $vResult

	If IsPtr($vClassGuid) Then
		$pClassGuid = $vClassGuid
	ElseIf IsDllStruct($vClassGuid) Then
		$pClassGuid = DllStructGetPtr($vClassGuid)
	Else
		If IsString($vClassGuid) Then
			If StringLeft($vClassGuid, 1) & StringRight($vClassGuid, 1) = "{}" Then
				$tClassGuid = _CM_GUID_From_String($vClassGuid)
			Else
				$tClassGuid = _SetupDiClassGuidsFromName($vClassGuid)
			EndIf
			$pClassGuid = DllStructGetPtr($tClassGuid)
		EndIf
	EndIf

	If Not IsPtr($pClassGuid) Then Return SetError($CR_INVALID_DATA, 0, "")
	$iResult = DllCall("Cfgmgr32.dll", "long", "CM_Get_Class_Registry_Property", _
			"ptr", $pClassGuid, "ulong", $iProperty, "ulong*", 0, "ptr", 0, _
			"ulong*", 0, "ulong", 0, "ptr", $hMachine)
	$pBuffer = _CM_Heap_Alloc($iResult[5])
	$iResult = DllCall("Cfgmgr32.dll", "long", "CM_Get_Class_Registry_Property", _
			"ptr", $pClassGuid, "ulong", $iProperty, "ulong*", 0, "ptr", $pBuffer, _
			"ulong*", $iResult[5], "ulong", 0, "ptr", $hMachine)
	_CM_Free_Variable($tClassGuid)
	Switch $iResult[3]
	Case 1, 2, 7
		$tBuffer = DllStructCreate("char Data[" & $iResult[5] & "]", $pBuffer)
	Case 4, 5
		$tBuffer = DllStructCreate("dword Data", $pBuffer)
	Case 6
		$tBuffer = DllStructCreate("wchar Data[" & Int($iResult[5] / 2) + 2 & "]", $pBuffer)
	Case Else
		$tBuffer = DllStructCreate("byte Data[" & $iResult[5] & "]", $pBuffer)
	EndSwitch
	If $iResult[3] <> 7 Then
		$vResult = DllStructGetData($tBuffer, "Data")
	Else
		Local $sChr
		For $i = 1 To $iResult[5]
			$sChr = DllStructGetData($tBuffer, "Data", $i)
			If $sChr = Chr(0) Then
				$vResult &= @LF
			Else
				$vResult &= $sChr
			EndIf
		Next
		While StringRight($vResult, 1) = @LF
			$vResult = StringTrimRight($vResult, 1)
		WEnd
	EndIf
	_CM_Heap_Free($pBuffer)
	Return SetError($iResult[0], $iResult[3] + _CM_Free_Variable($tBuffer), $vResult)
EndFunc	;==>_CM_Get_Class_Registry_Property_Ex

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Get_DevNode_Registry_Property
; Description	: Retrieves the device instance property on a local system.
; Parameter(s)	: $hDevInst	- Supplies a device instance handle.
;		: $iProperty	- Specifies a property value to be retrieved, see CM_DRP* constants for a value.
; Return values	: Requested property is returned if succeeds, otherwise, @error is set to a configuration manager error code.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Get_DevNode_Registry_Property($hDevInst, $iProperty)
	Local $vResult
	$vResult = _CM_Get_DevNode_Registry_Property_Ex($hDevInst, $iProperty, 0)
	Return SetError(@error, 0, $vResult)
EndFunc	;==>_CM_Get_DevNode_Registry_Property

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Advanced_Properties
; Description	: This function displays the advanced properties for a specified device.
; Parameter(s)	: $sDeviceID	- Device instance identifier.
;		: $hWnd	- Handle the window own the properties window.
;		: $sMachine	- Machine on which the function executes, default is local.
; Return values	: True indicates success, otherwise the @error is set to a system error.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Advanced_Properties($sDeviceID, $hWnd = 0, $sMachine = "")
	Local $iResult

	$iResult = DllCall($DEVMGR_DllHandle, "int_ptr", "DeviceAdvancedPropertiesW", "hWnd", $hWnd, _
			"wstr", $sMachine, "wstr", $sDeviceID)
	Return SetError(_CM_Get_Last_Error(), 0, $iResult[0])
EndFunc	;==>_CM_Advanced_Properties

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Format_Problem_Text_Ex
; Description	: This function formats a problem text.
; Parameter(s)	: $hDevInst	- Supplies the handle to a device instance.
;		: $iProblemID	- Problem ID.
;		: $hMachine	- Supplies the handle to a machine, default is local.
; Return values	: Problem text corresponding to the $iProblemID if succeeds.
; Author	: Pusofalse
; ====================================================================================
Func _CM_Format_Problem_Text_Ex($hDevInst, $iProblemID, $hMachine = 0)
	Local $iResult
	$iResult = DllCall($DEVMGR_DllHandle, "uint", "DeviceProblemTextW", "ptr", $hMachine, _
			"dword", $hDevInst, "ulong", $iProblemID, "wstr", "", "uint", 1024)
	Return SetError(_CM_Get_Last_Error(), 0, $iResult[4])
EndFunc	;==>_CM_Format_Problem_Text_Ex

Func _CM_Device_Properties_Ex($sDeviceID, $hWnd = 0, $fShowDevMgr = 0, $iFlags = 0, $sMachine = "")
	Local $iResult
	$iResult = DllCall($DEVMGR_DllHandle, "int_ptr", "DevicePropertiesExW", "hWnd", $hWnd, _
			"wstr", $sMachine, "wstr", $sDeviceID, "dword", $iFlags, "int", $fShowDevMgr)
	Return SetError(_CM_Get_Last_Error(), 0, $iResult[0])
EndFunc	;==>_CM_Device_Properties_Ex

Func _CM_Device_Problem_Wizard_Ex($sDeviceID, $hWnd = 0, $sMachine = "")
	Local $iResult
	$iResult = DllCall($DEVMGR_DllHandle, "int", "DeviceProblemWizardW", "hWnd", $hWnd, _
			"wstr", $sMachine, "wstr", $sDeviceID)
	Return SetError(_CM_Get_Last_Error(), 0, $iResult[0])
EndFunc	;==>_CM_Device_Problem_Wizard_Ex

; #### Reserved, only used for debug ####
; =====================================================================================
; Name	: _CM_Format_Error_Message
; Parameter(s)	: $iErrorCode	- Error code, returned by _CM_*.
; Remarks	: $iErrorCode is a configuration manager error code, but not a system error code.
; Return values	: Variable identifier corresponds to the error code.
; =====================================================================================
Func _CM_Format_Error_Message($iErrorCode, $fShow = False, $sFunction = "", $vParams = "")
	Local $iFlag = 64, $sMsg, $sVal

	$sMsg &= "SUCCESS, DEFAULT, OUT OF MEMORY, INVALID POINTER, "
	$sMsg &= "INVALID FLAG, INVALID DEVNODE, INVALID RES DES, "
	$sMsg &= "INVALID LOG CONF, INVALID ARBITRATOR, NODELIST, DEVNODE HAS REQS, "
	$sMsg &= "INVALID RESOURCEID, DLVXD NOT FOUND, NO SUCH DEVNODE, "
	$sMsg &= "NO MORE LOG CONF, NO MORE RES DES, ALREADY SUCH DEVNODE, "
	$sMsg &= "INVALID RANGE LIST, INVALID RANGE, FAILURE, NO SUCH LOGICAL DEV, "
	$sMsg &= "CREATE BLOCKED, NOT SYSTEM VM, EMOVE VETOED, APM VETOED, "
	$sMsg &= "INVALID LOAD TYPE, BUFFER SMALL, NO ARBITRATOR, "
	$sMsg &= "NO REGISTRY HANDLE, REGISTRY ERROR, INVALID DEVICE ID, "
	$sMsg &= "INVALID DATA, INVALID API, DEVLOADER NOT READY, "
	$sMsg &= "NEED RESTART, NO MORE HW PROFILES, DEVICE NOT THERE, "
	$sMsg &= "NO SUCH VALUE, WRONG TYPE, INVALID PRIORITY, NOT DISABLEABLE, "
	$sMsg &= "FREE RESOURCES, QUERY VETOED, CANT SHARE IRQ, NO DEPENDENT, "
	$sMsg &= "SAME RESOURCES, NO SUCH REGISTRY KEY, INVALID MACHINENAME, "
	$sMsg &= "REMOTE COMM FAILURE, MACHINE UNAVAILABLE, NO CM SERVICES, "
	$sMsg &= "ACCESS DENIED, CALL NOT IMPLEMENTED, INVALID PROPERTY, "
	$sMsg &= "DEVICE INTERFACE ACTIVE, NO SUCH DEVICE INTERFACE, "
	$sMsg &= "INVALID REFERENCE STRING, INVALID CONFLICT LIST, "
	$sMsg &= "INVALID INDEX, INVALID STRUCTURE SIZE, INTERNAL UNKNOWN ERROR"

	$aMsg = StringSplit($sMsg, ", ", 1)
	If $iErrorCode < 0 OR $iErrorCode > $aMsg[0] Then $iErrorCode = $aMsg[0] - 1
	$sVal = "$CR_" & StringReplace($aMsg[$iErrorCode + 1], " ", "_")
	$sMsg = ""
	If $fShow Then
		If $iErrorCode Then $iFlag = 48
		$sMsg &= "Function: " & "CM\" & $sFunction & @CRLF & @CRLF
		$sMsg &= "Error code: " & $sVal & " (" & $iErrorCode & ")           "
		If $vParams Then $sMsg &= @CRLF & @CRLF & "Parameter(s): " & $vParams
		Msgbox($iFlag, "Configuration Manager", $sMsg)
	EndIf
	Return $sVal
EndFunc	;==>_CM_Format_Error_Message

Func _CM_Get_HW_Prof_Flags_Ex($sDeviceID, $hMachine, $iHardwareProfile = 0)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_HW_Prof_Flags_Ex", "str", $sDeviceID, _
			"ulong", $iHardwareProfile, "ulong*", 0, "ulong", 0, "ptr", $hMachine)
	Return SetError($iResult[0], 0, $iResult[3])
EndFunc	;==>_CM_Get_HW_Profile_Flags_Ex

Func _CM_Get_HW_Prof_Flags($sDeviceID, $iHardwareProfile = 0)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_HW_Prof_Flags", "str", $sDeviceID, _
			"ulong", $iHardwareProfile, "ulong*", 0, "ulong", 0)
	Return SetError($iResult[0], 0, $iResult[3])
EndFunc	;==>_CM_Get_HW_Prof_Flags

Func _SetupDiInstallClass($sInfFileName, $iFlags, $hFileQueue = 0, $hWndOwner = 0)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiInstallClass", "hWnd", $hWndOwner, _
			"str", $sInfFileName, "dword", $iFlags, "hWnd", $hFileQueue)
	Return SetError(_CM_Get_Last_Error(), 0, $iResult[0])
EndFunc	;==>_SetupDiInstallClass

Func _SetupDiInstallClassEx($sInfFileName, $iFlags, $vGUID = "", $hFileQueue = 0, $hWndOwner = 0)
	Local $iResult, $tGUID, $pGUID

	If IsString($vGUID) Then
		If StringLeft($vGUID, 1) & StringRight($vGUID, 1) = "{}" Then
			$tGUID = _CM_GUID_From_String($vGUID)
			$pGUID = DllStructGetPtr($tGUID)
		EndIf
	ElseIf IsDllStruct($vGUID) Then
		$pGUID = DllStructGetPtr($vGUID)
	ElseIf IsPtr($vGUID) Then
		$pGUID = $vGUID
	Else
		$pGUID = 0
	EndIf

	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiInstallClassEx", "hWnd", $hWndOwner, _
			"str", $sInfFileName, "dword", $iFlags, "hWnd", $hFileQueue, _
			"ptr", $pGUID, "ptr", 0, "ptr", 0)
	Return SetError(_CM_Get_Last_Error(), 0, $iResult[0])
EndFunc	;==>_SetupDiInstallClassEx

; #### FUNCTION ####
; ====================================================================================
; Name	: _SetupDiDeleteDeviceInfo
; Description	: This function deletes a device information element from a device information set.
; Parameter(s)	: $hDevs	- Handle to a device information set.
;		: $pSP_DEVINFO_DATA - A pointer to a SP_DEVICEINFO_DATA.
; Return values	: True indicates success, False indicates failure.
; Author	: Pusofalse
; Remarks	: This function does not delete an actual device.
; ====================================================================================
Func _SetupDiDeleteDeviceInfo($hDevs, $pSP_DEVINFO_DATA)
	Local $iResult
	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiDeleteDeviceInfo", "ptr", $hDevs, _
			"ptr", $pSP_DEVINFO_DATA)
	Return SetError(_CM_Get_Last_Error(), 0, $iResult[0])
EndFunc	;==>_SetupDiDeleteDeviceInfo

Func _SetupDiCreateDeviceInterfaceRegKey($hDevs, $pSP_DEVIFINFO_DATA, $iAccess, $hInfFile = 0, $sInfSection = 0)
	Local $iResult

	If IsDllStruct($pSP_DEVIFINFO_DATA) Then
		$pSP_DEVIFINFO_DATA = DllStructGetPtr($pSP_DEVIFINFO_DATA)
	EndIf

	; Returns the handle to the registry key.
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "SetupDiCreateDeviceInterfaceRegKey", _
			"ptr", $hDevs, "ptr", $pSP_DEVIFINFO_DATA, "dword", 0, _
			"dword", $iAccess, "hWnd", $hInfFile, "str", $sInfSection)
	Return SetError(_CM_Get_Last_Error(), 0, $iResult[0])
EndFunc	;==>_SetupDiCreateDeviceInterfaceRegKey

Func _SetupDiDeleteDeviceInterfaceRegKey($hDevs, $pSP_DEVIFINFO_DATA)
	Local $iResult

	If IsDllStruct($pSP_DEVIFINFO_DATA) Then
		$pSP_DEVIFINFO_DATA = DllStructGetPtr($pSP_DEVIFINFO_DATA)
	EndIf

	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiDeleteDeviceInterfaceRegKey", _
			"ptr", $hDevs, "ptr", $pSP_DEVIFINFO_DATA, "dword", 0)
	Return SetError(_CM_Get_Last_Error(), 0, $iResult[0])
EndFunc	;==>_SetupDiDeleteDeviceInterfaceRegKey

; #### FUNCTION ####
; ====================================================================================
; Name	: _SetupDiGetDeviceInterfaceDevs
; Description	: Specifies the device path, returns the device information set associated with this device on a local system.
; Parameter(s)	: $sDevicePath	- A string contains the device path.
;		: $hDevs	- A variable receives the handle to the device information set.
;		: $tSP_DEVINFO_DATA - A variable receives the SP_DEVICEINFO_DATA structure.
; Return values	: Returns True if succeeds, else returns False.
; Author	: Pusofalse
; Remarks	: This function can only execute on the local system, to retrieve the device information from a remote system, call _SetupDiGetDeviceInterfaceDevsEx function.
; ====================================================================================
Func _SetupDiGetDeviceInterfaceDevs($sDevicePath, ByRef $hDevs, ByRef $tSP_DEVINFO_DATA)
	Return _SetupDiGetDeviceInterfaceDevsEx($sDevicePath, $hDevs, $tSP_DEVINFO_DATA)
EndFunc	;==>_SetupDiGetDeviceInterfaceDevs

; #### FUNCTION ####
; ====================================================================================
; Name	: _SetupDiGetDeviceInterfaceDevsEx
; Description	: Specifies the device path, returns the device information set associated with this device on a local or remote system.
; Parameter(s)	: $sDevicePath	- A string contains the device path.
;		: $hDevs	- A variable receives the handle to the device information set.
;		: $tSP_DEVINFO_DATA - A variable receives the SP_DEVICEINFO_DATA structure.
;		: $sMachine - Specify the system on which the function executes, in UNC format, default to local system.
; Return values	: True indicates success, false to failure.
; Author	: Pusofalse
; ====================================================================================
Func _SetupDiGetDeviceInterfaceDevsEx($sDevicePath, ByRef $hDevs, ByRef $tSP_DEVINFO_DATA,$sMachine="")
	Local $tDevIfInfo

	$hDevs = _SetupDiGetClassDevsEx($DIGCF_ALLCLASSES, "", "", $sMachine)
	If $hDevs < 1 Then Return SetError(@error, 0, 0)

	Select
	Case _SetupDiOpenDeviceInterface($hDevs, $sDevicePath, $tDevIfInfo) = 0
		Return SetError(@error, 0 * _SetupDiDestroyDeviceInfoList($hDevs), 0)
	Case _SetupDiGetDeviceInterfaceDetail($hDevs, $tDevIfInfo,$tSP_DEVINFO_DATA)<>$sDevicePath
		Return SetError(@error, 0 * _SetupDiDestroyDeviceInfoList($hDevs), 0)
	Case _SetupDiSetSelectedDevice($hDevs, $tSP_DEVINFO_DATA) = 0
		Return SetError(@error, 0 * _SetupDiDestroyDeviceInfoList($hDevs), 0)
	Case Else
		Return SetError(0, _CM_Free_Variable($tDevIfInfo), 1)
	EndSelect
EndFunc	;==>_SetupDiGetDeviceInterfaceDevsEx

; #### FUNCTION ####
; ====================================================================================
; Name	: _SetupDiOpenDeviceInterfaceRegKey
; Description	: This function returns the handle to the registry key that is specific to a device interface.
; Parameter(s)	: $hDevs	- A handle to the device information set.
;		: $pSP_DEVIFINFO_DATA - A pointer to a SP_DEVIFINFO_DATA structure that contains the device interface data.
;		: $iAccess	- Access mask to open the registry key.
; Return values	: If succeeds, returns the handle to the device interface registry key, otherwise, returns a value less than a value of one, and sets @error to a system error code.
; Author	: Pusofalse
; ====================================================================================
Func _SetupDiOpenDeviceInterfaceRegKey($hDevs, $pSP_DEVIFINFO_DATA, $iAccess)
	Local $iResult
	If IsDllStruct($pSP_DEVIFINFO_DATA) Then
		$pSP_DEVIFINFO_DATA = DllStructGetPtr($pSP_DEVIFINFO_DATA)
	EndIf
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "SetupDiOpenDeviceInterfaceRegKey", _
			"ptr", $hDevs, "ptr", $pSP_DEVIFINFO_DATA, "dword", 0, "dword", $iAccess)
	Return SetError(_CM_Get_Last_Error(), 0, $iResult[0])
EndFunc	;==>_SetupDiOpenDeviceInterfaceRegKey

; #### FUNCTION ####
; ====================================================================================
; Name	: _SetupDiDeleteDeviceInterfaceData
; Description	: Deletes a device interface from a device information set.
; Parameter(s)	: $hDevs	- A handle to device information set.
;		: $pSP_DEVIFINFO_DATA	- A pointer to a SP_DEV_INTERFACE_DATA structure, typically returned by _SetupDiEnumDeviceInterfaces function or _SetupDiOpenDeviceInterface.
; Return values	: True indicates success, False indicates failure, in this case, @error is set to a system error code.
; Author	: Pusofalse
; ====================================================================================
Func _SetupDiDeleteDeviceInterfaceData($hDevs, $pSP_DEVIFINFO_DATA)
	Local $iResult
	If IsDllStruct($pSP_DEVIFINFO_DATA) Then
		$pSP_DEVIFINFO_DATA = DllStructGetPtr($pSP_DEVIFINFO_DATA)
	EndIf
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupDiDeleteDeviceInterfaceData", _
			"ptr", $hDevs, "ptr", $pSP_DEVIFINFO_DATA)
	Return SetError(_CM_Get_Last_Error(), 0, $iResult[0])
EndFunc	;==>_SetupDiDeleteDeviceInterfaceData

Func _CM_Set_DevNode_Problem_Ex($hDevInst, $iProblem, $hMachine, $iFlags = $CM_SET_DEVNODE_PROBLEM_NORMAL)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Set_DevNode_Problem_Ex", "dword", $hDevInst, _
			"ulong", $iProblem, "ulong", $iFlags, "ptr", $hMachine)
	Return SetError($iResult[0], 0, $iResult[0] = $CR_SUCCESS)
EndFunc	;==>_CM_Set_DevNode_Problem_Ex

; #### FUNCTION ####
; =====================================================================================
; Name	: _CM_Get_Drive_Disk_Number
; Description	: Retrieves the physical disk number for the specified logical partition.
; Parameter(s)	: $sDrive	- Logical partition (for example, C: or C:\), the name string must not begin with "\\.\" or "\\?\".
; Return values	: Physical disk index, zero based, or -1 if failure. @extended is set to the disk type.
; Author	: Pusofalse
; =====================================================================================
Func _CM_Get_Drive_Disk_Number($sDrive)
	Local $iNum, $iType, $tBuffer, $hDrive, $iAccessMask

	While StringRight($sDrive, 1) = "\"
		$sDrive = StringTrimRight($sDrive, 1)
	WEnd

	$iAccessMask = bitOR($GENERIC_READ, $GENERIC_WRITE)
	$hDrive = _CM_Create_File("\\.\" & $sDrive, $iAccessMask, 3, 0, 3, 0)
	If $hDrive < 1 Then Return SetError(@error, 0, -1)

	$tBuffer = DllStructCreate("int Type;ulong Number;ulong PartNumber")
	If _CM_Device_IO_Control($hDrive, 0x2D1080, 0, 0, $tBuffer, 12) = 0 Then
		Return SetError(@error, _CM_Close_Handle($hDrive) * 0 - 1, -1)
	Else
		_CM_Close_Handle($hDrive)
		$iType = DllStructGetData($tBuffer, "Type")
		$iNum = DllStructGetData($tBuffer, "Number")
		Return SetError(_CM_Free_Variable($tBuffer), $iType, $iNum)
	EndIf
EndFunc	;==>_CM_Get_Drive_Disk_Number

; #### FUNCTION ####
; =====================================================================================
; Name	: _CM_Get_Drive_Type
; Description	: Retrieves the type for a drive.
; Parameter(s)	: $sDrive	- Logical partition (for example, C: or C:\), the name string must not begin with "\\.\" or "\\?\".
; Return values	: One of the following strings:
;		:	- UNKNOWN
;		:	- NO_ROOT_DIR
;		:	- REMOVABLE
;		:	- FIXED
;		:	- REMOTE
;		:	- CDROM
;		:	- RAMDISK
;		:	- REMOVABLE_DISK
; Author	: Pusofalse
; =====================================================================================
Func _CM_Get_Drive_Type($sDrive)
	Local $iResult, $hDevs, $tDevInfo, $tDevIfInfo, $iFlags, $iDiskNumber, $sDevicePath, $aClass
	Local $aType[7] = ["UNKNOWN", "NO_ROOT_DIR", "REMOVABLE", "FIXED", "REMOTE", "CDROM", "RAMDISK"]

	$iResult = DllCall($Kernel32_DllHandleA, "uint", "GetDriveType", "str", $sDrive)
	If $iResult[0] <> 3 Then Return $aType[$iResult[0]]

	$iDiskNumber = _CM_Get_Drive_Disk_Number($sDrive)
	If $iDiskNumber = -1 Then Return SetError(@error, 0, "UNKNOWN")

	$aClass = _CM_Get_Device_Interface_List_Ex(0, $GUID_DEVINTERFACE_DISK)
	If $aClass[0] = 0 Then Return SetError(@error, 0, "UNKNOWN")

	For $i = 1 To $aClass[0]
		$sDevicePath = StringTrimLeft($aClass[$i], 4)
		If _CM_Get_Drive_Disk_Number($sDevicePath) <> $iDiskNumber Then ContinueLoop
		$hDevs = _SetupDiCreateDeviceInfoList()
		Select
		Case _SetupDiOpenDeviceInterface($hDevs, $aClass[$i], $tDevIfInfo) = 0
			Return SetError(@error, _SetupDiDestroyDeviceInfoList($hDevs), "UNKNOWN")
		Case _SetupDiGetDeviceInterfaceDetail($hDevs, $tDevIfInfo, $tDevInfo) <> $aClass[$i]
			Return SetError(@error, _SetupDiDestroyDeviceInfoList($hDevs), "UNKNOWN")
		Case Else
			$iFlags = _SetupDiGetDeviceRegistryProperty($hDevs, $tDevInfo, 0x20);, 0)
			_SetupDiDestroyDeviceInfoList($hDevs)
			If bitAND($iFlags, 2) = 2 Then
				Return SetError(_CM_Free_Variable($tDevInfo), 0, "REMOVABLE_DISK")
			Else
				Return SetError(_CM_Free_Variable($tDevInfo), 0, "FIXED")
			EndIf
		EndSelect
	Next
	Return "UNKNOWN"
EndFunc	;==>_CM_Get_Drive_Type

; #### FUNCTION ####
; =====================================================================================
; Name	: _CM_Safely_Eject_Disk
; Description	: This function safely ejects an U-styled (or a CD-ROM) disk.
; Parameter(s)	: $sDrive	- Logical partition (for example, C: or C:\), the name string must not begin with "\\.\" or "\\?\".
;		: $fSafely	- If TRUE, the function ejects the disk with removing its subtree first. If FALSE, the function attempts to forcibly remove the disk. Default to TRUE.
; Return values	: True indicates success, False indicates failure, in which case, @error is set to a system error code (or a configuration manager error code).
; Author	: Pusofalse
; Remarks	: This function does not support to eject a floppy disk (only CD-ROM and U-styled disk are supported).
; =====================================================================================
Func _CM_Safely_Eject_Disk($sDrive, $fSafely = True)
	Local $hDevs, $tDevInfo, $hDisk, $aInterface, $hDevInst, $iDiskNum
	Local $iAccessMask, $sDevicePath, $fResult, $sDeviceType, $iStatus, $sVeto

	While StringRight($sDrive, 1) = "\"
		$sDrive = StringTrimRight($sDrive, 1)
	WEnd

	$iDiskNum = _CM_Get_Drive_Disk_Number($sDrive)
	$iAccessMask = bitOR($GENERIC_READ, $GENERIC_WRITE)
	$sDeviceType = _CM_Get_Drive_Type($sDrive)
	If $sDeviceType = "CDROM" Then
		$hDisk = _CM_Create_File("\\.\Cdrom" & $iDiskNum, $iAccessMask, 3, 0, 3, 0)
		If $hDisk < 1 Then Return SetError(@error, 0, 0)
		$fResult = _CM_Device_IO_Control($hDisk, 0x2D4808, 0, 0, 0, 0)
		Return SetError(@error, _CM_Close_Handle($hDisk), $fResult)
	ElseIf $sDeviceType <> "REMOVABLE" AND $sDeviceType <> "REMOVABLE_DISK" Then
		Return SetError(50, 0, 0)
	EndIf
	$aInterface = _CM_Get_Device_Interface_List($GUID_DEVINTERFACE_DISK)
	For $i = 1 To $aInterface[0]
		$sDevicePath = StringTrimLeft($aInterface[$i], 4)
		If _CM_Get_Drive_Disk_Number($sDevicePath) = $iDiskNum Then
			ExitLoop _CM_Assign_Var($sDevicePath, $aInterface[$i]) * 0 + 1
		EndIf
	Next
	If StringLeft($sDevicePath, 4) <> "\\?\" Then Return SetError(2, 0, 0)
	If _SetupDiGetDeviceInterfaceDevsEx($sDevicePath, $hDevs, $tDevInfo) = 0 Then
		Return SetError(@error, 0, 0)
	EndIf
	$hDevInst = DllStructGetData($tDevInfo, "DevInst")
	$iStatus = _CM_Get_DevNode_Status($hDevInst)
	If bitAND($iStatus, $DN_REMOVABLE) <> $DN_REMOVABLE Then
		_SetupDiDestroyDeviceInfoList($hDevs)
		$hDevInst =_CM_Get_Parent($hDevInst)
		$iStatus = _CM_Get_DevNode_Status($hDevInst)
		If bitAND($iStatus, $DN_REMOVABLE) <> $DN_REMOVABLE Then
			Return SetError(50, 0, 0)
		EndIf
		If _CM_Create_Device_Devs($hDevInst, $hDevs, $tDevInfo) = 0 Then
			Return SetError(@error, 0, 0)
		EndIf
	EndIf

	If $fSafely = True Then
		_SetupDiApiBufferFree($tDevInfo)
		_SetupDiDestroyDeviceInfoList($hDevs)
		Select
		Case _CM_Query_And_Remove_SubTree($hDevInst, 0, $sVeto) = 0
			Return SetError(@error, 0, 0)
		Case _CM_Request_Device_Eject($hDevInst, $sVeto) = 0
			Return SetError(@error, 0, 0)
		Case FileExists($sDrive) = 1
			Return SetError(997, 0, 0)
		Case Else
			Return SetError(0, 0, 1)
		EndSelect
	ElseIf _SetupDiRemoveDevice($hDevs, $tDevInfo) = 0 Then
		_CM_Assign_Var($tDevInfo, 0, @error, @extended)
		Return SetError(@error, _SetupDiDestroyDeviceInfoList($hDevs), 0)
	ElseIf FileExists($sDrive) = 1 Then
		_CM_Free_Variable($tDevInfo)
		Return SetError(997, _SetupDiDestroyDeviceInfoList($hDevs), 0)
	Else
		_CM_Free_Variable($tDevInfo)
		Return SetError(0, _SetupDiDestroyDeviceInfoList($hDevs), 1)
	EndIf
EndFunc	;==>_CM_Safely_Eject_Disk
; #### FUNCTION ####
; ================================================================================
; Name	: _CM_Safely_Eject_Device_Ex
; Description	: This function safely ejects a device instance, on local or remote machine.
; Parameter(s)	: $sDeviceID	- Device instance ID string.
;		: $hMachine	- A machine handle, zero indicates on local.
; Return values	: TRUE is returned if succeeds, FALSE otherwise. @error is set to a CR_* error code for the failure. If $sDeviceID device instance does not support a safe ejection, @error is set to $CR_INVALID_DEVINST. If the device is pending, @error is set to a system error code 997.
; Author	: Pusofalse
; ================================================================================
Func _CM_Safely_Eject_Device_Ex($sDeviceID, $hMachine = 0)
	Local $iStatus, $hDevInst, $sVeto

	$hDevInst = _CM_Locate_DevNode_Ex($sDeviceID, $hMachine)
	If $hDevInst < 1 OR @error Then Return SetError(@error, 0, 0)

	$iStatus = _CM_Get_DevNode_Status_Ex($hDevInst, $hMachine)
	If bitAND($iStatus, $DN_REMOVABLE) <> $DN_REMOVABLE Then
		Return SetError($CR_INVALID_DEVINST, 0, 0)
	EndIf
	_CM_Query_And_Remove_SubTree_Ex($hDevInst, $hMachine, $sVeto)
	_CM_Request_Device_Eject_Ex($hDevInst, $hMachine, $sVeto)
	_CM_Get_DevNode_Status_Ex($hDevInst, $hMachine)
	If @Extended <> 47 Then Return SetError(997, 0, 0)
	Return SetError(0, 0, 1)
EndFunc	;==>_CM_Safely_Eject_Device_Ex

; #### FUNCTION ####
; =================================================================================
; Name	: _CM_Enumerate_Physical_Disks
; Description	: This function lists the physical disks present on the local system.
; Parameter(s)	: This function has no parameters.
; Return values	: An array in the form:
;		:	- $aArray[0][0] - The number of returned disks.
;		:	- $aArray[1][0] - 1st disk's path.
;		:	- $aArray[1][1] - 1st disk's description, or friendly name.
;		:	- $aArray[1][2] - 1st physical disk's device instance ID.
;		:	- $aArray[1][3] - Logical drives in 1st physical disk.
;		:	- $aArray[1][4] - U-styled whether.
;		:	- $aArray[2][0] - 2nd disk's path.
; Author	: Pusofalse
; =================================================================================
Func _CM_Enumerate_Physical_Disks()
	Local $iFlags, $aDrive, $hDevs, $tDevInfo, $sDescr, $sName, $aDisk, $aCdrom
	Local $sDevicePath, $sDiskType, $iDiskNum, $sVolume, $sDeviceID, $aResult[1][5]


	$aDrive = DriveGetDrive("ALL")
	For $i = 1 To $aDrive[0]
		$iDiskNum = _CM_Get_Drive_Disk_Number($aDrive[$i])
		If $iDiskNum < 0 Then ContinueLoop
		$sDeviceType = "\\.\PhysicalDrive" & $iDiskNum
		If @Extended = 2 Then $sDeviceType = "\\.\Cdrom" & $iDiskNum
		Assign($sDeviceType, Eval($sDeviceType) & $aDrive[$i] & ", ")
	Next

	$aDisk = _CM_Get_Device_Interface_List($GUID_DEVINTERFACE_DISK)
	$aCdrom = _CM_Get_Device_Interface_List($GUID_DEVINTERFACE_CDROM)
	Redim $aDisk[$aDisk[0] + $aCdrom[0] + 1]
	For $i = 1 To $aCdrom[0]
		$aDisk[$aDisk[0] + $i] = $aCdrom[$i]
	Next
	$aDisk[0] = Ubound($aDisk) - 1
	$aResult[0][0] = $aDisk[0]
	Redim $aResult[$aDisk[0] + 1][5]

	For $i = 1 To $aResult[0][0]
		$sDevicePath = StringTrimLeft($aDisk[$i], 4)
		$iDiskNum = _CM_Get_Drive_Disk_Number($sDevicePath)
		If $iDiskNum < 0 Then ContinueLoop
		$sDeviceType = "\\.\PhysicalDrive" & $iDiskNum
		If @Extended = 2 Then $sDeviceType = "\\.\Cdrom" & $iDiskNum
		If _SetupDiGetDeviceInterfaceDevs($aDisk[$i], $hDevs, $tDevInfo) = 0 Then
			ContinueLoop
		EndIf
		$sDeviceID = _SetupDiGetDeviceInstanceID($hDevs, $tDevInfo)
		$sDescr = _SetupDiGetDeviceRegistryProperty($hDevs, $tDevInfo, 1)
		$sName = _SetupDiGetDeviceRegistryProperty($hDevs, $tDevInfo, 0xC)
		$iFlags = _SetupDiGetDeviceRegistryProperty($hDevs, $tDevInfo, 0x20);, 0)
		_SetupDiDestroyDeviceInfoList($hDevs)
		If $sName <> "" Then $sDescr = $sName
		If $sDescr = "" Then $sDescr = "(Unknown)"
		$aResult[$i][0] = $sDeviceType	; disk type
		$aResult[$i][1] = $sDescr	; description
		$aResult[$i][2] = $sDeviceID	; device instance indenfier string
		$aResult[$i][3] = StringTrimRight(Eval($sDeviceType), 2)	; logical drives
		$aResult[$i][4] = bitAND($iFlags, 2) = 2	; U-styled
	Next
	Return SetExtended(_SetupDiApiBufferFree($tDevInfo), $aResult)
EndFunc	;==>_CM_Enumerate_Physical_Disks

; #### FUNCTION ####
; ============================================================================
; Name	: _CM_Enable_Privileges
; Description	: Enable required privileges for calling process, for sub-sequent calls.
; Parameter(s)	: This function has no parameters.
; Return values	: Returns TRUE if succeeds, FALSE otherwise. @error is set to system error code for failure and success.
; Author	: Pusofalse
; ============================================================================
Func _CM_Enable_Privileges()
	Local $hToken, $fResult, $aPriv[7][2] = [[$SE_DEBUG_NAME, 2], _
			[$SE_RESTORE_NAME, 2], _
			[$SE_BACKUP_NAME, 2], _
			[$SE_LOAD_DRIVER_NAME, 2], _
			[$SE_UNDOCK_NAME, 2], _
			[$SE_SECURITY_NAME, 2], _
			[$SE_TAKE_OWNERSHIP_NAME, 2]]
	$hToken = _OpenProcessToken(-1)
	$fResult = _AdjustTokenPrivileges($hToken, $aPriv)
	Return SetError(@error, _LsaCloseHandle($hToken), $fResult)
EndFunc	;==>_CM_Enable_Privileges

Func _CM_Lock_Cdrom($sDrive, $fLock = True)
	Local $fResult, $hCdrom, $iMask, $tLock

	$iDiskNum = _CM_Get_Drive_Disk_Number($sDrive)
	If @extended <> 2 OR $iDiskNum < 0 Then Return SetError(87, 0, 0)

	$iMask = bitOR($GENERIC_READ, $GENERIC_WRITE)
	$hCdrom = _CM_Create_File("\\.\Cdrom" & $iDiskNum, $iMask, 3, 0, 3, 0)
	If $hCdrom < 1 Then Return SetError(@error, 0, 0)

	$tLock = DllStructCreate("int fLock")
	DllStructSetData($tLock, "fLock", Number(Not (Not $fLock)))	 

	$fResult = _CM_Device_IO_Control($hCdrom, 0x2D4804, $tLock, 4, 0, 0)
	Return SetError(@error, _CM_Close_Handle($hCdrom), $fResult)
EndFunc	;==>_CM_Lock_Cdrom

; #### FUNCTION ####
; =====================================================================================
; Name	: _CM_Cdrom_Known_Good_Digital_Playback
; Description	: Determines whether the specified CD-ROM or DVD drive has digital playback that is known to be good.
; Parameter(s)	: $hDevs	- Handle to the device information set.
;		: $pSP_DEVINFO_DATA - A pointer to an SP_DEVINFO_DATA structure defines the device information element.
; Return values	: If digital playback is good, the return value is TRUE. Otherwise, the return value is FALSE.
; Author	: Pusofalse
; =====================================================================================
Func _CM_Cdrom_Known_Good_Digital_Playback($hDevs, $pSP_DEVINFO_DATA)
	Local $iResult

	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	$iResult = DllCall($STORP_DllHandle, "int", "CdromKnownGoodDigitalPlayback", _
			"ptr", $hDevs, "ptr", $pSP_DEVINFO_DATA)
	Return $iResult[0]
EndFunc	;==>_CM_Cdrom_Known_Good_Digital_Playback

Func _CM_Enable_Cdrom_Digital_Playback($hDevs, $pSP_DEVINFO_DATA, $fForce = True)
	Local $iResult

	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	$iResult = DllCall($STORP_DllHandle, "long", "CdromEnableDigitalPlayback", _
			"ptr", $hDevs, "ptr", $pSP_DEVINFO_DATA, "int", $fForce)
	Return SetError($iResult[0], 0, $iResult[0] = $ERROR_SUCCESS)
EndFunc	;==>_CM_Enable_Cdrom_Digital_Playback

Func _CM_Disable_Cdrom_Digital_Playback($hDevs, $pSP_DEVINFO_DATA)
	Local $iResult

	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	$iResult = DllCall($STORP_DllHandle, "long", "CdromDisableDigitalPlayback", _
			"ptr", $hDevs, "ptr", $pSP_DEVINFO_DATA)
	Return SetError($iResult[0], 0, $iResult[0] = $ERROR_SUCCESS)
EndFunc	;==>_CM_Disbable_Cdrom_Digital_Playback

Func _CM_Is_Cdrom_Digital_Playback_Enabled($hDevs, $pSP_DEVINFO_DATA)
	Local $iResult

	If IsDllStruct($pSP_DEVINFO_DATA) Then
		$pSP_DEVINFO_DATA = DllStructGetPtr($pSP_DEVINFO_DATA)
	EndIf
	$iResult = DllCall($STORP_DllHandle, "long", "CdromIsDigitalPlaybackEnabled", _
			"ptr", $hDevs, "ptr", $pSP_DEVINFO_DATA, "int*", 0)
	Return SetError($iResult[0], 0, $iResult[3])
EndFunc	;==>_CM_Is_Cdrom_Digital_Playback_Enabled

Func _CM_Free_Resource_Conflict_Handle($hConflict)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Free_Resource_Conflict_Handle", "ptr", $hConflict)
	Return SetError($iResult[0], 0, $iResult[0] = $CR_SUCCESS)
EndFunc	;==>_CM_Free_Resource_Conflict_Handle

Func _CM_Get_Resource_Conflict_Count($hConflict)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Resource_Conflict_Count", _
			"ptr", $hConflict, "ulong*", 0)
	Return SetError($iResult[0], 0, $iResult[2])
EndFunc	;==>_CM_Get_Resource_Conflict_Count

Func _CM_Get_Resource_Conflict_Details($hConflict, $iIndex = 0)
	Local $iResult, $tDetail
	$tDetail = DllStructCreate($tagCONFLICT_DETAILS)
	DllStructSetData($tDetail, "Mask", 13)
	DllStructSetData($tDetail, "Size", DllStructGetSize($tDetail))
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Resource_Conflict_Details", _
			"ptr", $hConflict, "ulong", $iIndex, "ptr", DllStructGetPtr($tDetail))
	Return SetError($iResult[0], 0, $tDetail)
EndFunc	;==>_CM_Get_Resource_Conflict_Details

Func _CM_Query_Resource_Conflict_List($hDevInst, $iResourceID, $pData, $iSizeData, $hMachine = 0)
	Local $iResult

	If IsDllStruct($pData) Then $pData = DllStructGetPtr($pData)
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Query_Resource_Conflict_List", "ptr*", 0, _
			"dword", $hDevInst, "int", $iResourceID, "ptr", $pData, _
			"ulong", $iSizeData, "ulong", 0, "ptr", $hMachine)
	Return SetError($iResult[0], 0, $iResult[1])
EndFunc	;==>_CM_Query_Resource_Conflict_List

Func _CM_Validate_Res_Des_Conflict_Ex($hDevInst, $iResourceID, $pBuffer, $iSizeofBuffer, $hMachine = 0)
	Local $hConflict, $aConflict[1], $iCount, $tDetail, $sDescr, $sName, $iFlags, $hDevInst1

	$hConflict = _CM_Query_Resource_Conflict_List($hDevInst, $iResourceID, $pBuffer, $iSizeofBuffer, $hMachine)
	$iCount = _CM_Get_Resource_Conflict_Count($hConflict)
	$aConflict[0] = $iCount
	Redim $aConflict[$iCount + 1]
	For $i = 1 To $iCount
		$tDetail = _CM_Get_Resource_Conflict_Details($hConflict, $i - 1)
		$iFlags = DllStructGetData($tDetail, "Flags")
		$hDevInst1 = DllStructGetData($tDetail, "DevInst")

		If $iFlags = 0 Then
			$sDescr = _CM_Get_DevNode_Registry_Property($hDevInst1, 1)
			$sName = _CM_Get_DevNode_Registry_Property($hDevInst1, 0xD)
			If $sName <> "" Then $sDescr = $sName
			If $sDescr = "" Then $sDescr = "[Unknown device]"
			$aConflict[$i] = $sDescr & " , " & _CM_Get_Device_ID_Ex($hDevInst1, $hMachine)
			If $aConflict[$i] = "[Unknown device] , " Then
				$aConflict[$i] = DllStructGetData($tDetail, "Descr")
				If $aConflict[$i] = "" Then $aConflict[$i] = "The resource is unavailable"
			EndIf
		ElseIf bitAND($iFlags, $CM_CDFLAGS_DRIVER) = $CM_CDFLAGS_DRIVER Then
			$aConflict[$i] = DllStructGetData($tDetail, "Descr")
		ElseIf bitAND($iFlags, $CM_CDFLAGS_RESERVED) = $CM_CDFLAGS_RESERVED Then
			$aConflict[$i] = "Unknown"
		ElseIf bitAND($iFlags, $CM_CDFLAGS_ROOT_OWNED) = 2 Then
			$aConflict[$i] = "Owned by the root device"
		Else
			$aConflict[$i] = "The resource is unavailable"
		EndIf
		If $aConflict[$i] = "" Then $aConflict[$i] = "Unknown"
		_CM_Free_Variable($tDetail)
	Next
	_CM_Free_Resource_Conflict_Handle($hConflict)
	Return $aConflict
EndFunc	;==>_CM_Validate_Res_Des_Conflict_Ex

; #### FUNCTION ####
; =====================================================================================
; Name	: _CM_Add_Res_Des_IRQ_Array_Ex
; Description	: This function newly adds one or more IRQ resource descriptors to a device instance.
; Parameter(s)	: $hDevInst	- Handle to the device instance.
;		: $hLogConf	- Handle to the logical configuration.
;		: $aIRQDes	- An array in the form:
;		:	$aIRQDes[0][0] - 1st interrupt request line (IRQ) number.
;		:	$aIRQDes[0][1] - Flags for 1st IRQ, see Flags for IRQ_DES.Flags for correct values.
;		:	$aIRQDes[0][2] - A bitmask representing the processor affinity of the IRQ line that is allocated to the device. Bit zero represents the first processor, bit two the second, and so on. Set this value to -1 to represent all processors. 
;		:	$aIRQDes[0][3] - On input, this value specifies a BOOL value indicates that whether the function creates the resource descriptor forcibly by ignoring the conflict list, TRUE indicates to ignore. On output, this value receives the conflict list string text, splitted by @CRLF, if no conflicts against with the other device instance, this value is set to NULL.
;		:	$aIRQDes[0][4] - A value receives the handle to the newly created resource descriptor, when you finished with this handle, call _CM_Free_Res_Des_Handle (Not _CM_Free_Res_Des) function to free it.
;		:	$aIRQDes[1][0] - 2nd interrupt request line (IRQ) number.
;		:	- ... ...
;		: $hMachine	- Supplies a handle to the machine on where the function to execute, typically returned by _CM_Connect_Machine. A value of ZERO indicates on local system.
; Return values	: If $aIRQDes parameter is incorrect, @error is set to CR_INVALID_DATA. Caller can determine the result with $aIRQDes[n][3].
; Author	: Pusofalse
; =====================================================================================
Func _CM_Add_Res_Des_IRQ_Array_Ex($hDevInst, $hLogConf, ByRef $aIRQDes, $hMachine = 0)
	Local $iFlags, $pBuffer, $tBuffer, $aConflict

	If Ubound($aIRQDes, 0) <> 2 Then Return SetError($CR_INVALID_DATA, 0, 0)
	If Ubound($aIRQDes, 2) <> 5 Then Return SetError($CR_INVALID_DATA, 0, 0)

	$pBuffer = _CM_Heap_Alloc(36)
	$tBuffer = DllStructCreate($tagIRQ_DES, $pBuffer)
	DllStructSetData($tBuffer, "Count", 0)
	DllStructSetData($tBuffer, "Type", 12)

	For $i = 0 To Ubound($aIRQDes) - 1
		$iFlags = $aIRQDes[$i][3]
		$aIRQDes[$i][3] = ""
		If $aIRQDes[$i][1] = -1 Then $aIRQDes[$i][1] = 1
		DllStructSetData($tBuffer, "AllocNum", $aIRQDes[$i][0])
		DllStructSetData($tBuffer, "Flags", $aIRQDes[$i][1])
		DllStructSetData($tBuffer, "Affinity", $aIRQDes[$i][2])

		$aConflict = _CM_Validate_Res_Des_Conflict_Ex($hDevInst, $RESTYPE_IRQ, $pBuffer, 36, $hMachine)
		If $aConflict[0] Then
			$aIRQDes[$i][4] = 0
			For $j = 1 To $aConflict[0]
				$aIRQDes[$i][3] &= $aConflict[$j] & @CRLF
			Next
			If $iFlags = False Then ContinueLoop
		EndIf
		$aIRQDes[$i][4] = _CM_Add_Res_Des_Ex($hLogConf, $RESTYPE_IRQ, $pBuffer, 36, $hMachine)
	Next
	_CM_Heap_Free($pBuffer)
	Return _CM_Free_Variable($tBuffer)
EndFunc	;==>_CM_Add_Res_Des_IRQ_Array_Ex

; #### FUNCTION ####
; =====================================================================================
; Name	: _CM_Add_Res_Des_IO_Array_Ex
; Description	: This function newly creates one or more I/O resource descriptors for a device instance.
; Parameter(s)	: $hDevInst	- Supplies a handle to the device instance.
;		: $hLogConf	- Supplies a handle to the logical configuration.
;		: $aIORes		- An array in the form:
;		:	- $aIORes[0][0] - Allocation base address for 1st IO resource.
;		:	- $aIORes[0][1] - Allocation end address for 1st IO resource.
;		:	- $aIORes[0][2] - Allocation flags for 1st IO resource, see Flags for IO_DES.Flags for correct values.
;		:	- $aIORes[0][3] - On input, this value specifies a BOOL value indicates that whether ignores the conflict, TRUE indicates forcibly to create the IO resource, ignoring the conflict. On output, this value receives a conflict list string text splitted by @CRLF, if no conflicts, this value is set to NULL.
;		:	- $aIORes[0][4] - OUT-typed, receives the handle to the newly created resource descriptor. When you finished with this handle, call _CM_Free_Res_Des_Handle function to close it. If the resource conflicts to other device instance, and $aIORes[0][3] specifies False, this value is set to zero.
;		:	- $aIORes[1][0] - Allocation base address for 2nd IO resource.
;		:	- ... ...
;		: $hMachine	- A handle to a machine indicates on where the function executes, a value of zero indicates local.
; Author	: Pusofalse
; =====================================================================================
Func _CM_Add_Res_Des_IO_Array_Ex($hDevInst, $hLogConf, ByRef $aIORes, $hMachine = 0)
	Local $iFlags, $pBuffer, $tBuffer, $aConflict

	If Ubound($aIORes, 0) <> 2 Then Return SetError($CR_INVALID_DATA, 0, 0)
	If Ubound($aIORes, 2) <> 5 Then Return SetError($CR_INVALID_DATA, 0, 0)

	$pBuffer = _CM_Heap_Alloc(68)
	$tBuffer = DllStructCreate($tagIO_DES, $pBuffer)
	DllStructSetData($tBuffer, "Count", 0)
	DllStructSetData($tBuffer, "Type", 40)

	For $i = 0 To Ubound($aIORes) - 1
		$iFlags = $aIORes[$i][3]
		$aIORes[$i][3] = ""
		If $aIORes[$i][2] = -1 Then $aIORes[$i][2] = 33
		DllStructSetData($tBuffer, "AllocBase", $aIORes[$i][0])
		DllStructSetData($tBuffer, "AllocEnd", $aIORes[$i][1])
		DllStructSetData($tBuffer, "Flags", $aIORes[$i][2])

		$aConflict = _CM_Validate_Res_Des_Conflict_Ex($hDevInst, $RESTYPE_IO, $pBuffer, 68, $hMachine)
		If $aConflict[0] Then
			$aIORes[$i][4] = 0
			For $j = 1 To $aConflict[0]
				$aIORes[$i][3] &= $aConflict[$j] & @CRLF
			Next
			If $iFlags = False Then ContinueLoop
		EndIf
		$aIORes[$i][4] = _CM_Add_Res_Des_Ex($hLogConf, $RESTYPE_IO, $pBuffer, 68, $hMachine)
	Next
	_CM_Heap_Free($pBuffer)
	Return _CM_Free_Variable($tBuffer)
EndFunc	;==>_CM_Add_Res_Des_IO_Array_Ex

; #### FUNCTION ####
; ================================================================================
; Name	: _CM_Add_Res_Des_Mem_Array_Ex
; Description	: This function newly creates one or more memory resource descriptor for a device instance.
; Parameter(s)	: $hDevInst	- Supplies a device instance handle.
;		: $hLogConf	- Supplies a logical configuration handle.
;		: ByRef $aMemRes	- An array in the following format:
;		:	- $aMemRes[0][0] - Allocation base address for 1st memory resource.
;		:	- $aMemRes[0][1] - Allocation end address for 1st memory resource.
;		:	- $aMemRes[0][2] - Flags for 1st memory resource allocation.
;		:	- $aMemRes[0][3] - On INPUT, specifies a BOOL value indicates that whether forcibly creates the resource descriptor by ignoring the conflicts with other device instances, A value of TRUE indicates ignores the conflict to create forcibly. On OUTPUT, this value receives the conflict list (in string format, splitted by @CRLF), if the value is set to NULL, no conflicts are present.
;		:	- $aMemRes[0][4] - Receives the handle to the newly created resource descriptor. When you no longer use this returned handle, call _CM_Free_Res_Des_Handle (but not _CM_Free_Res_Des_Ex) function to release it. If the resource specified in $aMemRes (elements 0 to 2) is conflicted to other device instance's logical configuration, and $aMemRes[0][3] specifies FALSE, or an error occured during the call, this value is set to zero. 
;		:	- $aMemRes[1][0] - Allocation base address for 2nd memory resource.
;		:	- ... ...
;		: $hMachine	- A handle to a machine on which the function to execute, zero indicates local system.
; Return values	: $aMemRes[x][4] receives the handle to the newly created resource descriptor.
; Author	: Pusofalse
; ================================================================================
Func _CM_Add_Res_Des_Mem_Array_Ex($hDevInst, $hLogConf, ByRef $aMemRes, $hMachine = 0)
	Local $iResult, $aConflict, $iFlags, $tBuffer, $pBuffer

	If Ubound($aMemRes, 0) <> 2 Then Return SetError($CR_INVALID_DATA, 0, 0)
	If Ubound($aMemRes, 2) <> 5 Then Return SetError($CR_INVALID_DATA, 0, 0)

	$pBuffer = _CM_Heap_Alloc(68)
	$tBuffer = DllStructCreate($tagMEM_DES, $pBuffer)
	DllStructSetData($tBuffer, "Count", 0)
	DllStructSetData($tBuffer, "Reserved", 0)
	DllStructSetData($tBuffer, "Type", 36)

	For $i = 0 To Ubound($aMemRes) - 1
		$iFlags = $aMemRes[$i][3]
		$aMemRes[$i][3] = ""
		If $aMemRes[$i][2] = -1 Then $aMemRes[$i][2] = bitOR($FMD_RAM, $FMD_32)
		DllStructSetData($tBuffer, "AllocBase", $aMemRes[$i][0])
		DllStructSetData($tBuffer, "AllocEnd", $aMemRes[$i][1])
		DllStructSetData($tBuffer, "Flags", $aMemRes[$i][2])
		$aConflict = _CM_Validate_Res_Des_Conflict_Ex($hDevInst, $RESTYPE_MEM, $pBuffer, 68, $hMachine)
		If $aConflict[0] Then
			$aMemRes[$i][4] = 0
			For $j = 1 To $aConflict[0]
				$aMemRes[$i][3] &= $aConflict[$j] & @CRLF
			Next
			If $iFlags = False Then ContinueLoop
		EndIf
		$aMemRes[$i][4] = _CM_Add_Res_Des_Ex($hLogConf, $RESTYPE_MEM, $pBuffer, 68, $hMachine)
	Next
	_CM_Heap_Free($pBuffer)
	Return _CM_Free_Variable($tBuffer) + 1
EndFunc	;==>_CM_Add_Res_Des_Mem_Array_Ex

; #### FUNCTION ####
; ================================================================================
; Name	: _CM_Add_Res_Des_DMA_Array_Ex
; ================================================================================
Func _CM_Add_Res_Des_DMA_Array_Ex($hDevInst, $hLogConf, ByRef $aDmaRes, $hMachine = 0)
	Local $iResult, $tBuffer, $iFlags, $pBuffer

	If Ubound($aDmaRes, 0) <> 2 Then Return SetError($CR_INVALID_DATA, 0, 0)
	If Ubound($aDmaRes, 2) <> 5 Then Return SetError($CR_INVALID_DATA, 0, 0)

	$pBuffer = _CM_Heap_Alloc(28)
	$tBuffer = DllStructCreate($tagDMA_DES, $pBuffer)
	DllStructSetData($tBuffer, "Count", 0)
	DllStructSetData($tBuffer, "Type", 12)

	For $i = 0 To Ubound($aDmaRes) - 1
		$iFlags = $aDmaRes[$i][3]
		$aDmaRes[$i][3] = ""
		If $aDmaRes[$i][2] = -1 Then $aDmaRes[$i][2] = $FDD_BYTE_AND_WORD
		DllStructSetData($tBuffer, "Flags", $aDmaRes[$i][2])
		DllStructSetData($tBuffer, "AllocChannel", $aDmaRes[$i][1])

		$aConflict = _CM_Validate_Res_Des_Conflict_Ex($hDevInst, $RESTYPE_DMA, $pBuffer, 28, $hMachine)
		If $aConflict[0] Then
			$aDmaRes[$i][4] = 0
			For $j = 1 To $aConflict[0]
				$aDmaRes[$i][3] &= $aConflict[$j] & @CRLF
			Next
			If $iFlags = False Then ContinueLoop
		EndIf
		$aDmaRes[$i][4] = _CM_Add_Res_Des_Ex($hLogConf, $RESTYPE_DMA, $pBuffer, 28, $hMachine)
	Next
	_CM_Heap_Free($pBuffer)
	Return _CM_Free_Variable($tBuffer)
EndFunc	;==>_CM_Add_Res_Des_DMA_Array_Ex

; #### FUNCTION ####
; ================================================================================
; Name	: _CM_Query_DevNode_Resource_Conflicts_Ex
; Description	: Retrieves the conflict list for a device instance logical configuration.
; Parameter(s)	: $hDevInst	- A handle to the device instance, typically returned by _CM_Locate_DevNode function.
;		: $hMachine	- A handle to the machine, returned by _CM_Connect_Machine, can be a value of zero, which indicates to execute on local system.
; Return values	: If succeeds, returns an array in the following form:
;		: $aArray[0] - The number of conflicts.
;		: $aArray[1] - 1st conflict detail.
;		: $aArray[2] - 2nd conflict detail.
;		: $aArray[n] - nth conflict detail.
;		: ... ...
;		: If no conflicts, $aArray[0] and @error are both set to zero.
;		: If fails, @error is set to a CR_* error code, and $aArray[0] is set to 0.
; Author	: Pusofalse
; ================================================================================
Func _CM_Query_DevNode_Resource_Conflicts_Ex($hDevInst, $hMachine = 0)
	Local $hLogConf, $hResDes, $aResDes, $iResourceID
	Local $aConflict, $pBuffer, $iSizeofBuffer, $aResult[1] = [0]

	$aResDes = _CM_Get_Device_Resources_Ex($hDevInst, $hMachine, $RESTYPE_ALL)
	If $aResDes[0][0] = 0 Then Return SetError(@error, 0, $aResult)
	$hLogConf = _CM_Get_First_Log_Conf_Ex($hDevInst, $hMachine, $ALLOC_LOG_CONF)
	If @error OR $hLogConf < 1 Then
		$hLogConf = _CM_Get_First_Log_Conf_Ex($hDevInst, $hMachine, $BOOT_LOG_CONF)
		If @error OR $hLogConf < 1 Then Return SetError(@error, 0, $aResult)
	EndIf
	For $i = 1 To $aResDes[0][0]
		$hResDes = _CM_Get_Res_Des_By_Index_Ex($hLogConf, $aResDes[$i][2], $hMachine)
		$iResourceID = @Extended
		$pBuffer = _CM_Get_Res_Des_Data_Ex($hResDes, $hMachine)
		$iSizeofBuffer = _CM_Heap_Size($pBuffer)
		_CM_Free_Res_Des_Handle($hResDes)
		$aConflict = _CM_Validate_Res_Des_Conflict_Ex($hDevInst, $iResourceID, $pBuffer, $iSizeofBuffer, $hMachine)
		If $aConflict[0] = 0 Then ContinueLoop
		For $j = 1 To $aConflict[0]
			$aResult[0] += 1
			Redim $aResult[$aResult[0] + 1]
			$aResult[$aResult[0]] = $aConflict[$j]
		Next
	Next
	Return SetError(@error, _CM_Free_Log_Conf_Handle($hLogConf), $aResult)
EndFunc	;==>_CM_Query_DevNode_Resource_Conflicts_Ex

; #### FUNCTION ####
; ================================================================================
; Name	: _CM_Get_Device_ID_By_IRQ_Ex
; Description	: Specifies an IRQ number, retrieves the device instances that deploy the given IRQ.
; Parameter(s)	: $aDeviceIDs	- A variable receives the device instances identifier strings.
;		: $iIRQ	- IRQ Number.
;		: $sDeviceID	- Specifies an existing device instance identifier string from which the function begins to check, can be NULL specified.
;		: $hMachine	- Supplies a machine handle.
; Return values	: The number of device instances that deploy the specified IRQ. $aDeviceIDs is set to an array in the form:
;		: $aDeviceIDs[0] - Number of device instances.
;		: $aDeviceIDs[1] - 1st device instance.
;		: ......
; Author	: Pusofalse
; ================================================================================
Func _CM_Get_Device_ID_By_IRQ_Ex(ByRef $aDeviceIDs, $iIRQ, $sDeviceID = "", $hMachine = 0)
	Local $aDeviceID[1], $hDevInst

	$hDevInst = _CM_Locate_DevNode_Ex($sDeviceID, $hMachine)
	_CM_Get_Device_ID_By_IRQ_Ex_($iIRQ, $aDeviceID, $hDevInst, $hMachine)
	$aDeviceIDs = $aDeviceID
	Return $aDeviceIDs[0]
EndFunc	;==>_CM_Get_Device_ID_By_IRQ_Ex

; #### FUNCTION ####
; ================================================================================
; The _CM_Get_Device_ID_By_IRQ_Ex_ function is only internal used by _CM_Get_Device_ID_By_IRQ_Ex. Do not use it.
; ================================================================================
Func _CM_Get_Device_ID_By_IRQ_Ex_($iIRQ, ByRef $aDeviceID, $hDevInst, $hMachine)
	Local $aChild, $aResDes

	$aChild = _CM_Enumerate_Children_Ex($hDevInst, $hMachine)
	For $i = 1 To $aChild[0]
		$hDevInst = _CM_Locate_DevNode_Ex($aChild[$i], $hMachine)
		$aResDes = _CM_Get_Device_Resources_Ex($hDevInst, $hMachine)
		For $j = 1 To $aResDes[0][0]
			If $aResDes[$j][0] <> "IRQ" Then ContinueLoop
			If Number($aResDes[$j][1]) <> $iIRQ Then ContinueLoop
			$aDeviceID[0] += 1
			Redim $aDeviceID[$aDeviceID[0] + 1]
			$aDeviceID[$aDeviceID[0]] = $aChild[$i]
			ExitLoop
		Next
		_CM_Get_Device_ID_By_IRQ_Ex_($iIRQ, $aDeviceID, $hDevInst, $hMachine)
	Next
EndFunc	;==>_CM_Get_Device_ID_By_IRQ_Ex_

Func _CM_Get_Device_Driver_Files($sDeviceID)
	Local $tDevInfo, $hDevs, $tDrvInfo, $tDrvDetail, $sInf, $sSection, $aDriver[1]
	Local $sClass, $aVal, $iVar, $aSection, $aSect, $hDevInst

	Select
	Case _SetupDiCreateDeviceDevs($sDeviceID, $hDevs, $tDevInfo) = 0
		Return SetError(@error, 0, $aDriver)
	Case _SetupDiBuildDriverInfoList($hDevs, $tDevInfo) = 0
		Return SetError(@error, _SetupDiDestroyDeviceInfoList($hDevs), $aDriver)
	Case _SetupDiSelectBestCompatDrv($hDevs, $tDevInfo) = 0
		Return SetError(@error, _SetupDiDestroyDeviceInfoList($hDevs), $aDriver)
	Case _SetupDiGetSelectedDriver($hDevs, $tDevInfo, $tDrvInfo) = 0
		Return SetError(@error, _SetupDiDestroyDeviceInfoList($hDevs), $aDriver)
	Case _SetupDiGetDriverInfoDetail($hDevs, $tDevInfo, $tDrvInfo, $tDrvDetail) = 0
		Return SetError(@error, _SetupDiDestroyDeviceInfoList($hDevs), $aDriver)
	EndSelect

	$sInf = DllStructGetData($tDrvDetail, "InfFileName")
	$sSection = DllStructGetData($tDrvDetail, "SectionName")

	$sGuid = _SetupDiGetDeviceRegistryProperty($hDevs, $tDevInfo, 8)
	_SetupDiApiBufferFree($tDrvInfo)
	_SetupDiApiBufferFree($tDevInfo)
	_SetupDiApiBufferFree($tDrvDetail)
	_SetupDiDestroyDeviceInfoList($hDevs)
	$sClass = _SetupDiClassNameFromGuid($sGuid)
	If $sClass = "" Then Return SetError(@error, 0, $aDriver)
	If Not FileExists($sInf) Then Return SetError(2, 0, $aDriver)
	$hInf = _SetupOpenInfFile($sInf, $sClass, 2)
	$aSection = IniReadSection($sInf, $sSection)
	If @error Then
		$sSection &= ".NT"
		$aSection = IniReadSection($sInf, $sSection)
		If @error Then
			$sSection &= "x86"
			$aSection = IniReadSection($sInf, $sSection)
			If @error Then Return SetError(2, _SetupCloseInfFile($hInf), $aDriver)
		EndIf
	EndIf

	For $i = 1 To $aSection[0][0]
		If $aSection[$i][0] <> "CopyFiles" Then ContinueLoop
		$pContext = _SetupGetLineByIndex($hInf, $sSection, $i - 1)
		$aSect = _SetupGetLineText($pContext)
		If StringLeft($aSect, 1) = "@" Then
			$sPath = _SetupGetTargetPath($hInf, $pContext)
			$aDriver[0] += 1
			Redim $aDriver[$aDriver[0] + 1]
			$aDriver[$aDriver[0]] = $sPath & "\" & StringTrimLeft($aSect, 1)
			$aSect = ""
		EndIf
		_HeapFree($pContext)
		If $aSect = "" Then ContinueLoop
		$aSect = StringSplit($aSect, ",")
		For $j = 1 To $aSect[0]
			If $aSect[$j] = "" Then ContinueLoop
			For $k = 0 To _SetupGetLineCount($hInf, $aSect[$j]) - 1
				$pContext = _SetupGetLineByIndex($hInf, $aSect[$j], $k)
				$sPath = _SetupGetTargetPath($hInf, $pContext)
				$sName = _SetupGetLineText($pContext)
				If StringInStr($sName, ",") Then
					$iVal = StringInStr($sName,",") - 1
					$sName = StringLeft($sName, $iVal)
				EndIf
				$aDriver[0] += 1
				Redim $aDriver[$aDriver[0] + 1]
				$aDriver[$aDriver[0]] = $sPath & "\" & $sName
				_HeapFree($pContext)
			Next
		Next
	Next
	Return SetExtended(_SetupCloseInfFile($hInf), $aDriver)
EndFunc	;==>_CM_Get_Device_Driver_Files

; #### FUNCTION ####
; ================================================================================
; Name	: _CM_Wait_No_Pending_Install_Events
; Description	: This function waits until there are no pending device installation activities for the PnP manager to perform.
; Parameter(s)	: $iTimeout - Specifies a time-out interval, in milliseconds. If $iTimeout is zero, the function tests whether there are pending installation events and returns immediately. If $iTimeout is -1, the function's time-out interval never elapses. For all other values, the function returns when the specified interval elapses, even if there are still pending installation events.
; Return values	: 0 - There are no pending installation activities.
;		: 20 - The time-out interval elapsed, and installation activities are still pending.
;		: -1 - The function failed, the additional error code is set in @error.
; Author	: Pusofalse
; ================================================================================
Func _CM_Wait_No_Pending_Install_Events($iTimeout = -1)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "dword", "CMP_WaitNoPendingInstallEvents", _
			"dword", $iTimeout)
	Return SetError(_CM_Get_Last_Error(), 0, $iResult[0])
EndFunc	;==>_CM_Wait_No_Pending_Install_Events

Func _SetupCloseInfFile($hInf)
	DllCall($SETUPAPI_DllHandle, "none", "SetupCloseInfFile", "long", $hInf)
EndFunc	;==>_SetupCloseInfFile

Func _SetupGetLineText($pContext)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupGetLineText", "ptr", $pContext, _
			"long", 0, "str", "", "str", "", "str", "", "dword", 260, "dword*", 0)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[5])
EndFunc	;==>_SetupGetLineText

Func _SetupGetLineByIndex($hInf, $sSection, $iIndex)
	Local $hContext, $tContext, $pContext

	$pContext = _CM_Heap_Alloc(4 * 4)

	$hContext = DllCall($SETUPAPI_DllHandle, "int", "SetupGetLineByIndex", "long", $hInf, _
			"str", $sSection, "dword", $iIndex, "ptr", $pContext)
	If $hContext[0] = 1 Then
		Return SetExtended(1, $pContext)
	Else
		Return SetError(_CM_Get_Last_Error(), _CM_Heap_Free($pContext) * 0, 0)
	EndIf
EndFunc	;==>_SetupGetLineByIndex

Func _SetupGetTargetPath($hInf, $pContext)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "int", "SetupGetTargetPath", "long", $hInf, _
			"ptr", $pContext, "str", "", "str", "", "dword", 260, "dword*", 0)
	Return SetError(_CM_Get_Last_Error(), $iResult[0], $iResult[4])
EndFunc	;==>_SetupGetTargetPath

Func _SetupOpenInfFile($sInfFile, $sClass, $iStyle)
	Local $hInf

	$hInf = DllCall($SETUPAPI_DllHandle, "long", "SetupOpenInfFile", "str", $sInfFile, _
			"str", $sClass, "int", $iStyle, "uint*", 0)
	Return SetError(_CM_Get_Last_Error(), $hInf[4], $hInf[0])
EndFunc	;==>_SetupOpenInfFile

Func _SetupGetLineCount($hInf, $sSection)
	Local $iResult
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "SetupGetLineCount", _
			"long", $hInf, "str", $sSection)
	Return SetError(_CM_Get_Last_Error(), 0, $iResult[0])
EndFunc	;==>_SetupGetLineCount

Func _CM_Get_Hardware_Profile_Info($iIndex)
	Local $iResult, $tBuffer
	$tBuffer = DllStructCreate($tagHWPROFILE_INFO)
	$pBuffer = DllStructGetPtr($tBuffer)
	$iResult = DllCall($SETUPAPI_DllHandle, "long", "CM_Get_Hardware_Profile_Info", _
			"ulong", $iIndex, "ptr", $pBuffer, "ulong", 0)
	If $iResult[0] Then $tBuffer = 0
	Return SetError($iResult[0], 0, $tBuffer)
EndFunc	;==>_CM_Get_Hardware_Profile_Info


Func _CM_Format_Resource_Flags(ByRef $hResDes, $iResourceID, $pBuffer)
	Local $tBuffer, $sVar, $sMsg, $iFlags

	If Not IsPtr($pBuffer) Then Return SetError(87, 0, "Undetermined. (Code -1)")
	Switch $iResourceID
	Case $RESTYPE_MEM
		$sVar = $tagMEM_DES
	Case $RESTYPE_IO
		$sVar = $tagIO_DES
	Case $RESTYPE_IRQ
		$sVar = $tagIRQ_DES
	Case $RESTYPE_DMA
		$sVar = $tagDMA_DES
	Case $RESTYPE_BUSNUMBER
		$sVar = $tagBUSNUMBER_DES
	Case Else
		Return SetError(50, 0, "Undetermined. (Code -1)")
	EndSwitch
	$tBuffer = DllStructCreate($sVar, $pBuffer)
	$iFlags = DllStructGetData($tBuffer, "Flags")

	Switch $iResourceID
	Case $RESTYPE_MEM
		If $iFlags = 0 Then Return "Read-only. (Code 0)"
		If bitAND($iFlags, 1) Then $sMsg &= "Writable. (Code 1)"
		If bitAND($iFlags, 2) Then $sMsg &= "32-bit addressing. (Code 2)"
		If bitAND($iFlags, 4) Then $sMsg &= "Prefetchable. (Code 4)"
		If bitAND($iFlags, 8) Then $sMsg &= "Write-only. (Code 8)"
		If bitAND($iFlags, 16) Then $sMsg &= "Combined-write caching. (Code 16)"
		If bitAND($iFlags, 32) Then $sMsg &= "Cacheable. (Code 32)"
	Case $RESTYPE_IO
		If $iFlags = 0 Then Return "Accessed in memory address space. (Code 0)"
		If bitAND($iFlags, 1) Then $sMsg &= "Accessed in I/O address space. (Code 1)"
		If bitAND($iFlags, 4) Then $sMsg &= "Decodes 10-bits. (Code 4)"
		If bitAND($iFlags, 8) Then $sMsg &= "Decodes 12-bits. (Code 8)"
		If bitAND($iFlags, 16) Then $sMsg &= "Decodes 16-bits. (Code 16)"
		If bitAND($iFlags, 32) Then $sMsg &= "Positive decode. (Code 32)"
	Case $RESTYPE_IRQ
		If $iFlags = 0 Then Return "Exclusive. (Code 0)"
		If bitAND($iFlags, 1) Then $sMsg &= "Shared. (Code 1)"
		If bitAND($iFlags, 2) Then $sMsg &= "Edge-Triggered. (Code 2)"
	Case $RESTYPE_DMA
		If $iFlags = 0 Then Return "8-bits standard. (Code 0)"
		Select
		Case bitAND($iFlags, 1)
			$sMsg &= "8-bits. (Code 1)"
		Case bitAND($iFlags, 2)
			$sMsg &= "32-bits. (Code 2)"
		Case bitAND($iFlags, 3)
			$sMsg &= "8-bits / 16-bits. (Code 3)"
		EndSelect
		If bitAND($iFlags, 4) Then $sMsg &= "Bus mastering. (Code 4)"
		Select
		Case bitAND($iFlags, 8)
			$sMsg &= "Type-A. (Code 8)"
		Case bitAND($iFlags, 16)
			$sMsg &= "Type-B. (Code 16)"
		Case bitAND($iFlags, 24)
			$sMsg &= "Type-F. (Code 24)"
		EndSelect
	Case $RESTYPE_BUSNUMBER
		Return "Not used. (Code 0)"
	EndSwitch
	$sMsg = StringReplace($sMsg, ")", ")" & @CRLF)
	If $sMsg <> "" Then Return StringTrimRight($sMsg, 2)
	Return "Undetermined. (Code -1)"
EndFunc	;==>_CM_Format_Resource_Flags

; #### FUNCTION ####
; ====================================================================================
; Name	: _CM_Bind_Device
; Description	: Reenumerates a device tree, and binds device with specified options.
; Parameter(s)	: $iMask	- Bind options, can be a combination of the following values:
;		:	$CM_BIND_DEVINST_BIND_ID (1) - Binds the device instance to its device ID string.
;		:	$CM_BIND_DEVINST_BIND_PHYSNAME (2) - Binds the device instance to its physical object name.
;		:	$CM_BIND_PHYSNAME_BIND_DEVINST (4) - Binds the physical object name to a device instance handle.
;		:	$CM_BIND_DEVINST_BIND_CLASS (8) - Binds a device instance to its device setup class it belongs.
;		:	$CM_BIND_CLASS_BIND_DEVINST (16) - Binds a device class to a string that contains all the device members.
;		:	$CM_BIND_ENUMERATOR_BIND_DEVINST (32) - Binds a device enumerator to a string contains all the device members.
;		: For more information, see Remarks section.
;		: $sDeviceID - Reserved, must be NULL.
; Return values	: This function does not return a value.
; Author	: Pusofalse
; Remarks	: If CM_BIND_DEVINST_BIND_PHYSNAME is specified in $iMask parameter, the function creates a standard AutoIt variable in the following form:
;		:	- $_CM_DEVINST_BIND_PHYSNAME_xxxx, xxxx is the handle the a device instance, for example, 7098.
;		: If CM_BIND_CLASS_BIND_DEVINST is specified, the function creates a variable in the form:
;		:	- $_CM_CLASS_BIND_DEVINST_xxxx, where 'xxxx' is the device class name, for example, $_CM_CLASS_BIND_DEVINST_DiskDrive. Its value is a set of the handles to the device instances which class is 'xxxx', in string format, end with ', '.
;		: But for security, caller must use Eval function instead of the standard way of outputting variable to output a variable's value.
; ===================================================================================
Func _CM_Bind_Device($iMask = $CM_BIND_DEVINST_BIND_ID, $sDeviceID = "")
	Local $aChild, $hDevInst, $vReturn, $sVariable

	If IsString($sDeviceID) = 0 Then
		$hDevInst = $sDeviceID
	Else
		$hDevInst = _CM_Locate_DevNode($hDevInst)
	EndIf

	$aChild = _CM_Enumerate_Children($hDevInst)
	For $i = 1 To $aChild[0]
		$hDevInst = _CM_Locate_DevNode($aChild[$i])
		If bitAND($iMask, $CM_BIND_DEVINST_BIND_ID) Then
			Assign("_CM_DEVINST_BIND_ID_" & $hDevInst, $aChild[$i], 2)
		EndIf
		If bitAND($iMask, $CM_BIND_DEVINST_BIND_PHYSNAME) Then
			$vReturn = _CM_Get_DevNode_Registry_Property($hDevInst, 0xF)
			$vReturn = StringReplace($vReturn, "\", "_")
			Assign("_CM_DEVINST_BIND_PHYSNAME_" & $hDevInst, $vReturn, 2)
		EndIf
		If bitAND($iMask, $CM_BIND_PHYSNAME_BIND_DEVINST) Then
			If $vReturn = "" Then
				$vReturn = _CM_Get_DevNode_Registry_Property($hDevInst, 0xF)
				$vReturn = StringReplace($vReturn, "\", "_")
			EndIf
			Assign("_CM_PHYSNAME_BIND_DEVINST_" & $vReturn, $hDevInst, 2)
		EndIf
		$vReturn = ""
		If bitAND($iMask, $CM_BIND_DEVINST_BIND_CLASS) Then
			$vReturn = _CM_Get_DevNode_Registry_Property($hDevInst, 9)
			$vReturn = _SetupDiClassNameFromGuid($vReturn)
			Assign("_CM_DEVINST_BIND_CLASS_" & $hDevInst, $vReturn, 2)
		EndIf
		If bitAND($iMask, $CM_BIND_CLASS_BIND_DEVINST) Then
			If $vReturn = "" Then
				$vReturn = _CM_Get_DevNode_Registry_Property($hDevInst, 9)
				$vReturn = _SetupDiClassNameFromGuid($vReturn)
			EndIf
			$sVariable = Eval("_CM_CLASS_BIND_DEVINST_" & $vReturn)
		Assign("_CM_CLASS_BIND_DEVINST_" & $vReturn, $sVariable & $hDevInst & ", ", 2)
		EndIf
		If bitAND($iMask, $CM_BIND_ENUMERATOR_BIND_DEVINST) Then
			$vReturn = _CM_Get_DevNode_Registry_Property($hDevInst, 23)
			$sVariable = Eval("_CM_ENUMERATOR_BIND_DEVINST_" & $vReturn)
	Assign("_CM_ENUMERATOR_BIND_DEVINST_" & $vReturn, $sVariable & $hDevInst & ", ", 2)
		EndIf
		_CM_Bind_Device($iMask, $hDevInst)
	Next
EndFunc	;==>_CM_Bind_Device

Func _CM_Get_Device_Power_Capabilities_Ex($hDevInst, $hMachine = 0)
	Local $iFlags, $tBuffer, $tPowerData, $aResult[1], $sText

	$tBuffer = _CM_Get_Device_Power_Ex($hDevInst, $hMachine)
	If $tBuffer = 0 Then Return SetError(@error, 0, $aResult)


	$tPowerData = DllStructCreate($tagCM_POWER_DATA, DllStructGetPtr($tBuffer))
	$iFlags = DllStructGetData($tPowerData, "Capabilities")
	If bitAND($iFlags, $PDCAP_D0_SUPPORTED) Then $sText &= "D0" & @LF
	If bitAND($iFlags, $PDCAP_D1_SUPPORTED) Then $sText &= "D1" & @LF
	If bitAND($iFlags, $PDCAP_D2_SUPPORTED) Then $sText &= "D2" & @LF
	If bitAND($iFlags, $PDCAP_D3_SUPPORTED) Then $sText &= "D3" & @LF
	If bitAND($iFlags, $PDCAP_S0_SUPPORTED) Then $sText &= "S0" & @LF
	If bitAND($iFlags, $PDCAP_S1_SUPPORTED) Then $sText &= "S1" & @LF
	If bitAND($iFlags, $PDCAP_S2_SUPPORTED) Then $sText &= "S2" & @LF
	If bitAND($iFlags, $PDCAP_S3_SUPPORTED) Then $sText &= "S4" & @LF
	If bitAND($iFlags, $PDCAP_S4_SUPPORTED) Then $sText &= "S4" & @LF
	If bitAND($iFlags, $PDCAP_S5_SUPPORTED) Then $sText &= "S5" & @LF

	If bitAND($iFlags, $PDCAP_WAKE_FROM_D0_SUPPORTED) Then $sText &= "WAKE_FROM_D0" & @LF
	If bitAND($iFlags, $PDCAP_WAKE_FROM_D1_SUPPORTED) Then $sText &= "WAKE_FROM_D1" & @LF
	If bitAND($iFlags, $PDCAP_WAKE_FROM_D2_SUPPORTED) Then $sText &= "WAKE_FROM_D2" & @LF
	If bitAND($iFlags, $PDCAP_WAKE_FROM_D3_SUPPORTED) Then $sText &= "WAKE_FROM_D3" & @LF
	If bitAND($iFlags, $PDCAP_WAKE_FROM_S0_SUPPORTED) Then $sText &= "WAKE_FROM_S0" & @LF
	If bitAND($iFlags, $PDCAP_WAKE_FROM_S1_SUPPORTED) Then $sText &= "WAKE_FROM_S1" & @LF
	If bitAND($iFlags, $PDCAP_WAKE_FROM_S2_SUPPORTED) Then $sText &= "WAKE_FROM_S2" & @LF
	If bitAND($iFlags, $PDCAP_WAKE_FROM_S3_SUPPORTED) Then $sText &= "WAKE_FROM_S3" & @LF
	If bitAND($iFlags, $PDCAP_WARM_EJECT_SUPPORTED) Then $sText &= "WARM_EJECT" & @LF

	$sText = StringReplace($sText, @LF, "_SUPPORTED" & @LF & "PDCAP_")
	Return StringSplit(StringTrimRight("PDCAP_" & $sText, 7), @LF)
EndFunc	;==>_CM_Get_Device_Power_Capabilities_Ex

Func _CM_Get_Device_Power_Ex($hDevInst, $hMachine = 0)
	Local $bPowerData, $tBuffer, $iLength, $pBuffer

	$bPowerData = _CM_Get_DevNode_Registry_Property_Ex($hDevInst, 0x1F, $hMachine)
	If @error Then Return SetError(@error, 0, 0)

	$iLength = BinaryLen($bPowerData)
	$tBuffer = DllStructCreate("byte PowerData[" & $iLength & "]")
	DllStructSetData($tBuffer, "PowerData", $bPowerData)
	Return $tBuffer
EndFunc	;==>_CM_Get_Device_Power_Data_Ex

Func _CM_Get_Device_Power_State_Ex($hDevInst, $hMachine = 0)
	Local $tBuffer, $tPowerData, $iVal
	Local $aBuffer[6] = ["Unspecified", "D0", "D1", "D2", "D3", "Maximum"]

	$tBuffer = _CM_Get_Device_Power_Ex($hDevInst, $hMachine)
	If $tBuffer = 0 Then Return SetError(@error, 0, "Unknown")

	$tPowerData = DllStructCreate($tagCM_POWER_DATA, DllStructGetPtr($tBuffer))
	$iVal = DllStructGetData($tPowerData, "MostRecentPowerState")
	_CM_Free_Variable($tPowerData)
	If $iVal < 0 OR $iVal > 5 Then
		Return "Unknown"
	Else
		Return $aBuffer[$iVal]
	EndIf
EndFunc	;==>_CM_Get_Device_Power_State_Ex

Func _CM_Get_Device_Power_Mapping_Ex($hDevInst, $hMachine = 0)
	Local $tBuffer, $aResult[6], $tPowerData, $iVal
	Local $aMapping[6] = ["Unspecified", "D0", "D1", "D2", "D3", "Maximum"]

	$tBuffer = _CM_Get_Device_Power_Ex($hDevInst, $hMachine)
	If $tBuffer = 0 Then Return SetError(@error, 0, $aResult)

	$tPowerData = DllStructCreate($tagCM_POWER_DATA, DllStructGetPtr($tBuffer))
	For $i = 0 To 5
		$iVal = DllStructGetData($tPowerData, "PowerStateMapping", $i + 2)
		If $iVal < 0 OR $iVal > 5 Then
			$aResult[$i] = "S" & $i & " -> Unknown"
		Else
			$aResult[$i] = "S" & $i & " -> " & $aMapping[$iVal]
		EndIf
	Next
	Return SetError(0, _CM_Free_Variable($tPowerData), $aResult)
EndFunc	;==>_CM_Get_Device_Power_Mapping_Ex

Func _CM_Locate_Disk_DevInst($sDrive, $fReturnDisk = 1)
	Local $sClassGuid, $iMask, $hDevs, $tDevInfo, $tDevIfInfo, $iIndex, $sDevicePath, $vDisk

	If ($fReturnDisk) Then
		$vDisk = _CM_Get_Drive_Disk_Number($sDrive)
		If (@Extended = 7) Then
			$sClassGuid = $GUID_DEVINTERFACE_DISK
		ElseIf (@Extended = 2) Then
			$sClassGuid = $GUID_DEVINTERFACE_CDROM
		Else
			Return SetError(1, 0, 0)
		EndIf
	Else
		$sClassGuid = $GUID_DEVINTERFACE_VOLUME
		$vDisk = _CM_Get_Volume_Name($sDrive)
	EndIf
	If ($vDisk == "") Or ($vDisk == -1) Then Return SetError(@error, 0, 0)

	$iMask = bitOr($DIGCF_PRESENT, $DIGCF_DEVICEINTERFACE)
	$hDevs = _SetupDiGetClassDevs($iMask, $sClassGuid)
	If ($hDevs < 1) Then Return SetError(@error, 0, 0)

	While _SetupDiEnumDeviceInterfaces($hDevs, 0, $sClassGuid, $iIndex, $tDevIfInfo)
		$iIndex += 1
		$sDevicePath = _SetupDiGetDeviceInterfaceDetail($hDevs, $tDevIfInfo, $tDevInfo)
		If ($fReturnDisk) Then
			$sDevicePath = StringTrimLeft($sDevicePath, 4)
			If (_CM_Get_Drive_Disk_Number($sDevicePath) = $vDisk) Then
				ExitLoop _CM_Assign_Var($sDevicePath, "\\?\", 1)
			EndIf
		Else
			If (_CM_Get_Volume_Name($sDevicePath) = $vDisk) Then

				ExitLoop _CM_Assign_Var($sDevicePath, "\\?\", 1)
			EndIf
		EndIf
	WEnd
	_CM_Assign_Var($iMask, @error)
	_CM_Assign_Var($vDisk, DllStructGetData($tDevInfo, "DevInst"))

	_SetupDiDestroyDeviceInfoList($hDevs)
	_SetupDiApiBufferFree($tDevIfInfo)
	_SetupDiApiBufferFree($tDevInfo)

	If ($sDevicePath <> "\\?\") Then
		Return SetError($iMask, 0, 0)
	Else
		Return SetError($iMask, 0, $vDisk)
	EndIf
EndFunc	;==>_CM_Locate_Disk_DevInst

; #### FUNCTION ####
; ====================================================================================================
; Name	: _CM_Enumerate_Siblings
; Description	: Specify a device, retrieves the siblings for this device.
; Parameter(s)	: $hDevInst	- Handle to the device instance, typically returned by _CM_Locate_DevNode.
; Return values	: An array in the form:
;		:	$aArray[0][0] - The number of sibling devices.
;		:	$aArray[1][0] - Handle to the 1st device.
;		:	$aArray[1][1] - Display name of the 1st device.
;		:	... ...
; Author	: Pusofalse
; ====================================================================================================
Func _CM_Enumerate_Siblings($hDevInst)
	Local $aChild[1], $aSibling[1][2]

	$hDevInst = _CM_Get_Parent($hDevInst)
	If ($hDevInst = 0) Then Return SetError(@error, 0, $aSibling)

	$aChild = _CM_Enumerate_Children($hDevInst)
	Redim $aSibling[$aChild[0] + 1][2]
	For $i = 1 To $aChild[0]
		$aSibling[$i][0] = _CM_Locate_DevNode($aChild[$i])
		$aSibling[$i][1] = _CM_Get_Device_Display_Name_Ex($aSibling[$i][0], 0)
	Next
	$aSibling[0][0] = $aChild[0]
	Return $aSibling
EndFunc	;==>_CM_Enumerate_Siblings

; #### FUNCTION ####
; ====================================================================================================
; Name	: _CM_Get_Device_Display_Name_Ex
; Description	: This function retrieves the device friendly name displays in Device Manager.
; Parameter(s)	: $hDevInst	- Handle to the device instance.
;		: $hMachine	- Handle to the machine, or zero on local.
; Return values	: Display name of the device.
; Author	: Pusofalse
; ====================================================================================================
Func _CM_Get_Device_Display_Name_Ex($hDevInst, $hMachine = 0)
	Local $sDescr

	$sDescr = _CM_Get_DevNode_Registry_Property_Ex($hDevInst, 13, $hMachine)
	If ($sDescr = "") Then
		$sDescr = _CM_Get_DevNode_Registry_Property_Ex($hDevInst, 1, $hMachine)
		If ($sDescr = "") Then $sDescr = "(Unrecognized device)"
	EndIf
	Return $sDescr
EndFunc	;==>_CM_Get_Device_Display_Name_Ex

Func _CM_Is_Device_Resource_Present($sDeviceID)
	Local $sRegKey

	$sRegKey = $REGKEY_HARDWARE_CS002_ENUM & $sDeviceID & "\LogConf"
	RegRead($sRegKey, "BasicConfigVector")
	Return (@error = -2)
EndFunc	;==>_CM_Is_Device_Resource_Present

Func _CM_Make_IO_Request($iDeviceType, $iFunction, $iAccess, $iMethod = 0)
	Local $iIoRequest
	$iIoRequest = BitOR( BitShift($iDeviceType, -16), _
			BitShift($iAccess, -14), _
			BitShift($iFunction, -2), _
			$iMethod)
	Return $iIoRequest
EndFunc	;==>_CM_Make_IO_Request







































