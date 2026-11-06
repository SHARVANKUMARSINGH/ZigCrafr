//! Transpiled from Horizon Rust crate
//! Module: horizon-world_block_entities
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Proto-chunk block-entity storage. Active payloads are caller-owned runtime
//! types; this module does not create entities or execute their behavior.
// use crate::{compression::invalid, nbt::Tag};
// use horizon_core::position::{BlockPos, ChunkPos};
// use std::{
    // rust: collections::{HashMap, HashSet},
    // rust: io,
}

/// Resolve native block-entity coordinates, relocating mismatched X/Z into the
/// owning chunk while retaining local offsets and the full Y coordinate. The
/// supplied tag is not rewritten. NumericTag float/double reads use Mth.floor.
pub fn position_from_tag(chunk: ChunkPos, tag: *Tag) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !matches!(tag, Tag::Compound(_)) {
    // rust: return Err(invalid("block entity is not a compound"));
}
    // rust: let read = |name| match tag.get(name) {
    // rust: Some(Tag::Byte(v)) => i32::from(*v),
    // rust: Some(Tag::Short(v)) => i32::from(*v),
    // rust: Some(Tag::Int(v)) => *v,
    // rust: Some(Tag::Long(v)) => *v as i32,
    // rust: Some(Tag::Float(bits)) => f64::from(f32::from_bits(*bits)).floor() as i32,
    // rust: Some(Tag::Double(bits)) => f64::from_bits(*bits).floor() as i32,
    // rust: _ => 0,
}
    // rust: let (mut x, y, mut z) = (read("x"), read("y"), read("z"));
    // rust: if x >> 4 != chunk.x || z >> 4 != chunk.z {
    // rust: x = chunk.x.wrapping_shl(4).wrapping_add(x & 15);
    // rust: z = chunk.z.wrapping_shl(4).wrapping_add(z & 15);
}
    // rust: Ok(BlockPos::new(x, y, z))
}

pub const ProtoBlockEntities = struct {
    position: ChunkPos,
    pending: HashMap<BlockPos,
    active: HashMap<BlockPos,
};
    // rust: impl<E> ProtoBlockEntities<E> {
pub fn new(position: ChunkPos) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: position,
    // rust: pending: HashMap::new(),
    // rust: active: HashMap::new(),
}
}
    /// Ignore a pending record when an active entity already owns its resolved
    /// position. Inserting an active entity removes any earlier pending record.
pub fn set_pending(self: *Self, tag: Tag) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let position = position_from_tag(self.position, &tag)?;
    // rust: if !self.active.contains_key(&position) {
    // rust: self.pending.insert(position, tag);
}
    // rust: Ok(())
}
    /// Position must be the payload's immutable world position, as supplied by
    /// the runtime's block-entity constructor. No chunk/build-height gate applies.
pub fn set_active(self: *Self, position: BlockPos, entity: E) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pending.remove(&position);
    // rust: self.active.insert(position, entity)
}
pub fn active(self: *Self, position: BlockPos) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.active.get(&position)
}
pub fn pending(self: *Self, position: BlockPos) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pending.get(&position)
}
    /// Mutating coordinate fields does not re-key an existing pending entry.
pub fn pending_mut(self: *Self, position: BlockPos) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pending.get_mut(&position)
}
pub fn pending_entries(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.pending
}
pub fn positions(self: *Self) H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pending
    // rust: .keys()
    // rust: .chain(self.active.keys())
    // rust: .copied()
    // rust: .collect()
}
pub fn remove(self: *Self, position: BlockPos) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pending.remove(&position);
    // rust: self.active.remove(&position)
}
    /// Serialize an active entity when present, otherwise clone its pending tag.
    /// The caller supplies runtime serialization; this does not instantiate NBT.
    // rust: pub fn for_saving<T>(
    // rust: &self,
    // rust: position: BlockPos,
    // rust: serialize: impl FnOnce(&E) -> Result<Tag, T>,
    // rust: ) -> Result<Option<Tag>, T> {
    // rust: if let Some(entity) = self.active.get(&position) {
    // rust: serialize(entity).map(Some)
    // rust: } else {
    // rust: Ok(self.pending.get(&position).cloned())
}
}
}
