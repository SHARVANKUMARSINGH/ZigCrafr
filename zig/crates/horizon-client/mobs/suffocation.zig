//! Transpiled from Horizon Rust crate
//! Module: horizon-client_suffocation
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Runtime binding of Blocks' suffocation definitions to the native registry.
// use horizon_world::{
    // rust: block_collision::BlockCollisionRegistry,
    // rust: suffocation::{SuffocationDefinition, SuffocationRegistry},
}
// use std::{
    // rust: collections::{BTreeMap, BTreeSet},
    // rust: io,
    // rust: sync::Arc,
}

/// The predicates installed by Blocks' registrations. Predicate evaluation,
/// including full-shape tests and block entities, stays in SuffocationRegistry.
    // rust: pub fn bind<'r>(
    // rust: collision: Arc<BlockCollisionRegistry<'r>>,
    // rust: causes_suffocation: &BTreeSet<String>,
    // rust: ) -> io::Result<SuffocationRegistry<'r>> {
//     use SuffocationDefinition::*;
    // rust: let registry = collision.registry();
    // rust: let mut definitions = BTreeMap::new();
    // rust: for i in 0..registry.len() {
    // rust: let state = registry
    // rust: .state(horizon_world::registry::BlockStateId(i as u32))
    // rust: .unwrap();
    // rust: if definitions.contains_key(&state.name) {
    // rust: continue;
}
    // rust: let definition = match state.name.strip_prefix("minecraft:") {
    // rust: Some("dirt_path" | "farmland" | "mud" | "soul_sand") => Always,
    // rust: Some("piston" | "sticky_piston") => NotExtendedPiston,
    // rust: Some("mangrove_roots" | "moving_piston") => Never,
    // rust: Some(name)
    // rust: if name.ends_with("_leaves")
    // rust: || name == "glass"
    // rust: || name == "tinted_glass"
    // rust: || name.ends_with("_stained_glass")
    // rust: || name == "copper_grate"
    // rust: || name.ends_with("_copper_grate") =>
    // rust: {
    // rust: Never
}
    // rust: Some(name) if name == "shulker_box" || name.ends_with("_shulker_box") => ClosedShulker,
    // rust: _ => TaggedFullCollision,
}
    // rust: definitions.insert(state.name.clone(), definition);
}
    // rust: SuffocationRegistry::new(collision, &definitions, causes_suffocation)
}
