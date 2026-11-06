//! Transpiled from Horizon Rust crate
//! Module: horizon-client_ambience
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The player's ambient sound handlers: `BiomeAmbientSoundsHandler` (biome
//! loops with 40-tick cross-fades, random additions, cave mood) driven by the
//! `minecraft:audio/ambient_sounds` attribute, `UnderwaterAmbientSoundHandler`
//! and `LocalPlayer.updateIsUnderwater` (enter/exit sounds and the
//! `UnderLiquidAmbientSoundInstance` loop), played through the sound engine.
// use crate::sound_engine::{AMBIENT, InstanceId, PLAYERS, SoundEngine, SoundInstance, Sounds};
// use horizon_core::random::{LegacyRandom, RandomSource};
// use serde_json::Value;
// use std::{collections::HashMap, path::Path};

/// `AmbientMoodSettings`.
pub const Mood = struct {
    sound: []const u8,
    tick_delay: i32,
    block_search_extent: i32,
    offset: f64,
};
/// `AmbientSounds`: the attribute value.
pub const AmbientSounds = struct {
    // rust: pub r#loop: Option<String>,
    mood: ?Mood,
    /// (sound, tick chance)
    additions: Vec<([]const u8,
};
    // rust: impl AmbientSounds {
pub fn parse(v: *Value) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mood = &v["mood"];
    // rust: let addition =
    // rust: |a: &Value| Some((a["sound"].as_str()?.to_owned(), a["tick_chance"].as_f64()?));
    // rust: Self {
    // rust: r#loop: v["loop"].as_str().map(str::to_owned),
    // rust: mood: mood["sound"].as_str().map(|sound| Mood {
    // rust: sound: sound.to_owned(),
    // rust: tick_delay: mood["tick_delay"].as_i64().unwrap_or(6000) as i32,
    // rust: block_search_extent: mood["block_search_extent"].as_i64().unwrap_or(8) as i32,
    // rust: offset: mood["offset"].as_f64().unwrap_or(2.0),
    // rust: }),
            // A single addition or a list of them.
    // rust: additions: match &v["additions"] {
    // rust: Value::Array(list) => list.iter().filter_map(addition).collect(),
    // rust: single => addition(single).into_iter().collect(),
    // rust: },
}
}
}
/// Ambient sound attributes by dimension type and biome.
pub const AmbientTables = struct {
    dimensions: HashMap<[]const u8,
    biomes: HashMap<[]const u8,
};
    // rust: impl AmbientTables {
pub fn load(root: *Path) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let read = |dir: &str| -> HashMap<String, AmbientSounds> {
    // rust: let Ok(folder) =
    // rust: horizon_world::json_folder::read(&root.join("data/minecraft").join(dir))
    // rust: else {
    // rust: return HashMap::new();
}
    // rust: folder
    // rust: .files
    // rust: .iter()
    // rust: .filter_map(|file| {
    // rust: let json: Value = serde_json::from_slice(file.bytes().ok()?).ok()?;
    // rust: let v = &json["attributes"]["minecraft:audio/ambient_sounds"];
    // rust: (!v.is_null())
    // rust: .then(|| (format!("minecraft:{}", file.name), AmbientSounds::parse(v)))
    // rust: })
    // rust: .collect()
}
    // rust: Self {
    // rust: dimensions: read("dimension_type"),
    // rust: biomes: read("worldgen/biome"),
}
}
    /// `EnvironmentAttributes.AMBIENT_SOUNDS` at a position.
pub fn get(self: *Self, dimension: []const u8, biome: []const u8) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.biomes
    // rust: .get(biome)
    // rust: .or_else(|| self.dimensions.get(dimension))
    // rust: .cloned()
    // rust: .unwrap_or_default()
}
}
/// What the handlers read about the player and level each tick.
pub const AmbientContext = struct {
    /// `AMBIENT_SOUNDS` at the player's position.
    sounds: *'a AmbientSounds,
    /// The player's position (feet) and eye height.
    position: [f64,
    eye_y: f64,
    /// `isEyeInFluid(WATER)` this tick (`Entity.updateIsUnderwater`).
    underwater: bool,
    spectator: bool,
    /// `Level.getBrightness` (sky, block) at a block.
    light: *'a dyn Fn([i32,
    /// The bubble column in the player's box (its `drag` property), from
    /// `bubble_column_in`.
    bubble_column: ?bool,
};
/// `BubbleColumnAmbientSoundHandler`'s lookup: the first bubble column
/// (x fastest, then y, then z) in the player's bounding box inflated by
/// (0, -0.4F, 0) and deflated by 1.0E-6, as `drag_down`. `state` gives the
/// bubble column at a block (None for anything else).
pub fn bubble_column_in(bb: [f64; 6], state: impl Fn([i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // AABB keeps min <= max on every construction.
    // rust: let make = |a: [f64; 6]| {
    // rust: [
    // rust: a[0].min(a[3]),
    // rust: a[1].min(a[4]),
    // rust: a[2].min(a[5]),
    // rust: a[0].max(a[3]),
    // rust: a[1].max(a[4]),
    // rust: a[2].max(a[5]),
    // rust: ]
}
    // rust: let inflate = |b: [f64; 6], x: f64, y: f64, z: f64| {
    // rust: make([b[0] - x, b[1] - y, b[2] - z, b[3] + x, b[4] + y, b[5] + z])
}
    // rust: let b = inflate(make(bb), 0.0, f64::from(-0.4f32), 0.0);
    // rust: let b = inflate(b, -1.0E-6, -1.0E-6, -1.0E-6);
    // rust: let (x0, y0, z0) = (
    // rust: b[0].floor() as i32,
    // rust: b[1].floor() as i32,
    // rust: b[2].floor() as i32,
    // rust: );
    // rust: let (x1, y1, z1) = (
    // rust: b[3].floor() as i32,
    // rust: b[4].floor() as i32,
    // rust: b[5].floor() as i32,
    // rust: );
    // rust: for z in z0..=z1 {
    // rust: for y in y0..=y1 {
    // rust: for x in x0..=x1 {
    // rust: if let Some(drag) = state([x, y, z]) {
    // rust: return Some(drag);
}
}
}
}
    // rust: None
}
/// The local player's ambient sound handlers.
pub const Ambience = struct {
    /// The client level's random.
    random: LegacyRandom,
    /// `BiomeAmbientSoundsHandler.loopSounds` (insertion order).
    loops: Vec<([]const u8,
    previous_loop: ?[]const u8,
    moodiness: f32,
    /// `UnderwaterAmbientSoundHandler.tickDelay`.
    underwater_delay: i32,
    /// `LocalPlayer.wasUnderwater`.
    was_underwater: bool,
    /// `BubbleColumnAmbientSoundHandler.wasInBubbleColumn` / `firstTick`.
    was_in_bubble_column: bool,
    first_tick: bool,
};
    // rust: impl Default for Ambience {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new(crate::sound_engine::unique_seed())
}
}
    // rust: impl Ambience {
    /// Starts its random over from `seed`.
pub fn reseed(self: *Self, seed: i64) void {
}
    // rust: self.random = LegacyRandom::new(seed);
}
pub fn new(seed: i64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: random: LegacyRandom::new(seed),
    // rust: loops: Vec::new(),
    // rust: previous_loop: None,
    // rust: moodiness: 0.0,
    // rust: underwater_delay: 0,
    // rust: was_underwater: false,
    // rust: was_in_bubble_column: false,
    // rust: first_tick: true,
}
}
    /// `LocalPlayer.isUnderWater`.
pub fn was_underwater(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.was_underwater
}
    /// `BiomeAmbientSoundsHandler.loopSounds`.
pub fn loops(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.loops
}
    /// `UnderwaterAmbientSoundHandler.tickDelay`.
pub fn underwater_delay(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.underwater_delay
}
    /// A new player (leaving or changing worlds): fresh handlers.
pub fn clear(self: *Self, sounds: *mut impl Sounds) void {
}
    // rust: for (_, id) in self.loops.drain(..) {
    // rust: sounds.release(id);
}
    // rust: self.previous_loop = None;
    // rust: self.moodiness = 0.0;
    // rust: self.underwater_delay = 0;
    // rust: self.was_underwater = false;
    // rust: self.was_in_bubble_column = false;
    // rust: self.first_tick = true;
}
    /// `ClientLevel.playLocalSound(x, y, z, sound, source, 1, 1, false)`.
pub fn play_local(self: *Self, event: []const u8, source: usize, at: [f64; 3], sounds: *mut impl Sounds) void {
}
    // rust: let seed = self.random.next_long();
    // rust: let instance = SoundInstance::at(event, source, 1.0, 1.0, LegacyRandom::new(seed), at);
    // rust: sounds.play_instance(instance, false);
}
    /// `LocalPlayer.updateIsUnderwater`, then the `ambientSoundHandlers`
    /// (underwater, bubble column, biome) as `LocalPlayer.tick` runs them.
pub fn tick(self: *Self, ctx: *AmbientContext, sounds: *mut impl Sounds) void {
}
    // rust: let old = self.was_underwater;
    // rust: self.was_underwater = ctx.underwater;
    // rust: if !ctx.spectator {
    // rust: if !old && ctx.underwater {
    // rust: self.play_local(
    // rust: "minecraft:ambient.underwater.enter",
    // rust: AMBIENT,
    // rust: ctx.position,
    // rust: sounds,
    // rust: );
    // rust: let instance = SoundInstance::under_liquid_loop(
    // rust: "minecraft:ambient.underwater.loop",
    // rust: SoundEngine::unseeded(),
    // rust: );
    // rust: sounds.play_instance(instance, false);
}
    // rust: if old && !ctx.underwater {
    // rust: self.play_local(
    // rust: "minecraft:ambient.underwater.exit",
    // rust: AMBIENT,
    // rust: ctx.position,
    // rust: sounds,
    // rust: );
}
}
    // rust: self.tick_underwater(sounds);
    // rust: self.tick_bubble_column(ctx, sounds);
    // rust: self.tick_biome(ctx, sounds);
}
    /// `BubbleColumnAmbientSoundHandler.tick`: entering a column plays its
    /// inside sound (`LocalPlayer.playSound`, on PLAYERS).
pub fn tick_bubble_column(self: *Self, ctx: *AmbientContext, sounds: *mut impl Sounds) void {
}
    // rust: if let Some(drag_down) = ctx.bubble_column {
    // rust: if !self.was_in_bubble_column && !self.first_tick && !ctx.spectator {
    // rust: let event = if drag_down {
    // rust: "minecraft:block.bubble_column.whirlpool_inside"
    // rust: } else {
    // rust: "minecraft:block.bubble_column.upwards_inside"
}
    // rust: self.play_local(event, PLAYERS, ctx.position, sounds);
}
    // rust: self.was_in_bubble_column = true;
    // rust: } else {
    // rust: self.was_in_bubble_column = false;
}
    // rust: self.first_tick = false;
}
    /// `UnderwaterAmbientSoundHandler.tick`.
pub fn tick_underwater(self: *Self, sounds: *mut impl Sounds) void {
}
    // rust: self.underwater_delay -= 1;
    // rust: if self.underwater_delay <= 0 && self.was_underwater {
    // rust: let rand = self.random.next_float();
    // rust: let sound = if rand < 1.0E-4 {
    // rust: Some("minecraft:ambient.underwater.loop.additions.ultra_rare")
    // rust: } else if rand < 0.001 {
    // rust: Some("minecraft:ambient.underwater.loop.additions.rare")
    // rust: } else if rand < 0.01 {
    // rust: Some("minecraft:ambient.underwater.loop.additions")
    // rust: } else {
    // rust: None
}
    // rust: if let Some(sound) = sound {
    // rust: self.underwater_delay = 0;
    // rust: let instance = SoundInstance::under_liquid_sub(sound, SoundEngine::unseeded());
    // rust: sounds.play_instance(instance, false);
}
}
}
    /// `BiomeAmbientSoundsHandler.tick`.
pub fn tick_biome(self: *Self, ctx: *AmbientContext, sounds: *mut impl Sounds) void {
}
    // rust: let mut kept = Vec::new();
    // rust: for (event, id) in std::mem::take(&mut self.loops) {
    // rust: if sounds.engine().instance(id).is_some_and(|i| i.stopped) {
    // rust: sounds.release(id);
    // rust: } else {
    // rust: kept.push((event, id));
}
}
    // rust: self.loops = kept;
    // rust: let current = ctx
    // rust: .sounds
    // rust: .r#loop
    // rust: .as_deref()
    // rust: .map(crate::sound_events::normalize);
    // rust: if current != self.previous_loop {
    // rust: self.previous_loop = current.clone();
    // rust: for (_, id) in &self.loops {
    // rust: if let Some(i) = sounds.engine().instance_mut(*id) {
    // rust: i.fade_out();
}
}
    // rust: if let Some(event) = current {
    // rust: let id = match self.loops.iter().find(|(e, _)| *e == event) {
    // rust: Some((_, id)) => *id,
    // rust: None => {
    // rust: let instance = SoundInstance::biome_loop(&event, SoundEngine::unseeded());
    // rust: let id = sounds.engine().add(instance, true);
    // rust: sounds.play_id(id);
    // rust: self.loops.push((event, id));
    // rust: id
}
}
    // rust: if let Some(i) = sounds.engine().instance_mut(id) {
    // rust: i.fade_in();
}
}
}
    // rust: for (sound, chance) in &ctx.sounds.additions {
    // rust: if self.random.next_double() < *chance {
    // rust: let event = crate::sound_events::normalize(sound);
    // rust: let instance = SoundInstance::for_ambient_addition(&event, SoundEngine::unseeded());
    // rust: sounds.play_instance(instance, false);
}
}
    // rust: let Some(mood) = &ctx.sounds.mood else { return };
    // rust: let extent = mood.block_search_extent;
    // rust: let span = extent * 2 + 1;
    // rust: let x = ctx.position[0] + f64::from(self.random.next_int_bound(span).unwrap_or(0))
    // rust: - f64::from(extent);
    // rust: let y = ctx.eye_y + f64::from(self.random.next_int_bound(span).unwrap_or(0))
    // rust: - f64::from(extent);
    // rust: let z = ctx.position[2] + f64::from(self.random.next_int_bound(span).unwrap_or(0))
    // rust: - f64::from(extent);
    // rust: let sample = [x.floor() as i32, y.floor() as i32, z.floor() as i32];
    // rust: let (sky, block) = (ctx.light)(sample);
    // rust: if sky > 0 {
    // rust: self.moodiness -= f32::from(sky) / 15.0 * 0.001;
    // rust: } else {
    // rust: self.moodiness -= (i32::from(block) - 1) as f32 / mood.tick_delay as f32;
}
    // rust: if self.moodiness >= 1.0 {
    // rust: let sample_x = f64::from(sample[0]) + 0.5;
    // rust: let sample_y = f64::from(sample[1]) + 0.5;
    // rust: let sample_z = f64::from(sample[2]) + 0.5;
    // rust: let dx = sample_x - ctx.position[0];
    // rust: let dy = sample_y - ctx.eye_y;
    // rust: let dz = sample_z - ctx.position[2];
    // rust: let distance = (dx * dx + dy * dy + dz * dz).sqrt();
    // rust: let source = distance + mood.offset;
    // rust: let at = [
    // rust: ctx.position[0] + dx / distance * source,
    // rust: ctx.eye_y + dy / distance * source,
    // rust: ctx.position[2] + dz / distance * source,
    // rust: ];
            // The mood sound draws from the level random itself.
    // rust: let event = crate::sound_events::normalize(&mood.sound);
    // rust: let instance = SoundInstance::for_ambient_mood(&event, self.random.clone(), at);
    // rust: let id = sounds.engine().add(instance, true);
    // rust: sounds.play_id(id);
    // rust: if let Some(i) = sounds.engine().instance(id) {
    // rust: self.random = i.random.clone();
}
    // rust: sounds.release(id);
    // rust: self.moodiness = 0.0;
    // rust: } else {
    // rust: self.moodiness = self.moodiness.max(0.0);
}
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::sound_engine::{Bound, TickContext, test_backend::Null};
//     use crate::sound_events::SoundRegistry;

pub fn engine() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut registry = SoundRegistry::default();
    // rust: registry.add_file(
    // rust: "minecraft",
    // rust: br#"{"crimson": {"sounds": ["c"]}, "warped": {"sounds": ["w"]},
    // rust: "ambient.cave": {"sounds": ["a", "b"]},
    // rust: "ambient.underwater.loop": {"sounds": ["u"]},
    // rust: "ambient.underwater.enter": {"sounds": ["e"]},
    // rust: "ambient.underwater.exit": {"sounds": ["x"]}}"#,
    // rust: &|_, _| true,
    // rust: );
    // rust: SoundEngine::new(registry)
}
    // rust: fn ctx<'a>(
    // rust: sounds: &'a AmbientSounds,
    // rust: underwater: bool,
    // rust: light: &'a dyn Fn([i32; 3]) -> (u8, u8),
    // rust: ) -> AmbientContext<'a> {
    // rust: AmbientContext {
    // rust: sounds,
    // rust: position: [0.5, 10.0, 0.5],
    // rust: eye_y: 11.62,
    // rust: underwater,
    // rust: spectator: false,
    // rust: light,
    // rust: bubble_column: None,
}
}

pub fn loops_cross_fade_over_forty_ticks() void {
}
    // rust: let (mut engine, mut backend) = (engine(), Null::default());
    // rust: let mut a = Ambience::new(1);
    // rust: let lit = |_: [i32; 3]| (15u8, 0u8);
    // rust: let crimson = AmbientSounds {
    // rust: r#loop: Some("minecraft:crimson".into()),
    // rust: ..Default::default()
}
    // rust: let warped = AmbientSounds {
    // rust: r#loop: Some("minecraft:warped".into()),
    // rust: ..Default::default()
}
    // rust: let tick =
    // rust: |a: &mut Ambience, s: &AmbientSounds, engine: &mut SoundEngine, backend: &mut Null| {
    // rust: a.tick(
    // rust: &ctx(s, false, &lit),
    // rust: &mut Bound {
    // rust: engine: &mut *engine,
    // rust: backend: &mut *backend,
    // rust: },
    // rust: );
    // rust: engine.tick(false, &TickContext::default(), backend);
}
    // rust: for _ in 0..40 {
    // rust: tick(&mut a, &crimson, &mut engine, &mut backend);
}
    // rust: for _ in 0..20 {
    // rust: tick(&mut a, &warped, &mut engine, &mut backend);
}
    // rust: let volumes: Vec<f32> = a
    // rust: .loops
    // rust: .iter()
    // rust: .map(|(_, id)| engine.instance(*id).unwrap().volume)
    // rust: .collect();
    // rust: assert_eq!(volumes, [0.5, 0.5]);
    // rust: for _ in 0..30 {
    // rust: tick(&mut a, &warped, &mut engine, &mut backend);
}
    // rust: assert_eq!(a.loops.len(), 1);
}

pub fn mood_builds_in_the_dark_and_plays_a_cave_sound() void {
}
    // rust: let (mut engine, mut backend) = (engine(), Null::default());
    // rust: engine.listening = true;
    // rust: let mut a = Ambience::new(2);
    // rust: let cave = |_: [i32; 3]| (0u8, 0u8);
    // rust: let sounds = AmbientSounds {
    // rust: mood: Some(Mood {
    // rust: sound: "minecraft:ambient.cave".into(),
    // rust: tick_delay: 6000,
    // rust: block_search_extent: 8,
    // rust: offset: 2.0,
    // rust: }),
    // rust: ..Default::default()
}
    // rust: let mut ticks = 0;
    // rust: while engine.notifications.is_empty() && ticks < 7000 {
    // rust: a.tick(
    // rust: &ctx(&sounds, false, &cave),
    // rust: &mut Bound {
    // rust: engine: &mut engine,
    // rust: backend: &mut backend,
    // rust: },
    // rust: );
    // rust: ticks += 1;
}
    // rust: assert!((5990..=6010).contains(&ticks), "{ticks}");
    // rust: assert_eq!(engine.notifications[0].identifier, "minecraft:ambient.cave");
    // rust: assert_eq!(a.moodiness, 0.0);
}
}
