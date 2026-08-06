-- ==========================================
-- DỮ LIỆU MÃ HÓA & HỆ THỐNG KEY BẮT BUỘC
-- ==========================================

local EncryptedLink = {104, 116, 116, 112, 115, 58, 47, 47, 108, 105, 110, 107, 52, 109, 46, 111, 114, 103, 47, 105, 110, 110, 73, 77}
local EncryptedTutLink = {104, 116, 116, 112, 115, 58, 47, 47, 99, 98, 114, 111, 119, 115, 101, 46, 103, 105, 116, 104, 117, 98, 46, 105, 111, 47, 98, 114, 111, 119, 115, 101, 47, 103, 101, 116, 107, 101, 121, 46, 104, 116, 109, 108}
local EncryptedScriptURL = {104, 116, 116, 112, 115, 58, 47, 47, 114, 97, 119, 46, 103, 105, 116, 104, 117, 98, 117, 115, 101, 114, 99, 111, 110, 116, 101, 110, 116, 46, 99, 111, 109, 47, 76, 105, 108, 119, 101, 114, 111, 50, 48, 47, 75, 97, 116, 111, 72, 117, 98, 47, 114, 101, 102, 115, 47, 104, 101, 97, 100, 115, 47, 109, 97, 105, 110, 47, 75, 97, 116, 111, 72, 117, 98}

local function DecodeBytes(bytes)
    local result = ""
    for _, byte in ipairs(bytes) do
        result = result .. string.char(byte)
    end
    return result
end

local KeyLink = DecodeBytes(EncryptedLink)
local TutorialVideoLink = DecodeBytes(EncryptedTutLink)
local RawScriptURL = DecodeBytes(EncryptedScriptURL)

local EncryptedValidKeys = {
    {75, 97, 116, 111, 72, 117, 98, 45, 112, 114, 101, 109, 101, 117, 109, 112, 114, 111, 118, 105, 112, 45, 56, 55, 57, 57}
}

local function CheckEncryptedKey(inputKey)
    for _, keyBytes in ipairs(EncryptedValidKeys) do
        if inputKey == DecodeBytes(keyBytes) then
            return true
        end
    end
    return false
end

-- ==========================================
-- GIAO DIỆN CUSTOM GUI
-- ==========================================

local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("GetKey_KatoHub_UI") then
    CoreGui.GetKey_KatoHub_UI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GetKey_KatoHub_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

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

task.spawn(function()
    local hue = 0
    while RainbowFrame and RainbowFrame.Parent do
        hue = (hue + 0.005) % 1
        RainbowFrame.BackgroundColor3 = Color3.fromHSV(hue, 0.9, 1)
        task.wait(0.03)
    end
end)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 6)
Title.BackgroundTransparency = 1
Title.Text = "Hệ Thống GetKey Kato Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

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

local NoteText = Instance.new("TextLabel")
NoteText.Size = UDim2.new(0.9, 0, 0, 125)
NoteText.Position = UDim2.new(0.05, 0, 0, 198)
NoteText.BackgroundColor3 = Color3.fromRGB(16, 13, 26)
NoteText.BackgroundTransparency = 0.2
NoteText.Text = "Lưu ý: Key tự động đổi mới sau mỗi 24h để chống share. Vui lòng vượt link lấy key mới để ủng hộ mình nhé!\n\nNote: Keys automatically refresh every 24h to prevent sharing. Please complete the link to get a new key!"
NoteText.TextColor3 = Color3.fromRGB(255, 153, 102)
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

CopyBtn.MouseButton1Click:Connect(function()
    setclipboard(KeyLink)
    ShowToast("Đã sao chép link! Dán lên trình duyệt để getkey.")
end)

TutorialBtn.MouseButton1Click:Connect(function()
    setclipboard(TutorialVideoLink)
    ShowToast("Đã sao chép link video hướng dẫn! Hãy dán vào web.")
end)

GetKeyBtn.MouseButton1Click:Connect(function()
    local userKey = KeyInput.Text:gsub("%s+", "")

    if CheckEncryptedKey(userKey) then
        ShowToast("Key Chính Xác! Đang mở Kato Hub...")
        task.wait(0.5)
        
        ScreenGui:Destroy()
        
        local success, err = pcall(function()
            loadstring(game:HttpGet(RawScriptURL))()
        end)
        
        if not success then
            warn("Lỗi tải Kato Hub:", err)
        end
    else
        ShowToast("Key không chính xác hoặc đã hết hạn! Vui lòng lấy key mới.")
    end
end)
