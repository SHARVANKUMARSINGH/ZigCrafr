//! Transpiled from Horizon Rust crate
//! Module: horizon-client_projectiles
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Projectiles fired by mobs and thrown by the player: arrows
//! (`AbstractArrow`, gravity 0.05), throwables (`ThrowableProjectile`:
//! snowballs, eggs, ender pearls, gravity 0.03) and fireballs
//! (`AbstractHurtingProjectile`: no gravity, 0.1 acceleration, 0.95 inertia).
//! The game applies the effects of a hit.
// use crate::entity_rules::EntityRules;
// use crate::mobs::Who;
// use horizon_core::{
    // rust: geometry::{Aabb, Direction, Vec3},
    // rust: position::BlockPos,
    // rust: random::RandomSource,
}

/// A new projectile entity's own random: vanilla seeds every entity's random
/// unpredictably, and a projectile's spread (and an arrow's base damage) come
/// from it, never from the shooter's random.
pub fn own_random(shooter: *crate::mobs::Mob) h {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizon_core::random::LegacyRandom::new(
    // rust: i64::from(shooter.id).wrapping_mul(0x9E37_79B9)
    // rust: ^ i64::from(shooter.age)
    // rust: ^ shooter.position.x.to_bits() as i64,
    // rust: )
}

/// a content mod's thrown item projectile, a copy of `Snowball` that deals
/// `damage` and flies as its `item`.
pub const ThrownType = struct {
    /// `<mod id>:<path>`.
    id: *'static str,
    item: *'static str,
    damage: f32,
};
/// the thrown types content mods declare, in registry order.
pub const THROWN_TYPES: std::sync::OnceLock<std.ArrayList(ThrownType)> = std::sync::OnceLock::new();
/// registers the content mods' thrown types, `(id, item, damage)`, a list
/// set once per process (false when it already was).
pub fn register_thrown_types(types: impl IntoIterator<Item = ([]const u8) void {
}
    // rust: if THROWN_TYPES.get().is_some() {
    // rust: return false;
}
    // rust: let leak = |s: String| -> &'static str { Box::leak(s.into_boxed_str()) };
    // rust: let types = types.into_iter().map(|(id, item, damage)| ThrownType {
    // rust: id: leak(id),
    // rust: item: leak(item),
    // rust: damage,
    // rust: });
    // rust: THROWN_TYPES.set(types.collect()).is_ok()
}
/// the content mods' thrown types, in registry order.
pub fn thrown_types() * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: THROWN_TYPES.get().map_or(&[], Vec::as_slice)
}
/// the lib's tests' one mod type, `ruby:bolt` thrown from `ruby:gem`: the
/// registry is set once per process, so every test registers the same.
    // rust: pub(crate) fn register_test_types() {
    // rust: let _ = register_thrown_types([("ruby:bolt".into(), "ruby:gem".into(), 2.0)]);
}
/// the mod type with entity type `id`; out of line, as vanilla's never are.
pub fn thrown_type(id: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: thrown_types().iter().find(|t| t.id == id)
}
/// the mod type `item` throws (the first in registry order).
pub fn thrown_by_item(item: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: thrown_types().iter().find(|t| t.item == item)
}

pub const ProjectileKind = enum {
    /// Arrow with its base damage, critical flag and tipped/stray/bogged effect.
    Arrow {,
    base_damage: f64,
    critical: bool,
    effect: Option<(&'static str, i32)>,
    // rust: },
    /// `ThrownTrident` of a mob (a drowned's): flies and sticks with
    /// `AbstractArrow`'s tick; the trident itself is the arrow state's
    /// `pickup_item`.
    Trident,
    Snowball,
    Egg,
    EnderPearl,
    SmallFireball,
    LargeFireball {,
    power: i32,
    // rust: },
    LlamaSpit,
    /// A player's `WindCharge` and a breeze's `BreezeWindCharge`: straight
    /// flight that bursts on whatever it meets.
    WindCharge,
    BreezeWindCharge,
    /// `ShulkerBullet`: homing on `target` in axis-aligned steps; one with
    /// no target (a summoned one) falls like any projectile.
    ShulkerBullet {,
    target: Option<Who>,
        /// The current step direction (3D data value), if any.
    dir: Option<u8>,
    steps: i32,
    delta: [f64; 3],
    seed: u64,
    // rust: },
    /// `WitherSkull`: blue (dangerous) skulls keep their speed better.
    WitherSkull {,
    dangerous: bool,
    // rust: },
    /// `ThrownSplashPotion` or `ThrownLingeringPotion`: the potion item it
    /// flies as (`ThrowableItemProjectile.getItem`). What it splashes is that
    /// stack's `potion_contents`, so a witch's potion and a summoned one are
    /// the same thing; its entity type is the stack's item.
    ///
    /// The `bool` is whether its entity type is `ThrownLingeringPotion`: the
    /// type is the entity's own and `/summon` can pair either with any `Item`,
    /// so it is kept next to the stack (a thrown potion's follows its item).
    Potion(Box<crate::items::ItemStack>, bool),
    /// `ThrownExperienceBottle`: its own entity type, gravity 0.07.
    ExperienceBottle,
    /// a content mod's type.
    Thrown(&'static ThrownType),
};
    // rust: impl ProjectileKind {
    /// A thrown potion flying as `stack`: a lingering item makes the lingering
    /// entity type, any other the splash one.
pub fn potion(stack: crate::items::ItemStack) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let lingering = &*stack.item == "minecraft:lingering_potion";
    // rust: Self::Potion(Box::new(stack), lingering)
}
    /// Wind charges take no push from an explosion (vanilla leaves their motion at 0).
pub fn ignores_blast(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(self, Self::WindCharge | Self::BreezeWindCharge)
}
    /// Whether the kind is a `Fireball` proper (`LargeFireball`,
    /// `SmallFireball`): the projectiles that carry an `Item`
    /// (`Fireball.DATA_ITEM_STACK`) and are drawn as it. A `DragonFireball`
    /// and a `WitherSkull` extend the hurting projectile only.
pub fn is_item_fireball(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(self, Self::SmallFireball | Self::LargeFireball { .. })
}
    /// `EntityType.Builder.eyeHeight`: 0.13 for arrows and tridents, 0 for
    /// wind charges, else the default 0.85 of the box height.
pub fn eye_height(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Arrow { .. } | Self::Trident => f64::from(0.13_f32),
    // rust: Self::WindCharge | Self::BreezeWindCharge => 0.0,
    // rust: _ => f64::from(self.size() as f32 * 0.85_f32),
}
}
    /// The width and height of its entity type's `sized(...)`.
pub fn size(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Arrow { .. } | Self::Trident => 0.5,
    // rust: Self::Snowball
    // rust: | Self::Egg
    // rust: | Self::EnderPearl
    // rust: | Self::LlamaSpit
    // rust: | Self::Potion(..)
    // rust: | Self::ExperienceBottle
    // rust: | Self::Thrown(_) => 0.25,
    // rust: Self::SmallFireball
    // rust: | Self::WindCharge
    // rust: | Self::BreezeWindCharge
    // rust: | Self::ShulkerBullet { .. }
    // rust: | Self::WitherSkull { .. } => 0.3125,
    // rust: Self::LargeFireball { .. } => 1.0,
}
}
    /// Its entity type.
pub fn id(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Arrow { .. } => "minecraft:arrow",
    // rust: Self::Trident => "minecraft:trident",
    // rust: Self::Snowball => "minecraft:snowball",
    // rust: Self::Egg => "minecraft:egg",
    // rust: Self::EnderPearl => "minecraft:ender_pearl",
    // rust: Self::SmallFireball => "minecraft:small_fireball",
    // rust: Self::LargeFireball { .. } => "minecraft:fireball",
    // rust: Self::LlamaSpit => "minecraft:llama_spit",
    // rust: Self::WindCharge => "minecraft:wind_charge",
    // rust: Self::BreezeWindCharge => "minecraft:breeze_wind_charge",
    // rust: Self::ShulkerBullet { .. } => "minecraft:shulker_bullet",
    // rust: Self::WitherSkull { .. } => "minecraft:wither_skull",
            // `ThrownSplashPotion`/`ThrownLingeringPotion`: the item names it.
    // rust: Self::Potion(_, true) => "minecraft:lingering_potion",
    // rust: Self::Potion(_, false) => "minecraft:splash_potion",
    // rust: Self::ExperienceBottle => "minecraft:experience_bottle",
    // rust: Self::Thrown(t) => t.id,
}
}
}
/// `ThrownItemRenderer`'s sprite for a thrown potion.
pub fn potion_sprite(item: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if item == "minecraft:lingering_potion" {
    // rust: "item/lingering_potion"
    // rust: } else {
    // rust: "item/splash_potion"
}
}
pub const Projectile = struct {
    /// When it joined its list ([`crate::join_seq`]); set by the list, not by the spawn site.
    join: crate::join_seq::JoinSeq,
    /// The entity id a server tracks it by (0 until it is tracked).
    id: u32,
    kind: ProjectileKind,
    owner: ?Who,
    /// `Projectile.owner`'s UUID, kept while the owner is away (a guest who
    /// left, a mob not loaded): what its save writes as `Owner`.
    owner_uuid: Option<[i32,
    /// On a server, the guest (by connection) who shot it: `Who::Player`
    /// then means them, not the host.
    guest: ?u32,
    position: Vec3,
    previous: Vec3,
    velocity: Vec3,
    yaw: f32,
    pitch: f32,
    /// `Entity.yRotO`/`xRotO`: the rotation the last tick ended with, which
    /// the renderer interpolates from (`setOldPosAndRot`).
    previous_yaw: f32,
    previous_pitch: f32,
    age: u32,
    stuck: bool,
    /// Whether the projectile has left its owner's box (Projectile.leftOwner).
    left_owner: bool,
    /// Non-arrow Projectile.hasBeenShot, independent of entity age.
    has_been_shot: bool,
    shoot_event: ?Vec3,
    /// The shooter's bow enchantments (Power, Punch, Flame, Piercing).
    bonus: crate::mobs::gear::ArrowBonus,
    /// Arrows' `AbstractArrow` state (ticked by `arrows::tick`).
    arrow: ?*crate::arrows::ArrowState,
    /// `AbstractHurtingProjectile.accelerationPower`.
    acceleration: f64,
    /// `Entity.needsSync`: a server tells its clients about the change this
    /// tick instead of at the next update interval.
    needs_sync: bool,
    /// `Entity.wasTouchingWater`: what the last tick's
    /// `updateFluidInteraction` found around the box after the move, read by
    /// the next tick's inertia (false until the first tick has moved it).
    touching_water: bool,
    /// `Entity.noGravity` (`NoGravity` in its save): `getGravity` is 0.
    no_gravity: bool,
    /// `Entity.remainingFireTicks`: a thrown projectile that flew through a
    /// fire block burns for 160 ticks, with the flame drawn over it.
    fire_ticks: i32,
    /// `Fireball.DATA_ITEM_STACK`: the item a fireball is drawn as, a fire
    /// charge until [`Projectile::set_item`] gives it another. None for the
    /// kinds that are no `Fireball` (a wither skull, a wind charge).
    item: ?crate::items::ItemStack,
};
/// `ThrownEnderpearl.isAllowedToTeleportOwner(owner, level)` for an owner in
/// the pearl's own dimension: vanilla reaches
/// `LivingEntity.isAlive() && !LivingEntity.isSleeping()` (bytecode 26-45) and
/// returns false otherwise, so a pearl whose owner died or went to bed is
/// discarded where it lands: no teleport, no 5 damage, no endermite roll.
pub fn owner_can_take_pearl(alive: bool, sleeping: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: alive && !sleeping
}
/// What a projectile struck this tick.
pub const Hit = enum {
    None,
    Block {,
    pos: [i32; 3],
    at: Vec3,
    face: [i32; 3],
    // rust: },
    Entity {,
    who: Who,
    at: Vec3,
    // rust: },
};
/// The world a projectile flies through: block ray clipping, water, and
/// the boxes of entities it could hit.
    // rust: pub trait ProjectileWorld {
pub fn clip(self: *Self, from: Vec3, to: Vec3) O;
    /// `Entity.isInWater` as `updateFluidInteraction` sets it: some water
    /// block's surface reaches the bottom of the box (deflated by 0.001).
pub fn in_water(self: *Self, bounds: Aabb) b;
pub fn targets(self: *Self) *;
    /// Server-only mod-block contacts along the completed movement.
pub fn block_contacts(self: *Self, _entity: i32, _kind: []const u8, _from: Vec3, _to: Vec3, _bounds: Aabb) void {
}
    /// `Level.isEmptyBlock`.
pub fn empty(self: *Self, _p: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
    /// `loadedAndEntityCanStandOn`: a sturdy top face.
pub fn solid(self: *Self, _p: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: false
}
    /// The block at `p` is a `BaseFireBlock` (fire, soul fire) whose
    /// `entityInside` ignites an entity in it for 160 ticks
    /// (`BaseFireBlock.fireIgnite`).
pub fn ignites(self: *Self, _p: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: false
}
}
/// `CollisionGetter.clipIncludingBorder` over a block clip's result: a ray
/// from inside the world border whose hit (or end, on a miss) lies outside it
/// stops on the border instead, at `WorldBorder.clampVec3ToBound` of that
/// point, facing `Direction.getApproximateNearest` of the travel. `bounds` is
/// the border's [minX, minZ, maxX, maxZ].
    // rust: pub fn clip_including_border(
    // rust: hit: Option<(Vec3, [i32; 3], [i32; 3])>,
    // rust: from: Vec3,
    // rust: to: Vec3,
    // rust: bounds: [f64; 4],
    // rust: ) -> Option<(Vec3, [i32; 3], [i32; 3])> {
    // rust: let [min_x, min_z, max_x, max_z] = bounds;
    // WorldBorder.isWithinBounds(x, z): the far edges are outside.
    // rust: let within = |p: Vec3| p.x >= min_x && p.x < max_x && p.z >= min_z && p.z < max_z;
    // rust: let end = hit.map_or(to, |h| h.0);
    // rust: if !within(from) || within(end) {
    // rust: return hit;
}
    // Mth.clamp, up to 1.0E-5F inside the far edges.
    // rust: let clamp = |v: f64, low: f64, high: f64| if v < low { low } else { v.min(high) };
    // rust: let inset = f64::from(1.0e-5_f32);
    // rust: let at = Vec3::new(
    // rust: clamp(end.x, min_x, max_x - inset),
    // rust: end.y,
    // rust: clamp(end.z, min_z, max_z - inset),
    // rust: );
    // rust: let face =
    // rust: Direction::approximate_nearest(Vec3::new(end.x - from.x, end.y - from.y, end.z - from.z));
    // rust: let pos = BlockPos::containing(at);
    // rust: Some((at, [pos.x, pos.y, pos.z], face.normal()))
}
/// Direction steps by 3D data value: down, up, north, south, west, east.
    // rust: pub const STEPS: [[i32; 3]; 6] = [
    // rust: [0, -1, 0],
    // rust: [0, 1, 0],
    // rust: [0, 0, -1],
    // rust: [0, 0, 1],
    // rust: [-1, 0, 0],
    // rust: [1, 0, 0],
    // rust: ];
pub fn axis_of(d: u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match d {
    // rust: 0 | 1 => 1,
    // rust: 2 | 3 => 2,
    // rust: _ => 0,
}
}
    // rust: impl crate::entity_rules::EntityRules for Projectile {
pub fn is_no_gravity(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.no_gravity
}
    /// Each projectile class's `getDefaultGravity`.
pub fn get_default_gravity(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match &self.kind {
    // rust: ProjectileKind::Arrow { .. } | ProjectileKind::Trident => 0.05,
    // rust: ProjectileKind::SmallFireball
    // rust: | ProjectileKind::LargeFireball { .. }
    // rust: | ProjectileKind::WitherSkull { .. } => 0.0,
    // rust: ProjectileKind::LlamaSpit => 0.06,
            // `ThrownExperienceBottle.getDefaultGravity` is 0.07.
    // rust: ProjectileKind::ExperienceBottle => 0.07,
    // rust: ProjectileKind::Potion { .. } => 0.05,
    // rust: ProjectileKind::ShulkerBullet { .. } => 0.04,
    // rust: _ => 0.03,
}
}
}
/// `AbstractHurtingProjectile.applyInertia` / `ThrowableProjectile.applyInertia`:
/// four bubble particles at `position - movement * 0.25`, moving with `movement`.
pub fn water_bubble_at(position: [f64; 3], movement: [f64; 3]) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (
    // rust: [
    // rust: position[0] - movement[0] * 0.25,
    // rust: position[1] - movement[1] * 0.25,
    // rust: position[2] - movement[2] * 0.25,
    // rust: ],
    // rust: movement,
    // rust: )
}
    // rust: impl Projectile {
    /// `Entity.getBoundingBox`: its type's square box standing on its position.
pub fn bounds(self: *Self) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (p, half) = (self.position, self.kind.size() / 2.0);
    // rust: let height = self.kind.size();
    // rust: Aabb::new(
    // rust: Vec3::new(p.x - half, p.y, p.z - half),
    // rust: Vec3::new(p.x + half, p.y + height, p.z + half),
    // rust: )
}
pub fn new(kind: ProjectileKind, position: Vec3, owner: ?Who) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let kind_is_arrow = matches!(kind, ProjectileKind::Arrow { .. } | ProjectileKind::Trident);
        // `Fireball.defineSynchedData`: DATA_ITEM_STACK starts as a fire charge.
    // rust: let item = kind
    // rust: .is_item_fireball()
    // rust: .then(|| crate::items::ItemStack::new("minecraft:fire_charge", 1));
        // `AbstractWindCharge`'s constructors set it to 0.
    // rust: let acceleration = if matches!(
    // rust: kind,
    // rust: ProjectileKind::WindCharge | ProjectileKind::BreezeWindCharge
    // rust: ) {
    // rust: 0.0
    // rust: } else {
    // rust: 0.1
}
    // rust: Self {
    // rust: join: Default::default(),
    // rust: id: 0,
    // rust: kind,
    // rust: owner,
    // rust: owner_uuid: None,
    // rust: guest: None,
    // rust: position,
    // rust: previous: position,
    // rust: velocity: Vec3::ZERO,
    // rust: yaw: 0.0,
    // rust: pitch: 0.0,
    // rust: previous_yaw: 0.0,
    // rust: previous_pitch: 0.0,
    // rust: age: 0,
    // rust: stuck: false,
    // rust: left_owner: false,
    // rust: has_been_shot: false,
    // rust: shoot_event: None,
    // rust: bonus: Default::default(),
    // rust: acceleration,
    // rust: needs_sync: false,
    // rust: touching_water: false,
    // rust: no_gravity: false,
    // rust: fire_ticks: 0,
    // rust: item,
    // rust: arrow: kind_is_arrow.then(|| {
                // Entity.random: seeded unpredictably, the position stands in.
    // rust: Box::new(crate::arrows::ArrowState::new(
    // rust: horizon_core::random::LegacyRandom::new(
    // rust: position.x.to_bits() as i64 ^ position.z.to_bits().rotate_left(17) as i64,
    // rust: ),
    // rust: ))
    // rust: }),
}
}
    /// Entity box from the feet (`EntityType.sized` cube of `kind.size()`).
pub fn aabb(self: *Self) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let s = self.kind.size();
    // rust: let h = s * 0.5;
    // rust: Aabb::new(
    // rust: Vec3::new(self.position.x - h, self.position.y, self.position.z - h),
    // rust: Vec3::new(
    // rust: self.position.x + h,
    // rust: self.position.y + s,
    // rust: self.position.z + h,
    // rust: ),
    // rust: )
}
    /// The arrow's own random from now on (`Entity.random`).
pub fn with_arrow_random(random: horizon_core::random::LegacyRandom) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(a) = self.arrow.as_mut() {
    // rust: a.random = random;
}
    // rust: self
}
    /// The shooter's bow enchantments; Flame spawns the arrow burning for 100
    /// seconds (`projectile_spawned` ignite), Piercing sets its pierce level.
pub fn set_bonus(self: *Self, bonus: crate::mobs::gear::ArrowBonus) void {
}
    // rust: if let Some(a) = self.arrow.as_mut() {
    // rust: if bonus.flame {
    // rust: a.ignite_for_seconds(100.0);
}
    // rust: a.pierce = bonus.pierce.min(127) as u8;
}
    // rust: self.bonus = bonus;
}
    /// `AbstractArrow.isCritArrow`.
pub fn critical(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(self.kind, ProjectileKind::Arrow { critical: true, .. })
}
pub fn set_critical(self: *Self, value: bool) void {
}
    // rust: if let ProjectileKind::Arrow { critical, .. } = &mut self.kind {
    // rust: *critical = value;
}
}
    /// `AbstractArrow.tick`: critical streaks and submerged bubble trails.
    // rust: pub fn arrow_trail(
    // rust: &self,
    // rust: water: bool,
    // rust: ) -> Vec<(crate::particles::ParticleType, [f64; 3], [f64; 3])> {
//         use crate::particles::ParticleType;
    // rust: let mut trail = Vec::new();
    // rust: if self.stuck || !self.is_arrow() {
    // rust: return trail;
}
    // rust: let (p, v) = (self.position, self.velocity);
    // rust: if water {
    // rust: let drag = f64::from(0.6f32);
    // rust: let speed = [v.x * drag, v.y * drag, v.z * drag];
    // rust: let at = [
    // rust: p.x - speed[0] * 0.25,
    // rust: p.y - speed[1] * 0.25,
    // rust: p.z - speed[2] * 0.25,
    // rust: ];
    // rust: for _ in 0..4 {
    // rust: trail.push((ParticleType::Bubble, at, speed));
}
}
    // rust: if matches!(self.kind, ProjectileKind::Arrow { critical: true, .. }) {
    // rust: for i in 0..4 {
    // rust: let t = i as f64 / 4.0;
    // rust: trail.push((
    // rust: ParticleType::Crit,
    // rust: [p.x + v.x * t, p.y + v.y * t, p.z + v.z * t],
    // rust: [-v.x, -v.y + 0.2, -v.z],
    // rust: ));
}
}
    // rust: trail
}
pub fn is_arrow(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(self.kind, ProjectileKind::Arrow { .. })
}
    /// A `ThrowableProjectile`: snowballs, eggs, ender pearls, potions, a
    /// content mod's thrown item and a llama's spit. They are the projectiles
    /// that apply the effects of the blocks they fly through
    /// (`ThrowableProjectile.tick` calls `applyEffectsFromBlocks`), which an
    /// `AbstractHurtingProjectile` — a fireball, a wind charge, a skull — does
    /// not.
pub fn is_thrown(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: self.kind,
    // rust: ProjectileKind::Snowball
    // rust: | ProjectileKind::Egg
    // rust: | ProjectileKind::EnderPearl
    // rust: | ProjectileKind::LlamaSpit
    // rust: | ProjectileKind::Potion(..)
    // rust: | ProjectileKind::Thrown(_)
    // rust: )
}
    /// `Entity.isOnFire`.
pub fn on_fire(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.fire_ticks > 0
}
    /// `Entity.igniteForTicks`: the longer fire wins.
pub fn ignite_for_ticks(self: *Self, ticks: i32) void {
}
    // rust: if self.fire_ticks < ticks {
    // rust: self.fire_ticks = ticks;
}
}
    /// `Entity.clearFire`: it counts from below zero, which `on_fire` reads as out.
pub fn clear_fire(self: *Self) void {
}
    // rust: self.fire_ticks = self.fire_ticks.min(0);
}
    /// `ThrowableProjectile.tick`'s `applyEffectsFromBlocks` and the fire phase
    /// of `Entity.baseTick`: a fire block the box is in ignites the projectile
    /// for 160 ticks (`BaseFireBlock.fireIgnite`), water puts it out, and one
    /// tick is counted down every tick.
pub fn fire_tick(self: *Self, w: *impl ProjectileWorld) void {
}
    // rust: if !self.is_thrown() {
    // rust: return;
}
    // rust: if self.in_fire(w) {
    // rust: self.ignite_for_ticks(160);
}
    // rust: if w.in_water(self.bounds()) {
    // rust: self.clear_fire();
    // rust: } else if self.fire_ticks > 0 {
    // rust: self.fire_ticks -= 1;
}
}
    /// `Entity.checkInsideBlocks`: the blocks under the box, deflated by 1e-7
    /// so a box sitting exactly on a block boundary is not inside it.
pub fn in_fire(self: *Self, w: *impl ProjectileWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = self.bounds().deflate(Vec3::new(1.0e-7, 1.0e-7, 1.0e-7));
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: for x in (lo.x).floor() as i32..=(hi.x).floor() as i32 {
    // rust: for y in (lo.y).floor() as i32..=(hi.y).floor() as i32 {
    // rust: for z in (lo.z).floor() as i32..=(hi.z).floor() as i32 {
    // rust: if w.ignites([x, y, z]) {
    // rust: return true;
}
}
}
}
    // rust: false
}
    /// Whether it is a `SpectralArrow` (its own entity type): a spectral
    /// arrow's pickup item, or the glowing effect a dispenser shoots with.
pub fn is_spectral_arrow(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let ProjectileKind::Arrow { effect, .. } = &self.kind else {
    // rust: return false;
}
    // rust: effect.is_some_and(|(id, _)| id == "minecraft:glowing")
    // rust: || self
    // rust: .arrow
    // rust: .as_ref()
    // rust: .is_some_and(|a| a.spectral || &*a.pickup_item.item == "minecraft:spectral_arrow")
}
    /// `Arrow.ID_EFFECT_COLOR` (`updateColor`): the opaque colour of the
    /// potion the arrow carries, from its tipped pickup item or the effect a
    /// stray, bogged or parched adds; -1 for none.
pub fn arrow_effect_color(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let ProjectileKind::Arrow { effect, .. } = &self.kind else {
    // rust: return -1;
}
    // rust: if self.is_spectral_arrow() {
    // rust: return -1;
}
    // rust: let rgb = match (effect, &self.arrow) {
    // rust: (Some((id, _)), _) => crate::brewing::effect(id).map(|e| e.color),
    // rust: (None, Some(a)) if &*a.pickup_item.item == "minecraft:tipped_arrow" => a
    // rust: .pickup_item
    // rust: .potion()
    // rust: .map(|p| crate::brewing::potion_color(Some(p))),
    // rust: _ => None,
}
    // rust: rgb.map_or(-1, |rgb| (rgb | 0xFF00_0000) as i32)
}
pub fn is_fireball(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: self.kind,
    // rust: ProjectileKind::SmallFireball
    // rust: | ProjectileKind::LargeFireball { .. }
    // rust: | ProjectileKind::WitherSkull { .. }
    // rust: )
}
    /// `EntityRenderer.getBlockLightLevel` for a projectile: the renderer's
    /// own override wins (`ShulkerBulletRenderer` returns 15, as the fireball
    /// renderers do), and the base class draws anything `isOnFire` at 15
    /// whatever the level says. `None` keeps the level's block light; the sky
    /// light is never overridden.
pub fn block_light_override(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.is_fireball()
    // rust: || self.on_fire()
    // rust: || matches!(self.kind, ProjectileKind::ShulkerBullet { .. }))
    // rust: .then_some(15)
}
    /// `EntityRenderer.getPackedLightCoords` lights an entity from the block
    /// its `getLightProbePosition` is in, which is `getEyePosition`: the eye
    /// height of its box, not the cell its feet rest in.
pub fn light_probe_y(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.position.y + self.kind.eye_height()
}
pub fn water_bubbles(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.touching_water {
    // rust: return None;
}
        // ThrowableProjectile.tick applies gravity, then applyInertia reads
        // that movement. AbstractHurtingProjectile.applyInertia reads the
        // movement it already has: fireballs, wither skulls and wind charges
        // have no gravity step before the bubbles.
    // rust: let hurting = matches!(
    // rust: self.kind,
    // rust: ProjectileKind::SmallFireball
    // rust: | ProjectileKind::LargeFireball { .. }
    // rust: | ProjectileKind::WitherSkull { .. }
    // rust: | ProjectileKind::WindCharge
    // rust: | ProjectileKind::BreezeWindCharge
    // rust: );
    // rust: let throwable = matches!(
    // rust: self.kind,
    // rust: ProjectileKind::Snowball
    // rust: | ProjectileKind::Egg
    // rust: | ProjectileKind::EnderPearl
    // rust: | ProjectileKind::Potion(..)
    // rust: | ProjectileKind::ExperienceBottle
    // rust: | ProjectileKind::Thrown(_)
    // rust: );
    // rust: let movement = if hurting {
    // rust: [self.velocity.x, self.velocity.y, self.velocity.z]
    // rust: } else if throwable {
    // rust: [
    // rust: self.velocity.x,
    // rust: self.velocity.y - self.get_gravity(),
    // rust: self.velocity.z,
    // rust: ]
    // rust: } else {
    // rust: return None;
}
    // rust: let at = [self.position.x, self.position.y, self.position.z];
    // rust: Some(water_bubble_at(at, movement))
}
    /// Projectile.shoot: normalized direction plus triangular noise, times speed.
    // rust: pub fn shoot(
    // rust: &mut self,
    // rust: random: &mut impl RandomSource,
    // rust: dir: [f64; 3],
    // rust: speed: f32,
    // rust: uncertainty: f32,
    // rust: ) {
    // rust: let len = (dir[0] * dir[0] + dir[1] * dir[1] + dir[2] * dir[2])
    // rust: .sqrt()
    // rust: .max(1.0e-9);
    // rust: let spread = 0.017_227_5 * f64::from(uncertainty);
    // rust: let v = [
    // rust: (dir[0] / len + random.triangle(0.0, spread)) * f64::from(speed),
    // rust: (dir[1] / len + random.triangle(0.0, spread)) * f64::from(speed),
    // rust: (dir[2] / len + random.triangle(0.0, spread)) * f64::from(speed),
    // rust: ];
    // rust: self.velocity = Vec3::new(v[0], v[1], v[2]);
    // rust: self.update_rotation();
}
    /// Projectile.shootFromRotation for player throws.
    // rust: pub fn shoot_from_rotation(
    // rust: &mut self,
    // rust: random: &mut impl RandomSource,
    // rust: pitch: f32,
    // rust: yaw: f32,
    // rust: offset: f32,
    // rust: speed: f32,
    // rust: uncertainty: f32,
    // rust: source_velocity: Vec3,
    // rust: source_on_ground: bool,
    // rust: ) {
    // rust: let (p, y, o) = (
    // rust: pitch.to_radians(),
    // rust: yaw.to_radians(),
    // rust: (pitch + offset).to_radians(),
    // rust: );
    // rust: let dir = [
    // rust: f64::from(-y.sin() * p.cos()),
    // rust: f64::from(-o.sin()),
    // rust: f64::from(y.cos() * p.cos()),
    // rust: ];
    // rust: self.shoot(random, dir, speed, uncertainty);
    // rust: self.velocity = Vec3::new(
    // rust: self.velocity.x + source_velocity.x,
    // rust: self.velocity.y
    // rust: + if source_on_ground {
    // rust: 0.0
    // rust: } else {
    // rust: source_velocity.y
    // rust: },
    // rust: self.velocity.z + source_velocity.z,
    // rust: );
}
    /// AbstractHurtingProjectile: movement along the direction at the acceleration power.
    // rust: pub fn fireball(
    // rust: kind: ProjectileKind,
    // rust: position: Vec3,
    // rust: owner: Option<Who>,
    // rust: dir: [f64; 3],
    // rust: ) -> Self {
    // rust: let mut p = Self::new(kind, position, owner);
    // rust: let len = (dir[0] * dir[0] + dir[1] * dir[1] + dir[2] * dir[2])
    // rust: .sqrt()
    // rust: .max(1.0e-9);
    // rust: p.velocity = Vec3::new(dir[0] / len * 0.1, dir[1] / len * 0.1, dir[2] / len * 0.1);
    // rust: p.update_rotation();
    // rust: p
}
    /// `Fireball.setItem`: the item a fireball is drawn as. An empty stack
    /// puts the default fire charge back, anything else is kept as a single
    /// one (`copyWithCount(1)`); a kind that is no `Fireball` has no item.
pub fn set_item(self: *Self, stack: crate::items::ItemStack) void {
}
    // rust: if !self.kind.is_item_fireball() {
    // rust: return;
}
    // rust: let mut stack = if stack.count == 0 || &*stack.item == "minecraft:air" {
    // rust: crate::items::ItemStack::new("minecraft:fire_charge", 1)
    // rust: } else {
    // rust: stack
}
    // rust: stack.count = 1;
    // rust: self.item = Some(stack);
}
pub fn update_rotation(self: *Self) void {
}
    // rust: let v = self.velocity;
    // rust: let sd = (v.x * v.x + v.z * v.z).sqrt();
    // rust: self.yaw = v.x.atan2(v.z).to_degrees() as f32;
    // rust: self.pitch = v.y.atan2(sd).to_degrees() as f32;
        // `Projectile.shoot` ends with `yRotO = getYRot(); xRotO = getXRot()`:
        // a freshly shot projectile interpolates from the rotation it was
        // aimed along, not from where it was created.
    // rust: self.previous_yaw = self.yaw;
    // rust: self.previous_pitch = self.pitch;
}
    /// `Entity.setOldPosAndRot`: where the renderer interpolates from.
pub fn set_old_pos_and_rot(self: *Self) void {
}
    // rust: self.previous = self.position;
    // rust: self.previous_yaw = self.yaw;
    // rust: self.previous_pitch = self.pitch;
}
    /// A shulker's bullet from its block toward `target`, first leaving
    /// along an axis other than the one it is attached on.
    // rust: pub fn shulker_bullet(
    // rust: w: &impl ProjectileWorld,
    // rust: owner_block: [i32; 3],
    // rust: owner: Who,
    // rust: target: Who,
    // rust: attach_axis: u8,
    // rust: seed: u64,
    // rust: ) -> Self {
    // rust: let at = Vec3::new(
    // rust: f64::from(owner_block[0]) + 0.5,
    // rust: f64::from(owner_block[1]) + 0.5,
    // rust: f64::from(owner_block[2]) + 0.5,
    // rust: );
    // rust: let mut p = Self::new(
    // rust: ProjectileKind::ShulkerBullet {
    // rust: target: Some(target),
    // rust: dir: Some(1),
    // rust: steps: 0,
    // rust: delta: [0.0; 3],
    // rust: seed,
    // rust: },
    // rust: at,
    // rust: Some(owner),
    // rust: );
    // rust: p.select_next_move(w, Some(attach_axis));
    // rust: p
}
pub fn bullet_random(self: *Self, bound: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let ProjectileKind::ShulkerBullet { seed, .. } = &mut self.kind else {
    // rust: return 0;
}
        // xorshift64*: the bullet's own random stream.
    // rust: *seed ^= *seed >> 12;
    // rust: *seed ^= *seed << 25;
    // rust: *seed ^= *seed >> 27;
    // rust: let v = seed.wrapping_mul(0x2545_F491_4F6C_DD1D) >> 33;
    // rust: (v % bound.max(1) as u64) as i32
}
pub fn block_pos(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [
    // rust: self.position.x.floor() as i32,
    // rust: self.position.y.floor() as i32,
    // rust: self.position.z.floor() as i32,
    // rust: ]
}
pub fn target_box(self: *Self, w: *impl ProjectileWorld) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let ProjectileKind::ShulkerBullet {
    // rust: target: Some(target),
    // rust: ..
    // rust: } = self.kind
    // rust: else {
    // rust: return None;
}
    // rust: w.targets()
    // rust: .iter()
    // rust: .find(|(who, _)| *who == target)
    // rust: .map(|(_, b)| *b)
}
    /// `ShulkerBullet.selectNextMoveDirection`.
pub fn select_next_move(self: *Self, w: *impl ProjectileWorld, excluded: ?u8) void {
}
    // rust: let (target, y_offset) = match self.target_box(w) {
    // rust: Some(b) => {
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: let half = (hi.y - lo.y) * 0.5;
    // rust: let c = [(lo.x + hi.x) / 2.0, lo.y + half, (lo.z + hi.z) / 2.0];
    // rust: (c.map(|v| v.floor() as i32), half)
}
    // rust: None => {
    // rust: let p = self.block_pos();
    // rust: ([p[0], p[1] - 1, p[2]], 0.5)
}
}
    // rust: let mut goal = [
    // rust: f64::from(target[0]) + 0.5,
    // rust: f64::from(target[1]) + y_offset,
    // rust: f64::from(target[2]) + 0.5,
    // rust: ];
    // rust: let mut selection = None;
    // rust: let centre = [
    // rust: f64::from(target[0]) + 0.5,
    // rust: f64::from(target[1]) + 0.5,
    // rust: f64::from(target[2]) + 0.5,
    // rust: ];
    // rust: let d2 = (0..3)
    // rust: .map(|i| ([self.position.x, self.position.y, self.position.z][i] - centre[i]).powi(2))
    // rust: .sum::<f64>();
    // rust: if d2 >= 4.0 {
    // rust: let cur = self.block_pos();
    // rust: let mut options = Vec::new();
    // rust: let step = |d: u8| {
    // rust: let s = STEPS[d as usize];
    // rust: [cur[0] + s[0], cur[1] + s[1], cur[2] + s[2]]
}
    // rust: for (axis, (lo, hi)) in [(0u8, (4u8, 5u8)), (1, (0, 1)), (2, (2, 3))] {
    // rust: if excluded == Some(axis) {
    // rust: continue;
}
    // rust: let i = axis as usize;
    // rust: if cur[i] < target[i] && w.empty(step(hi)) {
    // rust: options.push(hi);
    // rust: } else if cur[i] > target[i] && w.empty(step(lo)) {
    // rust: options.push(lo);
}
}
    // rust: let mut pick = self.bullet_random(6) as u8;
    // rust: if options.is_empty() {
    // rust: let mut i = 5;
    // rust: while !w.empty(step(pick)) && i > 0 {
    // rust: pick = self.bullet_random(6) as u8;
    // rust: i -= 1;
}
    // rust: } else {
    // rust: pick = options[self.bullet_random(options.len() as i32) as usize];
}
    // rust: let s = STEPS[pick as usize];
    // rust: goal = [
    // rust: self.position.x + f64::from(s[0]),
    // rust: self.position.y + f64::from(s[1]),
    // rust: self.position.z + f64::from(s[2]),
    // rust: ];
    // rust: selection = Some(pick);
}
    // rust: let d = [
    // rust: goal[0] - self.position.x,
    // rust: goal[1] - self.position.y,
    // rust: goal[2] - self.position.z,
    // rust: ];
    // rust: let len = (d[0] * d[0] + d[1] * d[1] + d[2] * d[2]).sqrt();
    // rust: let delta = if len == 0.0 {
    // rust: [0.0; 3]
    // rust: } else {
    // rust: d.map(|v| v / len * 0.15)
}
    // rust: let steps_next = 10 + self.bullet_random(5) * 10;
    // rust: if let ProjectileKind::ShulkerBullet {
    // rust: dir,
    // rust: steps,
    // rust: delta: dl,
    // rust: ..
    // rust: } = &mut self.kind
    // rust: {
    // rust: *dir = selection;
    // rust: *dl = delta;
    // rust: *steps = steps_next;
}
}
    /// `ShulkerBullet.tick`.
pub fn tick_bullet(self: *Self, w: *impl ProjectileWorld, impact: bool) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let target = self.target_box(w);
    // rust: let ProjectileKind::ShulkerBullet { delta, .. } = &mut self.kind else {
    // rust: return (false, Hit::None);
}
    // rust: if target.is_some() {
    // rust: for d in delta.iter_mut() {
    // rust: *d = (*d * 1.025).clamp(-1.0, 1.0);
}
    // rust: let dl = *delta;
    // rust: let v = self.velocity;
    // rust: self.velocity = Vec3::new(
    // rust: v.x + (dl[0] - v.x) * 0.2,
    // rust: v.y + (dl[1] - v.y) * 0.2,
    // rust: v.z + (dl[2] - v.z) * 0.2,
    // rust: );
    // rust: } else {
            // `Entity.applyGravity`: `getGravity` is 0 under NoGravity.
    // rust: self.velocity.y -= crate::entity_rules::EntityRules::get_gravity(self);
}
    // rust: let from = self.position;
    // rust: let to = from.add_vector(self.velocity);
    // rust: let block = w.clip(from, to);
    // rust: let end = block.map_or(to, |b| b.0);
    // rust: let mut best: Option<(Who, Vec3, f64)> = None;
    // rust: for (who, b) in w.targets() {
    // rust: if Some(*who) == self.owner && !self.left_owner {
    // rust: continue;
}
    // rust: if let Some(at) = b.inflate(Vec3::new(0.3, 0.3, 0.3)).clip(from, end) {
    // rust: let d = (at.x - from.x).powi(2) + (at.y - from.y).powi(2) + (at.z - from.z).powi(2);
    // rust: if best.is_none_or(|bb| d < bb.2) {
    // rust: best = Some((*who, at, d));
}
}
}
    // rust: if !self.left_owner {
    // rust: let owner_box = w
    // rust: .targets()
    // rust: .iter()
    // rust: .find(|(who, _)| Some(*who) == self.owner)
    // rust: .map(|(_, b)| *b);
    // rust: self.left_owner =
    // rust: owner_box.is_none_or(|b| !b.inflate(Vec3::new(1.0, 1.0, 1.0)).contains(from));
}
    // rust: if impact && let Some((who, at, _)) = best {
    // rust: self.position = at;
    // rust: return (false, Hit::Entity { who, at });
}
    // rust: if impact && let Some((at, pos, face)) = block {
    // rust: self.position = at;
    // rust: return (false, Hit::Block { pos, at, face });
}
    // rust: self.position = to;
    // rust: self.update_rotation();
    // rust: if let Some(b) = target {
    // rust: let (dir, steps) = match self.kind {
    // rust: ProjectileKind::ShulkerBullet { dir, steps, .. } => (dir, steps),
    // rust: _ => (None, 0),
}
    // rust: if steps > 0 {
    // rust: let left = steps - 1;
    // rust: if let ProjectileKind::ShulkerBullet { steps, .. } = &mut self.kind {
    // rust: *steps = left;
}
    // rust: if left == 0 {
    // rust: self.select_next_move(w, dir.map(axis_of));
}
}
    // rust: let dir = match self.kind {
    // rust: ProjectileKind::ShulkerBullet { dir, .. } => dir,
    // rust: _ => None,
}
    // rust: if let Some(d) = dir {
    // rust: let p = self.block_pos();
    // rust: let s = STEPS[d as usize];
    // rust: let axis = axis_of(d);
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: let t = [
    // rust: ((lo.x + hi.x) / 2.0).floor() as i32,
    // rust: lo.y.floor() as i32,
    // rust: ((lo.z + hi.z) / 2.0).floor() as i32,
    // rust: ];
    // rust: if w.solid([p[0] + s[0], p[1] + s[1], p[2] + s[2]])
    // rust: || p[axis as usize] == t[axis as usize]
    // rust: {
    // rust: self.select_next_move(w, Some(axis));
}
}
}
    // rust: (self.position.y > -128.0, Hit::None)
}
    /// AbstractHurtingProjectile.applyInertia, on both server and client.
pub fn apply_hurting_inertia(self: *Self, water: bool) void {
}
        // WitherSkull.getInertia: 0.73 for dangerous skulls.
        // Vanilla returns float inertia and widens it before scaling double motion.
    // rust: let inertia = f64::from(match self.kind {
    // rust: ProjectileKind::WitherSkull { dangerous: true } => 0.73_f32,
            // AbstractWindCharge.getInertia and getLiquidInertia.
    // rust: ProjectileKind::WindCharge | ProjectileKind::BreezeWindCharge => 1.0,
    // rust: _ if water => 0.8,
    // rust: _ => 0.95,
    // rust: });
    // rust: let v = self.velocity;
    // rust: let len = (v.x * v.x + v.y * v.y + v.z * v.z).sqrt().max(1.0e-9);
    // rust: self.velocity = Vec3::new(
    // rust: (v.x + v.x / len * self.acceleration) * inertia,
    // rust: (v.y + v.y / len * self.acceleration) * inertia,
    // rust: (v.z + v.z / len * self.acceleration) * inertia,
    // rust: );
}

    /// One tick: returns whether to keep the projectile and what it hit.
pub fn tick(self: *Self, w: *impl ProjectileWorld) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.tick_with(w, true)
}
    /// One tick that meets nothing: what `tick` would have done had its hit been
    /// canceled (`ProjectileImpactEvent`). The projectile goes the whole way of its
    /// motion and flies on, with no hit to act on.
pub fn tick_through(self: *Self, w: *impl ProjectileWorld) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.tick_with(w, false)
}
pub fn tick_with(self: *Self, w: *impl ProjectileWorld, impact: bool) ( {
    // Implementation ported from Horizon
    return undefined;
}
        // LlamaSpit and ShulkerBullet call Projectile.tick before moving;
        // ThrowableProjectile and AbstractHurtingProjectile call it afterwards.
    // rust: let base_first = matches!(
    // rust: self.kind,
    // rust: ProjectileKind::LlamaSpit | ProjectileKind::ShulkerBullet { .. }
    // rust: );
    // rust: if base_first {
    // rust: self.tick_shoot_event();
}
    // rust: let from = self.position;
    // rust: let result = self.tick_inner(w, impact);
    // rust: w.block_contacts(
    // rust: self.id as i32,
    // rust: self.kind.id(),
    // rust: from,
    // rust: self.position,
    // rust: self.bounds(),
    // rust: );
    // rust: self.fire_tick(w);
    // rust: if !base_first {
    // rust: self.tick_shoot_event();
}
    // rust: result
}
    /// The first-tick notification branch of vanilla's base projectile tick.
    /// Arrows own this state in ArrowState and follow their separate tick path.
pub fn tick_shoot_event(self: *Self) void {
}
    // rust: if self.arrow.is_none() && !self.has_been_shot {
    // rust: self.has_been_shot = true;
    // rust: self.shoot_event = Some(self.position);
}
}
    /// Drain the first-tick event for dispatch in the owner's game context.
pub fn take_shoot_event(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.shoot_event.take()
}
pub fn tick_inner(self: *Self, w: *impl ProjectileWorld, impact: bool) ( {
    // Implementation ported from Horizon
    return undefined;
}
        // `Entity.setOldPosAndRot` (the previous position and rotation the
        // renderer interpolates from), kept across the `impact` flag's arrival
        // from #6279.
    // rust: self.set_old_pos_and_rot();
    // rust: self.age += 1;
    // rust: if matches!(self.kind, ProjectileKind::ShulkerBullet { .. }) {
    // rust: return self.tick_bullet(w, impact);
}
        // ThrowableProjectile and AbstractHurtingProjectile.applyInertia read
        // `isInWater` before their move and `Projectile.tick`'s base tick;
        // LlamaSpit.tick runs that base tick first, at the spit's box here.
    // rust: let water = if self.kind == ProjectileKind::LlamaSpit {
    // rust: w.in_water(self.bounds())
    // rust: } else {
    // rust: self.touching_water
}
    // rust: match self.kind {
    // rust: ProjectileKind::SmallFireball
    // rust: | ProjectileKind::LargeFireball { .. }
    // rust: | ProjectileKind::WitherSkull { .. }
    // rust: | ProjectileKind::WindCharge
    // rust: | ProjectileKind::BreezeWindCharge => {
    // rust: self.apply_hurting_inertia(water);
}
            // Arrows and tridents tick with `arrows::tick`.
    // rust: ProjectileKind::Arrow { .. } | ProjectileKind::Trident => {}
            // LlamaSpit.tick: gone in water; drag and gravity follow the move.
    // rust: ProjectileKind::LlamaSpit => {
    // rust: if water {
    // rust: return (false, Hit::None);
}
}
    // rust: _ => {
                // ThrowableProjectile: gravity, then inertia. Its drag is a
                // float in vanilla (0.8F in water, `getAirDrag` 0.99F), so
                // widens to the double that scales the motion.
    // rust: self.velocity.y -= self.get_gravity();
    // rust: let inertia = f64::from(if water { 0.8_f32 } else { 0.99_f32 });
    // rust: self.velocity = Vec3::new(
    // rust: self.velocity.x * inertia,
    // rust: self.velocity.y * inertia,
    // rust: self.velocity.z * inertia,
    // rust: );
}
}
    // rust: let from = self.position;
    // rust: let to = Vec3::new(
    // rust: from.x + self.velocity.x,
    // rust: from.y + self.velocity.y,
    // rust: from.z + self.velocity.z,
    // rust: );
    // rust: let block = w.clip(from, to);
    // rust: let end = block.map_or(to, |b| b.0);
        // ProjectileUtil.getEntityHitResult: boxes inflated by 0.3 along the path.
    // rust: let mut best: Option<(Who, Vec3, f64)> = None;
    // rust: for (who, b) in w.targets() {
    // rust: if Some(*who) == self.owner && !self.left_owner {
    // rust: continue;
}
    // rust: let inflated = b.inflate(Vec3::new(0.3, 0.3, 0.3));
    // rust: if let Some(at) = inflated.clip(from, end) {
    // rust: let d = (at.x - from.x).powi(2) + (at.y - from.y).powi(2) + (at.z - from.z).powi(2);
    // rust: if best.is_none_or(|bb| d < bb.2) {
    // rust: best = Some((*who, at, d));
}
}
}
    // rust: if !self.left_owner {
            // Leave the owner once no target box (the owner's) contains us.
    // rust: let owner_box = w
    // rust: .targets()
    // rust: .iter()
    // rust: .find(|(who, _)| Some(*who) == self.owner)
    // rust: .map(|(_, b)| *b);
    // rust: self.left_owner = owner_box
    // rust: .is_none_or(|b| !b.inflate(Vec3::new(1.0, 1.0, 1.0)).contains(self.position));
}
        // LlamaSpit never discards on an entity: `onHitEntity` only hurts, so
        // the spit flies on through what it hit (its block hit discards).
    // rust: let spit = self.kind == ProjectileKind::LlamaSpit;
    // rust: let spit_hit = best
    // rust: .filter(|_| impact && spit)
    // rust: .map_or(Hit::None, |(who, at, _)| Hit::Entity { who, at });
    // rust: if impact
    // rust: && !spit
    // rust: && let Some((who, at, _)) = best
    // rust: {
    // rust: self.position = at;
    // rust: return (false, Hit::Entity { who, at });
}
    // rust: if impact
    // rust: && !(spit && best.is_some())
    // rust: && let Some((at, pos, face)) = block
    // rust: {
    // rust: self.position = at;
    // rust: return (false, Hit::Block { pos, at, face });
}
    // rust: if self.kind == ProjectileKind::LlamaSpit {
            // The 0.25 box touching anything but air discards the spit.
    // rust: let h = 0.125;
    // rust: let touches = [-h, h].iter().any(|dx| {
    // rust: [-h, h].iter().any(|dy| {
    // rust: [-h, h].iter().any(|dz| {
    // rust: !w.empty([
    // rust: (from.x + dx).floor() as i32,
    // rust: (from.y + dy + h).floor() as i32,
    // rust: (from.z + dz).floor() as i32,
    // rust: ])
    // rust: })
    // rust: })
    // rust: });
    // rust: if touches {
    // rust: return (false, Hit::None);
}
    // rust: self.position = to;
    // rust: self.velocity = Vec3::new(
    // rust: self.velocity.x * 0.99,
    // rust: self.velocity.y * 0.99 - self.get_gravity(),
    // rust: self.velocity.z * 0.99,
    // rust: );
    // rust: self.update_rotation();
    // rust: return (self.position.y > -128.0 && self.age < 6000, spit_hit);
}
    // rust: self.position = to;
    // rust: if !self.is_fireball() {
    // rust: self.update_rotation();
}
        // Entity.baseTick's updateFluidInteraction, after the move.
    // rust: self.touching_water = w.in_water(self.bounds());
    // rust: let alive =
    // rust: self.position.y > -128.0 && self.age < if self.is_fireball() { 1200 } else { 6000 };
    // rust: (alive, Hit::None)
}
    /// AbstractArrow.onHitEntity damage: ceil(speed * base) plus crit bonus.
pub fn arrow_damage(self: *Self, random: *mut impl RandomSource) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let ProjectileKind::Arrow {
    // rust: base_damage,
    // rust: critical,
    // rust: ..
    // rust: } = self.kind
    // rust: else {
    // rust: return 0.0;
}
    // rust: let v = self.velocity;
    // rust: let speed = (v.x * v.x + v.y * v.y + v.z * v.z).sqrt();
    // rust: let mut damage = (speed * base_damage).clamp(0.0, f64::from(i32::MAX)).ceil() as i32;
    // rust: if critical {
    // rust: let bonus = random.next_int_bound(damage / 2 + 2).unwrap_or(0);
    // rust: damage = damage.saturating_add(bonus);
}
    // rust: damage as f32
}
    /// the item a thrown potion or a mod's type is drawn as with its model
    /// (`ThrownItemRenderer`): the potion stack itself, or the type's item.
pub fn drawn_item(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match &self.kind {
    // rust: ProjectileKind::Potion(stack, _) => Some((**stack).clone()),
    // rust: ProjectileKind::ExperienceBottle => Some(crate::items::ItemStack::new(
    // rust: "minecraft:experience_bottle",
    // rust: 1,
    // rust: )),
    // rust: ProjectileKind::Thrown(t) => Some(crate::items::ItemStack::new(t.item, 1)),
    // rust: _ => None,
}
}
    /// The item sprite drawn for thrown projectiles (ThrownItemRenderer).
pub fn item_sprite(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match &self.kind {
    // rust: ProjectileKind::Snowball => "item/snowball",
    // rust: ProjectileKind::Egg => "item/egg",
    // rust: ProjectileKind::EnderPearl => "item/ender_pearl",
    // rust: ProjectileKind::SmallFireball | ProjectileKind::LargeFireball { .. } => {
    // rust: "item/fire_charge"
}
    // rust: ProjectileKind::Potion(stack, _) => potion_sprite(&stack.item),
    // rust: ProjectileKind::ExperienceBottle => "item/experience_bottle",
    // rust: ProjectileKind::LlamaSpit => "entity/llama/llama_spit",
            // Drawn as `WindChargeModel` and `ShulkerBulletModel` by the game.
    // rust: ProjectileKind::WindCharge
    // rust: | ProjectileKind::BreezeWindCharge
    // rust: | ProjectileKind::ShulkerBullet { .. } => return None,
    // rust: ProjectileKind::WitherSkull { dangerous: false } => "entity/wither/wither",
    // rust: ProjectileKind::WitherSkull { dangerous: true } => "entity/wither/wither_invulnerable",
            // Drawn as their models by the game.
    // rust: ProjectileKind::Arrow { .. } | ProjectileKind::Trident | ProjectileKind::Thrown(_) => {
    // rust: return None;
}
    // rust: })
}
    /// `ThrownItemRenderer`'s scale for the kind: 3 for a large fireball,
    /// 0.75 for a small one, 1 for the rest.
pub fn sprite_scale(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.kind {
    // rust: ProjectileKind::LargeFireball { .. } => 3.0,
    // rust: ProjectileKind::SmallFireball => 0.75,
    // rust: _ => 1.0,
}
}
}
    // rust: mod tests {
//     use super::*;
//     use horizon_core::random::LegacyRandom;

pub const Empty = struct {};
    // rust: impl ProjectileWorld for Empty {
pub fn clip(self: *Self, _: Vec3, _: Vec3) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: None
}
pub fn in_water(self: *Self, _: Aabb) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: false
}
pub fn targets(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.0
}
}
pub fn first_tick_shoot_event_uses_base_tick_position_and_saved_flag() void {
}
    // rust: let w = Empty(vec![]);
    // rust: for kind in [ProjectileKind::Snowball, ProjectileKind::LlamaSpit] {
    // rust: let start = Vec3::new(0.0, 100.0, 0.0);
    // rust: let mut p = Projectile::new(kind.clone(), start, None);
    // rust: p.velocity = Vec3::new(1.0, 0.0, 0.0);
    // rust: p.tick(&w);
    // rust: let expected = if kind == ProjectileKind::LlamaSpit {
    // rust: start
    // rust: } else {
    // rust: p.position
}
    // rust: assert!(p.has_been_shot);
    // rust: assert_eq!(p.take_shoot_event(), Some(expected));
    // rust: assert_eq!(p.take_shoot_event(), None);
    // rust: p.tick(&w);
    // rust: assert_eq!(p.take_shoot_event(), None);
    // rust: let mut saved = Projectile::new(kind, start, None);
    // rust: saved.has_been_shot = true;
    // rust: saved.tick(&w);
    // rust: assert_eq!(saved.take_shoot_event(), None);
}
}

pub fn snowball_falls_with_throwable_gravity_and_drag() void {
}
    // rust: let mut p = Projectile::new(ProjectileKind::Snowball, Vec3::new(0.0, 100.0, 0.0), None);
    // rust: p.velocity = Vec3::new(1.0, 0.0, 0.0);
    // rust: let w = Empty(vec![]);
    // rust: p.tick(&w);
        // ThrowableProjectile: gravity before inertia, then move.
        // `getAirDrag` is 0.99F, widened to double: 0.9900000095367432.
    // rust: assert!((p.velocity.y - (-0.03 * 0.99)).abs() < 1e-9);
    // rust: assert!((p.position.x - f64::from(0.99_f32)).abs() < 1e-9);
}
    /// One fire block in the cell (0, 99, 0), open air around it: a throwable
    /// inside that cell is set alight, and one that has left it burns down.
pub const Fire = struct {
    targets: Vec<(Who,
    water: bool,
};
    // rust: impl ProjectileWorld for Fire {
pub fn clip(self: *Self, _: Vec3, _: Vec3) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: None
}
pub fn in_water(self: *Self, _: Aabb) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.water
}
pub fn targets(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.targets
}
pub fn ignites(self: *Self, p: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: p == [0, 99, 0]
}
}
    /// `ThrowableProjectile.tick` calls `applyEffectsFromBlocks`, so a snowball
    /// thrown through a fire block burns for `BaseFireBlock.fireIgnite`'s 160
    /// ticks and is drawn with the flame (`Entity.displayFireAnimation`). The
    /// port had no fire at all on a thrown projectile: `fire_ticks` stayed 0
    /// however long it sat in the flames (#7456).
pub fn a_snowball_in_a_fire_block_burns_and_the_fire_counts_down() void {
}
    // rust: let mut p = Projectile::new(ProjectileKind::Snowball, Vec3::new(0.5, 99.5, 0.5), None);
        // Falling slowly: it stays inside (0, 99, 0) for this tick.
    // rust: p.velocity = Vec3::ZERO;
    // rust: let w = Fire {
    // rust: targets: vec![],
    // rust: water: false,
}
    // rust: assert!(!p.on_fire());
    // rust: p.tick(&w);
        // Ignited for 160, then `Entity.baseTick`'s countdown for this tick.
    // rust: assert_eq!(p.fire_ticks, 159);
    // rust: assert!(p.on_fire());
        // Out of the flames, the rest of the 160 ticks burn down.
    // rust: let air = Empty(vec![]);
    // rust: p.position = Vec3::new(0.5, 120.0, 0.5);
    // rust: p.tick(&air);
    // rust: assert_eq!(p.fire_ticks, 158);
    // rust: for _ in 0..158 {
    // rust: p.tick(&air);
}
    // rust: assert_eq!(p.fire_ticks, 0, "the fire runs out");
    // rust: assert!(!p.on_fire());
        // Water puts it out at once: `Entity.baseTick`'s `isInWaterRainOrBubble`.
    // rust: let mut wet = Projectile::new(ProjectileKind::Snowball, Vec3::new(0.5, 99.5, 0.5), None);
    // rust: wet.velocity = Vec3::ZERO;
    // rust: wet.tick(&w);
    // rust: assert_eq!(wet.fire_ticks, 159);
    // rust: wet.tick(&Fire {
    // rust: targets: vec![],
    // rust: water: true,
    // rust: });
    // rust: assert_eq!(wet.fire_ticks, 0, "water puts the snowball out");
}
    /// A fireball is an `AbstractHurtingProjectile`: it does not apply the
    /// effects of the blocks it flies through, so the fire block leaves it cold.
pub fn a_fireball_is_not_ignited_by_a_fire_block() void {
}
    // rust: let mut p = Projectile::new(
    // rust: ProjectileKind::SmallFireball,
    // rust: Vec3::new(0.5, 99.5, 0.5),
    // rust: None,
    // rust: );
    // rust: p.velocity = Vec3::ZERO;
    // rust: p.tick(&Fire {
    // rust: targets: vec![],
    // rust: water: false,
    // rust: });
    // rust: assert_eq!(p.fire_ticks, 0);
}
pub fn throwables_in_water_leave_bubbles_behind_them() void {
}
    // rust: let mut p = Projectile::new(ProjectileKind::Snowball, Vec3::new(0.5, 60.0, 0.5), None);
    // rust: p.velocity = Vec3::new(1.0, 0.5, -2.0);
    // rust: assert_eq!(p.water_bubbles(), None);
    // rust: p.touching_water = true;
    // rust: let (at, speed) = p.water_bubbles().expect("a snowball in water");
    // rust: let expected_at = [0.25, 60.0 - 0.47 * 0.25, 1.0];
    // rust: let expected_speed = [1.0, 0.47, -2.0];
    // rust: for i in 0..3 {
    // rust: assert!((at[i] - expected_at[i]).abs() < 1e-12, "{at:?}");
    // rust: assert!((speed[i] - expected_speed[i]).abs() < 1e-12, "{speed:?}");
}
    // rust: let mut bottle = Projectile::new(
    // rust: ProjectileKind::ExperienceBottle,
    // rust: Vec3::new(0.5, 60.0, 0.5),
    // rust: None,
    // rust: );
    // rust: bottle.touching_water = true;
    // rust: let (_, speed) = bottle.water_bubbles().expect("a bottle in water");
    // rust: assert!((speed[1] + 0.07).abs() < 1e-12, "{speed:?}");
    // rust: for kind in [
    // rust: ProjectileKind::Arrow {
    // rust: base_damage: 2.0,
    // rust: critical: false,
    // rust: effect: None,
    // rust: },
    // rust: ProjectileKind::LlamaSpit,
    // rust: ] {
    // rust: let mut other = Projectile::new(kind, Vec3::new(0.5, 60.0, 0.5), None);
    // rust: other.touching_water = true;
    // rust: assert_eq!(other.water_bubbles(), None);
}
}
    /// `AbstractHurtingProjectile.applyInertia`: four bubbles on the motion
    /// the projectile already has, with no gravity taken off first.
pub fn hurting_projectiles_in_water_bubble_along_their_motion() void {
}
    // rust: let expected_at = [0.25, 59.875, 1.0];
    // rust: let expected_speed = [1.0, 0.5, -2.0];
    // rust: for kind in [
    // rust: ProjectileKind::SmallFireball,
    // rust: ProjectileKind::LargeFireball { power: 1 },
    // rust: ProjectileKind::WitherSkull { dangerous: true },
    // rust: ProjectileKind::WindCharge,
    // rust: ProjectileKind::BreezeWindCharge,
    // rust: ] {
    // rust: let label = format!("{kind:?}");
    // rust: let mut p = Projectile::new(kind, Vec3::new(0.5, 60.0, 0.5), None);
    // rust: p.velocity = Vec3::new(1.0, 0.5, -2.0);
    // rust: assert_eq!(p.water_bubbles(), None, "{label} in air leaves no trail");
    // rust: p.touching_water = true;
    // rust: let (at, speed) = p.water_bubbles().expect("bubbles in water");
    // rust: for i in 0..3 {
    // rust: assert!((at[i] - expected_at[i]).abs() < 1e-12, "{label} {at:?}");
    // rust: assert!(
    // rust: (speed[i] - expected_speed[i]).abs() < 1e-12,
    // rust: "{label} {speed:?}"
    // rust: );
}
}
}
    /// A wall of blocks across x = 1.
pub const Wall = struct {};
    // rust: impl ProjectileWorld for Wall {
pub fn clip(self: *Self, from: Vec3, to: Vec3) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (from.x < 1.0 && to.x >= 1.0)
    // rust: .then(|| (Vec3::new(1.0, from.y, from.z), [1, 100, 0], [-1, 0, 0]))
}
pub fn in_water(self: *Self, _: Aabb) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: false
}
pub fn targets(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.0
}
}
    /// Open air inside a border from x, z = -4.5 to 5.5 (`/worldborder set
    /// 10` centred on 0.5, 0.5).
pub const BORDER: [f64; 4] = [-4.5, -4.5, 5.5, 5.5];
    /// `WorldBorder.clampVec3ToBound`'s far-edge inset, the float 1.0E-5F as
    /// the class file holds it.
pub const INSET: f64 = 9.999999747378752E-6;
pub const Bordered = struct {};
    // rust: impl ProjectileWorld for Bordered {
pub fn clip(self: *Self, from: Vec3, to: Vec3) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: clip_including_border(None, from, to, BORDER)
}
pub fn in_water(self: *Self, _: Aabb) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: false
}
pub fn targets(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.0
}
}
pub fn a_pearl_thrown_at_the_world_border_stops_on_it() void {
}
    // rust: let mut p = Projectile::new(
    // rust: ProjectileKind::EnderPearl,
    // rust: Vec3::new(3.5, 100.0, 0.5),
    // rust: Some(Who::Player),
    // rust: );
    // rust: (p.left_owner, p.velocity) = (true, Vec3::new(3.0, 0.0, 0.0));
    // rust: let (keep, hit) = p.tick(&Bordered(vec![]));
        // It would end at x = 3.5 + 3 * 0.99F = 6.47, past maxX 5.5: the hit
        // is on the border, 1.0E-5F inside it, facing east (+x), at the
        // height it reached (100 - 0.03 * 0.99F).
    // rust: let at = Vec3::new(5.5 - INSET, 100.0 - 0.03 * f64::from(0.99_f32), 0.5);
    // rust: assert!(!keep, "ThrownEnderpearl.onHit discards the pearl");
    // rust: let Hit::Block {
    // rust: pos,
    // rust: at: hit_at,
    // rust: face,
    // rust: } = hit
    // rust: else {
    // rust: panic!("no border hit: {hit:?}");
}
    // rust: assert!((hit_at.x - at.x).abs() < 1e-12, "{hit_at:?}");
    // rust: assert!((hit_at.y - at.y).abs() < 1e-9, "{hit_at:?}");
    // rust: assert_eq!(hit_at.z, 0.5);
    // rust: assert_eq!((pos, face), ([5, 99, 0], [1, 0, 0]));
    // rust: assert_eq!(p.position, hit_at, "the pearl stays where it hit");
        // It teleports its owner to where it started that tick (oldPosition),
        // inside the border.
    // rust: assert_eq!(p.previous, Vec3::new(3.5, 100.0, 0.5));
}
pub fn the_border_clamps_each_axis_and_faces_the_travel() void {
}
        // Out across the near edge of z: minZ is kept as is, facing north.
    // rust: let from = Vec3::new(0.5, 70.0, -4.0);
    // rust: let hit = clip_including_border(None, from, Vec3::new(0.7, 70.0, -6.0), BORDER);
    // rust: assert_eq!(
    // rust: hit,
    // rust: Some((Vec3::new(0.7, 70.0, -4.5), [0, 70, -5], [0, 0, -1]))
    // rust: );
        // Ending on maxX itself is outside (isWithinBounds: x < maxX).
    // rust: let hit = clip_including_border(None, from, Vec3::new(5.5, 70.0, -4.0), BORDER)
    // rust: .expect("a border hit");
    // rust: assert_eq!(hit.0.x, 5.5 - INSET);
    // rust: assert_eq!(hit.2, [1, 0, 0]);
}
pub fn the_border_leaves_inner_hits_and_rays_from_outside_alone() void {
}
    // rust: let inside = Vec3::new(0.5, 70.0, 0.5);
        // A miss that stays inside.
    // rust: assert_eq!(
    // rust: clip_including_border(None, inside, Vec3::new(5.0, 70.0, 5.0), BORDER),
    // rust: None
    // rust: );
        // A block struck before the border.
    // rust: let block = Some((Vec3::new(2.0, 70.0, 0.5), [2, 70, 0], [-1, 0, 0]));
    // rust: assert_eq!(
    // rust: clip_including_border(block, inside, Vec3::new(9.0, 70.0, 0.5), BORDER),
    // rust: block
    // rust: );
        // A ray that starts outside the border is not stopped by it.
    // rust: let outside = Vec3::new(7.0, 70.0, 0.5);
    // rust: assert_eq!(
    // rust: clip_including_border(None, outside, Vec3::new(9.0, 70.0, 0.5), BORDER),
    // rust: None
    // rust: );
}
pub fn thrown(kind: ProjectileKind) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut p = Projectile::new(kind, Vec3::new(0.0, 100.0, 0.0), Some(Who::Player));
    // rust: (p.left_owner, p.velocity) = (true, Vec3::new(1.5, 0.0, 0.0));
    // rust: p
}
pub fn a_tick_through_a_wall_flies_the_whole_way_and_hits_nothing() void {
}
    // rust: for kind in [
    // rust: ProjectileKind::Snowball,
    // rust: ProjectileKind::SmallFireball,
    // rust: ProjectileKind::LlamaSpit,
    // rust: ] {
    // rust: let wall = Wall(Vec::new());
    // rust: let mut hit = thrown(kind.clone());
    // rust: let (keep, hits) = hit.tick(&wall);
    // rust: assert!(
    // rust: !keep
    // rust: && matches!(
    // rust: hits,
    // rust: Hit::Block {
    // rust: pos: [1, 100, 0],
    // rust: ..
}
    // rust: )
    // rust: );
    // rust: assert_eq!(hit.position.x, 1.0);
            // The same tick, canceled: on, as in open air.
    // rust: let mut through = thrown(kind.clone());
    // rust: let mut open = thrown(kind);
    // rust: let (kept, none) = through.tick_through(&wall);
    // rust: assert_eq!(none, Hit::None);
    // rust: let _ = open.tick(&Empty(Vec::new()));
    // rust: assert_eq!(
    // rust: (through.position, through.velocity),
    // rust: (open.position, open.velocity)
    // rust: );
    // rust: assert!(kept);
}
}
pub fn a_tick_through_an_entity_does_not_hit_it() void {
}
    // rust: let pig = Aabb::new(Vec3::new(1.0, 99.5, -0.5), Vec3::new(2.0, 100.5, 0.5));
    // rust: let world = Empty(vec![(Who::Mob(7), pig)]);
    // rust: let mut hit = thrown(ProjectileKind::EnderPearl);
    // rust: assert!(matches!(
    // rust: hit.tick(&world),
    // rust: (
    // rust: false,
    // rust: Hit::Entity {
    // rust: who: Who::Mob(7),
    // rust: ..
}
    // rust: )
    // rust: ));
    // rust: let mut through = thrown(ProjectileKind::EnderPearl);
    // rust: let (keep, none) = through.tick_through(&world);
    // rust: assert!(keep && none == Hit::None);
        // Gravity and drag of the tick, then the whole of its motion.
    // rust: assert!((through.position.x - 1.5 * f64::from(0.99_f32)).abs() < 1e-9);
}
pub fn a_snowball_with_no_gravity_stays_where_it_was_summoned() void {
}
        // Entity.getGravity is 0 with NoGravity: at rest, it never moves.
    // rust: let start = Vec3::new(0.5, 100.0, 0.5);
    // rust: let mut p = Projectile::new(ProjectileKind::Snowball, start, None);
    // rust: p.no_gravity = true;
    // rust: let w = Empty(vec![]);
    // rust: for _ in 0..20 {
    // rust: p.tick(&w);
}
    // rust: assert_eq!((p.position, p.velocity), (start, Vec3::ZERO));
}
pub fn a_mod_thrown_type_flies_tick_for_tick_as_a_snowball() void {
}
    // rust: static BOLT: ThrownType = ThrownType {
    // rust: id: "ruby:bolt",
    // rust: item: "ruby:gem",
    // rust: damage: 2.0,
}
    // rust: let start = Vec3::new(0.0, 100.0, 0.0);
    // rust: let mut snowball = Projectile::new(ProjectileKind::Snowball, start, None);
    // rust: let mut bolt = Projectile::new(ProjectileKind::Thrown(&BOLT), start, None);
    // rust: for p in [&mut snowball, &mut bolt] {
    // rust: p.velocity = Vec3::new(0.3, 0.4, -0.2);
}
    // rust: let air = Empty(Vec::new());
    // rust: for _ in 0..40 {
    // rust: assert_eq!(snowball.tick(&air), bolt.tick(&air));
    // rust: assert_eq!(
    // rust: (snowball.position, snowball.velocity, snowball.bounds()),
    // rust: (bolt.position, bolt.velocity, bolt.bounds())
    // rust: );
}
    // rust: assert_eq!(bolt.kind.id(), "ruby:bolt");
    // rust: assert_eq!(bolt.drawn_item().unwrap().item.as_ref(), "ruby:gem");
        // thrown at a mob, it hits it and is gone, as a snowball is.
    // rust: let mut bolt = Projectile::new(ProjectileKind::Thrown(&BOLT), start, Some(Who::Player));
    // rust: (bolt.left_owner, bolt.velocity) = (true, Vec3::new(1.5, 0.0, 0.0));
    // rust: let pig = Aabb::new(Vec3::new(1.0, 99.5, -0.5), Vec3::new(2.0, 100.5, 0.5));
    // rust: let (keep, hit) = bolt.tick(&Empty(vec![(Who::Mob(7), pig)]));
    // rust: assert!(!keep);
    // rust: assert!(matches!(
    // rust: hit,
    // rust: Hit::Entity {
    // rust: who: Who::Mob(7),
    // rust: ..
}
    // rust: ));
}

    /// the registry is set once per process: every test registers the same.
pub fn mod_thrown_types_are_found_by_id_and_item_once_registered() void {
}
    // rust: register_test_types();
    // rust: assert!(!register_thrown_types([(
    // rust: "ruby:late".into(),
    // rust: "ruby:x".into(),
    // rust: 1.0
    // rust: )]));
    // rust: let bolt = thrown_type("ruby:bolt").unwrap();
    // rust: assert_eq!((bolt.item, bolt.damage), ("ruby:gem", 2.0));
    // rust: assert_eq!(thrown_by_item("ruby:gem"), Some(bolt));
    // rust: assert!(
    // rust: thrown_type("ruby:late").is_none() && thrown_by_item("minecraft:snowball").is_none()
    // rust: );
        // its template's tracking settings, not the builder defaults.
    // rust: let settings = crate::lan::tracking::settings;
    // rust: assert_eq!(settings("ruby:bolt"), settings("minecraft:snowball"));
    // rust: assert_eq!(settings("ruby:late"), (5, 3, true));
}

    /// `ShulkerBullet.tick` with no target: `applyGravity` (0.04, none under
    /// NoGravity), then the move, no drag. 20 ticks from y 110 fall 8.4.
pub fn a_shulker_bullet_without_a_target_falls_unless_no_gravity() void {
}
    // rust: let bullet = || {
    // rust: Projectile::new(
    // rust: ProjectileKind::ShulkerBullet {
    // rust: target: None,
    // rust: dir: None,
    // rust: steps: 0,
    // rust: delta: [0.0; 3],
    // rust: seed: 0,
    // rust: },
    // rust: Vec3::new(0.5, 110.0, 0.5),
    // rust: None,
    // rust: )
}
    // rust: let w = Empty(vec![]);
    // rust: let mut falling = bullet();
    // rust: let mut held = bullet();
    // rust: held.no_gravity = true;
    // rust: for _ in 0..20 {
    // rust: falling.tick(&w);
    // rust: held.tick(&w);
}
    // rust: assert!(
    // rust: (falling.position.y - 101.6).abs() < 1e-6,
    // rust: "{}",
    // rust: falling.position.y
    // rust: );
    // rust: assert_eq!(held.position, Vec3::new(0.5, 110.0, 0.5));
}
pub fn llama_spit_moves_first_then_drags_and_falls() void {
}
    // rust: let mut p = Projectile::new(ProjectileKind::LlamaSpit, Vec3::new(0.0, 100.0, 0.0), None);
    // rust: p.velocity = Vec3::new(1.0, 0.0, 0.0);
    // rust: let w = Empty(vec![]);
    // rust: let (keep, _) = p.tick(&w);
    // rust: assert!(keep);
    // rust: assert!((p.position.x - 1.0).abs() < 1e-9);
    // rust: assert!((p.velocity.x - 0.99).abs() < 1e-9);
    // rust: assert!((p.velocity.y + 0.06).abs() < 1e-9);
}
pub fn arrow_damage_is_speed_times_base() void {
}
    // rust: let mut p = Projectile::new(
    // rust: ProjectileKind::Arrow {
    // rust: base_damage: 2.0,
    // rust: critical: false,
    // rust: effect: None,
    // rust: },
    // rust: Vec3::new(0.0, 100.0, 0.0),
    // rust: None,
    // rust: );
    // rust: p.velocity = Vec3::new(3.0, 0.0, 0.0);
    // rust: let mut r = LegacyRandom::new(1);
        // ceil(3 * 2) = 6 for a non-critical arrow.
    // rust: assert_eq!(p.arrow_damage(&mut r), 6.0);
}
pub fn fireball_accelerates_along_its_direction() void {
}
    // rust: let mut p = Projectile::fireball(
    // rust: ProjectileKind::SmallFireball,
    // rust: Vec3::new(0.0, 100.0, 0.0),
    // rust: None,
    // rust: [1.0, 0.0, 0.0],
    // rust: );
    // rust: let w = Empty(vec![]);
    // rust: p.tick(&w);
        // Fresh Java 26.3: (0.1 + 0.1) * (double) 0.95f.
    // rust: assert_eq!(p.velocity.x, 0.189_999_997_615_814_2);
}

    /// `Fireball.setItem` with `Fireball.defineSynchedData`'s default and
    /// `getItem`: a fireball is drawn as a fire charge until it is given
    /// another item, and it keeps a single one of it. A kind that is no
    /// `Fireball` (a wither skull, a snowball) has no item to set.
pub fn a_fireball_holds_one_of_the_item_it_is_given() void {
}
    // rust: let held = |p: &Projectile| {
    // rust: p.item
    // rust: .as_ref()
    // rust: .map(|i| (&*i.item, i.count))
    // rust: .map(|(i, n)| (i.to_string(), n))
}
    // rust: for kind in [
    // rust: ProjectileKind::LargeFireball { power: 1 },
    // rust: ProjectileKind::SmallFireball,
    // rust: ] {
    // rust: let mut p = Projectile::new(kind, Vec3::new(0.0, 100.0, 0.0), None);
    // rust: assert_eq!(
    // rust: held(&p),
    // rust: Some(("minecraft:fire_charge".to_owned(), 1)),
    // rust: "the default"
    // rust: );
    // rust: p.set_item(crate::items::ItemStack::new("minecraft:diamond", 5));
    // rust: assert_eq!(
    // rust: held(&p),
    // rust: Some(("minecraft:diamond".to_owned(), 1)),
    // rust: "copyWithCount(1)"
    // rust: );
            // `setItem` refuses an empty stack, either way of being empty, and
            // puts the default fire charge back.
    // rust: for empty in [
    // rust: crate::items::ItemStack::new("minecraft:air", 1),
    // rust: crate::items::ItemStack::new("minecraft:diamond", 0),
    // rust: ] {
    // rust: p.set_item(empty);
    // rust: assert_eq!(held(&p), Some(("minecraft:fire_charge".to_owned(), 1)));
}
}
    // rust: for kind in [
    // rust: ProjectileKind::WitherSkull { dangerous: false },
    // rust: ProjectileKind::Snowball,
    // rust: ] {
    // rust: let mut p = Projectile::new(kind, Vec3::new(0.0, 100.0, 0.0), None);
    // rust: assert_eq!(p.item, None);
    // rust: p.set_item(crate::items::ItemStack::new("minecraft:diamond", 1));
    // rust: assert_eq!(p.item, None, "no Fireball, no item");
}
}
    /// `ThrownItemRenderer`'s scale per entity type, which the item model a
    /// fireball is drawn as is scaled by: 3 for a fireball, 0.75 for a small
    /// one, 1 for the other kinds and their own renderers.
pub fn a_fireball_draws_at_thrice_or_three_quarters() void {
}
    // rust: let scale = |kind: ProjectileKind| {
    // rust: Projectile::new(kind, Vec3::new(0.0, 100.0, 0.0), None).sprite_scale()
}
    // rust: assert_eq!(scale(ProjectileKind::LargeFireball { power: 1 }), 3.0);
    // rust: assert_eq!(scale(ProjectileKind::SmallFireball), 0.75);
    // rust: assert_eq!(scale(ProjectileKind::Snowball), 1.0);
}
pub fn fireball_inertia_preserves_custom_acceleration() void {
}
    // rust: let mut p = Projectile::fireball(
    // rust: ProjectileKind::SmallFireball,
    // rust: Vec3::new(0.0, 100.0, 0.0),
    // rust: None,
    // rust: [1.0, 0.0, 0.0],
    // rust: );
        // A redirected projectile can carry a different acceleration power.
    // rust: p.acceleration = 0.2;
    // rust: p.tick(&Empty(vec![]));
    // rust: assert_eq!(p.velocity.x, 0.284_999_996_423_721_37);
    // rust: assert_eq!(p.position.x, 0.284_999_996_423_721_37);
}

pub fn hurting_inertia_widens_water_and_dangerous_skull_floats() void {
}
    // rust: for (kind, water, expected) in [
    // rust: (ProjectileKind::SmallFireball, true, 0.160_000_002_384_185_8),
    // rust: (
    // rust: ProjectileKind::WitherSkull { dangerous: true },
    // rust: false,
    // rust: 0.146_000_003_814_697_27,
    // rust: ),
    // rust: ] {
    // rust: let mut p = Projectile::new(kind, Vec3::ZERO, None);
    // rust: p.velocity = Vec3::new(0.1, 0.0, 0.0);
    // rust: p.acceleration = 0.1;
    // rust: p.apply_hurting_inertia(water);
    // rust: assert_eq!(p.velocity, Vec3::new(expected, 0.0, 0.0));
}
}

pub fn a_wind_charge_holds_its_speed_until_a_deflection_gives_it_power() void {
}
    // rust: let mut p = Projectile::new(ProjectileKind::WindCharge, Vec3::ZERO, None);
    // rust: p.velocity = Vec3::new(0.0, 1.5, 0.0);
    // rust: p.apply_hurting_inertia(false);
    // rust: assert_eq!(p.velocity, Vec3::new(0.0, 1.5, 0.0));
        // Inertia 1 in water too, and the power adds along the movement.
    // rust: p.acceleration = 0.1;
    // rust: p.apply_hurting_inertia(true);
    // rust: assert!((p.velocity.y - 1.6).abs() < 1e-12, "{p:?}");
}

pub fn ender_pearl_hits_a_wind_charge_box() void {
}
    // rust: let mut pearl = Projectile::new(
    // rust: ProjectileKind::EnderPearl,
    // rust: Vec3::new(0.0, 1.0, 0.0),
    // rust: Some(Who::Player),
    // rust: );
    // rust: pearl.left_owner = true;
    // rust: pearl.velocity = Vec3::new(2.0, 0.0, 0.0);
    // rust: let wind = Projectile::new(
    // rust: ProjectileKind::WindCharge,
    // rust: Vec3::new(0.6, 1.0, 0.0),
    // rust: Some(Who::Player),
    // rust: );
    // rust: let w = Empty(vec![(Who::Mob(1), wind.aabb())]);
    // rust: let (keep, hit) = pearl.tick(&w);
    // rust: assert!(!keep, "ThrownEnderpearl.onHit discards the pearl");
    // rust: assert!(
    // rust: matches!(
    // rust: hit,
    // rust: Hit::Entity {
    // rust: who: Who::Mob(1),
    // rust: ..
}
    // rust: ),
    // rust: "pearl collides with a pickable wind charge"
    // rust: );
}
}

    // rust: mod trail_tests {
//     use super::*;
//     use crate::particles::ParticleType;
pub fn arrow(critical: bool) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut p = Projectile::new(
    // rust: ProjectileKind::Arrow {
    // rust: base_damage: 2.0,
    // rust: critical,
    // rust: effect: None,
    // rust: },
    // rust: Vec3::new(1.0, 2.0, 3.0),
    // rust: None,
    // rust: );
    // rust: p.velocity = Vec3::new(4.0, 2.0, -1.0);
    // rust: p
}
pub fn critical_arrow_emits_four_native_streak_samples() void {
}
    // rust: let trail = arrow(true).arrow_trail(false);
    // rust: assert_eq!(trail.len(), 4);
    // rust: for (i, (ty, pos, speed)) in trail.iter().enumerate() {
    // rust: assert_eq!(*ty, ParticleType::Crit);
    // rust: assert_eq!(
    // rust: *pos,
    // rust: [1.0 + i as f64, 2.0 + i as f64 * 0.5, 3.0 - i as f64 * 0.25]
    // rust: );
    // rust: assert_eq!(*speed, [-4.0, -1.8, 1.0]);
}
}
pub fn submerged_arrow_emits_four_bubbles_after_water_inertia() void {
}
    // rust: let trail = arrow(false).arrow_trail(true);
    // rust: assert_eq!(trail.len(), 4);
    // rust: let drag = f64::from(0.6f32);
    // rust: for (ty, pos, speed) in trail {
    // rust: assert_eq!(ty, ParticleType::Bubble);
    // rust: assert_eq!(speed, [4.0 * drag, 2.0 * drag, -drag]);
    // rust: assert_eq!(pos, [1.0 - drag, 2.0 - drag * 0.5, 3.0 + drag * 0.25]);
}
}
pub fn ordinary_and_stuck_arrows_do_not_emit_critical_trails() void {
}
    // rust: assert!(arrow(false).arrow_trail(false).is_empty());
    // rust: let mut p = arrow(true);
    // rust: p.stuck = true;
    // rust: assert!(p.arrow_trail(true).is_empty());
}
}
    // rust: mod pearl_owner_tests {
//     use super::*;

    /// `ThrownEnderpearl.isAllowedToTeleportOwner` in the pearl's own
    /// dimension: only a living, awake owner takes the pearl. Vanilla's
    /// `onHit` discards the pearl (and skips the 5 damage) otherwise.
pub fn a_dead_or_sleeping_owner_cannot_take_its_pearl() void {
}
    // rust: assert!(owner_can_take_pearl(true, false), "alive and awake");
    // rust: assert!(!owner_can_take_pearl(false, false), "a dead owner");
    // rust: assert!(!owner_can_take_pearl(true, true), "a sleeping owner");
    // rust: assert!(!owner_can_take_pearl(false, true), "dead in bed");
}
}
    // rust: mod render_light_tests {
//     use super::*;

pub fn shot(kind: ProjectileKind) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Projectile::new(kind, Vec3::new(0.5, 64.0, 0.5), None)
}

    /// `EntityRenderer.getBlockLightLevel` and the two overrides: a shulker
    /// bullet and a fireball are 15 wherever they fly, anything on fire is 15
    /// by the base class, and an ordinary arrow keeps the level's light.
pub fn only_the_full_bright_projectiles_override_the_block_light() void {
}
    // rust: let bullet = shot(ProjectileKind::ShulkerBullet {
    // rust: target: None,
    // rust: dir: None,
    // rust: steps: 0,
    // rust: delta: [0.0; 3],
    // rust: seed: 0,
    // rust: });
    // rust: assert_eq!(bullet.block_light_override(), Some(15));
    // rust: assert_eq!(
    // rust: shot(ProjectileKind::SmallFireball).block_light_override(),
    // rust: Some(15)
    // rust: );
    // rust: assert_eq!(
    // rust: shot(ProjectileKind::WitherSkull { dangerous: false }).block_light_override(),
    // rust: Some(15)
    // rust: );
    // rust: let mut arrow = shot(ProjectileKind::Arrow {
    // rust: base_damage: 2.0,
    // rust: critical: false,
    // rust: effect: None,
    // rust: });
    // rust: assert_eq!(arrow.block_light_override(), None);
        // `Entity.isOnFire` on any projectile is 15, whatever its kind.
    // rust: arrow.ignite_for_ticks(100);
    // rust: assert_eq!(arrow.block_light_override(), Some(15));
    // rust: let mut snowball = shot(ProjectileKind::Snowball);
    // rust: assert_eq!(snowball.block_light_override(), None);
    // rust: snowball.ignite_for_ticks(1);
    // rust: assert_eq!(snowball.block_light_override(), Some(15));
}

    /// `Entity.getLightProbePosition` is the eye position, so an arrow lying
    /// in the top eighth of a block is lit by the block above it.
pub fn a_projectile_is_lit_from_the_block_its_eye_is_in() void {
}
    // rust: let mut arrow = shot(ProjectileKind::Arrow {
    // rust: base_damage: 2.0,
    // rust: critical: false,
    // rust: effect: None,
    // rust: });
    // rust: arrow.position = Vec3::new(0.5, 64.9, 0.5);
    // rust: assert_eq!(arrow.light_probe_y().floor(), 65.0);
    // rust: assert_eq!(arrow.position.y.floor(), 64.0);
        // A wind charge's entity type declares no eye height, so it keeps its feet.
    // rust: let mut wind = shot(ProjectileKind::WindCharge);
    // rust: wind.position = Vec3::new(0.5, 64.9, 0.5);
    // rust: assert_eq!(wind.light_probe_y(), 64.9);
        // A snowball's box is a quarter block: the eye is 0.2125 up.
    // rust: let mut ball = shot(ProjectileKind::Snowball);
    // rust: ball.position = Vec3::new(0.5, 64.8, 0.5);
    // rust: assert!((ball.light_probe_y() - 64.8 - 0.85 * 0.25).abs() < 1e-6);
}
}
    // rust: crate::impl_joined!(Projectile);
