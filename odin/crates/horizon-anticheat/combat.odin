//! Transpiled from Horizon Rust crate
package horizon_anticheat_combat

import "core:fmt"
import "core:mem"
import "core:math"

// Combat: attacks vanilla's client can't send (docs/anticheat.md).
//
// Vanilla's client sends ServerboundAttackPacket from one place only, `Minecraft.startAttack`, run from
// `handleKeybinds` once per client tick. It attacks the entity of the tick's `hitResult`, which
// `Minecraft.tick` picks once before the keys are handled, so every attack of one client tick is on the
// same entity. And each attack swings the arm (ServerboundPunchPacket) in the same call, so a client
// tick never has more attacks than swings: a tick that does comes from a kill aura hiding its swing.
// The swing is counted before or after the attack, as older clients behind a version proxy swing
// first; a swing without an attack (a miss, a block) is fine.

// What breaks vanilla's way of attacking.
Foul :: enum {
    // A client tick with more attacks than swings: how many more.
    NoSwing(u32),
    // A second entity attacked in the same client tick: the first one and this one.
    TwoTargets(i32, i32),
}

// The attacks of the client tick being heard.
Attacks :: struct {
    // The entity this tick attacked first.
    target: Maybe(i32),
    attacks: u32,
    swings: u32,
}

    // rust: impl Attacks {
    // ServerboundAttackPacket on entity `target`.
attack :: proc(self: ^Self, target: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.attacks = self.attacks.saturating_add(1);
    // rust: let first = *self.target.get_or_insert(target);
    // rust: (first != target).then_some(Foul::TwoTargets(first, target))
}

    // ServerboundPunchPacket: the arm swung.
swing :: proc(self: ^Self) {
}
    // rust: self.swings = self.swings.saturating_add(1);
}

    // ServerboundClientTickEndPacket: the tick's attacks are counted, and the next tick picks its
    // target again.
tick_end :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let unswung = self.attacks.saturating_sub(self.swings);
    // rust: *self = Self::default();
    // rust: (unswung > 0).then_some(Foul::NoSwing(unswung))
}
}

    // rust: mod tests {
//     use super::*;

a_vanilla_tick_is_clean :: proc() {
}
    // rust: let mut a = Attacks::default();
        // Two clicks in one tick on the same entity, each swung for.
    // rust: for _ in 0..2 {
    // rust: assert_eq!(a.attack(7), None);
    // rust: a.swing();
}
    // rust: assert_eq!(a.tick_end(), None);
        // The next tick may attack another entity, swinging first (an older client).
    // rust: a.swing();
    // rust: assert_eq!(a.attack(8), None);
    // rust: assert_eq!(a.tick_end(), None);
        // A swing on its own (a miss, a block) is fine.
    // rust: a.swing();
    // rust: assert_eq!(a.tick_end(), None);
}

an_attack_not_swung_for_is_caught :: proc() {
}
    // rust: let mut a = Attacks::default();
    // rust: a.attack(7);
    // rust: assert_eq!(a.tick_end(), Some(Foul::NoSwing(1)));
        // A swing in the tick before doesn't count for this one.
    // rust: a.swing();
    // rust: a.tick_end();
    // rust: a.attack(7);
    // rust: a.attack(7);
    // rust: a.swing();
    // rust: assert_eq!(a.tick_end(), Some(Foul::NoSwing(1)));
}

two_entities_in_one_tick_are_caught :: proc() {
}
    // rust: let mut a = Attacks::default();
    // rust: a.attack(7);
    // rust: a.swing();
    // rust: assert_eq!(a.attack(8), Some(Foul::TwoTargets(7, 8)));
    // rust: a.swing();
        // Still against the tick's first target.
    // rust: assert_eq!(a.attack(9), Some(Foul::TwoTargets(7, 9)));
    // rust: a.swing();
    // rust: assert_eq!(a.tick_end(), None);
}
}
