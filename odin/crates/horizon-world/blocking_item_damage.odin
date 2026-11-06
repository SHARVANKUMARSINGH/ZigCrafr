//! Transpiled from Horizon Rust crate
package horizon_world_blocking_item_damage

import "core:fmt"
import "core:mem"
import "core:math"

// Blocking-component durability dispatch bound to stored item durability.
// use crate::{
    // rust: blocking_rules::ItemDamageFunction,
    // rust: item_durability::{self, DurabilityWorld},
}

    // rust: pub trait BlockingItemDamageWorld: DurabilityWorld {
    // rust: type Level: Copy;
is_player :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
is_server_player :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: fn level_is_client(
    // rust: &mut self,
    // rust: stack: &mut Self::Stack,
    // rust: level: Self::Level,
    // rust: ) -> Result<bool, Self::Error>;
    // Implementations capture the stack's current item type before awarding it.
award_item_used :: proc(self: ^Self, stack: ^Self::Stack) -> R {
    // Ported from Horizon
    return {}
}
entity_level_is_server :: proc(self: ^Self, stack: ^Self::Stack) -> R {
    // Ported from Horizon
    return {}
}
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
