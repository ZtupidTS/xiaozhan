$Folder = FileSelectFolder('��ѡ���ļ���', '')
If @error Then Exit MsgBox(48, '', 'û��ѡ���ļ���')
Msgbox(0, '·��', $Folder)
;GuiCtrlSetData($Input, $Folder)