#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=chinaz4.ico
#AutoIt3Wrapper_outfile=���ݿ����.exe
#EndRegion ;**** ���������� ACNWrapper_GUI ****
;#AutoIt3Wrapper_au3check_parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <ListViewConstants.au3>
#include <WindowsConstants.au3>
#include <access.au3>
#include <GuiListView.au3>;�����������й�
Opt("TrayIconDebug", 1)
Dim $xinxi, $name, $T, $Address, $BuyTime, $s, $xulie, $strn, $Strnspin,$gaibugai
$gaibugai = 0
$xinxi = 0
$dushu = 1
$xulie = 0
$mdb_data_path = "sky.mdb"
$mdb_data_pwd = "crt123456"
$name = "����"
$Telephone = "�绰"
$Address = "��ַ"
$BuyTime = "����ʱ��"
$Frequency = "����"
$Sdata = "ά������"
$Staff = "��Ա"
$_error = "����"
$T = "*"
$tblname = "tywb"
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("ά�޼�¼���ݿ���ײ����鿴��By lovexia", 633, 454, -1, -1)
$ListView1 = GUICtrlCreateListView("", 8, 24, 617, 361, $LVS_SINGLESEL)
_GUICtrlListView_AddColumn($ListView1, "ID", 25)
_GUICtrlListView_AddColumn($ListView1, "����", 36)
_GUICtrlListView_AddColumn($ListView1, "��ϵ�绰", 72)
_GUICtrlListView_AddColumn($ListView1, "��ϵ��ַ", 72)
_GUICtrlListView_AddColumn($ListView1, "����ʱ��", 72)
_GUICtrlListView_AddColumn($ListView1, "ά�޴���", 72)
_GUICtrlListView_AddColumn($ListView1, "ά������", 72)
_GUICtrlListView_AddColumn($ListView1, "ά����Ա", 72)
_GUICtrlListView_AddColumn($ListView1, "����ԭ��", 72)
_GUICtrlListView_JustifyColumn($ListView1, 0, 2)
_GUICtrlListView_JustifyColumn($ListView1, 1, 2)
_GUICtrlListView_JustifyColumn($ListView1, 2, 2)
_GUICtrlListView_JustifyColumn($ListView1, 3, 2)
_GUICtrlListView_JustifyColumn($ListView1, 4, 2)
_GUICtrlListView_JustifyColumn($ListView1, 5, 2)
_GUICtrlListView_JustifyColumn($ListView1, 6, 2)
_GUICtrlListView_JustifyColumn($ListView1, 7, 2)
_GUICtrlListView_JustifyColumn($ListView1, 8, 2)
;_GUICtrlListView_SetColumnWidth($ListView1,0,$LVSCW_AUTOSIZE_USEHEADER)
$Button0 = GUICtrlCreateButton("�������ݿ�(&C)", 50, 408, 100, 25, 0)
$Button1 = GUICtrlCreateButton("��������(&Q)", 150, 408, 80, 25, 0)
$Button2 = GUICtrlCreateButton("��������(&S)", 230, 408, 80, 25, 0)
$Button3 = GUICtrlCreateButton("ɾ������(&D)", 390, 408, 80, 25, 0);280, 408, 113, 25, 0)
$Button4 = GUICtrlCreateButton("��ȡ����(&A)", 310, 408, 80, 25, 0)
$button5 = GUICtrlCreateButton("�����û�(&F)", 470, 408, 80, 25, 0)
GUISetState(@SW_SHOW)

GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY");<<<<<<<<<+++��������������ˡ�������̫����
Global $B_DESCENDING[_GUICtrlListView_GetColumnCount($ListView1)];<<<<<<<<<+++��ȡ�еĸ���
#EndRegion ### END Koda GUI section ###
If FileExists('sky.mdb') = 1 Then du()

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $Button0
			data($mdb_data_path, $tblname)
		Case $Button1;����
			sx()
			$xulie = $Strnspin[1] -1
			du()
		Case $Button2 ;����
			$xinxi = 0
			up()
			If $gaibugai = 1 Then du()

		Case $Button3 ;ɾ��
			del()
			du()

		Case $Button4 ;��ȡ

			du()



		Case $button5
			$find = InputBox("��ѯ", "��������Ҫ��ѯ������.", "", "", 40, 40, @DesktopWidth / 2 - 100, @DesktopHeight / 2 - 120, -1, $Form1)
			If @error = 1 Then ContinueLoop
			If $find = "" Then
				MsgBox(64, "��ʾ��", "û�йؼ��ʡ�", -1, $Form1)
				ContinueLoop
			EndIf

			If MsgBox(1, "", "��Ҫ���ҵ��ǣ�" & $find, -1, $Form1) = 2 Then ContinueLoop

			$adSource = @ScriptDir & "\sky.mdb"
			$adTable = "tywb"
			$adCol = "name"
			;$Find = ""
			$adFull = 1
			$yo = _accessQueryLike($adSource, $adTable, $adCol, $find, $adFull)
			If IsArray($yo) Then
				For $s = 1 To $yo[0]
					$aRecord = StringSplit($yo[$s], Chr(28))
					;_ArrayDisplay($aRecord, "ÿ��ֵ")
					If MsgBox(1, "�Ѿ��ҵ�", "ID�ţ�" & $aRecord[1] & @CRLF _;������ʾ�� ����
							 & "������" & $aRecord[2] & @CRLF _
							 & "�ֻ��ţ�" & $aRecord[3] & @CRLF _
							 & "��ַ��" & $aRecord[4] & @CRLF _
							 & "���ڣ�" & $aRecord[5] & @CRLF _
							 & "ά�޴�����" & $aRecord[6] & @CRLF _
							 & "ά�����ڣ�" & $aRecord[7] & @CRLF _
							 & "ά����Ա��" & $aRecord[8] & @CRLF _
							 & "����ԭ��" & $aRecord[9], -1, $Form1) = 2 Then
						$xulie = $aRecord[1]
						;MsgBox(0,'��XU',$xulie & "ID��:"& $arecord[1])
						ExitLoop
					EndIf
				Next
				$xulie = $aRecord[1] - 1
				;MsgBox(0,'��XU',$xulie & "ID��:"& $arecord[1])
				du()

			EndIf
	EndSwitch
WEnd




Func du()


	GUICtrlSendMsg($ListView1, $LVM_DELETEALLITEMS, 0, 0)
	$addfld = ObjCreate("ADODB.Connection")
	$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $mdb_data_path)
	$RS = ObjCreate("ADODB.Recordset")
	$RS.ActiveConnection = $addfld
	$RS.Open("Select " & $T & " From " & $tblname)
	While Not $RS.eof And Not $RS.bof
		If @error = 1 Then ExitLoop
		GUICtrlCreateListViewItem(StringRegExpReplace($RS.Fields(0).value, '\s+', '') & "|" & StringRegExpReplace($RS.Fields(1).value, '\s+', '') & "|" & StringRegExpReplace($RS.Fields(2).value, '\s+', '') & "|" & StringRegExpReplace($RS.Fields(3).value, '\s+', '') & "|" & StringRegExpReplace($RS.Fields(4).value, '\s+', '') & "|" & StringRegExpReplace($RS.Fields(5).value, '\s+', '') & "|" & StringRegExpReplace($RS.Fields(6).value, '\s+', '') & "|" & StringRegExpReplace($RS.Fields(7).value, '\s+', '') & "|" & StringRegExpReplace($RS.Fields(8).value, '\s+', ''), $ListView1)

		;MsgBox(0, "", $RS.Fields (1).value);��ʾ���һ������
		$RS.movenext
	WEnd
	$RS.close
	$addfld.Close
	;For $i = 0 To _GUICtrlListView_GetColumnCount($ListView1) ; �б�ĸ���
	;_GUICtrlListView_SetColumnWidth($ListView1,$i,$LVSCW_AUTOSIZE);�����п��Զ���Ӧ����
	;Next
	If $dushu = 1 Then
		_GUICtrlListView_SetColumnWidth($ListView1, 0, $LVSCW_AUTOSIZE)
		_GUICtrlListView_SetColumnWidth($ListView1, 1, 50)
		_GUICtrlListView_SetColumnWidth($ListView1, 2, $LVSCW_AUTOSIZE)
		_GUICtrlListView_SetColumnWidth($ListView1, 3, $LVSCW_AUTOSIZE)
		_GUICtrlListView_SetColumnWidth($ListView1, 4, $LVSCW_AUTOSIZE)
		_GUICtrlListView_SetColumnWidth($ListView1, 5, 75)
		_GUICtrlListView_SetColumnWidth($ListView1, 6, 85)
		_GUICtrlListView_SetColumnWidth($ListView1, 7, 75)
		_GUICtrlListView_SetColumnWidth($ListView1, 8, 85)
		
		$dushu = 0
	EndIf
	Dim $ii
	
	GUICtrlSetState($ListView1, $GUI_FOCUS)

	;If StringIsInt( $xulie / 10 ) = 1 Then $xulie = $xulie -1
	; MsgBox(0,"",StringInStr($xulie,0) & $xulie)

	$ii = _GUICtrlListView_FindText($ListView1, $xulie + 1);;;;;;;;;;;;��Ҹ���������;;;;;;;;;;;;;;;;;;;
	;MsgBox(4160, "�õ���λ�� ", $iI)
	_GUICtrlListView_EnsureVisible($ListView1, $ii);����ͼ�����ɼ�λ��
	_GUICtrlListView_SetItemSelected($ListView1, $ii) ;��$xulie�����

EndFunc   ;==>du

Func del()
	_GUICtrlListView_BeginUpdate($ListView1)

	$strn = GUICtrlRead(GUICtrlRead($ListView1))
	$Strnspin = StringSplit($strn, "|")
	$addfld = ObjCreate("ADODB.Connection")
	$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $mdb_data_path)
	$sQuery = "DELETE FROM " & $tblname & " IN '" & $mdb_data_path & "' WHERE id" & " = " & $Strnspin[1]
	; MsgBox(0,"",$sQuery)
	$addfld.execute($sQuery)
	$addfld.close
	_GUICtrlListView_EndUpdate($ListView1)
	;MsgBox(4096, "��ʾ:",$Strnspin[1]&"    ɾ���ɹ�!!!")

EndFunc   ;==>del


Func up()
	Global $_Quantity[100], $_File_INI, $_ID

	$strn = GUICtrlRead(GUICtrlRead($ListView1))
	;MsgBox(0,"",$strn)
	;$_FileId = FileOpenDialog('ѡ��ͻ�����,���ó���100���ļ�',@DesktopDir & '/�ͻ���Ϣ',"�����ļ� (*.Ini;*.Txt)",1,"",$Form1)

	_Newwindow()
	If $xinxi = 1 Then Return

	$_SQL = "name = '" & $name & "',address = '" & $Address & "' ,Telephone = '" & $Telephone & "',buyTime = '" & $BuyTime & "',Frequency = '" & $Frequency & "', " & "staff = '" & $Staff & "'," & "error = '" & $_error
	;MsgBox(0,"",$strn &@CRLF & $_SQL)
	$Strnspin = StringSplit($strn, "|")
	$addfld = ObjCreate("ADODB.Connection")
	$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $mdb_data_path)
	$sQuery = "update " & $tblname & " set " & $_SQL & "' WHERE id" & " = " & $Strnspin[1]
	;MsgBox(0,"",$sQuery)
	$addfld.execute($sQuery)
	$addfld.close
	;MsgBox(4096, "��ʾ:",$Strnspin[1]&"    ���³ɹ�!!!")
EndFunc   ;==>up


Func sx()
	$strn = GUICtrlRead(GUICtrlRead($ListView1))
	;If $strn = 0 Then Return
	$Strnspin = StringSplit($strn, "|")
	$_sbs = FileExists('sky.mdb')
	While $_sbs = 0
		If MsgBox(4 + 32, "��ʾ��", "�ⲻ���ڣ��Ƿ��½���") = 6 Then
			data($mdb_data_path, $tblname)
			$_sbs = 1
			Return
		Else
			Exit
		EndIf
	WEnd
	Global $_Quantity[100], $_File_INI, $_ID
	$_FileId = FileOpenDialog('ѡ��ͻ�����,���ó���100���ļ�', @DesktopDir & '/�ͻ���Ϣ', "�����ļ� (*.Ini;*.Txt)", 1 + 4, "", $Form1)
	If @error = 1 Then Return
	$_Quantity = StringSplit($_FileId, "|")
	If $_Quantity[0] = 1 Then;���ֻ��ѡ��һ���ļ��� ����Ϊ 2 ���� ����Ϊ 1
		$_ID = 1
	Else
		$_ID = 2
	EndIf

	$addfld = ObjCreate("ADODB.Connection")
	$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & $mdb_data_path & ";Jet Oledb:Database Password=" & $mdb_data_pwd)
	For $_File_INI = $_ID To $_Quantity[0];���㹲ѡ���˼����ļ�!
		;MsgBox(0,"",$_ID & "    " & $_Quantity[0])
		$name = IniRead($_Quantity[$_File_INI], "�ͻ���Ϣ", "����", "*δ����ָ������*")
		$Telephone = IniRead($_Quantity[$_File_INI], "�ͻ���Ϣ", "��ϵ�绰", "*δ����ָ������*")
		$Address = IniRead($_Quantity[$_File_INI], "�ͻ���Ϣ", "��ϵ��ַ", "*δ����ָ������*")
		$BuyTime = IniRead($_Quantity[$_File_INI], "�ͻ���Ϣ", "����ʱ��", "*δ����ָ������*")
		$Frequency = IniRead($_Quantity[$_File_INI], "ά�޼�¼", "����", ">o<")
		$Sdata = IniRead($_Quantity[$_File_INI], "ά�޼�¼", "����", ">o<")
		$Staff = IniRead($_Quantity[$_File_INI], "ά�޼�¼", "Ա��", ">o<")
		$_error = IniRead($_Quantity[$_File_INI], "ά�޼�¼", "����", ">o<")
		;;;���ﻹҪ�Ķ�һ�¡� ��INput�Ԥ��д��ԭ�������ݡ� ֻҪ��һ��Ҫ�Ķ������� ���Ϳ���ȷ���ˡ�

		$addfld.Execute("insert into tywb (name,Telephone,Address,BuyTime,Frequency,Sdata,staff,error) values('" & $name & "','" & $Telephone & "','" & $Address & "','" & $BuyTime & "','" & $Frequency & "','" & $Sdata & "','" & $Staff & "','" & $_error & "')")
	Next



	; $conn.Execute("insert into tywb (name,Telephone,Address,BuyTime) values('"&$name&"','"&$Telephone&"','"&$Address&"','"&$BuyTime&"')")
	;  $RS.close
	$addfld.close
	
	;MsgBox(4096, "��ʾ:"," �ɹ�д�����ݿ⣡")
EndFunc   ;==>sx

Func data($mdb_data_path, $tblname)
	If Not FileExists($mdb_data_path) Then
		$newMdb = ObjCreate("ADOX.Catalog")
		$newMdb.Create("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $mdb_data_path)
		$newMdb.ActiveConnection.Close;�����ݿ�
		$addtbl = ObjCreate("ADODB.Connection")
		$addtbl.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $mdb_data_path)
		$addtbl.Execute("CREATE TABLE " & $tblname)
		$addtbl.Close;����

		$addfld = ObjCreate("ADODB.Connection")
		$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $mdb_data_path)
		$addfld.Execute("ALTER TABLE " & $tblname & " ADD id identity(1, 1) primary key,name VARCHAR ,Telephone VARCHAR ,Address VARCHAR,BuyTime VARCHAR,Frequency VARCHAR,Sdata VARCHAR,Staff VARCHAR,error VARCHAR");id identity(1, 1) primary keyΪ�Զ���ź�����
		$addfld.Close;���б���;;;;;;VARCHAR �������͡� ����Ĵ�С ��С�ܶࡣ��� cher
		MsgBox(64, "��ʾ", "�������ݿ�ɹ�", 5)
	Else
		MsgBox(64, "��ʾ", "���Ѿ�������һ�����ݿ���", 5)
	EndIf
EndFunc   ;==>data

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam);<<<<<<<<<+++
	#forceref $hWnd, $iMsg, $iwParam
	Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $hWndListView, $tInfo
	$hWndListView = $ListView1
	If Not IsHWnd($ListView1) Then $hWndListView = GUICtrlGetHandle($ListView1)

	$tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $hWndListView
			Switch $iCode
				Case $LVN_COLUMNCLICK ; һ�б����
					$tInfo = DllStructCreate($tagNMLISTVIEW, $ilParam)
					_DebugPrint("$LVN_COLUMNCLICK" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @LF & _
							"-->Code:" & @TAB & $iCode & @LF & _
							"-->Item:" & @TAB & DllStructGetData($tInfo, "Item") & @LF & _
							"-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF & _
							"-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @LF & _
							"-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @LF & _
							"-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @LF & _
							"-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @LF & _
							"-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @LF & _
							"-->Param:" & @TAB & DllStructGetData($tInfo, "Param"))
					_GUICtrlListView_SimpleSort($hWndListView, $B_DESCENDING, DllStructGetData($tInfo, "SubItem"))
					;û�з���ֵ
				Case $LVN_KEYDOWN ; һ����������
					$tInfo = DllStructCreate($tagNMLVKEYDOWN, $ilParam)
					_DebugPrint("$LVN_KEYDOWN" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @LF & _
							"-->Code:" & @TAB & $iCode & @LF & _
							"-->VKey:" & @TAB & DllStructGetData($tInfo, "VKey") & @LF & _
							"-->Flags:" & @TAB & DllStructGetData($tInfo, "Flags"))
					;û�з���ֵ
				Case $NM_CLICK ; ����һ���б���ͼ�ؼ������û��������������Ŀ
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					_DebugPrint("$NM_CLICK" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @LF & _
							"-->Code:" & @TAB & $iCode & @LF & _
							"-->Index:" & @TAB & DllStructGetData($tInfo, "Index") & @LF & _
							"-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF & _
							"-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @LF & _
							"-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @LF & _
							"-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @LF & _
							"-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @LF & _
							"-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @LF & _
							"-->lParam:" & @TAB & DllStructGetData($tInfo, "lParam") & @LF & _
							"-->KeyFlags:" & @TAB & DllStructGetData($tInfo, "KeyFlags"))
					;û�з���ֵ
				Case $NM_DBLCLK ; ����һ���б���ͼ�ؼ������û��������������Ŀ
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					_DebugPrint("$NM_DBLCLK" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @LF & _
							"-->Code:" & @TAB & $iCode & @LF & _
							"-->Index:" & @TAB & DllStructGetData($tInfo, "Index") & @LF & _
							"-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF & _
							"-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @LF & _
							"-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @LF & _
							"-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @LF & _
							"-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @LF & _
							"-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @LF & _
							"-->lParam:" & @TAB & DllStructGetData($tInfo, "lParam") & @LF & _
							"-->KeyFlags:" & @TAB & DllStructGetData($tInfo, "KeyFlags"))
					;û�з���ֵ
				Case $NM_KILLFOCUS ; The control has lost the input focus
					_DebugPrint("$NM_KILLFOCUS" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @LF & _
							"-->Code:" & @TAB & $iCode)
					;û�з���ֵ
				Case $NM_RCLICK ; Sent by a list-view control when the user clicks an item with the right mouse button
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					_DebugPrint("$NM_RCLICK" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @LF & _
							"-->Code:" & @TAB & $iCode & @LF & _
							"-->Index:" & @TAB & DllStructGetData($tInfo, "Index") & @LF & _
							"-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF & _
							"-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @LF & _
							"-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @LF & _
							"-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @LF & _
							"-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @LF & _
							"-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @LF & _
							"-->lParam:" & @TAB & DllStructGetData($tInfo, "lParam") & @LF & _
							"-->KeyFlags:" & @TAB & DllStructGetData($tInfo, "KeyFlags"))
					;Return 1 ; not to allow the default processing
					Return 0 ; ����Ĭ�ϴ���
				Case $NM_RDBLCLK ; Sent by a list-view control when the user double-clicks an item with the right mouse button
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					_DebugPrint("$NM_RDBLCLK" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @LF & _
							"-->Code:" & @TAB & $iCode & @LF & _
							"-->Index:" & @TAB & DllStructGetData($tInfo, "Index") & @LF & _
							"-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF & _
							"-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @LF & _
							"-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @LF & _
							"-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @LF & _
							"-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @LF & _
							"-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @LF & _
							"-->lParam:" & @TAB & DllStructGetData($tInfo, "lParam") & @LF & _
							"-->KeyFlags:" & @TAB & DllStructGetData($tInfo, "KeyFlags"))
					;û�з���ֵ
				Case $NM_RETURN ; The control has the input focus and that the user has pressed the ENTER key
					_DebugPrint("$NM_RETURN" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @LF & _
							"-->Code:" & @TAB & $iCode)
					;û�з���ֵ
				Case $NM_SETFOCUS ; The control has received the input focus
					_DebugPrint("$NM_SETFOCUS" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @LF & _
							"-->Code:" & @TAB & $iCode)
					;û�з���ֵ
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY

Func _DebugPrint($s_text, $line = @ScriptLineNumber)
	ConsoleWrite( _
			"!===========================================================" & @LF & _
			"+======================================================" & @LF & _
			"-->Line(" & StringFormat("%04d", $line) & "):" & @TAB & $s_text & @LF & _
			"+======================================================" & @LF)
EndFunc   ;==>_DebugPrint


Func _Newwindow();�½��û��Ĵ���

	$strn = GUICtrlRead(GUICtrlRead($ListView1))
	If $strn = 0 Then Return
	$Strnspin = StringSplit($strn, "|")
	;MsgBox(0,"",$Strnspin[1] & "   " & $Strnspin[2])

	#Region ### START Koda GUI section ### Form=d:\backup\�ҵ��ĵ�\my music\�½�����.kxf
	$Form2 = GUICreate("��������Ϣ", 474, 193, -1, -1)
	$Label1 = GUICtrlCreateLabel("�û�����", 32, 32, 52, 17, 0)
	$Input1 = GUICtrlCreateInput($Strnspin[2], 96, 30, 121, 21)
	$Label2 = GUICtrlCreateLabel("�û���ַ��", 24, 64, 64, 17, 0)
	$Input2 = GUICtrlCreateInput($Strnspin[3], 96, 62, 121, 21)
	$Label3 = GUICtrlCreateLabel("��ϵ�绰��", 24, 96, 64, 17, 0)
	$Input3 = GUICtrlCreateInput($Strnspin[4], 96, 94, 121, 21)
	$Label4 = GUICtrlCreateLabel("����ʱ�䣺", 24, 128, 64, 17, 0)
	$Input4 = GUICtrlCreateInput($Strnspin[5], 96, 126, 121, 21)
	$Group1 = GUICtrlCreateGroup("�ͻ���Ϣ", 8, 8, 225, 145)

	$Group2 = GUICtrlCreateGroup("ά�޼�¼", 240, 8, 225, 145)
	$Label5 = GUICtrlCreateLabel("ά�����ڣ�", 256, 32, 64, 17)
	$Label6 = GUICtrlCreateLabel("ά�޴�����", 256, 64, 64, 17)
	$Label7 = GUICtrlCreateLabel("ά����Ա��", 256, 96, 64, 17)
	$Label8 = GUICtrlCreateLabel("����ԭ��", 256, 128, 64, 17)
	$Input5 = GUICtrlCreateInput($Strnspin[7], 328, 30, 121, 21)
	$Input6 = GUICtrlCreateInput($Strnspin[6], 328, 62, 121, 21)
	$Input7 = GUICtrlCreateInput($Strnspin[8], 328, 94, 121, 21)
	$Input8 = GUICtrlCreateInput($Strnspin[9], 328, 126, 121, 21)

	$Button6 = GUICtrlCreateButton("ȷ��", 72, 160, 75, 25)
	$Button7 = GUICtrlCreateButton("ȡ��", 304, 160, 75, 25)
	GUISetState(@SW_SHOW, $Form2)
	GUISetState(@SW_HIDE, $Form1)
	#EndRegion ### END Koda GUI section ###


	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				GUISetState(@SW_SHOW, $Form1)
				GUISetState(@SW_HIDE, $Form2)
				$xinxi = 1
				$xulie = $Strnspin[1] -1
				$gaibugai = 0
				ExitLoop

				;Case $Button6;ȡ�õ�ǰ������д��INPUT
				;GUICtrlSetData($input4,@YEAR &"/"& @MON &"/"& @MDAY)

			Case $Button7
				GUISetState(@SW_SHOW, $Form1)
				GUISetState(@SW_HIDE, $Form2)
				$xinxi = 1
				$xulie = $Strnspin[1] -1
				$gaibugai = 0
				ExitLoop

			Case $Button6

				$name = GUICtrlRead($Input1)
				$Address = GUICtrlRead($Input2)
				$Telephone = GUICtrlRead($Input3)
				$BuyTime = GUICtrlRead($Input4)
				$Sdata = GUICtrlRead($Input5)
				$Frequency = GUICtrlRead($Input6)
				$Staff = GUICtrlRead($Input7)
				$_error = GUICtrlRead($Input8)


				#cs
					If $name = "" Or $Address = "" Or $Telephone = "" Or $buyTime = "" Or $Sdata = "" Or $Frequency = "" Or $Staff = "" Or $_error = ""  Then
					MsgBox(64,"��ʾ!","����ѡ��б���!",3,$Form2)
					ContinueLoop
					EndIf
				#ce
				If StringLen($BuyTime) > 10 Then
					MsgBox(64, "����!", "��鿴�����Ƿ�������ȷ!�벻Ҫ����10���ַ�", 3, $Form2)
					ContinueLoop
				EndIf

				GUISetState(@SW_SHOW, $Form1)
				GUISetState(@SW_HIDE, $Form2)
				$xulie = $Strnspin[1] -1
				$gaibugai = 1
				ExitLoop
		EndSwitch
	WEnd
EndFunc   ;==>_Newwindow

#cs
	Func  _SelectData($mdb_data_path,  $tblname,  "158",  $T)
	$addfld  =  ObjCreate("ADODB.Connection")
	
	$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0;  Data  Source="  & $mdb_data_path)
	$RS  =ObjCreate("ADODB.Recordset")
	$RS.ActiveConnection  =  $addfld
	$RS.Open    ("Select  "&$T  &  "  From  "  &  $tblname  )
	msgbox(0,"",$RS.Fields(0).Name)
	msgbox(0,"",$RS.Fields(0).Value)
	
	$addfld.Close
	EndFunc
	����Ļ��� ��Ҫָ��INI�ļ�(Txt�ļ�Ҳ�ɡ� ֻҪ��ʽ�Ծ�����) �� 
����Ϊ��
[�ͻ���Ϣ]

����=sdf
��ϵ��ַ=fffffffffffff
��ϵ�绰=15857sdf
����ʱ��=2010/04/06

[ά�޼�¼]
���� = 1
���� = 2008/09/09
Ա�� = lovexia
���� = ��ëƬ�� �ж��ˣ���

	
#ce