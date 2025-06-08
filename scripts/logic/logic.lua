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

--counter

function booCount()
    return Tracker:ProviderCountForCode("booCount")
end




-- Acess Logic

function getAccessibleRooms(mansion_layout, player_keys, starting_room)
    mansion = mansion_layout
    -- Convert keys list to lookup
    local has_key = {}
    for _, key in ipairs(player_keys) do
        has_key[key] = true
    end

    -- TEMP add open doors to has_key list
    for _, door in ipairs(door_names) do
        if door_locks[_][door] == "1" then
            for __, door2 in pairs(door_keys) do
                if door2.name == door then
                    has_key[door2.key] = true
                end
            end
        end
    end

    -- Shelving open door logic as a separate entity, just tying it into the key check until the graph can successfully check the open doors
    -- Check against door_locks to mark which doors are starting open --FIND WAY TO INCLUDE stairwell_2f AND rec_room DOORS
    -- print(dump_table(door_locks))
    -- for _, door in ipairs(door_names) do
    --     if door_locks[_][door] == "1" then
    --         if (door ~= "stairwell_2f_n" and door ~= "stairwell_2f_w" and door ~= "rec_room_n" and door ~= "rec_room_s" and door ~= "courtyard_e" and door ~= "courtyard_w") then
    --             -- print(dump_table(mansion))
    --             -- print(dump_table(door_locks))
    --             for k, v in ipairs(mansion[door]) do
    --                 if v.door_name == door then
    --                     mansion[door][k].door = "1"
    --                 end
    --             end
    --         end
    --         if (door == "stairwell_2f_n" or door == "stairwell_2f_w" or door == "rec_room_n" or door == "rec_room_s" or door ~= "courtyard_e" or door ~= "courtyard_w") then
    --             if (door == "stairwell_2f_w") then
    --                 mansion["hallway_1f"][7].door = 1
    --                 mansion["stairwell_2f"][1].door = 1
    --             end
    --             if (door == "stairwell_2f_n" or door == "rec_room_s") then
    --                 mansion["rec_room"][2].door = 1
    --                 mansion["stairwell_2f"][2].door = 1
    --             end
    --             if (door == "rec_room_n" or door == "courtyard_e") then
    --                 mansion["courtyard"][2].door = 1
    --                 mansion["rec_room"][1].door = 1
    --             end
    --             if (door == "courtyard_w") then
    --                 mansion["courtyard"][1].door = 1
    --                 mansion["hallway_1f"][12].door = 1
    --             end
    --         end
    --     end
    -- end

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
        -- print("START ------------------------------------------------------------------------------------------------------------")
        -- print(room)
        if visited[room] then return end
        visited[room] = true
        accessible[room] = true
        for _, conn in ipairs(graph[room]) do
            -- print("Connection?: ", conn.door_name)
            if (conn.key == nil or has_key[conn.key]) or (conn.door == "1") then
                if has_key[conn.key] == nil then 
                    print("Room: ", conn.door_name, " is already open")
                end
                -- print("CONNECTION SUCCESS: ", conn.door_name)
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



function accesibleFromFoyer(mansion_layout, player_keys, target_room)
    local accessible_from = getAccessibleRooms(mansion_layout, player_keys, "foyer")
    for _, room in ipairs(accessible_from) do
        if room == target_room then 
            -- print(room, " is ", target_room)
            return true 
        end 
    end
end

function accessibleFromMasterBedroom(mansion_layout, player_keys, target_room)
    local accessible_from = getAccessibleRooms(mansion_layout, player_keys, "master_bedroom")
    for _, room in ipairs(accessible_from) do
        if room == target_room then 
            -- print(room, " is ", target_room)
            return true 
        end 
    end
end

function accessibleFromCourtyard(mansion_layout, player_keys, target_room)
    local accessible_from = getAccessibleRooms(mansion_layout, player_keys, "courtyard")
    for _, room in ipairs(accessible_from) do
        if room == target_room then 
            -- print(room, " is ", target_room)
            return true 
        end 
    end
end

function accessibleFromClockwork(mansion_layout, player_keys, target_room)
    local accessible_from = getAccessibleRooms(mansion_layout, player_keys, "clockwork")
    for _, room in ipairs(accessible_from) do
        if room == target_room then 
            -- print(room, " is ", target_room)
            return true 
        end 
    end
end

function accessibleFromHidden(mansion_layout, player_keys, target_room)
    local accessible_from = getAccessibleRooms(mansion_layout, player_keys, "hidden")
    for _, room in ipairs(accessible_from) do
        if room == target_room then 
            -- print(room, " is ", target_room)
            return true 
        end 
    end
end

function accessibleFromRec(mansion_layout, player_keys, target_room)
    local accessible_from = getAccessibleRooms(mansion_layout, player_keys, "rec_room")
    for _, room in ipairs(accessible_from) do
        if room == target_room then 
            -- print(room, " is ", target_room)
            return true 
        end 
    end
end

function accessibleFromLaundry(mansion_layout, player_keys, target_room)
    local accessible_from = getAccessibleRooms(mansion_layout, player_keys, "laundry")
    for _, room in ipairs(accessible_from) do
        if room == target_room then 
            -- print(room, " is ", target_room)
            return true 
        end 
    end
end

function accessibleFromTelephone(mansion_layout, player_keys, target_room)
    local accessible_from = getAccessibleRooms(mansion_layout, player_keys, "telephone")
    for _, room in ipairs(accessible_from) do
        if room == target_room then 
            -- print(room, " is ", target_room)
            return true 
        end 
    end
end

function accessibleFromButler(mansion_layout, player_keys, target_room)
    local accessible_from = getAccessibleRooms(mansion_layout, player_keys, "butler")
    for _, room in ipairs(accessible_from) do
        if room == target_room then 
            -- print(room, " is ", target_room)
            return true 
        end 
    end
end

function accessibleFromConservatory(mansion_layout, player_keys, target_room)
    local accessible_from = getAccessibleRooms(mansion_layout, player_keys, "conservatory")
    for _, room in ipairs(accessible_from) do
        if room == target_room then 
            -- print(room, " is ", target_room)
            return true 
        end 
    end
end

function accessibleFromBilliards(mansion_layout, player_keys, target_room)
    local accessible_from = getAccessibleRooms(mansion_layout, player_keys, "billiards")
    for _, room in ipairs(accessible_from) do
        if room == target_room then 
            -- print(room, " is ", target_room)
            return true 
        end 
    end
end

function accessibleFromTwins(mansion_layout, player_keys, target_room)
    local accessible_from = getAccessibleRooms(mansion_layout, player_keys, "twins")
    for _, room in ipairs(accessible_from) do
        if room == target_room then 
            -- print(room, " is ", target_room)
            return true 
        end 
    end
end

function accessibleFromNursery(mansion_layout, player_keys, target_room)
    local accessible_from = getAccessibleRooms(mansion_layout, player_keys, "nursery")
    for _, room in ipairs(accessible_from) do
        if room == target_room then 
            -- print(room, " is ", target_room)
            return true 
        end 
    end
end

function accessibleFromParlor(mansion_layout, player_keys, target_room)
    local accessible_from = getAccessibleRooms(mansion_layout, player_keys, "parlor")
    for _, room in ipairs(accessible_from) do
        if room == target_room then 
            -- print(room, " is ", target_room)
            return true 
        end 
    end
end

function accessibleFromNana(mansion_layout, player_keys, target_room)
    local accessible_from = getAccessibleRooms(mansion_layout, player_keys, "nana")
    for _, room in ipairs(accessible_from) do
        if room == target_room then 
            -- print(room, " is ", target_room)
            return true 
        end 
    end
end

-- Launch the process here. Possibly combine accessibleFrom functions with these
list_keys = {}
mansion_layout = full_mansion
starting_room = spawn_region
function canReachRoom(target_room)
    player_keys = {}
    for k, v in pairs(list_keys) do
        -- print(v)
        if has(v) then 
            table.insert(player_keys, v)
        end
    end
    -- print(dump_table(player_keys))

    if starting_room == "Foyer" then
        return accessibleFromFoyer(mansion_layout, player_keys, target_room)
    end
    if starting_room == "Courtyard" then
        return accessibleFromCourtyard(mansion_layout, player_keys, target_room)
    end
    if starting_room == "Clockwork Room" then
        return accessibleFromClockwork(mansion_layout, player_keys, target_room)
    end
    if starting_room == "Hidden Room" then
        return accessibleFromHidden(mansion_layout, player_keys, target_room)
    end
    if starting_room == "Rec Room" then
        return accessibleFromRec(mansion_layout, player_keys, target_room)
    end
    if starting_room == "Laundry Room" then
        return accessibleFromLaundry(mansion_layout, player_keys, target_room)
    end
    if starting_room == "Telephone Room" then
        return accessibleFromTelephone(mansion_layout, player_keys, target_room)
    end
    if starting_room == "Butler's Room" then
        return accessibleFromButler(mansion_layout, player_keys, target_room)
    end
    if starting_room == "Conservatory" then
        return accessibleFromConservatory(mansion_layout, player_keys, target_room)
    end
    if starting_room == "Billiard's Room" then
        return accessibleFromBilliards(mansion_layout, player_keys, target_room)
    end
    if starting_room == "Twins' Room" then
        return accessibleFromTwins(mansion_layout, player_keys, target_room)
    end
    if starting_room == "Nursery" then
        return accessibleFromNursery(mansion_layout, player_keys, target_room)
    end
    if starting_room == "Master Bedroom" then
        return accessibleFromMasterBedroom(mansion_layout, player_keys,target_room)
    end
    if starting_room == "Parlor" then
        return accessibleFromParlor(mansion_layout, player_keys, target_room)
    end
    if starting_room == "Nana's Room" then
        return accessibleFromNana(mansion_layout, player_keys, target_room)
    end
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

-- Room Logic

door_locks = {} -- Ensure door_locks is defined
function isDoorOpen(door)
    local door_doors = {} 
    local door_doors = door_locks
    -- print("DOOR LOCKS")
    -- print(door)
    for k,v in pairs (door_doors) do
        if door_doors[k][door] ~= nill then
            local door_status = door_doors[k][door]
            -- print("DOOR STATUS")
            if door_status == "1" then
                -- print("Door is Open!")
                return true
            else
                -- print("Door is Locked!")
                return false
            end
        end
    end
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
    return has("huge_flower_3") and canGrabWater()
end