AddCSLuaFile()


SWEP.PrintName				= "Sample vial"
SWEP.Author					= " [ Jota ] "
SWEP.Instructions			= ""
SWEP.Category 				= "Jota's lab System"

SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Weight					= 1
SWEP.AutoSwitchTo			= true
SWEP.AutoSwitchFrom			= true

SWEP.Slot			   	 	= 0
SWEP.SlotPos				= 1
SWEP.DrawAmmo				= false
SWEP.DrawCrosshair			= true

SWEP.HoldType 				= "pistol"

SWEP.ViewModel				= "models/weapons/jotalabsystem/c_vial.mdl"
SWEP.WorldModel				= "models/weapons/jotalabsystem/c_vial.mdl"

SWEP.Delay 					= 2
SWEP.ReloadDelay            = 1

SWEP.IronSightsPos  = Vector( 0 , 100 , 0 )
SWEP.IronSightsAng  = Vector( 0 , 0 , 0 )

if CLIENT then return end

function SWEP:PrimaryAttack( Player , table , Weapon )
    local eyetraceEnt = self.Owner:GetEyeTrace().Entity
    
    for k, v in pairs(ents.FindInSphere(self.Owner:GetPos(), 300)) do
        if (eyetraceEnt == v) and (eyetraceEnt:IsPlayer()) and ((capped == false)or(capped== nil)) then 
            sample = ( eyetraceEnt:Nick() .. "'s blood sample." )
            sampledEnt = eyetraceEnt
            self.Owner:ChatPrint( "You've collected " .. sample)
            capped = false
        elseif (eyetraceEnt == v) and ((eyetraceEnt:IsPlayer())or(eyetraceEnt:IsNPC())) and (capped == true) then
            self.Owner:ChatPrint( "The vial is capped" )
        elseif (eyetraceEnt == v) and (eyetraceEnt:IsNPC()) and ((capped == false)or(capped== nil)) then
            sample = ( eyetraceEnt:GetClass() .. "'s blood sample." )
            self.Owner:ChatPrint( "You've collected " .. sample)
            capped = false
            sampledEnt = eyetraceEnt
        end
	end	
    timer.Create( "checksprint" , -1 , 0.25 , function() 
        if ( self.Owner:IsSprinting() == true ) and ( self.Owner:GetActiveWeapon() == self) and (sample != nil) and (( capped == false)or(capped== nil)) then 
            sample = nil
            self.Owner:ChatPrint( "You've spilled the blood sample" )
            ParticleEffect( "blood_impact_red_01_droplets" , self.Owner:GetPos() , Angle( 0 , 0 , 0 ))
        end
    end) 
    
    self:SetNextPrimaryFire( CurTime() + self.Delay )
end

function SWEP:SecondaryAttack()
    if (sample != nil) then
        self.Owner:PrintMessage( 4 , sample )
    else
        self.Owner:ChatPrint( "You've got no blood sample." )
    end

    self:SetNextSecondaryFire( CurTime() + self.Delay )
end

function SWEP:Reload( Player )
    if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end

    
    if (capped == false)or(capped == nil) then
            capped = true
            self.Owner:ChatPrint( "You capped the vial." )
    elseif (capped == true) then
            capped = false
            self.Owner:ChatPrint( "You uncapped the vial." )
    end
    
    self.ReloadingTime = ( CurTime() + self.ReloadDelay )
end

