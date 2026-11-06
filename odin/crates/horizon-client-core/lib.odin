//! Transpiled from Horizon Rust crate
package horizon_client_core_lib

import "core:fmt"
import "core:mem"
import "core:math"

// The client's lowest layer, below commands and gameplay: chat text and
// translations, SNBT and NBT paths, text components, the scoreboard, boss
// bars, game rules, block entity NBT tables, and the registry, particle and
// sound source tables commands name, and the `pack.mcmeta` filter regex.
// horizon-client re-exports each module under its old path
// (`horizon_client::text`, ...).
    // rust: pub mod block_entity_nbt;
    // rust: pub mod bossbar;
    // rust: pub mod component;
    // rust: pub mod fastutil_order;
    // rust: pub mod gamerules;
    // rust: pub mod identifier;
    // rust: pub mod key_display;
    // rust: pub mod lang;
    // rust: pub mod nbt_path;
    // rust: pub mod nbt_value;
    // rust: pub mod particle_type;
    // rust: pub mod pattern;
    // rust: pub mod potions;
    // rust: pub mod registries;
    // rust: pub mod scoreboard;
    // rust: pub mod snbt;
    // rust: pub mod sound_source;
    // rust: pub mod text;
    // rust: pub mod uuid;
    // rust: pub mod who;
    // rust: pub type Result<T> = std::result::Result<T, Box<dyn std::error::Error>>;
