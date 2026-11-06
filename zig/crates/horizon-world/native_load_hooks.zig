//! Transpiled from Horizon Rust crate
//! Module: horizon-world_native_load_hooks
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Callbacks into the executable for data-loading native trait mods.
// use crate::loot::{LootStack, NativeLootContext};
// use serde_json::{Map, Value};
// use std::sync::OnceLock;

/// Data-loading hooks, installed before any data loads. Earlier loads see no mods.
pub const NativeLoadHooks = struct {
    loot_table_load: fn([]const u8,
    modify_default_components: fn([]const u8,
    loot_function: fn([]const u8,
    loot_condition: fn([]const u8,
};

pub const HOOKS: OnceLock<NativeLoadHooks> = OnceLock::new();

/// Install the process-wide callbacks once; a second installation keeps the first.
pub fn install(hooks: NativeLoadHooks) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: HOOKS.set(hooks)
}

    // rust: pub(crate) fn loot_table_load(id: &str, table: &mut Value) {
    // rust: if let Some(hooks) = HOOKS.get() {
    // rust: (hooks.loot_table_load)(id, table);
}
}

    // rust: pub(crate) fn modify_default_components(item: &str, components: &mut Map<String, Value>) {
    // rust: if let Some(hooks) = HOOKS.get() {
    // rust: (hooks.modify_default_components)(item, components);
}
}

    // rust: pub(crate) fn loot_function(
    // rust: kind: &str,
    // rust: data: &Value,
    // rust: ctx: &NativeLootContext<'_>,
    // rust: stack: &mut LootStack,
    // rust: ) {
    // rust: if let Some(hooks) = HOOKS.get() {
    // rust: (hooks.loot_function)(kind, data, ctx, stack);
}
}

    // rust: pub(crate) fn loot_condition(
    // rust: kind: &str,
    // rust: data: &Value,
    // rust: ctx: &NativeLootContext<'_>,
    // rust: holds: &mut bool,
    // rust: ) {
    // rust: if let Some(hooks) = HOOKS.get() {
    // rust: (hooks.loot_condition)(kind, data, ctx, holds);
}
}
