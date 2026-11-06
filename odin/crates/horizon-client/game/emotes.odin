//! Transpiled from Horizon Rust crate
package horizon_client_emotes

import "core:fmt"
import "core:mem"
import "core:math"

// Emotes ([docs/cosmetics.md](../../../../docs/cosmetics.md)): short animations of the player
// model, played from the emote wheel. Visual only: the game protocol carries nothing, a game
// server sees a player standing still. Moving, attacking, using an item, being hurt, riding,
// sleeping, gliding or sneaking cancels one; the camera pulls back to the front view while it
// plays (from first person only) and comes back when it ends.

// use super::Game;
// use super::perspective::CameraType;
// use horizon_cosmetics::account::OwnedEmote;
// use horizon_cosmetics::{Item, Playing, Slot};
// use std::sync::Arc;

// How far the player may drift (blocks) before the emote stops: a nudge, not a step.
DRIFT :: 0.01

    // rust: pub(super) struct Emotes {
    // The emotes the wheel offers, in order.
    // rust: pub(super) owned: Vec<Arc<Item>>,
    // Their names by locale, by id (the service's), when known.
    // rust: pub(super) names: std::collections::HashMap<String, std::collections::BTreeMap<String, String>>,
    // The account's emotes on their way from the service, and when they last came.
    // rust: pub(super) loading: Option<std::sync::mpsc::Receiver<Result<Vec<OwnedEmote>, String>>>,
    // rust: pub(super) loaded: Option<std::time::Instant>,
    // `owned` was read from `HORIZON_COSMETICS_LOCAL`'s folder.
    // rust: local_read: bool,
    // rust: playing: Option<Playing>,
    // The camera the emote pulled back from, put back when it ends (unless the player chose
    // another meanwhile).
    // rust: camera_from: Option<CameraType>,
    // Where the player stood when it started.
    // rust: from: Option<horizon_core::geometry::Vec3>,
}

    // rust: impl Emotes {
    // The emote to tell the service about, while it plays: its id and whether it loops.
    // rust: pub(super) fn sending(&self) -> Option<(String, bool)> {
    // rust: let p = self.playing.as_ref().filter(|p| p.stop.is_none())?;
    // rust: let looping = p.item.emote.as_ref().is_some_and(|e| e.looping);
    // rust: Some((p.item.id.clone(), looping))
}
}

// The emotes among a folder's item files, by id.
read_folder :: proc(dir: ^std::path::Path) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut emotes: Vec<Arc<Item>> = std::fs::read_dir(dir)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: .filter_map(|e| Item::parse(&std::fs::read(e.path()).ok()?).ok())
    // rust: .filter(|i| i.slot == Slot::Emote)
    // rust: .map(Arc::new)
    // rust: .collect();
    // rust: emotes.sort_by(|a, b| a.id.cmp(&b.id));
    // rust: emotes
}

    // rust: impl Game<'_> {
    // The emotes the wheel offers: a local folder's (`HORIZON_COSMETICS_LOCAL`), else those the
    // account owns.
    // rust: pub(super) fn owned_emotes(&mut self) -> &[Arc<Item>] {
    // rust: if !self.emotes.local_read {
    // rust: self.emotes.local_read = true;
    // rust: if let Some(dir) = std::env::var_os("HORIZON_COSMETICS_LOCAL") {
    // rust: self.emotes.owned = read_folder(std::path::Path::new(&dir));
}
}
    // rust: &self.emotes.owned
}

    // An emote's name: the catalogue's, else its id in words (`wave_hello`: "Wave hello").
    // rust: pub(super) fn emote_name(&self, id: &str) -> String {
    // rust: let names = self.emotes.names.get(id);
    // rust: let lang = horizon_client::lang::code();
    // rust: if let Some(name) = names.and_then(|n| n.get(&lang).or_else(|| n.get("en_us"))) {
    // rust: return name.clone();
}
    // rust: let words = id.replace('_', " ");
    // rust: let mut chars = words.chars();
    // rust: chars
    // rust: .next()
    // rust: .map_or_else(String::new, |c| c.to_uppercase().chain(chars).collect())
}

    // Whether the player could start an emote now: in a world, standing, alive, not a spectator.
may_emote :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return false;
}
    // rust: horizon_cosmetics::enabled()
    // rust: && self.player_model.is_some()
    // rust: && !p.health.dead_or_dying()
    // rust: && !p.fall_flying
    // rust: && p.pose == horizon_client::pose::Pose::Standing
    // rust: && self.riding.is_none()
    // rust: && self.sleeping.is_none()
    // rust: && !self.spectator()
}

    // Plays the owned emote `id` (again from its start if it plays already). False if it isn't
    // owned or the player can't emote now.
    // rust: pub(super) fn play_emote(&mut self, id: &str) -> bool {
    // rust: let Some(item) = self.owned_emotes().iter().find(|i| i.id == id).cloned() else {
    // rust: return false;
}
    // rust: if !self.may_emote() {
    // rust: return false;
}
    // rust: let (Some(m), Some(p)) = (self.player_model.as_ref(), self.player.as_ref()) else {
    // rust: return false;
}
    // rust: let start = m.age as f32;
    // rust: self.emotes.from = Some(p.position);
    // rust: self.emotes.playing = Some(Playing {
    // rust: item,
    // rust: start,
    // rust: stop: None,
    // rust: });
    // rust: if self.camera_type.first_person() {
    // rust: self.emotes.camera_from = Some(self.camera_type);
    // rust: self.camera_type = CameraType::ThirdPersonFront;
    // rust: self.check_entity_post_effect(false);
}
    // rust: true
}

    // Stops the emote playing, fading it out.
    // rust: pub(super) fn stop_emote(&mut self) {
    // rust: let now = self.player_model.as_ref().map_or(0.0, |m| m.age as f32);
    // rust: if let Some(p) = self.emotes.playing.as_mut()
    // rust: && p.stop.is_none()
    // rust: {
    // rust: p.stop = Some(now);
}
}

    // The emote playing, if any (its id).
    // rust: pub(super) fn emote_playing(&self) -> Option<&str> {
    // rust: let p = self.emotes.playing.as_ref()?;
    // rust: p.stop.is_none().then_some(p.item.id.as_str())
}

    // Once a tick after the player's model: cancels the emote on movement or action, ends it,
    // puts the camera back, and hands it to the model.
tick_emote :: proc(self: ^Self) {
}
    // rust: if self.emotes.playing.is_none() {
    // rust: if let Some(m) = self.player_model.as_mut() {
    // rust: m.emote = None;
}
    // rust: return;
}
    // rust: let moved = match (self.player.as_ref(), self.emotes.from) {
    // rust: (Some(p), Some(from)) => {
    // rust: let (dx, dy, dz) = (
    // rust: p.position.x - from.x,
    // rust: p.position.y - from.y,
    // rust: p.position.z - from.z,
    // rust: );
    // rust: dx * dx + dy * dy + dz * dz > DRIFT * DRIFT
}
    // rust: _ => true,
}
    // rust: let hurt = self
    // rust: .player
    // rust: .as_ref()
    // rust: .is_some_and(|p| p.health.hurt_animation_time > 0);
    // rust: if moved || hurt || self.swing.swinging() || self.using.is_some() || !self.may_emote() {
    // rust: self.stop_emote();
}
    // rust: let now = self.player_model.as_ref().map_or(0.0, |m| m.age as f32);
    // rust: if self
    // rust: .emotes
    // rust: .playing
    // rust: .as_ref()
    // rust: .and_then(|p| p.at(now))
    // rust: .is_none()
    // rust: {
    // rust: self.emotes.playing = None;
    // rust: self.emotes.from = None;
            // The pulled-back view goes back to first person, unless the player turned it.
    // rust: if let Some(from) = self.emotes.camera_from.take()
    // rust: && self.camera_type == CameraType::ThirdPersonFront
    // rust: {
    // rust: self.camera_type = from;
    // rust: self.check_entity_post_effect(from.first_person());
}
}
    // rust: if let Some(m) = self.player_model.as_mut() {
    // rust: m.emote = self.emotes.playing.clone();
}
}

    // Once a tick: my emote, then the other players'.
    // rust: pub(super) fn tick_emotes(&mut self) {
    // rust: if let Some(done) = self
    // rust: .emotes
    // rust: .loading
    // rust: .as_ref()
    // rust: .and_then(|rx| rx.try_recv().ok())
    // rust: {
    // rust: self.emotes.loading = None;
    // rust: if let Ok(owned) = done {
    // rust: self.emotes.loaded = Some(std::time::Instant::now());
    // rust: self.emotes.names.clear();
    // rust: self.emotes.owned.clear();
    // rust: for (item, names) in owned {
    // rust: self.emotes.names.insert(item.id.clone(), names);
    // rust: self.emotes.owned.push(Arc::new(item));
}
}
}
    // rust: self.tick_emote();
    // rust: self.tick_others_emotes();
}

    // How far the camera stands back while an emote pulls it (1: the usual distance): it eases
    // out over the emote's first quarter second.
    // rust: pub(super) fn emote_camera_pull(&self, partial: f32) -> f32 {
    // rust: let (Some(p), Some(m)) = (&self.emotes.playing, &self.player_model) else {
    // rust: return 1.0;
}
    // rust: if self.emotes.camera_from.is_none() {
    // rust: return 1.0;
}
    // rust: let t = ((m.age as f32 + partial - p.start) / 5.0).clamp(0.0, 1.0);
    // rust: 0.35 + 0.65 * t * t * (3.0 - 2.0 * t)
}
}
