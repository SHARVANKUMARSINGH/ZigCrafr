//! Transpiled from Horizon Rust crate
//! Module: horizon-client_entity_rules
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! PURPOSE: `Entity`'s gravity and fluid-push rules, decided once for every kind.
//! WHY: each kind used to check its own `NoGravity` flag and pick its own
//! number, so a kind that forgot the check ignored the flag (#6481).
//! REFS: vanilla `Entity.isNoGravity`, `getDefaultGravity`, `getGravity`,
//! `applyGravity`, `isPushedByFluid`; issue #6509, slice #6544.
//! LOGS: none. READS-BY: the kinds' ticks in this crate and in `game/`.
//! ENDS-WHEN: kinds share one stored `Entity` state and this folds into it.

/// The rules vanilla's `Entity` answers for every kind. A kind overrides one
/// only where its vanilla class does; the defaults are `Entity`'s.
    // rust: pub trait EntityRules {
    /// `Entity.isNoGravity` (`NoGravity` in the save).
pub fn is_no_gravity(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: false
}
    /// `Entity.getDefaultGravity`.
pub fn get_default_gravity(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 0.0
}
    /// `Entity.getGravity`: none with `NoGravity`, else the kind's default.
    /// `applyGravity` subtracts this from the vertical velocity.
pub fn get_gravity(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.is_no_gravity() {
    // rust: 0.0
    // rust: } else {
    // rust: self.get_default_gravity()
}
}
    /// `Entity.isPushedByFluid`.
pub fn is_pushed_by_fluid(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
}
