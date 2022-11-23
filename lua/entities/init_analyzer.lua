AddCSLuaFile("cl_init_analyzer.lua")
AddCSLuaFile("shared_analyzer.lua")
include( "shared_analyzer.lua" )
include( "autorun/bloodtypes.lua" )





function ENT:Initialize()
	self:SetModel( "models/hunter/blocks/cube025x025x025.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
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
	if (activator:GetActiveWeapon():GetClass()=="jotaslab_vial") and (sample != nil) then 
		--print(table.Random(bloodtypes))	
		sampleBloodtypeTable = { table.Random(isItNeg) , table.Random(bloodtypes)}

        local plyID = ply:SteamID64()
        if file.Exists("jotaslabsystem/data/" .. plyID .. ".txt", "DATA") then
            local data = file.Read("jotaslabsystem/data/" .. plyID .. ".txt", "DATA")
            data = util.JSONToTable(data)
            sampleBloodtypeTable = data
        end
	else
		print("wrong")
		sound.Play( "player/suit_denydevice.wav" , self:GetPos())
	end

	self.AnalyzingTime = ( CurTime() + self.AnalizeDelay )

end

/*
if SERVER then
    hook.Add( "PlayerInitialSpawn", "SetBloodType", function( ply )
        timer.Simple(1, function()
            if not file.Exists("jotaslabsystem", "DATA") then
                file.CreateDir("jotaslabsystem")
            end
        
            if not file.Exists("jotaslabsystem/data/", "DATA") then
                file.CreateDir("jotaslabsystem/data/")
            end
        
            local plyID = ply:SteamID64()
            if file.Exists("jotaslabsystem/data/" .. plyID .. ".txt", "DATA") then
                local data = file.Read("jotaslabsystem/data/" .. plyID .. ".txt", "DATA")
                data = util.JSONToTable(data)
                ply:Setjotaslabsystem( Vector( data.red , data.green , data.blue ) )   
            end
        end)
    end )

    hook.Add("OnPlayerDisconnect", "SetColorPlyDisconnect", function (ply)
        changeColorPlayerSave(ply)
    end)

    function changeColorPlayerSave(ply)
        print("Saving color")   
        local plyID = ply:SteamID64()
        local colors = string.Explode(" ", tostring(ply:setplayercolor():ToColor()))
        local data = {
            ["red"] = colors[1],
            ["green"] = colors[2],
            ["blue"] = colors[3]
        }
        local jsonData = util.TableToJSON(data)
        file.Write("jotaslabsystem/data/" .. plyID .. ".txt", jsonData)
    end

end
*/
