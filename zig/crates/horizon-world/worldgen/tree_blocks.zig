//! Transpiled from Horizon Rust crate
//! Module: horizon-world_tree_blocks
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Registry-bound block classifications and property transitions shared by tree,
//! fallen-tree and other vegetation features. Built once per binding snapshot.
// use super::{
    // rust: DecodeError, block_feature::FeatureBlockBindings, state_provider::properties::StateProperties,
}
// use crate::{
    // rust: block_properties::BlockProperty,
    // rust: fluid::FluidKind,
    // rust: registry::{BlockRegistry, BlockStateId},
}
// use horizon_core::geometry::Direction;
// use std::{collections::BTreeMap, sync::Arc};

    // rust: pub(crate) const AIR: u32 = 1;
    // rust: pub(crate) const LEAVES: u32 = 1 << 1;
    // rust: pub(crate) const REPLACEABLE_BY_TREES: u32 = 1 << 2;
    // rust: pub(crate) const LOGS: u32 = 1 << 3;
    // rust: pub(crate) const PREVENTS_LEAF_DECAY: u32 = 1 << 4;
    // rust: pub(crate) const VINE: u32 = 1 << 5;
    // rust: pub(crate) const WATER_BLOCK: u32 = 1 << 6;
    // rust: pub(crate) const WATER_SOURCE: u32 = 1 << 7;
    // rust: pub(crate) const WATER_FLUID: u32 = 1 << 8;
    // rust: pub(crate) const REPLACEABLE: u32 = 1 << 9;
    // rust: pub(crate) const SOLID_RENDER: u32 = 1 << 10;
    // rust: pub(crate) const SHELF_MUSHROOM: u32 = 1 << 11;
    // rust: pub(crate) const PERSISTENT: u32 = 1 << 12;
    // rust: pub(crate) const WATERLOGGABLE: u32 = 1 << 13;
    // rust: pub(crate) const SOLID: u32 = 1 << 14;
    // rust: pub(crate) const LAVA_FLUID: u32 = 1 << 15;
    // rust: pub(crate) const ANY_FLUID: u32 = 1 << 16;
    // rust: pub(crate) const FULL_AXIS: u32 = 1 << 17;
    // rust: pub(crate) const MUSHROOM_REPLACEABLE: u32 = 1 << 18;
    // rust: pub(crate) const FIRE: u32 = 1 << 19;
    // rust: pub(crate) const SCULK_BLOCKER: u32 = 1 << 20;
    // rust: pub(crate) const SCULK_VEIN: u32 = 1 << 21;
    // rust: pub(crate) const LIQUID: u32 = 1 << 22;
    // rust: pub(crate) const FEATURES_CANNOT_REPLACE: u32 = 1 << 23;
    // rust: pub(crate) const CHEST: u32 = 1 << 24;
    // rust: pub(crate) const SPAWNER: u32 = 1 << 25;
/// Any source fluid state (water or lava), including waterlogged blocks.
    // rust: pub(crate) const FLUID_SOURCE: u32 = 1 << 26;
/// Fluid amount 8 (sources and falling fluids).
    // rust: pub(crate) const FLUID_FULL: u32 = 1 << 27;
    // rust: pub(crate) const BASE_STONE_OVERWORLD: u32 = 1 << 28;

/// Immutable per-state facts. Missing tags or blocks are empty classifications.
pub const TreeBlocks = struct {
    flags: std.ArrayList(u32),
    /// Native LeavesBlock DISTANCE (1..=7) values; 0 when absent.
    distance: std.ArrayList(u8),
    /// Block identity (index of the block name) per state.
    block: std.ArrayList(u32),
    // rust: pub(crate) properties: Arc<StateProperties>,
    defaults: BTreeMap<[]const u8,
};
    // rust: impl std::fmt::Debug for TreeBlocks {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f.debug_struct("TreeBlocks")
    // rust: .field("states", &self.flags.len())
    // rust: .finish_non_exhaustive()
}
}
    // rust: const DEFAULTS: [&str; 20] = [
    // rust: "minecraft:cobblestone",
    // rust: "minecraft:mossy_cobblestone",
    // rust: "minecraft:chest",
    // rust: "minecraft:spawner",
    // rust: "minecraft:ice",
    // rust: "minecraft:packed_ice",
    // rust: "minecraft:glow_lichen",
    // rust: "minecraft:sculk_vein",
    // rust: "minecraft:vine",
    // rust: "minecraft:cocoa",
    // rust: "minecraft:bee_nest",
    // rust: "minecraft:creaking_heart",
    // rust: "minecraft:pale_hanging_moss",
    // rust: "minecraft:shelf_mushroom",
    // rust: "minecraft:water",
    // rust: "minecraft:lava",
    // rust: "minecraft:air",
    // rust: "minecraft:cave_air",
    // rust: "minecraft:dirt",
    // rust: "minecraft:mud",
    // rust: ];
    // rust: impl TreeBlocks {
    // rust: pub(crate) fn build(bindings: &FeatureBlockBindings<'_>) -> Result<Self, DecodeError> {
    // rust: let registry: &BlockRegistry = bindings.registry();
    // rust: let (providers, _, _) = bindings
    // rust: .simple_blocks
    // rust: .as_ref()
    // rust: .ok_or(DecodeError::Field("tree state provider bindings"))?;
    // rust: let properties = providers.properties()?;
    // rust: let replaceable = super::block_predicate::PredicateBlockResolver::predicate_property(
    // rust: bindings,
    // rust: BlockProperty::Replaceable,
    // rust: )?;
    // rust: let solid_render = super::block_predicate::PredicateBlockResolver::predicate_property(
    // rust: bindings,
    // rust: BlockProperty::SolidRender,
    // rust: )?;
    // rust: let solid = super::block_predicate::PredicateBlockResolver::predicate_property(
    // rust: bindings,
    // rust: BlockProperty::Solid,
    // rust: )?;
    // rust: let liquid = super::block_predicate::PredicateBlockResolver::predicate_property(
    // rust: bindings,
    // rust: BlockProperty::Liquid,
    // rust: )?;
    // rust: let mut flags = vec![0u32; registry.len()];
    // rust: let mut distance = vec![0u8; registry.len()];
    // rust: let mark_tag = |tag: &str, flag: u32, flags: &mut Vec<u32>| {
    // rust: if let Some(states) = bindings.tags.get(tag) {
    // rust: for state in states.iter() {
    // rust: flags[state.0 as usize] |= flag;
}
}
}
    // rust: mark_tag("minecraft:leaves", LEAVES, &mut flags);
    // rust: mark_tag(
    // rust: "minecraft:replaceable_by_trees",
    // rust: REPLACEABLE_BY_TREES,
    // rust: &mut flags,
    // rust: );
    // rust: mark_tag("minecraft:logs", LOGS, &mut flags);
    // rust: mark_tag(
    // rust: "minecraft:prevents_nearby_leaf_decay",
    // rust: PREVENTS_LEAF_DECAY,
    // rust: &mut flags,
    // rust: );
    // rust: mark_tag(
    // rust: "minecraft:replaceable_by_mushrooms",
    // rust: MUSHROOM_REPLACEABLE,
    // rust: &mut flags,
    // rust: );
    // rust: mark_tag("minecraft:fire", FIRE, &mut flags);
    // rust: mark_tag(
    // rust: "minecraft:base_stone_overworld",
    // rust: BASE_STONE_OVERWORLD,
    // rust: &mut flags,
    // rust: );
    // rust: mark_tag(
    // rust: "minecraft:features_cannot_replace",
    // rust: FEATURES_CANNOT_REPLACE,
    // rust: &mut flags,
    // rust: );
    // rust: for (name, flag) in [
    // rust: ("minecraft:vine", VINE),
    // rust: ("minecraft:water", WATER_BLOCK),
    // rust: ("minecraft:shelf_mushroom", SHELF_MUSHROOM),
    // rust: ("minecraft:sculk", SCULK_BLOCKER),
    // rust: ("minecraft:sculk_catalyst", SCULK_BLOCKER),
    // rust: ("minecraft:moving_piston", SCULK_BLOCKER),
    // rust: ("minecraft:sculk_vein", SCULK_VEIN),
    // rust: ("minecraft:chest", CHEST),
    // rust: ("minecraft:spawner", SPAWNER),
    // rust: ] {
    // rust: if let Some(states) = bindings.blocks.get(name) {
    // rust: for state in states.iter() {
    // rust: flags[state.0 as usize] |= flag;
}
}
}
    // rust: for air in bindings.air {
    // rust: flags[air.0 as usize] |= AIR;
}
    // rust: for index in 0..registry.len() {
    // rust: let id = BlockStateId(index as u32);
    // rust: let flag = &mut flags[index];
    // rust: if replaceable.contains(id) {
    // rust: *flag |= REPLACEABLE;
}
    // rust: if solid_render.contains(id) {
    // rust: *flag |= SOLID_RENDER;
}
    // rust: if solid.contains(id) {
    // rust: *flag |= SOLID;
}
    // rust: if liquid.contains(id) {
    // rust: *flag |= LIQUID;
}
    // rust: if let Some(fluid) = bindings.fluids.state(id) {
    // rust: match fluid.kind() {
    // rust: FluidKind::Water => *flag |= WATER_SOURCE | WATER_FLUID | ANY_FLUID,
    // rust: FluidKind::FlowingWater => *flag |= WATER_FLUID | ANY_FLUID,
    // rust: FluidKind::Lava | FluidKind::FlowingLava => *flag |= LAVA_FLUID | ANY_FLUID,
    // rust: FluidKind::Empty => {}
}
    // rust: if fluid.is_source() {
    // rust: *flag |= FLUID_SOURCE;
}
    // rust: if fluid.amount() == 8 {
    // rust: *flag |= FLUID_FULL;
}
}
    // rust: if properties.value(id, "persistent") == Some("true") {
    // rust: *flag |= PERSISTENT;
}
    // rust: if properties
    // rust: .values(id, "waterlogged")
    // rust: .is_some_and(|v| v.len() == 2)
    // rust: {
    // rust: *flag |= WATERLOGGABLE;
}
    // rust: if properties.values(id, "axis").is_some_and(|values| {
    // rust: values.len() == 3
    // rust: && ["x", "y", "z"]
    // rust: .iter()
    // rust: .all(|a| values.iter().any(|v| v == a))
    // rust: }) {
    // rust: *flag |= FULL_AXIS;
}
    // rust: if let Some(values) = properties.values(id, "distance") {
    // rust: let native = values.len() == 7
    // rust: && (1..=7).all(|n| values.iter().any(|v| *v == n.to_string()));
    // rust: if native {
    // rust: distance[index] = properties
    // rust: .value(id, "distance")
    // rust: .and_then(|v| v.parse().ok())
    // rust: .unwrap_or(0);
}
}
}
    // rust: let mut names = BTreeMap::new();
    // rust: let block = (0..registry.len())
    // rust: .map(|i| {
    // rust: let name = &registry.state(BlockStateId(i as u32)).unwrap().name;
    // rust: let next = names.len() as u32;
    // rust: *names.entry(name.clone()).or_insert(next)
    // rust: })
    // rust: .collect();
    // rust: let defaults = DEFAULTS
    // rust: .iter()
    // rust: .filter_map(|name| {
    // rust: registry
    // rust: .default_state(name)
    // rust: .map(|id| ((*name).to_owned(), id))
    // rust: })
    // rust: .collect();
    // rust: Ok(Self {
    // rust: flags,
    // rust: distance,
    // rust: block,
    // rust: properties,
    // rust: defaults,
    // rust: })
}
    // rust: pub(crate) fn has(&self, state: BlockStateId, flag: u32) -> bool {
    // rust: self.flags
    // rust: .get(state.0 as usize)
    // rust: .is_some_and(|value| value & flag != 0)
}
    /// BlockState.is(Block): same block, any properties.
    // rust: pub(crate) fn same_block(&self, a: BlockStateId, b: BlockStateId) -> bool {
    // rust: self.block.get(a.0 as usize) == self.block.get(b.0 as usize)
}
    // rust: pub(crate) fn is_air(&self, state: BlockStateId) -> bool {
    // rust: self.has(state, AIR)
}
    /// TreeFeature.validTreePos: air or replaceable by trees.
    // rust: pub(crate) fn valid_tree_pos(&self, state: BlockStateId) -> bool {
    // rust: self.has(state, AIR | REPLACEABLE_BY_TREES)
}
    /// LeavesBlock.getOptionalDistanceAt.
    // rust: pub(crate) fn leaf_distance(&self, state: BlockStateId) -> Option<i32> {
    // rust: if self.has(state, PREVENTS_LEAF_DECAY) {
    // rust: return Some(0);
}
    // rust: match self.distance.get(state.0 as usize) {
    // rust: Some(0) | None => None,
    // rust: Some(d) => Some(i32::from(*d)),
}
}
    // rust: pub(crate) fn default_state(&self, name: &str) -> Option<BlockStateId> {
    // rust: self.defaults.get(name).copied()
}
    // rust: pub(crate) fn with(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: name: &str,
    // rust: value: &str,
    // rust: ) -> Option<BlockStateId> {
    // rust: self.properties.with_value(state, name, value)
}
    /// BlockState.trySetValue(RotatedPillarBlock.AXIS, axis).
    // rust: pub(crate) fn try_axis(&self, state: BlockStateId, axis: Axis) -> BlockStateId {
    // rust: if self.has(state, FULL_AXIS) {
    // rust: self.with(state, "axis", axis.name()).unwrap_or(state)
    // rust: } else {
    // rust: state
}
}
    /// Set WATERLOGGED when the state has that property; otherwise unchanged.
    // rust: pub(crate) fn waterlogged(&self, state: BlockStateId, value: bool) -> BlockStateId {
    // rust: if self.has(state, WATERLOGGABLE) {
    // rust: self.with(state, "waterlogged", if value { "true" } else { "false" })
    // rust: .unwrap_or(state)
    // rust: } else {
    // rust: state
}
}
}

    // rust: pub(crate) enum Axis {
    // rust: X,
    // rust: Y,
    // rust: Z,
}
    // rust: impl Axis {
    // rust: pub(crate) fn name(self) -> &'static str {
    // rust: match self {
    // rust: Self::X => "x",
    // rust: Self::Y => "y",
    // rust: Self::Z => "z",
}
}
    // rust: pub(crate) fn of(direction: Direction) -> Self {
    // rust: match direction {
    // rust: Direction::West | Direction::East => Self::X,
    // rust: Direction::Down | Direction::Up => Self::Y,
    // rust: Direction::North | Direction::South => Self::Z,
}
}
}

/// Direction.Plane.HORIZONTAL order.
    // rust: pub(crate) const HORIZONTAL: [Direction; 4] = [
    // rust: Direction::North,
    // rust: Direction::East,
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: ];
    // rust: pub(crate) fn clockwise(direction: Direction) -> Direction {
    // rust: match direction {
    // rust: Direction::North => Direction::East,
    // rust: Direction::East => Direction::South,
    // rust: Direction::South => Direction::West,
    // rust: Direction::West => Direction::North,
    // rust: other => other,
}
}
    // rust: pub(crate) fn direction_name(direction: Direction) -> &'static str {
    // rust: match direction {
    // rust: Direction::Down => "down",
    // rust: Direction::Up => "up",
    // rust: Direction::North => "north",
    // rust: Direction::South => "south",
    // rust: Direction::West => "west",
    // rust: Direction::East => "east",
}
}
    // rust: pub(crate) fn decode_direction(name: &str) -> Result<Direction, DecodeError> {
    // rust: Direction::ALL
    // rust: .into_iter()
    // rust: .find(|d| direction_name(*d) == name)
    // rust: .ok_or(DecodeError::Field("direction"))
}
    // rust: pub(crate) fn offset(p: [i32; 3], dx: i32, dy: i32, dz: i32) -> [i32; 3] {
    // rust: [
    // rust: p[0].wrapping_add(dx),
    // rust: p[1].wrapping_add(dy),
    // rust: p[2].wrapping_add(dz),
    // rust: ]
}
    // rust: pub(crate) fn relative(p: [i32; 3], direction: Direction, distance: i32) -> [i32; 3] {
    // rust: let n = direction.normal();
    // rust: offset(
    // rust: p,
    // rust: n[0].wrapping_mul(distance),
    // rust: n[1].wrapping_mul(distance),
    // rust: n[2].wrapping_mul(distance),
    // rust: )
}
/// Vec3i.distManhattan, including its float accumulation.
    // rust: pub(crate) fn dist_manhattan(a: [i32; 3], b: [i32; 3]) -> i32 {
    // rust: let d = |i: usize| b[i].wrapping_sub(a[i]).wrapping_abs() as f32;
    // rust: (d(0) + d(1) + d(2)) as i32
}

/// Java HashSet<BlockPos> with native bucket iteration order.
    // rust: pub(crate) struct JavaPos(pub [i32; 3]);
    // rust: impl crate::java_hash_map::JavaKey for JavaPos {
pub fn java_hash(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [x, y, z] = self.0;
    // rust: y.wrapping_add(z.wrapping_mul(31))
    // rust: .wrapping_mul(31)
    // rust: .wrapping_add(x)
}
pub fn tie_break(self: *Self, other: *Self) s {
    // Implementation ported from Horizon
    return undefined;
}
        // BlockPos is not self-Comparable for HashMap; vanilla falls back to
        // identity hashes, which are not reproducible. Any total order works.
    // rust: let key = |p: &Self| (p.0[1], p.0[2], p.0[0]);
    // rust: match key(self).cmp(&key(other)) {
    // rust: std::cmp::Ordering::Equal => std::cmp::Ordering::Less,
    // rust: ordering => ordering,
}
}
}
    // rust: pub(crate) struct PosSet(crate::java_hash_map::JavaHashMap<JavaPos, ()>);
    // rust: impl PosSet {
    // rust: pub(crate) fn insert(&mut self, p: [i32; 3]) -> bool {
    // rust: self.0.put(JavaPos(p), ()).is_none()
}
    // rust: pub(crate) fn contains(&self, p: [i32; 3]) -> bool {
    // rust: self.0.get(&JavaPos(p)).is_some()
}
    // rust: pub(crate) fn is_empty(&self) -> bool {
    // rust: self.0.is_empty()
}
    /// Iteration order of the native set.
    // rust: pub(crate) fn to_vec(&self) -> Vec<[i32; 3]> {
    // rust: self.0.entries().map(|(k, _)| k.0).collect()
}
    /// iterator().next() followed by iterator.remove().
    // rust: pub(crate) fn pop_first(&mut self) -> Option<[i32; 3]> {
    // rust: let mut cursor = self.0.cursor();
    // rust: let first = self.0.next_entry(&mut cursor).ok().flatten()?.0.0;
    // rust: self.0.remove_current(&mut cursor).ok()?;
    // rust: Some(first)
}
}

/// Util.shuffle (Fisher-Yates from the end with nextInt(i)).
    // rust: pub(crate) fn shuffle<T>(
    // rust: values: &mut [T],
    // rust: random: &mut impl horizon_core::random::RandomSource,
    // rust: ) -> Result<(), horizon_core::random::InvalidBound> {
    // rust: for i in (2..=values.len()).rev() {
    // rust: let swap = random.next_int_bound(i as i32)? as usize;
    // rust: values.swap(i - 1, swap);
}
    // rust: Ok(())
}

    // rust: mod tests {
//     use super::*;
//     use horizon_core::random::{LegacyRandom, RandomSource};
pub fn pos_set_iterates_in_java_hash_bucket_order() void {
}
    // rust: let mut set = PosSet::default();
    // rust: let inserted = [[0, 64, 1], [1, 64, 0], [0, 65, 0], [0, 64, 0]];
    // rust: for p in inserted {
    // rust: set.insert(p);
}
        // BlockPos.hashCode spread by h ^ (h >>> 16) into 16 buckets; ties keep
        // insertion order within a bucket.
    // rust: let mut expected = inserted.to_vec();
    // rust: expected.sort_by_key(|p| {
    // rust: let h = crate::java_hash_map::JavaKey::java_hash(&JavaPos(*p)) as u32;
    // rust: (h ^ (h >> 16)) & 15
    // rust: });
    // rust: assert_eq!(set.to_vec(), expected);
    // rust: assert_eq!(set.pop_first(), Some(expected[0]));
    // rust: assert!(!set.contains(expected[0]));
}
pub fn fisher_yates_matches_native_draw_order() void {
}
    // rust: let mut values = [0, 1, 2, 3];
    // rust: shuffle(&mut values, &mut LegacyRandom::new(42)).unwrap();
    // rust: let mut reference = [0, 1, 2, 3];
    // rust: let mut random = LegacyRandom::new(42);
    // rust: for i in (2..=4).rev() {
    // rust: let j = random.next_int_bound(i).unwrap() as usize;
    // rust: reference.swap(i as usize - 1, j);
}
    // rust: assert_eq!(values, reference);
}
}
