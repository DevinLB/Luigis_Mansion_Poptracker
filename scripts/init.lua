-- entry point for all lua code of the pack
-- more info on the lua API: https://github.com/black-sliver/PopTracker/blob/master/doc/PACKS.md#lua-interface
ENABLE_DEBUG_LOG = true
-- get current variant
local variant = Tracker.ActiveVariantUID
-- check variant info
IS_ITEMS_ONLY = variant:find("itemsonly")

print("-- Luigi Mansion PopTracker --")
print("Loaded variant: ", variant)
if ENABLE_DEBUG_LOG then
    print("Debug logging is enabled!")
end

-- Utility Script for helper functions etc.
ScriptHost:LoadScript("scripts/utils.lua")

-- Logic
ScriptHost:LoadScript("scripts/logic/logic.lua")


-- Items
Tracker:AddItems("items/items.jsonc")
Tracker:AddItems("items/booitems.json")

    -- Maps
Tracker:AddMaps("maps/maps.jsonc")
    -- Locations
Tracker:AddLocations("locations/start.jsonc")
Tracker:AddLocations("locations/furniture.jsonc")
Tracker:AddLocations("locations/chest.jsonc")
Tracker:AddLocations("locations/boo.jsonc")
Tracker:AddLocations("locations/plant.jsonc")
Tracker:AddLocations("locations/portrait.jsonc")
Tracker:AddLocations("locations/room.jsonc")
Tracker:AddLocations("locations/speedy.jsonc")
Tracker:AddLocations("locations/toad.jsonc")
Tracker:AddLocations("locations/mouse.jsonc")


-- Layout
Tracker:AddLayouts("layouts/items.jsonc")
Tracker:AddLayouts("layouts/tracker.jsonc")
Tracker:AddLayouts("layouts/broadcast.jsonc")

-- AutoTracking for Poptracker
if PopVersion and PopVersion >= "0.18.0" then
    ScriptHost:LoadScript("scripts/autotracking.lua")
end
