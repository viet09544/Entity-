---====== Load spawner ======---

local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Entity-Spawner-V2/main/init.luau"))()
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")

---====== Create entity ======---

local entity = Spawner:Create({
	Entity = {
		Name = "Smile",
		Asset = "rbxassetid://108764900572976",
		HeightOffset = 0
	},
	Lights = {
		Flicker = {
			Enabled = true,
			Duration = 1
		},
		Shatter = false,
		Repair = false
	},
	Earthquake = {
		Enabled = false
	},
	CameraShake = {
		Enabled = true,
		Range = 100,
		Values = {5, 25, 0.2, 3.2} -- Magnitude, Roughness, FadeIn, FadeOut
	},
	Movement = {
		Speed = 105,
		Delay = 2,
		Reversed = false
	},
	Rebounding = {
		Enabled = true,
		Type = "Ambush",
		Min = 4,
		Max = 7,
		Delay = 1.7
	},
	Damage = {
		Enabled = true,
		IgnoreHiding = false,
		Range = 40,
		Amount = 125
	},
	Crucifixion = {
        Type = "Curious",
		Enabled = true,
		Range = 40,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Curious",
		Hints = {
			"You died to the Smile...",
			"It lurks in dark places and moves extremely fast.",
			"Try hiding in a closet or breaking line of sight!"
		},
		Cause = "Smile"
	}
})

---====== Debug entity / Callbacks ======---

local smileSound = Instance.new("Sound")
smileSound.Name = "SmileSound"
smileSound.SoundId = "rbxassetid://9114223297"
smileSound.Volume = 6
smileSound.PlaybackSpeed = 1.1
smileSound.Parent = SoundService

entity:SetCallback("OnSpawned", function()
    smileSound:Play()
end)

entity:SetCallback("OnStartMoving", function()
    print("Smile has started moving")
end)

entity:SetCallback("OnDespawned", function()
    local fadeOut = TweenService:Create(smileSound, TweenInfo.new(1), {Volume = 0})
    fadeOut:Play()
    task.delay(1, function()
        smileSound:Stop()
        smileSound:Destroy()
    end)
end)

---====== Run entity trong vòng lặp (Thời gian chờ: 20 giây) ======---

task.spawn(function()
    while true do
        task.wait(20)
        entity:Run(true)
    end
end)
