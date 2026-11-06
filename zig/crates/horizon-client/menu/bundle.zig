//! Transpiled from Horizon Rust crate
//! Module: horizon-client_bundle
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `BundleItem`'s click overrides in a PICKUP click
//! (`tryItemClickBehaviourOverride`).
// use super::{Env, Menu, tidy};
// use crate::bundle::{Contents, INSERT, INSERT_FAIL, REMOVE_ONE, can_be_in_bundle, toggle_selected};

    // rust: impl Menu {
    /// The carried stack's `overrideStackedOnOther`, then the clicked
    /// one's `overrideOtherStackedOnMe`. True when a bundle took the click.
    // rust: pub(super) fn bundle_click(&mut self, env: &Env, s: usize, primary: bool) -> bool {
    // rust: let took = self.carried_bundle_click(env, s, primary)
    // rust: || self.clicked_bundle_click(env, s, primary);
    // rust: if took {
            // broadcastChangesOnContainerMenu: the open menu's
            // slotsChanged for the player's inventory.
    // rust: self.inventory_slots_changed(env);
}
    // rust: took
}

    /// `BundleItem.overrideStackedOnOther`: the carried bundle on a slot.
pub fn carried_bundle_click(self: *Self, env: *Env, s: usize, primary: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(mut contents) = self
    // rust: .carried
    // rust: .as_ref()
    // rust: .and_then(|c| Contents::of(env.items, c))
    // rust: else {
    // rust: return false;
}
    // rust: match (self.slot(s).cloned(), primary) {
    // rust: (Some(other), true) => {
                // tryTransfer: what fits, taken by the slot's rules.
    // rust: let mut moved = 0;
    // rust: if can_be_in_bundle(&other) {
    // rust: let room = contents.room_for(env.items, &other);
    // rust: if let Some(mut taken) = self.safe_take(env, s, other.count, room) {
    // rust: moved = contents.try_insert(env.items, &mut taken);
}
}
    // rust: self.player_sounds
    // rust: .push(if moved > 0 { INSERT } else { INSERT_FAIL });
}
    // rust: (None, false) => {
    // rust: if let Some(stack) = contents.remove_one(env.items) {
    // rust: let count = stack.count;
    // rust: let mut remainder = Some(stack);
    // rust: self.safe_insert(env, s, &mut remainder, count);
    // rust: match remainder {
    // rust: Some(mut rest) => {
    // rust: contents.try_insert(env.items, &mut rest);
}
    // rust: None => self.player_sounds.push(REMOVE_ONE),
}
}
}
    // rust: _ => return false,
}
    // rust: if let Some(carried) = self.carried.as_mut() {
    // rust: contents.store(carried);
}
    // rust: true
}

    /// `BundleItem.overrideOtherStackedOnMe`: a click on a bundle in a slot.
pub fn clicked_bundle_click(self: *Self, env: *Env, s: usize, primary: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(mut bundle) = self.slot(s).cloned() else {
    // rust: return false;
}
    // rust: let Some(mut contents) = Contents::of(env.items, &bundle) else {
    // rust: return false;
}
    // rust: let allowed = self.allow_modification(env, s);
    // rust: match (self.carried.take(), primary) {
    // rust: (Some(mut other), true) => {
    // rust: let moved = if allowed {
    // rust: contents.try_insert(env.items, &mut other)
    // rust: } else {
    // rust: 0
}
    // rust: self.player_sounds
    // rust: .push(if moved > 0 { INSERT } else { INSERT_FAIL });
    // rust: self.carried = Some(other);
    // rust: tidy(&mut self.carried);
}
    // rust: (None, false) => {
    // rust: if allowed && let Some(removed) = contents.remove_one(env.items) {
    // rust: self.player_sounds.push(REMOVE_ONE);
    // rust: self.carried = Some(removed);
}
}
    // rust: (carried, _) => {
                // toggleSelectedItem(-1), then the click goes on.
    // rust: self.carried = carried;
    // rust: toggle_selected(&mut bundle, -1);
    // rust: let slot = self.slots[s];
    // rust: self.containers[slot.container][slot.index] = Some(bundle);
    // rust: return false;
}
}
        // `self.set(BUNDLE_CONTENTS, ...)` changes the slot's stack in place.
    // rust: contents.store(&mut bundle);
    // rust: let slot = self.slots[s];
    // rust: self.containers[slot.container][slot.index] = Some(bundle);
    // rust: true
}
}
