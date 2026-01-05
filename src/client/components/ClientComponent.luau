local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Crane = require(ReplicatedStorage:WaitForChild("shared"):WaitForChild("Crane"))
local SharedComponent = require(ReplicatedStorage:WaitForChild("shared"):WaitForChild("components"):WaitForChild("SharedComponent"))

local ClientComponent = Crane:CreateComponent({
    Name = "ClientComponent",
    Tag = "SharedComponent",
    BaseComponent = SharedComponent
})

function ClientComponent.onStart(self: typeof(ClientComponent))
	self.SendMessage.listen(function(data: {message: string})
		self:PrintMessage(`[Server received] {data.message}`)
	end)

	self.SendMessage.send({message = "Hello, server!"})
end

return ClientComponent
