local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local types = require(script.types)

local IS_SERVER = RunService:IsServer()

-- folder of all components scripts
local COMPONENTS_FOLDER = IS_SERVER and game.ServerScriptService.Server.Components or game.ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Components")

local ComponentSystem: {
	instances: { [Instance]: {[string]: types.ComponentClass<Instance>} };
	_components: {[string]: types.ComponentClass<Instance>};
	_trackedTags: {[string]: string};
} = {
	instances = {},
	_components = {},
	_trackedTags = {},
}
ComponentSystem.__index = ComponentSystem

function ComponentSystem:AddComponent<T>(instance: T, component: types.ComponentClass<T>)
	if not self.instances[instance] then
		self.instances[instance] = {}
	end

	if self.instances[instance][tostring(component)] then
		return warn("[ComponentSystem] This instance already has this component")
	end

	local newComponent = component.new(instance)

	newComponent.Destroyed:Connect(function()
		self.instances[instance][tostring(component)] = nil
	end)
	
	self.instances[instance][tostring(component)] = newComponent

	return newComponent
end

function ComponentSystem:RemoveComponent(instance: Instance, componentName: string)
	if not self.instances[instance] then return end
	if not self.instances[instance][componentName] then return end

	self.instances[instance][componentName]:destroy()
	self.instances[instance][componentName] = nil
end

function ComponentSystem:GetComponentOfObject(instance: Instance, componentName: string)
	if not self.instances[instance] then return end
	return self.instances[instance][componentName]
end

function ComponentSystem:GetAllInstancesFromComponent(componentName: string)
	local instances = {}
	for instance, components in self.instances do
		if components[componentName] then
			table.insert(instances, instance)
		end
	end
	return instances
end

function ComponentSystem:RegisterComponent<T>(component: types.ComponentClass<T>, options: {tag: string?})
	local componentName = tostring(component)
	if self._components[componentName] then return end

	self._components[componentName] = component

	if options.tag then
		self._trackedTags[options.tag] = componentName
	end
end

function ComponentSystem:Init()

	-- For registration components
	for i, componentModule in COMPONENTS_FOLDER:GetChildren() do
		require(componentModule)
	end

    for tag, component in self._trackedTags do
        CollectionService:GetInstanceAddedSignal(tag):Connect(function(instance)
			self:AddComponent(instance, self._components[component])
        end)
    end
    
	for tag, component in self._trackedTags do
		for i, instance in CollectionService:GetTagged(tag) do
			self:AddComponent(instance, self._components[component])
		end
	end
end

return ComponentSystem