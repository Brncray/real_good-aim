local Player = game:GetService("Players").LocalPlayer


local aimbot = {}

local aimbotEnabled = false

function FindNearestHumanoid()
    local nearestHumanoid = nil
    local shortestDistance = math.huge

    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player ~= Player and player.Character and player.Character:FindFirstChild("Humanoid") then
            local distance = (Player.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestHumanoid = player.Character.Humanoid
            end
        end
    end

    return nearestHumanoid
end

function AimAtHumanoid(humanoid)
    if humanoid and humanoid.Parent and humanoid.Parent:FindFirstChild("Head") then
        local head = humanoid.Parent.Head
        if head and head.Parent then
            local camera = game:GetService("Workspace").CurrentCamera
            local headPosition = head.Position
            local cameraPosition = camera.CFrame.Position
            local direction = (headPosition - cameraPosition).unit
            local targetCFrame = CFrame.new(cameraPosition, cameraPosition + direction)
            camera.CFrame = camera.CFrame:Lerp(targetCFrame, 0.2) -- Interpolation for smoother aiming
            -- doesnt fucking work properly but i'll fix later
        end
    end
end

function aimbot.AimbotLoop()
    while aimbotEnabled do
        local nearestHumanoid = FindNearestHumanoid()
        AimAtHumanoid(nearestHumanoid)
        task.wait(0.05) -- Less delay more updates

    end
end


function aimbot.ToggleAimbot(Value)
    aimbotEnabled = Value
    if aimbotEnabled then
        task.spawn(aimbot.AimbotLoop())
    else
    end

end

return aimbot