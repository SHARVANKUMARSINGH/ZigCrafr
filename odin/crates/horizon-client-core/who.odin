//! Transpiled from Horizon Rust crate
package horizon_client_core_who

import "core:fmt"
import "core:mem"
import "core:math"

// Who an action came from or is aimed at: the player or a mob by id.

// Who caused damage or is being targeted.
Who :: enum {
    Player,
    Mob(u32),
}
