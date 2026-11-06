//! Transpiled from Horizon Rust crate
//! Module: horizon-client_nether_portal
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `PortalProcessor` and an entity's portal cooldown
//! (`Entity.setAsInsidePortal` / `handlePortal`) for nether portals.
// use horizon_core::position::BlockPos;

/// `Entity.getDimensionChangingDelay`: the portal cooldown of an entity that
/// went through a portal.
pub const ENTITY_DELAY: i32 = 300;

/// `PortalProcessor` for a nether portal.
pub const Process = struct {
    entry: BlockPos,
    time: i32,
    inside: bool,
};
    // rust: impl Process {
    /// `processPortalTeleportation`: whether the entity goes through now.
pub fn process(self: *Self, allowed: bool, transition_time: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.inside {
            // decayTick
    // rust: self.time = (self.time - 4).max(0);
    // rust: return false;
}
    // rust: self.inside = false;
    // rust: if !allowed {
    // rust: return false;
}
    // rust: let time = self.time;
    // rust: self.time += 1;
    // rust: time >= transition_time
}
}

/// An entity's `portalCooldown` and `portalProcess`.
pub const PortalState = struct {
    cooldown: i32,
    process: ?Process,
};
    // rust: impl PortalState {
    /// `Entity.setAsInsidePortal` for a nether portal block at `pos`.
pub fn set_inside(self: *Self, pos: BlockPos, delay: i32) void {
}
    // rust: if self.cooldown > 0 {
    // rust: self.cooldown = delay;
    // rust: return;
}
    // rust: match &mut self.process {
    // rust: None => {
    // rust: self.process = Some(Process {
    // rust: entry: pos,
    // rust: time: 0,
    // rust: inside: true,
    // rust: })
}
    // rust: Some(p) if !p.inside => {
    // rust: p.entry = pos;
    // rust: p.inside = true;
}
    // rust: Some(_) => {}
}
}
    /// `Entity.handlePortal`: the entry block when the entity goes through
    /// (its cooldown then set to `delay`).
pub fn handle(self: *Self, allowed: bool, transition_time: i32, delay: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
        // processPortalCooldown
    // rust: if self.cooldown > 0 {
    // rust: self.cooldown -= 1;
}
    // rust: let process = self.process.as_mut()?;
    // rust: if process.process(allowed, transition_time) {
    // rust: self.cooldown = delay;
    // rust: return Some(process.entry);
}
        // hasExpired
    // rust: if process.time <= 0 {
    // rust: self.process = None;
}
    // rust: None
}
}
