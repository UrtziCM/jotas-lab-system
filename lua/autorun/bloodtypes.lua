bloodtypes = {
    "A",
    "B",
    "AB",
    "O"
}

isItNeg = {
    "-",
    "+"
}

hook.Add( "OnPlayerSpawn" , "SetBloodTypeOnSpawn", function( ply ) 
    timer.Simple(1, function()
        if not file.Exists("jotaslabsystem", "DATA") then
            file.CreateDir("jotaslabsystem")
        end
            
        if not file.Exists("jotaslabsystem/data/", "DATA") then
            file.CreateDir("jotaslabsystem/data/")
        end
    end)
end)
