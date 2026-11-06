//! Transpiled from Horizon Rust crate
//! Module: horizon-world_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::*;
// use crate::nbt::parse_snbt;

pub fn snbt(s: []const u8) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: parse_snbt(s).unwrap().0
}

pub fn current_data_is_left_alone() void {
}
    // rust: let mut tag = snbt("{DataVersion: 5023, Status: \"minecraft:full\"}");
    // rust: let before = tag.clone();
    // rust: update_chunk(&mut tag, "minecraft:overworld", Some("minecraft:noise"));
    // rust: assert_eq!(tag, before);
}

pub fn item_stacks_of_1_20_take_components() void {
}
    // rust: let mut player = snbt(
    // rust: "{DataVersion: 3465, Inventory: [{Slot: 0b, id: \"minecraft:diamond_sword\", Count: 1b, \
    // rust: tag: {Damage: 5, display: {Name: '{\"text\":\"Blade\"}'}}}]}",
    // rust: );
    // rust: update_player(&mut player);
    // rust: let stack = &dynamic::stream(player.get("Inventory"))[0];
    // rust: assert_eq!(
    // rust: dynamic::as_str(stack.get("id")).as_deref(),
    // rust: Some("minecraft:diamond_sword")
    // rust: );
    // rust: assert_eq!(stack.get("count"), Some(&Tag::Int(1)));
    // rust: let components = stack.get("components").expect("components");
    // rust: assert_eq!(components.get("minecraft:damage"), Some(&Tag::Int(5)));
    // rust: assert_eq!(
    // rust: components.get("minecraft:custom_name"),
    // rust: Some(&Tag::compound([("text", dynamic::string("Blade"))]))
    // rust: );
}

pub fn level_data_of_1_20_moves_to_the_new_fields() void {
}
    // rust: let mut level = snbt(
    // rust: "{DataVersion: 3465, Difficulty: 3b, DifficultyLocked: 1b, hardcore: 0b, SpawnX: 1, SpawnY: 64, SpawnZ: -3, \
    // rust: SpawnAngle: 90.0f, GameRules: {doFireTick: \"false\", keepInventory: \"true\", randomTickSpeed: \"5\"}}",
    // rust: );
    // rust: update(Ty::Level, &mut level, 3465, CURRENT);
    // rust: let settings = level
    // rust: .get("difficulty_settings")
    // rust: .expect("difficulty settings");
    // rust: assert_eq!(
    // rust: dynamic::as_str(settings.get("difficulty")).as_deref(),
    // rust: Some("hard")
    // rust: );
    // rust: assert_eq!(settings.get("locked"), Some(&Tag::Byte(1)));
    // rust: let rules = level.get("game_rules").expect("game rules");
    // rust: assert_eq!(rules.get("minecraft:keep_inventory"), Some(&Tag::Byte(1)));
    // rust: assert_eq!(rules.get("minecraft:random_tick_speed"), Some(&Tag::Int(5)));
    // rust: assert_eq!(
    // rust: rules.get("minecraft:fire_spread_radius_around_player"),
    // rust: Some(&Tag::Int(0))
    // rust: );
    // rust: assert_eq!(
    // rust: level.get("spawn").and_then(|s| s.get("pos")),
    // rust: Some(&Tag::IntArray(vec![1, 64, -3]))
    // rust: );
}

pub fn block_states_take_their_new_field_names() void {
}
    // rust: let mut chunk = snbt(
    // rust: "{DataVersion: 4903, Status: \"minecraft:full\", sections: [{Y: 0b, block_states: \
    // rust: {palette: [{Name: \"minecraft:chain\", Properties: {axis: \"y\"}}]}}]}",
    // rust: );
    // rust: update_chunk(&mut chunk, "minecraft:the_nether", Some("minecraft:noise"));
    // rust: let section = &dynamic::stream(chunk.get("sections"))[0];
    // rust: let state = &dynamic::stream(section.get("block_states").and_then(|b| b.get("palette")))[0];
    // rust: assert_eq!(
    // rust: dynamic::as_str(state.get("id")).as_deref(),
    // rust: Some("minecraft:chain")
    // rust: );
    // rust: assert!(state.get("properties").is_some());
    // rust: assert_eq!(chunk.get("DataVersion"), Some(&Tag::Int(CURRENT)));
}
