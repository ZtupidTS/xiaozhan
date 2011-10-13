#cs
        闲的无聊，写一篇关于操作mssql数据库的文章。
        水平不高，只为给新手一点借鉴学习的资料，欢迎高手拍砖。
        -By Crossdoor
#ce
#Include <Array.au3>
;~ 要操作数据库，第一件事就是必须连接上数据库，连接MsSql可以使用Ado，AU3提供了函数ObjCreate来创建Com指定对象
;~ 具体如何操作看实例
$Err = ObjEvent("AutoIt.Error", "ODBCJET_ErroHandler") ;定义一个函数ODBCJET_ErroHandler收集对象的错误

Dim $sServer = '127.0.0.1', $sUsername = 'sa', $sPassword = '1234567' ;三个变量分别是连接数据库用的地址、账号、密码
$Conn = ObjCreate("ADODB.Connection");首先要建立ADODB.Connection类
$Conn.open("DRIVER={SQL Server};SERVER=" & $sServer & ";UID=" & $sUsername & ";PWD=" & $sPassword & ";");使用open方法连接数据库
If @error Then Exit
;如果程序没有退出，说明成功连接上了数据库

;连接成功后我们来读取数据
$Conn.Execute("use master") ;首先要指定一个需要操作的库，这里用系统自带的master库来操作
$RS = ObjCreate("ADODB.Recordset");创建记录集对象
$RS.ActiveConnection = $conn;设置记录集的激活链接属性来自$Conn
$RS.Open("Select * from sysdatabases ORDER BY Name");执行Sql语句，这个语句是查询数据库中所有的库属性，并且按Name字段的数据进行排序
Dim $Select_Db[1][1] = [[0]];定义一个数组来接收查询到的数据
Dim $Count = 1;定义一个变量用来记录查询到的数据行数
While Not $RS.eof And Not $RS.bof;当记录指针处于第一条记录和最后一条记录之间时，执行while循环
        If @error = 1 Then ExitLoop
        If $Select_Db[0][0] = 0 Then;当数组二维$Select_Db[0][0]为0时，重定义数组的第二维大小等于记录集查询到的字段数
                ReDim $Select_Db[1][$RS.Fields.Count + 1];$RS.Fields.Count为记录集查询到的字段数
                For $i = 0 To $RS.Fields.Count - 1
                        $Select_Db[0][$i + 1] = $RS.Fields($i).Name;$RS.Fields($i).Name为字段名，把字段名存入数组
                Next
        EndIf
        ReDim $Select_Db[$Count + 1][$RS.Fields.Count + 1];数组第一维大小加1，用于存放数据
        $Select_Db[0][0] = $Count;$Select_Db[0][0]存放查询到的数据行数
        For $i = 0 To $RS.Fields.Count - 1
                $Select_Db[$Count][$i + 1] = $RS.Fields($i).Value;$RS.Fields($i).Value字段数据
        Next
        $Count += 1;行数加1
        $RS.movenext;将记录指针从当前的位置向下移一行
WEnd
$RS.Close;关闭记录集对象
_ArrayDisplay($Select_Db, "数据库所有库属性");显示数组

#cs    查询数据的时候，如果不指定要操作的数据库，还可以使用下面的方法。具体区别就在于查询的sql语句上，想多了解的朋友可以看一下下面的代码
$RS = ObjCreate("ADODB.Recordset");创建记录集对象
$RS.ActiveConnection = $conn;设置记录集的激活链接属性来自$Conn
$RS.Open("Select * from Master.dbo.sysdatabases ORDER BY Name");执行Sql语句
Dim $Select_Db[1][1] = [[0]];定义一个数组来接收查询到的数据
Dim $Count = 1;定义一个变量用来记录查询到的数据行数
While Not $RS.eof And Not $RS.bof;当记录指针处于第一条记录和最后一条记录之间时，执行while循环
        If @error = 1 Then ExitLoop
        If $Select_Db[0][0] = 0 Then;当数组二维$Select_Db[0][0]为0时，重定义数组的第二维大小等于记录集查询到的字段数
                ReDim $Select_Db[1][$RS.Fields.Count + 1];$RS.Fields.Count为记录集查询到的字段数
                For $i = 0 To $RS.Fields.Count - 1
                        $Select_Db[0][$i + 1] = $RS.Fields($i).Name;$RS.Fields($i).Name为字段名，把字段名存入数组
                Next
        EndIf
        ReDim $Select_Db[$Count + 1][$RS.Fields.Count + 1];数组第一维大小加1，用于存放数据
        $Select_Db[0][0] = $Count;$Select_Db[0][0]存放查询到的数据行数
        For $i = 0 To $RS.Fields.Count - 1
                $Select_Db[$Count][$i + 1] = $RS.Fields($i).Value;$RS.Fields($i).Value字段数据
        Next
        $Count += 1;行数加1
        $RS.movenext;将记录指针从当前的位置向下移一行
WEnd
$RS.close;关闭记录集
_ArrayDisplay($Select_Db);显示数组
#ce

;~ 知道如何读取数据后，再来试试写入数据，不过为了不破坏master系统库的数据，在此之前我们来创建一个测试表test
$Conn.Execute("use master");首先依旧是先指定要操作的库
$Conn.Execute("CREATE TABLE test(F_id int identity(1, 1) primary key,Name varchar(50),Tel char(50))");执行建表的sql语句
;上面的sql语句，在test表中创建了三个字段int型的F_id、varchar型的Name、char型的Tel，其中F_id被定义为主键，且启用了标识
$read = ReabTableDb($conn, "select * from dbo.sysobjects where OBJECTPROPERTY(id, N'IsUserTable') = 1 ORDER BY Name")
_ArrayDisplay($read, "Test表建立后操作库所有的表名称")

;test表建立后，我们就可以来测试写入数据了。看下面的代码，给Name字段写入张三，Tel字段写入13911931773
$Conn.Execute("insert into test (Name,Tel) values ('张三','13911931773')")
$read = ReabTableDb($conn, "Select * from test")
_ArrayDisplay($read, "Test表写入张三")
;再写入李四 13614441525
$Conn.Execute("insert into test (Name,Tel) values ('李四','13614441525')")
$read = ReabTableDb($conn, "Select * from test")
_ArrayDisplay($read, "Test表写入李四")
;再写入王五 13000074125
$Conn.Execute("insert into test (Name,Tel) values ('王五','13000074125')")
$read = ReabTableDb($conn, "Select * from test")
_ArrayDisplay($read, "Test表写入王五")
;从上面执行建表和写入数据可以看出，因为不需要获取数据，所以我们没有建立记录集


;成功写入数据后，我们来尝试更新数据。看下面的代码，把张三的Tel字段数据从13911931773改成119
$Conn.Execute("UPDATE test set Tel = '119' WHERE Name = '张三'")
$read = ReabTableDb($conn, "Select * from test")
_ArrayDisplay($read, "Test表更新张三")
;上面是有条件修改，我们再试试无条件修改。把Tel字段的所有数据改成9个0
$Conn.Execute("UPDATE test set Tel = '000000000'")
$read = ReabTableDb($conn, "Select * from test")
_ArrayDisplay($read, "Test表更新所有")


;更新数据后，再试试删除数据。首先删除张三
$Conn.Execute("DELETE FROM test WHERE Name = '张三'")
$read = ReabTableDb($conn, "Select * from test")
_ArrayDisplay($read, "Test表删除张三")
;再来删除test表的全部数据
$Conn.Execute("DELETE FROM test")
$read = ReabTableDb($conn, "Select * from test")
_ArrayDisplay($read, "Test表删除所有")


;既然可以清理表中的数据，那当然要试试删除表了。我们来把刚才建立的Test表删掉
$Conn.Execute("DROP TABLE test")
$read = ReabTableDb($conn, "select * from dbo.sysobjects where OBJECTPROPERTY(id, N'IsUserTable') = 1 ORDER BY Name")
_ArrayDisplay($read, "Test表删除后操作库所有的表名称")


$Conn.Close;所有的操作都结束后，关闭数据库连接



#cs 结束语
        乱七八糟的写了一大通，果然不出乎意料，烂的可以。不过权当抛砖引玉好了，希望高手能多写点好的教程出来。
        通过上面的一大堆例子，其实不难看出，使用Au3操作数据库的话，真正考验的还是对sql脚本的熟悉。
        写不出sql语句的话，那想干点什么恐怕会比较麻烦。不过还有百度和谷歌，所以我们还可以加油！
        -By Crossdoor 2010-05-07
#ce



Func ReabTableDb($conn, $Sql);读取数据
        $RS = ObjCreate("ADODB.Recordset");创建记录集对象
        $RS.ActiveConnection = $conn;设置记录集的激活链接属性来自$Conn
        $RS.Open($Sql);执行Sql语句
        Dim $Select_Db[1][1] = [[0]];定义一个数组来接收查询到的数据
        Dim $Count = 1;定义一个变量用来记录查询到的数据行数
        While Not $RS.eof And Not $RS.bof;当记录指针处于第一条记录和最后一条记录之间时，执行while循环
                If @error = 1 Then ExitLoop
                If $Select_Db[0][0] = 0 Then;当数组二维$Select_Db[0][0]为0时，重定义数组的第二维大小等于记录集查询到的字段数
                        ReDim $Select_Db[1][$RS.Fields.Count + 1];$RS.Fields.Count为记录集查询到的字段数
                        For $i = 0 To $RS.Fields.Count - 1
                                $Select_Db[0][$i + 1] = $RS.Fields($i).Name;$RS.Fields($i).Name为字段名，把字段名存入数组
                        Next
                EndIf
                ReDim $Select_Db[$Count + 1][$RS.Fields.Count + 1];数组第一维大小加1，用于存放数据
                $Select_Db[0][0] = $Count;$Select_Db[0][0]存放查询到的数据行数
                For $i = 0 To $RS.Fields.Count - 1
                        $Select_Db[$Count][$i + 1] = $RS.Fields($i).Value;$RS.Fields($i).Value字段数据
                Next
                $Count += 1;行数加1
                $RS.movenext;将记录指针从当前的位置向下移一行
        WEnd
        $RS.Close;关闭记录集对象
        Return $Select_Db
EndFunc

Func ODBCJET_ErroHandler();Com对象错误信息收集函数
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