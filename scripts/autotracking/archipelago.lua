ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/door_rando_tables.lua")
ScriptHost:LoadScript("scripts/autotracking/ghost_rando_table.lua")
ScriptHost:LoadScript("scripts/autotracking/map_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/room_connectors.lua")

SLOT_DATA = nil
CUR_INDEX = -1
LOCAL_ITEMS = {}
GLOBAL_ITEMS = {}

-- Fix for FindObjectForCode error - handle cases where item codes are tables
function safeGetCode(item)
    if type(item) == "table" then
        return item[1] -- Return first element if it's a table
    elseif type(item) == "string" then
        return item -- Return as-is if it's already a string
    else
        return nil -- Return nil for invalid types
    end
end

function has_value (t, val)
    for i, v in ipairs(t) do
        if v == val then return 1 end
    end
    return 0
end

function dump_table(o, depth)
    if depth == nil then
        depth = 0
    end
    if type(o) == 'table' then
        local tabs = ('\t'):rep(depth)
        local tabs2 = ('\t'):rep(depth + 1)
        local s = '{\n'
        for k, v in pairs(o) do
            if type(k) ~= 'number' then
                k = '"' .. k .. '"'
            end
            s = s .. tabs2 .. '[' .. k .. '] = ' .. dump_table(v, depth + 1) .. ',\n'
        end
        return s .. tabs .. '}'
    else
        return tostring(o)
    end
end

function incrementItem(item_code, item_type, multiplier)
	local obj = Tracker:FindObjectForCode(item_code)
	if obj then
		item_type = item_type or obj.Type
		if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
			print(string.format("incrementItem: code: %s, type %s", item_code, item_type))
		end
		if item_type == "toggle" or item_type == "toggle_badged" then
			obj.Active = true
		elseif item_type == "progressive" or item_type == "progressive_toggle" then
			if obj.Active then
				obj.CurrentStage = obj.CurrentStage + 1
			else
				obj.Active = true
			end
		elseif item_type == "consumable" then
			obj.AcquiredCount = obj.AcquiredCount + obj.Increment * multiplier
		elseif item_type == "custom" then
			-- your code for your custom lua items goes here
		elseif item_type == "static" and AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
			print(string.format("incrementItem: tried to increment static item %s", item_code))
		elseif item_type == "composite_toggle" and AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
			print(string.format(
				"incrementItem: tried to increment composite_toggle item %s but composite_toggle cannot be access via lua." ..
				"Please use the respective left/right toggle item codes instead.", item_code))
		elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
			print(string.format("incrementItem: unknown item type %s for code %s", item_type, item_code))
		end
	elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
		print(string.format("incrementItem: could not find object for code %s", item_code))
	end
end

function onClear(slot_data)
    print(dump_table(slot_data))
    SLOT_DATA = slot_data
    CUR_INDEX = -1

    -- reset locations
    for _, v in pairs(LOCATION_MAPPING) do
        if v[1] then
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[1]:sub(1, 1) == "@" then
                    if obj.ChestCount ~= nil then
                        obj.AvailableChestCount = obj.ChestCount
                    else
                        print(string.format("Warning: Object %s does not have a ChestCount property", v[1]))
                    end
                else
                    obj.Active = false
                end
            end
        end
    end
    -- reset items
    Tracker:FindObjectForCode("key").AcquiredCount = 0
    for _, v in pairs(ITEM_MAPPING) do
        if v[1][1] and v[1][2] then
            local item_code = safeGetCode(v[1][1])
            if item_code then
                if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                    print(string.format("onClear: clearing item %s of type %s", item_code, v[1][2]))
                end
                local obj = Tracker:FindObjectForCode(item_code)
                if obj then
                    if v[1][2] == "toggle" then
                        obj.Active = false
                    elseif v[1][2] == "progressive" then
                        obj.CurrentStage = 0
                        obj.Active = false
                    elseif v[1][2] == "consumable" then
                        obj.AcquiredCount = 0
                    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                        print(string.format("onClear: unknown item type %s for code %s", v[1][2], item_code))
                    end
                elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                    print(string.format("onClear: could not find object for code %s", item_code))
                end
            end
        end
    end

    --Door Randomizer Logic
    starting_room = slot_data['spawn_region']
    print("SPAWNED IN:", starting_room)
    door_locks = {}
        --organizes and iterates the slot_data doors
    for k,v in pairs(door_numbers) do
        door_name = door_names[k]
        door_slot_data = dump_table(slot_data['door rando list'][v])
        -- print(k, v, door_slot_data)
        door_finished = {[door_name] = door_slot_data}
        table.insert(door_locks, door_finished)
        --Prints out door number, door name, and locked status
        print(v, door_names[k], dump_table(door_locks[k][door_names[k]]))
    end
    -- print(dump_table(door_locks))

    --Enemy Randomizer Logic
    enemies = slot_data['ghost elements']

    if slot_data == nil  then
        print("welp")
        return
    end

    PLAYER_ID = Archipelago.PlayerNumber or -1
    TEAM_NUMBER = Archipelago.TeamNumber or 0

    if slot_data['final boo count'] then
        local finalboo = Tracker:FindObjectForCode("final_boo")
        finalboo.AcquiredCount = (slot_data['final boo count'])
        FINAL_GATE = slot_data['final boo count']
    end

    if slot_data['furnisanity'] then
        -- furniture_handler = slot_data['furnisanity']
        for k,setting in pairs(slot_data['furnisanity']) do
            if setting == "Full" then
                local furniture = Tracker:FindObjectForCode('furnisanity')
                furniture.CurrentStage = (1)
            end
            if setting == "Decor" then
                local decor = Tracker:FindObjectForCode('fs_decor')
                decor.CurrentStage = (1)
            end
            if setting == "Ceiling" then
                local ceiling = Tracker:FindObjectForCode('fs_ceiling')
                ceiling.CurrentStage = (1)
            end
            if setting == "Candles" then
                local candles = Tracker:FindObjectForCode('fs_candles')
                candles.CurrentStage = (1)
            end
            if setting == "Hangables" then
                local hangables = Tracker:FindObjectForCode('fs_hangables')
                hangables.CurrentStage = (1)
            end
            if setting == "Seating" then
                local seating = Tracker:FindObjectForCode('fs_seating')
                seating.CurrentStage = (1)
            end
            if setting == "Surfaces" then
                local surfaces = Tracker:FindObjectForCode('fs_surfaces')
                surfaces.CurrentStage = (1)
            end
            if setting == "Storage" then
                local storage = Tracker:FindObjectForCode('fs_storage')
                storage.CurrentStage = (1)
            end
            if setting == "Plants" then
                local plants = Tracker:FindObjectForCode('fs_plants')
                plants.CurrentStage = (1)
            end
            if setting == "Drawers" then
                local drawers = Tracker:FindObjectForCode('fs_drawers')
                drawers.CurrentStage = (1)
            end
            if setting == "Treasures" then
                local treasures = Tracker:FindObjectForCode('fs_treasures')
                treasures.CurrentStage = (1)
            end
        end
    end
    if slot_data['rank requirement'] then
        local goal = Tracker:FindObjectForCode("wincon")
        goal.CurrentStage = (slot_data['rank requirement'])
    end
    if slot_data['clairvoya requirement'] then
        local mario = Tracker:FindObjectForCode("mario_items")
        mario.AcquiredCount = (slot_data['clairvoya requirement'])
    end
    if slot_data['toadsanity'] then
        local toad = Tracker:FindObjectForCode("toadsanity")
        toad.CurrentStage = (slot_data['toadsanity'])
    end
    if slot_data['speedy spirits'] then
        local obj = Tracker:FindObjectForCode("speedy_spirits")
        local stage = slot_data['speedy spirits']
        if stage == 1 then
            obj.CurrentStage = 1
        elseif stage == 0 then
            obj.CurrentStage = 2
        end
    end
    if slot_data['boosanity'] then
        local obj = Tracker:FindObjectForCode("boosanity")
        local stage = slot_data['boosanity']
        if stage == 1 then
            obj.CurrentStage = 1
        elseif stage == 0 then
            obj.CurrentStage = 2
        end
    end
    if slot_data['walksanity'] then
        local obj = Tracker:FindObjectForCode("walksanity")
        local stage = slot_data['walksanity']
        if stage == 1 then
            obj.CurrentStage = 1
        elseif stage == 0 then
            obj.CurrentStage = 2
        end
    end
    if slot_data['portrait ghosts'] then
        local obj = Tracker:FindObjectForCode("portrification")
        local stage = slot_data['portrait ghosts']
        if stage == 1 then
            obj.CurrentStage = 1
        elseif stage == 0 then
            obj.CurrentStage = 2
        end
    end
    if slot_data['lightsanity'] then
        local obj = Tracker:FindObjectForCode("lightsanity")
        local stage = slot_data['lightsanity']
        if stage == 1 then
            obj.CurrentStage = 1
        elseif stage == 0 then
            obj.CurrentStage = 2
        end
    end
    if slot_data['gold_mice'] then
        local obj = Tracker:FindObjectForCode("mouse")
        local stage = slot_data['gold_mice']
        if stage == 1 then
            obj.CurrentStage = 1
        elseif stage == 0 then
            obj.CurrentStage = 2
        end
    end
    if slot_data['washroom boo count'] then
        local mario = Tracker:FindObjectForCode("washroom_boo")
        mario.AcquiredCount = (slot_data['washroom boo count'])
        WASHROOM_GATE = slot_data['washroom boo count']
    end
    if slot_data['balcony boo count'] then
        local mario = Tracker:FindObjectForCode("balcony_boo")
        mario.AcquiredCount = (slot_data['balcony boo count'])
        BALCONY_GATE = slot_data['balcony boo count']
    end

    if slot_data['spawn_region'] then
        SPAWN_REGION = slot_data['spawn_region']
    end

    if Archipelago.PlayerNumber > -1 then
        print("SUCCESS?")
        ROOM_ID = "lm_room_"..TEAM_NUMBER.."_"..PLAYER_ID
        Archipelago:SetNotify({ROOM_ID})
        Archipelago:Get({ROOM_ID})
    end
end


-- Modified onItem function to handle table codes properly and process all item entries
function onItem(index, item_id, item_name, player_number)
	if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
		print(string.format("called onItem: %s, %s, %s, %s, %s", index, item_id, item_name, player_number, CUR_INDEX))
	end
	if not AUTOTRACKER_ENABLE_ITEM_TRACKING then
		return
	end
	if index <= CUR_INDEX then
		return
	end
	local is_local = player_number == Archipelago.PlayerNumber
	CUR_INDEX = index
	local mapping_entry = ITEM_MAPPING[item_id]
	if not mapping_entry then
		if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
			print(string.format("onItem: could not find item mapping for id %s", item_id))
		end		return
	end
	for _, item_table in pairs(mapping_entry) do
		if item_table then
			local item_code = safeGetCode(item_table[1])
			local item_type = item_table[2]
			local multiplier = item_table[3] or 1
			if item_code then
				incrementItem(item_code, item_type, multiplier)
				-- keep track which items we touch are local and which are global
				if is_local then
					if LOCAL_ITEMS[item_code] then
						LOCAL_ITEMS[item_code] = LOCAL_ITEMS[item_code] + 1
					else
						LOCAL_ITEMS[item_code] = 1
					end
				else
					if GLOBAL_ITEMS[item_code] then
						GLOBAL_ITEMS[item_code] = GLOBAL_ITEMS[item_code] + 1
					else
						GLOBAL_ITEMS[item_code] = 1
					end
				end
			elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
				print(string.format("onItem: skipping item_table with no item_code"))
			end
		elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
			print(string.format("onItem: skipping empty item_table"))
		end
	end
	if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
		print(string.format("local items: %s", dump_table(LOCAL_ITEMS)))
		print(string.format("global items: %s", dump_table(GLOBAL_ITEMS)))
	end
end

function onLocation(location_id, location_name)
    local loc_list = LOCATION_MAPPING[location_id]

    for i, loc in ipairs(loc_list) do
        if not loc then
            return
        end
        print(loc)
        local obj = Tracker:FindObjectForCode(loc)
        if obj then
            if loc:sub(1, 1) == "@" then
                obj.AvailableChestCount = obj.AvailableChestCount - 1
            else
                obj.Active = true
            end
        end
    end
end

function onNotify(key, value, old_value)
	if value ~= old_value then
		if key == ROOM_ID then
            print("room: "..value)
        end
	end
end

function onNotifyLaunch(key, value)
    Tracker.BulkUpdate = false
    if key == ROOM_ID then
        print("room: "..value)
    end
end

function onMapChange(key, value, old)
    -- print("key", key)
    -- print("old", old)
    -- print("value", value)
    print("got  " .. key .. " = " .. tostring(value) .. " (was " .. tostring(old) .. ")")
    print(dump_table(MAP_MAPPING[tostring(value)]))

    tabs = MAP_MAPPING[tostring(value)]
    for i, tab in ipairs(tabs) do
        Tracker:UiHint("ActivateTab", tab)
    end
end



Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)
Archipelago:AddSetReplyHandler("notify handler", onNotify)
Archipelago:AddRetrievedHandler("notify launch handler", onNotifyLaunch)
Archipelago:AddSetReplyHandler("map_key", onMapChange)
Archipelago:AddRetrievedHandler("map_key", onMapChange)

