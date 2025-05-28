ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/door_rando_tables.lua")
ScriptHost:LoadScript("scripts/autotracking/map_mapping.lua")

CUR_INDEX = -1
SLOT_DATA = nil

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

function onClear(slot_data)
    print(dump_table(slot_data))
    SLOT_DATA = slot_data
    CUR_INDEX = -1
    --reset locations
    for _, v in pairs(LOCATION_MAPPING) do
        if v[1] then
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[1]:sub(1, 1) == "@" then
                    obj.AvailableChestCount = obj.ChestCount
                else
                    obj.Active = false
                end
            end
        end
    end
    -- reset items
    for _, v in pairs(ITEM_MAPPING) do
        if v[1] and v[2] then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: clearing item %s of type %s", v[1], v[2]))
            end
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[2] == "toggle" then
                    obj.Active = false
                elseif v[2] == "progressive" then
                    obj.CurrentStage = 0
                    obj.Active = false
                elseif v[2] == "consumable" then
                    obj.AcquiredCount = 0
                elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                    print(string.format("onClear: unknown item type %s for code %s", v[2], v[1]))
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: could not find object for code %s", v[1]))
            end
        end
    end

    --Door Randomizer Logic
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

    if slot_data == nil  then
        print("welp")
        return
    end

    PLAYER_ID = Archipelago.PlayerNumber or -1
    TEAM_NUMBER = Archipelago.TeamNumber or 0

    if slot_data['final boo count'] then
        local finalboo = Tracker:FindObjectForCode("boo")
        finalboo.AcquiredCount = (slot_data['final boo count'])
    end

    if slot_data['goal'] then
        local goal = Tracker:FindObjectForCode("wincon")
        goal.CurrentStage = (slot_data['goal'])
    elseif slot_data['rank requirement'] then
        local rank = Tracker:FindObjectForCode("wincon")
        rank.CurrentStage = (slot_data['rank requirement'])
    end
    if slot_data['plantsanity'] then
        local plant = Tracker:FindObjectForCode('plantsanity')
        plant.CurrentStage = (slot_data['plantsanity'])
    end

    if slot_data['furnisanity'] then
        local furniture = Tracker:FindObjectForCode('furnisanity')
        -- furniture.CurrentStage = (slot_data['furnisanity'])
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
    if slot_data['washroom boo count'] then
        local mario = Tracker:FindObjectForCode("washroom_boo")
        mario.AcquiredCount = (slot_data['washroom boo count'])
    end
    if slot_data['balcony boo count'] then
        local mario = Tracker:FindObjectForCode("balcony_boo")
        mario.AcquiredCount = (slot_data['balcony boo count'])
    end
    if Archipelago.PlayerNumber > -1 then
        print("SUCCESS?")
        ROOM_ID = "lm_room_"..TEAM_NUMBER.."_"..PLAYER_ID
        Archipelago:SetNotify({ROOM_ID})
        Archipelago:Get({ROOM_ID})
    end
end

function onItem(index, item_id, item_name, player_number)
    if index <= CUR_INDEX then
        return
    end
    local is_local = player_number == Archipelago.PlayerNumber
    CUR_INDEX = index;
    local v = ITEM_MAPPING[item_id]
    if not v or not v[1] then
        --print(string.format("onItem: could not find item mapping for id %s", item_id))
        return
    end
    local obj = Tracker:FindObjectForCode(v[1])
    if obj then
        if v[2] == "toggle" then
            obj.Active = true
        elseif v[2] == "progressive" then
            if obj.Active then
                obj.CurrentStage = obj.CurrentStage + 1
            else
                obj.Active = true
            end
        elseif v[2] == "consumable" then
            obj.AcquiredCount = obj.AcquiredCount + obj.Increment
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: unknown item type %s for code %s", v[2], v[1]))
        end
    else
        print(string.format("onItem: could not find object for code %s", v[1]))
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