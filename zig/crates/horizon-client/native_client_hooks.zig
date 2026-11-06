//! Transpiled from Horizon Rust crate
//! Module: horizon-client_native_client_hooks
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Callbacks into the executable for native trait mods' client-library hooks.
// use crate::items::ItemStack;
// use serde_json::{Map, Value};
// use std::sync::OnceLock;

/// Client-library hooks, installed before any menu, entity or recipe is used.
pub const NativeClientHooks = struct {
    menu_slot_rules: fn([]const u8,
    living_heal: fn(u32,
    player_chat: fn(u128,
    living_breathe: fn(u32,
    living_drown: fn(u32,
    living_fall: fn(u32,
    living_jump: fn(u32,
    register_goals: fn(*mut crate::mobs::Mob),
    ingredient: fn([]const u8,
    ingredient_test: fn([]const u8,
};

pub const HOOKS: OnceLock<NativeClientHooks> = OnceLock::new();

/// Install the process-wide callbacks once; a second installation keeps the first.
pub fn install(hooks: NativeClientHooks) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: HOOKS.set(hooks)
}

    // rust: pub(crate) fn menu_slot_rules(
    // rust: menu: &str,
    // rust: slot: usize,
    // rust: stack: &ItemStack,
    // rust: may_place: &mut bool,
    // rust: max_stack: &mut u32,
    // rust: ) {
    // rust: if let Some(hooks) = HOOKS.get() {
    // rust: (hooks.menu_slot_rules)(menu, slot, stack, may_place, max_stack);
}
}

    // rust: pub(crate) fn player_chat(
    // rust: player: u128,
    // rust: name: &str,
    // rust: message: &str,
    // rust: replies: &mut Vec<horizon_client_core::text::Text>,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: if let Some(hooks) = HOOKS.get() {
    // rust: (hooks.player_chat)(player, name, message, replies, cancel);
}
}

    // rust: pub(crate) fn living_heal(entity: u32, amount: &mut f32, cancel: &mut bool) {
    // rust: if let Some(hooks) = HOOKS.get() {
    // rust: (hooks.living_heal)(entity, amount, cancel);
}
}

    // rust: pub(crate) fn living_breathe(
    // rust: entity: u32,
    // rust: kind: &str,
    // rust: can_breathe: &mut bool,
    // rust: consume: &mut i32,
    // rust: refill: &mut i32,
    // rust: ) {
    // rust: if let Some(hooks) = HOOKS.get() {
    // rust: (hooks.living_breathe)(entity, kind, can_breathe, consume, refill);
}
}

    // rust: pub(crate) fn living_drown(
    // rust: entity: u32,
    // rust: kind: &str,
    // rust: is_drowning: &mut bool,
    // rust: damage_amount: &mut f32,
    // rust: bubble_count: i32,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: if let Some(hooks) = HOOKS.get() {
    // rust: (hooks.living_drown)(
    // rust: entity,
    // rust: kind,
    // rust: is_drowning,
    // rust: damage_amount,
    // rust: bubble_count,
    // rust: cancel,
    // rust: );
}
}

    // rust: pub(crate) fn living_fall(
    // rust: entity: u32,
    // rust: kind: &str,
    // rust: distance: &mut f64,
    // rust: multiplier: &mut f32,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: if let Some(hooks) = HOOKS.get() {
    // rust: (hooks.living_fall)(entity, kind, distance, multiplier, cancel);
}
}

    // rust: pub(crate) fn living_jump(entity: u32, kind: &str) {
    // rust: if let Some(hooks) = HOOKS.get() {
    // rust: (hooks.living_jump)(entity, kind);
}
}

    // rust: pub(crate) fn register_goals(mob: &mut crate::mobs::Mob) {
    // rust: if let Some(hooks) = HOOKS.get() {
    // rust: (hooks.register_goals)(mob);
}
}

    // rust: pub(crate) fn ingredient(kind: &str, data: &Map<String, Value>, items: &mut Vec<String>) {
    // rust: if let Some(hooks) = HOOKS.get() {
    // rust: (hooks.ingredient)(kind, data, items);
}
}

    // rust: pub(crate) fn ingredient_test(
    // rust: kind: &str,
    // rust: data: &Map<String, Value>,
    // rust: stack: &ItemStack,
    // rust: accept: &mut bool,
    // rust: ) {
    // rust: if let Some(hooks) = HOOKS.get() {
    // rust: (hooks.ingredient_test)(kind, data, stack, accept);
}
}
