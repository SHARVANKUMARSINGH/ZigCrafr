//! Transpiled from Horizon Rust crate
//! Module: horizon-world_fluid_predicate
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Resolved fluid holder sets bound to immutable vanilla block-state identities.
// use super::{DecodeError, density::identifier};
// use crate::{
    // rust: fluid::{FluidKind, FluidStateTable},
    // rust: registry::{BlockRegistry, BlockStateId},
}
// use std::{collections::BTreeMap, sync::Arc};
pub const FluidPredicateBindings = struct {
    table: *FluidStateTable,
    tags: BTreeMap<[]const u8,
};
    // rust: impl FluidPredicateBindings {
pub fn new(registry: *BlockRegistry) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(Self {
    // rust: table: Arc::new(
    // rust: FluidStateTable::new(registry).map_err(|e| DecodeError::Registry(e.to_string()))?,
    // rust: ),
    // rust: tags: BTreeMap::new(),
    // rust: })
}
    // rust: pub fn with_resolved_tags(
    // rust: mut self,
    // rust: tags: &BTreeMap<String, Vec<String>>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: if tags.len() > 8192 {
    // rust: return Err(DecodeError::Field("fluid tag count"));
}
    // rust: let mut resolved = BTreeMap::new();
    // rust: for (tag, names) in tags {
    // rust: if names.len() > 8192 {
    // rust: return Err(DecodeError::Field("fluid tag size"));
}
    // rust: let mut mask = 0;
    // rust: for name in names {
    // rust: mask |= fluid(name)?.mask();
}
    // rust: if resolved
    // rust: .insert(super::tags::identifier(tag)?, mask)
    // rust: .is_some()
    // rust: {
    // rust: return Err(DecodeError::Field("duplicate fluid tag"));
}
}
    // rust: self.tags = resolved;
    // rust: Ok(self)
}
    // rust: pub(crate) fn table(&self) -> &Arc<FluidStateTable> {
    // rust: &self.table
}
pub fn state(self: *Self, block: BlockStateId) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.table.get(block)
}
    /// Missing tags have no members, as for a native tag-key membership query.
pub fn state_matches_tag(self: *Self, block: BlockStateId, tag: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.table.get(block).is_some_and(|state| {
    // rust: self.tags
    // rust: .get(tag)
    // rust: .is_some_and(|mask| state.kind().mask() & mask != 0)
    // rust: })
}
pub fn resolve(self: *Self, json: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mask = if let Ok(name) = serde_json::from_str::<String>(json) {
    // rust: if let Some(tag) = name.strip_prefix('#') {
    // rust: *self
    // rust: .tags
    // rust: .get(&super::tags::identifier(tag)?)
    // rust: .ok_or_else(|| DecodeError::Registry(format!("unknown fluid tag {tag}")))?
    // rust: } else {
    // rust: fluid(&name)?.mask()
}
    // rust: } else {
    // rust: let names: Vec<String> = serde_json::from_str(json)?;
    // rust: if names.len() > 8192 {
    // rust: return Err(DecodeError::Field("fluid holder list"));
}
    // rust: let mut mask = 0;
    // rust: for name in names {
    // rust: mask |= fluid(&name)?.mask();
}
    // rust: mask
}
    // rust: Ok(BoundFluidSet {
    // rust: table: self.table.clone(),
    // rust: mask,
    // rust: })
}
}
pub fn fluid(name: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: FluidKind::from_name(&identifier(name)?)
    // rust: .ok_or_else(|| DecodeError::Registry(format!("unknown fluid {name}")))
}

/// A fluid-family mask over one shared immutable state table. Membership needs
/// one indexed lookup and avoids allocating large sets of equivalent states.
pub const BoundFluidSet = struct {
    table: *FluidStateTable,
    mask: u8,
};
    // rust: impl BoundFluidSet {
pub fn contains(self: *Self, state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.table
    // rust: .get(state)
    // rust: .is_some_and(|value| value.kind().mask() & self.mask != 0)
}
}
