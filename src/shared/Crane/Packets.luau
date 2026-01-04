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


--[[
	This module contains the packets used by the Crane Framework.
	You can use any network library you want, such as ByteNet for example.
	Just return the packets table, and use it in your middleware or services!
]]

local ByteNet = require(script.Parent.packages.ByteNet)

return ByteNet.defineNamespace("CranePackets", function()
	return {
		SendMessage = ByteNet.definePacket({
			value = ByteNet.struct({
				message = ByteNet.string,
			})
		}),
	}
end)
