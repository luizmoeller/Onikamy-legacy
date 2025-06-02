-- Onikami Auto Farm + Boss (Delta Executor Mobile)

local gui = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 160)
frame.Position = UDim2.new(0, 30, 0, 30)
frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
frame.BorderSizePixel = 0

local farmBtn = Instance.new("TextButton", frame)
farmBtn.Size = UDim2.new(1, 0, 0, 40)
farmBtn.Position = UDim2.new(0, 0, 0, 10)
farmBtn.Text = "Auto Farm"
farmBtn.BackgroundColor3 = Color3.new(0.2, 0.6, 0.2)
farmBtn.TextColor3 = Color3.new(1,1,1)
farmBtn.Font = Enum.Font.SourceSansBold
farmBtn.TextSize = 18

local bossBtn = Instance.new("TextButton", frame)
bossBtn.Size = UDim2.new(1, 0, 0, 40)
bossBtn.Position = UDim2.new(0, 0, 0, 60)
bossBtn.Text = "Farm Boss"
bossBtn.BackgroundColor3 = Color3.new(0.6, 0.4, 0.1)
bossBtn.TextColor3 = Color3.new(1,1,1)
bossBtn.Font = Enum.Font.SourceSansBold
bossBtn.TextSize = 18

local stopBtn = Instance.new("TextButton", frame)
stopBtn.Size = UDim2.new(1, 0, 0, 40)
stopBtn.Position = UDim2.new(0, 0, 0, 110)
stopBtn.Text = "Parar"
stopBtn.BackgroundColor3 = Color3.new(0.6, 0.2, 0.2)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.SourceSansBold
stopBtn.TextSize = 18

local farming = false

function getHRP()
    local p = game.Players.LocalPlayer
    local char = p.Character or p.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart")
end

function attackNearest(filter)
    local hrp = getHRP()

    while farming do
        local closest, dist = nil, math.huge
        for _, mob in pairs(workspace:GetDescendants()) do
            if mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                if mob.Name ~= game.Players.LocalPlayer.Name and (not filter or mob.Name:lower():find(filter)) then
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

farmBtn.MouseButton1Click:Connect(function()
    if not farming then
        farming = true
        attackNearest(nil) -- todos
    end
end)

bossBtn.MouseButton1Click:Connect(function()
    if not farming then
        farming = true
        attackNearest("boss") -- filtra por "boss" no nome
    end
end)

stopBtn.MouseButton1Click:Connect(function()
    farming = false
end)
