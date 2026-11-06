//! Transpiled from Horizon Rust crate
//! Module: horizon-anticheat_combat
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Combat: attacks vanilla's client can't send (docs/anticheat.md).
//!
//! Vanilla's client sends ServerboundAttackPacket from one place only, `Minecraft.startAttack`, run from
//! `handleKeybinds` once per client tick. It attacks the entity of the tick's `hitResult`, which
//! `Minecraft.tick` picks once before the keys are handled, so every attack of one client tick is on the
//! same entity. And each attack swings the arm (ServerboundPunchPacket) in the same call, so a client
//! tick never has more attacks than swings: a tick that does comes from a kill aura hiding its swing.
//! The swing is counted before or after the attack, as older clients behind a version proxy swing
//! first; a swing without an attack (a miss, a block) is fine.

/// What breaks vanilla's way of attacking.
pub const Foul = enum {
    /// A client tick with more attacks than swings: how many more.
    NoSwing(u32),
    /// A second entity attacked in the same client tick: the first one and this one.
    TwoTargets(i32, i32),
};

/// The attacks of the client tick being heard.
pub const Attacks = struct {
    /// The entity this tick attacked first.
    target: ?i32,
    attacks: u32,
    swings: u32,
};

    // rust: impl Attacks {
    /// ServerboundAttackPacket on entity `target`.
pub fn attack(self: *Self, target: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.attacks = self.attacks.saturating_add(1);
    // rust: let first = *self.target.get_or_insert(target);
    // rust: (first != target).then_some(Foul::TwoTargets(first, target))
}

    /// ServerboundPunchPacket: the arm swung.
pub fn swing(self: *Self) void {
}
    // rust: self.swings = self.swings.saturating_add(1);
}

    /// ServerboundClientTickEndPacket: the tick's attacks are counted, and the next tick picks its
    /// target again.
pub fn tick_end(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let unswung = self.attacks.saturating_sub(self.swings);
    // rust: *self = Self::default();
    // rust: (unswung > 0).then_some(Foul::NoSwing(unswung))
}
}

    // rust: mod tests {
//     use super::*;

pub fn a_vanilla_tick_is_clean() void {
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

pub fn an_attack_not_swung_for_is_caught() void {
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

pub fn two_entities_in_one_tick_are_caught() void {
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
