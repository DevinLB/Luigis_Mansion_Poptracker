-- put logic functions here using the Lua API: https://github.com/black-sliver/PopTracker/blob/master/doc/PACKS.md#lua-interface
-- don't be afraid to use custom logic functions. it will make many things a lot easier to maintain, for example by adding logging.
-- to see how this function gets called, check: locations/locations.json
-- example:
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



-- Room Logic

function canReachParlor()
    return has("keyParlor")
end

function canReachAnteroom()
    return has("key_parlor") and has("key_anteroom")
end

function canReachWardrobe()
    return has("key_wardrobe") and canReachAnteroom()
end

function canReachWarBalcony()
    return has("key_wardrobebalcony") and canReachWardrobe()
end

function canReachFamHall()
    return has("key_famhall")
end

function canReachFloor1Hall()
    return has("key_heart")
end

function canReachStudy()
    return has("key_study") and canReachFamHall()
end

function canReachMaster()
    return has("key_master") and canReachFamHall()
end

function canReachNursery()
    return has("key_nursery") and canReachFamHall()
end

function canReachTwins()
    return has("key_twin") and canReachFamHall()
end

function canReachBaseStair()
    return has("key_basementstair") and canReachFloor1Hall()
end

function canReach2FStair()
    return (has("key_lower2f") and canReachFloor1Hall()) or (has("key_southrec") and canReachRec())
end

function canReachCourtyard()
    return (has("key_club") and canReachFloor1Hall()) or (has("key_northrec") and canReachRec())
end

function canReachFloor1Bath()
    return has("key_1fbath") and canReachFloor1Hall()
end

function canReachFloor1Wash()
    return has("key_1fwash") and canReachFloor1Hall() and booCount() >= Tracker:ProviderCountForCode("washroom boo count") --Fix once washroom boo count gets added
end

function canReachBallRoom()
    return has("key_ballroom") and canReachFloor1Hall()
end

function canReachDining()
    return has("key_dining") and canReachFloor1Hall()
end

function canReachLaundry()
    return has("key_laundry") and canReachFloor1Hall()
end

function canReachFortune()
    return has("key_fortune") and canReachFloor1Hall()
end

function canReachRec()
    return (has("key_northrec") and canReachCourtyard()) or (has("key_southrec") and canReach2FStair())
end

function canReachStorage()
    return has("key_storage") and canReachBallRoom()
end

function canReachKitchen()
    return has("key_kitchen") and canReachDining()
end

function canReachBoneyard()
    return has("key_boneyard") and canReachKitchen() and canGrabWater()
end

function canReachGraveyard()
    return canGrabWater() and canReachBoneyard()
end

function canReachConservatory()
    return has("key_conservatory") and canReachFloor1Hall()
end

function canReachBilliards()
    return has("key_billiard") and canReachFloor1Hall()
end

function canReachMirror()
    return has("key_mirror") and canReachFortune()
end

function canReachButler()
    return has("key_butler") and canReachLaundry()
end

function canReachHidden()
    return canReachButler()
end

function canReachWell()
    return canReachCourtyard()
end

function canReachTea()
    return has("key_tea") and canReach2FStair()
end

function canReach2FHall()
    return has("key_upper2f") and canReach2FStair()
end

function canReachF2Bath()
    return has("key_f2bath") and canReach2FHall()
end

function canReach2FWash()
    return has("key_2fwash") and canReach2FHall()
end

function canReachNana()
    return has("key_nana") and canReach2FHall()
end

function canReachAstral()
    return has("key_astral") and canReach2FHall()
end

function canReachSitting()
    return has("key_sitting") and canReach2FHall()
end

function canReachSafari()
    return has("key_safari") and canReach2FHall()
end

function canReachObservatory()
    return has("key_observatory") and canReachAstral() and canGrabFire()
end

function canReachGuest()
    return has("key_guest") and canReachSitting()
end

function canReachEastAttic()
    return has("key_eastattic") and canReachSafari()
end

function canReachArtist()
    return has("key_artist") and canReachEastAttic()
end

function canReachBalcony()
    return has("key_balcony") and canReachEastAttic()
end

function canReachWestAttic()
    return has("key_diamond") and canReachBalcony() and booCount() >= Tracker:ProviderCountForCode("balcony boo count") --Update to check for yaml
end

function canReachArmory()
    return has("key_armory") and canReachWestAttic()
end

function canReachTelephone()
    return has("key_telephone") and canReachWestAttic()
end

function canReachClockWork()
    return has("key_clockwork") and canReachTelephone()
end

function canReachCeramics()
    return has("key_ceramics") and canReachArmory()
end

function canReachRoof()
    return canReachClockWork()
end

function canReachBreaker()
    return has("key_breaker") and canReachBaseStair()
end

function canReachCellar()
    return has("key_cellar") and canReachBaseStair()
end

function canReachBasementHall()
    return has("key_basehall") and canReachCellar()
end

function canReachColdRoom()
    return has("key_cold") and canReachBasementHall()
end

function canReachPipe()
    return has("key_pipe") and canReachBasementHall()
end

function canReachSpadeHall()
    return has("key_spadehall") and canReachBasementHall()
end

function canReachAltar()
    return has("key_spade") and canReachSpadeHall() and booCount() >= Tracker:ProviderCountForCode("final boo count") --Update to match yaml
end

-- Medal Logic

function canGrabFire()
    return has("fire") and 
    (
        canReachFloor1Hall() or 
        canReachStudy() or 
        canReachButler() or 
        canReachColdRoom() or 
        canReachMirror() or 
        canReachDining() or 
        canReach2FHall() or 
        canReachSitting() or 
        canReachGraveyard() or 
        canReachRoof()
    )
end

function canGrabWater()
    return has("water") and
    (
        canReachKitchen() or
        canReachBoneyard() or
        canReachCourtyard() or
        canReachFloor1Bath() or
        canReach2FWash() or
        canReachSitting()
    )
end

function canGrabIce()
    return has("ice") and
    (
        canReachKitchen() or
        canReachPipe() or
        canReachTea() or
        canReachCeramics()
    )
end