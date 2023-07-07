#include-once
#include <Array.au3>
#include <Excel.au3>
#include <MsgBoxConstants.au3>
#include <File.au3>
#include "../au3WebDriver-0.12.0/wd_helper.au3"
#include "../au3WebDriver-0.12.0/wd_capabilities.au3"
#include "../au3WebDriver-0.12.0/wd_core.au3"
#include "../au3WebDriver-0.12.0/webdriver_utils.au3"
#include "../utils/common_utils.au3"

testGetElement()

Func testGetElement()
	Local $sSession = SetupChrome()

	_WD_Window($sSession,"MINIMIZE")

	Local $sFilePath = _WriteTestHtml()
	_WD_Navigate($sSession, $sFilePath)
	_WD_LoadWait($sSession, 1000)

	;~ $sElement = findElement($sSession, "//h4[contains(text(),'bevis')]")

	$aElements = _WD_FindElement($sSession, $_WD_LOCATOR_ByXPath, "//div[@class='x9f619 x1n2onr6 x1ja2u2z x78zum5 xdt5ytf x2lah0s x193iq5w x1xmf6yo x1e56ztr xzboxd6 x14l7nz5']", Default, True)

	ConsoleWrite("sElement: " & $aElements)

	;~ _ArrayDisplay($aElements)

	$sPosition = 999

	For $i = 0 To UBound($aElements) - 1
        ; Tìm phần tử con theo class
        Local $aChildElements = _WD_FindElement($sSession, $_WD_LOCATOR_ByXPath, ".//span[@class='x1lliihq x6ikm8r x10wlt62 x1n2onr6 x1120s5i']", $aElements[$i], True)
        
        If @error Then
            ;~ ConsoleWrite("Không tìm thấy phần tử con trong phần tử thứ " & $i & @CRLF)
			ConsoleWrite(@CRLF)
        Else
            ; In ra tên class của phần tử con
			;~ _ArrayDisplay($aElements)
            ;~ ConsoleWrite("Tên class của phần tử con trong phần tử thứ " & $i & ": " & _WD_ElementAction($sSession, $aChildElements[0], "Attribute", "class") & @CRLF)
			$sText = getTextElement($sSession, $aChildElements[0])
			If $sText == 'Thành viên đảm nhận vai trò này' Then
				$sPosition = $i
			EndIf
			;~ writeLog("Text lay dc " & $sText)
        EndIf
    Next

	writeLog("Vi tri lay dc: " & ($sPosition + 1))

	$aChildElements = _WD_FindElement($sSession, $_WD_LOCATOR_ByXPath, ".//span[contains(@class, 'xt0psk2')]/a[contains(@class, 'x1i10hfl xjbqb8w x6umtig x1b1mbwd xaqea5y xav7gou x9f619 x1ypdohk xt0psk2 xe8uvvx xdj266r x11i5rnm xat24cr x1mh8g0r xexx8yu x4uap5 x18d9i69 xkhd6sd x16tdsg8 x1hl2dhg xggy1nq x1a2a7pz xt0b8zv xzsf02u x1s688f')]", $aElements[($sPosition + 1)], True)

	If @error Then
		;~ ConsoleWrite("Không tìm thấy phần tử con trong phần tử thứ " & $i & @CRLF)
		ConsoleWrite(@CRLF)
	Else
		; In ra tên class của phần tử con
		;~ _ArrayDisplay($aElements)
		;~ ConsoleWrite("Tên class của phần tử con trong phần tử thứ " & $i & ": " & _WD_ElementAction($sSession, $aChildElements[0], "Attribute", "class") & @CRLF)
		For $i = 0 To UBound($aChildElements) - 1
			;~ ConsoleWrite($vElement)
			$sText = getTextElement($sSession, $aChildElements[$i])
			;~ If $sText == 'Thành viên đảm nhận vai trò này' Then
			;~ 	$sPosition = $i
			;~ EndIf
			writeLog("Text lay dc 111" & $sText)
		Next
	EndIf

	If $sSession Then _WD_DeleteSession($sSession)
	
	_WD_Shutdown()

EndFunc

Func _WriteTestHtml($sFilePath = $sRootDir & "input\wd_demo_SelectElement_TestFile.html")
    Return "file:///" & StringReplace($sFilePath, "\", "/")
EndFunc   ;==>_WriteTestHtml