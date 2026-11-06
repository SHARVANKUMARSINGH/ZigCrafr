//! Transpiled from Horizon Rust crate
package horizon_client_block_contact

import "core:fmt"
import "core:mem"
import "core:math"

// Synchronous mod-block contacts from the server's simulation code.
// use horizon_core::position::BlockPos;
// use horizon_world::registry::BlockStateId;
// use std::{
    // rust: cell::Cell,
    // rust: sync::{
    // rust: OnceLock,
    // rust: atomic::{AtomicBool, Ordering},
    // rust: },
}

Contact :: struct {
    entity: i32,
    kind: ^'a str,
    block: ^'a str,
    state: BlockStateId,
    position: BlockPos,
}

Event :: enum {
    StepOn(Contact<'a>),
    Inside(Contact<'a>),
    FallOn(Contact<'a>, f64),
}

HOOK :: OnceLock::new()
// Whether the loaded blocks hold one outside `minecraft:` (a content mod's).
// Without one no contact can dispatch, so the item and projectile sweeps
// skip their per-tick work: every item and thrown thing on a server would
// otherwise sweep its blocks each tick for nothing.
MOD_BLOCKS :: AtomicBool::new(false)

// Called when the block tables load.
set_mod_blocks :: proc(any: bool) {
}
    // rust: MOD_BLOCKS.store(any, Ordering::Relaxed);
}
    // rust: thread_local! {
LEVEL :: const { Cell::new(None) }
}

// Scope authority to this thread and restore it even on an error or panic.
// Nested guest actions may temporarily enter a different dimension.
    // rust: pub fn in_level<R>(dimension: Option<&'static str>, f: impl FnOnce() -> R) -> R {
Restore :: struct {
    // rust: impl Drop for Restore {
drop :: proc(self: ^Self) {
}
    // rust: LEVEL.set(self.0);
}
}
    // rust: let _restore = Restore(LEVEL.replace(dimension));
    // rust: f()
}

emit :: proc(event: Event<'_>) {
}
    // rust: dispatch(event, &mut 0.0);
}

// Damage is the calculated fall damage, before hurt handling and fall sounds.
fall :: proc(contact: Contact<'_>, distance: f64, mut damage: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: dispatch(Event::FallOn(contact, distance), &mut damage);
    // rust: damage
}

dispatch :: proc(event: Event<'_>, damage: ^f32) {
}
    // rust: let contact = match event {
    // rust: Event::StepOn(c) | Event::Inside(c) | Event::FallOn(c, _) => c,
}
    // rust: if contact.block.starts_with("minecraft:") {
    // rust: return;
}
    // rust: if let Some(dimension) = LEVEL.get()
    // rust: && let Some(hook) = HOOK.get()
    // rust: {
    // rust: let original = *damage;
    // rust: hook(dimension, event, damage);
    // rust: if !damage.is_finite() {
    // rust: *damage = original;
}
    // rust: *damage = damage.max(0.0);
}
}

// Reuse the entity block sweep for item and projectile ticks without an effect collector.
    // rust: pub fn swept_inside<'a>(
    // rust: entity: i32,
    // rust: kind: &str,
    // rust: from: horizon_core::geometry::Vec3,
    // rust: to: horizon_core::geometry::Vec3,
    // rust: bounds: horizon_core::geometry::Aabb,
    // rust: mut block: impl FnMut(BlockPos) -> (BlockStateId, &'a str),
    // rust: ) {
    // rust: if !MOD_BLOCKS.load(Ordering::Relaxed) || LEVEL.get().is_none() || HOOK.get().is_none() {
    // rust: return;
}
    // rust: let bounds = bounds.deflate(horizon_core::geometry::Vec3::new(1e-5, 1e-5, 1e-5));
    // rust: let mut visited = std::collections::HashSet::new();
    // rust: let _ =
    // rust: horizon_core::geometry::sweep_intersected_blocks(from, to, bounds, 1_000_000, |p, step| {
    // rust: if step >= 16 {
    // rust: return false;
}
    // rust: if visited.insert(p) {
    // rust: let (state, name) = block(p);
    // rust: emit(Event::Inside(Contact {
    // rust: entity,
    // rust: kind,
    // rust: block: name,
    // rust: state,
    // rust: position: p,
    // rust: }));
}
    // rust: true
    // rust: });
}

    // rust: mod tests {
//     use super::*;
    // rust: thread_local! {
SEEN :: const { Cell::new(0) }
}
hook :: proc(dimension: string, event: Event<'_>, damage: ^f32) {
}
    // rust: assert_eq!(dimension, "minecraft:the_nether");
    // rust: let c = match event {
    // rust: Event::FallOn(c, distance) => {
    // rust: assert_eq!(distance, 12.0);
    // rust: *damage = match *damage {
    // rust: 99.0 => f32::NAN,
    // rust: 98.0 => -1.0,
    // rust: _ => *damage * 0.2,
}
    // rust: c
}
    // rust: Event::Inside(c) | Event::StepOn(c) => c,
}
    // rust: assert_eq!(
    // rust: (c.entity, c.kind, c.state, c.position),
    // rust: (
    // rust: 17,
    // rust: "minecraft:zombie",
    // rust: BlockStateId(9),
    // rust: BlockPos::new(1, 2, 3)
    // rust: )
    // rust: );
    // rust: SEEN.set(SEEN.get() + 1);
}
contacts_require_server_scope_and_mod_blocks_and_restore_nested_levels :: proc() {
}
    // rust: HOOK.set(hook).unwrap();
    // rust: let c = Contact {
    // rust: entity: 17,
    // rust: kind: "minecraft:zombie",
    // rust: block: "test:hay",
    // rust: state: BlockStateId(9),
    // rust: position: BlockPos::new(1, 2, 3),
}
    // rust: assert_eq!(fall(c, 12.0, 10.0), 10.0);
    // rust: in_level(Some("minecraft:the_nether"), || {
    // rust: emit(Event::StepOn(c));
    // rust: emit(Event::Inside(c));
    // rust: assert_eq!(fall(c, 12.0, 10.0), 2.0);
    // rust: in_level(None, || assert_eq!(fall(c, 12.0, 10.0), 10.0));
    // rust: assert_eq!(fall(c, 12.0, 0.0), 0.0);
    // rust: emit(Event::Inside(Contact {
    // rust: block: "minecraft:hay_block",
    // rust: ..c
    // rust: }));
    // rust: });
    // rust: assert_eq!(fall(c, 12.0, 10.0), 10.0);
    // rust: assert_eq!(SEEN.get(), 4);
    // rust: in_level(Some("minecraft:the_nether"), || {
    // rust: assert_eq!(fall(c, 12.0, 99.0), 99.0);
    // rust: assert_eq!(fall(c, 12.0, 98.0), 0.0);
//             use horizon_core::geometry::{Aabb, Vec3};
    // rust: let to = Vec3::new(2.5, 2.0, 3.5);
    // rust: let bounds = Aabb::new(Vec3::new(2.25, 2.0, 3.25), Vec3::new(2.75, 2.5, 3.75));
    // rust: let block = |p| {
    // rust: (
    // rust: BlockStateId(9),
    // rust: if p == c.position {
    // rust: "test:hay"
    // rust: } else {
    // rust: "minecraft:air"
    // rust: },
    // rust: )
}
    // rust: set_mod_blocks(true);
    // rust: swept_inside(17, c.kind, Vec3::new(0.5, 2.0, 3.5), to, bounds, block);
    // rust: assert_eq!(SEEN.get(), 7, "a block crossed mid-move is notified once");
    // rust: let at = Vec3::new(1.5, 2.0, 3.5);
    // rust: let bounds = bounds.move_by(Vec3::new(-1.0, 0.0, 0.0));
    // rust: swept_inside(17, c.kind, at, at, bounds, block);
    // rust: assert_eq!(SEEN.get(), 8, "stationary overlap still notifies");
    // rust: });
    // rust: let _ =
    // rust: std::panic::catch_unwind(|| in_level(Some("minecraft:the_nether"), || panic!("test")));
    // rust: assert_eq!(fall(c, 12.0, 10.0), 10.0);
}
}
