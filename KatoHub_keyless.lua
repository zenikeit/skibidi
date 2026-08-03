local sg = Instance.new("ScreenGui")
sg.Name = "RonneiNotifBoard"
sg.ResetOnSpawn = false
sg.Parent = game:GetService("CoreGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 320, 0, 140)
frame.Position = UDim2.new(0.5, -160, 0.5, -70)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Parent = sg

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Thickness = 3
stroke.Color = Color3.fromRGB(255, 0, 128)
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Parent = frame

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 0.35, 0)
label.Position = UDim2.new(0, 0, 0.12, 0)
label.BackgroundTransparency = 1
label.Text = "TIKTOK: ronnei7.htk"
label.TextColor3 = Color3.fromRGB(0, 255, 255)
label.Font = Enum.Font.GothamBold
label.TextSize = 22
label.TextStrokeTransparency = 0.5
label.Parent = frame

local noteLabel = Instance.new("TextLabel")
noteLabel.Size = UDim2.new(1, 0, 0.25, 0)
noteLabel.Position = UDim2.new(0, 0, 0.48, 0)
noteLabel.BackgroundTransparency = 1
noteLabel.Text = "follow đi ko t ✂️ 🐦"
noteLabel.TextColor3 = Color3.fromRGB(255, 75, 75)
noteLabel.Font = Enum.Font.GothamMedium
noteLabel.TextSize = 15
noteLabel.TextStrokeTransparency = 0.7
noteLabel.Parent = frame

local timerLabel = Instance.new("TextLabel")
timerLabel.Size = UDim2.new(1, 0, 0.2, 0)
timerLabel.Position = UDim2.new(0, 0, 0.75, 0)
timerLabel.BackgroundTransparency = 1
timerLabel.Text = "Khởi chạy sau 5 giây..."
timerLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
timerLabel.Font = Enum.Font.Gotham
timerLabel.TextSize = 12
timerLabel.Parent = frame

-- Hiệu ứng viền đổi màu Neon
task.spawn(function()
    local counter = 0
    while sg and sg.Parent do
        counter = counter + 0.01
        stroke.Color = Color3.fromHSV(counter % 1, 0.9, 1)
        task.wait(0.01)
    end
end)

-- Đếm ngược 5 giây
for i = 5, 1, -1 do
    timerLabel.Text = "🔥 Khởi chạy sau " .. i .. " giây..."
    task.wait(1)
end

timerLabel.Text = "Đang tải Script..."

-- Hiệu ứng mờ dần (Fade out)
for opacity = 0, 1, 0.1 do
    frame.BackgroundTransparency = opacity
    label.TextTransparency = opacity
    noteLabel.TextTransparency = opacity
    timerLabel.TextTransparency = opacity
    stroke.Transparency = opacity
    task.wait(0.02)
end

sg:Destroy()

-- ==========================================
-- SCRIPT CỦA BẠN SẼ KHỞI CHẠY TẠI ĐÂY
-- ==========================================
local function Deobfuscate(Code)
    local Decompiled = loadstring(Code)()
    return Decompiled
end

local Raw = game:HttpGet("https://raw.githubusercontent.com/Lilwero20/KatoHub/refs/heads/main/KatoHub")
local Clean = Deobfuscate(Raw)
print(Clean)
