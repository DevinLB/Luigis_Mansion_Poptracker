list_keys = {
    "key_heart", 
    "key_club", 
    "key_diamond", 
    "key_spade", 
    "key_parlor", 
    "key_anteroom", 
    "key_wardrobe", 
    "key_famhall", 
    "key_MasterBed", 
    "key_nursery", 
    "key_twin", 
    "key_ballroom", 
    "key_storage", 
    "key_fortune", 
    "key_laundry", 
    "key_butler", 
    "key_lower2f", 
    "key_conservatory", 
    "key_dining", 
    "key_northrec", 
    "key_billiards", 
    "key_safari", 
    "key_balcony", 
    "key_cellar", 
    "key_clockwork", 
    "key_armory", 
    "key_sitting", 
    "key_pipe", 
    "key_cold", 
    "key_artist", 
    "key_wardrobebalcony", 
    "key_study", 
    "key_basementstair", 
    "key_1fbath", 
    "key_1fwash", 
    "key_kitchen", 
    "key_boneyard", 
    "key_projection", 
    "key_mirror", 
    "key_mirror", 
    "key_tea", 
    "key_southrec", 
    "key_upper2f", 
    "key_2fbath", 
    "key_2fwash", 
    "key_nana", 
    "key_astral", 
    "key_observatory", 
    "key_guest", 
    "key_eastattic", 
    "key_telephone", 
    "key_ceramics", 
    "key_breaker", 
    "key_basehall", 
    "key_spadehall"
}

SPAWN_CONNECTIONS = {
    ["foyer"] = {
        {room = "parlor", key = "key_parlor", door = "0"},
        {room = "family_hallway", key = "key_famhall", door = "0"},
        {room = "hallway_1f", key = "key_heart", door = "0"}
    },
    ["parlor"] = {
        {room = "foyer", key = "key_", door = "0"},
        {room = "anteroom", key = "key_", door = "0"}
    }, 
    ["anteroom"] = {
        {room = "parlor", key = "key_anteroom", door = "0"},
        {room = "wardrobe", key = "key_wardrobe", door = "0"}
    }, 
    ["wardrobe"] = {
        {room = "anteroom", key = "key_wardrobe", door = "0"},
        {room = "wardrobe_balcony", key = "key_wardrobebalcony", door = "0"}
    }, 
    ["wardrobe_balcony"] = {
        {room = "wardrobe", key = "key_wardrobebalcony", door = "0"}
    }, 
    ["family_hallway"] = {
        {room = "foyer", key = "key_famhall", door = "0"},
        {room = "study", key = "key_study", door = "0"},
        {room = "master_bedroom", key = "key_MasterBed", door = "0"},
        {room = "nursery", key = "key_nursery", door = "0"},
        {room = "twins", key = "key_twin", door = "0"},
    }, 
    ["study"] = {
        {room = "family_hallway", key = "key_study", door = "0"}
    }, 
    ["master_bedroom"] = {
        {room = "family_hallway", key = "key_MasterBed", door = "0"}
    }, 
    ["nursery"] = {
        {room = "family_hallway", key = "key_nursery", door = "0"}
    }, 
    ["twins"] = {
        {room = "family_hallway", key = "key_twin", door = "0"}
    }, 
    ["hallway_1f"] = {
        {room = "foyer", key = "key_heart", door = "0"},
        {room = "laundry", key = "key_laundry", door = "0"},
        {room = "fortune", key = "key_fortune", door = "0"},
        {room = "basement_stairwell", key = "key_basementstair", door = "0"},
        {room = "dining", key = "key_dining", door = "0"},
        {room = "ballroom", key = "key_ballroom", door = "0"},
        {room = "stairwell_2f", key = "key_lower2f", door = "0"},
        {room = "conservatory", key = "key_conservatory", door = "0"},
        {room = "billiards", key = "key_billiards", door = "0"},
        {room = "washroom_1f", key = "key_1fwash", door = "0"},
        {room = "bathroom_1f", key = "key_1fbath", door = "0"},
        {room = "courtyard", key = "key_club", door = "0"},
    }, 
    ["laundry"] = {
        {room = "hallway_1f", key = "key_laundry", door = "0"},
        {room = "butler", key = "key_butler", door = "0"}
    }, 
    ["butler"] = {
        {room = "laundry", key = "key_butler", door = "0"}
    },
    ["courtyard"] = {
        {room = "hallway_1f", key = "key_club", door = "0"},
        {room = "rec_room", key = "key_northrec", door = "0"}
    }, 
    ["bathroom_1f"] = {
        {room = "hallway_1f", key = "key_1fbath", door = "0"}
    }, 
    ["washroom_1f"] = {
        {room = "hallway_1f", key = "key_1fwash", door = "0"}
    }, 
    ["conservatory"] = {
        {room = "hallway_1f", key = "key_conservatory", door = "0"}
    }, 
    ["billiards"] = {
        {room = "hallway_1f", key = "key_billiards", door = "0"}
    }, 
    ["projection"] = {
        {room = "billiards", key = "key_projection", door = "0"}
    }, 
    ["ballroom"] = {
        {room = "hallway_1f", key = "key_ballrom", door = "0"},
        {room = "storage", key = "key_storage", door = "0"}
    }, 
    ["storage"] = {
        {room = "ballroom", key = "key_ballrom", door = "0"}
    }, 
    ["fortune"] = {
        {room = "hallway_1f", key = "key_fortune", door = "0"},
        {room = "mirror", key = "key_mirror", door = "0"}
    }, 
    ["mirror"] = {
        {room = "fortune", key = "key_mirror", door = "0"}
    }, 
    ["dining"] = {
        {room = "hallway_1f", key = "key_dining", door = "0"},
        {room = "kitchen", key = "key_kitchen", door = "0"}
    }, 
    ["kitchen"] = {
        {room = "dining", key = "key_kitchen", door = "0"},
        {room = "boneyard", key = "key_boneyard", door = "0"}
    }, 
    ["boneyard"] = {
        {room = "kitchen", key = "key_boneyard", door = "0"}
    }, 
    ["rec_room"] = {
        {room = "courtyard", key = "key_northrec", door = "0"},
        {room = "stairwell_2f", key = "key_southrec", door = "0"}
    }, 
    ["stairwell_2f"] = {
        {room = "hallway_1f", key = "key_lower2f", door = "0"},
        {room = "rec_room", key = "key_southrec", door = "0"},
        {room = "tea", key = "key_tea", door = "0"},
        {room = "rear_hallway_2f", key = "key_upper2f", door = "0"}
    },
    ["tea"] = {
        {room = "stairwell_2f", key = "key_tea", door = "0"}
    }, 
    ["rear_hallway_2f"] = {
        {room = "stairwell_2f", key = "key_upper2f", door = "0"},
        {room = "nana", key = "key_nana", door = "0"},
        {room = "washroom_2f", key = "key_2fwash", door = "0"},
        {room = "bathroom_2f", key = "key_2fbath", door = "0"},
        {room = "astral", key = "key_astral", door = "0"},
        {room = "sitting", key = "key_sitting", door = "0"},
        {room = "safari", key = "key_safari", door = "0"}
    }, 
    ["bathroom_2f"] = {
        {room = "rear_hallway_2f", key = "key_bath2f", door = "0"}
    }, 
    ["washroom_2f"] = {
        {room = "rear_hallway_2f", key = "key_wash2f", door = "0"}
    }, 
    ["nana"] = {
        {room = "rear_hallway_2f", key = "key_nana", door = "0"}
    }, 
    ["astral"] = {
        {room = "rear_hallway_2f", key = "key_astral", door = "0"},
        {room = "observatory", key = "key_observatory", door = "0"}
    }, 
    ["observatory"] = {
        {room = "astral", key = "key_observatory", door = "0"}
    }, 
    ["sitting"] = {
        {room = "rear_hallway_2f", key = "key_sitting", door = "0"},
        {room = "guest", key = "key_guest", door = "0"}
    }, 
    ["guest"] = {
        {room = "sitting", key = "key_guest", door = "0"}
    }, 
    ["safari"] = {
        {room = "rear_hallway_2f", key = "key_safari", door = "0"},
        {room = "east_attic", key = "key_eastattic", door = "0"}
    }, 
    ["east_attic"] = {
        {room = "safari", key = "key_eastattic", door = "0"},
        {room = "artist", key = "key_artist", door = "0"},
        {room = "balcony", key = "key_balcony", door = "0"}
    }, 
    ["artist"] = {
        {room = "east_attic", key = "key_artist", door = "0"}
    }, 
    ["balcony"] = {
        {room = "east_attic", key = "key_balcony", door = "0"},
        {room = "west_attic", key = "key_diamond", door = "0"}
    }, 
    ["west_attic"] = {
        {room = "balcony", key = "key_diamond", door = "0"},
        {room = "armory", key = "key_armory", door = "0"},
        {room = "telephone", key = "key_telephone", door = "0"}
    }, 
    ["armory"] = {
        {room = "west_attic", key = "key_armory", door = "0"},
        {room = "ceramics", key = "key_ceramics", door = "0"}
    }, 
    ["ceramics"] = {
        {room = "armory", key = "key_ceramics", door = "0"}
    }, 
    ["telephone"] = {
        {room = "west_attic", key = "key_telephone", door = "0"},
        {room = "clockwork", key = "key_clockwork", door = "0"}
    }, 
    ["clockwork"] = {
        {room = "telephone", key = "key_clockwork", door = "0"}
    }, 
    ["basement_stairwell"] = {
        {room = "basement_stairwell", key = "key_basementstair", door = "0"},
        {room = "breaker", key = "key_breaker", door = "0"},
        {room = "cellar", key = "key_cellar", door = "0"}
    }, 
    ["breaker"] = {
        {room = "basement_stairwell", key = "key_breaker", door = "0"}
    }, 
    ["cellar"] = {
        {room = "basement_stairwell", key = "key_cellar", door = "0"},
        {room = "basement_hallway", key = "key_basehall", door = "0"}
    }, 
    ["basement_hallway"] = {
        {room = "cellar", key = "key_basehall", door = "0"},
        {room = "cold", key = "key_cold", door = "0"},
        {room = "pipe", key = "key_pipe", door = "0"},
        {room = "spade_hallway", key = "key_spadehall", door = "0"}
    }, 
    ["cold"] = {
        {room = "basement_hallway", key = "key_cold", door = "0"}
    }, 
    ["pipe"] = {
        {room = "basement_hallway", key = "key_pipe", door = "0"}
    },
    ["spade_hallway"] = {
        {room = "basement_hallway", key = "key_spadehall", door = "0"},
        {room = "secret_altar", key = "key_spade", door = "0"}
    }, 
    ["secret_altar"] = {
        {room = "spade_hallway", key = "key_spade", door = "0"}
    },
}