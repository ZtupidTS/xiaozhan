$Folder = FileSelectFolder('请选择文件夹', '')
If @error Then Exit MsgBox(48, '', '没有选择文件夹')
Msgbox(0, '路径', $Folder)
;GuiCtrlSetData($Input, $Folder)