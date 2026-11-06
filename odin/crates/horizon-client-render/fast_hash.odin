//! Transpiled from Horizon Rust crate
package horizon_client_render_fast_hash

import "core:fmt"
import "core:mem"
import "core:math"

// The Fx hasher for hot maps keyed by small integers: kept in horizon-core
// (the scheduled ticks use it too), and reachable here under its old path.
    // rust: pub use horizon_core::fast_hash::*;
