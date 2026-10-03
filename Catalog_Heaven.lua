--==================================================
-- BONA EQUIP ALL GEAR
-- RAYFIELD
--==================================================

--==================================================
-- RAYFIELD
--==================================================

local RayfieldSuccess, Rayfield = pcall(function()
    return loadstring(game:HttpGet(
        "https://sirius.menu/rayfield"
    ))()
end)

if not RayfieldSuccess or not Rayfield then
    warn("[BONA] Failed to load Rayfield")
    return
end

--==================================================
-- SERVICES
--==================================================

local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

--==================================================
-- WINDOW
--==================================================

local Window = Rayfield:CreateWindow({
    Name = "BONA Gear",
    LoadingTitle = "BONA Gear",
    LoadingSubtitle = "Equip All Gear",
    ConfigurationSaving = {
        Enabled = false
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

--==================================================
-- FUNCTIONS
--==================================================

local function getCharacter()
    return LocalPlayer.Character
        or LocalPlayer.CharacterAdded:Wait()
end

local function getBackpack()
    return LocalPlayer:WaitForChild("Backpack")
end

local function getTools()
    local tools = {}

    local backpack = getBackpack()
    local character = getCharacter()

    for _, item in ipairs(backpack:GetChildren()) do
        if item:IsA("Tool") then
            table.insert(tools, item)
        end
    end

    for _, item in ipairs(character:GetChildren()) do
        if item:IsA("Tool") then
            table.insert(tools, item)
        end
    end

    return tools
end

--==================================================
-- EQUIP ALL
--==================================================

local function equipAll()
    local character = getCharacter()
    local backpack = getBackpack()

    local tools = {}

    for _, item in ipairs(backpack:GetChildren()) do
        if item:IsA("Tool") then
            table.insert(tools, item)
        end
    end

    for _, tool in ipairs(tools) do
        pcall(function()
            tool.Parent = character
        end)
    end

    Rayfield:Notify({
        Title = "BONA Gear",
        Content = "Equipped " .. tostring(#tools) .. " gear item(s).",
        Duration = 3
    })
end

--==================================================
-- UNEQUIP ALL
--==================================================

local function unequipAll()
    local character = getCharacter()
    local backpack = getBackpack()

    local count = 0

    for _, item in ipairs(character:GetChildren()) do
        if item:IsA("Tool") then
            pcall(function()
                item.Parent = backpack
                count = count + 1
            end)
        end
    end

    Rayfield:Notify({
        Title = "BONA Gear",
        Content = "Unequipped " .. tostring(count) .. " gear item(s).",
        Duration = 3
    })
end

--==================================================
-- REFRESH
--==================================================

local function refreshGear()
    local tools = getTools()

    Rayfield:Notify({
        Title = "Gear",
        Content = "Found " .. tostring(#tools) .. " gear item(s).",
        Duration = 3
    })
end

--==================================================
-- TAB
--==================================================

local GearTab = Window:CreateTab(
    "🎒 Gear",
    4483362458
)

GearTab:CreateParagraph({
    Title = "All Gear",
    Content = "Equip the Tool items currently available in your Backpack."
})

GearTab:CreateButton({
    Name = "⚡ Equip All Gear",
    Callback = function()
        equipAll()
    end
})

GearTab:CreateButton({
    Name = "🛑 Unequip All Gear",
    Callback = function()
        unequipAll()
    end
})

GearTab:CreateButton({
    Name = "🔄 Refresh Gear",
    Callback = function()
        refreshGear()
    end
})

--==================================================
-- AUTO RE-EQUIP AFTER RESPAWN
--==================================================

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)

    -- Character is recreated after respawn.
    -- Gear stays in Backpack, so it can be equipped again manually.
end)

--==================================================
-- LOADED
--==================================================

Rayfield:Notify({
    Title = "BONA Gear",
    Content = "Gear system loaded!",
    Duration = 4
})
