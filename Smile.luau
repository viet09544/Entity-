--==================================================
-- KHỞI TẠO DỊCH VỤ VÀ MODULE ENTITY SPAWNER V2 (SMILE)
--==================================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer

-- Tải module Vynixu's Entity Spawner V2 (Link chuẩn mới nhất)
local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Entity-Spawner-V2/main/init.luau"))()

---==================================================
--- ENTITY: SMILE (Thời gian chờ: 20 giây)
---==================================================
task.spawn(function()
    while true do
        task.wait(20)

        local smileSound = Instance.new("Sound")
        smileSound.Name = "SmileSound"
        smileSound.SoundId = "rbxassetid://9114223297"
        smileSound.Volume = 6
        smileSound.PlaybackSpeed = 1.1
        smileSound.Parent = SoundService

        local Smile = Spawner.createEntity({
            CustomName = "Smile",
            Model = "rbxassetid://108764900572976",
            Speed = 105,
            DelayTime = 2,
            HeightOffset = 0,
            CanKill = true,
            KillRange = 40,
            Backstrack = false,
            BreakLights = false,
            FlickerLights = true,
            FlickerDuration = 1,
            Cycles = {
                Min = 4,
                Max = 7,
                Wait = 1.7
            },
            CamShake = {
                Enabled = true,
                Values = {5, 25, 0.2, 3.2},
                Range = 100
            },
            CustomDialog = {"You died to the Smile...", "It lurks in dark places and moves extremely fast.", "Try hiding in a closet or breaking line of sight!"}
        })

        Smile:SetCallback("OnSpawned", function() smileSound:Play() end)
        Smile:SetCallback("OnDespawned", function()
            local fadeOut = TweenService:Create(smileSound, TweenInfo.new(1), {Volume = 0})
            fadeOut:Play()
            task.delay(1, function()
                smileSound:Stop()
                smileSound:Destroy()
            end)
        end)

        Smile:Run()
    end
end)
