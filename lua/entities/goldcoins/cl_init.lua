include("shared.lua")

function ENT:Initialize()
	self.csModel = ClientsideModel("models/xqm/panel360.mdl")
	self.csModel:SetModelScale(0.3, 0)
	self.csModel:SetMaterial("models/shiny")
	self.csModel:SetColor(Color(230, 255, 41))
end

function ENT:Draw()
	local coinAngel  = (CurTime() * 90) % 360
	local coinHeight = math.sin(CurTime() * 3) * 5

	self.csModel:SetPos(self:GetPos() + Vector(0,0,coinHeight + 10))
	self.csModel:SetAngles(Angle(0, coinAngel))

end

function ENT:OnRemove()
	self.csModel:Remove()
end	