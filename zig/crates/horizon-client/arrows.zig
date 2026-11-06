//! Transpiled from Horizon Rust crate
//! Module: horizon-client_arrows
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `AbstractArrow.tick` for arrows, tipped and spectral arrows: the flight with
//! its water inertia and bubbles, the base tick's fluids (currents, splash),
//! bubble columns and water along the path, sticking in blocks, falling out
//! when the block goes, and despawning. The tick stops at an entity it hits:
//! the game hurts the entity (`projectile_hit`), then `finish_entity_hit`
//! spends the arrow or turns it back and ends the tick.
// use crate::entity_rules::EntityRules;
// use crate::{
    // rust: blocks::BlockFacts,
    // rust: collisions::SceneCollisions,
    // rust: mobs::Who,
    // rust: motion::{FluidResources, LAVA, WATER},
    // rust: projectiles::{Hit, Projectile, ProjectileKind},
    // rust: world::World,
}
// use horizon_core::{
    // rust: geometry::{Aabb, Direction, Vec3, sweep_intersected_blocks},
    // rust: position::BlockPos,
    // rust: random::{LegacyRandom, RandomSource},
}
// use horizon_world::{
    // rust: block_collision::BlockCollisionRegistry,
    // rust: entity_fluid::{
    // rust: CurrentTarget, EntityFluidInteraction, FluidInteractionWorld, FluidMembership,
    // rust: FluidSections, FluidTagId,
    // rust: },
    // rust: entity_fluid_tick::{self, EntityFluidTickWorld},
    // rust: fluid::{FluidHeightWorld, FluidKind, FluidState},
    // rust: fluid_flow::{FluidFlowWorld, flow_at},
    // rust: registry::BlockStateId,
    // rust: water_splash::{self, SplashParticle, WaterSplashWorld},
}
// use std::{collections::HashSet, fmt};

/// `EntityType.ARROW` (and tipped/spectral arrows): 0.5 x 0.5, eyes at 0.13.
pub const WIDTH: f32 = 0.5;
pub const HEIGHT: f32 = 0.5;
pub const EYE_HEIGHT: f32 = 0.13;

/// `AbstractArrow.Pickup`.
pub const Pickup = enum {
    Disallowed,
    Allowed,
    CreativeOnly,
};
    // rust: impl Pickup {
    /// The saved `pickup` byte (`LEGACY_CODEC`: the ordinal, out of range is
    /// DISALLOWED).
pub fn from_byte(b: i64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match b {
    // rust: 1 => Self::Allowed,
    // rust: 2 => Self::CreativeOnly,
    // rust: _ => Self::Disallowed,
}
}
pub fn byte(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self as i8
}
}
/// `DataComponents.INTANGIBLE_PROJECTILE`.
pub const INTANGIBLE: []const u8 = "minecraft:intangible_projectile";
/// `ProjectileWeaponItem.useAmmo`'s drawn stack: one of the ammo, marked
/// intangible when no ammo was used (creative, Infinity, multishot extras).
pub fn drawn_ammo(ammo: *crate::items::ItemStack, intangible: bool) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut drawn = crate::items::ItemStack {
    // rust: count: 1,
    // rust: ..ammo.clone()
}
    // rust: if intangible {
    // rust: drawn.data_mut().set_other(
    // rust: INTANGIBLE,
    // rust: Some(horizon_world::nbt::Tag::Compound(Default::default())),
    // rust: );
}
    // rust: drawn
}
/// What `AbstractArrow.playerTouch` does for a player touching the arrow.
pub const Touch = enum {
    /// Not stuck yet, still shaking, or not the player's to take.
    Ignore,
    /// ALLOWED: taken if the inventory takes this stack whole.
    Give(crate::items::ItemStack),
    /// CREATIVE_ONLY in creative: taken without an item.
    Take,
};
/// What an arrow's tick asks the game to play or show.
pub const ArrowEvent = enum {
    /// `level().addParticle` (the client's copy of the arrow adds them).
    Particle {,
    kind: ArrowParticle,
    position: Vec3,
    velocity: Vec3,
    // rust: },
    /// `Level.broadcastEntityEvent(arrow, 0)`: a tipped arrow stuck for 600
    /// ticks. The clients burst its particles (`Arrow.handleEntityEvent`);
    /// the arrow itself is a plain one from now on.
    PotionPuff {,
    id: u32,
    color: u32,
    // rust: },
    Sound {,
    sound: ArrowSound,
    volume: f32,
    pitch: f32,
    // rust: },
    /// `Entity.sendBubbleColumnParticles` at this block: two SPLASH (speed 1)
    /// and two BUBBLE (spread 0, 0.01, 0, speed 0.2) particles at the top,
    /// placed by the level random (drawn by the consumer, nothing else draws
    /// it during an arrow's tick).
    BubbleColumnParticles {,
    pos: BlockPos,
    // rust: },
    /// The block hit reacts (before the arrow sticks).
    Block {,
    pos: BlockPos,
    reaction: BlockReaction,
        /// The arrow's owner (`Projectile.getOwner`), who owns a TNT it primes.
    owner: Option<Who>,
    // rust: },
    /// The SPLASH and PROJECTILE_SHOOT game events.
    SplashEvent,
    ShootEvent,
    /// `spawnAtLocation(pickupItem, 0.1)`: a turned-back arrow too slow to fly
    /// on drops what picking it up gives.
    Drop,
};
pub const ArrowParticle = enum {
    Bubble,
    Crit,
    Splash,
};
pub const ArrowSound = enum {
    /// `entity.generic.splash` (an arrow's splash and high-speed splash).
    Splash,
    /// The arrow's `soundEvent` (`entity.arrow.hit`), for blocks and entities.
    HitGround,
    /// An arrow shot from a crossbow: `item.crossbow.hit`.
    CrossbowHit,
    /// `entity.generic.extinguish_fire`.
    Extinguish,
    /// A thrown trident's `getDefaultHitGroundSoundEvent` (`item.trident.hit_ground`).
    TridentHitGround,
    /// `ThrownTrident.onHitEntity`'s `item.trident.hit`.
    TridentHit,
};
/// What a burning arrow does to the block it hits (`onProjectileHit`).
pub const BlockReaction = enum {
    /// `TntBlock.prime` (primed TNT, its sound and PRIME_FUSE), then
    /// `removeBlock(pos, false)`.
    PrimeTnt,
    /// `setBlock(pos, lit=true, 11)`: campfires and candles.
    Light(BlockStateId),
};
/// The arrow part of `AbstractArrow` and its `Entity` state.
pub const ArrowState = struct {
    in_ground: bool,
    canceled_impact_inside: bool,
    in_ground_time: i32,
    /// Ticks stuck (`life`): gone at 1200.
    life: i32,
    shake: i32,
    /// The block it stuck in (`lastState`).
    last_state: ?BlockStateId,
    pickup: Pickup,
    /// Its entity type is `SpectralArrow` (the type is its own, not the pickup item's).
    spectral: bool,
    /// `pickupItemStack`: what picking the arrow up gives.
    pickup_item: crate::items::ItemStack,
    /// `AbstractArrow.firedFromWeapon`: the crossbow or bow it was shot from.
    fired_from_weapon: ?crate::items::ItemStack,
    no_physics: bool,
    /// `Arrow.ID_EFFECT_COLOR` as a client has it from its server (-1: none).
    effect_color: i32,
    /// `AbstractArrow.getPierceLevel`.
    pierce: u8,
    /// `piercingIgnoreEntityIds`: the entities a piercing arrow has gone
    /// through (cleared when it sticks in a block).
    pierced: std.ArrayList(Who),
    /// `Entity.remainingFireTicks`.
    fire_ticks: i32,
    /// The server's shared fire flag, independent of the client-local fire timer.
    synced_fire: bool,
    fall_distance: f64,
    fluids: EntityFluidInteraction,
    was_touching_water: bool,
    was_eye_in_water: bool,
    first_tick: bool,
    has_been_shot: bool,
    /// `ThrownTrident.dealtDamage`: it has hit an entity (or sat in a block
    /// for over 4 ticks) and hits no more.
    dealt_damage: bool,
    removed: bool,
    /// The arrow's own random (`Entity.random`).
    random: LegacyRandom,
    events: std.ArrayList(ArrowEvent),
    /// The speed (`deltaMovement.length()`) it hit a block at, before it stuck.
    hit_speed: f64,
    /// Spawn position when this fresh arrow joined the level before its first tick.
    spawn_pos: ?Vec3,
    /// Spawn velocity when this fresh arrow joined the level before its first tick.
    spawn_velocity: ?Vec3,
    /// Spawn rotation (pitch, yaw) when this fresh arrow joined the level before its first tick.
    spawn_rot: Option<(f32,
};
    // rust: impl fmt::Debug for ArrowState {
pub fn fmt(self: *Self, f: *mut fmt::Formatter<'_>) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f.debug_struct("ArrowState")
    // rust: .field("in_ground", &self.in_ground)
    // rust: .field("life", &self.life)
    // rust: .field("fire_ticks", &self.fire_ticks)
    // rust: .field("synced_fire", &self.synced_fire)
    // rust: .finish_non_exhaustive()
}
}
    // rust: impl PartialEq for ArrowState {
pub fn eq(self: *Self, other: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.in_ground == other.in_ground
    // rust: && self.life == other.life
    // rust: && self.last_state == other.last_state
    // rust: && self.fire_ticks == other.fire_ticks
    // rust: && self.synced_fire == other.synced_fire
}
}
    // rust: impl ArrowState {
pub fn new(random: LegacyRandom) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: in_ground: false,
    // rust: canceled_impact_inside: false,
    // rust: in_ground_time: 0,
    // rust: life: 0,
    // rust: shake: 0,
    // rust: last_state: None,
    // rust: pickup: Pickup::Disallowed,
    // rust: spectral: false,
    // rust: pickup_item: crate::items::ItemStack::new("minecraft:arrow", 1),
    // rust: fired_from_weapon: None,
    // rust: no_physics: false,
    // rust: effect_color: -1,
    // rust: pierce: 0,
    // rust: pierced: Vec::new(),
    // rust: fire_ticks: 0,
    // rust: synced_fire: false,
    // rust: fall_distance: 0.0,
    // rust: fluids: EntityFluidInteraction::new([WATER, LAVA]),
    // rust: was_touching_water: false,
    // rust: was_eye_in_water: false,
    // rust: first_tick: true,
    // rust: has_been_shot: false,
    // rust: dealt_damage: false,
    // rust: removed: false,
    // rust: random,
    // rust: events: Vec::new(),
    // rust: hit_speed: 0.0,
    // rust: spawn_pos: None,
    // rust: spawn_velocity: None,
    // rust: spawn_rot: None,
}
}
    /// `Arrow.getColor` of the server's own arrow: the colour of the potion on
    /// its pickup item, None for a plain arrow (`PotionContents.EMPTY`).
pub fn potion_color(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let potion = self.pickup_item.potion()?;
    // rust: Some(crate::brewing::potion_color(Some(potion)))
}
    /// The `AbstractArrow` constructor's `pickupItemStack`: the drawn ammo
    /// (one item). Ammo drawn without being used up (`INTANGIBLE_PROJECTILE`)
    /// makes the arrow CREATIVE_ONLY; vanilla takes the component off the
    /// stack it was given, not its copy, so the item keeps it.
pub fn set_item(self: *Self, item: *crate::items::ItemStack) void {
}
    // rust: self.pickup_item = item.clone();
    // rust: if item.data().and_then(|d| d.other(INTANGIBLE)).is_some() {
    // rust: self.pickup = Pickup::CreativeOnly;
}
}
    /// `AbstractArrow.setOwner`: a player's arrows may be picked up.
pub fn set_owner(self: *Self, owner: ?Who) void {
}
    // rust: if owner == Some(Who::Player) && self.pickup == Pickup::Disallowed {
    // rust: self.pickup = Pickup::Allowed;
}
}
    /// `AbstractArrow.playerTouch` and `tryPickup` (`creative`:
    /// `Player.hasInfiniteMaterials`). Like vanilla it does not look at
    /// removal: players only touch arrows still in the world.
pub fn player_touch(self: *Self, creative: bool) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !(self.in_ground || self.no_physics) || self.shake > 0 {
    // rust: return Touch::Ignore;
}
    // rust: match self.pickup {
    // rust: Pickup::Disallowed => Touch::Ignore,
    // rust: Pickup::Allowed => Touch::Give(self.pickup_item.clone()),
    // rust: Pickup::CreativeOnly if creative => Touch::Take,
    // rust: Pickup::CreativeOnly => Touch::Ignore,
}
}
    /// `Entity.isOnFire` (arrows are not fire immune).
pub fn on_fire(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.fire_ticks > 0 || self.synced_fire
}
    /// `Entity.clearFire`.
pub fn clear_fire(self: *Self) void {
}
    // rust: self.fire_ticks = self.fire_ticks.min(0);
}
    /// `Entity.igniteForTicks` (an arrow never freezes).
pub fn ignite_for_ticks(self: *Self, ticks: i32) void {
}
    // rust: if self.fire_ticks < ticks {
    // rust: self.fire_ticks = ticks;
}
}
    /// `Entity.igniteForSeconds`: Flame's `projectile_spawned` ignite.
pub fn ignite_for_seconds(self: *Self, seconds: f32) void {
}
    // rust: self.ignite_for_ticks((seconds * 20.0).floor() as i32);
}
}
/// The blocks, fluids and weather an arrow flies through.
pub const ArrowScene = struct {
    world: *'a World,
    registry: *'a horizon_world::registry::BlockRegistry,
    facts: *'a BlockFacts,
    collision: *'a BlockCollisionRegistry<'r>,
    fluids: *'a FluidResources,
    /// `Level.isRainingAt`.
    raining: *'a dyn Fn(BlockPos) -> bool,
    /// The `mob_griefing` and `tnt_explodes` game rules.
    mob_griefing: bool,
    tnt_explodes: bool,
};
    // rust: impl ArrowScene<'_, '_> {
pub fn block(self: *Self, p: BlockPos) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world.block(p.x, p.y, p.z)
}
pub fn is_air(self: *Self, state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.facts.is_air(state)
}
    /// `BlockState.getCollisionShape(level, pos)` (an empty collision context).
pub fn collision_boxes(self: *Self, state: BlockStateId, p: BlockPos) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut scene = SceneCollisions {
    // rust: world: self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: self.collision
    // rust: .collision_shape(&mut scene, state, [p.x, p.y, p.z])
    // rust: .map(|s| s.boxes().to_vec())
    // rust: .unwrap_or_default()
}
pub fn property(self: *Self, state: BlockStateId, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.registry
    // rust: .state(state)?
    // rust: .properties
    // rust: .get(name)
    // rust: .map(String::as_str)
}
    /// `ClipContext.Block.COLLIDER` with `Fluid.NONE`: the first block hit.
    // rust: fn clip(
    // rust: &self,
    // rust: from: Vec3,
    // rust: to: Vec3,
    // rust: ignored: Option<BlockPos>,
    // rust: ) -> Option<(Vec3, BlockPos, [i32; 3])> {
    // rust: let mut scene = SceneCollisions {
    // rust: world: self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: let hit = horizon_core::geometry::traverse_blocks(from, to, 1024, |p: BlockPos| {
    // rust: if Some(p) == ignored {
    // rust: return None;
}
    // rust: let state = self.block(p);
    // rust: if self.is_air(state) {
    // rust: return None;
}
    // rust: let shape = self
    // rust: .collision
    // rust: .collision_shape(&mut scene, state, [p.x, p.y, p.z])
    // rust: .ok()?;
    // rust: shape.clip(from, to, p)
    // rust: });
    // rust: let hit = hit.ok().flatten()?;
    // rust: Some((hit.location, hit.block, hit.direction.normal()))
}
    /// `CollisionGetter.noCollision(null, box)` over blocks.
pub fn no_block_collision(self: *Self, b: Aabb) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: for x in (lo.x.floor() as i32 - 1)..=(hi.x.floor() as i32 + 1) {
    // rust: for y in (lo.y.floor() as i32 - 1)..=(hi.y.floor() as i32 + 1) {
    // rust: for z in (lo.z.floor() as i32 - 1)..=(hi.z.floor() as i32 + 1) {
    // rust: let p = BlockPos::new(x, y, z);
    // rust: let state = self.block(p);
    // rust: if self.is_air(state) {
    // rust: continue;
}
    // rust: let origin = Vec3::new(f64::from(x), f64::from(y), f64::from(z));
    // rust: if self
    // rust: .collision_boxes(state, p)
    // rust: .iter()
    // rust: .any(|c| c.move_by(origin).intersects(b))
    // rust: {
    // rust: return false;
}
}
}
}
    // rust: true
}
}
/// `AbstractArrow.tick`'s block phase for a thrown trident: the zero-width
/// `level().clip(new ClipContext(position(), position().add(movement),
/// ClipContext.Block.COLLIDER, ClipContext.Fluid.NONE, this))`, then
/// `AbstractArrow.onHitBlock`'s `position().subtract(signum * 0.05)`. Returns
/// the position to stop at (pull-back included), the block that was hit and
/// the normal of the face it was hit on.
    // rust: pub fn clip_block_stop(
    // rust: world: &World,
    // rust: facts: &BlockFacts,
    // rust: collision: &BlockCollisionRegistry<'_>,
    // rust: from: Vec3,
    // rust: movement: Vec3,
    // rust: ) -> Option<(Vec3, BlockPos, [i32; 3])> {
    // rust: let (location, block, normal) = clip_block_hit(world, facts, collision, from, movement)?;
    // rust: Some((back_off(location, movement), block, normal))
}
/// The clip of `clip_block_stop` before the back-off: the hit location (what a
/// `BlockHitResult` carries), the block and the normal of the face.
    // rust: pub fn clip_block_hit(
    // rust: world: &World,
    // rust: facts: &BlockFacts,
    // rust: collision: &BlockCollisionRegistry<'_>,
    // rust: from: Vec3,
    // rust: movement: Vec3,
    // rust: ) -> Option<(Vec3, BlockPos, [i32; 3])> {
    // rust: let to = Vec3::new(
    // rust: from.x + movement.x,
    // rust: from.y + movement.y,
    // rust: from.z + movement.z,
    // rust: );
    // rust: let mut scene = SceneCollisions {
    // rust: world,
    // rust: binding: collision,
    // rust: subject: None,
}
    // rust: let hit = horizon_core::geometry::traverse_blocks(from, to, 1024, |p: BlockPos| {
    // rust: let state = world.block(p.x, p.y, p.z);
    // rust: if facts.is_air(state) {
    // rust: return None;
}
    // rust: let shape = collision
    // rust: .collision_shape(&mut scene, state, [p.x, p.y, p.z])
    // rust: .ok()?;
    // rust: shape.clip(from, to, p)
    // rust: })
    // rust: .ok()
    // rust: .flatten()?;
    // rust: Some((hit.location, hit.block, hit.direction.normal()))
}
/// `AbstractArrow.onHitBlock`'s back-off: vanilla scales `(double) 0.05f` by
/// `Math.signum` per axis, whose value at zero is zero (not Rust's -1.0).
pub fn back_off(location: Vec3, movement: Vec3) V {
    // Implementation ported from Horizon
    return undefined;
}
pub fn signum(v: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if v > 0.0 {
    // rust: 1.0
    // rust: } else if v < 0.0 {
    // rust: -1.0
    // rust: } else {
    // rust: 0.0
}
}
    // rust: let offset = f64::from(0.05f32);
    // rust: Vec3::new(
    // rust: location.x - signum(movement.x) * offset,
    // rust: location.y - signum(movement.y) * offset,
    // rust: location.z - signum(movement.z) * offset,
    // rust: )
}
pub fn bounds(at: Vec3) A {
    // Implementation ported from Horizon
    return undefined;
}
    // EntityDimensions.makeBoundingBox: half the float width.
    // rust: let w = f64::from(WIDTH / 2.0);
    // rust: Aabb::new(
    // rust: Vec3::new(at.x - w, at.y, at.z - w),
    // rust: Vec3::new(at.x + w, at.y + f64::from(HEIGHT), at.z + w),
    // rust: )
}
/// The bounding box of an arrow, or a thrown trident, at `at`.
pub fn arrow_bounds(at: Vec3) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: bounds(at)
}
/// The blocks an arrow that moved from `from` to `to` was inside
/// (`Entity.checkInsideBlocks`: the sweep of its box, 16 steps at most), for
/// the blocks that react to it (`entityInside`).
pub fn blocks_inside(from: Vec3, to: Vec3) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let deflated = bounds(to).deflate(Vec3::new(
    // rust: f64::from(1.0e-5f32),
    // rust: f64::from(1.0e-5f32),
    // rust: f64::from(1.0e-5f32),
    // rust: ));
    // rust: let mut inside = Vec::new();
    // rust: let _ = sweep_intersected_blocks(from, to, deflated, 1_000_000, |p, iteration| {
    // rust: if iteration >= 16 {
    // rust: return false;
}
    // rust: inside.push(p);
    // rust: true
    // rust: });
    // rust: inside
}
/// `Projectile.lerpRotation`.
pub fn lerp_rotation(mut old: f32, new: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: while new - old < -180.0 {
    // rust: old -= 360.0;
}
    // rust: while new - old >= 180.0 {
    // rust: old += 360.0;
}
    // rust: old + 0.2 * (new - old)
}
/// `(float)(Mth.atan2(y, x) * 180.0F / (float)Math.PI)`: compiled as one
/// multiplication by the folded float constant.
pub fn degrees(y: f64, x: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizon_core::geometry::trig::atan2_degrees(y, x)
}
pub fn signum(v: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if v > 0.0 {
    // rust: 1.0
    // rust: } else if v < 0.0 {
    // rust: -1.0
    // rust: } else {
    // rust: v
}
}
/// One arrow tick: whether to keep it and what it hit. An arrow that hit an
/// entity stops there and is not kept: the game hands it to
/// `finish_entity_hit` once it has hurt the entity.
pub fn tick(p: *mut Projectile, scene: *ArrowScene, targets: *[(Who) void {
}
    // rust: tick_with(p, scene, targets, true, false)
}
/// One arrow tick whose hit is canceled (`ProjectileImpactEvent`): the arrow
/// flies through its full movement: not stuck, nothing hurt, no hit.
    // rust: pub fn tick_through(
    // rust: p: &mut Projectile,
    // rust: scene: &ArrowScene,
    // rust: targets: &[(Who, Aabb)],
    // rust: ) -> (bool, Hit) {
    // rust: tick_with(p, scene, targets, false, false)
}
/// Simulate a remote arrow without server-only despawn or block reactions.
/// Entity hits remain authoritative on the server.
pub fn tick_client(p: *mut Projectile, scene: *ArrowScene) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let out = tick_with(p, scene, &[], true, true);
    // `Entity.playSound` passes no player to `Level.playSound`, and
    // `ClientLevel.playSeededSound` plays only for its own player: the server's
    // sound packets carry the hit and splash. The sounds' draws still happened.
    // rust: if let Some(a) = p.arrow.as_mut() {
    // rust: a.events.retain(|e| !matches!(e, ArrowEvent::Sound { .. }));
}
    // rust: out
}
    // rust: fn tick_with(
    // rust: p: &mut Projectile,
    // rust: scene: &ArrowScene,
    // rust: targets: &[(Who, Aabb)],
    // rust: impact: bool,
    // rust: client: bool,
    // rust: ) -> (bool, Hit) {
    // rust: let Some(mut st) = p.arrow.take() else {
    // rust: return (false, Hit::None);
}
    // Entity.setOldPosAndRot: the renderer interpolates from here, in flight
    // and stuck alike; ServerLevel.tickNonPassenger counts the tick.
    // rust: p.set_old_pos_and_rot();
    // rust: p.age += 1;
    // rust: let hit = Ticker {
    // rust: p,
    // rust: st: &mut st,
    // rust: scene,
    // rust: client,
}
    // rust: .tick(targets, impact);
    // rust: p.stuck = st.in_ground;
    // rust: let keep = !st.removed && !matches!(hit, Hit::Entity { .. });
    // rust: p.arrow = Some(st);
    // rust: (keep, hit)
}
/// What became of the entity an arrow hit (`AbstractArrow.onHitEntity`).
pub const EntityHit = enum {
    /// `hurtOrSimulate` succeeded: the arrow is spent, with its hit sound.
    Hurt,
    /// It failed (a raised shield, invulnerability): the arrow turns back.
    Refused,
    /// The entity turned it first (`Entity.deflection`: breezes).
    Deflected,
    /// The target teleported away from it (`EnderMan.hurtServer` returns true,
    /// `onHitEntity` returns before the hit sound and the discard): the arrow
    /// flies on and falls to the ground.
    Dodged,
};
/// `ProjectileDeflection.REVERSE` with power `0.2`: each axis of the movement
/// is multiplied by `-0.2 * 0.5` (`-0.1`), and the yaw turns `170 + nextFloat * 20`
/// degrees. No hit sound. One left almost still (`lengthSqr < 1e-7`) drops its
/// pickup when that is ALLOWED, then is discarded.
pub fn deflect_reverse(velocity: *mut Vec3, yaw: *mut f32, st: *mut ArrowState) void {
}
    // rust: let power = 0.2;
    // rust: let rotation = 170.0 + st.random.next_float() * 20.0;
    // rust: let v = *velocity;
    // rust: let k = -power * 0.5;
    // rust: *velocity = Vec3::new(v.x * k, v.y * k, v.z * k);
    // rust: *yaw += rotation;
    // rust: if velocity.length_squared() < 1.0e-7 {
    // rust: if st.pickup == Pickup::Allowed {
    // rust: st.events.push(ArrowEvent::Drop);
}
    // rust: st.removed = true;
}
}
/// The rest of the tick of an arrow that hit an entity: whether to keep it.
pub fn finish_entity_hit(p: *mut Projectile, scene: *ArrowScene, outcome: EntityHit) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(mut st) = p.arrow.take() else {
    // rust: return false;
}
    // rust: let trident = matches!(p.kind, ProjectileKind::Trident);
    // rust: let mut ticker = Ticker {
    // rust: p,
    // rust: st: &mut st,
    // rust: scene,
    // rust: client: false,
}
    // rust: match outcome {
    // rust: EntityHit::Hurt | EntityHit::Refused if trident => ticker.trident_bounce(),
    // rust: EntityHit::Hurt => {
    // rust: ticker.hit_sound();
            // A piercing arrow flies on (`getPierceLevel() <= 0` discards).
    // rust: if ticker.st.pierce == 0 {
    // rust: ticker.st.removed = true;
}
}
    // rust: EntityHit::Refused => ticker.turn_back(),
    // rust: EntityHit::Dodged => {}
    // rust: EntityHit::Deflected => {
            // The deflection comes before `onHitEntity` adds the entity to
            // `piercingIgnoreEntityIds`.
    // rust: if ticker.st.pierce > 0 {
    // rust: ticker.st.pierced.pop();
}
}
}
    // rust: ticker.finish();
    // rust: p.stuck = st.in_ground;
    // rust: let keep = !st.removed;
    // rust: p.arrow = Some(st);
    // rust: keep
}
pub const Ticker = struct {
    p: *'p mut Projectile,
    st: *'s mut ArrowState,
    scene: *'s ArrowScene<'a,
    client: bool,
};
    // rust: impl Ticker<'_, '_, '_, '_> {
pub fn position(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.p.position
}
pub fn block_position(self: *Self) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: BlockPos::containing(self.p.position)
}
    /// `Entity.isInRain`: at the block position or the top of the box.
pub fn in_rain(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.scene.in_rain(self.p.position)
}
    /// Whether this is a `ThrownTrident` (`AbstractArrow` with its own water
    /// inertia, sounds and hit).
pub fn trident(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(self.p.kind, ProjectileKind::Trident)
}
pub fn tick(self: *Self, targets: *[(Who) void {
}
        // ThrownTrident.tick.
    // rust: if self.trident() && self.st.in_ground_time > 4 {
    // rust: self.st.dealt_damage = true;
}
    // rust: let physics = !self.st.no_physics;
    // rust: let movement = self.p.velocity;
    // rust: let block_pos = self.block_position();
    // rust: let state = self.scene.block(block_pos);
    // rust: if !self.scene.is_air(state) && physics {
    // rust: let origin = Vec3::new(
    // rust: f64::from(block_pos.x),
    // rust: f64::from(block_pos.y),
    // rust: f64::from(block_pos.z),
    // rust: );
    // rust: let at = self.position();
    // rust: let inside = self
    // rust: .scene
    // rust: .collision_boxes(state, block_pos)
    // rust: .iter()
    // rust: .any(|b| b.move_by(origin).contains(at));
    // rust: if inside && !self.st.canceled_impact_inside {
    // rust: self.p.velocity = Vec3::ZERO;
    // rust: self.st.in_ground = true;
}
    // rust: self.st.canceled_impact_inside &= inside;
    // rust: } else {
    // rust: self.st.canceled_impact_inside = false;
}
    // rust: if self.st.shake > 0 {
    // rust: self.st.shake -= 1;
}
    // rust: if self.st.was_touching_water || self.in_rain() {
    // rust: self.st.clear_fire();
}
    // rust: if self.st.in_ground && physics {
    // rust: if !self.client {
    // rust: if self.st.last_state != Some(state) && self.should_fall() {
    // rust: self.start_falling();
    // rust: } else {
                    // AbstractArrow.tickDespawn.
    // rust: self.st.life += 1;
    // rust: if self.st.life >= 1200 {
    // rust: self.st.removed = true;
}
}
}
    // rust: self.st.in_ground_time += 1;
    // rust: if !self.st.removed {
    // rust: let at = self.position();
    // rust: self.apply_effects_from_blocks(at, at);
}
            // Arrow.tick on the server: a tipped arrow stuck for 600 ticks sends
            // entity event 0 (the clients' burst of particles in its colour,
            // `handleEntityEvent`) and turns into a plain arrow. The flight
            // and ground particles are the clients' own (`Level.isClientSide`).
    // rust: if !self.client
    // rust: && self.st.in_ground_time >= 600
    // rust: && let Some(color) = self.st.potion_color()
    // rust: {
    // rust: self.st.events.push(ArrowEvent::PotionPuff {
    // rust: id: self.p.id,
    // rust: color,
    // rust: });
    // rust: self.st.pickup_item = crate::items::ItemStack::new("minecraft:arrow", 1);
}
    // rust: return Hit::None;
}
    // rust: self.st.in_ground_time = 0;
    // rust: let original = self.position();
    // rust: if self.st.was_touching_water {
            // getWaterInertia (0.99 for a trident), then the bubbles behind it.
    // rust: let inertia = if self.trident() { 0.99f32 } else { 0.6f32 };
    // rust: self.p.velocity = self.p.velocity.scale(f64::from(inertia));
    // rust: let v = self.p.velocity;
    // rust: for _ in 0..4 {
    // rust: self.st.events.push(ArrowEvent::Particle {
    // rust: kind: ArrowParticle::Bubble,
    // rust: position: Vec3::new(
    // rust: original.x - v.x * 0.25,
    // rust: original.y - v.y * 0.25,
    // rust: original.z - v.z * 0.25,
    // rust: ),
    // rust: velocity: v,
    // rust: });
}
}
    // rust: if self.p.critical() {
    // rust: for i in 0..4 {
    // rust: let f = f64::from(i) / 4.0;
    // rust: self.st.events.push(ArrowEvent::Particle {
    // rust: kind: ArrowParticle::Crit,
    // rust: position: Vec3::new(
    // rust: original.x + movement.x * f,
    // rust: original.y + movement.y * f,
    // rust: original.z + movement.z * f,
    // rust: ),
    // rust: velocity: Vec3::new(-movement.x, -movement.y + 0.2, -movement.z),
    // rust: });
}
}
    // rust: let y_rot = if physics {
    // rust: degrees(movement.x, movement.z)
    // rust: } else {
    // rust: degrees(-movement.x, -movement.z)
}
    // rust: let x_rot = degrees(movement.y, movement.horizontal_distance());
    // rust: self.p.pitch = lerp_rotation(self.p.pitch, x_rot);
    // rust: self.p.yaw = lerp_rotation(self.p.yaw, y_rot);
    // rust: self.check_left_owner(targets);
    // rust: let mut hit = Hit::None;
    // rust: let end = Vec3::new(
    // rust: original.x + movement.x,
    // rust: original.y + movement.y,
    // rust: original.z + movement.z,
    // rust: );
    // rust: if physics && impact {
    // rust: hit = self.step_move_and_hit(original, end, targets, impact);
    // rust: if matches!(hit, Hit::Entity { .. }) {
    // rust: return hit;
}
    // rust: } else {
    // rust: self.p.position = end;
    // rust: self.apply_effects_from_blocks(original, end);
    // rust: if physics {
    // rust: self.st.canceled_impact_inside = true;
}
}
    // rust: self.finish();
    // rust: hit
}
    /// The end of a tick in flight: drag and gravity, then `Projectile.tick`
    /// and `Entity.baseTick`'s fluid and fire phases.
pub fn finish(self: *Self) void {
}
    // rust: let physics = !self.st.no_physics;
    // rust: if !self.st.was_touching_water {
    // rust: self.p.velocity = self.p.velocity.scale(f64::from(0.99f32));
}
    // rust: if physics && !self.st.in_ground {
            // Entity.applyGravity: AbstractArrow.getDefaultGravity, none with NoGravity.
    // rust: self.add_velocity(-self.p.get_gravity());
}
        // Projectile.tick, then Entity.baseTick's fluid and fire phases.
    // rust: if !self.st.has_been_shot {
    // rust: if !self.client {
    // rust: self.st.events.push(ArrowEvent::ShootEvent);
}
    // rust: self.st.has_been_shot = true;
}
    // rust: self.st.was_eye_in_water = self.st.fluids.is_eye_in_fluid(&Tags, WATER);
    // rust: let mut fluids = std::mem::take(&mut self.st.fluids);
    // rust: let _ = entity_fluid_tick::update(&mut fluids, self, WATER, LAVA, 1_000_000);
    // rust: self.st.fluids = fluids;
    // rust: if self.client {
    // rust: self.st.clear_fire();
    // rust: } else if self.st.fire_ticks > 0 {
    // rust: self.st.fire_ticks -= 1;
}
    // rust: if !self.st.first_tick && self.st.fluids.is_in_fluid(&Tags, LAVA) {
    // rust: self.st.fall_distance *= 0.5;
}
    // rust: if self.position().y < f64::from(self.scene.world.bottom_y() - 64) {
    // rust: self.st.removed = true;
}
    // rust: self.st.first_tick = false;
}
    /// `getDeltaMovement().add(0, y, 0)`: the zeros added to x and z also
    /// turn a negative zero positive.
pub fn add_velocity(self: *Self, y: f64) void {
}
    // rust: let v = self.p.velocity;
    // rust: self.p.velocity = Vec3::new(v.x + 0.0, v.y + y, v.z + 0.0);
}
    /// `Projectile.checkLeftOwner`: out of the owner's box once the arrow's
    /// box, swept by its motion and grown by 1, no longer touches it.
pub fn check_left_owner(self: *Self, targets: *[(Who) void {
}
    // rust: if self.p.left_owner {
    // rust: return;
}
    // rust: let owner = targets
    // rust: .iter()
    // rust: .find(|(who, _)| Some(*who) == self.p.owner)
    // rust: .map(|(_, b)| *b);
    // rust: let swept = bounds(self.p.position)
    // rust: .expand_towards(self.p.velocity)
    // rust: .inflate(Vec3::new(1.0, 1.0, 1.0));
    // rust: self.p.left_owner = owner.is_none_or(|b| !swept.intersects(b));
}
    /// `AbstractArrow.shouldFall`.
pub fn should_fall(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let at = self.position();
    // rust: self.st.in_ground
    // rust: && self
    // rust: .scene
    // rust: .no_block_collision(Aabb::new(at, at).inflate(Vec3::new(0.06, 0.06, 0.06)))
}
    /// `AbstractArrow.startFalling`.
pub fn start_falling(self: *Self) void {
}
    // rust: self.st.in_ground = false;
    // rust: let v = self.p.velocity;
    // rust: let x = f64::from(self.st.random.next_float() * 0.2);
    // rust: let y = f64::from(self.st.random.next_float() * 0.2);
    // rust: let z = f64::from(self.st.random.next_float() * 0.2);
    // rust: self.p.velocity = Vec3::new(v.x * x, v.y * y, v.z * z);
    // rust: self.st.life = 0;
}
    /// `AbstractArrow.stepMoveAndHit`: the nearest entity on the way, else the
    /// block. A piercing arrow that hits an entity here goes on from it next
    /// tick (`finish_entity_hit`); vanilla's loop goes on within the same tick.
    // rust: fn step_move_and_hit(
    // rust: &mut self,
    // rust: from: Vec3,
    // rust: to: Vec3,
    // rust: targets: &[(Who, Aabb)],
    // rust: impact: bool,
    // rust: ) -> Hit {
    // rust: let ignored = self
    // rust: .st
    // rust: .canceled_impact_inside
    // rust: .then(|| self.block_position());
    // rust: let block = self.scene.clip(from, to, ignored);
    // rust: let end = block.map_or(to, |b| b.0);
        // findHitEntities: ProjectileUtil.computeMargin and the search box.
    // rust: let margin = f64::from(((self.p.age as i32 - 2) as f32 / 20.0).clamp(0.0, 0.3));
    // rust: let area = bounds(from)
    // rust: .expand_towards(self.p.velocity)
    // rust: .inflate(Vec3::new(1.0, 1.0, 1.0));
    // rust: let mut best: Option<(Who, Vec3, f64)> = None;
        // ThrownTrident.findHitEntity: none once it has dealt damage.
    // rust: let targets = if self.st.dealt_damage { &[] } else { targets };
    // rust: for (who, b) in targets {
    // rust: if Some(*who) == self.p.owner && !self.p.left_owner || !b.intersects(area) {
    // rust: continue;
}
            // canHitEntity: not an entity a piercing arrow has gone through.
    // rust: if self.st.pierced.contains(who) {
    // rust: continue;
}
    // rust: if let Some(at) = self.entity_hit(b, from, end, margin) {
                // Sorted by the distance to the entity's position (the
                // stable sort keeps the first of equals).
    // rust: let c = b.center();
    // rust: let d = from.distance_squared(Vec3::new(c.x, b.min_position().y, c.z));
    // rust: if best.is_none_or(|bb| d < bb.2) {
    // rust: best = Some((*who, at, d));
}
}
}
    // rust: let next = best.map_or(end, |b| b.1);
    // rust: self.p.position = next;
    // rust: self.apply_effects_from_blocks(from, next);
    // rust: if let Some((who, at, _)) = best {
            // A canceled impact ends the search, the arrow where it would have hit.
    // rust: if !impact {
    // rust: return Hit::None;
}
            // AbstractArrow.onHitEntity: past pierce level + 1 entities the
            // arrow is discarded before it hurts the next one.
    // rust: if self.st.pierce > 0 {
    // rust: if self.st.pierced.len() > usize::from(self.st.pierce) {
    // rust: self.st.removed = true;
    // rust: return Hit::None;
}
    // rust: self.st.pierced.push(who);
}
    // rust: return Hit::Entity { who, at };
}
    // rust: let Some((at, pos, face)) = block else {
    // rust: return Hit::None;
}
    // rust: if self.st.removed {
    // rust: return Hit::None;
}
    // rust: let state = self.scene.block(pos);
    // rust: if self.scene.is_air(state) {
    // rust: return Hit::None;
}
    // rust: if !impact {
    // rust: return Hit::None;
}
    // rust: self.on_hit_block(pos, state);
    // rust: Hit::Block {
    // rust: pos: [pos.x, pos.y, pos.z],
    // rust: at,
    // rust: face,
}
}
    /// `ProjectileUtil.getManyEntityHitResult` for one entity box: where the
    /// path enters it, else where it enters the box grown by `margin`, if a
    /// line from there towards the centre (stopped by blocks) reaches the box.
pub fn entity_hit(self: *Self, b: *Aabb, from: Vec3, to: Vec3, margin: f64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(at) = b.clip(from, to) {
    // rust: return Some(at);
}
    // rust: if margin <= 0.0 {
    // rust: return None;
}
    // rust: let outside = b
    // rust: .inflate(Vec3::new(margin, margin, margin))
    // rust: .clip(from, to)?;
    // rust: let centre = b.center();
    // rust: let towards = self
    // rust: .scene
    // rust: .clip(outside, centre, None)
    // rust: .map_or(centre, |h| h.0);
    // rust: b.clip(outside, towards).map(|_| outside)
}
    /// `playSound(soundEvent, 1, 1.2 / (random * 0.2 + 0.9))`.
pub fn hit_sound(self: *Self) void {
}
    // rust: let pitch = 1.2 / (self.st.random.next_float() * 0.2 + 0.9);
        // CrossbowItem.createProjectile: its arrows hit with the crossbow's sound.
    // rust: let crossbow = self
    // rust: .st
    // rust: .fired_from_weapon
    // rust: .as_ref()
    // rust: .is_some_and(|s| &*s.item == "minecraft:crossbow");
    // rust: let sound = if self.trident() {
    // rust: ArrowSound::TridentHitGround
    // rust: } else if crossbow {
    // rust: ArrowSound::CrossbowHit
    // rust: } else {
    // rust: ArrowSound::HitGround
}
    // rust: self.st.events.push(ArrowEvent::Sound {
    // rust: sound,
    // rust: volume: 1.0,
    // rust: pitch,
    // rust: });
}
    /// `ThrownTrident.onHitEntity` after the hurt, whether it landed or not:
    /// the hit sound, then `deflect(REVERSE, ..., (0.02, 0.2, 0.02))`. The
    /// trident keeps flying (it has dealt its damage) and falls.
pub fn trident_bounce(self: *Self) void {
}
    // rust: self.st.dealt_damage = true;
    // rust: self.st.events.push(ArrowEvent::Sound {
    // rust: sound: ArrowSound::TridentHit,
    // rust: volume: 1.0,
    // rust: pitch: 1.0,
    // rust: });
        // ProjectileDeflection.REVERSE.
    // rust: let rotation = 170.0 + self.st.random.next_float() * 20.0;
    // rust: let v = self.p.velocity;
    // rust: self.p.velocity = Vec3::new(v.x * (-0.02 * 0.5), v.y * (-0.2 * 0.5), v.z * (-0.02 * 0.5));
    // rust: self.p.yaw += rotation;
}
    /// `onHitEntity` when the entity took no damage: `deflect(REVERSE, 0.2)`,
    /// a half turn give or take ten degrees at a tenth of the speed; one
    /// left almost still drops its pickup (ALLOWED) and is discarded.
pub fn turn_back(self: *Self) void {
}
    // rust: deflect_reverse(&mut self.p.velocity, &mut self.p.yaw, self.st);
}
    /// `AbstractArrow.onHitBlock`: back off the face by 0.05 along each axis
    /// it moved on, stop, and stick.
pub fn on_hit_block(self: *Self, pos: BlockPos, state: BlockStateId) void {
}
    // rust: self.st.last_state = Some(state);
        // BlockState.onProjectileHit still sees the deltaMovement it hit at.
    // rust: self.st.hit_speed = self.p.velocity.length();
        // Projectile.onHitBlock: BlockState.onProjectileHit.
    // rust: if !self.client
    // rust: && self.st.on_fire()
    // rust: && let Some(reaction) = self.block_reaction(state)
    // rust: {
    // rust: self.st.events.push(ArrowEvent::Block {
    // rust: pos,
    // rust: reaction,
    // rust: owner: self.p.owner,
    // rust: });
}
    // rust: let v = self.p.velocity;
    // rust: let offset = f64::from(0.05f32);
    // rust: self.p.position = Vec3::new(
    // rust: self.p.position.x - signum(v.x) * offset,
    // rust: self.p.position.y - signum(v.y) * offset,
    // rust: self.p.position.z - signum(v.z) * offset,
    // rust: );
    // rust: self.p.velocity = Vec3::ZERO;
    // rust: self.hit_sound();
    // rust: self.st.in_ground = true;
    // rust: self.st.shake = 7;
    // rust: self.p.set_critical(false);
    // rust: self.st.pierce = 0;
    // rust: self.st.pierced.clear();
}
    /// `Projectile.mayInteract`: a mob's arrows need `mob_griefing`.
pub fn may_interact(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !matches!(self.p.owner, Some(Who::Mob(_))) || self.scene.mob_griefing
}
    /// `onProjectileHit` of the blocks a burning projectile lights.
pub fn block_reaction(self: *Self, state: BlockStateId) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = self.scene.registry.state(state)?.name.as_str();
    // rust: let flag = |key: &str| self.scene.property(state, key) == Some("true");
    // rust: let lit = || {
    // rust: let mut definition = self.scene.registry.state(state)?.clone();
    // rust: definition.properties.insert("lit".into(), "true".into());
    // rust: self.scene.registry.id(&definition)
}
    // rust: match name {
    // rust: "minecraft:tnt" if self.may_interact() && self.scene.tnt_explodes => {
    // rust: Some(BlockReaction::PrimeTnt)
}
    // rust: "minecraft:campfire" | "minecraft:soul_campfire"
    // rust: if self.may_interact() && !flag("lit") && !flag("waterlogged") =>
    // rust: {
    // rust: lit().map(BlockReaction::Light)
}
            // AbstractCandleBlock: candles also must be dry (CandleBlock.canBeLit).
    // rust: _ if name.ends_with("candle_cake") && !flag("lit") => lit().map(BlockReaction::Light),
    // rust: _ if name.ends_with("candle") && !flag("lit") && !flag("waterlogged") => {
    // rust: lit().map(BlockReaction::Light)
}
    // rust: _ => None,
}
}
    /// `Entity.applyEffectsFromBlocks`: the shared sweep keeps the arrow's
    /// contact hooks and bubble-column pushes before applying the fire effects.
pub fn apply_effects_from_blocks(self: *Self, from: Vec3, to: Vec3) void {
}
    // rust: if self.st.removed || self.st.no_physics {
    // rust: return;
}
    // rust: let scene = self.scene;
    // rust: let (fire_ticks, extinguished) =
    // rust: scene.apply_block_effects(from, to, self.st.fire_ticks, |state, p, precise| {
    // rust: let name = &*scene.facts.get(state).name;
    // rust: crate::block_contact::emit(crate::block_contact::Event::Inside(
    // rust: crate::block_contact::Contact {
    // rust: entity: self.p.id as i32,
    // rust: kind: self.p.kind.id(),
    // rust: block: name,
    // rust: state,
    // rust: position: p,
    // rust: },
    // rust: ));
    // rust: if name == "minecraft:bubble_column" && precise {
    // rust: self.bubble_column(state, p);
}
    // rust: });
    // rust: self.st.fire_ticks = fire_ticks;
    // rust: if extinguished {
            // Entity.playEntityOnFireExtinguishedSound: keep the entity RNG order.
    // rust: let pitch = 1.6 + (self.st.random.next_float() - self.st.random.next_float()) * 0.4;
    // rust: self.st.events.push(ArrowEvent::Sound {
    // rust: sound: ArrowSound::Extinguish,
    // rust: volume: 0.7,
    // rust: pitch,
    // rust: });
}
}
    /// `BubbleColumnBlock.entityInside` with `Projectile`'s pushes.
pub fn bubble_column(self: *Self, state: BlockStateId, p: BlockPos) void {
}
    // rust: let drag = self.scene.property(state, "drag") == Some("true");
    // rust: let above = self.scene.block(BlockPos::new(p.x, p.y + 1, p.z));
        // The state above's collision shape, queried at this position.
    // rust: let nothing_above = self.scene.collision_boxes(above, p).is_empty()
    // rust: && self.scene.fluids.fluid(above).kind() == FluidKind::Empty;
    // rust: if self.st.in_ground {
    // rust: return;
}
    // rust: if nothing_above {
    // rust: self.add_velocity(if drag { -0.03 } else { 0.1 });
    // rust: self.st
    // rust: .events
    // rust: .push(ArrowEvent::BubbleColumnParticles { pos: p });
    // rust: } else {
    // rust: self.add_velocity(if drag { -0.03 } else { 0.06 });
    // rust: self.st.fall_distance = 0.0;
}
}
}
    // rust: impl ArrowScene<'_, '_> {
    /// `Entity.isInRain`: at the feet or the top of the arrow-sized box.
pub fn in_rain(self: *Self, at: Vec3) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let p = BlockPos::containing(at);
    // rust: (self.raining)(p)
    // rust: || (self.raining)(BlockPos::new(
    // rust: p.x,
    // rust: bounds(at).max_position().y.floor() as i32,
    // rust: p.z,
    // rust: ))
}
    /// The water membership used by `AbstractArrow.tick` on the next tick.
    /// Only query the fluid; callers keep their own movement and splash logic.
pub fn in_water(self: *Self, at: Vec3) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = bounds(at).deflate(Vec3::new(0.001, 0.001, 0.001));
    // rust: let lo = b.min_position();
    // rust: let hi = b.max_position();
    // rust: let low = BlockPos::containing(lo);
    // rust: let high = BlockPos::new(
    // rust: hi.x.ceil() as i32 - 1,
    // rust: hi.y.ceil() as i32 - 1,
    // rust: hi.z.ceil() as i32 - 1,
    // rust: );
    // rust: for x in (low.x - 1) >> 4..=(high.x + 1) >> 4 {
    // rust: for z in (low.z - 1) >> 4..=(high.z + 1) >> 4 {
    // rust: if !self.world.chunks.contains_key(&(x, z)) {
    // rust: return false;
}
}
}
    // rust: for x in low.x..=high.x {
    // rust: for y in low.y..=high.y {
    // rust: for z in low.z..=high.z {
    // rust: let fluid = self.fluids.fluid(self.block(BlockPos::new(x, y, z)));
    // rust: let mut scene = self;
    // rust: if matches!(fluid.kind(), FluidKind::Water | FluidKind::FlowingWater)
    // rust: && let Ok(height) = fluid.height_at(&mut scene, [x, y, z])
    // rust: && f64::from(y) + f64::from(height) >= lo.y
    // rust: && f64::from(y) + f64::from(height) > at.y
    // rust: {
    // rust: return true;
}
}
}
}
    // rust: false
}
    /// `Entity.applyEffectsFromBlocks` for arrows and player-thrown tridents.
    /// The caller handles `isAffectedByBlocks`, initial water/rain clearing and
    /// `baseTick`. `visit` preserves arrow contact hooks and bubble pushes.
    /// Returns the fire timer and whether to play the extinguishing sound.
    // rust: pub fn apply_block_effects(
    // rust: &self,
    // rust: from: Vec3,
    // rust: to: Vec3,
    // rust: mut fire_ticks: i32,
    // rust: mut visit: impl FnMut(BlockStateId, BlockPos, bool),
    // rust: ) -> (i32, bool) {
    // rust: let previous_fire = fire_ticks;
    // rust: let mut visited = HashSet::new();
    // rust: let mut effects = Collector::default();
    // rust: let used = self.check_inside_blocks(from, to, &mut visited, &mut effects, 16, &mut visit);
    // rust: if 16 - used <= 0 {
    // rust: self.check_inside_blocks(to, to, &mut visited, &mut effects, 1, &mut visit);
}
    // rust: for effect in effects.finish() {
    // rust: match effect {
    // rust: Effect::ClearFreeze => {}
    // rust: Effect::FireIgnite => {
                    // BaseFireBlock.fireIgnite for a non-player entity.
    // rust: if fire_ticks < 0 {
    // rust: fire_ticks += 1;
}
    // rust: if fire_ticks >= 0 {
    // rust: fire_ticks = fire_ticks.max(160);
}
}
    // rust: Effect::LavaIgnite => fire_ticks = fire_ticks.max(300),
    // rust: Effect::Extinguish => fire_ticks = fire_ticks.min(0),
}
}
    // rust: if self.in_rain(to) {
    // rust: fire_ticks = fire_ticks.min(0);
}
    // rust: let extinguished = previous_fire > 0 && fire_ticks <= 0;
    // rust: let ignited = fire_ticks > previous_fire;
    // rust: if fire_ticks <= 0 && !ignited {
            // -getFireImmuneTicks(): zero for AbstractArrow.
    // rust: fire_ticks = 0;
}
    // rust: (fire_ticks, extinguished)
}
    /// `Entity.checkInsideBlocks(from, to, ...)`: returns the iterations used.
    // rust: fn check_inside_blocks(
    // rust: &self,
    // rust: from: Vec3,
    // rust: to: Vec3,
    // rust: visited: &mut HashSet<BlockPos>,
    // rust: effects: &mut Collector,
    // rust: max_iterations: i32,
    // rust: visit: &mut impl FnMut(BlockStateId, BlockPos, bool),
    // rust: ) -> i32 {
    // rust: let deflated = bounds(to).deflate(Vec3::new(
    // rust: f64::from(1.0e-5f32),
    // rust: f64::from(1.0e-5f32),
    // rust: f64::from(1.0e-5f32),
    // rust: ));
    // rust: let far = from.distance_squared(to) > 0.999_990_000_000_252_6f64 * 0.999_990_000_000_252_6;
    // rust: let mut hits = Vec::new();
    // rust: let mut iterations = 0;
    // rust: let _ = sweep_intersected_blocks(from, to, deflated, 1_000_000, |p, iteration| {
    // rust: if iteration >= max_iterations {
    // rust: return false;
}
    // rust: iterations = iteration;
    // rust: hits.push((p, iteration));
    // rust: true
    // rust: });
    // rust: for (p, step) in hits {
    // rust: let state = self.block(p);
    // rust: if self.is_air(state) {
    // rust: continue;
}
            // getEntityInsideCollisionShape: the whole block for these.
    // rust: let inside_block = true;
    // rust: let fluid = self.fluids.fluid(state);
    // rust: let inside_fluid = self.collided_with_fluid(fluid, p, from, to);
    // rust: if !(inside_block || inside_fluid) || !visited.insert(p) {
    // rust: continue;
}
    // rust: effects.advance(step);
    // rust: let name = &*self.facts.get(state).name;
    // rust: let precise = far
    // rust: || deflated.intersects(Aabb::new(
    // rust: Vec3::new(f64::from(p.x), f64::from(p.y), f64::from(p.z)),
    // rust: Vec3::new(f64::from(p.x + 1), f64::from(p.y + 1), f64::from(p.z + 1)),
    // rust: ));
    // rust: visit(state, p, precise);
    // rust: if matches!(name, "minecraft:fire" | "minecraft:soul_fire") {
                // BaseFireBlock.entityInside (its inFire hurt does nothing to arrows).
    // rust: effects.apply(Effect::ClearFreeze);
    // rust: effects.apply(Effect::FireIgnite);
}
    // rust: if inside_fluid {
    // rust: effects.advance(step);
    // rust: match fluid.kind() {
                    // WaterFluid.entityInside.
    // rust: FluidKind::Water | FluidKind::FlowingWater => effects.apply(Effect::Extinguish),
                    // LavaFluid.entityInside (lavaHurt does nothing to arrows).
    // rust: FluidKind::Lava | FluidKind::FlowingLava => {
    // rust: effects.apply(Effect::ClearFreeze);
    // rust: effects.apply(Effect::LavaIgnite);
}
    // rust: FluidKind::Empty => {}
}
}
}
    // rust: iterations + 1
}
    /// `Entity.collidedWithFluid`: the fluid's box swept from `from` to `to`.
pub fn collided_with_fluid(self: *Self, fluid: FluidState, p: BlockPos, from: Vec3, to: Vec3) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if fluid.kind() == FluidKind::Empty {
    // rust: return false;
}
    // rust: let mut scene = self;
    // rust: let Ok(height) = fluid.height_at(&mut scene, [p.x, p.y, p.z]) else {
    // rust: return false;
}
    // rust: let b = Aabb::new(
    // rust: Vec3::new(f64::from(p.x), f64::from(p.y), f64::from(p.z)),
    // rust: Vec3::new(
    // rust: f64::from(p.x) + 1.0,
    // rust: f64::from(p.y) + f64::from(height),
    // rust: f64::from(p.z) + 1.0,
    // rust: ),
    // rust: );
    // rust: bounds(from).collided_along_vector(to.subtract(from), &[b])
}
}
    // rust: impl FluidHeightWorld for &ArrowScene<'_, '_> {
    // rust: type Error = Error;
pub fn fluid(self: *Self, p: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self
    // rust: .fluids
    // rust: .fluid(self.block(BlockPos::new(p[0], p[1], p[2]))))
}
pub fn sturdy_down(self: *Self, p: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let state = self.block(BlockPos::new(p[0], p[1], p[2]));
    // rust: Ok(self.fluids.sturdy(state, Direction::Down))
}
}
/// `InsideBlockEffectType`s an arrow meets, in their apply order (FREEZE
/// needs powder snow, which an arrow's collision context passes through).
pub const Effect = enum {
    ClearFreeze,
    FireIgnite,
    LavaIgnite,
    Extinguish,
};
    // rust: const EFFECT_ORDER: [Effect; 4] = [
    // rust: Effect::ClearFreeze,
    // rust: Effect::FireIgnite,
    // rust: Effect::LavaIgnite,
    // rust: Effect::Extinguish,
    // rust: ];
/// `InsideBlockEffectApplier.StepBasedCollector`: each step's effects once,
/// in type order, steps in the order they were reached.
pub const Collector = struct {
    last_step: i32,
    step: [bool,
    effects: std.ArrayList(Effect),
};
    // rust: impl Default for Collector {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: last_step: -1,
    // rust: step: [false; 4],
    // rust: effects: Vec::new(),
}
}
}
    // rust: impl Collector {
pub fn advance(self: *Self, step: i32) void {
}
    // rust: if self.last_step != step {
    // rust: self.last_step = step;
    // rust: self.flush();
}
}
pub fn apply(self: *Self, effect: Effect) void {
}
    // rust: self.step[effect as usize] = true;
}
pub fn flush(self: *Self) void {
}
    // rust: for effect in EFFECT_ORDER {
    // rust: if std::mem::take(&mut self.step[effect as usize]) {
    // rust: self.effects.push(effect);
}
}
}
pub fn finish() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.flush();
    // rust: self.effects
}
}
pub const Tags = struct {};
    // rust: impl FluidMembership for Tags {
pub fn fluid_in_tag(self: *Self, kind: FluidKind, tag: FluidTagId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if tag == WATER {
    // rust: matches!(kind, FluidKind::Water | FluidKind::FlowingWater)
    // rust: } else {
    // rust: matches!(kind, FluidKind::Lava | FluidKind::FlowingLava)
}
}
}
    // rust: type Error = Box<dyn std::error::Error>;
    // rust: impl FluidMembership for Ticker<'_, '_, '_, '_> {
pub fn fluid_in_tag(self: *Self, kind: FluidKind, tag: FluidTagId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Tags.fluid_in_tag(kind, tag)
}
}
    // rust: impl CurrentTarget for Ticker<'_, '_, '_, '_> {
    // rust: type Error = Error;
pub fn is_player_class(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: false
}
pub fn velocity(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.p.velocity)
}
pub fn add_delta_movement(self: *Self, delta: Vec3) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let v = self.p.velocity;
    // rust: let sum = Vec3::new(v.x + delta.x, v.y + delta.y, v.z + delta.z);
    // rust: if delta.is_finite() && sum.is_finite() {
    // rust: self.p.velocity = sum;
}
    // rust: Ok(())
}
}
    // rust: impl FluidInteractionWorld for Ticker<'_, '_, '_, '_> {
    // rust: type Error = Error;
    // rust: type Chunk = ();
pub fn interaction_box(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(Some(
    // rust: bounds(self.p.position).deflate(Vec3::new(0.001, 0.001, 0.001)),
    // rust: ))
}
pub fn loaded_chunk(self: *Self, x: i32, z: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.scene.world.chunks.contains_key(&(x, z)).then_some(()))
}
pub fn chunk_sections(self: *Self, _: () void {
}
    // rust: let layout = self.scene.world.layout();
    // rust: Ok(FluidSections {
    // rust: minimum_section_y: layout.min_y() >> 4,
    // rust: has_fluid: crate::chunk::every_section(layout),
    // rust: })
}
pub fn bounding_box_min_y(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.p.position.y
}
pub fn block_x(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.p.position.x.floor() as i32
}
pub fn eye_y(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.p.position.y + f64::from(EYE_HEIGHT))
}
pub fn block_z(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.p.position.z.floor() as i32
}
pub fn fluid_state(self: *Self, p: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.scene.fluids.fluid(self.scene.block(p)))
}
pub fn fluid_height(self: *Self, f: FluidState, p: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f.height_at(self, [p.x, p.y, p.z])
}
pub fn camera_height(self: *Self, f: FluidState, p: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f.camera_height_at(self, [p.x, p.y, p.z])
}
pub fn flow(self: *Self, f: FluidState, p: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: flow_at(self, f, p)
}
}
    // rust: impl EntityFluidTickWorld for Ticker<'_, '_, '_, '_> {
    /// `AbstractArrow.isPushedByFluid`: not when stuck.
pub fn is_pushed_by_fluid(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(!self.st.in_ground)
}
pub fn reset_fall_distance(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.st.fall_distance = 0.0;
    // rust: Ok(())
}
pub fn was_touching_water(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.st.was_touching_water
}
pub fn first_tick(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.st.first_tick
}
pub fn water_splash(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: water_splash::water_splash(self, 1_000_000).map_err(|e| e.to_string())?;
    // rust: Ok(())
}
pub fn set_was_touching_water(self: *Self, value: bool) void {
}
    // rust: self.st.was_touching_water = value;
}
pub fn fast_lava(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
}
    // rust: impl FluidHeightWorld for Ticker<'_, '_, '_, '_> {
    // rust: type Error = Error;
pub fn fluid(self: *Self, p: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self
    // rust: .scene
    // rust: .fluids
    // rust: .fluid(self.scene.block(BlockPos::new(p[0], p[1], p[2]))))
}
pub fn sturdy_down(self: *Self, p: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let state = self.scene.block(BlockPos::new(p[0], p[1], p[2]));
    // rust: Ok(self.scene.fluids.sturdy(state, Direction::Down))
}
}
    // rust: impl FluidFlowWorld for Ticker<'_, '_, '_, '_> {
    // rust: type Error = Error;
    // rust: type Block = BlockStateId;
pub fn fluid(self: *Self, p: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.scene.fluids.fluid(self.scene.block(p)))
}
pub fn block(self: *Self, p: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.scene.block(p))
}
pub fn blocks_fluid_flow(self: *Self, s: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.scene.fluids.blocks_flow(s)
}
pub fn is_ice_class(self: *Self, s: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.scene.fluids.ice(s)
}
    // rust: fn is_face_sturdy(
    // rust: &mut self,
    // rust: s: BlockStateId,
    // rust: _: BlockPos,
    // rust: d: Direction,
    // rust: ) -> Result<bool, Error> {
    // rust: Ok(self.scene.fluids.sturdy(s, d))
}
}
/// `Entity.doWaterSplashEffect` with the arrow's own random.
    // rust: impl WaterSplashWorld for Ticker<'_, '_, '_, '_> {
    // rust: type Error = Error;
    // rust: type Entity = ();
    // rust: type Sound = ();
pub fn this_entity(self: *Self) void {
}
pub fn controlling_passenger(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(None)
}
pub fn velocity(self: *Self, _: () void {
}
    // rust: Ok(self.p.velocity)
}
pub fn splash_sound(self: *Self, _: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
pub fn random_float(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.st.random.next_float())
}
pub fn random_double(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.st.random.next_double())
}
pub fn play_sound(self: *Self, _: () void {
}
    // rust: self.st.events.push(ArrowEvent::Sound {
    // rust: sound: ArrowSound::Splash,
    // rust: volume,
    // rust: pitch,
    // rust: });
    // rust: Ok(())
}
pub fn position(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.p.position
}
pub fn width(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: WIDTH
}
    // rust: fn particle(
    // rust: &mut self,
    // rust: kind: SplashParticle,
    // rust: position: Vec3,
    // rust: velocity: Vec3,
    // rust: ) -> Result<(), Error> {
    // rust: self.st.events.push(ArrowEvent::Particle {
    // rust: kind: match kind {
    // rust: SplashParticle::Bubble => ArrowParticle::Bubble,
    // rust: SplashParticle::Splash => ArrowParticle::Splash,
    // rust: },
    // rust: position,
    // rust: velocity,
    // rust: });
    // rust: Ok(())
}
pub fn splash_event(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.client {
    // rust: self.st.events.push(ArrowEvent::SplashEvent);
}
    // rust: Ok(())
}
}

    // rust: mod client_tests;
