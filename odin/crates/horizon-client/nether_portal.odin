//! Transpiled from Horizon Rust crate
package horizon_client_nether_portal

import "core:fmt"
import "core:mem"
import "core:math"

// `PortalProcessor` and an entity's portal cooldown
// (`Entity.setAsInsidePortal` / `handlePortal`) for nether portals.
// use horizon_core::position::BlockPos;

// `Entity.getDimensionChangingDelay`: the portal cooldown of an entity that
// went through a portal.
ENTITY_DELAY :: 300

// `PortalProcessor` for a nether portal.
Process :: struct {
    entry: BlockPos,
    time: i32,
    inside: bool,
}
    // rust: impl Process {
    // `processPortalTeleportation`: whether the entity goes through now.
process :: proc(self: ^Self, allowed: bool, transition_time: i32) -> b {
    // Ported from Horizon
    return {}
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

// An entity's `portalCooldown` and `portalProcess`.
PortalState :: struct {
    cooldown: i32,
    process: Maybe(Process),
}
    // rust: impl PortalState {
    // `Entity.setAsInsidePortal` for a nether portal block at `pos`.
set_inside :: proc(self: ^Self, pos: BlockPos, delay: i32) {
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
    // `Entity.handlePortal`: the entry block when the entity goes through
    // (its cooldown then set to `delay`).
handle :: proc(self: ^Self, allowed: bool, transition_time: i32, delay: i32) -> O {
    // Ported from Horizon
    return {}
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
