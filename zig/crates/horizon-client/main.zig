//! Transpiled from Horizon Rust crate
//! Module: horizon-client_main
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Horizon: native Rust client for Minecraft Java Edition 26.3 gameplay.

pub const ALLOCATOR: horizon_threads::Allocator = horizon_threads::ALLOCATOR;
pub const ALLOCATOR: horizon_threads::CensusAllocator = horizon_threads::CensusAllocator;

/// The mod API level this game serves, kept in the program for the launcher
/// to read without running it (`horizon_mods::api_level::MARK`). `main`
/// reads it, so the linker keeps it.
pub const MOD_API_LEVEL: [u8; 27] = horizon_mods::api_level::MARK;

pub fn main() void {
}
    // rust: std::hint::black_box(&MOD_API_LEVEL);
    // rust: horizon_client::entry::main();
}
