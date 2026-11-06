//! Transpiled from Horizon Rust crate
//! Module: horizon-client_combat
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A mob's `CombatTracker`: the hits it took lately, which its death message
//! is built from (`TamableAnimal.die` sends it to the owner).
// use super::Damage;

/// `CombatEntry`: one hit, with where the mob was falling from when it landed.
pub const Entry = struct {
    source: Damage,
    damage: f32,
    /// `FallLocation.getCurrentFallLocation` is `WATER`. Horizon keeps no
    /// `lastClimbablePos` for mobs, so the climbable locations are not known.
    in_water: bool,
    fall_distance: f32,
};

/// `CombatTracker` for a mob, timed by its `tickCount` (`Mob::age`).
pub const Tracker = struct {
    entries: std.ArrayList(Entry),
    last_damage_time: u32,
    in_combat: bool,
    taking_damage: bool,
};

    // rust: impl Tracker {
    /// `CombatTracker.recordDamage`: the hit after forgetting an old fight; a
    /// living cause (`shouldEnterCombat`) starts a fight. It runs before the
    /// hit takes the health (`actuallyHurt`), so the mob is still alive.
pub fn record(self: *Self, entry: Entry, tick: u32) void {
}
    // rust: self.recheck(true, tick);
    // rust: let living_cause = entry.source.attacker.is_some();
    // rust: self.entries.push(entry);
    // rust: self.last_damage_time = tick;
    // rust: self.taking_damage = true;
    // rust: if !self.in_combat && living_cause {
    // rust: self.in_combat = true;
}
}
    /// `CombatTracker.recheckStatus`: 100 ticks without a hit (300 in a
    /// fight) forget them all. Vanilla also forgets them once the mob is
    /// dead, after `die` has read them; Horizon's `die` runs after the tick,
    /// so a dead mob's hits stay for it.
pub fn recheck(self: *Self, alive: bool, tick: u32) void {
}
    // rust: let reset = if self.in_combat { 300 } else { 100 };
    // rust: if alive && self.taking_damage && tick.wrapping_sub(self.last_damage_time) > reset {
    // rust: self.taking_damage = false;
    // rust: self.in_combat = false;
    // rust: self.entries.clear();
}
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::mobs::{DamageKind, Who};

pub fn hit(attacker: ?Who) E {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Entry {
    // rust: source: Damage {
    // rust: kind: DamageKind::MobAttack,
    // rust: attacker,
    // rust: from: None,
    // rust: attacker_species: None,
    // rust: },
    // rust: damage: 2.0,
    // rust: in_water: false,
    // rust: fall_distance: 0.0,
}
}

pub fn old_hits_are_forgotten_after_100_ticks_or_300_in_a_fight() void {
}
    // rust: let mut t = Tracker::default();
    // rust: t.record(hit(None), 10);
    // rust: t.recheck(true, 110);
    // rust: assert_eq!(t.entries.len(), 1, "100 ticks later it still remembers");
    // rust: t.recheck(true, 111);
    // rust: assert!(t.entries.is_empty());
    // rust: t.record(hit(Some(Who::Mob(7))), 200);
    // rust: assert!(t.in_combat);
    // rust: t.recheck(true, 500);
    // rust: assert_eq!(t.entries.len(), 1, "a fight is remembered for 300 ticks");
    // rust: t.record(hit(None), 501);
    // rust: assert_eq!(t.entries.len(), 1, "the new hit comes after forgetting");
    // rust: assert!(!t.in_combat);
}

pub fn a_dead_mob_keeps_its_hits_for_its_death_message() void {
}
    // rust: let mut t = Tracker::default();
    // rust: t.record(hit(Some(Who::Mob(7))), 0);
    // rust: t.recheck(false, 1000);
    // rust: assert_eq!(t.entries.len(), 1);
}
}
