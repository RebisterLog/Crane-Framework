local Crane = require(game:GetService("ReplicatedStorage"):WaitForChild("shared"):WaitForChild("Crane"))

--[[
	-- Basic example for base part with tag "Part",
	-- which will be tracked by Crane automatically
]]

local PartComponent: Crane.Component<BasePart> = Crane:CreateComponent({
    Name = "PartComponent",
    Tag = "Part",
})

function PartComponent.onStart(self: Crane.Component<BasePart>)
	print(self.instance.Position)
end

return PartComponent
