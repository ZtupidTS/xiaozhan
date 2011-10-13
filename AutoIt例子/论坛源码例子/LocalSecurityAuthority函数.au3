<LocalSecurityAuthority.au3>


; #### Security descriptor functions ###
; =========================================================
; _AddAce                        ; ���ACE��ACL
; _BuildSecurityDescriptor        ; ������ȫ������(security descriptor)
; _CheckAclMembership        ; ���ACL���Ƿ�Ϊָ���û�����������Ȩ��
; _CombineAcl                ; �ϲ�����ACL
; _ConvertSDToStringSD        ; ת����ȫ���������ַ�����
; _ConvertStringSDToSD        ; ת����ȫ��������ָ����
; _DeleteAce                ; ɾ��ACE
; _DeleteAceByOwner        ; ����ACE������ɾ��ACE
; _DuplicateAcl                ; ??
; _GetAce                        ; ����ACEָ��
; _GetAclInformation                ; ����ACL��Ϣ
; _GetAclType                ; ??
; _GetAuditedPermissionsFromAcl        ; ����SACL���û���Ȩ��
; _GetEffectiveRightsFromAcl                ; ����DACL���û���Ȩ��ֵ
; _GetExplicitAce                        ; ����ACE�����Ϣ (������/����Ȩ��/����ģʽ/�̳�ģʽ)
; _GetExplicitEntriesFromAcl                ; ����ACL�����е�ACE.
; _GetSecurityDescriptorDacl                ; ���ذ�ȫ������DACLָ��
; _GetSecurityDescriptorGroup                ; ��ȫ������GROUPָ��
; _GetSecurityDescriptorLength        ; ��ȫ����������
; _GetSecurityDescriptorOwner                ; ���ذ�ȫ������������ָ�롣
; _GetSecurityDescriptorSacl                ; ��ȫ������SACLָ��
; _InitializeAcl                        ; ��ʼ��ACLָ��
; _InitializeExplicitAccess                ; ��ʼ��EXPLICIT_ACCESS �ṹ�����ӳ̵��á�
; _InitializeSecurityDescriptor                ; ��ʼ����ȫ������
; _InitializeTrustee                        ; ��ʼ��TRUSTEE�ṹ
; _IsValidAcl                        ; У��ACL
; _IsValidSecurityDescriptor                ; У�鰲ȫ������
; _MakeAbsoluteSD
; _MakeSelfRelativeSD
; _SetEntriesInAcl                        ; ����ACL
; _SetEntriesInAcl1                        ; ����ACL
; _SetSecurityDescriptorDacl                ; ���ð�ȫ��������DACL
; _SetSecurityDescriptorGroup                ; ���ð�ȫ��������GROUP
; _SetSecurityDescriptorOwner                ; ���ð�ȫ������������
; _SetSecurityDescriptorSacl                ; .���ð�ȫ������SACL
; =========================================================

; #### File object security functions ####
; =========================================================
; _IsNtfs                        ; ���ָ���ļ��Ƿ���NTFS�ļ�ϵͳ��
; _QueryFileSecurity                ; ����ָ���ļ��İ�ȫ������
; _QueryFileSecurityDacl        ; ����ָ���ļ���DACL�б�
; _QueryFileSecurityOwner        ; ��ѯ�ļ�������
; _SetFileSecurity                ; �����ļ���ȫ
; _SetFileSecurityDacl        ; �����ļ�����Ȩ��
; _SetFileSecurityOwner        ; �����ļ�������
; =========================================================

; #### Kernel object security functions ####
; =========================================================
; _QueryKernelObjectSecurity                ; �����������(����/��������)�İ�ȫ��Ϣ
; _QueryKernelObjectSecurityDacl        ; �����������ķ���Ȩ�ޡ�
; _QueryKernelObjectSecurityOwner        ; ..........................������
; _SetKernelObjectSecurity                ; �����������ȫ
; _SetKernelObjectSecurityDacl        ; ��������������Ȩ��
; _SetKernelObjectSecurityOwner        ; �����������������

; #### Share object security functions ####
; =========================================================
; _QueryShareObjectSecurityDacl        ; ��ѯ������Դ����Ȩ��
; _QueryShareObjectSecurityOwner        ; ��ѯ������Դ������
; _SetShareObjectSecurityDacl                ; ���ù���Ȩ��
; =========================================================

; #### Registry key security functions ####
; =========================================================
; _RegCloseKey ( internal used only )        ; �ر�ע�������, �ڲ�ʹ��
; _RegGetKeySecurity                ; ����ע������ȫ
; _RegGetKeySecurityDacl                ; ����...............����Ȩ��
; _RegGetKeySecurityOwner                ; ......................������
; _RegGetKeySecuritySacl                ; ע����ϵͳ�����б�(SACL)
; _RegOpenKeyEx ( internal used only )        ; ��ע������� (�ڲ�ʹ��)
; _RegSetKeySecurity                ; ����ע������ȫ
; _RegSetKeySecurityDacl                ; ......................DACL
; _RegSetKeySecurityOwner                ; ......................������
; =========================================================

; #### Service object security functions ####
; =========================================================
; _LsaCloseServiceHandle ( internal used only )        ; �رշ�����, �ڲ�ʹ��
; _LsaOpenSCManager ( internal used only )        ; �򿪷��������������ڲ�ʹ��
; _LsaOpenService ( internal used only )                ; �򿪷��������ڲ�ʹ��
; _QueryServiceObjectSecurity                        ; ��ѯ����ȫ
; _QueryServiceObjectSecurityDacl                ; ��ѯ����Ȩ��
; _QueryServiceObjectSecurityOwner                ; ����������
; _QueryServiceObjectSecuritySacl                ; ����ϵͳ�����б�(system access control list)
; _SetServiceObjectSecurity                        ; ���÷���ȫ
; _SetServiceObjectSecurityDacl                ; ���÷���Ȩ��
; _SetServiceObjectSecurityOwner                ; ���÷���������
; _SetServiceObjectSecuritySacl                ; ���÷���SACL
; =========================================================

; #### User account access rights (privileges) functions #### (ʵ��)
; =========================================================
; _ConvertSidToStringSid                ; ת��SIDΪ�ַ���SID
; _ConvertStringSidToSid                ; ת���ַ���SIDΪָ����SID
; _CopySid                        ; ����SID
; _CreateWellKnownSid                ; ���������˻���SID (Everyone, Local, SYSTEM, Creator owner...)
; _EqualSid                        ; �����SID�Ƿ����
; _GetLengthSid                        ; ����SID����
; _GetSidIdentifierAuthority                ; ����SID��Ȩ���������ID(Relative identifier)
; _GetSidSubAuthority                ; ����SID������Ȩ����
; _GetSidSubAuthorityCount                ; ����SID����Ȩ����������
; _IsWellKnownSid                        ; �Ƿ�Ϊ����SID(Everyone, SYSTEM��...)
; _IsValidSid                        ; У��SID
; _LookupAccountName                ; �����û�SID
; _LookupAccountSid                ; ����SID�����û���
; _LsaAccountRightIsEnabled                ; �ж�ָ���û��Ƿ�ӵ��ָ��Ȩ��
; _LsaAddAccountRight                ; ����û�Ȩ��
; _LsaAddLocalGroup                ; ��ӱ����û���
; _LsaAddLocalUser                        ; ��ӱ����û�
; _LsaApiBufferFree (internal used only)        ; �ͷŻ��� (�ڲ�ʹ��)
; _LsaDelLocalGroup                ; ɾ�������û���
; _LsaDelLocalUser                        ; ɾ�������û�
; _LsaEnumerateAccountRights        ; ö���û�Ȩ��
; _LsaEnumerateAccountsWithUserRight        ; ����Ȩ��ö��ӵ�д�Ȩ�޵��û�
; _LsaEnumerateLocalAccounts        ; ö�ٱ����˻�
; _LsaEnumerateLocalGroups                ; ö�ٱ����û���
; _LsaEnumerateWellKnownAccounts        ; ö�������˻�
; _LsaLocalGroupAddMembers        ; ��ָ���ı����û�������ӳ�Ա
; _LsaLocalGroupDelMembers                ; ��ָ���ı����û�����ɾ����Ա
; _LsaLocalGroupGetMembers                ; ö�ٱ����û����е����г�Ա
; _LsaLocalUserGetGroups                ; ���ر����û����ڵ��û���
; _LsaLocalUserGetPasswordPolicy        ; �����������
; _LsaLocalUserSetForceLogoff        ; ���á�ǿ��ע����
; _LsaLocalUserSetLockout                ; �����˻���������
; _LsaLocalUserSetMinPasswordAge        ; ������С�����
; _LsaLocalUserSetMinPasswordLength        ; ������С����
; _LsaLocalUserSetModals (internal used only ?)
; _LsaLookupAccountsRight                ; У���������û���Ȩ�ޣ�������Ȩ�޸ߵ�һ��
; _LsaLocalUserSetPasswordHistLength        ; ������ʷ����
; _LsaRemoveAccountRight                ; �Ƴ��û�Ȩ��
; _LsaStringIsUserAccount                ; �ж��ַ����Ƿ�����û���
; =========================================================



; #### Process functions ####
; =========================================================
; _CreateProcessAsSystem        ; ����ϵͳ������ (����)
; _CreateProcessAsUser        ; ���������û��µĽ���
; _CreateProcessWithLogon        ; ����RunAs
; _GetProcessHeap ( internal used only ) ; ���̶�ջ (�ڲ�ʹ��)
; _OpenProcess                ; �򿪽��̾��
; =========================================================

; #### Access token functions ####
; =========================================================
; _AdjustTokenPrivileges        ; ������Ȩ
; _CheckTokenMembership        ; �жϷ����������Ƿ�Ϊָ���û�����Ȩ��
; _DuplicateTokenEx        ; �������ƣ���ת����������
; _GetTokenGroups                ; ���������������û���
; _GetTokenImpersonationLevel        ; �������Ƶļٳ伶��
; _GetTokenInformation ( internal used only )        ; �������������Ϣ (�ڲ�ʹ��)
; _GetTokenOwner                ; ��������������
; _GetTokenPrivileges        ; ���������а�����Ȩ��
; _GetTokenSource                ; ?
; _GetTokenType                ; ��������
; _GetTokenUser                ; ���������û�
; _ImpersonateLoggedOnUser
; _IsPrivilegeEnabled        ; ���ָ��Ȩ���Ƿ���
; _IsTokenRestricted                ; ��������Ƿ�Ϊ��������
; _LookupPrivilegeDisplayName        ; ������Ȩ��ʾ����
; _LookupPrivilegeName                ; ������Ȩ����
; _LookupPrivilegeValue                ; ������ȨLUID (local unique identifier)
; _OpenProcessToken                ; �򿪽�������
; _RevertToSelf
; =========================================================

; #### Policy audit functions #### (��)
; =========================================================
; _AdjustPolicyAuditEvent        ; ������˲���
; _LsaClose                ; �رղ��Ծ��
; _LsaFreeMemory ( internal used only ) ; �ͷ��ڴ棨�ڲ�ʹ�ã�
; _LsaFreeReturnBuffer ( internal used only ) ; �ͷŻ��棨�ڲ�ʹ�ã�
; _LsaNtStatusToWinError( internal used only ) ; ת��NTSTATUSΪϵͳ������루�ڲ�ʹ�ã�
; _LsaOpenPolicy                ; �򿪲��Ծ��
; =========================================================

; #### System functions ####
; =========================================================
; _AllocateGUID                ; ����ȫ��ΨһID (global unique identifier)
; _AllocateLUID                ; ���䱾��ΨһID (local unique identifier) 
; _GetNamedSecurityInfo        ; �����ض�����İ�ȫ��Ϣ
; _GetSecurityInfo                ; �����ض�����İ�ȫ��Ϣ
; _HeapAlloc                ; �����ڴ棬�������_Query*ObjectSecurity����
; _HeapFree                ; �ͷ��ڴ�
; _HeapSize                ; �ڴ泤��
; _InitializeLuid                ; ��ʼ��LUID
; _LogonUser                ; ��¼�û�
; _LookupPrivilegeOnLoggedUser ; �����ACL���Ƿ�Ϊ��ǰ�û�����Ȩ�ޣ������ظ�Ȩ�޵�һ����
; _LsaCloseHandle                ; �رվ��
; _LsaEnumerateLogonSessions        ; �оٵ�¼�Ự
; _LsaGetLogonSessionData                ; ���ػỰ��Ϣ
; _LsaHiLong64                ; ����8�ֽ���ֵ�еĸ�8λ
; _LsaInitializeBufferW        ; ��ʼ��tagLSAUNICODE�ṹ��������ָ�롣
; _LsaLocalFree                ; �ͷ��ڴ�
; _LsaLocalSize                ; �ڴ泤�ȣ����ڷ�����_SetEntriesInAcl�����ACL���ȡ�
; _LsaLoLong64                ; ����8�ֽ���ֵ�еĵ�8λ��
; _LsaMakeLong64                ; ����8�ֽ���ֵ
; _SetNamedSecurityInfo        ; ����ָ������İ�ȫ��Ϣ
; _SetSecurityInfo                ; ����ָ������İ�ȫ��Ϣ
; _StringFromGUID                ; ����GUID���ַ�����ʽ
; _GUIDFromString                ; ����ָ����GUID.
; =========================================================

; #### Secret functions #### (����)
; =========================================================
; _LsaCreateSecret                ; ������������
; _LsaCreateSecretManager        ; �����������ݿ�
; _LsaDeleteSecret                ; ɾ����������
; _LsaEnumerateSecrets        ; ö�ٻ�������
; _LsaGetSecret                ; ���ػ������ݵ�GUID
; _LsaQuerySecret                ; ��ѯ��������
; _LsaRetrievePrivateData        ; ����˽������
; _LsaStorePrivateData        ; �洢˽������
; =========================================================


; #### Cryptography functions #### (�Ѷȡ�����)
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
; _CryptVerifyObjectHashValue        ; У���ļ�/����/ע���/��������HASHֵ��
; =========================================================



; #### Other internal used only functions ####
; =========================================================
; _FreeVariable
; _GetLastError


; _QueryFile*/_SetFile*����ֻ�ܶ�NTFS�ļ�ϵͳ�е��ļ�����Ȩ�޲�ѯ/���ò�����
; _Set*SecurityDacl ��_Set*SecurityOwner���ʹ�ã�����ʹ������Ȩ�����ó���(cacls.exe setacl.exe��)�������������� 
; _LookupPrivilegeOnLoggedUser/_LsaLookupAccountsRight, ���ᱻ�����õ�����һ���õ����ᷢ��������������ʵ�á�
; Security description functions �еĺ������Ϊ�ڲ�ʹ�ã����û��ѯ����ȫ����ʹ�����Ӧ�ĺ�����

; _GetNamedSecurityInfo ������һ���������ַ����ͣ���_GetSecurityInfo��һ�������Ǿ���͡����������÷���ȣ�
; _GetNamedSecurityInfo("LanmanServer", $SE_SERVICE, 4)
; _GetSecurityInfo(_LsaOpenService("LanmanServer", $READ_CONTROL), $SE_SERVICE, 4)
; ���_GetNamedSecurityInfo�������������������ú��ʵ�Ȩ��ֵ�򿪶��������ٴ��ݵ�_GetSecurityInfo�������в�����
; _GetNamedSecurityInfo ��_GetSecurityInfo�����ܷ����м̳й�ϵ�Ķ���İ�ȫ��
; _GetNamedSecurityInfo("Machine\Software\Test", $SE_REGISTRY_KEY, 4) ,���Test����Ȩ�޼̳���Software��������ô_GetNamedSecurityInfo��������������, _GetSecurityInfoͬ�ǡ�ʹ��_RegGetKeySecurityDacl��������ִ���

; ϵͳ���ʿ����б�(SACL - system access control list) ����ֻ�����ڷ����С�������ļ��������������SACL����ô��û���κ����塣
; ���Ҫ���ػ�����ĳ�����SACL����Ϊ���̿���SE_SECURITY_NAME��Ȩ��


; ʹ��_AdjustTokenPrivileges����ĳ��Ȩʱ����ȷ����ǰ�û��Ƿ��д���Ȩ��
; _LsaAddAccountRight����û�Ȩ��, _LsaRemoveAccountRight�Ƴ��û�Ȩ�ޡ�
; ʹ��_AdjustTokenPrivileges���Ե�����Ȩ������SE_DEBUG_NAME, ������GENERIC_ALL����ֵ�򿪽��̾����
; ʹ��_CreateProcessAsSystem����ϵͳ�����̣��Դ˿��Ե���������������ע������ؼ�ֵ������SYSTEMȨ���£�FileOpen(��?)��������������������

; _GetSidIdentifierAuthority/_GetSidSubAuthority/_GetSidSubAuthorityCount 3���������ʹ�ã������жϳ�ָ���û���ӵ�е�Ȩ��(administrator or guest Ȩ��)��

; Secret functions������ϵͳ�����ػ������ݣ����ó�����Ч�ڻ��õ���Щ������
; _LsaRetrievePrivateData������ϵͳ�еĸ��ֻ������ݣ��������ADSL�����û�������ʹ�ô˺��������ɵصõ�ADSL���롣
; _LsaStorePrivateData��ϵͳ�д洢�������ݣ������ܴ洢_CryptProtectData���ܹ������ݡ�

; _CryptProtectData/ _CryptUnprotectData ����/�����ַ�����administrator���ܵ�����ֻ����administrartor��ͬһϵͳ�н��ܡ�
; _CryptBinaryToString/_CryptStringToBinary ���Է����ַ�����BASE64���룬�ظ�����_CryptBinaryToString����ʹ���ܸ���ǿ׳��
; _CryptHashCeritificate У��hashֵ��MD2/MD4/MD5/SHA1 �ȡ�
; _CryptVerifyObjectHashValue У������hashֵ��
; _CryptVerifyObjectHashValue("cmd.exe", $CRYPT_OBJECT_FILE, $CRYPT_MASK_ATTRIBUTES)�����cmd.exe������(ֻ��/����)�ı䣬hash��֮�ı�
; _CryptVerifyObjectHashValue("LanmanServer", $CRYPT_OBJECT_SERVICE, $CRYPT_MASK_DACL), ���LanmanServer�ķ���Ȩ�޸ı䣬hash��֮�ı�