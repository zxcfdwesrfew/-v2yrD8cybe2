local https = game:GetService("HttpService")

local clothingWebhook = "https://discord.com/api/webhooks/1361043894049181898/uearmUJKIGUkFc4tBNWoqJeDQG2iji7FQLjI-OXlAxaVRrxkuQHF6Kjbdge2JvcvyoUi"


local function sendDiscordMessage(webhook, message)
	local info = {
		content = message,
		username = "Clothing Logger",
		avatar_url = ""
	}
	local encoded = https:JSONEncode(info)
	https:PostAsync(webhook, encoded)
end

game:GetService("ReplicatedStorage").GameNetwork.ServerNetwork.DropClothing.OnServerInvoke = function(player, name)
	local gg = player:FindFirstChild("ClothingStorage")
	if gg then
		local hed = gg:FindFirstChild(name)
		if hed then
			local Proximity = game:GetService("ReplicatedStorage"):FindFirstChild("CollectPrompt"):Clone()
			hed.Parent = Proximity
			Proximity.ActionText = hed.Name

			local currentTime = os.date("%Y-%m-%d %H:%M:%S")

			
			local function removeClothing(clothingType)
				if clothingType == "Кофта" then
					-- Удалить кофту с игрока
					for _, shirt in pairs(player.Character:GetChildren()) do
						if shirt:IsA("Shirt") and shirt.ShirtTemplate == "http://www.roblox.com/asset/?id=" .. hed.ID.Value then
							shirt:Destroy()
						end
					end
					
					local defaultShirt = Instance.new("Shirt")
					defaultShirt.ShirtTemplate = "http://www.roblox.com/asset/?id=4818675062"
					defaultShirt.Parent = player.Character
				elseif clothingType == "Штаны" then
					
					for _, pants in pairs(player.Character:GetChildren()) do
						if pants:IsA("Pants") and pants.PantsTemplate == "http://www.roblox.com/asset/?id=" .. hed.ID.Value then
							pants:Destroy()
						end
					end
					
					local defaultPants = Instance.new("Pants")
					defaultPants.PantsTemplate = "http://www.roblox.com/asset/?id=4354659735"
					defaultPants.Parent = player.Character
				end
			end

			
			if hed.Value == "Кофта" then
				local var_56 = game:GetService("ReplicatedStorage"):FindFirstChild("ShirtTemplate"):Clone()
				var_56.Parent = workspace
				var_56.Shir.ShirtTemplate = "http://www.roblox.com/asset/?id=" .. hed.ID.Value

				local randomX = math.random(90, 90) 
				local randomZ = math.random(-90, 90) 

				local shirtOrientation = CFrame.fromOrientation(math.rad(randomX), math.rad(53), math.rad(randomZ))
				local shirtPosition = player.Character.Head.Position - Vector3.new(0, 3, 0) + player.Character.Head.CFrame.LookVector * 2
				var_56.PrimaryPart.CFrame = CFrame.new(shirtPosition) * shirtOrientation

				Proximity.Parent = var_56.Torso.Attachment
				Proximity.ActionText = "подобрать " .. hed.Name
				var_56.Humanoid.Sit = true
				wait(0.1)
				var_56.PrimaryPart.Anchored = true

				sendDiscordMessage(clothingWebhook, player.Name .. " Выбросил кофту: " .. hed.Name .. " в " .. currentTime)

				
				removeClothing("Кофта")

			elseif hed.Value == "Штаны" then
				local var_56 = game:GetService("ReplicatedStorage"):FindFirstChild("PantsTemplate"):Clone()
				var_56.Parent = workspace
				var_56.Pants.PantsTemplate = "http://www.roblox.com/asset/?id=" .. hed.ID.Value

				local randomX = math.random(-90, 90) 
				local randomZ = math.random(-90, 90) 

				local pantsOrientation = CFrame.fromOrientation(math.rad(90), math.rad(-55 + randomX), math.rad(randomZ))
				local pantsPosition = player.Character.Head.Position - Vector3.new(0, 3, 0) + player.Character.Head.CFrame.LookVector * 2
				var_56.PrimaryPart.CFrame = CFrame.new(pantsPosition) * pantsOrientation

				Proximity.Parent = var_56.Handle.Attachment
				Proximity.ActionText = "подобрать " .. hed.Name
				var_56.Humanoid.Sit = true
				wait(0.1)
				var_56.PrimaryPart.Anchored = true

				sendDiscordMessage(clothingWebhook, player.Name .. " Выбросил штаны: " .. hed.Name .. " в " .. currentTime)

				
				removeClothing("Штаны")

			else
				
				local accessoryTemplate = game.ReplicatedStorage.Accessory:FindFirstChild(hed.Name .. "_Viewmodel")
				if accessoryTemplate then
					local droppedModel = Instance.new("Model")
					droppedModel.Name = hed.Name

					local clonedAccessory = accessoryTemplate:Clone()
					for _, child in pairs(clonedAccessory:GetChildren()) do
						child.Parent = droppedModel
					end
					clonedAccessory:Destroy()

					local handleClone = droppedModel:FindFirstChild("Handle")
					if handleClone then
						droppedModel.PrimaryPart = handleClone

						local targetPosition = player.Character.Head.Position - Vector3.new(0, 3, 0) + player.Character.Head.CFrame.LookVector * 2
						droppedModel:SetPrimaryPartCFrame(CFrame.new(targetPosition))

						local at = Instance.new("Attachment")
						at.Parent = handleClone

						Proximity.Parent = at
						Proximity.ActionText = "подобрать " .. hed.Name

						handleClone.Anchored = true
						handleClone.CanCollide = true

						droppedModel.Parent = workspace

						sendDiscordMessage(clothingWebhook, player.Name .. " Выбросил предмет: " .. hed.Name .. " в " .. currentTime)
					else
						warn("У аксессуара нет Handle: " .. hed.Name)
					end
				else
					warn("Не найден аксессуар: " .. hed.Name)
				end


			end

					
			Proximity.Triggered:Connect(function(triggeredPlayer)
				if triggeredPlayer == player then
					sendDiscordMessage(clothingWebhook, triggeredPlayer.Name .. " Подобрал: " .. hed.Name .. " в " .. currentTime)
				end
			end)
		end
	end
end










--[[local https = game:GetService("HttpService")

local clothingWebhook = "https://discord.com/api/webhooks/1318252812769038407/O38S1ne7wpJx9yE1dBfD7HyCMdNqmuKkkT8eK6SPA2vYytSWPNW8fN698UYGC9doFU8m"


local function sendDiscordMessage(webhook, message)
	local info = {
		content = message,
		username = "Clothing Logger",
		avatar_url = ""
	}
	local encoded = https:JSONEncode(info)
	https:PostAsync(webhook, encoded)
end

game:GetService("ReplicatedStorage").GameNetwork.ServerNetwork.DropClothing.OnServerInvoke = function(player, name)
	local gg = player:FindFirstChild("ClothingStorage")
	if gg then
		local hed = gg:FindFirstChild(name)
		if hed then
			local Proximity = game:GetService("ReplicatedStorage"):FindFirstChild("CollectPrompt"):Clone()
			hed.Parent = Proximity
			Proximity.ActionText = hed.Name

			local currentTime = os.date("%Y-%m-%d %H:%M:%S")


			local function removeClothing(clothingType)
				if clothingType == "Кофта" then
					-- Удалить кофту с игрока
					for _, shirt in pairs(player.Character:GetChildren()) do
						if shirt:IsA("Shirt") and shirt.ShirtTemplate == "http://www.roblox.com/asset/?id=" .. hed.ID.Value then
							shirt:Destroy()
						end
					end

					local defaultShirt = Instance.new("Shirt")
					defaultShirt.ShirtTemplate = "http://www.roblox.com/asset/?id=4818675062"
					defaultShirt.Parent = player.Character
				elseif clothingType == "Штаны" then

					for _, pants in pairs(player.Character:GetChildren()) do
						if pants:IsA("Pants") and pants.PantsTemplate == "http://www.roblox.com/asset/?id=" .. hed.ID.Value then
							pants:Destroy()
						end
					end

					local defaultPants = Instance.new("Pants")
					defaultPants.PantsTemplate = "http://www.roblox.com/asset/?id=4354659735"
					defaultPants.Parent = player.Character
				end
			end


			if hed.Value == "Кофта" then
				local var_56 = game:GetService("ReplicatedStorage"):FindFirstChild("Content"):FindFirstChild("TemplatesDrop"):FindFirstChild("HangerShirt"):Clone()
				var_56.Parent = workspace
				var_56.ClothingShirt:FindFirstChildOfClass("Decal").Texture = "http://www.roblox.com/asset/?id=" .. hed.ID.Value

				local randomX = math.random(90, 90) 
				local randomZ = math.random(-90, 90) 

				local shirtOrientation = CFrame.fromOrientation(math.rad(randomX), math.rad(53), math.rad(randomZ))
				local shirtPosition = player.Character.Head.Position - Vector3.new(0, 3, 0) + player.Character.Head.CFrame.LookVector * 2
				var_56.PrimaryPart.CFrame = CFrame.new(shirtPosition) * shirtOrientation

				Proximity.Parent = var_56.Torso
				Proximity.ActionText = "подобрать " .. hed.Name
				var_56.Humanoid.Sit = true
				wait(0.1)
				var_56.PrimaryPart.Anchored = true

				sendDiscordMessage(clothingWebhook, player.Name .. " выбросил кофту: " .. hed.Name .. " в " .. currentTime)


				removeClothing("Кофта")

			elseif hed.Value == "Штаны" then
				local var_56 = game:GetService("ReplicatedStorage"):FindFirstChild("Content"):FindFirstChild("TemplatesDrop"):FindFirstChild("HangerPants"):Clone()
				var_56.Parent = workspace
				var_56.ClothingPants:FindFirstChildOfClass("Decal").Texture = "http://www.roblox.com/asset/?id=" .. hed.ID.Value

				local randomX = math.random(-90, 90) 
				local randomZ = math.random(-90, 90) 

				local pantsOrientation = CFrame.fromOrientation(math.rad(90), math.rad(-55 + randomX), math.rad(randomZ))
				local pantsPosition = player.Character.Head.Position - Vector3.new(0, 3, 0) + player.Character.Head.CFrame.LookVector * 2
				var_56.PrimaryPart.CFrame = CFrame.new(pantsPosition) * pantsOrientation

				Proximity.Parent = var_56.Handle
				Proximity.ActionText = "подобрать " .. hed.Name
				var_56.Humanoid.Sit = true
				wait(0.1)
				var_56.PrimaryPart.Anchored = true

				sendDiscordMessage(clothingWebhook, player.Name .. " выбросил штаны: " .. hed.Name .. " в " .. currentTime)


				removeClothing("Штаны")

			else

				local accessoryTemplate = game.ReplicatedStorage.Accessory:FindFirstChild(hed.Name .. "_Viewmodel")
				if accessoryTemplate then

					local handle = accessoryTemplate:FindFirstChild("Handle")
					if handle then

						local clonedAccessory = accessoryTemplate:Clone()
						clonedAccessory.Parent = workspace


						local handleClone = clonedAccessory:FindFirstChild("Handle")
						if handleClone then


							local targetPosition = player.Character.Head.Position - Vector3.new(0, 3, 0) + player.Character.Head.CFrame.LookVector * 2
							handleClone.CFrame = CFrame.new(targetPosition) 


							Proximity.Parent = handleClone
							Proximity.ActionText = "подобрать " .. hed.Name


							handleClone.Anchored = true


							sendDiscordMessage(clothingWebhook, player.Name .. " выбросил предмет: " .. hed.Name .. " в " .. currentTime)
						else
							warn("У аксессуара нет Handle: " .. hed.Name)
						end
					else
						warn("Не найден Handle в аксессуаре: " .. hed.Name)
					end
				end
			end


			Proximity.Triggered:Connect(function(triggeredPlayer)
				if triggeredPlayer == player then
					sendDiscordMessage(clothingWebhook, triggeredPlayer.Name .. " подобрал: " .. hed.Name .. " в " .. currentTime)
				end
			end)
		end
	end
end
]]
