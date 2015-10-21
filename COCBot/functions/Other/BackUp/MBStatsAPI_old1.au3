
; #FUNCTION# ====================================================================================================================
; Name ..........: MCStatsAPI
; Description ...: Add MBStats API
; Syntax ........: MCStatsAPI()
; Parameters ....:
; Return values .: None
; Author ........:
; Modified ......: Wednesday (October 2015)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func MBStatsAPI()

Local $MBStatsForm,

	If $TotalCamp = 0 Or ($TotalCamp <> $tmpTotalCamp) Then ; if Total camp size is still not set or value not same as read use forced value
		If $ichkTotalCampForced = 0 Then ; check if forced camp size set in expert tab
			$sInputbox = InputBox("Question", "Enter your total Army Camp capacity", "200", "", Default, Default, Default, Default, 240, $frmbot)
			$TotalCamp = Number($sInputbox)
			$iValueTotalCampForced = $TotalCamp
			$ichkTotalCampForced = 1
			Setlog("Army Camp User input = " & $TotalCamp, $COLOR_RED) ; log if there is read error AND we ask the user to tell us.
		Else
			$TotalCamp = Number($iValueTotalCampForced)
		EndIf
	EndIf


EndFunc   ;==>MBStatsAPI