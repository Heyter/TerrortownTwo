SWEP.HoldType           = "grenade"

if CLIENT then
	SWEP.PrintName       = "grenade_fire"
	SWEP.Slot            = 3

	SWEP.ViewModelFlip   = false
	SWEP.ViewModelFOV    = 54

	SWEP.Icon            = "vgui/ttt/icon_nades"
	SWEP.IconLetter      = "P"
end

SWEP.Base               = "weapon_ttt_basegrenade"

SWEP.Kind               = WEAPON_GRENADE

SWEP.UseHands           = true
SWEP.ViewModel          = "models/weapons/cstrike/c_eq_flashbang.mdl"
SWEP.WorldModel         = "models/weapons/w_eq_flashbang.mdl"

SWEP.Weight             = 5
SWEP.AutoSpawnable      = true
SWEP.Spawnable          = true
-- really the only difference between grenade weapons: the model and the thrown
-- ent.
SWEP.GrenadeName 	= "ttt_grenade_incendiary"
