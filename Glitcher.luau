--==================================================
-- KHỞI TẠO DỊCH VỤ VÀ MODULE ENTITY SPAWNER V2 (GLITCHER)
--==================================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer

-- Tải module Vynixu's Entity Spawner V2
local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Entity-Spawner-V2/main/init.luau"))()

---==================================================
--- 4. ENTITY: GLITCHER (Thời gian chờ: 25 giây)
---==================================================
task.spawn(function()
    while true do
        task.wait(25)

        local glitchSound = Instance.new("Sound")
        glitchSound.Name = "GlitcherSound"
        glitchSound.SoundId = "rbxassetid://9114225501"
        glitchSound.Volume = 8
        glitchSound.PlaybackSpeed = 0.8
        glitchSound.Parent = SoundService

        local glitchGui = Instance.new("ScreenGui")
        glitchGui.Name = "GlitcherEffectGui"
        glitchGui.IgnoreGuiInset = true
        glitchGui.DisplayOrder = 99999
        
        local glitchFrame = Instance.new("Frame")
        glitchFrame.Size = UDim2.new(1, 0, 1, 0)
        glitchFrame.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        glitchFrame.BackgroundTransparency = 1
        glitchFrame.Parent = glitchGui
        
        local glitchText = Instance.new("TextLabel")
        glitchText.Size = UDim2.new(1, 0, 0, 100)
        glitchText.Position = UDim2.new(0, 0, 0.4, 0)
        glitchText.BackgroundTransparency = 1
        glitchText.TextColor3 = Color3.fromRGB(255, 0, 0)
        glitchText.TextScaled = true
        glitchText.Font = Enum.Font.SpecialElite
        glitchText.Text = "ERR_GLITCH_SYSTEM_OVERLOAD"
        glitchText.TextTransparency = 1
        glitchText.Parent = glitchGui

        glitchGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

        local Glitcher = Spawner.createEntity({
            CustomName = "Glitcher",
            Model = "rbxassetid://13124351651",
            Speed = 160,
            DelayTime = 1,
            HeightOffset = 1,
            CanKill = true,
            KillRange = 50,
            Backstrack = true,
            BreakLights = true,
            FlickerLights = true,
            FlickerDuration = 3.5,
            Cycles = {
                Min = 3,
                Max = 6,
                Wait = 0.5
            },
            CamShake = {
                Enabled = true,
                Values = {8, 35, 0.1, 4},
                Range = 120
            },
            CustomDialog = {"You died to Glitcher...", "It distorts reality and moves in unpredictable patterns.", "Pay attention to extreme camera shaking and hide early!"}
        })

        Glitcher:SetCallback("OnSpawned", function()
            glitchSound:Play()
            TweenService:Create(glitchFrame, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {BackgroundTransparency = 0.7}):Play()
            TweenService:Create(glitchText, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {TextTransparency = 0.2}):Play()
        end)

        Glitcher:SetCallback("OnDespawned", function()
            task.delay(0.367, function()
                TweenService:Create(glitchSound, TweenInfo.new(0.5), {Volume = 0}):Play()
                TweenService:Create(glitchFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
                TweenService:Create(glitchText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()

                task.wait(0.5)
                glitchSound:Stop()
                glitchSound:Destroy()
                glitchGui:Destroy()
            end)
        end)

        Glitcher:Run()
    end
end)
