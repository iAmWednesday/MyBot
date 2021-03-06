
; #FUNCTION# ====================================================================================================================
; Name ..........: BrewSpells
; Description ...: Create Normal Spells and Dark Spells
; Syntax ........: BrewSpells()
; Parameters ....:
; Return values .: None
; Author ........: ProMac ( 08-2015)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
Func BrewSpells()

	; ATTENTION : This function only works if the ArmyOverView Windows is open

	Local $NextPos = _PixelSearch(749, 311, 787, 322, Hex(0xF08C40, 6), 5)
	Local $PrevPos = _PixelSearch(70, 311, 110, 322, Hex(0xF08C40, 6), 5)

	; Spell Creation
	; Dark Spell Factory

	If $iTotalCountSpell = 0 Then Return

	If $CurSFactory < $TotalSFactory Then ;  If not full the Spell Factory then try to make spells
		If $numFactoryDarkSpellAvaiables = 1 And ($PoisonSpellComp > 0 Or $HasteSpellComp > 0) Then
			$iBarrHere = 0
			While Not (isDarkSpellFactory())
				If Not (IsTrainPage()) Then Return
				If IsArray($PrevPos) Then _TrainMoveBtn(-1) ;click prev button
				$iBarrHere += 1
				If _Sleep($iDelayTrain3) Then ExitLoop
				If $iBarrHere = 8 Then ExitLoop
			WEnd
			If isDarkSpellFactory() Then
				If $PoisonSpellComp > 0 Then ; Lightning Spells
					$TempPoisonSpell = Number(getBarracksTroopQuantity(175 + 107 * 0, 296))
					Local $PoisonSpell = $PoisonSpellComp - ($CurPoisonSpell + $TempPoisonSpell)
					If $debugSetlog = 1 Then SetLog("Making PoisionSpell: " & $PoisonSpell)
					If _sleep($iDelayTrain2) Then Return
					If $TempPoisonSpell = 0 Then
						If _sleep($iDelayTrain2) Then Return
						If _ColorCheck(_GetPixelColor(239, 375, True), Hex(0xFFFFFF, 6), 20) = False Then
							setlog("Not enough Elixir to create Spell", $COLOR_RED)
							Return
						ElseIf _ColorCheck(_GetPixelColor(200, 346, True), Hex(0x414141, 6), 20) Then
							setlog("Spell Factory Full", $COLOR_RED)
							Return
						Else
							If $PoisonSpell > 0 Then
								GemClick(252, 354, $PoisonSpell, $iDelayTrain7, "#0290")
								SetLog("Created " & $PoisonSpell & " Poison Spell(s)", $COLOR_BLUE)
							EndIf
						EndIf
					Else
						Setlog("Hei Chef! Already done PoisonSpell(s)")
					EndIf
				EndIf

				If $HasteSpellComp > 0 Then ; Rage Spells
					$TempHasteSpell = Number(getBarracksTroopQuantity(175 + 107 * 2, 296))
					Local $HasteSpell = $HasteSpellComp - ($CurHasteSpell + $TempHasteSpell)
					If $debugSetlog = 1 Then SetLog("Making PoisonSpell: " & $HasteSpell)
					If _sleep($iDelayTrain2) Then Return
					If $TempHasteSpell = 0 Then
						If _sleep($iDelayTrain2) Then Return
						If _ColorCheck(_GetPixelColor(453, 375, True), Hex(0xFFFFFF, 6), 20) = False Then
							setlog("Not enough Elixir to create Spell", $COLOR_RED)
							Return
						ElseIf _ColorCheck(_GetPixelColor(200, 346, True), Hex(0x414141, 6), 20) Then
							setlog("Spell Factory Full", $COLOR_RED)
							Return
						Else
							If $HasteSpell > 0 Then
								GemClick(430, 354, $HasteSpell, $iDelayTrain7, "#0290")
								SetLog("Created " & $HasteSpell & " Haste Spell(s)", $COLOR_BLUE)
							EndIf
						EndIf
					Else
						Setlog("Hei Chef! Already done HasteSpell(s)")
					EndIf
				EndIf
			Else
				SetLog("Dark Spell Factory not found...", $COLOR_BLUE)
			EndIf
		EndIf

		; Spell Creation
		; Normal Spell Factory

		If $numFactorySpellAvaiables = 1 And ($LightningSpellComp > 0 Or $RageSpellComp > 0 Or $HealSpellComp > 0) Then
			$iBarrHere = 0
			While Not (isSpellFactory())
				If Not (IsTrainPage()) Then Return
				If IsArray($PrevPos) Then _TrainMoveBtn(-1) ;click prev button
				$iBarrHere += 1
				If _Sleep($iDelayTrain3) Then ExitLoop
				If $iBarrHere = 8 Then ExitLoop
			WEnd
			If isSpellFactory() Then
				If $LightningSpellComp > 0 Then ; Lightning Spells
					$TempLightningSpell = Number(getBarracksTroopQuantity(175 + 107 * 0, 296))
					Local $LightningSpell = $LightningSpellComp - ($CurLightningSpell + $TempLightningSpell)
					If $debugSetlog = 1 Then SetLog("Making LightningSpell: " & $LightningSpell)
					If _sleep($iDelayTrain2) Then Return
					If $TempLightningSpell = 0 Then
						If _ColorCheck(_GetPixelColor(239, 375, True), Hex(0xFFFFFF, 6), 20) = False Then
							setlog("Not enough Elixir to create Spell", $COLOR_RED)
							Return
						ElseIf _ColorCheck(_GetPixelColor(200, 346, True), Hex(0x414141, 6), 20) Then
							setlog("Spell Factory Full", $COLOR_RED)
							Return
						Else
							If $LightningSpell > 0 Then
								GemClick(252, 354, $LightningSpell, $iDelayTrain7, "#0290")
								SetLog("Created " & $LightningSpell & " Lightning Spell(s)", $COLOR_BLUE)
							EndIf
						EndIf
					Else
						Setlog("Hei Chef! Already done LightningSpell(s)")
					EndIf
				EndIf
				If $HealSpellComp > 0 Then ; Heal Spells
					$TempHealSpell = Number(getBarracksTroopQuantity(175 + 107 * 1, 296))
					Local $HealSpell = $HealSpellComp - ($CurHealSpell + $TempHealSpell)
					If $debugSetlog = 1 Then SetLog("Making HealSpell: " & $HealSpell)
					If _sleep($iDelayTrain2) Then Return
					If $TempHealSpell = 0 Then
						If _ColorCheck(_GetPixelColor(346, 375, True), Hex(0xFFFFFF, 6), 20) = False Then
							setlog("Not enough Elixir to create Spell", $COLOR_RED)
							Return
						ElseIf _ColorCheck(_GetPixelColor(200, 346, True), Hex(0x414141, 6), 20) Then
							setlog("Spell Factory Full", $COLOR_RED)
							Return
						Else
							If $HealSpell > 0 Then
								GemClick(334, 354, $HealSpell, $iDelayTrain7, "#0290")
								SetLog("Created " & $HealSpell & " Heal Spell(s)", $COLOR_BLUE)
							EndIf
						EndIf
					Else
						Setlog("Hei Chef! Already done HealSpell(s)")
					EndIf
				EndIf
				If $RageSpellComp > 0 Then ; Rage Spells
					$TempRageSpell = Number(getBarracksTroopQuantity(175 + 107 * 2, 296))
					Local $RageSpell = $RageSpellComp - ($CurRageSpell + $TempRageSpell)
					If $debugSetlog = 1 Then SetLog("Making RageSpell: " & $RageSpell)
					If _sleep($iDelayTrain2) Then Return
					If $TempRageSpell = 0 Then
						If _ColorCheck(_GetPixelColor(453, 375, True), Hex(0xFFFFFF, 6), 20) = False Then
							setlog("Not enough Elixir to create Spell", $COLOR_RED)
							Return
						ElseIf _ColorCheck(_GetPixelColor(200, 346, True), Hex(0x414141, 6), 20) Then
							setlog("Spell Factory Full", $COLOR_RED)
							Return
						Else
							If $RageSpell > 0 Then
								GemClick(430, 354, $RageSpell, $iDelayTrain7, "#0290")
								SetLog("Created " & $RageSpell & " Rage Spell(s)", $COLOR_BLUE)
							EndIf
						EndIf
					Else
						Setlog("Hei Chef! Already done RageSpell(s)")
					EndIf
				EndIf
			Else
				SetLog("Spell Factory not found...", $COLOR_BLUE)
			EndIf
		EndIf
	Else
		SetLog("Spell Factory is full ...", $COLOR_BLUE)
	EndIf
EndFunc   ;==>BrewSpells
