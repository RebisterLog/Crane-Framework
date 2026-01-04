--[[
██████╗██████╗  █████╗ ███╗   ██╗███████╗
██╔════╝██╔══██╗██╔══██╗████╗  ██║██╔════╝
██║     ██████╔╝███████║██╔██╗ ██║█████╗
██║     ██╔══██╗██╔══██║██║╚██╗██║██╔══╝
╚██████╗██║  ██║██║  ██║██║ ╚████║███████╗
╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝

███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗
██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝
█████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝█████╔╝
██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗██╔═██╗
██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗
╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
by RebisterLog
]]

--!native
--!strict
--!optimize 2

--[=[
	Utility functions module for the Crane framework.

	Provides logging functionality with different severity levels (info, warn, error)
	that can be used throughout the framework for debugging and error reporting.

	@class Utils
]=]

--[=[
	Log level types for the Log function.

	@type LogLevel "info" | "warn" | "error"
	@within Utils
]=]
type LogLevel = "info" | "warn" | "error"

--[=[
	Logs a message with a specified owner and level.

	The log message is formatted as `[owner]reason` and output based on the level:
	- `"info"`: Uses `print()`
	- `"warn"`: Uses `warn()`
	- `"error"`: Uses `error()`

	```lua
	local Utils = require(path.to.Utils)

	Utils.Log("MyService", "Initialization complete", "info")
	Utils.Log("MyComponent", "Warning message", "warn")
	Utils.Log("MyService", "Critical error", "error")
	```

	@function Log
	@param owner string
	@param reason string
	@param level LogLevel?
	@within Utils
]=]
local function Log(owner: string, reason: string, level: LogLevel?)
	level = level or "info"

	local logMsg = `[{owner}]{reason}`

	if level == "info" then
		print(logMsg)
	elseif level == "warn" then
		warn(logMsg)
	elseif level == "error" then
		error(logMsg)
	end
end

return {
	Log = Log,
}
