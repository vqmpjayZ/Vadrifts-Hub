--[[ 
__   __   ______     _____     ______     __     ______   ______   ______  
/\ \ / /  /\  __ \   /\  __-.  /\  == \   /\ \   /\  ___\ /\__  _\ /\  ___\ 
\ \ \'/   \ \  __ \  \ \ \/\ \ \ \  __<   \ \ \  \ \  __\ \/_/\ \/ \ \___  \ 
 \ \__|    \ \_\ \_\  \ \____-  \ \_\ \_\  \ \_\  \ \_\      \ \_\  \/\_____\
  \/_/      \/_/\/_/   \/____/   \/_/ /_/   \/_/   \/_/       \/_/   \/_____/
Some loot detections may not work properly
]]

local function checkForMeshIds(model, meshIds)
    for _, part in pairs(model:GetDescendants()) do
        if part:IsA("MeshPart") and part.MeshId then
            for _, meshId in ipairs(meshIds) do
                if part.MeshId == meshId then
                    return true
                end
            end
        end
        if part:IsA("Part") then
            local specialMesh = part:FindFirstChildOfClass("SpecialMesh")
            if specialMesh and specialMesh.MeshId then
                for _, meshId in ipairs(meshIds) do
                    if specialMesh.MeshId == meshId then
                        return true
                    end
                end
            end
            for _, child in pairs(part:GetChildren()) do
                if child:IsA("SpecialMesh") and child.MeshId then
                    for _, meshId in ipairs(meshIds) do
                        if child.MeshId == meshId then
                            return true
                        end
                    end
                end
            end
        end
    end
    return false
end

return {
    rarities = {
        Common = {
            name = "Common",
            color = Color3.fromRGB(255, 255, 255),
            coins = 2
        },
        Uncommon = {
            name = "Uncommon",
            color = Color3.fromRGB(0, 255, 0),
            coins = 5
        },
        Rare = {
            name = "Rare",
            color = Color3.fromRGB(0, 112, 255),
            coins = 7
        },
        Legendary = {
            name = "Legendary",
            color = Color3.fromRGB(255, 0, 255),
            coins = 20
        },
        Immortal = {
            name = "Immortal",
            color = Color3.fromRGB(255, 215, 0),
            coins = 40
        },
        Spectrum = {
            name = "Spectrum",
            color = Color3.fromRGB(255, 0, 0),
            coins = 150
        }
    },
    
    loot = {
        -- ==================== COMMON LOOT ====================
        {
            name = "Broken Bottle",
            rarity = "Common",
            check = function(model)
                return model:FindFirstChild("Meshes/aBrokenBottle") ~= nil
            end
        },
        {
            name = "Rusty Lantern",
            rarity = "Common",
            check = function(model)
                local frame = model:FindFirstChild("Frame")
                return frame and frame:IsA("Part") and frame.BrickColor.Name == "Rust"
            end
        },
        {
            name = "Broken Lightbulb",
            rarity = "Common",
            check = function(model)
                return model:FindFirstChild("Light") ~= nil
            end
        },
        {
            name = "Rusty Screwdriver",
            rarity = "Common",
            check = function(model)
                local meshCount = 0
                local hasDeepBlue = false
                local hasReallyDark = false
                
                for _, part in pairs(model:GetDescendants()) do
                    if part:IsA("MeshPart") or (part:IsA("Part") and part:FindFirstChildOfClass("SpecialMesh")) then
                        meshCount = meshCount + 1
                        
                        if part.BrickColor.Name == "Deep blue" then
                            hasDeepBlue = true
                        elseif part.BrickColor.Name == "Really black" then
                            hasReallyDark = true
                        end
                    end
                end
                
                return meshCount == 2 and hasDeepBlue and hasReallyDark
            end
        },
        {
            name = "Glass Bottle",
            rarity = "Common",
            check = function(model)
                return model:FindFirstChild("Glass Bottle 1a") ~= nil
            end
        },
        {
            name = "Gasoline Canister",
            rarity = "Common",
            check = function(model)
                return model:FindFirstChild("GasolineCanister") ~= nil
            end
        },
        {
            name = "Shattered Glasses",
            rarity = "Common",
            check = function(model)
                local handleCount = 0
                for _, child in pairs(model:GetChildren()) do
                    if child.Name == "Handle" then
                        handleCount = handleCount + 1
                    end
                end
                return handleCount == 1 and model:FindFirstChild("Handle") ~= nil
            end
        },

        -- ==================== UNCOMMON LOOT ====================
        {
            name = "Rusty Kitchen Knife",
            rarity = "Uncommon",
            check = function(model)
                local meshCount = 0
                for _, part in pairs(model:GetDescendants()) do
                    if part:IsA("MeshPart") then
                        meshCount = meshCount + 1
                    end
                end
                return meshCount == 3
            end
        },
        {
            name = "Tire/Wheel",
            rarity = "Uncommon",
            check = function(model)
                for _, part in pairs(model:GetDescendants()) do
                    if part:IsA("MeshPart") and part.Name == "MeshPart" then
                        return true
                    end
                end
                return false
            end
        },
        {
            name = "Rusty Pipe",
            rarity = "Uncommon",
            check = function(model)
                local mesh = model:FindFirstChild("Mesh")
                return mesh and mesh:IsA("Part") and
                        mesh.BrickColor.Name == "Institutional white" and
                        mesh.Material == Enum.Material.CorrodedMetal
            end
        },
        {
            name = "Boombox",
            rarity = "Uncommon",
            check = function(model)
                local meshIds = {
                    "http://www.roblox.com/asset/?id=319536754",
                    "rbxassetid://319536754"
                }
                return checkForMeshIds(model, meshIds)
            end
        },
        {
            name = "Engine",
            rarity = "Uncommon",
            check = function(model)
                return model:FindFirstChild("Engine") ~= nil
            end
        },
        {
            name = "Pickaxe",
            rarity = "Uncommon",
            check = function(model)
                local meshIds = {
                    "http://www.roblox.com/asset/?id=22147051",
                    "rbxassetid://22147051"
                }
                return checkForMeshIds(model, meshIds)
            end
        },

        -- ==================== RARE LOOT ====================
        {
            name = "Wrist Watch",
            rarity = "Rare",
            check = function(model)
                local mesh = model:FindFirstChild("Mesh")
                return mesh and mesh:IsA("Part") and
                        mesh.BrickColor.Name == "Institutional white" and
                        mesh.Material == Enum.Material.SmoothPlastic
            end
        },
        {
            name = "Binoculars",
            rarity = "Rare",
            check = function(model)
                local meshIds = {
                    "http://www.roblox.com/asset/?id=27039535",
                    "rbxassetid://27039535"
                }
                return checkForMeshIds(model, meshIds)
            end
        },
        {
            name = "Mobile Phone",
            rarity = "Rare",
            check = function(model)
                local meshIds = {
                    "http://www.roblox.com/asset/?id=268471347",
                    "rbxassetid://268471347"
                }
                return checkForMeshIds(model, meshIds)
            end
        },
        {
            name = "Laptop",
            rarity = "Rare",
            check = function(model)
                local innerModel = model:FindFirstChild("Model")
                return innerModel and innerModel:FindFirstChild("Screen") ~= nil
            end
        },
        {
            name = "Welding Goggles",
            rarity = "Rare",
            check = function(model)
                local meshIds = {
                    "http://www.roblox.com/asset/?id=81700098",
                    "rbxassetid://81700098"
                }
                return checkForMeshIds(model, meshIds)
            end
        },
        {
            name = "Trophy",
            rarity = "Rare",
            check = function(model)
                local meshIds = {
                    "rbxassetid://6719139437",
                    "http://www.roblox.com/asset/?id=6719139437"
                }
                if checkForMeshIds(model, meshIds) then
                    return true
                end
                -- Fallback check for bright yellow mesh
                local mesh = model:FindFirstChild("Mesh")
                return mesh and mesh:IsA("Part") and mesh.BrickColor.Name == "Bright yellow"
            end
        },

        -- ==================== LEGENDARY LOOT ====================
        {
            name = "Golden Compass",
            rarity = "Legendary",
            check = function(model)
                local meshIds = {
                    "http://www.roblox.com/asset/?id=14655367",
                    "rbxassetid://14655367"
                }
                return checkForMeshIds(model, meshIds)
            end
        },
        {
            name = "Gold Pocket Watch",
            rarity = "Legendary",
            check = function(model)
                return model:FindFirstChild("ConductorsPocketwatch") ~= nil
            end
        },
        {
            name = "Apocalypse Helmet",
            rarity = "Legendary",
            check = function(model)
                local meshIds = {
                    "rbxassetid://4770107066",
                    "http://www.roblox.com/asset/?id=4770107066"
                }
                return checkForMeshIds(model, meshIds)
            end
        },

        -- ==================== IMMORTAL LOOT ====================
        {
            name = "Redcliff Necklace",
            rarity = "Immortal",
            check = function(model)
                return model:FindFirstChild("RedcliffNecklace") ~= nil
            end
        },
        {
            name = "Gold Bar",
            rarity = "Immortal",
            check = function(model)
                if model:FindFirstChild("Gold Bar") then
                    return true
                end
                local children = model:GetChildren()
                if #children >= 2 then
                    local possibleGoldBar = children[2]
                    if possibleGoldBar:IsA("Part") or possibleGoldBar:IsA("MeshPart") then
                        local isGoldColored = possibleGoldBar.BrickColor.Name:lower():find("yellow") or
                                              possibleGoldBar.BrickColor.Name:lower():find("gold")
                        return isGoldColored
                    end
                end
                return false
            end
        },

        -- ==================== SPECTRUM LOOT ====================
        {
            name = "Treasure Chest",
            rarity = "Spectrum",
            check = function(model)
                local meshIds = {
                    "rbxassetid://117542870",
                    "http://www.roblox.com/asset/?id=117542870",
                    "rbxassetid://123781273",
                    "http://www.roblox.com/asset/?id=123781273",
                    "rbxassetid://4799316239",
                    "http://www.roblox.com/asset/?id=4799316239",
                    "rbxassetid://144474705",
                    "http://www.roblox.com/asset/?id=144474705"
                }
                return checkForMeshIds(model, meshIds)
            end
        }
    }
}
