//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_sound_engine
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Vanilla's `SoundEngine` bookkeeping, separated from the mixer: sound
//! instances resolved from the registry with their own random, the channel
//! pools (`Library.CountingChannelPool`), `calculateVolume`/`calculatePitch`,
//! the channel parameters a play sets (gain, pitch, linear attenuation, looping,
//! position, relative), the subtitle notifications, tickable instances,
//! delayed and manually looped sounds, the 20-tick minimum channel lifetime,
//! `isActive`, category gains and stopping by sound or source.
//!
//! The executor is modelled as running every channel task immediately (the
//! sound thread keeps up between ticks); a channel's own end is reported by the
//! backend through `stopped`.
// use crate::sound_events::{INTENTIONALLY_EMPTY, Sentinel, Sound, SoundRegistry};
// use horizon_core::random::LegacyRandom;
// use std::{
    // rust: collections::HashMap,
    // rust: sync::{Arc, RwLock},
}

/// `SoundSource` indices (vanilla order).
pub const MASTER: usize = 0;
pub const MUSIC: usize = 1;
pub const RECORDS: usize = 2;
pub const NEUTRAL: usize = 6;
pub const PLAYERS: usize = 7;
pub const AMBIENT: usize = 8;
pub const UI: usize = 10;
/// The pool sizes `Library.init` derives from OpenAL Soft's default 255 mono
/// sources: `clamp((int) sqrt(255), 2, 8)` streaming, the rest static.
pub const STATIC_CHANNELS: usize = 247;
pub const STREAMING_CHANNELS: usize = 8;
/// Static channels only sounds played to the listener (no position) may take
/// while the `uiSoundReserve` extra is on.
pub const HEARD_RESERVE: usize = 16;

pub const PlayResult = enum {
    Started,
    StartedSilently,
    NotStarted,
};
/// `SoundInstance.Attenuation`.
pub const Attenuation = enum {
    None,
    Linear,
};
/// The object an entity-bound sound follows. Clones retain the same object,
/// even after the world replaces another entity with the same numeric id.
pub const SoundEntity = struct {
    id: u32,
    state: *RwLock<SoundEntityState>,
};
pub const SoundEntityState = struct {
    position: [f64,
    silent: bool,
    removed: bool,
};
    // rust: impl SoundEntity {
pub fn new(id: u32, position: [f64; 3], silent: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: id,
    // rust: state: Arc::new(RwLock::new(SoundEntityState {
    // rust: position,
    // rust: silent,
    // rust: removed: false,
    // rust: })),
}
}
pub fn state(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: *self.state.read().unwrap()
}
pub fn update(self: *Self, state: SoundEntityState) void {
}
    // rust: *self.state.write().unwrap() = state;
}
}

/// The tickable instance kinds Horizon plays (`TickableSoundInstance`).
pub const Ticking = enum {
    /// Not tickable.
    No,
    /// A compiled native owner updates this instance through `instance_mut`.
    /// The ordinary engine applies gain, pitch and position each unpaused tick;
    /// no vanilla entity behavior overwrites them. Stop and release when done.
    Native,
    /// `EntityBoundSoundInstance`.
    EntityBound,
    /// `BiomeAmbientSoundsHandler.LoopSoundInstance`.
    BiomeLoop { fade: i32, direction: i32 },
    /// `UnderLiquidAmbientSoundInstance`.
    UnderLiquidLoop { fade: i32 },
    /// `UnderLiquidSubSound`.
    UnderLiquidSub,
    /// `MinecartSoundInstance` following a minecart.
    Minecart { cart: u32 },
    /// `RidingMinecartSoundInstance` for the player riding a minecart.
    RidingMinecart { cart: u32, underwater: bool },
    /// `BeeFlyingSoundInstance`, or `BeeAggressiveSoundInstance` when
    /// `aggressive`.
    Bee { bee: u32, aggressive: bool },
    /// `GuardianAttackSoundInstance`.
    GuardianAttack { guardian: u32 },
    /// `SnifferSoundInstance`.
    Sniffer { sniffer: u32 },
    /// `ElytraOnPlayerSoundInstance`: ticks since it started.
    Elytra { time: i32 },
    /// `RidingEntitySoundInstance` for the player riding a happy ghast
    /// (`underwater_sound` false) or a nautilus (true).
    RidingEntity { entity: u32, underwater_sound: bool },
    /// A native mod's music layer (`MusicLayers`), whose volume its owner
    /// sets each tick.
    MusicLayer,
};
/// What a minecart's sound instances read about it.
pub const CartSound = struct {
    id: u32,
    position: [f64,
    /// `getDeltaMovement().horizontalDistance()`.
    speed: f64,
};
/// What a bee's or a guardian's sound instance reads about it.
pub const MobSound = struct {
    id: u32,
    position: [f64,
    /// `getDeltaMovement().horizontalDistance()`.
    speed: f64,
    baby: bool,
    /// `Bee.isAngry`.
    angry: bool,
    /// `isSilent`.
    silent: bool,
    /// `Guardian.getAttackAnimationScale(0)`.
    attack_scale: f32,
    /// `getTarget() == null && Sniffer.canPlayDiggingSound()`.
    sniffer_digging: bool,
};
/// What a `RidingEntitySoundInstance` reads about the mob the player rides.
pub const RiddenSound = struct {
    id: u32,
    /// `getDeltaMovement().length()`.
    speed: f64,
    /// `isSilent`.
    silent: bool,
    /// `Entity.isUnderWater`.
    underwater: bool,
};
/// What tickable instances read about the player and the entities they follow.
pub const TickContext = struct {
    player_underwater: bool,
    player_removed: bool,
    /// The minecart the player rides.
    vehicle: ?u32,
    /// The minecarts in the level (a missing one has been removed).
    carts: std.ArrayList(CartSound),
    /// The bees and guardians in the level (a missing one has been removed).
    mobs: std.ArrayList(MobSound),
    /// `!tickRateManager().runsNormally()`.
    frozen: bool,
    /// The player's position.
    player_position: [f64,
    /// `getDeltaMovement().lengthSqr()` of the player.
    player_speed_sqr: f64,
    /// `isFallFlying()` of the player.
    player_fall_flying: bool,
    /// The mob the player rides, when it is not a minecart.
    ridden: ?RiddenSound,
};
/// `AbstractSoundInstance` and its subclasses' fields.
pub const SoundInstance = struct {
    identifier: []const u8,
    source: usize,
    volume: f32,
    pitch: f32,
    position: [f64,
    looping: bool,
    delay: i32,
    attenuation: Attenuation,
    relative: bool,
    random: LegacyRandom,
    can_start_silent: bool,
    ticking: Ticking,
    /// A stable entity reference, separate from its reusable network id.
    bound_entity: ?SoundEntity,
    /// `AbstractTickableSoundInstance.stopped`.
    stopped: bool,
    /// `sound` after `getOrResolve`, or the sound a caller chose for the
    /// instance (`chosen`).
    sound: ?Sound,
    /// `soundEvent != null` after `getOrResolve`, and its subtitle.
    event: ?Option<[]const u8>,
    /// The caller picked `sound` itself (the Music page leaves its off tracks
    /// out), so `resolve` keeps it. Every other instance resolves again at each
    /// play, as vanilla's `getOrResolve` does.
    chosen: bool,
};
    // rust: impl SoundInstance {
    // rust: pub fn new(
    // rust: identifier: &str,
    // rust: source: usize,
    // rust: volume: f32,
    // rust: pitch: f32,
    // rust: random: LegacyRandom,
    // rust: looping: bool,
    // rust: delay: i32,
    // rust: attenuation: Attenuation,
    // rust: position: [f64; 3],
    // rust: relative: bool,
    // rust: ) -> Self {
    // rust: Self {
    // rust: identifier: identifier.to_owned(),
    // rust: source,
    // rust: volume,
    // rust: pitch,
    // rust: position,
    // rust: looping,
    // rust: delay,
    // rust: attenuation,
    // rust: relative,
    // rust: random,
    // rust: can_start_silent: false,
    // rust: ticking: Ticking::No,
    // rust: bound_entity: None,
    // rust: stopped: false,
    // rust: sound: None,
    // rust: event: None,
    // rust: chosen: false,
}
}
    /// `new SimpleSoundInstance(sound, source, volume, pitch, random, x, y, z)`.
    // rust: pub fn at(
    // rust: id: &str,
    // rust: source: usize,
    // rust: volume: f32,
    // rust: pitch: f32,
    // rust: random: LegacyRandom,
    // rust: at: [f64; 3],
    // rust: ) -> Self {
    // rust: Self::new(
    // rust: id,
    // rust: source,
    // rust: volume,
    // rust: pitch,
    // rust: random,
    // rust: false,
    // rust: 0,
    // rust: Attenuation::Linear,
    // rust: at,
    // rust: false,
    // rust: )
}
    /// `EntityBoundSoundInstance`: initial coordinates are widened floats too.
    // rust: pub fn entity_bound(
    // rust: id: &str,
    // rust: source: usize,
    // rust: volume: f32,
    // rust: pitch: f32,
    // rust: random: LegacyRandom,
    // rust: entity: SoundEntity,
    // rust: ) -> Self {
    // rust: let position = entity.state().position.map(|v| f64::from(v as f32));
    // rust: let mut instance = Self::at(id, source, volume, pitch, random, position);
    // rust: instance.ticking = Ticking::EntityBound;
    // rust: instance.bound_entity = Some(entity);
    // rust: instance
}
    /// `EntityBoundSoundInstance.canPlaySound`, also checked on replay.
pub fn can_play_sound(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.bound_entity
    // rust: .as_ref()
    // rust: .is_none_or(|entity| !entity.state().silent)
}
    /// `SimpleSoundInstance.forUI(sound, pitch, volume)`.
pub fn for_ui(id: []const u8, pitch: f32, volume: f32, random: LegacyRandom) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new(
    // rust: id,
    // rust: UI,
    // rust: volume,
    // rust: pitch,
    // rust: random,
    // rust: false,
    // rust: 0,
    // rust: Attenuation::None,
    // rust: [0.0; 3],
    // rust: true,
    // rust: )
}
    /// `SimpleSoundInstance.forMusic`.
pub fn for_music(id: []const u8, random: LegacyRandom) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new(
    // rust: id,
    // rust: MUSIC,
    // rust: 1.0,
    // rust: 1.0,
    // rust: random,
    // rust: false,
    // rust: 0,
    // rust: Attenuation::None,
    // rust: [0.0; 3],
    // rust: true,
    // rust: )
}
    /// A native mod's music layer: a looping, unattenuated track on the music
    /// source that starts silent (`MusicLayers` fades it in).
pub fn for_music_layer(id: []const u8, random: LegacyRandom) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut s = Self::new(
    // rust: id,
    // rust: MUSIC,
    // rust: 0.0,
    // rust: 1.0,
    // rust: random,
    // rust: true,
    // rust: 0,
    // rust: Attenuation::None,
    // rust: [0.0; 3],
    // rust: true,
    // rust: );
    // rust: s.can_start_silent = true;
    // rust: s.ticking = Ticking::MusicLayer;
    // rust: s
}
    /// `SimpleSoundInstance.forJukeboxSong`.
pub fn for_jukebox_song(id: []const u8, at: [f64; 3], random: LegacyRandom) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new(
    // rust: id,
    // rust: RECORDS,
    // rust: 4.0,
    // rust: 1.0,
    // rust: random,
    // rust: false,
    // rust: 0,
    // rust: Attenuation::Linear,
    // rust: at,
    // rust: false,
    // rust: )
}
    /// `SimpleSoundInstance.forLocalAmbience`.
pub fn for_local_ambience(id: []const u8, pitch: f32, volume: f32, random: LegacyRandom) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new(
    // rust: id,
    // rust: AMBIENT,
    // rust: volume,
    // rust: pitch,
    // rust: random,
    // rust: false,
    // rust: 0,
    // rust: Attenuation::None,
    // rust: [0.0; 3],
    // rust: true,
    // rust: )
}
    /// `SimpleSoundInstance.forAmbientAddition`.
pub fn for_ambient_addition(id: []const u8, random: LegacyRandom) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::for_local_ambience(id, 1.0, 1.0, random)
}
    /// `SimpleSoundInstance.forAmbientMood`.
pub fn for_ambient_mood(id: []const u8, random: LegacyRandom, at: [f64; 3]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new(
    // rust: id,
    // rust: AMBIENT,
    // rust: 1.0,
    // rust: 1.0,
    // rust: random,
    // rust: false,
    // rust: 0,
    // rust: Attenuation::Linear,
    // rust: at,
    // rust: false,
    // rust: )
}
    /// A relative looping ambient instance (the loop sound constructors).
pub fn ambient_loop(id: []const u8, random: LegacyRandom, looping: bool, ticking: Ticking) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut s = Self::new(
    // rust: id,
    // rust: AMBIENT,
    // rust: 1.0,
    // rust: 1.0,
    // rust: random,
    // rust: looping,
    // rust: 0,
    // rust: Attenuation::Linear,
    // rust: [0.0; 3],
    // rust: true,
    // rust: );
    // rust: s.ticking = ticking;
    // rust: s
}
    /// `new BiomeAmbientSoundsHandler.LoopSoundInstance(event)`.
pub fn biome_loop(id: []const u8, random: LegacyRandom) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::ambient_loop(
    // rust: id,
    // rust: random,
    // rust: true,
    // rust: Ticking::BiomeLoop {
    // rust: fade: 0,
    // rust: direction: 0,
    // rust: },
    // rust: )
}
    /// `UnderLiquidAmbientSoundInstance.underwater(player)`.
pub fn under_liquid_loop(id: []const u8, random: LegacyRandom) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::ambient_loop(id, random, true, Ticking::UnderLiquidLoop { fade: 0 })
}
    /// `new UnderLiquidSubSound(player, event)`.
pub fn under_liquid_sub(id: []const u8, random: LegacyRandom) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::ambient_loop(id, random, false, Ticking::UnderLiquidSub)
}
    /// `new MinecartSoundInstance(minecart)`: silent until the cart rolls.
pub fn minecart(cart: *CartSound, random: LegacyRandom) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [x, y, z] = cart.position;
    // rust: let mut s = Self::new(
    // rust: "minecraft:entity.minecart.riding",
    // rust: NEUTRAL,
    // rust: 0.0,
    // rust: 1.0,
    // rust: random,
    // rust: true,
    // rust: 0,
    // rust: Attenuation::Linear,
    // rust: [
    // rust: f64::from(x as f32),
    // rust: f64::from(y as f32),
    // rust: f64::from(z as f32),
    // rust: ],
    // rust: false,
    // rust: );
    // rust: s.can_start_silent = true;
    // rust: s.ticking = Ticking::Minecart { cart: cart.id };
    // rust: s
}
    /// `new RidingMinecartSoundInstance(player, minecart, underwater, event, 0, 0.75, 1)`.
pub fn riding_minecart(cart: *CartSound, underwater: bool, random: LegacyRandom) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = if underwater {
    // rust: "minecraft:entity.minecart.inside.underwater"
    // rust: } else {
    // rust: "minecraft:entity.minecart.inside"
}
    // rust: let mut s = Self::new(
    // rust: id,
    // rust: NEUTRAL,
    // rust: 0.0,
    // rust: 1.0,
    // rust: random,
    // rust: true,
    // rust: 0,
    // rust: Attenuation::None,
    // rust: cart.position,
    // rust: false,
    // rust: );
    // rust: s.can_start_silent = true;
    // rust: s.ticking = Ticking::RidingMinecart {
    // rust: cart: cart.id,
    // rust: underwater,
}
    // rust: s
}
    /// `new RidingEntitySoundInstance(player, happyGhast, false,
    /// HAPPY_GHAST_RIDING, happyGhast.getSoundSource(), 0, 1, 5)`, from
    /// `LocalPlayer.startRiding`.
pub fn riding_happy_ghast(ghast: *RiddenSound, random: LegacyRandom) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::riding_entity("minecraft:entity.happy_ghast.riding", ghast, false, random)
}
    /// `new RidingEntitySoundInstance(player, nautilus, true,
    /// NAUTILUS_RIDING, nautilus.getSoundSource(), 0, 1, 5)`, from
    /// `LocalPlayer.startRiding`.
pub fn riding_nautilus(nautilus: *RiddenSound, random: LegacyRandom) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::riding_entity("minecraft:entity.nautilus.riding", nautilus, true, random)
}
    // rust: fn riding_entity(
    // rust: id: &str,
    // rust: entity: &RiddenSound,
    // rust: underwater_sound: bool,
    // rust: random: LegacyRandom,
    // rust: ) -> Self {
    // rust: let mut s = Self::new(
    // rust: id,
    // rust: NEUTRAL,
    // rust: 0.0,
    // rust: 1.0,
    // rust: random,
    // rust: true,
    // rust: 0,
    // rust: Attenuation::None,
    // rust: [0.0; 3],
    // rust: false,
    // rust: );
    // rust: s.can_start_silent = true;
    // rust: s.ticking = Ticking::RidingEntity {
    // rust: entity: entity.id,
    // rust: underwater_sound,
}
    // rust: s
}
    /// `new BeeFlyingSoundInstance(bee)` (or `BeeAggressiveSoundInstance`):
    /// silent until the bee moves.
pub fn bee(bee: *MobSound, aggressive: bool, random: LegacyRandom) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = if aggressive {
    // rust: "minecraft:entity.bee.loop_aggressive"
    // rust: } else {
    // rust: "minecraft:entity.bee.loop"
}
    // rust: let [x, y, z] = bee.position;
    // rust: let mut s = Self::new(
    // rust: id,
    // rust: NEUTRAL,
    // rust: 0.0,
    // rust: 1.0,
    // rust: random,
    // rust: true,
    // rust: 0,
    // rust: Attenuation::Linear,
    // rust: [
    // rust: f64::from(x as f32),
    // rust: f64::from(y as f32),
    // rust: f64::from(z as f32),
    // rust: ],
    // rust: false,
    // rust: );
    // rust: s.can_start_silent = true;
    // rust: s.ticking = Ticking::Bee {
    // rust: bee: bee.id,
    // rust: aggressive,
}
    // rust: s
}
    /// `new GuardianAttackSoundInstance(guardian)`: the guardian's own volume
    /// and pitch until its first tick, heard everywhere.
pub fn guardian_attack(guardian: *MobSound, random: LegacyRandom) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = "minecraft:entity.guardian.attack";
    // rust: let mut s = Self::new(
    // rust: id,
    // rust: crate::settings::sound_source(id),
    // rust: 1.0,
    // rust: 1.0,
    // rust: random,
    // rust: true,
    // rust: 0,
    // rust: Attenuation::None,
    // rust: guardian.position,
    // rust: false,
    // rust: );
    // rust: s.ticking = Ticking::GuardianAttack {
    // rust: guardian: guardian.id,
}
    // rust: s
}
    /// `new SnifferSoundInstance(sniffer)`: the digging sound, which sits at
    /// the origin (`AbstractSoundInstance` leaves x, y, z at 0) until its
    /// first tick moves it to the sniffer.
pub fn sniffer(sniffer: u32, random: LegacyRandom) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut s = Self::new(
    // rust: "minecraft:entity.sniffer.digging",
    // rust: NEUTRAL,
    // rust: 1.0,
    // rust: 1.0,
    // rust: random,
    // rust: false,
    // rust: 0,
    // rust: Attenuation::Linear,
    // rust: [0.0; 3],
    // rust: false,
    // rust: );
    // rust: s.ticking = Ticking::Sniffer { sniffer };
    // rust: s
}
    /// `new ElytraOnPlayerSoundInstance(player)`: looping at volume 0.1 until
    /// its first tick.
pub fn elytra(position: [f64; 3], random: LegacyRandom) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut s = Self::new(
    // rust: "minecraft:item.elytra.flying",
    // rust: PLAYERS,
    // rust: 0.1,
    // rust: 1.0,
    // rust: random,
    // rust: true,
    // rust: 0,
    // rust: Attenuation::Linear,
    // rust: position,
    // rust: false,
    // rust: );
    // rust: s.ticking = Ticking::Elytra { time: 0 };
    // rust: s
}
pub fn tickable(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.ticking != Ticking::No
}
    /// `AbstractSoundInstance.getVolume` (after `getOrResolve`).
pub fn get_volume(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let sample = match &self.sound {
    // rust: Some(s) => s.volume.sample(&mut self.random),
    // rust: None => 1.0,
}
    // rust: self.volume * sample
}
    /// `AbstractSoundInstance.getPitch`.
pub fn get_pitch(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let sample = match &self.sound {
    // rust: Some(s) => s.pitch.sample(&mut self.random),
    // rust: None => 1.0,
}
    // rust: self.pitch * sample
}
    /// `AbstractTickableSoundInstance.stop`.
pub fn stop(self: *Self) void {
}
    // rust: self.stopped = true;
    // rust: self.looping = false;
}
    /// `TickableSoundInstance.tick`.
pub fn tick(self: *Self, ctx: *TickContext) void {
}
    // rust: match &mut self.ticking {
    // rust: Ticking::No | Ticking::Native | Ticking::MusicLayer => {}
    // rust: Ticking::EntityBound => {
    // rust: let entity = self
    // rust: .bound_entity
    // rust: .as_ref()
    // rust: .expect("entity-bound sound target")
    // rust: .state();
    // rust: if entity.removed {
    // rust: self.stop();
    // rust: } else {
    // rust: self.position = entity.position.map(|v| f64::from(v as f32));
}
}
    // rust: Ticking::BiomeLoop { fade, direction } => {
    // rust: let stop = *fade < 0;
    // rust: *fade += *direction;
    // rust: self.volume = (*fade as f32 / 40.0).clamp(0.0, 1.0);
    // rust: if stop {
    // rust: self.stop();
}
}
    // rust: Ticking::UnderLiquidLoop { fade } => {
    // rust: if !ctx.player_removed && *fade >= 0 {
    // rust: if ctx.player_underwater {
    // rust: *fade += 1;
    // rust: } else {
    // rust: *fade -= 2;
}
    // rust: *fade = (*fade).min(40);
    // rust: self.volume = 0.0f32.max((*fade as f32 / 40.0).min(1.0));
    // rust: } else {
    // rust: self.stop();
}
}
    // rust: Ticking::UnderLiquidSub => {
    // rust: if ctx.player_removed || !ctx.player_underwater {
    // rust: self.stop();
}
}
    // rust: Ticking::Minecart { cart } => {
    // rust: let id = *cart;
    // rust: let Some(cart) = ctx.carts.iter().find(|c| c.id == id) else {
    // rust: self.stop();
    // rust: return;
}
    // rust: let [x, y, z] = cart.position;
    // rust: self.position = [
    // rust: f64::from(x as f32),
    // rust: f64::from(y as f32),
    // rust: f64::from(z as f32),
    // rust: ];
                // Its own `pitch` field shadows the instance's, which stays 1.
    // rust: let speed = cart.speed as f32;
    // rust: self.volume = if speed >= 0.01 && !ctx.frozen {
    // rust: speed.clamp(0.0, 0.5) * 0.7
    // rust: } else {
    // rust: 0.0
}
}
    // rust: Ticking::Bee { bee, aggressive } => {
    // rust: let (id, aggressive) = (*bee, *aggressive);
                // canPlaySound, then shouldSwitchSounds: the other kind of
                // instance is started in this one's place.
    // rust: let Some(bee) = ctx
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .filter(|m| !m.silent && m.angry == aggressive)
    // rust: else {
    // rust: self.stop();
    // rust: return;
}
    // rust: let [x, y, z] = bee.position;
    // rust: self.position = [
    // rust: f64::from(x as f32),
    // rust: f64::from(y as f32),
    // rust: f64::from(z as f32),
    // rust: ];
    // rust: let (min, max) = if bee.baby { (1.1, 1.5) } else { (0.7, 1.1) };
    // rust: let speed = bee.speed as f32;
    // rust: if speed >= 0.01 {
                    // Mth.lerp(Mth.clamp(speed, min, max), min, max).
    // rust: self.pitch = min + speed.clamp(min, max) * (max - min);
    // rust: self.volume = speed.clamp(0.0, 0.5) * 1.2;
    // rust: } else {
    // rust: self.pitch = 0.0;
    // rust: self.volume = 0.0;
}
}
    // rust: Ticking::Elytra { time } => {
    // rust: *time += 1;
    // rust: let time = *time;
    // rust: if ctx.player_removed || (time > 20 && !ctx.player_fall_flying) {
    // rust: self.stop();
    // rust: return;
}
    // rust: let [x, y, z] = ctx.player_position;
    // rust: self.position = [
    // rust: f64::from(x as f32),
    // rust: f64::from(y as f32),
    // rust: f64::from(z as f32),
    // rust: ];
    // rust: let speed = ctx.player_speed_sqr as f32;
    // rust: self.volume = if speed >= 1.0e-7 {
    // rust: (speed / 4.0).clamp(0.0, 1.0)
    // rust: } else {
    // rust: 0.0
}
                // Silent for a second, then a second's fade in.
    // rust: if time < 20 {
    // rust: self.volume = 0.0;
    // rust: } else if time < 40 {
    // rust: self.volume *= (time - 20) as f32 / 20.0;
}
    // rust: self.pitch = if self.volume > 0.8 {
    // rust: 1.0 + (self.volume - 0.8)
    // rust: } else {
    // rust: 1.0
}
}
    // rust: Ticking::Sniffer { sniffer } => {
                // canPlaySound (`!isSilent`), then `tick`: follow the sniffer
                // while it is alive, has no target and still digs or searches.
    // rust: let id = *sniffer;
    // rust: let Some(sniffer) = ctx
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id && !m.silent && m.sniffer_digging)
    // rust: else {
    // rust: self.stop();
    // rust: return;
}
    // rust: let [x, y, z] = sniffer.position;
    // rust: self.position = [
    // rust: f64::from(x as f32),
    // rust: f64::from(y as f32),
    // rust: f64::from(z as f32),
    // rust: ];
    // rust: self.volume = 1.0;
    // rust: self.pitch = 1.0;
}
    // rust: Ticking::GuardianAttack { guardian } => {
    // rust: let id = *guardian;
                // The client's guardian never has a target of its own, so
                // only its removal or silence ends the loop.
    // rust: let Some(guardian) = ctx.mobs.iter().find(|m| m.id == id && !m.silent) else {
    // rust: self.stop();
    // rust: return;
}
    // rust: let [x, y, z] = guardian.position;
    // rust: self.position = [
    // rust: f64::from(x as f32),
    // rust: f64::from(y as f32),
    // rust: f64::from(z as f32),
    // rust: ];
    // rust: let scale = guardian.attack_scale;
    // rust: self.volume = 0.0 + 1.0 * scale * scale;
    // rust: self.pitch = 0.7 + 0.5 * scale;
}
    // rust: Ticking::RidingEntity {
    // rust: entity,
    // rust: underwater_sound,
    // rust: } => {
                // RidingEntitySoundInstance.tick: canPlaySound, then while the
                // player still rides it, volumeMin (0) when
                // `underwaterSound != entity.isUnderWater()` and else
                // `volumeAmplifier * Mth.clampedLerp(speed, volumeMin, volumeMax)`.
    // rust: let (id, underwater_sound) = (*entity, *underwater_sound);
    // rust: let Some(entity) = ctx.ridden.filter(|r| r.id == id && !r.silent) else {
    // rust: self.stop();
    // rust: return;
}
    // rust: let speed = entity.speed as f32;
    // rust: self.volume = if underwater_sound != entity.underwater || speed < 0.01 {
    // rust: 0.0
    // rust: } else {
    // rust: 5.0 * speed.clamp(0.0, 1.0)
}
}
    // rust: Ticking::RidingMinecart { cart, underwater } => {
    // rust: let (id, underwater) = (*cart, *underwater);
    // rust: let found = ctx.carts.iter().find(|c| c.id == id);
    // rust: let Some(cart) = found.filter(|c| ctx.vehicle == Some(c.id)) else {
    // rust: self.stop();
    // rust: return;
}
    // rust: if underwater != ctx.player_underwater {
    // rust: self.volume = 0.0;
    // rust: } else {
                    // Mth.clampedLerp(speed, 0, 0.75), amplified by 1.
    // rust: let speed = cart.speed as f32;
    // rust: self.volume = if speed >= 0.01 {
    // rust: if speed > 1.0 { 0.75 } else { speed * 0.75 }
    // rust: } else {
    // rust: 0.0
}
    // rust: self.position = cart.position;
}
}
}
}
    /// `LoopSoundInstance.fadeOut`.
pub fn fade_out(self: *Self) void {
}
    // rust: if let Ticking::BiomeLoop { fade, direction } = &mut self.ticking {
    // rust: *fade = (*fade).min(40);
    // rust: *direction = -1;
}
}
    /// `LoopSoundInstance.fadeIn`.
pub fn fade_in(self: *Self) void {
}
    // rust: if let Ticking::BiomeLoop { fade, direction } = &mut self.ticking {
    // rust: *fade = 0.max(*fade);
    // rust: *direction = 1;
}
}
}
/// A sound instance handle.
    // rust: pub type InstanceId = u64;
/// A backend channel (an OpenAL source).
    // rust: pub type ChannelId = u64;
/// The OpenAL side: `Channel` operations, all applied immediately.
    // rust: pub trait Backend {
    /// `Channel.create`.
pub fn create(self: *Self, streaming: bool) O;
    /// `Channel.destroy`.
pub fn destroy(self: *Self, channel: ChannelId) void;
pub fn set_pitch(self: *Self, channel: ChannelId, pitch: f32) void;
pub fn set_volume(self: *Self, channel: ChannelId, volume: f32) void;
    /// `Some(max distance)` for `linearAttenuation`, None for `disableAttenuation`.
pub fn set_attenuation(self: *Self, channel: ChannelId, linear: ?f32) void;
pub fn set_looping(self: *Self, channel: ChannelId, looping: bool) void;
pub fn set_position(self: *Self, channel: ChannelId, position: [f64; 3]) void;
pub fn set_relative(self: *Self, channel: ChannelId, relative: bool) void;
    /// Attach the sound's buffer or stream (when loaded) and play it.
pub fn start(self: *Self, channel: ChannelId, sound: *Sound, looping: bool) void;
pub fn stop(self: *Self, channel: ChannelId) void;
pub fn pause(self: *Self, channel: ChannelId) void;
pub fn unpause(self: *Self, channel: ChannelId) void;
    /// `Channel.stopped`.
pub fn stopped(self: *Self, channel: ChannelId) b;
}
/// A `SoundEventListener.onPlaySound` call.
pub const Notification = struct {
    identifier: []const u8,
    subtitle: ?[]const u8,
    position: [f64,
    relative: bool,
    looping: bool,
    range: f32,
};
/// `ChannelAccess.ChannelHandle`.
pub const Handle = struct {
    channel: ?ChannelId,
    streaming: bool,
    stopped: bool,
};
pub const SoundEngine = struct {
    registry: SoundRegistry,
    /// `loaded`: the library opened.
    loaded: bool,
    tick_count: i32,
    instances: HashMap<InstanceId,
    /// Instances their owner still refers to.
    retained: HashMap<InstanceId,
    next_instance: InstanceId,
    /// `instanceToChannel` (insertion order).
    instance_to_channel: Vec<(InstanceId,
    handles: HashMap<u64,
    next_handle: u64,
    /// `instanceBySource`.
    instance_by_source: Vec<(usize,
    gain_by_source: [f32,
    ticking: std.ArrayList(InstanceId),
    /// `queuedSounds` (insertion order).
    queued: Vec<(InstanceId,
    delete_time: HashMap<InstanceId,
    queued_tickable: std.ArrayList(InstanceId),
    used: [usize,
    limits: [usize,
    /// `Options.getSoundSourceVolume` per source (index 0 is master).
    source_volumes: [f32,
    /// A `SoundEventListener` is registered.
    listening: bool,
    /// Static channels positional sounds leave free for the ones played to the
    /// listener: 0 as vanilla, `HEARD_RESERVE` with the `uiSoundReserve` extra.
    listener_reserve: usize,
    notifications: std.ArrayList(Notification),
};
pub fn handle_channel(h: *Handle) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: h.channel
}
    // rust: impl SoundEngine {
pub fn new(registry: SoundRegistry) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: registry,
    // rust: loaded: true,
    // rust: tick_count: 0,
    // rust: instances: HashMap::new(),
    // rust: retained: HashMap::new(),
    // rust: next_instance: 1,
    // rust: instance_to_channel: Vec::new(),
    // rust: handles: HashMap::new(),
    // rust: next_handle: 1,
    // rust: instance_by_source: Vec::new(),
    // rust: gain_by_source: [1.0; 11],
    // rust: ticking: Vec::new(),
    // rust: queued: Vec::new(),
    // rust: delete_time: HashMap::new(),
    // rust: queued_tickable: Vec::new(),
    // rust: used: [0, 0],
    // rust: limits: [STATIC_CHANNELS, STREAMING_CHANNELS],
    // rust: source_volumes: [1.0; 11],
    // rust: listening: false,
    // rust: listener_reserve: 0,
    // rust: notifications: Vec::new(),
}
}
    /// Hand an instance to the engine. A retained instance stays until
    /// `release`; others go once the engine no longer refers to them.
pub fn add(self: *Self, instance: SoundInstance, retain: bool) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = self.next_instance;
    // rust: self.next_instance += 1;
    // rust: self.instances.insert(id, instance);
    // rust: if retain {
    // rust: self.retained.insert(id, ());
}
    // rust: id
}
    /// The owner drops its reference.
pub fn release(self: *Self, id: InstanceId) void {
}
    // rust: self.retained.remove(&id);
    // rust: self.collect(id);
}
pub fn referenced(self: *Self, id: InstanceId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.retained.contains_key(&id)
    // rust: || self.instance_to_channel.iter().any(|(i, _)| *i == id)
    // rust: || self.queued.iter().any(|(i, _)| *i == id)
    // rust: || self.queued_tickable.contains(&id)
    // rust: || self.ticking.contains(&id)
}
pub fn collect(self: *Self, id: InstanceId) void {
}
    // rust: if !self.referenced(id) {
    // rust: self.instances.remove(&id);
}
}
    /// Table sizes, for soak tests watching what the engine holds.
pub fn census(self: *Self) s {
    // Implementation ported from Horizon
    return undefined;
}
        // The sounds holding channels, most first: what a soak test hears.
    // rust: let mut events: HashMap<&str, usize> = HashMap::new();
    // rust: for (id, _) in &self.instance_to_channel {
    // rust: if let Some(i) = self.instances.get(id) {
    // rust: *events.entry(i.identifier.as_str()).or_default() += 1;
}
}
    // rust: let mut events: Vec<(&str, usize)> = events.into_iter().collect();
    // rust: events.sort_by(|a, b| b.1.cmp(&a.1).then(a.0.cmp(b.0)));
    // rust: events.truncate(12);
    // rust: serde_json::json!({
    // rust: "events": events,
    // rust: "instances": self.instances.len(),
    // rust: "playing": self.instance_to_channel.len(),
    // rust: "handles": self.handles.len(),
    // rust: "ticking": self.ticking.len(),
    // rust: "queued": self.queued.len(),
    // rust: "used": self.used,
    // rust: })
}
pub fn instance(self: *Self, id: InstanceId) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.instances.get(&id)
}
pub fn instance_mut(self: *Self, id: InstanceId) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.instances.get_mut(&id)
}
pub fn tick_count(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.tick_count
}
    /// `Options.getFinalSoundSourceVolume`.
pub fn final_source_volume(self: *Self, source: usize) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if source == MASTER {
    // rust: self.source_volumes[MASTER]
    // rust: } else {
    // rust: self.source_volumes[source] * self.source_volumes[MASTER]
}
}
    /// `calculateVolume(volume, source)`.
pub fn calculate_volume(self: *Self, volume: f32, source: usize) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: volume.clamp(0.0, 1.0)
    // rust: * self.final_source_volume(source).clamp(0.0, 1.0)
    // rust: * self.gain_by_source[source]
}
    /// `calculatePitch`.
pub fn calculate_pitch(pitch: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: pitch.clamp(0.5, 2.0)
}
pub fn channel_of(self: *Self, id: InstanceId) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.instance_to_channel
    // rust: .iter()
    // rust: .find(|(i, _)| *i == id)
    // rust: .map(|(_, h)| *h)
}
    /// `refreshCategoryVolume`.
pub fn refresh_category_volume(self: *Self, source: usize, backend: *mut impl Backend) void {
}
    // rust: if !self.loaded {
    // rust: return;
}
    // rust: for (id, handle) in self.instance_to_channel.clone() {
    // rust: let Some(instance) = self.instances.get_mut(&id) else {
    // rust: continue;
}
    // rust: if source == instance.source || source == MASTER {
    // rust: let (v, s) = (instance.get_volume(), instance.source);
    // rust: let volume = self.calculate_volume(v, s);
    // rust: if let Some(c) = self.handles.get(&handle).and_then(handle_channel) {
    // rust: backend.set_volume(c, volume);
}
}
}
}
    /// `updateCategoryVolume`.
pub fn update_category_volume(self: *Self, source: usize, gain: f32, backend: *mut impl Backend) void {
}
    // rust: self.gain_by_source[source] = gain.clamp(0.0, 1.0);
    // rust: self.refresh_category_volume(source, backend);
}
pub fn category_gain(self: *Self, source: usize) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.gain_by_source[source]
}
    /// Live object references used by entity-bound instances, including queued ones.
pub fn bound_entities(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.instances
    // rust: .values()
    // rust: .filter_map(|s| s.bound_entity.clone())
    // rust: .collect()
}
    /// `stop(SoundInstance)`.
pub fn stop(self: *Self, id: InstanceId, backend: *mut impl Backend) void {
}
    // rust: if !self.loaded {
    // rust: return;
}
    // rust: if let Some(handle) = self.channel_of(id)
    // rust: && let Some(c) = self.handles.get(&handle).and_then(handle_channel)
    // rust: {
    // rust: backend.stop(c);
}
}
    /// `ChannelHandle.release`.
pub fn release_handle(self: *Self, handle: u64, backend: *mut impl Backend) void {
}
    // rust: if let Some(h) = self.handles.get_mut(&handle) {
    // rust: h.stopped = true;
    // rust: if let Some(c) = h.channel.take() {
    // rust: self.used[usize::from(h.streaming)] -= 1;
    // rust: backend.destroy(c);
}
}
}
    /// `stopAll`.
pub fn stop_all(self: *Self, backend: *mut impl Backend) void {
}
    // rust: if !self.loaded {
    // rust: return;
}
    // rust: let ids: Vec<InstanceId> = self.instances.keys().copied().collect();
    // rust: self.instance_to_channel.clear();
    // rust: let handles: Vec<u64> = self.handles.keys().copied().collect();
    // rust: for h in handles {
    // rust: self.release_handle(h, backend);
}
    // rust: self.handles.clear();
    // rust: self.queued.clear();
    // rust: self.ticking.clear();
    // rust: self.instance_by_source.clear();
    // rust: self.delete_time.clear();
    // rust: self.queued_tickable.clear();
    // rust: self.gain_by_source = [1.0; 11];
    // rust: for id in ids {
    // rust: self.collect(id);
}
}
    /// `stop(Identifier sound, SoundSource source)`.
    // rust: pub fn stop_matching(
    // rust: &mut self,
    // rust: sound: Option<&str>,
    // rust: source: Option<usize>,
    // rust: backend: &mut impl Backend,
    // rust: ) {
    // rust: let matches = |engine: &Self, id: InstanceId| {
    // rust: sound.is_none_or(|s| engine.instances.get(&id).is_some_and(|i| i.identifier == s))
}
    // rust: if let Some(source) = source {
    // rust: let ids: Vec<InstanceId> = self
    // rust: .instance_by_source
    // rust: .iter()
    // rust: .filter(|(s, _)| *s == source)
    // rust: .map(|(_, i)| *i)
    // rust: .collect();
    // rust: for id in ids {
    // rust: if matches(self, id) {
    // rust: self.stop(id, backend);
}
}
    // rust: } else if sound.is_none() {
    // rust: self.stop_all(backend);
    // rust: } else {
    // rust: let ids: Vec<InstanceId> = self.instance_to_channel.iter().map(|(i, _)| *i).collect();
    // rust: for id in ids {
    // rust: if matches(self, id) {
    // rust: self.stop(id, backend);
}
}
}
}
    /// `getRange`.
pub fn range(relative: bool, attenuation: Attenuation, distance: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !relative && attenuation != Attenuation::None {
    // rust: distance
    // rust: } else {
    // rust: f32::INFINITY
}
}
pub fn notify(self: *Self, id: InstanceId, subtitle: ?[]const u8, distance: f32) void {
}
    // rust: let Some(i) = self.instances.get(&id) else {
    // rust: return;
}
    // rust: self.notifications.push(Notification {
    // rust: identifier: i.identifier.clone(),
    // rust: subtitle,
    // rust: position: i.position,
    // rust: relative: i.relative,
    // rust: looping: i.looping,
    // rust: range: Self::range(i.relative, i.attenuation, distance),
    // rust: });
}
    /// `getOrResolve`.
pub fn resolve(self: *Self, id: InstanceId) void {
}
    // rust: let Some(instance) = self.instances.get_mut(&id) else {
    // rust: return;
}
    // rust: if instance.identifier == INTENTIONALLY_EMPTY {
    // rust: instance.sound = Some(Sound::intentionally_empty());
    // rust: instance.event = Some(None);
    // rust: return;
}
        // A caller that chose the exact sound (the Music page) resolved it
        // itself, with `sound_except`.
    // rust: if instance.chosen && instance.sound.is_some() {
    // rust: return;
}
    // rust: match self.registry.get(&instance.identifier) {
    // rust: None => {
    // rust: instance.event = None;
    // rust: instance.sound = Some(Sound::empty());
}
    // rust: Some(event) => {
    // rust: instance.event = Some(event.subtitle.clone());
    // rust: instance.sound = self
    // rust: .registry
    // rust: .sound(&instance.identifier, &mut instance.random);
}
}
}
    /// `play(SoundInstance)`.
pub fn play(self: *Self, id: InstanceId, backend: *mut impl Backend) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let result = self.play_inner(id, backend);
    // rust: self.collect(id);
    // rust: result
}
    /// Add and play an instance.
    // rust: pub fn play_new(
    // rust: &mut self,
    // rust: instance: SoundInstance,
    // rust: retain: bool,
    // rust: backend: &mut impl Backend,
    // rust: ) -> (InstanceId, PlayResult) {
    // rust: let id = self.add(instance, retain);
    // rust: (id, self.play(id, backend))
}
pub fn play_inner(self: *Self, id: InstanceId, backend: *mut impl Backend) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.loaded || !self.instances.contains_key(&id) {
    // rust: return PlayResult::NotStarted;
}
    // rust: if !self.instances[&id].can_play_sound() {
    // rust: return PlayResult::NotStarted;
}
    // rust: self.resolve(id);
    // rust: let instance = &self.instances[&id];
    // rust: let Some(subtitle) = instance.event.clone() else {
    // rust: return PlayResult::NotStarted;
}
    // rust: let sound = instance.sound.clone().unwrap_or_else(Sound::empty);
    // rust: if sound.sentinel != Sentinel::None {
    // rust: return PlayResult::NotStarted;
}
    // rust: let instance = self.instances.get_mut(&id).expect("present");
    // rust: let instance_volume = instance.get_volume();
    // rust: let attenuation_distance = sound.attenuation_distance(instance_volume);
    // rust: if self.listening {
    // rust: self.notify(id, subtitle, attenuation_distance);
}
    // rust: let instance = &self.instances[&id];
    // rust: let source = instance.source;
    // rust: let volume = self.calculate_volume(instance_volume, source);
    // rust: let mut silently = false;
    // rust: if volume == 0.0 {
    // rust: if !instance.can_start_silent && source != MUSIC {
    // rust: return PlayResult::NotStarted;
}
    // rust: silently = true;
}
    // rust: let position = instance.position;
    // rust: let looping = instance.looping && instance.delay <= 0;
    // rust: let streaming = sound.stream;
    // rust: let pool = usize::from(streaming);
        // With the `uiSoundReserve` extra, sounds out in the world leave a few static channels free, so a flood of
        // them (a crater's worth of blocks breaking) can't stop the ones played to the listener.
    // rust: let positional = !instance.relative && instance.attenuation != Attenuation::None;
    // rust: let reserved = if positional && !streaming {
    // rust: self.listener_reserve
    // rust: } else {
    // rust: 0
}
    // rust: let channel = if self.used[pool] + reserved >= self.limits[pool] {
    // rust: None
    // rust: } else {
    // rust: backend.create(streaming)
}
    // rust: let Some(channel) = channel else {
    // rust: return PlayResult::NotStarted;
}
    // rust: self.used[pool] += 1;
    // rust: let handle = self.next_handle;
    // rust: self.next_handle += 1;
    // rust: self.handles.insert(
    // rust: handle,
    // rust: Handle {
    // rust: channel: Some(channel),
    // rust: streaming,
    // rust: stopped: false,
    // rust: },
    // rust: );
    // rust: self.delete_time.insert(id, self.tick_count + 20);
    // rust: if let Some(entry) = self.instance_to_channel.iter_mut().find(|(i, _)| *i == id) {
    // rust: entry.1 = handle;
    // rust: } else {
    // rust: self.instance_to_channel.push((id, handle));
}
    // rust: if !self.instance_by_source.contains(&(source, id)) {
    // rust: self.instance_by_source.push((source, id));
}
    // rust: let instance = self.instances.get_mut(&id).expect("present");
    // rust: let pitch = Self::calculate_pitch(instance.get_pitch());
    // rust: let (attenuation, relative, tickable) =
    // rust: (instance.attenuation, instance.relative, instance.tickable());
    // rust: backend.set_pitch(channel, pitch);
    // rust: backend.set_volume(channel, volume);
    // rust: backend.set_attenuation(
    // rust: channel,
    // rust: (attenuation == Attenuation::Linear).then_some(attenuation_distance),
    // rust: );
    // rust: backend.set_looping(channel, looping && !streaming);
    // rust: backend.set_position(channel, position);
    // rust: backend.set_relative(channel, relative);
    // rust: backend.start(channel, &sound, looping);
    // rust: if tickable {
    // rust: self.ticking.push(id);
}
    // rust: if silently {
    // rust: PlayResult::StartedSilently
    // rust: } else {
    // rust: PlayResult::Started
}
}
    /// `queueTickingSound`.
pub fn queue_ticking(self: *Self, id: InstanceId) void {
}
    // rust: self.queued_tickable.push(id);
}
    /// `playDelayed`.
pub fn play_delayed(self: *Self, id: InstanceId, delay: i32) void {
}
    // rust: let at = self.tick_count + delay;
    // rust: if let Some(entry) = self.queued.iter_mut().find(|(i, _)| *i == id) {
    // rust: entry.1 = at;
    // rust: } else {
    // rust: self.queued.push((id, at));
}
}
    /// `isActive`.
pub fn is_active(self: *Self, id: InstanceId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.loaded && self.channel_of(id).is_some()
}
    /// `tick(paused)`, then `ChannelAccess.scheduleTick`.
pub fn tick(self: *Self, paused: bool, ctx: *TickContext, backend: *mut impl Backend) void {
}
    // rust: if !paused {
    // rust: self.tick_in_game(ctx, backend);
    // rust: } else {
    // rust: self.tick_music_when_paused();
}
    // rust: self.schedule_tick(backend);
}
pub fn schedule_tick(self: *Self, backend: *mut impl Backend) void {
}
    // rust: let live: Vec<(u64, ChannelId)> = self
    // rust: .handles
    // rust: .iter()
    // rust: .filter_map(|(h, handle)| handle.channel.map(|c| (*h, c)))
    // rust: .collect();
    // rust: for (h, c) in live {
    // rust: if backend.stopped(c) {
    // rust: self.release_handle(h, backend);
}
}
        // Released handles nobody maps any more.
    // rust: let mapped: Vec<u64> = self.instance_to_channel.iter().map(|(_, h)| *h).collect();
    // rust: self.handles
    // rust: .retain(|h, handle| handle.channel.is_some() || mapped.contains(h));
}
pub fn handle_stopped(self: *Self, handle: u64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.handles.get(&handle).is_none_or(|h| h.stopped)
}
pub fn tick_in_game(self: *Self, ctx: *TickContext, backend: *mut impl Backend) void {
}
    // rust: self.tick_count += 1;
    // rust: for id in std::mem::take(&mut self.queued_tickable) {
    // rust: self.play(id, backend);
}
    // rust: for id in self.ticking.clone() {
    // rust: let Some(instance) = self.instances.get(&id) else {
    // rust: continue;
}
    // rust: if !instance.can_play_sound() {
                // SoundEngine still ticks the instance after stopping its channel.
    // rust: self.stop(id, backend);
}
    // rust: let instance = self.instances.get_mut(&id).expect("present");
    // rust: instance.tick(ctx);
    // rust: if instance.stopped {
    // rust: self.stop(id, backend);
    // rust: continue;
}
    // rust: let (v, source) = (instance.get_volume(), instance.source);
    // rust: let pitch = Self::calculate_pitch(instance.get_pitch());
    // rust: let position = instance.position;
    // rust: let volume = self.calculate_volume(v, source);
    // rust: let Some(handle) = self.channel_of(id) else {
    // rust: continue;
}
    // rust: if let Some(c) = self.handles.get(&handle).and_then(handle_channel) {
    // rust: backend.set_volume(c, volume);
    // rust: backend.set_pitch(c, pitch);
    // rust: backend.set_position(c, position);
}
    // rust: let instance = self.instances.get_mut(&id).expect("present");
    // rust: if instance.looping
    // rust: && self.tick_count % 10 == 0
    // rust: && volume > 0.0
    // rust: && self.listening
    // rust: && let (Some(sound), Some(subtitle)) =
    // rust: (instance.sound.clone(), instance.event.clone())
    // rust: {
    // rust: let distance = sound.attenuation_distance(instance.get_volume());
    // rust: self.notify(id, subtitle, distance);
}
}
    // rust: let mut removed = Vec::new();
    // rust: let mut index = 0;
    // rust: while index < self.instance_to_channel.len() {
    // rust: let (id, handle) = self.instance_to_channel[index];
    // rust: if self.handle_stopped(handle)
    // rust: && self.delete_time.get(&id).copied().unwrap_or(0) <= self.tick_count
    // rust: {
    // rust: if let Some(i) = self.instances.get(&id)
    // rust: && i.looping
    // rust: && i.delay > 0
    // rust: {
    // rust: let at = self.tick_count + i.delay;
    // rust: if let Some(entry) = self.queued.iter_mut().find(|(q, _)| *q == id) {
    // rust: entry.1 = at;
    // rust: } else {
    // rust: self.queued.push((id, at));
}
}
    // rust: self.instance_to_channel.remove(index);
    // rust: self.handles.remove(&handle);
    // rust: self.delete_time.remove(&id);
    // rust: let source = self.instances.get(&id).map(|i| i.source);
    // rust: self.instance_by_source
    // rust: .retain(|e| Some(e.0) != source || e.1 != id);
    // rust: if let Some(p) = self.ticking.iter().position(|t| *t == id) {
    // rust: self.ticking.remove(p);
}
    // rust: removed.push(id);
    // rust: } else {
    // rust: index += 1;
}
}
    // rust: let mut index = 0;
    // rust: while index < self.queued.len() {
    // rust: let (id, at) = self.queued[index];
    // rust: if self.tick_count >= at {
    // rust: self.queued.remove(index);
    // rust: if let Some(i) = self.instances.get_mut(&id)
    // rust: && i.tickable()
    // rust: {
    // rust: i.tick(ctx);
}
    // rust: self.play(id, backend);
    // rust: } else {
    // rust: index += 1;
}
}
    // rust: for id in removed {
    // rust: self.collect(id);
}
}
pub fn tick_music_when_paused(self: *Self) void {
}
    // rust: let mut index = 0;
    // rust: while index < self.instance_to_channel.len() {
    // rust: let (id, handle) = self.instance_to_channel[index];
    // rust: let music = self.instances.get(&id).is_some_and(|i| i.source == MUSIC);
    // rust: if music && self.handle_stopped(handle) {
    // rust: self.instance_to_channel.remove(index);
    // rust: self.handles.remove(&handle);
    // rust: self.delete_time.remove(&id);
    // rust: self.instance_by_source
    // rust: .retain(|e| e.0 != MUSIC || e.1 != id);
    // rust: self.collect(id);
    // rust: } else {
    // rust: index += 1;
}
}
}
    /// `pauseAllExcept`.
pub fn pause_all_except(self: *Self, sources: *[usize], backend: *mut impl Backend) void {
}
    // rust: if !self.loaded {
    // rust: return;
}
    // rust: for (id, handle) in self.instance_to_channel.clone() {
    // rust: let source = self.instances.get(&id).map_or(MASTER, |i| i.source);
    // rust: if !sources.contains(&source)
    // rust: && let Some(c) = self.handles.get(&handle).and_then(handle_channel)
    // rust: {
    // rust: backend.pause(c);
}
}
}
    /// `resume`.
pub fn resume(self: *Self, backend: *mut impl Backend) void {
}
    // rust: if !self.loaded {
    // rust: return;
}
    // rust: let channels: Vec<ChannelId> = self.handles.values().filter_map(handle_channel).collect();
    // rust: for c in channels {
    // rust: backend.unpause(c);
}
}
    /// Channels in use (static, streaming).
pub fn used_channels(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.used
}
    /// The live channel of an instance.
pub fn channel(self: *Self, id: InstanceId) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.channel_of(id)
    // rust: .and_then(|h| self.handles.get(&h))
    // rust: .and_then(handle_channel)
}
    /// Instances with a channel, in insertion order.
pub fn active_instances(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.instance_to_channel.iter().map(|(i, _)| *i).collect()
}
    /// A fresh unseeded random (`RandomSource.create()`).
pub fn unseeded() L {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: LegacyRandom::new(unique_seed())
}
}
/// `RandomSupport.generateUniqueSeed`.
pub fn unique_seed() i {
    // Implementation ported from Horizon
    return undefined;
}
//     use std::sync::atomic::{AtomicI64, Ordering};
pub const UNIQUIFIER: AtomicI64 = AtomicI64::new(8_682_522_807_148_012);
    // rust: let mut current = UNIQUIFIER.load(Ordering::Relaxed);
    // rust: let next = loop {
    // rust: let next = current.wrapping_mul(1_181_783_497_276_652_981);
    // rust: match UNIQUIFIER.compare_exchange(current, next, Ordering::Relaxed, Ordering::Relaxed) {
    // rust: Ok(_) => break next,
    // rust: Err(v) => current = v,
}
}
    // rust: let nanos = std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_nanos() as i64);
    // rust: next ^ nanos
}
/// The `SoundManager` calls game code makes.
    // rust: pub trait Sounds {
pub fn engine(self: *Self) *;
    /// `SoundManager.play` of a new instance (`retain`: the caller keeps it).
pub fn play_instance(self: *Self, instance: SoundInstance, retain: bool) (;
    /// `SoundManager.play` of an instance the caller holds.
pub fn play_id(self: *Self, id: InstanceId) P;
    /// `SoundManager.stop(SoundInstance)`.
pub fn stop_instance(self: *Self, id: InstanceId) void;
    /// `SoundManager.isActive`.
pub fn is_active(self: *Self, id: InstanceId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.engine().is_active(id)
}
    /// `SoundManager.updateCategoryVolume`.
pub fn update_category_volume(self: *Self, source: usize, gain: f32) void;
    /// The caller drops its instance.
pub fn release(self: *Self, id: InstanceId) void {
}
    // rust: self.engine().release(id);
}
}
/// An engine with its backend.
pub const Bound = struct {
    engine: *'a mut SoundEngine,
    backend: *'a mut B,
};
    // rust: impl<B: Backend> Sounds for Bound<'_, B> {
pub fn engine(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.engine
}
pub fn play_instance(self: *Self, instance: SoundInstance, retain: bool) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.engine.play_new(instance, retain, self.backend)
}
pub fn play_id(self: *Self, id: InstanceId) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.engine.play(id, self.backend)
}
pub fn stop_instance(self: *Self, id: InstanceId) void {
}
    // rust: self.engine.stop(id, self.backend);
}
pub fn update_category_volume(self: *Self, source: usize, gain: f32) void {
}
    // rust: self.engine
    // rust: .update_category_volume(source, gain, self.backend);
}
}
    // rust: pub mod test_backend {
//     use super::{Backend, ChannelId};
//     use crate::sound_events::Sound;
//     use std::collections::HashMap;
    /// Channels that play until stopped.
pub const Null = struct {
    next: ChannelId,
    stopped: HashMap<ChannelId,
    volume: HashMap<ChannelId,
    pitch: HashMap<ChannelId,
    position: HashMap<ChannelId,
};
    // rust: impl Backend for Null {
pub fn create(self: *Self, _streaming: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.next += 1;
    // rust: self.stopped.insert(self.next, false);
    // rust: Some(self.next)
}
pub fn destroy(self: *Self, c: ChannelId) void {
}
    // rust: self.stopped.remove(&c);
}
pub fn set_pitch(self: *Self, c: ChannelId, value: f32) void {
}
    // rust: self.pitch.insert(c, value);
}
pub fn set_volume(self: *Self, c: ChannelId, v: f32) void {
}
    // rust: self.volume.insert(c, v);
}
pub fn set_attenuation(self: *Self, _: ChannelId, _: ?f32) void {
}
pub fn set_looping(self: *Self, _: ChannelId, _: bool) void {
}
pub fn set_position(self: *Self, c: ChannelId, value: [f64; 3]) void {
}
    // rust: self.position.insert(c, value);
}
pub fn set_relative(self: *Self, _: ChannelId, _: bool) void {
}
pub fn start(self: *Self, _: ChannelId, _: *Sound, _: bool) void {
}
pub fn stop(self: *Self, c: ChannelId) void {
}
    // rust: self.stopped.insert(c, true);
}
pub fn pause(self: *Self, _: ChannelId) void {
}
pub fn unpause(self: *Self, _: ChannelId) void {
}
pub fn stopped(self: *Self, c: ChannelId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.stopped.get(&c).copied().unwrap_or(true)
}
}
}

    // rust: mod tests {
//     use super::*;

pub fn native_owned_loop_applies_updates_and_stops_through_the_ordinary_engine() void {
}
    // rust: let mut registry = SoundRegistry::default();
    // rust: registry.add_file(
    // rust: "example",
    // rust: br#"{"loop":{"sounds":["machine/loop"]}}"#,
    // rust: &|_, _| true,
    // rust: );
    // rust: let mut engine = SoundEngine::new(registry);
    // rust: let mut backend = test_backend::Null::default();
    // rust: let mut instance = SoundInstance::new(
    // rust: "example:loop",
    // rust: 4,
    // rust: 0.1,
    // rust: 0.5,
    // rust: LegacyRandom::new(1),
    // rust: true,
    // rust: 0,
    // rust: Attenuation::None,
    // rust: [0.0; 3],
    // rust: true,
    // rust: );
    // rust: instance.ticking = Ticking::Native;
    // rust: let (id, result) = engine.play_new(instance, true, &mut backend);
    // rust: assert_eq!(result, PlayResult::Started);
    // rust: let channel = engine.channel(id).unwrap();
    // rust: assert_eq!(backend.volume[&channel], 0.1);
    // rust: let owned = engine.instance_mut(id).unwrap();
    // rust: owned.volume = 0.4;
    // rust: owned.pitch = 1.25;
    // rust: owned.position = [2.0, 3.0, 4.0];
    // rust: engine.tick(true, &TickContext::default(), &mut backend);
    // rust: assert_eq!(
    // rust: backend.volume[&channel], 0.1,
    // rust: "paused world sounds retain channel values"
    // rust: );
    // rust: assert_eq!(backend.pitch[&channel], 0.5);
    // rust: assert_eq!(backend.position[&channel], [0.0; 3]);
    // rust: engine.tick(false, &TickContext::default(), &mut backend);
    // rust: assert_eq!(backend.volume[&channel], 0.4);
    // rust: assert_eq!(backend.pitch[&channel], 1.25);
    // rust: assert_eq!(backend.position[&channel], [2.0, 3.0, 4.0]);
    // rust: let owned = engine.instance(id).unwrap();
    // rust: assert_eq!((owned.pitch, owned.position), (1.25, [2.0, 3.0, 4.0]));
    // rust: let replacement = owned.clone();
    // rust: assert!(engine.is_active(id));
    // rust: engine.stop(id, &mut backend);
    // rust: assert_eq!(backend.stopped.get(&channel), Some(&true));
    // rust: engine.tick(false, &TickContext::default(), &mut backend);
    // rust: engine.release(id);
    // rust: for _ in 0..20 {
    // rust: engine.tick(false, &TickContext::default(), &mut backend);
}
    // rust: assert!(engine.instance(id).is_none());
    // rust: assert!(!engine.is_active(id));
    // rust: assert!(!backend.stopped.contains_key(&channel));

    // rust: let (id, result) = engine.play_new(replacement, true, &mut backend);
    // rust: assert_eq!(result, PlayResult::Started);
    // rust: engine.stop_all(&mut backend);
    // rust: assert!(!engine.is_active(id));
    // rust: assert!(backend.stopped.is_empty());
    // rust: assert!(engine.instance(id).is_some(), "the owner still retains it");
    // rust: engine.release(id);
    // rust: assert!(engine.instance(id).is_none());
    // rust: assert_eq!(engine.census()["playing"], 0);
    // rust: assert_eq!(engine.census()["ticking"], 0);
    // rust: assert_eq!(engine.census()["handles"], 0);
}

pub fn happy_ghast_riding_sound_follows_the_ghast_speed() void {
}
    // rust: let ghast = RiddenSound {
    // rust: id: 7,
    // rust: speed: 0.1,
    // rust: silent: false,
    // rust: underwater: false,
}
    // rust: let mut s = SoundInstance::riding_happy_ghast(&ghast, SoundEngine::unseeded());
    // rust: assert_eq!(s.volume, 0.0);
    // rust: let mut ctx = TickContext {
    // rust: ridden: Some(ghast),
    // rust: ..TickContext::default()
}
        // 5 * clampedLerp(speed, 0, 1).
    // rust: s.tick(&ctx);
    // rust: assert!((s.volume - 0.5).abs() < 1e-6, "{}", s.volume);
    // rust: ctx.ridden = Some(RiddenSound {
    // rust: speed: 3.0,
    // rust: ..ghast
    // rust: });
    // rust: s.tick(&ctx);
    // rust: assert_eq!(s.volume, 5.0);
    // rust: ctx.ridden = Some(RiddenSound {
    // rust: speed: 0.005,
    // rust: ..ghast
    // rust: });
    // rust: s.tick(&ctx);
    // rust: assert_eq!(s.volume, 0.0);
        // Under water the ghast's sound is not the underwater one.
    // rust: ctx.ridden = Some(RiddenSound {
    // rust: underwater: true,
    // rust: ..ghast
    // rust: });
    // rust: s.tick(&ctx);
    // rust: assert_eq!(s.volume, 0.0);
    // rust: assert!(!s.stopped);
        // Off the ghast, it stops.
    // rust: ctx.ridden = None;
    // rust: s.tick(&ctx);
    // rust: assert!(s.stopped);
}

pub fn sniffer_digging_sound_follows_the_sniffer_and_stops() void {
}
    // rust: let sniffer = MobSound {
    // rust: id: 3,
    // rust: position: [10.0, 64.0, -5.0],
    // rust: speed: 0.0,
    // rust: baby: false,
    // rust: angry: false,
    // rust: silent: false,
    // rust: attack_scale: 0.0,
    // rust: sniffer_digging: true,
}
    // rust: let mut s = SoundInstance::sniffer(3, SoundEngine::unseeded());
    // rust: assert_eq!(s.position, [0.0; 3]);
    // rust: assert!(!s.looping);
    // rust: let mut ctx = TickContext {
    // rust: mobs: vec![sniffer],
    // rust: ..TickContext::default()
}
    // rust: s.tick(&ctx);
    // rust: assert_eq!(s.position, [10.0, 64.0, -5.0]);
    // rust: assert!(!s.stopped);
        // A target, a state other than digging or searching: stop.
    // rust: ctx.mobs[0].sniffer_digging = false;
    // rust: s.tick(&ctx);
    // rust: assert!(s.stopped);
        // Removed (missing): stop.
    // rust: let mut s = SoundInstance::sniffer(3, SoundEngine::unseeded());
    // rust: ctx.mobs.clear();
    // rust: s.tick(&ctx);
    // rust: assert!(s.stopped);
}

pub fn nautilus_riding_sound_plays_only_under_water() void {
}
    // rust: let nautilus = RiddenSound {
    // rust: id: 9,
    // rust: speed: 0.2,
    // rust: silent: false,
    // rust: underwater: true,
}
    // rust: let mut s = SoundInstance::riding_nautilus(&nautilus, SoundEngine::unseeded());
    // rust: let mut ctx = TickContext {
    // rust: ridden: Some(nautilus),
    // rust: ..TickContext::default()
}
    // rust: s.tick(&ctx);
    // rust: assert!((s.volume - 1.0).abs() < 1e-6, "{}", s.volume);
    // rust: ctx.ridden = Some(RiddenSound {
    // rust: underwater: false,
    // rust: ..nautilus
    // rust: });
    // rust: s.tick(&ctx);
    // rust: assert_eq!(s.volume, 0.0);
    // rust: assert!(!s.stopped);
}
    /// `AbstractSoundInstance.getOrResolve` picks the sound again each time an
    /// instance plays (a replayed instance can land on another variant, with
    /// its own volume); only a sound the caller chose stays.
pub fn an_instance_resolves_again_at_each_play_unless_its_sound_was_chosen() void {
}
    // rust: let mut registry = SoundRegistry::default();
    // rust: registry.add_file(
    // rust: "minecraft",
    // rust: br#"{"block.note": {"sounds": ["note/a", {"name": "note/b", "volume": 0.4}]}}"#,
    // rust: &|_, _| true,
    // rust: );
    // rust: let picks = |chosen: bool| {
    // rust: let mut engine = SoundEngine::new(registry.clone());
    // rust: let mut instance =
    // rust: SoundInstance::for_ui("minecraft:block.note", 1.0, 1.0, LegacyRandom::new(3));
    // rust: if chosen {
    // rust: instance.sound = registry.sound("minecraft:block.note", &mut LegacyRandom::new(3));
    // rust: instance.event = Some(None);
    // rust: instance.chosen = true;
}
    // rust: let id = engine.add(instance, true);
    // rust: let mut seen = std::collections::BTreeSet::new();
    // rust: for _ in 0..64 {
    // rust: engine.resolve(id);
    // rust: seen.insert(
    // rust: engine.instances[&id]
    // rust: .sound
    // rust: .as_ref()
    // rust: .unwrap()
    // rust: .location
    // rust: .clone(),
    // rust: );
}
    // rust: seen.len()
}
    // rust: assert_eq!(picks(false), 2, "both variants come up across plays");
    // rust: assert_eq!(picks(true), 1, "the chosen sound is kept");
}
pub fn world_sounds_leave_channels_for_the_listener_only_with_the_extra() void {
}
//         use test_backend::Null;
    // rust: let mut registry = SoundRegistry::default();
    // rust: registry.add_file(
    // rust: "minecraft",
    // rust: br#"{"block.stone.break": {"sounds": ["dig/stone1"]},
    // rust: "ui.button.click": {"sounds": ["random/click"]}}"#,
    // rust: &|_, _| true,
    // rust: );
    // rust: let random = || LegacyRandom::new(0);
    // rust: let block = |i: usize| {
    // rust: let at = [i as f64, 64.0, 0.0];
    // rust: let source = crate::settings::sound_source("minecraft:block.stone.break");
    // rust: SoundInstance::at(
    // rust: "minecraft:block.stone.break",
    // rust: source,
    // rust: 1.0,
    // rust: 1.0,
    // rust: random(),
    // rust: at,
    // rust: )
}
    // rust: let click = || SoundInstance::for_ui("minecraft:ui.button.click", 1.0, 0.25, random());
    // rust: for reserve in [0, HEARD_RESERVE] {
    // rust: let mut engine = SoundEngine::new(registry.clone());
    // rust: engine.listener_reserve = reserve;
    // rust: let mut backend = Null::default();
            // Positional sounds take the static channels the reserve leaves; then their plays fail.
    // rust: let started = (0..STATIC_CHANNELS)
    // rust: .filter(|&i| {
    // rust: engine.play_new(block(i), false, &mut backend).1 == PlayResult::Started
    // rust: })
    // rust: .count();
    // rust: assert_eq!(started, STATIC_CHANNELS - reserve);
    // rust: let heard = engine.play_new(click(), false, &mut backend).1;
    // rust: assert_eq!(
    // rust: heard == PlayResult::Started,
    // rust: reserve > 0,
    // rust: "reserve {reserve}"
    // rust: );
}
}
pub fn minecart_sound_volume_scales_with_speed_and_silences_when_stopped() void {
}
    // rust: let cart = CartSound {
    // rust: id: 42,
    // rust: position: [10.0, 64.0, 5.0],
    // rust: speed: 0.0,
}
    // rust: let mut s = SoundInstance::minecart(&cart, SoundEngine::unseeded());
    // rust: assert!(s.can_start_silent);
    // rust: assert_eq!(s.volume, 0.0);

        // Stationary cart has volume 0.
    // rust: let mut ctx = TickContext {
    // rust: carts: vec![cart],
    // rust: ..TickContext::default()
}
    // rust: s.tick(&ctx);
    // rust: assert_eq!(s.volume, 0.0);
    // rust: assert!(!s.stopped);

        // Moving cart scales volume with clamp(speed, 0, 0.5) * 0.7.
    // rust: ctx.carts[0].speed = 0.2;
    // rust: s.tick(&ctx);
    // rust: assert!((s.volume - 0.2 * 0.7).abs() < 1e-6, "volume: {}", s.volume);

    // rust: ctx.carts[0].speed = 1.0;
    // rust: s.tick(&ctx);
    // rust: assert!((s.volume - 0.5 * 0.7).abs() < 1e-6, "volume: {}", s.volume);

        // Frozen clock silences cart.
    // rust: ctx.frozen = true;
    // rust: s.tick(&ctx);
    // rust: assert_eq!(s.volume, 0.0);
    // rust: ctx.frozen = false;

        // Removing cart stops the instance.
    // rust: ctx.carts.clear();
    // rust: s.tick(&ctx);
    // rust: assert!(s.stopped);
}
pub fn riding_minecart_sound_scales_with_speed_and_switches_underwater() void {
}
    // rust: let cart = CartSound {
    // rust: id: 99,
    // rust: position: [0.0, 60.0, 0.0],
    // rust: speed: 0.4,
}
    // rust: let mut surface = SoundInstance::riding_minecart(&cart, false, SoundEngine::unseeded());
    // rust: let mut underwater = SoundInstance::riding_minecart(&cart, true, SoundEngine::unseeded());

    // rust: let mut ctx = TickContext {
    // rust: vehicle: Some(99),
    // rust: carts: vec![cart],
    // rust: player_underwater: false,
    // rust: ..TickContext::default()
}

        // Surface riding active on surface.
    // rust: surface.tick(&ctx);
    // rust: underwater.tick(&ctx);
    // rust: assert!(
    // rust: (surface.volume - 0.4 * 0.75).abs() < 1e-6,
    // rust: "{}",
    // rust: surface.volume
    // rust: );
    // rust: assert_eq!(underwater.volume, 0.0);

        // Submerged player switches active sound.
    // rust: ctx.player_underwater = true;
    // rust: surface.tick(&ctx);
    // rust: underwater.tick(&ctx);
    // rust: assert_eq!(surface.volume, 0.0);
    // rust: assert!(
    // rust: (underwater.volume - 0.4 * 0.75).abs() < 1e-6,
    // rust: "{}",
    // rust: underwater.volume
    // rust: );

        // Dismounting stops both instances.
    // rust: ctx.vehicle = None;
    // rust: surface.tick(&ctx);
    // rust: underwater.tick(&ctx);
    // rust: assert!(surface.stopped);
    // rust: assert!(underwater.stopped);
}
}

    // rust: mod entity_bound_tests {
//     use super::*;
pub fn instance(entity: SoundEntity) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: SoundInstance::entity_bound(
    // rust: "minecraft:entity.allay.item_given",
    // rust: NEUTRAL,
    // rust: 0.7,
    // rust: 1.2,
    // rust: LegacyRandom::new(42),
    // rust: entity,
    // rust: )
}
pub fn an_entity_bound_sound_tracks_float_positions_and_stops_before_the_removed_position() void {
}
    // rust: let entity = SoundEntity::new(7, [0.123456789, 64.123456789, -3.123456789], false);
    // rust: let mut sound = instance(entity.clone());
    // rust: assert_eq!(sound.position[0].to_bits(), 0x3fbf9add40000000);
    // rust: entity.update(SoundEntityState {
    // rust: position: [0.248456789, 65.25, -3.623456789],
    // rust: silent: false,
    // rust: removed: false,
    // rust: });
    // rust: sound.tick(&TickContext::default());
    // rust: assert_eq!(sound.position[0].to_bits(), 0x3fcfcd6ea0000000);
    // rust: let last = sound.position;
    // rust: entity.update(SoundEntityState {
    // rust: position: [100.0; 3],
    // rust: silent: false,
    // rust: removed: true,
    // rust: });
    // rust: sound.tick(&TickContext::default());
    // rust: assert!(sound.stopped);
    // rust: assert_eq!(sound.position, last);
}
pub fn silence_is_read_from_the_entity_including_before_a_replay() void {
}
    // rust: let entity = SoundEntity::new(7, [0.0; 3], true);
    // rust: let sound = instance(entity.clone());
    // rust: assert!(!sound.can_play_sound());
    // rust: entity.update(SoundEntityState {
    // rust: position: [0.0; 3],
    // rust: silent: false,
    // rust: removed: false,
    // rust: });
    // rust: assert!(sound.can_play_sound());
}
pub fn reusing_a_network_id_does_not_retarget_an_old_sound() void {
}
    // rust: let old = SoundEntity::new(7, [0.0; 3], false);
    // rust: let mut sound = instance(old.clone());
    // rust: old.update(SoundEntityState {
    // rust: position: [0.0; 3],
    // rust: silent: false,
    // rust: removed: true,
    // rust: });
    // rust: let replacement = SoundEntity::new(7, [10.0; 3], false);
    // rust: sound.tick(&TickContext::default());
    // rust: assert!(sound.stopped);
    // rust: assert_ne!(sound.position, replacement.state().position);
}
}
