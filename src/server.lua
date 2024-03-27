local isAutomaticCarwipeCancelled = false
local timer = 0

---@param source number
---@param notification NotifyProps
local function sendNotification(source, notification)
	lib.callback("vx_carwipe:sendNotification", source, function() end, notification)
end

local function scheduleCarwipe()
	isAutomaticCarwipeCancelled = false
	timer = 0

	while not isAutomaticCarwipeCancelled do
		for _, notifyAt in ipairs(Config.notifies) do
			local remainingTime = (Config.interval - timer) / 1000
			local metric = remainingTime < 60 and "seconds" or "minutes"

			if remainingTime == notifyAt / 1000 then
				sendNotification(-1, {
					type = "info",
					title = "Carwipe",
					description = ("Carwipe in %d %s."):format(
						math.floor(remainingTime), metric)
				})
			end
		end

		if timer >= Config.interval then
			break
		end

		timer += 1000
		Citizen.Wait(1000)
	end
end

local function runCarwipe()
	lib.callback("vx_carwipe:deleteVehicles", -1, function() end)

	sendNotification(-1, {
		type = "success",
		title = "Carwipe",
		description = "Carwipe done."
	})
end

local function cancelAutomaticCarwipe()
	isAutomaticCarwipeCancelled = true
end

lib.addCommand("carwipe", {
	restricted = Config.commandGroups,
	help = "Wipe all vehicles",
}, function()
	cancelAutomaticCarwipe()
	runCarwipe()
end)

lib.addCommand("cancelcarwipe", {
	restricted = Config.commandGroups,
	help = "Cancel automatic carwipe",
}, function()
	cancelAutomaticCarwipe()
	sendNotification(-1, {
		type = "info",
		title = "Carwipe",
		description = "The carwipe has been cancelled."
	})
end)

Citizen.CreateThread(function()
	while true do
		scheduleCarwipe()

		if not isAutomaticCarwipeCancelled then
			lib.print.info("Running automatic carwipe")
			runCarwipe()
		else
			lib.print.info("Automatic carwipe cancelled by user")
		end
	end
end)
