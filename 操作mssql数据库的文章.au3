#cs
        �е����ģ�дһƪ���ڲ���mssql���ݿ�����¡�
        ˮƽ���ߣ�ֻΪ������һ����ѧϰ�����ϣ���ӭ������ש��
        -By Crossdoor
#ce
#Include <Array.au3>
;~ Ҫ�������ݿ⣬��һ���¾��Ǳ������������ݿ⣬����MsSql����ʹ��Ado��AU3�ṩ�˺���ObjCreate������Comָ������
;~ ������β�����ʵ��
$Err = ObjEvent("AutoIt.Error", "ODBCJET_ErroHandler") ;����һ������ODBCJET_ErroHandler�ռ�����Ĵ���

Dim $sServer = '127.0.0.1', $sUsername = 'sa', $sPassword = '1234567' ;���������ֱ����������ݿ��õĵ�ַ���˺š�����
$Conn = ObjCreate("ADODB.Connection");����Ҫ����ADODB.Connection��
$Conn.open("DRIVER={SQL Server};SERVER=" & $sServer & ";UID=" & $sUsername & ";PWD=" & $sPassword & ";");ʹ��open�����������ݿ�
If @error Then Exit
;�������û���˳���˵���ɹ������������ݿ�

;���ӳɹ�����������ȡ����
$Conn.Execute("use master") ;����Ҫָ��һ����Ҫ�����Ŀ⣬������ϵͳ�Դ���master��������
$RS = ObjCreate("ADODB.Recordset");������¼������
$RS.ActiveConnection = $conn;���ü�¼���ļ���������������$Conn
$RS.Open("Select * from sysdatabases ORDER BY Name");ִ��Sql��䣬�������ǲ�ѯ���ݿ������еĿ����ԣ����Ұ�Name�ֶε����ݽ�������
Dim $Select_Db[1][1] = [[0]];����һ�����������ղ�ѯ��������
Dim $Count = 1;����һ������������¼��ѯ������������
While Not $RS.eof And Not $RS.bof;����¼ָ�봦�ڵ�һ����¼�����һ����¼֮��ʱ��ִ��whileѭ��
        If @error = 1 Then ExitLoop
        If $Select_Db[0][0] = 0 Then;�������ά$Select_Db[0][0]Ϊ0ʱ���ض�������ĵڶ�ά��С���ڼ�¼����ѯ�����ֶ���
                ReDim $Select_Db[1][$RS.Fields.Count + 1];$RS.Fields.CountΪ��¼����ѯ�����ֶ���
                For $i = 0 To $RS.Fields.Count - 1
                        $Select_Db[0][$i + 1] = $RS.Fields($i).Name;$RS.Fields($i).NameΪ�ֶ��������ֶ�����������
                Next
        EndIf
        ReDim $Select_Db[$Count + 1][$RS.Fields.Count + 1];�����һά��С��1�����ڴ������
        $Select_Db[0][0] = $Count;$Select_Db[0][0]��Ų�ѯ������������
        For $i = 0 To $RS.Fields.Count - 1
                $Select_Db[$Count][$i + 1] = $RS.Fields($i).Value;$RS.Fields($i).Value�ֶ�����
        Next
        $Count += 1;������1
        $RS.movenext;����¼ָ��ӵ�ǰ��λ��������һ��
WEnd
$RS.Close;�رռ�¼������
_ArrayDisplay($Select_Db, "���ݿ����п�����");��ʾ����

#cs    ��ѯ���ݵ�ʱ�������ָ��Ҫ���������ݿ⣬������ʹ������ķ�����������������ڲ�ѯ��sql����ϣ�����˽�����ѿ��Կ�һ������Ĵ���
$RS = ObjCreate("ADODB.Recordset");������¼������
$RS.ActiveConnection = $conn;���ü�¼���ļ���������������$Conn
$RS.Open("Select * from Master.dbo.sysdatabases ORDER BY Name");ִ��Sql���
Dim $Select_Db[1][1] = [[0]];����һ�����������ղ�ѯ��������
Dim $Count = 1;����һ������������¼��ѯ������������
While Not $RS.eof And Not $RS.bof;����¼ָ�봦�ڵ�һ����¼�����һ����¼֮��ʱ��ִ��whileѭ��
        If @error = 1 Then ExitLoop
        If $Select_Db[0][0] = 0 Then;�������ά$Select_Db[0][0]Ϊ0ʱ���ض�������ĵڶ�ά��С���ڼ�¼����ѯ�����ֶ���
                ReDim $Select_Db[1][$RS.Fields.Count + 1];$RS.Fields.CountΪ��¼����ѯ�����ֶ���
                For $i = 0 To $RS.Fields.Count - 1
                        $Select_Db[0][$i + 1] = $RS.Fields($i).Name;$RS.Fields($i).NameΪ�ֶ��������ֶ�����������
                Next
        EndIf
        ReDim $Select_Db[$Count + 1][$RS.Fields.Count + 1];�����һά��С��1�����ڴ������
        $Select_Db[0][0] = $Count;$Select_Db[0][0]��Ų�ѯ������������
        For $i = 0 To $RS.Fields.Count - 1
                $Select_Db[$Count][$i + 1] = $RS.Fields($i).Value;$RS.Fields($i).Value�ֶ�����
        Next
        $Count += 1;������1
        $RS.movenext;����¼ָ��ӵ�ǰ��λ��������һ��
WEnd
$RS.close;�رռ�¼��
_ArrayDisplay($Select_Db);��ʾ����
#ce

;~ ֪����ζ�ȡ���ݺ���������д�����ݣ�����Ϊ�˲��ƻ�masterϵͳ������ݣ��ڴ�֮ǰ����������һ�����Ա�test
$Conn.Execute("use master");������������ָ��Ҫ�����Ŀ�
$Conn.Execute("CREATE TABLE test(F_id int identity(1, 1) primary key,Name varchar(50),Tel char(50))");ִ�н����sql���
;�����sql��䣬��test���д����������ֶ�int�͵�F_id��varchar�͵�Name��char�͵�Tel������F_id������Ϊ�������������˱�ʶ
$read = ReabTableDb($conn, "select * from dbo.sysobjects where OBJECTPROPERTY(id, N'IsUserTable') = 1 ORDER BY Name")
_ArrayDisplay($read, "Test��������������еı�����")

;test���������ǾͿ���������д�������ˡ�������Ĵ��룬��Name�ֶ�д��������Tel�ֶ�д��13911931773
$Conn.Execute("insert into test (Name,Tel) values ('����','13911931773')")
$read = ReabTableDb($conn, "Select * from test")
_ArrayDisplay($read, "Test��д������")
;��д������ 13614441525
$Conn.Execute("insert into test (Name,Tel) values ('����','13614441525')")
$read = ReabTableDb($conn, "Select * from test")
_ArrayDisplay($read, "Test��д������")
;��д������ 13000074125
$Conn.Execute("insert into test (Name,Tel) values ('����','13000074125')")
$read = ReabTableDb($conn, "Select * from test")
_ArrayDisplay($read, "Test��д������")
;������ִ�н����д�����ݿ��Կ�������Ϊ����Ҫ��ȡ���ݣ���������û�н�����¼��


;�ɹ�д�����ݺ����������Ը������ݡ�������Ĵ��룬��������Tel�ֶ����ݴ�13911931773�ĳ�119
$Conn.Execute("UPDATE test set Tel = '119' WHERE Name = '����'")
$read = ReabTableDb($conn, "Select * from test")
_ArrayDisplay($read, "Test���������")
;�������������޸ģ������������������޸ġ���Tel�ֶε��������ݸĳ�9��0
$Conn.Execute("UPDATE test set Tel = '000000000'")
$read = ReabTableDb($conn, "Select * from test")
_ArrayDisplay($read, "Test���������")


;�������ݺ�������ɾ�����ݡ�����ɾ������
$Conn.Execute("DELETE FROM test WHERE Name = '����'")
$read = ReabTableDb($conn, "Select * from test")
_ArrayDisplay($read, "Test��ɾ������")
;����ɾ��test���ȫ������
$Conn.Execute("DELETE FROM test")
$read = ReabTableDb($conn, "Select * from test")
_ArrayDisplay($read, "Test��ɾ������")


;��Ȼ����������е����ݣ��ǵ�ȻҪ����ɾ�����ˡ��������ѸղŽ�����Test��ɾ��
$Conn.Execute("DROP TABLE test")
$read = ReabTableDb($conn, "select * from dbo.sysobjects where OBJECTPROPERTY(id, N'IsUserTable') = 1 ORDER BY Name")
_ArrayDisplay($read, "Test��ɾ������������еı�����")


$Conn.Close;���еĲ����������󣬹ر����ݿ�����



#cs ������
        ���߰����д��һ��ͨ����Ȼ���������ϣ��õĿ��ԡ�����Ȩ����ש������ˣ�ϣ�������ܶ�д��õĽ̳̳�����
        ͨ�������һ������ӣ���ʵ���ѿ�����ʹ��Au3�������ݿ�Ļ�����������Ļ��Ƕ�sql�ű�����Ϥ��
        д����sql���Ļ�������ɵ�ʲô���»�Ƚ��鷳���������аٶȺ͹ȸ裬�������ǻ����Լ��ͣ�
        -By Crossdoor 2010-05-07
#ce



Func ReabTableDb($conn, $Sql);��ȡ����
        $RS = ObjCreate("ADODB.Recordset");������¼������
        $RS.ActiveConnection = $conn;���ü�¼���ļ���������������$Conn
        $RS.Open($Sql);ִ��Sql���
        Dim $Select_Db[1][1] = [[0]];����һ�����������ղ�ѯ��������
        Dim $Count = 1;����һ������������¼��ѯ������������
        While Not $RS.eof And Not $RS.bof;����¼ָ�봦�ڵ�һ����¼�����һ����¼֮��ʱ��ִ��whileѭ��
                If @error = 1 Then ExitLoop
                If $Select_Db[0][0] = 0 Then;�������ά$Select_Db[0][0]Ϊ0ʱ���ض�������ĵڶ�ά��С���ڼ�¼����ѯ�����ֶ���
                        ReDim $Select_Db[1][$RS.Fields.Count + 1];$RS.Fields.CountΪ��¼����ѯ�����ֶ���
                        For $i = 0 To $RS.Fields.Count - 1
                                $Select_Db[0][$i + 1] = $RS.Fields($i).Name;$RS.Fields($i).NameΪ�ֶ��������ֶ�����������
                        Next
                EndIf
                ReDim $Select_Db[$Count + 1][$RS.Fields.Count + 1];�����һά��С��1�����ڴ������
                $Select_Db[0][0] = $Count;$Select_Db[0][0]��Ų�ѯ������������
                For $i = 0 To $RS.Fields.Count - 1
                        $Select_Db[$Count][$i + 1] = $RS.Fields($i).Value;$RS.Fields($i).Value�ֶ�����
                Next
                $Count += 1;������1
                $RS.movenext;����¼ָ��ӵ�ǰ��λ��������һ��
        WEnd
        $RS.Close;�رռ�¼������
        Return $Select_Db
EndFunc

Func ODBCJET_ErroHandler();Com���������Ϣ�ռ�����
        MsgBox(0,"Intercepted Sql Error !", @CRLF &"Intercepted Sql Error !"      & @CRLF  & _
             "err.description is: "    & @TAB & $Err.description    & @CRLF & _
             "err.windescription:"     & @TAB & $Err.windescription & @CRLF & _
             "err.number is: "         & @TAB & hex($Err.number,8)  & @CRLF & _
             "err.lastdllerror is: "   & @TAB & $Err.lastdllerror   & @CRLF & _
             "err.source is: "         & @TAB & $Err.source         & @CRLF & _
             "err.helpfile is: "       & @TAB & $Err.helpfile       & @CRLF & _
             "err.helpcontext is: "    & @TAB & $Err.helpcontext & @CRLF)
        SetError(1)
EndFunc   ;==>ODBCJET_ErroHandler