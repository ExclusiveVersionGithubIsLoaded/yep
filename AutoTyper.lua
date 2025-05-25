--[[

 /$$       /$$$$$$ /$$   /$$  /$$$$$$   /$$$$$$         /$$$$$$  /$$   /$$ /$$       /$$$$$$      
| $$      |_  $$_/| $$$ | $$ /$$__  $$ /$$__  $$       /$$__  $$| $$  | $$| $$      |_  $$_/      
| $$        | $$  | $$$$| $$| $$  \__/| $$  \ $$      | $$  \__/| $$  | $$| $$        | $$        
| $$        | $$  | $$ $$ $$| $$ /$$$$| $$$$$$$$      | $$ /$$$$| $$  | $$| $$        | $$        
| $$        | $$  | $$  $$$$| $$|_  $$| $$__  $$      | $$|_  $$| $$  | $$| $$        | $$        
| $$        | $$  | $$\  $$$| $$  \ $$| $$  | $$      | $$  \ $$| $$  | $$| $$        | $$        
| $$$$$$$$ /$$$$$$| $$ \  $$|  $$$$$$/| $$  | $$      |  $$$$$$/|  $$$$$$/| $$$$$$$$ /$$$$$$      
|________/|______/|__/  \__/ \______/ |__/  |__/       \______/  \______/ |________/|______/      
                                                                                                  
                                                                                                  
                                                                                                                                                                                   
]]--

local text_to_copy = "https://discord.gg/sn6BGaeBKQ"

if setclipboard then
    setclipboard(text_to_copy)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Discord Copied",
        Text = "Discord invite link copied to your clipboard",
        Duration = 3
    })
else
    warn("Your shitty exploit with 0% unc won't run this best script")
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
while not player do
    wait()
    player = Players.LocalPlayer
end

-- Конфигурация стиля
local colors = {
    background = Color3.fromRGB(15, 15, 25),
    primary = Color3.fromRGB(140, 70, 255),
    secondary = Color3.fromRGB(50, 200, 255),
    error = Color3.fromRGB(230, 70, 70),
    text = Color3.fromRGB(245, 245, 255),
    accent = Color3.fromRGB(180, 120, 255)
}

-- Создаем GUI для ключа
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "BludKeySystem"
KeyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
KeyGui.Parent = player:WaitForChild("PlayerGui")

-- Основной контейнер
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 250)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
MainFrame.BackgroundColor3 = colors.background
MainFrame.BackgroundTransparency = 0.2
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Parent = KeyGui

local corner = Instance.new("UICorner", MainFrame)
corner.CornerRadius = UDim.new(0, 12)

-- Неоновая подсветка
local glow = Instance.new("ImageLabel")
glow.Name = "Glow"
glow.BackgroundTransparency = 1
glow.Size = UDim2.new(1, 30, 1, 30)
glow.Position = UDim2.new(0, -15, 0, -15)
glow.Image = "rbxassetid://5028857084"
glow.ImageColor3 = colors.primary
glow.ImageTransparency = 0.85
glow.ScaleType = Enum.ScaleType.Slice
glow.SliceCenter = Rect.new(24, 24, 276, 276)
glow.ZIndex = -1
glow.Parent = MainFrame

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 10)
Title.Text = "Version x BrutForce | Dev Test"
Title.TextColor3 = colors.accent
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 22
Title.Parent = MainFrame

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, 0, 0, 20)
SubTitle.Position = UDim2.new(0, 0, 0, 40)
SubTitle.Text = "Key System"
SubTitle.TextColor3 = colors.text
SubTitle.TextTransparency = 0.3
SubTitle.BackgroundTransparency = 1
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 14
SubTitle.Parent = MainFrame

-- Поле для ввода ключа
local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0.8, 0, 0, 40)
KeyBox.Position = UDim2.new(0.1, 0, 0.4, 0)
KeyBox.PlaceholderText = " Enter key..."
KeyBox.Text = ""
KeyBox.TextColor3 = colors.text
KeyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 16
KeyBox.TextXAlignment = Enum.TextXAlignment.Center
KeyBox.ClearTextOnFocus = false
KeyBox.Parent = MainFrame

local boxCorner = Instance.new("UICorner", KeyBox)
boxCorner.CornerRadius = UDim.new(0, 8)

local boxStroke = Instance.new("UIStroke", KeyBox)
boxStroke.Color = colors.primary
boxStroke.Thickness = 1
boxStroke.Transparency = 0.7

-- Кнопка проверки
local CheckButton = Instance.new("TextButton")
CheckButton.Size = UDim2.new(0.6, 0, 0, 40)
CheckButton.Position = UDim2.new(0.2, 0, 0.85, -50)
CheckButton.Text = "Check Key"
CheckButton.TextColor3 = Color3.new(1, 1, 1)
CheckButton.BackgroundColor3 = colors.primary
CheckButton.Font = Enum.Font.GothamBold
CheckButton.TextSize = 16
CheckButton.AutoButtonColor = false
CheckButton.Parent = MainFrame

local btnCorner = Instance.new("UICorner", CheckButton)
btnCorner.CornerRadius = UDim.new(0, 8)

-- Сообщение об ошибке
local MessageLabel = Instance.new("TextLabel")
MessageLabel.Size = UDim2.new(1, -40, 0, 20)
MessageLabel.Position = UDim2.new(0, 20, 0.95, -50)
MessageLabel.Text = ""
MessageLabel.TextColor3 = colors.error
MessageLabel.BackgroundTransparency = 1
MessageLabel.Font = Enum.Font.Gotham
MessageLabel.TextSize = 14
MessageLabel.Parent = MainFrame

-- Анимации кнопок
local function animateButton(button, hoverColor)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            BackgroundColor3 = hoverColor,
            Size = button.Size + UDim2.new(0.02, 0, 0.05, 0)
        }):Play()
    end)

-- Кнопка проверки ключа
CheckButton.MouseButton1Click:Connect(function()
    if KeyBox.Text == "777" then
        TweenService:Create(KeyBox, TweenInfo.new(0.2), {
            BackgroundColor3 = colors.secondary,
            TextColor3 = Color3.new(1,1,1)
        }):Play()
        TweenService:Create(CheckButton, TweenInfo.new(0.2), {
            BackgroundColor3 = colors.secondary
        }):Play()
        CheckButton.Text = "✓ Successfully"
        MessageLabel.Text = ""
        task.wait(0.8)
        TweenService:Create(MainFrame, TweenInfo.new(0.5), {
            Position = UDim2.new(0.5, -200, -0.5, -125),
            BackgroundTransparency = 1
        }):Play()
        TweenService:Create(glow, TweenInfo.new(0.5), {
            ImageTransparency = 1
        }):Play()
        task.wait(1)
        KeyGui:Destroy()
        -- BrutForce Premium UI
local Players = game:GetService("Players")
local VirtualInput = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local alphabet = {}
for i = 65, 90 do table.insert(alphabet, string.char(i)) end 
table.insert(alphabet, " ")

-- Цветовая палитра
local colors = {
    dark = Color3.fromRGB(15, 15, 20),
    darker = Color3.fromRGB(25, 25, 35),
    primary = Color3.fromRGB(120, 80, 220),
    secondary = Color3.fromRGB(80, 160, 255),
    success = Color3.fromRGB(0, 200, 100),
    danger = Color3.fromRGB(230, 70, 70),
    text = Color3.fromRGB(240, 240, 250),
    accent = Color3.fromRGB(255, 130, 255)
}

-- Создание основного интерфейса
local gui = Instance.new("ScreenGui")
gui.Name = "BrutForceElite"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- Главный контейнер
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 380, 0, 280)
mainFrame.Position = UDim2.new(0.5, -190, 0.5, -140)
mainFrame.BackgroundColor3 = colors.dark
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui

local corner = Instance.new("UICorner", mainFrame)
corner.CornerRadius = UDim.new(0, 14)

-- Эффект неоновой подсветки
local glow = Instance.new("ImageLabel")
glow.Name = "Glow"
glow.BackgroundTransparency = 1
glow.Size = UDim2.new(1, 30, 1, 30)
glow.Position = UDim2.new(0, -15, 0, -15)
glow.Image = "rbxassetid://5028857084"
glow.ImageColor3 = colors.primary
glow.ImageTransparency = 0.9
glow.ScaleType = Enum.ScaleType.Slice
glow.SliceCenter = Rect.new(24, 24, 276, 276)
glow.ZIndex = -1
glow.Parent = mainFrame

-- Заголовок
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = colors.darker
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner", header)
headerCorner.CornerRadius = UDim.new(0, 14)
headerCorner.Name = "HeaderCorner"

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -20, 1, 0)
title.Position = UDim2.new(0, 20, 0, 0)
title.Text = "Version x BrutForce Beta"
title.TextColor3 = colors.text
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBlack
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left

local version = Instance.new("TextLabel", header)
version.Size = UDim2.new(0, 80, 0, 20)
version.Position = UDim2.new(1, -90, 0, 15)
version.Text = "Dev Test"
version.TextColor3 = colors.accent
version.BackgroundTransparency = 1
version.Font = Enum.Font.GothamBold
version.TextSize = 12
version.TextXAlignment = Enum.TextXAlignment.Right

-- Индикатор состояния
local statusCard = Instance.new("Frame", mainFrame)
statusCard.Size = UDim2.new(1, -40, 0, 100)
statusCard.Position = UDim2.new(0, 20, 0, 60)
statusCard.BackgroundColor3 = colors.darker
statusCard.Parent = mainFrame

local statusCorner = Instance.new("UICorner", statusCard)
statusCorner.CornerRadius = UDim.new(0, 10)

local function createStatusItem(y, icon, text, initialValue)
    local container = Instance.new("Frame", statusCard)
    container.Size = UDim2.new(1, 0, 0, 30)
    container.Position = UDim2.new(0, 0, 0, y)
    container.BackgroundTransparency = 1
    
    local iconLabel = Instance.new("TextLabel", container)
    iconLabel.Size = UDim2.new(0, 30, 1, 0)
    iconLabel.Text = icon
    iconLabel.TextColor3 = colors.primary
    iconLabel.BackgroundTransparency = 1
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.TextSize = 16
    
    local textLabel = Instance.new("TextLabel", container)
    textLabel.Size = UDim2.new(0, 100, 1, 0)
    textLabel.Position = UDim2.new(0, 35, 0, 0)
    textLabel.Text = text
    textLabel.TextColor3 = colors.text
    textLabel.BackgroundTransparency = 1
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextSize = 14
    
    local valueLabel = Instance.new("TextLabel", container)
    valueLabel.Size = UDim2.new(0, 150, 1, 0)
    valueLabel.Position = UDim2.new(1, -150, 0, 0)
    valueLabel.Text = initialValue
    valueLabel.TextColor3 = colors.text
    valueLabel.BackgroundTransparency = 1
    valueLabel.Font = Enum.Font.GothamMedium
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.TextSize = 14
    
    return valueLabel
end

-- Статусные элементы
local statusLabel = createStatusItem(10, "📊", "Status:", "Waiting")
local speedLabel = createStatusItem(40, "⚡", "Скорость:", "Not Selected")
local countLabel = createStatusItem(70, "🔢", "Pressed:", "0")

-- Прогресс бар времени
local timeBar = Instance.new("Frame", statusCard)
timeBar.Size = UDim2.new(1, 0, 0, 4)
timeBar.Position = UDim2.new(0, 0, 1, -4)
timeBar.BackgroundColor3 = colors.dark
timeBar.BorderSizePixel = 0

local timeProgress = Instance.new("Frame", timeBar)
timeProgress.Size = UDim2.new(0, 0, 1, 0)
timeProgress.BackgroundColor3 = colors.secondary
timeProgress.BorderSizePixel = 0

-- Панель управления
local controlPanel = Instance.new("Frame", mainFrame)
controlPanel.Size = UDim2.new(1, -40, 0, 80)
controlPanel.Position = UDim2.new(0, 20, 0, 170)
controlPanel.BackgroundTransparency = 1
controlPanel.Parent = mainFrame

-- Кнопки скорости
local speedButtons = {
    {icon = "🐢", name = "Slow", color = Color3.fromRGB(100, 180, 255)},
    {icon = "⚖️", name = "Medium", color = Color3.fromRGB(160, 120, 255)},
    {icon = "⚡", name = "Fast", color = Color3.fromRGB(255, 100, 150)}
}

local speedValues = {0.04, 0.018, 0.001}
local selectedSpeed = nil

for i, btn in ipairs(speedButtons) do
    local button = Instance.new("TextButton", controlPanel)
    button.Size = UDim2.new(0.32, -5, 0, 36)
    button.Position = UDim2.new((i-1)*0.33, 0, 0, 0)
    button.Text = btn.icon .. " " .. btn.name
    button.BackgroundColor3 = btn.color
    button.TextColor3 = Color3.new(1,1,1)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 12
    button.AutoButtonColor = false
    
    local corner = Instance.new("UICorner", button)
    corner.CornerRadius = UDim.new(0, 8)
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(0.32, -5, 0, 40)}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(0.32, -5, 0, 36)}):Play()
    end)
    
    button.MouseButton1Click:Connect(function()
        selectedSpeed = speedValues[i]
        speedLabel.Text = btn.name
        for _, b in ipairs(controlPanel:GetChildren()) do
            if b:IsA("TextButton") then
                TweenService:Create(b, TweenInfo.new(0.2), {BackgroundTransparency = b == button and 0 or 0.7}):Play()
            end
        end
    end)
    
    if i == 2 then
        button.BackgroundTransparency = 0
    else
        button.BackgroundTransparency = 0.7
    end
end

-- Основные кнопки управления
local function createControlButton(text, color, xPos, callback)
    local button = Instance.new("TextButton", controlPanel)
    button.Size = UDim2.new(0.48, -5, 0, 36)
    button.Position = UDim2.new(xPos, 0, 1, -36)
    button.Text = text
    button.BackgroundColor3 = color
    button.TextColor3 = Color3.new(1,1,1)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 14
    button.AutoButtonColor = false
    
    local corner = Instance.new("UICorner", button)
    corner.CornerRadius = UDim.new(0, 8)
    
    local hoverAnim = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, hoverAnim, {BackgroundColor3 = Color3.new(
            math.min(color.R * 1.3, 1),
            math.min(color.G * 1.3, 1),
            math.min(color.B * 1.3, 1)
        )}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, hoverAnim, {BackgroundColor3 = color}):Play()
    end)
    
    button.MouseButton1Click:Connect(callback)
    
    return button
end

local startBtn = createControlButton("🚀 Start", colors.success, 0, function() start() end)
local stopBtn = createControlButton("⛔ Stop", colors.danger, 0.52, function() stop() end)

-- Футер
local footer = Instance.new("TextLabel", mainFrame)
footer.Size = UDim2.new(1, -40, 0, 20)
footer.Position = UDim2.new(0, 20, 1, -25)
footer.Text = "Dev test of Version Hub x BrutForce"
footer.TextColor3 = Color3.fromRGB(150, 150, 160)
footer.BackgroundTransparency = 1
footer.Font = Enum.Font.Gotham
footer.TextSize = 11
footer.TextXAlignment = Enum.TextXAlignment.Center

-- Логика работы
local isRunning = false
local pressedCount = 0
local startTime = 0

local function pressKey(key)
    local keycode = Enum.KeyCode[key == " " and "Space" or key]
    VirtualInput:SendKeyEvent(true, keycode, false, game)
    VirtualInput:SendKeyEvent(false, keycode, false, game)
    pressedCount += 1
    countLabel.Text = tostring(pressedCount)
end

local function randomLoop()
    while isRunning do
        local k = alphabet[math.random(1, #alphabet)]
        pressKey(k)
        task.wait(selectedSpeed or 0.1)
    end
end

function start()
    if isRunning or not selectedSpeed then return end
    isRunning = true
    pressedCount = 0
    startTime = os.clock()
    statusLabel.Text = "Working"
    
    -- Анимация кнопки
    TweenService:Create(startBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.7}):Play()
    TweenService:Create(stopBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
    
    -- Запуск потоков
    for _ = 1, 6 do task.spawn(randomLoop) end
    
    -- Обновление времени
    local connection
    connection = RunService.RenderStepped:Connect(function()
        if not isRunning then 
            connection:Disconnect()
            return 
        end
        
        local elapsed = os.clock() - startTime
        timeProgress.Size = UDim2.new(math.min(elapsed / 30, 1), 0, 1, 0)
        
        if elapsed >= 30 then
            timeProgress.BackgroundColor3 = colors.danger
        elseif elapsed >= 20 then
            timeProgress.BackgroundColor3 = colors.accent
        end
    end)
end

function stop()
    isRunning = false
    statusLabel.Text = "Stopped"
    
    -- Анимация кнопки
    TweenService:Create(startBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
    TweenService:Create(stopBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.7}):Play()
end
        print("Основной скрипт активирован!")
    else
        MessageLabel.Text = "Wrong Key! Get New Key From Discord"
        TweenService:Create(KeyBox, TweenInfo.new(0.2), {
            BackgroundColor3 = colors.error,
            TextColor3 = Color3.new(1,1,1)
        }):Play()
        TweenService:Create(CheckButton, TweenInfo.new(0.2), {
            BackgroundColor3 = colors.error
        }):Play()
        CheckButton.Text = "Error"
        task.wait(3)
        TweenService:Create(KeyBox, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(30, 30, 40),
            TextColor3 = colors.text
        }):Play()
        TweenService:Create(CheckButton, TweenInfo.new(0.3), {
            BackgroundColor3 = colors.primary
        }):Play()
        CheckButton.Text = "Check"
        MessageLabel.Text = ""
        KeyBox.Text = ""
    end
end)

-- Автофокус
KeyBox:CaptureFocus()

-- Перетаскивание окна
local dragging = false
local dragStart, startPos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
    end
end)
