//! Transpiled from Horizon Rust crate
//! Module: horizon-world_blocking_item_damage
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Blocking-component durability dispatch bound to stored item durability.
// use crate::{
    // rust: blocking_rules::ItemDamageFunction,
    // rust: item_durability::{self, DurabilityWorld},
}

    // rust: pub trait BlockingItemDamageWorld: DurabilityWorld {
    // rust: type Level: Copy;
pub fn is_player(self: *Self) b;
pub fn is_server_player(self: *Self) b;
    // rust: fn level_is_client(
    // rust: &mut self,
    // rust: stack: &mut Self::Stack,
    // rust: level: Self::Level,
    // rust: ) -> Result<bool, Self::Error>;
    /// Implementations capture the stack's current item type before awarding it.
pub fn award_item_used(self: *Self, stack: *mut Self::Stack) R;
pub fn entity_level_is_server(self: *Self, stack: *mut Self::Stack) R;
}

    // rust: pub fn hurt<W: BlockingItemDamageWorld>(
    // rust: stack: &mut W::Stack,
    // rust: world: &mut W,
    // rust: level: W::Level,
    // rust: damage: f32,
    // rust: rule: ItemDamageFunction,
    // rust: ) -> Result<(), W::Error> {
    // rust: if !world.is_player() {
    // rust: return Ok(());
}
    // rust: if !world.level_is_client(stack, level)? {
    // rust: world.award_item_used(stack)?;
}
    // rust: let amount = rule.apply(damage);
    // rust: if amount > 0 && world.entity_level_is_server(stack)? {
    // rust: let player = world.is_server_player();
    // rust: item_durability::hurt_and_break(stack, world, amount, player)?;
}
    // rust: Ok(())
}
