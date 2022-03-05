--print("Fire Script has loaded! Coded by Rjross2013")

ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj 
end)

local chatStreetAlerts = true
local chanceForSpread = 900 -- basically a thousand sided dice is rolled and if it gets above this number then the fire spreads once
local spawnRandomFires = true -- set to true and put x,y,z locations and amount of time before their is a chance of a fire spawning
local spawnRandomFireChance = 100 -- basically a thousand sided dice is rolled and if it gets above this number then a fire spawns at one of the locations specified
local randomSpawnTimeMin = 120000 -- time to wait before trying ot spawn another random fire in milliseconds 1,200,000 is 20 minutes this is per player.
local randomSpawnTimeMax = 240000
local randomFireLocations = {} --  this is the format you need to put in for your possible locations.}
l1 = {x=1491.52, y= -2336.72, z= 73.78}
l2 = {x=2081.25, y= 2809.25, z= 50.29}
l3 = {x=767.83, y= 3039.73, z= 49.65 }
l4 = {x=1376.58, y= 3703.25, z= 33.27}
l5 = {x=271.66, y= 909.94, z= 209.82}
l6 = {x=-593.25, y= -1451.20, z= 10.01}
l7 = {x=-627.60, y= -1861.86, z= 29.52}
l8 = {x=2557.26, y= -25.15, z= 97.32}
l9 = {x=1827.06, y= 1818.60, z= 68.34}
l10 = {x=2079.31, y= 5079.79, z= 43.58}
l11 = {x=1842.78, y= 4897.71, z= 43.47}
l12 = {x=38.94, y= 6887.82, z= 14.13}
l13 = {x=-592.95, y= 6228.28, z= 12.58}
local minimumFire = 1


function returnRandom(min, max)
	math.randomseed(GetGameTimer())
	return math.random(min, max)
end

function enoughAmbulances()
	if (ESX == nil) then end
		local jobCounter = 0
		local xPlayers = ESX.GetPlayers()
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			local jobTable = xPlayer.getJob()
			if jobTable.name == "fire" then
				jobCounter = jobCounter + 1
			end
		end
		if jobCounter >= minimumFire then
			print('More than '..minimumFire..' fire fighters online')
			return true
		else 
			return false
		end
end

if spawnRandomFires == true then
	Citizen.CreateThread(function() 
		while true do
			Citizen.Wait( math.random(randomSpawnTimeMin, randomSpawnTimeMax) )
			local randomNumber = math.random(1,1000)
			print('timers up')
			if randomNumber > spawnRandomFireChance then
				
					if enoughAmbulances() == true then
						local possibleLocations = #randomFireLocations
						local LocationID = math.random(1, 50)
						if LocationID < 30 then
							loc = math.random(1, 16)
							if loc == 1 then
								location = l1
							elseif loc == 2 then
								location = l2
							elseif loc == 3 then
								location = l3
							elseif loc == 4 then
								location = l4
							elseif loc == 5 then
								location = l5
							elseif loc == 6 then
								location = l6
							elseif loc == 7 then
								location = l7
							elseif loc == 8 then
								location = l8
							elseif loc == 9 then
								location = l9
							elseif loc == 10 then
								location = l10
							elseif loc == 11 then
								location = l11
							elseif loc == 12 then
								location = l12
							elseif loc == 13 then
								location = l4
							elseif loc == 14 then
								location = l3
							elseif loc == 15 then
								location = l2
							elseif loc == 16 then
								location = l1
							end

							firep = 0
						local xPlayers = ESX.GetPlayers()
						for i=1, #xPlayers, 1 do
						local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
						local jobTable = xPlayer.getJob()
							if jobTable.name == "fire" then
								firep = firep + 1
								print('FireFighter Host Is, '..xPlayer.source)
								if firep == 1 then
									TriggerClientEvent('startfire', xPlayer.source, location)
								end
							end
						end
						TriggerClientEvent('startfire', location)
					end
					end
				
			end
		end 

	end)
end





RegisterServerEvent('fire:chatAlert')
AddEventHandler('fire:chatAlert', function( text, coords )  
    TriggerClientEvent('cd_dispatch:AddNotification', -1, {
        job_table = {'fire'}, --{'police', 'sheriff} 
        coords = coords,
        title = 'Forest Fire!',
        message = 'A Forest Fire Has Been Spotted At '..text, 
        flash = 0, 
        blip = {
            sprite = 648, 
            scale = 1.2, 
            colour = 17,
            flashes = false, 
            text = 'Forest Fire',
            time = (5*60*1000),
            sound = 1,
        }
    })
end)


 RegisterServerEvent("lol:firesyncs")
 AddEventHandler("lol:firesyncs", function( firec, lastamnt, deletedfires, original )
	--local test = ping
	TriggerClientEvent("lol:firesyncs2", -1, firec, lastamnt, deletedfires, original)
	--TriggerClientEvent("lol:firesync3", -1)
 end)
  RegisterServerEvent("lol:fireremovesyncs2")
 AddEventHandler("lol:fireremovesyncs2", function( firec, lastamnt, deletedfires, original )
	--local test = ping
	TriggerClientEvent("lol:fireremovesync", -1, firec, lastamnt, deletedfires, original)
 end)
 RegisterServerEvent("lol:firesyncs60")
 AddEventHandler("lol:firesyncs60", function()
	--local test = ping
	--TriggerClientEvent("lol:firesyncs2", -1, firec, lastamnt, deletedfires, original)
	TriggerClientEvent("lol:firesync3", -1)
 end)
 
  RegisterServerEvent("lol:removefires")
 AddEventHandler("lol:removefires", function( x, y, z, i )
	local test = i
	--local test = ping
	TriggerClientEvent("lol:fireremovess", -1, x, y, z, test)
	--TriggerClientEvent("lol:firesync3", -1)
 end)

 RegisterCommand('stopallfires', function(source, args, rawCommand)
			TriggerClientEvent("chatMessage", p, "FIRE ", {255, 0, 0}, "You stopped all fires!")
        	TriggerClientEvent("lol:firestop", p)
			TriggerClientEvent("lol:firesync", -1)
        	CancelEvent()
 end, true)


--AddEventHandler("chatMessage", function(p, color, msg)
--    if msg:sub(1, 1) == "/" then
--        fullcmd = stringSplit(msg, " ")
--        cmd = fullcmd[1]
--		
--			
--
--        if cmd == "/fire" then
--			TriggerClientEvent("chatMessage", p, "FIRE ", {255, 0, 0}, "You started a fire! ")
--                local fireamnt = cmd[2]
--        	TriggerClientEvent("lol:firethings", p)
--        	CancelEvent()
--        end
--        if cmd == "/firestop" then
--			TriggerClientEvent("chatMessage", p, "FIRE ", {255, 0, 0}, "You stopped all fires!")
--        	TriggerClientEvent("lol:firestop", p)
--			TriggerClientEvent("lol:firesync", -1)
--        	CancelEvent()
--        end
--        if cmd == "/coords" then
--        	TriggerClientEvent("lol:coords", p)
--        	CancelEvent()
--        end
--		if cmd == "/firecount" then
--        	TriggerClientEvent("lol:firecounter", p)
--        	CancelEvent()
--        end
--        if cmd == "/cbomb" then
--        	TriggerClientEvent("lol:carbomb", p)
--        	CancelEvent()
--        end
--		if cmd == "/test" then
--        	TriggerClientEvent("lol:test1", p)
--        	CancelEvent()
--        end
--		if cmd == "/sync" then
--        	TriggerClientEvent("lol:firesync3", p)
--        end
--        if cmd == "/firehelp" then
--        	TriggerClientEvent("chatMessage", p, "FIRE ", {255, 0, 0}, "You can start a big fire by typing /fire, and you can also start a single fire by pressing the home key! /cbomb blows up the last car you entered and starts a big fire around it!")
--        	CancelEvent()
--        end
--    end
--end)
RegisterServerEvent("potato:syncedAlarm")
AddEventHandler("potato:syncedAlarm", function()
  TriggerClientEvent("triggerSound", source)
end)
function stringSplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end