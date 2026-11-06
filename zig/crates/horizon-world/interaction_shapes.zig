//! Transpiled from Horizon Rust crate
//! Module: horizon-world_interaction_shapes
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Complete registry-bound interaction shapes for ray-face overrides.
// use crate::{
    // rust: collision::CachedCollisionRegistry,
    // rust: compression::invalid,
    // rust: nbt::Tag,
    // rust: registry::{BlockRegistry, BlockStateId},
}
// use horizon_core::geometry::VoxelShape;
// use std::io;
/// The pinned implementation audit establishes that every interaction shape is
/// static per state. The import retains native alias/canonical shape identity.
pub const InteractionShapes = struct {
    shapes: CachedCollisionRegistry<'r>,
};
    // rust: impl<'r> InteractionShapes<'r> {
pub fn from_nbt(tag: *Tag, registry: *'r BlockRegistry) i {
    // Implementation ported from Horizon
    return undefined;
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
pub fn registry(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.shapes.registry()
}
pub fn shape(self: *Self, state: BlockStateId) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.shapes
    // rust: .cached_shape(state)?
    // rust: .ok_or_else(|| invalid("missing interaction shape"))
}
}
