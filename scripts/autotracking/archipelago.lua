ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")

CUR_INDEX = -1
SLOT_DATA = nil

parlor = 35
foyer = 2
family_hallway = 29
hallway_1f = 6
anteroom = 39
well = 69 -- nice
wardrobe = 38
wardrobe_balcony = 37
study = 34
master_bedroom = 33
nursery = 24
twins = 25
laundry = 5
butler = 0
fortune = 3
ballroom = 10
dining = 9
washroom_1f = 17
bathroom_1f = 20
conservatory = 21
billiards = 12
basement_stairwell = 65
projection = 13
kitchen = 8
boneyard = 11
graveyard = 16
hidden = 1
storage = 14
mirror = 4
rec = 22
courtyard = 23
stairwell_2f = 19
cellar = 63
breaker = 67
basement_hallway = 62
cold = 61
pipe = 66
secret_altar = 70
tea = 47
nana = 46
rear_hallway2f = 26
washroom_2f = 42
bathroom_2f = 45
astral = 40
observatory = 41
sealed = 36
sitting = 27
guest = 28
safari = 52
east_attic = 51
west_attic = 49
artist = 57
balcony = 59
armory = 48
ceramics = 55
telephone = 50
clockwork = 56
roof = 60
spade_hallway = 68

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
        local plant = Tracker:FindObjectForCode('plant')
        plant.CurrentStage = (slot_data['plantsanity'])
    end

    if slot_data['furnisanity'] then
        local furniture = Tracker:FindObjectForCode('object')
        furniture.CurrentStage = (slot_data['furnisanity'])
    end
    if slot_data['speedy spirits'] then
        local spirit = Tracker:FindObjectForCode("speedy")
        spirit.CurrentStage = (slot_data['speedy spirits'])
    end
    if slot_data['clairvoya requirement'] then
        local mario = Tracker:FindObjectForCode("mario_items")
        mario.AcquiredCount = (slot_data['clairvoya requirement'])
    end
    if slot_data['toadsanity'] then
        local toad = Tracker:FindObjectForCode("toad")
        toad.CurrentStage = (slot_data['toadsanity'])
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



Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)