//! Transpiled from Horizon Rust crate
package horizon_client_main

import "core:fmt"
import "core:mem"
import "core:math"

// Horizon: native Rust client for Minecraft Java Edition 26.3 gameplay.

ALLOCATOR :: horizon_threads::ALLOCATOR
ALLOCATOR :: horizon_threads::CensusAllocator

// The mod API level this game serves, kept in the program for the launcher
// to read without running it (`horizon_mods::api_level::MARK`). `main`
// reads it, so the linker keeps it.
MOD_API_LEVEL :: horizon_mods::api_level::MARK

main :: proc() {
}
    // rust: std::hint::black_box(&MOD_API_LEVEL);
    // rust: horizon_client::entry::main();
}
