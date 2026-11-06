//! Transpiled from Horizon Rust crate
package horizon_client_sound_order

import "core:fmt"
import "core:mem"
import "core:math"

// Keep captured level sounds between an emitter's pairing and removal.
// use super::{containers::captured_sound_range, entity::EntityState, guest::Guest, hub::Hub};
// use crate::{audio::CapturedSound, fast_hash::FxHashSet};
// use horizon_protocol::{
    // rust: buf::Reader,
    // rust: ids::play::clientbound as ids,
    // rust: packets::play::{self, Clientbound as C},
}

    // rust: pub(super) struct SoundOrder {
    // rust: protected: FxHashSet<i32>,
    // rust: removed: Vec<(u32, Vec<i32>)>,
}

    // rust: impl Hub {
    // Flush the ordered prefix whose emitters need no new pairing. A sound
    // waiting for AddEntity holds the rest of the queue in order; removals of
    // those later emitters wait until the remaining sounds have gone out.
    // rust: pub fn prepare_captured_sounds(
    // rust: &self,
    // rust: sounds: &mut Vec<CapturedSound>,
    // rust: entities: &[EntityState],
    // rust: ) {
    // rust: let present: FxHashSet<i32> = if sounds.iter().any(|sound| sound.entity.is_some()) {
    // rust: entities
    // rust: .iter()
    // rust: .map(|e| e.id)
    // rust: .chain(
    // rust: self.guests
    // rust: .iter()
    // rust: .filter(|g| self.here(g))
    // rust: .map(|g| g.entity_id),
    // rust: )
    // rust: .collect()
    // rust: } else {
    // rust: FxHashSet::default()
}
    // rust: let early = sounds
    // rust: .iter()
    // rust: .position(|sound| {
    // rust: sound.entity.is_some_and(|id| {
    // rust: present.contains(&(id as i32))
    // rust: && self.guests.iter().any(|g| {
    // rust: self.here(g)
    // rust: && g.entity_id as u32 != id
    // rust: && sound.except_entity != Some(g.entity_id as u32)
    // rust: && !g.tracker.is_tracking(id as i32)
    // rust: && super::containers::within_range(
    // rust: sound.position,
    // rust: g.position,
    // rust: captured_sound_range(sound),
    // rust: )
    // rust: })
    // rust: })
    // rust: })
    // rust: .unwrap_or(sounds.len());
    // rust: {
    // rust: let mut order = self.sound_order.lock().unwrap();
    // rust: debug_assert!(
    // rust: order.removed.is_empty(),
    // rust: "finish the preceding sound batch first"
    // rust: );
    // rust: order.protected = sounds[early..]
    // rust: .iter()
    // rust: .filter_map(|s| s.entity.map(|id| id as i32))
    // rust: .collect();
}
    // rust: for sound in sounds.drain(..early) {
    // rust: self.captured_sound(&sound, None);
}
}

    // Delay only protected ids, keeping every other removal at its usual point.
    // rust: pub(super) fn send_ordered_removal(&self, guest: &Guest, ids: &[i32]) {
    // rust: let mut now = Vec::new();
    // rust: let mut held = Vec::new();
    // rust: {
    // rust: let mut order = self.sound_order.lock().unwrap();
    // rust: for &id in ids {
    // rust: if order.protected.contains(&id) {
    // rust: held.push(id);
    // rust: } else {
    // rust: now.push(id);
}
}
    // rust: if !held.is_empty() {
    // rust: order.removed.push((guest.conn, held));
}
}
    // rust: if !now.is_empty() {
    // rust: guest.send(&C::RemoveEntities(play::RemoveEntities { ids: now }));
}
}

    // Entity tracking already builds packet bodies. Split its removal batch
    // without decoding or changing any of its pairing/movement packets.
    // rust: pub(super) fn hold_sound_removals(&self, conn: u32, packets: &mut Vec<Vec<u8>>) {
    // rust: let mut order = self.sound_order.lock().unwrap();
    // rust: if order.protected.is_empty() {
    // rust: return;
}
    // rust: packets.retain_mut(|body| {
    // rust: let mut reader = Reader::new(body);
    // rust: if reader.varint().unwrap() != ids::REMOVE_ENTITIES {
    // rust: return true;
}
    // rust: let C::RemoveEntities(mut packet) =
    // rust: C::decode(ids::REMOVE_ENTITIES, reader.rest()).unwrap()
    // rust: else {
    // rust: unreachable!()
}
    // rust: let original = packet.ids.len();
    // rust: let mut held = Vec::new();
    // rust: packet.ids.retain(|id| {
    // rust: if order.protected.contains(id) {
    // rust: held.push(*id);
    // rust: false
    // rust: } else {
    // rust: true
}
    // rust: });
    // rust: if held.is_empty() {
    // rust: return true;
}
    // rust: order.removed.push((conn, held));
    // rust: if packet.ids.is_empty() {
    // rust: return false;
}
    // rust: debug_assert!(packet.ids.len() < original);
    // rust: *body = C::RemoveEntities(packet).encode();
    // rust: true
    // rust: });
}

    // Called after the rest of the captured sounds, before the level changes.
finish_captured_sounds :: proc(self: ^Self) {
}
    // rust: let order = std::mem::take(&mut *self.sound_order.lock().unwrap());
    // rust: for (conn, ids) in order.removed {
    // rust: if let Some(guest) = self.guest(conn) {
    // rust: guest.send(&C::RemoveEntities(play::RemoveEntities { ids }));
}
}
}
}
