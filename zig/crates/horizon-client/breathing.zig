//! Transpiled from Horizon Rust crate
//! Module: horizon-client_breathing
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Breathing for native mods: `LivingEntity.baseTick`'s air supply, the part
//! that raises or lowers it. A player (`motion/environment.rs`) and a mob
//! (`mobs/ai.rs`) work out what vanilla does this tick, `breathe` lets the
//! mods change it (`native_living_breathe`, NeoForge's `LivingBreatheEvent`),
//! and the caller applies the answer. Servers only: the callers keep it off a
//! client's prediction.

/// One tick of breathing: whether the entity can breathe, how much air it
/// loses when it cannot and how much it gains when it can.
pub const Breath = struct {
    can_breathe: bool,
    /// `decreaseAirSupply`: 1, or 0 by the oxygen bonus's chance, for an
    /// entity that drowns; 1 for one that would not.
    consume: i32,
    /// `increaseAirSupply`: 4 for one that can breathe, 0 for one that drowns
    /// or is held under by the nautilus' breath.
    refill: i32,
};

/// An entity's breathing this tick (`LivingBreatheEvent`, posted from
/// `LivingEntity.baseTick` every tick for a living entity with the generic
/// air logic): `entity` is its ID and `kind` its type (`minecraft:player`,
/// `minecraft:zombie`). `can_breathe`, `consume` and `refill` come in as
/// Horizon does it today (a mod-free game changes nothing); set them to
/// change this tick. With `can_breathe` the air rises by `refill`, up to its
/// maximum (300); without, it falls by `consume`, and at -20 it is set to 0
/// and the entity takes 2 drowning damage. Negative amounts count as 0.
/// Asked on servers for players and for mobs, except those with a
/// `WaterAnimal`'s or an axolotl's own air logic. API 144.
    // rust: pub fn native_living_breathe(
    // rust: entity: u32,
    // rust: kind: &str,
    // rust: can_breathe: &mut bool,
    // rust: consume: &mut i32,
    // rust: refill: &mut i32,
    // rust: ) {
    // rust: crate::native_client_hooks::living_breathe(entity, kind, can_breathe, consume, refill);
}

/// `vanilla`'s breathing after the mods have had their say.
pub fn breathe(entity: u32, kind: []const u8, vanilla: Breath) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut now = vanilla;
    // rust: native_living_breathe(
    // rust: entity,
    // rust: kind,
    // rust: &mut now.can_breathe,
    // rust: &mut now.consume,
    // rust: &mut now.refill,
    // rust: );
    // rust: Breath {
    // rust: can_breathe: now.can_breathe,
    // rust: consume: now.consume.max(0),
    // rust: refill: now.refill.max(0),
}
}

/// An entity that can't breathe and has no air (`LivingDrownEvent`, posted
/// from `LivingEntity.baseTick`), with vanilla's answers as the defaults: it
/// drowns at -20 air, for 2 damage and 8 bubbles. Bubble count is read-only;
/// changes to the event field do not affect the vanilla entity event. Asked on
/// servers, for the entities `native_living_breathe` is. API 356.
    // rust: pub fn native_living_drown(
    // rust: entity: u32,
    // rust: kind: &str,
    // rust: is_drowning: &mut bool,
    // rust: damage_amount: &mut f32,
    // rust: bubble_count: i32,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: crate::native_client_hooks::living_drown(
    // rust: entity,
    // rust: kind,
    // rust: is_drowning,
    // rust: damage_amount,
    // rust: bubble_count,
    // rust: cancel,
    // rust: );
}

/// A drowning tick as the mods left it.
pub const Drowning = struct {
    damage: ?f32,
};

/// `breath` applied to `air` (`apply`), then `LivingEntity.baseTick`'s
/// drowning, which the mods may change when `server` (`native_living_drown`).
/// An entity that drowns is set to 0 air.
    // rust: pub fn drown(
    // rust: entity: u32,
    // rust: kind: &str,
    // rust: air: &mut i32,
    // rust: breath: Breath,
    // rust: server: bool,
    // rust: ) -> Option<Drowning> {
    // rust: let (next, drowned) = apply(*air, 300, breath);
    // rust: *air = if drowned { *air - breath.consume } else { next };
    // rust: let (mut drowning, mut damage, mut cancel) = (drowned, 2.0, false);
    // rust: if server && !breath.can_breathe && *air <= 0 {
    // rust: native_living_drown(entity, kind, &mut drowning, &mut damage, 8, &mut cancel);
}
    // rust: if cancel || !drowning {
    // rust: return None;
}
    // rust: *air = 0;
    // rust: Some(Drowning {
    // rust: damage: (damage > 0.0).then_some(damage),
    // rust: })
}

/// The air supply after `breath`: raised up to `max` when it can breathe,
/// lowered otherwise. The second is whether the entity now drowns
/// (`LivingEntity.shouldTakeDrowningDamage`: -20 or less), and its air is
/// then 0.
pub fn apply(air: i32, max: i32, breath: Breath) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if breath.can_breathe {
    // rust: return (air.max((air + breath.refill).min(max)), false);
}
    // rust: let air = air - breath.consume;
    // rust: if air <= -20 { (0, true) } else { (air, false) }
}

    // rust: mod tests {
//     use super::*;

    // rust: const VANILLA: Breath = Breath {
    // rust: can_breathe: true,
    // rust: consume: 1,
    // rust: refill: 4,
}

pub fn air_refills_up_to_the_maximum() void {
}
    // rust: assert_eq!(apply(100, 300, VANILLA), (104, false));
    // rust: assert_eq!(apply(299, 300, VANILLA), (300, false));
    // rust: assert_eq!(apply(300, 300, VANILLA), (300, false));
        // A refill of 0 leaves it, as does one that would pass the maximum.
    // rust: let held = Breath {
    // rust: refill: 0,
    // rust: ..VANILLA
}
    // rust: assert_eq!(apply(120, 300, held), (120, false));
}

pub fn air_runs_down_and_drowns_at_minus_twenty() void {
}
    // rust: let drowning = Breath {
    // rust: can_breathe: false,
    // rust: consume: 1,
    // rust: refill: 0,
}
    // rust: assert_eq!(apply(300, 300, drowning), (299, false));
    // rust: assert_eq!(apply(-18, 300, drowning), (-19, false));
    // rust: assert_eq!(apply(-19, 300, drowning), (0, true));
        // The oxygen bonus can spare a tick, and a mod can take more.
    // rust: let spared = Breath {
    // rust: consume: 0,
    // rust: ..drowning
}
    // rust: assert_eq!(apply(-19, 300, spared), (-19, false));
    // rust: let gas = Breath {
    // rust: consume: 30,
    // rust: ..drowning
}
    // rust: assert_eq!(apply(20, 300, gas), (-10, false));
    // rust: assert_eq!(apply(10, 300, gas), (0, true));
}

pub fn nothing_changes_without_a_mod() void {
}
    // rust: assert_eq!(breathe(1, "minecraft:zombie", VANILLA), VANILLA);
    // rust: let negative = Breath {
    // rust: can_breathe: false,
    // rust: consume: -3,
    // rust: refill: -2,
}
        // Mods only ever answer with their own values, so what comes back is clamped.
    // rust: assert_eq!(breathe(1, "minecraft:player", negative).consume, 0);
    // rust: assert_eq!(breathe(1, "minecraft:player", negative).refill, 0);
}
}
