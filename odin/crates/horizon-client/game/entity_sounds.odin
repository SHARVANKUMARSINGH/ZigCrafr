//! Transpiled from Horizon Rust crate
package horizon_client_entity_sounds

import "core:fmt"
import "core:mem"
import "core:math"

// The entity overload of level sounds, shared by mob and player call sites.
// use super::Game;
// use horizon_client::sound_engine::{SoundEntity, SoundEntityState};
// use horizon_world::nbt::Tag;

saved_silent :: proc(extra: Maybe(^Tag)) -> b {
    // Ported from Horizon
    return {}
}
    // rust: horizon_client::save::number(extra.and_then(|tag| tag.get("Silent"))).unwrap_or(0) != 0
}

    // rust: impl Game<'_> {
    // `Level.playSound(except, mob, ...)`: the category and actor exclusion
    // belong to the call site, not to the event's name.
    // rust: pub(super) fn play_mob_bound_sound(
    // rust: &mut self,
    // rust: index: usize,
    // rust: event: &str,
    // rust: source: usize,
    // rust: volume: f32,
    // rust: pitch: f32,
    // rust: except_actor: bool,
    // rust: ) {
    // rust: let mob = &self.mobs[index];
    // rust: let entity = horizon_client::sound_engine::SoundEntity::new(
    // rust: mob.id,
    // rust: [mob.position.x, mob.position.y, mob.position.z],
    // rust: mob.silent,
    // rust: );
    // rust: let except = except_actor.then(|| self.native_acting_entity());
    // rust: self.audio
    // rust: .play_bound(event, source, volume, pitch, entity, except);
}

sound_player_id :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.remote
    // rust: .as_ref()
    // rust: .map_or_else(|| self.native_acting_entity(), |r| r.entity_id as u32)
}

    // The player in place can be a guest while `as_guest` runs. Its entity
    // id and saved metadata travel with that action, even while the hub is out.
    // rust: pub(super) fn play_player_bound_sound(
    // rust: &mut self,
    // rust: event: &str,
    // rust: source: usize,
    // rust: volume: f32,
    // rust: pitch: f32,
    // rust: except_actor: bool,
    // rust: ) {
    // rust: let id = self.sound_player_id();
    // rust: let Some(state) = self.sound_entity_state(id) else {
    // rust: return;
}
    // rust: let entity = SoundEntity::new(id, state.position, state.silent);
    // rust: entity.update(state);
    // rust: self.audio.play_bound(
    // rust: event,
    // rust: source,
    // rust: volume,
    // rust: pitch,
    // rust: entity,
    // rust: except_actor.then_some(id),
    // rust: );
}

    // rust: pub(super) fn sound_entity_state(&mut self, id: u32) -> Option<SoundEntityState> {
    // rust: if self.remote.is_some() {
    // rust: return self.remote_sound_entity_state(id as i32);
}
    // rust: if id == self.sound_player_id()
    // rust: && let Some(player) = self.player.as_ref()
    // rust: {
    // rust: return Some(SoundEntityState {
    // rust: position: [player.position.x, player.position.y, player.position.z],
    // rust: silent: saved_silent(self.level.player_extra.as_ref()),
    // rust: removed: false,
    // rust: });
}
    // rust: if let Some(guest) = self.lan.as_ref().and_then(|host| {
    // rust: host.hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.entity_id as u32 == id && g.placed && g.dimension == self.dim.id())
    // rust: }) {
    // rust: return Some(SoundEntityState {
    // rust: position: guest.position,
    // rust: silent: saved_silent(guest.saved.as_ref()),
    // rust: removed: false,
    // rust: });
}
    // rust: if let Some(t) = self.tridents.iter().find(|t| t.id == id) {
    // rust: return Some(SoundEntityState {
    // rust: position: [t.position.x, t.position.y, t.position.z],
    // rust: silent: false,
    // rust: removed: false,
    // rust: });
}
    // rust: self.mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .map(|m| SoundEntityState {
    // rust: position: [m.position.x, m.position.y, m.position.z],
    // rust: silent: m.silent,
    // rust: removed: m.removed,
    // rust: })
}
}
