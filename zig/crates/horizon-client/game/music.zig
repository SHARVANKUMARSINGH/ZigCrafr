//! Transpiled from Horizon Rust crate
//! Module: horizon-client_music
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `Minecraft.getSituationalMusic` and `getMusicVolume` for the music manager,
//! the local player's ambient sound handlers and the sound engine tick.
// use super::Game;
// use horizon_client::{
    // rust: blocks::Fluid,
    // rust: music::{BackgroundMusic, Music, MusicFrequency, Situation},
    // rust: options_ui::MusicGroup,
    // rust: sound_engine::{SoundEngine, SoundInstance, Sounds, TickContext},
}

    // rust: impl Game<'_> {
    /// `Minecraft.tick` -> `MusicManager.tick`, once per client tick.
    // rust: pub(super) fn tick_music(&mut self) {
        // Splitscreen: one music, P1's.
    // rust: if self.options.split_guest {
    // rust: return;
}
    // rust: let (mut music, mut volume) = self.situational_music();
        // A native mod's own choice of track and volume, then its layers.
    // rust: self.native_music(&mut music, &mut volume);
    // rust: let mut layers = Vec::new();
    // rust: self.native_music_layers(&mut layers);
    // rust: self.music_layers.tick(&layers, &mut self.audio);
        // Options.musicFrequency's listener: MusicManager.setMinutesBetweenSongs.
    // rust: let frequency = MusicFrequency::parse(&self.settings.file.name("musicFrequency"));
    // rust: if frequency != self.music.frequency {
    // rust: self.music.set_frequency(frequency, music.as_ref());
}
        // The Music page's off tracks leave every pool they play in (the
        // extra off: nothing is filtered, vanilla's pools play as they are).
    // rust: let off = if self.settings.extras.music_page {
    // rust: &self.settings.extras.music_off[..]
    // rust: } else {
    // rust: &[][..]
}
    // rust: self.music.set_off(off);
        // LevelLoadingScreen: no new track before the player is in the world.
    // rust: let loading = self.title.is_none() && self.player.is_none() && self.win.is_none();
    // rust: self.music
    // rust: .tick(music.as_ref(), volume, loading, &mut self.audio);
        // Options.musicToast's listener: ToastManager.setMusicToastDisplayState.
    // rust: let state = self.settings.file.int("musicToast").clamp(0, 2) as u8;
    // rust: if state != self.music_toast_state {
    // rust: self.music_toast_state = state;
    // rust: self.set_music_toast_state(state);
}
        // MusicManager's showNowPlayingToast and hideNowPlayingToast calls.
    // rust: let multiplier = f64::from(self.settings.notification_display_time);
    // rust: for show in std::mem::take(&mut self.music.toast_requests) {
            // Each showing is a new toast to mods (`ToastAddEvent`).
    // rust: if show && self.now_playing.is_some() && !self.toast_allowed("now_playing", "") {
    // rust: continue;
}
    // rust: if let Some(toast) = &mut self.now_playing {
    // rust: if show {
    // rust: toast.show(multiplier);
    // rust: } else {
    // rust: toast.hide();
}
}
}
}
    /// The Music page's groups: every track the loaded `sounds.json` can play,
    /// by situation (see `music::track_groups`).
    // rust: pub(super) fn music_groups(&self) -> Vec<MusicGroup> {
    // rust: horizon_client::music::track_groups(&self.audio.engine.registry)
}
    /// A Music page row: play this track of `event` now.
    // rust: pub(super) fn play_music_track(&mut self, event: &str, track: &str) {
    // rust: self.music.play_track(event, track, &mut self.audio);
}
    /// `Options.getFinalSoundSourceVolume(SoundSource.MUSIC)`.
pub fn final_music_volume(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.settings.master_volume * self.settings.volumes[1]
}
    /// `ToastManager.setMusicToastDisplayState`: Pause and Pause and Toast make
    /// the toast (the second one shows it at once while music is audible),
    /// Never drops it.
pub fn set_music_toast_state(self: *Self, state: u8) void {
}
    // rust: self.now_playing = match state {
    // rust: 0 => None,
    // rust: _ => {
    // rust: let mut toast = horizon_client::toasts::NowPlayingToast::default();
    // rust: if state == 2
    // rust: && self.final_music_volume() > 0.0
    // rust: && self.toast_allowed("now_playing", "")
    // rust: {
    // rust: toast.show(f64::from(self.settings.notification_display_time));
}
    // rust: Some(toast)
}
}
}
    /// `NowPlayingToast.getNowPlayingString` of the song the music manager
    /// plays: its file's short language key, slashes as dots.
pub fn now_playing_song(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = self.music.current_instance()?;
    // rust: let location = self
    // rust: .audio
    // rust: .engine
    // rust: .instance(id)?
    // rust: .sound
    // rust: .as_ref()?
    // rust: .location
    // rust: .as_str();
    // rust: let (namespace, path) = location.split_once(':').unwrap_or(("minecraft", location));
        // Identifier.toShortLanguageKey.
    // rust: let key = if namespace == "minecraft" {
    // rust: path.to_owned()
    // rust: } else {
    // rust: format!("{namespace}.{path}")
}
    // rust: .replace('/', ".");
    // rust: Some(horizon_client::lang::get_or(&key, &key))
}
    /// `ToastManager.update` (it plays no toast sound for this toast) and
    /// `extractRenderState` for the Now Playing toast, which slides in at the
    /// top left over every screen but the pause screen, and
    /// `PauseScreen.extractRenderState` with its `tick`, which draws the song
    /// name on the pause menu under the Pause and Pause and Toast settings
    /// while music is audible. `hidden` (F1) keeps the toast
    /// timing out without drawing it.
    // rust: pub(super) fn draw_music_toast(
    // rust: &mut self,
    // rust: batch: &mut horizon_client::hud::HudBatch,
    // rust: hidden: bool,
    // rust: ) {
    // rust: let song = self.now_playing_song();
    // rust: let Some(toast) = self.now_playing.as_mut() else {
    // rust: return;
}
    // rust: toast.update(song.is_some(), &mut self.music_notes);
    // rust: let Some(song) = song else {
    // rust: return;
}
    // rust: if self.screen == super::Screen::Paused {
    // rust: if self.pause_menu && self.final_music_volume() > 0.0 {
    // rust: self.music_notes.tick();
    // rust: horizon_client::toasts::draw_now_playing(
    // rust: &self.gui.atlas,
    // rust: batch,
    // rust: 0.0,
    // rust: &song,
    // rust: self.music_notes.color,
    // rust: );
}
    // rust: } else if !hidden
    // rust: && self.music_toast_state == 2
    // rust: && let Some(toast) = &self.now_playing
    // rust: {
    // rust: toast.draw(&self.gui.atlas, batch, &song, &self.music_notes);
}
}
    /// `Minecraft.tick` -> `SoundManager.tick(pause)`, after the music, with
    /// `pauseAllExcept(MUSIC, UI)` when the game pauses and `resume` when it
    /// carries on.
    // rust: pub(super) fn tick_sound_engine(&mut self) {
    // rust: update_bound_entities(self.audio.engine.bound_entities(), |id| {
    // rust: self.sound_entity_state(id)
    // rust: });

    // rust: if self.pause != self.sound_paused {
    // rust: if self.pause {
    // rust: self.audio.pause();
    // rust: } else {
    // rust: self.audio.resume();
}
    // rust: self.sound_paused = self.pause;
}
    // rust: let (vehicle, carts) = self.start_cart_sounds();
    // rust: let mobs = self.start_mob_sounds();
    // rust: let ridden = self.start_riding_sound();
    // rust: let (player_position, player_speed_sqr, player_fall_flying) =
    // rust: self.player.as_ref().map_or(([0.0; 3], 0.0, false), |p| {
    // rust: let at = p.position;
    // rust: (
    // rust: [at.x, at.y, at.z],
    // rust: p.velocity.length_squared(),
    // rust: p.fall_flying,
    // rust: )
    // rust: });
        // LocalPlayer.onSyncedDataUpdated: starting to glide starts the
        // elytra's flying sound.
    // rust: if player_fall_flying && !self.was_fall_flying {
    // rust: let instance = SoundInstance::elytra(player_position, SoundEngine::unseeded());
    // rust: self.audio.play_instance(instance, false);
}
    // rust: self.was_fall_flying = player_fall_flying;
    // rust: let ctx = TickContext {
    // rust: player_underwater: self.ambience.was_underwater(),
    // rust: player_removed: self.player.is_none(),
    // rust: vehicle,
    // rust: carts,
    // rust: mobs,
    // rust: frozen: !self.clock.runs_normally(),
    // rust: player_position,
    // rust: player_speed_sqr,
    // rust: player_fall_flying,
    // rust: ridden,
}
    // rust: self.audio
    // rust: .set_listener_reserve(self.settings.extras.ui_sound_reserve);
    // rust: self.audio.tick(self.pause, &ctx);
}
    /// `Minecraft.setLevel` -> `updateLevelInEngines`: `SoundManager.stop()`.
    /// The music manager keeps its stopped track and, on its next tick, waits
    /// the level's music delay before the next one.
    // rust: pub(super) fn stop_sounds_for_new_level(&mut self) {
    // rust: self.ambience.clear(&mut self.audio);
    // rust: self.audio.stop_all();
}
    /// `getSituationalMusic` and `getMusicVolume`.
    // rust: pub(super) fn situational_music(&self) -> (Option<Music>, f32) {
    // rust: let empty = BackgroundMusic::default();
        // The title screen has no player (and no level for the camera probe).
        // A server's client has its player from handleLogin on, before the
        // first teleport makes it here: the camera is still at the origin.
    // rust: let eye = if self.title.is_some() {
    // rust: None
    // rust: } else {
    // rust: self.eye_position().or_else(|| {
    // rust: self.remote
    // rust: .as_ref()
    // rust: .is_some_and(|r| r.logged_in)
    // rust: .then_some([0.0; 3])
    // rust: })
}
    // rust: let (background, probe_volume) = match eye {
    // rust: Some(eye) => {
    // rust: let (dimension, biome) = (self.dim.id(), self.biome_at(eye));
    // rust: let tables = self.res.music();
    // rust: (
    // rust: tables.background(dimension, biome),
    // rust: tables.volume(dimension, biome),
    // rust: )
}
    // rust: None => (empty, 1.0),
}
    // rust: let situation = Situation {
            // WinScreen.getBackgroundMusic.
    // rust: screen_music: self
    // rust: .win
    // rust: .is_some()
    // rust: .then(horizon_client::music::Music::credits),
    // rust: in_world: eye.is_some(),
    // rust: in_end: self.dim == super::Dim::End,
    // rust: boss_music: self.boss_music(),
    // rust: background: &background,
    // rust: probe_volume,
    // rust: creative: self.creative,
    // rust: underwater: self.ambience.was_underwater(),
}
    // rust: (situation.music(), situation.volume())
}
    /// `BiomeManager.getNoiseBiomeAtPosition`: the quart cell holding a position.
pub fn biome_at(self: *Self, p: [f64; 3]) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (x, y, z) = (
    // rust: p[0].floor() as i32,
    // rust: p[1].floor() as i32,
    // rust: p[2].floor() as i32,
    // rust: );
    // rust: self.world
    // rust: .chunks
    // rust: .get(&(x >> 4, z >> 4))
    // rust: .map_or("minecraft:plains", |c| {
    // rust: world_biomes!(self).list[c.biome(x, y, z) as usize]
    // rust: .name
    // rust: .as_str()
    // rust: })
}
    /// `isEyeInFluid(WATER)`: the eye inside the water of its block column.
    // rust: pub(super) fn eye_in_water(&self, x: f64, eye_y: f64, z: f64) -> bool {
    // rust: let (bx, by, bz) = (x.floor() as i32, eye_y.floor() as i32, z.floor() as i32);
    // rust: let f = self.res.facts().get(self.world.block(bx, by, bz));
    // rust: if f.fluid != Fluid::Water {
    // rust: return false;
}
    // rust: let above = self.res.facts().get(self.world.block(bx, by + 1, bz));
    // rust: let height = if above.fluid == Fluid::Water {
    // rust: 1.0
    // rust: } else {
    // rust: f64::from(f.fluid_level) / 9.0
}
    // rust: eye_y <= f64::from(by) + height
}
}

    // rust: impl Game<'_> {
    /// The local player's ambient sound handlers (LocalPlayer.tick).
    // rust: pub(super) fn tick_ambience(&mut self) {
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return;
}
    // rust: let feet = [p.position.x, p.position.y, p.position.z];
    // rust: let eye_y = feet[1] + f64::from(p.dimensions.eye_height);
    // rust: let sounds = self.res.ambient().get(self.dim.id(), self.biome_at(feet));
    // rust: let underwater = self.eye_in_water(feet[0], eye_y, feet[2]);
    // rust: let world = &self.world;
    // rust: let light = |b: [i32; 3]| {
    // rust: let l = world.light(b[0], b[1], b[2]);
    // rust: (l >> 4, l & 15)
}
    // rust: let (half, height) = (
    // rust: f64::from(p.dimensions.width / 2.0),
    // rust: f64::from(p.dimensions.height),
    // rust: );
    // rust: let registry = &self.pack.assets.registry;
    // rust: let facts = self.res.facts();
    // rust: let bubble_column = horizon_client::ambience::bubble_column_in(
    // rust: [
    // rust: feet[0] - half,
    // rust: feet[1],
    // rust: feet[2] - half,
    // rust: feet[0] + half,
    // rust: feet[1] + height,
    // rust: feet[2] + half,
    // rust: ],
    // rust: |b| {
    // rust: let state = world.block(b[0], b[1], b[2]);
    // rust: (&*facts.get(state).name == "minecraft:bubble_column").then(|| {
    // rust: registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get("drag"))
    // rust: .is_some_and(|d| d == "true")
    // rust: })
    // rust: },
    // rust: );
    // rust: let ctx = horizon_client::ambience::AmbientContext {
    // rust: sounds: &sounds,
    // rust: position: feet,
    // rust: eye_y,
    // rust: underwater,
    // rust: spectator: self.spectator(),
    // rust: light: &light,
    // rust: bubble_column,
}
    // rust: self.ambience.tick(&ctx, &mut self.audio);
}
}

/// Resolve each live entity once per sound tick, even when several sounds name it.
    // rust: fn update_bound_entities(
    // rust: entities: Vec<horizon_client::sound_engine::SoundEntity>,
    // rust: mut resolve: impl FnMut(u32) -> Option<horizon_client::sound_engine::SoundEntityState>,
    // rust: ) {
//     use horizon_client::sound_engine::SoundEntityState;
    // rust: let mut states = std::collections::HashMap::new();
    // rust: for entity in entities {
    // rust: let previous = entity.state();
    // rust: if previous.removed {
    // rust: continue;
}
    // rust: let state = *states
    // rust: .entry(entity.id)
    // rust: .or_insert_with(|| resolve(entity.id));
    // rust: entity.update(state.unwrap_or(SoundEntityState {
    // rust: removed: true,
    // rust: ..previous
    // rust: }));
}
}

    // rust: mod bound_lookup_tests {
//     use super::update_bound_entities;
//     use horizon_client::sound_engine::{SoundEntity, SoundEntityState};

pub fn simultaneous_sounds_share_a_lookup_but_follow_each_new_tick() void {
}
    // rust: let a = SoundEntity::new(7, [0.0; 3], false);
    // rust: let b = SoundEntity::new(7, [1.0; 3], false);
    // rust: let mut calls = Vec::new();
    // rust: for position in [[24.0, 80.0, -16.0], [25.5, 81.0, -18.0]] {
    // rust: update_bound_entities(vec![a.clone(), b.clone()], |id| {
    // rust: calls.push(id);
    // rust: Some(SoundEntityState {
    // rust: position,
    // rust: silent: true,
    // rust: removed: false,
    // rust: })
    // rust: });
    // rust: assert_eq!(a.state().position, position);
    // rust: assert_eq!(b.state().position, position);
    // rust: assert!(a.state().silent && b.state().silent);
}
    // rust: assert_eq!(calls, vec![7, 7]);
}

pub fn missing_entities_stop_all_their_sounds_without_reviving_reused_ids() void {
}
    // rust: let a = SoundEntity::new(7, [1.0; 3], false);
    // rust: let b = SoundEntity::new(7, [2.0; 3], false);
    // rust: let mut calls = 0;
    // rust: update_bound_entities(vec![a.clone(), b.clone()], |_| {
    // rust: calls += 1;
    // rust: None
    // rust: });
    // rust: assert_eq!(calls, 1);
    // rust: assert!(a.state().removed && b.state().removed);
    // rust: let replacement = SoundEntity::new(7, [3.0; 3], false);
    // rust: update_bound_entities(vec![a.clone(), replacement.clone(), b.clone()], |_| {
    // rust: calls += 1;
    // rust: Some(SoundEntityState {
    // rust: position: [4.0; 3],
    // rust: silent: false,
    // rust: removed: false,
    // rust: })
    // rust: });
    // rust: assert_eq!(calls, 2);
    // rust: assert!(a.state().removed && b.state().removed);
    // rust: assert_eq!(a.state().position, [1.0; 3]);
    // rust: assert_eq!(replacement.state().position, [4.0; 3]);
    // rust: assert!(!replacement.state().removed);
}
}
