#include <ScreenCapture.au3>
#include <Misc.au3>
#include-once
HotKeySet("{ESC}", "Terminate")

$hDll = DllOpen("gdi32.dll")
$vDC = _PixelGetColor_CreateDC($hDll)
$vRegion = _PixelGetColor_CaptureRegion($vDC, 0,0,@DesktopWidth,@DesktopHeight,$hDll)
;点击鼠标左键退出。
While Not _IsPressed(0x01)
    $aPos = MouseGetPos()
    $sColor = _PixelGetColor_GetPixel($vDC, $aPos[0],$aPos[1], $hDll)

    ToolTip("鼠标下的颜色是: " & $sColor, $aPos[0]+3, $aPos[1]+3, "数据由 _PixelGetColor_GetPixel 函数返回",$hDll)
WEnd
_PixelGetColor_ReleaseRegion($vRegion)
_PixelGetColor_ReleaseDC($vDC,$hDll)
DllClose($hDll)

; #子函数# ;===============================================================================
;
; 函数名.........: _PixelGetColor_CreateDC
; 作用 ..........: 创建一个DC供另外的函数 _PixelGetColor 使用。
; 用法...........: _PixelGetColor_CreateDC()
; 参数 ..........: 无.
; 返回数据..... .: 成功 - 返回一个公用的DC 句柄指针.
;                  失败 - 返回0并将@error 设置成DLLCALL返回的@error值.
; 作者？ ........: Jos van Egmond
; Modified.......:
; 修改    .......:
; 相关函数.......: _PixelGetColor_CaptureRegion, _PixelGetcolor_GetPixel, _PixelGetColor_GetPixelRaw, _PixelGetColor_ReleaseRegion, _PixelGet_Color_ReleaseDC
; 例子    .......; 无
;
; ;==========================================================================================
Func _PixelGetColor_CreateDC($hDll = "gdi32.dll")
        $iPixelGetColor_MemoryContext = DllCall($hDll, "int", "CreateCompatibleDC", "int", 0)
        If @error Then Return SetError(@error,0,0)
        Return $iPixelGetColor_MemoryContext[0]
EndFunc

; #FUNCTION# ;===============================================================================
;
; 函数名.......: _PixelGetColor_CaptureRegion
; 作用 ........: 抓取用户定义的一个区域并将之放置到一个内存DC中.
; 用法.........: _PixelGetColor_CaptureRegion($iPixelGetColor_MemoryContext, $iLeft = 0, $iTop = 0, $iRight = -1, $iBottom = -1, $fCursor = False)
; 参数 ....: $iPixelGetColor_MemoryContext        - 由函数 _PixelGetColor_CreateDC 返回的DC
;            $iLeft           - 用户定义的矩形区域的左边
;            $iTop            - 用户定义的矩形区域的上边
;            $iRight          - 用户定义的矩形区域的右边
;            $iBottom         - 用户定义的矩形区域的底部
;            $iCursor         - 如果这个值是TRUE, 那么鼠标也会被抓取到内存中。
; 返回数据 .: 成功 - 返回矩形区域的HANDLE（句柄）.
;             失败 - 
; 作者 ........: Jos van Egmond
; Modified.......:
; 修改 ..........:
; 相关函数 ......: _PixelGet_Color_CreateDC, _PixelGetcolor_GetPixel, _PixelGetColor_GetPixelRaw, _PixelGetColor_ReleaseRegion, _PixelGet_Color_ReleaseDC
; 例子    .......; 无
;
; ;==========================================================================================
Func _PixelGetColor_CaptureRegion($iPixelGetColor_MemoryContext, $iLeft = 0, $iTop = 0, $iRight = -1, $iBottom = -1, $fCursor = False, $hDll = "gdi32.dll")
        $HBITMAP = _ScreenCapture_Capture("", $iLeft, $iTop, $iRight, $iBottom, $fCursor)
        DllCall($hDll, "hwnd", "SelectObject", "int", $iPixelGetColor_MemoryContext, "hwnd", $HBITMAP)
        Return $HBITMAP
EndFunc

; #FUNCTION# ;===============================================================================
;
; 函数名...........: _PixelGetColor_GetPixel
; 作用 ...: 从DC句柄读取一个坐标的10进制BGR格式的颜色值然后将之转换成6位16进制的RGB格式的颜色值.
; 用法.........: _PixelGetColor_GetPixel($iPixelGetColor_MemoryContext,$iX,$iY)
; 参数 ....: $iPixelGetColor_MemoryContext        - 由函数 _PixelGetColor_CreateDC 返回的DC句柄
;            $iX                - 抓取点的X坐标
;            $iY                - 抓取点的Y坐标
; 返回数据 .: 成功 - 返回6位16进制RGB格式的颜色值.
;             失败 - 返回-1并将@error设置为 1.
; 作者 ........: Jos van Egmond
; Modified.......:
; 修改 ..........:
; 相关函数 ......: _PixelGetColor_CreateDC, _PixelGetColor_CaptureRegion, _PixelGetColor_GetPixelRaw, _PixelGetColor_ReleaseRegion, _PixelGet_Color_ReleaseDC
; 例子    .......; 是
;
; ;==========================================================================================
Func _PixelGetColor_GetPixel($iPixelGetColor_MemoryContext,$iX,$iY, $hDll = "gdi32.dll")
        $iColor = DllCall($hDll,"int","GetPixel","int",$iPixelGetColor_MemoryContext,"int",$iX,"int",$iY)
        If $iColor[0] = -1 then Return SetError(1,0,-1)
        $sColor = Hex($iColor[0],6)
        Return StringRight($sColor,2) & StringMid($sColor,3,2) & StringLeft($sColor,2)
EndFunc

; #FUNCTION# ;===============================================================================
;
; 函数名...........: _PixelGetColor_GetPixelRaw
; 作用 ...: 从DC句柄中获取一个点的10进制BGR格式的颜色值.
; 用法.........: _PixelGetColor_GetPixelRaw($iPixelGetColor_MemoryContext,$iX,$iY)
; 参数 ....: $iPixelGetColor_MemoryContext        - 函数_PixelGetColor_CreateDC返回的DC句柄
;            $iX                - 抓取点的X坐标
;            $iY                - 抓取点的Y坐标
; 返回数据 .: 成功 - 返回10进制BGR格式的颜色.
;             失败 - 返回-1并将@error设置为 1.
; 作者 ........: Jos van Egmond
; Modified.......:
; 修改 ..........:
; 相关函数.......: _PixelGetColor_CreateDC, _PixelGetColor_CaptureRegion, _PixelGetColor_GetPixel, _PixelGetColor_ReleaseRegion, _PixelGet_Color_ReleaseDC
; 例子.......; 无
;
; ;==========================================================================================
Func _PixelGetColor_GetPixelRaw($iPixelGetColor_MemoryContext,$iX,$iY, $hDll = "gdi32.dll")
        $iColor = DllCall($hDll,"int","GetPixel","int",$iPixelGetColor_MemoryContext,"int",$iX,"int",$iY)
        Return $iColor[0]
EndFunc

; #FUNCTION# ;===============================================================================
;
; 函数名...........: _PixelGetColor_ReleaseRegion
; 作用 ...: 释放一个被_PixelGetColor_CaptureRegion函数创建的选区 
; 用法.........: _PixelGetColor_ReleaseRegion($HBITMAP)
; 参数 ....: $HBITMAP - 由函数 _PixelGetColor_CaptureRegion 创建的区域
; 返回数据.: 无.
; 作者 ........: Jos van Egmond
; Modified.......:
; 修改 ..........:
; 相关函数. .......: _PixelGetColor_CreateDC, _PixelGetColor_CaptureRegion, _PixelGetcolor_GetPixel, _PixelGetColor_GetPixelRaw, _PixelGet_Color_ReleaseDC
; 例子.......; 无
;
; ;==========================================================================================
Func _PixelGetColor_ReleaseRegion($HBITMAP)
        _WinAPI_DeleteObject($HBITMAP)
EndFunc

; #FUNCTION# ;===============================================================================
;
; 函数名..........: _PixelGetColor_ReleaseDC
; 作用 ...: 释放一个由 _PixelGetColor_CreateDC函数创建的DC句柄
; 用法.........: _PixelGetColor_ReleaseDC($iPixelGetColor_MemoryContext)
; 参数  ....: $iPixelGetColor_MemoryContext - 由_PixelGetColor_CreateDC函数创建的内存指针
; 返回数据 .: 无.
; 作者 ........: Jos van Egmond
; Modified.......:
; 修改 ..........:
; 相关函数. .......: _PixelGetColor_CreateDC, _PixelGetColor_CaptureRegion, _PixelGetcolor_GetPixel, _PixelGetColor_GetPixelRaw, _PixelGetColor_ReleaseRegion
; 例子.......; 无
;
; ;==========================================================================================
Func _PixelGetColor_ReleaseDC($iPixelGetColor_MemoryContext, $hDll = "gdi32.dll")
        DllCall($hDll, "int", "DeleteDC", "hwnd", $iPixelGetColor_MemoryContext)
	EndFunc
	
Func Terminate()
    Exit 0
EndFunc