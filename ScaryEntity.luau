--==================================================
-- KHỞI TẠO DỊCH VỤ VÀ MODULE ENTITY SPAWNER V2 (SCARY ENTITY)
--==================================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")

-- Tải module Vynixu's Entity Spawner V2
local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Entity-Spawner-V2/main/init.luau"))()

---==================================================
--- 2. SCARY ENTITY (Thời gian chờ: 35 giây)
---==================================================
task.spawn(function()
    while true do
        task.wait(35)

        local originalAmbient = Lighting.Ambient
        local originalOutdoorAmbient = Lighting.OutdoorAmbient
        local originalClockTime = Lighting.ClockTime

        local spawnSound = Instance.new("Sound")
        spawnSound.Name = "ScarySpawnSound"
        spawnSound.SoundId = "rbxassetid://9114227045"
        spawnSound.Volume = 5
        spawnSound.PlaybackSpeed = 0.5
        spawnSound.Parent = SoundService

        local function applyScarySky()
            if Lighting:FindFirstChild("ScarySky") then Lighting.ScarySky:Destroy() end
            local sky = Instance.new("Sky")
            sky.Name = "ScarySky"
            local skyId = "rbxassetid://13720474225"
            sky.SkyboxBk, sky.SkyboxDn, sky.SkyboxFt, sky.SkyboxLf, sky.SkyboxRt, sky.SkyboxUp = skyId, skyId, skyId, skyId, skyId, skyId
            sky.Parent = Lighting

            Lighting.Ambient = Color3.fromRGB(40, 0, 0)
            Lighting.OutdoorAmbient = Color3.fromRGB(20, 0, 0)
            Lighting.ClockTime = 0
        end

        local function removeScarySky()
            if Lighting:FindFirstChild("ScarySky") then Lighting.ScarySky:Destroy() end
            Lighting.Ambient = originalAmbient
            Lighting.OutdoorAmbient = originalOutdoorAmbient
            Lighting.ClockTime = originalClockTime
        end

        local ScaryEntity = Spawner.createEntity({
            CustomName = "Scary Entity",
            Model = "rbxassetid://13124351651",
            Speed = 100,
            DelayTime = 2,
            HeightOffset = 0,
            CanKill = true,
            KillRange = 40,
            Backstrack = false,
            BreakLights = true,
            FlickerLights = true,
            FlickerDuration = 0,
            Cycles = {
                Min = 1,
                Max = 1,
                Wait = 2
            },
            CamShake = {
                Enabled = true,
                Values = {1.5, 20, 0.1, 1},
                Range = 100
            },
            CustomDialog = {"You died by Scary.... Thing", "Ground transit means it will arrive", "Hide", "Good luck next time"}
        })

        ScaryEntity:SetCallback("OnSpawned", function()
            applyScarySky()
            spawnSound:Play()
        end)

        ScaryEntity:SetCallback("OnDespawned", function()
            TweenService:Create(spawnSound, TweenInfo.new(2), {Volume = 0}):Play()
            task.delay(2, function()
                spawnSound:Stop()
                spawnSound:Destroy()
            end)
            removeScarySky()
        end)

        ScaryEntity:Run()
    end
end)
