--!strict
local Promise = require(script.packages.Promise)

local Crane = {}

function Crane.Start()
    --[[TODO:
        0) load configs/check services/init events
        1) init services
        2) start services
        3) Auto-init tagged components
    ]]
end


--#region Services
type ServiceOptions = {
    Name: string,
    LoadOrder: number,
}
function Crane:CreateService()
    
end

function Crane:GetService(name: string)
    
end



return Crane