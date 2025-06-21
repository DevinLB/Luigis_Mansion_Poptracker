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


full_mansion = {
    ["foyer"] = {
        {room = "parlor", door_name = "parlor", key = "key_parlor", door = "0"},
        {room = "family_hallway", door_name = "family_hallway", key = "key_famhall", door = "0"},
        {room = "hallway_1f", door_name = "hallway_1f", key = "key_heart", door = "0"}
    },
    ["parlor"] = {
        {room = "foyer", door_name = "parlor", key = "key_parlor", door = "0"},
        {room = "anteroom", door_name = "anteroom", key = "key_anteroom", door = "0"}
    }, 
    ["anteroom"] = {
        {room = "parlor", door_name = "anteroom", key = "key_anteroom", door = "0"},
        {room = "wardrobe", door_name = "wardrobe", key = "key_wardrobe", door = "0"}
    }, 
    ["wardrobe"] = {
        {room = "anteroom", door_name = "wardrobe", key = "key_wardrobe", door = "0"},
        {room = "wardrobe_balcony", door_name = "wardrobe_balcony", key = "key_wardrobebalcony", door = "0"}
    }, 
    ["wardrobe_balcony"] = {
        {room = "wardrobe", door_name = "wardrobe_balcony", key = "key_wardrobebalcony", door = "0"}
    }, 
    ["family_hallway"] = {
        {room = "foyer", door_name = "family_hallway", key = "key_famhall", door = "0"},
        {room = "study", door_name = "study", key = "key_study", door = "0"},
        {room = "master_bedroom", door_name = "master_bedroom", key = "key_MasterBed", door = "0"},
        {room = "nursery", door_name = "nursery", key = "key_nursery", door = "0"},
        {room = "twins", door_name = "twins", key = "key_twin", door = "0"},
    }, 
    ["study"] = {
        {room = "family_hallway", door_name = "study", key = "key_study", door = "0"}
    }, 
    ["master_bedroom"] = {
        {room = "family_hallway", door_name = "master_bedroom", key = "key_MasterBed", door = "0"}
    }, 
    ["nursery"] = {
        {room = "family_hallway", door_name = "nursery", key = "key_nursery", door = "0"}
    }, 
    ["twins"] = {
        {room = "family_hallway", door_name = "twins", key = "key_twin", door = "0"}
    }, 
    ["hallway_1f"] = {
        {room = "foyer", door_name = "hallway_1f", key = "key_heart", door = "0"},
        {room = "laundry", door_name = "laundry", key = "key_laundry", door = "0"},
        {room = "fortune", door_name = "fortune", key = "key_fortune", door = "0"},
        {room = "basement_stairwell", door_name = "basement_stairwell", key = "key_basementstair", door = "0"},
        {room = "dining", door_name = "dining", key = "key_dining", door = "0"},
        {room = "ballroom", door_name = "ballroom", key = "key_ballroom", door = "0"},
        {room = "stairwell_2f", door_name = "stairwell_2f_w", key = "key_lower2f", door = "0"},
        {room = "conservatory", door_name = "conservatory", key = "key_conservatory", door = "0"},
        {room = "billiards", door_name = "billiards", key = "key_billiards", door = "0"},
        {room = "washroom_1f", door_name = "washroom_1f", key = "key_1fwash", door = "0"},
        {room = "bathroom_1f", door_name = "bathroom_1f", key = "key_1fbath", door = "0"},
        {room = "courtyard", door_name = "courtyard_w", key = "key_club", door = "0"},
    }, 
    ["laundry"] = {
        {room = "hallway_1f", door_name = "laundry", key = "key_laundry", door = "0"},
        {room = "butler", door_name = "butler", key = "key_butler", door = "0"}
    }, 
    ["butler"] = {
        {room = "laundry", door_name = "butler", key = "key_butler", door = "0"}
    },
    ["courtyard"] = {
        {room = "hallway_1f", door_name = "courtyard_w", key = "key_club", door = "0"},
        {room = "rec_room", door_name = "rec_room_n", key = "key_northrec", door = "0"}
    }, 
    ["bathroom_1f"] = {
        {room = "hallway_1f", door_name = "bathroom_1f", key = "key_1fbath", door = "0"}
    }, 
    ["washroom_1f"] = {
        {room = "hallway_1f", door_name = "washroom_1f", key = "key_1fwash", door = "0"}
    }, 
    ["conservatory"] = {
        {room = "hallway_1f", door_name = "conservatory", key = "key_conservatory", door = "0"}
    }, 
    ["billiards"] = {
        {room = "hallway_1f", door_name = "billiards", key = "key_billiards", door = "0"},
        {room = "projection", door_name = "projection", key = "key_projection", door = "0"}
    }, 
    ["projection"] = {
        {room = "billiards", door_name = "projection", key = "key_projection", door = "0"}
    }, 
    ["ballroom"] = {
        {room = "hallway_1f", door_name = "ballroom", key = "key_ballrom", door = "0"},
        {room = "storage", door_name = "storage", key = "key_storage", door = "0"}
    }, 
    ["storage"] = {
        {room = "ballroom", door_name = "storage", key = "key_storage", door = "0"}
    }, 
    ["fortune"] = {
        {room = "hallway_1f", door_name = "fortune", key = "key_fortune", door = "0"},
        {room = "mirror", door_name = "mirror", key = "key_mirror", door = "0"}
    }, 
    ["mirror"] = {
        {room = "fortune", door_name = "fortune", key = "key_mirror", door = "0"}
    }, 
    ["dining"] = {
        {room = "hallway_1f", door_name = "dining", key = "key_dining", door = "0"},
        {room = "kitchen", door_name = "kitchen", key = "key_kitchen", door = "0"}
    }, 
    ["kitchen"] = {
        {room = "dining", door_name = "kitchen", key = "key_kitchen", door = "0"},
        {room = "boneyard", door_name = "boneyard", key = "key_boneyard", door = "0"}
    }, 
    ["boneyard"] = {
        {room = "kitchen", door_name = "kitchen", key = "key_boneyard", door = "0"}
    }, 
    ["rec_room"] = {
        {room = "courtyard", door_name = "rec_room_n", key = "key_northrec", door = "0"},
        {room = "stairwell_2f", door_name = "rec_room_s", key = "key_southrec", door = "0"}
    }, 
    ["stairwell_2f"] = {
        {room = "hallway_1f", door_name = "stairwell_2f_w", key = "key_lower2f", door = "0"},
        {room = "rec_room", door_name = "stairwell_2f_n", key = "key_southrec", door = "0"},
        {room = "tea", door_name = "tea", key = "key_tea", door = "0"},
        {room = "rear_hallway_2f", door_name = "rear_hallway_2f", key = "key_upper2f", door = "0"}
    },
    ["tea"] = {
        {room = "stairwell_2f", door_name = "tea", key = "key_tea", door = "0"}
    }, 
    ["rear_hallway_2f"] = {
        {room = "stairwell_2f", door_name = "rear_hallway_2f", key = "key_upper2f", door = "0"},
        {room = "nana", door_name = "nana", key = "key_nana", door = "0"},
        {room = "washroom_2f", door_name = "washroom_2f", key = "key_2fwash", door = "0"},
        {room = "bathroom_2f", door_name = "bathroom_2f", key = "key_2fbath", door = "0"},
        {room = "astral", door_name = "astral", key = "key_astral", door = "0"},
        {room = "sitting", door_name = "sitting", key = "key_sitting", door = "0"},
        {room = "safari", door_name = "safari", key = "key_safari", door = "0"}
    }, 
    ["bathroom_2f"] = {
        {room = "rear_hallway_2f", door_name = "bathroom_2f", key = "key_bath2f", door = "0"}
    }, 
    ["washroom_2f"] = {
        {room = "rear_hallway_2f", door_name = "washroom_2f", key = "key_wash2f", door = "0"}
    }, 
    ["nana"] = {
        {room = "rear_hallway_2f", door_name = "nana", key = "key_nana", door = "0"}
    }, 
    ["astral"] = {
        {room = "rear_hallway_2f", door_name = "astral", key = "key_astral", door = "0"},
        {room = "observatory", door_name = "observatory", key = "key_observatory", door = "0"}
    }, 
    ["observatory"] = {
        {room = "astral", door_name = "observatory", key = "key_observatory", door = "0"}
    }, 
    ["sitting"] = {
        {room = "rear_hallway_2f", door_name = "sitting", key = "key_sitting", door = "0"},
        {room = "guest", door_name = "guest", key = "key_guest", door = "0"}
    }, 
    ["guest"] = {
        {room = "sitting", door_name = "guest", key = "key_guest", door = "0"}
    }, 
    ["safari"] = {
        {room = "rear_hallway_2f", door_name = "safari", key = "key_safari", door = "0"},
        {room = "east_attic", door_name = "east_attic", key = "key_eastattic", door = "0"}
    }, 
    ["east_attic"] = {
        {room = "safari", door_name = "east_attic", key = "key_eastattic", door = "0"},
        {room = "artist", door_name = "artist", key = "key_artist", door = "0"},
        {room = "balcony", door_name = "balcony", key = "key_balcony", door = "0"}
    }, 
    ["artist"] = {
        {room = "east_attic", door_name = "artist", key = "key_artist", door = "0"}
    }, 
    ["balcony"] = {
        {room = "east_attic", door_name = "balcony", key = "key_balcony", door = "0"},
        {room = "west_attic", door_name = "west_attic", key = "key_diamond", door = "0"}
    }, 
    ["west_attic"] = {
        {room = "balcony", door_name = "west_attic", key = "key_diamond", door = "0"},
        {room = "armory", door_name = "armory", key = "key_armory", door = "0"},
        {room = "telephone", door_name = "telephone", key = "key_telephone", door = "0"}
    }, 
    ["armory"] = {
        {room = "west_attic", door_name = "armory", key = "key_armory", door = "0"},
        {room = "ceramics", door_name = "ceramics", key = "key_ceramics", door = "0"}
    }, 
    ["ceramics"] = {
        {room = "armory", door_name = "ceramics", key = "key_ceramics", door = "0"}
    }, 
    ["telephone"] = {
        {room = "west_attic", door_name = "telephone", key = "key_telephone", door = "0"},
        {room = "clockwork", door_name = "clockwork", key = "key_clockwork", door = "0"}
    }, 
    ["clockwork"] = {
        {room = "telephone", door_name = "clockwork", key = "key_clockwork", door = "0"}
    }, 
    ["basement_stairwell"] = {
        {room = "hallway_1f", door_name = "basement_stairwell", key = "key_basementstair", door = "0"},
        {room = "breaker", door_name = "breaker", key = "key_breaker", door = "0"},
        {room = "cellar", door_name = "cellar", key = "key_cellar", door = "0"}
    }, 
    ["breaker"] = {
        {room = "basement_stairwell", door_name = "breaker", key = "key_breaker", door = "0"}
    }, 
    ["cellar"] = {
        {room = "basement_stairwell", door_name = "cellar", key = "key_cellar", door = "0"},
        {room = "basement_hallway", door_name = "basement_hallway", key = "key_basehall", door = "0"}
    }, 
    ["basement_hallway"] = {
        {room = "cellar", door_name = "basement_hallway", key = "key_basehall", door = "0"},
        {room = "cold", door_name = "cold", key = "key_cold", door = "0"},
        {room = "pipe", door_name = "pipe", key = "key_pipe", door = "0"},
        {room = "spade_hallway", door_name = "spade_hallway", key = "key_spadehall", door = "0"}
    }, 
    ["cold"] = {
        {room = "basement_hallway", door_name = "cold", key = "key_cold", door = "0"}
    }, 
    ["pipe"] = {
        {room = "basement_hallway", door_name = "pipe", key = "key_pipe", door = "0"}
    },
    ["spade_hallway"] = {
        {room = "basement_hallway", door_name = "spade_hallway", key = "key_spadehall", door = "0"},
        {room = "secret_altar", door_name = "secret_altar", key = "key_spade", door = "0"}
    }, 
    ["secret_altar"] = {
        {room = "spade_hallway", door_name = "secret_altar", key = "key_spade", door = "0"}
    },
}