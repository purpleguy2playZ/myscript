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


local function checkprop(obj)
	local mat,col,inserted
	
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
			table.insert(fruits,"Spawned "..final)
			inserted = true
			break
		end
	end
	
	if inserted == false then
	    if v:FindFirstChild("Fruit") then
			table.insert(fruits,v.Name.."(Material = "..mat..", Color = "..tostring(col)..")")
		elseif v:FindFirstChild("Handle") then
			table.insert(fruits,v.Name.."(Material = "..nat..", Color = "..tostring(col)..")")
		end
	end
end

for i,v in pairs(workspace:GetChildren()) do
	if string.find(v.Name,"Fruit") then
		if v.Name == "Fruit " then
			checkprop(v)
		else
			table.insert(fruits,v.Name)
		end
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
					},
					{
						["name"] = "Execute:",
						["value"] = 'game:GetService("TeleportService"):TeleportToPlaceInstance(2753915549,"'..game.JobId..'")',
						["inline"] = false
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

end
