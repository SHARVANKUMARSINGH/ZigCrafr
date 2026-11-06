//! Transpiled from Horizon Rust crate
package horizon_client_execution_role

import "core:fmt"
import "core:mem"
import "core:math"

// A Game's execution role is fixed at construction. Connecting or disconnecting
// changes `remote`, not this role. A client never simulates a world itself: single
// player's runs on its integrated server thread.

    // rust: pub(super) enum ExecutionRole {
    // rust: Client,
    // rust: IntegratedServer,
    // rust: DedicatedServer,
}

    // rust: impl ExecutionRole {
    // Only a client owns presentation work (audio, loading UI, chunk meshes).
is_client :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self == Self::Client
}

    // Single-player worlds (on the integrated server thread) keep the owner's state in
    // `Level` and write `players/data/<singleplayer_uuid>.dat` with the world; a dedicated
    // server saves each connected player separately.
writes_singleplayer_player :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self != Self::DedicatedServer
}
}
