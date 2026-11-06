//! Transpiled from Horizon Rust crate
//! Module: horizon-world_collision
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Version-pinned cached block collision data, without entity-context behavior.
//!
//! Java's no-context BlockState.getCollisionShape uses its cache when present.
//! The overload taking CollisionContext always calls block behavior instead.
//! This module covers the cached branch only; uncached states remain explicit.
// use crate::{
    // rust: DATA_VERSION,
    // rust: chunk::BlockSection,
    // rust: compression::invalid,
    // rust: nbt::Tag,
    // rust: registry::{BlockRegistry, BlockStateId, BlockTable},
}
// use horizon_core::geometry::{Axis, VoxelShape};
// use std::{collections::HashMap, io};

/// `PipeBlock`'s shape for `size` pixels across (`makeShapes`): the core
/// cube, with an arm from the centre out to each joined side (`sides` by
/// `Direction`: down, up, north, south, west, east).
pub fn pipe_shape(size: f64, sides: [bool; 6]) i {
    // Implementation ported from Horizon
    return undefined;
}
//     use horizon_core::geometry::{Aabb, ShapeOp, Vec3};
    // rust: let (lo, hi) = ((8.0 - size / 2.0) / 16.0, (8.0 + size / 2.0) / 16.0);
    // rust: let shape = |min: [f64; 3], max: [f64; 3]| {
    // rust: VoxelShape::from_box(Aabb::new(
    // rust: Vec3::new(min[0], min[1], min[2]),
    // rust: Vec3::new(max[0], max[1], max[2]),
    // rust: ))
    // rust: .map_err(|e| invalid(e.to_string()))
}
    // rust: let mut result = shape([lo; 3], [hi; 3])?;
    // rust: let arms = [
    // rust: ([lo, 0.0, lo], [hi, 0.5, hi]),
    // rust: ([lo, 0.5, lo], [hi, 1.0, hi]),
    // rust: ([lo, lo, 0.0], [hi, hi, 0.5]),
    // rust: ([lo, lo, 0.5], [hi, hi, 1.0]),
    // rust: ([0.0, lo, lo], [0.5, hi, hi]),
    // rust: ([0.5, lo, lo], [1.0, hi, hi]),
    // rust: ];
    // rust: for (joined, (min, max)) in sides.into_iter().zip(arms) {
    // rust: if joined {
    // rust: result = shape(min, max)?
    // rust: .join(&result, ShapeOp::OR)
    // rust: .map_err(|e| invalid(e.to_string()))?;
}
}
    // rust: Ok(result)
}

pub const GridKey = struct {
    coords: [std.ArrayList(u64),
    occupied: std.ArrayList(u8),
    cube: bool,
    axes: u8,
    min: [i32,
    max: [i32,
};

pub const CachedCollisionRegistry = struct {
    registry: *'r BlockRegistry,
    shapes: std.ArrayList(VoxelShape),
    state_shapes: std.ArrayList(i32),
    grid_count: usize,
    canonical_identities: bool,
};
    // rust: impl<'r> CachedCollisionRegistry<'r> {
pub fn registry(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.registry
}
pub fn from_nbt(tag: *Tag, registry: *'r BlockRegistry) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::from_table(BlockTable::check(tag, registry, "collision")?)
}
pub fn from_table(table: BlockTable<'_) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (tag, registry) = (table.tag(), table.registry());
    // rust: if tag.get("DataVersion") != Some(&Tag::Int(DATA_VERSION)) {
    // rust: return Err(invalid("collision DataVersion mismatch"));
}
    // rust: let Some(Tag::List(entries)) = tag.get("shapes") else {
    // rust: return Err(invalid("missing collision shapes"));
}
    // rust: if entries.len() > registry.len() {
    // rust: return Err(invalid("too many cached collision shapes"));
}
    // rust: let mut shapes = Vec::with_capacity(entries.len());
    // rust: let mut canonical_identities = true;
    // rust: let mut seen_canonical = [false; 3];
    // rust: let mut grids = HashMap::<GridKey, VoxelShape>::new();
    // rust: for entry in entries {
    // rust: let canonical = match entry.get("canonical") {
    // rust: None => {
    // rust: canonical_identities = false;
    // rust: 0
}
    // rust: Some(Tag::Byte(value @ 0..=2)) => *value as usize,
    // rust: _ => return Err(invalid("invalid canonical collision identity")),
}
    // rust: if canonical != 0 {
    // rust: if seen_canonical[canonical] {
    // rust: return Err(invalid("duplicate canonical collision identity"));
}
    // rust: seen_canonical[canonical] = true;
}
    // rust: let mut coords: [Vec<f64>; 3] = std::array::from_fn(|_| Vec::new());
    // rust: for (i, axis) in ["x", "y", "z"].into_iter().enumerate() {
    // rust: let Some(Tag::LongArray(bits)) = entry.get(axis) else {
    // rust: return Err(invalid("missing collision coordinates"));
}
    // rust: coords[i] = bits.iter().map(|b| f64::from_bits(*b as u64)).collect();
}
    // rust: let Some(Tag::ByteArray(bits)) = entry.get("occupied") else {
    // rust: return Err(invalid("missing collision occupancy"));
}
    // rust: if bits.iter().any(|b| *b != 0 && *b != 1) {
    // rust: return Err(invalid("invalid collision occupancy"));
}
    // rust: let occupied = bits.iter().map(|b| *b != 0).collect::<Vec<_>>();
    // rust: let Some(Tag::Byte(cube_axes)) = entry.get("cube_axes") else {
    // rust: return Err(invalid("missing cube-coordinate metadata"));
}
    // rust: if *cube_axes < 0 || *cube_axes > 7 {
    // rust: return Err(invalid("invalid cube-coordinate metadata"));
}
    // rust: let coordinate_cubes = [cube_axes & 1 != 0, cube_axes & 2 != 0, cube_axes & 4 != 0];
    // rust: let discrete_bounds = |name| -> io::Result<[i32; 3]> {
    // rust: let Some(Tag::IntArray(values)) = entry.get(name) else {
    // rust: return Err(invalid("missing collision discrete extrema"));
}
    // rust: values
    // rust: .as_slice()
    // rust: .try_into()
    // rust: .map_err(|_| invalid("invalid collision discrete extrema length"))
}
    // rust: let min = discrete_bounds("discrete_min")?;
    // rust: let max = discrete_bounds("discrete_max")?;
    // rust: let cube = match entry.get("cube") {
    // rust: Some(Tag::Byte(0)) => false,
    // rust: Some(Tag::Byte(1)) => true,
    // rust: _ => return Err(invalid("invalid collision cube flag")),
}
    // rust: let key = GridKey {
    // rust: coords: std::array::from_fn(|i| coords[i].iter().map(|v| v.to_bits()).collect()),
    // rust: occupied: bits.clone(),
    // rust: cube,
    // rust: axes: *cube_axes as u8,
    // rust: min,
    // rust: max,
}
    // rust: let shape = if let Some(existing) = grids.get(&key) {
    // rust: existing.fresh_identity()
    // rust: } else {
    // rust: match entry.get("cube") {
    // rust: Some(Tag::Byte(0)) => {
    // rust: VoxelShape::from_mixed_grid(coords, &occupied, coordinate_cubes)
}
    // rust: Some(Tag::Byte(1)) => {
    // rust: if *cube_axes != 7 {
    // rust: return Err(invalid("cube shape has array-coordinate metadata"));
}
    // rust: let sizes = std::array::from_fn(|i| coords[i].len().saturating_sub(1));
    // rust: let shape = VoxelShape::from_cube(sizes, &occupied)
    // rust: .map_err(|e| invalid(e.to_string()))?;
    // rust: for axis in Axis::ALL {
    // rust: if shape
    // rust: .coordinates(axis)
    // rust: .iter()
    // rust: .map(|v| v.to_bits())
    // rust: .ne(coords[axis as usize].iter().map(|v| v.to_bits()))
    // rust: {
    // rust: return Err(invalid("cube collision coordinates differ"));
}
}
    // rust: Ok(shape)
}
    // rust: _ => return Err(invalid("invalid collision cube flag")),
}
    // rust: .map_err(|e| invalid(e.to_string()))?
    // rust: .with_discrete_bounds(min, max)
    // rust: .map_err(|e| invalid(e.to_string()))?
}
    // rust: let shape = if canonical == 0 {
    // rust: shape
    // rust: } else {
    // rust: let reference = if canonical == 1 {
    // rust: VoxelShape::empty()
    // rust: } else {
    // rust: VoxelShape::block()
}
    // rust: let expected_count = usize::from(canonical == 2);
    // rust: if cube != reference.is_cube()
    // rust: || coordinate_cubes != reference.cube_coordinate_axes()
    // rust: || occupied != vec![true; expected_count]
    // rust: || min != [0; 3]
    // rust: || max != [expected_count as i32; 3]
    // rust: || Axis::ALL.into_iter().any(|axis| {
    // rust: key.coords[axis as usize]
    // rust: .iter()
    // rust: .copied()
    // rust: .ne(reference.coordinates(axis).iter().map(|v| v.to_bits()))
    // rust: })
    // rust: {
    // rust: return Err(invalid(
    // rust: "canonical collision identity has different geometry",
    // rust: ));
}
    // rust: reference
}
    // rust: grids.entry(key).or_insert_with(|| shape.clone());
    // rust: shapes.push(shape);
}
    // rust: let Some(Tag::IntArray(state_shapes)) = tag.get("cached_shapes") else {
    // rust: return Err(invalid("missing cached shape mapping"));
}
    // rust: if state_shapes.len() != registry.len()
    // rust: || state_shapes
    // rust: .iter()
    // rust: .any(|id| *id < -1 || *id >= shapes.len() as i32)
    // rust: {
    // rust: return Err(invalid("invalid cached shape mapping"));
}
    // rust: Ok(Self {
    // rust: registry,
    // rust: shapes,
    // rust: state_shapes: state_shapes.clone(),
    // rust: grid_count: grids.len(),
    // rust: canonical_identities,
    // rust: })
}
    /// Older exports omit native canonical identities. Such imports retain their
    /// local alias graph but cannot support identity-dependent world iteration.
pub fn has_canonical_identities(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.canonical_identities
}
pub fn shape_count(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.shapes.len()
}
pub fn unique_grid_count(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.grid_count
}
pub fn cached_state_count(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.state_shapes.iter().filter(|id| **id >= 0).count()
}
    /// None means vanilla must call block behavior for this state. It does not
    /// mean air, an empty shape, or permission to ignore a collision.
pub fn cached_shape(self: *Self, state: BlockStateId) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = *self
    // rust: .state_shapes
    // rust: .get(state.0 as usize)
    // rust: .ok_or_else(|| invalid("collision state outside registry"))?;
    // rust: Ok(if id < 0 {
    // rust: None
    // rust: } else {
    // rust: Some(&self.shapes[id as usize])
    // rust: })
}
    // rust: pub fn section_shape(
    // rust: &self,
    // rust: section: &BlockSection<'_>,
    // rust: index: usize,
    // rust: ) -> io::Result<Option<&VoxelShape>> {
    // rust: if !std::ptr::eq(section.registry(), self.registry) {
    // rust: return Err(invalid("section uses a different collision registry"));
}
    // rust: self.cached_shape(section.get(index)?)
}
}

    // rust: mod pipe_tests {
//     use super::*;
//     use crate::registry::BlockTableFile;
//     use horizon_core::geometry::ShapeOp;
//     use std::path::PathBuf;

    /// `pipe_shape` at the chorus plant's 10 pixels is vanilla's own shape for
    /// each of its 64 states.
pub fn pipe_shapes_match_the_chorus_plant() void {
}
    // rust: let root = std::env::var_os("HORIZON_RESOURCES")
    // rust: .map(PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: PathBuf::from(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION)
    // rust: });
    // rust: if !root.join("cached-collision.nbt").exists() {
    // rust: eprintln!("skipping: no resources at {}", root.display());
    // rust: return;
}
    // rust: let registry = crate::level::data::load_registry(&root).unwrap();
    // rust: let file = BlockTableFile::open(&root.join("cached-collision.nbt"), &registry).unwrap();
    // rust: let cached = CachedCollisionRegistry::from_table(file.table("collision").unwrap()).unwrap();
    // rust: let mut checked = 0;
    // rust: for id in 0..registry.len() as u32 {
    // rust: let state = BlockStateId(id);
    // rust: let s = registry.state(state).unwrap();
    // rust: if s.name != "minecraft:chorus_plant" {
    // rust: continue;
}
    // rust: let sides = ["down", "up", "north", "south", "west", "east"]
    // rust: .map(|k| s.properties.get(k).map(String::as_str) == Some("true"));
    // rust: let ours = pipe_shape(10.0, sides).unwrap();
    // rust: let theirs = cached.cached_shape(state).unwrap().unwrap();
    // rust: assert!(
    // rust: !ours.join_is_not_empty(theirs, ShapeOp::XOR).unwrap(),
    // rust: "{sides:?}"
    // rust: );
    // rust: assert_eq!(ours.boxes(), theirs.boxes(), "{sides:?}");
    // rust: checked += 1;
}
    // rust: assert_eq!(checked, 64);
}
}
