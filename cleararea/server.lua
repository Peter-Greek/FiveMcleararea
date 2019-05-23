
AddEventHandler('chatMessage', function(source, n, message)
    local player = source
    cm = stringsplit(message, " ")

	if (cm[1] == "/clear") then
		if IsPlayerAceAllowed(player, "BCDOJRP.clear") then
			print("Cleared area")
			TriggerClientEvent("CA", -1)
			TriggerClientEvent('chatMessage', -1, '[^1SYSTEM^0]', { 255, 255, 255 }, GetPlayerName(player) ..' Cleared all vehicles from the Server')
		else
			TriggerClientEvent('chatMessage', player, '[^1SYSTEM^0]', { 255, 255, 255 }, "You do not have permissions to use this command.")
		end
	end
	CancelEvent()
end)


function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
--Coded by XERXES
