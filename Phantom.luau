---====== Load spawner ======---

local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Entity-Spawner-V2/main/init.luau"))()
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")

---====== Create entity ======---

local entity = Spawner:Create({
	Entity = {
		Name = "Phantom",
		Asset = "rbxassetid://13124351651",
		HeightOffset = 0
	},
	Lights = {
		Flicker = {
			Enabled = true,
			Duration = 1.5
		},
		Shatter = true,
		Repair = false
	},
	Earthquake = {
		Enabled = true
	},
	CameraShake = {
		Enabled = true,
		Range = 90,
		Values = {4, 20, 0.25, 2.5} -- Magnitude, Roughness, FadeIn, FadeOut
	},
	Movement = {
		Speed = 140,
		Delay = 1.5,
		Reversed = false
	},
	Rebounding = {
		Enabled = true,
		Type = "Ambush",
		Min = 2,
		Max = 12,
		Delay = 0.9
	},
	Damage = {
		Enabled = true,
		IgnoreHiding = false,
		Range = 40,
		Amount = 15
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
			"You died to Phantom...",
			"It moves at blinding speeds and rebounds multiple times",
			"Listen for its approach and hide immediately!"
		},
		Cause = "Phantom"
	}
})

---====== Custom Logic & Callbacks ======---

local phantomSound = Instance.new("Sound")
phantomSound.Name = "PhantomSound"
phantomSound.SoundId = "rbxassetid://9114224856"
phantomSound.Volume = 6
phantomSound.PlaybackSpeed = 1.4
phantomSound.Parent = SoundService

entity:SetCallback("OnSpawned", function()
    phantomSound:Play()
end)

entity:SetCallback("OnDespawned", function()
    TweenService:Create(phantomSound, TweenInfo.new(1.5), {Volume = 0}):Play()
    task.delay(1.5, function()
        phantomSound:Stop()
        phantomSound:Destroy()
    end)
end)

---====== Run entity trong vòng lặp (Thời gian chờ: 45 giây) ======---

task.spawn(function()
    while true do
        task.wait(45)
        entity:Run(true)
    end
end)
