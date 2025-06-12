print("EltonsHub carregando...") -- Mostra no console do executor

local StarterGui = game:GetService("StarterGui")
local tempo = 15

for i = tempo, 1, -1 do
    StarterGui:SetCore("SendNotification", {
        Title = "EltonsHub",
        Text = "waiting for the game to load... " .. i .. "s",
        Duration = 1
    })
    task.wait(1)
end


local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()


local Window = Fluent:CreateWindow({
    Title = "Build An Island",
    SubTitle = "by  Elton",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl 
})

local Tabs = {
    Main = Window:AddTab({ Title = "Farm", Icon = "home" }),
    Sell = Window:AddTab({ Title = "Sell", Icon = "dollar-sign" }),
    Craft = Window:AddTab({ Title = "Craft", Icon = "wrench" }),
    Event = Window:AddTab({ Title = "Events", Icon = "star" }),
    Collect = Window:AddTab({ Title = "Collect", Icon = "archive" }),
    Shop = Window:AddTab({ Title = "Shop", Icon = "shopping-cart" }),
    AntiAfk = Window:AddTab({ Title = "Anti-Afk", Icon = "clock" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
    feed = Window:AddTab({ Title = "FeedBack", Icon = "file" }),
}
    
local Options = Fluent.Options


local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local ResourcesFolder = ReplicatedStorage:WaitForChild("Storage"):WaitForChild("Resources")
    local listplayers = {}
    local players = game.Players
    local localPlayerName = players.LocalPlayer.Name
    getgenv().selectedPlayers = {localPlayerName}

    -- Function to refresh the player list and update the dropdown
    local function refreshPlayerList()
        table.clear(listplayers)
        for _, player in pairs(players:GetPlayers()) do
            table.insert(listplayers, player.Name)
        end
        Options.playersmulti:SetValues(listplayers)
        Options.playersmulti:SetValue({[localPlayerName] = true})
    end


    local playersmulti = Tabs.Main:AddDropdown("playersmulti", {
        Title = "List Of Players",
        Description = "You can now farm other players resources as long as your a helper",
        Values = listplayers,
        Multi = true,
        Default = {localPlayerName}, 
    })


    playersmulti:OnChanged(function(Value)
        local Values = {}
        for name, state in next, Value do
            if state then
                table.insert(Values, name)
            end
        end
        selectedPlayers = Values
    end)


    Tabs.Main:AddButton({
        Title = "Refresh Player List",
        Callback = function()
            refreshPlayerList()
        end
    })

    -- Toggle for Instant Farm
    local AutoFarm = Tabs.Main:AddToggle("AutoFarm", {
        Title = "Instant Farm All",
        Default = false
    })

    AutoFarm:OnChanged(function()
        task.spawn(function()
            while Options.AutoFarm.Value do
                local plots = workspace:WaitForChild("Plots")

                for _, targetPlayer in ipairs(selectedPlayers) do
                    local targetPlot = plots:FindFirstChild(targetPlayer)

                    if targetPlot and targetPlot:FindFirstChild("Resources") then
                        local resources = targetPlot.Resources:GetChildren()

                        for _, resource in ipairs(resources) do
                            local hp = resource:GetAttribute("HP")
                            if hp and hp > 0 then
                                game:GetService("ReplicatedStorage")
                                    :WaitForChild("Communication")
                                    :WaitForChild("HitResource")
                                    :FireServer(resource)
                            end
                        end
                    end
                end

                task.wait(0.1)
            end
        end)
    end)

    Options.AutoFarm:SetValue(false)


    local AutoFarm2 = Tabs.Main:AddToggle("AutoFarm2", {
        Title = "Farm All (With Delay)",
        Default = false
    })

    AutoFarm2:OnChanged(function()
        task.spawn(function()
            while Options.AutoFarm2.Value do
                local plots = workspace:WaitForChild("Plots")

                for _, targetPlayer in ipairs(selectedPlayers) do
                    local targetPlot = plots:FindFirstChild(targetPlayer)

                    if targetPlot and targetPlot:FindFirstChild("Resources") then
                        local resources = targetPlot.Resources:GetChildren()

                        for _, resource in ipairs(resources) do
                            local hp = resource:GetAttribute("HP")
                            if hp and hp > 0 then
                                game:GetService("ReplicatedStorage")
                                    :WaitForChild("Communication")
                                    :WaitForChild("HitResource")
                                    :FireServer(resource)
                            end
                            task.wait(0.01)
                        end
                    end
                end
                task.wait(0.1)
            end
        end)
    end)

    Options.AutoFarm2:SetValue(false)

    refreshPlayerList()

    --[[local AutoFarmTree = Tabs.Event:AddToggle("AutoFarmTree", {
        Title = "Auto Farm World Tree",
        Default = false
    })

    AutoFarmTree:OnChanged(function()
        task.spawn(function()
            while Options.AutoFarmTree.Value do
                local globalresources = workspace:FindFirstChild("GlobalResources")

                if globalresources then
                    for _, resource in ipairs(globalresources:GetChildren()) do
                        if resource.Name == "World Tree" then
                            local hp = resource:GetAttribute("HP")
                            if hp and hp > 0 then
                                game:GetService("ReplicatedStorage")
                                    :WaitForChild("Communication")
                                    :WaitForChild("HitResource")
                                    :FireServer(resource)
                            end
                        end
                    end
                end
                task.wait(0.1)
            end
        end)
    end)]]

    Options.AutoFarm2:SetValue(false)

    refreshPlayerList()

    local AutoFarmTree = Tabs.Event:AddToggle("AutoFarmTree", {
        Title = "Auto Farm World Tree",
        Default = false
    })

    AutoFarmTree:OnChanged(function()
        task.spawn(function()
            while Options.AutoFarmTree.Value do
                local globalresources = workspace:FindFirstChild("GlobalResources")

                if globalresources then
                    for _, resource in ipairs(globalresources:GetChildren()) do
                        if resource.Name == "World Tree" then
                            local hp = resource:GetAttribute("HP")
                            if hp and hp > 0 then
                                game:GetService("ReplicatedStorage")
                                    :WaitForChild("Communication")
                                    :WaitForChild("HitResource")
                                    :FireServer(resource)
                            end
                        end
                    end
                end
                task.wait(0.1)
            end
        end)
    end)

    Options.AutoFarmTree:SetValue(false)

    local autocollectreward = Tabs.Event:AddToggle("autocollectreward", {Title = "Collect Reward Chest", Default = false })

    autocollectreward:OnChanged(function()
        while Options.autocollectreward.Value do
            local rewardchest = workspace:FindFirstChild("RewardChest")
            if rewardchest then
                local chestkey = rewardchest:GetAttribute("ChestKey")
                local args = {
                    chestkey
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("RewardChestClaimRequest"):FireServer(unpack(args))
            end
            task.wait(0.1)
        end
    end)

    Options.autocollectreward:SetValue(false)

    local autocollectworldtree = Tabs.Event:AddToggle("autocollectworldtree", {Title = "Collect World Tree Seed", Default = false })

    autocollectworldtree:OnChanged(function()
        while Options.autocollectworldtree.Value do
            local worldtreeseed = workspace:FindFirstChild("WorldTreeSeed")
            if worldtreeseed then
                local key = worldtreeseed:GetAttribute("Key")
                local args = {
                    key
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("CollectWorldTree"):FireServer(unpack(args))
            end
            task.wait(0.1)
        end
    end)

     Options.autocollectworldtree:SetValue(false)

    local backpackitems = {}
    local backpackitemsloc = game:GetService("ReplicatedStorage").Storage:FindFirstChild("BackpackItems")
    if backpackitemsloc then
        for _, backpackitem in pairs(backpackitemsloc:GetChildren()) do
            table.insert(backpackitems, backpackitem.Name)
        end
    end

    
    getgenv().backpackselectedItems = {}

    local backpackitemsmulti = Tabs.Sell:AddDropdown("backpackitemsmulti", {
        Title = "Exclude from Selling",
        Values = backpackitems,
        Multi = true,
        Default = {},
    })

    backpackitemsmulti:OnChanged(function(value)
        local values = {}
        for itemName, isSelected in pairs(value) do
            if isSelected then
                table.insert(values, itemName)
            end
        end
        backpackselectedItems = values
    end)


    local selldelay = 2
    local autosellall = Tabs.Sell:AddToggle("autosellall", {Title = "Auto Sell", Default = false })

    autosellall:OnChanged(function()
        while Options.autosellall.Value do
            local backpack = game:GetService("Players").LocalPlayer:FindFirstChild("Backpack")
            if backpack then
                for _, item in pairs(backpack:GetChildren()) do
                    local sellable = item:GetAttribute("Sellable")
                    if sellable and not table.find(backpackselectedItems, item.Name) then
                        local hash = item:GetAttribute("Hash")
                        local args = {
                            false,
                            {
                                hash
                            }
                        }
                        game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("SellToMerchant"):FireServer(unpack(args))
                    end
                end
            end
            task.wait(selldelay)
        end
    end)

       Options.autosellall:SetValue(false)

    local autoselldelay = Tabs.Sell:AddSlider("autoselldelay", {
        Title = "Sell Delay",
        Default = 2,
        Min = 0.5,
        Max = 60,
        Rounding = 1,
        Callback = function(Value)
            selldelay = Value
        end
    })

     Tabs.Sell:AddParagraph({
        Title = "About Auto Sell",
        Content = "Even if you didn't exclude seeds and animals, it will not sell them but for potions you need to exclude them"
    })

     local myspeed = 30
    local enablewalkspeed = Tabs.Main:AddToggle("enablewalkspeed", {Title = "Enable Walkspeed", Default = false })

    enablewalkspeed:OnChanged(function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer

        if Options.enablewalkspeed.Value then
            while Options.enablewalkspeed.Value do
                local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                if Character and Character:FindFirstChild("Humanoid") then
                    Character.Humanoid.WalkSpeed = myspeed
                end
                task.wait(0.01)
            end
        else
            local Character = LocalPlayer.Character
            if Character and Character:FindFirstChild("Humanoid") then
                Character.Humanoid.WalkSpeed = 16
            end
        end
    end)

    
    Options.enablewalkspeed:SetValue(false)

    local WalkSpeedSlider = Tabs.Main:AddSlider("WalkSpeedSlider", {
        Title = "WalkSpeed",
        Description = "Adjust your walk speed",
        Default = 30,
        Min = 1,
        Max = 150,
        Rounding = 0.1,
        Callback = function(Value)
            myspeed = Value
        end
    })


    local Players = game:GetService("Players")
    local plr = Players.LocalPlayer
    local plot = game:GetService("Workspace"):WaitForChild("Plots"):WaitForChild(plr.Name)
    local craft_delay = 5
    local autocraftall = Tabs.Craft:AddToggle("autocraftall", {Title = "Auto Craft All", Description = "This does not craft furniture or other earning money craft", Default = false })

    autocraftall:OnChanged(function()
        while Options.autocraftall.Value do
            for _, c in pairs(plot:GetDescendants()) do
				if c.Name == "Crafter" then
					local attachment = c:FindFirstChildOfClass("Attachment")
					if attachment then
						game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("Craft"):FireServer(attachment)
					end
				end
			end
			task.wait(craft_delay)
        end
    end)
    
    Options.autocraftall:SetValue(false)

    local autocraftalldelay = Tabs.Craft:AddSlider("autocraftalldelay", {
        Title = "Craft All Delay",
        Default = 5,
        Min = 1,
        Max = 60,
        Rounding = 1,
        Callback = function(Value)
            craft_delay = Value
        end
    })

    autocraftalldelay:SetValue(3)

     autocraftalldelay:SetValue(3)

    local playerName = game.Players.LocalPlayer.Name

    local plankdelay = 5
    local autocraftplank = Tabs.Craft:AddToggle("autocraftplank", {Title = "Auto Craft Plank", Default = false })
    autocraftplank:OnChanged(function()
        while Options.autocraftplank.Value do
            local args = {
                workspace:WaitForChild("Plots"):WaitForChild(playerName):WaitForChild("Land"):WaitForChild("S13"):WaitForChild("Crafter"):WaitForChild("Attachment")
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("Craft"):FireServer(unpack(args))
            task.wait(plankdelay)
        end
    end)
    Options.autocraftplank:SetValue(false)

    local autodelayplank = Tabs.Craft:AddSlider("autodelayplank", {
        Title = "Craft Delay",
        Default = 5,
        Min = 1,
        Max = 200,
        Rounding = 1,
        Callback = function(Value)
            plankdelay = Value
        end
    })

    autodelayplank:SetValue(5)

        local brickdelay = 5
    local autocraftbrick = Tabs.Craft:AddToggle("autocraftbrick", {Title = "Auto Craft Brick", Default = false })
    autocraftbrick:OnChanged(function()
        while Options.autocraftbrick.Value do
            local args = {
                workspace:WaitForChild("Plots"):WaitForChild(playerName):WaitForChild("Land"):WaitForChild("S24"):WaitForChild("Crafter"):WaitForChild("Attachment")
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("Craft"):FireServer(unpack(args))
            task.wait(brickdelay)
        end
    end)

    Options.autocraftbrick:SetValue(false)

        local autodelaybrick = Tabs.Craft:AddSlider("autodelaybrick", {
        Title = "Craft Delay",
        Default = 5,
        Min = 1,
        Max = 200,
        Rounding = 1,
        Callback = function(Value)
            brickdelay = Value
        end
    })

    autodelaybrick:SetValue(5)

        local bamboodelay = 5
    local autocraftbamboo = Tabs.Craft:AddToggle("autocraftbamboo", {Title = "Auto Craft Bamboo Plank", Default = false })
    autocraftbamboo:OnChanged(function()
        while Options.autocraftbamboo.Value do
            local args = {
                workspace:WaitForChild("Plots"):WaitForChild(playerName):WaitForChild("Land"):WaitForChild("S72"):WaitForChild("Crafter"):WaitForChild("Attachment")
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("Craft"):FireServer(unpack(args))
            task.wait(bamboodelay)
        end
    end)
    Options.autocraftbamboo:SetValue(false)

    local autodelaybamboo = Tabs.Craft:AddSlider("autodelaybamboo", {
        Title = "Craft Delay",
        Default = 5,
        Min = 1,
        Max = 200,
        Rounding = 1,
        Callback = function(Value)
            bamboodelay = Value
        end
    })

    autodelaybamboo:SetValue(5)

    local furnituredelay = 5
    local autocraftfurniture = Tabs.Craft:AddToggle("autocraftfurniture", {Title = "Auto Craft Furniture", Default = false })
    autocraftfurniture:OnChanged(function()
        while Options.autocraftfurniture.Value do
            local args = {
                workspace:WaitForChild("Plots"):WaitForChild(playerName):WaitForChild("Land"):WaitForChild("S9"):WaitForChild("Crafter"):WaitForChild("Attachment")
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("DoubleCraft"):FireServer(unpack(args))
            task.wait(furnituredelay)
        end
    end)
    
    Options.autocraftfurniture:SetValue(false)

      local autodelayfurniture = Tabs.Craft:AddSlider("autodelayfurniture", {
        Title = "Craft Delay",
        Default = 5,
        Min = 1,
        Max = 200,
        Rounding = 1,
        Callback = function(Value)
            furnituredelay = Value
        end
    })
    
    autodelayfurniture:SetValue(5)

       local ironbardelay = 5
    local autocraftironbar = Tabs.Craft:AddToggle("autocraftironbar", {Title = "Auto Craft Ironbar", Default = false })
    autocraftironbar:OnChanged(function()
        while Options.autocraftironbar.Value do
            local args = {
                workspace:WaitForChild("Plots"):WaitForChild(playerName):WaitForChild("Land"):WaitForChild("S23"):WaitForChild("Crafter"):WaitForChild("Attachment")
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("DoubleCraft"):FireServer(unpack(args))
            task.wait(ironbardelay)
        end
    end)
    
    Options.autocraftironbar:SetValue(false)

        local autodelayironbar = Tabs.Craft:AddSlider("autodelayironbar", {
        Title = "Craft Delay",
        Default = 5,
        Min = 1,
        Max = 200,
        Rounding = 1,
        Callback = function(Value)
            ironbardelay = Value
        end
    })

    autodelayironbar:SetValue(5)

       local toolsmithdelay = 5
    local autocrafttoolsmith = Tabs.Craft:AddToggle("autocrafttoolsmith", {Title = "Auto Craft Toolsmith", Default = false })
    autocrafttoolsmith:OnChanged(function()
        while Options.autocrafttoolsmith.Value do
            local args = {
                workspace:WaitForChild("Plots"):WaitForChild(playerName):WaitForChild("Land"):WaitForChild("S38"):WaitForChild("Crafter"):WaitForChild("Attachment")
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("DoubleCraft"):FireServer(unpack(args))
            task.wait(toolsmithdelay)
        end
    end)
    Options.autocrafttoolsmith:SetValue(false)

    local autodelaytoolsmith = Tabs.Craft:AddSlider("autodelaytoolsmith", {
        Title = "Craft Delay",
        Default = 5,
        Min = 1,
        Max = 200,
        Rounding = 1,
        Callback = function(Value)
            toolsmithdelay = Value
        end
    })

    autodelaytoolsmith:SetValue(5)

        local cactusfiberdelay = 5
    local autocraftcactusfiber = Tabs.Craft:AddToggle("autocraftcactusfiber", {Title = "Auto Craft Cactus Fiber", Default = false })
    autocraftcactusfiber:OnChanged(function()
        while Options.autocraftcactusfiber.Value do
            local args = {
                workspace:WaitForChild("Plots"):WaitForChild(playerName):WaitForChild("Land"):WaitForChild("S54"):WaitForChild("Crafter"):WaitForChild("Attachment")
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("Craft"):FireServer(unpack(args))
            task.wait(cactusfiberdelay)
        end
    end)
    Options.autocraftcactusfiber:SetValue(false)

    local autodelaycactusfiber = Tabs.Craft:AddSlider("autodelaycactusfiber", {
        Title = "Craft Delay",
        Default = 5,
        Min = 1,
        Max = 200,
        Rounding = 1,
        Callback = function(Value)
            cactusfiberdelay = Value
        end
    })
    
    autodelaycactusfiber:SetValue(5)

local magmafurnacedelay = 5
    local autocraftmagmafurnace = Tabs.Craft:AddToggle("autocraftmagmafurnace", {Title = "Auto Craft Magma Furnace", Default = false })
    autocraftmagmafurnace:OnChanged(function()
        while Options.autocraftmagmafurnace.Value do
            local args = {
                workspace:WaitForChild("Plots"):WaitForChild(playerName):WaitForChild("Land"):WaitForChild("S106"):WaitForChild("Crafter"):WaitForChild("Attachment")
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("DoubleCraft"):FireServer(unpack(args))
            task.wait(magmafurnacedelay)
        end
    end)
    Options.autocraftmagmafurnace:SetValue(false)

    local autodelaymagmafurnace = Tabs.Craft:AddSlider("autodelaymagmafurnace", {
        Title = "Craft Delay",
        Default = 5,
        Min = 1,
        Max = 200,
        Rounding = 1,
        Callback = function(Value)
            magmafurnacedelay = Value
        end
    })

    autodelaymagmafurnace:SetValue(5)

    local haydelay = 5
    local autocrafthay = Tabs.Craft:AddToggle("autocrafthay", {Title = "Auto Craft Hay Baler", Default = false })
    autocrafthay:OnChanged(function()
        while Options.autocrafthay.Value do
            local args = {
                workspace:WaitForChild("Plots"):WaitForChild(playerName):WaitForChild("Land"):WaitForChild("S178"):WaitForChild("Crafter"):WaitForChild("Attachment")
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("Craft"):FireServer(unpack(args))
            task.wait(haydelay)
        end
    end)
    
    Options.autocrafthay:SetValue(false)

    local autodelayhay = Tabs.Craft:AddSlider("autodelayhay", {
        Title = "Craft Delay",
        Default = 5,
        Min = 1,
        Max = 200,
        Rounding = 1,
        Callback = function(Value)
            haydelay = Value
        end
    })
    autodelayhay:SetValue(5)

     local magmasawmilldelay = 5
    local autocraftmagmasawmill = Tabs.Craft:AddToggle("autocraftmagmasawmill", {Title = "Auto Craft Magma Sawmill", Default = false })
    autocraftmagmasawmill:OnChanged(function()
        while Options.autocraftmagmasawmill.Value do
            local args = {
                workspace:WaitForChild("Plots"):WaitForChild(playerName):WaitForChild("Land"):WaitForChild("S108"):WaitForChild("Crafter"):WaitForChild("Attachment")
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("Craft"):FireServer(unpack(args))
            task.wait(magmasawmilldelay)
        end
    end)
    Options.autocraftmagmasawmill:SetValue(false)

    local autodelaymagmasawmill = Tabs.Craft:AddSlider("autodelaymagmasawmill", {
        Title = "Craft Delay",
        Default = 5,
        Min = 1,
        Max = 200,
        Rounding = 1,
        Callback = function(Value)
            magmasawmilldelay = Value
        end
    })
    autodelaymagmasawmill:SetValue(5)

    local Toggle4 = Tabs.AntiAfk:AddToggle("AntiAfk", {
        Title = "Anti-Afk", 
        Description = "This will prevent you from being kicked when AFK", 
        Default = false 
    })
    
    Toggle4:OnChanged(function()
        task.spawn(function()
            while Options.AntiAfk.Value do
                local VirtualUser = game:GetService("VirtualUser")
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
                task.wait(10)
            end
        end)
    end)
        Options.AntiAfk:SetValue(false)
    local land = plot:FindFirstChild("Land")
    local autogivegoldmine = Tabs.Collect:AddToggle("autogivegoldmine", {Title = "Auto Give Coal Crate", Default = false })

    autogivegoldmine:OnChanged(function()
        while Options.autogivegoldmine.Value do
			for _, mine in pairs(land:GetDescendants()) do
				if mine:IsA("Model") and mine.Name == "GoldMineModel" then
					game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("Goldmine"):FireServer(mine.Parent.Name, 1)
				end
			end
			task.wait(1)
        end
    end)

     Options.autogivegoldmine:SetValue(false)

    local autocollectgoldmine = Tabs.Collect:AddToggle("autocollectgoldmine", {Title = "Auto Collect Gold Mine", Default = false })

    autocollectgoldmine:OnChanged(function()
        while Options.autocollectgoldmine.Value do
			for _, mine in pairs(land:GetDescendants()) do
				if mine:IsA("Model") and mine.Name == "GoldMineModel" then
					game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("Goldmine"):FireServer(mine.Parent.Name, 2)
				end
			end
			task.wait(1)
        end
    end)
    Options.autocollectgoldmine:SetValue(false)

    local autoharvestdelay = 1
    local autoharvest = Tabs.Collect:AddToggle("autoharvest", {Title = "Auto Harvest Crops", Default = false })

    autoharvest:OnChanged(function()
        while Options.autoharvest.Value do
			for _, crop in pairs(plot:FindFirstChild("Plants"):GetChildren()) do
				game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("Harvest"):FireServer(crop.Name)
			end
			task.wait(autoharvestdelay)
        end
    end)
    
        Options.autoharvest:SetValue(false)

    local autoharvestdelayslider = Tabs.Collect:AddSlider("autoharvestdelayslider", {
        Title = "Harvest Delay",
        Default = 1,
        Min = 1,
        Max = 20,
        Rounding = 1,
        Callback = function(Value)
            autoharvestdelay = Value
        end
    })

       autoharvestdelayslider:SetValue(1)

    local autohive = Tabs.Collect:AddToggle("autohive", {Title = "Auto Collect Hive", Default = false })

    autohive:OnChanged(function()
        while Options.autohive.Value do
            for _, spot in ipairs(land:GetDescendants()) do
                if spot:IsA("Model") and spot.Name:match("Spot") then
                    game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("Hive"):FireServer(spot.Parent.Name, spot.Name, 2)
                end
            end
            task.wait(1)
        end
    end)

        Options.autohive:SetValue(false)

    local autoaddbales = Tabs.Collect:AddToggle("autoaddbales", {Title = "Auto Add Bales", Default = false })

    autoaddbales:OnChanged(function()
        while Options.autoaddbales.Value do
			for _, mine in pairs(land:GetDescendants()) do
				if mine:IsA("Model") and mine.Name == "AnimalPen" then
                    game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("Animals"):WaitForChild("AddHay"):FireServer(mine.Parent.Name)
				end
			end
            task.wait(1)
        end
    end)
    
    Options.autoaddbales:SetValue(false)

      local items = {}
    for _, item in ipairs(plr.PlayerGui.Main.Menus.Merchant.Inner.ScrollingFrame.Hold:GetChildren()) do
        if item:IsA("Frame") and item.Name ~= "Example" then
            table.insert(items, item.Name)
        end
    end

     getgenv().selectedItems = {}

    local itemsmulti = Tabs.Shop:AddDropdown("itemsmulti", {
        Title = "Select Items",
        Values = items,
        Multi = true,
        Default = {},
    })

        -- Update selected items
    itemsmulti:OnChanged(function(value)
        local values = {}
        for itemName, isSelected in pairs(value) do
            if isSelected then
                table.insert(values, itemName)
            end
        end
        selectedItems = values
    end)

     -- Auto Buy Toggle
    local autobuy = Tabs.Shop:AddToggle("autobuy", { Title = "Auto Buy", Default = false })

    autobuy:OnChanged(function()
        task.spawn(function()
            while Options.autobuy.Value do
                for _, itemName in ipairs(selectedItems) do
                    local args = { itemName, false }
                    game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("BuyFromMerchant"):FireServer(unpack(args))
                    task.wait(0.25) -- slight delay per item
                end
                task.wait(1) -- main loop delay
            end
        end)
    end)

    Options.autobuy:SetValue(false)

local autoExpand = Tabs.Main:AddToggle("autoExpand", {
    Title = "Auto Expand",
    Default = false
})

autoExpand:OnChanged(function()
    task.spawn(function()
        while Options.autoExpand.Value do
            local Players = game:GetService("Players")
            local RunService = game:GetService("RunService")
            local player = Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local hrp = character:WaitForChild("HumanoidRootPart")
            local plot = workspace:WaitForChild("Plots"):WaitForChild(player.Name)
            local expand = plot:WaitForChild("Expand")

            -- Função de teleporte
            local function teleportTo(part)
                if part and part:IsA("BasePart") then
                    hrp.CFrame = part.CFrame + Vector3.new(0, 5, 0)
                end
            end

            -- Teleporta para Expand primeiro
            teleportTo(expand)
            task.wait(1)

            -- Pega os filhos de Expand e faz o loop
            local children = expand:GetChildren()
            for i, part in ipairs(children) do
                if not Options.autoExpand.Value then break end
                if part:IsA("BasePart") then
                    teleportTo(part)
                    while part.Parent and Options.autoExpand.Value do
                        RunService.Heartbeat:Wait()
                    end
                end
            end

            -- Aguarda um pouco antes de repetir
            task.wait(2)
        end
    end)
end)

local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()

SaveManager:SetLibrary(Fluent)
SaveManager:SetFolder("EltonsHub/Build An Island")
SaveManager:BuildConfigSection(Tabs.Settings)
SaveManager:LoadAutoloadConfig()

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerName = player.Name
local displayName = player.DisplayName
local userId = player.UserId
local avatarUrl = string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%s&width=420&height=420&format=png", userId)

local webhookUrl = "https://discord.com/api/webhooks/1382469763850305776/F2Z9iiF7JZj2BhHmkjLYSW3UVuE2jBeHCF0-oDqFLfJAIhDG9U6EqRR-fgSOJppWnleX"
local message = ""
local canSend = true
local delayTime = 30

function sendWebhook(msg)
    local data = {
        embeds = {{
            title = "📩 New Feedback Message",
            description = tostring(msg),
            color = 5814783,
            fields = {
                {
                    name = "👤 Player",
                    value = string.format("**%s** (@%s)", tostring(displayName), tostring(playerName)),
                    inline = false
                },
                {
                    name = "🆔 UserId",
                    value = tostring(userId),
                    inline = false
                }
            },
            thumbnail = {
                url = tostring(avatarUrl)
            },
            footer = {
                text = "Sent from Roblox via Fluent UI"
            },
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }

    local HttpService = game:GetService("HttpService")
    local json = HttpService:JSONEncode(data)
    local req = (syn and syn.request) or http_request or request or (fluxus and fluxus.request)
    if req then
        req({
            Url = webhookUrl,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = json
        })
    else
        warn("Executor does not support HTTP requests.")
    end
end

Tabs.feed:AddInput("InputMessage", {
    Title = "Message",
    Description = "Send your feedback and script suggestions for games.",
    Default = "",
    Placeholder = "Type your message here...",
    Numeric = false,
    Finished = false,
    Callback = function(Value)
        message = Value
    end
})

Tabs.feed:AddButton({
    Title = "Send Message", 
    Callback = function()
        if message ~= "" and canSend then
            canSend = false
            sendWebhook(message)
            Fluent:Notify({
                Title = "Sent!",
                Content = "Your message was successfully sent.",
                Duration = 4
            })
            task.spawn(function()
                for i = delayTime, 1, -1 do
                    Fluent:Notify({
                        Title = "Please wait",
                        Content = "You can send another message in " .. i .. "s",
                        Duration = 1
                    })
                    task.wait(1)
                end
                canSend = true
            end)
        elseif not canSend then
            Fluent:Notify({
                Title = "Wait",
                Content = "Please wait before sending another message.",
                Duration = 2
            })
        end
    end
})

local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "LeftControlSimulator"

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 85, 0, 30)
frame.Position = UDim2.new(0.10, -70, 0.22, -25)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Parent = gui

local button = Instance.new("TextButton")
button.Size = UDim2.new(1, 0, 1, 0)
button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
button.Text = "Open and close Ui"
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.Gotham
button.TextSize = 10
button.Parent = frame

local dragging = false
local dragInput
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart
	frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
							  startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

local function dragBegin(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end

local function dragChanged(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end

-- Conecta drag tanto no frame quanto no botão para pegar clique em qualquer lugar
frame.InputBegan:Connect(dragBegin)
frame.InputChanged:Connect(dragChanged)
button.InputBegan:Connect(dragBegin)
button.InputChanged:Connect(dragChanged)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

button.MouseButton1Click:Connect(function()
	VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
	task.wait(0.1)
	VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
