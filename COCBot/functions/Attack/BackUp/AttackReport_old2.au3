; #FUNCTION# ====================================================================================================================
; Name ..........: AttackReport
; Description ...: This function will report the loot from the last Attack: gold, elixir, dark elixir and trophies.
;                  It will also update the statistics to the GUI (Last Attack).
; Syntax ........: AttackReport()
; Parameters ....: None
; Return values .: None
; Author ........: Hervidero (2015-feb-10), Sardo (may-2015)
; Modified ......: Sardo (may-2015), Hervidero (may-2015), Knowjack (July 2015)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func AttackReport()

	Local $iCount

	$lootGold = "" ; reset previous loot won values
	$lootElixir = ""
	$lootDarkElixir = ""
	$lootTrophies = ""

	$iCount = 0 ; Reset loop counter
	While _CheckPixel($aEndFightSceneAvl, True) = False ; check for light gold pixle in the Gold ribbon in End of Attack Scene before reading values
		$iCount += 1
		If _Sleep($iDelayAttackReport1) Then Return
		If $debugSetlog = 1 Then Setlog("Waiting Attack Report Ready, " & ($iCount / 2) & " Seconds.", $COLOR_PURPLE)
		If $iCount > 30 Then ExitLoop ; wait 30*500ms = 15 seconds max for the window to render
	WEnd
	If $iCount > 30 Then Setlog("End of Attack scene slow to appear, attack values my not be correct", $COLOR_BLUE)

	$iCount = 0 ; reset loop counter
	While getResourcesLoot(333, 289) = "" ; check for gold value to be non-zero before reading other values as a secondary timer to make sure all values are available
		$iCount += 1
		If _Sleep($iDelayAttackReport1) Then Return
		If $debugSetlog = 1 Then Setlog("Waiting Attack Report Ready, " & ($iCount / 2) & " Seconds.", $COLOR_PURPLE)
		If $iCount > 20 Then ExitLoop ; wait 20*500ms = 10 seconds max before we have call the OCR read an error
	WEnd
	If $iCount > 20 Then Setlog("End of Attack scene read gold error, attack values my not be correct", $COLOR_BLUE)

	If _ColorCheck(_GetPixelColor($aAtkRprtDECheck[0], $aAtkRprtDECheck[1], True), Hex($aAtkRprtDECheck[2], 6), $aAtkRprtDECheck[3]) Then ; if the color of the DE drop detected
		$iGoldLast = getResourcesLoot(333, 289)
		If _Sleep($iDelayAttackReport2) Then Return
		$iElixirLast = getResourcesLoot(333, 328)
		If _Sleep($iDelayAttackReport2) Then Return
		$iDarkLast = getResourcesLootDE(365, 365)
		If _Sleep($iDelayAttackReport2) Then Return
		$iTrophyLast = getResourcesLootT(403, 402)
		If _ColorCheck(_GetPixelColor($aAtkRprtTrophyCheck[0], $aAtkRprtTrophyCheck[1], True), Hex($aAtkRprtTrophyCheck[2], 6), $aAtkRprtTrophyCheck[3]) Then
			$iTrophyLast = -$iTrophyLast
		EndIf
		SetLog("Loot: [G]: " & _NumberFormat($iGoldLast) & " [E]: " & _NumberFormat($iElixirLast) & " [DE]: " & _NumberFormat($iDarkLast) & " [T]: " & $iTrophyLast, $COLOR_GREEN)
	Else
		$iGoldLast = getResourcesLoot(333, 289)
		If _Sleep($iDelayAttackReport2) Then Return
		$iElixirLast = getResourcesLoot(333, 328)
		If _Sleep($iDelayAttackReport2) Then Return
		$iTrophyLast = getResourcesLootT(403, 365)
		If _ColorCheck(_GetPixelColor($aAtkRprtTrophyCheck[0], $aAtkRprtTrophyCheck[1], True), Hex($aAtkRprtTrophyCheck[2], 6), $aAtkRprtTrophyCheck[3]) Then
			$iTrophyLast = -$iTrophyLast
		EndIf
		$iDarkLast = ""
		SetLog("Loot: [G]: " & _NumberFormat($iGoldLast) & " [E]: " & _NumberFormat($iElixirLast) & " [DE]: " & _NumberFormat($iDarkLast) & " [T]: " & $iTrophyLast, $COLOR_GREEN)
	EndIf

	If $iTrophyLast >= 0 Then
		If _ColorCheck(_GetPixelColor($aAtkRprtDECheck2[0], $aAtkRprtDECheck2[1], True), Hex($aAtkRprtDECheck2[2], 6), $aAtkRprtDECheck2[3]) Then
			If _Sleep($iDelayAttackReport2) Then Return
			$iGoldLastBonus = getResourcesBonus(590, 340)
			$iGoldLastBonus = StringReplace($iGoldLastBonus, "+", "")
			If _Sleep($iDelayAttackReport2) Then Return
			$iElixirLastBonus = getResourcesBonus(590, 371)
			$iElixirLastBonus = StringReplace($iElixirLastBonus, "+", "")
			If _Sleep($iDelayAttackReport2) Then Return
			$iDarkLastBonus = getResourcesBonus(621, 402)
			$iDarkLastBonus = StringReplace($iDarkLastBonus, "+", "")
			SetLog("Bonus [G]: " & _NumberFormat($iGoldLastBonus) & " [E]: " & _NumberFormat($iElixirLastBonus) & " [DE]: " & _NumberFormat($iDarkLastBonus), $COLOR_GREEN)
		Else
			If _Sleep($iDelayAttackReport2) Then Return
			$iGoldLastBonus = getResourcesBonus(590, 340)
			$iGoldLastBonus = StringReplace($iGoldLastBonus, "+", "")
			If _Sleep($iDelayAttackReport2) Then Return
			$iElixirLastBonus = getResourcesBonus(590, 371)
			$iElixirLastBonus = StringReplace($iElixirLastBonus, "+", "")
			$iDarkLastBonus = 0
			SetLog("Bonus [G]: " & _NumberFormat($iGoldLastBonus) & " [E]: " & _NumberFormat($iElixirLastBonus), $COLOR_GREEN)
		EndIf
		$LeagueShort = "--"
		For $i = 0 To 15
			If _Sleep($iDelayAttackReport2) Then Return
			If $League[$i][0] = $iGoldLastBonus Then
				SetLog("Your league level is: " & $League[$i][1])
				$LeagueShort = $League[$i][3]
				ExitLoop
			EndIf
		Next
	Else
		$iGoldLastBonus = 0
		$iElixirLastBonus = 0
		$iDarkLastBonus = 0
		$LeagueShort = "--"
	EndIf

	; check stars earned
	Local $starsearned = 0
	If _ColorCheck(_GetPixelColor($aWonOneStarAtkRprt[0], $aWonOneStarAtkRprt[1], True), Hex($aWonOneStarAtkRprt[2], 6), $aWonOneStarAtkRprt[3]) Then $starsearned += 1
	If _ColorCheck(_GetPixelColor($aWonTwoStarAtkRprt[0], $aWonTwoStarAtkRprt[1], True), Hex($aWonTwoStarAtkRprt[2], 6), $aWonTwoStarAtkRprt[3]) Then $starsearned += 1
	If _ColorCheck(_GetPixelColor($aWonThreeStarAtkRprt[0], $aWonThreeStarAtkRprt[1], True), Hex($aWonThreeStarAtkRprt[2], 6), $aWonThreeStarAtkRprt[3]) Then $starsearned += 1
	SetLog("Stars earned: " & $starsearned)

	Local $AtkLogTxt
	$AtkLogTxt = "" & _NowTime(4) & "|"
	$AtkLogTxt &= StringFormat("%5d", $iTrophyCurrent) & "|"
	$AtkLogTxt &= StringFormat("%6d", $SearchCount) & "|"
	$AtkLogTxt &= StringFormat("%7d", $iGoldLast) & "|"
	$AtkLogTxt &= StringFormat("%7d", $iElixirLast) & "|"
	$AtkLogTxt &= StringFormat("%7d", $iDarkLast) & "|"
	$AtkLogTxt &= StringFormat("%3d", $iTrophyLast) & "|"
	$AtkLogTxt &= StringFormat("%1d", $starsearned) & "|"
	$AtkLogTxt &= StringFormat("%6d", $iGoldLastBonus) & "|"
	$AtkLogTxt &= StringFormat("%6d", $iElixirLastBonus) & "|"
	$AtkLogTxt &= StringFormat("%4d", $iDarkLastBonus) & "|"
	$AtkLogTxt &= $LeagueShort & "|"
	SetAtkLog($AtkLogTxt)

   ; ==================== Begin MBStats Mod ====================
   SetLog("Sending attack report to mbstats.net...", $COLOR_BLUE)
   $MyApiKey = "7e2ca211fc3488ea995edc829313d93d" ; <---- insert api key here
   $sPD = 'apikey=' & $MyApiKey & '&ctrophy=' & $iTrophyCurrent & '&cgold=' & _
	   $iGoldCurrent & '&celix=' & $iElixirCurrent & '&cdelix=' & $iDarkCurrent & '&search=' & _
	   $SearchCount & '&gold=' & $iGoldLast & '&elix=' & $iElixirLast & '&delix=' & $iDarkLast & _
	   '&trophy=' & $iTrophyLast & '&bgold=' & $iGoldLastBonus & '&belix=' & $iElixirLastBonus & _
	   '&bdelix=' & $iDarkLastBonus & '&stars=' & $starsearned & '&thlevel=' & $iTownHallLevel & '&log='

   $tempLogText = _GuiCtrlRichEdit_GetText($txtLog, True)
   For $i = 1 To StringLen($tempLogText)
	  $acode = Asc(StringMid($tempLogText, $i, 1))
	  Select
		 Case ($acode >= 48 And $acode <= 57) Or _
			   ($acode >= 65 And $acode <= 90) Or _
			   ($acode >= 97 And $acode <= 122)
			$sPD = $sPD & StringMid($tempLogText, $i, 1)
		 Case $acode = 32
			$sPD = $sPD & "+"
		 Case Else
			$sPD = $sPD & "%" & Hex($acode, 2)
	  EndSelect
   Next

   $oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
   $oHTTP.Open("POST", "https://mbstats.net/api/log.php", False)
   $oHTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")

   $oHTTP.Send($sPD)

   $oReceived = $oHTTP.ResponseText
   $oStatusCode = $oHTTP.Status
   SetLog("Report sent. " & $oStatusCode & " " & $oReceived, $COLOR_BLUE)
   ; ===================== End MBStats Mod =====================

	; Share Replay
	If $iShareAttack = 1 Then
		If (Number($iGoldLast) >= Number($iShareminGold)) And (Number($iElixirLast) >= Number($iShareminElixir)) And (Number($iDarkLast) >= Number($iSharemindark)) Then
			SetLog("reach miminum loots values... share Replay")
			$iShareAttackNow = 1
		Else
			SetLog("under miminum loots values... no share Replay")
			$iShareAttackNow = 0
		EndIf
	EndIf

	If $FirstAttack = 0 Then $FirstAttack = 1
	$iGoldTotal += $iGoldLast + $iGoldLastBonus
	$iTotalGoldGain[$iMatchMode] += $iGoldLast + $iGoldLastBonus
	$iElixirTotal += $iElixirLast + $iElixirLastBonus
	$iTotalElixirGain[$iMatchMode] += $iElixirLast + $iElixirLastBonus
	If $iDarkStart <> "" Then
		$iDarkTotal += $iDarkLast + $iDarkLastBonus
		$iTotalDarkGain[$iMatchMode] += $iDarkLast + $iDarkLastBonus
	EndIf
	$iTrophyTotal += $iTrophyLast
	$iTotalTrophyGain[$iMatchMode] += $iTrophyLast
	If $iMatchMode = $TS Then
		If $starsearned > 0 Then
			$iNbrOfTHSnipeSuccess += 1
		Else
			$iNbrOfTHSnipeFails += 1
		EndIf
	EndIf
	$iAttackedVillageCount[$iMatchMode] += 1
	UpdateStats()

EndFunc   ;==>AttackReport