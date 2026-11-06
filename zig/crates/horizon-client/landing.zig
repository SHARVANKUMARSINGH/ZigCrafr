//! Transpiled from Horizon Rust crate
//! Module: horizon-client_landing
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Resident-world landing, registered block reactions and fall-damage requests.
//! Health, sound/particle playback and network delivery remain event consumers.
// use crate::{
    // rust: Result,
    // rust: collisions::SceneCollisions,
    // rust: motion::{MotionEvent, MotionWorld},
}
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3, VoxelShape},
    // rust: position::BlockPos,
    // rust: random::RandomSource,
}
// use horizon_world::{
    // rust: block_entity_push::BlockPushWorld,
    // rust: block_landing::{
    // rust: BlockLandingRegistry, BlockLandingWorld, DamageSourceOwner, FallDefinition, LandingDamage,
    // rust: LandingDefinition, LandingEntityKind, LandingEvent, LandingSound,
    // rust: },
    // rust: entity_obstruction::EntityIdentity,
    // rust: fall_damage::FallDamageWorld,
    // rust: living_fall::{self, LivingFallWorld},
    // rust: living_landing::LivingLandingWorld,
    // rust: movement_properties::MovementProperties,
    // rust: registry::BlockStateId,
}
// use std::{collections::BTreeMap, fs, path::Path};

/// A living entity is about to handle a fall (`LivingFallEvent`). Mods may
/// change the distance and damage multiplier, or cancel fall handling.
/// 357.
    // rust: pub fn native_living_fall(
    // rust: entity: u32,
    // rust: kind: &str,
    // rust: distance: &mut f64,
    // rust: multiplier: &mut f32,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: crate::native_client_hooks::living_fall(entity, kind, distance, multiplier, cancel);
}

pub fn load(root: *Path, properties: *MovementProperties<'_>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let raw: BTreeMap<String, serde_json::Value> =
    // rust: serde_json::from_slice(&fs::read(root.join("landing-definitions.json"))?)?;
    // rust: let mut definitions = BTreeMap::new();
    // rust: for (name, d) in raw {
    // rust: let float = |key: &str| -> Result<f32> {
    // rust: Ok(f32::from_bits(u32::from_str_radix(
    // rust: d[key].as_str().ok_or("missing landing float")?,
    // rust: 16,
    // rust: )?))
}
    // rust: let fall = match d["fall"].as_str().ok_or("missing landing family")? {
    // rust: "Block" => FallDefinition::Default,
    // rust: "HayBlock" => FallDefinition::Hay,
    // rust: "HoneyBlock" => FallDefinition::Honey {
    // rust: volume: float("volume")?,
    // rust: pitch: float("pitch")?,
    // rust: },
    // rust: "SlimeBlock" => FallDefinition::Slime,
    // rust: "PowderSnowBlock" => FallDefinition::PowderSnow,
    // rust: "PointedDripstoneBlock" => FallDefinition::PointedDripstone,
    // rust: "FarmlandBlock" => FallDefinition::Farmland {
    // rust: base_block: d["base"].as_str().ok_or("missing farmland base")?.into(),
    // rust: },
    // rust: "TurtleEggBlock" => FallDefinition::TurtleEgg,
    // rust: _ => return Err("unsupported landing family".into()),
}
    // rust: definitions.insert(
    // rust: name,
    // rust: LandingDefinition {
    // rust: fall,
    // rust: shelf_mushroom_bounce: d["bounce"].as_bool().ok_or("missing bounce flag")?,
    // rust: },
    // rust: );
}
    // rust: Ok(BlockLandingRegistry::new(properties, &definitions)?)
}
pub const SceneSound = enum {
    Block(LandingSound),
    SmallFall,
    BigFall,
};
    // rust: impl SceneSound {
    /// The sound event of `LivingEntity.getFallDamageSound` for a player, if
    /// this is one of the two fall sounds.
pub fn player_fall_sound(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::BigFall => Some("minecraft:entity.player.big_fall"),
    // rust: Self::SmallFall => Some("minecraft:entity.player.small_fall"),
    // rust: Self::Block(_) => None,
}
}
    /// The sound event a block plays where it is (`Level.playSound(null, pos,
    /// ..)`, which every player hears), if this is one: a turtle egg breaking
    /// (`TurtleEggBlock.decreaseEggs`), a shelf mushroom bouncing.
pub fn block_sound(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Block(LandingSound::TurtleEggBreak) => Some("minecraft:entity.turtle.egg_break"),
    // rust: Self::Block(LandingSound::ShelfMushroomBounce) => {
    // rust: Some("minecraft:block.shelf_mushroom.bounce")
}
    // rust: _ => None,
}
}
    /// `HoneyBlock.fallOn`: `entity.playSound` of the slide, and of the block's
    /// own fall sound when the landing still hurts. A player's `playSound`
    /// skips that player; their client plays the same event itself.
pub fn honey_landing_sound(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Block(LandingSound::HoneySlide) => Some("minecraft:block.honey_block.slide"),
    // rust: Self::Block(LandingSound::HoneyFall) => Some("minecraft:block.honey_block.fall"),
    // rust: _ => None,
}
}
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::SmallFall => "small",
    // rust: Self::BigFall => "big",
    // rust: Self::Block(v) => match v {
    // rust: LandingSound::HoneySlide => "honey-slide",
    // rust: LandingSound::HoneyFall => "honey-fall",
    // rust: LandingSound::TurtleEggBreak => "egg-break",
    // rust: LandingSound::ShelfMushroomBounce => "mushroom",
    // rust: },
}
}
}
/// `HoneyBlock.showParticles`: a slide (entity event 53) sheds 5 honey-block
/// crumbs, a landing (entity event 54) sheds 10.
pub fn honey_particle_count(event: i8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match event {
    // rust: 53 => Some(5),
    // rust: 54 => Some(10),
    // rust: _ => None,
}
}

pub const FallEvent = enum {
    Particles {,
    state: BlockStateId,
    position: Vec3,
    count: i32,
    speed: f64,
    // rust: },
    HitGround {,
    position: Vec3,
    state: BlockStateId,
    // rust: },
    Statistic(i32),
    Damage {,
    source: LandingDamage,
    amount: f32,
    // rust: },
    Sound {,
    sound: SceneSound,
    position: Option<BlockPos>,
    volume: f32,
    pitch: f32,
    // rust: },
    BlockFallSound,
    Broadcast(u8),
    Write {,
    position: BlockPos,
    state: BlockStateId,
    flags: u32,
    // rust: },
    Destroy {,
    position: BlockPos,
    drops: bool,
        /// The block it destroyed, for `Level.destroyBlock`'s level event 2001.
    state: BlockStateId,
    // rust: },
    BlockEvent {,
    kind: LandingEvent,
    position: BlockPos,
    state: BlockStateId,
    with_entity: bool,
    // rust: },
    LevelEvent {,
    event: i32,
    position: BlockPos,
    data: i32,
    // rust: },
};
    // rust: impl FallEvent {
    /// Exact-bit diagnostic representation shared by the headless scene probe.
pub fn trace(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
pub fn p(v: BlockPos) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!("{},{},{}", v.x, v.y, v.z)
}
pub fn v(v: Vec3) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!(
    // rust: "{:016x},{:016x},{:016x}",
    // rust: v.x.to_bits(),
    // rust: v.y.to_bits(),
    // rust: v.z.to_bits()
    // rust: )
}
    // rust: match self {
    // rust: Self::Particles {
    // rust: state,
    // rust: position,
    // rust: count,
    // rust: speed,
    // rust: } => format!(
    // rust: "particles {} {} {} {:016x}",
    // rust: state.0,
    // rust: v(position),
    // rust: count,
    // rust: speed.to_bits()
    // rust: ),
    // rust: Self::HitGround { position, state } => format!("hit {} {}", v(position), state.0),
    // rust: Self::Statistic(n) => format!("stat {n}"),
    // rust: Self::Damage { source, amount } => format!(
    // rust: "damage {} {:08x}",
    // rust: if source == LandingDamage::Fall {
    // rust: "fall"
    // rust: } else {
    // rust: "stalagmite"
    // rust: },
    // rust: amount.to_bits()
    // rust: ),
    // rust: Self::Sound {
    // rust: sound,
    // rust: position,
    // rust: volume,
    // rust: pitch,
    // rust: } => format!(
    // rust: "sound {} {} {:08x} {:08x}",
    // rust: sound.name(),
    // rust: position.map_or_else(|| "entity".into(), p),
    // rust: volume.to_bits(),
    // rust: pitch.to_bits()
    // rust: ),
    // rust: Self::BlockFallSound => "block-fall-sound".into(),
    // rust: Self::Broadcast(event) => format!("broadcast {event}"),
    // rust: Self::Write {
    // rust: position,
    // rust: state,
    // rust: flags,
    // rust: } => format!("write {} {} {}", p(position), state.0, flags),
    // rust: Self::Destroy {
    // rust: position, drops, ..
    // rust: } => format!("destroy {} {}", p(position), drops),
    // rust: Self::BlockEvent {
    // rust: kind,
    // rust: position,
    // rust: state,
    // rust: with_entity,
    // rust: } => format!(
    // rust: "event {} {} {} {}",
    // rust: if kind == LandingEvent::BlockChange {
    // rust: "change"
    // rust: } else {
    // rust: "destroy"
    // rust: },
    // rust: p(position),
    // rust: state.0,
    // rust: with_entity
    // rust: ),
    // rust: Self::LevelEvent {
    // rust: event,
    // rust: position,
    // rust: data,
    // rust: } => format!("level-event {} {} {}", event, p(position), data),
}
}
}
    // rust: impl MotionWorld<'_, '_, '_> {
    // rust: fn mod_block_fall(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: position: BlockPos,
    // rust: distance: f64,
    // rust: damage: f32,
    // rust: ) -> f32 {
    // rust: let block = self
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .map(|s| s.name.as_str())
    // rust: .unwrap_or("minecraft:air");
    // rust: crate::block_contact::fall(
    // rust: crate::block_contact::Contact {
    // rust: entity: self.player.entity_id,
    // rust: kind: "minecraft:player",
    // rust: block,
    // rust: state,
    // rust: position,
    // rust: },
    // rust: distance,
    // rust: damage,
    // rust: )
}
pub fn fall_event(self: *Self, event: FallEvent) void {
}
    // rust: self.player.events.push(MotionEvent::Fall(event));
}
    // rust: fn player_fall_damage(
    // rust: &mut self,
    // rust: distance: f64,
    // rust: multiplier: f32,
    // rust: source: LandingDamage,
    // rust: contact: Option<(BlockStateId, BlockPos, f64)>,
    // rust: ) -> Result<bool> {
        // Player.causeFallDamage exempts players with the mayfly ability,
        // including creative players who are currently walking.
    // rust: if self.player.may_fly {
    // rust: if let Some((state, position, original_distance)) = contact {
    // rust: self.mod_block_fall(state, position, original_distance, 0.0);
}
    // rust: return Ok(false);
}
        // Record centimeters before delegating to LivingEntity.
    // rust: if distance >= 2.0 || distance.is_nan() {
    // rust: let scaled = distance * 100.0;
    // rust: let floor = scaled.floor();
    // rust: let rounded = (if scaled - floor >= 0.5 {
    // rust: floor + 1.0
    // rust: } else {
    // rust: floor
    // rust: }) as i64;
    // rust: self.fall_event(FallEvent::Statistic(rounded as i32));
}
    // rust: let mut distance = distance;
    // rust: let mut multiplier = multiplier;
    // rust: let mut cancel = false;
    // rust: if !self.player.replaying {
    // rust: native_living_fall(
    // rust: self.player.entity_id as u32,
    // rust: "minecraft:player",
    // rust: &mut distance,
    // rust: &mut multiplier,
    // rust: &mut cancel,
    // rust: );
}
        // A canceled fall still lands on the block (`Block.fallOn`).
    // rust: if cancel {
    // rust: if let Some((state, position, original_distance)) = contact {
    // rust: self.mod_block_fall(state, position, original_distance, 0.0);
}
    // rust: return Ok(false);
}
    // rust: living_fall::cause_living_fall_damage(
    // rust: &mut FallCall {
    // rust: world: self,
    // rust: source,
    // rust: contact,
    // rust: },
    // rust: distance,
    // rust: multiplier,
    // rust: )
}
    /// `Entity.propagateFallToPassengers`: the call on this player, whose
    /// vehicle fell `distance` blocks at `multiplier`, so the player takes
    /// `Player.causeFallDamage` of it.
pub fn cause_mount_fall(self: *Self, distance: f64, multiplier: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: BlockLandingWorld::cause_fall_damage(self, distance, multiplier, LandingDamage::Fall)
}
}
    // rust: impl FallDamageWorld for MotionWorld<'_, '_, '_> {
    // rust: type Error = Box<dyn std::error::Error>;
    // rust: type State = BlockStateId;
pub fn is_in_water(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.fluids.was_touching_water)
}
pub fn fall_distance(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.fall_distance
}
pub fn set_fall_distance(self: *Self, value: f64) void {
}
    // rust: self.player.fall_distance = value;
}
pub fn fall_on(self: *Self, state: BlockStateId, position: BlockPos, distance: f64) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let block = self
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .map(|s| s.name.as_str())
    // rust: .unwrap_or("minecraft:air");
    // rust: let previous = self.player.block_landing.take();
    // rust: if !block.starts_with("minecraft:") {
    // rust: self.player.block_landing = Some((state, position, distance));
}
        // Keep template landing rules (hay, honey, slime, etc.) in control.
    // rust: let result = self
    // rust: .resources
    // rust: .landing
    // rust: .fall_on(self, state, position, LandingEntityKind::Player, distance)
    // rust: .map_err(|e| e.to_string().into());
    // rust: let pending = self.player.block_landing.take();
    // rust: self.player.block_landing = previous;
    // rust: if result.is_ok()
    // rust: && let Some((state, position, distance)) = pending
    // rust: {
            // Some landing rules never call causeFallDamage.
    // rust: self.mod_block_fall(state, position, distance, 0.0);
}
    // rust: result
}

pub fn position(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.position
}
pub fn supporting_block(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.ground.supporting_block
}
pub fn block_state(self: *Self, p: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.scene.block(p.x, p.y, p.z))
}
pub fn hit_ground(self: *Self, position: Vec3, state: BlockStateId) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.fall_event(FallEvent::HitGround { position, state });
    // rust: Ok(())
}
pub fn reset_fall_distance(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.fall_distance = 0.0;
    // rust: Ok(())
}
}
    // rust: impl LivingLandingWorld for MotionWorld<'_, '_, '_> {
pub fn update_fluid_interaction(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.update_fluids()
}
pub fn is_server_level(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn on_changed_block(self: *Self, _: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
    // rust: } // empty equipment
pub fn safe_fall_distance(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.attribute("minecraft:safe_fall_distance")
}
pub fn state_is_air(self: *Self, state: BlockStateId) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.scene.is_air(state))
}
pub fn block_position(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(BlockPos::containing(self.player.position))
}
    // rust: fn landing_particles(
    // rust: &mut self,
    // rust: state: BlockStateId,
    // rust: position: Vec3,
    // rust: count: i32,
    // rust: speed: f64,
    // rust: ) -> Result<()> {
    // rust: self.fall_event(FallEvent::Particles {
    // rust: state,
    // rust: position,
    // rust: count,
    // rust: speed,
    // rust: });
    // rust: Ok(())
}
pub fn clear_last_climbable_position(self: *Self) void {
}
    // rust: self.player.last_climbable = None;
}
}
    // rust: impl BlockPushWorld for MotionWorld<'_, '_, '_> {
    // rust: type Error = Box<dyn std::error::Error>;
pub fn collision_shape(self: *Self, state: BlockStateId, p: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut world = SceneCollisions {
    // rust: world: self.scene,
    // rust: binding: self.collision_binding,
    // rust: subject: None,
}
    // rust: self.collision_binding
    // rust: .collision_shape(&mut world, state, [p.x, p.y, p.z])
    // rust: .map_err(|e| e.to_string().into())
}
pub fn entities(self: *Self, bounds: Aabb) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(if bounds.intersects(self.player.bounds()) {
    // rust: vec![EntityIdentity(0)]
    // rust: } else {
    // rust: vec![]
    // rust: })
}
pub fn entity_bounds(self: *Self, _: EntityIdentity) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.bounds()
}
pub fn teleport_relative(self: *Self, _: EntityIdentity, movement: Vec3) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.position = Vec3::new(
    // rust: self.player.position.x + movement.x,
    // rust: self.player.position.y + movement.y,
    // rust: self.player.position.z + movement.z,
    // rust: );
    // rust: Ok(())
}
}
    // rust: impl BlockLandingWorld for MotionWorld<'_, '_, '_> {
    // rust: type DamageSource = LandingDamage;
    // rust: type Sound = SceneSound;
pub fn is_server_level(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
        // A remote client's world is a client level: it never tramples,
        // the server's block change and teleport do it (FarmlandBlock.fallOn
        // and TurtleEggBlock.fallOn check `level instanceof ServerLevel`).
    // rust: !self.player.client_side
}
pub fn is_client_side(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.client_side)
}
pub fn random_float(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.scene.random.next_float())
}
pub fn random_int(self: *Self, bound: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.scene.random.next_int_bound(bound)?)
}
pub fn under_spawn_protection(self: *Self, _: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn mob_griefing(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(true)
}
pub fn entity_dimensions(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.player.dimensions.width, self.player.dimensions.height)
}
pub fn suppressing_bounce(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.shift_key_down)
}
    // rust: fn damage_source(
    // rust: &mut self,
    // rust: _: DamageSourceOwner,
    // rust: kind: LandingDamage,
    // rust: ) -> Result<LandingDamage> {
    // rust: Ok(kind)
}
    // rust: fn cause_fall_damage(
    // rust: &mut self,
    // rust: distance: f64,
    // rust: multiplier: f32,
    // rust: source: LandingDamage,
    // rust: ) -> Result<bool> {
    // rust: let contact = self.player.block_landing.take();
    // rust: self.player_fall_damage(distance, multiplier, source, contact)
}
pub fn known_sound(self: *Self, s: LandingSound) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: SceneSound::Block(s)
}
pub fn living_fall_sound(self: *Self, big: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(if big {
    // rust: SceneSound::BigFall
    // rust: } else {
    // rust: SceneSound::SmallFall
    // rust: })
}
pub fn entity_sound(self: *Self, sound: SceneSound, volume: f32, pitch: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.fall_event(FallEvent::Sound {
    // rust: sound,
    // rust: position: None,
    // rust: volume,
    // rust: pitch,
    // rust: });
    // rust: Ok(())
}
    // rust: fn block_sound(
    // rust: &mut self,
    // rust: position: BlockPos,
    // rust: sound: SceneSound,
    // rust: volume: f32,
    // rust: pitch: f32,
    // rust: ) -> Result<()> {
    // rust: self.fall_event(FallEvent::Sound {
    // rust: sound,
    // rust: position: Some(position),
    // rust: volume,
    // rust: pitch,
    // rust: });
    // rust: Ok(())
}
pub fn broadcast_entity_event(self: *Self, event: u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.fall_event(FallEvent::Broadcast(event));
    // rust: Ok(())
}
pub fn destroy_block(self: *Self, position: BlockPos, drops: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let air = self
    // rust: .assets
    // rust: .registry
    // rust: .default_state("minecraft:air")
    // rust: .ok_or("missing air")?;
    // rust: let state = self.scene.block(position.x, position.y, position.z);
    // rust: self.scene.set(position.x, position.y, position.z, air)?;
    // rust: self.fall_event(FallEvent::Destroy {
    // rust: position,
    // rust: drops,
    // rust: state,
    // rust: });
    // rust: Ok(true)
}
pub fn set_block(self: *Self, position: BlockPos, state: BlockStateId, flags: u32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.scene.set(position.x, position.y, position.z, state)?;
    // rust: self.fall_event(FallEvent::Write {
    // rust: position,
    // rust: state,
    // rust: flags,
    // rust: });
    // rust: Ok(true)
}
    // rust: fn block_event(
    // rust: &mut self,
    // rust: kind: LandingEvent,
    // rust: position: BlockPos,
    // rust: state: BlockStateId,
    // rust: with_entity: bool,
    // rust: ) -> Result<()> {
    // rust: self.fall_event(FallEvent::BlockEvent {
    // rust: kind,
    // rust: position,
    // rust: state,
    // rust: with_entity,
    // rust: });
    // rust: Ok(())
}
pub fn level_event(self: *Self, event: i32, position: BlockPos, data: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.fall_event(FallEvent::LevelEvent {
    // rust: event,
    // rust: position,
    // rust: data,
    // rust: });
    // rust: Ok(())
}
}
pub const FallCall = struct {
    world: *'a mut MotionWorld<'p,
    source: LandingDamage,
    contact: Option<(BlockStateId,
};
    // rust: impl LivingFallWorld for FallCall<'_, '_, '_, '_> {
    // rust: type Error = Box<dyn std::error::Error>;
    // rust: type Sound = SceneSound;
pub fn impact_position(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world.player.impulse.impact_position
}
pub fn y(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world.player.position.y
}
pub fn reset_impulse(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world.player.impulse.reset();
    // rust: Ok(())
}
pub fn try_reset_impulse(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world.player.impulse.try_reset();
    // rust: Ok(())
}
pub fn immune_to_fall_damage(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
    // rust: } // player type
pub fn propagate_fall_to_passengers(self: *Self, _: f64, _: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
    // rust: } // no passengers
pub fn safe_fall_distance(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world.player.attribute("minecraft:safe_fall_distance")
}
pub fn fall_damage_multiplier(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world
    // rust: .player
    // rust: .attribute("minecraft:fall_damage_multiplier")
}
pub fn modify_fall_damage(self: *Self, _distance: f64, damage: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.contact.map_or(damage, |(state, position, distance)| {
    // rust: self.world.mod_block_fall(state, position, distance, damage)
    // rust: }))
}
pub fn fall_sound(self: *Self, big: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world.living_fall_sound(big)
}
pub fn play_fall_sound(self: *Self, sound: SceneSound) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world.entity_sound(sound, 1.0, 1.0)
}
pub fn play_block_fall_sound(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world.fall_event(FallEvent::BlockFallSound);
    // rust: Ok(())
}
pub fn hurt(self: *Self, amount: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world.fall_event(FallEvent::Damage {
    // rust: source: self.source,
    // rust: amount,
    // rust: });
    // rust: let resources = self.world.health;
    // rust: self.world.player.hurt(
    // rust: resources,
    // rust: self.world.scene.health_rules,
    // rust: resources.landing_source(self.source),
    // rust: amount,
    // rust: )?;
    // rust: Ok(())
}
}
    // rust: mod tests {
//     use super::*;

    /// Both landing sources use the world's frozen definitions and current
    /// damage tags, including a tag-only reload with no pack definitions left.
pub fn datapack_damage_landing_uses_world_armor_tags_and_exhaustion() void {
}
//         use crate::{assets::Assets, motion::MotionResources, world::World};
//         use horizon_world::loot::PackOverlay;
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let collision = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let files = vec![
    // rust: (
    // rust: "damage_type/minecraft:fall".into(),
    // rust: vec![br#"{"message_id":"fall","scaling":"never","exhaustion":0.75}"#.to_vec()],
    // rust: ),
    // rust: (
    // rust: "damage_type/minecraft:stalagmite".into(),
    // rust: vec![br#"{"message_id":"stalagmite","scaling":"never","exhaustion":0.5}"#.to_vec()],
    // rust: ),
    // rust: (
    // rust: "tags/minecraft:damage_type/bypasses_armor".into(),
    // rust: vec![br#"{"replace":true,"values":[]}"#.to_vec()],
    // rust: ),
    // rust: ];
    // rust: let open = resources
    // rust: .health
    // rust: .with_packs(&root, &PackOverlay { files: &files }, false)
    // rust: .unwrap();
    // rust: let reloaded = open.with_packs(&root, &PackOverlay::NONE, true).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 1).unwrap();
    // rust: for (source, exhaustion, name) in [
    // rust: (LandingDamage::Fall, 0.75, "minecraft:fall"),
    // rust: (LandingDamage::Stalagmite, 0.5, "minecraft:stalagmite"),
    // rust: ] {
    // rust: for (health, bypass) in [(&resources.health, true), (&open, false), (&reloaded, true)] {
    // rust: let mut player = crate::motion::PlayerMotion::new(&resources, Vec3::ZERO).unwrap();
    // rust: let key = player.attributes.key("minecraft:armor").unwrap();
    // rust: let armor = player.attributes.get_instance(Some(key)).unwrap().unwrap();
    // rust: player
    // rust: .attributes
    // rust: .edit(&armor, |a, o| a.set_base_value(20.0, o))
    // rust: .unwrap();
    // rust: BlockLandingWorld::cause_fall_damage(
    // rust: &mut MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &collision,
    // rust: resources: &resources,
    // rust: health,
    // rust: },
    // rust: 7.0,
    // rust: 1.0,
    // rust: source,
    // rust: )
    // rust: .unwrap();
    // rust: if bypass {
    // rust: assert_eq!(player.health.health(), 16.0, "{name}");
    // rust: } else {
    // rust: assert!(
    // rust: player.health.health() > 16.0 && player.health.health() < 20.0,
    // rust: "{name}"
    // rust: );
}
    // rust: assert_eq!(player.hurt_log.last().unwrap().source, name);
    // rust: let expected = if std::ptr::eq(health, &resources.health) {
    // rust: 0.0
    // rust: } else {
    // rust: exhaustion
}
    // rust: assert_eq!(player.health.food.exhaustion, expected, "{name}");
}
}
}

pub fn fall_sounds_map_to_player_events() void {
}
    // rust: assert_eq!(
    // rust: SceneSound::BigFall.player_fall_sound(),
    // rust: Some("minecraft:entity.player.big_fall")
    // rust: );
    // rust: assert_eq!(
    // rust: SceneSound::SmallFall.player_fall_sound(),
    // rust: Some("minecraft:entity.player.small_fall")
    // rust: );
    // rust: assert_eq!(
    // rust: SceneSound::Block(LandingSound::HoneyFall).player_fall_sound(),
    // rust: None
    // rust: );
}

    /// The sounds a block plays where it is; the honey block's are the
    /// entity's own (`Entity.playSound`) and the fall sounds the player's.
pub fn block_sounds_map_to_block_events() void {
}
    // rust: assert_eq!(
    // rust: SceneSound::Block(LandingSound::TurtleEggBreak).block_sound(),
    // rust: Some("minecraft:entity.turtle.egg_break")
    // rust: );
    // rust: assert_eq!(
    // rust: SceneSound::Block(LandingSound::ShelfMushroomBounce).block_sound(),
    // rust: Some("minecraft:block.shelf_mushroom.bounce")
    // rust: );
    // rust: assert_eq!(
    // rust: SceneSound::Block(LandingSound::HoneySlide).block_sound(),
    // rust: None
    // rust: );
    // rust: assert_eq!(SceneSound::BigFall.block_sound(), None);
}

    /// `HoneyBlock.fallOn` plays the slide, then the block's fall sound when
    /// the landing hurts. `showSlideParticles` is entity event 53 (5 crumbs);
    /// `showJumpParticles` is entity event 54 (10).
pub fn a_honey_landing_names_its_sounds_and_particle_counts() void {
}
    // rust: assert_eq!(
    // rust: SceneSound::Block(LandingSound::HoneySlide).honey_landing_sound(),
    // rust: Some("minecraft:block.honey_block.slide")
    // rust: );
    // rust: assert_eq!(
    // rust: SceneSound::Block(LandingSound::HoneyFall).honey_landing_sound(),
    // rust: Some("minecraft:block.honey_block.fall")
    // rust: );
    // rust: assert_eq!(SceneSound::SmallFall.honey_landing_sound(), None);
    // rust: assert_eq!(honey_particle_count(53), Some(5));
    // rust: assert_eq!(honey_particle_count(54), Some(10));
    // rust: assert_eq!(honey_particle_count(46), None);
}
}
