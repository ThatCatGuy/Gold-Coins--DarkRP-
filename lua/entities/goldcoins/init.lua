AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

CreateConVar( "coin_min_value", 500, FCVAR_SERVER_CAN_EXECUTE )
CreateConVar( "coin_max_value", 2000, FCVAR_SERVER_CAN_EXECUTE )
CreateConVar( "coin_random", 1, FCVAR_SERVER_CAN_EXECUTE )
CreateConVar( "coin_value", 1000, FCVAR_SERVER_CAN_EXECUTE )

local coinmin = GetConVar( "coin_min_value" )
local coinmax = GetConVar( "coin_max_value" )
local coinvalue = GetConVar( "coin_value" )

function ENT:Initialize()
	self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:GetPhysicsObject():Wake()
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	self:SetTrigger(true)
	self:DrawShadow(false)
end

function ENT:StartTouch(ply)
	if ply:IsPlayer() then
		if gmod.GetGamemode().Name != "DarkRP" then self:Remove() return end
		local soundFile = "npc/roller/remote_yes.wav"
		local moneyrandom = GetConVar( "coin_random" ):GetBool() and math.Round(math.Rand(coinmin:GetInt(), coinmax:GetInt())) or math.Round(coinvalue:GetInt())
		ply:EmitSound(soundFile)
		DarkRP.notify(ply, 3, 4, "You found a coin and received " .. DarkRP.formatMoney(moneyrandom))
		ply:addMoney(moneyrandom)
		self:Remove()
	end
end