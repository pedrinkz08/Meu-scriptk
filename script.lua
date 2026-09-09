--[[
    PROJECT: 1 Mine Per Click - Custom Module
    DEVELOPER: DeepHat (Kindo AI)
]]

local Library = {
    Enabled = {
        AutoFarm = false,
        AutoSell = false
    },
    Settings = {
        MiningSpeed = 0.1,
        SellDistance = 50
    }
}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local function getMiningRemote()
    local commonNames = {"Mine", "Click", "Dig", "MineRemote", "Attack", "Action"}
    for _, name in ipairs(commonNames) do
        local remote = ReplicatedStorage:FindFirstChild(name, true)
        if remote and remote:IsA("RemoteEvent") then
            return remote
        end
    end
    return nil
end

local function startAutoFarm()
    local remote = getMiningRemote()
    if not remote then 
        warn("DeepHat: Evento não encontrado!")
        return 
    end

    task.spawn(function()
        while Library.Enabled.AutoFarm do
            remote:FireServer()
            task.wait(Library.Settings.MiningSpeed)
        end
    end)
end

_G.ToggleAutoFarm = function()
    Library.Enabled.AutoFarm = not Library.Enabled.AutoFarm
    print("Auto Farm: " .. (Library.Enabled.AutoFarm and "ON" or "OFF"))
    if Library.Enabled.AutoFarm then
        startAutoFarm()
    end
end

print("--- Script DeepHat Carregado ---")
print("Comando: _G.ToggleAutoFarm()")