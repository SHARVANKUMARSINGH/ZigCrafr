//! Transpiled from Horizon Rust crate
//! Module: horizon-items_lib
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Blocks and items as the client knows them, below gameplay: block facts
//! (`blocks`), item stacks and definitions (`items`), their data components
//! (`item_data`), enchantments, cooldowns, bundles and item stacks in NBT.
//! horizon-client re-exports each module under its old path
//! (`horizon_client::items`, ...).
    // rust: pub mod banner_layer;
    // rust: pub mod blocks;
    // rust: pub mod bundle;
    // rust: pub mod content_namespaces;
    // rust: pub mod cooldowns;
    // rust: pub mod enchant;
    // rust: pub mod firework;
    // rust: pub mod flowers;
    // rust: pub mod item_data;
    // rust: pub mod item_nbt;
    // rust: pub mod items;
    // rust: pub mod random_sequences;
    // rust: pub mod recipe_filters;
    // rust: pub mod use_animation;
    // rust: pub use horizon_client_core::Result;
