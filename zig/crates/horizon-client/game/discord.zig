//! Transpiled from Horizon Rust crate
//! Module: horizon-client_discord
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! What the player is doing, for Discord Rich Presence (`horizon_client::discord_presence`).
// use super::*;
// use horizon_client::discord_presence::{self as presence, Dimension, Play, Status};

    // rust: impl Game<'_> {
    /// Each frame: only a change reaches the presence thread.
    // rust: pub(super) fn update_discord_presence(&self) {
        // One Discord status per computer: P1's, not a splitscreen player's.
    // rust: if self.options.split_guest {
    // rust: return;
}
    // rust: presence::set(self.discord_status());
}
pub fn discord_status(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.settings.extras.discord_presence {
    // rust: return Status::Off;
}
    // rust: if self.title.is_some() {
    // rust: return Status::Menus;
}
    // rust: let play = if let Some(host) = &self.lan {
    // rust: Play::Hosting {
    // rust: players: 1 + host.hub.guests.len(),
}
    // rust: } else if let Some(server) = &self.integrated {
    // rust: match (server.published(), &self.remote) {
    // rust: (Some(_), Some(remote)) => Play::Hosting {
    // rust: players: remote.player_count(),
    // rust: },
    // rust: _ => Play::Singleplayer,
}
    // rust: } else if self.remote.is_some() {
    // rust: Play::Multiplayer
    // rust: } else {
    // rust: Play::Singleplayer
}
    // rust: Status::World {
    // rust: play,
    // rust: dimension: match self.dim {
    // rust: Dim::Overworld => Dimension::Overworld,
    // rust: Dim::Nether => Dimension::Nether,
    // rust: Dim::End => Dimension::End,
    // rust: },
    // rust: mode: self.mode,
}
}
}
