local gui = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 160)
frame.Position = UDim2.new(0, 30, 0, 30)
frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)

local farming = false

local function addButton(text, yPos, color, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Position = UDim2.new(0, 0, 0, yPos)
    btn.Text = text
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.MouseButton1Click:Connect(callback)
end

local function getHRP()
    local p = game.Players.LocalPlayer
    local char = p.Character or p.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart")
end

local function attackNearest(filter)
    local hrp = getHRP()
    while farming do
        local closest, dist = nil, math.huge
        for _, mob in pairs(workspace:GetDescendants()) do
            if mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 and mob.Name ~= game.Players.LocalPlayer.Name then
                if not filter or mob.Name:lower():find(filter) then
                    local d = (mob.HumanoidRootPart.Position - hrp.Position).magnitude
                    if d < dist then
                        closest = mob
                        dist = d
                    end
                end
            end
        end
        if closest then
            hrp.CFrame = closest.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
        end
        task.wait(0.5)
    end
end

addButton("Auto Farm", 10, Color3.new(0.2, 0.6, 0.2), function()
    if not farming then
        farming = true
        attackNearest(nil)
    end
end)

addButton("Farm Boss", 60, Color3.new(0.6, 0.4, 0.1), function()
    if not farming then
        farming = true
        attackNearest("boss")
    end
end)

addButton("Parar", 110, Color3.new(0.6, 0.2, 0.2), function()
    farming = false
end)
