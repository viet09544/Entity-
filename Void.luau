---====== Load spawner ======---

local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Entity-Spawner-V2/main/init.luau"))()
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

---====== Create entity ======---

local entity = Spawner:Create({
	Entity = {
		Name = "Void",
		Asset = "rbxassetid://13124351651",
		HeightOffset = 0
	},
	Lights = {
		Flicker = {
			Enabled = true,
			Duration = 0
		},
		Shatter = true,
		Repair = false
	},
	Earthquake = {
		Enabled = true
	},
	CameraShake = {
		Enabled = true,
		Range = 110,
		Values = {6, 30, 0.2, 3} -- Magnitude, Roughness, FadeIn, FadeOut
	},
	Movement = {
		Speed = 130,
		Delay = 2.5,
		Reversed = false
	},
	Rebounding = {
		Enabled = true,
		Type = "Ambush",
		Min = 2,
		Max = 4,
		Delay = 1.2
	},
	Damage = {
		Enabled = true,
		IgnoreHiding = false,
		Range = 45,
		Amount = 100
	},
	Crucifixion = {
        Type = "Curious",
		Enabled = true,
		Range = 35,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Curious",
		Hints = {
			"You died to Void...",
			"It plunges the hotel into absolute darkness.",
			"Keep your flashlight ready and hide quickly!"
		},
		Cause = "Void"
	}
})

---====== Custom Logic & Callbacks ======---

local originalAmbient = Lighting.Ambient
local originalOutdoorAmbient = Lighting.OutdoorAmbient
local originalBrightness = Lighting.Brightness

local voidSound = Instance.new("Sound")
voidSound.Name = "VoidSound"
voidSound.SoundId = "rbxassetid://9114226194"
voidSound.Volume = 8
voidSound.PlaybackSpeed = 0.4
voidSound.Parent = SoundService

entity:SetCallback("OnSpawned", function()
    Lighting.Ambient = Color3.fromRGB(0, 0, 0)
    Lighting.OutdoorAmbient = Color3.fromRGB(0, 0, 0)
    Lighting.Brightness = 0
    voidSound:Play()
end)

entity:SetCallback("OnDespawned", function()
    TweenService:Create(voidSound, TweenInfo.new(2), {Volume = 0}):Play()
    Lighting.Ambient = originalAmbient
    Lighting.OutdoorAmbient = originalOutdoorAmbient
    Lighting.Brightness = originalBrightness

    task.delay(2, function()
        voidSound:Stop()
        voidSound:Destroy()
    end)
end)

---====== Run entity trong vòng lặp (Thời gian chờ: 50 giây) ======---

task.spawn(function()
    while true do
        task.wait(50)
        entity:Run(true)
    end
end)
