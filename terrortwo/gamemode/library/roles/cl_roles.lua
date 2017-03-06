TTT.Roles = TTT.Roles or {}

local always_spec = CreateClientConVar("ttt_always_spectator", "0", true, true, "Setting this to true will always make you a spectator.")
cvars.AddChangeCallback("ttt_always_spectator", function(_, _, newval)
	net.Start("TTT.Roles.ChangedSpectatorMode")
		net.WriteBool(newval == 1 and true or false)
	net.SendToServer()
end)

------------------------
-- TTT.Roles.GetUnknown
------------------------
-- Desc:		Gets all players with unknown roles.
-- Returns:		Table, containning players with unknown roles.
function TTT.Roles.GetUnknown()
	local plys = {}
	for i, v in ipairs(player.GetAll()) do
		if v:IsUnknown() then
			table.insert(plys, v)
		end
	end
end

net.Receive("TTT.Roles.Clear", function()
	local numplys = net.ReadUInt(7)
	local activeplayers = {}
	for i = 1, numplys do
		activeplayers[net.ReadPlayer()] = true
	end

	for i, v in ipairs(player.GetAll()) do
		if activeplayers[v] then
			v:SetRole(ROLE_WAITING)
		else
			v:SetRole(ROLE_SPECTATOR)
		end
	end
end)

net.Receive("TTT.Roles.SyncTraitors", function()
	local numtraitors = net.ReadUInt(7)
	for i = 1, numtraitors do
		net.ReadPlayer():SetRole(ROLE_TRAITOR)
	end
end)

net.Receive("TTT.Roles.Sync", function()
	-- Set dectives.
	local numdetectives = net.ReadUInt(7)
	for i = 1, numdetectives do
		net.ReadPlayer():SetRole(ROLE_DETECTIVE)
	end

	-- Set spectators.
	local numspectators = net.ReadUInt(7)
	for i = 1, numspectators do
		net.ReadPlayer():SetRole(ROLE_SPECTATOR)
	end

	-- Set our own role.
	if LocalPlayer():IsUnknown() then
		LocalPlayer():SetRole(ROLE_INNOCENT)
	end

	-- Any player without a role, set to unknown
	for i, v in ipairs(player.GetAll()) do
		if v:IsWaiting() then
			v:SetRole(ROLE_UKNOWN)
		end
	end
end)