//! Transpiled from Horizon Rust crate
package horizon_client_lib

import "core:fmt"
import "core:mem"
import "core:math"

// Gameplay and startup, above the reusable client library.
// No `#![recursion_limit]` or other inner attribute horizon-mixins doesn't know here: the
// launcher's horizon-mixins then rejects every native mod targeting this crate (#8169).
    // rust: extern crate self as horizon_client;
    // rust: pub use horizon_client_lib::*;
    // rust: pub mod entry;
    // rust: pub mod game;
    // rust: pub mod mod_api;
