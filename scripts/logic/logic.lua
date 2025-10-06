ScriptHost:LoadScript("scripts/autotracking/room_connectors.lua")
ScriptHost:LoadScript("scripts/autotracking/archipelago.lua")
ScriptHost:LoadScript("scripts/autotracking/door_rando_tables.lua")

-- Check if Luigi has an item
function has(item, amount)
    local count = Tracker:ProviderCountForCode(item)
    amount = tonumber(amount)
    if not amount then
        return count > 0
    else
        return count >= amount
    end
end

-- boo counter

function booCount()
    return Tracker:ProviderCountForCode("booCount")
end

-- Access Logic

function getAccessibleRooms(mansion_layout, player_keys, starting_room)
    mansion = mansion_layout
    -- Convert keys list to lookup
    local has_key = {}
    for _, key in ipairs(player_keys) do
        has_key[key] = true
    end

    -- Add Open Doors to the key list
    for _, door in ipairs(door_names) do
        if door_locks[_][door] == "1" then
            for __, door2 in pairs(door_keys) do
                if door2.name == door then
                    has_key[door2.key] = true
                end
            end
        end
    end

    -- Boo Gate Logic - remove keys until there is enough boos
    if BALCONY_GATE then
        current_boo_count = booCount()
        if BALCONY_GATE > current_boo_count then 
            if has_key["key_balcony"] then 
                has_key["key_balcony"] = false
            end
        end
        if FINAL_GATE > current_boo_count then 
            if has_key["key_spade"] then 
                has_key["key_spade"] = false
            end
        end
    end

    -- Build bidirectional graph
    local graph = {}
    for from, connections in pairs(mansion) do
        if not graph[from] then graph[from] = {} end
        for _, conn in ipairs(connections) do
            local to = conn.room
            local key = conn.key
            local door = conn.door
            local door_name = conn.door_name
            
            table.insert(graph[from], {room = to, key = key, door = door, door_name = door_name})
            if not graph[to] then graph[to] = {} end
            table.insert(graph[to], {room = from, key = key, door = door, door_name = door_name})
        end
    end
    
    -- If starting room doesn't exist in the graph, return empty list
    if not graph[starting_room] then
        return {}
    end
    
    -- DFS traversal from the starting room
    local accessible = {}
    local visited = {}
    
    local function visit(room)
        if visited[room] then return end
        visited[room] = true
        accessible[room] = true
        for _, conn in ipairs(graph[room]) do
            if conn.key == nil or has_key[conn.key] then
                visit(conn.room)
            end
        end
    end
    
    visit(starting_room)
    
    -- Convert set to list
    local result = {}
    for room, _ in pairs(accessible) do
        table.insert(result, room)
    end

    return result
end

-- Launch the door access logic process here
list_keys = {}
mansion_layout = full_mansion
starting_room = SPAWN_REGION
function canReachRoom(target_room)
    player_keys = {}
    for k, v in pairs(list_keys) do
        if has(v) then 
            table.insert(player_keys, v)
        end
    end

    local accessible_from = getAccessibleRooms(mansion_layout, player_keys, starting_room_strings[starting_room])
    for _, room in ipairs(accessible_from) do
        -- print("room is ", room)
        if room == target_room then
            print(room, " is ", target_room)
            return true
        end
    end
    return false
end

-- Medal Logic

function canGrabFire()
    return has("fire") and (
        canReachRoom("hallway_1f") or 
        canReachRoom("study") or 
        canReachRoom("butler") or 
        canReachRoom("cold") or 
        canReachRoom("mirror") or 
        canReachRoom("dining") or 
        canReachRoom("rear_hallway_2f") or 
        canReachRoom("sitting") or 
        canReachRoom("boneyard") or 
        canReachRoom("clockwork")
    )
end

function canGrabWater()
    return has("water") and (
        canReachRoom("kitchen") or
        canReachRoom("boneyard") or
        canReachRoom("courtyard") or
        canReachRoom("bathroom_1f") or
        canReachRoom("washroom_2f") or
        canReachRoom("sitting")
    )
end
    
function canGrabIce()
    return has ("ice") and (
        canReachRoom("kitchen") or
        canReachRoom("pipe") or
        canReachRoom("tea") or
        canReachRoom("ceramics")
    )
end

-- Elemental Ghost Logic

enemies = {}
function canCatchGhosts(room)
    ghost_element = enemies[room]
    if ghost_element == "No Element" then
        return true
    end
    if ghost_element == "Fire" then
        return canGrabWater()
    end
    if ghost_element == "Ice" then
        return canGrabFire()
    end
    if ghost_element == "Water" then
        return canGrabIce()
    end
    if ghost_element == nil then
        return true
    end
end

-- Clairvoya Logic

function marioItem(item)
    if has(item) then
        return 1
    else
        return 0
    end
end

function marioItems()
    return marioItem("glove") + marioItem("cap") + marioItem("letter") + marioItem("shoe") + marioItem("star")
end

function canBeatClairvoya()
    return marioItems() >= Tracker:ProviderCountForCode("mario_items")
end

-- Huge Flower Logic

function canWaterFlower()
    return (Tracker:ProviderCountForCode("huge_flower") == 3 and canGrabWater())
end

-- Starting in Twins' Room Special Rule (can't catch twins without their key)

function hasTwinsRoomKey()
    return has("key_twin")
end