---====== Load spawner ======---

local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Entity-Spawner-V2/main/init.luau"))()
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

---====== Create entity ======---

local entity = Spawner:Create({
	Entity = {
		Name = "Scary Entity",
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
		Range = 100,
		Values = {1.5, 20, 0.1, 1} -- Magnitude, Roughness, FadeIn, FadeOut
	},
	Movement = {
		Speed = 100,
		Delay = 2,
		Reversed = false
	},
	Rebounding = {
		Enabled = true,
		Type = "Ambush",
		Min = 1,
		Max = 1,
		Delay = 2
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
			"You died by Scary.... Thing",
			"Ground transit means it will arrive",
			"Hide",
			"Good luck next time"
		},
		Cause = "Scary Thing....?"
	}
})

---====== Custom Logic & Callbacks ======---

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

entity:SetCallback("OnSpawned", function()
    applyScarySky()
    spawnSound:Play()
end)

entity:SetCallback("OnDespawned", function()
    TweenService:Create(spawnSound, TweenInfo.new(2), {Volume = 0}):Play()
    task.delay(2, function()
        spawnSound:Stop()
        spawnSound:Destroy()
    end)
    removeScarySky()
end)

---====== Run entity trong vòng lặp (Thời gian chờ: 35 giây) ======---

task.spawn(function()
    while true do
        task.wait(35)
        entity:Run(true)
    end
end)
