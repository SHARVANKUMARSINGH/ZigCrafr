//! Transpiled from Horizon Rust crate
package horizon_world_item_use_start

import "core:fmt"
import "core:mem"
import "core:math"

// Begin using a held stack, retaining native callback and flag ordering.
// use crate::item_use_lifecycle::{UseLifecycleWorld, UseState};
    // rust: pub trait StartUseWorld: UseLifecycleWorld {
    // rust: fn duration(
    // rust: &mut self,
    // rust: s: &mut UseState<Self::Item>,
    // rust: item: Self::Item,
    // rust: ) -> Result<i32, Self::Error>;
    // rust: fn synchronize_equipment(
    // rust: &mut self,
    // rust: s: &mut UseState<Self::Item>,
    // rust: level: Self::Level,
    // rust: hand: Self::Hand,
    // rust: item: Self::Item,
    // rust: ) -> Result<(), Self::Error>;
is_off_hand :: proc(self: ^Self, hand: Self::Hand) -> b {
    // Ported from Horizon
    return {}
}
    // rust: fn set_off_hand_flag(
    // rust: &mut self,
    // rust: s: &mut UseState<Self::Item>,
    // rust: off: bool,
    // rust: ) -> Result<(), Self::Error>;
    // rust: fn start_vibration(
    // rust: &mut self,
    // rust: s: &mut UseState<Self::Item>,
    // rust: item: Self::Item,
    // rust: ) -> Result<(), Self::Error>;
has_kinetic_weapon :: proc(self: ^Self, item: Self::Item) -> b {
    // Ported from Horizon
    return {}
}
reset_recent_kinetic_enemies :: proc(self: ^Self, s: ^UseState<Self::Item>) {
}
}
    // rust: pub fn start<W: StartUseWorld>(
    // rust: w: &mut W,
    // rust: s: &mut UseState<W::Item>,
    // rust: hand: W::Hand,
    // rust: ) -> Result<(), W::Error> {
    // rust: let item = w.hand_item(s, hand)?;
    // rust: if w.is_empty(item.clone()) || w.using_item(s)? {
    // rust: return Ok(());
}
    // rust: s.item = item.clone();
    // rust: s.remaining = w.duration(s, item)?;
    // rust: let level = w.level(s)?;
    // rust: if !w.is_client(s, level)? {
    // rust: let level = w.level(s)?;
    // rust: w.synchronize_equipment(s, level, hand, s.item.clone())?;
    // rust: w.set_using_flag(s, true)?;
    // rust: let off = w.is_off_hand(hand);
    // rust: w.set_off_hand_flag(s, off)?;
    // rust: w.start_vibration(s, s.item.clone())?;
    // rust: if w.has_kinetic_weapon(s.item.clone()) {
    // rust: w.reset_recent_kinetic_enemies(s);
}
}
    // rust: Ok(())
}
