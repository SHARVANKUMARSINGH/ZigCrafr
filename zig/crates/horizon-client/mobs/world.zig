//! Transpiled from Horizon Rust crate
//! Module: horizon-client_world
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! What mobs read from the level: block solidity, ray clipping for line of
//! sight (`ClipContext.Block.COLLIDER`), sky visibility, light-dependent
//! values and the positions of other entities.
// use super::{MobWorld, Seen, Who, data};
// use crate::{
    // rust: blocks::{BlockFacts, Fluid},
    // rust: collisions::SceneCollisions,
}
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3, VoxelShape, block_floor_height, traverse_blocks},
    // rust: position::BlockPos,
}
// use horizon_world::{
    // rust: block_collision::{BlockCollisionRegistry, DynamicCollisionWorld},
    // rust: registry::BlockStateId,
}

/// Where a target entity is this tick.
pub const TargetInfo = struct {
    position: Vec3,
    eye_y: f64,
    bounds: Aabb,
    alive: bool,
    can_be_seen_as_enemy: bool,
    is_player: bool,
    creative: bool,
    /// `isPassenger`.
    passenger: bool,
};
    // rust: impl MobWorld<'_> {
    /// The biome's base temperature at a position.
pub fn temperature(self: *Self, x: i32, y: i32, z: i32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world
    // rust: .chunks
    // rust: .get(&(x >> 4, z >> 4))
    // rust: .map_or(0.8, |c| self.biomes.get(c.biome(x, y, z)).temperature)
}
    /// `Heightmap.Types.MOTION_BLOCKING`: above the highest blocking block.
pub fn motion_blocking_height(self: *Self, x: i32, z: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let top = self.world.top_y();
    // rust: (self.world.bottom_y()..top)
    // rust: .rev()
    // rust: .find(|&y| {
    // rust: let f = self.facts.get(self.world.block(x, y, z));
    // rust: f.full_collision || f.fluid != crate::blocks::Fluid::None
    // rust: })
    // rust: .map_or(self.world.bottom_y(), |y| y + 1)
}
    /// BlockState.isSolid (the legacy solid flag).
pub fn solid(self: *Self, x: i32, y: i32, z: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.data.state(self.world.block(x, y, z)).flags & data::SOLID != 0
}
    /// `BlockGetter.getBlockFloorHeight(pos)`: how high the block's collision
    /// shape stands, or how far into it the block below reaches up, minus one
    /// (negative infinity with neither).
pub fn block_floor_height(self: *Self, x: i32, y: i32, z: i32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut scene = SceneCollisions {
    // rust: world: self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: let mut shape = |y: i32| {
    // rust: self.collision
    // rust: .collision_shape(&mut scene, self.world.block(x, y, z), [x, y, z])
    // rust: .unwrap_or_else(|_| VoxelShape::empty())
}
    // rust: let here = shape(y);
    // rust: let below = shape(y - 1);
    // rust: block_floor_height(&here, || &below)
}
pub fn fluid(self: *Self, x: i32, y: i32, z: i32) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.facts.get(self.world.block(x, y, z)).fluid
}
pub fn block_name(self: *Self, x: i32, y: i32, z: i32) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.facts.get(self.world.block(x, y, z)).name
}
    /// A block state property's value.
pub fn prop(self: *Self, x: i32, y: i32, z: i32, key: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.registry
    // rust: .state(self.world.block(x, y, z))
    // rust: .and_then(|s| s.properties.get(key))
    // rust: .map(String::as_str)
}
pub fn has_tag(self: *Self, tag: []const u8, block: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.block_tags.get(tag).is_some_and(|s| s.contains(block))
}
    /// `findBlocksInBoxByManhattanDistance(at, range_xz, range_y).filterState(..).findFirst()`:
    /// the first block `matches` accepts (given its position and name), going
    /// out from `at` by Manhattan distance as `BlockPos.withinBoxByManhattanDistance` does.
    // rust: pub fn nearest_block(
    // rust: &self,
    // rust: at: [i32; 3],
    // rust: range_xz: i32,
    // rust: range_y: i32,
    // rust: matches: impl Fn([i32; 3], &str) -> bool,
    // rust: ) -> Option<[i32; 3]> {
        // Visiting order: distance, then x, then y, then +z before -z.
    // rust: let mut best: Option<((i32, i32, i32, bool), [i32; 3])> = None;
    // rust: for dx in -range_xz..=range_xz {
    // rust: for dy in -range_y..=range_y {
    // rust: for dz in -range_xz..=range_xz {
    // rust: let key = (dx.abs() + dy.abs() + dz.abs(), dx, dy, dz < 0);
    // rust: if best.is_some_and(|(k, _)| k <= key) {
    // rust: continue;
}
    // rust: let p = [at[0] + dx, at[1] + dy, at[2] + dz];
    // rust: let state = self.world.block(p[0], p[1], p[2]);
    // rust: if !self.facts.is_air(state) && matches(p, &self.facts.get(state).name) {
    // rust: best = Some((key, p));
}
}
}
}
    // rust: best.map(|(_, p)| p)
}
    /// Level.clip with COLLIDER shapes (optionally stopping at any fluid): true on a miss.
pub fn clear_between(self: *Self, from: Vec3, to: Vec3, fluids_block: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.clear_between_for(None, from, to, fluids_block)
}
    /// The same for an entity whose `getY()` is `feet_y`: `ClipContext` hands
    /// its `CollisionContext.of(entity)` to every block, so scaffolding is
    /// solid for a viewer above it and open for one below.
    // rust: fn clear_between_for(
    // rust: &self,
    // rust: feet_y: Option<f64>,
    // rust: from: Vec3,
    // rust: to: Vec3,
    // rust: fluids_block: bool,
    // rust: ) -> bool {
    // rust: let context = feet_y.map(horizon_world::collision_context::CollisionContext::position);
    // rust: let mut scene = SceneCollisions {
    // rust: world: self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: let result = traverse_blocks(from, to, 512, |p: BlockPos| {
    // rust: let state = self.world.block(p.x, p.y, p.z);
    // rust: if fluids_block && self.facts.get(state).fluid != Fluid::None {
    // rust: return Some(());
}
    // rust: if self.facts.is_air(state) {
    // rust: return None;
}
    // rust: let shape = match &context {
    // rust: Some(context) => self
    // rust: .collision
    // rust: .collision_shape_with_context(&mut scene, state, p, context),
    // rust: None => self
    // rust: .collision
    // rust: .collision_shape(&mut scene, state, [p.x, p.y, p.z]),
}
    // rust: .ok()?;
    // rust: shape.clip(from, to, p).map(|_| ())
    // rust: });
    // rust: matches!(result, Ok(None))
}
    /// Level.clip with VISUAL shapes and no fluids: true on a miss.
pub fn visual_clear_between(self: *Self, from: Vec3, to: Vec3) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.visual_clip(from, to) == Some(None)
}
    /// Level.clip with VISUAL shapes and no fluids: the block the segment
    /// first hits, if it does.
pub fn visual_hit(self: *Self, from: Vec3, to: Vec3) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.visual_clip(from, to).flatten()
}
pub fn visual_clip(self: *Self, from: Vec3, to: Vec3) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut scene = SceneCollisions {
    // rust: world: self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: let state = |x, y, z| self.world.block(x, y, z);
    // rust: visual_clip(self.facts, self.collision, &mut scene, &state, from, to)
}
    /// Level.clip with COLLIDER shapes and no fluids: where the segment
    /// first hits a block, if it does.
pub fn clip_block(self: *Self, from: Vec3, to: Vec3) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut scene = SceneCollisions {
    // rust: world: self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: let result = traverse_blocks(from, to, 512, |p: BlockPos| {
    // rust: let state = self.world.block(p.x, p.y, p.z);
    // rust: if self.facts.is_air(state) {
    // rust: return None;
}
    // rust: let shape = self
    // rust: .collision
    // rust: .collision_shape(&mut scene, state, [p.x, p.y, p.z])
    // rust: .ok()?;
    // rust: shape.clip(from, to, p).map(|hit| hit.location)
    // rust: });
    // rust: result.ok().flatten()
}
    /// Level.clip with COLLIDER shapes and no fluids: the block the segment
    /// first hits, if it does.
pub fn clip_block_at(self: *Self, from: Vec3, to: Vec3) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut scene = SceneCollisions {
    // rust: world: self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: let result = traverse_blocks(from, to, 512, |p: BlockPos| {
    // rust: let state = self.world.block(p.x, p.y, p.z);
    // rust: if self.facts.is_air(state) {
    // rust: return None;
}
    // rust: let shape = self
    // rust: .collision
    // rust: .collision_shape(&mut scene, state, [p.x, p.y, p.z])
    // rust: .ok()?;
    // rust: shape.clip(from, to, p).map(|_| [p.x, p.y, p.z])
    // rust: });
    // rust: result.ok().flatten()
}
    /// The bounds of the block's collision shape, relative to the block.
pub fn collision_bounds(self: *Self, p: [i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.collision_bounds_of(self.world.block(p[0], p[1], p[2]), p)
}
    /// The same for `state` standing at `p` (a block that was there).
    // rust: pub fn collision_bounds_of(
    // rust: &self,
    // rust: state: horizon_world::registry::BlockStateId,
    // rust: p: [i32; 3],
    // rust: ) -> Option<horizon_core::geometry::Aabb> {
    // rust: let mut scene = SceneCollisions {
    // rust: world: self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: self.collision
    // rust: .collision_shape(&mut scene, state, p)
    // rust: .ok()?
    // rust: .bounds()
}
    /// LivingEntity.hasLineOfSight: eye to eye within 128 blocks.
pub fn line_of_sight(self: *Self, from_eye: Vec3, to: Vec3) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.line_of_sight_for(None, from_eye, to)
}
    /// The same for a viewer standing at `feet_y` (its collision context).
pub fn line_of_sight_for(self: *Self, feet_y: ?f64, from_eye: Vec3, to: Vec3) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let d =
    // rust: (to.x - from_eye.x).powi(2) + (to.y - from_eye.y).powi(2) + (to.z - from_eye.z).powi(2);
    // rust: if d > 128.0 * 128.0 {
    // rust: return false;
}
    // rust: self.clear_between_for(feet_y, from_eye, to, false)
}
    /// Level.canSeeSky: sky light 15 at the position (no roof above).
pub fn can_see_sky(self: *Self, x: i32, y: i32, z: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.nether {
    // rust: return false;
}
    // rust: self.world.light(x, y, z) >> 4 == 15
}
    /// Level.precipitationAt: raining, open to the sky, nothing motion
    /// blocking above, then the biome's precipitation at the position:
    /// `Some(true)` rain, `Some(false)` snow, `None` nothing.
pub fn precipitation_at(self: *Self, x: i32, y: i32, z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.raining || !self.can_see_sky(x, y, z) || self.motion_blocking_height(x, z) > y {
    // rust: return None;
}
    // rust: let chunk = self.world.chunks.get(&(x >> 4, z >> 4))?;
    // rust: let biome = self.biomes.get(chunk.biome(x, y, z));
    // rust: if !biome.precipitation {
    // rust: return None;
}
    // rust: Some(biome.temperature_at(BlockPos::new(x, y, z), self.sea_level) >= 0.15)
}
    /// Level.isRainingAt: the precipitation at the position is rain, not snow
    /// or none.
pub fn raining_at(self: *Self, x: i32, y: i32, z: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.precipitation_at(x, y, z) == Some(true)
}
    /// Level.getLightLevelDependentMagicValue: the dimension's brightness curve
    /// at the raw (sky darkened) light level.
pub fn brightness(self: *Self, x: i32, y: i32, z: i32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let light = self.world.light(x, y, z);
    // rust: let sky = i32::from(light >> 4) - self.sky_darken();
    // rust: let level = sky.max(i32::from(light & 15)).clamp(0, 15) as f32;
        // DimensionType.getBrightness with ambient light 0 (overworld) / 0.1 (nether).
    // rust: let f = level / 15.0;
    // rust: let base = f / (4.0 - 3.0 * f);
    // rust: if self.nether { 0.1 + base * 0.9 } else { base }
}
pub fn sky_darken(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.daylight { 0 } else { 11 }
}
pub fn target_info(self: *Self, who: Who) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some((id, target)) = self.dragon
    // rust: && who == Who::Mob(id)
    // rust: {
    // rust: return Some(target);
}
    // rust: match who {
    // rust: Who::Player => self.player.as_ref().map(|p| TargetInfo {
    // rust: position: p.position,
    // rust: eye_y: p.eye[1],
    // rust: bounds: p.bounds,
    // rust: alive: p.alive,
    // rust: can_be_seen_as_enemy: true,
    // rust: is_player: true,
    // rust: creative: p.creative,
    // rust: passenger: p.passenger,
    // rust: }),
    // rust: Who::Mob(id) => self.seen(id).map(|s| TargetInfo {
    // rust: position: s.position,
    // rust: eye_y: s.eye_y,
    // rust: bounds: s.bounds,
    // rust: alive: s.alive,
    // rust: can_be_seen_as_enemy: !s.playing_dead,
    // rust: is_player: false,
    // rust: creative: false,
    // rust: passenger: s.passenger,
    // rust: }),
}
}
    /// The other mobs whose boxes may meet `area` (callers test the boxes),
    /// in snapshot order: through the grid when there is one, else all.
pub fn others_near(self: *Self, area: Aabb) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut near = Vec::new();
    // rust: let indexed = self
    // rust: .others_grid
    // rust: .is_some_and(|grid| grid.candidates(area, &mut near));
    // rust: let all = (!indexed).then(|| self.others.iter());
    // rust: near.into_iter()
    // rust: .map(|i| &self.others[i as usize])
    // rust: .chain(all.into_iter().flatten())
}
pub fn seen(self: *Self, id: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.others_index {
    // rust: Some(index) => index
    // rust: .get(&id)
    // rust: .and_then(|&i| self.others.get(i as usize))
    // rust: .filter(|s| s.id == id),
    // rust: None => self.others.iter().find(|s| s.id == id),
}
}
    /// Living mobs of the given species within `range` of `from`, nearest first.
    // rust: pub fn nearby<'s>(
    // rust: &'s self,
    // rust: from: Vec3,
    // rust: range: f64,
    // rust: pred: impl Fn(&Seen) -> bool + 's,
    // rust: ) -> impl Iterator<Item = &'s Seen> + 's {
        // A position within `range` puts the box's bottom face in this area
        // (one block wider, as the box test is strict).
    // rust: let r = range + 1.0;
    // rust: let area = Aabb::new(
    // rust: Vec3::new(from.x - r, from.y - r, from.z - r),
    // rust: Vec3::new(from.x + r, from.y + r, from.z + r),
    // rust: );
    // rust: let mut v: Vec<&Seen> = self
    // rust: .others_near(area)
    // rust: .filter(|s| {
    // rust: s.alive
    // rust: && (s.position.x - from.x).abs() <= range
    // rust: && (s.position.y - from.y).abs() <= range
    // rust: && (s.position.z - from.z).abs() <= range
    // rust: })
    // rust: .filter(move |s| pred(s))
    // rust: .collect();
    // rust: v.sort_by(|a, b| {
    // rust: let da = (a.position.x - from.x).powi(2)
    // rust: + (a.position.y - from.y).powi(2)
    // rust: + (a.position.z - from.z).powi(2);
    // rust: let db = (b.position.x - from.x).powi(2)
    // rust: + (b.position.y - from.y).powi(2)
    // rust: + (b.position.z - from.z).powi(2);
    // rust: da.total_cmp(&db)
    // rust: });
    // rust: v.into_iter()
}
}

/// Level.clip with VISUAL shapes and no fluids: the block the segment first
/// hits, None inside when it hits nothing and outside when the segment is
/// too long to walk. Glass and copper grates (`TransparentBlock`) and bars and panes
/// (`IronBarsBlock`) have no visual shape; mud, soul sand and powder snow
/// look like full blocks.
    // rust: pub fn visual_clip<W: DynamicCollisionWorld>(
    // rust: facts: &BlockFacts,
    // rust: collision: &BlockCollisionRegistry,
    // rust: scene: &mut W,
    // rust: state: &dyn Fn(i32, i32, i32) -> BlockStateId,
    // rust: from: Vec3,
    // rust: to: Vec3,
    // rust: ) -> Option<Option<[i32; 3]>> {
    // rust: let full = Aabb::new(Vec3::ZERO, Vec3::new(1.0, 1.0, 1.0));
    // rust: let result = traverse_blocks(from, to, 512, |p: BlockPos| {
    // rust: let id = state(p.x, p.y, p.z);
    // rust: if facts.is_air(id) {
    // rust: return None;
}
    // rust: let name = facts.get(id).name.trim_start_matches("minecraft:");
    // rust: if name.ends_with("glass")
    // rust: || name.ends_with("glass_pane")
    // rust: || name.ends_with("_bars")
    // rust: || name.ends_with("copper_grate")
    // rust: {
    // rust: return None;
}
    // rust: if matches!(name, "mud" | "soul_sand" | "powder_snow") {
    // rust: return full
    // rust: .move_by(Vec3::new(f64::from(p.x), f64::from(p.y), f64::from(p.z)))
    // rust: .clip(from, to)
    // rust: .map(|_| [p.x, p.y, p.z]);
}
    // rust: let shape = collision.collision_shape(scene, id, [p.x, p.y, p.z]).ok()?;
    // rust: shape.clip(from, to, p).map(|_| [p.x, p.y, p.z])
    // rust: });
    // rust: result.ok()
}

/// Runs `f` with an empty overworld (`others` its mobs) and the mob types,
/// both from the extracted vanilla data; false, without running it, when
/// that data is missing.
    // rust: pub(crate) fn with_test_world(
    // rust: others: &[Seen],
    // rust: f: impl FnOnce(&MobWorld<'_>, &super::MobTypes),
    // rust: ) -> bool {
    // rust: with_built_test_world(others, |_, _| {}, f)
}
/// `with_test_world` with `build` placing blocks first.
    // rust: pub(crate) fn with_built_test_world(
    // rust: others: &[Seen],
    // rust: build: impl FnOnce(&mut crate::world::World, &horizon_world::registry::BlockRegistry),
    // rust: f: impl FnOnce(&MobWorld<'_>, &super::MobTypes),
    // rust: ) -> bool {
    // rust: with_built_test_world_rules(others, true, true, build, f)
}
/// `with_built_test_world` with the `mob_griefing` game rule the world reports.
    // rust: pub(crate) fn with_built_test_world_rules(
    // rust: others: &[Seen],
    // rust: mob_griefing: bool,
    // rust: mob_drops: bool,
    // rust: build: impl FnOnce(&mut crate::world::World, &horizon_world::registry::BlockRegistry),
    // rust: f: impl FnOnce(&MobWorld<'_>, &super::MobTypes),
    // rust: ) -> bool {
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: with_resource_test_world(&root, others, mob_griefing, mob_drops, build, f)
}
/// The same mob world loaded from a content mod's resource root.
    // rust: pub(crate) fn with_resource_test_world(
    // rust: root: &std::path::Path,
    // rust: others: &[Seen],
    // rust: mob_griefing: bool,
    // rust: mob_drops: bool,
    // rust: build: impl FnOnce(&mut crate::world::World, &horizon_world::registry::BlockRegistry),
    // rust: f: impl FnOnce(&MobWorld<'_>, &super::MobTypes),
    // rust: ) -> bool {
    // rust: if !root.join("entity-types.json").exists() || !root.join("movement-properties.nbt").exists() {
    // rust: return false;
}
    // rust: let assets = crate::assets::Assets::load(root).unwrap();
    // rust: let registry = assets.registry;
    // rust: let facts = BlockFacts::load(root, registry).unwrap();
    // rust: let motion = crate::motion::MotionResources::load(root, &assets).unwrap();
    // rust: let data = super::MobData::load(root, &facts);
    // rust: let types = super::MobTypes::load(root).unwrap();
    // rust: let biomes = crate::biome::Biomes::load(root).unwrap();
    // rust: let items = crate::items::Items::load(
    // rust: root,
    // rust: registry,
    // rust: &facts,
    // rust: &horizon_world::loot::PackOverlay::NONE,
    // rust: )
    // rust: .unwrap();
    // rust: let collision = std::sync::Arc::new(crate::collisions::load(root, registry).unwrap());
    // rust: let suffocation =
    // rust: crate::mobs::suffocation::bind(collision.clone(), &motion.causes_suffocation).unwrap();
    // rust: let air = registry.default_state("minecraft:air").unwrap();
    // rust: let mut world = crate::world::World::new(air, 0);
    // rust: build(&mut world, registry);
    // rust: let lid_openers = std::collections::HashMap::new();
    // rust: let w = MobWorld {
    // rust: teams: Default::default(),
    // rust: world: &world,
    // rust: registry,
    // rust: facts: &facts,
    // rust: fluid_tables: &motion.fluids,
    // rust: movement: &motion.blocks,
    // rust: collision: &collision,
    // rust: suffocation: &suffocation,
    // rust: data: &data,
    // rust: player: None,
    // rust: controlling_player_movement: None,
    // rust: nearest_player: None,
    // rust: others,
    // rust: dragon: None,
    // rust: leash_boats: &[],
    // rust: others_grid: None,
    // rust: others_index: None,
    // rust: others_villagers: None,
    // rust: daylight: true,
    // rust: monsters_burn: false,
    // rust: game_time: 1000,
    // rust: day_time: 18000,
    // rust: raining: false,
    // rust: thundering: false,
    // rust: nether: false,
    // rust: block_tags: &items.block_tags,
    // rust: landing: &motion.landing,
    // rust: biomes: &biomes,
    // rust: mob_griefing,
    // rust: universal_anger: false,
    // rust: mob_drops,
    // rust: max_entity_cramming: 24,
    // rust: difficulty: super::spawning::LocalDifficulty::new(2, 18000, 0, 0.0),
    // rust: end: false,
    // rust: world_seed: 0,
    // rust: sea_level: 63,
    // rust: items: Some(&items),
    // rust: lid_openers: &lid_openers,
    // rust: mod_effects: None,
    // rust: border: None,
}
    // rust: f(&w, &types);
    // rust: true
}
/// A player standing at `position` in survival, as mobs see one.
    // rust: pub(crate) fn test_player(position: Vec3) -> super::PlayerView {
    // rust: super::PlayerView {
    // rust: position,
    // rust: bounds: Aabb::new(
    // rust: Vec3::new(position.x - 0.3, position.y, position.z - 0.3),
    // rust: Vec3::new(position.x + 0.3, position.y + 1.8, position.z + 0.3),
    // rust: ),
    // rust: eye: [position.x, position.y + 1.62, position.z],
    // rust: alive: true,
    // rust: creative: false,
    // rust: sneaking: false,
    // rust: swimming: false,
    // rust: look: [0.0; 3],
    // rust: main_hand: None,
    // rust: off_hand: None,
    // rust: head: None,
    // rust: chest: None,
    // rust: legs: None,
    // rust: feet: None,
    // rust: armor_cover: 0.0,
    // rust: invisible: false,
    // rust: spectator: false,
    // rust: gold_armor: false,
    // rust: hurt_by: None,
    // rust: last_hurt: None,
    // rust: velocity: Vec3::ZERO,
    // rust: yaw: 0.0,
    // rust: sprinting: false,
    // rust: riding: false,
    // rust: hero: false,
    // rust: effects: Vec::new(),
    // rust: uuid: [0; 4],
    // rust: allies: Default::default(),
    // rust: remote: false,
    // rust: sleeping: false,
    // rust: sleep_timer: 0,
    // rust: passenger: false,
    // rust: riding_vehicle: None,
    // rust: vehicle: None,
}
}

    // rust: mod scaffolding_sight_tests {
//     use super::*;

    /// ScaffoldingBlock.getCollisionShape: a viewer below the block sees
    /// through it, one above does not (issue 9607).
pub fn scaffolding_blocks_sight_only_from_above() void {
}
    // rust: let ran = super::with_built_test_world(
    // rust: &[],
    // rust: |world, registry| {
    // rust: world.chunks.insert(
    // rust: (0, 0),
    // rust: std::sync::Arc::new(crate::chunk::Chunk::empty(0, 0)),
    // rust: );
    // rust: let scaffolding = registry.default_state("minecraft:scaffolding").unwrap();
    // rust: world.set(0, 65, 0, scaffolding).unwrap();
    // rust: },
    // rust: |w, _| {
    // rust: let below = Vec3::new(0.5, 64.0 + 1.62, 0.5);
    // rust: let above = Vec3::new(0.5, 66.0 + 1.62, 0.5);
    // rust: assert!(w.line_of_sight_for(Some(64.0), below, above));
    // rust: assert!(!w.line_of_sight_for(Some(66.0), above, below));
    // rust: },
    // rust: );
    // rust: let _ = ran;
}
}
