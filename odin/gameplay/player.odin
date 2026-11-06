package gameplay

ItemStack :: struct {
    item_id: u16,
    count: u8,
    durability: u16,
}

HOTBAR_SLOTS :: 9
TOTAL_INVENTORY_SLOTS :: 36

PlayerSession :: struct {
    health: f32,
    food_level: i32,
    saturation: f32,
    selected_slot: int,
    inventory: [TOTAL_INVENTORY_SLOTS]ItemStack,
    world_time: u64, // 0 to 24000 per day
    is_sneaking: bool,
    is_sprinting: bool,
}

init_player_session :: proc() -> PlayerSession {
    session := PlayerSession{
        health = 20.0,
        food_level = 20,
        saturation = 5.0,
        selected_slot = 0,
        world_time = 6000, // Noon
        is_sneaking = false,
        is_sprinting = false,
    }

    // Default starter tools in hotbar
    session.inventory[0] = ItemStack{ item_id = 1, count = 64, durability = 0 } // Stone
    session.inventory[1] = ItemStack{ item_id = 5, count = 64, durability = 0 } // Planks
    session.inventory[2] = ItemStack{ item_id = 4, count = 64, durability = 0 } // Cobble
    session.inventory[3] = ItemStack{ item_id = 17, count = 32, durability = 0 } // Logs
    session.inventory[4] = ItemStack{ item_id = 20, count = 16, durability = 0 } // Glass

    return session
}

tick_day_night :: proc(session: ^PlayerSession) {
    session.world_time = (session.world_time + 1) % 24000
}

get_sun_angle :: proc(session: ^PlayerSession) -> f32 {
    return f32(session.world_time) / 24000.0 * 360.0
}
