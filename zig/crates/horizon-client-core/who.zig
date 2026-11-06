//! Transpiled from Horizon Rust crate
//! Module: horizon-client-core_who
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Who an action came from or is aimed at: the player or a mob by id.

/// Who caused damage or is being targeted.
pub const Who = enum {
    Player,
    Mob(u32),
};
