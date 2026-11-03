--==================================================
-- KHỞI TẠO DỊCH VỤ VÀ MODULE ENTITY SPAWNER V2 (PHANTOM)
--==================================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

-- Tải module Vynixu's Entity Spawner V2
local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Entity-Spawner-V2/main/init.luau"))()

---==================================================
--- 3. ENTITY: PHANTOM (Thời gian chờ: 45 giây)
---==================================================
task.spawn(function()
    while true do
        task.wait(45)

        local phantomSound = Instance.new("Sound")
        phantomSound.Name = "PhantomSound"
        phantomSound.SoundId = "rbxassetid://9114224856"
        phantomSound.Volume = 6
        phantomSound.PlaybackSpeed = 1.4
        phantomSound.Parent = SoundService

        local Phantom = Spawner.createEntity({
            CustomName = "Phantom",
            Model = "rbxassetid://13124351651",
            Speed = 140,
            DelayTime = 1.5,
            HeightOffset = 0,
            CanKill = true,
            KillRange = 40,
            Backstrack = false,
            BreakLights = true,
            FlickerLights = true,
            FlickerDuration = 1.5,
            Cycles = {
                Min = 2,
                Max = 12,
                Wait = 0.9
            },
            CamShake = {
                Enabled = true,
                Values = {4, 20, 0.25, 2.5},
                Range = 90
            },
            CustomDialog = {"You died to Phantom...", "It moves at blinding speeds and rebounds multiple times", "Listen for its approach and hide immediately!"}
        })

        Phantom:SetCallback("OnSpawned", function() phantomSound:Play() end)
        Phantom:SetCallback("OnDespawned", function()
            TweenService:Create(phantomSound, TweenInfo.new(1.5), {Volume = 0}):Play()
            task.delay(1.5, function()
                phantomSound:Stop()
                phantomSound:Destroy()
            end)
        end)

        Phantom:Run()
    end
end)
