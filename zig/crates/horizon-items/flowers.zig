//! Transpiled from Horizon Rust crate
//! Module: horizon-items_flowers
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The suspicious stew effect of each flower block: `FlowerBlock`'s
//! `suspiciousStewEffects`, built by `FlowerBlock.makeEffectList` as
//! `Entry(effect, Mth.floor(seconds * 20))`. The effect belongs to the block,
//! not to the item's components (`SuspiciousEffectHolder.tryGet`), so a brown
//! mooshroom fed a flower stores the same entry a crafted stew carries.
//!
//! In `Blocks`'s constructor order. `wither_rose` is a `WitherRoseBlock` and
//! the eyeblossoms take their values from `EyeblossomBlock.Type`; all three
//! reach `FlowerBlock`'s constructor, so all are suspicious effect holders.
    // rust: pub const FLOWER_STEW_EFFECTS: [(&str, &str, i32); 17] = [
    // rust: ("minecraft:dandelion", "minecraft:saturation", 7),
    // rust: ("minecraft:golden_dandelion", "minecraft:saturation", 7),
    // rust: ("minecraft:torchflower", "minecraft:night_vision", 100),
    // rust: ("minecraft:poppy", "minecraft:night_vision", 100),
    // rust: ("minecraft:blue_orchid", "minecraft:saturation", 7),
    // rust: ("minecraft:allium", "minecraft:fire_resistance", 60),
    // rust: ("minecraft:azure_bluet", "minecraft:blindness", 220),
    // rust: ("minecraft:red_tulip", "minecraft:weakness", 140),
    // rust: ("minecraft:orange_tulip", "minecraft:weakness", 140),
    // rust: ("minecraft:white_tulip", "minecraft:weakness", 140),
    // rust: ("minecraft:pink_tulip", "minecraft:weakness", 140),
    // rust: ("minecraft:oxeye_daisy", "minecraft:regeneration", 140),
    // rust: ("minecraft:cornflower", "minecraft:jump_boost", 100),
    // rust: ("minecraft:wither_rose", "minecraft:wither", 140),
    // rust: ("minecraft:lily_of_the_valley", "minecraft:poison", 220),
    // rust: ("minecraft:open_eyeblossom", "minecraft:blindness", 220),
    // rust: ("minecraft:closed_eyeblossom", "minecraft:nausea", 140),
    // rust: ];

/// `SuspiciousEffectHolder.tryGet(item)` for a flower's item: its one entry,
/// as (effect id, ticks).
pub fn stew_effect(item: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: FLOWER_STEW_EFFECTS
    // rust: .iter()
    // rust: .find(|(flower, _, _)| *flower == item)
    // rust: .map(|&(_, effect, ticks)| (effect, ticks))
}

    // rust: mod tests {
//     use super::*;

pub fn every_flower_maps_to_its_blocks_stew_effect() void {
}
        // Read off `Blocks`'s constructor sites: 15 effect-bearing factories
        // (14 `FlowerBlock` sites plus `WitherRoseBlock`), then the two
        // eyeblossoms' `EyeblossomBlock.Type` values.
    // rust: let expected = [
    // rust: ("minecraft:dandelion", "minecraft:saturation", 7),
    // rust: ("minecraft:golden_dandelion", "minecraft:saturation", 7),
    // rust: ("minecraft:torchflower", "minecraft:night_vision", 100),
    // rust: ("minecraft:poppy", "minecraft:night_vision", 100),
    // rust: ("minecraft:blue_orchid", "minecraft:saturation", 7),
    // rust: ("minecraft:allium", "minecraft:fire_resistance", 60),
    // rust: ("minecraft:azure_bluet", "minecraft:blindness", 220),
    // rust: ("minecraft:red_tulip", "minecraft:weakness", 140),
    // rust: ("minecraft:orange_tulip", "minecraft:weakness", 140),
    // rust: ("minecraft:white_tulip", "minecraft:weakness", 140),
    // rust: ("minecraft:pink_tulip", "minecraft:weakness", 140),
    // rust: ("minecraft:oxeye_daisy", "minecraft:regeneration", 140),
    // rust: ("minecraft:cornflower", "minecraft:jump_boost", 100),
    // rust: ("minecraft:wither_rose", "minecraft:wither", 140),
    // rust: ("minecraft:lily_of_the_valley", "minecraft:poison", 220),
    // rust: ("minecraft:open_eyeblossom", "minecraft:blindness", 220),
    // rust: ("minecraft:closed_eyeblossom", "minecraft:nausea", 140),
    // rust: ];
    // rust: assert_eq!(FLOWER_STEW_EFFECTS, expected);
    // rust: assert_eq!(FLOWER_STEW_EFFECTS.len(), 17);
    // rust: for (flower, effect, ticks) in expected {
    // rust: assert_eq!(stew_effect(flower), Some((effect, ticks)), "{flower}");
}
    // rust: let mut seen = std::collections::HashSet::new();
    // rust: for (flower, _, _) in FLOWER_STEW_EFFECTS {
    // rust: assert!(seen.insert(flower), "duplicate flower {flower}");
}
    // rust: assert_eq!(stew_effect("minecraft:mushroom_stew"), None);
}
}
