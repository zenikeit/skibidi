-- ==========================================
-- DỮ LIỆU MÃ HÓA & HỆ THỐNG KEY 24H
-- ==========================================

-- Link GetKey (https://zenikeit.github.io/skibidi/go.html)
local EncryptedLink = {104, 116, 116, 112, 115, 58, 47, 47, 108, 105, 110, 107, 52, 109, 46, 111, 114, 103, 47, 105, 110, 110, 73, 77}

-- Link Video Hướng Dẫn GetKey
local TutorialVideoLink = "https://cbrowse.github.io/browse/getkey.html"

-- Script Gốc Kato Hub (Đã mã hóa Bytecode)
local EncryptedScript = {108, 111, 97, 100, 115, 116, 114, 105, 110, 103, 40, 103, 97, 109, 101, 58, 72, 116, 116, 112, 71, 101, 116, 40, 34, 104, 116, 116, 112, 115, 58, 47, 47, 114, 97, 119, 46, 103, 105, 116, 104, 117, 98, 117, 115, 101, 114, 99, 111, 110, 116, 101, 110, 116, 46, 99, 111, 109, 47, 76, 105, 108, 119, 101, 114, 111, 50, 48, 47, 75, 97, 116, 111, 72, 117, 98, 47, 114, 101, 102, 115, 47, 104, 101, 97, 100, 115, 47, 109, 97, 105, 110, 47, 75, 97, 116, 111, 72, 117, 98, 34, 41, 41, 40, 41}

-- Hàm giải mã bytecode
local function Decode(bytes)
    local result = ""
    for _, byte in ipairs(bytes) do
        result = result .. string.char(byte)
    end
    return result
end

local KeyLink = Decode(EncryptedLink)

-- ==========================================
-- HỆ THỐNG TÍNH KEY ĐỘNG THEO NGÀY (24H)
-- ==========================================
local saveFileName = "KatoHub_LastKeyDate.txt"

local function getTodayKey()
    local date = os.date("!*t")
    local dateSeed = date.year * 10000 + date.month * 100 + date.day
    local dynamicKey = string.format("KATO-%04d%02d%02d-PASS", date.year, date.month, date.day)
    local formattedDate = string.format("%02d/%02d/%d", date.day, date.month, date.year)
    
    return dynamicKey, tostring(dateSeed), formattedDate
end

local DynamicKey, TodaySeed, TodayFormattedDate = getTodayKey()
local AlternativeKey = "NETPLUS-55955A03F15D8556" -- Key dự phòng cố định

-- ==========================================
-- GIAO DIỆN CUSTOM GUI (MỞ RỘNG THÊM NÚT HƯỚNG DẪN)
-- ==========================================

local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("GetKey_KatoHub_UI") then
    CoreGui.GetKey_KatoHub_UI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GetKey_KatoHub_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- Frame Viền Cầu Vồng Ngoài (Tăng chiều cao lên chút để vừa nút hướng dẫn)
local RainbowFrame = Instance.new("Frame")
RainbowFrame.Name = "RainbowFrame"
RainbowFrame.Size = UDim2.new(0, 370, 0, 360)
RainbowFrame.Position = UDim2.new(0.5, -185, 0.5, -180)
RainbowFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
RainbowFrame.BorderSizePixel = 0
RainbowFrame.Parent = ScreenGui

local RainbowCorner = Instance.new("UICorner")
RainbowCorner.CornerRadius = UDim.new(0, 14)
RainbowCorner.Parent = RainbowFrame

-- Frame Menu Chính (#0B0813)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(1, -6, 1, -6)
MainFrame.Position = UDim2.new(0, 3, 0, 3)
MainFrame.BackgroundColor3 = Color3.fromRGB(11, 8, 19)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = RainbowFrame

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Hiệu ứng viền cầu vồng nhấp nháy
task.spawn(function()
    local hue = 0
    while RainbowFrame and RainbowFrame.Parent do
        hue = (hue + 0.005) % 1
        RainbowFrame.BackgroundColor3 = Color3.fromHSV(hue, 0.9, 1)
        task.wait(0.03)
    end
end)

-- Tiêu đề Menu
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 6)
Title.BackgroundTransparency = 1
Title.Text = "Hệ Thống GetKey Kato Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

-- Nút Sao Chép Link GetKey
local CopyBtn = Instance.new("TextButton")
CopyBtn.Size = UDim2.new(0.9, 0, 0, 32)
CopyBtn.Position = UDim2.new(0.05, 0, 0, 40)
CopyBtn.BackgroundColor3 = Color3.fromRGB(22, 18, 36)
CopyBtn.Text = "📋 Sao chép Link GetKey"
CopyBtn.TextColor3 = Color3.fromRGB(0, 240, 255)
CopyBtn.TextSize = 13
CopyBtn.Font = Enum.Font.SourceSansBold
CopyBtn.Parent = MainFrame

local CopyCorner = Instance.new("UICorner")
CopyCorner.CornerRadius = UDim.new(0, 6)
CopyCorner.Parent = CopyBtn

-- Nút Xem Video Hướng Dẫn GetKey
local TutorialBtn = Instance.new("TextButton")
TutorialBtn.Size = UDim2.new(0.9, 0, 0, 32)
TutorialBtn.Position = UDim2.new(0.05, 0, 0, 78)
TutorialBtn.BackgroundColor3 = Color3.fromRGB(40, 30, 60)
TutorialBtn.Text = "🎥 Xem Video Hướng Dẫn GetKey"
TutorialBtn.TextColor3 = Color3.fromRGB(255, 153, 102)
TutorialBtn.TextSize = 13
TutorialBtn.Font = Enum.Font.SourceSansBold
TutorialBtn.Parent = MainFrame

local TutCorner = Instance.new("UICorner")
TutCorner.CornerRadius = UDim.new(0, 6)
TutCorner.Parent = TutorialBtn

-- Ô nhập Key
local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0.9, 0, 0, 34)
KeyInput.Position = UDim2.new(0.05, 0, 0, 116)
KeyInput.BackgroundColor3 = Color3.fromRGB(22, 18, 36)
KeyInput.PlaceholderText = "Nhập Key vào đây..."
KeyInput.PlaceholderColor3 = Color3.fromRGB(130, 120, 150)
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.TextSize = 14
KeyInput.Font = Enum.Font.SourceSansBold
KeyInput.ClearTextOnFocus = false
KeyInput.Parent = MainFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 6)
InputCorner.Parent = KeyInput

-- Nút GET KEY
local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0.9, 0, 0, 36)
GetKeyBtn.Position = UDim2.new(0.05, 0, 0, 156)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 240, 255)
GetKeyBtn.Text = "XÁC NHẬN GET KEY"
GetKeyBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
GetKeyBtn.TextSize = 15
GetKeyBtn.Font = Enum.Font.SourceSansBold
GetKeyBtn.Parent = MainFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 6)
BtnCorner.Parent = GetKeyBtn

-- Bảng Note ghi chú chữ nhỏ màu vàng đỏ nhẹ (#FF9966) kèm bản dịch tiếng Anh
local NoteText = Instance.new("TextLabel")
NoteText.Size = UDim2.new(0.9, 0, 0, 125)
NoteText.Position = UDim2.new(0.05, 0, 0, 198)
NoteText.BackgroundColor3 = Color3.fromRGB(16, 13, 26)
NoteText.BackgroundTransparency = 0.2
NoteText.Text = "Lưu ý: Key tự động đổi mới sau mỗi 24h để chống share. Vui lòng vượt link lấy key mới để ủng hộ mình nhé!\n\nNote: Keys automatically refresh every 24h to prevent sharing. Please complete the link to get a new key!"
NoteText.TextColor3 = Color3.fromRGB(255, 153, 102) -- Màu vàng đỏ nhẹ
NoteText.TextSize = 10
NoteText.Font = Enum.Font.SourceSans
NoteText.TextWrapped = true
NoteText.TextYAlignment = Enum.TextYAlignment.Top
NoteText.Parent = MainFrame

local NotePadding = Instance.new("UIPadding")
NotePadding.PaddingTop = UDim.new(0, 6)
NotePadding.PaddingLeft = UDim.new(0, 6)
NotePadding.PaddingRight = UDim.new(0, 6)
NotePadding.Parent = NoteText

local NoteCorner = Instance.new("UICorner")
NoteCorner.CornerRadius = UDim.new(0, 6)
NoteCorner.Parent = NoteText

-- Thông báo nổi (Toast Notification)
local function ShowToast(text)
    local Toast = Instance.new("TextLabel")
    Toast.Size = UDim2.new(0, 320, 0, 45)
    Toast.Position = UDim2.new(0.5, -160, 0.12, 0)
    Toast.BackgroundColor3 = Color3.fromRGB(0, 240, 255)
    Toast.Text = text
    Toast.TextColor3 = Color3.fromRGB(0, 0, 0)
    Toast.TextSize = 12
    Toast.Font = Enum.Font.SourceSansBold
    Toast.TextWrapped = true
    Toast.Parent = ScreenGui
    
    local ToastCorner = Instance.new("UICorner")
    ToastCorner.CornerRadius = UDim.new(0, 8)
    ToastCorner.Parent = Toast

    task.delay(3.5, function()
        if Toast then Toast:Destroy() end
    end)
end

-- ==========================================
-- XỬ LÝ SỰ KIỆN TRÊN SCRIPT
-- ==========================================

-- Bấm Sao Chép Link GetKey
CopyBtn.MouseButton1Click:Connect(function()
    setclipboard(KeyLink)
    ShowToast("Đã sao chép link! Dán lên trình duyệt để getkey.")
end)

-- Bấm Xem Video Hướng Dẫn
TutorialBtn.MouseButton1Click:Connect(function()
    setclipboard(TutorialVideoLink)
    ShowToast("Đã sao chép link video hướng dẫn! Hãy dán vào web.")
end)

-- Bấm XÁC NHẬN GET KEY
GetKeyBtn.MouseButton1Click:Connect(function()
    local userKey = KeyInput.Text:gsub("%s+", "")
    
    local lastSavedSeed = ""
    if isfile and isfile(saveFileName) then
        lastSavedSeed = readfile(saveFileName)
    end

    if userKey == DynamicKey or userKey == AlternativeKey then
        if writefile then
            writefile(saveFileName, TodaySeed)
        end
        
        ShowToast("Key Chính Xác! Đang mở Kato Hub...")
        task.wait(1)
        
        -- Xóa Menu GetKey
        ScreenGui:Destroy()
        
        -- Kích hoạt Script Kato Hub gốc
        local RawScript = Decode(EncryptedScript)
        local func, err = loadstring(RawScript)
        if func then
            func()
        else
            warn("Lỗi tải Kato Hub:", err)
        end
        
    elseif lastSavedSeed ~= "" and lastSavedSeed ~= TodaySeed then
        ShowToast("Key đã hết hạn! Vui lòng getkey ngày " .. TodayFormattedDate .. ".\n(Your key has expired! Please get today's key.)")
    else
        ShowToast("Key không chính xác hoặc đã hết hạn 24h!\n(Invalid key or expired!)")
    end
end)
