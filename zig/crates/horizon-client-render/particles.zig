//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_particles
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Client particle engine (`ParticleEngine`, `Particle`, `SingleQuadParticle`)
//! and the vanilla particle types players see most: block crumbs, smoke,
//! flames, lava pops, drips, splashes and rain, bubbles, portal and enchant
//! glyphs, crits, hearts, villager particles, explosions, campfire smoke,
//! notes, redstone dust, totem, end rod, biome ash and spores, falling leaves,
//! spells and dragon breath. Constructors, ticks, sizes, colours and light
//! follow the vanilla classes; sprite sets come from `particles/*.json`.
// use crate::{
    // rust: blocks::{BlockFacts, Fluid},
    // rust: collisions::SceneCollisions,
    // rust: hud::Rect,
    // rust: mesher::Vertex,
    // rust: world::World,
}
// use glam::{DVec3, Quat, Vec3 as FVec3};
// use horizon_core::{
    // rust: geometry::{Aabb, Axis, Vec3, trig},
    // rust: random::{LegacyRandom, RandomSource},
}
// use horizon_protocol::entity_data::PositionSource;
// use horizon_world::block_collision::BlockCollisionRegistry;
// use std::{
    // rust: array,
    // rust: collections::{HashMap, HashSet},
    // rust: path::Path,
}

    // rust: pub use horizon_client_core::particle_type::ParticleType;
    // rust: pub use horizon_items::firework::{DYE_FIREWORK_COLORS, FireworkExplosion, FireworkShape};
    // rust: mod native;
    // rust: pub use native::{ParticleController, ParticleUpdate};

/// `ParticleOptions` with the parameters of the option classes used here.
pub const ParticleOptions = struct {
    ty: ParticleType,
    /// `BlockParticleOption`: the block's particle sprite and terrain tint.
    block: Option<([]const u8,
    /// RGB(A) for dust, spells, entity effects and tinted leaves.
    color: [f32,
    /// `DustParticleOptions.scale`, `PowerParticleOption.power`, `SpellParticleOption.power`,
    /// `SculkChargeParticleOptions.roll`, `ShriekParticleOption.delay`.
    scale: f32,
    /// `DustColorTransitionOptions.toColor` (`color` is the from colour).
    to_color: [f32,
    /// `TrailParticleOption`: the point it flies to and how many ticks it takes.
    trail: Option<([f64,
    /// `ItemParticleOption`: the particle sprite of each layer of the item's
    /// model as resolved for the ground.
    item: ?std.ArrayList([]const u8),
    /// `GeyserParticleOptions.waterBlocks` and `GeyserBaseParticleOptions`'
    /// `waterBlocks` and `burstImpulseBase` (0 where the type has none).
    geyser: Option<(i32,
    /// `VibrationParticleOption`: the listener's `PositionSource`, the point
    /// the signal flies to and its arrival time in ticks
    /// (`ParticleEngine::vibration` is the same particle).
    vibration: Option<(PositionSource,
    /// A native mod's own particle type, by its namespaced name (`mymod:spark`):
    /// `SimpleParticleType` plus the provider `particles/<name>.json` names.
    mod_particle: ?[]const u8,
};
    // rust: impl ParticleOptions {
pub fn simple(ty: ParticleType) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: ty,
    // rust: block: None,
    // rust: color: [1.0; 4],
    // rust: scale: 1.0,
    // rust: to_color: [1.0, 0.0, 0.0],
    // rust: trail: None,
    // rust: item: None,
    // rust: geyser: None,
    // rust: vibration: None,
    // rust: mod_particle: None,
}
}
    /// A native mod's `SimpleParticleType`: the sprite set of
    /// `assets/<namespace>/particles/<path>.json`, drawn as a plain billboard.
pub fn named(name: impl Into<[]const u8>) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: mod_particle: Some(name.into()),
    // rust: ..Self::simple(ParticleType::Smoke)
}
}
    /// `GeyserParticleOptions(type, waterBlocks)`.
pub fn geyser(ty: ParticleType, water_blocks: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: geyser: Some((water_blocks, 0.0)),
    // rust: ..Self::simple(ty)
}
}
    /// `GeyserBaseParticleOptions(type, waterBlocks, burstImpulseBase)`.
pub fn geyser_base(ty: ParticleType, water_blocks: i32, burst_impulse_base: f32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: geyser: Some((water_blocks, burst_impulse_base)),
    // rust: ..Self::simple(ty)
}
}
    /// `VibrationParticleOption(destination, arrivalInTicks)`: the listener's
    /// position source and the point this engine flies the signal to.
pub fn vibration(source: PositionSource, dest: [f64; 3], ticks: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: vibration: Some((source, dest, ticks)),
    // rust: ..Self::simple(ParticleType::Vibration)
}
}
    /// `ItemParticleOption`: the stack's layer particle sprites (`BreakingItemParticle`).
pub fn item(layers: std.ArrayList([]const u8)) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: item: Some(layers),
    // rust: ..Self::simple(ParticleType::Item)
}
}
    /// `DustColorTransitionOptions`.
pub fn dust_transition(from: [f32; 3], to: [f32; 3], scale: f32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: color: [from[0], from[1], from[2], 1.0],
    // rust: to_color: to,
    // rust: scale: scale.clamp(0.01, 4.0),
    // rust: ..Self::simple(ParticleType::DustColorTransition)
}
}
    /// `DustColorTransitionOptions.SCULK_TO_REDSTONE`.
pub fn sculk_to_redstone() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let rgb = |c: u32| {
    // rust: [
    // rust: ((c >> 16) & 255) as f32 / 255.0,
    // rust: ((c >> 8) & 255) as f32 / 255.0,
    // rust: (c & 255) as f32 / 255.0,
    // rust: ]
}
    // rust: Self::dust_transition(rgb(3_790_560), rgb(16_711_680), 1.0)
}
    /// `SculkChargeParticleOptions(roll)`.
pub fn sculk_charge(roll: f32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: scale: roll,
    // rust: ..Self::simple(ParticleType::SculkCharge)
}
}
    /// `ShriekParticleOption(delay)`.
pub fn shriek(delay: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: scale: delay as f32,
    // rust: ..Self::simple(ParticleType::Shriek)
}
}
    /// `TrailParticleOption(target, color, duration)`.
pub fn trail(target: [f64; 3], rgb: u32, duration: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: color: [
    // rust: ((rgb >> 16) & 255) as f32 / 255.0,
    // rust: ((rgb >> 8) & 255) as f32 / 255.0,
    // rust: (rgb & 255) as f32 / 255.0,
    // rust: 1.0,
    // rust: ],
    // rust: trail: Some((target, duration)),
    // rust: ..Self::simple(ParticleType::Trail)
}
}
pub fn block(ty: ParticleType, sprite: []const u8, tint: u32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: block: Some((sprite, tint)),
    // rust: ..Self::simple(ty)
}
}
    /// `DustParticleOptions(color, scale)`.
pub fn dust(rgb: [f32; 3], scale: f32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: color: [rgb[0], rgb[1], rgb[2], 1.0],
    // rust: scale: scale.clamp(0.01, 4.0),
    // rust: ..Self::simple(ParticleType::Dust)
}
}
pub fn colored(ty: ParticleType, rgba: [f32; 4]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: color: rgba,
    // rust: ..Self::simple(ty)
}
}
}

pub const Sprite = enum {
    /// Index into the engine's sprite table.
    Index(u32),
    /// An atlas sprite by name (block textures for terrain particles).
    Named(String),
};
pub const Size = enum {
    Fixed,
    /// `quadSize * clamp((age + a) / lifetime * 32, 0, 1)`.
    GrowIn,
    Flame,
    Lava,
    Portal,
    ReversePortal,
    /// `ShriekParticle.getQuadSize`.
    Shriek,
    /// `FireworkParticles.OverlayParticle.getQuadSize`: a sine pulse.
    Flash,
};
pub const Light = enum {
    World,
    FullBright,
    /// `LightCoordsUtil.withBlock(light, 15)`.
    Block15,
    /// `addSmoothBlockEmission` with the age fraction.
    AgeEmission,
    /// `addSmoothBlockEmission` with the age fraction to the fourth power.
    AgeEmission4,
    /// `FireflyParticle.getLightCoords`: block light fading in and out, no sky.
    Firefly,
};
pub const Behaviour = enum {
    Base,
    Controlled {,
    translucent: bool,
    // rust: },
    Mod {,
    size: [f32; 2],
    alpha: [f32; 2],
    // rust: },
    /// BaseAshSmokeParticle / Explode / Dust / Snowflake / EmissiveRising: base tick, sprite from age.
    Animated,
    Lava,
    Drip {,
    fluid: Fluid,
    stage: DripStage,
    next: Option<ParticleType>,
    sound: Option<&'static str>,
    // rust: },
    WaterDrop,
    Bubble,
    /// `SulfurBubbleParticle`: rises three blocks through still water,
    /// growing to 0.15.
    SulfurBubble {,
    y_start: f64,
    y_end: f64,
    size_start: f32,
    y_prev: f64,
    // rust: },
    /// `NoxiousGasParticle`: fades out from `fade_start` ticks of age.
    NoxiousGas {,
    fade_start: f32,
    // rust: },
    /// `NoxiousGasCloudParticle`: every second tick, a gas particle where the
    /// gas reaches.
    NoxiousGasCloud,
    /// `GeyserEruptionParticle`: the base puffs, the plume and the poofs of
    /// one eruption; `aux` is the speed its provider was given.
    GeyserEruption {,
    water_blocks: i32,
    aux: [f64; 3],
    // rust: },
    /// `GeyserPlumeParticle`: shoots up `plumeHeight` blocks, then falls back.
    GeyserPlume {,
    start_y: f64,
    max_y: f64,
    propulsion: f32,
    spray: [f32; 2],
    min_size: f32,
    max_size: f32,
    done: bool,
    // rust: },
    BubblePop,
    BubbleColumnUp,
    CurrentDown {,
    angle: f32,
    // rust: },
    SuspendedTown,
    Portal {,
    start: [f64; 3],
    // rust: },
    ReversePortal,
    FlyTowards {,
    start: [f64; 3],
    alpha: [f32; 4],
    // rust: },
    Crit,
    HugeExplosion,
    ExplosionSeed,
    /// `GustSeedParticle`: three gusts around it every `delay + 1` ticks.
    GustSeed {,
    scale: f64,
    delay: i32,
    // rust: },
    Campfire,
    SimpleAnimated {,
    fade: Option<[f32; 3]>,
    // rust: },
    /// FireworkParticles.SparkParticle.
    Spark {,
    fade: Option<[f32; 3]>,
    trail: bool,
    twinkle: bool,
    // rust: },
    Spell {,
    original_alpha: f32,
    // rust: },
    Cloud,
    Snowflake,
    Leaves {,
    rot_speed: f32,
    spin: f32,
    wind: f32,
    swirl: bool,
    flow: bool,
    flow_scale: [f64; 2],
    swirl_period: f64,
    // rust: },
    FallingDust {,
    rot_speed: f32,
    // rust: },
    DragonBreath {,
    hit_ground: bool,
    // rust: },
    /// `ShriekParticle`: waits `delay` ticks, then rises.
    Shriek {,
    delay: i32,
    // rust: },
    /// `VibrationSignalParticle`: flies to a listener.
    Vibration {,
    dest: [f64; 3],
    rot: f32,
    rot_o: f32,
    pitch: f32,
    pitch_o: f32,
    // rust: },
    /// `DustColorTransitionParticle`: from one colour to the other.
    Transition {,
    from: [f32; 3],
    to: [f32; 3],
    // rust: },
    /// `TrailParticle`: eases towards its target over its lifetime.
    Trail {,
    target: [f64; 3],
    // rust: },
    /// `SquidInkParticle`: `SimpleAnimatedParticle`, sinking through air.
    SquidInk,
    /// `FireflyParticle`: wanders, fading in and out, gone inside blocks.
    Firefly,
    /// `WakeParticle` (fishing): grows and cycles four sprites.
    Wake,
    /// `DustPlumeParticle`: gravity and friction decay every tick.
    DustPlume,
    /// `FlyStraightTowardsParticle`: from its start along its motion back to
    /// the start, the colour moving from one to the other.
    FlyStraight {,
    start: [f64; 3],
    colors: [u32; 2],
    // rust: },
};
pub const DripStage = enum {
    Hang,
    CoolingHang,
    Fall,
    FallAndLand,
    Land,
};

/// How a mod particle walks through its sprite set.
pub const ModAnimation = enum {
    /// Over its lifetime, first to last sprite.
    Age,
    /// Cycles the sprites every `frame_ticks`.
    Loop,
    /// One random sprite, kept (what a particle without `animation` does).
    Random,
    /// The first sprite, kept.
    First,
};
pub const ModBehaviour = struct {
    velocity: Option<[f64,
    /// Random extra velocity, each axis uniform in `-jitter..=jitter`.
    velocity_jitter: Option<[f64,
    animation: ?ModAnimation,
    /// Ticks per frame of the `loop` animation.
    frame_ticks: ?u16,
    gravity: ?f32,
    friction: ?f32,
    lifetime: ?i32,
    size: Option<[f32,
    alpha: Option<[f32,
};
    // rust: impl ModBehaviour {
pub fn parse(json: *serde_json::Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let behaviour: Self = serde_json::from_value(json.clone()).ok()?;
    // rust: if behaviour
    // rust: .velocity
    // rust: .is_some_and(|v| v.iter().any(|c| !c.is_finite() || c.abs() > 16.0))
    // rust: || behaviour
    // rust: .velocity_jitter
    // rust: .is_some_and(|v| v.iter().any(|c| !(0.0..=16.0).contains(c)))
    // rust: || behaviour.frame_ticks.is_some_and(|v| {
    // rust: !(1..=200).contains(&v) || behaviour.animation != Some(ModAnimation::Loop)
    // rust: })
    // rust: || behaviour
    // rust: .gravity
    // rust: .is_some_and(|v| !v.is_finite() || v.abs() > 100.0)
    // rust: || behaviour
    // rust: .friction
    // rust: .is_some_and(|v| !(0.0..=1.0).contains(&v))
    // rust: || behaviour
    // rust: .lifetime
    // rust: .is_some_and(|v| !(1..=12000).contains(&v))
    // rust: || behaviour
    // rust: .size
    // rust: .is_some_and(|v| v.iter().any(|c| !(0.0..=16.0).contains(c)))
    // rust: || behaviour
    // rust: .alpha
    // rust: .is_some_and(|v| v.iter().any(|c| !(0.0..=1.0).contains(c)))
    // rust: {
    // rust: return None;
}
    // rust: Some(behaviour)
}

    /// `spawn` is the velocity the spawn call passed; a declared velocity is added to it,
    /// with the jitter drawn from `random`.
pub fn apply(self: *Self, particle: *mut Particle, spawn: [f64; 3], random: *mut LegacyRandom) void {
}
    // rust: if self.velocity.is_some() || self.velocity_jitter.is_some() {
    // rust: let base = self.velocity.unwrap_or([0.0; 3]);
    // rust: let jitter = self.velocity_jitter.unwrap_or([0.0; 3]);
    // rust: for axis in 0..3 {
    // rust: let spread = if jitter[axis] > 0.0 {
    // rust: f64::from(random.next_float() * 2.0 - 1.0) * jitter[axis]
    // rust: } else {
    // rust: 0.0
}
    // rust: particle.velocity[axis] = base[axis] + spawn[axis] + spread;
}
}
    // rust: if let Some(gravity) = self.gravity {
    // rust: particle.gravity = gravity;
}
    // rust: if let Some(friction) = self.friction {
    // rust: particle.friction = friction;
}
    // rust: if let Some(lifetime) = self.lifetime {
    // rust: particle.lifetime = lifetime;
}
    // rust: match self.animation {
    // rust: Some(ModAnimation::Loop) => particle.frame_ticks = self.frame_ticks.unwrap_or(2),
    // rust: Some(ModAnimation::Age) => {}
            // No `animation`, `random` or `first`: the sprite chosen at spawn is kept.
    // rust: Some(ModAnimation::Random | ModAnimation::First) | None => particle.set = None,
}
    // rust: if self.size.is_some() || self.alpha.is_some() {
    // rust: let size = self.size.unwrap_or([particle.size; 2]);
    // rust: let alpha = self.alpha.unwrap_or([particle.rgba[3]; 2]);
    // rust: particle.size = size[0];
    // rust: particle.rgba[3] = alpha[0];
    // rust: particle.behaviour = Behaviour::Mod { size, alpha };
    // rust: } else if matches!(self.animation, Some(ModAnimation::Age | ModAnimation::Loop)) {
            // The tick that walks the sprite set (base tick, then `sprite_from_age`).
    // rust: particle.behaviour = Behaviour::Animated;
}
}
}

pub fn mod_curve(end]: [f32; 2], age: i32, lifetime: i32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let progress = (age as f32 / lifetime.max(1) as f32).clamp(0.0, 1.0);
    // rust: start + (end - start) * progress
}

/// One live particle (`Particle` + `SingleQuadParticle` state).
pub const Particle = struct {
    ty: ParticleType,
    position: [f64,
    previous: [f64,
    velocity: [f64,
    bb: Aabb,
    bb_width: f32,
    bb_height: f32,
    on_ground: bool,
    has_physics: bool,
    /// Particles that move without collision (`move` overridden).
    free_move: bool,
    stopped_by_collision: bool,
    removed: bool,
    age: i32,
    lifetime: i32,
    gravity: f32,
    friction: f32,
    speed_up_when_y_blocked: bool,
    /// `quadSize`.
    size: f32,
    rgba: [f32,
    roll: f32,
    o_roll: f32,
    sprite: Sprite,
    /// Age-driven sprite set (`setSpriteFromAge`).
    set: ?u32,
    /// A mod particle's `loop` animation: ticks per sprite, 0 for none.
    frame_ticks: u16,
    /// Sub-rectangle of the sprite (u0, v0, u1, v1) in 0..1.
    uv: [f32,
    size_curve: Size,
    light: Light,
    behaviour: Behaviour,
    no_render: bool,
    /// Ticked once when created (`CritParticle` constructor).
    pre_tick: bool,
    /// `Particle.random`: the particle's own generator (`RandomSource.create()`).
    random: LegacyRandom,
    controller: ?*dyn native::Controller,
};
pub fn aabb_at(p: [f64; 3], w: f32, h: f32) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let w = f64::from(w) / 2.0;
    // rust: Aabb::new(
    // rust: Vec3::new(p[0] - w, p[1], p[2] - w),
    // rust: Vec3::new(p[0] + w, p[1] + f64::from(h), p[2] + w),
    // rust: )
}
/// ClientLevel.addBreakingParticles placement, using local outline boxes.
    // rust: pub fn breaking_position(
    // rust: random: &mut impl RandomSource,
    // rust: pos: [i32; 3],
    // rust: face: [i32; 3],
    // rust: boxes: &[[f64; 6]],
    // rust: ) -> Option<[f64; 3]> {
    // rust: let mut bounds = *boxes.first()?;
    // rust: for b in &boxes[1..] {
    // rust: for i in 0..3 {
    // rust: bounds[i] = bounds[i].min(b[i]);
    // rust: bounds[i + 3] = bounds[i + 3].max(b[i + 3]);
}
}
    // Vanilla consumes all three doubles before replacing the hit-face coordinate.
    // rust: let mut p = array::from_fn(|i| {
    // rust: f64::from(pos[i])
    // rust: + random.next_double() * (bounds[i + 3] - bounds[i] - f64::from(0.2f32))
    // rust: + f64::from(0.1f32)
    // rust: + bounds[i]
    // rust: });
    // rust: for i in 0..3 {
    // rust: match face[i] {
    // rust: -1 => p[i] = f64::from(pos[i]) + bounds[i] - f64::from(0.1f32),
    // rust: 1 => p[i] = f64::from(pos[i]) + bounds[i + 3] + f64::from(0.1f32),
    // rust: _ => {}
}
}
    // rust: Some(p)
}

/// A burst of particles about an entity's box (`around_self`).
pub const Burst = struct {
    count: u32,
    /// Scale of the Gaussian speeds; `None` spawns them at rest without drawing any.
    speed: ?f64,
    /// Added to `getRandomY()`.
    y: f64,
};
    // rust: impl Burst {
    /// `AbstractVillager.addParticlesAroundSelf`.
    // rust: pub const VILLAGER: Self = Self {
    // rust: count: 5,
    // rust: speed: Some(0.02),
    // rust: y: 1.0,
}
    /// `TamableAnimal`/`AbstractHorse.spawnTamingParticles`,
    /// `Ocelot.spawnTrustingParticles`, `Animal`'s entity event 18.
    // rust: pub const TAMING: Self = Self {
    // rust: count: 7,
    // rust: speed: Some(0.02),
    // rust: y: 0.5,
}
    /// `Allay`'s entity event 18: three `spawnHeartParticle`.
    // rust: pub const ALLAY: Self = Self {
    // rust: count: 3,
    // rust: speed: Some(0.02),
    // rust: y: 0.5,
}
    /// `Dolphin.addParticlesAroundSelf`.
    // rust: pub const DOLPHIN: Self = Self {
    // rust: count: 7,
    // rust: speed: Some(0.01),
    // rust: y: 0.2,
}
    /// `AbstractHorse.handleEating`'s growth particle.
    // rust: pub const HORSE_EATING: Self = Self {
    // rust: count: 1,
    // rust: speed: None,
    // rust: y: 0.5,
}
}
/// The particle bursts entity events show on the client: the particle and
/// burst of `handleEntityEvent(event)` for the entity type `entity`.
pub fn entity_event_burst(entity: []const u8, event: u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let entity = entity.strip_prefix("minecraft:").unwrap_or(entity);
    // rust: let tamable = matches!(
    // rust: entity,
    // rust: "wolf" | "cat" | "parrot" | "nautilus" | "zombie_nautilus"
    // rust: );
    // rust: let horse = matches!(
    // rust: entity,
    // rust: "horse"
    // rust: | "donkey"
    // rust: | "mule"
    // rust: | "llama"
    // rust: | "trader_llama"
    // rust: | "camel"
    // rust: | "camel_husk"
    // rust: | "skeleton_horse"
    // rust: | "zombie_horse"
    // rust: );
    // rust: Some(match (entity, event) {
    // rust: ("villager", 12) => ("heart", Burst::VILLAGER),
    // rust: ("villager", 13) => ("angry_villager", Burst::VILLAGER),
    // rust: ("villager", 14) => ("happy_villager", Burst::VILLAGER),
    // rust: ("villager", 42) => ("splash", Burst::VILLAGER),
    // rust: ("allay", 18) => ("heart", Burst::ALLAY),
    // rust: ("dolphin", 38) => ("happy_villager", Burst::DOLPHIN),
    // rust: ("ocelot", 41) => ("heart", Burst::TAMING),
    // rust: ("ocelot", 40) => ("smoke", Burst::TAMING),
    // rust: (_, 7) if tamable || horse => ("heart", Burst::TAMING),
    // rust: (_, 6) if tamable || horse => ("smoke", Burst::TAMING),
    // rust: (_, 18) if !matches!(entity, "villager" | "allay") => ("heart", Burst::TAMING),
    // rust: _ => return None,
    // rust: })
}

/// Particles about an entity's box, as `AbstractVillager.addParticlesAroundSelf`,
/// `Animal`'s love hearts (entity event 18), `TamableAnimal` and
/// `AbstractHorse.spawnTamingParticles`, `Ocelot.spawnTrustingParticles`,
/// `Allay`'s hearts and `Dolphin.addParticlesAroundSelf` place them: `count`
/// times three Gaussian speeds scaled by `speed` (none drawn without one), then
/// `getRandomX(1.0)`, `getRandomY() + y` and `getRandomZ(1.0)`.
    // rust: pub fn around_self(
    // rust: random: &mut impl RandomSource,
    // rust: feet: [f64; 3],
    // rust: width: f64,
    // rust: height: f64,
    // rust: burst: Burst,
    // rust: mut emit: impl FnMut([f64; 3], [f64; 3]),
    // rust: ) {
    // rust: for _ in 0..burst.count {
    // rust: let v = burst.speed.map_or([0.0; 3], |s| {
    // rust: [
    // rust: random.next_gaussian() * s,
    // rust: random.next_gaussian() * s,
    // rust: random.next_gaussian() * s,
    // rust: ]
    // rust: });
    // rust: let p = [
    // rust: feet[0] + width * ((2.0 * random.next_double() - 1.0) * 1.0),
    // rust: feet[1] + height * random.next_double() + burst.y,
    // rust: feet[2] + width * ((2.0 * random.next_double() - 1.0) * 1.0),
    // rust: ];
    // rust: emit(p, v);
}
}

/// `LivingEntity.handleEntityEvent(46)`: 128 `ParticleTypes.PORTAL` samples
/// from the entity's old position (`xo`, `yo`, `zo`) to its current one,
/// spread across the bounding box (`getBbWidth() * 2` on x and z, `getBbHeight`
/// on y). The speeds are `(nextFloat() - 0.5) * 0.2`.
    // rust: pub fn living_teleport_particles(
    // rust: random: &mut impl RandomSource,
    // rust: from: [f64; 3],
    // rust: to: [f64; 3],
    // rust: width: f64,
    // rust: height: f64,
    // rust: mut emit: impl FnMut([f64; 3], [f64; 3]),
    // rust: ) {
    // rust: for i in 0..128 {
    // rust: let d = i as f64 / 127.0;
    // rust: let velocity = [0; 3].map(|_| f64::from((random.next_float() - 0.5) * 0.2));
    // rust: let position = [
    // rust: from[0] + d * (to[0] - from[0]) + (random.next_double() - 0.5) * width * 2.0,
    // rust: from[1] + d * (to[1] - from[1]) + random.next_double() * height,
    // rust: from[2] + d * (to[2] - from[2]) + (random.next_double() - 0.5) * width * 2.0,
    // rust: ];
    // rust: emit(position, velocity);
}
}

/// ClientLevel.addDestroyBlockEffect placement and pre-constructor velocities.
    // rust: pub fn destroy_positions(
    // rust: pos: [i32; 3],
    // rust: boxes: &[[f64; 6]],
    // rust: mut emit: impl FnMut([f64; 3], [f64; 3]),
    // rust: ) {
    // rust: for b in boxes {
    // rust: let widths: [f64; 3] = array::from_fn(|i| (b[i + 3] - b[i]).min(1.0));
    // rust: let counts: [usize; 3] = widths.map(|w| ((w / 0.25).ceil() as usize).max(2));
    // rust: for x in 0..counts[0] {
    // rust: for y in 0..counts[1] {
    // rust: for z in 0..counts[2] {
    // rust: let cells = [x, y, z];
    // rust: let relative: [f64; 3] =
    // rust: array::from_fn(|i| (cells[i] as f64 + 0.5) / counts[i] as f64);
    // rust: emit(
    // rust: array::from_fn(|i| f64::from(pos[i]) + (relative[i] * widths[i] + b[i])),
    // rust: relative.map(|v| v - 0.5),
    // rust: );
}
}
}
}
}

/// `LivingEntity.spawnItemParticles(stack, count)` (eating, drinking, an item
/// breaking): `count` crumbs in front of the eyes, thrown up and forwards,
/// both turned by the pitch and yaw in degrees.
    // rust: pub fn item_use_particles(
    // rust: random: &mut impl RandomSource,
    // rust: pitch: f32,
    // rust: yaw: f32,
    // rust: position: [f64; 3],
    // rust: eye_y: f64,
    // rust: count: u32,
    // rust: mut emit: impl FnMut([f64; 3], [f64; 3]),
    // rust: ) {
    // rust: let (x_rot, y_rot) = (-pitch * trig::DEG_TO_RAD, -yaw * trig::DEG_TO_RAD);
    // rust: for _ in 0..count {
    // rust: let d = Vec3::new(
    // rust: (f64::from(random.next_float()) - 0.5) * 0.1,
    // rust: f64::from(random.next_float()) * 0.1 + 0.1,
    // rust: 0.0,
    // rust: )
    // rust: .rotate_x(x_rot)
    // rust: .rotate_y(y_rot);
    // rust: let y = f64::from(-random.next_float()) * 0.6 - 0.3;
    // rust: let p = Vec3::new((f64::from(random.next_float()) - 0.5) * 0.3, y, 0.6)
    // rust: .rotate_x(x_rot)
    // rust: .rotate_y(y_rot);
    // rust: emit(
    // rust: [p.x + position[0], p.y + eye_y, p.z + position[2]],
    // rust: [d.x, d.y + 0.05, d.z],
    // rust: );
}
}

/// `Mth.nextDouble(random, min, max)`.
pub fn next_double_between(random: *mut impl RandomSource, min: f64, max: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if min >= max {
    // rust: min
    // rust: } else {
    // rust: random.next_double() * (max - min) + min
}
}
/// `ParticleUtils.spawnParticlesOnBlockFaces(level, pos, particle, UniformInt.of(3, 5))`
/// (level events 3002 without an axis, 3003 wax on, 3004 wax off, 3005 scrape):
/// three to five particles on each face, in `Direction.values()` order, moving
/// along the face at up to half a block a tick.
    // rust: pub fn on_block_faces(
    // rust: random: &mut impl RandomSource,
    // rust: pos: [i32; 3],
    // rust: emit: impl FnMut([f64; 3], [f64; 3]),
    // rust: ) {
    // rust: on_block_faces_between(random, pos, 3, 5, emit);
}
/// `ParticleUtils.spawnParticlesOnBlockFaces` with `UniformInt.of(min, max)`
/// particles per face (3009 sniffer egg cracks use 3 to 6).
    // rust: pub fn on_block_faces_between(
    // rust: random: &mut impl RandomSource,
    // rust: pos: [i32; 3],
    // rust: min: i32,
    // rust: max: i32,
    // rust: mut emit: impl FnMut([f64; 3], [f64; 3]),
    // rust: ) {
    // rust: const FACES: [[i32; 3]; 6] = [
    // rust: [0, -1, 0],
    // rust: [0, 1, 0],
    // rust: [0, 0, -1],
    // rust: [0, 0, 1],
    // rust: [-1, 0, 0],
    // rust: [1, 0, 0],
    // rust: ];
    // rust: for face in FACES {
    // rust: let count = random.next_int_bound(max - min + 1).unwrap_or(0) + min;
    // rust: for _ in 0..count {
            // getRandomSpeedRanges, then spawnParticleOnFace with step factor 0.55.
    // rust: let speed: [f64; 3] = array::from_fn(|_| next_double_between(random, -0.5, 0.5));
    // rust: let mut p = [0.0; 3];
    // rust: let mut v = [0.0; 3];
    // rust: for i in 0..3 {
    // rust: let center = f64::from(pos[i]) + 0.5;
    // rust: if face[i] == 0 {
    // rust: p[i] = center + next_double_between(random, -0.5, 0.5);
    // rust: v[i] = speed[i];
    // rust: } else {
    // rust: p[i] = center + f64::from(face[i]) * 0.55;
}
}
    // rust: emit(p, v);
}
}
}
/// `ParticleUtils.spawnParticlesAlongAxis(axis, level, pos, 0.125, particle,
/// UniformInt.of(min, max))` (`count` is the range; level event 3002 on a
/// lightning rod uses 10 to 19): sparks along the rod, moving along it.
/// `axis` is 0, 1, 2 for X, Y, Z.
    // rust: pub fn along_axis(
    // rust: random: &mut impl RandomSource,
    // rust: axis: usize,
    // rust: pos: [i32; 3],
    // rust: (min, max): (i32, i32),
    // rust: mut emit: impl FnMut([f64; 3], [f64; 3]),
    // rust: ) {
    // rust: let count = random.next_int_bound(max - min + 1).unwrap_or(0) + min;
    // rust: for _ in 0..count {
    // rust: let p: [f64; 3] = array::from_fn(|i| {
    // rust: f64::from(pos[i])
    // rust: + 0.5
    // rust: + next_double_between(random, -1.0, 1.0) * if i == axis { 0.5 } else { 0.125 }
    // rust: });
    // rust: let v: [f64; 3] = array::from_fn(|i| {
    // rust: if i == axis {
    // rust: next_double_between(random, -1.0, 1.0)
    // rust: } else {
    // rust: 0.0
}
    // rust: });
    // rust: emit(p, v);
}
}

    // rust: impl Particle {
    /// `Particle(level, x, y, z)` + `SingleQuadParticle` (no initial velocity).
pub fn at(random: *mut LegacyRandom, ty: ParticleType, p: [f64; 3]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut particle = Self::base_at(random, ty, p);
    // rust: particle.size = 0.1 * (random.next_float() * 0.5 + 0.5) * 2.0;
    // rust: particle
}
    /// `Particle(level, x, y, z)` without `SingleQuadParticle` (`NoRenderParticle`).
pub fn base_at(random: *mut LegacyRandom, ty: ParticleType, p: [f64; 3]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut particle = Self::blank(ty, p);
    // rust: particle.lifetime = (4.0 / (random.next_float() * 0.9 + 0.1)) as i32;
    // rust: particle
}
pub fn blank(ty: ParticleType, p: [f64; 3]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: ty,
    // rust: position: p,
    // rust: previous: p,
    // rust: velocity: [0.0; 3],
    // rust: bb: aabb_at(p, 0.2, 0.2),
    // rust: bb_width: 0.2,
    // rust: bb_height: 0.2,
    // rust: on_ground: false,
    // rust: has_physics: true,
    // rust: free_move: false,
    // rust: stopped_by_collision: false,
    // rust: removed: false,
    // rust: age: 0,
    // rust: lifetime: 0,
    // rust: gravity: 0.0,
    // rust: friction: 0.98,
    // rust: speed_up_when_y_blocked: false,
    // rust: size: 0.0,
    // rust: rgba: [1.0; 4],
    // rust: roll: 0.0,
    // rust: o_roll: 0.0,
    // rust: sprite: Sprite::Index(u32::MAX),
    // rust: set: None,
    // rust: uv: [0.0, 0.0, 1.0, 1.0],
    // rust: size_curve: Size::Fixed,
    // rust: light: Light::World,
    // rust: behaviour: Behaviour::Base,
    // rust: no_render: false,
    // rust: pre_tick: false,
    // rust: frame_ticks: 0,
    // rust: random: LegacyRandom::new(0),
    // rust: controller: None,
}
}
    /// The normal age/removal test and previous pose, without vanilla motion.
    /// Returns false when this tick expires the particle.
pub fn advance_age(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.previous = self.position;
    // rust: self.o_roll = self.roll;
    // rust: let alive = self.age < self.lifetime;
    // rust: self.age = self.age.saturating_add(1);
    // rust: self.removed |= !alive;
    // rust: alive
}
pub fn remove(self: *Self) void {
}
    // rust: self.removed = true;
}
    /// Hide geometry while retaining the particle's lifetime and controller.
pub fn set_visible(self: *Self, visible: bool) void {
}
    // rust: self.no_render = !visible;
}
    /// The particle's own random, distinct from the engine and level generators.
pub fn random(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &mut self.random
}
pub fn set_full_bright(self: *Self, full_bright: bool) void {
}
    // rust: self.light = if full_bright {
    // rust: Light::FullBright
    // rust: } else {
    // rust: Light::World
}
}
    /// `Particle(level, x, y, z, xa, ya, za)`: jittered, normalized initial velocity.
pub fn moving(random: *mut LegacyRandom, ty: ParticleType, p: [f64; 3], v: [f64; 3]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut particle = Self::base_moving(random, ty, p, v);
    // rust: particle.size = 0.1 * (random.next_float() * 0.5 + 0.5) * 2.0;
    // rust: particle
}
    /// `Particle(level, x, y, z, xa, ya, za)` without `SingleQuadParticle`.
pub fn base_moving(random: *mut LegacyRandom, ty: ParticleType, p: [f64; 3], v: [f64; 3]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let lifetime = (4.0 / (random.next_float() * 0.9 + 0.1)) as i32;
    // rust: let mut d = [
    // rust: v[0] + f64::from((random.next_float() * 2.0 - 1.0) * 0.4),
    // rust: v[1] + f64::from((random.next_float() * 2.0 - 1.0) * 0.4),
    // rust: v[2] + f64::from((random.next_float() * 2.0 - 1.0) * 0.4),
    // rust: ];
    // rust: let speed = f64::from((random.next_float() + random.next_float() + 1.0) * 0.15);
    // rust: let length = (d[0] * d[0] + d[1] * d[1] + d[2] * d[2]).sqrt();
    // rust: for (i, c) in d.iter_mut().enumerate() {
    // rust: *c = *c / length * speed * f64::from(0.4f32);
    // rust: if i == 1 {
    // rust: *c += f64::from(0.1f32);
}
}
    // rust: let mut particle = Self::blank(ty, p);
    // rust: particle.lifetime = lifetime;
    // rust: particle.velocity = d;
    // rust: particle
}
    /// `TerrainParticle(level, x, y, z, xa, ya, za, state)`: a crumb from a
    /// random quarter of the block's particle sprite, tinted like the block.
    // rust: pub fn terrain(
    // rust: random: &mut LegacyRandom,
    // rust: position: [f64; 3],
    // rust: velocity: [f64; 3],
    // rust: sprite: String,
    // rust: tint: u32,
    // rust: ) -> Self {
    // rust: let mut p = Self::moving(random, ParticleType::Block, position, velocity);
    // rust: p.sprite = Sprite::Named(sprite);
    // rust: p.gravity = 1.0;
    // rust: let c = |shift: u32| 0.6 * ((tint >> shift) & 255) as f32 / 255.0;
    // rust: p.rgba = [c(16), c(8), c(0), 1.0];
    // rust: p.size /= 2.0;
    // rust: let uo = random.next_float() * 3.0;
    // rust: let vo = random.next_float() * 3.0;
        // getU0 = (uo + 1) / 4, getU1 = uo / 4: the crumb is mirrored horizontally.
    // rust: p.uv = [(uo + 1.0) / 4.0, vo / 4.0, uo / 4.0, (vo + 1.0) / 4.0];
    // rust: p
}
    /// What `CritParticle`'s providers do once its constructor has ticked it.
pub fn after_constructor_tick(self: *Self) void {
}
    // rust: match self.ty {
            // MagicProvider.
    // rust: ParticleType::EnchantedHit => {
    // rust: self.rgba[0] *= 0.3;
    // rust: self.rgba[1] *= 0.8;
}
            // DamageIndicatorProvider.
    // rust: ParticleType::DamageIndicator => self.lifetime = 20,
    // rust: _ => {}
}
}
    /// `Particle.setPower`.
pub fn set_power(self: *Self, power: f32) void {
}
    // rust: let power = f64::from(power);
    // rust: self.velocity[0] *= power;
    // rust: self.velocity[1] = (self.velocity[1] - f64::from(0.1f32)) * power + f64::from(0.1f32);
    // rust: self.velocity[2] *= power;
}
    /// `SingleQuadParticle.scale` (quad and collision box).
pub fn scale(self: *Self, scale: f32) void {
}
    // rust: self.size *= scale;
    // rust: self.set_size(0.2 * scale, 0.2 * scale);
}
pub fn set_size(self: *Self, w: f32, h: f32) void {
}
    // rust: if w != self.bb_width || h != self.bb_height {
    // rust: self.bb_width = w;
    // rust: self.bb_height = h;
    // rust: let min = self.bb.min_position();
    // rust: let max = self.bb.max_position();
    // rust: let nx = (min.x + max.x - f64::from(w)) / 2.0;
    // rust: let nz = (min.z + max.z - f64::from(w)) / 2.0;
    // rust: self.bb = Aabb::new(
    // rust: Vec3::new(nx, min.y, nz),
    // rust: Vec3::new(nx + f64::from(w), min.y + f64::from(h), nz + f64::from(w)),
    // rust: );
}
}
pub fn set_pos(self: *Self, p: [f64; 3]) void {
}
    // rust: self.position = p;
    // rust: self.bb = aabb_at(p, self.bb_width, self.bb_height);
}
pub fn set_location_from_bb(self: *Self) void {
}
    // rust: let (min, max) = (self.bb.min_position(), self.bb.max_position());
    // rust: self.position = [(min.x + max.x) / 2.0, min.y, (min.z + max.z) / 2.0];
}
pub fn set_color(self: *Self, r: f32, g: f32, b: f32) void {
}
    // rust: self.rgba[0] = r;
    // rust: self.rgba[1] = g;
    // rust: self.rgba[2] = b;
}
pub fn is_alive(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !self.removed
}
    /// `Particle.move` with `Entity.collideBoundingBox` against block collision shapes.
pub fn move_by(self: *Self, level: *ParticleLevel, d: [f64; 3]) void {
}
    // rust: if self.free_move {
    // rust: self.bb = self.bb.move_by(Vec3::new(d[0], d[1], d[2]));
    // rust: self.set_location_from_bb();
    // rust: return;
}
    // rust: if self.stopped_by_collision {
    // rust: return;
}
    // rust: let original = d;
    // rust: let mut moved = d;
    // rust: let length2 = d[0] * d[0] + d[1] * d[1] + d[2] * d[2];
    // rust: if self.has_physics && length2 != 0.0 && length2 < 100.0 * 100.0 {
    // rust: moved = level.collide(self.bb, d);
}
    // rust: if moved != [0.0; 3] {
    // rust: self.bb = self.bb.move_by(Vec3::new(moved[0], moved[1], moved[2]));
    // rust: self.set_location_from_bb();
}
    // rust: if original[1].abs() >= f64::from(1.0e-5f32) && moved[1].abs() < f64::from(1.0e-5f32) {
    // rust: self.stopped_by_collision = true;
}
    // rust: self.on_ground = original[1] != moved[1] && original[1] < 0.0;
    // rust: if original[0] != moved[0] {
    // rust: self.velocity[0] = 0.0;
}
    // rust: if original[2] != moved[2] {
    // rust: self.velocity[2] = 0.0;
}
}
    /// `Particle.tick`.
pub fn base_tick(self: *Self, level: *ParticleLevel) void {
}
    // rust: self.previous = self.position;
    // rust: let age = self.age;
    // rust: self.age += 1;
    // rust: if age >= self.lifetime {
    // rust: self.removed = true;
    // rust: return;
}
    // rust: self.velocity[1] -= 0.04 * f64::from(self.gravity);
    // rust: self.move_by(level, self.velocity);
    // rust: if self.speed_up_when_y_blocked && self.position[1] == self.previous[1] {
    // rust: self.velocity[0] *= 1.1;
    // rust: self.velocity[2] *= 1.1;
}
    // rust: let f = f64::from(self.friction);
    // rust: for c in &mut self.velocity {
    // rust: *c *= f;
}
    // rust: if self.on_ground {
    // rust: self.velocity[0] *= f64::from(0.7f32);
    // rust: self.velocity[2] *= f64::from(0.7f32);
}
}
    /// `getLightCoords(a)` from the world's smooth sky and block light (0..=240).
pub fn light_coords(self: *Self, partial: f32, sky: u32, block: u32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let t = ((self.age as f32 + partial) / self.lifetime as f32).clamp(0.0, 1.0);
    // rust: match self.light {
    // rust: Light::World => (sky, block),
    // rust: Light::FullBright => (240, 240),
    // rust: Light::Block15 => (sky, 240),
    // rust: Light::AgeEmission => (sky, (block + (t * 240.0) as u32).min(240)),
    // rust: Light::AgeEmission4 => {
    // rust: let b = self.age as f32 / self.lifetime as f32;
    // rust: let b = (b * b) * (b * b);
    // rust: (sky, (block + (b.clamp(0.0, 1.0) * 240.0) as u32).min(240))
}
    // rust: Light::Firefly => (
    // rust: 0,
    // rust: (255.0 * fade_amount(self.lifetime_progress(self.age as f32 + partial), 0.1, 0.3))
    // rust: as u32,
    // rust: ),
}
}
pub fn quad_size(self: *Self, a: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let t = (self.age as f32 + a) / self.lifetime as f32;
    // rust: match self.size_curve {
    // rust: Size::Fixed => self.size,
    // rust: Size::GrowIn => self.size * (t * 32.0).clamp(0.0, 1.0),
    // rust: Size::Flame => self.size * (1.0 - t * t * 0.5),
    // rust: Size::Lava => self.size * (1.0 - t * t),
    // rust: Size::Portal => {
    // rust: let s = 1.0 - t;
    // rust: self.size * (1.0 - s * s)
}
    // rust: Size::ReversePortal => {
    // rust: self.size * (1.0 - (self.age as f32 + a) / (self.lifetime as f32 * 1.5))
}
    // rust: Size::Shriek => self.size * (t * 0.75).clamp(0.0, 1.0),
    // rust: Size::Flash => {
    // rust: 7.1 * trig::sin(f64::from(
    // rust: (self.age as f32 + a - 1.0) * 0.25 * std::f64::consts::PI as f32,
    // rust: ))
}
}
}
    /// `FireflyParticle.getLifetimeProgress`.
pub fn lifetime_progress(self: *Self, age: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (age / self.lifetime as f32).clamp(0.0, 1.0)
}
}
/// `NoxiousGasCloudParticle.pickRandomParticleSpawnPoint`: a point up to three
/// blocks from the centre of `center_block` in a random horizontal direction,
/// a quarter block lower, from the level's random.
pub fn pick_random_particle_spawn_point(random: *mut LegacyRandom, center_block: [i32; 3]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dx = f64::from(random.next_float() - 0.5);
    // rust: let dz = f64::from(random.next_float() - 0.5);
    // Vec3.normalize.
    // rust: let length = (dx * dx + dz * dz).sqrt();
    // rust: let (dx, dz) = if length < f64::from(1.0e-5f32) {
    // rust: (0.0, 0.0)
    // rust: } else {
    // rust: (dx / length, dz / length)
}
    // rust: let distance = f64::from(random.next_float() * 3.0);
    // rust: [
    // rust: f64::from(center_block[0]) + 0.5 + dx * distance,
    // rust: f64::from(center_block[1]) + 0.5 - 0.25,
    // rust: f64::from(center_block[2]) + 0.5 + dz * distance,
    // rust: ]
}
/// `FireflyParticle.getFadeAmount`.
pub fn fade_amount(progress: f32, fade_in: f32, fade_out: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if progress >= 1.0 - fade_in {
    // rust: (1.0 - progress) / fade_in
    // rust: } else if progress <= fade_out {
    // rust: progress / fade_out
    // rust: } else {
    // rust: 1.0
}
}

/// A particle's fields as the parity probe reports them.
pub const ParticleSnapshot = struct {
    age: i32,
    lifetime: i32,
    removed: bool,
    on_ground: bool,
    position: [f64,
    velocity: [f64,
    previous: [f64,
    /// `SingleQuadParticle` state; `None` for `NoRenderParticle`s.
    quad: ?QuadSnapshot,
};
/// `SingleQuadParticle` state at a render.
pub const QuadSnapshot = struct {
    /// `getQuadSize` at partial ticks 0 and 0.5.
    size: [f32,
    rgba: [f32,
    /// `roll`, `oRoll`.
    roll: [f32,
    sprite: []const u8,
    /// `getU0`, `getU1`, `getV0`, `getV1` within the sprite.
    uv: [f32,
    /// `getLightCoords(0.5)` over full sky light and no block light.
    light: u32,
};

/// World access for particle physics.
pub const ParticleLevel = struct {
    world: *'a World,
    facts: *'a BlockFacts,
    collision: *'a BlockCollisionRegistry<'a>,
    /// Local player feet position and vertical velocity (`PlayerCloudParticle`).
    player: Option<([f64,
};
    // rust: impl ParticleLevel<'_> {
pub fn collide(self: *Self, bb: Aabb, d: [f64; 3]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut scene = SceneCollisions {
    // rust: world: self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: let movement = Vec3::new(d[0], d[1], d[2]);
        // `Entity.collideBoundingBox(null, ...)`: no entity shapes, no border. Where no
        // block of the swept box's cells can collide, it finds no shape and the
        // movement stands, as the resolution below would return it.
    // rust: if scene.cells_without_collision(bb.expand_towards(movement)) {
    // rust: return d;
}
    // rust: match scene.resolve(bb, movement, 0.0, false) {
    // rust: Ok(v) => [v.x, v.y, v.z],
    // rust: Err(_) => d,
}
}
    // rust: pub(crate) fn block_at(p: [f64; 3]) -> [i32; 3] {
    // rust: [
    // rust: p[0].floor() as i32,
    // rust: p[1].floor() as i32,
    // rust: p[2].floor() as i32,
    // rust: ]
}
    /// The fluid at a block and `FluidState.getHeight`.
pub fn fluid(self: *Self, b: [i32; 3]) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let s = self.facts.get(self.world.block(b[0], b[1], b[2]));
    // rust: if s.fluid == Fluid::None {
    // rust: return (Fluid::None, 0.0);
}
    // rust: let above = self.facts.get(self.world.block(b[0], b[1] + 1, b[2]));
    // rust: let height = if above.fluid == s.fluid {
    // rust: 1.0
    // rust: } else {
    // rust: f64::from(s.fluid_level) / 9.0
}
    // rust: (s.fluid, height)
}
    /// The fluid at a block and whether it is a source (`FluidState.isSource`).
    // rust: pub(crate) fn fluid_source(&self, b: [i32; 3]) -> (Fluid, bool) {
    // rust: let s = self.facts.get(self.world.block(b[0], b[1], b[2]));
    // rust: (s.fluid, s.fluid_level == 8 && !s.fluid_falling)
}
    /// `getCollisionShape(...).max(Y, x, z)` for cached shapes.
pub fn collision_top(self: *Self, b: [i32; 3], fx: f64, fz: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let state = self.world.block(b[0], b[1], b[2]);
    // rust: match self.collision.cached_shapes().cached_shape(state) {
    // rust: Ok(Some(shape)) if !shape.is_empty() => shape.max_at(Axis::Y, fx, fz),
    // rust: Ok(Some(_)) => 0.0,
    // rust: _ => {
    // rust: if self.facts.get(state).full_collision {
    // rust: 1.0
    // rust: } else {
    // rust: 0.0
}
}
}
}
}

/// `ParticleEngine` plus the sprite sets of `ParticleResources`.
pub const ParticleEngine = struct {
    particles: std.ArrayList(Particle),
    pending: std.ArrayList(Particle),
    /// `ParticleEngine.random`, handed to every `ParticleProvider`.
    random: LegacyRandom,
    /// `ClientLevel.random` as particle constructors use it (`level.getRandom()`).
    level_random: LegacyRandom,
    /// `SpellParticle.RANDOM`.
    spell_random: LegacyRandom,
    /// The local player's eye while it looks through a spyglass in first person.
    scope_eye: Option<[f64,
    /// Seeds for each particle's own random (`RandomSource.create()`).
    seeds: LegacyRandom,
    /// When set, particles ask the level for other particles here instead
    /// (type, position, velocity), as the parity probe's stand-in level does.
    requested: Option<Vec<(ParticleOptions,
    /// When set, `create` records every particle the level is asked for here and
    /// makes none: no particle's own random is drawn and no sprite is picked, so a
    /// parity probe compares exactly what a block, fluid or entity asked for.
    created_requests: Option<Vec<(ParticleOptions,
    names: std.ArrayList([]const u8),
    rects: std.ArrayList(?Rect),
    /// Each named sprite, and whether `SingleQuadParticle.Layer.bySprite` puts
    /// it on the translucent layer (a texel with 0 < alpha < 255).
    atlas: HashMap<[]const u8,
    sets: HashMap<ParticleType,
    /// A native mod's sprite sets, by namespaced particle name.
    mod_sets: HashMap<[]const u8,
    set_sprites: std.ArrayList(Vec<u32)>,
    /// `TrackingEmitter`s: particle type, entity feet position, width, height, ticks left.
    emitters: Vec<(ParticleOptions,
    /// Camera position for the 32-block spawn limiter.
    camera: [f64,
    /// The Particles option (`ParticleStatus`): 0 all, 1 decreased, 2 minimal.
    particle_level: u8,
    /// FireworkParticles.Starter instances.
    starters: std.ArrayList(Starter),
    /// `ClientExplosionTracker` tracked explosions pending debris generation.
    tracked_explosions: std.ArrayList(TrackedExplosion),
    /// Local sounds requested by particles (dripstone drips, firework bursts):
    /// (event, position, volume, pitch, distanceDelay).
    sounds: Vec<(*'static str,
    /// How many of each type were made, for `horizon-ctl status`.
    made: std::collections::BTreeMap<*'static str,
    /// The item particles' sprites (`BreakingItemParticle`'s slime ball, snowball
    /// and cobweb models, resolved for the ground), one per model layer.
    item_sprites: HashMap<ParticleType,
};
/// `ParticleGroup.MAX_PARTICLES` (per render group; one group here).
pub const MAX_PARTICLES: usize = 16384;
/// `ParticleLimit.SPORE_BLOSSOM`, the only limited particle.
pub const SPORE_BLOSSOM_LIMIT: usize = 1000;
pub const PARTICLE_LIGHT_CACHE_SIZE: usize = 64;

pub const CachedParticleLight = struct {
    block: [i32,
    packed: u8,
};

pub const ParticleLightCache = struct {
    entries: [?CachedParticleLight,
};

    // rust: impl Default for ParticleLightCache {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: entries: [None; PARTICLE_LIGHT_CACHE_SIZE],
}
}
}

    // rust: impl ParticleLightCache {
pub fn get(self: *Self, block: [i32; 3], light_at: *dyn Fn([i32; 3]) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let hash = (block[0] as u32).wrapping_mul(73_856_093)
    // rust: ^ (block[1] as u32).wrapping_mul(19_349_663)
    // rust: ^ (block[2] as u32).wrapping_mul(83_492_791);
    // rust: let slot = hash as usize & (PARTICLE_LIGHT_CACHE_SIZE - 1);
    // rust: if let Some(entry) = self.entries[slot]
    // rust: && entry.block == block
    // rust: {
    // rust: return entry.packed;
}
    // rust: let packed = light_at(block);
    // rust: self.entries[slot] = Some(CachedParticleLight { block, packed });
    // rust: packed
}
}

pub const PARTICLE_SECTION_CACHE_SIZE: usize = 128;

pub const SectionFrustumResult = enum {
    Outside,
    Intersects,
    Inside,
};

pub const CachedSectionFrustum = struct {
    section: [i32,
    radius_quarters: i32,
    result: SectionFrustumResult,
};

pub const ParticleSectionFrustumCache = struct {
    entries: [?CachedSectionFrustum,
};

    // rust: impl Default for ParticleSectionFrustumCache {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: entries: [None; PARTICLE_SECTION_CACHE_SIZE],
}
}
}

    // rust: impl ParticleSectionFrustumCache {
    // rust: fn result(
    // rust: &mut self,
    // rust: world: [f64; 3],
    // rust: camera: DVec3,
    // rust: radius: f64,
    // rust: frustum: &crate::gfx::Frustum,
    // rust: ) -> SectionFrustumResult {
    // rust: let Some(section) = world_section(world) else {
    // rust: return SectionFrustumResult::Intersects;
}
    // rust: if !radius.is_finite() || radius < 0.0 || radius * 4.0 > f64::from(i32::MAX) {
    // rust: return SectionFrustumResult::Intersects;
}
    // rust: let radius_quarters = (radius * 4.0).ceil() as i32;
    // rust: let hash = (section[0] as u32).wrapping_mul(73_856_093)
    // rust: ^ (section[1] as u32).wrapping_mul(19_349_663)
    // rust: ^ (section[2] as u32).wrapping_mul(83_492_791)
    // rust: ^ (radius_quarters as u32).wrapping_mul(2_654_435_761);
    // rust: let slot = hash as usize & (PARTICLE_SECTION_CACHE_SIZE - 1);
    // rust: if let Some(entry) = self.entries[slot]
    // rust: && entry.section == section
    // rust: && entry.radius_quarters == radius_quarters
    // rust: {
    // rust: return entry.result;
}

    // rust: let pad = f64::from(radius_quarters) * 0.25;
    // rust: let camera = camera.to_array();
    // rust: let min = array::from_fn(|axis| f64::from(section[axis]) * 16.0 - pad - camera[axis]);
    // rust: let max = array::from_fn(|axis| min[axis] + 16.0 + 2.0 * pad);
    // rust: let result = if min.into_iter().chain(max).any(|v| !v.is_finite()) {
    // rust: SectionFrustumResult::Intersects
    // rust: } else {
    // rust: let min = FVec3::from_array(min.map(|v| v as f32));
    // rust: let max = FVec3::from_array(max.map(|v| v as f32));
    // rust: if !min.is_finite() || !max.is_finite() {
    // rust: SectionFrustumResult::Intersects
    // rust: } else if frustum.contains(min, max) {
    // rust: SectionFrustumResult::Inside
    // rust: } else if frustum.intersects(min, max) {
    // rust: SectionFrustumResult::Intersects
    // rust: } else {
    // rust: SectionFrustumResult::Outside
}
}
    // rust: self.entries[slot] = Some(CachedSectionFrustum {
    // rust: section,
    // rust: radius_quarters,
    // rust: result,
    // rust: });
    // rust: result
}
}

pub fn world_section(position: [f64; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut block = [0; 3];
    // rust: for axis in 0..3 {
    // rust: let value = position[axis].floor();
    // rust: if !value.is_finite() || value < f64::from(i32::MIN) || value > f64::from(i32::MAX) {
    // rust: return None;
}
    // rust: block[axis] = value as i32;
}
    // rust: Some([block[0] >> 4, block[1] >> 4, block[2] >> 4])
}

pub fn below_half_pixel(radius: f64, distance_squared: f64, pixel_focal_length: f32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let projected_limit = 4.0 * radius * f64::from(pixel_focal_length);
    // rust: radius.is_finite()
    // rust: && radius >= 0.0
    // rust: && distance_squared.is_finite()
    // rust: && distance_squared > 0.0
    // rust: && pixel_focal_length.is_finite()
    // rust: && pixel_focal_length > 0.0
    // rust: && projected_limit.is_finite()
    // rust: && projected_limit * projected_limit < distance_squared
}

/// `ClientExplosionTracker.ExplosionInfo`.
pub const TrackedExplosion = struct {
    center: [f64,
    radius: f32,
    block_count: usize,
};
    // rust: impl ParticleEngine {
pub fn new(root: *Path, atlas: *HashMap<[]const u8, translucent: *std.AutoHashMap([]const u8, void)) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut engine = Self {
    // rust: particles: Vec::new(),
    // rust: pending: Vec::new(),
    // rust: random: LegacyRandom::new(0x7061_7274),
    // rust: level_random: LegacyRandom::new(0x6c65_7665),
    // rust: spell_random: LegacyRandom::new(0x7370_656c),
    // rust: scope_eye: None,
    // rust: seeds: LegacyRandom::new(0x7365_6564),
    // rust: requested: None,
    // rust: created_requests: None,
    // rust: names: Vec::new(),
    // rust: rects: Vec::new(),
    // rust: atlas: HashMap::new(),
    // rust: sets: HashMap::new(),
    // rust: mod_sets: HashMap::new(),
    // rust: set_sprites: Vec::new(),
    // rust: emitters: Vec::new(),
    // rust: starters: Vec::new(),
    // rust: tracked_explosions: Vec::new(),
    // rust: camera: [0.0; 3],
    // rust: particle_level: 0,
    // rust: sounds: Vec::new(),
    // rust: made: Default::default(),
    // rust: item_sprites: HashMap::new(),
}
    // rust: engine.reload(root, atlas, translucent);
    // rust: engine
}
    /// `onResourceManagerReload`: sprite rects and sets come from the
    /// reloaded atlas and pack; a live particle keeps drawing its sprite by
    /// name or index.
    // rust: pub fn reload(
    // rust: &mut self,
    // rust: root: &Path,
    // rust: atlas: &HashMap<String, Rect>,
    // rust: translucent: &HashSet<String>,
    // rust: ) {
        // Controllers' numeric sprite-set handles belong to this resource
        // generation. Discard them rather than selecting another set after reload.
    // rust: self.particles.retain(|p| p.controller.is_none());
    // rust: self.pending.retain(|p| p.controller.is_none());
    // rust: self.atlas = atlas
    // rust: .iter()
    // rust: .map(|(name, &rect)| (name.clone(), (rect, translucent.contains(name))))
    // rust: .collect();
    // rust: self.rects = self
    // rust: .names
    // rust: .iter()
    // rust: .map(|name| self.atlas.get(name).map(|&(rect, _)| rect))
    // rust: .collect();
    // rust: self.sets.clear();
    // rust: self.mod_sets.clear();
    // rust: self.set_sprites.clear();
    // rust: self.item_sprites.clear();
    // rust: self.load_sprites(root);
}
    /// The sprite sets of every `particles/*.json` under `root`: vanilla's own
    /// and a native mod's (`assets/<namespace>/particles/<name>.json`).
pub fn load_sprites(self: *Self, root: *Path) void {
}
    // rust: let assets = root.join("assets");
    // rust: if let Ok(namespaces) = std::fs::read_dir(&assets) {
    // rust: for namespace in namespaces.flatten() {
    // rust: let ns = namespace.file_name().to_string_lossy().into_owned();
    // rust: if ns == "minecraft" || !namespace.path().is_dir() {
    // rust: continue;
}
    // rust: self.load_mod_sprites(&ns, &namespace.path().join("particles"));
}
}
    // rust: let dir = root.join("assets/minecraft/particles");
    // rust: for &ty in ParticleType::ALL {
    // rust: let Ok(bytes) =
    // rust: horizon_core::prepared_files::read(&dir.join(format!("{}.json", ty.name())))
    // rust: else {
    // rust: continue;
}
    // rust: let Ok(json) = serde_json::from_slice::<serde_json::Value>(&bytes) else {
    // rust: continue;
}
    // rust: let sprites: Vec<u32> = json["textures"]
    // rust: .as_array()
    // rust: .map(|a| {
    // rust: a.iter()
    // rust: .filter_map(|t| t.as_str())
    // rust: .map(|t| {
    // rust: self.intern(&format!("particle/{}", t.trim_start_matches("minecraft:")))
    // rust: })
    // rust: .collect()
    // rust: })
    // rust: .unwrap_or_default();
    // rust: if !sprites.is_empty() {
    // rust: self.sets.insert(ty, self.set_sprites.len() as u32);
    // rust: self.set_sprites.push(sprites);
}
}
}
    /// A namespace's particle JSONs that vanilla has no type for: each becomes
    /// one sprite set under `<ns>:<file name>`.
pub fn load_mod_sprites(self: *Self, ns: []const u8, dir: *Path) void {
}
    // rust: let Ok(files) = std::fs::read_dir(dir) else {
    // rust: return;
}
    // rust: for file in files.flatten() {
    // rust: let path = file.path();
    // rust: if path.extension().is_none_or(|e| e != "json") {
    // rust: continue;
}
    // rust: let Some(stem) = path.file_stem().map(|s| s.to_string_lossy().into_owned()) else {
    // rust: continue;
}
    // rust: let key = format!("{ns}:{stem}");
    // rust: if ParticleType::from_name(&key).is_some() {
    // rust: continue;
}
    // rust: let Ok(bytes) = std::fs::read(&path) else {
    // rust: continue;
}
    // rust: let Ok(json) = serde_json::from_slice::<serde_json::Value>(&bytes) else {
    // rust: continue;
}
    // rust: let behaviour = json.get("horizon:behaviour").and_then(|value| {
    // rust: let behaviour = ModBehaviour::parse(value);
    // rust: if behaviour.is_none() {
    // rust: log::warn!("Invalid particle behaviour in {}", path.display());
}
    // rust: behaviour
    // rust: });
    // rust: let sprites: Vec<u32> = json["textures"]
    // rust: .as_array()
    // rust: .map(|a| {
    // rust: a.iter()
    // rust: .filter_map(|t| t.as_str())
    // rust: .map(|t| {
                            // A texture is `<ns>:<path>` (bare means
                            // `minecraft:`), and the atlas names a sprite
                            // `<ns>:particle/<path>` — `minecraft`'s own
                            // without its namespace.
    // rust: let name = match t.split_once(':') {
    // rust: Some(("minecraft", path)) => format!("particle/{path}"),
    // rust: Some((ns, path)) => format!("{ns}:particle/{path}"),
    // rust: None => format!("particle/{t}"),
}
    // rust: self.intern(&name)
    // rust: })
    // rust: .collect()
    // rust: })
    // rust: .unwrap_or_default();
    // rust: if !sprites.is_empty() {
    // rust: self.mod_sets
    // rust: .insert(key, (self.set_sprites.len() as u32, behaviour));
    // rust: self.set_sprites.push(sprites);
}
}
}
pub fn intern(self: *Self, name: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(i) = self.names.iter().position(|n| n == name) {
    // rust: return i as u32;
}
    // rust: self.names.push(name.to_owned());
    // rust: self.rects.push(self.atlas.get(name).map(|&(rect, _)| rect));
    // rust: (self.names.len() - 1) as u32
}
pub fn len(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.particles.len()
}
pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.particles.is_empty()
}
pub fn clear(self: *Self) void {
}
    // rust: self.emitters.clear();
    // rust: self.particles.clear();
    // rust: self.pending.clear();
}
    /// `VibrationSignalParticle`'s body: the signal leaves `from` aimed at the
    /// listener at `to` and lands there in `ticks`.
pub fn vibration_particle(from: [f64; 3], to: [f64; 3], ticks: i32) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut q = Particle::blank(ParticleType::Vibration, from);
    // rust: q.size = 0.3;
    // rust: q.lifetime = ticks;
    // rust: q.has_physics = false;
    // rust: q.light = Light::Block15;
    // rust: let d = [from[0] - to[0], from[1] - to[1], from[2] - to[2]];
    // rust: let rot = d[0].atan2(d[2]) as f32;
    // rust: let pitch = d[1].atan2((d[0] * d[0] + d[2] * d[2]).sqrt()) as f32;
    // rust: q.behaviour = Behaviour::Vibration {
    // rust: dest: to,
    // rust: rot,
    // rust: rot_o: rot,
    // rust: pitch,
    // rust: pitch_o: pitch,
}
    // rust: q
}
    /// A vibration signal flying from `from` to `to` in `ticks`
    /// (`VibrationParticleOption`), as the client's own vibration system
    /// (`VibrationSystem.Ticker`) spawns one.
pub fn vibration(self: *Self, from: [f64; 3], to: [f64; 3], ticks: i32) void {
}
    // rust: let mut q = Self::vibration_particle(from, to, ticks);
    // rust: q.set = self.set_of(ParticleType::Vibration);
    // rust: self.pending.push(q);
}
    /// `ParticleEngine.add` (via `particlesToAdd`, applied on the next tick).
pub fn push(self: *Self, particle: Particle) void {
}
    // rust: self.pending.push(particle);
}
    /// Create a named billboard with custom compiled behavior and no vanilla
    /// motion. Like `add`, respects camera distance and the Particles setting.
    /// Configure its public fields, then `push` it to the ordinary engine queue.
    /// Missing sprite sets return None. The constructor has the ordinary
    /// stationary SingleQuadParticle random size/lifetime and no velocity draws.
    // rust: pub fn controlled<C: ParticleController>(
    // rust: &mut self,
    // rust: name: &str,
    // rust: position: [f64; 3],
    // rust: translucent: bool,
    // rust: controller: C,
    // rust: ) -> Option<Particle> {
    // rust: let minimal = self.calculate_particle_level(false) == 2;
    // rust: let distance: f64 = position
    // rust: .iter()
    // rust: .zip(self.camera)
    // rust: .map(|(p, c)| (p - c).powi(2))
    // rust: .sum();
    // rust: if minimal || !distance.is_finite() || distance > 1024.0 {
    // rust: return None;
}
    // rust: let (set, _) = *self.mod_sets.get(name)?;
    // rust: let mut random = LegacyRandom::new(self.seeds.next_long());
    // rust: let mut particle = Particle::at(&mut random, ParticleType::Smoke, position);
    // rust: particle.random = random;
    // rust: particle.set = Some(set);
    // rust: particle.sprite = Sprite::Index(*self.set_sprites.get(set as usize)?.first()?);
    // rust: particle.behaviour = Behaviour::Controlled { translucent };
    // rust: particle.controller = Some(Box::new(controller));
    // rust: Some(particle)
}
    /// Choose a frame from this particle's declared sprite set.
pub fn set_sprite_frame(self: *Self, particle: *mut Particle, frame: usize) void {
}
    // rust: if let Some(sprites) = particle.set.and_then(|s| self.set_sprites.get(s as usize))
    // rust: && !sprites.is_empty()
    // rust: {
    // rust: particle.sprite = Sprite::Index(sprites[frame.min(sprites.len() - 1)]);
}
}
    /// Random generator shared by particle constructors and spawners.
pub fn random(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &mut self.random
}
    /// `ClientLevel.random` as client effects use it (`LevelEventHandler`).
pub fn level_random(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &mut self.level_random
}
    /// `ClientLevel.addParticle`: dropped beyond 32 blocks of the camera unless
    /// the type overrides the limiter, and thinned by the Particles option.
pub fn add(self: *Self, options: *ParticleOptions, p: [f64; 3], v: [f64; 3]) void {
}
    // rust: self.add_with(options, p, v, false, false);
}
    /// `ClientLevel.addParticle(particle, overrideLimiter, alwaysShow, ...)`
    /// (`doAddParticle`). `always_show` is `addAlwaysVisibleParticle`'s flag.
    // rust: pub fn add_with(
    // rust: &mut self,
    // rust: options: &ParticleOptions,
    // rust: p: [f64; 3],
    // rust: v: [f64; 3],
    // rust: override_limiter: bool,
    // rust: always_show: bool,
    // rust: ) {
    // rust: let c = self.camera;
    // rust: let d2 = (p[0] - c[0]).powi(2) + (p[1] - c[1]).powi(2) + (p[2] - c[2]).powi(2);
    // rust: if let Some(requested) = &mut self.requested {
    // rust: requested.push((options.clone(), p, v));
    // rust: return;
}
    // rust: let minimal = self.calculate_particle_level(always_show) == 2;
    // rust: if override_limiter || options.ty.override_limiter() || (d2 <= 1024.0 && !minimal) {
    // rust: self.create(options, p, v);
}
}
    /// `NoxiousGasCloudParticle.spawnNoxiousGasParticle`: the gas, as an
    /// always visible particle (`ClientLevel.addAlwaysVisibleParticle`).
pub fn spawn_noxious_gas_particle(self: *Self, pos: [f64; 3]) void {
}
    // rust: self.add_with(
    // rust: &ParticleOptions::simple(ParticleType::NoxiousGas),
    // rust: pos,
    // rust: [0.0; 3],
    // rust: false,
    // rust: true,
    // rust: );
}
    /// `ClientLevel.calculateParticleLevel`: minimal still shows one in ten
    /// always-visible particles as decreased, and decreased drops a third.
pub fn calculate_particle_level(self: *Self, always_show: bool) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut level = self.particle_level.min(2);
    // rust: if always_show && level == 2 && self.level_random.next_int_bound(10).unwrap_or(0) == 0 {
    // rust: level = 1;
}
    // rust: if level == 1 && self.level_random.next_int_bound(3).unwrap_or(0) == 0 {
    // rust: level = 2;
}
    // rust: level
}
    /// `LevelEventHandler.singleBlockTeleportationParticles` towards
    /// `BlockUtil.unpackDifferenceInPosition(from, data, radius)`: the dragon
    /// egg's event 2015 packs offsets within (16, 8, 16), a consumable's
    /// teleport (2017) within (127, 127, 127).
pub fn block_teleportation(self: *Self, from: [i32; 3], data: i32, radius: [i32; 3]) void {
}
    // rust: let to = [
    // rust: from[0].wrapping_add(((data >> 16) & 255) - radius[0]),
    // rust: from[1].wrapping_add(((data >> 8) & 255) - radius[1]),
    // rust: from[2].wrapping_add((data & 255) - radius[2]),
    // rust: ]
    // rust: .map(f64::from);
    // rust: let from = from.map(f64::from);
    // rust: let options = ParticleOptions::simple(ParticleType::Portal);
    // rust: for _ in 0..128 {
    // rust: let r = &mut self.level_random;
    // rust: let t = r.next_double();
    // rust: let velocity = array::from_fn(|_| f64::from((r.next_float() - 0.5) * 0.2));
    // rust: let position = [
    // rust: to[0] + t * (from[0] - to[0]) + (r.next_double() - 0.5) + 0.5,
    // rust: to[1] + t * (from[1] - to[1]) + r.next_double() - 0.5,
    // rust: to[2] + t * (from[2] - to[2]) + (r.next_double() - 0.5) + 0.5,
    // rust: ];
    // rust: self.add(&options, position, velocity);
}
}
    /// `LevelEventHandler.levelEvent` 2018: an enderman's portal trail from
    /// where it was (`from`) to where it went, which `data` packs within
    /// (127, 127, 127). 128 portal particles along the way, spread about the
    /// width and height of an enderman.
pub fn enderman_teleportation(self: *Self, from: [i32; 3], data: i32, particle_level: u8) void {
}
        // EntityTypes.ENDERMAN's dimensions.
pub const WIDTH: f64 = 0.6_f32 as f64;
pub const HEIGHT: f64 = 2.9_f32 as f64;
    // rust: let to = [
    // rust: from[0].wrapping_add(((data >> 16) & 255) - 127),
    // rust: from[1].wrapping_add(((data >> 8) & 255) - 127),
    // rust: from[2].wrapping_add((data & 255) - 127),
    // rust: ]
    // rust: .map(f64::from);
    // rust: let from = from.map(f64::from);
    // rust: let options = ParticleOptions::simple(ParticleType::Portal);
    // rust: for _ in 0..128 {
    // rust: let r = &mut self.level_random;
    // rust: let t = r.next_double();
    // rust: let velocity = array::from_fn(|_| f64::from((r.next_float() - 0.5) * 0.2));
            // Mth.lerp(t, to, from).
    // rust: let position = [
    // rust: to[0] + t * (from[0] - to[0]) + (r.next_double() - 0.5) * WIDTH * 2.0,
    // rust: to[1] + t * (from[1] - to[1]) + r.next_double() * HEIGHT,
    // rust: to[2] + t * (from[2] - to[2]) + (r.next_double() - 0.5) * WIDTH * 2.0,
    // rust: ];
            // The option roll shares the level random and precedes the distance check.
    // rust: let limited = match particle_level {
    // rust: 1 => r.next_int_bound(3).unwrap_or(0) == 0,
    // rust: 2 => true,
    // rust: _ => false,
}
    // rust: if !limited {
    // rust: self.add(&options, position, velocity);
}
}
}
    /// `ClientExplosionTracker.track`: queue an explosion's block count and position
    /// for debris generation during `ClientLevel.tick`.
pub fn track_explosion(self: *Self, center: [f64; 3], radius: f32, block_count: usize) void {
}
    // rust: if block_count > 0 {
    // rust: self.tracked_explosions.push(TrackedExplosion {
    // rust: center,
    // rust: radius,
    // rust: block_count,
    // rust: });
}
}
    /// `ClientPacketListener.handleExplosion` + `ClientExplosionTracker`: the
    /// explosion particle (the emitter unless `ServerExplosion.isSmall`) and
    /// debris tracked for `tick`.
    // rust: pub fn explosion(
    // rust: &mut self,
    // rust: center: [f64; 3],
    // rust: small: bool,
    // rust: block_count: usize,
    // rust: radius: f32,
    // rust: _is_air: &dyn Fn([i32; 3]) -> bool,
    // rust: ) {
    // rust: let ty = if small {
    // rust: ParticleType::Explosion
    // rust: } else {
    // rust: ParticleType::ExplosionEmitter
}
    // rust: self.add(&ParticleOptions::simple(ty), center, [1.0, 0.0, 0.0]);
    // rust: self.track_explosion(center, radius, block_count);
}
    /// `LlamaSpit.recreateFromPacket`: seven spit particles thrown ahead of a
    /// new spit, each faster than the last along x and z.
pub fn llama_spit_burst(self: *Self, at: [f64; 3], movement: [f64; 3]) void {
}
    // rust: for i in 0..7 {
    // rust: let k = 0.4 + 0.1 * f64::from(i);
    // rust: self.add(
    // rust: &ParticleOptions::simple(ParticleType::Spit),
    // rust: at,
    // rust: [movement[0] * k, movement[1], movement[2] * k],
    // rust: );
}
}
    /// `ParticleEngine.createTrackingEmitter` (crits): 16 tries per tick for
    /// three ticks inside a quarter of the entity's box, ticked once at creation.
    // rust: pub fn tracking_emitter(
    // rust: &mut self,
    // rust: options: ParticleOptions,
    // rust: feet: [f64; 3],
    // rust: width: f64,
    // rust: height: f64,
    // rust: ) {
    // rust: self.tracking_emitter_for(options, feet, width, height, 3);
}
    /// `createTrackingEmitter(entity, type, lifetime)`.
    // rust: pub fn tracking_emitter_for(
    // rust: &mut self,
    // rust: options: ParticleOptions,
    // rust: feet: [f64; 3],
    // rust: width: f64,
    // rust: height: f64,
    // rust: life: u32,
    // rust: ) {
    // rust: self.emit(&options, feet, width, height);
    // rust: if life > 1 {
    // rust: self.emitters.push((options, feet, width, height, life - 1));
}
}
pub fn emit(self: *Self, options: *ParticleOptions, feet: [f64; 3], width: f64, height: f64) void {
}
    // rust: for _ in 0..16 {
    // rust: let r = &mut self.random;
    // rust: let xa = f64::from(r.next_float() * 2.0 - 1.0);
    // rust: let ya = f64::from(r.next_float() * 2.0 - 1.0);
    // rust: let za = f64::from(r.next_float() * 2.0 - 1.0);
    // rust: if xa * xa + ya * ya + za * za <= 1.0 {
    // rust: let p = [
    // rust: feet[0] + width * xa / 4.0,
    // rust: feet[1] + height * (0.5 + ya / 4.0),
    // rust: feet[2] + width * za / 4.0,
    // rust: ];
    // rust: self.add(options, p, [xa, ya + 0.2, za]);
}
}
}
    /// Set each frame to the local player's eye while it scopes in first person.
pub fn set_scope_eye(self: *Self, eye: ?[f64; 3]) void {
}
    // rust: self.scope_eye = eye;
}
    /// `SpellParticle.isCloseToScopingPlayer`: within 3 blocks of that eye.
pub fn close_to_scoping_player(self: *Self, pos: [f64; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.scope_eye.is_some_and(|eye| {
    // rust: (eye[0] - pos[0]).powi(2) + (eye[1] - pos[1]).powi(2) + (eye[2] - pos[2]).powi(2) <= 9.0
    // rust: })
}
    /// `ClientPacketListener.handleParticleEvent` for `ServerLevel.sendParticles`.
    // rust: pub fn send_particles(
    // rust: &mut self,
    // rust: options: &ParticleOptions,
    // rust: at: [f64; 3],
    // rust: spread: [f64; 3],
    // rust: speed: f64,
    // rust: count: u32,
    // rust: ) {
    // rust: if count == 0 {
    // rust: let v = [speed * spread[0], speed * spread[1], speed * spread[2]];
    // rust: self.add(options, at, v);
    // rust: return;
}
    // rust: for _ in 0..count {
    // rust: let r = &mut self.random;
    // rust: let p = [
    // rust: at[0] + r.next_gaussian() * spread[0],
    // rust: at[1] + r.next_gaussian() * spread[1],
    // rust: at[2] + r.next_gaussian() * spread[2],
    // rust: ];
    // rust: let v = [
    // rust: r.next_gaussian() * speed,
    // rust: r.next_gaussian() * speed,
    // rust: r.next_gaussian() * speed,
    // rust: ];
    // rust: self.add(options, p, v);
}
}
    /// `ParticleEngine.createParticle`: always spawned, but `ParticleEngine.add`
    /// drops a spore blossom air particle once `ParticleLimit.SPORE_BLOSSOM` is full.
pub fn create(self: *Self, options: *ParticleOptions, p: [f64; 3], v: [f64; 3]) void {
}
    // rust: if let Some(requests) = &mut self.created_requests {
    // rust: requests.push((options.clone(), p, v));
    // rust: return;
}
    // rust: let seed = self.seeds.next_long();
    // rust: if let Some(particle) = self.make(options, p, v, seed) {
    // rust: *self.made.entry(options.ty.name()).or_default() += 1;
            // The provider has drawn, so rejecting here keeps vanilla's RNG order.
            // shortcut: counts live plus queued particles by scanning instead of
            // vanilla's counted map; use a counter if spore spawning shows in profiles.
    // rust: if particle.ty == ParticleType::SporeBlossomAir
    // rust: && self.particles.len() + self.pending.len() >= SPORE_BLOSSOM_LIMIT
    // rust: && self
    // rust: .particles
    // rust: .iter()
    // rust: .chain(self.pending.iter())
    // rust: .filter(|q| q.ty == ParticleType::SporeBlossomAir)
    // rust: .count()
    // rust: >= SPORE_BLOSSOM_LIMIT
    // rust: {
    // rust: return;
}
    // rust: self.pending.push(particle);
}
}
    /// How many particles of each type were made so far.
pub fn made(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.made
}
    /// Parity probes: seed the provider (`ParticleEngine.random`), level and
    /// `SpellParticle.RANDOM` generators.
pub fn seed_randoms(self: *Self, provider: i64, level: i64, spell: i64) void {
}
    // rust: self.random = LegacyRandom::new(provider);
    // rust: self.level_random = LegacyRandom::new(level);
    // rust: self.spell_random = LegacyRandom::new(spell);
}
    /// Parity probes: the next long of the provider, level and spell generators.
pub fn next_randoms(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [
    // rust: self.random.next_long(),
    // rust: self.level_random.next_long(),
    // rust: self.spell_random.next_long(),
    // rust: ]
}
    /// Parity probes: `ParticleProvider.createParticle` with the particle's own
    /// random seeded `seed`, ticked in its constructor where vanilla does.
    // rust: pub fn probe_create(
    // rust: &mut self,
    // rust: options: &ParticleOptions,
    // rust: p: [f64; 3],
    // rust: v: [f64; 3],
    // rust: seed: i64,
    // rust: level: &ParticleLevel,
    // rust: ) -> Option<Particle> {
    // rust: let mut particle = self.make(options, p, v, seed)?;
    // rust: if particle.pre_tick {
    // rust: particle.pre_tick = false;
    // rust: self.tick_particle(&mut particle, level);
    // rust: particle.after_constructor_tick();
}
    // rust: Some(particle)
}
    /// Parity probes: `Particle.tick`.
pub fn probe_tick(self: *Self, particle: *mut Particle, level: *ParticleLevel) void {
}
    // rust: self.tick_particle(particle, level);
}
    /// Parity probes: the state vanilla's particle fields hold.
pub fn snapshot(self: *Self, p: *Particle) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let sprite = match &p.sprite {
    // rust: Sprite::Index(i) => self.names.get(*i as usize).map_or_else(
    // rust: || "-".to_owned(),
    // rust: |n| n.strip_prefix("particle/").unwrap_or(n).to_owned(),
    // rust: ),
    // rust: Sprite::Named(n) => n.clone(),
}
    // rust: let (sky, block) = p.light_coords(0.5, 240, 0);
    // rust: ParticleSnapshot {
    // rust: age: p.age,
    // rust: lifetime: p.lifetime,
    // rust: removed: p.removed,
    // rust: on_ground: p.on_ground,
    // rust: position: p.position,
    // rust: velocity: p.velocity,
    // rust: previous: p.previous,
    // rust: quad: (!p.no_render).then(|| QuadSnapshot {
    // rust: size: [p.quad_size(0.0), p.quad_size(0.5)],
    // rust: rgba: p.rgba,
    // rust: roll: [p.roll, p.o_roll],
    // rust: sprite,
    // rust: uv: [p.uv[0], p.uv[2], p.uv[1], p.uv[3]],
    // rust: light: block | sky << 16,
    // rust: }),
}
}
    /// `SpriteSet.get(random)`.
pub fn sprite_from_set(self: *Self, ty: ParticleType) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.sets.get(&ty) {
    // rust: Some(&set) => {
    // rust: let sprites = &self.set_sprites[set as usize];
    // rust: Sprite::Index(
    // rust: sprites[self
    // rust: .random
    // rust: .next_int_bound(sprites.len() as i32)
    // rust: .unwrap_or(0) as usize],
    // rust: )
}
    // rust: None => Sprite::Index(u32::MAX),
}
}
pub fn set_of(self: *Self, ty: ParticleType) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sets.get(&ty).copied()
}
pub fn first(self: *Self, ty: ParticleType) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.set_of(ty).map_or(Sprite::Index(u32::MAX), |s| {
    // rust: Sprite::Index(self.set_sprites[s as usize][0])
    // rust: })
}
    /// `SingleQuadParticle.setSpriteFromAge`.
pub fn sprite_from_age(self: *Self, p: *mut Particle) void {
}
    // rust: if p.removed {
    // rust: return;
}
    // rust: if let Some(set) = p.set {
            // A sprite set's index can outlive the reload that rebuilt them.
    // rust: let Some(sprites) = self.set_sprites.get(set as usize) else {
    // rust: return;
}
    // rust: let lifetime = p.lifetime.max(1);
    // rust: let index = if p.frame_ticks > 0 {
    // rust: (p.age.max(0) as i64 / i64::from(p.frame_ticks)) % sprites.len() as i64
    // rust: } else {
    // rust: (p.age.max(0) as i64 * (sprites.len() as i64 - 1) / i64::from(lifetime))
    // rust: .clamp(0, sprites.len() as i64 - 1)
}
    // rust: p.sprite = Sprite::Index(sprites[index as usize]);
}
}
    /// `ParticleProvider.createParticle`: provider draws use the engine's
    /// random, constructor and tick draws the particle's own (seeded `seed`).
    // rust: fn make(
    // rust: &mut self,
    // rust: o: &ParticleOptions,
    // rust: p: [f64; 3],
    // rust: v: [f64; 3],
    // rust: seed: i64,
    // rust: ) -> Option<Particle> {
//         use ParticleType as T;
    // rust: let ty = o.ty;
        // A native mod's SimpleParticleType: vanilla's TextureSheetParticle with
        // the sprite set its particles/<name>.json names, no tint, 20..40 ticks.
    // rust: if let Some(name) = &o.mod_particle {
    // rust: let (set, behaviour) = *self.mod_sets.get(name)?;
    // rust: let mut r = LegacyRandom::new(seed);
    // rust: let mut q = Particle::moving(&mut r, ParticleType::Smoke, p, v);
    // rust: q.ty = ParticleType::Smoke;
    // rust: q.gravity = 0.0;
    // rust: q.rgba = [1.0; 4];
    // rust: q.lifetime = 20 + r.next_int_bound(20).unwrap_or(0);
    // rust: q.set = Some(set);
    // rust: let sprites = &self.set_sprites[set as usize];
    // rust: q.sprite = Sprite::Index(
    // rust: sprites[r.next_int_bound(sprites.len() as i32).unwrap_or(0) as usize],
    // rust: );
    // rust: if let Some(behaviour) = behaviour {
    // rust: behaviour.apply(&mut q, v, &mut r);
    // rust: if behaviour.animation == Some(ModAnimation::First) {
    // rust: q.sprite = Sprite::Index(sprites[0]);
}
}
    // rust: return Some(q);
}
    // rust: let set = self.set_of(ty);
    // rust: let mut local = LegacyRandom::new(seed);
    // rust: let r = &mut local;
    // rust: let mut particle = match ty {
    // rust: T::Block | T::BlockCrumble | T::DustPillar => {
    // rust: let (sprite, tint) = o.block.clone()?;
    // rust: let mut q = Particle::terrain(r, p, v, sprite, tint);
    // rust: q.ty = ty;
    // rust: let pr = &mut self.random;
    // rust: if ty == T::BlockCrumble {
    // rust: q.velocity = [0.0; 3];
    // rust: q.lifetime = pr.next_int_bound(10).unwrap_or(0) + 1;
    // rust: } else if ty == T::DustPillar {
    // rust: q.velocity = [
    // rust: pr.next_gaussian() / 30.0,
    // rust: v[1] + pr.next_gaussian() / 2.0,
    // rust: pr.next_gaussian() / 30.0,
    // rust: ];
    // rust: q.lifetime = pr.next_int_bound(20).unwrap_or(0) + 20;
}
    // rust: q
}
    // rust: T::FallingDust => {
    // rust: let (_, tint) = o.block.clone()?;
    // rust: let mut q = Particle::at(r, ty, p);
    // rust: q.set_color(
    // rust: ((tint >> 16) & 255) as f32 / 255.0,
    // rust: ((tint >> 8) & 255) as f32 / 255.0,
    // rust: (tint & 255) as f32 / 255.0,
    // rust: );
    // rust: q.size *= 0.674_999_95;
    // rust: let base = (32.0 / (r.next_float() * 0.8 + 0.2)) as i32;
    // rust: q.lifetime = ((base as f32 * 0.9) as i32).max(1);
    // rust: let rot_speed = (r.next_float() - 0.5) * 0.1;
    // rust: q.roll = r.next_float() * std::f32::consts::TAU;
    // rust: q.size_curve = Size::GrowIn;
    // rust: q.behaviour = Behaviour::FallingDust { rot_speed };
    // rust: q.set = set;
    // rust: q
}
    // rust: T::Smoke
    // rust: | T::LargeSmoke
    // rust: | T::WhiteSmoke
    // rust: | T::Ash
    // rust: | T::WhiteAsh
    // rust: | T::DustPlume
    // rust: | T::NoxiousGas
    // rust: | T::GeyserBase
    // rust: | T::GeyserPoof => {
                // BaseAshSmokeParticle(dir, xa, scale, colorRandom, maxLifetime, gravity, hasPhysics).
    // rust: let (dir, scale, color_random, max_lifetime, gravity, physics, vel) = match ty {
    // rust: T::Smoke | T::WhiteSmoke => ([0.1, 0.1, 0.1], 1.0, 0.3, 8, -0.1, true, v),
    // rust: T::LargeSmoke => ([0.1, 0.1, 0.1], 2.5, 0.3, 8, -0.1, true, v),
    // rust: T::Ash => ([0.1, -0.1, 0.1], 1.0, 0.5, 20, 0.1, false, [0.0; 3]),
                    // DustPlumeParticle: ya + 0.15F.
    // rust: T::DustPlume => (
    // rust: [0.7, 0.6, 0.7],
    // rust: 1.0,
    // rust: 0.5,
    // rust: 7,
    // rust: 0.5,
    // rust: false,
    // rust: [v[0], v[1] + f64::from(0.15f32), v[2]],
    // rust: ),
                    // NoxiousGasParticle.Provider: scale 3.
    // rust: T::NoxiousGas => ([0.1, 0.1, 0.1], 3.0, 0.3, 5, -0.02, true, v),
                    // GeyserBaseParticle: the burst impulse scales every axis.
    // rust: T::GeyserBase | T::GeyserPoof => {
    // rust: let (water_blocks, burst_impulse_base) = o.geyser?;
    // rust: let burst_impulse = burst_impulse_base + 0.25 * water_blocks as f32;
    // rust: (
    // rust: [f64::from(burst_impulse); 3],
    // rust: 3.0 + 0.125 * water_blocks as f32,
    // rust: 0.0,
    // rust: 0,
    // rust: 0.0,
    // rust: true,
    // rust: v,
    // rust: )
}
    // rust: _ => {
                        // WhiteAshParticle.Provider draws the motion.
    // rust: let pr = &mut self.random;
    // rust: let xa =
    // rust: f64::from(pr.next_float()) * -1.9 * f64::from(pr.next_float()) * 0.1;
    // rust: let ya = f64::from(pr.next_float())
    // rust: * -0.5
    // rust: * f64::from(pr.next_float())
    // rust: * 0.1
    // rust: * 5.0;
    // rust: let za =
    // rust: f64::from(pr.next_float()) * -1.9 * f64::from(pr.next_float()) * 0.1;
    // rust: ([0.1, -0.1, 0.1], 1.0, 0.0, 20, 0.0125, false, [xa, ya, za])
}
}
                // GeyserBaseParticle.Provider: a random spot half a block
                // around the point, a fifth of a block up (the provider's
                // random, as float arithmetic added to the double position).
    // rust: let p = if matches!(ty, T::GeyserBase | T::GeyserPoof) {
    // rust: let pr = &mut self.random;
    // rust: let x = p[0] + f64::from((pr.next_float() - 0.5) * 0.5);
    // rust: let y = p[1] + f64::from((pr.next_float() - 0.5) * 0.5) + f64::from(0.2f32);
    // rust: let z = p[2] + f64::from((pr.next_float() - 0.5) * 0.5);
    // rust: [x, y, z]
    // rust: } else {
    // rust: p
}
    // rust: let mut q = Particle::moving(r, ty, p, [0.0; 3]);
    // rust: q.friction = 0.96;
    // rust: q.gravity = gravity;
    // rust: q.speed_up_when_y_blocked = true;
    // rust: for i in 0..3 {
    // rust: q.velocity[i] = q.velocity[i] * f64::from(dir[i] as f32) + vel[i];
}
    // rust: let col = r.next_float() * color_random;
    // rust: q.set_color(col, col, col);
    // rust: q.size *= 0.75 * scale;
    // rust: q.lifetime = ((f64::from(max_lifetime) / (f64::from(r.next_float()) * 0.8 + 0.2)
    // rust: * f64::from(scale)) as i32)
    // rust: .max(1);
    // rust: q.has_physics = physics;
    // rust: if matches!(ty, T::WhiteSmoke | T::WhiteAsh) {
    // rust: q.set_color(186.0 / 255.0, 177.0 / 255.0, 194.0 / 255.0);
}
    // rust: q.size_curve = Size::GrowIn;
    // rust: q.behaviour = Behaviour::Animated;
    // rust: if ty == T::DustPlume {
    // rust: let shift = r.next_float() * 0.2;
    // rust: q.set_color(
    // rust: 186.0 / 255.0 - shift,
    // rust: 177.0 / 255.0 - shift,
    // rust: 194.0 / 255.0 - shift,
    // rust: );
    // rust: q.behaviour = Behaviour::DustPlume;
}
    // rust: match ty {
                    // NoxiousGasParticle: white, living `6 / (0.5 to 1) * 3`
                    // ticks, fading out over its second half.
    // rust: T::NoxiousGas => {
    // rust: q.set_color(1.0, 1.0, 1.0);
    // rust: q.lifetime = (6.0 / (f64::from(r.next_float()) * 0.5 + 0.5)
    // rust: * f64::from(3.0f32)) as i32;
    // rust: q.behaviour = Behaviour::NoxiousGas {
    // rust: fade_start: q.lifetime as f32 / 2.0,
}
}
                    // GeyserBaseParticle: white, only ever rising, 20 to 25 ticks.
    // rust: T::GeyserBase | T::GeyserPoof => {
    // rust: q.friction = 0.725;
    // rust: q.set_color(1.0, 1.0, 1.0);
    // rust: q.velocity[1] = q.velocity[1].abs();
    // rust: let lifetime_factor = 0.8 + 0.2 * self.level_random.next_float();
    // rust: q.lifetime = (25.0 * lifetime_factor) as i32;
}
    // rust: _ => {}
}
    // rust: q.set = set;
    // rust: q
}
            // NoxiousGasCloudParticle: lives 20 ticks, draws nothing itself.
    // rust: T::NoxiousGasCloud => {
    // rust: let mut q = Particle::base_at(r, ty, p);
    // rust: q.lifetime = 20;
    // rust: q.no_render = true;
    // rust: q.behaviour = Behaviour::NoxiousGasCloud;
    // rust: q
}
            // GeyserEruptionParticle: lives 20 ticks, draws nothing itself.
    // rust: T::Geyser => {
    // rust: let (water_blocks, _) = o.geyser?;
    // rust: let mut q = Particle::base_at(r, ty, p);
    // rust: q.lifetime = 20;
    // rust: q.no_render = true;
    // rust: q.behaviour = Behaviour::GeyserEruption {
    // rust: water_blocks,
    // rust: aux: v,
}
    // rust: q
}
            // GeyserPlumeParticle, after its provider's random placement.
    // rust: T::GeyserPlume => {
    // rust: let (water_blocks, _) = o.geyser?;
    // rust: let pr = &mut self.random;
    // rust: let at = [
    // rust: p[0] + f64::from((pr.next_float() - 0.5) * 0.2),
    // rust: p[1] + f64::from(pr.next_float()),
    // rust: p[2] + f64::from((pr.next_float() - 0.5) * 0.2),
    // rust: ];
    // rust: let plume_height = 5 * water_blocks.max(1);
    // rust: let mut q = Particle::moving(r, ty, at, v);
    // rust: q.has_physics = true;
    // rust: q.speed_up_when_y_blocked = true;
    // rust: q.lifetime = plume_height * 5;
    // rust: q.velocity[1] = 0.0;
    // rust: let level = &mut self.level_random;
    // rust: let spray = [
    // rust: (level.next_float() - 0.5) * 0.2,
    // rust: (level.next_float() - 0.5) * 0.2,
    // rust: ];
    // rust: q.friction = 1.0;
    // rust: let propulsion =
    // rust: (if water_blocks == 1 { 1.5 } else { 1.0 }) * plume_height as f32 * 1.45;
    // rust: q.gravity = -propulsion;
    // rust: let initial_size = q.size * 0.75;
    // rust: let min_size = initial_size * (2.0 + plume_height as f32 / 8.0);
    // rust: let max_size = initial_size * (3.0 + plume_height as f32 / 8.0);
    // rust: q.size = min_size;
    // rust: q.behaviour = Behaviour::GeyserPlume {
    // rust: start_y: at[1],
    // rust: max_y: at[1] + f64::from(plume_height) - 1.0,
    // rust: propulsion,
    // rust: spray,
    // rust: min_size,
    // rust: max_size,
    // rust: done: false,
}
    // rust: q.set = set;
    // rust: q
}
    // rust: T::Flame
    // rust: | T::SoulFireFlame
    // rust: | T::CopperFireFlame
    // rust: | T::SmallFlame
    // rust: | T::Soul
    // rust: | T::SculkSoul => {
                // RisingParticle.
    // rust: let mut q = Particle::moving(r, ty, p, v);
    // rust: q.friction = 0.96;
    // rust: for i in 0..3 {
    // rust: q.velocity[i] = q.velocity[i] * f64::from(0.01f32) + v[i];
}
    // rust: for i in 0..3 {
    // rust: q.position[i] += f64::from((r.next_float() - r.next_float()) * 0.05);
}
                // RisingParticle moves x/y/z but not the bounding box.
    // rust: q.previous = p;
    // rust: q.lifetime = (8.0 / (f64::from(r.next_float()) * 0.8 + 0.2)) as i32 + 4;
    // rust: if matches!(ty, T::Soul | T::SculkSoul) {
    // rust: q.scale(1.5);
    // rust: q.behaviour = Behaviour::Animated;
    // rust: q.set = set;
    // rust: if ty == T::SculkSoul {
    // rust: q.light = Light::Block15;
}
    // rust: } else {
    // rust: q.free_move = true;
    // rust: q.size_curve = Size::Flame;
    // rust: q.light = Light::AgeEmission;
    // rust: if ty == T::SmallFlame {
    // rust: q.scale(0.5);
}
}
    // rust: q
}
    // rust: T::Lava => {
    // rust: let mut q = Particle::moving(r, ty, p, [0.0; 3]);
    // rust: q.gravity = 0.75;
    // rust: q.friction = 0.999;
    // rust: q.velocity[0] *= f64::from(0.8f32);
    // rust: q.velocity[1] *= f64::from(0.8f32);
    // rust: q.velocity[2] *= f64::from(0.8f32);
    // rust: q.velocity[1] = f64::from(r.next_float() * 0.4 + 0.05);
    // rust: q.size *= r.next_float() * 2.0 + 0.2;
    // rust: q.lifetime = (16.0 / (f64::from(r.next_float()) * 0.8 + 0.2)) as i32;
    // rust: q.size_curve = Size::Lava;
    // rust: q.light = Light::Block15;
    // rust: q.behaviour = Behaviour::Lava;
    // rust: q
}
    // rust: T::DrippingWater
    // rust: | T::FallingWater
    // rust: | T::DrippingLava
    // rust: | T::FallingLava
    // rust: | T::LandingLava
    // rust: | T::DrippingHoney
    // rust: | T::FallingHoney
    // rust: | T::LandingHoney
    // rust: | T::FallingNectar
    // rust: | T::FallingSporeBlossom
    // rust: | T::DrippingObsidianTear
    // rust: | T::FallingObsidianTear
    // rust: | T::LandingObsidianTear
    // rust: | T::DrippingDripstoneWater
    // rust: | T::FallingDripstoneWater
    // rust: | T::DrippingDripstoneLava
    // rust: | T::FallingDripstoneLava => {
                // The provider picks the sprite first (`sprite.get(random)`).
    // rust: let sprite = self.sprite_from_set(ty);
    // rust: let mut q = Particle::at(r, ty, p);
    // rust: q.sprite = sprite;
    // rust: q.set_size(0.01, 0.01);
    // rust: q.gravity = 0.06;
    // rust: let water = [0.2, 0.3, 1.0];
    // rust: let lava = [1.0, 0.285_714_3, 0.083_333_336];
    // rust: let tear = [0.511_718_75, 0.031_25, 0.890_625];
    // rust: let (fluid, stage, next, color, sound) = match ty {
    // rust: T::DrippingWater => (
    // rust: Fluid::Water,
    // rust: DripStage::Hang,
    // rust: Some(T::FallingWater),
    // rust: Some(water),
    // rust: None,
    // rust: ),
    // rust: T::FallingWater => (
    // rust: Fluid::Water,
    // rust: DripStage::FallAndLand,
    // rust: Some(T::Splash),
    // rust: Some(water),
    // rust: None,
    // rust: ),
    // rust: T::DrippingLava => (
    // rust: Fluid::Lava,
    // rust: DripStage::CoolingHang,
    // rust: Some(T::FallingLava),
    // rust: None,
    // rust: None,
    // rust: ),
    // rust: T::FallingLava => (
    // rust: Fluid::Lava,
    // rust: DripStage::FallAndLand,
    // rust: Some(T::LandingLava),
    // rust: Some(lava),
    // rust: None,
    // rust: ),
    // rust: T::LandingLava => (Fluid::Lava, DripStage::Land, None, Some(lava), None),
    // rust: T::DrippingHoney => (
    // rust: Fluid::None,
    // rust: DripStage::Hang,
    // rust: Some(T::FallingHoney),
    // rust: Some([0.622, 0.508, 0.082]),
    // rust: None,
    // rust: ),
    // rust: T::FallingHoney => (
    // rust: Fluid::None,
    // rust: DripStage::FallAndLand,
    // rust: Some(T::LandingHoney),
    // rust: Some([0.582, 0.448, 0.082]),
    // rust: Some("minecraft:block.beehive.drip"),
    // rust: ),
    // rust: T::LandingHoney => (
    // rust: Fluid::None,
    // rust: DripStage::Land,
    // rust: None,
    // rust: Some([0.522, 0.408, 0.082]),
    // rust: None,
    // rust: ),
    // rust: T::FallingNectar => (
    // rust: Fluid::None,
    // rust: DripStage::Fall,
    // rust: None,
    // rust: Some([0.92, 0.782, 0.72]),
    // rust: None,
    // rust: ),
    // rust: T::FallingSporeBlossom => (
    // rust: Fluid::None,
    // rust: DripStage::Fall,
    // rust: None,
    // rust: Some([0.32, 0.5, 0.22]),
    // rust: None,
    // rust: ),
    // rust: T::DrippingObsidianTear => (
    // rust: Fluid::None,
    // rust: DripStage::Hang,
    // rust: Some(T::FallingObsidianTear),
    // rust: Some(tear),
    // rust: None,
    // rust: ),
    // rust: T::FallingObsidianTear => (
    // rust: Fluid::None,
    // rust: DripStage::FallAndLand,
    // rust: Some(T::LandingObsidianTear),
    // rust: Some(tear),
    // rust: None,
    // rust: ),
    // rust: T::LandingObsidianTear => {
    // rust: (Fluid::None, DripStage::Land, None, Some(tear), None)
}
    // rust: T::DrippingDripstoneWater => (
    // rust: Fluid::Water,
    // rust: DripStage::Hang,
    // rust: Some(T::FallingDripstoneWater),
    // rust: Some(water),
    // rust: None,
    // rust: ),
    // rust: T::FallingDripstoneWater => (
    // rust: Fluid::Water,
    // rust: DripStage::FallAndLand,
    // rust: Some(T::Splash),
    // rust: Some(water),
    // rust: Some("minecraft:block.pointed_dripstone.drip_water"),
    // rust: ),
    // rust: T::DrippingDripstoneLava => (
    // rust: Fluid::Lava,
    // rust: DripStage::CoolingHang,
    // rust: Some(T::FallingDripstoneLava),
    // rust: None,
    // rust: None,
    // rust: ),
    // rust: _ => (
    // rust: Fluid::Lava,
    // rust: DripStage::FallAndLand,
    // rust: Some(T::LandingLava),
    // rust: Some(lava),
    // rust: Some("minecraft:block.pointed_dripstone.drip_lava"),
    // rust: ),
}
    // rust: match stage {
    // rust: DripStage::Hang | DripStage::CoolingHang => {
    // rust: q.gravity *= 0.02;
    // rust: q.lifetime = 40;
}
    // rust: DripStage::FallAndLand => {
    // rust: q.lifetime = (64.0 / (f64::from(r.next_float()) * 0.8 + 0.2)) as i32
}
    // rust: DripStage::Land => {
    // rust: q.lifetime = (16.0 / (f64::from(r.next_float()) * 0.8 + 0.2)) as i32
}
    // rust: DripStage::Fall => {}
}
    // rust: match ty {
    // rust: T::FallingHoney | T::FallingObsidianTear => q.gravity = 0.01,
    // rust: T::DrippingHoney | T::DrippingObsidianTear => {
    // rust: q.gravity *= 0.01;
    // rust: q.lifetime = 100;
}
                    // Lifetimes the providers draw from their own random.
    // rust: T::LandingHoney => {
    // rust: q.lifetime =
    // rust: (128.0 / (f64::from(self.random.next_float()) * 0.8 + 0.2)) as i32
}
    // rust: T::LandingObsidianTear => {
    // rust: q.lifetime =
    // rust: (28.0 / (f64::from(self.random.next_float()) * 0.8 + 0.2)) as i32
}
    // rust: T::FallingNectar => {
    // rust: q.lifetime =
    // rust: (16.0 / (f64::from(self.random.next_float()) * 0.8 + 0.2)) as i32;
    // rust: q.gravity = 0.007;
}
    // rust: T::FallingSporeBlossom => {
    // rust: q.lifetime = (64.0 / (r.next_float() * (0.9 - 0.1) + 0.1)) as i32;
    // rust: q.gravity = 0.005;
}
    // rust: _ => {}
}
    // rust: if matches!(
    // rust: ty,
    // rust: T::DrippingObsidianTear | T::FallingObsidianTear | T::LandingObsidianTear
    // rust: ) {
    // rust: q.light = Light::Block15;
}
    // rust: if let Some(c) = color {
    // rust: q.set_color(c[0], c[1], c[2]);
}
    // rust: q.behaviour = Behaviour::Drip {
    // rust: fluid,
    // rust: stage,
    // rust: next,
    // rust: sound,
}
    // rust: q
}
    // rust: T::Rain | T::Splash => {
                // WaterDropParticle.
    // rust: let mut q = Particle::moving(r, ty, p, [0.0; 3]);
    // rust: q.velocity[0] *= f64::from(0.3f32);
    // rust: q.velocity[1] = f64::from(r.next_float() * 0.2 + 0.1);
    // rust: q.velocity[2] *= f64::from(0.3f32);
    // rust: q.set_size(0.01, 0.01);
    // rust: q.gravity = 0.06;
    // rust: q.lifetime = (8.0 / (f64::from(r.next_float()) * 0.8 + 0.2)) as i32;
    // rust: if ty == T::Splash {
    // rust: q.gravity = 0.04;
    // rust: if v[1] == 0.0 && (v[0] != 0.0 || v[2] != 0.0) {
    // rust: q.velocity = [v[0], 0.1, v[2]];
}
}
    // rust: q.behaviour = Behaviour::WaterDrop;
    // rust: q
}
    // rust: T::Bubble | T::BubbleColumnUp => {
    // rust: let mut q = Particle::at(r, ty, p);
    // rust: q.set_size(0.02, 0.02);
    // rust: q.size *= r.next_float() * 0.6 + 0.2;
    // rust: for i in 0..3 {
    // rust: q.velocity[i] =
    // rust: v[i] * f64::from(0.2f32) + f64::from((r.next_float() * 2.0 - 1.0) * 0.02);
}
    // rust: if ty == T::Bubble {
    // rust: q.lifetime = (8.0 / (f64::from(r.next_float()) * 0.8 + 0.2)) as i32;
    // rust: q.behaviour = Behaviour::Bubble;
    // rust: } else {
    // rust: q.gravity = -0.125;
    // rust: q.friction = 0.85;
    // rust: q.lifetime = (40.0 / (f64::from(r.next_float()) * 0.8 + 0.2)) as i32;
    // rust: q.behaviour = Behaviour::BubbleColumnUp;
}
    // rust: q
}
    // rust: T::SulfurBubbles => {
    // rust: let mut q = Particle::at(r, ty, p);
    // rust: q.gravity = -0.04;
    // rust: q.friction = 0.85;
    // rust: q.set_size(0.02, 0.02);
    // rust: q.velocity[0] =
    // rust: v[0] * f64::from(0.2f32) + f64::from((r.next_float() * 2.0 - 1.0) * 0.02);
                // The provider passes `yAux` as `za`, so the Z speed comes from Y.
    // rust: q.velocity[2] =
    // rust: v[1] * f64::from(0.2f32) + f64::from((r.next_float() * 2.0 - 1.0) * 0.02);
    // rust: let size_start = 0.02 + 0.02 * r.next_float();
    // rust: q.size = size_start;
    // rust: q.lifetime = i32::MAX;
    // rust: q.behaviour = Behaviour::SulfurBubble {
    // rust: y_start: p[1],
    // rust: y_end: p[1] + 4.0 - 1.0,
    // rust: size_start,
    // rust: y_prev: p[1],
}
    // rust: q
}
    // rust: T::BubblePop => {
    // rust: let mut q = Particle::at(r, ty, p);
    // rust: q.lifetime = 4;
    // rust: q.gravity = 0.008;
    // rust: q.velocity = v;
    // rust: q.behaviour = Behaviour::BubblePop;
    // rust: q.set = set;
    // rust: q
}
    // rust: T::CurrentDown => {
    // rust: let mut q = Particle::at(r, ty, p);
    // rust: q.lifetime = (r.next_float() * 60.0) as i32 + 30;
    // rust: q.has_physics = false;
    // rust: q.velocity = [0.0, -0.05, 0.0];
    // rust: q.set_size(0.02, 0.02);
    // rust: q.size *= r.next_float() * 0.6 + 0.2;
    // rust: q.gravity = 0.002;
    // rust: q.behaviour = Behaviour::CurrentDown { angle: 0.0 };
    // rust: q
}
    // rust: T::Underwater | T::CrimsonSpore | T::WarpedSpore | T::SporeBlossomAir => {
                // SuspendedParticle; the providers draw motion, then the sprite.
    // rust: let below = [p[0], p[1] - 0.125, p[2]];
    // rust: let pr = &mut self.random;
    // rust: let vel = match ty {
    // rust: T::CrimsonSpore => [
    // rust: pr.next_gaussian() * f64::from(1.0e-6f32),
    // rust: pr.next_gaussian() * f64::from(1.0e-4f32),
    // rust: pr.next_gaussian() * f64::from(1.0e-6f32),
    // rust: ],
    // rust: T::WarpedSpore => [
    // rust: 0.0,
    // rust: f64::from(pr.next_float()) * -1.9 * f64::from(pr.next_float()) * 0.1,
    // rust: 0.0,
    // rust: ],
    // rust: _ => [0.0, f64::from(-0.8f32), 0.0],
}
    // rust: let sprite = self.sprite_from_set(ty);
    // rust: let mut q = if ty == T::Underwater {
    // rust: let mut q = Particle::at(r, ty, below);
    // rust: q.set_size(0.01, 0.01);
    // rust: q.size *= r.next_float() * 0.6 + 0.2;
    // rust: q
    // rust: } else {
    // rust: let mut q = Particle::moving(r, ty, below, vel);
    // rust: q.set_size(0.01, 0.01);
    // rust: q.size *= r.next_float() * 0.6 + 0.6;
    // rust: q
}
    // rust: q.lifetime = (16.0 / (f64::from(r.next_float()) * 0.8 + 0.2)) as i32;
    // rust: q.has_physics = false;
    // rust: q.friction = 1.0;
    // rust: q.gravity = 0.0;
    // rust: match ty {
    // rust: T::Underwater => q.set_color(0.4, 0.4, 0.7),
    // rust: T::CrimsonSpore => q.set_color(0.9, 0.4, 0.5),
    // rust: T::WarpedSpore => {
    // rust: q.set_color(0.1, 0.1, 0.3);
    // rust: q.set_size(0.001, 0.001);
}
    // rust: _ => {
    // rust: q.lifetime = self.random.next_int_bound(501).unwrap_or(0) + 500;
    // rust: q.gravity = 0.01;
    // rust: q.set_color(0.32, 0.5, 0.22);
}
}
    // rust: q.sprite = sprite;
    // rust: q
}
    // rust: T::Portal | T::ReversePortal => {
    // rust: let mut q = Particle::at(r, ty, p);
    // rust: q.velocity = v;
    // rust: q.size = 0.1 * (r.next_float() * 0.2 + 0.5);
    // rust: let br = r.next_float() * 0.6 + 0.4;
    // rust: q.set_color(br * 0.9, br * 0.3, br);
    // rust: q.lifetime = (r.next_float() * 10.0) as i32 + 40;
    // rust: q.free_move = true;
    // rust: q.light = Light::AgeEmission4;
    // rust: if ty == T::Portal {
    // rust: q.size_curve = Size::Portal;
    // rust: q.behaviour = Behaviour::Portal { start: p };
    // rust: } else {
    // rust: q.size *= 1.5;
    // rust: q.lifetime = (r.next_float() * 2.0) as i32 + 60;
    // rust: q.size_curve = Size::ReversePortal;
    // rust: q.behaviour = Behaviour::ReversePortal;
}
    // rust: q
}
    // rust: T::Enchant | T::Nautilus | T::VaultConnection => {
    // rust: let mut q = Particle::at(r, ty, p);
    // rust: let alpha = if ty == T::VaultConnection {
    // rust: [0.0, 0.6, 0.25, 1.0]
    // rust: } else {
    // rust: [1.0, 1.0, 0.0, 1.0]
}
    // rust: q.rgba[3] = alpha[0];
    // rust: q.velocity = v;
    // rust: let start = [p[0] + v[0], p[1] + v[1], p[2] + v[2]];
    // rust: q.previous = start;
    // rust: q.set_pos(start);
    // rust: q.position = start;
    // rust: q.size = 0.1 * (r.next_float() * 0.5 + 0.2);
    // rust: let br = r.next_float() * 0.6 + 0.4;
    // rust: q.set_color(0.9 * br, 0.9 * br, br);
    // rust: q.has_physics = false;
    // rust: q.lifetime = (r.next_float() * 10.0) as i32 + 30;
    // rust: q.free_move = true;
    // rust: q.light = if ty == T::VaultConnection {
    // rust: Light::Block15
    // rust: } else {
    // rust: Light::AgeEmission4
}
    // rust: q.behaviour = Behaviour::FlyTowards { start: p, alpha };
    // rust: if ty == T::VaultConnection {
    // rust: q.scale(1.5);
}
    // rust: q
}
    // rust: T::Crit | T::EnchantedHit | T::DamageIndicator => {
    // rust: let vel = if ty == T::DamageIndicator {
    // rust: [v[0], v[1] + 1.0, v[2]]
    // rust: } else {
    // rust: v
}
    // rust: let mut q = Particle::moving(r, ty, p, [0.0; 3]);
    // rust: q.friction = 0.7;
    // rust: q.gravity = 0.5;
    // rust: for i in 0..3 {
    // rust: q.velocity[i] = q.velocity[i] * f64::from(0.1f32) + vel[i] * 0.4;
}
    // rust: let col = r.next_float() * 0.3 + 0.6;
    // rust: q.set_color(col, col, col);
    // rust: q.size *= 0.75;
    // rust: q.lifetime = ((6.0 / (f64::from(r.next_float()) * 0.8 + 0.6)) as i32).max(1);
    // rust: q.has_physics = false;
    // rust: q.size_curve = Size::GrowIn;
    // rust: q.behaviour = Behaviour::Crit;
    // rust: q.pre_tick = true;
    // rust: q
}
    // rust: T::Heart | T::AngryVillager => {
    // rust: let at = if ty == T::AngryVillager {
    // rust: [p[0], p[1] + 0.5, p[2]]
    // rust: } else {
    // rust: p
}
    // rust: let mut q = Particle::moving(r, ty, at, [0.0; 3]);
    // rust: q.speed_up_when_y_blocked = true;
    // rust: q.friction = 0.86;
    // rust: for c in &mut q.velocity {
    // rust: *c *= f64::from(0.01f32);
}
    // rust: q.velocity[1] += 0.1;
    // rust: q.size *= 1.5;
    // rust: q.lifetime = 16;
    // rust: q.has_physics = false;
    // rust: q.size_curve = Size::GrowIn;
    // rust: q
}
    // rust: T::HappyVillager | T::Composter | T::Mycelium | T::Dolphin | T::EggCrack => {
                // SuspendedTownParticle; the provider picks the sprite first.
    // rust: let sprite = self.sprite_from_set(ty);
    // rust: let mut q = Particle::moving(r, ty, p, v);
    // rust: q.sprite = sprite;
    // rust: let br = r.next_float() * 0.1 + 0.2;
    // rust: q.set_color(br, br, br);
    // rust: q.set_size(0.02, 0.02);
    // rust: q.size *= r.next_float() * 0.6 + 0.5;
    // rust: for c in &mut q.velocity {
    // rust: *c *= f64::from(0.02f32);
}
    // rust: q.lifetime = (20.0 / (f64::from(r.next_float()) * 0.8 + 0.2)) as i32;
    // rust: q.free_move = true;
    // rust: q.behaviour = Behaviour::SuspendedTown;
    // rust: match ty {
    // rust: T::HappyVillager | T::EggCrack => q.set_color(1.0, 1.0, 1.0),
    // rust: T::Composter => {
    // rust: q.set_color(1.0, 1.0, 1.0);
    // rust: q.lifetime = 3 + self.level_random.next_int_bound(5).unwrap_or(0);
}
    // rust: T::Dolphin => {
    // rust: q.set_color(0.3, 0.5, 1.0);
    // rust: q.rgba[3] = 1.0 - self.random.next_float() * 0.7;
    // rust: q.lifetime /= 2;
}
    // rust: _ => {}
}
    // rust: q
}
    // rust: T::Poof | T::Snowflake | T::Spit => {
    // rust: let mut q = Particle::at(r, ty, p);
    // rust: if ty != T::Snowflake {
    // rust: q.gravity = -0.1;
    // rust: q.friction = 0.9;
    // rust: } else {
    // rust: q.gravity = 0.225;
    // rust: q.friction = 1.0;
}
    // rust: for i in 0..3 {
    // rust: q.velocity[i] = v[i] + f64::from((r.next_float() * 2.0 - 1.0) * 0.05);
}
    // rust: if ty != T::Snowflake {
    // rust: let col = r.next_float() * 0.3 + 0.7;
    // rust: q.set_color(col, col, col);
    // rust: q.size = 0.1 * (r.next_float() * r.next_float() * 6.0 + 1.0);
    // rust: } else {
    // rust: q.size = 0.1 * (r.next_float() * r.next_float() + 1.0);
}
    // rust: q.lifetime = (16.0 / (f64::from(r.next_float()) * 0.8 + 0.2)) as i32 + 2;
    // rust: q.behaviour = if ty == T::Snowflake {
    // rust: Behaviour::Snowflake
    // rust: } else {
    // rust: Behaviour::Animated
}
                // SpitParticle: ExplodeParticle falling at gravity 0.5.
    // rust: if ty == T::Spit {
    // rust: q.gravity = 0.5;
}
    // rust: if ty == T::Snowflake {
    // rust: q.set_color(0.923, 0.964, 0.999);
}
    // rust: q.set = set;
    // rust: q
}
    // rust: T::Explosion | T::SonicBoom => {
    // rust: let mut q = Particle::moving(r, ty, p, [0.0; 3]);
    // rust: q.lifetime = 6 + r.next_int_bound(4).unwrap_or(0);
    // rust: let col = r.next_float() * 0.6 + 0.4;
    // rust: q.set_color(col, col, col);
    // rust: q.size = 2.0 * (1.0 - v[0] as f32 * 0.5);
    // rust: if ty == T::SonicBoom {
                    // SonicBoomParticle.
    // rust: q.lifetime = 16;
    // rust: q.size = 1.5;
}
    // rust: q.light = Light::FullBright;
    // rust: q.behaviour = Behaviour::HugeExplosion;
    // rust: q.set = set;
    // rust: q
}
    // rust: T::ExplosionEmitter => {
    // rust: let mut q = Particle::base_moving(r, ty, p, [0.0; 3]);
    // rust: q.lifetime = 8;
    // rust: q.no_render = true;
    // rust: q.behaviour = Behaviour::ExplosionSeed;
    // rust: q
}
            // GustParticle: a still, bright, opaque quad that animates over
            // its 12 to 15 ticks; the small one is scaled to 15%.
    // rust: T::Gust | T::SmallGust => {
    // rust: let mut q = Particle::at(r, ty, p);
    // rust: q.lifetime = 12 + r.next_int_bound(4).unwrap_or(0);
    // rust: q.size = 1.0;
    // rust: q.set_size(1.0, 1.0);
    // rust: if ty == T::SmallGust {
    // rust: q.scale(0.15);
}
    // rust: q.light = Light::FullBright;
    // rust: q.behaviour = Behaviour::HugeExplosion;
    // rust: q.set = set;
    // rust: q
}
    // rust: T::GustEmitterLarge | T::GustEmitterSmall => {
    // rust: let mut q = Particle::base_moving(r, ty, p, [0.0; 3]);
    // rust: let (scale, lifetime, delay) = if ty == T::GustEmitterLarge {
    // rust: (3.0, 7, 0)
    // rust: } else {
    // rust: (1.0, 3, 2)
}
    // rust: q.lifetime = lifetime;
    // rust: q.no_render = true;
    // rust: q.behaviour = Behaviour::GustSeed { scale, delay };
    // rust: q
}
    // rust: T::CampfireCosySmoke | T::CampfireSignalSmoke => {
    // rust: let mut q = Particle::at(r, ty, p);
    // rust: q.scale(3.0);
    // rust: q.set_size(0.25, 0.25);
    // rust: q.lifetime = r.next_int_bound(50).unwrap_or(0)
    // rust: + if ty == T::CampfireSignalSmoke {
    // rust: 280
    // rust: } else {
    // rust: 80
}
    // rust: q.gravity = 3.0e-6;
    // rust: q.velocity = [v[0], v[1] + f64::from(r.next_float() / 500.0), v[2]];
    // rust: q.rgba[3] = if ty == T::CampfireSignalSmoke {
    // rust: 0.95
    // rust: } else {
    // rust: 0.9
}
    // rust: q.behaviour = Behaviour::Campfire;
    // rust: q
}
    // rust: T::Note => {
    // rust: let mut q = Particle::moving(r, ty, p, [0.0; 3]);
    // rust: q.friction = 0.66;
    // rust: q.speed_up_when_y_blocked = true;
    // rust: for c in &mut q.velocity {
    // rust: *c *= f64::from(0.01f32);
}
    // rust: q.velocity[1] += 0.2;
    // rust: let color = v[0] as f32;
                // `Mth.sin` (the quantized table) of a float angle.
    // rust: let channel = |offset: f32| {
    // rust: (trig::sin(f64::from((color + offset) * std::f64::consts::TAU as f32)) * 0.65
    // rust: + 0.35)
    // rust: .max(0.0)
}
    // rust: q.set_color(channel(0.0), channel(0.333_333_34), channel(0.666_666_7));
    // rust: q.size *= 1.5;
    // rust: q.lifetime = 6;
    // rust: q.size_curve = Size::GrowIn;
    // rust: q
}
    // rust: T::DustColorTransition => {
    // rust: let mut q = Particle::moving(r, ty, p, v);
    // rust: q.friction = 0.96;
    // rust: q.speed_up_when_y_blocked = true;
    // rust: for c in &mut q.velocity {
    // rust: *c *= f64::from(0.1f32);
}
    // rust: q.size *= 0.75 * o.scale;
    // rust: let base = (8.0 / (r.next_double() * 0.8 + 0.2)) as i32;
    // rust: q.lifetime = ((base as f32 * o.scale).max(1.0)) as i32;
    // rust: let factor = r.next_float() * 0.4 + 0.6;
    // rust: let mut randomize = |c: f32| (r.next_float() * 0.2 + 0.8) * c * factor;
    // rust: let from = [
    // rust: randomize(o.color[0]),
    // rust: randomize(o.color[1]),
    // rust: randomize(o.color[2]),
    // rust: ];
    // rust: let to = [
    // rust: randomize(o.to_color[0]),
    // rust: randomize(o.to_color[1]),
    // rust: randomize(o.to_color[2]),
    // rust: ];
    // rust: q.size_curve = Size::GrowIn;
    // rust: q.behaviour = Behaviour::Transition { from, to };
    // rust: q.set = set;
    // rust: q
}
            // SculkChargeParticle / SculkChargePopParticle.
    // rust: T::SculkCharge | T::SculkChargePop => {
    // rust: let mut q = Particle::moving(r, ty, p, v);
    // rust: q.friction = 0.96;
    // rust: q.scale(if ty == T::SculkCharge { 1.5 } else { 1.0 });
    // rust: q.has_physics = false;
    // rust: q.velocity = v;
    // rust: q.light = Light::Block15;
    // rust: q.behaviour = Behaviour::Animated;
    // rust: q.set = set;
    // rust: if ty == T::SculkCharge {
    // rust: q.roll = o.scale;
    // rust: q.o_roll = o.scale;
    // rust: q.lifetime = self.random.next_int_bound(12).unwrap_or(0) + 8;
    // rust: } else {
    // rust: q.lifetime = self.random.next_int_bound(4).unwrap_or(0) + 6;
}
    // rust: q
}
            // VibrationSignalParticle.Provider: `VibrationParticleOption` carries
            // the listener the signal flies to and its arrival time; the sprite
            // is the set's own draw from the engine's random.
    // rust: T::Vibration => {
    // rust: let (_, dest, ticks) = o.vibration.as_ref()?;
    // rust: let mut q = Self::vibration_particle(p, *dest, *ticks);
    // rust: q.set = set;
    // rust: q.sprite = self.sprite_from_set(ty);
    // rust: q
}
            // ShriekParticle.
    // rust: T::Shriek => {
    // rust: let mut q = Particle::moving(r, ty, p, [0.0; 3]);
    // rust: q.size = 0.85;
    // rust: q.lifetime = 30;
    // rust: q.gravity = 0.0;
    // rust: q.velocity = [0.0, 0.1, 0.0];
    // rust: q.light = Light::Block15;
    // rust: q.size_curve = Size::Shriek;
    // rust: q.behaviour = Behaviour::Shriek {
    // rust: delay: o.scale as i32,
}
    // rust: q
}
    // rust: T::Dust => {
    // rust: let mut q = Particle::moving(r, ty, p, v);
    // rust: q.friction = 0.96;
    // rust: q.speed_up_when_y_blocked = true;
    // rust: for c in &mut q.velocity {
    // rust: *c *= f64::from(0.1f32);
}
    // rust: q.size *= 0.75 * o.scale;
    // rust: let base = (8.0 / (r.next_double() * 0.8 + 0.2)) as i32;
    // rust: q.lifetime = ((base as f32 * o.scale).max(1.0)) as i32;
    // rust: let factor = r.next_float() * 0.4 + 0.6;
    // rust: let mut randomize = |c: f32| (r.next_float() * 0.2 + 0.8) * c * factor;
    // rust: let rgb = [
    // rust: randomize(o.color[0]),
    // rust: randomize(o.color[1]),
    // rust: randomize(o.color[2]),
    // rust: ];
    // rust: q.set_color(rgb[0], rgb[1], rgb[2]);
    // rust: q.size_curve = Size::GrowIn;
    // rust: q.behaviour = Behaviour::Animated;
    // rust: q.set = set;
    // rust: q
}
            // FireworkParticles.SparkProvider (a rocket's trail).
    // rust: T::Firework => {
    // rust: let mut q = Particle::at(r, ty, p);
    // rust: q.velocity = v;
    // rust: q.gravity = 0.1;
    // rust: q.friction = 0.91;
    // rust: q.size *= 0.75;
    // rust: q.lifetime = 48 + r.next_int_bound(12).unwrap_or(0);
    // rust: q.rgba[3] = 0.99;
    // rust: q.light = Light::FullBright;
    // rust: q.behaviour = Behaviour::Spark {
    // rust: fade: None,
    // rust: trail: false,
    // rust: twinkle: false,
}
    // rust: q.set = set;
    // rust: q
}
    // rust: T::TotemOfUndying | T::EndRod => {
    // rust: let mut q = Particle::at(r, ty, p);
    // rust: q.friction = 0.91;
    // rust: q.gravity = if ty == T::TotemOfUndying {
    // rust: 1.25
    // rust: } else {
    // rust: 0.0125
}
    // rust: q.velocity = v;
    // rust: q.size *= 0.75;
    // rust: q.lifetime = 60 + r.next_int_bound(12).unwrap_or(0);
    // rust: let mut fade = None;
    // rust: if ty == T::TotemOfUndying {
    // rust: q.friction = 0.6;
    // rust: if r.next_int_bound(4).unwrap_or(1) == 0 {
    // rust: q.set_color(
    // rust: 0.6 + r.next_float() * 0.2,
    // rust: 0.6 + r.next_float() * 0.3,
    // rust: r.next_float() * 0.2,
    // rust: );
    // rust: } else {
    // rust: q.set_color(
    // rust: 0.1 + r.next_float() * 0.2,
    // rust: 0.4 + r.next_float() * 0.3,
    // rust: r.next_float() * 0.2,
    // rust: );
}
    // rust: } else {
    // rust: fade = Some([
    // rust: 0xF2 as f32 / 255.0,
    // rust: 0xDE as f32 / 255.0,
    // rust: 0xC9 as f32 / 255.0,
    // rust: ]);
    // rust: q.free_move = true;
}
    // rust: q.light = Light::FullBright;
    // rust: q.behaviour = Behaviour::SimpleAnimated { fade };
    // rust: q.set = set;
    // rust: q
}
    // rust: T::CherryLeaves
    // rust: | T::PaleOakLeaves
    // rust: | T::TintedLeaves
    // rust: | T::RedPoplarLeaves
    // rust: | T::OrangePoplarLeaves
    // rust: | T::YellowPoplarLeaves => {
    // rust: let (fall, side, swirl, flow, scale, start) = if ty == T::CherryLeaves {
    // rust: (0.25f32, 2.0f32, false, true, 1.0f32, 0.0f32)
    // rust: } else {
    // rust: (0.07, 10.0, true, false, 2.0, 0.021)
}
    // rust: let mut q = Particle::at(r, ty, p);
    // rust: let rot_speed = (if r.next_boolean() { -30.0f32 } else { 30.0 }).to_radians();
    // rust: let spin = (if r.next_boolean() { -5.0f32 } else { 5.0 }).to_radians();
    // rust: q.lifetime = 300;
    // rust: q.gravity = fall * 1.2 * 0.0025;
    // rust: let s = scale * if r.next_boolean() { 0.05 } else { 0.075 };
    // rust: q.size = s;
    // rust: q.set_size(s, s);
    // rust: q.friction = 1.0;
    // rust: q.velocity[1] = -f64::from(start);
    // rust: let pr = r.next_float();
    // rust: let flow_scale = [
    // rust: f64::from(pr * 60.0).to_radians().cos() * f64::from(side),
    // rust: f64::from(pr * 60.0).to_radians().sin() * f64::from(side),
    // rust: ];
    // rust: let swirl_period = f64::from(1000.0 + pr * 3000.0).to_radians();
    // rust: if ty == T::TintedLeaves {
    // rust: q.set_color(o.color[0], o.color[1], o.color[2]);
}
    // rust: q.behaviour = Behaviour::Leaves {
    // rust: rot_speed,
    // rust: spin,
    // rust: wind: side,
    // rust: swirl,
    // rust: flow,
    // rust: flow_scale,
    // rust: swirl_period,
}
    // rust: q
}
    // rust: T::Effect
    // rust: | T::InstantEffect
    // rust: | T::EntityEffect
    // rust: | T::Witch
    // rust: | T::Infested
    // rust: | T::TrialOmen
    // rust: | T::RaidOmen => {
                // SpellParticle: x/z velocity from `SpellParticle.RANDOM`, y from the option.
    // rust: let xa = 0.5 - self.spell_random.next_double();
    // rust: let za = 0.5 - self.spell_random.next_double();
    // rust: let mut q = Particle::moving(r, ty, p, [xa, v[1], za]);
    // rust: q.friction = 0.96;
    // rust: q.gravity = -0.1;
    // rust: q.speed_up_when_y_blocked = true;
    // rust: q.velocity[1] *= f64::from(0.2f32);
    // rust: if v[0] == 0.0 && v[2] == 0.0 {
    // rust: q.velocity[0] *= f64::from(0.1f32);
    // rust: q.velocity[2] *= f64::from(0.1f32);
}
    // rust: q.size *= 0.75;
    // rust: q.lifetime = (8.0 / (f64::from(r.next_float()) * 0.8 + 0.2)) as i32;
    // rust: q.has_physics = false;
                // SpellParticle's constructor: setAlpha(0.0F), which also sets originalAlpha.
                // MobEffectProvider sets the option's alpha after it, so an entity
                // effect starts visible and the first tick hides it.
    // rust: if self.close_to_scoping_player(q.position) {
    // rust: q.rgba[3] = 0.0;
}
    // rust: match ty {
    // rust: T::Witch => {
    // rust: let b = self.random.next_float() * 0.5 + 0.35;
    // rust: q.set_color(b, 0.0, b);
}
    // rust: T::EntityEffect => {
    // rust: q.set_color(o.color[0], o.color[1], o.color[2]);
    // rust: q.rgba[3] = o.color[3];
}
    // rust: T::Effect | T::InstantEffect => {
    // rust: q.set_color(o.color[0], o.color[1], o.color[2]);
    // rust: q.set_power(o.scale);
}
    // rust: _ => {}
}
    // rust: q.behaviour = Behaviour::Spell {
    // rust: original_alpha: q.rgba[3],
}
    // rust: q.set = set;
    // rust: q
}
    // rust: T::Cloud | T::Sneeze => {
    // rust: let mut q = Particle::moving(r, ty, p, [0.0; 3]);
    // rust: q.friction = 0.96;
    // rust: for i in 0..3 {
    // rust: q.velocity[i] = q.velocity[i] * f64::from(0.1f32) + v[i];
}
    // rust: let col = 1.0 - r.next_float() * 0.3;
    // rust: q.set_color(col, col, col);
    // rust: q.size *= 1.875;
    // rust: let base = (8.0 / (f64::from(r.next_float()) * 0.8 + 0.3)) as i32;
    // rust: q.lifetime = ((base as f32 * 2.5).max(1.0)) as i32;
    // rust: q.has_physics = false;
    // rust: if ty == T::Sneeze {
    // rust: q.set_color(0.22, 1.0, 0.53);
    // rust: q.rgba[3] = 0.4;
}
    // rust: q.size_curve = Size::GrowIn;
    // rust: q.behaviour = Behaviour::Cloud;
    // rust: q.set = set;
    // rust: q
}
    // rust: T::DragonBreath => {
    // rust: let mut q = Particle::at(r, ty, p);
    // rust: q.friction = 0.96;
    // rust: q.velocity = v;
    // rust: q.set_color(
    // rust: r.next_float() * (0.874_509_8 - 0.717_647_1) + 0.717_647_1,
    // rust: 0.0,
    // rust: r.next_float() * (0.976_470_6 - 0.823_529_4) + 0.823_529_4,
    // rust: );
    // rust: q.size *= 0.75;
    // rust: q.lifetime = (20.0 / (f64::from(r.next_float()) * 0.8 + 0.2)) as i32;
    // rust: q.has_physics = false;
    // rust: q.size_curve = Size::GrowIn;
    // rust: q.behaviour = Behaviour::DragonBreath { hit_ground: false };
    // rust: q.set = set;
    // rust: q.set_power(o.scale);
    // rust: q
}
            // AttackSweepParticle: `xAux` shrinks it; still, bright, animated over 4 ticks.
    // rust: T::SweepAttack => {
    // rust: let mut q = Particle::moving(r, ty, p, [0.0; 3]);
    // rust: q.lifetime = 4;
    // rust: let col = r.next_float() * 0.6 + 0.4;
    // rust: q.set_color(col, col, col);
    // rust: q.size = 1.0 - v[0] as f32 * 0.5;
    // rust: q.light = Light::FullBright;
    // rust: q.behaviour = Behaviour::HugeExplosion;
    // rust: q.set = set;
    // rust: q
}
            // GlowParticle and its providers.
    // rust: T::Glow | T::WaxOn | T::WaxOff | T::ElectricSpark | T::Scrape => {
    // rust: let pr = &mut self.random;
    // rust: let start = if ty == T::Glow {
    // rust: let xa = 0.5 - pr.next_double();
    // rust: [xa, v[1], 0.5 - pr.next_double()]
    // rust: } else {
    // rust: [0.0; 3]
}
    // rust: let mut q = Particle::moving(r, ty, p, start);
    // rust: q.friction = 0.96;
    // rust: q.speed_up_when_y_blocked = true;
    // rust: q.size *= 0.75;
    // rust: q.has_physics = false;
    // rust: q.light = Light::AgeEmission;
    // rust: q.behaviour = Behaviour::Animated;
    // rust: q.set = set;
    // rust: match ty {
    // rust: T::ElectricSpark => {
    // rust: q.set_color(1.0, 0.9, 1.0);
    // rust: q.velocity = [v[0] * 0.25, v[1] * 0.25, v[2] * 0.25];
    // rust: q.lifetime = pr.next_int_bound(2).unwrap_or(0) + 2;
}
    // rust: T::Glow => {
    // rust: if pr.next_boolean() {
    // rust: q.set_color(0.6, 1.0, 0.8);
    // rust: } else {
    // rust: q.set_color(0.08, 0.4, 0.4);
}
    // rust: q.velocity[1] *= f64::from(0.2f32);
    // rust: if v[0] == 0.0 && v[2] == 0.0 {
    // rust: q.velocity[0] *= f64::from(0.1f32);
    // rust: q.velocity[2] *= f64::from(0.1f32);
}
    // rust: q.lifetime = (8.0 / (pr.next_double() * 0.8 + 0.2)) as i32;
}
    // rust: T::Scrape => {
    // rust: if pr.next_boolean() {
    // rust: q.set_color(0.29, 0.58, 0.51);
    // rust: } else {
    // rust: q.set_color(0.43, 0.77, 0.62);
}
    // rust: q.velocity = [v[0] * 0.01, v[1] * 0.01, v[2] * 0.01];
    // rust: q.lifetime = pr.next_int_bound(30).unwrap_or(0) + 10;
}
    // rust: _ => {
    // rust: if ty == T::WaxOn {
    // rust: q.set_color(0.91, 0.55, 0.08);
    // rust: } else {
    // rust: q.set_color(1.0, 0.9, 1.0);
}
    // rust: q.velocity = [v[0] * 0.01 / 2.0, v[1] * 0.01, v[2] * 0.01 / 2.0];
    // rust: q.lifetime = pr.next_int_bound(30).unwrap_or(0) + 10;
}
}
    // rust: q
}
            // SquidInkParticle (SimpleAnimatedParticle, gravity 0).
    // rust: T::SquidInk | T::GlowSquidInk => {
    // rust: let mut q = Particle::at(r, ty, p);
    // rust: q.friction = 0.92;
    // rust: q.size = 0.5;
    // rust: if ty == T::GlowSquidInk {
                    // ARGB.colorFromFloat(1, 0.2, 0.8, 0.6), back to floats.
    // rust: q.set_color(51.0 / 255.0, 204.0 / 255.0, 153.0 / 255.0);
    // rust: } else {
    // rust: q.set_color(0.0, 0.0, 0.0);
}
    // rust: q.lifetime = (q.size * 12.0 / (r.next_float() * 0.8 + 0.2)) as i32;
    // rust: q.has_physics = false;
    // rust: q.velocity = v;
    // rust: q.light = Light::FullBright;
    // rust: q.behaviour = Behaviour::SquidInk;
    // rust: q.set = set;
    // rust: q
}
            // BreakingItemParticle: a crumb of the item's sprite.
    // rust: T::Item | T::ItemSlime | T::ItemSnowball | T::ItemCobweb | T::SulfurCubeGoo => {
    // rust: let sprite = if ty == T::SulfurCubeGoo {
    // rust: self.first(ty)
    // rust: } else {
                    // ItemStackRenderState.pickParticleMaterial.
    // rust: let layers = match ty {
    // rust: T::Item => o.item.clone().unwrap_or_default(),
    // rust: _ => self.item_sprites.get(&ty).cloned().unwrap_or_default(),
}
    // rust: if layers.is_empty() {
    // rust: Sprite::Index(u32::MAX)
    // rust: } else {
    // rust: let i = self.random.next_int_bound(layers.len() as i32).unwrap_or(0);
    // rust: Sprite::Named(layers[i as usize].clone())
}
}
    // rust: let mut q = Particle::moving(r, ty, p, [0.0; 3]);
    // rust: q.sprite = sprite;
    // rust: q.gravity = 1.0;
    // rust: q.size /= 2.0;
    // rust: let uo = r.next_float() * 3.0;
    // rust: let vo = r.next_float() * 3.0;
    // rust: q.uv = [(uo + 1.0) / 4.0, vo / 4.0, uo / 4.0, (vo + 1.0) / 4.0];
    // rust: if ty == T::Item {
    // rust: for i in 0..3 {
    // rust: q.velocity[i] = q.velocity[i] * f64::from(0.1f32) + v[i];
}
}
    // rust: q
}
            // FireworkParticles.OverlayParticle: the flash of an explosion.
    // rust: T::Flash => {
    // rust: let mut q = Particle::at(r, ty, p);
    // rust: q.lifetime = 4;
    // rust: q.set_color(o.color[0], o.color[1], o.color[2]);
    // rust: q.rgba[3] = o.color[3];
    // rust: q.size_curve = Size::Flash;
    // rust: q
}
            // FireflyParticle; the provider draws its motion, sprite and lifetime.
    // rust: T::Firefly => {
    // rust: let pr = &mut self.random;
    // rust: let xa = 0.5 - pr.next_double();
    // rust: let ya = if pr.next_boolean() { v[1] } else { -v[1] };
    // rust: let za = 0.5 - pr.next_double();
    // rust: let sprite = self.sprite_from_set(ty);
    // rust: let mut q = Particle::moving(r, ty, p, [xa, ya, za]);
    // rust: q.sprite = sprite;
    // rust: q.speed_up_when_y_blocked = true;
    // rust: q.friction = 0.96;
    // rust: q.size *= 0.75;
    // rust: q.velocity[1] *= f64::from(0.8f32);
    // rust: q.velocity[0] *= f64::from(0.8f32);
    // rust: q.velocity[2] *= f64::from(0.8f32);
    // rust: q.lifetime = self
    // rust: .random
    // rust: .next_int_between_inclusive(200, 300)
    // rust: .unwrap_or(200);
    // rust: q.scale(1.5);
    // rust: q.rgba[3] = 0.0;
    // rust: q.light = Light::Firefly;
    // rust: q.behaviour = Behaviour::Firefly;
    // rust: q
}
            // TrialSpawnerDetectionParticle (scale 1.5 from the provider).
    // rust: T::TrialSpawnerDetection | T::TrialSpawnerDetectionOminous => {
    // rust: let scale = 1.5f32;
    // rust: let mut q = Particle::moving(r, ty, p, [0.0; 3]);
    // rust: q.friction = 0.96;
    // rust: q.gravity = -0.1;
    // rust: q.speed_up_when_y_blocked = true;
    // rust: q.velocity[0] *= 0.0;
    // rust: q.velocity[1] *= 0.9;
    // rust: q.velocity[2] *= 0.0;
    // rust: for i in 0..3 {
    // rust: q.velocity[i] += v[i];
}
    // rust: q.size *= 0.75 * scale;
                // Mth.randomBetween(random, 0.5, 1.0).
    // rust: q.lifetime = ((8.0 / (r.next_float() * (1.0 - 0.5) + 0.5) * scale) as i32).max(1);
    // rust: q.light = Light::Block15;
    // rust: q.size_curve = Size::GrowIn;
    // rust: q.behaviour = Behaviour::Animated;
    // rust: q.set = set;
    // rust: q
}
            // FlyStraightTowardsParticle.OminousSpawnProvider.
    // rust: T::OminousSpawning => {
    // rust: let sprite = self.sprite_from_set(ty);
    // rust: let mut q = Particle::at(r, ty, p);
    // rust: q.sprite = sprite;
    // rust: q.velocity = v;
    // rust: let start = [p[0] + v[0], p[1] + v[1], p[2] + v[2]];
    // rust: q.previous = start;
    // rust: q.position = start;
    // rust: q.size = 0.1 * (r.next_float() * 0.5 + 0.2);
    // rust: q.has_physics = false;
    // rust: q.free_move = true;
    // rust: q.lifetime = (r.next_float() * 5.0) as i32 + 25;
    // rust: q.light = Light::Block15;
    // rust: q.behaviour = Behaviour::FlyStraight {
    // rust: start: p,
    // rust: colors: [0xFF45_AEFE, 0xFFFF_FFFF],
}
                // Mth.randomBetween(level.getRandom(), 3, 5).
    // rust: let s = self.level_random.next_float() * (5.0 - 3.0) + 3.0;
    // rust: q.scale(s);
    // rust: q
}
            // WakeParticle.
    // rust: T::Fishing => {
    // rust: let mut q = Particle::moving(r, ty, p, [0.0; 3]);
    // rust: q.velocity[0] *= f64::from(0.3f32);
    // rust: q.velocity[1] = f64::from(r.next_float() * 0.2 + 0.1);
    // rust: q.velocity[2] *= f64::from(0.3f32);
    // rust: q.set_size(0.01, 0.01);
    // rust: q.lifetime = (8.0 / (f64::from(r.next_float()) * 0.8 + 0.2)) as i32;
    // rust: q.gravity = 0.0;
    // rust: q.velocity = v;
    // rust: q.behaviour = Behaviour::Wake;
    // rust: q.set = set;
    // rust: q
}
            // SimpleVerticalParticle.
    // rust: T::PauseMobGrowth | T::ResetMobGrowth => {
    // rust: let mut q = Particle::moving(r, ty, p, v);
    // rust: q.velocity = v;
    // rust: q.gravity = 0.0;
    // rust: q.velocity[1] += if ty == T::ResetMobGrowth { 0.03 } else { -0.03 };
    // rust: q.size *= r.next_float() * 0.6 + 0.5;
    // rust: q.lifetime = 8;
    // rust: q
}
            // BlockMarker: the block's particle sprite, half a block wide, 80 ticks.
    // rust: T::BlockMarker => {
    // rust: let (sprite, _) = o.block.clone()?;
    // rust: let mut q = Particle::at(r, ty, p);
    // rust: q.sprite = Sprite::Named(sprite);
    // rust: q.gravity = 0.0;
    // rust: q.lifetime = 80;
    // rust: q.has_physics = false;
    // rust: q.size = 0.5;
    // rust: q
}
    // rust: T::Trail => {
    // rust: let (target, duration) = o.trail?;
    // rust: let mut q = Particle::moving(r, ty, p, v);
    // rust: let jitter = |r: &mut LegacyRandom| 0.875 + r.next_float() * 0.25;
    // rust: let (jr, jg, jb) = (jitter(r), jitter(r), jitter(r));
                // `ARGB.scaleRGB` on the 8-bit channels.
    // rust: let scaled = |c: f32, s: f32| {
    // rust: ((((c * 255.0).round() as i32) as f32 * s) as i32).clamp(0, 255) as f32 / 255.0
}
    // rust: q.set_color(
    // rust: scaled(o.color[0], jr),
    // rust: scaled(o.color[1], jg),
    // rust: scaled(o.color[2], jb),
    // rust: );
    // rust: q.size = 0.26;
    // rust: q.lifetime = duration;
    // rust: q.has_physics = false;
    // rust: q.free_move = true;
    // rust: q.light = Light::FullBright;
    // rust: q.behaviour = Behaviour::Trail { target };
    // rust: q
}
}
    // rust: if particle.set.is_some() {
    // rust: particle.sprite = self.first(ty);
    // rust: self.sprite_from_age(&mut particle);
    // rust: } else if matches!(particle.sprite, Sprite::Index(u32::MAX)) {
    // rust: particle.sprite = self.sprite_from_set(ty);
}
    // rust: particle.random = local;
    // rust: Some(particle)
}

    /// `ParticleEngine.tick`: tick live particles, then admit queued ones.
    /// A firework spark (`SparkParticle`: gravity 0.1, friction 0.91, 3/4 size,
    /// 48..59 ticks).
    // rust: fn spark(
    // rust: &mut self,
    // rust: at: [f64; 3],
    // rust: v: [f64; 3],
    // rust: rgba: [f32; 4],
    // rust: fade: Option<[f32; 3]>,
    // rust: trail: bool,
    // rust: twinkle: bool,
    // rust: ) -> Particle {
    // rust: let mut local = LegacyRandom::new(self.seeds.next_long());
    // rust: let mut q = Particle::at(&mut local, ParticleType::Firework, at);
    // rust: q.velocity = v;
    // rust: q.gravity = 0.1;
    // rust: q.friction = 0.91;
    // rust: q.size *= 0.75;
    // rust: q.lifetime = 48 + local.next_int_bound(12).unwrap_or(0);
    // rust: q.random = local;
    // rust: q.rgba = [rgba[0], rgba[1], rgba[2], 0.99];
    // rust: q.light = Light::FullBright;
    // rust: q.behaviour = Behaviour::Spark {
    // rust: fade,
    // rust: trail,
    // rust: twinkle,
}
    // rust: q.set = self.set_of(ParticleType::Firework);
    // rust: self.sprite_from_age(&mut q);
    // rust: q
}
    /// ClientLevel.createFireworks: a Starter (or poofs without explosions).
    // rust: pub fn fireworks(
    // rust: &mut self,
    // rust: at: [f64; 3],
    // rust: v: [f64; 3],
    // rust: explosions: Vec<FireworkExplosion>,
    // rust: camera: [f64; 3],
    // rust: ) {
    // rust: if explosions.is_empty() {
    // rust: for _ in 0..self.random.next_int_bound(3).unwrap_or(0) + 2 {
    // rust: let g = |r: &mut LegacyRandom| r.next_gaussian() * 0.05;
    // rust: let (vx, vz) = (g(&mut self.random), g(&mut self.random));
    // rust: self.add(
    // rust: &ParticleOptions::simple(ParticleType::Poof),
    // rust: at,
    // rust: [vx, 0.005, vz],
    // rust: );
}
    // rust: return;
}
    // rust: let twinkle = explosions.iter().any(|e| e.twinkle);
    // rust: let lifetime = explosions.len() as i32 * 2 - 1 + if twinkle { 15 } else { 0 };
    // rust: let far = (0..3).map(|i| (at[i] - camera[i]).powi(2)).sum::<f64>() >= 256.0;
    // rust: self.starters.push(Starter {
    // rust: at,
    // rust: v,
    // rust: explosions,
    // rust: life: 0,
    // rust: lifetime,
    // rust: twinkle_delay: twinkle,
    // rust: far,
    // rust: });
}
pub fn tick_starters(self: *Self) void {
}
    // rust: for mut s in std::mem::take(&mut self.starters) {
    // rust: if s.life == 0 {
    // rust: let large = s.explosions.len() >= 3
    // rust: || s.explosions
    // rust: .iter()
    // rust: .any(|e| e.shape == FireworkShape::LargeBall);
    // rust: let sound = match (large, s.far) {
    // rust: (true, true) => "minecraft:entity.firework_rocket.large_blast_far",
    // rust: (true, false) => "minecraft:entity.firework_rocket.large_blast",
    // rust: (false, true) => "minecraft:entity.firework_rocket.blast_far",
    // rust: (false, false) => "minecraft:entity.firework_rocket.blast",
}
    // rust: let pitch = 0.95 + self.random.next_float() * 0.1;
    // rust: self.sounds.push((sound, s.at, 20.0, pitch, true));
}
    // rust: if s.life % 2 == 0 && ((s.life / 2) as usize) < s.explosions.len() {
    // rust: let e = s.explosions[(s.life / 2) as usize].clone();
                // DyeColor.BLACK.getFireworkColor without colours.
    // rust: let colors = if e.colors.is_empty() {
    // rust: vec![0x1E1B1B]
    // rust: } else {
    // rust: e.colors.clone()
}
    // rust: match e.shape {
    // rust: FireworkShape::SmallBall => self.spark_ball(&s, 0.25, 2, &colors, &e),
    // rust: FireworkShape::LargeBall => self.spark_ball(&s, 0.5, 4, &colors, &e),
    // rust: FireworkShape::Star => self.spark_shape(&s, 0.5, &STAR, &colors, &e, false),
    // rust: FireworkShape::Creeper => {
    // rust: self.spark_shape(&s, 0.5, &CREEPER, &colors, &e, true)
}
    // rust: FireworkShape::Burst => {
    // rust: let g = |r: &mut LegacyRandom| r.next_gaussian();
    // rust: let (bx, bz) = (g(&mut self.random) * 0.05, g(&mut self.random) * 0.05);
    // rust: for _ in 0..70 {
    // rust: let xa = s.v[0] * 0.5 + g(&mut self.random) * 0.15 + bx;
    // rust: let za = s.v[2] * 0.5 + g(&mut self.random) * 0.15 + bz;
    // rust: let ya = s.v[1] * 0.5 + self.random.next_double() * 0.5;
    // rust: self.spark_from(&s, [xa, ya, za], &colors, &e);
}
}
}
                // The flash: ColorParticleOption.create(FLASH, first colour), alpha 0.
    // rust: let c = colors[0];
    // rust: let rgba = [
    // rust: ((c >> 16) & 255) as f32 / 255.0,
    // rust: ((c >> 8) & 255) as f32 / 255.0,
    // rust: (c & 255) as f32 / 255.0,
    // rust: ((c >> 24) & 255) as f32 / 255.0,
    // rust: ];
    // rust: self.create(
    // rust: &ParticleOptions::colored(ParticleType::Flash, rgba),
    // rust: s.at,
    // rust: [0.0; 3],
    // rust: );
}
    // rust: s.life += 1;
    // rust: if s.life > s.lifetime {
    // rust: if s.twinkle_delay {
    // rust: let sound = if s.far {
    // rust: "minecraft:entity.firework_rocket.twinkle_far"
    // rust: } else {
    // rust: "minecraft:entity.firework_rocket.twinkle"
}
    // rust: let pitch = 0.9 + self.random.next_float() * 0.15;
    // rust: self.sounds.push((sound, s.at, 20.0, pitch, true));
}
    // rust: continue;
}
    // rust: self.starters.push(s);
}
}
    /// Starter.createParticle: a random colour and fade colour.
pub fn spark_from(self: *Self, s: *Starter, v: [f64; 3], colors: *[u32], e: *FireworkExplosion) void {
}
    // rust: let rgb = |c: u32| {
    // rust: [
    // rust: ((c >> 16) & 255) as f32 / 255.0,
    // rust: ((c >> 8) & 255) as f32 / 255.0,
    // rust: (c & 255) as f32 / 255.0,
    // rust: ]
}
    // rust: let c = colors[self.random.next_int_bound(colors.len() as i32).unwrap_or(0) as usize];
    // rust: let fade = (!e.fade.is_empty()).then(|| {
    // rust: rgb(e.fade[self.random.next_int_bound(e.fade.len() as i32).unwrap_or(0) as usize])
    // rust: });
    // rust: let [r, g, b] = rgb(c);
    // rust: let p = self.spark(s.at, v, [r, g, b, 0.99], fade, e.trail, e.twinkle);
    // rust: self.pending.push(p);
}
    // rust: fn spark_ball(
    // rust: &mut self,
    // rust: s: &Starter,
    // rust: speed: f64,
    // rust: steps: i32,
    // rust: colors: &[u32],
    // rust: e: &FireworkExplosion,
    // rust: ) {
    // rust: for y in -steps..=steps {
    // rust: for x in -steps..=steps {
    // rust: let mut z = -steps;
    // rust: while z <= steps {
    // rust: let d = |r: &mut LegacyRandom| (r.next_double() - r.next_double()) * 0.5;
    // rust: let xa = f64::from(x) + d(&mut self.random);
    // rust: let ya = f64::from(y) + d(&mut self.random);
    // rust: let za = f64::from(z) + d(&mut self.random);
    // rust: let len = (xa * xa + ya * ya + za * za).sqrt() / speed
    // rust: + self.random.next_gaussian() * 0.05;
    // rust: self.spark_from(s, [xa / len, ya / len, za / len], colors, e);
    // rust: if y != -steps && y != steps && x != -steps && x != steps {
    // rust: z += steps * 2 - 1;
}
    // rust: z += 1;
}
}
}
}
    // rust: fn spark_shape(
    // rust: &mut self,
    // rust: s: &Starter,
    // rust: speed: f64,
    // rust: coords: &[[f64; 2]],
    // rust: colors: &[u32],
    // rust: e: &FireworkExplosion,
    // rust: flat: bool,
    // rust: ) {
    // rust: let (sx, sy) = (coords[0][0], coords[0][1]);
    // rust: self.spark_from(s, [sx * speed, sy * speed, 0.0], colors, e);
    // rust: let base = f64::from(self.random.next_float() * std::f32::consts::PI);
    // rust: let modifier = if flat { 0.034 } else { 0.34 };
    // rust: for step in 0..3 {
    // rust: let angle = base + f64::from(step as f32 * std::f32::consts::PI) * modifier;
    // rust: let (mut ox, mut oy) = (sx, sy);
    // rust: for c in &coords[1..] {
    // rust: let (tx, ty) = (c[0], c[1]);
    // rust: let mut sub = 0.25;
    // rust: while sub <= 1.0 {
    // rust: let mut xa = (ox + (tx - ox) * sub) * speed;
    // rust: let ya = (oy + (ty - oy) * sub) * speed;
    // rust: let za = xa * angle.sin();
    // rust: xa *= angle.cos();
    // rust: for flip in [-1.0, 1.0] {
    // rust: self.spark_from(s, [xa * flip, ya, za * flip], colors, e);
}
    // rust: sub += 0.25;
}
    // rust: (ox, oy) = (tx, ty);
}
}
}
pub fn tick(self: *Self, level: *ParticleLevel) void {
}
    // rust: self.tick_starters();
    // rust: self.tick_explosions(level);
    // rust: for (options, feet, width, height, life) in std::mem::take(&mut self.emitters) {
    // rust: self.emit(&options, feet, width, height);
    // rust: if life > 1 {
    // rust: self.emitters.push((options, feet, width, height, life - 1));
}
}
    // rust: let mut particles = std::mem::take(&mut self.particles);
    // rust: for p in &mut particles {
    // rust: self.tick_particle(p, level);
}
    // rust: particles.retain(|p| !p.removed);
    // rust: self.particles = particles;
    // rust: let pending = std::mem::take(&mut self.pending);
    // rust: for mut p in pending {
    // rust: if p.pre_tick {
    // rust: p.pre_tick = false;
    // rust: self.tick_particle(&mut p, level);
    // rust: p.after_constructor_tick();
}
            // ParticleGroup.add: the last quarter fills with decreasing probability.
    // rust: let size = self.particles.len();
    // rust: if size >= MAX_PARTICLES {
    // rust: continue;
}
    // rust: if size >= 12288 {
    // rust: let free = (MAX_PARTICLES - size) as f32 / 4096.0;
    // rust: if self.random.next_float() >= free * free {
    // rust: continue;
}
}
    // rust: self.particles.push(p);
}
}
    /// `ClientExplosionTracker.tick`: throws up to 512 debris particles across all
    /// explosions tracked in this tick, weighted by each explosion's block count.
pub fn tick_explosions(self: *Self, level: *ParticleLevel) void {
}
    // rust: self.tick_explosions_with(&|b| level.facts.is_air(level.world.block(b[0], b[1], b[2])));
}
pub fn tick_explosions_with(self: *Self, is_air: *dyn Fn([i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.tracked_explosions.is_empty() {
    // rust: return;
}
    // rust: let explosions = std::mem::take(&mut self.tracked_explosions);
    // rust: if self.particle_level != 0 {
    // rust: return;
}
    // rust: let total_blocks: usize = explosions.iter().map(|e| e.block_count).sum();
    // rust: if total_blocks == 0 {
    // rust: return;
}
    // rust: let total_particles = total_blocks.min(512);
    // rust: for _ in 0..total_particles {
            // `WeightedRandom.getRandomItem` draws its `nextInt(totalWeight)`
            // even when one explosion is tracked.
    // rust: let mut pick = self.random.next_int_bound(total_blocks as i32).unwrap_or(0) as usize;
    // rust: let mut explosion = &explosions[0];
    // rust: for exp in &explosions {
    // rust: if pick < exp.block_count {
    // rust: explosion = exp;
    // rust: break;
}
    // rust: pick -= exp.block_count;
}
    // rust: let r = &mut self.random;
    // rust: let d = Vec3::new(
    // rust: f64::from(r.next_float() * 2.0 - 1.0),
    // rust: f64::from(r.next_float() * 2.0 - 1.0),
    // rust: f64::from(r.next_float() * 2.0 - 1.0),
    // rust: )
    // rust: .normalize();
    // rust: let distance = r.next_float().cbrt() * explosion.radius;
    // rust: let local = [
    // rust: d.x * f64::from(distance),
    // rust: d.y * f64::from(distance),
    // rust: d.z * f64::from(distance),
    // rust: ];
    // rust: let at = [
    // rust: explosion.center[0] + local[0],
    // rust: explosion.center[1] + local[1],
    // rust: explosion.center[2] + local[2],
    // rust: ];
    // rust: if !is_air(ParticleLevel::block_at(at)) {
    // rust: continue;
}
    // rust: let speed =
    // rust: 0.5 / (distance / explosion.radius + 0.1) * r.next_float() * r.next_float() + 0.3;
            // Level.DEFAULT_EXPLOSION_BLOCK_PARTICLES: poof (scaling 0.5) or smoke, equally weighted.
    // rust: let (ty, scaling) = if r.next_int_bound(2).unwrap_or(0) == 0 {
    // rust: (ParticleType::Poof, 0.5)
    // rust: } else {
    // rust: (ParticleType::Smoke, 1.0)
}
    // rust: let p = [
    // rust: explosion.center[0] + local[0] * scaling,
    // rust: explosion.center[1] + local[1] * scaling,
    // rust: explosion.center[2] + local[2] * scaling,
    // rust: ];
    // rust: self.add(
    // rust: &ParticleOptions::simple(ty),
    // rust: p,
    // rust: [
    // rust: d.x * f64::from(speed),
    // rust: d.y * f64::from(speed),
    // rust: d.z * f64::from(speed),
    // rust: ],
    // rust: );
}
}
pub fn tick_particle(self: *Self, p: *mut Particle, level: *ParticleLevel) void {
}
    // rust: match p.behaviour {
    // rust: Behaviour::Base => p.base_tick(level),
    // rust: Behaviour::Controlled { .. } => {
    // rust: if let Some(mut controller) = p.controller.take() {
    // rust: let update = controller.tick(p, level);
    // rust: p.controller = Some(controller);
    // rust: if let Some(frame) = update.frame {
    // rust: self.set_sprite_frame(p, frame);
}
    // rust: for (options, pos, velocity) in update.spawned {
    // rust: self.add(&options, pos, velocity);
}
    // rust: } else {
    // rust: p.remove();
}
}
    // rust: Behaviour::Mod { size, alpha } => {
    // rust: p.base_tick(level);
    // rust: p.size = mod_curve(size, p.age, p.lifetime);
    // rust: p.rgba[3] = mod_curve(alpha, p.age, p.lifetime);
    // rust: self.sprite_from_age(p);
}
    // rust: Behaviour::Animated => {
    // rust: p.base_tick(level);
    // rust: self.sprite_from_age(p);
}
    // rust: Behaviour::Snowflake => {
    // rust: p.base_tick(level);
    // rust: self.sprite_from_age(p);
    // rust: p.velocity[0] *= f64::from(0.95f32);
    // rust: p.velocity[1] *= f64::from(0.9f32);
    // rust: p.velocity[2] *= f64::from(0.95f32);
}
    // rust: Behaviour::Lava => {
    // rust: p.base_tick(level);
    // rust: if !p.removed {
    // rust: let odds = p.age as f32 / p.lifetime as f32;
    // rust: if p.random.next_float() > odds {
    // rust: self.add(
    // rust: &ParticleOptions::simple(ParticleType::Smoke),
    // rust: p.position,
    // rust: p.velocity,
    // rust: );
}
}
}
    // rust: Behaviour::Crit => {
    // rust: p.base_tick(level);
    // rust: p.rgba[1] *= 0.96;
    // rust: p.rgba[2] *= 0.9;
}
    // rust: Behaviour::Drip {
    // rust: fluid,
    // rust: stage,
    // rust: next,
    // rust: sound,
    // rust: } => {
    // rust: p.previous = p.position;
                // preMoveUpdate
    // rust: if stage == DripStage::CoolingHang {
    // rust: p.rgba[0] = 1.0;
    // rust: p.rgba[1] = 16.0 / (40 - p.lifetime + 16) as f32;
    // rust: p.rgba[2] = 4.0 / (40 - p.lifetime + 8) as f32;
}
    // rust: let lifetime = p.lifetime;
    // rust: p.lifetime -= 1;
    // rust: if lifetime <= 0 {
    // rust: p.removed = true;
    // rust: if matches!(stage, DripStage::Hang | DripStage::CoolingHang)
    // rust: && let Some(next) = next
    // rust: {
    // rust: self.add(&ParticleOptions::simple(next), p.position, p.velocity);
}
}
    // rust: if p.removed {
    // rust: return;
}
    // rust: p.velocity[1] -= f64::from(p.gravity);
    // rust: p.move_by(level, p.velocity);
                // postMoveUpdate
    // rust: match stage {
    // rust: DripStage::Hang | DripStage::CoolingHang => {
    // rust: for c in &mut p.velocity {
    // rust: *c *= 0.02;
}
}
    // rust: DripStage::Fall if p.on_ground => p.removed = true,
    // rust: DripStage::FallAndLand if p.on_ground => {
    // rust: p.removed = true;
    // rust: if let Some(next) = next {
    // rust: self.add(&ParticleOptions::simple(next), p.position, [0.0; 3]);
}
    // rust: if let Some(sound) = sound {
    // rust: let volume = p.random.next_float() * 0.7 + 0.3;
    // rust: self.sounds.push((sound, p.position, volume, 1.0, false));
}
}
    // rust: _ => {}
}
    // rust: if p.removed {
    // rust: return;
}
    // rust: for c in &mut p.velocity {
    // rust: *c *= f64::from(0.98f32);
}
    // rust: if fluid != Fluid::None {
    // rust: let b = ParticleLevel::block_at(p.position);
    // rust: let (f, height) = level.fluid(b);
    // rust: if f == fluid && p.position[1] < f64::from(b[1]) + height {
    // rust: p.removed = true;
}
}
}
    // rust: Behaviour::WaterDrop => {
    // rust: p.previous = p.position;
    // rust: let lifetime = p.lifetime;
    // rust: p.lifetime -= 1;
    // rust: if lifetime <= 0 {
    // rust: p.removed = true;
    // rust: return;
}
    // rust: p.velocity[1] -= f64::from(p.gravity);
    // rust: p.move_by(level, p.velocity);
    // rust: for c in &mut p.velocity {
    // rust: *c *= f64::from(0.98f32);
}
    // rust: if p.on_ground {
    // rust: if p.random.next_float() < 0.5 {
    // rust: p.removed = true;
}
    // rust: p.velocity[0] *= f64::from(0.7f32);
    // rust: p.velocity[2] *= f64::from(0.7f32);
}
    // rust: let b = ParticleLevel::block_at(p.position);
    // rust: let top = level.collision_top(
    // rust: b,
    // rust: p.position[0] - f64::from(b[0]),
    // rust: p.position[2] - f64::from(b[2]),
    // rust: );
    // rust: let offset = top.max(level.fluid(b).1);
    // rust: if offset > 0.0 && p.position[1] < f64::from(b[1]) + offset {
    // rust: p.removed = true;
}
}
    // rust: Behaviour::Bubble => {
    // rust: p.previous = p.position;
    // rust: let lifetime = p.lifetime;
    // rust: p.lifetime -= 1;
    // rust: if lifetime <= 0 {
    // rust: p.removed = true;
    // rust: return;
}
    // rust: p.velocity[1] += 0.002;
    // rust: p.move_by(level, p.velocity);
    // rust: for c in &mut p.velocity {
    // rust: *c *= f64::from(0.85f32);
}
    // rust: if level.fluid(ParticleLevel::block_at(p.position)).0 != Fluid::Water {
    // rust: p.removed = true;
}
}
    // rust: Behaviour::SulfurBubble {
    // rust: y_start,
    // rust: y_end,
    // rust: size_start,
    // rust: y_prev,
    // rust: } => {
    // rust: p.base_tick(level);
    // rust: let (fluid, source) = level.fluid_source(ParticleLevel::block_at(p.position));
    // rust: if !(p.removed || (fluid == Fluid::Water && source)) {
    // rust: p.removed = true;
}
    // rust: if !p.removed && p.position[1] >= y_end {
    // rust: p.removed = true;
}
    // rust: if !p.removed && p.position[1] <= y_prev {
    // rust: p.removed = true;
}
                // randomHorizontalWiggling, then a second, horizontal move.
    // rust: let wiggle = |r: &mut LegacyRandom| {
    // rust: let f = r.next_float() * 0.003;
    // rust: f64::from(if r.next_boolean() { f } else { -f }) * 0.5
}
    // rust: p.velocity[0] += wiggle(&mut p.random);
    // rust: p.velocity[2] += wiggle(&mut p.random);
    // rust: p.move_by(level, [p.velocity[0], 0.0, p.velocity[2]]);
    // rust: let progress = ((p.position[1] - y_start) / (y_end - y_start)) as f32;
    // rust: p.size = size_start + progress * (0.15 - size_start);
    // rust: p.behaviour = Behaviour::SulfurBubble {
    // rust: y_start,
    // rust: y_end,
    // rust: size_start,
    // rust: y_prev: p.position[1],
}
}
    // rust: Behaviour::NoxiousGas { fade_start } => {
    // rust: p.base_tick(level);
    // rust: self.sprite_from_age(p);
    // rust: if p.age as f32 > fade_start {
    // rust: let frames_since_fade_out_start = p.age as f32 - fade_start;
    // rust: p.rgba[3] =
    // rust: (p.lifetime as f32 - frames_since_fade_out_start) / p.lifetime as f32;
}
}
    // rust: Behaviour::NoxiousGasCloud => {
    // rust: p.base_tick(level);
    // rust: if p.age % 2 == 0 {
    // rust: let source = ParticleLevel::block_at(p.position);
    // rust: let spawn = pick_random_particle_spawn_point(&mut self.level_random, source);
    // rust: if crate::potent_sulfur::can_be_reached_by_noxious_gas(level, source, spawn) {
    // rust: self.spawn_noxious_gas_particle(spawn);
}
}
}
    // rust: Behaviour::GeyserEruption { water_blocks, aux } => {
    // rust: p.base_tick(level);
    // rust: if p.age % 2 == 0 {
    // rust: for _ in 0..2 {
    // rust: self.add(
    // rust: &ParticleOptions::geyser_base(
    // rust: ParticleType::GeyserBase,
    // rust: water_blocks,
    // rust: 1.5,
    // rust: ),
    // rust: p.position,
    // rust: aux,
    // rust: );
}
}
    // rust: for _ in 0..water_blocks + 2 {
    // rust: self.add(
    // rust: &ParticleOptions::geyser(ParticleType::GeyserPlume, water_blocks),
    // rust: p.position,
    // rust: aux,
    // rust: );
}
    // rust: if p.age % 10 == 0 {
    // rust: for _ in 0..20 {
    // rust: self.add(
    // rust: &ParticleOptions::geyser_base(
    // rust: ParticleType::GeyserPoof,
    // rust: water_blocks,
    // rust: 2.0,
    // rust: ),
    // rust: p.position,
    // rust: aux,
    // rust: );
}
}
}
    // rust: Behaviour::GeyserPlume {
    // rust: start_y,
    // rust: max_y,
    // rust: propulsion,
    // rust: spray,
    // rust: min_size,
    // rust: max_size,
    // rust: mut done,
    // rust: } => {
    // rust: p.base_tick(level);
    // rust: if !done
    // rust: && (p.velocity[1] < 0.0
    // rust: || p.position[1] > max_y
    // rust: || p.position[1] == p.previous[1])
    // rust: {
    // rust: p.lifetime = p.lifetime.min(p.age + 5);
    // rust: p.friction = 0.0;
    // rust: done = true;
}
    // rust: let y_progress_linear =
    // rust: ((p.position[1] - start_y) / (max_y - start_y)).clamp(0.0, 1.0);
    // rust: let y_progress_exponential = horizon_core::jmath::pow(y_progress_linear, 3.0);
    // rust: p.gravity = propulsion * y_progress_exponential as f32 * 0.12;
    // rust: p.velocity[0] = y_progress_linear * f64::from(spray[0]);
    // rust: p.velocity[2] = y_progress_linear * f64::from(spray[1]);
    // rust: self.sprite_from_age(p);
    // rust: p.size = min_size + (y_progress_linear * f64::from(max_size - min_size)) as f32;
    // rust: p.behaviour = Behaviour::GeyserPlume {
    // rust: start_y,
    // rust: max_y,
    // rust: propulsion,
    // rust: spray,
    // rust: min_size,
    // rust: max_size,
    // rust: done,
}
}
    // rust: Behaviour::BubbleColumnUp => {
    // rust: p.base_tick(level);
    // rust: if !p.removed && level.fluid(ParticleLevel::block_at(p.position)).0 != Fluid::Water
    // rust: {
    // rust: p.removed = true;
}
}
    // rust: Behaviour::BubblePop => {
    // rust: p.previous = p.position;
    // rust: let age = p.age;
    // rust: p.age += 1;
    // rust: if age >= p.lifetime {
    // rust: p.removed = true;
    // rust: return;
}
    // rust: p.velocity[1] -= f64::from(p.gravity);
    // rust: p.move_by(level, p.velocity);
    // rust: self.sprite_from_age(p);
}
    // rust: Behaviour::CurrentDown { angle } => {
    // rust: p.previous = p.position;
    // rust: let age = p.age;
    // rust: p.age += 1;
    // rust: if age >= p.lifetime {
    // rust: p.removed = true;
    // rust: return;
}
    // rust: p.velocity[0] += f64::from(0.6 * angle.cos());
    // rust: p.velocity[2] += f64::from(0.6 * angle.sin());
    // rust: p.velocity[0] *= 0.07;
    // rust: p.velocity[2] *= 0.07;
    // rust: p.move_by(level, p.velocity);
    // rust: if level.fluid(ParticleLevel::block_at(p.position)).0 != Fluid::Water || p.on_ground
    // rust: {
    // rust: p.removed = true;
}
    // rust: p.behaviour = Behaviour::CurrentDown {
    // rust: angle: angle + 0.08,
}
}
    // rust: Behaviour::SuspendedTown => {
    // rust: p.previous = p.position;
    // rust: let lifetime = p.lifetime;
    // rust: p.lifetime -= 1;
    // rust: if lifetime <= 0 {
    // rust: p.removed = true;
    // rust: return;
}
    // rust: p.move_by(level, p.velocity);
    // rust: for c in &mut p.velocity {
    // rust: *c *= 0.99;
}
}
    // rust: Behaviour::Portal { start } => {
    // rust: p.previous = p.position;
    // rust: let age = p.age;
    // rust: p.age += 1;
    // rust: if age >= p.lifetime {
    // rust: p.removed = true;
    // rust: return;
}
    // rust: let a = p.age as f32 / p.lifetime as f32;
    // rust: let pos = 1.0 - (-a + a * a * 2.0);
    // rust: p.position = [
    // rust: start[0] + p.velocity[0] * f64::from(pos),
    // rust: start[1] + p.velocity[1] * f64::from(pos) + f64::from(1.0 - a),
    // rust: start[2] + p.velocity[2] * f64::from(pos),
    // rust: ];
}
    // rust: Behaviour::ReversePortal => {
    // rust: p.previous = p.position;
    // rust: let age = p.age;
    // rust: p.age += 1;
    // rust: if age >= p.lifetime {
    // rust: p.removed = true;
    // rust: return;
}
    // rust: let m = f64::from(p.age as f32 / p.lifetime as f32);
    // rust: for i in 0..3 {
    // rust: p.position[i] += p.velocity[i] * m;
}
}
    // rust: Behaviour::FlyTowards { start, .. } => {
    // rust: p.previous = p.position;
    // rust: let age = p.age;
    // rust: p.age += 1;
    // rust: if age >= p.lifetime {
    // rust: p.removed = true;
    // rust: return;
}
    // rust: let pos = 1.0 - p.age as f32 / p.lifetime as f32;
    // rust: let mut pp = 1.0 - pos;
    // rust: pp *= pp;
    // rust: pp *= pp;
    // rust: p.position = [
    // rust: start[0] + p.velocity[0] * f64::from(pos),
    // rust: start[1] + p.velocity[1] * f64::from(pos) - f64::from(pp * 1.2),
    // rust: start[2] + p.velocity[2] * f64::from(pos),
    // rust: ];
}
    // rust: Behaviour::Transition { .. } => {
    // rust: p.base_tick(level);
    // rust: self.sprite_from_age(p);
}
    // rust: Behaviour::Shriek { delay } => {
    // rust: if delay > 0 {
    // rust: p.behaviour = Behaviour::Shriek { delay: delay - 1 };
    // rust: } else {
    // rust: p.base_tick(level);
}
}
    // rust: Behaviour::Vibration {
    // rust: dest, rot, pitch, ..
    // rust: } => {
    // rust: p.previous = p.position;
    // rust: let age = p.age;
    // rust: p.age += 1;
    // rust: if age >= p.lifetime {
    // rust: p.removed = true;
    // rust: return;
}
    // rust: let remaining = p.lifetime - p.age;
    // rust: if remaining > 0 {
    // rust: let alpha = 1.0 / f64::from(remaining);
    // rust: for i in 0..3 {
    // rust: p.position[i] += (dest[i] - p.position[i]) * alpha;
}
}
    // rust: let d = [
    // rust: p.position[0] - dest[0],
    // rust: p.position[1] - dest[1],
    // rust: p.position[2] - dest[2],
    // rust: ];
    // rust: p.behaviour = Behaviour::Vibration {
    // rust: dest,
    // rust: rot: d[0].atan2(d[2]) as f32,
    // rust: rot_o: rot,
    // rust: pitch: d[1].atan2((d[0] * d[0] + d[2] * d[2]).sqrt()) as f32,
    // rust: pitch_o: pitch,
}
    // rust: self.sprite_from_age(p);
}
    // rust: Behaviour::Trail { target } => {
    // rust: p.previous = p.position;
    // rust: let age = p.age;
    // rust: p.age += 1;
    // rust: if age >= p.lifetime {
    // rust: p.removed = true;
    // rust: return;
}
                // `Mth.lerp(1.0 / ticksRemaining, x, target)`, infinite on the last tick.
    // rust: let alpha = 1.0 / f64::from(p.lifetime - p.age);
    // rust: for i in 0..3 {
    // rust: p.position[i] += alpha * (target[i] - p.position[i]);
}
}
    // rust: Behaviour::HugeExplosion => {
    // rust: p.previous = p.position;
    // rust: let age = p.age;
    // rust: p.age += 1;
    // rust: if age >= p.lifetime {
    // rust: p.removed = true;
    // rust: return;
}
    // rust: self.sprite_from_age(p);
}
    // rust: Behaviour::GustSeed { scale, delay } => {
    // rust: if p.age % (delay + 1) == 0 {
    // rust: for _ in 0..3 {
    // rust: let r = &mut p.random;
    // rust: let at = [
    // rust: p.position[0] + (r.next_double() - r.next_double()) * scale,
    // rust: p.position[1] + (r.next_double() - r.next_double()) * scale,
    // rust: p.position[2] + (r.next_double() - r.next_double()) * scale,
    // rust: ];
    // rust: let f = f64::from(p.age as f32 / p.lifetime as f32);
    // rust: self.add(
    // rust: &ParticleOptions::simple(ParticleType::Gust),
    // rust: at,
    // rust: [f, 0.0, 0.0],
    // rust: );
}
}
    // rust: let age = p.age;
    // rust: p.age += 1;
    // rust: if age == p.lifetime {
    // rust: p.removed = true;
}
}
    // rust: Behaviour::ExplosionSeed => {
    // rust: for _ in 0..6 {
    // rust: let r = &mut p.random;
    // rust: let at = [
    // rust: p.position[0] + (r.next_double() - r.next_double()) * 4.0,
    // rust: p.position[1] + (r.next_double() - r.next_double()) * 4.0,
    // rust: p.position[2] + (r.next_double() - r.next_double()) * 4.0,
    // rust: ];
    // rust: let f = f64::from(p.age as f32 / p.lifetime as f32);
    // rust: self.add(
    // rust: &ParticleOptions::simple(ParticleType::Explosion),
    // rust: at,
    // rust: [f, 0.0, 0.0],
    // rust: );
}
    // rust: p.age += 1;
    // rust: if p.age == p.lifetime {
    // rust: p.removed = true;
}
}
    // rust: Behaviour::Campfire => {
    // rust: p.previous = p.position;
    // rust: let age = p.age;
    // rust: p.age += 1;
    // rust: if age < p.lifetime && p.rgba[3] > 0.0 {
    // rust: let r = &mut p.random;
    // rust: let dx = r.next_float() / 5000.0 * if r.next_boolean() { 1.0 } else { -1.0 };
    // rust: p.velocity[0] += f64::from(dx);
    // rust: let dz = r.next_float() / 5000.0 * if r.next_boolean() { 1.0 } else { -1.0 };
    // rust: p.velocity[2] += f64::from(dz);
    // rust: p.velocity[1] -= f64::from(p.gravity);
    // rust: p.move_by(level, p.velocity);
    // rust: if p.age >= p.lifetime - 60 && p.rgba[3] > 0.01 {
    // rust: p.rgba[3] -= 0.015;
}
    // rust: } else {
    // rust: p.removed = true;
}
}
    // rust: Behaviour::SimpleAnimated { fade } => {
    // rust: p.base_tick(level);
    // rust: self.sprite_from_age(p);
    // rust: if p.age > p.lifetime / 2 {
    // rust: p.rgba[3] = 1.0 - (p.age as f32 - (p.lifetime / 2) as f32) / p.lifetime as f32;
    // rust: if let Some(f) = fade {
    // rust: for i in 0..3 {
    // rust: p.rgba[i] += (f[i] - p.rgba[i]) * 0.2;
}
}
}
}
    // rust: Behaviour::Spark {
    // rust: fade,
    // rust: trail,
    // rust: twinkle,
    // rust: } => {
    // rust: p.base_tick(level);
    // rust: self.sprite_from_age(p);
    // rust: if p.age > p.lifetime / 2 {
    // rust: p.rgba[3] = 1.0 - (p.age as f32 - (p.lifetime / 2) as f32) / p.lifetime as f32;
    // rust: if let Some(f) = fade {
    // rust: for i in 0..3 {
    // rust: p.rgba[i] += (f[i] - p.rgba[i]) * 0.2;
}
}
}
    // rust: if trail && p.age < p.lifetime / 2 && (p.age + p.lifetime) % 2 == 0 {
    // rust: let mut child = self.spark(p.position, [0.0; 3], p.rgba, fade, false, twinkle);
    // rust: child.age = child.lifetime / 2;
    // rust: self.pending.push(child);
}
}
    // rust: Behaviour::Spell { original_alpha } => {
    // rust: p.base_tick(level);
    // rust: self.sprite_from_age(p);
                // SpellParticle.tick: alpha 0 while close, else eased back to originalAlpha.
    // rust: if self.close_to_scoping_player(p.position) {
    // rust: p.rgba[3] = 0.0;
    // rust: } else {
    // rust: p.rgba[3] += (original_alpha - p.rgba[3]) * 0.05;
}
}
    // rust: Behaviour::Cloud => {
    // rust: p.base_tick(level);
    // rust: if !p.removed {
    // rust: self.sprite_from_age(p);
    // rust: if let Some((player, vy)) = level.player {
    // rust: let d2 = (player[0] - p.position[0]).powi(2)
    // rust: + (player[1] - p.position[1]).powi(2)
    // rust: + (player[2] - p.position[2]).powi(2);
    // rust: if d2 < 4.0 && p.position[1] > player[1] {
    // rust: let y = p.position[1] + (player[1] - p.position[1]) * 0.2;
    // rust: p.velocity[1] += (vy - p.velocity[1]) * 0.2;
    // rust: p.set_pos([p.position[0], y, p.position[2]]);
}
}
}
}
    // rust: Behaviour::Leaves {
    // rust: mut rot_speed,
    // rust: spin,
    // rust: wind,
    // rust: swirl,
    // rust: flow,
    // rust: flow_scale,
    // rust: swirl_period,
    // rust: } => {
    // rust: p.previous = p.position;
    // rust: let lifetime = p.lifetime;
    // rust: p.lifetime -= 1;
    // rust: if lifetime <= 0 {
    // rust: p.removed = true;
}
    // rust: if !p.removed {
    // rust: let alive = (300 - p.lifetime) as f32;
    // rust: let relative = (alive / 300.0).min(1.0);
    // rust: let (mut xa, mut za) = (0.0f64, 0.0f64);
    // rust: if flow {
    // rust: xa += flow_scale[0] * f64::from(relative).powf(1.25);
    // rust: za += flow_scale[1] * f64::from(relative).powf(1.25);
}
    // rust: if swirl {
    // rust: let rel = f64::from(relative);
    // rust: xa += rel * (rel * swirl_period).cos() * f64::from(wind);
    // rust: za += rel * (rel * swirl_period).sin() * f64::from(wind);
}
    // rust: p.velocity[0] += xa * f64::from(0.0025f32);
    // rust: p.velocity[2] += za * f64::from(0.0025f32);
    // rust: p.velocity[1] -= f64::from(p.gravity);
    // rust: rot_speed += spin / 20.0;
    // rust: p.o_roll = p.roll;
    // rust: p.roll += rot_speed / 20.0;
    // rust: p.move_by(level, p.velocity);
    // rust: if p.on_ground
    // rust: || p.lifetime < 299 && (p.velocity[0] == 0.0 || p.velocity[2] == 0.0)
    // rust: {
    // rust: p.removed = true;
}
    // rust: if !p.removed {
    // rust: let f = f64::from(p.friction);
    // rust: for c in &mut p.velocity {
    // rust: *c *= f;
}
}
}
    // rust: p.behaviour = Behaviour::Leaves {
    // rust: rot_speed,
    // rust: spin,
    // rust: wind,
    // rust: swirl,
    // rust: flow,
    // rust: flow_scale,
    // rust: swirl_period,
}
}
    // rust: Behaviour::FallingDust { rot_speed } => {
    // rust: p.previous = p.position;
    // rust: let age = p.age;
    // rust: p.age += 1;
    // rust: if age >= p.lifetime {
    // rust: p.removed = true;
    // rust: return;
}
    // rust: self.sprite_from_age(p);
    // rust: p.o_roll = p.roll;
    // rust: p.roll += std::f32::consts::PI * rot_speed * 2.0;
    // rust: if p.on_ground {
    // rust: p.o_roll = 0.0;
    // rust: p.roll = 0.0;
}
    // rust: p.move_by(level, p.velocity);
    // rust: p.velocity[1] -= f64::from(0.003f32);
    // rust: p.velocity[1] = p.velocity[1].max(f64::from(-0.14f32));
}
    // rust: Behaviour::SquidInk => {
                // SimpleAnimatedParticle.tick, then SquidInkParticle's.
    // rust: p.base_tick(level);
    // rust: self.sprite_from_age(p);
    // rust: let half = |p: &mut Particle| {
    // rust: if p.age > p.lifetime / 2 {
    // rust: p.rgba[3] =
    // rust: 1.0 - (p.age as f32 - (p.lifetime / 2) as f32) / p.lifetime as f32;
}
}
    // rust: half(p);
    // rust: if !p.removed {
    // rust: self.sprite_from_age(p);
    // rust: half(p);
    // rust: let b = ParticleLevel::block_at(p.position);
    // rust: if level.facts.is_air(level.world.block(b[0], b[1], b[2])) {
    // rust: p.velocity[1] -= f64::from(0.0074f32);
}
}
}
    // rust: Behaviour::Firefly => {
    // rust: p.base_tick(level);
    // rust: let b = ParticleLevel::block_at(p.position);
    // rust: if !level.facts.is_air(level.world.block(b[0], b[1], b[2])) {
    // rust: p.removed = true;
    // rust: } else {
    // rust: p.rgba[3] = fade_amount(p.lifetime_progress(p.age as f32), 0.3, 0.5);
    // rust: if p.random.next_float() > 0.95 || p.age == 1 {
    // rust: let r = &mut p.random;
    // rust: let mut speed = || f64::from(-0.05f32 + 0.1 * r.next_float());
    // rust: p.velocity = [speed(), speed(), speed()];
}
}
}
    // rust: Behaviour::Wake => {
    // rust: p.previous = p.position;
    // rust: let life = 60 - p.lifetime;
    // rust: let lifetime = p.lifetime;
    // rust: p.lifetime -= 1;
    // rust: if lifetime <= 0 {
    // rust: p.removed = true;
    // rust: return;
}
    // rust: p.velocity[1] -= f64::from(p.gravity);
    // rust: p.move_by(level, p.velocity);
    // rust: for c in &mut p.velocity {
    // rust: *c *= f64::from(0.98f32);
}
    // rust: let size = life as f32 * 0.001;
    // rust: p.set_size(size, size);
                // SpriteSet.get(life % 4, 4).
    // rust: if let Some(set) = p.set {
    // rust: let sprites = &self.set_sprites[set as usize];
    // rust: let index = (life % 4) as usize * (sprites.len() - 1) / 4;
    // rust: p.sprite = Sprite::Index(sprites[index]);
}
}
    // rust: Behaviour::DustPlume => {
    // rust: p.gravity *= 0.88;
    // rust: p.friction *= 0.92;
    // rust: p.base_tick(level);
    // rust: self.sprite_from_age(p);
}
    // rust: Behaviour::FlyStraight { start, colors } => {
    // rust: p.previous = p.position;
    // rust: let age = p.age;
    // rust: p.age += 1;
    // rust: if age >= p.lifetime {
    // rust: p.removed = true;
    // rust: return;
}
    // rust: let normalized = p.age as f32 / p.lifetime as f32;
    // rust: let along = 1.0 - normalized;
    // rust: for i in 0..3 {
    // rust: p.position[i] = start[i] + p.velocity[i] * f64::from(along);
}
                // ARGB.srgbLerp: Mth.lerpInt on each 8-bit channel.
    // rust: let lerp = |shift: u32| {
    // rust: let (a, b) = (
    // rust: (colors[0] >> shift & 255) as i32,
    // rust: (colors[1] >> shift & 255) as i32,
    // rust: );
    // rust: (a + (normalized * (b - a) as f32).floor() as i32) as f32 / 255.0
}
    // rust: p.set_color(lerp(16), lerp(8), lerp(0));
    // rust: p.rgba[3] = lerp(24);
}
    // rust: Behaviour::DragonBreath { mut hit_ground } => {
    // rust: p.previous = p.position;
    // rust: let age = p.age;
    // rust: p.age += 1;
    // rust: if age >= p.lifetime {
    // rust: p.removed = true;
    // rust: return;
}
    // rust: self.sprite_from_age(p);
    // rust: if p.on_ground {
    // rust: p.velocity[1] = 0.0;
    // rust: hit_ground = true;
}
    // rust: if hit_ground {
    // rust: p.velocity[1] += 0.002;
}
    // rust: p.move_by(level, p.velocity);
    // rust: if p.position[1] == p.previous[1] {
    // rust: p.velocity[0] *= 1.1;
    // rust: p.velocity[2] *= 1.1;
}
    // rust: let f = f64::from(p.friction);
    // rust: p.velocity[0] *= f;
    // rust: p.velocity[2] *= f;
    // rust: if hit_ground {
    // rust: p.velocity[1] *= f;
}
    // rust: p.behaviour = Behaviour::DragonBreath { hit_ground };
}
}
}

    /// The particles that `entries` name, as lights: where each is this frame, its entry's colour
    /// as RGB and reach, and its alpha as the intensity.
    // rust: pub fn lights(
    // rust: &self,
    // rust: entries: &[horizon_shader_api::manifest::ParticleLight],
    // rust: partial: f32,
    // rust: ) -> Vec<([f64; 3], u32, f32, f32)> {
    // rust: let shining: Vec<(ParticleType, u32, f32)> = entries
    // rust: .iter()
    // rust: .flat_map(|e| {
    // rust: let [r, g, b] = e.color.map(|c| (c.clamp(0.0, 1.0) * 255.0) as u32);
    // rust: e.particles.iter().filter_map(move |name| {
    // rust: let name = if name.contains(':') {
    // rust: name.clone()
    // rust: } else {
    // rust: format!("minecraft:{name}")
}
    // rust: Some((
    // rust: ParticleType::from_name(&name)?,
    // rust: r << 16 | g << 8 | b,
    // rust: e.reach,
    // rust: ))
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: if shining.is_empty() {
    // rust: return Vec::new();
}
    // rust: let f = f64::from(partial);
    // rust: self.particles
    // rust: .iter()
    // rust: .filter(|p| p.rgba[3] > 0.0)
    // rust: .filter_map(|p| {
    // rust: let (_, rgb, reach) = shining.iter().find(|(ty, ..)| *ty == p.ty)?;
    // rust: let at = array::from_fn(|i| p.previous[i] + (p.position[i] - p.previous[i]) * f);
    // rust: Some((at, *rgb, *reach, p.rgba[3].clamp(0.0, 1.0)))
    // rust: })
    // rust: .collect()
}

    /// Camera-facing quads (`QuadParticleRenderState.renderRotatedQuad`).
    // rust: pub fn render(
    // rust: &self,
    // rust: camera: DVec3,
    // rust: yaw: f32,
    // rust: pitch: f32,
    // rust: partial: f32,
    // rust: light_at: &dyn Fn([i32; 3]) -> u8,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: self.render_inner::<false>(
    // rust: camera,
    // rust: yaw,
    // rust: pitch,
    // rust: partial,
    // rust: 0.0,
    // rust: None,
    // rust: &mut |_, _| false,
    // rust: light_at,
    // rust: out,
    // rust: );
}

    /// Render particles after rejecting view-frustum misses and any particles
    /// the caller proves hidden behind opaque terrain.
    // rust: pub fn render_culled(
    // rust: &self,
    // rust: camera: DVec3,
    // rust: yaw: f32,
    // rust: pitch: f32,
    // rust: partial: f32,
    // rust: pixel_focal_length: f32,
    // rust: culling_enabled: bool,
    // rust: frustum: Option<&crate::gfx::Frustum>,
    // rust: mut occluded: impl FnMut([f64; 3], [f64; 3]) -> bool,
    // rust: light_at: &dyn Fn([i32; 3]) -> u8,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: if !culling_enabled {
    // rust: self.render(camera, yaw, pitch, partial, light_at, out);
    // rust: return;
}
    // rust: self.render_inner::<true>(
    // rust: camera,
    // rust: yaw,
    // rust: pitch,
    // rust: partial,
    // rust: pixel_focal_length,
    // rust: frustum,
    // rust: &mut occluded,
    // rust: light_at,
    // rust: out,
    // rust: );
}

    // rust: fn render_inner<const CULL: bool>(
    // rust: &self,
    // rust: camera: DVec3,
    // rust: yaw: f32,
    // rust: pitch: f32,
    // rust: partial: f32,
    // rust: pixel_focal_length: f32,
    // rust: frustum: Option<&crate::gfx::Frustum>,
    // rust: occluded: &mut dyn FnMut([f64; 3], [f64; 3]) -> bool,
    // rust: light_at: &dyn Fn([i32; 3]) -> u8,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
        // Camera.setRotation: rotationYXZ(PI - yRot, -xRot, 0).
    // rust: let base = Quat::from_rotation_y(std::f32::consts::PI - yaw.to_radians())
    // rust: * Quat::from_rotation_x(-pitch.to_radians());
    // rust: let mut light_cache = ParticleLightCache::default();
    // rust: let mut section_cache =
    // rust: (CULL && frustum.is_some()).then(ParticleSectionFrustumCache::default);
    // rust: for p in &self.particles {
    // rust: if p.no_render {
    // rust: continue;
}
            // SparkParticle.extract: twinkling sparks blink after a third of their life.
    // rust: if let Behaviour::Spark { twinkle: true, .. } = p.behaviour
    // rust: && p.age >= p.lifetime / 3
    // rust: && ((p.age + p.lifetime) / 3) % 2 != 0
    // rust: {
    // rust: continue;
}
    // rust: if CULL && matches!(p.behaviour, Behaviour::Shriek { delay } if delay > 0) {
    // rust: continue;
}
    // rust: let culled_geometry = if CULL {
    // rust: let a = f64::from(partial);
    // rust: let world = array::from_fn(|i| p.previous[i] + (p.position[i] - p.previous[i]) * a);
    // rust: let center = (DVec3::from_array(world) - camera).as_vec3();
    // rust: let size = p.quad_size(partial);
                // Every generated quad vertex is sqrt(2) * size from its center,
                // including the rotated two-quad particle types.
    // rust: let radius = f64::from(size.abs()) * std::f64::consts::SQRT_2 + 0.05;
    // rust: if let (Some(frustum), Some(section_cache)) = (frustum, section_cache.as_mut()) {
    // rust: match section_cache.result(world, camera, radius, frustum) {
    // rust: SectionFrustumResult::Outside => continue,
    // rust: SectionFrustumResult::Intersects
    // rust: if !frustum.intersects_sphere(center, radius as f32) =>
    // rust: {
    // rust: continue;
}
    // rust: SectionFrustumResult::Inside | SectionFrustumResult::Intersects => {}
}
}
    // rust: let distance_squared = f64::from(center.length_squared());
    // rust: if below_half_pixel(radius, distance_squared, pixel_focal_length) {
    // rust: continue;
}
    // rust: if occluded(world.map(|v| v - radius), world.map(|v| v + radius)) {
    // rust: continue;
}
    // rust: Some((center, size))
    // rust: } else {
    // rust: None
}
            // `SubmitNodeCollection.submitQuadParticleGroup`: the translucent
            // layer draws after translucent terrain, so a crumb of stained
            // glass cannot hide the glass behind it (`getLayer`).
    // rust: let (rect, layer) = match &p.sprite {
    // rust: Sprite::Index(i) => (
    // rust: self.rects.get(*i as usize).copied().flatten(),
    // rust: p.ty.translucent_layer()
    // rust: || matches!(p.behaviour, Behaviour::Controlled { translucent: true })
    // rust: || matches!(p.behaviour, Behaviour::Mod { alpha, .. } if alpha != [1.0; 2]),
    // rust: ),
    // rust: Sprite::Named(name) => match self.atlas.get(name) {
    // rust: Some(&(rect, translucent)) => (Some(rect), translucent),
    // rust: None => (None, false),
    // rust: },
}
    // rust: let Some(r) = rect else { continue };
    // rust: let (center, size) = culled_geometry.unwrap_or_else(|| {
    // rust: let a = f64::from(partial);
    // rust: let pos = DVec3::new(
    // rust: p.previous[0] + (p.position[0] - p.previous[0]) * a,
    // rust: p.previous[1] + (p.position[1] - p.previous[1]) * a,
    // rust: p.previous[2] + (p.position[2] - p.previous[2]) * a,
    // rust: ) - camera;
    // rust: (pos.as_vec3(), p.quad_size(partial))
    // rust: });
    // rust: let rotation = if p.roll != 0.0 {
    // rust: base * Quat::from_rotation_z(p.o_roll + (p.roll - p.o_roll) * partial)
    // rust: } else {
    // rust: base
}
    // rust: let mut alpha = p.rgba[3];
            // OverlayParticle.extract: the flash fades as it pulses.
    // rust: if p.ty == ParticleType::Flash {
    // rust: alpha = 0.6 - (p.age as f32 + partial - 1.0) * 0.25 * 0.5;
}
    // rust: if let Behaviour::FlyTowards { alpha: la, .. } = p.behaviour {
    // rust: alpha = lifetime_alpha(la, p.age, p.lifetime, partial);
}
    // rust: let mut rotations = [Some(rotation), None];
    // rust: let mut rgb = [p.rgba[0], p.rgba[1], p.rgba[2]];
    // rust: match p.behaviour {
                // ShriekParticle.extract: two tilted quads, fading out.
    // rust: Behaviour::Shriek { delay } => {
    // rust: if !CULL && delay > 0 {
    // rust: continue;
}
    // rust: alpha = 1.0 - ((p.age as f32 + partial) / p.lifetime as f32).clamp(0.0, 1.0);
    // rust: rotations = [
    // rust: Some(Quat::from_rotation_x(-std::f32::consts::FRAC_PI_3)),
    // rust: Some(Quat::from_euler(
    // rust: glam::EulerRot::YXZ,
    // rust: -std::f32::consts::PI,
    // rust: std::f32::consts::FRAC_PI_3,
    // rust: 0.0,
    // rust: )),
    // rust: ];
}
                // VibrationSignalParticle.extract: two quads along the flight.
    // rust: Behaviour::Vibration {
    // rust: rot,
    // rust: rot_o,
    // rust: pitch,
    // rust: pitch_o,
    // rust: ..
    // rust: } => {
    // rust: let sway =
    // rust: ((p.age as f32 + partial - std::f32::consts::TAU) * 0.05).sin() * 2.0;
    // rust: let lerped_rot = rot_o + (rot - rot_o) * partial;
    // rust: let lerped_pitch =
    // rust: pitch_o + (pitch - pitch_o) * partial + std::f32::consts::FRAC_PI_2;
    // rust: rotations = [
    // rust: Some(
    // rust: Quat::from_rotation_y(lerped_rot)
    // rust: * Quat::from_rotation_x(-lerped_pitch)
    // rust: * Quat::from_rotation_y(sway),
    // rust: ),
    // rust: Some(
    // rust: Quat::from_rotation_y(-std::f32::consts::PI + lerped_rot)
    // rust: * Quat::from_rotation_x(lerped_pitch)
    // rust: * Quat::from_rotation_y(sway),
    // rust: ),
    // rust: ];
}
                // DustColorTransitionParticle.lerpColors.
    // rust: Behaviour::Transition { from, to } => {
    // rust: let t = (p.age as f32 + partial) / (p.lifetime as f32 + 1.0);
    // rust: rgb = array::from_fn(|i| from[i] + (to[i] - from[i]) * t);
}
    // rust: _ => {}
}
    // rust: let block = ParticleLevel::block_at(p.position);
    // rust: let packed = light_cache.get(block, light_at);
    // rust: let (sky_light, block_light) = p.light_coords(
    // rust: partial,
    // rust: u32::from(packed >> 4) * 16,
    // rust: u32::from(packed & 15) * 16,
    // rust: );
    // rust: let light = sky_light | block_light << 8;
    // rust: let c = |v: f32| (v.clamp(0.0, 1.0) * 255.0) as u32;
    // rust: let color = c(alpha) << 24 | c(rgb[2]) << 16 | c(rgb[1]) << 8 | c(rgb[0]);
    // rust: let (du, dv) = (r.u1 - r.u0, r.v1 - r.v0);
    // rust: let (u0, v0, u1, v1) = (
    // rust: r.u0 + du * p.uv[0],
    // rust: r.v0 + dv * p.uv[1],
    // rust: r.u0 + du * p.uv[2],
    // rust: r.v0 + dv * p.uv[3],
    // rust: );
    // rust: for rotation in rotations.into_iter().flatten() {
    // rust: for (n, uv) in [
    // rust: ((1.0, -1.0), [u1, v1]),
    // rust: ((1.0, 1.0), [u1, v0]),
    // rust: ((-1.0, 1.0), [u0, v0]),
    // rust: ((-1.0, -1.0), [u0, v1]),
    // rust: ] {
    // rust: let v = center + rotation * FVec3::new(n.0, n.1, 0.0) * size;
    // rust: out.push(Vertex {
    // rust: normal: [0; 4],
    // rust: pos: v.to_array(),
    // rust: uv,
    // rust: layer: if layer {
    // rust: crate::gfx::TRANSLUCENT_PARTICLE_OVERLAY
    // rust: } else {
    // rust: 0
    // rust: } | u32::from(hdr_tier(p.ty)) << 16,
    // rust: color,
    // rust: light,

    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}
}
}
}
/// How brightly particle `ty` shines in HDR output, as `mesher::hdr_tier`: flames,
/// glowing drops and fireworks, not their smoke.
pub fn hdr_tier(ty: ParticleType) u {
    // Implementation ported from Horizon
    return undefined;
}
//     use ParticleType as P;
    // rust: match ty {
    // rust: P::Flame
    // rust: | P::SoulFireFlame
    // rust: | P::CopperFireFlame
    // rust: | P::SmallFlame
    // rust: | P::Lava
    // rust: | P::DrippingLava
    // rust: | P::FallingLava
    // rust: | P::LandingLava
    // rust: | P::DrippingDripstoneLava
    // rust: | P::FallingDripstoneLava => crate::mesher::INCANDESCENT,
    // rust: P::DrippingObsidianTear | P::FallingObsidianTear | P::LandingObsidianTear => {
    // rust: crate::mesher::LOW
}
        // FireworkParticles: the sparks and the flash of the burst.
    // rust: P::Firework | P::Flash => crate::mesher::BRIGHT,
    // rust: _ => 0,
}
}
/// `Particle.LifetimeAlpha.currentAlphaForAge`.
pub fn lifetime_alpha(a: [f32; 4], age: i32, lifetime: i32, partial: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if (a[0] - a[1]).abs() < 1.0e-5 {
    // rust: return a[0];
}
    // rust: let t = ((age as f32 + partial) / lifetime as f32 - a[2]) / (a[3] - a[2]);
    // rust: a[0] + (a[1] - a[0]) * t.clamp(0.0, 1.0)
}

pub const Starter = struct {
    at: [f64,
    v: [f64,
    explosions: std.ArrayList(FireworkExplosion),
    life: i32,
    lifetime: i32,
    twinkle_delay: bool,
    far: bool,
};
    // rust: const STAR: [[f64; 2]; 6] = [
    // rust: [0.0, 1.0],
    // rust: [0.3455, 0.309],
    // rust: [0.9511, 0.309],
    // rust: [0.379_591_836_734_693_9, -0.126_530_612_244_897_95],
    // rust: [0.612_244_897_959_183_7, -0.804_081_632_653_061_2],
    // rust: [0.0, -0.359_183_673_469_387_73],
    // rust: ];
    // rust: const CREEPER: [[f64; 2]; 12] = [
    // rust: [0.0, 0.2],
    // rust: [0.2, 0.2],
    // rust: [0.2, 0.6],
    // rust: [0.6, 0.6],
    // rust: [0.6, 0.2],
    // rust: [0.2, 0.2],
    // rust: [0.2, 0.0],
    // rust: [0.4, 0.0],
    // rust: [0.4, -0.6],
    // rust: [0.2, -0.6],
    // rust: [0.2, -0.4],
    // rust: [0.0, -0.4],
    // rust: ];

    // rust: mod tests {
//     use super::*;

pub fn particle_light_cache_reuses_exact_blocks_and_fails_open_on_collisions() void {
}
    // rust: let reads = std::cell::Cell::new(0);
    // rust: let light_at = |block: [i32; 3]| {
    // rust: reads.set(reads.get() + 1);
    // rust: block[0] as u8
}
    // rust: let mut cache = ParticleLightCache::default();
    // rust: let first = [0, 0, 0];
    // rust: let colliding = [64, 0, 0];

    // rust: assert_eq!(cache.get(first, &light_at), 0);
    // rust: assert_eq!(cache.get(first, &light_at), 0);
    // rust: assert_eq!(reads.get(), 1);
    // rust: assert_eq!(cache.get(colliding, &light_at), 64);
    // rust: assert_eq!(cache.get(first, &light_at), 0);
    // rust: assert_eq!(reads.get(), 3);
}

pub fn subpixel_culling_uses_the_frame_projection_and_fails_open() void {
}
    // rust: assert!(below_half_pixel(0.01, 41.0_f64.powi(2), 1_000.0));
    // rust: assert!(!below_half_pixel(0.01, 40.0_f64.powi(2), 1_000.0));
    // rust: assert!(!below_half_pixel(0.01, 41.0_f64.powi(2), 0.0));
    // rust: assert!(!below_half_pixel(0.01, f64::NAN, 1_000.0));
    // rust: assert!(!below_half_pixel(f64::NAN, 41.0_f64.powi(2), 1_000.0));

    // rust: for distance in [0.25_f32, 1.0, 8.0, 40.0, 128.0] {
    // rust: for radius in [0.01, 0.05, 0.2] {
    // rust: let center = FVec3::new(distance, distance * 0.3, -distance * 0.8);
    // rust: let old = 2.0 * radius * 900.0 / f64::from(center.length()) < 0.5;
    // rust: assert_eq!(
    // rust: below_half_pixel(radius, f64::from(center.length_squared()), 900.0),
    // rust: old
    // rust: );
}
}
}

pub fn disabled_culled_render_matches_the_regular_particle_path() void {
}
    // rust: let mut engine = ParticleEngine::new(Path::new(""), &HashMap::new(), &HashSet::new());
    // rust: let sprite = "test:smoke".to_owned();
    // rust: engine.atlas.insert(
    // rust: sprite.clone(),
    // rust: (
    // rust: Rect {
    // rust: u0: 0.0,
    // rust: v0: 0.0,
    // rust: u1: 1.0,
    // rust: v1: 1.0,
    // rust: w: 16,
    // rust: h: 16,
    // rust: },
    // rust: false,
    // rust: ),
    // rust: );
    // rust: let mut random = LegacyRandom::new(7);
    // rust: let mut particle =
    // rust: Particle::moving(&mut random, ParticleType::Smoke, [0.0, 0.0, -3.0], [0.0; 3]);
    // rust: particle.sprite = Sprite::Named(sprite);
    // rust: engine.particles.push(particle);

    // rust: let light_at = |_: [i32; 3]| 0xf0;
    // rust: let mut regular = Vec::new();
    // rust: engine.render(DVec3::ZERO, 0.0, 0.0, 0.5, &light_at, &mut regular);
    // rust: let mut disabled = Vec::new();
    // rust: engine.render_culled(
    // rust: DVec3::ZERO,
    // rust: 0.0,
    // rust: 0.0,
    // rust: 0.5,
    // rust: 900.0,
    // rust: false,
    // rust: None,
    // rust: |_, _| panic!("disabled culling must not query particle visibility"),
    // rust: &light_at,
    // rust: &mut disabled,
    // rust: );

    // rust: let attributes = |vertices: &[Vertex]| {
    // rust: vertices
    // rust: .iter()
    // rust: .map(|vertex| {
    // rust: (
    // rust: vertex.pos,
    // rust: vertex.uv,
    // rust: vertex.layer,
    // rust: vertex.color,
    // rust: vertex.light,
    // rust: vertex.normal,
    // rust: vertex.glint_uv,
    // rust: )
    // rust: })
    // rust: .collect::<Vec<_>>()
}
    // rust: assert_eq!(attributes(&disabled), attributes(&regular));
}

pub fn a_mod_particles_json_becomes_its_sprite_set() void {
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-mod-particles-{}", std::process::id()));
    // rust: let particles = dir.join("assets/mymod/particles");
    // rust: std::fs::create_dir_all(&particles).unwrap();
    // rust: std::fs::write(
    // rust: particles.join("spark.json"),
    // rust: br#"{"textures":["mymod:spark/1","mymod:spark/2"]}"#,
    // rust: )
    // rust: .unwrap();
    // rust: assert!(particles.join("spark.json").exists());
    // rust: let mut engine = ParticleEngine::new(&dir, &HashMap::new(), &HashSet::new());
    // rust: let (set, _) = *engine
    // rust: .mod_sets
    // rust: .get("mymod:spark")
    // rust: .expect("the set is loaded");
    // rust: assert_eq!(engine.set_sprites[set as usize].len(), 2);
        // The named option spawns a billboard from that set, not a vanilla type.
    // rust: let made = engine
    // rust: .make(
    // rust: &ParticleOptions::named("mymod:spark"),
    // rust: [0.0; 3],
    // rust: [0.0; 3],
    // rust: 7,
    // rust: )
    // rust: .expect("a mod particle is made");
    // rust: assert_eq!(made.set, Some(set));
        // A name no pack knows draws nothing, like a missing vanilla sprite set.
    // rust: assert!(
    // rust: engine
    // rust: .make(
    // rust: &ParticleOptions::named("mymod:missing"),
    // rust: [0.0; 3],
    // rust: [0.0; 3],
    // rust: 7
    // rust: )
    // rust: .is_none()
    // rust: );
    // rust: std::fs::write(
    // rust: particles.join("spark.json"),
    // rust: br#"{"textures":["mymod:spark/1"],"horizon:behaviour":{
    // rust: "velocity":[0,0.5,0],"gravity":-1,"friction":0.5,
    // rust: "lifetime":4,"size":[0.25,0.5],"alpha":[0.75,0]
    // rust: }}"#,
    // rust: )
    // rust: .unwrap();
    // rust: engine.reload(&dir, &HashMap::new(), &HashSet::new());
    // rust: let custom = engine
    // rust: .make(
    // rust: &ParticleOptions::named("mymod:spark"),
    // rust: [0.0; 3],
    // rust: [0.0; 3],
    // rust: 7,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(custom.velocity, [0.0, 0.5, 0.0]);
    // rust: assert_eq!(custom.gravity, -1.0);
    // rust: assert_eq!(custom.friction, 0.5);
    // rust: assert_eq!(custom.lifetime, 4);
    // rust: assert_eq!(custom.size, 0.25);
    // rust: assert_eq!(custom.rgba[3], 0.75);
    // rust: for suffix in [r#", "horizon:behaviour": {"lifetime":0}"#, ""] {
    // rust: std::fs::write(
    // rust: particles.join("spark.json"),
    // rust: format!(r#"{{"textures":["mymod:spark/1","mymod:spark/2"]{suffix}}}"#,),
    // rust: )
    // rust: .unwrap();
    // rust: engine.reload(&dir, &HashMap::new(), &HashSet::new());
    // rust: let fallback = engine
    // rust: .make(
    // rust: &ParticleOptions::named("mymod:spark"),
    // rust: [0.0; 3],
    // rust: [0.0; 3],
    // rust: 7,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(fallback.velocity, made.velocity);
    // rust: assert_eq!(fallback.gravity, made.gravity);
    // rust: assert_eq!(fallback.friction, made.friction);
    // rust: assert_eq!(fallback.size, made.size);
    // rust: assert_eq!(fallback.rgba, made.rgba);
    // rust: assert_eq!(fallback.lifetime, made.lifetime);
    // rust: assert_eq!(fallback.behaviour, made.behaviour);
}
    // rust: assert_eq!(custom.lifetime, 4);
    // rust: assert_eq!(custom.size, 0.25);
    // rust: let _ = std::fs::remove_dir_all(&dir);
}

pub fn mod_behaviour_validates_declarations() void {
}
//         use serde_json::json;
    // rust: for invalid in [
    // rust: json!({"velocity": [0, 0]}),
    // rust: json!({"velocity": [17, 0, 0]}),
    // rust: json!({"gravity": 101}),
    // rust: json!({"gravity": 1e100}),
    // rust: json!({"friction": -0.1}),
    // rust: json!({"friction": 1.1}),
    // rust: json!({"lifetime": 0}),
    // rust: json!({"lifetime": 12001}),
    // rust: json!({"lifetime": 2.5}),
    // rust: json!({"size": [-1, 1]}),
    // rust: json!({"size": [0, 17]}),
    // rust: json!({"alpha": [0, 1.1]}),
    // rust: json!({"alpha": [-0.1, 1]}),
    // rust: json!({"fricton": 0.9}),
    // rust: json!(null),
    // rust: ] {
    // rust: assert!(ModBehaviour::parse(&invalid).is_none(), "{invalid}");
}
    // rust: assert!(
    // rust: ModBehaviour::parse(&json!({
    // rust: "velocity": [-16, 0, 16], "gravity": -100, "friction": 0,
    // rust: "lifetime": 12000, "size": [0, 16], "alpha": [0, 1]
    // rust: }))
    // rust: .is_some()
    // rust: );
    // rust: let mut particle = Particle::moving(
    // rust: &mut LegacyRandom::new(7),
    // rust: ParticleType::Smoke,
    // rust: [0.0; 3],
    // rust: [0.0; 3],
    // rust: );
    // rust: let original = particle.clone();
    // rust: ModBehaviour::parse(&json!({})).unwrap().apply(
    // rust: &mut particle,
    // rust: [0.0; 3],
    // rust: &mut LegacyRandom::new(1),
    // rust: );
    // rust: assert_eq!(particle.velocity, original.velocity);
    // rust: assert_eq!(particle.lifetime, original.lifetime);
    // rust: assert_eq!(particle.gravity, original.gravity);
    // rust: assert_eq!(particle.friction, original.friction);
    // rust: assert_eq!(particle.size, original.size);
    // rust: assert_eq!(particle.rgba, original.rgba);
    // rust: assert_eq!(particle.behaviour, original.behaviour);
}

pub fn mod_velocity_adds_the_spawn_velocity_and_jitters_deterministically() void {
}
//         use serde_json::json;
    // rust: let mut base = Particle::blank(ParticleType::Smoke, [0.0; 3]);
    // rust: ModBehaviour::parse(&json!({"velocity": [0.5, 0.0, 0.0]}))
    // rust: .unwrap()
    // rust: .apply(&mut base, [0.25, 1.0, -1.0], &mut LegacyRandom::new(1));
    // rust: assert_eq!(base.velocity, [0.75, 1.0, -1.0]);
    // rust: let jitter = ModBehaviour::parse(&json!({"velocity_jitter": [0.5, 0.0, 0.25]})).unwrap();
    // rust: let mut first = Particle::blank(ParticleType::Smoke, [0.0; 3]);
    // rust: let mut second = Particle::blank(ParticleType::Smoke, [0.0; 3]);
    // rust: jitter.apply(&mut first, [1.0, 2.0, 3.0], &mut LegacyRandom::new(9));
    // rust: jitter.apply(&mut second, [1.0, 2.0, 3.0], &mut LegacyRandom::new(9));
    // rust: assert_eq!(first.velocity, second.velocity);
    // rust: assert!((0.5..=1.5).contains(&first.velocity[0]));
    // rust: assert_eq!(first.velocity[1], 2.0);
    // rust: assert!((2.75..=3.25).contains(&first.velocity[2]));
    // rust: for invalid in [
    // rust: json!({"velocity_jitter": [-0.1, 0, 0]}),
    // rust: json!({"velocity_jitter": [17, 0, 0]}),
    // rust: json!({"frame_ticks": 2}),
    // rust: json!({"animation": "age", "frame_ticks": 2}),
    // rust: json!({"animation": "loop", "frame_ticks": 0}),
    // rust: json!({"animation": "loop", "frame_ticks": 201}),
    // rust: json!({"animation": "spin"}),
    // rust: ] {
    // rust: assert!(ModBehaviour::parse(&invalid).is_none(), "{invalid}");
}
    // rust: assert!(ModBehaviour::parse(&json!({"animation": "loop", "frame_ticks": 3})).is_some());
}

pub fn mod_animation_modes_pick_their_sprites() void {
}
    // rust: let mut engine = ParticleEngine::new(Path::new(""), &HashMap::new(), &HashSet::new());
    // rust: engine.set_sprites.push(vec![10, 11, 12]);
    // rust: let mut looping = Particle::blank(ParticleType::Smoke, [0.0; 3]);
    // rust: looping.set = Some(0);
    // rust: ModBehaviour::parse(&serde_json::json!({"animation": "loop", "frame_ticks": 2}))
    // rust: .unwrap()
    // rust: .apply(&mut looping, [0.0; 3], &mut LegacyRandom::new(1));
    // rust: let mut seen = Vec::new();
    // rust: for age in 0..8 {
    // rust: looping.age = age;
    // rust: engine.sprite_from_age(&mut looping);
    // rust: seen.push(match looping.sprite {
    // rust: Sprite::Index(i) => i,
    // rust: Sprite::Named(_) => u32::MAX,
    // rust: });
}
    // rust: assert_eq!(seen, [10, 10, 11, 11, 12, 12, 10, 10]);
    // rust: let mut kept = Particle::blank(ParticleType::Smoke, [0.0; 3]);
    // rust: kept.set = Some(0);
    // rust: ModBehaviour::parse(&serde_json::json!({"animation": "first"}))
    // rust: .unwrap()
    // rust: .apply(&mut kept, [0.0; 3], &mut LegacyRandom::new(1));
    // rust: assert_eq!(kept.set, None);
}

pub fn mod_curves_clamp_and_interpolate_over_lifetime() void {
}
    // rust: assert_eq!(mod_curve([0.0, 2.0], -1, 4), 0.0);
    // rust: assert_eq!(mod_curve([0.0, 2.0], 0, 4), 0.0);
    // rust: assert_eq!(mod_curve([0.0, 2.0], 1, 4), 0.5);
    // rust: assert_eq!(mod_curve([0.0, 2.0], 4, 4), 2.0);
    // rust: assert_eq!(mod_curve([0.0, 2.0], 5, 4), 2.0);
    // rust: assert_eq!(mod_curve([1.0, 0.0], 1, 4), 0.75);
    // rust: assert_eq!(mod_curve([0.5, 0.5], 2, 4), 0.5);
    // rust: assert_eq!(mod_curve([0.0, 1.0], 1, 1), 1.0);
}

pub fn mod_animation_advances_in_the_tick_with_and_without_curves() void {
}
//         use horizon_world::{
    // rust: DATA_VERSION,
    // rust: collision::CachedCollisionRegistry,
    // rust: nbt::Tag,
    // rust: registry::{BlockRegistry, BlockStateId},
}
    // rust: let registry = BlockRegistry::from_nbt(&Tag::compound([
    // rust: ("DataVersion", Tag::Int(DATA_VERSION)),
    // rust: (
    // rust: "states",
    // rust: Tag::List(vec![Tag::String("minecraft:air".into())]),
    // rust: ),
    // rust: ("defaults", Tag::compound([("minecraft:air", Tag::Int(0))])),
    // rust: ]))
    // rust: .unwrap();
    // rust: let cached = CachedCollisionRegistry::from_nbt(
    // rust: &Tag::compound([
    // rust: ("DataVersion", Tag::Int(DATA_VERSION)),
    // rust: (
    // rust: "states",
    // rust: Tag::List(vec![Tag::String("minecraft:air".into())]),
    // rust: ),
    // rust: ("shapes", Tag::List(vec![])),
    // rust: ("cached_shapes", Tag::IntArray(vec![-1])),
    // rust: ]),
    // rust: &registry,
    // rust: )
    // rust: .unwrap();
    // rust: let collision = BlockCollisionRegistry::new(std::sync::Arc::new(cached)).unwrap();
    // rust: let facts = BlockFacts {
    // rust: states: vec![],
    // rust: air: BlockStateId(0),
    // rust: woods: HashMap::new(),
}
    // rust: let world = World::new(BlockStateId(0), 0);
    // rust: let level = ParticleLevel {
    // rust: world: &world,
    // rust: facts: &facts,
    // rust: collision: &collision,
    // rust: player: None,
}
    // rust: let mut engine = ParticleEngine::new(Path::new(""), &HashMap::new(), &HashSet::new());
    // rust: engine.set_sprites.push(vec![10, 11, 12]);
    // rust: let sprite = |p: &Particle| match p.sprite {
    // rust: Sprite::Index(i) => i,
    // rust: Sprite::Named(_) => u32::MAX,
}
    // rust: for declaration in [
    // rust: serde_json::json!({"animation": "loop", "frame_ticks": 2, "alpha": [1, 0], "lifetime": 100}),
    // rust: serde_json::json!({"animation": "loop", "frame_ticks": 2, "lifetime": 100}),
    // rust: ] {
    // rust: let mut particle = Particle::blank(ParticleType::Smoke, [0.0; 3]);
    // rust: particle.has_physics = false;
    // rust: particle.set = Some(0);
    // rust: ModBehaviour::parse(&declaration).unwrap().apply(
    // rust: &mut particle,
    // rust: [0.0; 3],
    // rust: &mut LegacyRandom::new(1),
    // rust: );
    // rust: let mut seen = Vec::new();
    // rust: for _ in 0..6 {
    // rust: engine.tick_particle(&mut particle, &level);
    // rust: seen.push(sprite(&particle));
}
    // rust: assert_eq!(seen, [10, 11, 11, 12, 12, 10], "{declaration}");
}
    // rust: let mut aged = Particle::blank(ParticleType::Smoke, [0.0; 3]);
    // rust: aged.has_physics = false;
    // rust: aged.set = Some(0);
    // rust: ModBehaviour::parse(&serde_json::json!({"animation": "age", "lifetime": 4}))
    // rust: .unwrap()
    // rust: .apply(&mut aged, [0.0; 3], &mut LegacyRandom::new(1));
    // rust: for _ in 0..4 {
    // rust: engine.tick_particle(&mut aged, &level);
}
    // rust: assert_eq!(sprite(&aged), 12);
    // rust: let mut kept = Particle::blank(ParticleType::Smoke, [0.0; 3]);
    // rust: kept.has_physics = false;
    // rust: kept.set = Some(0);
    // rust: kept.sprite = Sprite::Index(11);
    // rust: ModBehaviour::parse(&serde_json::json!({"alpha": [1, 0], "lifetime": 4}))
    // rust: .unwrap()
    // rust: .apply(&mut kept, [0.0; 3], &mut LegacyRandom::new(1));
    // rust: for _ in 0..4 {
    // rust: engine.tick_particle(&mut kept, &level);
}
    // rust: assert_eq!(sprite(&kept), 11, "no animation keeps the spawn sprite");
}

pub fn mod_particle_ticks_motion_curves_and_removal() void {
}
//         use horizon_world::{
    // rust: DATA_VERSION,
    // rust: collision::CachedCollisionRegistry,
    // rust: nbt::Tag,
    // rust: registry::{BlockRegistry, BlockStateId},
}
    // rust: let registry = BlockRegistry::from_nbt(&Tag::compound([
    // rust: ("DataVersion", Tag::Int(DATA_VERSION)),
    // rust: (
    // rust: "states",
    // rust: Tag::List(vec![Tag::String("minecraft:air".into())]),
    // rust: ),
    // rust: ("defaults", Tag::compound([("minecraft:air", Tag::Int(0))])),
    // rust: ]))
    // rust: .unwrap();
    // rust: let cached = CachedCollisionRegistry::from_nbt(
    // rust: &Tag::compound([
    // rust: ("DataVersion", Tag::Int(DATA_VERSION)),
    // rust: (
    // rust: "states",
    // rust: Tag::List(vec![Tag::String("minecraft:air".into())]),
    // rust: ),
    // rust: ("shapes", Tag::List(vec![])),
    // rust: ("cached_shapes", Tag::IntArray(vec![-1])),
    // rust: ]),
    // rust: &registry,
    // rust: )
    // rust: .unwrap();
    // rust: let collision = BlockCollisionRegistry::new(std::sync::Arc::new(cached)).unwrap();
    // rust: let facts = BlockFacts {
    // rust: states: vec![],
    // rust: air: BlockStateId(0),
    // rust: woods: HashMap::new(),
}
    // rust: let world = World::new(BlockStateId(0), 0);
    // rust: let level = ParticleLevel {
    // rust: world: &world,
    // rust: facts: &facts,
    // rust: collision: &collision,
    // rust: player: None,
}
    // rust: let mut engine = ParticleEngine::new(Path::new(""), &HashMap::new(), &HashSet::new());
    // rust: let mut particle = Particle::blank(ParticleType::Smoke, [0.0; 3]);
    // rust: particle.has_physics = false;
    // rust: ModBehaviour::parse(&serde_json::json!({
    // rust: "velocity": [1, 2, -1], "gravity": 1, "friction": 0.5,
    // rust: "lifetime": 2, "size": [0.25, 0.75], "alpha": [1, 0]
    // rust: }))
    // rust: .unwrap()
    // rust: .apply(&mut particle, [0.0; 3], &mut LegacyRandom::new(1));
    // rust: assert_eq!(particle.size, 0.25);
    // rust: assert_eq!(particle.rgba[3], 1.0);
    // rust: engine.tick_particle(&mut particle, &level);
    // rust: assert_eq!(particle.age, 1);
    // rust: assert_eq!(particle.previous, [0.0; 3]);
    // rust: assert_eq!(particle.position, [1.0, 1.96, -1.0]);
    // rust: assert_eq!(particle.velocity, [0.5, 0.98, -0.5]);
    // rust: assert_eq!(particle.size, 0.5);
    // rust: assert_eq!(particle.rgba[3], 0.5);
    // rust: engine.tick_particle(&mut particle, &level);
    // rust: assert_eq!(particle.position, [1.5, 2.9, -1.5]);
    // rust: assert_eq!(particle.velocity, [0.25, 0.47, -0.25]);
    // rust: assert_eq!(particle.size, 0.75);
    // rust: assert_eq!(particle.rgba[3], 0.0);
    // rust: assert!(!particle.removed);
    // rust: engine.tick_particle(&mut particle, &level);
    // rust: assert!(particle.removed);
    // rust: assert_eq!(particle.position, [1.5, 2.9, -1.5]);
}

pub fn fading_mod_particles_use_the_blended_layer() void {
}
    // rust: let mut engine = ParticleEngine::new(Path::new(""), &HashMap::new(), &HashSet::new());
    // rust: engine.rects.push(Some(Rect {
    // rust: u0: 0.0,
    // rust: v0: 0.0,
    // rust: u1: 1.0,
    // rust: v1: 1.0,
    // rust: w: 16,
    // rust: h: 16,
    // rust: }));
    // rust: let mut particle = Particle::blank(ParticleType::Smoke, [0.0; 3]);
    // rust: ModBehaviour::parse(&serde_json::json!({"alpha": [0.5, 0]}))
    // rust: .unwrap()
    // rust: .apply(&mut particle, [0.0; 3], &mut LegacyRandom::new(1));
    // rust: particle.sprite = Sprite::Index(0);
    // rust: engine.particles.push(particle);
    // rust: let mut vertices = Vec::new();
    // rust: engine.render(DVec3::ZERO, 0.0, 0.0, 0.0, &|_| 0, &mut vertices);
    // rust: assert_eq!(vertices.len(), 4);
    // rust: assert!(vertices.iter().all(
    // rust: |v| v.color >> 24 == 127 && v.layer & crate::gfx::TRANSLUCENT_PARTICLE_OVERLAY != 0
    // rust: ));
}

    /// `LivingEntity.handleEntityEvent(46)`: 128 samples, the first on the old
    /// box and the last on the new one, with speeds inside ±0.1.
pub fn living_teleport_particles_span_the_old_and_new_boxes() void {
}
    // rust: let mut random = LegacyRandom::new(1);
    // rust: let mut samples = Vec::new();
    // rust: living_teleport_particles(
    // rust: &mut random,
    // rust: [0.0, 1.0, 0.0],
    // rust: [8.0, 1.0, 0.0],
    // rust: 0.6,
    // rust: 1.8,
    // rust: |p, v| samples.push((p, v)),
    // rust: );
    // rust: assert_eq!(samples.len(), 128);
    // rust: let first = samples[0].0;
    // rust: let last = samples[127].0;
    // rust: assert!(first[0].abs() <= 0.6, "{first:?}");
    // rust: assert!((1.0..2.8).contains(&first[1]), "{first:?}");
    // rust: assert!(first[2].abs() <= 0.6, "{first:?}");
    // rust: assert!((7.4..8.6).contains(&last[0]), "{last:?}");
    // rust: assert!((1.0..2.8).contains(&last[1]), "{last:?}");
    // rust: assert!(last[2].abs() <= 0.6, "{last:?}");
        // `(nextDouble - 0.5) * width * 2` reaches ±width. A spread of only
        // `width` (the factor of 2 dropped) stays inside 0.3 of the line.
    // rust: let edge = samples
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, (p, _))| {
    // rust: let along = (i as f64 / 127.0) * 8.0;
    // rust: (p[0] - along).abs()
    // rust: })
    // rust: .fold(0.0_f64, f64::max);
    // rust: assert!(edge > 0.45, "box spread reached only {edge}");
    // rust: for (_, v) in &samples {
    // rust: for c in v {
    // rust: assert!((-0.1..0.1).contains(c), "{v:?}");
}
}
}

pub fn egg_teleport_unpacks_offsets_and_preserves_seeded_draw_order() void {
}
    // rust: let mut engine = ParticleEngine::new(Path::new(""), &HashMap::new(), &HashSet::new());
    // rust: engine.seed_randoms(0, 0, 0);
        // Destination offset (-15, 7, 15); the unused top byte is ignored.
    // rust: engine.block_teleportation([4, 12, -5], 0xff01_0f1fu32 as i32, [16, 8, 16]);
    // rust: assert_eq!(engine.pending.len(), 128);
    // rust: assert!(engine.pending.iter().all(|p| p.ty == ParticleType::Portal));
    // rust: let first = &engine.pending[0];
    // rust: assert_eq!(
    // rust: first.position.map(f64::to_bits),
    // rust: [0x3fd18220c05a530a, 0x402b001e6be383c1, 0xbfc76bf5c46dbe5c]
    // rust: );
    // rust: assert_eq!(
    // rust: first.velocity.map(f64::to_bits),
    // rust: [0xbfaa91aee0000000, 0x3f95c78ce0000000, 0x3f9c24a0e0000000]
    // rust: );
    // rust: assert_eq!(
    // rust: engine.pending[127].position.map(f64::to_bits),
    // rust: [0xbfd728b135cb9ef6, 0x402ddd72dc6d0019, 0x3fe0b5775a29f186]
    // rust: );
    // rust: assert_eq!(engine.level_random.state(), 99_413_408_083_437);
    // rust: assert!(engine.sounds.is_empty());
}

pub fn consume_teleport_unpacks_offsets_within_127() void {
}
    // rust: let mut engine = ParticleEngine::new(Path::new(""), &HashMap::new(), &HashSet::new());
    // rust: engine.seed_randoms(0, 0, 0);
        // TeleportRandomlyConsumeEffect: BlockUtil.clampedPackDifferenceInPosition
        // of the move (-7, -3, 9) with radii 127, from (4, 12, -5) to (-3, 9, 4).
    // rust: let data = (-7 + 127) << 16 | (-3 + 127) << 8 | (9 + 127);
    // rust: engine.block_teleportation([4, 12, -5], data, [127, 127, 127]);
    // rust: assert_eq!(engine.pending.len(), 128);
    // rust: for p in &engine.pending {
    // rust: let [x, y, z] = p.position;
    // rust: assert!((-3.0..5.0).contains(&x), "{x}");
    // rust: assert!((8.5..12.5).contains(&y), "{y}");
    // rust: assert!((-5.0..5.0).contains(&z), "{z}");
}
        // The same draws as the egg's: only the unpacking differs.
    // rust: assert_eq!(engine.level_random.state(), 99_413_408_083_437);
}

pub fn egg_teleport_options_roll_before_distance_rejection() void {
}
    // rust: for (option, count, state) in [
    // rust: (0, 128, 99_413_408_083_437),
    // rust: (1, 89, 244_221_347_771_501),
    // rust: (2, 0, 99_413_408_083_437),
    // rust: ] {
    // rust: for distant in [false, true] {
    // rust: let mut engine =
    // rust: ParticleEngine::new(Path::new(""), &HashMap::new(), &HashSet::new());
    // rust: engine.seed_randoms(0, 0, 0);
    // rust: if distant {
    // rust: engine.camera = [1000.0; 3];
}
    // rust: engine.particle_level = option;
    // rust: engine.block_teleportation([4, 12, -5], 0x010f1f, [16, 8, 16]);
    // rust: assert_eq!(engine.pending.len(), if distant { 0 } else { count });
    // rust: assert_eq!(engine.level_random.state(), state);
}
}
}

pub fn mining_particles_follow_slab_and_trapdoor_height() void {
}
    // rust: for height in [0.5, 3.0 / 16.0] {
    // rust: let boxes = [[0.0, 0.0, 0.0, 1.0, height, 1.0]];
    // rust: let p = breaking_position(&mut LegacyRandom::new(1), [2, 97, 3], [0, 1, 0], &boxes)
    // rust: .unwrap();
    // rust: assert_eq!(p[1], 97.0 + height + f64::from(0.1f32));
    // rust: for seed in 0..128 {
    // rust: let p = breaking_position(&mut LegacyRandom::new(seed), [0; 3], [0, 0, -1], &boxes)
    // rust: .unwrap();
    // rust: assert!(p[1] <= height, "crumb above shape: {p:?}");
}
}
}
pub fn destroyed_slab_uses_its_shape_and_particle_density() void {
}
    // rust: let mut burst = Vec::new();
    // rust: destroy_positions([0; 3], &[[0.0, 0.0, 0.0, 1.0, 0.5, 1.0]], |p, v| {
    // rust: burst.push((p, v))
    // rust: });
    // rust: assert_eq!(burst.len(), 32);
    // rust: assert!(burst.iter().all(|(p, _)| p[1] < 0.5));
    // rust: assert_eq!(burst[0], ([0.125, 0.125, 0.125], [-0.375, -0.25, -0.375]));
}
pub fn empty_outline_emits_no_terrain_particles_or_random_draws() void {
}
    // rust: let mut r = LegacyRandom::new(1);
    // rust: assert_eq!(breaking_position(&mut r, [0; 3], [0, 1, 0], &[]), None);
    // rust: assert_eq!(r.next_long(), LegacyRandom::new(1).next_long());
    // rust: destroy_positions([0; 3], &[], |_, _| panic!("empty shape emitted a particle"));
}
pub fn every_hit_face_consumes_three_position_draws() void {
}
    // rust: let boxes = [[0.25, 0.0, 0.25, 0.75, 0.5, 0.75]];
    // rust: for face in [
    // rust: [-1, 0, 0],
    // rust: [1, 0, 0],
    // rust: [0, -1, 0],
    // rust: [0, 1, 0],
    // rust: [0, 0, -1],
    // rust: [0, 0, 1],
    // rust: ] {
    // rust: let mut random = LegacyRandom::new(42);
    // rust: let p = breaking_position(&mut random, [0; 3], face, &boxes).unwrap();
    // rust: let i = face.iter().position(|v| *v != 0).unwrap();
    // rust: let expected = if face[i] < 0 {
    // rust: boxes[0][i] - f64::from(0.1f32)
    // rust: } else {
    // rust: boxes[0][i + 3] + f64::from(0.1f32)
}
    // rust: assert_eq!(p[i], expected);
    // rust: let mut reference = LegacyRandom::new(42);
    // rust: for _ in 0..3 {
    // rust: reference.next_double();
}
    // rust: assert_eq!(random.next_long(), reference.next_long());
}
}
pub fn multipart_destroy_burst_uses_each_box_and_caps_widths() void {
}
    // rust: let boxes = [
    // rust: [0.0, 0.0, 0.0, 1.0, 0.5, 1.0],
    // rust: [0.0, 0.5, 0.5, 1.0, 1.0, 1.0],
    // rust: ];
    // rust: let mut burst = Vec::new();
    // rust: destroy_positions([0; 3], &boxes, |p, v| burst.push((p, v)));
    // rust: assert_eq!(burst.len(), 48);
    // rust: assert_eq!(burst[32].0, [0.125, 0.625, 0.625]);
    // rust: let mut tall = Vec::new();
    // rust: destroy_positions([0; 3], &[[0.0, 0.0, 0.0, 1.0, 1.5, 1.0]], |p, _| {
    // rust: tall.push(p)
    // rust: });
    // rust: assert_eq!(tall.len(), 64);
    // rust: assert!(tall.iter().all(|p| p[1] < 1.0));
}
pub fn spore_blossom_air_stops_at_its_particle_limit() void {
}
    // rust: let mut engine = ParticleEngine::new(Path::new(""), &HashMap::new(), &HashSet::new());
    // rust: let spore = ParticleOptions::simple(ParticleType::SporeBlossomAir);
    // rust: for i in 0..1001 {
    // rust: engine.create(&spore, [f64::from(i % 16), 70.0, 0.0], [0.0; 3]);
}
    // rust: assert_eq!(engine.pending.len(), 1000);
    // rust: assert!(
    // rust: engine
    // rust: .pending
    // rust: .iter()
    // rust: .all(|p| p.ty == ParticleType::SporeBlossomAir)
    // rust: );
        // A type without a `ParticleLimit` is not capped.
    // rust: let smoke = ParticleOptions::simple(ParticleType::Smoke);
    // rust: for _ in 0..10 {
    // rust: engine.create(&smoke, [0.0; 3], [0.0; 3]);
}
    // rust: assert_eq!(engine.pending.len(), 1010);
}
    /// `VibrationSignalParticle.Provider.createParticle`: the provider path
    /// the client's packet handler reaches (`add_with`) makes the signal from
    /// the option's destination and arrival time, where it used to refuse it.
pub fn a_vibration_option_makes_the_signal_its_provider_draws() void {
}
    // rust: let mut engine = ParticleEngine::new(Path::new(""), &HashMap::new(), &HashSet::new());
    // rust: let options =
    // rust: ParticleOptions::vibration(PositionSource::Block([10, 70, -4]), [10.5, 70.5, -3.5], 20);
        // Within the camera's 32 blocks, so only the provider decides.
    // rust: engine.add_with(&options, [0.5, 1.5, 0.5], [0.0; 3], false, false);
    // rust: assert_eq!(engine.made().get("vibration"), Some(&1));
    // rust: let q = engine.pending.first().expect("the signal is made");
    // rust: assert_eq!(q.ty, ParticleType::Vibration);
    // rust: assert_eq!(q.lifetime, 20);
    // rust: assert!((q.size - 0.3).abs() < 1e-6);
    // rust: assert!(!q.has_physics);
    // rust: match &q.behaviour {
    // rust: Behaviour::Vibration {
    // rust: dest, rot, pitch, ..
    // rust: } => {
    // rust: assert_eq!(*dest, [10.5, 70.5, -3.5]);
                // The constructor aims it from where it starts at the listener.
    // rust: let d: [f64; 3] = [0.5 - 10.5, 1.5 - 70.5, 0.5 + 3.5];
    // rust: assert!((*rot - d[0].atan2(d[2]) as f32).abs() < 1e-6);
    // rust: let flat = (d[0] * d[0] + d[2] * d[2]).sqrt();
    // rust: assert!((*pitch - d[1].atan2(flat) as f32).abs() < 1e-6);
}
    // rust: _ => panic!("a vibration signal"),
}
        // Only `VibrationParticleOption` carries a listener; a bare type has none.
    // rust: let bare = ParticleOptions::simple(ParticleType::Vibration);
    // rust: assert!(
    // rust: engine.make(&bare, [0.0; 3], [0.0; 3], 1).is_none(),
    // rust: "no destination, no signal"
    // rust: );
}
pub fn particle_names_round_trip() void {
}
    // rust: for &ty in ParticleType::ALL {
    // rust: assert_eq!(
    // rust: ParticleType::from_name(&format!("minecraft:{}", ty.name())),
    // rust: Some(ty)
    // rust: );
}
    // rust: assert_eq!(ParticleType::from_name("minecraft:not_a_particle"), None);
}
pub fn terrain_crumb_samples_a_mirrored_quarter() void {
}
    // rust: let mut r = LegacyRandom::new(1);
    // rust: let p = Particle::terrain(&mut r, [0.5; 3], [0.0; 3], "block/stone".into(), 0xFFFFFF);
    // rust: assert!((p.uv[0] - p.uv[2] - 0.25).abs() < 1e-6);
    // rust: assert!((p.uv[3] - p.uv[1] - 0.25).abs() < 1e-6);
    // rust: assert!((p.rgba[0] - 0.6).abs() < 1e-6);
        // The initial speed is normalized to 0.15..0.45 * 0.4 plus 0.1 upwards.
    // rust: let s =
    // rust: (p.velocity[0].powi(2) + (p.velocity[1] - 0.1).powi(2) + p.velocity[2].powi(2)).sqrt();
    // rust: assert!((0.15 * 0.4 - 1e-6..=0.45 * 0.4 + 1e-6).contains(&s));
}
pub fn sizes_follow_vanilla_curves() void {
}
    // rust: let mut r = LegacyRandom::new(2);
    // rust: let mut p = Particle::at(&mut r, ParticleType::Flame, [0.0; 3]);
    // rust: p.size = 1.0;
    // rust: p.lifetime = 10;
    // rust: p.age = 5;
    // rust: p.size_curve = Size::Flame;
    // rust: assert!((p.quad_size(0.0) - (1.0 - 0.25 * 0.5)).abs() < 1e-6);
    // rust: p.size_curve = Size::GrowIn;
    // rust: p.age = 0;
    // rust: assert!((p.quad_size(0.1) - (0.1f32 / 10.0 * 32.0)).abs() < 1e-6);
}
pub fn lifetime_alpha_interpolates() void {
}
    // rust: let a = [0.0, 0.6, 0.25, 1.0];
    // rust: assert_eq!(lifetime_alpha(a, 0, 40, 0.0), 0.0);
    // rust: assert!((lifetime_alpha(a, 40, 40, 0.0) - 0.6).abs() < 1e-6);
}
pub fn explosion_tracker_tracks_and_ignores_zero_blocks() void {
}
    // rust: let mut engine = ParticleEngine::new(Path::new(""), &HashMap::new(), &HashSet::new());
    // rust: assert!(engine.tracked_explosions.is_empty());
    // rust: engine.track_explosion([1.0, 2.0, 3.0], 4.0, 100);
    // rust: engine.track_explosion([5.0, 6.0, 7.0], 2.0, 50);
    // rust: assert_eq!(engine.tracked_explosions.len(), 2);
    // rust: assert_eq!(engine.tracked_explosions[0].block_count, 100);
    // rust: assert_eq!(engine.tracked_explosions[1].block_count, 50);

        // Zero block count explosions are not queued.
    // rust: engine.track_explosion([0.0; 3], 1.0, 0);
    // rust: assert_eq!(engine.tracked_explosions.len(), 2);
}
pub fn explosion_tracker_caps_debris_at_512_across_multiple_explosions() void {
}
    // rust: let mut engine = ParticleEngine::new(Path::new(""), &HashMap::new(), &HashSet::new());
        // Queue two explosions near camera: 400 blocks and 300 blocks (total 700).
    // rust: engine.track_explosion([0.0, 0.0, 0.0], 4.0, 400);
    // rust: engine.track_explosion([2.0, 0.0, 2.0], 5.0, 300);
    // rust: assert_eq!(engine.tracked_explosions.len(), 2);

        // In pure air, total particles spawned must be capped at 512.
    // rust: engine.tick_explosions_with(&|_| true);
    // rust: assert_eq!(engine.pending.len(), 512);
    // rust: assert!(engine.tracked_explosions.is_empty());
}
pub fn explosion_tracker_emits_debris_only_in_air() void {
}
    // rust: let mut engine = ParticleEngine::new(Path::new(""), &HashMap::new(), &HashSet::new());
    // rust: engine.track_explosion([0.0, 64.0, 0.0], 4.0, 100);

        // When no blocks are air, zero debris particles are emitted.
    // rust: engine.tick_explosions_with(&|_| false);
    // rust: assert_eq!(engine.pending.len(), 0);
    // rust: assert!(engine.tracked_explosions.is_empty());
}
}
