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




-- NEW ACCESS LOGIC


function getAccessibleRooms(mansion_layout, player_keys, starting_room)
    mansion = mansion_layout
    -- Convert keys list to lookup
    -- print("STEP 3 -----", starting_room)
    local has_key = {}
    for _, key in ipairs(player_keys) do
        has_key[key] = true
        -- print(dump_table(has_key))
    end

    local door_check = {}
    print(dump_table(door_locks))
    for _, door in ipairs(door_names) do
        -- print(dump_table(door))
        print(door)
        print("-- door")
        -- print(dump_table(door_locks[_][door]))
        if door_locks[_][door] == "1" then
            -- door_check[lock] = true
            -- door_checks = door_check
            -- print(dump_table(door_check[lock]))
            
            -- print(door)
            -- print(dump_table(mansion_layout)) 
            -- print(dump_table(mansion_layout[door])) 
            -- print(mansion_layout[door][1]) 
            print(type(door))
            print(dump_table(door_locks[_]))
            print(mansion["secret_altar"][1].door)
            print(mansion[door][1].door) --why the fuck does this shit not work when everything is right
            print("check --")
        end
    end

    -- print("STEP 3.1 -----", "graph")
    -- Build bidirectional graph
    local graph = {}
    for from, connections in pairs(mansion) do
        if not graph[from] then graph[from] = {} end
        for _, conn in ipairs(connections) do
            local to = conn.room
            local key = conn.key
            local door = conn.door
            -- print(to, key, door)
            
            table.insert(graph[from], {room = to, key = key, door = door})
            if not graph[to] then graph[to] = {} end
            table.insert(graph[to], {room = from, key = key, door = door})
        end
    end
    
    -- If starting room doesn't exist in the graph, return empty list
    if not graph[starting_room] then
        return {}
    end
    
    -- print("STEP 3.2 -----", "visited")
    -- DFS traversal from the starting room
    local accessible = {}
    local visited = {}
    
    local function visit(room)
        if visited[room] then return end
        visited[room] = true
        accessible[room] = true
        for _, conn in ipairs(graph[room]) do
            if conn.key == nil or has_key[conn.key] or (conn.door == "1") then
                visit(conn.room)
            end
        end
    end
    
    visit(starting_room)
    
    -- print("STEP 3.3 -----", "result")
    -- Convert set to list
    local result = {}
    for room, _ in pairs(accessible) do
        table.insert(result, room)
    end

    return result
end

mansion_layout = SPAWN_CONNECTIONS
-- player_keys = list_keys
starting_room = spawn_region

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





-- Access Logic

-- function canReachParlor()
--     return has("key_parlor") or isDoorOpen("parlor")
-- end

-- function canReachAnteroom()
--     return canReachParlor() and (has("key_anteroom") or isDoorOpen("anteroom"))
-- end

-- function canReachWardrobe()
--     return (has("key_wardrobe") or isDoorOpen("wardrobe")) and canReachAnteroom()
-- end

-- function canReachWarBalcony()
--     return (has("key_wardrobebalcony") or isDoorOpen("wardrobe_balcony")) and canReachWardrobe()
-- end

-- function canReachFamHall()
--     return has("key_famhall") or isDoorOpen("family_hallway")
-- end

-- function canReachFloor1Hall()
--     return has("key_heart") or isDoorOpen("hallway_1f")
-- end

-- function canReachStudy()
--     return (has("key_study") or isDoorOpen("study")) and canReachFamHall()
-- end

-- function canReachMaster()
--     return (has("key_masterbed") or isDoorOpen("master_bedroom")) and canReachFamHall()
-- end

-- function canReachNursery()
--     return (has("key_nursery") or isDoorOpen("nursery")) and canReachFamHall()
-- end

-- function canReachTwins()
--     return (has("key_twin") or isDoorOpen("twins")) and canReachFamHall()
-- end

-- function canReachBaseStair()
--     return (has("key_basestair") or isDoorOpen("basement_stairwell")) and canReachFloor1Hall()
-- end

-- function canReach2FStair()
--     return ((has("key_lower2f") or isDoorOpen("stairwell_2f_w")) and canReachFloor1Hall()) or ((has("key_southrec") or isDoorOpen("rec_room_s")) and (has("key_northrec") or isDoorOpen("rec_room_n")) and canReachCourtyard())
-- end

-- function canReachCourtyard()
--     return ((has("key_club") or isDoorOpen("courtyard_w")) and canReachFloor1Hall()) or ((has("key_northrec") or isDoorOpen("rec_room_n")) and (has("key_southrec") or isDoorOpen("rec_room_s")) and canReach2FHall())
-- end

-- function canReachFloor1Bath()
--     return (has("key_1fbath") or isDoorOpen("bathroom_1f")) and canReachFloor1Hall()
-- end

-- function canReachFloor1Wash()
--     return (has("key_1fwash") or isDoorOpen("washroom_1f")) and canReachFloor1Hall() and booCount() >= Tracker:ProviderCountForCode("washroom_boo") --Fix once washroom boo count gets added
-- end

-- function canReachBallRoom()
--     return (has("key_ballroom") or isDoorOpen("ballroom")) and canReachFloor1Hall()
-- end

-- function canReachDining()
--     return (has("key_dining") or isDoorOpen("dining")) and canReachFloor1Hall()
-- end

-- function canReachLaundry()
--     return (has("key_laundry") or isDoorOpen("laundry")) and canReachFloor1Hall()
-- end

-- function canReachFortune()
--     return (has("key_fortune") or isDoorOpen("fortune")) and canReachFloor1Hall()
-- end

-- function canReachMirror()
--     return (has("key_mirror") or isDoorOpen("mirror")) and canReachFortune()
-- end

-- function canReachRec()
--     return ((has("key_northrec") or isDoorOpen("rec_room_n")) and canReachCourtyard()) or ((has("key_southrec") or isDoorOpen("rec_room_s")) and canReach2FStair())
-- end

-- function canReachStorage()
--     return (has("key_storage") or isDoorOpen("storage")) and canReachBallRoom()
-- end

-- function canReachKitchen()
--     return (has("key_kitchen") or isDoorOpen("kitchen")) and canReachDining()
-- end

-- function canReachBoneyard()
--     return (has("key_boneyard") or isDoorOpen("key_boneyard")) and canReachKitchen() and canGrabWater()
-- end

-- function canReachGraveyard()
--     return canGrabWater() and canReachBoneyard()
-- end

-- function canReachConservatory()
--     return (has("key_conservatory") or isDoorOpen("conservatory")) and canReachFloor1Hall()
-- end

-- function canReachBilliards()
--     return (has("key_billiards") or isDoorOpen("billiards")) and canReachFloor1Hall()
-- end

-- function canReachProjection()
--     return (has("key_projection") or isDoorOpen("projection")) and canReachBilliards()
-- end

-- function canReachButler()
--     return (has("key_butler") or isDoorOpen("butler")) and canReachLaundry()
-- end

-- function canReachHidden()
--     return canReachButler()
-- end

-- function canReachWell()
--     return canReachCourtyard()
-- end

-- function canReachTea()
--     return (has("key_tea") or isDoorOpen("tea")) and canReach2FStair() and canGrabWater()
-- end

-- function canReach2FHall()
--     return (has("key_upper2f") or isDoorOpen("rear_hallway_2f")) and canReach2FStair()
-- end

-- function canReach2FBath()
--     return (has("key_2fbath") or isDoorOpen("bathroom_2f")) and canReach2FHall()
-- end

-- function canReach2FWash()
--     return (has("key_2fwash") or isDoorOpen("washroom_2f")) and canReach2FHall()
-- end

-- function canReachNana()
--     return (has("key_nana") or isDoorOpen("nana")) and canReach2FHall()
-- end

-- function canReachAstral()
--     return (has("key_astral") or isDoorOpen("astral")) and canReach2FHall()
-- end

-- function canReachSitting()
--     return (has("key_sitting") or isDoorOpen("sitting")) and canReach2FHall()
-- end

-- function canReachSafari()
--     return (has("key_safari") or isDoorOpen("safari")) and canReach2FHall()
-- end

-- function canReachObservatory()
--     return (has("key_observatory") or isDoorOpen("observatory")) and canReachAstral() and canGrabFire()
-- end

-- function canReachGuest()
--     return (has("key_guest") or isDoorOpen("guest")) and canReachSitting()
-- end

-- function canReachEastAttic()
--     return (has("key_eastattic") or isDoorOpen("east_attic")) and canReachSafari()
-- end

-- function canReachArtist()
--     return (has("key_artist") or isDoorOpen("artist")) and canReachEastAttic()
-- end

-- function canReachBalcony()
--     return (has("key_balcony") or isDoorOpen("balcony")) and canReachEastAttic() and booCount() >= Tracker:ProviderCountForCode("balcony_boo")
-- end

-- function canReachWestAttic()
--     return (has("key_diamond") or isDoorOpen("west_attic")) and canReachBalcony()
-- end

-- function canReachArmory()
--     return (has("key_armory") or isDoorOpen("armory")) and canReachWestAttic()
-- end

-- function canReachTelephone()
--     return (has("key_telephone") or isDoorOpen("telephone")) and canReachWestAttic()
-- end

-- function canReachClockWork()
--     return (has("key_clockwork") or isDoorOpen("clockwork")) and canReachTelephone()
-- end

-- function canReachCeramics()
--     return (has("key_ceramics") or isDoorOpen("ceramics")) and canReachArmory()
-- end

-- function canReachRoof()
--     return canReachClockWork()
-- end

-- function canReachBreaker()
--     return (has("key_breaker") or isDoorOpen("breaker")) and canReachBaseStair()
-- end

-- function canReachCellar()
--     return (has("key_cellar") or isDoorOpen("cellar")) and canReachBaseStair()
-- end

-- function canReachBasementHall()
--     return (has("key_basehall") or isDoorOpen("basement_hallway")) and canReachCellar()
-- end

-- function canReachColdRoom()
--     return (has("key_cold") or isDoorOpen("cold")) and canReachBasementHall()
-- end

-- function canReachPipe()
--     return (has("key_pipe") or isDoorOpen("pipe")) and canReachBasementHall()
-- end

-- function canReachSpadeHall()
--     return (has("key_spadehall") or isDoorOpen("spade_hallway")) and canReachBasementHall()
-- end

-- function canReachAltar()
--     return (has("key_spade") or isDoorOpen("secret_altar")) and canReachSpadeHall() and booCount() >= Tracker:ProviderCountForCode("final_boo")
-- end

-- Medal Logic

function canGrabFire()
    -- return has("fire") and 
    -- (
    --     canReachFloor1Hall() or 
    --     canReachStudy() or 
    --     canReachButler() or 
    --     canReachColdRoom() or 
    --     canReachMirror() or 
    --     canReachDining() or 
    --     canReach2FHall() or 
    --     canReachSitting() or 
    --     canReachGraveyard() or 
    --     canReachRoof()
    -- )
    return true
end

function canGrabWater()
-- return has("water") and
-- (
    --     canReachKitchen() or
    --     canReachBoneyard() or
    --     canReachCourtyard() or
    --     canReachFloor1Bath() or
    --     canReach2FWash() or
    --     canReachSitting()
    -- )
    return true
end
    
function canGrabIce()
    -- return has("ice") and
    -- (
    --     canReachKitchen() or
    --     canReachPipe() or
    --     canReachTea() or
    --     canReachCeramics()
    -- )
    return true
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
    -- print("TESTING ELEMENTAL GHOST LOGIC FOR", room)
    -- print(dump_table(enemies[room]))
    ghost_element = enemies[room]
    if ghost_element == "No Element" then
        return true
    end
    if ghost_element == "Fire" then
        -- return canGrabWater()
        return true
    end
    if ghost_element == "Ice" then
        -- return canGrabFire()
        return true
    end
    if ghost_element == "Water" then
        -- return canGrabIce()
        return true
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