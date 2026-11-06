//! Transpiled from Horizon Rust crate
package horizon_world_interaction_shapes

import "core:fmt"
import "core:mem"
import "core:math"

// Complete registry-bound interaction shapes for ray-face overrides.
// use crate::{
    // rust: collision::CachedCollisionRegistry,
    // rust: compression::invalid,
    // rust: nbt::Tag,
    // rust: registry::{BlockRegistry, BlockStateId},
}
// use horizon_core::geometry::VoxelShape;
// use std::io;
// The pinned implementation audit establishes that every interaction shape is
// static per state. The import retains native alias/canonical shape identity.
InteractionShapes :: struct {
    shapes: CachedCollisionRegistry<'r>,
}
    // rust: impl<'r> InteractionShapes<'r> {
from_nbt :: proc(tag: ^Tag, registry: ^'r BlockRegistry) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if tag.get("kind") != Some(&Tag::String("interaction".into())) {
    // rust: return Err(invalid("not an interaction shape table"));
}
    // rust: let shapes = CachedCollisionRegistry::from_nbt(tag, registry)?;
    // rust: if !shapes.has_canonical_identities() || shapes.cached_state_count() != registry.len() {
    // rust: return Err(invalid(
    // rust: "interaction shape table must bind every state with canonical identities",
    // rust: ));
}
    // rust: Ok(Self { shapes })
}
registry :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.shapes.registry()
}
shape :: proc(self: ^Self, state: BlockStateId) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.shapes
    // rust: .cached_shape(state)?
    // rust: .ok_or_else(|| invalid("missing interaction shape"))
}
}
