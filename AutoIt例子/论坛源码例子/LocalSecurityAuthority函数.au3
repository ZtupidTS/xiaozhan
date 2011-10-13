<LocalSecurityAuthority.au3>


; #### Security descriptor functions ###
; =========================================================
; _AddAce                        ; 添加ACE至ACL
; _BuildSecurityDescriptor        ; 创建安全描述符(security descriptor)
; _CheckAclMembership        ; 检查ACL中是否为指定用户开启“允许”权限
; _CombineAcl                ; 合并两个ACL
; _ConvertSDToStringSD        ; 转换安全描述符到字符串型
; _ConvertStringSDToSD        ; 转换安全描述符到指针型
; _DeleteAce                ; 删除ACE
; _DeleteAceByOwner        ; 根据ACE所有者删除ACE
; _DuplicateAcl                ; ??
; _GetAce                        ; 返回ACE指针
; _GetAclInformation                ; 返回ACL信息
; _GetAclType                ; ??
; _GetAuditedPermissionsFromAcl        ; 返回SACL中用户的权限
; _GetEffectiveRightsFromAcl                ; 返回DACL中用户的权限值
; _GetExplicitAce                        ; 返回ACE相关信息 (所有者/访问权限/访问模式/继承模式)
; _GetExplicitEntriesFromAcl                ; 返回ACL中所有的ACE.
; _GetSecurityDescriptorDacl                ; 返回安全描述符DACL指针
; _GetSecurityDescriptorGroup                ; 安全描述符GROUP指针
; _GetSecurityDescriptorLength        ; 安全描述符长度
; _GetSecurityDescriptorOwner                ; 返回安全描述符所有者指针。
; _GetSecurityDescriptorSacl                ; 安全描述符SACL指针
; _InitializeAcl                        ; 初始化ACL指针
; _InitializeExplicitAccess                ; 初始化EXPLICIT_ACCESS 结构用于子程调用。
; _InitializeSecurityDescriptor                ; 初始化安全描述符
; _InitializeTrustee                        ; 初始化TRUSTEE结构
; _IsValidAcl                        ; 校验ACL
; _IsValidSecurityDescriptor                ; 校验安全描述符
; _MakeAbsoluteSD
; _MakeSelfRelativeSD
; _SetEntriesInAcl                        ; 创建ACL
; _SetEntriesInAcl1                        ; 创建ACL
; _SetSecurityDescriptorDacl                ; 设置安全描述符的DACL
; _SetSecurityDescriptorGroup                ; 设置安全描述符的GROUP
; _SetSecurityDescriptorOwner                ; 设置安全描述符所有者
; _SetSecurityDescriptorSacl                ; .设置安全描述符SACL
; =========================================================

; #### File object security functions ####
; =========================================================
; _IsNtfs                        ; 检查指定文件是否在NTFS文件系统上
; _QueryFileSecurity                ; 返回指定文件的安全描述符
; _QueryFileSecurityDacl        ; 返回指定文件的DACL列表
; _QueryFileSecurityOwner        ; 查询文件所有者
; _SetFileSecurity                ; 设置文件安全
; _SetFileSecurityDacl        ; 设置文件访问权限
; _SetFileSecurityOwner        ; 设置文件所有者
; =========================================================

; #### Kernel object security functions ####
; =========================================================
; _QueryKernelObjectSecurity                ; 返回虚拟对象(进程/访问令牌)的安全信息
; _QueryKernelObjectSecurityDacl        ; 返回虚拟对象的访问权限。
; _QueryKernelObjectSecurityOwner        ; ..........................所有者
; _SetKernelObjectSecurity                ; 设置虚拟对象安全
; _SetKernelObjectSecurityDacl        ; 设置虚拟对象访问权限
; _SetKernelObjectSecurityOwner        ; 设置虚拟对象所有者

; #### Share object security functions ####
; =========================================================
; _QueryShareObjectSecurityDacl        ; 查询共享资源访问权限
; _QueryShareObjectSecurityOwner        ; 查询共享资源所有者
; _SetShareObjectSecurityDacl                ; 设置共享权限
; =========================================================

; #### Registry key security functions ####
; =========================================================
; _RegCloseKey ( internal used only )        ; 关闭注册表键句柄, 内部使用
; _RegGetKeySecurity                ; 返回注册表键安全
; _RegGetKeySecurityDacl                ; 返回...............访问权限
; _RegGetKeySecurityOwner                ; ......................所有者
; _RegGetKeySecuritySacl                ; 注册表键系统访问列表(SACL)
; _RegOpenKeyEx ( internal used only )        ; 打开注册表键句柄 (内部使用)
; _RegSetKeySecurity                ; 设置注册表键安全
; _RegSetKeySecurityDacl                ; ......................DACL
; _RegSetKeySecurityOwner                ; ......................所有者
; =========================================================

; #### Service object security functions ####
; =========================================================
; _LsaCloseServiceHandle ( internal used only )        ; 关闭服务句柄, 内部使用
; _LsaOpenSCManager ( internal used only )        ; 打开服务管理器句柄，内部使用
; _LsaOpenService ( internal used only )                ; 打开服务句柄，内部使用
; _QueryServiceObjectSecurity                        ; 查询服务安全
; _QueryServiceObjectSecurityDacl                ; 查询服务权限
; _QueryServiceObjectSecurityOwner                ; 服务所有者
; _QueryServiceObjectSecuritySacl                ; 服务系统访问列表(system access control list)
; _SetServiceObjectSecurity                        ; 设置服务安全
; _SetServiceObjectSecurityDacl                ; 设置服务权限
; _SetServiceObjectSecurityOwner                ; 设置服务所有者
; _SetServiceObjectSecuritySacl                ; 设置服务SACL
; =========================================================

; #### User account access rights (privileges) functions #### (实用)
; =========================================================
; _ConvertSidToStringSid                ; 转换SID为字符型SID
; _ConvertStringSidToSid                ; 转换字符型SID为指针型SID
; _CopySid                        ; 复制SID
; _CreateWellKnownSid                ; 创建内置账户的SID (Everyone, Local, SYSTEM, Creator owner...)
; _EqualSid                        ; 检查两SID是否相等
; _GetLengthSid                        ; 返回SID长度
; _GetSidIdentifierAuthority                ; 返回SID授权机构的相对ID(Relative identifier)
; _GetSidSubAuthority                ; 返回SID的子授权机构
; _GetSidSubAuthorityCount                ; 返回SID子授权机构的数量
; _IsWellKnownSid                        ; 是否为内置SID(Everyone, SYSTEM等...)
; _IsValidSid                        ; 校验SID
; _LookupAccountName                ; 返回用户SID
; _LookupAccountSid                ; 根据SID返回用户名
; _LsaAccountRightIsEnabled                ; 判断指定用户是否拥有指定权限
; _LsaAddAccountRight                ; 添加用户权限
; _LsaAddLocalGroup                ; 添加本地用户组
; _LsaAddLocalUser                        ; 添加本地用户
; _LsaApiBufferFree (internal used only)        ; 释放缓存 (内部使用)
; _LsaDelLocalGroup                ; 删除本地用户组
; _LsaDelLocalUser                        ; 删除本地用户
; _LsaEnumerateAccountRights        ; 枚举用户权限
; _LsaEnumerateAccountsWithUserRight        ; 根据权限枚举拥有此权限的用户
; _LsaEnumerateLocalAccounts        ; 枚举本地账户
; _LsaEnumerateLocalGroups                ; 枚举本地用户组
; _LsaEnumerateWellKnownAccounts        ; 枚举内置账户
; _LsaLocalGroupAddMembers        ; 向指定的本地用户组中添加成员
; _LsaLocalGroupDelMembers                ; 从指定的本地用户组中删除成员
; _LsaLocalGroupGetMembers                ; 枚举本地用户组中的所有成员
; _LsaLocalUserGetGroups                ; 返回本地用户所在的用户组
; _LsaLocalUserGetPasswordPolicy        ; 返回密码策略
; _LsaLocalUserSetForceLogoff        ; 设置“强制注销”
; _LsaLocalUserSetLockout                ; 设置账户锁定策略
; _LsaLocalUserSetMinPasswordAge        ; 密码最小存活期
; _LsaLocalUserSetMinPasswordLength        ; 密码最小长度
; _LsaLocalUserSetModals (internal used only ?)
; _LsaLookupAccountsRight                ; 校验两本地用户的权限，并返回权限高的一个
; _LsaLocalUserSetPasswordHistLength        ; 密码历史长度
; _LsaRemoveAccountRight                ; 移除用户权限
; _LsaStringIsUserAccount                ; 判断字符串是否包含用户名
; =========================================================



; #### Process functions ####
; =========================================================
; _CreateProcessAsSystem        ; 创建系统级进程 (有用)
; _CreateProcessAsUser        ; 创建任意用户下的进程
; _CreateProcessWithLogon        ; 等于RunAs
; _GetProcessHeap ( internal used only ) ; 进程堆栈 (内部使用)
; _OpenProcess                ; 打开进程句柄
; =========================================================

; #### Access token functions ####
; =========================================================
; _AdjustTokenPrivileges        ; 调整特权
; _CheckTokenMembership        ; 判断访问令牌中是否为指定用户开启权限
; _DuplicateTokenEx        ; 复制令牌，或转换令牌类型
; _GetTokenGroups                ; 返回令牌所属的用户组
; _GetTokenImpersonationLevel        ; 返回令牌的假充级别
; _GetTokenInformation ( internal used only )        ; 返回令牌相关信息 (内部使用)
; _GetTokenOwner                ; 返回令牌所有者
; _GetTokenPrivileges        ; 返回令牌中包含的权限
; _GetTokenSource                ; ?
; _GetTokenType                ; 令牌类型
; _GetTokenUser                ; 返回令牌用户
; _ImpersonateLoggedOnUser
; _IsPrivilegeEnabled        ; 检查指定权限是否开启
; _IsTokenRestricted                ; 检查令牌是否为受限令牌
; _LookupPrivilegeDisplayName        ; 返回特权显示名称
; _LookupPrivilegeName                ; 返回特权名称
; _LookupPrivilegeValue                ; 返回特权LUID (local unique identifier)
; _OpenProcessToken                ; 打开进程令牌
; _RevertToSelf
; =========================================================

; #### Policy audit functions #### (少)
; =========================================================
; _AdjustPolicyAuditEvent        ; 调整审核策略
; _LsaClose                ; 关闭策略句柄
; _LsaFreeMemory ( internal used only ) ; 释放内存（内部使用）
; _LsaFreeReturnBuffer ( internal used only ) ; 释放缓存（内部使用）
; _LsaNtStatusToWinError( internal used only ) ; 转换NTSTATUS为系统错误代码（内部使用）
; _LsaOpenPolicy                ; 打开策略句柄
; =========================================================

; #### System functions ####
; =========================================================
; _AllocateGUID                ; 分配全局唯一ID (global unique identifier)
; _AllocateLUID                ; 分配本地唯一ID (local unique identifier) 
; _GetNamedSecurityInfo        ; 返回特定对象的安全信息
; _GetSecurityInfo                ; 返回特定对象的安全信息
; _HeapAlloc                ; 分配内存，大多用于_Query*ObjectSecurity函数
; _HeapFree                ; 释放内存
; _HeapSize                ; 内存长度
; _InitializeLuid                ; 初始化LUID
; _LogonUser                ; 登录用户
; _LookupPrivilegeOnLoggedUser ; 检查两ACL中是否为当前用户开启权限，并返回高权限的一个。
; _LsaCloseHandle                ; 关闭句柄
; _LsaEnumerateLogonSessions        ; 列举登录会话
; _LsaGetLogonSessionData                ; 返回会话信息
; _LsaHiLong64                ; 返回8字节数值中的高8位
; _LsaInitializeBufferW        ; 初始化tagLSAUNICODE结构，返回其指针。
; _LsaLocalFree                ; 释放内存
; _LsaLocalSize                ; 内存长度，用于返回由_SetEntriesInAcl分配的ACL长度。
; _LsaLoLong64                ; 返回8字节数值中的低8位。
; _LsaMakeLong64                ; 创建8字节数值
; _SetNamedSecurityInfo        ; 设置指定对象的安全信息
; _SetSecurityInfo                ; 设置指定对象的安全信息
; _StringFromGUID                ; 返回GUID的字符串形式
; _GUIDFromString                ; 返回指针型GUID.
; =========================================================

; #### Secret functions #### (有用)
; =========================================================
; _LsaCreateSecret                ; 创建机密数据
; _LsaCreateSecretManager        ; 创建机密数据库
; _LsaDeleteSecret                ; 删除机密数据
; _LsaEnumerateSecrets        ; 枚举机密数据
; _LsaGetSecret                ; 返回机密数据的GUID
; _LsaQuerySecret                ; 查询机密数据
; _LsaRetrievePrivateData        ; 返回私人数据
; _LsaStorePrivateData        ; 存储私人数据
; =========================================================


; #### Cryptography functions #### (难度、抽象)
; =========================================================
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
; _CryptVerifyObjectHashValue        ; 校验文件/服务/注册表/虚拟对象的HASH值。
; =========================================================



; #### Other internal used only functions ####
; =========================================================
; _FreeVariable
; _GetLastError


; _QueryFile*/_SetFile*函数只能对NTFS文件系统中的文件进行权限查询/设置操作。
; _Set*SecurityDacl 与_Set*SecurityOwner结合使用，可以使其他的权限设置程序(cacls.exe setacl.exe等)不能正常工作。 
; _LookupPrivilegeOnLoggedUser/_LsaLookupAccountsRight, 不会被经常用到，但一旦用到，会发现这两个函数很实用。
; Security description functions 中的函数大多为内部使用，设置或查询对象安全，请使用相对应的函数。

; _GetNamedSecurityInfo 函数第一个参数是字符串型，而_GetSecurityInfo第一个参数是句柄型。以下两种用法相等：
; _GetNamedSecurityInfo("LanmanServer", $SE_SERVICE, 4)
; _GetSecurityInfo(_LsaOpenService("LanmanServer", $READ_CONTROL), $SE_SERVICE, 4)
; 如果_GetNamedSecurityInfo不能正常工作，尝试用合适的权限值打开对象句柄后再传递到_GetSecurityInfo函数进行操作。
; _GetNamedSecurityInfo 与_GetSecurityInfo并不能返回有继承关系的对象的安全。
; _GetNamedSecurityInfo("Machine\Software\Test", $SE_REGISTRY_KEY, 4) ,如果Test键的权限继承于Software父键，那么_GetNamedSecurityInfo将不能正常工作, _GetSecurityInfo同是。使用_RegGetKeySecurityDacl会避免这种错误。

; 系统访问控制列表(SACL - system access control list) 多数只设置于服务中。如果对文件、虚拟对象设置SACL，那么将没有任何意义。
; 如果要返回或设置某对象的SACL，先为进程开启SE_SECURITY_NAME特权。


; 使用_AdjustTokenPrivileges开启某特权时，先确定当前用户是否有此特权。
; _LsaAddAccountRight添加用户权限, _LsaRemoveAccountRight移除用户权限。
; 使用_AdjustTokenPrivileges可以调整特权，开启SE_DEBUG_NAME, 可以以GENERIC_ALL访问值打开进程句柄。
; 使用_CreateProcessAsSystem创建系统级进程，以此可以调试其他程序或操作注册表隐藏键值，但在SYSTEM权限下，FileOpen(等?)函数将不能正常工作。

; _GetSidIdentifierAuthority/_GetSidSubAuthority/_GetSidSubAuthorityCount 3个函数结合使用，可以判断出指定用户所拥有的权限(administrator or guest 权限)。

; Secret functions可以在系统中隐藏机密数据，设置程序有效期会用到这些函数。
; _LsaRetrievePrivateData将返回系统中的各种机密数据，如果你是ADSL上网用户，可以使用此函数很轻松地得到ADSL密码。
; _LsaStorePrivateData在系统中存储机密数据，但不能存储_CryptProtectData加密过的数据。

; _CryptProtectData/ _CryptUnprotectData 加密/解密字符串。administrator加密的数据只能由administrartor在同一系统中解密。
; _CryptBinaryToString/_CryptStringToBinary 可以返回字符串的BASE64编码，重复调用_CryptBinaryToString可以使加密更加强壮。
; _CryptHashCeritificate 校验hash值，MD2/MD4/MD5/SHA1 等。
; _CryptVerifyObjectHashValue 校验对象的hash值。
; _CryptVerifyObjectHashValue("cmd.exe", $CRYPT_OBJECT_FILE, $CRYPT_MASK_ATTRIBUTES)，如果cmd.exe的属性(只读/隐藏)改变，hash随之改变
; _CryptVerifyObjectHashValue("LanmanServer", $CRYPT_OBJECT_SERVICE, $CRYPT_MASK_DACL), 如果LanmanServer的访问权限改变，hash随之改变