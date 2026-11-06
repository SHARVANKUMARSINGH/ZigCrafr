//! Transpiled from Horizon Rust crate
package horizon_world_suffocation

import "core:fmt"
import "core:mem"
import "core:math"

// Native suffocation predicates bound to a registry and a resolved block-tag set.
// use crate::{
    // rust: block_collision::{BlockCollisionRegistry, CollisionQueryError, DynamicCollisionWorld},
    // rust: compression::invalid,
    // rust: registry::BlockStateId,
}
// use horizon_core::geometry::{ShapeOp, VoxelShape};
// use std::{
    // rust: collections::{BTreeMap, BTreeSet, HashMap},
    // rust: io,
    // rust: sync::Arc,
}

SuffocationDefinition :: enum {
    TaggedFullCollision,
    Always,
    Never,
    NotExtendedPiston,
    ClosedShulker,
}
Rule :: enum {
    Constant(bool),
    DynamicFull,
    Shulker,
}

SuffocationRegistry :: struct {
    collisions: ^BlockCollisionRegistry<'r>,
    rules: [dynamic]Rule,
}
    // rust: impl<'r> SuffocationRegistry<'r> {
collisions :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.collisions
}

    // Rebind after the causes_suffocation tag changes. Definition keys and tag
    // members are canonical block identifiers from the same pinned registry.
    // rust: pub fn new(
    // rust: collisions: Arc<BlockCollisionRegistry<'r>>,
    // rust: definitions: &BTreeMap<String, SuffocationDefinition>,
    // rust: causes_suffocation: &BTreeSet<String>,
    // rust: ) -> io::Result<Self> {
    // rust: let registry = collisions.registry();
    // rust: if definitions
    // rust: .keys()
    // rust: .chain(causes_suffocation)
    // rust: .any(|name| registry.default_state(name).is_none())
    // rust: {
    // rust: return Err(invalid("unknown suffocation definition or tag member"));
}
    // rust: let mut full_shapes = HashMap::new();
    // rust: let mut rules = Vec::with_capacity(registry.len());
    // rust: for index in 0..registry.len() {
    // rust: let id = BlockStateId(index as u32);
    // rust: let state = registry.state(id).unwrap();
    // rust: let definition = definitions
    // rust: .get(&state.name)
    // rust: .ok_or_else(|| invalid("missing suffocation definition"))?;
    // rust: let rule = match definition {
    // rust: SuffocationDefinition::Always => Rule::Constant(true),
    // rust: SuffocationDefinition::Never => Rule::Constant(false),
    // rust: SuffocationDefinition::NotExtendedPiston => {
    // rust: Rule::Constant(match state.properties.get("extended").map(String::as_str) {
    // rust: Some("false") => true,
    // rust: Some("true") => false,
    // rust: _ => return Err(invalid("invalid piston suffocation property")),
    // rust: })
}
    // rust: SuffocationDefinition::ClosedShulker => Rule::Shulker,
    // rust: SuffocationDefinition::TaggedFullCollision => {
    // rust: if !causes_suffocation.contains(&state.name) {
    // rust: Rule::Constant(false)
    // rust: } else if let Some(shape) = collisions.cached_shapes().cached_shape(id)? {
    // rust: let identity = std::ptr::from_ref(shape);
    // rust: let full = if let Some(full) = full_shapes.get(&identity) {
    // rust: *full
    // rust: } else {
    // rust: let full = !shape
    // rust: .join_is_not_empty(&VoxelShape::block(), ShapeOp::XOR)
    // rust: .map_err(|e| invalid(e.to_string()))?;
    // rust: full_shapes.insert(identity, full);
    // rust: full
}
    // rust: Rule::Constant(full)
    // rust: } else {
    // rust: Rule::DynamicFull
}
}
}
    // rust: rules.push(rule);
}
    // rust: Ok(Self { collisions, rules })
}

    // rust: pub fn is_suffocating<W: DynamicCollisionWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: state: BlockStateId,
    // rust: position: [i32; 3],
    // rust: ) -> Result<bool, CollisionQueryError<W::Error>> {
    // rust: let rule = self.rules.get(state.0 as usize).ok_or_else(|| {
    // rust: CollisionQueryError::Data(invalid("suffocation state outside registry"))
    // rust: })?;
    // rust: match rule {
    // rust: Rule::Constant(value) => Ok(*value),
    // rust: Rule::Shulker => world
    // rust: .shulker_is_closed(position)
    // rust: .map(|closed| closed != Some(false))
    // rust: .map_err(CollisionQueryError::Context),
    // rust: Rule::DynamicFull => self
    // rust: .collisions
    // rust: .collision_shape(world, state, position)?
    // rust: .join_is_not_empty(&VoxelShape::block(), ShapeOp::XOR)
    // rust: .map(|different| !different)
    // rust: .map_err(|error| CollisionQueryError::Data(invalid(error.to_string()))),
}
}
}
