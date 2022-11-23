ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Helath kit dispenser"
ENT.Category = "Jota's lab System"

ENT.Author = "[ Jota ]"
ENT.Contact = "[ Jota ]#1490"

ENT.Spawnable			= true
ENT.AdminOnly			= true
ENT.AnalizeDelay		= 3
ENT.CheckDelay			= 1
if CLIENT then
	net.Receive( "jotasanalyzer_msg", function()
		chat.AddText( Color( 109, 109, 109 ), net.ReadString() )
	end )
end