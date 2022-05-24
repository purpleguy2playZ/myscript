local waiting = 5

repeat wait() until game:IsLoaded() == true
wait(waiting)

local fruits = {}
local fruitprop = {
    
    {"Dragon Fruit","Neon","Neon orange"},
	{"Soul Fruit","Foil","Alder"},
	{"Control Fruit","SmoothPlastic","Deep blue"},
	{"Shadow Fruit","Neon","Black"},
	{"Dough Fruit","SmoothPlastic","Buttermilk"},
	{"Gravity Fruit","Neon","Royal purple"},
	{"Paw Fruit","Neon","Medium stone grey"},
	{"Rumble","Neon","Toothpaste"},
	{"Bird: Phoenix Fruit","Neon","Deep blue"},
	{"String","Metal","Institutional white"},
	{"Human: Buddha Fruit","Neon","Cork"},
	{"Door Fruit","Glass","Forest green"},
	{"Magma Fruit","SmoothPlastic","Cocoa"},
	{"Barrier Fruit","Neon","Shamrock"},
	{"Rubber Fruit","SmoothPlastic","Pink"},
	{"Love Fruit","Neon","Pink"},
	{"Light Fruit","Plastic","New Yeller"},
	{"Diamond Fruit","SmoothPlastic","Pastel blue-green"},
	{"Revive Fruit","Neon","Lime green"},
	{"Dark Fruit","SmoothPlastic","Royal purple"},
	{"Sand Fruit","SmoothPlastic","Burlap"},
	{"Ice Fruit","SmoothPlastic","Teal"},
	{"Bird: Falcon Fruit","SmoothPlastic","Pine Cone"},
	{"Flame Fruit","SmoothPlastic","Bright orange"},
	{"Spin Fruit","SmoothPlastic","Institutional white"},
	{"Smoke Fruit","SmoothPlastic","Medium stone grey"},
	{"Kilo Fruit","SmoothPlastic","Dark stone grey"},
	{"Chop Fruit","SmoothPlastic","Lavender"},
	{"Spike Fruit","SmoothPlastic","Bright blue"},
	{"Bomb Fruit","SmoothPlastic","Bright red"}

}

local function checking(name)
	local returning = true

	if #blacklist > 0 then
		for i,v in pairs(blacklist) do
			if v == name then
				returning = false
				break
			end
		end
	end

	return returning
end

local function checkprop(obj)
	local mat,col
	local returning = false
	
	if obj:FindFirstChild("Fruit") then
		mat = obj.Fruit.Material.Name
		col = tostring(obj.Fruit.BrickColor)
	else
		mat = obj.Handle.Material.Name
		col = tostring(obj.Handle.BrickColor)
	end

	for i,v in pairs(fruitprop) do
		if v[2] == mat and v[3] == col then
			local final = v[1]
			if final == "Spin Fruit" then
				if not obj.Stem:FindFirstChild("Mesh") then
					final = "Quake Fruit"
				end
			elseif final == "Gravity Fruit" then
				if obj.Handle:FindFirstChild("FireParticleEmitter") then
					final = "Venom Fruit"
				end
			elseif final == "Smoke Fruit" then
			    if obj.Fruit:FindFirstChild("Mesh") then
			        final = "Spring Fruit"
			    end
			end
			if checking(final) == true then
				table.insert(fruits,"Spawned "..final)
			end
			returning = true
		end
	end
	return returning
end

for i,v in pairs(workspace:GetChildren()) do
	if string.find(v.Name,"Fruit") and string.find(v.Name," ") then
		if checking(v.Name) == true then
			if v.Name == "Fruit " then
				if checkprop(v) == false then
					if v:FindFirstChild("Fruit") then
						table.insert(fruits,v.Name.."(Material = "..v.Fruit.Material.Name..", Color = "..tostring(v.Fruit.BrickColor)..")")
					elseif v:FindFirstChild("Handle") then
						table.insert(fruits,v.Name.."(Material = "..v.Handle.Material.Name..", Color = "..tostring(v.Handle.BrickColor)..")")
					end
				end
			else
				table.insert(fruits,v.Name)
			end
		end
	end
end

if game:GetService("ReplicatedStorage"):FindFirstChild("Saw [Lv. 100] [Boss]") and _G.saw == true then
	table.insert(fruits,"Saw")
end

if game:GetService("ReplicatedStorage"):FindFirstChild("Greybeard [Lv. 750] [Raid Boss]") and _G.whitebeard == true then
	table.insert(fruits,"Whitebeard")
end

if game:GetService("ReplicatedStorage"):FindFirstChild("Cursed Captain [Lv. 1325] [Raid Boss]") and _G.cursedcaptain == true then
	table.insert(fruits,"Cursed Captain")
end

if game:GetService("ReplicatedStorage"):FindFirstChild("Darkbeard [Lv. 1000] [Raid Boss]") and _G.blackbeard == true then
	table.insert(fruits,"Blackbeard")
end

if game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") and _G.cakeprince == true then
	table.insert(fruits,"Cake Prince")
end

if _G.ripindra == true then
    if game:GetService("ReplicatedStorage"):FindFirstChild("rip_indra") or game:GetService("ReplicatedStorage"):FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]") then
	    table.insert(fruits,"Rip Indra")
    end
end

if game:GetService("Workspace").Map:FindFirstChild("Dressrosa") and facility == true then
	if game:GetService("Workspace").Map:FindFirstChild("Dressrosa").SmileFactory.Door.CanCollide == false then
		table.insert(fruits,"Facility")
	end
end

	if #fruits > 0 then

		local text = "1. "..fruits[1]
		for i,v in pairs(fruits) do
			if i > 1 then
				text = text.." "..tostring(i)..". "..v
			end
		end

		msg = {
			["embeds"] = {{
				["color"] = 13708129,
				["timestamp"] = DateTime.now():ToIsoDate(),
				["author"] = {
					["name"] = "Blox Fruit Notifier"
				},
				["fields"] = {
					{
						["name"] = "Fruits:",
						["value"] = text,
						["inline"] = true
					},
					{
						["name"] = "Players Amount:",
						["value"] = tostring(#game:GetService("Players"):GetPlayers()-1),
						["inline"] = true
					}
				}
			}}
		}
		
		response = http_request or request or HttpPost or syn.request
		response(
			{
				Url = url,
				Method = "POST",
				Headers = {
					["Content-Type"] = "application/json"
				},
				Body = game:GetService("HttpService"):JSONEncode(msg)
			}
		)
	elseif #fruits == 0 then
		local PlaceID = game.PlaceId
		local AllIDs = {}
		local foundAnything = ""
		local actualHour = os.date("!*t").hour
		local Deleted = false

		local File =
			pcall(
				function()
					AllIDs = game:GetService("HttpService"):JSONDecode(readfile("NotSameServers.json"))
				end
			)
		if not File then
			table.insert(AllIDs, actualHour)
			writefile("NotSameServers.json",     game:GetService("HttpService"):JSONEncode(AllIDs))
		end
		function TPReturner()
			local Site
			if foundAnything == "" then
				Site =
					game.HttpService:JSONDecode(
						game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceID .. "/servers/Public?sortOrder=Asc&limit=100")
					)
			else
				Site =
					game.HttpService:JSONDecode(
						game:HttpGet(
							"https://games.roblox.com/v1/games/" ..
							PlaceID .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. foundAnything
						)
					)
			end
			local ID = ""
			if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
				foundAnything = Site.nextPageCursor
			end
			local num = 0
			for i, v in pairs(Site.data) do
				local Possible = true
				ID = tostring(v.id)
				if tonumber(v.maxPlayers) > tonumber(v.playing) then
					for _, Existing in pairs(AllIDs) do
						if num ~= 0 then
							if ID == tostring(Existing) then
								Possible = false
							end
						else
							if tonumber(actualHour) ~= tonumber(Existing) then
								local delFile =
									pcall(
										function()
											delfile("NotSameServers.json")
											AllIDs = {}
											table.insert(AllIDs, actualHour)
										end
									)
							end
						end
						num = num + 1
					end
					if Possible == true then
						table.insert(AllIDs, ID)
						wait()
						pcall(
							function()
								writefile("NotSameServers.json", game:GetService("HttpService"):JSONEncode(AllIDs))
								wait()
								game:GetService("TeleportService"):TeleportToPlaceInstance(
								PlaceID,
								ID,
								game.Players.LocalPlayer
								)
							end
						)
						wait(4)
					end
				end
			end
		end

		function Teleport()
			while wait() do
				pcall(
					function()
						TPReturner()
						if foundAnything ~= "" then
							TPReturner()
						end
					end
				)
			end
		end
    Teleport()
end
