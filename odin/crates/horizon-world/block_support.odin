//! Transpiled from Horizon Rust crate
package horizon_world_block_support

import "core:fmt"
import "core:mem"
import "core:math"

// Native support tests over an already-selected block support shape. Selecting
// that shape from block/world/entity behavior is the caller's responsibility.
// use horizon_core::geometry::{Aabb, Direction, ShapeError, ShapeOp, Vec3, VoxelShape};
// use std::sync::OnceLock;
SupportType :: enum {
    Full,
    Center,
    Rigid,
}
    // rust: impl SupportType {
    // rust: pub fn is_supporting(
    // rust: self,
    // rust: shape: &VoxelShape,
    // rust: direction: Direction,
    // rust: ) -> Result<bool, ShapeError> {
    // rust: self.supported_by(&shape.face_shape(direction)?)
}
    // [`Self::is_supporting`] given the shape's face in that direction.
supported_by :: proc(self: ^Self, face: ^VoxelShape) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let (required, operation) = match self {
    // rust: Self::Full => (VoxelShape::block(), ShapeOp::XOR),
    // rust: Self::Center => {
CENTER :: OnceLock::new()
    // rust: (
    // rust: CENTER
    // rust: .get_or_init(|| {
    // rust: VoxelShape::from_box(Aabb::new(
    // rust: Vec3::new(0.4375, 0.0, 0.4375),
    // rust: Vec3::new(0.5625, 0.625, 0.5625),
    // rust: ))
    // rust: .expect("valid support shape")
    // rust: })
    // rust: .clone(),
    // rust: ShapeOp::ONLY_SECOND,
    // rust: )
}
    // rust: Self::Rigid => {
RIGID :: OnceLock::new()
    // rust: (
    // rust: RIGID
    // rust: .get_or_init(|| {
    // rust: VoxelShape::block()
    // rust: .join(
    // rust: &VoxelShape::from_box(Aabb::new(
    // rust: Vec3::new(0.125, 0.0, 0.125),
    // rust: Vec3::new(0.875, 1.0, 0.875),
    // rust: ))
    // rust: .expect("valid support inset"),
    // rust: ShapeOp::ONLY_FIRST,
    // rust: )
    // rust: .expect("valid support ring")
    // rust: })
    // rust: .clone(),
    // rust: ShapeOp::ONLY_SECOND,
    // rust: )
}
}
    // rust: Ok(!face.join_is_not_empty(&required, operation)?)
}
}

// use crate::{
    // rust: collision::CachedCollisionRegistry,
    // rust: compression::invalid,
    // rust: nbt::Tag,
    // rust: registry::{BlockRegistry, BlockStateId, BlockTable},
}
// use std::{collections::HashMap, io};
// Cached branch of BlockState.isFaceSturdy. Dynamic support-shape selection
// stays explicit as None, even when a context-free approximation looks obvious.
CachedBlockSupportRegistry :: struct {
    shapes: CachedCollisionRegistry<'r>,
    states: Vec<Option<[u8,
}
    // rust: impl<'r> CachedBlockSupportRegistry<'r> {
from_nbt :: proc(tag: ^Tag, registry: ^'r BlockRegistry) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Self::from_table(BlockTable::check(tag, registry, "support")?)
}
from_table :: proc(table: BlockTable<'_) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if table.get("Kind") != Some(&Tag::String("block_support".into())) {
    // rust: return Err(invalid("wrong cached support data kind"));
}
    // rust: let registry = table.registry();
    // rust: let shapes = CachedCollisionRegistry::from_table(table)?;
    // rust: let mut cache = HashMap::new();
    // rust: let mut states = Vec::with_capacity(registry.len());
    // rust: for id in 0..registry.len() {
    // rust: let Some(shape) = shapes.cached_shape(BlockStateId(id as u32))? else {
    // rust: states.push(None);
    // rust: continue;
}
    // rust: let identity = std::ptr::from_ref(shape);
    // rust: let flags = if let Some(flags) = cache.get(&identity) {
    // rust: *flags
    // rust: } else {
    // rust: let mut flags = [0; 3];
    // rust: for direction in Direction::ALL {
                    // Not kept on the shape: only these flags are.
    // rust: let face = shape
    // rust: .face_shape_transient(direction)
    // rust: .map_err(|e| invalid(e.to_string()))?;
    // rust: for (i, support) in [SupportType::Full, SupportType::Center, SupportType::Rigid]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: if support
    // rust: .supported_by(&face)
    // rust: .map_err(|e| invalid(e.to_string()))?
    // rust: {
    // rust: flags[i] |= 1 << direction as u8;
}
}
}
    // rust: cache.insert(identity, flags);
    // rust: flags
}
    // rust: states.push(Some(flags));
}
    // rust: Ok(Self { shapes, states })
}
registry :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.shapes.registry()
}
cached_state_count :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.shapes.cached_state_count()
}
cached_shape :: proc(self: ^Self, state: BlockStateId) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.shapes.cached_shape(state)
}
    // rust: pub fn is_face_sturdy(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: direction: Direction,
    // rust: support: SupportType,
    // rust: ) -> io::Result<Option<bool>> {
    // rust: let flags = self
    // rust: .states
    // rust: .get(state.0 as usize)
    // rust: .ok_or_else(|| invalid("support state outside registry"))?;
    // rust: Ok(flags.map(|flags| {
    // rust: flags[match support {
    // rust: SupportType::Full => 0,
    // rust: SupportType::Center => 1,
    // rust: SupportType::Rigid => 2,
    // rust: }] & (1 << direction as u8)
    // rust: != 0
    // rust: }))
}
}

// use crate::dynamic_support::{DynamicSupport, DynamicSupportError, DynamicSupportWorld};
// Unified cached/dynamic support dispatch. Block-entity queries remain owned by
// the world, including the moving-piston entity's collision calculation.
BlockSupportRegistry :: struct {
    cached: CachedBlockSupportRegistry<'r>,
    dynamic: HashMap<BlockStateId,
}
SupportQueryError :: enum {
    Data(io::Error),
    Dynamic(DynamicSupportError<E>),
    Unsupported(BlockStateId),
}
    // rust: impl<E: std::fmt::Display> std::fmt::Display for SupportQueryError<E> {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Data(e) => e.fmt(f),
    // rust: Self::Dynamic(e) => e.fmt(f),
    // rust: Self::Unsupported(state) => write!(f, "unsupported block support state {}", state.0),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for SupportQueryError<E> {}
    // rust: impl<'r> BlockSupportRegistry<'r> {
from_nbt :: proc(tag: ^Tag, registry: ^'r BlockRegistry) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Self::from_table(BlockTable::check(tag, registry, "support")?)
}
from_table :: proc(table: BlockTable<'_) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let registry = table.registry();
    // rust: let cached = CachedBlockSupportRegistry::from_table(table)?;
    // rust: let mut dynamic = HashMap::new();
    // rust: for id in 0..registry.len() {
    // rust: let id = BlockStateId(id as u32);
    // rust: if cached.cached_shape(id)?.is_none() {
    // rust: if let Some(behavior) = DynamicSupport::from_state(registry.state(id).unwrap())? {
    // rust: dynamic.insert(id, behavior);
}
}
}
    // rust: Ok(Self { cached, dynamic })
}
registry :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.cached.registry()
}
    // rust: pub fn is_face_sturdy<W: DynamicSupportWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: state: BlockStateId,
    // rust: position: [i32; 3],
    // rust: direction: Direction,
    // rust: support: SupportType,
    // rust: ) -> Result<bool, SupportQueryError<W::Error>> {
    // rust: if let Some(result) = self
    // rust: .cached
    // rust: .is_face_sturdy(state, direction, support)
    // rust: .map_err(SupportQueryError::Data)?
    // rust: {
    // rust: return Ok(result);
}
    // rust: self.dynamic
    // rust: .get(&state)
    // rust: .ok_or(SupportQueryError::Unsupported(state))?
    // rust: .is_face_sturdy(world, position, direction, support)
    // rust: .map_err(SupportQueryError::Dynamic)
}
}
