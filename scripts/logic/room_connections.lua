-- Define a complete map of room connections (bidirectional)
ROOM_CONNECTIONS = {
    ["Foyer"] = {
        ["1F Hallway"] = "key_heart",
        ["Parlor"] = "key_parlor",
        ["Family Hallway"] = "key_famhall",
    },
    ["Family Hallway"] = {
        ["Foyer"] = "key_heart",
        ["Study"] = "key_study",
        ["Master Bedroom"] = "key_masterbed",
        ["Nursery"] = "key_nursery",
        ["Twin's Room"] = "key_twin"
    },
    ["Parlor"] = {
        ["Foyer"] = "key_parlor",
        ["Anteroom"] = "key_anteroom"
    },
    ["Anteroom"] = {
        ["Parlor"] = "key_anteroom",
        ["Wardrobe"] = "key_wardrobe"
    },
    ["Wardrobe"] = {
        ["Anteroom"] = "key_wardrobe",
        ["Wardrobe Balcony"] = "key_wardrobebalcony"
    },
    ["Wardrobe Balcony"] = {
        ["Wardrobe"] = "key_wardrobebalcony"
    },
    ["1F Hallway"] = {
        ["Foyer"] = "key_diamond",
        ["Laundry Room"] = "key_laundry",
        ["Fortune Teller's Room"] = "key_fortune",
        ["Basement Stairwell"] = "key_basestair",
        ["Ballroom"] = "key_ballroom",
        ["Dining Room"] = "key_dining",
        ["Billiards Room"] = "key_billiards",
        ["1F Washroom"] = "key_1fwash",
        ["1F Bathroom"] = "key_1fbath",
        ["Conservatory"] = "key_conservatory",
        ["Courtyard"] = "key_club",
        ["2F Stairwell"] = "key_lower2f"
    },
    ["Laundry Room"] = {
        ["1F Hallway"] = "key_laundry",
        ["Butler's Room"] = "key_butler"
    },
    ["Butler's Room"] = {
        ["Laundry Room"] = "key_laundry",
        ["Hidden Room"] = nil
    },
    ["Hidden Room"] = {
        ["Butler's Room"] = nil
    },
    ["Fortune Teller's Room"] = {
        ["1F Hallway"] = "key_fortune",
        ["Mirror Room"] = "key_mirror"
    },
    ["Mirror Room"] = {
        ["Fortune Teller's Room"] = "key_mirror"
    },
    ["Ballroom"] = {
        ["1F Hallway"] = "key_ballroom",
        ["Storage Room"] = "key_storage"
    },
    ["Storage Room"] = {
        ["Ballroom"] = "key_storage"
    },
    ["Dining Room"] = {
        ["1F Hallway"] = "key_dining",
        ["Kitchen"] = "key_kitchen"
    },
    ["Kitchen"] = {
        ["Dining Room"] = "key_kitchen",
        ["Boneyard"] = "key_boneyard"
    },
    ["Boneyard"] = {
        ["Kitchen"] = "key_boneyard",
        ["Graveyard"] = nil  -- No key needed for Graveyard
    },
    ["Graveyard"] = {
        ["Boneyard"] = nil
    },
    ["Billiards Room"] = {
        ["1F Hallway"] = "key_billiards",
        ["Projection Room"] = "key_projection",
        ["Foyer"] = nil  -- Mirror
    },
    ["Projection Room"] = {
        ["Billiards Room"] = "key_projection"
    },
    ["Conservatory"] = {
        ["1F Hallway"] = "key_conservatory"
    },
    ["1F Washroom"] = {
        ["1F Hallway"] = "key_1fwash"
    },
    ["1F Bathroom"] = {
        ["1F Hallway"] = "key_1fbath"
    },
    ["Courtyard"] = {
        ["1F Hallway"] = "key_club",
        ["Rec Room"] = "key_northrec"
    },
    ["Rec Room"] = {
        ["2F Stairwell"] = "key_southrec",
        ["Courtyard"] = "key_northrec"
    },
    ["2F Stairwell"] = {
        ["1F Hallway"] = "key_lower2f",
        ["Tea Room"] = "key_tea",
        ["2F Hallway"] = "key_upper2f",
        ["Rec Room"] = "key_southrec"
    },
    ["Tea Room"] = {
        ["2F Stairwell"] = "key_tea"
    },
    ["2F Hallway"] = {
        ["2F Stairwell"] = "key_upper2f",
        ["Nana's Room"] = "key_nana",
        ["2F Washroom"] = "key_2fwash",
        ["2F Bathroom"] = "key_2fbath",
        ["Astral Hall"] = "key_astral",
        ["Sitting Room"] = "key_sitting",
        ["Safari Room"] = "key_safari"
    },
    ["Nana's Room"] = {
        ["2F Hallway"] = "key_nana"
    },
    ["2F Washroom"] = {
        ["2F Hallway"] = "key_2fwash"
    },
    ["2F Bathroom"] = {
        ["2F Hallway"] = "key_2fbath"
    },
    ["Astral Hall"] = {
        ["2F Hallway"] = "key_astral",
        ["Observatory"] = "key_observatory"
    },
    ["Observatory"] = {
        ["Astral Hall"] = "key_observatory"
    },
    ["Sitting Room"] = {
        ["2F Hallway"] = "key_sitting",
        ["Guest Room"] = "key_guest"
    },
    ["Guest Room"] = {
        ["Sitting Room"] = "key_guest"
    },
    ["Safari Room"] = {
        ["2F Hallway"] = "key_safari",
        ["East Attic Hallway"] = "key_eastattic"
    },
    ["East Attic Hallway"] = {
        ["Safari Room"] = "key_eastattic",
        ["Artist's Studio"] = "key_artist",
        ["Balcony"] = "key_balcony"
    },
    ["Artist's Studio"] = {
        ["East Attic Hallway"] = "key_artist"
    },
    ["Balcony"] = {
        ["East Attic Hallway"] = "key_balcony",
        ["West Attic Hallway"] = "key_diamond"
    },
    ["West Attic Hallway"] = {
        ["Balcony"] = "key_diamond",
        ["Telephone Room"] = "key_telephone",
        ["Armory"] = "key_armory"
    },
    ["Telephone Room"] = {
        ["West Attic Hallway"] = "key_telephone",
        ["Clockwork Room"] = "key_clockwork"
    },
    ["Clockwork Room"] = {
        ["Telephone Room"] = "key_clockwork",
        ["Roof"] = nil
    },
    ["Roof"] = {
        ["Clockwork Room"] = nil,
        ["Sealed Room"] = "key_sealed"  -- One-way to Sealed Room
    },
    ["Sealed Room"] = {
        -- No connection back to Roof, only to Foyer
    },
    ["Armory"] = {
        ["West Attic Hallway"] = "key_armory",
        ["Ceramics Studio"] = "key_ceramics"
    },
    ["Ceramics Studio"] = {
        ["Armory"] = "key_ceramics"
    },
    ["Basement Stairwell"] = {
        ["1F Hallway"] = "key_basestair",
        ["Breaker Room"] = "key_breaker",
        ["Cellar"] = "key_cellar"
    },
    ["Breaker Room"] = {
        ["Basement Stairwell"] = "key_breaker"
    },
    ["Cellar"] = {
        ["Basement Stairwell"] = "key_cellar",
        ["Basement Hallway"] = "key_basementhall"
    },
    ["Basement Hallway"] = {
        ["Cellar"] = "key_cellar",
        ["Cold Room"] = "key_cold",
        ["Pipe Room"] = "key_pipe",
        ["Altar Hallway"] = "key_spadehall"
    },
    ["Cold Room"] = {
        ["Basement Hallway"] = "key_cold"
    },
    ["Pipe Room"] = {
        ["Basement Hallway"] = "key_pipe"
    },
    ["Altar Hallway"] = {
        ["Basement Hallway"] = "key_spadehall",
        ["Secret Altar"] = "key_altar"
    },
    ["Secret Altar"] = {
        ["Altar Hallway"] = "key_spade"
    }
}
