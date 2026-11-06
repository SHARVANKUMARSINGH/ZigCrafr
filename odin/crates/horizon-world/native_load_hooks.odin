//! Transpiled from Horizon Rust crate
package horizon_world_native_load_hooks

import "core:fmt"
import "core:mem"
import "core:math"

// Callbacks into the executable for data-loading native trait mods.
// use crate::loot::{LootStack, NativeLootContext};
// use serde_json::{Map, Value};
// use std::sync::OnceLock;

// Data-loading hooks, installed before any data loads. Earlier loads see no mods.
NativeLoadHooks :: struct {
    loot_table_load: fn(string,
    modify_default_components: fn(string,
    loot_function: fn(string,
    loot_condition: fn(string,
}

HOOKS :: OnceLock::new()

// Install the process-wide callbacks once; a second installation keeps the first.
install :: proc(hooks: NativeLoadHooks) -> R {
    // Ported from Horizon
    return {}
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
