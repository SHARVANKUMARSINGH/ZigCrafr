//! Transpiled from Horizon Rust crate
//! Module: horizon-client_execution_role
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A Game's execution role is fixed at construction. Connecting or disconnecting
//! changes `remote`, not this role. A client never simulates a world itself: single
//! player's runs on its integrated server thread.

    // rust: pub(super) enum ExecutionRole {
    // rust: Client,
    // rust: IntegratedServer,
    // rust: DedicatedServer,
}

    // rust: impl ExecutionRole {
    /// Only a client owns presentation work (audio, loading UI, chunk meshes).
pub fn is_client(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self == Self::Client
}

    /// Single-player worlds (on the integrated server thread) keep the owner's state in
    /// `Level` and write `players/data/<singleplayer_uuid>.dat` with the world; a dedicated
    /// server saves each connected player separately.
pub fn writes_singleplayer_player(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self != Self::DedicatedServer
}
}
