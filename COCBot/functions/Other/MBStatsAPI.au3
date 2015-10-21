
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

	Local  $sInputboxMBStatsAPI

; get the API from config.ini

; if no value, ask user

;	If $TotalCamp = 0 Then ; if Total camp size is still not set or value not same as read use forced value
;~ 		If $ichkMBStatsAPI = 0 Then ; check if MBStats has been set
			$sInputboxMBStatsAPI = InputBox("MBStatsAPI", $MBStatsAPI & "Enter your MBStats API from the www.mbstats.net website:", "", "", Default, Default, Default, Default, 240, $frmbot)
			$MBStatsAPI = $sInputboxMBStatsAPI
;~			$iValueTotalCampForced = $TotalCamp
			$ichkMBStatsAPI = 1
			Setlog("MBStats API input = " & $MBStatsAPI, $COLOR_GREEN) ; log the new MBStats API
;~ 			saveConfig()
;~		Else
;~			$TotalCamp = Number($iValueTotalCampForced)
;~		EndIf
;~	EndIf


EndFunc   ;==>MBStatsAPI
