Dim $title[22]
$kong1 = "����������������������������������������"
$x = 20
$title[$x] = $kong1 & '������������'
$run = Run("notepad.exe")
WinWait("�ޱ��� - ���±�")
WinSetTitle("�ޱ��� - ���±�", "", $title[$x])

While 1
        If Not ProcessExists($run) Then ExitLoop
        $x = $x - 1
        $kong1 = StringTrimRight($kong1, 1)
        $kong = StringTrimRight($kong1, 1) & '������������'
        $title[$x] = $kong
        WinSetTitle($title[$x + 1], "", $title[$x])
        If $x = 0 Then
                $kong1 = "����������������������������������������"
                $title[$x + 20] = $title[$x]
                $x = 20
        EndIf
        Sleep(300)
WEnd