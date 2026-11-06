//! Transpiled from Horizon Rust crate
package horizon_client_native_energy

import "core:fmt"
import "core:mem"
import "core:math"

// Energy in a block's buffer for native server mods (docs/native-mods.md):
// the buffer a mod block declared through `native_block_entity_energy`, read
// through a side, filled, drained and moved to another block. Vanilla has no
// energy; the contract is NeoForge's `EnergyHandler` (`SimpleEnergyHandler`
// and `EnergyHandlerUtil.move`). Like the fluid helpers, they act where the
// world is simulated, never on a client's copy, and only on the level in
// place, which the readers name by their `dimension`
// (`minecraft:overworld`), as `native_set_block` does.
// use super::Game;
// use horizon_client::containers::ModEnergyBuffer;
// use horizon_core::geometry::Direction;
// use horizon_world::nbt::{Compound, JavaString, Tag};
// use std::sync::Arc;

// A block's energy as a side reaches it (`native_energy`).
    // rust: pub(crate) struct NativeEnergy {
    // rust: pub(crate) amount: i32,
    // rust: pub(crate) capacity: i32,
    // The most one insert moves.
    // rust: pub(crate) max_insert: i32,
    // The most one extract moves.
    // rust: pub(crate) max_extract: i32,
    // Whether a fill may come through this side (and moves more than 0).
    // rust: pub(crate) can_insert: bool,
    // Whether a drain may leave by this side (and moves more than 0).
    // rust: pub(crate) can_extract: bool,
}

// The amount in `nbt`: the int `energy`, as `SimpleEnergyHandler` saves it;
// anything else, or a negative, reads as empty.
read_energy :: proc(nbt: ^Compound) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match nbt.get(&JavaString::from("energy")) {
    // rust: Some(Tag::Int(energy)) => (*energy).max(0),
    // rust: _ => 0,
}
}

// `SimpleEnergyHandler.insert`: the room left (none when the amount is
// over the capacity), the call's limit and what was offered, whichever is
// least.
insert_amount :: proc(buffer: ^ModEnergyBuffer, energy: i32, offered: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: (buffer.capacity.saturating_sub(energy))
    // rust: .min(offered)
    // rust: .min(buffer.max_insert)
    // rust: .max(0)
}

// `SimpleEnergyHandler.extract`: what is stored, the call's limit and what
// was asked, whichever is least.
extract_amount :: proc(buffer: ^ModEnergyBuffer, energy: i32, asked: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: energy.min(asked).min(buffer.max_extract).max(0)
}

// Native mods use these; nothing in Horizon does.
    // rust: impl Game<'_> {
    // The buffer of the mod block at `pos` in the level in place,
    // `dimension`, and the energy it holds (its block entity's, and not the
    // placeholder standing in while it ticks).
    // rust: fn native_energy_at(
    // rust: &self,
    // rust: dimension: &str,
    // rust: pos: [i32; 3],
    // rust: ) -> Option<(Arc<ModEnergyBuffer>, i32)> {
    // rust: if !self.native_simulates() || dimension != self.dim.id() {
    // rust: return None;
}
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let buffer = self.world.block_entities.mod_energy(state.0)?;
        // The block entity is out of the world while it ticks.
    // rust: match self.world.block_entities.get(&key) {
    // rust: Some(horizon_client::containers::BlockEntity::Mod(m)) if !m.id.is_empty() => {
    // rust: Some((Arc::clone(buffer), read_energy(&m.nbt)))
}
    // rust: _ => None,
}
}
    // Writes `energy` into the block entity at `pos`, saved with its chunk.
native_energy_store :: proc(self: ^Self, pos: [i32; 3], energy: i32) {
}
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: if let Some(horizon_client::containers::BlockEntity::Mod(m)) =
    // rust: self.world.block_entities.get_mut(&key)
    // rust: {
    // rust: m.nbt
    // rust: .insert(JavaString::from("energy"), Tag::Int(energy.max(0)));
    // rust: self.world.modified.insert((key.0 >> 4, key.2 >> 4));
}
}
    // What the buffer at `pos` takes (`insert`) or gives through `face` of
    // up to `amount`, written unless `simulate`. Nothing where the side
    // doesn't reach the buffer for that.
    // rust: fn native_energy_transfer(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: pos: [i32; 3],
    // rust: face: Direction,
    // rust: amount: i32,
    // rust: insert: bool,
    // rust: simulate: bool,
    // rust: ) -> i32 {
    // rust: if amount <= 0 {
    // rust: return 0;
}
    // rust: let Some((buffer, energy)) = self.native_energy_at(dimension, pos) else {
    // rust: return 0;
}
    // rust: let moved = if insert {
    // rust: if !buffer.insert_faces[face as usize] {
    // rust: return 0;
}
    // rust: insert_amount(&buffer, energy, amount)
    // rust: } else {
    // rust: if !buffer.extract_faces[face as usize] {
    // rust: return 0;
}
    // rust: extract_amount(&buffer, energy, amount)
}
    // rust: if moved > 0 && !simulate {
    // rust: let after = if insert {
    // rust: energy.saturating_add(moved)
    // rust: } else {
    // rust: energy - moved
}
    // rust: self.native_energy_store(pos, after);
}
    // rust: moved
}
    // The energy buffer of the block at `pos` in the level in place,
    // `dimension`, as its side `face` reaches it: what it holds, its
    // capacity and its limits per call. None where no buffer is: another
    // dimension, a chunk that isn't loaded, a block without one, a side
    // that reaches neither a fill nor a drain, or the mod block entity
    // ticking now (it's out of the world). `Capabilities.Energy.BLOCK`.
    // rust: pub(in crate::game) fn native_energy(
    // rust: &self,
    // rust: dimension: &str,
    // rust: pos: [i32; 3],
    // rust: face: Direction,
    // rust: ) -> Option<NativeEnergy> {
    // rust: let (buffer, amount) = self.native_energy_at(dimension, pos)?;
    // rust: let (fill, drain) = (
    // rust: buffer.insert_faces[face as usize],
    // rust: buffer.extract_faces[face as usize],
    // rust: );
    // rust: (fill || drain).then(|| NativeEnergy {
    // rust: amount,
    // rust: capacity: buffer.capacity,
    // rust: max_insert: buffer.max_insert,
    // rust: max_extract: buffer.max_extract,
    // rust: can_insert: fill && buffer.max_insert > 0,
    // rust: can_extract: drain && buffer.max_extract > 0,
    // rust: })
}
    // `EnergyHandler.insert`: up to `amount` into the buffer of the block at
    // `pos` through its side `face`, in the level in place: no more than
    // its room and its limit per call. With `simulate` nothing changes and
    // the answer says what would. The amount that went in.
    // rust: pub(in crate::game) fn native_energy_insert(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: face: Direction,
    // rust: amount: i32,
    // rust: simulate: bool,
    // rust: ) -> i32 {
    // rust: let dimension = self.dim.id();
    // rust: self.native_energy_transfer(dimension, pos, face, amount, true, simulate)
}
    // `EnergyHandler.extract`: up to `amount` out of the buffer of the block
    // at `pos` in the level in place, `dimension`, through its side `face`:
    // no more than it holds and its limit per call. With `simulate` nothing
    // changes and the answer says what would. The amount that came out.
    // rust: pub(in crate::game) fn native_energy_extract(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: pos: [i32; 3],
    // rust: face: Direction,
    // rust: amount: i32,
    // rust: simulate: bool,
    // rust: ) -> i32 {
    // rust: self.native_energy_transfer(dimension, pos, face, amount, false, simulate)
}
    // `EnergyHandlerUtil.move`: up to `max` from the block at `from`,
    // through its side `from_face`, into the one at `to`, through
    // `to_face`, in the level in place, `dimension`. It asks what the
    // source can give, offers that to the target, and takes from the source
    // exactly what the target accepted, so none is lost. The amount moved;
    // 0 where either has no buffer for it, and within one block.
    // rust: pub(in crate::game) fn native_move_energy(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: from: [i32; 3],
    // rust: from_face: Direction,
    // rust: to: [i32; 3],
    // rust: to_face: Direction,
    // rust: max: i32,
    // rust: ) -> i32 {
    // rust: if from == to || max <= 0 {
    // rust: return 0;
}
    // rust: let offered = self.native_energy_transfer(dimension, from, from_face, max, false, true);
    // rust: let accepted = self.native_energy_transfer(dimension, to, to_face, offered, true, true);
    // rust: if accepted == 0 {
    // rust: return 0;
}
    // rust: let taken = self.native_energy_transfer(dimension, from, from_face, accepted, false, false);
    // rust: let put = self.native_energy_transfer(dimension, to, to_face, taken, true, false);
    // rust: if put < taken {
            // Both were just simulated and nothing ran between; a buffer
            // that answers differently is a bug, and its energy goes back.
    // rust: log::warn!("Horizon: an energy move lost {} energy", taken - put);
    // rust: let _ =
    // rust: self.native_energy_transfer(dimension, from, from_face, taken - put, true, false);
}
    // rust: put
}
}

    // rust: mod tests {
//     use super::*;

buffer :: proc(capacity: i32, max_insert: i32, max_extract: i32) -> M {
    // Ported from Horizon
    return {}
}
    // rust: ModEnergyBuffer {
    // rust: capacity,
    // rust: max_insert,
    // rust: max_extract,
    // rust: insert_faces: [true; 6],
    // rust: extract_faces: [true; 6],
}
}

an_insert_stops_at_the_room_the_limit_and_the_offer :: proc() {
}
    // rust: let b = buffer(1000, 100, 50);
    // rust: assert_eq!(insert_amount(&b, 0, 40), 40);
    // rust: assert_eq!(insert_amount(&b, 0, 500), 100);
    // rust: assert_eq!(insert_amount(&b, 950, 500), 50);
    // rust: assert_eq!(insert_amount(&b, 1000, 500), 0);
        // Over the capacity after a mod update shrank it: nothing goes in.
    // rust: assert_eq!(insert_amount(&b, 1500, 500), 0);
    // rust: assert_eq!(insert_amount(&b, 0, i32::MAX), 100);
    // rust: assert_eq!(
    // rust: insert_amount(&buffer(i32::MAX, i32::MAX, 0), 5, i32::MAX),
    // rust: i32::MAX - 5
    // rust: );
}

an_extract_stops_at_what_is_stored_the_limit_and_the_ask :: proc() {
}
    // rust: let b = buffer(1000, 100, 50);
    // rust: assert_eq!(extract_amount(&b, 800, 30), 30);
    // rust: assert_eq!(extract_amount(&b, 800, 500), 50);
    // rust: assert_eq!(extract_amount(&b, 20, 500), 20);
    // rust: assert_eq!(extract_amount(&b, 0, 500), 0);
    // rust: assert_eq!(extract_amount(&buffer(1000, 100, 0), 800, 500), 0);
}

the_amount_reads_as_the_saved_int_and_anything_else_as_empty :: proc() {
}
    // rust: let mut nbt = Compound::new();
    // rust: assert_eq!(read_energy(&nbt), 0);
    // rust: nbt.insert(JavaString::from("energy"), Tag::Int(750));
    // rust: assert_eq!(read_energy(&nbt), 750);
    // rust: nbt.insert(JavaString::from("energy"), Tag::Int(-5));
    // rust: assert_eq!(read_energy(&nbt), 0);
    // rust: nbt.insert(
    // rust: JavaString::from("energy"),
    // rust: Tag::String(JavaString::from("lots")),
    // rust: );
    // rust: assert_eq!(read_energy(&nbt), 0);
}
}
