//! Transpiled from Horizon Rust crate
package horizon_world_write_zone

import "core:fmt"
import "core:mem"
import "core:math"

// Horizontal generation write-zone predicate from the pinned chunk step.
// use horizon_core::position::{BlockPos, ChunkPos};

GenerationWriteZone :: struct {
    center: ChunkPos,
    radius: i32,
}
    // rust: impl GenerationWriteZone {
    // The caller supplies the center chunk and the generation step's write
    // radius. Negative radii and wrapped coordinates retain Java semantics.
new :: proc(center: ChunkPos, radius: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self { center, radius }
}
contains_chunk :: proc(self: ^Self, chunk: ChunkPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.center.x.wrapping_sub(chunk.x).wrapping_abs() <= self.radius
    // rust: && self.center.z.wrapping_sub(chunk.z).wrapping_abs() <= self.radius
}
contains_block :: proc(self: ^Self, position: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.contains_chunk(position.chunk())
}
}

// The center chunk's generation height while an upgrade is active. Normal
// generation has no vertical write-policy gate (storage bounds are separate).
UpgradeWriteHeight :: struct {
    min_y: i32,
    max_y: i32,
}
    // rust: impl UpgradeWriteHeight {
    // rust: pub const BELOW_ZERO: Self = Self {
    // rust: min_y: -64,
    // rust: max_y: -1,
}
new :: proc(min_y: i32, height: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: min_y,
    // rust: max_y: min_y.wrapping_add(height).wrapping_sub(1),
}
}
contains :: proc(self: ^Self, y: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: y >= self.min_y && y <= self.max_y
}
}
