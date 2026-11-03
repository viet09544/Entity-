---====== Load spawner ======---

local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Entity-Spawner-V2/main/init.luau"))()
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

---====== Run entity trong vòng lặp (Thời gian chờ: ngẫu nhiên từ 30 - 50 giây) ======---

task.spawn(function()
    while true do
        task.wait(math.random(30, 50))

        local eyesSound = Instance.new("Sound")
        eyesSound.Name = "GroupDarknessEyeSound"
        eyesSound.SoundId = "rbxassetid://9114224164"
        eyesSound.Volume = 5
        eyesSound.PlaybackSpeed = 1.2
        eyesSound.Looped = true
        eyesSound.Parent = SoundService

        local eyesCount = math.random(1, 2)
        local activeModels = {}
        eyesSound:Play()

        for i = 1, eyesCount do
            ---====== Create entity ======---
            local entity = Spawner:Create({
                Entity = {
                    Name = "TheDarknessEye_" .. i,
                    Asset = "rbxassetid://108764900572976",
                    HeightOffset = math.random(1, 4)
                },
                Lights = {
                    Flicker = {
                        Enabled = false,
                        Duration = 0
                    },
                    Shatter = false,
                    Repair = false
                },
                Earthquake = {
                    Enabled = false
                },
                CameraShake = {
                    Enabled = true,
                    Range = 80,
                    Values = {2, 10, 0.1, 1} -- Magnitude, Roughness, FadeIn, FadeOut
                },
                Movement = {
                    Speed = 0,
                    Delay = 0,
                    Reversed = false
                },
                Rebounding = {
                    Enabled = false,
                    Type = "Ambush",
                    Min = 1,
                    Max = 1,
                    Delay = 0
                },
                Damage = {
                    Enabled = true,
                    IgnoreHiding = true,
                    Range = 50,
                    Amount = 10
                },
                Crucifixion = {
                    Type = "Curious",
                    Enabled = true,
                    Range = 30,
                    Resist = false,
                    Break = true
                },
                Death = {
                    Type = "Curious",
                    Hints = {
                        "You died to The Darkness Eye...",
                        "Don't look at them when entering the room!"
                    },
                    Cause = "The Darkness Eye"
                }
            })

            entity:SetCallback("OnSpawned", function(model)
                if model then table.insert(activeModels, model) end
            end)

            entity:Run(true)
        end

        local currentRoomVal = LocalPlayer:GetAttribute("CurrentRoom") or 1
        local dismissed = false
        local connection
        connection = RunService.Heartbeat:Connect(function()
            local newRoomVal = LocalPlayer:GetAttribute("CurrentRoom")
            if newRoomVal and newRoomVal > currentRoomVal then
                dismissed = true
                if connection then connection:Disconnect() end
            end
        end)

        local timer = 0
        while not dismissed and timer < 15 do
            task.wait(0.5)
            timer = timer + 0.5
        end

        if connection then connection:Disconnect() end

        TweenService:Create(eyesSound, TweenInfo.new(0.5), {Volume = 0}):Play()
        task.delay(0.5, function()
            eyesSound:Stop()
            eyesSound:Destroy()
        end)

        for _, mdl in ipairs(activeModels) do
            if mdl and mdl.Parent then mdl:Destroy() end
        end
    end
end)
