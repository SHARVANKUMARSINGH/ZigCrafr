//! Transpiled from Horizon Rust crate
//! Module: horizon-world_write_zone
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Horizontal generation write-zone predicate from the pinned chunk step.
// use horizon_core::position::{BlockPos, ChunkPos};

pub const GenerationWriteZone = struct {
    center: ChunkPos,
    radius: i32,
};
    // rust: impl GenerationWriteZone {
    /// The caller supplies the center chunk and the generation step's write
    /// radius. Negative radii and wrapped coordinates retain Java semantics.
pub fn new(center: ChunkPos, radius: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self { center, radius }
}
pub fn contains_chunk(self: *Self, chunk: ChunkPos) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.center.x.wrapping_sub(chunk.x).wrapping_abs() <= self.radius
    // rust: && self.center.z.wrapping_sub(chunk.z).wrapping_abs() <= self.radius
}
pub fn contains_block(self: *Self, position: BlockPos) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.contains_chunk(position.chunk())
}
}

/// The center chunk's generation height while an upgrade is active. Normal
/// generation has no vertical write-policy gate (storage bounds are separate).
pub const UpgradeWriteHeight = struct {
    min_y: i32,
    max_y: i32,
};
    // rust: impl UpgradeWriteHeight {
    // rust: pub const BELOW_ZERO: Self = Self {
    // rust: min_y: -64,
    // rust: max_y: -1,
}
pub fn new(min_y: i32, height: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: min_y,
    // rust: max_y: min_y.wrapping_add(height).wrapping_sub(1),
}
}
pub fn contains(self: *Self, y: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: y >= self.min_y && y <= self.max_y
}
}
