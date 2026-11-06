//! Transpiled from Horizon Rust crate
//! Module: horizon-client_music
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Situational music: `MusicManager.tick` choosing tracks from
//! `Minecraft.getSituationalMusic`, with the `minecraft:audio/background_music`
//! and `minecraft:audio/music_volume` environment attributes of dimension
//! types and biomes (a biome value overrides its dimension's).
// use crate::options_ui::{MusicGroup, MusicTrack};
// use crate::sound_engine::{InstanceId, MUSIC, PlayResult, SoundEngine, SoundInstance, Sounds};
// use crate::sound_events::{Sentinel, SoundRegistry};
// use horizon_core::random::{LegacyRandom, RandomSource};
// use serde_json::Value;
// use std::{
    // rust: collections::{BTreeMap, HashMap},
    // rust: fs,
    // rust: path::Path,
}

/// `Music`: a sound event and the delay range (ticks) before it starts.
pub const Music = struct {
    sound: []const u8,
    min_delay: i32,
    max_delay: i32,
    replace_current_music: bool,
};
    // rust: impl Music {
pub fn new(sound: []const u8, min_delay: i32, max_delay: i32, replace_current_music: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: sound: sound.to_owned(),
    // rust: min_delay,
    // rust: max_delay,
    // rust: replace_current_music,
}
}
    /// `Musics.MENU`.
pub fn menu() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new("minecraft:music.menu", 20, 600, true)
}
    /// `Musics.CREDITS`.
pub fn credits() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new("minecraft:music.credits", 0, 0, true)
}
    /// `Musics.END_BOSS`.
pub fn end_boss() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new("minecraft:music.dragon", 0, 0, true)
}
    /// `Musics.CREATIVE`.
pub fn creative() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new("minecraft:music.creative", 12000, 24000, false)
}
    /// `Musics.END`.
pub fn end() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new("minecraft:music.end", 6000, 24000, true)
}
    /// `Musics.UNDER_WATER`.
pub fn under_water() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new("minecraft:music.under_water", 12000, 24000, false)
}
    /// `Musics.GAME`.
pub fn game() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new("minecraft:music.game", 12000, 24000, false)
}
    /// The built-in situations the Music page lists, in its order: the lang key
    /// of the heading the page's group shows and the music that situation plays.
pub fn builtin() [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [
    // rust: ("horizon.pages.music.menu", Self::menu()),
    // rust: ("horizon.pages.music.overworld", Self::game()),
    // rust: ("horizon.pages.music.creative", Self::creative()),
    // rust: ("horizon.pages.music.underwater", Self::under_water()),
    // rust: ("horizon.pages.music.end", Self::end()),
    // rust: ("horizon.pages.music.boss", Self::end_boss()),
    // rust: ("horizon.pages.music.credits", Self::credits()),
    // rust: ]
}
    /// `Music.CODEC`.
pub fn parse(v: *Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let sound = v["sound"].as_str()?;
    // rust: let int = |k: &str| v[k].as_i64().unwrap_or(0) as i32;
    // rust: Some(Self::new(
    // rust: sound,
    // rust: int("min_delay"),
    // rust: int("max_delay"),
    // rust: v["replace_current_music"].as_bool().unwrap_or(false),
    // rust: ))
}
}
/// The Music page's groups: each built-in situation's own tracks first, then
/// every other `music.` event's tracks that no earlier group listed, under
/// its dimension's biomes. A track several pools share is listed once, from
/// the first pool that names it, so "play now" always has a pool that plays
/// it and no track is left without a row.
pub fn track_groups(registry: *SoundRegistry) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut groups: Vec<MusicGroup> = Vec::new();
    // rust: let mut listed: Vec<String> = Vec::new();
    // rust: let builtin = Music::builtin();
    // rust: for (label, music) in &builtin {
    // rust: let tracks = registry.tracks(&music.sound);
    // rust: if tracks.is_empty() {
    // rust: continue;
}
    // rust: listed.extend(tracks.iter().cloned());
    // rust: groups.push(MusicGroup {
    // rust: label: (*label).to_owned(),
    // rust: tracks: tracks
    // rust: .into_iter()
    // rust: .map(|id| MusicTrack {
    // rust: event: music.sound.clone(),
    // rust: id,
    // rust: })
    // rust: .collect(),
    // rust: });
}
    // `music_disc.*` (records) do not start with "music.".
    // rust: let mut events: Vec<&String> = registry
    // rust: .names()
    // rust: .filter(|event| event.starts_with("minecraft:music."))
    // rust: .collect();
    // rust: events.sort();
    // Keyed by the heading's rank, so the dimensions keep their order however
    // the event ids sort.
    // rust: let mut rest: BTreeMap<u8, (&'static str, Vec<MusicTrack>)> = BTreeMap::new();
    // rust: for event in events {
    // rust: if builtin.iter().any(|(_, music)| music.sound == *event) {
    // rust: continue;
}
    // rust: let tracks: Vec<MusicTrack> = registry
    // rust: .tracks(event)
    // rust: .into_iter()
    // rust: .filter(|id| !listed.contains(id))
    // rust: .map(|id| MusicTrack {
    // rust: event: event.clone(),
    // rust: id,
    // rust: })
    // rust: .collect();
    // rust: if tracks.is_empty() {
    // rust: continue;
}
    // rust: listed.extend(tracks.iter().map(|track| track.id.clone()));
    // rust: let (rank, label) = biome_group(event);
    // rust: rest.entry(rank)
    // rust: .or_insert_with(|| (label, Vec::new()))
    // rust: .1
    // rust: .extend(tracks);
}
    // rust: groups.extend(rest.into_values().map(|(label, tracks)| MusicGroup {
    // rust: label: label.to_owned(),
    // rust: tracks,
    // rust: }));
    // rust: groups
}
/// The heading a biome-only pool's tracks go under: vanilla plays these
/// tracks in several biomes, so no heading names a single one.
pub fn biome_group(event: []const u8) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let path = event.strip_prefix("minecraft:").unwrap_or(event);
    // rust: if path.starts_with("music.overworld.") {
    // rust: (1, "horizon.pages.music.overworld_biomes")
    // rust: } else if path.starts_with("music.nether.") {
    // rust: (2, "horizon.pages.music.nether_biomes")
    // rust: } else if path.starts_with("music.end.") {
    // rust: (3, "horizon.pages.music.end_biomes")
    // rust: } else {
    // rust: (4, "horizon.pages.music.other")
}
}
pub const BackgroundMusic = struct {
    default: ?Music,
    creative: ?Music,
    underwater: ?Music,
};
    // rust: impl BackgroundMusic {
pub fn parse(v: *Value) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: default: Music::parse(&v["default"]),
    // rust: creative: Music::parse(&v["creative"]),
    // rust: underwater: Music::parse(&v["underwater"]),
}
}
    /// `BackgroundMusic.select`.
pub fn select(self: *Self, creative: bool, underwater: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if underwater && self.underwater.is_some() {
    // rust: self.underwater.as_ref()
    // rust: } else if creative && self.creative.is_some() {
    // rust: self.creative.as_ref()
    // rust: } else {
    // rust: self.default.as_ref()
}
}
}
pub const Layer = struct {
    music: ?BackgroundMusic,
    volume: ?f32,
};
    // rust: impl Layer {
pub fn parse(json: *Value) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let attributes = &json["attributes"];
    // rust: let music = &attributes["minecraft:audio/background_music"];
    // rust: Self {
    // rust: music: (!music.is_null()).then(|| BackgroundMusic::parse(music)),
    // rust: volume: attributes["minecraft:audio/music_volume"]
    // rust: .as_f64()
    // rust: .map(|v| v.clamp(0.0, 1.0) as f32),
}
}
}
/// What `Minecraft.getSituationalMusic` and `getMusicVolume` read.
pub const Situation = struct {
    /// `Screen.getBackgroundMusic` of the open screen.
    screen_music: ?Music,
    /// `Minecraft.player != null`.
    in_world: bool,
    /// The player's level is the End.
    in_end: bool,
    /// `BossHealthOverlay.shouldPlayMusic`: a boss bar asks for music.
    boss_music: bool,
    /// `BACKGROUND_MUSIC` at the camera.
    background: *'a BackgroundMusic,
    /// `MUSIC_VOLUME` at the camera (1 without a level).
    probe_volume: f32,
    /// `abilities.instabuild && abilities.mayfly`.
    creative: bool,
    /// `LocalPlayer.isUnderWater`.
    underwater: bool,
};
    // rust: impl Situation<'_> {
    /// `Minecraft.getSituationalMusic`.
pub fn music(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(music) = &self.screen_music {
    // rust: return Some(music.clone());
}
    // rust: if !self.in_world {
    // rust: return Some(Music::menu());
}
    // rust: if self.in_end && self.boss_music {
    // rust: return Some(Music::end_boss());
}
    // rust: self.background
    // rust: .select(self.creative, self.underwater)
    // rust: .cloned()
}
    /// `Minecraft.getMusicVolume`.
pub fn volume(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.screen_music.is_some() {
    // rust: 1.0
    // rust: } else {
    // rust: self.probe_volume
}
}
}
/// Music attributes by dimension type and biome.
pub const MusicTables = struct {
    dimensions: HashMap<[]const u8,
    biomes: HashMap<[]const u8,
};
    // rust: impl MusicTables {
pub fn load(root: *Path) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let read = |dir: &str| -> HashMap<String, Layer> {
    // rust: let Ok(entries) = fs::read_dir(root.join("data/minecraft").join(dir)) else {
    // rust: return HashMap::new();
}
    // rust: entries
    // rust: .flatten()
    // rust: .filter_map(|e| {
    // rust: let path = e.path();
    // rust: let name = path.file_stem()?.to_str()?.to_owned();
    // rust: let json: Value = serde_json::from_slice(&fs::read(&path).ok()?).ok()?;
    // rust: Some((format!("minecraft:{name}"), Layer::parse(&json)))
    // rust: })
    // rust: .collect()
}
    // rust: Self {
    // rust: dimensions: read("dimension_type"),
    // rust: biomes: read("worldgen/biome"),
}
}
    /// `EnvironmentAttributes.BACKGROUND_MUSIC` at a position.
pub fn background(self: *Self, dimension: []const u8, biome: []const u8) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.biomes
    // rust: .get(biome)
    // rust: .and_then(|l| l.music.clone())
    // rust: .or_else(|| self.dimensions.get(dimension).and_then(|l| l.music.clone()))
    // rust: .unwrap_or_default()
}
    /// `EnvironmentAttributes.MUSIC_VOLUME` at a position (default 1).
pub fn volume(self: *Self, dimension: []const u8, biome: []const u8) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.biomes
    // rust: .get(biome)
    // rust: .and_then(|l| l.volume)
    // rust: .or_else(|| self.dimensions.get(dimension).and_then(|l| l.volume))
    // rust: .unwrap_or(1.0)
}
}
/// `MusicManager.MusicFrequency` (the `musicFrequency` option).
pub const MusicFrequency = enum {
    Default,
    Frequent,
    Constant,
};
    // rust: impl MusicFrequency {
pub fn parse(name: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match name {
    // rust: "FREQUENT" => Self::Frequent,
    // rust: "CONSTANT" => Self::Constant,
    // rust: _ => Self::Default,
}
}
pub fn max_frequency(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Default => 20 * 1200,
    // rust: Self::Frequent => 10 * 1200,
    // rust: Self::Constant => 0,
}
}
pub fn next_song_delay(self: *Self, music: ?*Music, random: *mut LegacyRandom) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(music) = music else {
    // rust: return self.max_frequency();
}
    // rust: if self == Self::Constant {
    // rust: return 100;
}
    // rust: let min = music.min_delay.min(self.max_frequency());
    // rust: let max = music.max_delay.min(self.max_frequency());
    // rust: next_int(random, min, max)
}
}
/// `Mth.nextInt(random, min, max)`: inclusive.
pub fn next_int(random: *mut LegacyRandom, min: i32, max: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if min >= max {
    // rust: min
    // rust: } else {
    // rust: random.next_int_bound(max - min + 1).unwrap_or(0) + min
}
}
/// A track a native mod plays over or instead of the music
/// (`native_music_layers`): a sound event and its volume, 0 to 1.
pub const MusicLayer = struct {
    sound: []const u8,
    volume: f32,
};

/// The layers playing: each a looping music-source instance whose volume
/// eases toward the one its mod asks for, by [`MusicLayers::FADE`] a tick.
/// A layer asked for again after it faded out starts from its beginning.
pub const MusicLayers = struct {
    playing: std.ArrayList(PlayingLayer),
};
pub const PlayingLayer = struct {
    sound: []const u8,
    id: InstanceId,
    gain: f32,
    target: f32,
    /// The engine has played it: once it isn't active any more (a new level
    /// stopped every sound), the layer starts again.
    heard: bool,
};
    // rust: impl MusicLayers {
    /// The volume a layer moves by in a tick: two seconds from silent to full.
pub const FADE: f32 = 0.025;
    /// One client tick with the layers `wanted` (the last of a sound counts).
    /// Layers new this tick start together, silent, so stems listed at once
    /// stay in step.
pub fn tick(self: *Self, wanted: *[MusicLayer], sounds: *mut impl Sounds) void {
}
    // rust: let target = |sound: &str| {
    // rust: wanted
    // rust: .iter()
    // rust: .rev()
    // rust: .find(|w| w.sound == sound)
    // rust: .map_or(0.0, |w| {
    // rust: if w.volume.is_finite() {
    // rust: w.volume.clamp(0.0, 1.0)
    // rust: } else {
    // rust: 0.0
}
    // rust: })
}
    // rust: self.playing.retain(|l| {
    // rust: let active = sounds.is_active(l.id);
    // rust: if l.heard && !active {
    // rust: sounds.release(l.id);
    // rust: return false;
}
    // rust: true
    // rust: });
    // rust: for w in wanted {
    // rust: if w.sound.is_empty() || self.playing.iter().any(|l| l.sound == w.sound) {
    // rust: continue;
}
    // rust: let instance = SoundInstance::for_music_layer(&w.sound, SoundEngine::unseeded());
    // rust: let (id, _) = sounds.play_instance(instance, true);
    // rust: self.playing.push(PlayingLayer {
    // rust: sound: w.sound.clone(),
    // rust: id,
    // rust: gain: 0.0,
    // rust: target: 0.0,
    // rust: heard: false,
    // rust: });
}
    // rust: self.playing.retain_mut(|l| {
    // rust: l.target = target(&l.sound);
    // rust: l.gain = if l.gain < l.target {
    // rust: (l.gain + Self::FADE).min(l.target)
    // rust: } else {
    // rust: (l.gain - Self::FADE).max(l.target)
}
            // Float steps land a hair off the target.
    // rust: if (l.gain - l.target).abs() < 1.0E-4 {
    // rust: l.gain = l.target;
}
    // rust: l.heard |= sounds.is_active(l.id);
    // rust: if l.gain <= 0.0 && l.target <= 0.0 && !wanted.iter().any(|w| w.sound == l.sound) {
    // rust: sounds.stop_instance(l.id);
    // rust: sounds.release(l.id);
    // rust: return false;
}
    // rust: if let Some(instance) = sounds.engine().instance_mut(l.id) {
    // rust: instance.volume = l.gain;
}
    // rust: true
    // rust: });
}
    /// The sound events playing and each one's volume now.
pub fn playing(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.playing.iter().map(|l| (l.sound.as_str(), l.gain))
}
}

/// `MusicManager`.
pub const MusicManager = struct {
    random: LegacyRandom,
    /// `currentMusic`: the instance the manager holds.
    current: ?InstanceId,
    current_gain: f32,
    next_song_delay: i32,
    toast_shown: bool,
    /// The built-in tracks the Music page turned off (sound ids): every pool
    /// picks around them.
    off: std.ArrayList([]const u8),
    /// `current` was started by the Music page's "play now", not by the
    /// situation: its own music waits for it to end.
    forced: bool,
    frequency: MusicFrequency,
    /// `ToastManager.showNowPlayingToast` (true) / `hideNowPlayingToast`
    /// (false) calls since the last drain.
    toast_requests: std.ArrayList(bool),
};
    // rust: impl Default for MusicManager {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
        // RandomSource.create(): seeded from the clock, not the world.
    // rust: Self::new(crate::sound_engine::unique_seed())
}
}
    // rust: impl MusicManager {
pub fn new(seed: i64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: random: LegacyRandom::new(seed),
    // rust: current: None,
    // rust: current_gain: 1.0,
    // rust: next_song_delay: 100,
    // rust: toast_shown: false,
    // rust: off: Vec::new(),
    // rust: forced: false,
    // rust: frequency: MusicFrequency::Default,
    // rust: toast_requests: Vec::new(),
}
}
    /// The sound event of the current track.
    // rust: pub fn current<'a>(&self, sounds: &'a SoundEngine) -> Option<&'a str> {
    // rust: self.current
    // rust: .and_then(|id| sounds.instance(id))
    // rust: .map(|i| i.identifier.as_str())
}
pub fn current_instance(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.current
}
pub fn next_song_delay(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.next_song_delay
}
pub fn current_gain(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.current_gain
}
pub fn toast_shown(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.toast_shown
}
pub fn set_current(self: *Self, id: ?InstanceId, sounds: *mut impl Sounds) void {
}
    // rust: if let Some(old) = self.current
    // rust: && Some(old) != id
    // rust: {
    // rust: sounds.release(old);
}
    // rust: self.current = id;
    // rust: if id.is_none() {
    // rust: self.forced = false;
}
}
    /// The tracks the Music page turned off: each pool picks around them, so a
    /// situation whose tracks are all off plays nothing.
pub fn set_off(self: *Self, tracks: *[[]const u8]) void {
}
    // rust: if self.off != tracks {
    // rust: self.off = tracks.to_vec();
}
}
    /// `MusicManager.tick` with `Minecraft.getMusicVolume` and
    /// `getSituationalMusic`; `loading` is a `LevelLoadingScreen`.
    // rust: pub fn tick(
    // rust: &mut self,
    // rust: music: Option<&Music>,
    // rust: volume: f32,
    // rust: loading: bool,
    // rust: sounds: &mut impl Sounds,
    // rust: ) {
    // rust: if self.current.is_some()
    // rust: && self.current_gain != volume
    // rust: && !self.fade(volume, music, sounds)
    // rust: {
    // rust: return;
}
    // rust: let Some(music) = music else {
    // rust: self.next_song_delay = self.next_song_delay.max(100);
    // rust: return;
}
    // rust: if let Some(current) = self.current {
            // canReplace
    // rust: let playing = sounds
    // rust: .engine()
    // rust: .instance(current)
    // rust: .map(|i| i.identifier.clone());
    // rust: if music.replace_current_music
    // rust: && !self.forced
    // rust: && playing.as_deref() != Some(music.sound.as_str())
    // rust: {
    // rust: sounds.stop_instance(current);
    // rust: self.next_song_delay = next_int(&mut self.random, 0, music.min_delay / 2);
}
    // rust: if !sounds.is_active(current) {
    // rust: self.set_current(None, sounds);
    // rust: let delay = self
    // rust: .frequency
    // rust: .next_song_delay(Some(music), &mut self.random);
    // rust: self.next_song_delay = self.next_song_delay.min(delay);
}
}
    // rust: self.next_song_delay = self.next_song_delay.min(music.max_delay);
    // rust: if self.current.is_none() && !loading {
    // rust: self.next_song_delay -= 1;
    // rust: if self.next_song_delay <= 0 {
    // rust: self.start_playing(music, sounds);
}
}
}
    /// `MusicManager.startPlaying`, with the Music page's off tracks left out
    /// of the pool.
pub fn start_playing(self: *Self, music: *Music, sounds: *mut impl Sounds) void {
}
    // rust: self.start_playing_with(music, None, sounds);
}
    /// Play one track of `event` now (a Music page row): it takes the
    /// manager's slot, and the situation's own music waits until it ends.
    /// False when the event has no such track.
pub fn play_track(self: *Self, event: []const u8, track: []const u8, sounds: *mut impl Sounds) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let music = Music::new(event, 0, 0, true);
    // rust: self.start_playing_with(&music, Some(track), sounds)
}
    /// `MusicManager.startPlaying`, choosing the concrete sound with `only`
    /// (that track alone) or else `off` left out.
    // rust: fn start_playing_with(
    // rust: &mut self,
    // rust: music: &Music,
    // rust: only: Option<&str>,
    // rust: sounds: &mut impl Sounds,
    // rust: ) -> bool {
    // rust: let mut instance = SoundInstance::for_music(&music.sound, SoundEngine::unseeded());
        // No track off and no row to play: vanilla's startPlaying as it is.
        // `resolve` picks the track, and an event with nothing to play (or no
        // event) is still the current music, with the delay at its maximum.
    // rust: if only.is_none() && self.off.is_empty() {
    // rust: return self.play_current(instance, only, sounds);
}
        // The event's own random picks the track, as `resolve` would.
    // rust: let mut random = instance.random.clone();
    // rust: let sound = sounds
    // rust: .engine()
    // rust: .registry
    // rust: .sound_except(&music.sound, &mut random, &|id| match only {
    // rust: Some(track) => id != track,
                // A row's On/Off is per track, everywhere it plays.
    // rust: None => self.off.iter().any(|off| off == id),
    // rust: });
    // rust: instance.random = random;
    // rust: let Some(sound) = sound.filter(|s| s.sentinel == Sentinel::None) else {
            // Nothing left to play (every track of the situation is off, or
            // the event is unknown): retry after a normal delay, so turning
            // a track back on is heard without reloading the music.
    // rust: if only.is_none() {
    // rust: self.next_song_delay = self
    // rust: .frequency
    // rust: .next_song_delay(Some(music), &mut self.random);
}
    // rust: return false;
}
        // The manager resolved the sound itself; `resolve` keeps it.
    // rust: instance.sound = Some(sound);
    // rust: instance.event = Some(None);
    // rust: instance.chosen = true;
    // rust: self.play_current(instance, only, sounds)
}
    /// The rest of `MusicManager.startPlaying`: play `instance` as the current
    /// music (a Music page row replaces the track already playing).
    // rust: fn play_current(
    // rust: &mut self,
    // rust: instance: SoundInstance,
    // rust: only: Option<&str>,
    // rust: sounds: &mut impl Sounds,
    // rust: ) -> bool {
        // "Play now" takes the manager's slot: the track already playing stops
        // (a situation's own track is replaced by `set_current` below).
    // rust: if only.is_some()
    // rust: && let Some(current) = self.current
    // rust: {
    // rust: sounds.stop_instance(current);
    // rust: self.set_current(None, sounds);
}
    // rust: let (id, result) = sounds.play_instance(instance, true);
    // rust: self.set_current(Some(id), sounds);
    // rust: self.forced = only.is_some();
    // rust: match result {
    // rust: PlayResult::Started => {
    // rust: self.toast_requests.push(true);
    // rust: self.toast_shown = true;
}
    // rust: PlayResult::StartedSilently => self.toast_shown = false,
    // rust: PlayResult::NotStarted => {}
}
    // rust: self.next_song_delay = i32::MAX;
    // rust: true
}
    /// `MusicManager.showNowPlayingToastIfNeeded`.
pub fn show_now_playing_toast_if_needed(self: *Self) void {
}
    // rust: if !self.toast_shown {
    // rust: self.toast_requests.push(true);
    // rust: self.toast_shown = true;
}
}
    /// `MusicManager.stopPlaying(Music)`.
    // rust: pub fn stop_playing_music(
    // rust: &mut self,
    // rust: music: &Music,
    // rust: situational: Option<&Music>,
    // rust: sounds: &mut impl Sounds,
    // rust: ) {
    // rust: if self.is_playing_music(music, sounds.engine()) {
    // rust: self.stop_playing(situational, sounds);
}
}
    /// `MusicManager.stopPlaying()`.
pub fn stop_playing(self: *Self, situational: ?*Music, sounds: *mut impl Sounds) void {
}
    // rust: if let Some(current) = self.current {
    // rust: sounds.stop_instance(current);
    // rust: self.set_current(None, sounds);
    // rust: self.toast_requests.push(false);
}
    // rust: self.next_song_delay = self
    // rust: .frequency
    // rust: .next_song_delay(situational, &mut self.random)
    // rust: + 100;
}
    /// `MusicManager.isPlayingMusic`.
pub fn is_playing_music(self: *Self, music: *Music, sounds: *SoundEngine) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.current(sounds) == Some(music.sound.as_str())
}
    /// `MusicManager.setMinutesBetweenSongs`.
pub fn set_frequency(self: *Self, frequency: MusicFrequency, situational: ?*Music) void {
}
    // rust: self.frequency = frequency;
    // rust: self.next_song_delay = self
    // rust: .frequency
    // rust: .next_song_delay(situational, &mut self.random);
}
    /// `MusicManager.fadePlaying`: false once the track faded out and stopped.
pub fn fade(self: *Self, volume: f32, situational: ?*Music, sounds: *mut impl Sounds) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.current.is_none() {
    // rust: return false;
}
    // rust: if self.current_gain == volume {
    // rust: return true;
}
    // rust: if self.current_gain < volume {
    // rust: self.current_gain += self.current_gain.clamp(5.0E-4, 0.005);
    // rust: if self.current_gain > volume {
    // rust: self.current_gain = volume;
}
    // rust: } else {
    // rust: self.current_gain = 0.03 * volume + 0.97 * self.current_gain;
    // rust: if (self.current_gain - volume).abs() < 1.0E-4 || self.current_gain < volume {
    // rust: self.current_gain = volume;
}
}
    // rust: self.current_gain = self.current_gain.clamp(0.0, 1.0);
    // rust: if self.current_gain <= 1.0E-4 {
    // rust: self.stop_playing(situational, sounds);
    // rust: false
    // rust: } else {
    // rust: sounds.update_category_volume(MUSIC, self.current_gain);
    // rust: true
}
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::sound_engine::{Bound, test_backend::Null};
//     use crate::sound_events::SoundRegistry;

pub fn engine() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut registry = SoundRegistry::default();
    // rust: registry.add_file(
    // rust: "minecraft",
    // rust: br#"{"music.menu": {"sounds": [{"name": "m", "stream": true}]},
    // rust: "music.game": {"sounds": [{"name": "g", "stream": true}]},
    // rust: "music.end": {"sounds": [{"name": "e", "stream": true}]}}"#,
    // rust: &|_, _| true,
    // rust: );
    // rust: SoundEngine::new(registry)
}

pub fn layer(sound: []const u8, volume: f32) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MusicLayer {
    // rust: sound: sound.to_owned(),
    // rust: volume,
}
}

pub fn layers_fade_in_together_follow_their_volume_and_fade_out() void {
}
    // rust: let (mut engine, mut backend) = (engine(), Null::default());
    // rust: let mut layers = MusicLayers::default();
    // rust: let mut tick = |layers: &mut MusicLayers, wanted: &[MusicLayer]| {
    // rust: layers.tick(
    // rust: wanted,
    // rust: &mut Bound {
    // rust: engine: &mut engine,
    // rust: backend: &mut backend,
    // rust: },
    // rust: );
}
    // rust: let playing = |layers: &MusicLayers| -> Vec<(String, f32)> {
    // rust: layers
    // rust: .playing()
    // rust: .map(|(s, g)| (s.to_owned(), (g * 1000.0).round() / 1000.0))
    // rust: .collect()
}
        // Two stems, one silent: both start in the same tick.
    // rust: let both = [
    // rust: layer("minecraft:music.game", 1.0),
    // rust: layer("minecraft:music.end", 0.0),
    // rust: ];
    // rust: tick(&mut layers, &both);
    // rust: assert_eq!(
    // rust: playing(&layers),
    // rust: [
    // rust: ("minecraft:music.game".into(), 0.025),
    // rust: ("minecraft:music.end".into(), 0.0)
    // rust: ]
    // rust: );
    // rust: for _ in 0..50 {
    // rust: tick(&mut layers, &both);
}
    // rust: assert_eq!(playing(&layers)[0].1, 1.0);
        // The second stem rises toward its new volume, by FADE a tick.
    // rust: let fuller = [
    // rust: layer("minecraft:music.game", 1.0),
    // rust: layer("minecraft:music.end", 0.5),
    // rust: ];
    // rust: for _ in 0..10 {
    // rust: tick(&mut layers, &fuller);
}
    // rust: assert_eq!(playing(&layers)[1].1, 0.25);
        // A layer left out fades out, then stops.
    // rust: let one = [layer("minecraft:music.end", 0.5)];
    // rust: for _ in 0..39 {
    // rust: tick(&mut layers, &one);
}
    // rust: assert_eq!(playing(&layers).len(), 2);
    // rust: tick(&mut layers, &one);
    // rust: assert_eq!(playing(&layers), [("minecraft:music.end".into(), 0.5)]);
}

pub fn layer_volumes_out_of_range_are_clamped() void {
}
    // rust: let (mut engine, mut backend) = (engine(), Null::default());
    // rust: let mut layers = MusicLayers::default();
    // rust: for volume in [7.0, f32::NAN] {
    // rust: for _ in 0..60 {
    // rust: layers.tick(
    // rust: &[layer("minecraft:music.game", volume)],
    // rust: &mut Bound {
    // rust: engine: &mut engine,
    // rust: backend: &mut backend,
    // rust: },
    // rust: );
}
    // rust: let gain = layers.playing().next().map(|(_, g)| g);
    // rust: assert_eq!(gain, Some(if volume.is_nan() { 0.0 } else { 1.0 }));
}
}

pub fn menu_music_starts_within_its_delay_and_game_music_replaces_nothing() void {
}
    // rust: let (mut engine, mut backend) = (engine(), Null::default());
    // rust: let mut m = MusicManager::new(1);
    // rust: let menu = Music::menu();
    // rust: let tick =
    // rust: |m: &mut MusicManager, music: &Music, engine: &mut SoundEngine, backend: &mut Null| {
    // rust: m.tick(Some(music), 1.0, false, &mut Bound { engine, backend });
}
        // nextSongDelay starts at 100, capped to MENU's max delay 600: starts on tick 100.
    // rust: for _ in 0..99 {
    // rust: tick(&mut m, &menu, &mut engine, &mut backend);
}
    // rust: assert!(m.current(&engine).is_none());
    // rust: tick(&mut m, &menu, &mut engine, &mut backend);
    // rust: assert_eq!(m.current(&engine), Some("minecraft:music.menu"));
        // Game music does not replace the current track.
    // rust: let game = Music::new("minecraft:music.game", 12000, 24000, false);
    // rust: tick(&mut m, &game, &mut engine, &mut backend);
    // rust: assert_eq!(m.current(&engine), Some("minecraft:music.menu"));
}

pub fn a_new_level_stops_menu_music_and_waits_for_game_music() void {
}
    // rust: let (mut engine, mut backend) = (engine(), Null::default());
    // rust: let mut m = MusicManager::new(2);
    // rust: let menu = Music::menu();
    // rust: m.start_playing(
    // rust: &menu,
    // rust: &mut Bound {
    // rust: engine: &mut engine,
    // rust: backend: &mut backend,
    // rust: },
    // rust: );
        // Minecraft.setLevel -> SoundManager.stop(); the next tick has a player.
    // rust: engine.stop_all(&mut backend);
    // rust: let game = Music::game();
    // rust: m.tick(
    // rust: Some(&game),
    // rust: 1.0,
    // rust: true,
    // rust: &mut Bound {
    // rust: engine: &mut engine,
    // rust: backend: &mut backend,
    // rust: },
    // rust: );
    // rust: assert!(m.current_instance().is_none());
    // rust: assert!((12000..=24000).contains(&m.next_song_delay()));
}

pub fn zero_music_volume_fades_out_and_stops() void {
}
    // rust: let (mut engine, mut backend) = (engine(), Null::default());
    // rust: let mut m = MusicManager::new(3);
    // rust: let game = Music::new("minecraft:music.game", 12000, 24000, false);
    // rust: m.start_playing(
    // rust: &game,
    // rust: &mut Bound {
    // rust: engine: &mut engine,
    // rust: backend: &mut backend,
    // rust: },
    // rust: );
    // rust: let mut ticks = 0;
    // rust: while m.current_instance().is_some() && ticks < 1000 {
    // rust: m.tick(
    // rust: Some(&game),
    // rust: 0.0,
    // rust: false,
    // rust: &mut Bound {
    // rust: engine: &mut engine,
    // rust: backend: &mut backend,
    // rust: },
    // rust: );
    // rust: ticks += 1;
}
        // 0.97^n < 1e-4 after ~303 ticks.
    // rust: assert!((290..=310).contains(&ticks), "{ticks}");
}

pub fn select_prefers_underwater_then_creative() void {
}
    // rust: let bg = BackgroundMusic {
    // rust: default: Some(Music::new("a", 0, 0, false)),
    // rust: creative: Some(Music::new("b", 0, 0, false)),
    // rust: underwater: Some(Music::new("c", 0, 0, false)),
}
    // rust: assert_eq!(bg.select(true, true).unwrap().sound, "c");
    // rust: assert_eq!(bg.select(true, false).unwrap().sound, "b");
    // rust: assert_eq!(bg.select(false, false).unwrap().sound, "a");
}

pub fn the_music_page_lists_every_track_once_from_a_pool_that_plays_it() void {
}
    // rust: let mut registry = SoundRegistry::default();
    // rust: registry.add_file(
    // rust: "minecraft",
    // rust: br#"{
    // rust: "music.game": {"sounds": ["music/game/shared", "music/game/second"]},
    // rust: "music.menu": {"sounds": ["music/menu/one"]},
    // rust: "music.overworld.forest": {"sounds": ["music/game/shared", "music/game/bromeliad"]},
    // rust: "music.overworld.swamp": {"sounds": ["music/game/bromeliad", "music/game/aerie"]},
    // rust: "music.nether.warped_forest": {"sounds": ["music/game/rubedo"]},
    // rust: "music_disc.cat": {"sounds": ["records/cat"]},
    // rust: "note": {"sounds": ["block/note/harp"]}
    // rust: }"#,
    // rust: &|_, _| true,
    // rust: );
    // rust: let groups = track_groups(&registry);
    // rust: let summary: Vec<(&str, Vec<&str>)> = groups
    // rust: .iter()
    // rust: .map(|group| {
    // rust: (
    // rust: group.label.as_str(),
    // rust: group
    // rust: .tracks
    // rust: .iter()
    // rust: .map(|track| track.id.rsplit('/').next().unwrap())
    // rust: .collect(),
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(
    // rust: summary,
    // rust: [
    // rust: ("horizon.pages.music.menu", vec!["one"]),
    // rust: ("horizon.pages.music.overworld", vec!["shared", "second"]),
                // A biome pool's own track, from the pool that plays it.
    // rust: (
    // rust: "horizon.pages.music.overworld_biomes",
    // rust: vec!["bromeliad", "aerie"]
    // rust: ),
    // rust: ("horizon.pages.music.nether_biomes", vec!["rubedo"]),
    // rust: ]
    // rust: );
        // Each row plays from a pool that has the track; no track repeats.
    // rust: let mut seen = Vec::new();
    // rust: for group in &groups {
    // rust: for track in &group.tracks {
    // rust: assert!(!seen.contains(&track.id), "{} listed twice", track.id);
    // rust: seen.push(track.id.clone());
    // rust: assert!(
    // rust: registry.tracks(&track.event).contains(&track.id),
    // rust: "{} does not play {}",
    // rust: track.event,
    // rust: track.id
    // rust: );
}
}
        // Records and other events are not music.
    // rust: assert!(seen.iter().all(|id| !id.contains("records/")));
}

    /// The overworld pool, two tracks, and a menu track.
pub fn two_tracks() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut registry = SoundRegistry::default();
    // rust: registry.add_file(
    // rust: "minecraft",
    // rust: br#"{"music.game": {"sounds": [
    // rust: {"name": "music/game/one", "stream": true},
    // rust: {"name": "music/game/two", "stream": true}]},
    // rust: "music.menu": {"sounds": [{"name": "music/menu/one", "stream": true}]}}"#,
    // rust: &|_, _| true,
    // rust: );
    // rust: SoundEngine::new(registry)
}
pub fn played(m: *MusicManager, engine: *SoundEngine) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = m.current_instance()?;
    // rust: let sound = engine.instance(id)?.sound.clone()?;
    // rust: Some(sound.location)
}

pub fn a_track_turned_off_leaves_the_pool() void {
}
    // rust: let (mut engine, mut backend) = (two_tracks(), Null::default());
    // rust: let mut m = MusicManager::new(11);
    // rust: m.set_off(&["minecraft:music/game/one".to_owned()]);
    // rust: m.start_playing(
    // rust: &Music::game(),
    // rust: &mut Bound {
    // rust: engine: &mut engine,
    // rust: backend: &mut backend,
    // rust: },
    // rust: );
    // rust: assert_eq!(
    // rust: played(&m, &engine).as_deref(),
    // rust: Some("minecraft:music/game/two")
    // rust: );
        // `current` is the event, as `isPlayingMusic` reads it.
    // rust: assert_eq!(m.current(&engine), Some("minecraft:music.game"));
}

pub fn a_situation_with_every_track_off_plays_nothing_and_tries_later() void {
}
    // rust: let (mut engine, mut backend) = (two_tracks(), Null::default());
    // rust: let mut m = MusicManager::new(12);
    // rust: m.set_off(&[
    // rust: "minecraft:music/game/one".to_owned(),
    // rust: "minecraft:music/game/two".to_owned(),
    // rust: ]);
    // rust: m.start_playing(
    // rust: &Music::game(),
    // rust: &mut Bound {
    // rust: engine: &mut engine,
    // rust: backend: &mut backend,
    // rust: },
    // rust: );
    // rust: assert!(m.current_instance().is_none());
        // A retry after the usual delay, so turning one back on is heard.
    // rust: assert!((12000..=24000).contains(&m.next_song_delay()));
}

pub fn play_now_plays_that_track_and_the_situation_waits() void {
}
    // rust: let (mut engine, mut backend) = (two_tracks(), Null::default());
    // rust: let mut m = MusicManager::new(13);
    // rust: m.start_playing(
    // rust: &Music::menu(),
    // rust: &mut Bound {
    // rust: engine: &mut engine,
    // rust: backend: &mut backend,
    // rust: },
    // rust: );
    // rust: let menu = m.current_instance().expect("menu music started");
        // Even a track turned off plays when asked to, by hand, and it takes
        // the slot from the track already playing.
    // rust: m.set_off(&["minecraft:music/game/two".to_owned()]);
    // rust: assert!(m.play_track(
    // rust: "minecraft:music.game",
    // rust: "minecraft:music/game/two",
    // rust: &mut Bound {
    // rust: engine: &mut engine,
    // rust: backend: &mut backend,
    // rust: },
    // rust: ));
        // The slot's old track is told to stop as soon as it is replaced.
    // rust: assert_ne!(m.current_instance(), Some(menu), "the slot changed");
    // rust: assert!(
    // rust: backend.stopped.values().any(|stopped| *stopped),
    // rust: "the old channel stopped"
    // rust: );
    // rust: assert_eq!(
    // rust: played(&m, &engine).as_deref(),
    // rust: Some("minecraft:music/game/two")
    // rust: );
        // Menu music replaces what plays; a "play now" track keeps its slot.
    // rust: for _ in 0..3 {
    // rust: m.tick(
    // rust: Some(&Music::menu()),
    // rust: 1.0,
    // rust: false,
    // rust: &mut Bound {
    // rust: engine: &mut engine,
    // rust: backend: &mut backend,
    // rust: },
    // rust: );
}
    // rust: assert_eq!(
    // rust: played(&m, &engine).as_deref(),
    // rust: Some("minecraft:music/game/two")
    // rust: );
        // Once it ends, the situation's own music takes over again.
    // rust: engine.stop_all(&mut backend);
    // rust: m.tick(
    // rust: Some(&Music::menu()),
    // rust: 1.0,
    // rust: false,
    // rust: &mut Bound {
    // rust: engine: &mut engine,
    // rust: backend: &mut backend,
    // rust: },
    // rust: );
    // rust: assert!(m.current_instance().is_none());
}

pub fn play_now_of_a_track_the_event_lacks_plays_nothing() void {
}
    // rust: let (mut engine, mut backend) = (two_tracks(), Null::default());
    // rust: let mut m = MusicManager::new(14);
    // rust: assert!(!m.play_track(
    // rust: "minecraft:music.game",
    // rust: "minecraft:music/game/absent",
    // rust: &mut Bound {
    // rust: engine: &mut engine,
    // rust: backend: &mut backend,
    // rust: },
    // rust: ));
    // rust: assert!(m.current_instance().is_none());
}
}
