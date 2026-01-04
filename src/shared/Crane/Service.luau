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

--!strict
--!optimize 2

local Log = require(script.Parent.Utils).Log

--[=[
	The Service module provides the base class for all services in the Crane framework.

	Services are singleton-like modules that handle game-wide functionality. They support
	initialization and startup callbacks, and can be ordered using the LoadOrder property
	to control initialization sequence.

	@class Service
]=]
local Service = {}
Service.__index = Service
Service.__tostring = "CraneService"

-- Types
--[=[
	Configuration table for creating a new service.

	@type ServiceDef
	@within Service
]=]
export type ServiceDef = {
	--[=[
		The unique name of the service.

		@prop Name string
		@within ServiceDef
	]=]
    Name: string,
	--[=[
		Optional load order for service initialization. Lower values are initialized first.

		@prop LoadOrder number?
		@within ServiceDef
	]=]
    LoadOrder: number?,
}

--[=[
	Internal data structure for service instances.

	@type ServiceData
	@within Service
]=]
export type ServiceData = ServiceDef & {
	--[=[
		Optional callback function that is called when the service is initialized.

		@prop onInit ((self: Service) -> ())?
		@within ServiceData
	]=]
	onInit: ((self: Service) -> ())?;
	--[=[
		Optional callback function that is called when the service starts.

		@prop onStart ((self: Service) -> ())?
		@within ServiceData
	]=]
	onStart: ((self: Service) -> ())?;
}

--[=[
	Represents a service instance in the Crane framework.

	@type Service
	@within Service
]=]
export type Service = setmetatable<ServiceData, typeof(Service)>


--[=[
	Creates a new service definition. This is typically called by `Crane:CreateService`.

	```lua
	local service = Service.new({
		Name = "MyService",
		LoadOrder = 1,
	})
	```

	@method new
	@param options ServiceDef
	@return Service
	@within Service
]=]
function Service.new(options: ServiceDef)
	local self = {}
	self.Name = options.Name
	self.LoadOrder = options.LoadOrder or 0

	return setmetatable(self, Service) :: Service
end

--[=[
	Initializes the service by calling the `onInit` callback if it exists.

	This method is automatically called by `Crane:Start` for all services in order of their `LoadOrder` and should not be called manually in most cases.

	If `CRANE_DEBUGGING` is enabled, errors are caught and logged instead of being thrown.

	```lua
	function MyService:onInit()
		-- Initialization logic here
		print("Service initialized")
	end
	```

	@method Init
	@within Service
]=]
function Service.Init(self: Service)
	if not self.onInit then return end

	if _G["CRANE_DEBUGGING"] then
		local success, err = pcall(self.onInit, self)

		if not success then
			Log(self.Name, err, "warn")
		else
			Log(self.Name, "Successfully initialized")
		end
	else
		self:onInit()
	end
end

--[=[
	Starts the service by calling the `onStart` callback if it exists.

	This method is automatically called by `Crane:Start` for all services after initialization and should not be called manually in most cases.

	If `CRANE_DEBUGGING` is enabled, errors are caught and logged instead of being thrown.

	```lua
	function MyService:onStart()
		-- Startup logic here
		print("Service started")
	end
	```

	@method Start
	@within Service
]=]
function Service.Start(self: Service)
	if not self.onStart then return end

	if _G["CRANE_DEBUGGING"] then
		local success, err = pcall(self.onStart, self)

		if not success then
			Log(self.Name, err, "warn")
		else
			Log(self.Name, "Successfully started")
		end
	else
		self:onStart()
	end
end

return Service
