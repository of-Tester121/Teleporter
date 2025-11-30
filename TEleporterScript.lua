local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local savedCords = nil

--// GUI Creation
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 250)
frame.Position = UDim2.new(0.5, -175, 0.5, -125)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BackgroundTransparency = 1
frame.Parent = gui

frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "Made by Edu Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextColor3 = Color3.fromRGB(255, 255, 255)

--// Button Creation Function
local function makeButton(text, order)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -40, 0, 45)
	btn.Position = UDim2.new(0, 20, 0, 50 + ((order - 1) * 55))
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.Text = text
	btn.Font = Enum.Font.GothamSemibold
	btn.TextSize = 20
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.BorderSizePixel = 0
	btn.AutoButtonColor = false
	btn.Parent = frame

	-- Hover animation
	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {
			BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		}):Play()
	end)

	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {
			BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		}):Play()
	end)

	return btn
end

local saveBtn = makeButton("Save Cords", 1)
local tpBtn = makeButton("Teleport to Cords", 2)
local delBtn = makeButton("Delete Cords", 3)

--// Pop-up message
local function notify(msg)
	local n = Instance.new("TextLabel", frame)
	n.Size = UDim2.new(1, 0, 0, 30)
	n.Position = UDim2.new(0, 0, 1, 5)
	n.BackgroundTransparency = 1
	n.Text = msg
	n.Font = Enum.Font.GothamBold
	n.TextSize = 20
	n.TextColor3 = Color3.fromRGB(255, 255, 255)
	n.TextStrokeTransparency = 0.5

	local tween = TweenService:Create(n, TweenInfo.new(0.5), {
		TextTransparency = 0
	})
	tween:Play()

	task.wait(1.5)

	TweenService:Create(n, TweenInfo.new(0.5), {
		TextTransparency = 1
	}):Play()

	task.wait(0.5)
	n:Destroy()
end

--// Save cords
saveBtn.MouseButton1Click:Connect(function()
	savedCords = hrp.Position
	notify("Saved Cords!")
end)

--// Teleport to cords
tpBtn.MouseButton1Click:Connect(function()
	if savedCords == nil then
		notify("No cords detected!")
		return
	end

	hrp.CFrame = CFrame.new(savedCords)
	notify("Teleported!")
end)

--// Delete cords
delBtn.MouseButton1Click:Connect(function()
	if savedCords == nil then
		notify("No cords to delete!")
		return
	end

	savedCords = nil
	notify("Cords Deleted!")
end)

--// Fancy fade-in animation
TweenService:Create(frame, TweenInfo.new(0.5), {
	BackgroundTransparency = 0
}):Play()
