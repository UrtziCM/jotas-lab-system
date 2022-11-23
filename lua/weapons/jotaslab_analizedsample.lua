AddCSLuaFile()


SWEP.PrintName				= "Packed sample"
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

SWEP.ViewModel				= ""
SWEP.WorldModel				= ""

SWEP.Delay 					= 2
SWEP.ReloadDelay            = 1

SWEP.IronSightsPos  = Vector( 0 , 100 , 0 )
SWEP.IronSightsAng  = Vector( 0 , 0 , 0 )

if CLIENT then return end

function SWEP:PrimaryAttack( Player , table , Weapon )

    
    self:SetNextPrimaryFire( CurTime() + self.Delay )
end

function SWEP:SecondaryAttack()

    self:SetNextSecondaryFire( CurTime() + self.Delay )
end

function SWEP:Reload( Player )
    if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end
    
    self.ReloadingTime = ( CurTime() + self.ReloadDelay )
end

