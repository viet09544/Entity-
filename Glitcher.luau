---====== Load spawner ======---

local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Entity-Spawner-V2/main/init.luau"))()
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

---====== Create entity ======---

local entity = Spawner:Create({
	Entity = {
		Name = "Glitcher",
		Asset = "rbxassetid://13124351651",
		HeightOffset = 1
	},
	Lights = {
		Flicker = {
			Enabled = true,
			Duration = 3.5
		},
		Shatter = true,
		Repair = false
	},
	Earthquake = {
		Enabled = true
	},
	CameraShake = {
		Enabled = true,
		Range = 120,
		Values = {8, 35, 0.1, 4} -- Magnitude, Roughness, FadeIn, FadeOut
	},
	Movement = {
		Speed = 160,
		Delay = 1,
		Reversed = true
	},
	Rebounding = {
		Enabled = true,
		Type = "Ambush",
		Min = 3,
		Max = 6,
		Delay = 0.5
	},
	Damage = {
		Enabled = true,
		IgnoreHiding = false,
		Range = 50,
		Amount = 80
	},
	Crucifixion = {
        Type = "Curious",
		Enabled = true,
		Range = 40,
		Resist = true,
		Break = true
	},
	Death = {
		Type = "Curious",
		Hints = {
			"You died to Glitcher...",
			"It distorts reality and moves in unpredictable patterns.",
			"Pay attention to extreme camera shaking and hide early!"
		},
		Cause = "Glitcher"
	}
})

---====== Custom Logic & Callbacks ======---

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

entity:SetCallback("OnSpawned", function()
    glitchGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    glitchSound:Play()
    TweenService:Create(glitchFrame, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {BackgroundTransparency = 0.7}):Play()
    TweenService:Create(glitchText, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {TextTransparency = 0.2}):Play()
end)

entity:SetCallback("OnDespawned", function()
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

---====== Run entity trong vòng lặp (Thời gian chờ: 25 giây) ======---

task.spawn(function()
    while true do
        task.wait(25)
        entity:Run(true)
    end
end)
