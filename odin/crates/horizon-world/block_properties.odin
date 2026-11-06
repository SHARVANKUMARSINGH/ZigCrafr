//! Transpiled from Horizon Rust crate
package horizon_world_block_properties

import "core:fmt"
import "core:mem"
import "core:math"

// Immutable block-definition flags and legacy solidity calculated from cached
// collision shapes. Replacement with an item/fluid context is separate behavior.
// use crate::{
    // rust: DATA_VERSION,
    // rust: collision::CachedCollisionRegistry,
    // rust: compression::invalid,
    // rust: nbt::Tag,
    // rust: registry::{BlockRegistry, BlockStateId, BlockTable},
}
// use horizon_core::geometry::{Direction, ShapeError, ShapeOp, VoxelShape};
// use std::{
    // rust: collections::{BTreeMap, HashMap},
    // rust: io,
    // rust: sync::Arc,
}

BlockDefinitionProperties :: struct {
    force_solid_on: bool,
    force_solid_off: bool,
    replaceable: bool,
    liquid: bool,
    can_occlude: bool,
}
    // rust: impl BlockDefinitionProperties {
calculate_full_occlusion_faces :: proc(self: ^Self, occlusion: ^VoxelShape) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut mask = 0;
    // rust: if self.can_occlude {
    // rust: for direction in Direction::ALL {
    // rust: if !occlusion
    // rust: .face_shape(direction)?
    // rust: .join_is_not_empty(&VoxelShape::block(), ShapeOp::XOR)?
    // rust: {
    // rust: mask |= 1 << direction as u8;
}
}
}
    // rust: Ok(mask)
}
calculate_solid_render :: proc(self: ^Self, occlusion: ^VoxelShape) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.can_occlude && !occlusion.join_is_not_empty(&VoxelShape::block(), ShapeOp::XOR)?)
}

    // Force-on wins even if both definition flags are set. A missing cache
    // counts as non-solid; it is distinct from a missing collision implementation.
calculate_solid :: proc(self: ^Self, cached_shape: Maybe(^VoxelShape)) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.force_solid_on {
    // rust: return true;
}
    // rust: if self.force_solid_off {
    // rust: return false;
}
    // rust: cached_shape
    // rust: .and_then(VoxelShape::bounds)
    // rust: .is_some_and(|bounds| {
    // rust: bounds.average_size() >= 0.7291666666666666 || bounds.size().y >= 1.0
    // rust: })
}
}

BlockProperty :: enum {
    Solid,
    Replaceable,
    Liquid,
    SolidRender,
}
    // rust: impl BlockProperty {
mask :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Solid => 1,
    // rust: Self::Replaceable => 2,
    // rust: Self::Liquid => 4,
    // rust: Self::SolidRender => 8,
}
}
}
// An immutable property selection, shared by decoded block predicates.
BoundBlockProperty :: struct {
    states: ^[u8],
    mask: u8,
}
    // rust: impl BoundBlockProperty {
contains :: proc(self: ^Self, id: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.states
    // rust: .get(id.0 as usize)
    // rust: .is_some_and(|flags| flags & self.mask != 0)
}
}
// The per-state flag of the block definition's `canOcclude`, past the
// [`BlockProperty`] bits.
CAN_OCCLUDE :: 16

// Immutable FULL face-occlusion results, independent of support/collision.
BoundOcclusionFaces :: struct {
    states: ^[u8],
}
    // rust: impl BoundOcclusionFaces {
is_full :: proc(self: ^Self, state: BlockStateId, direction: Direction) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.states
    // rust: .get(state.0 as usize)
    // rust: .map(|mask| mask & (1 << direction as u8) != 0)
    // rust: .ok_or_else(|| invalid("unknown occlusion state ID"))
}
}

BlockPropertiesRegistry :: struct {
    registry: ^'r BlockRegistry,
    definitions: BTreeMap<string,
    states: ^[u8],
    occlusion_faces: BoundOcclusionFaces,
}
    // rust: impl<'r> BlockPropertiesRegistry<'r> {
from_nbt :: proc(tag: ^Tag, collisions: ^CachedCollisionRegistry<'r>) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Self::from_table(
    // rust: BlockTable::check(tag, collisions.registry(), "block property")?,
    // rust: collisions,
    // rust: )
}
    // rust: pub fn from_table(
    // rust: table: BlockTable<'_, '_>,
    // rust: collisions: &CachedCollisionRegistry<'r>,
    // rust: ) -> io::Result<Self> {
    // rust: let registry = collisions.registry();
    // rust: if !std::ptr::eq(table.registry(), registry) {
    // rust: return Err(invalid(
    // rust: "block properties and collisions use other registries",
    // rust: ));
}
    // rust: let tag = table.tag();
    // rust: if tag.get("DataVersion") != Some(&Tag::Int(DATA_VERSION)) {
    // rust: return Err(invalid("block properties DataVersion mismatch"));
}
    // rust: let Some(Tag::Compound(blocks)) = tag.get("blocks") else {
    // rust: return Err(invalid("missing block definition properties"));
}
    // rust: let mut definitions = BTreeMap::new();
    // rust: for (name, flags) in blocks {
    // rust: let name = name.to_string().map_err(|e| invalid(e.to_string()))?;
    // rust: let Tag::Byte(flags @ 0..=31) = flags else {
    // rust: return Err(invalid("invalid block definition flags"));
}
    // rust: if registry.default_state(&name).is_none() {
    // rust: return Err(invalid("unknown block definition properties"));
}
    // rust: definitions.insert(
    // rust: name,
    // rust: BlockDefinitionProperties {
    // rust: force_solid_on: flags & 1 != 0,
    // rust: force_solid_off: flags & 2 != 0,
    // rust: replaceable: flags & 4 != 0,
    // rust: liquid: flags & 8 != 0,
    // rust: can_occlude: flags & 16 != 0,
    // rust: },
    // rust: );
}
    // rust: let occlusion = CachedCollisionRegistry::from_table(
    // rust: table.nested("occlusion", "block occlusion shapes")?,
    // rust: )?;
    // rust: let mut result = Vec::with_capacity(registry.len());
    // rust: let mut faces = Vec::with_capacity(registry.len());
    // rust: let mut face_cache = HashMap::new();
    // rust: for id in 0..registry.len() {
    // rust: let id = BlockStateId(id as u32);
    // rust: let state = registry.state(id).unwrap();
    // rust: let properties = definitions
    // rust: .get(&state.name)
    // rust: .ok_or_else(|| invalid("missing block definition properties"))?;
    // rust: let shape = occlusion
    // rust: .cached_shape(id)?
    // rust: .ok_or_else(|| invalid("missing block occlusion shape"))?;
    // rust: let mask = if properties.can_occlude {
    // rust: let key = std::ptr::from_ref(shape);
    // rust: if let Some(mask) = face_cache.get(&key) {
    // rust: *mask
    // rust: } else {
    // rust: let mask = properties
    // rust: .calculate_full_occlusion_faces(shape)
    // rust: .map_err(|e| invalid(e.to_string()))?;
    // rust: face_cache.insert(key, mask);
    // rust: mask
}
    // rust: } else {
    // rust: 0
}
    // rust: faces.push(mask);
    // rust: result.push(
    // rust: u8::from(properties.calculate_solid(collisions.cached_shape(id)?))
    // rust: | (u8::from(properties.replaceable) << 1)
    // rust: | (u8::from(properties.liquid) << 2)
    // rust: | (u8::from(
    // rust: properties
    // rust: .calculate_solid_render(
    // rust: occlusion
    // rust: .cached_shape(id)?
    // rust: .ok_or_else(|| invalid("missing block occlusion shape"))?,
    // rust: )
    // rust: .map_err(|error| invalid(error.to_string()))?,
    // rust: ) << 3)
    // rust: | if properties.can_occlude {
    // rust: CAN_OCCLUDE
    // rust: } else {
    // rust: 0
    // rust: },
    // rust: );
}
    // rust: Ok(Self {
    // rust: registry,
    // rust: definitions,
    // rust: states: result.into(),
    // rust: occlusion_faces: BoundOcclusionFaces {
    // rust: states: faces.into(),
    // rust: },
    // rust: })
}
bind_occlusion_faces :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.occlusion_faces.clone()
}
registry :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.registry
}
definition :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.definitions.get(name).copied()
}
property :: proc(self: ^Self, id: BlockStateId, property: BlockProperty) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.states
    // rust: .get(id.0 as usize)
    // rust: .map(|flags| flags & property.mask() != 0)
    // rust: .ok_or_else(|| invalid("block property state outside registry"))
}
bind :: proc(self: ^Self, property: BlockProperty) -> B {
    // Ported from Horizon
    return {}
}
    // rust: BoundBlockProperty {
    // rust: states: Arc::clone(&self.states),
    // rust: mask: property.mask(),
}
}
    // The states whose block definition can occlude (BlockState.canOcclude).
bind_can_occlude :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
    // rust: BoundBlockProperty {
    // rust: states: Arc::clone(&self.states),
    // rust: mask: CAN_OCCLUDE,
}
}
}
