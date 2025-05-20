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



local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local HttpService = game:GetService("HttpService")
local configFile = "versionHubConfig.json"

local config = {
    diveSpeed = 1,
    spikePower = 1,
    tiltPower = 1,
    speed = 1,
    setPower = 1,
    servePower = 1,
    jumpPower = 1,
    bumpPower = 1,
    blockPower = 1,
    spikeHitbox = 10,
    jumpsetHitbox = 10,
    setHitbox = 10,
    serveHitbox = 10,
    diveHitbox = 10,
    bumpHitbox = 10,
    blockHitbox = 10
}

-- Конфиги
if isfile(configFile) then
    local data = readfile(configFile)
    local success, result = pcall(function()
        return HttpService:JSONDecode(data)
    end)
    if success then
        for k, v in pairs(result) do
            config[k] = v
        end
    end
end

local function saveConfig()
    writefile(configFile, HttpService:JSONEncode(config))
end

local Window = Rayfield:CreateWindow({
    Name = "Version Hub",
    LoadingTitle = "Version Hub",
    LoadingSubtitle = "volleyball legends",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "VersionHub", 
        FileName = "versionHubConfig"
    },
    Discord = {
        Enabled = true,
        Invite = "https://discord.gg/sn6BGaeBKQ", 
        RememberJoins = true
    },
    KeySystem = true, 
    KeySettings = {
        Title = "Version Hub / Key System",
        Subtitle = "Need a key",
        Note = "Get Key in our discord",
        FileName = "VersionHubKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"777"} 
    }
})
-------------------- 💪 Stat Changer Tab --------------------
local statTab = Window:CreateTab("Stats changer", 4483345998)
Rayfield:Notify({Title="version Hub", Content="script Loaded!", Duration=3})

local function slider(attribute, name, min, max, inc)
    statTab:CreateSlider({
        Name = name,
        Range = {min, max},
        Increment = inc,
        CurrentValue = config[attribute],
        Callback = function(value)
            game.Players.LocalPlayer:SetAttribute("Game"..attribute:gsub("^%l", string.upper).."Multiplier", value)
            config[attribute] = value
            saveConfig()
        end
    })
end

slider("diveSpeed", "Dive Speed", 0, 5, 0.1)
slider("spikePower", "Spike Power", 0, 500, 0.1)
slider("tiltPower", "Tilt Power", 0, 500, 0.1)
slider("speed", "Speed", 0, 1.5, 0.1)
slider("setPower", "Set Power", 0, 500, 0.1)
slider("servePower", "Serve Power", 0, 500, 0.1)
slider("jumpPower", "Jump Power", 0, 5, 0.1)
slider("bumpPower", "Bump Power", 0, 500, 0.1)
slider("blockPower", "Block Power", 0, 500, 0.1)

local hitboxTab = Window:CreateTab("hitbox editor", 4483345998)

local lastBallSize = 10 -- Сохраняем последнее значение
local targetColor = Color3.fromRGB(255, 100, 100)

-- Поиск мяча по шаблону CLIENT_BALL_
local function findBall()
    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("Model") and string.match(obj.Name, "^CLIENT_BALL_") then
            return obj:FindFirstChildWhichIsA("BasePart")
        end
    end
    return nil
end

-- Слайдер изменения размера мяча
hitboxTab:CreateSlider({
    Name = "Ball Size",
    Range = {1, 100},
    Increment = 0.5,
    CurrentValue = lastBallSize,
    Callback = function(value)
        lastBallSize = value
        local ball = findBall()
        if ball then
            ball.Size = Vector3.new(value, value, value)
            print("ok", value)
        else
            warn("ball refreshing")
        end
    end
})

--[[ Кнопка перекраски мяча
hitboxTab:CreateButton({
    Name = "Изменить цвет мяча",
    Callback = function()
        local ball = findBall()
        if ball then
            ball.Color = targetColor
            ball.Material = Enum.Material.Neon
            print("Цвет мяча изменён!")
        else
            warn("Мяч не найден для перекраски.")
        end
    end
})
--]]
-- ⏱️ Циклическая проверка мяча
task.spawn(function()
    while true do
        local ball = findBall()
        if ball and ball.Size ~= Vector3.new(lastBallSize, lastBallSize, lastBallSize) then
            ball.Size = Vector3.new(lastBallSize, lastBallSize, lastBallSize)
        end
        task.wait(0.1)
    end
end)

local visualTab = Window:CreateTab("Visual", 4483345998)

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

-- === Мяч Highlight ===
local ballHighlight = Instance.new("Highlight")
ballHighlight.Enabled = false
ballHighlight.FillTransparency = 0
ballHighlight.OutlineTransparency = 1
ballHighlight.FillColor = Color3.new(0, 0, 0)
ballHighlight.Name = "BallHighlight"
ballHighlight.Parent = workspace

local highlightColor = Color3.new(0, 0, 0)
local rainbowHighlight = false
local rainbowHighlightThread = nil
local ballHighlightEnabled = false
local ballTrackerConnection = nil

-- Функция для поиска мяча
local function findBall()
    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("Model") and string.match(obj.Name, "^CLIENT_BALL_") then
            return obj:FindFirstChildWhichIsA("BasePart")
        end
    end
    return nil
end

-- Функция обновления подсветки мяча
local function updateBallHighlight()
    if ballHighlightEnabled then
        local ball = findBall()
        if ball then
            ballHighlight.Adornee = ball
            ballHighlight.Enabled = true
        else
            ballHighlight.Enabled = false
        end
    else
        ballHighlight.Enabled = false
        ballHighlight.Adornee = nil
    end
end

-- Функция для запуска/остановки отслеживания мяча
local function toggleBallTracking(enable)
    if enable then
        if ballTrackerConnection then
            ballTrackerConnection:Disconnect()
        end
        ballTrackerConnection = RunService.Heartbeat:Connect(function()
            updateBallHighlight()
        end)
    else
        if ballTrackerConnection then
            ballTrackerConnection:Disconnect()
            ballTrackerConnection = nil
        end
        ballHighlight.Enabled = false
        ballHighlight.Adornee = nil
    end
end

visualTab:CreateToggle({
    Name = "Подсветка мяча (Highlight)",
    CurrentValue = false,
    Callback = function(state)
        ballHighlightEnabled = state
        toggleBallTracking(state)
        updateBallHighlight()
    end
})

visualTab:CreateColorPicker({
    Name = "Цвет подсветки мяча",
    Color = highlightColor,
    Callback = function(c)
        highlightColor = c
        if not rainbowHighlight then
            ballHighlight.FillColor = c
        end
    end
})

visualTab:CreateToggle({
    Name = "Радужная подсветка мяча",
    CurrentValue = false,
    Callback = function(state)
        rainbowHighlight = state
        if rainbowHighlight then
            if rainbowHighlightThread then
                rainbowHighlightThread:Disconnect()
            end
            rainbowHighlightThread = RunService.Heartbeat:Connect(function()
                local hue = tick() % 5 / 5
                ballHighlight.FillColor = Color3.fromHSV(hue, 1, 1)
            end)
        else
            if rainbowHighlightThread then
                rainbowHighlightThread:Disconnect()
                rainbowHighlightThread = nil
            end
            ballHighlight.FillColor = highlightColor
        end
    end
})

-- Очистка при отключении скрипта
game:GetService("Players").LocalPlayer.CharacterRemoving:Connect(function()
    if ballTrackerConnection then
        ballTrackerConnection:Disconnect()
    end
    if rainbowHighlightThread then
        rainbowHighlightThread:Disconnect()
    end
    ballHighlight:Destroy()
end)

-- === Ambient игрока ===
local ambientEnabled = false
local ambientPart = nil
local rainbowAmbient = false
local ambientColor = Color3.new(1, 1, 1)
local ambientBrightness = 1
local ambientUpdater

visualTab:CreateToggle({
    Name = "Enable Player Ambient",
    CurrentValue = false,
    Callback = function(Value)
        ambientEnabled = Value

        if Value then
            if not ambientPart then
                ambientPart = Instance.new("Part")
                ambientPart.Name = "AmbientPart"
                ambientPart.Size = Vector3.new(10, 10, 10)
                ambientPart.Transparency = 1
                ambientPart.Anchored = true
                ambientPart.CanCollide = false
                ambientPart.Parent = workspace

                local pointLight = Instance.new("PointLight")
                pointLight.Color = ambientColor
                pointLight.Brightness = ambientBrightness
                pointLight.Range = 15
                pointLight.Parent = ambientPart
            end

            if ambientUpdater then ambientUpdater:Disconnect() end
            ambientUpdater = game:GetService("RunService").Heartbeat:Connect(function()
                local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp and ambientPart then
                    ambientPart.Position = hrp.Position
                end
            end)
        else
            if ambientUpdater then
                ambientUpdater:Disconnect()
                ambientUpdater = nil
            end
            if ambientPart then
                ambientPart:Destroy()
                ambientPart = nil
            end
        end
    end
})

visualTab:CreateColorPicker({
    Name = "Ambient Color",
    Color = ambientColor,
    Callback = function(Color)
        ambientColor = Color
        if ambientPart and not rainbowAmbient then
            local light = ambientPart:FindFirstChildOfClass("PointLight")
            if light then light.Color = Color end
        end
    end
})

visualTab:CreateSlider({
    Name = "Ambient Brightness",
    Range = {0.1, 5},
    Increment = 0.1,
    CurrentValue = ambientBrightness,
    Callback = function(Value)
        ambientBrightness = Value
        if ambientPart then
            local light = ambientPart:FindFirstChildOfClass("PointLight")
            if light then light.Brightness = Value end
        end
    end
})

visualTab:CreateToggle({
    Name = "Rainbow Ambient",
    CurrentValue = false,
    Callback = function(Value)
        rainbowAmbient = Value
        if Value then
            coroutine.wrap(function()
                while rainbowAmbient and task.wait(0.1) do
                    if ambientPart then
                        local light = ambientPart:FindFirstChildOfClass("PointLight")
                        if light then
                            local hue = tick() % 5 / 5
                            light.Color = Color3.fromHSV(hue, 1, 1)
                        end
                    end
                end
            end)()
        elseif ambientPart then
            local light = ambientPart:FindFirstChildOfClass("PointLight")
            if light then light.Color = ambientColor end
        end
    end
})

-- === Подсветка игроков ===
local playerHighlights = {}
local playerHighlightColor = Color3.fromRGB(255, 255, 255)
local rainbowPlayers = false
local rainbowPlayersThread = nil
local playerHighlightEnabled = false

-- Функция для создания подсветки для персонажа
local function createHighlightForCharacter(player, character)
    if playerHighlights[player] then
        playerHighlights[player]:Destroy()
    end
    
    local hl = Instance.new("Highlight")
    hl.Name = "PlayerHighlight"
    hl.FillColor = rainbowPlayers and Color3.fromHSV((tick() % 5)/5, 1, 1) or playerHighlightColor
    hl.FillTransparency = 0.3
    hl.OutlineTransparency = 1
    hl.Enabled = playerHighlightEnabled
    hl.Parent = character
    playerHighlights[player] = hl
end

-- Функция для удаления подсветки при выходе игрока
local function removePlayerHighlight(player)
    if playerHighlights[player] then
        playerHighlights[player]:Destroy()
        playerHighlights[player] = nil
    end
end

-- Обработчик добавления нового игрока
local function onPlayerAdded(player)
    -- Обработчик появления персонажа
    player.CharacterAdded:Connect(function(character)
        createHighlightForCharacter(player, character)
    end)
    
    -- Обработчик удаления персонажа (например, при смерти)
    player.CharacterRemoving:Connect(function()
        removePlayerHighlight(player)
    end)
    
    -- Если у игрока уже есть персонаж при подключении
    if player.Character then
        createHighlightForCharacter(player, player.Character)
    end
end

-- Обработчик выхода игрока
local function onPlayerRemoving(player)
    removePlayerHighlight(player)
end

-- Подключаем обработчики событий
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        onPlayerAdded(player)
    end
end

Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)

-- Функция для обновления всех подсветок
local function updateAllHighlights()
    for player, highlight in pairs(playerHighlights) do
        if player and highlight and player.Character and highlight.Parent ~= player.Character then
            highlight.Parent = player.Character
        end
    end
end

-- Периодическая проверка и обновление подсветок
local highlightUpdater = game:GetService("RunService").Heartbeat:Connect(function()
    for player, highlight in pairs(playerHighlights) do
        if not player or not player.Character or not highlight then
            if highlight then highlight:Destroy() end
            playerHighlights[player] = nil
        end
    end
end)

visualTab:CreateToggle({
    Name = "Подсветка игроков",
    CurrentValue = false,
    Callback = function(state)
        playerHighlightEnabled = state
        for _, highlight in pairs(playerHighlights) do
            if highlight then
                highlight.Enabled = state
            end
        end
    end
})

visualTab:CreateColorPicker({
    Name = "Цвет подсветки игроков",
    Color = playerHighlightColor,
    Callback = function(c)
        playerHighlightColor = c
        if not rainbowPlayers then
            for _, highlight in pairs(playerHighlights) do
                if highlight then
                    highlight.FillColor = c
                end
            end
        end
    end
})

visualTab:CreateToggle({
    Name = "Радужная подсветка игроков",
    CurrentValue = false,
    Callback = function(state)
        rainbowPlayers = state
        if rainbowPlayers then
            if rainbowPlayersThread then
                rainbowPlayersThread:Disconnect()
            end
            rainbowPlayersThread = RunService.Heartbeat:Connect(function()
                local hue = tick() % 5 / 5
                for _, highlight in pairs(playerHighlights) do
                    if highlight then
                        highlight.FillColor = Color3.fromHSV(hue, 1, 1)
                    end
                end
            end)
        else
            if rainbowPlayersThread then
                rainbowPlayersThread:Disconnect()
                rainbowPlayersThread = nil
            end
            for _, highlight in pairs(playerHighlights) do
                if highlight then
                    highlight.FillColor = playerHighlightColor
                end
            end
        end
    end
})
