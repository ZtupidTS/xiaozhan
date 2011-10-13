#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("写MAC和序列号(参数)", 328, 505, 751, 231)
$Group1 = GUICtrlCreateGroup("写序列号", 24, 16, 280, 161)
$Label1 = GUICtrlCreateLabel("title", 60, 45, 44, 17)
$Input1 = GUICtrlCreateInput("0", 104, 40, 97, 21)
$Label2 = GUICtrlCreateLabel("例子(0)", 215, 45, 44, 17)
$Label3 = GUICtrlCreateLabel("title1", 56, 76, 36, 17)
$Input2 = GUICtrlCreateInput("", 104, 72, 97, 21)
$Label4 = GUICtrlCreateLabel("例子(3001001)", 215, 77, 80, 17)
$Label5 = GUICtrlCreateLabel("title2", 56, 110, 36, 17)
$Input3 = GUICtrlCreateInput("120816", 104, 104, 97, 21)
$Label6 = GUICtrlCreateLabel("例子(120816)", 215, 109, 80, 17)
$Label7 = GUICtrlCreateLabel("title3", 56, 141, 36, 17)
$Input4 = GUICtrlCreateInput("", 104, 136, 97, 21)
$Label8 = GUICtrlCreateLabel("例子(02)", 215, 141, 50, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("写MAC", 24, 192, 280, 258)
$Label9 = GUICtrlCreateLabel("title4", 56, 221, 44, 17)
$Input5 = GUICtrlCreateInput("000f09", 104, 216, 97, 21)
$Label10 = GUICtrlCreateLabel("例子(000f09)", 215, 221, 80, 17)
$Label11 = GUICtrlCreateLabel("title5", 56, 253, 44, 17)
$Input6 = GUICtrlCreateInput("", 104, 248, 97, 21)
$Label12 = GUICtrlCreateLabel("例子(0)", 215, 253, 44, 17)
$Label13 = GUICtrlCreateLabel("title6", 56, 285, 44, 17)
$Input7 = GUICtrlCreateInput("", 104, 280, 97, 21)
$Label14 = GUICtrlCreateLabel("例子(0)", 215, 285, 44, 17)
$Label15 = GUICtrlCreateLabel("title7", 56, 318, 44, 17)
$Input8 = GUICtrlCreateInput("", 104, 312, 97, 21)
$Label16 = GUICtrlCreateLabel("例子(0)", 215, 317, 44, 17)
$Label17 = GUICtrlCreateLabel("title8", 56, 350, 44, 17)
$Input9 = GUICtrlCreateInput("", 104, 344, 97, 21)
$Label18 = GUICtrlCreateLabel("例子(0)", 215, 349, 44, 17)
$Label19 = GUICtrlCreateLabel("title9", 56, 381, 44, 17)
$Input10 = GUICtrlCreateInput("", 104, 376, 97, 21)
$Label20 = GUICtrlCreateLabel("例子(0)", 215, 381, 44, 17)
$Label21 = GUICtrlCreateLabel("title10", 50, 413, 44, 17)
$Input11 = GUICtrlCreateInput("", 104,408,97, 21)
$Label22 = GUICtrlCreateLabel("例子(0)", 215, 413, 50, 17)

GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button1 = GUICtrlCreateButton("确定", 48, 465, 97, 25)
$Button2 = GUICtrlCreateButton("取消", 190, 465, 97, 25)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###


While 1
 
  $msg = GUIGetMsg()
  Select
	Case $msg = $GUI_EVENT_CLOSE
    ExitLoop
Case $msg = $Button2
	Exit
   Case $msg = $Button1
    IniWrite(@scriptdir & "\序列号和MAC.ini", "title","title", GUICtrlRead ($Input1))
	IniWrite(@scriptdir & "\序列号和MAC.ini", "title1", "title1", GUICtrlRead ($Input2))	
	IniWrite(@scriptdir & "\序列号和MAC.ini", "title2", "title2", GUICtrlRead ($Input3))	
	IniWrite(@scriptdir & "\序列号和MAC.ini", "title3", "title3", GUICtrlRead ($Input4))	
	IniWrite(@scriptdir & "\序列号和MAC.ini", "title4","title4", GUICtrlRead ($Input5))
	IniWrite(@scriptdir & "\序列号和MAC.ini", "title5", "title5", GUICtrlRead ($Input6))	
	IniWrite(@scriptdir & "\序列号和MAC.ini", "title6", "title6", GUICtrlRead ($Input7))		
	IniWrite(@scriptdir & "\序列号和MAC.ini", "title7", "title7", GUICtrlRead ($Input8))	;
	IniWrite(@scriptdir & "\序列号和MAC.ini", "title8", "title8", GUICtrlRead ($Input9)) ;	
	IniWrite(@scriptdir & "\序列号和MAC.ini", "title9", "title9", GUICtrlRead ($Input10));
	IniWrite(@scriptdir & "\序列号和MAC.ini", "title10", "title10", GUICtrlRead ($Input11))
   ; Will Run/Open Notepad
    ExitLoop
  EndSelect
 WEnd


#cs
[title]
title=0
[title1]
title1=3001002
[title2]
title2=120816
[title3]
title3=10
[title4]
title4=000f09
[title5]
title5=5
[title6]
title6=5
[title7]
title7=5
[title8]
title8=5
[title9]
title9=5
[title10]
title10=5
#ce