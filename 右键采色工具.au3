#include <ScreenCapture.au3>
#include <Misc.au3>
#include-once
HotKeySet("{ESC}", "Terminate")

$hDll = DllOpen("gdi32.dll")
$vDC = _PixelGetColor_CreateDC($hDll)
$vRegion = _PixelGetColor_CaptureRegion($vDC, 0,0,@DesktopWidth,@DesktopHeight,$hDll)
;����������˳���
While Not _IsPressed(0x01)
    $aPos = MouseGetPos()
    $sColor = _PixelGetColor_GetPixel($vDC, $aPos[0],$aPos[1], $hDll)

    ToolTip("����µ���ɫ��: " & $sColor, $aPos[0]+3, $aPos[1]+3, "������ _PixelGetColor_GetPixel ��������",$hDll)
WEnd
_PixelGetColor_ReleaseRegion($vRegion)
_PixelGetColor_ReleaseDC($vDC,$hDll)
DllClose($hDll)

; #�Ӻ���# ;===============================================================================
;
; ������.........: _PixelGetColor_CreateDC
; ���� ..........: ����һ��DC������ĺ��� _PixelGetColor ʹ�á�
; �÷�...........: _PixelGetColor_CreateDC()
; ���� ..........: ��.
; ��������..... .: �ɹ� - ����һ�����õ�DC ���ָ��.
;                  ʧ�� - ����0����@error ���ó�DLLCALL���ص�@errorֵ.
; ���ߣ� ........: Jos van Egmond
; Modified.......:
; �޸�    .......:
; ��غ���.......: _PixelGetColor_CaptureRegion, _PixelGetcolor_GetPixel, _PixelGetColor_GetPixelRaw, _PixelGetColor_ReleaseRegion, _PixelGet_Color_ReleaseDC
; ����    .......; ��
;
; ;==========================================================================================
Func _PixelGetColor_CreateDC($hDll = "gdi32.dll")
        $iPixelGetColor_MemoryContext = DllCall($hDll, "int", "CreateCompatibleDC", "int", 0)
        If @error Then Return SetError(@error,0,0)
        Return $iPixelGetColor_MemoryContext[0]
EndFunc

; #FUNCTION# ;===============================================================================
;
; ������.......: _PixelGetColor_CaptureRegion
; ���� ........: ץȡ�û������һ�����򲢽�֮���õ�һ���ڴ�DC��.
; �÷�.........: _PixelGetColor_CaptureRegion($iPixelGetColor_MemoryContext, $iLeft = 0, $iTop = 0, $iRight = -1, $iBottom = -1, $fCursor = False)
; ���� ....: $iPixelGetColor_MemoryContext        - �ɺ��� _PixelGetColor_CreateDC ���ص�DC
;            $iLeft           - �û�����ľ�����������
;            $iTop            - �û�����ľ���������ϱ�
;            $iRight          - �û�����ľ���������ұ�
;            $iBottom         - �û�����ľ�������ĵײ�
;            $iCursor         - ������ֵ��TRUE, ��ô���Ҳ�ᱻץȡ���ڴ��С�
; �������� .: �ɹ� - ���ؾ��������HANDLE�������.
;             ʧ�� - 
; ���� ........: Jos van Egmond
; Modified.......:
; �޸� ..........:
; ��غ��� ......: _PixelGet_Color_CreateDC, _PixelGetcolor_GetPixel, _PixelGetColor_GetPixelRaw, _PixelGetColor_ReleaseRegion, _PixelGet_Color_ReleaseDC
; ����    .......; ��
;
; ;==========================================================================================
Func _PixelGetColor_CaptureRegion($iPixelGetColor_MemoryContext, $iLeft = 0, $iTop = 0, $iRight = -1, $iBottom = -1, $fCursor = False, $hDll = "gdi32.dll")
        $HBITMAP = _ScreenCapture_Capture("", $iLeft, $iTop, $iRight, $iBottom, $fCursor)
        DllCall($hDll, "hwnd", "SelectObject", "int", $iPixelGetColor_MemoryContext, "hwnd", $HBITMAP)
        Return $HBITMAP
EndFunc

; #FUNCTION# ;===============================================================================
;
; ������...........: _PixelGetColor_GetPixel
; ���� ...: ��DC�����ȡһ�������10����BGR��ʽ����ɫֵȻ��֮ת����6λ16���Ƶ�RGB��ʽ����ɫֵ.
; �÷�.........: _PixelGetColor_GetPixel($iPixelGetColor_MemoryContext,$iX,$iY)
; ���� ....: $iPixelGetColor_MemoryContext        - �ɺ��� _PixelGetColor_CreateDC ���ص�DC���
;            $iX                - ץȡ���X����
;            $iY                - ץȡ���Y����
; �������� .: �ɹ� - ����6λ16����RGB��ʽ����ɫֵ.
;             ʧ�� - ����-1����@error����Ϊ 1.
; ���� ........: Jos van Egmond
; Modified.......:
; �޸� ..........:
; ��غ��� ......: _PixelGetColor_CreateDC, _PixelGetColor_CaptureRegion, _PixelGetColor_GetPixelRaw, _PixelGetColor_ReleaseRegion, _PixelGet_Color_ReleaseDC
; ����    .......; ��
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
; ������...........: _PixelGetColor_GetPixelRaw
; ���� ...: ��DC����л�ȡһ�����10����BGR��ʽ����ɫֵ.
; �÷�.........: _PixelGetColor_GetPixelRaw($iPixelGetColor_MemoryContext,$iX,$iY)
; ���� ....: $iPixelGetColor_MemoryContext        - ����_PixelGetColor_CreateDC���ص�DC���
;            $iX                - ץȡ���X����
;            $iY                - ץȡ���Y����
; �������� .: �ɹ� - ����10����BGR��ʽ����ɫ.
;             ʧ�� - ����-1����@error����Ϊ 1.
; ���� ........: Jos van Egmond
; Modified.......:
; �޸� ..........:
; ��غ���.......: _PixelGetColor_CreateDC, _PixelGetColor_CaptureRegion, _PixelGetColor_GetPixel, _PixelGetColor_ReleaseRegion, _PixelGet_Color_ReleaseDC
; ����.......; ��
;
; ;==========================================================================================
Func _PixelGetColor_GetPixelRaw($iPixelGetColor_MemoryContext,$iX,$iY, $hDll = "gdi32.dll")
        $iColor = DllCall($hDll,"int","GetPixel","int",$iPixelGetColor_MemoryContext,"int",$iX,"int",$iY)
        Return $iColor[0]
EndFunc

; #FUNCTION# ;===============================================================================
;
; ������...........: _PixelGetColor_ReleaseRegion
; ���� ...: �ͷ�һ����_PixelGetColor_CaptureRegion����������ѡ�� 
; �÷�.........: _PixelGetColor_ReleaseRegion($HBITMAP)
; ���� ....: $HBITMAP - �ɺ��� _PixelGetColor_CaptureRegion ����������
; ��������.: ��.
; ���� ........: Jos van Egmond
; Modified.......:
; �޸� ..........:
; ��غ���. .......: _PixelGetColor_CreateDC, _PixelGetColor_CaptureRegion, _PixelGetcolor_GetPixel, _PixelGetColor_GetPixelRaw, _PixelGet_Color_ReleaseDC
; ����.......; ��
;
; ;==========================================================================================
Func _PixelGetColor_ReleaseRegion($HBITMAP)
        _WinAPI_DeleteObject($HBITMAP)
EndFunc

; #FUNCTION# ;===============================================================================
;
; ������..........: _PixelGetColor_ReleaseDC
; ���� ...: �ͷ�һ���� _PixelGetColor_CreateDC����������DC���
; �÷�.........: _PixelGetColor_ReleaseDC($iPixelGetColor_MemoryContext)
; ����  ....: $iPixelGetColor_MemoryContext - ��_PixelGetColor_CreateDC�����������ڴ�ָ��
; �������� .: ��.
; ���� ........: Jos van Egmond
; Modified.......:
; �޸� ..........:
; ��غ���. .......: _PixelGetColor_CreateDC, _PixelGetColor_CaptureRegion, _PixelGetcolor_GetPixel, _PixelGetColor_GetPixelRaw, _PixelGetColor_ReleaseRegion
; ����.......; ��
;
; ;==========================================================================================
Func _PixelGetColor_ReleaseDC($iPixelGetColor_MemoryContext, $hDll = "gdi32.dll")
        DllCall($hDll, "int", "DeleteDC", "hwnd", $iPixelGetColor_MemoryContext)
	EndFunc
	
Func Terminate()
    Exit 0
EndFunc