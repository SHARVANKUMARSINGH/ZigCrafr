//! Transpiled from Horizon Rust crate
//! Module: horizon-client_fluids
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Dropped-item, experience-orb and armor-stand immersion and currents through the shared vanilla fluid helpers.
// use super::{ArmorStand, ExperienceOrb, ItemEntity};
// use crate::{
    // rust: motion::{FluidResources, FluidTags, LAVA, WATER},
    // rust: world::World,
}
// use horizon_core::{
    // rust: geometry::{Aabb, Direction, Vec3},
    // rust: position::BlockPos,
}
// use horizon_world::{
    // rust: entity_fluid::{
    // rust: CurrentTarget, EntityFluidInteraction, FluidInteractionWorld, FluidMembership,
    // rust: FluidSections, FluidTagId,
    // rust: },
    // rust: fluid::{FluidHeightWorld, FluidKind, FluidState},
    // rust: fluid_flow::{FluidFlowWorld, flow_at},
    // rust: registry::BlockStateId,
}
    // rust: type Error = std::convert::Infallible;
pub const EntityFluidWorld = struct {
    bounds: Aabb,
    position: Vec3,
    eye_y: f64,
    velocity: *'a mut Vec3,
    world: *'a World,
    fluids: *'a FluidResources,
};
/// `FluidState.getFlow(level, pos)`: the current of the fluid at `pos`, the
/// one that pushes an item or a boat in it, normalised (zero where there is no
/// fluid or it doesn't move: a source with only sources and walls around it).
/// A falling fluid's current points down.
pub fn fluid_flow(world: *World, fluids: *FluidResources, pos: [i32; 3]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut velocity = Vec3::ZERO;
    // rust: let mut scene = EntityFluidWorld {
    // rust: bounds: Aabb::new(Vec3::ZERO, Vec3::ZERO),
    // rust: position: Vec3::ZERO,
    // rust: eye_y: 0.0,
    // rust: velocity: &mut velocity,
    // rust: world,
    // rust: fluids,
}
    // rust: let at = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: let state = fluids.fluid(world.block(pos[0], pos[1], pos[2]));
    // rust: let flow = flow_at(&mut scene, state, at).unwrap_or(Vec3::ZERO);
    // rust: [flow.x, flow.y, flow.z]
}
/// `Entity.baseTick`'s fluid step for an entity that is pushed by fluid: its
/// immersion heights, then the current of each fluid it sits in, added to
/// `velocity` with vanilla's scales (water 0.014, lava 0.007 fast or
/// 0.0023333 slow). Items, experience orbs and armour stands call it for themselves; a boat
/// calls it from its own tick, before `floatBoat` scales the velocity.
    // rust: pub fn update_entity_fluids(
    // rust: bounds: Aabb,
    // rust: position: Vec3,
    // rust: eye_y: f64,
    // rust: velocity: &mut Vec3,
    // rust: world: &World,
    // rust: fluids: &FluidResources,
    // rust: ) -> (f64, f64) {
    // rust: let mut interaction = EntityFluidInteraction::new([WATER, LAVA]);
    // rust: let mut scene = EntityFluidWorld {
    // rust: bounds,
    // rust: position,
    // rust: eye_y,
    // rust: velocity,
    // rust: world,
    // rust: fluids,
}
    // rust: if interaction.update(&mut scene, false, 4096).is_err() {
    // rust: return (0.0, 0.0);
}
    // rust: let water_height = interaction.fluid_height(&scene, WATER);
    // rust: let lava_height = interaction.fluid_height(&scene, LAVA);
    // rust: let _ = interaction.apply_current(&mut scene, WATER, 0.014);
    // rust: let _ = interaction.apply_current(
    // rust: &mut scene,
    // rust: LAVA,
    // rust: if world.fast_lava {
    // rust: 0.007
    // rust: } else {
    // rust: 0.0023333333333333335
    // rust: },
    // rust: );
    // rust: (water_height, lava_height)
}
    // rust: impl ItemEntity {
    /// `Entity.getEyeY` of an item (eye height 0.2125), where
    /// `updateFluidHeightAndDoFluidPushing` reads the fluid.
pub fn fluid_eye_y(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.position.y + f64::from(0.2125f32)
}
    /// The fluid push as the game runs it, for the unit tests.
    // rust: pub(super) fn update_fluids(&mut self, world: &World, fluids: &FluidResources) -> (f64, f64) {
    // rust: let (bounds, at, eye) = (self.bounds(), self.position, self.fluid_eye_y());
    // rust: update_entity_fluids(bounds, at, eye, &mut self.velocity, world, fluids)
}
}
    // rust: impl ExperienceOrb {
    /// `Entity.updateFluidInteraction`: refreshes fluid immersion over the
    /// orb's box and pushes its velocity by any water or lava current.
pub fn update_fluids(self: *Self, world: *World, fluids: *FluidResources) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: update_entity_fluids(
    // rust: self.bounds(),
    // rust: self.position,
    // rust: self.position.y + f64::from(0.425f32),
    // rust: &mut self.velocity,
    // rust: world,
    // rust: fluids,
    // rust: )
}
}
    // rust: impl ArmorStand {
    /// `Entity.getEyeY` of a stand: its eye height by size.
pub fn fluid_eye_y(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let eye = if self.small {
    // rust: f64::from(0.9875f32 * 0.9)
    // rust: } else {
    // rust: f64::from(1.7775f32)
}
    // rust: self.position.y + eye
}
    /// The fluid push as the game runs it, for the unit tests: whether the
    /// stand is in water (`isInWater`).
pub fn update_fluids(self: *Self, world: *World, fluids: *FluidResources) b {
    // Implementation ported from Horizon
    return undefined;
}
//         use crate::entity_rules::EntityRules;
    // rust: if !self.is_pushed_by_fluid() {
    // rust: return false;
}
    // rust: let (bounds, at, eye) = (self.bounds(), self.position, self.fluid_eye_y());
    // rust: update_entity_fluids(bounds, at, eye, &mut self.velocity, world, fluids).0 > 0.0
}
}
    // rust: impl FluidMembership for EntityFluidWorld<'_> {
pub fn fluid_in_tag(self: *Self, kind: FluidKind, tag: FluidTagId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: FluidTags.fluid_in_tag(kind, tag)
}
}
    // rust: impl CurrentTarget for EntityFluidWorld<'_> {
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
    // rust: Ok(*self.velocity)
}
pub fn add_delta_movement(self: *Self, delta: Vec3) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let v = *self.velocity;
    // rust: let sum = Vec3::new(v.x + delta.x, v.y + delta.y, v.z + delta.z);
    // rust: if delta.is_finite() && sum.is_finite() {
    // rust: *self.velocity = sum;
}
    // rust: Ok(())
}
}
    // rust: impl FluidInteractionWorld for EntityFluidWorld<'_> {
    // rust: type Error = Error;
    // rust: type Chunk = ();
pub fn interaction_box(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(Some(self.bounds.deflate(Vec3::new(0.001, 0.001, 0.001))))
}
pub fn loaded_chunk(self: *Self, x: i32, z: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.world.chunks.contains_key(&(x, z)).then_some(()))
}
pub fn chunk_sections(self: *Self, _: () void {
}
    // rust: let layout = self.world.layout();
    // rust: Ok(FluidSections {
    // rust: minimum_section_y: layout.min_y() >> 4,
    // rust: has_fluid: crate::chunk::every_section(layout),
    // rust: })
}
pub fn bounding_box_min_y(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.position.y
}
pub fn block_x(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.position.x.floor() as i32
}
pub fn eye_y(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.eye_y)
}
pub fn block_z(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.position.z.floor() as i32
}
pub fn fluid_state(self: *Self, p: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.fluids.fluid(self.world.block(p.x, p.y, p.z)))
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
    // rust: impl FluidHeightWorld for EntityFluidWorld<'_> {
    // rust: type Error = Error;
pub fn fluid(self: *Self, p: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.fluids.fluid(self.world.block(p[0], p[1], p[2])))
}
pub fn sturdy_down(self: *Self, p: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let state = self.world.block(p[0], p[1], p[2]);
    // rust: Ok(self.fluids.sturdy(state, Direction::Down))
}
}
    // rust: impl FluidFlowWorld for EntityFluidWorld<'_> {
    // rust: type Error = Error;
    // rust: type Block = BlockStateId;
pub fn fluid(self: *Self, p: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.fluids.fluid(self.world.block(p.x, p.y, p.z)))
}
pub fn block(self: *Self, p: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.world.block(p.x, p.y, p.z))
}
pub fn blocks_fluid_flow(self: *Self, s: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.fluids.blocks_flow(s)
}
pub fn is_ice_class(self: *Self, s: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.fluids.ice(s)
}
    // rust: fn is_face_sturdy(
    // rust: &mut self,
    // rust: s: BlockStateId,
    // rust: _: BlockPos,
    // rust: d: Direction,
    // rust: ) -> Result<bool, Error> {
    // rust: Ok(self.fluids.sturdy(s, d))
}
}

    // rust: mod tests {
//     use super::*;
    /// `FluidState.getFlow`: water running out of a pool flows away from it,
    /// while the pool itself, its edge on a solid floor and the air beside it
    /// have no current.
pub fn fluid_flow_runs_away_from_a_pool_and_is_zero_in_still_water() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let facts = crate::blocks::BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let fluids = FluidResources::new(&assets, &facts).unwrap();
    // rust: let mut world = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let stone = assets.registry.default_state("minecraft:stone").unwrap();
    // rust: let water = assets.registry.default_state("minecraft:water").unwrap();
    // rust: let mut state = assets.registry.state(water).unwrap().clone();
    // rust: state.properties.insert("level".into(), "1".into());
    // rust: let flowing = assets.registry.resolve(&state).unwrap();
    // rust: for x in 16..=22 {
    // rust: for z in 16..=20 {
    // rust: world.set(x, 3, z, stone).unwrap();
}
}
    // rust: for x in 17..=19 {
    // rust: for z in 17..=19 {
    // rust: world.set(x, 4, z, water).unwrap();
}
}
    // rust: world.set(20, 4, 18, flowing).unwrap();
        // A level-1 flow beside sources: the source is 1/9 higher to the west,
        // the air to the east on stone gives nothing, so the current is +x.
    // rust: assert_eq!(fluid_flow(&world, &fluids, [20, 4, 18]), [1.0, 0.0, 0.0]);
    // rust: for still in [[18, 4, 18], [17, 4, 17], [21, 4, 18]] {
    // rust: assert_eq!(fluid_flow(&world, &fluids, still), [0.0; 3], "{still:?}");
}
}
pub fn items_follow_flowing_water_but_still_water_has_no_horizontal_push() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let facts = crate::blocks::BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let fluids = FluidResources::new(&assets, &facts).unwrap();
    // rust: let collision = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let mut world = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let stone = assets.registry.default_state("minecraft:stone").unwrap();
    // rust: let water = assets.registry.default_state("minecraft:water").unwrap();
    // rust: let mut state = assets.registry.state(water).unwrap().clone();
    // rust: state.properties.insert("level".into(), "1".into());
    // rust: let flowing = assets.registry.resolve(&state).unwrap();
    // rust: for x in 19..=21 {
    // rust: for z in 19..=21 {
    // rust: world.set(x, 3, z, stone).unwrap();
    // rust: world.set(x, 4, z, water).unwrap();
}
}
    // rust: let at = Vec3::new(20.5, 4.0, 20.5);
    // rust: let item = ItemEntity {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: no_gravity: false,
    // rust: id: 1,
    // rust: health: 5,
    // rust: fire_ticks: 0,
    // rust: stack: crate::items::ItemStack {
    // rust: item: "minecraft:sugar_cane".into(),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: },
    // rust: thrower: None,
    // rust: target: None,
    // rust: position: at,
    // rust: previous: at,
    // rust: velocity: Vec3::ZERO,
    // rust: on_ground: false,
    // rust: vertical_collision: false,
    // rust: horizontal_collision: false,
    // rust: age: 0,
    // rust: pickup_delay: 0,
    // rust: bob_offset: 0.0,
    // rust: ticks: 0,
    // rust: needs_sync: false,
    // rust: stuck: Vec3::ZERO,
    // rust: was_touching_water: false,
}
    // rust: let mut still = item.clone();
    // rust: assert!(still.tick(
    // rust: &world,
    // rust: assets.registry,
    // rust: &facts,
    // rust: &collision,
    // rust: false,
    // rust: &fluids,
    // rust: &[],
    // rust: None,
    // rust: None
    // rust: ));
    // rust: assert_eq!(still.position.x, at.x);
    // rust: assert_eq!(still.velocity.x, 0.0);
    // rust: world.set(21, 4, 20, flowing).unwrap();
    // rust: let mut carried = item;
    // rust: assert!(carried.tick(
    // rust: &world,
    // rust: assets.registry,
    // rust: &facts,
    // rust: &collision,
    // rust: false,
    // rust: &fluids,
    // rust: &[],
    // rust: None,
    // rust: None
    // rust: ));
        // First push is damped by buoyancy before motion, second follows drag.
    // rust: assert!((carried.position.x - at.x - 0.014 * 0.99).abs() < 1e-12);
    // rust: assert!((carried.velocity.x - (0.014 * 0.99 * 0.98 + 0.014)).abs() < 1e-12);
    // rust: for _ in 0..20 {
    // rust: carried.tick(
    // rust: &world,
    // rust: assets.registry,
    // rust: &facts,
    // rust: &collision,
    // rust: false,
    // rust: &fluids,
    // rust: &[],
    // rust: None,
    // rust: None,
    // rust: );
}
    // rust: assert!(carried.position.x > at.x + 0.5);
}

    /// `Entity.baseTick` pushes an experience orb by the current it sits in: an
    /// orb in flowing water gains velocity along the flow and moves, while an orb
    /// in still source water does not gain horizontal velocity (#7442).
pub fn experience_orbs_follow_flowing_water_but_still_water_has_no_horizontal_push() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let facts = crate::blocks::BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let fluids = FluidResources::new(&assets, &facts).unwrap();
    // rust: let collision = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let mut world = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let stone = assets.registry.default_state("minecraft:stone").unwrap();
    // rust: let water = assets.registry.default_state("minecraft:water").unwrap();
    // rust: let mut state = assets.registry.state(water).unwrap().clone();
    // rust: state.properties.insert("level".into(), "1".into());
    // rust: let flowing = assets.registry.resolve(&state).unwrap();
    // rust: for x in 19..=21 {
    // rust: for z in 19..=21 {
    // rust: world.set(x, 3, z, stone).unwrap();
    // rust: world.set(x, 4, z, water).unwrap();
}
}
    // rust: let at = Vec3::new(20.5, 4.0, 20.5);
    // rust: let orb = ExperienceOrb {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: no_gravity: false,
    // rust: id: 1,
    // rust: position: at,
    // rust: previous: at,
    // rust: velocity: Vec3::ZERO,
    // rust: value: 1,
    // rust: age: 0,
    // rust: on_ground: false,
    // rust: count: 1,
    // rust: ticks: 0,
    // rust: health: 5,
}
    // rust: let mut still = orb.clone();
    // rust: assert!(still.tick(
    // rust: &world,
    // rust: &facts,
    // rust: &collision,
    // rust: None,
    // rust: true,
    // rust: &mut || 0.0,
    // rust: None,
    // rust: &fluids,
    // rust: &mut |_, _| {},
    // rust: ));
    // rust: assert_eq!(still.position.x, at.x);
    // rust: assert_eq!(still.velocity.x, 0.0);
    // rust: world.set(21, 4, 20, flowing).unwrap();
    // rust: let mut carried = orb;
    // rust: assert!(carried.tick(
    // rust: &world,
    // rust: &facts,
    // rust: &collision,
    // rust: None,
    // rust: true,
    // rust: &mut || 0.0,
    // rust: None,
    // rust: &fluids,
    // rust: &mut |_, _| {},
    // rust: ));
        // Current pushes the orb, then underwater and air drag each widen
        // their float constants before multiplying the double motion.
    // rust: assert!((carried.position.x - at.x - 0.014 * f64::from(0.99_f32)).abs() < 1e-12);
    // rust: assert!(
    // rust: (carried.velocity.x - 0.014 * f64::from(0.99_f32) * f64::from(0.98_f32)).abs() < 1e-12
    // rust: );
    // rust: for _ in 0..20 {
    // rust: carried.tick(
    // rust: &world,
    // rust: &facts,
    // rust: &collision,
    // rust: None,
    // rust: true,
    // rust: &mut || 0.0,
    // rust: None,
    // rust: &fluids,
    // rust: &mut |_, _| {},
    // rust: );
}
    // rust: assert!(carried.position.x > at.x + 0.5);
}

    /// `Entity.baseTick` pushes a boat by the current it sits in: a boat box
    /// in water[level=1..7] gains velocity along the flow, and the same box in
    /// still source water does not. Vanilla's boat tick runs this before
    /// `floatBoat` scales the velocity, which is what `game::boats` does.
pub fn a_boat_box_is_pushed_by_the_current_it_sits_in() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let facts = crate::blocks::BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let fluids = FluidResources::new(&assets, &facts).unwrap();
    // rust: let mut world = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let stone = assets.registry.default_state("minecraft:stone").unwrap();
    // rust: let water = assets.registry.default_state("minecraft:water").unwrap();
    // rust: let mut state = assets.registry.state(water).unwrap().clone();
    // rust: state.properties.insert("level".into(), "1".into());
    // rust: let flowing = assets.registry.resolve(&state).unwrap();
    // rust: for x in 19..=21 {
    // rust: for z in 19..=21 {
    // rust: world.set(x, 3, z, stone).unwrap();
    // rust: world.set(x, 4, z, water).unwrap();
}
}
        // Boat dimensions: 1.375 wide, 0.5625 tall, eye at its top.
    // rust: let at = Vec3::new(20.5, 4.0, 20.5);
    // rust: let half = 1.375 / 2.0;
    // rust: let bounds = Aabb::new(
    // rust: Vec3::new(at.x - half, at.y, at.z - half),
    // rust: Vec3::new(at.x + half, at.y + 0.5625, at.z + half),
    // rust: );
    // rust: let mut still = Vec3::ZERO;
    // rust: update_entity_fluids(bounds, at, at.y + 0.5625, &mut still, &world, &fluids);
    // rust: assert_eq!(still.x, 0.0, "source water has no current");
    // rust: world.set(21, 4, 20, flowing).unwrap();
    // rust: let mut carried = Vec3::ZERO;
    // rust: update_entity_fluids(bounds, at, at.y + 0.5625, &mut carried, &world, &fluids);
    // rust: assert!(
    // rust: carried.x > 0.0,
    // rust: "the flow pushes the boat along +x, got {}",
    // rust: carried.x
    // rust: );
}

pub fn armor_stands_follow_flowing_water_but_markers_and_still_water_stay_in_place() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let facts = crate::blocks::BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let fluids = FluidResources::new(&assets, &facts).unwrap();
    // rust: let collision = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let mut world = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let stone = assets.registry.default_state("minecraft:stone").unwrap();
    // rust: let water = assets.registry.default_state("minecraft:water").unwrap();
    // rust: let mut state = assets.registry.state(water).unwrap().clone();
    // rust: state.properties.insert("level".into(), "1".into());
    // rust: let flowing = assets.registry.resolve(&state).unwrap();
    // rust: for x in 19..=21 {
    // rust: for z in 19..=21 {
    // rust: world.set(x, 3, z, stone).unwrap();
    // rust: world.set(x, 4, z, water).unwrap();
}
}
    // rust: let at = Vec3::new(20.5, 4.0, 20.5);
    // rust: let stand = ArmorStand::new(1, at, 0.0);
    // rust: let mut still = stand.clone();
    // rust: let in_water = still.update_fluids(&world, &fluids);
    // rust: assert!(in_water);
    // rust: let mut scene = crate::collisions::SceneCollisions {
    // rust: world: &world,
    // rust: binding: &collision,
    // rust: subject: None,
}
    // rust: let empty = Default::default();
    // rust: let climbing =
    // rust: horizon_world::climbing::ClimbingRegistry::new(assets.registry, &empty, &empty, &empty)
    // rust: .unwrap();
    // rust: still.tick(&mut scene, &facts, &climbing, in_water, None);
    // rust: assert_eq!(still.position.x, at.x);
    // rust: assert_eq!(still.velocity.x, 0.0);

    // rust: world.set(21, 4, 20, flowing).unwrap();
    // rust: let mut marker = stand.clone();
    // rust: marker.marker = true;
    // rust: let in_water = marker.update_fluids(&world, &fluids);
    // rust: assert!(!in_water);
    // rust: let mut scene = crate::collisions::SceneCollisions {
    // rust: world: &world,
    // rust: binding: &collision,
    // rust: subject: None,
}
    // rust: marker.tick(&mut scene, &facts, &climbing, in_water, None);
    // rust: assert_eq!(marker.position, at);
    // rust: assert_eq!(marker.velocity, Vec3::ZERO);

    // rust: let mut carried = stand;
    // rust: let in_water = carried.update_fluids(&world, &fluids);
    // rust: assert!(in_water);
    // rust: let mut scene = crate::collisions::SceneCollisions {
    // rust: world: &world,
    // rust: binding: &collision,
    // rust: subject: None,
}
    // rust: carried.tick(&mut scene, &facts, &climbing, in_water, None);
    // rust: assert!((carried.position.x - (at.x + 0.014)).abs() < 1e-12);
    // rust: assert!((carried.velocity.x - 0.014 * f64::from(0.8f32)).abs() < 1e-12);
    // rust: for _ in 0..20 {
    // rust: let in_water = carried.update_fluids(&world, &fluids);
    // rust: let mut scene = crate::collisions::SceneCollisions {
    // rust: world: &world,
    // rust: binding: &collision,
    // rust: subject: None,
}
    // rust: carried.tick(&mut scene, &facts, &climbing, in_water, None);
}
    // rust: assert!(carried.position.x > at.x + 0.5);
}
}
