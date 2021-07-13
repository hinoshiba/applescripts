#!/usr/bin/evn osascript
#the list of keycode: https://eastmanreference.com/complete-list-of-applescript-key-codes

set timeoutSeconds to 2.0
set RemotePS4App to "RemotePlay"

repeat with i from 1 to 60 * 9.5 # the loop takes 9.5 hours.
	tell application RemotePS4App
		activate
		log "target window activated."

		repeat with i from 1 to 11 # the loop takes 1 minute.
			delay 2.5
			log "send key [up]"
			my sendKey(RemotePS4App, "key code 126", timeoutSeconds) #send [up]

			delay 2.5
			log "send key [return]"
			my sendKey(RemotePS4App, "key code 36", timeoutSeconds) #send [return]
		end repeat
	end tell
end repeat


on sendKey(applicationName, uiScript, timeoutSeconds)
	tell application "System Events"
		set activeApp to name of first application process whose frontmost is true
		if applicationName is not in activeApp then
			log "pass the sendKey. target window is inactive."
			return
		end if
	end tell

	set endDate to (current date) + timeoutSeconds
	repeat
		try
			run script "tell application \"System Events\"
" & uiScript & "
end tell"
			exit repeat
		on error errorMessage
			if ((current date) > endDate) then
				error "Can not " & uiScript
			end if
		end try
	end repeat
end sendKey
