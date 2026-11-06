//! Transpiled from Horizon Rust crate
//! Module: horizon-shaders_biomes
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The biome parameters and constants of custom uniform expressions (spec 3.4): `BIOME_<NAME>`,
//! `CAT_<NAME>` and `PPT_<NAME>`.
//!
//! Decisions (impl-plan.md, OQ-11):
//! - `biome` is not the biome's registry id (the registry lists biomes sorted by identifier):
//!   Iris 1.11.7 numbers vanilla's biomes in the order vanilla's `Biomes` class declares them
//!   ([`VANILLA_ORDER`]; forest 8, ocean 46, soul_sand_valley 60, the_end 62, read back with a
//!   probe pack). Other biomes follow, in registry order (not measured). `BIOME_<NAME>` is the
//!   number of `minecraft:<name>`. Names from before the 1.18 renames map to the biome that
//!   replaced them. A `BIOME_` name that matches no biome reads -1, so it never equals the
//!   player's biome.
//! - `biome_category` comes from the biome's name (categories left the game in 1.19).

// use std::collections::HashMap;

/// `CAT_*`, in the order of their values.
    // rust: pub const CATEGORIES: [&str; 17] = [
    // rust: "NONE",
    // rust: "TAIGA",
    // rust: "EXTREME_HILLS",
    // rust: "JUNGLE",
    // rust: "MESA",
    // rust: "PLAINS",
    // rust: "SAVANNA",
    // rust: "ICY",
    // rust: "THE_END",
    // rust: "BEACH",
    // rust: "FOREST",
    // rust: "OCEAN",
    // rust: "DESERT",
    // rust: "RIVER",
    // rust: "SWAMP",
    // rust: "MUSHROOM",
    // rust: "NETHER",
    // rust: ];

/// Old biome names and the biomes that replaced them.
    // rust: const LEGACY: &[(&str, &str)] = &[
    // rust: ("EXTREME_HILLS", "windswept_hills"),
    // rust: ("MOUNTAINS", "windswept_hills"),
    // rust: ("GRAVELLY_MOUNTAINS", "windswept_gravelly_hills"),
    // rust: ("WOODED_MOUNTAINS", "windswept_forest"),
    // rust: ("SHATTERED_SAVANNA", "windswept_savanna"),
    // rust: ("GIANT_TREE_TAIGA", "old_growth_pine_taiga"),
    // rust: ("GIANT_SPRUCE_TAIGA", "old_growth_spruce_taiga"),
    // rust: ("TALL_BIRCH_FOREST", "old_growth_birch_forest"),
    // rust: ("SNOWY_TUNDRA", "snowy_plains"),
    // rust: ("JUNGLE_EDGE", "sparse_jungle"),
    // rust: ("WOODED_BADLANDS_PLATEAU", "wooded_badlands"),
    // rust: ("STONE_SHORE", "stony_shore"),
    // rust: ("NETHER", "nether_wastes"),
    // rust: ];

/// Vanilla 26.3's biomes in the order `net.minecraft.world.level.biome.Biomes` declares them:
/// a pack's number for each.
    // rust: pub const VANILLA_ORDER: [&str; 67] = [
    // rust: "the_void",
    // rust: "plains",
    // rust: "sunflower_plains",
    // rust: "snowy_plains",
    // rust: "ice_spikes",
    // rust: "desert",
    // rust: "swamp",
    // rust: "mangrove_swamp",
    // rust: "forest",
    // rust: "flower_forest",
    // rust: "birch_forest",
    // rust: "dappled_forest",
    // rust: "dark_forest",
    // rust: "pale_garden",
    // rust: "old_growth_birch_forest",
    // rust: "old_growth_pine_taiga",
    // rust: "old_growth_spruce_taiga",
    // rust: "taiga",
    // rust: "snowy_taiga",
    // rust: "savanna",
    // rust: "savanna_plateau",
    // rust: "windswept_hills",
    // rust: "windswept_gravelly_hills",
    // rust: "windswept_forest",
    // rust: "windswept_savanna",
    // rust: "jungle",
    // rust: "sparse_jungle",
    // rust: "bamboo_jungle",
    // rust: "badlands",
    // rust: "eroded_badlands",
    // rust: "wooded_badlands",
    // rust: "meadow",
    // rust: "cherry_grove",
    // rust: "grove",
    // rust: "snowy_slopes",
    // rust: "frozen_peaks",
    // rust: "jagged_peaks",
    // rust: "stony_peaks",
    // rust: "river",
    // rust: "frozen_river",
    // rust: "beach",
    // rust: "snowy_beach",
    // rust: "stony_shore",
    // rust: "warm_ocean",
    // rust: "lukewarm_ocean",
    // rust: "deep_lukewarm_ocean",
    // rust: "ocean",
    // rust: "deep_ocean",
    // rust: "cold_ocean",
    // rust: "deep_cold_ocean",
    // rust: "frozen_ocean",
    // rust: "deep_frozen_ocean",
    // rust: "mushroom_fields",
    // rust: "dripstone_caves",
    // rust: "lush_caves",
    // rust: "deep_dark",
    // rust: "sulfur_caves",
    // rust: "nether_wastes",
    // rust: "warped_forest",
    // rust: "crimson_forest",
    // rust: "soul_sand_valley",
    // rust: "basalt_deltas",
    // rust: "the_end",
    // rust: "end_highlands",
    // rust: "end_midlands",
    // rust: "small_end_islands",
    // rust: "end_barrens",
    // rust: ];

/// The number a pack reads for the biome `name` (`biome` and `BIOME_*`), given the registry's
/// identifiers in id order: its place in [`VANILLA_ORDER`], or for a biome vanilla doesn't
/// have, the count of vanilla's plus its place among the others in the registry.
    // rust: pub fn pack_id<'a>(name: &str, biomes: impl IntoIterator<Item = &'a str>) -> i32 {
    // rust: let vanilla = |b: &str| {
    // rust: b.strip_prefix("minecraft:")
    // rust: .and_then(|n| VANILLA_ORDER.iter().position(|v| *v == n))
}
    // rust: if let Some(i) = vanilla(name) {
    // rust: return i as i32;
}
    // rust: biomes
    // rust: .into_iter()
    // rust: .filter(|b| vanilla(b).is_none())
    // rust: .position(|b| b == name)
    // rust: .map_or(-1, |i| (VANILLA_ORDER.len() + i) as i32)
}

/// The constants every pack sees: `CAT_*` and `PPT_*`, plus `BIOME_*` for `biomes` (the
/// registry's identifiers, in id order), numbered by [`pack_id`].
pub fn constants(biomes: *[[]const u8]) H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out: HashMap<String, f64> = CATEGORIES
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, c)| (format!("CAT_{c}"), i as f64))
    // rust: .collect();
    // rust: for (i, p) in ["NONE", "RAIN", "SNOW"].iter().enumerate() {
    // rust: out.insert(format!("PPT_{p}"), i as f64);
}
    // rust: let index = |name: &str| {
    // rust: biomes
    // rust: .iter()
    // rust: .find(|b| b.strip_prefix("minecraft:") == Some(name))
    // rust: .map(|b| pack_id(b, biomes.iter().copied()))
}
    // rust: for b in biomes {
    // rust: if let Some(name) = b.strip_prefix("minecraft:") {
    // rust: let id = pack_id(b, biomes.iter().copied());
    // rust: out.insert(
    // rust: format!("BIOME_{}", name.to_ascii_uppercase()),
    // rust: f64::from(id),
    // rust: );
}
}
    // rust: for (old, new) in LEGACY {
    // rust: if let Some(i) = index(new) {
    // rust: out.entry(format!("BIOME_{old}")).or_insert(f64::from(i));
}
}
    // rust: out
}

/// `biome_category` of the biome `minecraft:<name>`.
pub fn category(name: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = name.strip_prefix("minecraft:").unwrap_or(name);
    // rust: let has = |words: &[&str]| words.iter().any(|w| name.contains(w));
    // rust: let cat = if name == "the_void" {
    // rust: "NONE"
    // rust: } else if name == "the_end" || name.starts_with("end_") || name == "small_end_islands" {
    // rust: "THE_END"
    // rust: } else if has(&["nether", "crimson", "warped", "basalt", "soul_sand"]) {
    // rust: "NETHER"
    // rust: } else if has(&["ocean"]) {
    // rust: "OCEAN"
    // rust: } else if has(&["river"]) {
    // rust: "RIVER"
    // rust: } else if has(&["beach", "shore"]) {
    // rust: "BEACH"
    // rust: } else if has(&["swamp"]) {
    // rust: "SWAMP"
    // rust: } else if has(&["mushroom"]) {
    // rust: "MUSHROOM"
    // rust: } else if has(&["desert"]) {
    // rust: "DESERT"
    // rust: } else if has(&["badlands"]) {
    // rust: "MESA"
    // rust: } else if has(&["savanna"]) {
    // rust: "SAVANNA"
    // rust: } else if has(&["jungle"]) {
    // rust: "JUNGLE"
    // rust: } else if has(&["taiga"]) {
    // rust: "TAIGA"
    // rust: } else if has(&["windswept", "peaks", "slopes", "meadow", "grove"]) && name != "cherry_grove" {
    // rust: "EXTREME_HILLS"
    // rust: } else if has(&["frozen", "snowy", "ice"]) {
    // rust: "ICY"
    // rust: } else if has(&["forest", "garden", "cherry"]) {
    // rust: "FOREST"
    // rust: } else if has(&["plains"]) {
    // rust: "PLAINS"
    // rust: } else {
    // rust: "NONE"
}
    // rust: CATEGORIES.iter().position(|c| *c == cat).unwrap_or(0) as i32
}

/// `biome_precipitation`: none where the biome has none, else rain from temperature 0.15 up,
/// snow below it (spec 3.4).
pub fn precipitation(has_precipitation: bool, temperature: f32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match (has_precipitation, temperature >= 0.15) {
    // rust: (false, _) => 0,
    // rust: (true, true) => 1,
    // rust: (true, false) => 2,
}
}

    // rust: mod tests {
//     use super::*;

pub fn constants_categories_and_precipitation() void {
}
    // rust: let c = constants(&[
    // rust: "minecraft:badlands",
    // rust: "minecraft:pale_garden",
    // rust: "minecraft:windswept_hills",
    // rust: ]);
    // rust: assert_eq!(c["BIOME_PALE_GARDEN"], 13.0);
    // rust: assert_eq!(c["BIOME_EXTREME_HILLS"], 21.0);
    // rust: assert_eq!(c["CAT_NETHER"], 16.0);
    // rust: assert_eq!(c["PPT_SNOW"], 2.0);
    // rust: assert!(!c.contains_key("BIOME_SULFUR_CAVES"));
    // rust: assert_eq!(category("minecraft:pale_garden"), 10);
    // rust: assert_eq!(category("minecraft:deep_frozen_ocean"), 11);
    // rust: assert_eq!(category("minecraft:snowy_taiga"), 1);
    // rust: assert_eq!(category("minecraft:crimson_forest"), 16);
    // rust: assert_eq!(category("minecraft:cherry_grove"), 10);
    // rust: assert_eq!(precipitation(true, 0.0), 2);
    // rust: assert_eq!(precipitation(true, 0.8), 1);
    // rust: assert_eq!(precipitation(false, 2.0), 0);
}

    /// Iris 1.11.7's `BIOME_*` constants, read back with a probe pack: each of the 67 is the
    /// biome's place in vanilla's `Biomes` (here with the registry in identifier order).
pub fn biome_constants_follow_iris() void {
}
    // rust: let c = constants(&[
    // rust: "minecraft:badlands",
    // rust: "minecraft:forest",
    // rust: "minecraft:ocean",
    // rust: "minecraft:soul_sand_valley",
    // rust: "minecraft:the_end",
    // rust: "minecraft:the_void",
    // rust: ]);
    // rust: assert_eq!(c["BIOME_FOREST"], 8.0);
    // rust: assert_eq!(c["BIOME_OCEAN"], 46.0);
    // rust: assert_eq!(c["BIOME_SOUL_SAND_VALLEY"], 60.0);
    // rust: assert_eq!(c["BIOME_THE_END"], 62.0);
    // rust: assert_eq!(c["BIOME_BADLANDS"], 28.0);
    // rust: assert_eq!(c["BIOME_THE_VOID"], 0.0);
}

    /// Iris 1.11.7's `biome`, read back with a probe pack where the scene world is forest,
    /// ocean, soul sand valley and the End: 8, 46, 60 and 62. A biome vanilla doesn't have
    /// comes after vanilla's (Horizon's choice; not measured in Iris).
pub fn biomes_are_numbered_as_iris_numbers_them() void {
}
    // rust: let registry = [
    // rust: "minecraft:forest",
    // rust: "minecraft:ocean",
    // rust: "mod:glade",
    // rust: "minecraft:soul_sand_valley",
    // rust: "minecraft:the_end",
    // rust: "mod:marsh",
    // rust: ];
    // rust: let ids: Vec<i32> = registry.iter().map(|b| pack_id(b, registry)).collect();
    // rust: assert_eq!(ids, [8, 46, 67, 60, 62, 68]);
    // rust: assert_eq!(pack_id("minecraft:unknown", registry), -1);
    // rust: assert_eq!(constants(&registry)["BIOME_SOUL_SAND_VALLEY"], 60.0);
}
}
