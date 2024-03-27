Config = {}

Config.commandGroups = { "group.mod", "group.admin" }
Config.interval = 30 * 60 * 1000 -- 30 minutes
Config.notifies = {
	10 * 60 * 1000,                -- 10 minutes,
	5 * 60 * 1000,                 -- 5 minutes,
	3 * 60 * 1000,                 -- 3 minute,
	1 * 60 * 1000,                 -- 1 minute,
	30 * 1000,                     -- 30 seconds,
	10 * 1000,                     -- 10 seconds,
	3 * 1000,                      -- 3 seconds,
	2 * 1000,                      -- 2 second,
	1 * 1000,                      -- 1 second
}
