
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

			$sInputboxMBStatsAPI = InputBox("MBStatsAPI", "Current API: " & $MBStatsAPI & @CRLF & @CRLF & "Enter your MBStats API from the www.mbstats.net website:", $MBStatsAPI, "", Default, Default, Default, Default, 240, $frmbot)
			if $sInputboxMBStatsAPI <> "" Then
				$MBStatsAPI = $sInputboxMBStatsAPI
				$ichkMBStatsAPI = 1
				Setlog("MBStats API input = " & $MBStatsAPI, $COLOR_GREEN) ; log the new MBStats API
				SaveConfig()
			EndIf

EndFunc   ;==>MBStatsAPI
