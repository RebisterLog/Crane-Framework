local RunService = game:GetService("RunService")
local types = require(script.types)

local IS_SERVER = RunService:IsServer()

-- folder of all components scripts
local SERVICES_FOLDER = IS_SERVER and game.ServerScriptService.Server.Services or game.ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Services")

local function sortElementsByPriority(arr: { {
	Priority: number?,
} }): typeof(arr)
	table.sort(arr, function(a, b)
		return (a.Priority or 0) > (b.Priority or 0)
	end)

	return arr
end

local ServiceSystem: {
	_services: {types.ServiceClass},
	Init: () -> (),
} = {
	_services = {},
}
ServiceSystem.__index = ServiceSystem

function ServiceSystem:Init()
	print("[Services] Starting services")
	-- For registration services
	for i, serviceModule in SERVICES_FOLDER:GetDescendants() do
		if not serviceModule:IsA("ModuleScript") then continue end
		local service = require(serviceModule)
		table.insert(self._services, service)
	end

	self._services = sortElementsByPriority(self._services)

	for i, service in self._services do
		if service.onStart then
			service:onStart()
		end

		if service.onTick then
			RunService.Heartbeat:Connect(function(deltaTime)
				service:onTick(deltaTime)
			end)
		end
	end

	print("[Services] Services initialized")
end

return ServiceSystem