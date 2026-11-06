//! Transpiled from Horizon Rust crate
//! Module: horizon-client_sheep_dye
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::Game;
// use horizon_client::{first_person::Hand, mobs::sheep_dye};

    // rust: impl Game<'_> {
    /// `DyeItem.interactLivingEntity`: PLAYERS, fixed pitch, excluding the
    /// actor on the server because that client's item interaction plays it.
    // rust: pub(super) fn interact_sheep_dye(&mut self, index: usize, hand: Hand, client: bool) -> bool {
    // rust: let Some(mut stack) = self.with_hand(hand, |g| g.held().cloned()) else {
    // rust: return false;
}
    // rust: if !sheep_dye::interact(&mut self.mobs[index], &mut stack, client) {
    // rust: return false;
}
    // rust: self.play_mob_bound_sound(index, "minecraft:item.dye.use", 7, 1.0, 1.0, !client);
    // rust: if !client && !self.creative {
    // rust: self.with_hand(hand, |g| *g.held_mut() = (stack.count > 0).then_some(stack));
}
    // rust: true
}
}
