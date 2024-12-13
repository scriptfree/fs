local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "MVSD / Fusion Services", HidePremium = false, IntroEnabled = false, SaveConfig = nil})

OrionLib:MakeNotification({
    Name = "Notification",
    Content = "Successfully loaded.",
    Image = "rbxassetid://17829956110",
    Time = 3
})

function tp(pos) 
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
    end
    function killall()
        for i, v in pairs(game.Players:GetPlayers()) do
            spawn(function()
                pcall(function()
                    local ohVector31 = Vector3.new(-186.46624755859375, 49.74998474121094, math.random(-49.323232, 49.488882))
                    local ohVector32 = Vector3.new(-254.47802734375, 68.99893188476562, math.random(-49.323232, 49.488882))
                    local ohInstance3 = v.Character.LowerTorso
                    local ohVector34 = Vector3.new(-222.7018585205078, 60.864871978759766, math.random(-49.323232, 49.488882))
                    game:GetService("ReplicatedStorage").Remotes.Shoot:FireServer(ohVector31, ohVector32, ohInstance3, ohVector34)
                end)
            end)
        end
    end
    function equipgun()
        for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v:FindFirstChild("Fire") then
                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                break
            end
        end
    end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HighlightColor = Color3.new(1, 0, 0) -- Red color

local function createOutline(player)
if not player.Character then return end

for _, part in ipairs(player.Character:GetChildren()) do
    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
        if not part:FindFirstChild("HighlightOutline") then
            local adornment = Instance.new("BoxHandleAdornment")
            adornment.Name = "HighlightOutline"
            adornment.Adornee = part
            adornment.AlwaysOnTop = true
            adornment.ZIndex = 10
            adornment.Color3 = HighlightColor
            adornment.Transparency = 0.9 -- Increased transparency to make it less intrusive

            if part.Name == "Torso" or part.Name == "UpperTorso" then
                adornment.Size = Vector3.new(2, 2, 1) -- Fixed size for torso parts
            else
                adornment.Size = part.Size + Vector3.new(0.1, 0.1, 0.1) -- Slightly larger to wrap around
            end

            adornment.Parent = part
        end
    end
end
end

local function removeHighlights(player)
if player.Character then
    for _, part in ipairs(player.Character:GetChildren()) do
        if part:IsA("BasePart") then
            local highlight = part:FindFirstChild("HighlightOutline")
            if highlight then
                highlight:Destroy()
            end
        end
    end
end
end

local function updateHighlights()
local myTeam = LocalPlayer.Team
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        if player.Team == nil or myTeam == player.Team or not player.Character or not player.Character:FindFirstChild("Humanoid") or player.Character.Humanoid.Health <= 0 then
            removeHighlights(player)
        elseif myTeam and player.Team and myTeam ~= player.Team then
            createOutline(player)
        end
    end
end
end

local function initializePlayerEvents(player)
player.CharacterAdded:Connect(function()
    if getgenv().FLO then
        updateHighlights()
    end
end)
player.CharacterRemoving:Connect(function()
    removeHighlights(player)
end)
player:GetPropertyChangedSignal("Team"):Connect(function()
    if getgenv().FLO then
        updateHighlights()
    end
end)
end

for _, player in ipairs(Players:GetPlayers()) do
initializePlayerEvents(player)
end

Players.PlayerAdded:Connect(function(player)
initializePlayerEvents(player)
end)

Players.PlayerRemoving:Connect(function(player)
removeHighlights(player)
end)

LocalPlayer:GetPropertyChangedSignal("Team"):Connect(function()
if getgenv().FLO then
    updateHighlights()
end
end)


local Tab = Window:MakeTab({
Name = "Main",
Icon = "rbxassetid://18777407436",
PremiumOnly = false
})

Tab:AddToggle({
Name = "Esp",
Default = false,
Callback = function(t)
    getgenv().FLO = t
    if t then
        updateHighlights()
    else
        for _, player in ipairs(Players:GetPlayers()) do
            removeHighlights(player)
        end
    end
end    
})


Tab:AddButton({
Name = "Kill all",
Callback = function()
            
        equipgun()
        killall()
end
})


Tab:AddSlider({
Name = "Walkspeed",
Min = 16,
Max = 100,
Default = 16,
Color = Color3.fromRGB(255,255,255),
Increment = 1,
ValueName = "Speed",
Callback = function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end    
})

local Tab = Window:MakeTab({Name = "Credits",Icon = "rbxassetid://18719810809",PremiumOnly = false})

Tab:AddLabel("Developer")

Tab:AddParagraph("Xubs","Discord: nnty.")


local Tab = Window:MakeTab({Name = "Exit",Icon = "rbxassetid://9405925508",PremiumOnly = false})

Tab:AddButton({
Name = "Close UI",
Callback = function()
        OrionLib:MakeNotification({
            Name = "Notification",
            Content = "Closing UI...",
            Image = "rbxassetid://9405925508",
            Time = 2
        })
        wait(1)
        OrionLib:Destroy()

end
})

OrionLib:Init()
