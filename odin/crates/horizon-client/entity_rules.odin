//! Transpiled from Horizon Rust crate
package horizon_client_entity_rules

import "core:fmt"
import "core:mem"
import "core:math"

// PURPOSE: `Entity`'s gravity and fluid-push rules, decided once for every kind.
// WHY: each kind used to check its own `NoGravity` flag and pick its own
// number, so a kind that forgot the check ignored the flag (#6481).
// REFS: vanilla `Entity.isNoGravity`, `getDefaultGravity`, `getGravity`,
// `applyGravity`, `isPushedByFluid`; issue #6509, slice #6544.
// LOGS: none. READS-BY: the kinds' ticks in this crate and in `game/`.
// ENDS-WHEN: kinds share one stored `Entity` state and this folds into it.

// The rules vanilla's `Entity` answers for every kind. A kind overrides one
// only where its vanilla class does; the defaults are `Entity`'s.
    // rust: pub trait EntityRules {
    // `Entity.isNoGravity` (`NoGravity` in the save).
is_no_gravity :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
    // `Entity.getDefaultGravity`.
get_default_gravity :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 0.0
}
    // `Entity.getGravity`: none with `NoGravity`, else the kind's default.
    // `applyGravity` subtracts this from the vertical velocity.
get_gravity :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if self.is_no_gravity() {
    // rust: 0.0
    // rust: } else {
    // rust: self.get_default_gravity()
}
}
    // `Entity.isPushedByFluid`.
is_pushed_by_fluid :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
}
