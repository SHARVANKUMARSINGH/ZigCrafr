//! Transpiled from Horizon Rust crate
//! Module: horizon-port-pack_ctov
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Choice Theorem's Overhauled Village: the entries it adds to other
//! structure sets in Java code (its `modular_compat` processor is
//! `crate::lithostitched`'s now).

/// ChoiceTheorem's Overhauled Village's villages and outposts, which it adds
/// to vanilla's `villages` and `pillager_outposts` sets in Java code
/// (`CTOV.registerstructure`, through lithostitched), with its default
/// config: every village type in three sizes, weighted 10, 4 and 1, and
/// every outpost weighted 1. Vanilla's own entries stay (weight 1 each).
    // rust: const CTOV_VILLAGES: [&str; 21] = [
    // rust: "beach",
    // rust: "christmas",
    // rust: "desert",
    // rust: "desert_oasis",
    // rust: "dark_forest",
    // rust: "jungle",
    // rust: "jungle_tree",
    // rust: "mesa",
    // rust: "mesa_fortified",
    // rust: "mountain",
    // rust: "mountain_alpine",
    // rust: "mushroom",
    // rust: "plains",
    // rust: "plains_fortified",
    // rust: "savanna",
    // rust: "savanna_na",
    // rust: "snowy_igloo",
    // rust: "swamp",
    // rust: "swamp_fortified",
    // rust: "taiga",
    // rust: "taiga_fortified",
    // rust: ];
    // rust: const CTOV_OUTPOSTS: [&str; 11] = [
    // rust: "beach",
    // rust: "dark_forest",
    // rust: "desert",
    // rust: "jungle",
    // rust: "badlands",
    // rust: "mountain",
    // rust: "plains",
    // rust: "savanna",
    // rust: "snowy",
    // rust: "swamp",
    // rust: "taiga",
    // rust: ];

/// The entries a mod adds to other structure sets in Java code, as its
/// default config has them: (file name, set, `[(structure, weight)]`).
/// Lithostitched appends them in the order of a hash map of every modifier
/// in the pack, which carry cannot know; they are written in the order the
/// mod registers them. Each set picks by weight, so how often each starts
/// is the same.
    // rust: pub(crate) fn code_set_entries(
    // rust: mod_id: &str,
    // rust: ) -> Vec<(&'static str, &'static str, Vec<(String, u32)>)> {
    // rust: match mod_id {
    // rust: "ctov" => {
    // rust: let outposts = CTOV_OUTPOSTS
    // rust: .iter()
    // rust: .map(|v| (format!("ctov:pillager_outpost_{v}"), 1))
    // rust: .collect();
    // rust: let villages = [("small", 10), ("medium", 4), ("large", 1)]
    // rust: .into_iter()
    // rust: .flat_map(|(size, weight)| {
    // rust: CTOV_VILLAGES
    // rust: .iter()
    // rust: .map(move |v| (format!("ctov:{size}/village_{v}"), weight))
    // rust: })
    // rust: .collect();
    // rust: vec![
    // rust: ("pillager_outposts", "minecraft:pillager_outposts", outposts),
    // rust: ("villages", "minecraft:villages", villages),
    // rust: ]
}
    // rust: _ => Vec::new(),
}
}

    // rust: mod tests {
//     use super::*;

pub fn ctov_joins_vanillas_villages_and_outposts() void {
}
    // rust: let sets = code_set_entries("ctov");
    // rust: let (file, set, outposts) = &sets[0];
    // rust: assert_eq!(
    // rust: (*file, *set),
    // rust: ("pillager_outposts", "minecraft:pillager_outposts")
    // rust: );
    // rust: assert_eq!(outposts.len(), 11);
    // rust: assert!(outposts.iter().all(|(_, w)| *w == 1));
    // rust: let (_, set, villages) = &sets[1];
    // rust: assert_eq!(*set, "minecraft:villages");
    // rust: assert_eq!(villages.len(), 63);
    // rust: assert_eq!(villages[0], ("ctov:small/village_beach".into(), 10));
    // rust: assert_eq!(villages[21], ("ctov:medium/village_beach".into(), 4));
    // rust: assert_eq!(
    // rust: villages[62],
    // rust: ("ctov:large/village_taiga_fortified".into(), 1)
    // rust: );
    // rust: assert!(code_set_entries("mvs").is_empty());
}
}
