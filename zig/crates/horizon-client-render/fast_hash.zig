//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_fast_hash
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The Fx hasher for hot maps keyed by small integers: kept in horizon-core
//! (the scheduled ticks use it too), and reachable here under its old path.
    // rust: pub use horizon_core::fast_hash::*;
