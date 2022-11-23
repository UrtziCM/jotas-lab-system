AddCSLuaFile("cl_init_dispenser.lua")
AddCSLuaFile("shared_dispenser.lua")
include( "shared_dispenser.lua" )
include( "autorun/bloodtypes.lua" )



function ENT:Initialize()
	self:SetModel( "models/hunter/blocks/cube025x025x025.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
    self:SetColor( 255 , 0 , 0 )
	
	local phys = self.Entity:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	util.AddNetworkString("jotasanalyzer_msg")
end

function ENT:Use( activator )
	if self.AnalyzingTime and CurTime() <= self.AnalyzingTime then 
		if self.LastCheck and CurTime() <= self.LastCheck then 
			activator:PrintMessage( 4 , "The machine is not ready yet" )
			self.LastCheck = ( CurTime() + self.CheckDelay )
			sound.Play( "player/suit_denydevice.wav" , self:GetPos())
		return end
        
        


	return end
	

	self.AnalyzingTime = ( CurTime() + self.AnalizeDelay )
end

/*
if SERVER then
    hook.Add( "PlayerInitialSpawn", "SetBloodType", function( ply )
        timer.Simple(1, function()
            if not file.Exists("jotaslabsystem", "DATA") then
                file.CreateDir("jotaslabsystem")
            end
        
            if not file.Exists("playercolor/data/", "DATA") then
                file.CreateDir("playercolor/data/")
            end
        
            local plyID = ply:SteamID64()
            if file.Exists("jotaslabsystem/data/" .. plyID .. ".txt", "DATA") then
                local data = file.Read("jotaslabsystem/data/" .. plyID .. ".txt", "DATA")
                data = util.JSONToTable(data)
                ply:SetPlayerColor( Vector( data.red , data.green , data.blue ) )   
            end
        end)
    end )

    hook.Add("OnPlayerDisconnect", "SetColorPlyDisconnect", function (ply)
        changeColorPlayerSave(ply)
    end)

    function changeColorPlayerSave(ply)
        print("Saving color")   
        local plyID = ply:SteamID64()
        local colors = string.Explode(" ", tostring(ply:GetPlayerColor():ToColor()))
        local data = {
            ["red"] = colors[1],
            ["green"] = colors[2],
            ["blue"] = colors[3]
        }
        local jsonData = util.TableToJSON(data)
        file.Write("playercolor/data/" .. plyID .. ".txt", jsonData)
    end

end
*/
