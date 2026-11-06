//! Transpiled from Horizon Rust crate
package horizon_client_entity

import "core:fmt"
import "core:mem"
import "core:math"

// `Entity`: what every kind in the game's entity lists answers to, so a system
// can treat them alike and only write down where vanilla's kinds differ.
//
// Default methods follow vanilla's `Entity`; a kind overrides one only where
// its vanilla class does. [`EntityHandle`] names one entity by list and index,
// so a system can walk handles and reach each entity after other borrows of
// `Game` end. The walk allocates nothing and dispatch is static: hot paths pay
// no vtable. A new kind is one line in `entity_lists!` and one `impl Entity`.

// use super::commands::Target;
// use super::persist::ChunkKey;
// use super::{FallingBlock, Game};
// use super::{
    // rust: boats::Boat, fireworks::Rocket, minecarts::Minecart, tnt::PrimedTnt, trident::ThrownTrident,
}
// use horizon_client::entities::{
    // rust: ArmorStand, Cushion, ExperienceOrb, ItemEntity, ItemFrame, Painting,
}
// use horizon_client::entity_rules::EntityRules;
// use horizon_client::join_seq::JoinSeq;
// use horizon_client::join_seq::Joined as _;
// use horizon_client::mobs::{Mob, Species};
// use horizon_client::projectiles::Projectile;
// use horizon_core::geometry::{Aabb, Direction, Vec3};
// use horizon_core::position::BlockPos;
// use horizon_world::nbt::Tag;
// use horizon_world::{level::data::PushReaction, piston_push};
// use std::borrow::Cow;
// use std::collections::{HashMap, HashSet};

// What `Entity.thunderHit` does to a kind: it sets the entity on fire and
// calls `hurtServer(lightning_bolt, 5)`, so a kind whose `hurtServer` does
// nothing (projectiles, rockets, TNT, falling blocks, armor stands here) stays
// untouched. A strike runs the stages in this order.
    // rust: pub(super) enum ThunderHit {
    // rust: Untouched,
    // Burns, takes 5 damage, and the kinds with their own `thunderHit` change.
    // rust: Mob,
    // `VehicleEntity.hurtServer`: 5 x 10 is over the 40 that destroys it.
    // rust: Vehicle,
    // `ExperienceOrb.hurtServer`: 5 damage off 5 health.
    // rust: Orb,
    // `ItemEntity.hurtServer`: burns up unless fire resistant.
    // rust: Item,
}

// What a blast knows about itself, for the entities in its reach to answer.
    // rust: pub(super) struct Blast {
    // `VehicleEntity.ignoreExplosion`: a mob's blast, with mob griefing off.
    // rust: pub(super) vehicles_ignore: bool,
    // `ItemEntity.ignoreExplosion` (`shouldAffectBlocklikeEntities`).
    // rust: pub(super) items_ignore: bool,
    // The exploding mob, which `getEntities(source, box)` leaves out.
    // rust: pub(super) spared: Option<u32>,
}

    // rust: pub(super) trait Entity: EntityRules {
    // `Entity.getId`.
id :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
position :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
position_mut :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // `Entity.getDeltaMovement`.
velocity :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
velocity_mut :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // `Entity.getYRot` and `getXRot`: yaw, pitch.
rotation :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // The rotation part of `Entity.teleportSetPosition`: `setYRot`, `setXRot`
    // (clamped to -90..90), then `setOldRot`.
set_rotation :: proc(self: ^Self, rotation: [f32; 2]) {
}
bounds :: proc(self: ^Self) -> A {
    // Ported from Horizon
    return {}
}
    // What a selector finds this entity as (`@e`), or `None` for one it cannot
    // name yet. Required, so a new kind states which.
selector_target :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // The entity type id a native mod's join hook names (`minecraft:oak_boat`).
native_type :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // Saves entity `index` of this kind into its chunk's entity list: the
    // chunk and the NBT when it lies in `keys` and is saved with its chunk.
    // Required, so a new kind states how it saves.
    // rust: fn save_nbt(
    // rust: game: &mut Game<'_>,
    // rust: index: usize,
    // rust: keys: &HashSet<ChunkKey>,
    // rust: ) -> Option<(ChunkKey, Tag)>;
    // Loads a saved entity whose type id is `kind` as this kind and joins it to
    // the world, or hands `tag` back when `kind` is not one this kind loads.
    // Required, so a new kind states how it loads: it cannot be saved and then
    // dropped silently on the way back in.
    // rust: fn load_nbt(
    // rust: game: &mut Game<'_>,
    // rust: kind: &str,
    // rust: uuid: Option<[i32; 4]>,
    // rust: player_uuid: Option<[i32; 4]>,
    // rust: tag: Tag,
    // rust: ) -> Result<(), Tag>;

on_ground :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
    // `Entity.maxUpStep`.
get_step_height :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 0.0
}
is_alive :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
    // `Entity.isRemoved`.
is_removed :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
    // `instanceof LivingEntity`.
is_living :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
    // `Entity.isIgnoringBlockTriggers`.
is_ignoring_block_triggers :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
    // Whether it presses plates and tripwires: `getEntitiesOfClass` skips
    // removed entities, and the block's predicate skips the ones above.
triggers_blocks :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.is_removed() && !self.is_ignoring_block_triggers()
}
    // Whether `tick_blocks` sends the blocks in its box to `entityInside`
    // (`applyEffectsFromBlocks`). A kind that function sweeps another way, or
    // whose tick skips that step, says no.
sweeps_blocks_inside :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
    // `Entity.thunderHit` for this kind.
thunder_hit :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: ThunderHit::Untouched
}
    // The box a lightning strike tests against.
thunder_bounds :: proc(self: ^Self) -> A {
    // Ported from Horizon
    return {}
}
    // rust: self.bounds()
}
    // `Entity.ignoreExplosion`: the blast neither hurts nor pushes it. Also
    // answers for what `getEntities(source, box)` never lists: the exploding
    // mob, and the dead.
ignores_explosion :: proc(self: ^Self, _blast: ^Blast) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
    // Whether a burst of wind moves it: what `Entity.push` moves, unless the
    // kind says otherwise.
pushed_by_wind :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.pushed_by_explosion()
}
    // Whether `Entity.push` moves it. An arrow in the ground, a wind charge and
    // an armour stand (`explosion_breaks_decorations` takes those) stay put.
pushed_by_explosion :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
    // The box the blast casts its rays at: `getSeenPercent`.
explosion_box :: proc(self: ^Self) -> A {
    // Ported from Horizon
    return {}
}
    // rust: self.bounds()
}
    // How far above its feet `pushFromExplosion` aims: `getEyeHeight`, which
    // defaults to 0.85 of the box.
explosion_eye_height :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let b = self.explosion_box();
    // rust: f64::from((b.max_position().y - b.min_position().y) as f32 * 0.85f32)
}
    // Whether this kind can still be waiting for its tick when a projectile
    // ticks, though it joined before it (orbs, falling blocks, primed TNT: they
    // tick between the batches, `game/ordered_tick.rs`).
ticks_after_projectiles :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
    // `Entity.push` with the explosion's knockback.
push_from_explosion :: proc(self: ^Self, push: Vec3) {
}
    // rust: let v = self.velocity_mut();
    // rust: *v = Vec3::new(v.x + push.x, v.y + push.y, v.z + push.z);
}
    // `Entity.isSupportedBy`.
is_supported_by :: proc(self: ^Self, _pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
    // `Entity.getEyeY`, where `updateFluidHeightAndDoFluidPushing` reads the
    // eye's fluid; the top of the box unless a kind sets it.
fluid_eye_y :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.bounds().max_position().y
}
    // `Entity.updateFluidHeightAndDoFluidPushing`: its water and lava heights
    // (`(0, 0)` for a kind that is not pushed by fluid), and the current of
    // each fluid added to its velocity. One body for every kind.
    // rust: fn push_by_fluid(
    // rust: &mut self,
    // rust: world: &horizon_client::world::World,
    // rust: fluids: &horizon_client::motion::FluidResources,
    // rust: ) -> (f64, f64) {
    // rust: if !self.is_pushed_by_fluid() {
    // rust: return (0.0, 0.0);
}
    // rust: let (bounds, at, eye) = (self.bounds(), self.position(), self.fluid_eye_y());
    // rust: horizon_client::entities::update_entity_fluids(
    // rust: bounds,
    // rust: at,
    // rust: eye,
    // rust: self.velocity_mut(),
    // rust: world,
    // rust: fluids,
    // rust: )
}
    // `BubbleColumnBlock.entityInside` through `applyEffectsFromBlocks`: a
    // column lifts or drags every kind alike.
    // rust: fn push_by_bubble_column(
    // rust: &mut self,
    // rust: world: &horizon_client::world::World,
    // rust: registry: &horizon_world::registry::BlockRegistry,
    // rust: facts: &horizon_client::blocks::BlockFacts,
    // rust: collision: &horizon_world::block_collision::BlockCollisionRegistry<'_>,
    // rust: ) -> bool {
    // rust: self.push_by_bubble_column_over(world, registry, facts, collision, |_| {})
}
    // [`Entity::push_by_bubble_column`], telling `surface` the position of
    // each column block it lies in (for the bubbles at the top).
    // rust: fn push_by_bubble_column_over(
    // rust: &mut self,
    // rust: world: &horizon_client::world::World,
    // rust: registry: &horizon_world::registry::BlockRegistry,
    // rust: facts: &horizon_client::blocks::BlockFacts,
    // rust: collision: &horizon_world::block_collision::BlockCollisionRegistry<'_>,
    // rust: surface: impl FnMut(BlockPos),
    // rust: ) -> bool {
    // rust: let bounds = self.bounds();
    // rust: horizon_client::motion::bubble_column_push_over(
    // rust: world,
    // rust: registry,
    // rust: facts,
    // rust: collision,
    // rust: bounds,
    // rust: self.velocity_mut(),
    // rust: surface,
    // rust: )
}
    // `Entity.getPistonPushReaction`.
get_piston_push_reaction :: proc(self: ^Self) -> P {
    // Ported from Horizon
    return {}
}
    // rust: PushReaction::PushPull
}
    // Width and height of the box a portal sweep follows, or None for a kind
    // the game does not carry through portals (so far armor stands and
    // falling blocks; fishing hooks are off the walk, and
    // `FishingHook.canUsePortal` is false in vanilla).
portal_size :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}
    // `Entity.canUsePortal(false)` for a kind in `portal_size`. A kind that
    // cannot stays tracked, so its cooldown and process run out.
can_use_portal :: proc(self: ^Self, _game: ^Game<'_>) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
    // A boat or minecart: the kinds whose portal pass opens the tick, before
    // they move (`AbstractMinecart.tick` handles its portal first).
is_vehicle :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
    // Where it stood at the start of its tick, for the kinds that store it
    // (None: `portals.before` has it).
portal_from :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}
    // Whether this tick's movement can have entered a portal block: a stuck
    // arrow or a trident in the ground that did not move enters none.
portal_sweeps :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
    // `Entity.move(MoverType.PISTON, …)` once the movement is resolved.
move_by_piston :: proc(self: ^Self, movement: Vec3) {
}
    // rust: let position = self.position_mut();
    // rust: *position = position.add_vector(movement);
}
    // `PistonMovingBlockEntity.causeBounce`: a slime block sets the velocity
    // along the movement axis.
piston_slime_bounce :: proc(self: ^Self, movement: Direction) {
}
    // rust: let velocity = self.velocity_mut();
    // rust: *velocity = piston_push::bounce_velocity(movement, *velocity);
}
}

// Bounds and identity needed by the render occlusion culler. Moving renderers
// use interpolated entity bounds; attached entities use their own world bounds.
    // rust: pub(super) trait RenderEntityBounds {
render_id :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
render_bounds :: proc(self: ^Self, alpha: f64) -> A {
    // Ported from Horizon
    return {}
}
render_glowing :: proc(self: ^Self, game: ^Game<'_>) -> b {
    // Ported from Horizon
    return {}
}
    // rust: game.entity_glowing(self.render_id())
}
}

    // rust: impl RenderEntityBounds for Mob {
render_id :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.id
}

render_bounds :: proc(self: ^Self, alpha: f64) -> A {
    // Ported from Horizon
    return {}
}
        // Keep models with large independent appendages on the old envelope:
        // their tentacles and wings can extend several blocks past the entity
        // dimensions. Equipment and custom rendering bypass this pre-check at
        // the call site.
    // rust: let (width, height, _) = self.awake_dims();
    // rust: let at = self.previous.lerp(self.position, f64::from(alpha as f32));
    // rust: if matches!(
    // rust: self.species(),
    // rust: Species::Guardian | Species::ElderGuardian | Species::Phantom
    // rust: ) {
    // rust: let radius = width.max(height) * 2.5 + 3.0;
    // rust: return Aabb::of_size(at, Vec3::new(radius * 2.0, radius * 2.0, radius * 2.0));
}

        // Vanilla's ordinary models can rotate their head, limbs and death
        // pose beyond the collision box. This envelope covers those poses while
        // remaining close to the rendered mesh for the common upright mobs.
        // A few quadruped death and riding poses reach several blocks past
        // their standing width. Keep a bounded fallback radius for ordinary
        // models while still shrinking the common pig/zombie envelope below
        // the old five-block radius.
    // rust: let horizontal = (width * 2.0).max(height * 1.5).max(3.5);
    // rust: let vertical = height * 3.0 + 0.5;
    // rust: Aabb::new(
    // rust: at.subtract(Vec3::new(horizontal, vertical, horizontal)),
    // rust: at.add_vector(Vec3::new(horizontal, vertical, horizontal)),
    // rust: )
}

render_glowing :: proc(self: ^Self, _game: ^Game<'_>) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.is_currently_glowing()
}
}

    // rust: impl RenderEntityBounds for ArmorStand {
render_id :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.id
}

render_bounds :: proc(self: ^Self, alpha: f64) -> A {
    // Ported from Horizon
    return {}
}
    // rust: let at = self.previous.lerp(self.position, alpha);
        // ArmorStandRenderer poses the limbs, then attaches hand items, head
        // items, armour and folded elytra. Those can extend well beyond the
        // 0.5 x 1.975 collision box (especially raised arms and head banners).
        // This axis-aligned envelope contains every vanilla pose while staying
        // independent of the stand's yaw and partial-tick rotation.
    // rust: let scale = if self.small { 0.5 } else { 1.0 };
    // rust: let equipped = self.equipment.iter().any(Option::is_some);
    // rust: let horizontal = if equipped { 2.0 } else { 1.5 * scale };
    // rust: let lower = if equipped { -1.0 } else { -0.5 * scale };
    // rust: let upper = 3.5 * scale
    // rust: + if self.equipment[5].is_some() {
    // rust: 1.5
    // rust: } else {
    // rust: 0.0
}
    // rust: Aabb::new(
    // rust: at.subtract(Vec3::new(horizontal, -lower, horizontal)),
    // rust: at.add_vector(Vec3::new(horizontal, upper, horizontal)),
    // rust: )
}
}

    // rust: impl RenderEntityBounds for ItemEntity {
render_id :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.id
}

render_bounds :: proc(self: ^Self, alpha: f64) -> A {
    // Ported from Horizon
    return {}
}
    // rust: let at = self.previous.lerp(self.position, alpha);
        // DroppedItemRenderer bobs, spins, and fans out up to five item copies.
        // The draw path uses the resolved model's exact posed extents; this
        // fallback envelope also covers the largest vanilla ground item.
    // rust: Aabb::new(
    // rust: at.subtract(Vec3::new(0.75, 0.1, 0.75)),
    // rust: at.add_vector(Vec3::new(0.75, 1.0, 0.75)),
    // rust: )
}
}

    // rust: impl RenderEntityBounds for Boat {
render_id :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.id
}

render_bounds :: proc(self: ^Self, alpha: f64) -> A {
    // Ported from Horizon
    return {}
}
    // rust: let at = self.previous.lerp(self.position, alpha);
        // The boat model turns with yaw and its animated paddles sweep outside
        // the sized collision box. Hurt and bubble-column rotations are covered
        // by this orientation-independent model envelope.
    // rust: Aabb::new(
    // rust: at.subtract(Vec3::new(1.75, 0.75, 1.75)),
    // rust: at.add_vector(Vec3::new(1.75, 1.5, 1.75)),
    // rust: )
}
}

    // rust: impl RenderEntityBounds for Minecart {
render_id :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.id
}

render_bounds :: proc(self: ^Self, alpha: f64) -> A {
    // Ported from Horizon
    return {}
}
    // rust: let at = self.previous.lerp(self.position, alpha);
    // rust: let offset = self.custom_offset.map_or_else(
    // rust: || {
    // rust: if self.kind == super::minecarts::CartKind::Hopper {
    // rust: 1.0
    // rust: } else {
    // rust: 6.0
}
    // rust: },
    // rust: f64::from,
    // rust: );
    // rust: let display_shift = 0.75 * (offset - 8.0) / 16.0;
    // rust: let display_low = at.y + 0.375 - 0.4 + display_shift;
    // rust: let display_high = at.y + 0.375 + 0.4 + display_shift + 0.9;
    // rust: Aabb::new(
    // rust: Vec3::new(at.x - 1.25, (at.y - 0.5).min(display_low), at.z - 1.25),
    // rust: Vec3::new(at.x + 1.25, (at.y + 1.0).max(display_high), at.z + 1.25),
    // rust: )
}
}

aabb_from_extents :: proc(bounds: ([f64; 3]) {
}
    // rust: Aabb::new(
    // rust: Vec3::new(bounds.0[0], bounds.0[1], bounds.0[2]),
    // rust: Vec3::new(bounds.1[0], bounds.1[1], bounds.1[2]),
    // rust: )
}

    // rust: impl RenderEntityBounds for Painting {
render_id :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.id
}

render_bounds :: proc(self: ^Self, _alpha: f64) -> A {
    // Ported from Horizon
    return {}
}
    // rust: aabb_from_extents(self.bounds())
}
}

    // rust: impl RenderEntityBounds for ItemFrame {
render_id :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.id
}

render_bounds :: proc(self: ^Self, _alpha: f64) -> A {
    // Ported from Horizon
    return {}
}
    // rust: let (lo, hi) = self.bounds();
    // rust: let step = self.step().map(f64::from);
    // rust: let center: [f64; 3] = std::array::from_fn(|axis| (lo[axis] + hi[axis]) * 0.5);
        // Maps fill a full block, while the held item projects toward the
        // camera from the frame plane. Include both in the occlusion envelope.
    // rust: let half: [f64; 3] = std::array::from_fn(|axis| if step[axis] != 0.0 { 0.75 } else { 0.5 });
    // rust: aabb_from_extents((
    // rust: std::array::from_fn(|axis| center[axis] - half[axis]),
    // rust: std::array::from_fn(|axis| center[axis] + half[axis]),
    // rust: ))
}
}

    // rust: impl RenderEntityBounds for Cushion {
render_id :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.id
}

render_bounds :: proc(self: ^Self, _alpha: f64) -> A {
    // Ported from Horizon
    return {}
}
    // rust: aabb_from_extents(self.bounds())
}
}

    // rust: mod render_bounds_tests {
//     use super::*;

armor_stand_bounds_include_raised_equipment_space :: proc() {
}
    // rust: let mut stand = ArmorStand::new(1, Vec3::new(4.0, 64.0, -2.0), 90.0);
    // rust: stand.show_arms = true;
    // rust: stand.pose[2] = [180.0, 0.0, 45.0];
    // rust: stand.equipment[0] = Some(horizon_client::items::ItemStack {
    // rust: item: "minecraft:iron_sword".into(),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: });
    // rust: stand.equipment[5] = Some(horizon_client::items::ItemStack {
    // rust: item: "minecraft:banner".into(),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: });
    // rust: let bounds = stand.render_bounds(0.5);
    // rust: assert!(bounds.min_position().x <= 2.0);
    // rust: assert!(bounds.max_position().x >= 6.0);
    // rust: assert!(bounds.min_position().y <= 63.0);
    // rust: assert!(bounds.max_position().y >= 69.0);
    // rust: assert!(bounds.min_position().z <= -4.0);
    // rust: assert!(bounds.max_position().z >= 0.0);
}

boat_bounds_cover_the_rotated_paddle_sweep :: proc() {
}
    // rust: let boat = Boat::new(2, "oak".into(), Vec3::new(0.0, 10.0, 0.0), 90.0);
    // rust: let bounds = boat.render_bounds(0.5);
    // rust: assert!(bounds.min_position().x <= -1.75);
    // rust: assert!(bounds.max_position().x >= 1.75);
    // rust: assert!(bounds.min_position().y <= 9.25);
    // rust: assert!(bounds.max_position().y >= 11.5);
    // rust: assert!(bounds.min_position().z <= -1.75);
    // rust: assert!(bounds.max_position().z >= 1.75);
}

item_frame_bounds_include_the_full_map_and_held_item_depth :: proc() {
}
    // rust: let frame = ItemFrame {
    // rust: id: 3,
    // rust: pos: [0, 0, 0],
    // rust: facing: 5,
    // rust: glow: false,
    // rust: item: None,
    // rust: rotation: 0,
    // rust: drop_chance: 1.0,
    // rust: fixed: false,
    // rust: invisible: false,
    // rust: check_interval: 0,
    // rust: custom_name: None,
}
    // rust: let bounds = frame.render_bounds(1.0);
    // rust: assert!(bounds.min_position().x <= -0.71875);
    // rust: assert!(bounds.max_position().x >= 0.78125);
    // rust: assert!(bounds.min_position().y <= 0.0);
    // rust: assert!(bounds.max_position().y >= 1.0);
    // rust: assert!(bounds.min_position().z <= 0.0);
    // rust: assert!(bounds.max_position().z >= 1.0);
}

minecart_bounds_follow_custom_display_offset :: proc() {
}
    // rust: let mut cart = Minecart::new(
    // rust: 4,
    // rust: super::super::minecarts::CartKind::Chest,
    // rust: Vec3::new(0.0, 10.0, 0.0),
    // rust: );
    // rust: cart.custom_offset = Some(32);
    // rust: let bounds = cart.render_bounds(1.0);
    // rust: assert!(bounds.min_position().y <= 9.5);
    // rust: assert!(bounds.max_position().y >= 12.8);
}
}

// The fields every kind stores under the same names.
    // rust: macro_rules! stored_motion {
    // rust: () => {
id :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.id
}
position :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.position
}
position_mut :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &mut self.position
}
velocity :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.velocity
}
velocity_mut :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &mut self.velocity
}
}
}

// One `ItemEntity.tick`, with the fluid push and the bubble column decided by
// the `Entity` defaults every kind shares: fluids, move, column, settle,
// fluids again. Returns false when the item should be removed.
    // rust: pub(super) fn tick_item(
    // rust: item: &mut ItemEntity,
    // rust: world: &horizon_client::world::World,
    // rust: registry: &horizon_world::registry::BlockRegistry,
    // rust: facts: &horizon_client::blocks::BlockFacts,
    // rust: collision: &horizon_world::block_collision::BlockCollisionRegistry<'_>,
    // rust: fluids: &horizon_client::motion::FluidResources,
    // rust: no_physics: bool,
    // rust: entity_boxes: &[Aabb],
    // rust: border: Option<&horizon_core::geometry::border::BorderGeometry>,
    // rust: blocks: Option<&horizon_world::movement_properties::BoundMovementProperties>,
    // rust: splash: &mut impl FnMut(horizon_client::entities::ItemSplash),
    // rust: ) -> bool {
    // rust: let (water, _lava) = item.push_by_fluid(world, fluids);
    // `Entity.baseTick` splashes before the item moves. The first tick does not.
    // rust: item.water_entry(water > 0.0, item.ticks == 0, splash);
    // rust: let step = item.tick_move(
    // rust: world,
    // rust: facts,
    // rust: collision,
    // rust: no_physics,
    // rust: (water, _lava),
    // rust: entity_boxes,
    // rust: border,
    // rust: blocks,
    // rust: );
    // rust: item.push_by_bubble_column(world, registry, facts, collision);
    // rust: let alive = item.tick_settle(world, facts, no_physics, step);
    // `ItemEntity.tick` refreshes immersion after moving and splashes if that
    // move is what entered the water.
    // rust: let (water, _) = item.push_by_fluid(world, fluids);
    // rust: item.water_entry(water > 0.0, false, splash);
    // rust: alive
}

// The game's lists of entities, in the order systems walk them. Hands them to
// `$then`, so one list drives the handles and every typed dispatch.
    // rust: macro_rules! entity_lists {
    // rust: ($then:ident, $($args:tt)*) => {
    // rust: $crate::game::entity::$then! {
    // rust: ($($args)*)
    // rust: Mob(Mob) mobs: mobs,
    // rust: Item(ItemEntity) dropped: dropped,
    // rust: Boat(Boat) boats: boats,
    // rust: Cart(Minecart) carts: carts,
    // rust: ArmorStand(ArmorStand) armor_stands: armor_stands,
    // rust: Tnt(PrimedTnt) tnts: tnts,
    // rust: Falling(FallingBlock) falling: falling,
    // rust: Orb(ExperienceOrb) orbs: orbs,
    // rust: Projectile(Projectile) projectiles: creatures.projectiles,
    // rust: Rocket(Rocket) rockets: rockets,
    // rust: Trident(ThrownTrident) tridents: tridents,
}
}
}
    // rust: pub(crate) use entity_lists;

    // rust: macro_rules! define_entity_handles {
    // rust: (() $($kind:ident($ty:ty) $field:ident: $($list:ident).+,)*) => {
        // Every list, borrowed apart from the rest of `Game`, for
        // [`for_each_entity`] while the world is borrowed mutably.
    // rust: pub(super) struct EntityLists<'w> {
    // rust: $(pub(super) $field: &'w [$ty],)*
}

        // One entity, by list and index.
    // rust: pub(super) enum EntityHandle {
    // rust: $($kind(usize),)*
}

        // Every list moved out of `Game`, for [`for_each_entity_mut`]: the
        // world stays readable while the entities change.
    // rust: pub(super) struct TakenEntities {
    // rust: $(pub(super) $field: horizon_client::join_seq::JoinList<$ty>,)*
}


    // rust: impl EntityLists<'_> {
            // Visits every entity once, in the order they joined, whatever the
            // kind: a merge of the lists, each already in join order, by a
            // cursor per list. Static dispatch and nothing allocated. Checked:
            // a list out of join order, or an entity that never joined, stops
            // the walk with the entity at fault.
    // rust: pub(super) fn walk_in_join_order(
    // rust: self,
    // rust: visit: impl FnMut(EntityHandle, JoinSeq),
    // rust: ) -> Result<(), JoinOrderError> {
    // rust: let lens = [$(self.$field.len()),*];
    // rust: merge_in_join_order(
    // rust: lens,
    // rust: |kind, i| {
    // rust: let mut at = 0;
    // rust: $(if kind == at {
    // rust: return self.$field[i].join_seq();
    // rust: } at += 1;)*
    // rust: let _ = at;
    // rust: unreachable!("kind {kind} is not a list")
    // rust: },
    // rust: |kind, i| {
    // rust: let mut at = 0;
    // rust: $(if kind == at {
    // rust: return EntityHandle::$kind(i);
    // rust: } at += 1;)*
    // rust: let _ = at;
    // rust: unreachable!("kind {kind} is not a list")
    // rust: },
    // rust: visit,
    // rust: )
}
}

    // rust: impl Game<'_> {
            // Moves every list out; give it back with `restore_entities`.
    // rust: pub(super) fn take_entities(&mut self) -> TakenEntities {
    // rust: TakenEntities {
    // rust: $($field: std::mem::take(&mut self$(.$list)+),)*
}
}
    // rust: pub(super) fn restore_entities(&mut self, taken: TakenEntities) {
    // rust: $(self$(.$list)+ = taken.$field;)*
}
            // Every entity's handle: lengths read now, nothing allocated, and
            // no borrow of `Game` held, so the caller can change it mid-walk.
    // rust: pub(super) fn entity_handles(&self) -> impl Iterator<Item = EntityHandle> + use<> {
    // rust: std::iter::empty()
    // rust: $(.chain((0..self$(.$list)+.len()).map(EntityHandle::$kind)))*
}

            // Takes the entity out of its list (`Entity.discard` before it ever ticked).
    // rust: pub(super) fn discard_entity(&mut self, handle: EntityHandle) {
    // rust: match handle {
    // rust: $(EntityHandle::$kind(i) => {
    // rust: self$(.$list)+.remove(i);
    // rust: })*
}
}

            // [`Self::entity_handles`], last of each list first, so the
            // caller can remove the entity it is on.
    // rust: pub(super) fn entity_handles_rev(&self) -> impl Iterator<Item = EntityHandle> + use<> {
    // rust: std::iter::empty()
    // rust: $(.chain((0..self$(.$list)+.len()).rev().map(EntityHandle::$kind)))*
}
}
}
}
    // rust: pub(crate) use define_entity_handles;

// Why [`EntityLists::walk_in_join_order`] stopped.
    // rust: pub(super) enum JoinOrderError {
    // Never put in its list through the list's own `push`, so it has no
    // join number.
    // rust: Unjoined(EntityHandle),
    // Joined before an entity the walk had already visited: its list is out
    // of join order.
    // rust: OutOfOrder(EntityHandle),
}

// The merge behind the join-order walk, over `N` lists: `lens` are their
// lengths, `seq(list, i)` the join number of entity `i` of a list, `handle`
// names it. Each step takes the lowest next number among the `N` cursors
// (a stack array; no allocation).
    // rust: fn merge_in_join_order<const N: usize>(
    // rust: lens: [usize; N],
    // rust: seq: impl Fn(usize, usize) -> JoinSeq,
    // rust: handle: impl Fn(usize, usize) -> EntityHandle,
    // rust: mut visit: impl FnMut(EntityHandle, JoinSeq),
    // rust: ) -> Result<(), JoinOrderError> {
    // rust: let mut cursor = [0usize; N];
    // rust: let mut last = JoinSeq::UNJOINED;
    // rust: loop {
    // rust: let mut best: Option<(usize, JoinSeq)> = None;
    // rust: for list in 0..N {
    // rust: if cursor[list] < lens[list] {
    // rust: let s = seq(list, cursor[list]);
    // rust: if !s.is_joined() {
    // rust: return Err(JoinOrderError::Unjoined(handle(list, cursor[list])));
}
    // rust: if best.is_none_or(|(_, b)| s < b) {
    // rust: best = Some((list, s));
}
}
}
    // rust: let Some((list, s)) = best else {
    // rust: return Ok(());
}
    // rust: let h = handle(list, cursor[list]);
    // rust: if s <= last {
    // rust: return Err(JoinOrderError::OutOfOrder(h));
}
    // rust: last = s;
    // rust: cursor[list] += 1;
    // rust: visit(h, s);
}
}

    // rust: entity_lists!(define_entity_handles,);
    // rust: horizon_client::impl_joined!(FallingBlock);

    // rust: macro_rules! entity_borrow {
    // rust: (shared, $place:expr) => {
    // rust: &$place
}
    // rust: (exclusive, $place:expr) => {
    // rust: &mut $place
}
}
    // rust: pub(crate) use entity_borrow;

    // rust: macro_rules! match_entity {
    // rust: (($borrow:ident, $entity:ident, $game:expr, $handle:expr, $body:expr)
    // rust: $($kind:ident($ty:ty) $field:ident: $($list:ident).+,)*) => {
    // rust: match $handle {
    // rust: $($crate::game::entity::EntityHandle::$kind(i) => {
    // rust: let $entity = $crate::game::entity::entity_borrow!($borrow, $game$(.$list)+[i]);
    // rust: $body
    // rust: })*
}
}
}
    // rust: pub(crate) use match_entity;

// Runs `$body` with `$entity` bound to the handle's entity, as its own type:
// one match, each arm compiled for its kind, so nothing goes through a vtable.
    // rust: macro_rules! with_entity {
    // rust: ($game:expr, $handle:expr, $entity:ident => $body:expr) => {
    // rust: $crate::game::entity::entity_lists!(match_entity, shared, $entity, $game, $handle, $body)
}
}
    // rust: pub(super) use with_entity;

    // rust: macro_rules! borrow_lists {
    // rust: (($game:expr) $($kind:ident($ty:ty) $field:ident: $($list:ident).+,)*) => {
    // rust: $crate::game::entity::EntityLists {
    // rust: $($field: &$game$(.$list)+,)*
}
}
}
    // rust: pub(crate) use borrow_lists;

// `$game`'s [`EntityLists`]; a macro so the borrow stays field by field.
    // rust: macro_rules! entity_lists_of {
    // rust: ($game:expr) => {
    // rust: $crate::game::entity::entity_lists!(borrow_lists, $game)
}
}
    // rust: pub(super) use entity_lists_of;

    // rust: macro_rules! walk_lists {
    // rust: (($lists:expr, $entity:ident, $body:block)
    // rust: $($kind:ident($ty:ty) $field:ident: $($list:ident).+,)*) => {
    // rust: $(for $entity in $lists.$field $body)*
}
}
    // rust: pub(crate) use walk_lists;

// Runs `$body` for every entity, with `$entity` as a reference to its own
// type: one loop per list, each compiled for its kind, so nothing allocates
// or goes through a vtable and a check a kind answers with a constant folds
// away. A kind added to `entity_lists!` joins every walk.
    // rust: macro_rules! for_each_entity {
    // rust: ($lists:expr, $entity:ident => $body:block) => {
    // rust: $crate::game::entity::entity_lists!(walk_lists, $lists, $entity, $body)
}
}
    // rust: pub(super) use for_each_entity;

    // rust: macro_rules! walk_lists_mut {
    // rust: (($lists:expr, $entity:ident, $body:block)
    // rust: $($kind:ident($ty:ty) $field:ident: $($list:ident).+,)*) => {
    // rust: $(for $entity in $lists.$field.iter_mut() $body)*
}
}
    // rust: pub(crate) use walk_lists_mut;

// [`for_each_entity`] over [`TakenEntities`], with the entity mutable.
    // rust: macro_rules! for_each_entity_mut {
    // rust: ($lists:expr, $entity:ident => $body:block) => {
    // rust: $crate::game::entity::entity_lists!(walk_lists_mut, $lists, $entity, $body)
}
}
    // rust: pub(super) use for_each_entity_mut;

// [`with_entity`], with the entity mutable.
    // rust: macro_rules! with_entity_mut {
    // rust: ($game:expr, $handle:expr, $entity:ident => $body:expr) => {
    // rust: $crate::game::entity::entity_lists!(match_entity, exclusive, $entity, $game, $handle, $body)
}
}
    // rust: pub(super) use with_entity_mut;

    // rust: macro_rules! save_lists {
    // rust: (($game:expr, $keys:expr, $out:expr)
    // rust: $($kind:ident($ty:ty) $field:ident: $($list:ident).+,)*) => {
    // rust: $(for i in 0..$game$(.$list)+.len() {
    // rust: if let Some((key, tag)) = <$ty as $crate::game::entity::Entity>::save_nbt($game, i, $keys) {
    // rust: $out.entry(key).or_default().push((
    // rust: $game$(.$list)+[i].join_seq(),
    // rust: tag,
    // rust: ));
}
    // rust: })*
}
}
    // rust: pub(crate) use save_lists;

// Saves every entity of every list in `entity_lists!` into `$out` by chunk,
// each with its join number (`$out` maps a chunk to `(JoinSeq, Tag)` pairs),
// each through its own `Entity::save_nbt`: one loop per list, static dispatch,
// nothing allocated beyond the tags. A kind added to the lists cannot be left
// out, since `save_nbt` has no default.
    // rust: macro_rules! save_entities_of_every_kind {
    // rust: ($game:expr, $keys:expr, $out:expr) => {
    // rust: $crate::game::entity::entity_lists!(save_lists, $game, $keys, $out)
}
}

    // rust: macro_rules! load_lists {
    // rust: (($game:expr, $kind:expr, $uuid:expr, $player:expr, $tag:expr)
    // rust: $($kind_name:ident($ty:ty) $field:ident: $($list:ident).+,)*) => {{
    // rust: let mut tag = $tag;
    // rust: $(match <$ty as $crate::game::entity::Entity>::load_nbt($game, $kind, $uuid, $player, tag) {
    // rust: Ok(()) => return Ok(()),
    // rust: Err(back) => tag = back,
    // rust: })*
    // rust: Err(tag)
    // rust: }};
}
    // rust: pub(crate) use load_lists;

// Loads a saved entity as the first kind in `entity_lists!` that claims its
// type id, through that kind's own `Entity::load_nbt`: one test per kind,
// static dispatch, nothing allocated (the compound moves through). Evaluates
// to `Err(tag)` when no kind claims it, and `return`s `Ok` from the caller
// otherwise. A kind added to the lists cannot be left out, since `load_nbt`
// has no default.
    // rust: macro_rules! load_entity_of_any_kind {
    // rust: ($game:expr, $kind:expr, $uuid:expr, $player:expr, $tag:expr) => {
    // rust: $crate::game::entity::entity_lists!(load_lists, $game, $kind, $uuid, $player, $tag)
}
}

    // rust: impl Game<'_> {
    // Loads a saved entity as the first kind in `entity_lists!` that claims
    // its type id: `Err` hands the compound back when none does.
    // rust: pub(super) fn load_listed(
    // rust: &mut self,
    // rust: kind: &str,
    // rust: uuid: Option<[i32; 4]>,
    // rust: player_uuid: Option<[i32; 4]>,
    // rust: tag: Tag,
    // rust: ) -> Result<(), Tag> {
    // rust: load_entity_of_any_kind!(self, kind, uuid, player_uuid, tag)
}
    // The ids of the entities that are not on the walk of `entity_lists!`.
    // rust: pub(super) fn entity_ids_off_walk(&self) -> impl Iterator<Item = u32> + '_ {
    // rust: self.cushions
    // rust: .iter()
    // rust: .map(|e| e.id)
    // rust: .chain(self.item_frames.iter().map(|e| e.id))
    // rust: .chain(self.paintings.iter().map(|e| e.id))
    // rust: .chain(self.others.iter().map(|e| e.id))
    // rust: .chain(self.breath_clouds.iter().map(|e| e.id))
    // rust: .chain(self.fangs.list.iter().map(|e| e.id))
    // rust: .chain(self.crystals.iter().map(|e| e.id))
    // rust: .chain(self.dragon.iter().map(|e| e.id))
    // rust: .chain(self.ominous_spawners.iter().map(|e| e.id))
}
    // Saves every entity of every kind that lies in `keys` into `out`, by chunk.
    // rust: pub(super) fn save_every_entity(
    // rust: &mut self,
    // rust: keys: &HashSet<ChunkKey>,
    // rust: out: &mut HashMap<ChunkKey, Vec<Tag>>,
    // rust: ) {
        // Saved by chunk in the order they joined, so a reload adds them in
        // that order (a chunk's entity list is in insertion order in vanilla).
    // rust: let mut staged: HashMap<ChunkKey, Vec<(JoinSeq, Tag)>> = HashMap::new();
    // rust: save_entities_of_every_kind!(self, keys, staged);
    // rust: for (key, mut tags) in staged {
    // rust: tags.sort_by_key(|(seq, _)| *seq);
    // rust: out.entry(key)
    // rust: .or_default()
    // rust: .extend(tags.into_iter().map(|(_, tag)| tag));
}
}
}

    // rust: impl Entity for Mob {
rotation :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [self.yaw, self.head_pitch]
}
set_rotation :: proc(self: ^Self, pitch]: [f32; 2]) {
}
    // rust: let previous = self.rotation();
    // rust: let yaw = if yaw.is_finite() { yaw } else { previous[0] };
    // rust: let pitch = if pitch.is_nan() { previous[1] } else { pitch };
    // rust: self.yaw = yaw;
    // rust: self.body_yaw = yaw;
    // rust: self.head_yaw = yaw;
    // rust: self.head_pitch = pitch.clamp(-90.0, 90.0);
    // rust: self.previous_yaw = self.yaw;
    // rust: self.previous_head_pitch = self.head_pitch;
}
native_type :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: super::native_hooks::mob_kind(self).into()
}
    // rust: fn save_nbt(
    // rust: game: &mut Game<'_>,
    // rust: index: usize,
    // rust: keys: &HashSet<ChunkKey>,
    // rust: ) -> Option<(ChunkKey, Tag)> {
    // rust: game.save_mob(index, keys)
}
    // rust: fn load_nbt(
    // rust: game: &mut Game<'_>,
    // rust: kind: &str,
    // rust: _uuid: Option<[i32; 4]>,
    // rust: _player_uuid: Option<[i32; 4]>,
    // rust: tag: Tag,
    // rust: ) -> Result<(), Tag> {
    // rust: if !(game.res.mob_types().contains_key(kind)) {
    // rust: return Err(tag);
}
    // rust: game.load_mob(tag, None);
    // rust: Ok(())
}
    // rust: stored_motion!();
portal_size :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some((self.width(), self.height()))
}
can_use_portal :: proc(self: ^Self, game: ^Game<'_>) -> b {
    // Ported from Horizon
    return {}
}
    // rust: game.mob_can_use_portal(self)
}
selector_target :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: (self.death_time == 0).then_some(Target::Mob(self.id))
}
bounds :: proc(self: ^Self) -> A {
    // Ported from Horizon
    return {}
}
    // rust: Mob::bounds(self)
}
on_ground :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.on_ground
}
get_step_height :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.kind.step_height as f32
}
is_alive :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.removed && self.alive()
}
is_removed :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.removed
}
is_living :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
    // `Bat.isIgnoringBlockTriggers`.
is_ignoring_block_triggers :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.species() == Species::Bat
}
    // `Warden.ignoreExplosion`: while it digs or emerges.
ignores_explosion :: proc(self: ^Self, blast: ^Blast) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.alive()
    // rust: || blast.spared == Some(self.id)
    // rust: || (self.species() == Species::Warden
    // rust: && horizon_client::mobs::warden::digging_or_emerging(self))
}
    // `getEyeHeight` of the mob as it stands: a baby's, a slime's or a
    // phantom's own scaled eye height, not the adult kind's. The blast's box
    // is its real `bounds`, so it needs no override.
explosion_eye_height :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.eye_height()
}
    // `Entity.push` sets `needsSync`.
push_from_explosion :: proc(self: ^Self, push: Vec3) {
}
    // rust: self.velocity = Vec3::new(
    // rust: self.velocity.x + push.x,
    // rust: self.velocity.y + push.y,
    // rust: self.velocity.z + push.z,
    // rust: );
    // rust: self.needs_sync = true;
}
is_supported_by :: proc(self: ^Self, pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.supporting == Some([pos.x, pos.y, pos.z])
}
thunder_hit :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: if self.alive() {
    // rust: ThunderHit::Mob
    // rust: } else {
    // rust: ThunderHit::Untouched
}
}
    // The kind's own size, as the strike has always read it.
thunder_bounds :: proc(self: ^Self) -> A {
    // Ported from Horizon
    return {}
}
    // rust: let (p, w) = (self.position, self.kind.width / 2.0);
    // rust: Aabb::new(
    // rust: Vec3::new(p.x - w, p.y, p.z - w),
    // rust: Vec3::new(p.x + w, p.y + self.kind.height, p.z + w),
    // rust: )
}
}

    // rust: impl Entity for ItemEntity {
rotation :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: self.rotation
}
set_rotation :: proc(self: ^Self, pitch]: [f32; 2]) {
}
    // rust: let previous = self.rotation();
    // rust: let yaw = if yaw.is_finite() { yaw } else { previous[0] };
    // rust: let pitch = if pitch.is_nan() { previous[1] } else { pitch };
    // rust: self.rotation = [yaw, pitch.clamp(-90.0, 90.0)];
}
fluid_eye_y :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: ItemEntity::fluid_eye_y(self)
}
native_type :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: "minecraft:item".into()
}
    // rust: fn save_nbt(
    // rust: game: &mut Game<'_>,
    // rust: index: usize,
    // rust: keys: &HashSet<ChunkKey>,
    // rust: ) -> Option<(ChunkKey, Tag)> {
    // rust: game.save_item(index, keys)
}
    // rust: fn load_nbt(
    // rust: game: &mut Game<'_>,
    // rust: kind: &str,
    // rust: uuid: Option<[i32; 4]>,
    // rust: _player_uuid: Option<[i32; 4]>,
    // rust: tag: Tag,
    // rust: ) -> Result<(), Tag> {
    // rust: if !(kind == "minecraft:item") {
    // rust: return Err(tag);
}
    // rust: game.load_item(tag, uuid);
    // rust: Ok(())
}
    // rust: stored_motion!();
portal_size :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some((0.25, 0.25))
}
selector_target :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(Target::Item(self.id))
}
thunder_hit :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: ThunderHit::Item
}
ignores_explosion :: proc(self: ^Self, blast: ^Blast) -> b {
    // Ported from Horizon
    return {}
}
    // rust: blast.items_ignore
}
explosion_eye_height :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 0.2125
}
bounds :: proc(self: ^Self) -> A {
    // Ported from Horizon
    return {}
}
    // rust: ItemEntity::bounds(self)
}
on_ground :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.on_ground
}
move_by_piston :: proc(self: ^Self, movement: Vec3) {
}
    // rust: self.position = self.position.add_vector(movement);
        // Entity.move(MoverType.PISTON): onGround only if the push was down.
    // rust: if movement.y != 0.0 {
    // rust: self.on_ground = movement.y < 0.0;
}
}
piston_slime_bounce :: proc(self: ^Self, movement: Direction) {
}
    // rust: ItemEntity::piston_slime_bounce(self, movement);
}
}

    // rust: impl Entity for ExperienceOrb {
rotation :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: self.rotation
}
set_rotation :: proc(self: ^Self, pitch]: [f32; 2]) {
}
    // rust: let previous = self.rotation();
    // rust: let yaw = if yaw.is_finite() { yaw } else { previous[0] };
    // rust: let pitch = if pitch.is_nan() { previous[1] } else { pitch };
    // rust: self.rotation = [yaw, pitch.clamp(-90.0, 90.0)];
}
ticks_after_projectiles :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
native_type :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: "minecraft:experience_orb".into()
}
    // rust: fn save_nbt(
    // rust: game: &mut Game<'_>,
    // rust: index: usize,
    // rust: keys: &HashSet<ChunkKey>,
    // rust: ) -> Option<(ChunkKey, Tag)> {
    // rust: game.save_orb(index, keys)
}
    // rust: fn load_nbt(
    // rust: game: &mut Game<'_>,
    // rust: kind: &str,
    // rust: uuid: Option<[i32; 4]>,
    // rust: _player_uuid: Option<[i32; 4]>,
    // rust: tag: Tag,
    // rust: ) -> Result<(), Tag> {
    // rust: if !(kind == "minecraft:experience_orb") {
    // rust: return Err(tag);
}
    // rust: game.load_orb(tag, uuid);
    // rust: Ok(())
}
    // rust: stored_motion!();
portal_size :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some((0.5, 0.5))
}
selector_target :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(Target::Orb(self.id))
}
thunder_hit :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: ThunderHit::Orb
}
explosion_eye_height :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: f64::from(0.5f32 * 0.85f32)
}
bounds :: proc(self: ^Self) -> A {
    // Ported from Horizon
    return {}
}
    // rust: ExperienceOrb::bounds(self)
}
on_ground :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.on_ground
}
move_by_piston :: proc(self: ^Self, movement: Vec3) {
}
    // rust: self.position = self.position.add_vector(movement);
    // rust: if movement.y != 0.0 {
    // rust: self.on_ground = movement.y < 0.0;
}
}
piston_slime_bounce :: proc(self: ^Self, movement: Direction) {
}
    // rust: self.velocity = piston_push::bounce_velocity(movement, self.velocity);
    // rust: self.on_ground = false;
}
}

    // rust: impl Entity for Boat {
rotation :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [self.yaw, self.pitch]
}
set_rotation :: proc(self: ^Self, pitch]: [f32; 2]) {
}
    // rust: let previous = self.rotation();
    // rust: let yaw = if yaw.is_finite() { yaw } else { previous[0] };
    // rust: let pitch = if pitch.is_nan() { previous[1] } else { pitch };
    // rust: self.yaw = yaw;
    // rust: self.pitch = pitch.clamp(-90.0, 90.0);
}
native_type :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: self.entity_type().into()
}
    // rust: fn save_nbt(
    // rust: game: &mut Game<'_>,
    // rust: index: usize,
    // rust: keys: &HashSet<ChunkKey>,
    // rust: ) -> Option<(ChunkKey, Tag)> {
    // rust: game.save_boat(index, keys)
}
    // rust: fn load_nbt(
    // rust: game: &mut Game<'_>,
    // rust: kind: &str,
    // rust: uuid: Option<[i32; 4]>,
    // rust: _player_uuid: Option<[i32; 4]>,
    // rust: tag: Tag,
    // rust: ) -> Result<(), Tag> {
    // rust: if !(super::boats::any_boat_wood(kind)
    // rust: .is_some_and(|(wood, chest)| game.boat_models.has(wood, chest)))
    // rust: {
    // rust: return Err(tag);
}
    // rust: game.load_boat(tag, uuid, kind);
    // rust: Ok(())
}
    // rust: stored_motion!();
is_vehicle :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
    // `Boat.getEyeY`: the top of the 0.5625 box.
fluid_eye_y :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.position.y + super::boats::HEIGHT
}
portal_size :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some((super::boats::WIDTH as f32, super::boats::HEIGHT as f32))
}
can_use_portal :: proc(self: ^Self, game: ^Game<'_>) -> b {
    // Ported from Horizon
    return {}
}
    // rust: game.vehicle_can_use_portal(self.id)
}
selector_target :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(Target::Boat(self.id))
}
thunder_hit :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: ThunderHit::Vehicle
}
ignores_explosion :: proc(self: ^Self, blast: ^Blast) -> b {
    // Ported from Horizon
    return {}
}
    // rust: blast.vehicles_ignore
}
    // `EntityType.OAK_BOAT & co`: the full 0.5625.
explosion_eye_height :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 0.5625
}
bounds :: proc(self: ^Self) -> A {
    // Ported from Horizon
    return {}
}
    // rust: Boat::bounds(self)
}
on_ground :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.on_ground
}
}

    // rust: impl Entity for Minecart {
rotation :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [self.yaw, self.pitch]
}
set_rotation :: proc(self: ^Self, pitch]: [f32; 2]) {
}
    // rust: let previous = self.rotation();
    // rust: let yaw = if yaw.is_finite() { yaw } else { previous[0] };
    // rust: let pitch = if pitch.is_nan() { previous[1] } else { pitch };
    // rust: self.yaw = yaw;
    // rust: self.pitch = pitch.clamp(-90.0, 90.0);
}
native_type :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: self.kind.id().into()
}
    // rust: fn save_nbt(
    // rust: game: &mut Game<'_>,
    // rust: index: usize,
    // rust: keys: &HashSet<ChunkKey>,
    // rust: ) -> Option<(ChunkKey, Tag)> {
    // rust: game.save_cart(index, keys)
}
    // rust: fn load_nbt(
    // rust: game: &mut Game<'_>,
    // rust: kind: &str,
    // rust: uuid: Option<[i32; 4]>,
    // rust: _player_uuid: Option<[i32; 4]>,
    // rust: tag: Tag,
    // rust: ) -> Result<(), Tag> {
    // rust: if !(super::minecarts::CartKind::from_id(kind).is_some()) {
    // rust: return Err(tag);
}
    // rust: game.load_cart(tag, uuid, kind);
    // rust: Ok(())
}
    // rust: stored_motion!();
is_vehicle :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
portal_size :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some((
    // rust: super::minecarts::WIDTH as f32,
    // rust: super::minecarts::HEIGHT as f32,
    // rust: ))
}
can_use_portal :: proc(self: ^Self, game: ^Game<'_>) -> b {
    // Ported from Horizon
    return {}
}
    // rust: game.vehicle_can_use_portal(self.id)
}
selector_target :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(Target::Cart(self.id))
}
thunder_hit :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: ThunderHit::Vehicle
}
ignores_explosion :: proc(self: ^Self, blast: ^Blast) -> b {
    // Ported from Horizon
    return {}
}
    // rust: blast.vehicles_ignore
}
bounds :: proc(self: ^Self) -> A {
    // Ported from Horizon
    return {}
}
    // rust: Minecart::bounds(self)
}
on_ground :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.on_ground
}
    // `tick_blocks` sweeps minecarts along with the players.
sweeps_blocks_inside :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
}

// Width and height `EntityType.ARMOR_STAND` gives a stand.
armor_stand_size :: proc(stand: ^ArmorStand) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: if stand.marker {
    // rust: (0.0, 0.0)
    // rust: } else if stand.small {
    // rust: (0.25, f64::from(0.9875f32))
    // rust: } else {
    // rust: (0.5, f64::from(1.975f32))
}
}

    // rust: impl Entity for ArmorStand {
rotation :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [self.yaw, self.pitch]
}
set_rotation :: proc(self: ^Self, pitch]: [f32; 2]) {
}
    // rust: let previous = self.rotation();
    // rust: let yaw = if yaw.is_finite() { yaw } else { previous[0] };
    // rust: let pitch = if pitch.is_nan() { previous[1] } else { pitch };
    // rust: self.yaw = yaw;
    // rust: self.previous_yaw = yaw;
    // rust: self.pitch = pitch.clamp(-90.0, 90.0);
}
fluid_eye_y :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: ArmorStand::fluid_eye_y(self)
}
native_type :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: "minecraft:armor_stand".into()
}
    // rust: fn save_nbt(
    // rust: game: &mut Game<'_>,
    // rust: index: usize,
    // rust: keys: &HashSet<ChunkKey>,
    // rust: ) -> Option<(ChunkKey, Tag)> {
    // rust: game.save_armor_stand(index, keys)
}
    // rust: fn load_nbt(
    // rust: game: &mut Game<'_>,
    // rust: kind: &str,
    // rust: uuid: Option<[i32; 4]>,
    // rust: _player_uuid: Option<[i32; 4]>,
    // rust: tag: Tag,
    // rust: ) -> Result<(), Tag> {
    // rust: if !(kind == "minecraft:armor_stand") {
    // rust: return Err(tag);
}
    // rust: game.load_armor_stand(tag, uuid);
    // rust: Ok(())
}
    // rust: stored_motion!();
selector_target :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(Target::Stand(self.id))
}
    // `ArmorStand.ignoreExplosion`: a visible stand feels only a burst that
    // affects block-like entities (`items_ignore` is that flag, negated).
ignores_explosion :: proc(self: ^Self, blast: ^Blast) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.invisible || blast.items_ignore
}
    // `EntityType.ARMOR_STAND`'s size, halved when small; a marker has none.
explosion_box :: proc(self: ^Self) -> A {
    // Ported from Horizon
    return {}
}
    // rust: let (w, h) = armor_stand_size(self);
    // rust: let half = w / 2.0;
    // rust: let p = self.position;
    // rust: Aabb::new(
    // rust: Vec3::new(p.x - half, p.y, p.z - half),
    // rust: Vec3::new(p.x + half, p.y + h, p.z + half),
    // rust: )
}
explosion_eye_height :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if self.marker {
    // rust: 0.0
    // rust: } else if self.small {
    // rust: f64::from(0.9875f32)
    // rust: } else {
    // rust: f64::from(1.7775f32)
}
}
    // A burst of wind pushes a stand that a blast only breaks.
pushed_by_wind :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
bounds :: proc(self: ^Self) -> A {
    // Ported from Horizon
    return {}
}
    // rust: ArmorStand::bounds(self)
}
on_ground :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.on_ground
}
is_living :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
    // `ArmorStand.isIgnoringBlockTriggers`.
is_ignoring_block_triggers :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.marker
}
    // A NoGravity stand is not swept for the blocks it stands in (plates,
    // fire): measured beside the real server, it never presses a plate nor
    // catches fire, and does again once `NoGravity` is cleared.
sweeps_blocks_inside :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.no_gravity
}
pushed_by_explosion :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
    // `ArmorStand.getPistonPushReaction`: a marker is ignored.
get_piston_push_reaction :: proc(self: ^Self) -> P {
    // Ported from Horizon
    return {}
}
    // rust: if self.marker {
    // rust: PushReaction::IgnoreEntity
    // rust: } else {
    // rust: PushReaction::PushPull
}
}
}

    // rust: impl Entity for PrimedTnt {
rotation :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: self.rotation
}
set_rotation :: proc(self: ^Self, pitch]: [f32; 2]) {
}
    // rust: let previous = self.rotation();
    // rust: let yaw = if yaw.is_finite() { yaw } else { previous[0] };
    // rust: let pitch = if pitch.is_nan() { previous[1] } else { pitch };
    // rust: self.rotation = [yaw, pitch.clamp(-90.0, 90.0)];
}
ticks_after_projectiles :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
native_type :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: "minecraft:tnt".into()
}
    // rust: fn save_nbt(
    // rust: game: &mut Game<'_>,
    // rust: index: usize,
    // rust: keys: &HashSet<ChunkKey>,
    // rust: ) -> Option<(ChunkKey, Tag)> {
    // rust: game.save_tnt(index, keys)
}
    // rust: fn load_nbt(
    // rust: game: &mut Game<'_>,
    // rust: kind: &str,
    // rust: uuid: Option<[i32; 4]>,
    // rust: _player_uuid: Option<[i32; 4]>,
    // rust: tag: Tag,
    // rust: ) -> Result<(), Tag> {
    // rust: if !(kind == "minecraft:tnt") {
    // rust: return Err(tag);
}
    // rust: game.load_tnt(tag, uuid);
    // rust: Ok(())
}
    // rust: stored_motion!();
    // `PrimedTnt` eye height: `0.98 * 0.85`.
fluid_eye_y :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.position.y + f64::from(0.98f32 * 0.85f32)
}
    // `PrimedTnt` is 0.98 across.
portal_size :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some((0.98, 0.98))
}
can_use_portal :: proc(self: ^Self, game: ^Game<'_>) -> b {
    // Ported from Horizon
    return {}
}
    // rust: game.tnt_can_use_portal(self.id)
}
selector_target :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(Target::Tnt(self.id))
}
    // Pushed from its position, not its eyes.
explosion_eye_height :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 0.0
}
bounds :: proc(self: ^Self) -> A {
    // Ported from Horizon
    return {}
}
    // rust: PrimedTnt::bounds(self)
}
on_ground :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.on_ground
}
piston_slime_bounce :: proc(self: ^Self, movement: Direction) {
}
    // rust: self.velocity = piston_push::bounce_velocity(movement, self.velocity);
        // Leave the ground so the next tick does not apply the on-ground
        // Y * -0.5 friction that cancels the launch.
    // rust: self.on_ground = false;
}
}

    // rust: impl Entity for FallingBlock {
rotation :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: self.rotation
}
set_rotation :: proc(self: ^Self, pitch]: [f32; 2]) {
}
    // rust: let previous = self.rotation();
    // rust: let yaw = if yaw.is_finite() { yaw } else { previous[0] };
    // rust: let pitch = if pitch.is_nan() { previous[1] } else { pitch };
    // rust: self.rotation = [yaw, pitch.clamp(-90.0, 90.0)];
}
ticks_after_projectiles :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
native_type :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: "minecraft:falling_block".into()
}
    // rust: fn save_nbt(
    // rust: game: &mut Game<'_>,
    // rust: index: usize,
    // rust: keys: &HashSet<ChunkKey>,
    // rust: ) -> Option<(ChunkKey, Tag)> {
    // rust: game.save_falling(index, keys)
}
    // rust: fn load_nbt(
    // rust: game: &mut Game<'_>,
    // rust: kind: &str,
    // rust: uuid: Option<[i32; 4]>,
    // rust: _player_uuid: Option<[i32; 4]>,
    // rust: tag: Tag,
    // rust: ) -> Result<(), Tag> {
    // rust: if !(kind == "minecraft:falling_block") {
    // rust: return Err(tag);
}
    // rust: game.load_falling(tag, uuid);
    // rust: Ok(())
}
    // rust: stored_motion!();
selector_target :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(Target::Falling(self.id))
}
bounds :: proc(self: ^Self) -> A {
    // Ported from Horizon
    return {}
}
    // rust: horizon_client::falling_block::bounds(self.position)
}
}

    // rust: impl Entity for Projectile {
rotation :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [self.yaw, self.pitch]
}
set_rotation :: proc(self: ^Self, pitch]: [f32; 2]) {
}
    // rust: let previous = self.rotation();
    // rust: let yaw = if yaw.is_finite() { yaw } else { previous[0] };
    // rust: let pitch = if pitch.is_nan() { previous[1] } else { pitch };
    // rust: self.yaw = yaw;
    // rust: self.pitch = pitch.clamp(-90.0, 90.0);
    // rust: self.previous_yaw = self.yaw;
    // rust: self.previous_pitch = self.pitch;
}
native_type :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: self.kind.id().into()
}
    // rust: fn save_nbt(
    // rust: game: &mut Game<'_>,
    // rust: index: usize,
    // rust: keys: &HashSet<ChunkKey>,
    // rust: ) -> Option<(ChunkKey, Tag)> {
    // rust: game.save_projectile(index, keys)
}
    // rust: fn load_nbt(
    // rust: game: &mut Game<'_>,
    // rust: kind: &str,
    // rust: uuid: Option<[i32; 4]>,
    // rust: player_uuid: Option<[i32; 4]>,
    // rust: tag: Tag,
    // rust: ) -> Result<(), Tag> {
    // rust: match kind {
    // rust: "minecraft:arrow" | "minecraft:spectral_arrow" => {
    // rust: game.load_arrow(tag, uuid, player_uuid)
}
    // rust: "minecraft:llama_spit" | "minecraft:shulker_bullet" => {
    // rust: game.load_spit_or_bullet(tag, player_uuid)
}
    // rust: "minecraft:fireball"
    // rust: | "minecraft:small_fireball"
    // rust: | "minecraft:wind_charge"
    // rust: | "minecraft:breeze_wind_charge" => game.load_fireball(tag, uuid, player_uuid),
    // rust: id if horizon_client::entity_nbt::throwable_kind(id).is_some() => {
    // rust: game.load_throwable(tag, uuid, player_uuid)
}
    // rust: _ => return Err(tag),
}
    // rust: Ok(())
}
    // rust: stored_motion!();
    // Arrows and the thrown items and fireballs a chunk saves.
portal_size :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: (super::nether_portal::is_arrow(self) || super::nether_portal::is_portal_projectile(self))
    // rust: .then(|| super::nether_portal::projectile_box(self))
}
portal_from :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(self.previous)
}
portal_sweeps :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !super::nether_portal::is_arrow(self) || !self.stuck || self.previous != self.position
}
selector_target :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
//         use horizon_client::projectiles::ProjectileKind as K;
        // The kinds /data can write (entity_nbt).
    // rust: let selectable = self.is_arrow()
    // rust: || horizon_client::entity_nbt::saved_with_chunk(self)
    // rust: || matches!(
    // rust: self.kind,
    // rust: K::LargeFireball { .. } | K::SmallFireball | K::WindCharge | K::BreezeWindCharge
    // rust: );
    // rust: selectable.then_some(Target::Projectile(self.id))
}
    // `AbstractArrow.push` does nothing in the ground; a wind charge's motion
    // stays 0.
pushed_by_explosion :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.stuck && !self.kind.ignores_blast()
}
explosion_eye_height :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.kind.eye_height()
}
push_from_explosion :: proc(self: ^Self, push: Vec3) {
}
    // rust: self.velocity = Vec3::new(
    // rust: self.velocity.x + push.x,
    // rust: self.velocity.y + push.y,
    // rust: self.velocity.z + push.z,
    // rust: );
    // rust: self.needs_sync = true;
}
bounds :: proc(self: ^Self) -> A {
    // Ported from Horizon
    return {}
}
    // rust: Projectile::bounds(self)
}
move_by_piston :: proc(self: ^Self, movement: Vec3) {
}
    // rust: self.position = self.position.add_vector(movement);
    // rust: self.needs_sync = true;
}
piston_slime_bounce :: proc(self: ^Self, movement: Direction) {
}
    // rust: self.velocity = piston_push::bounce_velocity(movement, self.velocity);
    // rust: self.needs_sync = true;
}
}

    // rust: impl Entity for Rocket {
rotation :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: self.rotation
}
set_rotation :: proc(self: ^Self, pitch]: [f32; 2]) {
}
    // rust: let previous = self.rotation();
    // rust: let yaw = if yaw.is_finite() { yaw } else { previous[0] };
    // rust: let pitch = if pitch.is_nan() { previous[1] } else { pitch };
    // rust: self.rotation = [yaw, pitch.clamp(-90.0, 90.0)];
}
native_type :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: "minecraft:firework_rocket".into()
}
    // rust: fn save_nbt(
    // rust: game: &mut Game<'_>,
    // rust: index: usize,
    // rust: keys: &HashSet<ChunkKey>,
    // rust: ) -> Option<(ChunkKey, Tag)> {
    // rust: game.save_rocket(index, keys)
}
    // rust: fn load_nbt(
    // rust: game: &mut Game<'_>,
    // rust: kind: &str,
    // rust: uuid: Option<[i32; 4]>,
    // rust: player_uuid: Option<[i32; 4]>,
    // rust: tag: Tag,
    // rust: ) -> Result<(), Tag> {
    // rust: if !(kind == "minecraft:firework_rocket") {
    // rust: return Err(tag);
}
    // rust: game.load_rocket(tag, uuid, player_uuid);
    // rust: Ok(())
}
    // rust: stored_motion!();
    // A rocket that carries its owner stays.
portal_size :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: (self.attached_to.is_none() && !self.attached).then_some((0.25, 0.25))
}
portal_from :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(self.previous)
}
selector_target :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(Target::Rocket(self.id))
}
    // 0.25 wide, so 0.2125 to the eyes.
explosion_eye_height :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 0.2125
}
bounds :: proc(self: ^Self) -> A {
    // Ported from Horizon
    return {}
}
    // rust: Rocket::bounds(self)
}
    // `FireworkRocketEntity.tick`: boosting a player skips the step.
sweeps_blocks_inside :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.attached
}
}

    // rust: impl Entity for ThrownTrident {
rotation :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [self.yaw, self.pitch]
}
set_rotation :: proc(self: ^Self, pitch]: [f32; 2]) {
}
    // rust: let previous = self.rotation();
    // rust: let yaw = if yaw.is_finite() { yaw } else { previous[0] };
    // rust: let pitch = if pitch.is_nan() { previous[1] } else { pitch };
    // rust: self.yaw = yaw;
    // rust: self.pitch = pitch.clamp(-90.0, 90.0);
}
native_type :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: "minecraft:trident".into()
}
    // rust: fn save_nbt(
    // rust: game: &mut Game<'_>,
    // rust: index: usize,
    // rust: keys: &HashSet<ChunkKey>,
    // rust: ) -> Option<(ChunkKey, Tag)> {
    // rust: game.save_trident(index, keys)
}
    // rust: fn load_nbt(
    // rust: game: &mut Game<'_>,
    // rust: kind: &str,
    // rust: uuid: Option<[i32; 4]>,
    // rust: _player_uuid: Option<[i32; 4]>,
    // rust: tag: Tag,
    // rust: ) -> Result<(), Tag> {
    // rust: if !(kind == "minecraft:trident") {
    // rust: return Err(tag);
}
    // rust: game.load_trident(tag, uuid);
    // rust: Ok(())
}
    // rust: stored_motion!();
portal_size :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some((0.5, 0.5))
}
portal_from :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(self.previous)
}
portal_sweeps :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.in_ground || self.previous != self.position
}
selector_target :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(Target::Trident(self.id))
}
    // Like any arrow (`AbstractArrow.push`) not pushed while in the ground.
pushed_by_explosion :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.in_ground
}
    // `EntityType.TRIDENT`: eyes at 0.13.
explosion_eye_height :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: f64::from(0.13_f32)
}
bounds :: proc(self: ^Self) -> A {
    // Ported from Horizon
    return {}
}
    // rust: let p = self.position;
    // rust: Aabb::new(
    // rust: Vec3::new(p.x - 0.25, p.y, p.z - 0.25),
    // rust: Vec3::new(p.x + 0.25, p.y + 0.5, p.z + 0.25),
    // rust: )
}
    // `GameLevel::tick_blocks` sweeps tridents itself.
sweeps_blocks_inside :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
}

    // rust: impl EntityRules for Rocket {}
    // rust: impl EntityRules for ThrownTrident {}
    // rust: impl EntityRules for Boat {
is_no_gravity :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.no_gravity
}
    // `AbstractBoat.getDefaultGravity`.
get_default_gravity :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 0.04
}
}
    // rust: impl EntityRules for Minecart {
is_no_gravity :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.no_gravity
}
    // `AbstractMinecart.getDefaultGravity`.
get_default_gravity :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if self.in_water { 0.005 } else { 0.04 }
}
}
    // rust: impl EntityRules for PrimedTnt {
is_no_gravity :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.no_gravity
}
    // `PrimedTnt.getDefaultGravity`.
get_default_gravity :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 0.04
}
}
    // rust: impl EntityRules for FallingBlock {
is_no_gravity :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.no_gravity
}
    // `FallingBlockEntity.getDefaultGravity`.
get_default_gravity :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 0.04
}
}

    // rust: mod no_gravity_stand_tests {
//     use super::Entity as _;
//     use horizon_client::entities::ArmorStand;
//     use horizon_core::geometry::Vec3;

a_no_gravity_stand_is_not_swept_for_the_blocks_it_is_in :: proc() {
}
    // rust: let mut stand = ArmorStand::new(1, Vec3::new(0.5, 100.0, 0.5), 0.0);
        // A resting stand presses a plate (measured beside the real server)...
    // rust: assert!(stand.sweeps_blocks_inside() && stand.triggers_blocks());
        // ...a NoGravity one does not, nor does a marker.
    // rust: stand.no_gravity = true;
    // rust: assert!(!stand.sweeps_blocks_inside());
    // rust: stand.no_gravity = false;
    // rust: stand.marker = true;
    // rust: assert!(!stand.triggers_blocks());
}
}

    // rust: mod load_claim_tests {
    // `Mob` is first in `entity_lists!` and claims every id in `mob_types`;
    // the old load tried every other kind first. Both agree only while no
    // mob species shares an id with another kind, which this checks.
no_mob_species_is_an_id_another_kind_loads :: proc() {
}
    // rust: let others = [
    // rust: "minecraft:item",
    // rust: "minecraft:experience_orb",
    // rust: "minecraft:arrow",
    // rust: "minecraft:spectral_arrow",
    // rust: "minecraft:llama_spit",
    // rust: "minecraft:shulker_bullet",
    // rust: "minecraft:fireball",
    // rust: "minecraft:small_fireball",
    // rust: "minecraft:wind_charge",
    // rust: "minecraft:breeze_wind_charge",
    // rust: "minecraft:falling_block",
    // rust: "minecraft:trident",
    // rust: "minecraft:firework_rocket",
    // rust: "minecraft:tnt",
    // rust: "minecraft:armor_stand",
    // rust: "minecraft:ominous_item_spawner",
    // rust: "minecraft:ender_dragon",
    // rust: "minecraft:end_crystal",
    // rust: "minecraft:item_frame",
    // rust: "minecraft:glow_item_frame",
    // rust: "minecraft:cushion",
    // rust: "minecraft:painting",
    // rust: ];
    // rust: for def in horizon_client::mobs::species::ALL {
    // rust: let id = format!("minecraft:{}", def.name);
    // rust: assert!(!others.contains(&id.as_str()), "{id}");
    // rust: assert!(
    // rust: horizon_client::entity_nbt::throwable_kind(&id).is_none(),
    // rust: "{id}"
    // rust: );
    // rust: assert!(super::super::boats::any_boat_wood(&id).is_none(), "{id}");
    // rust: assert!(
    // rust: super::super::minecarts::CartKind::from_id(&id).is_none(),
    // rust: "{id}"
    // rust: );
}
}
}

    // rust: mod trident_selector_tests {
//     use super::Entity as _;
//     use crate::game::{commands::Target, trident::ThrownTrident};
//     use horizon_core::geometry::Vec3;

    // `@e`, `/kill` and `/data` reach a thrown trident like any other entity
    // (`EntityTypeTest.forClass(Entity.class)`: every entity in the level).
a_thrown_trident_is_a_selector_target :: proc() {
}
    // rust: let t = ThrownTrident::remote(9, Vec3::new(0.5, 100.0, 0.5), 0.0, 0.0);
    // rust: assert_eq!(t.selector_target(), Some(Target::Trident(9)));
}
}

    // rust: mod join_order_tests {
//     use super::{EntityHandle, EntityLists, JoinOrderError};
//     use crate::game::{boats::Boat, fireworks::Rocket, trident::ThrownTrident};
//     use horizon_client::entities::ArmorStand;
//     use horizon_client::join_seq::JoinList;
//     use horizon_core::geometry::Vec3;

at :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: Vec3::new(0.5, 100.0, 0.5)
}

Lists :: struct {
    stands: JoinList<ArmorStand>,
    tridents: JoinList<ThrownTrident>,
    rockets: JoinList<Rocket>,
    boats: JoinList<Boat>,
}

    // rust: impl Lists {
view :: proc(self: ^Self) -> E {
    // Ported from Horizon
    return {}
}
    // rust: EntityLists {
    // rust: mobs: &[],
    // rust: dropped: &[],
    // rust: boats: &self.boats,
    // rust: carts: &[],
    // rust: armor_stands: &self.stands,
    // rust: tnts: &[],
    // rust: falling: &[],
    // rust: orbs: &[],
    // rust: projectiles: &[],
    // rust: rockets: &self.rockets,
    // rust: tridents: &self.tridents,
}
}
walk :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut seen = Vec::new();
    // rust: self.view().walk_in_join_order(|h, _| seen.push(h))?;
    // rust: Ok(seen)
}
}

    // Joins five kinds' entities interleaved, the way a level gets them.
mixed :: proc() -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut l = Lists {
    // rust: stands: JoinList::default(),
    // rust: tridents: JoinList::default(),
    // rust: rockets: JoinList::default(),
    // rust: boats: JoinList::default(),
}
    // rust: l.trident(1);
    // rust: l.rocket(2);
    // rust: l.stand(3);
    // rust: l.boat(4);
    // rust: l.trident(5);
    // rust: l.stand(6);
    // rust: l.rocket(7);
    // rust: let joined = vec![
    // rust: EntityHandle::Trident(0),
    // rust: EntityHandle::Rocket(0),
    // rust: EntityHandle::ArmorStand(0),
    // rust: EntityHandle::Boat(0),
    // rust: EntityHandle::Trident(1),
    // rust: EntityHandle::ArmorStand(1),
    // rust: EntityHandle::Rocket(1),
    // rust: ];
    // rust: (l, joined)
}

    // rust: impl Lists {
stand :: proc(self: ^Self, id: u32) {
}
    // rust: self.stands.push(ArmorStand::new(id, at(), 0.0));
}
trident :: proc(self: ^Self, id: u32) {
}
    // rust: self.tridents
    // rust: .push(ThrownTrident::remote(id, at(), 0.0, 0.0));
}
rocket :: proc(self: ^Self, id: u32) {
}
    // rust: self.rockets.push(Rocket::remote(id, at(), Vec3::ZERO));
}
boat :: proc(self: ^Self, id: u32) {
}
    // rust: self.boats.push(Boat::new(id, "oak".into(), at(), 0.0));
}
}

    // The walk visits entities in the order they joined, not list by list.
mixed_kinds_are_visited_in_join_order :: proc() {
}
    // rust: let (lists, joined) = mixed();
    // rust: assert_eq!(lists.walk().unwrap(), joined);
        // Walked list by list they would come in another order.
    // rust: assert_ne!(joined[0], EntityHandle::ArmorStand(0));
}

    // An entity taken out and put back (a tick takes its list) keeps its place.
an_entity_put_back_keeps_its_join_number :: proc() {
}
    // rust: let (mut lists, joined) = mixed();
    // rust: let taken = std::mem::take(&mut lists.tridents);
    // rust: let before: Vec<_> = taken
    // rust: .iter()
    // rust: .map(horizon_client::join_seq::Joined::join_seq)
    // rust: .collect();
    // rust: let mut back = JoinList::default();
    // rust: for t in taken {
    // rust: back.push(t);
}
    // rust: lists.tridents = back;
    // rust: let after: Vec<_> = lists
    // rust: .tridents
    // rust: .iter()
    // rust: .map(horizon_client::join_seq::Joined::join_seq)
    // rust: .collect();
    // rust: assert_eq!(before, after);
    // rust: assert_eq!(lists.walk().unwrap(), joined);
}

    // The walk is checked: a list out of join order, or an entity that never
    // went through the list's `push`, is reported and not walked past.
the_walk_reports_a_list_out_of_order_and_an_entity_that_never_joined :: proc() {
}
    // rust: let (mut lists, _) = mixed();
    // rust: lists.tridents.swap(0, 1);
    // rust: assert!(matches!(lists.walk(), Err(JoinOrderError::OutOfOrder(_))));
    // rust: let (mut lists, _) = mixed();
    // rust: Vec::push(&mut lists.stands, ArmorStand::new(9, at(), 0.0));
    // rust: assert_eq!(
    // rust: lists.walk(),
    // rust: Err(JoinOrderError::Unjoined(EntityHandle::ArmorStand(2)))
    // rust: );
}
}

    // rust: mod set_rotation_tests {
//     use super::Entity as _;
//     use horizon_client::entities::ExperienceOrb;

    // `Entity.teleportSetPosition`: yaw as given, pitch clamped to -90..90, on
    // every kind (the ones with no field of their own used to drop it).
set_rotation_keeps_yaw_and_clamps_pitch_on_kinds_that_had_none :: proc() {
}
    // rust: let mut orb = ExperienceOrb {
    // rust: join: Default::default(),
    // rust: no_gravity: false,
    // rust: id: 0,
    // rust: position: horizon_core::geometry::Vec3::ZERO,
    // rust: previous: horizon_core::geometry::Vec3::ZERO,
    // rust: velocity: horizon_core::geometry::Vec3::ZERO,
    // rust: value: 1,
    // rust: age: 0,
    // rust: on_ground: false,
    // rust: count: 1,
    // rust: ticks: 0,
    // rust: health: 5,
    // rust: rotation: [0.0, 0.0],
}
    // rust: orb.set_rotation([90.0, 10.0]);
    // rust: assert_eq!(orb.rotation(), [90.0, 10.0]);
    // rust: orb.set_rotation([0.0, 200.0]);
    // rust: assert_eq!(orb.rotation(), [0.0, 90.0]);
}
}
