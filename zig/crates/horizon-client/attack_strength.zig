//! Transpiled from Horizon Rust crate
//! Module: horizon-client_attack_strength
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The player's attack strength (`Player.attackStrengthTicker`,
//! `itemSwapTicker`, `getAttackStrengthScale`, `getCurrentItemAttackStrengthDelay`):
//! the charge the attack indicator shows and attacks scale their damage by.

/// `Attributes.ATTACK_SPEED` base value.
pub const BASE_ATTACK_SPEED: f64 = 4.0;

pub const AttackStrength = struct {
    /// `LivingEntity.attackStrengthTicker`.
    ticker: i32,
    /// `LivingEntity.itemSwapTicker`.
    swap_ticker: i32,
    /// `Player.lastItemInMainHand`: the stack as last compared.
    last_item: ?HeldStack,
};
/// What `ItemStack.matches` / `isSameItem` compare of the main-hand stack:
/// its item id and the rest of the stack (count and components) as a key.
pub const HeldStack = struct {
    item: []const u8,
    rest: []const u8,
};
/// `Player.getCurrentItemAttackStrengthDelay` for an ATTACK_SPEED value.
pub fn delay(attack_speed: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (1.0 / attack_speed * 20.0) as f32
}
    // rust: impl AttackStrength {
    /// The attack-strength part of `Player.tick`: both tickers advance, and a
    /// main-hand change to a different item resets them
    /// (`!ItemStack.matches` and `!ItemStack.isSameItem`).
    /// Whether they were reset.
pub fn tick(self: *Self, main_hand: ?HeldStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.ticker += 1;
    // rust: self.swap_ticker += 1;
    // rust: let mut reset = false;
    // rust: if self.last_item != main_hand {
    // rust: let same_item = match (&self.last_item, &main_hand) {
    // rust: (Some(a), Some(b)) => a.item == b.item,
    // rust: (None, None) => true,
    // rust: _ => false,
}
    // rust: if !same_item {
    // rust: self.reset();
    // rust: reset = true;
}
    // rust: self.last_item = main_hand;
}
    // rust: reset
}
    /// `resetAttackStrengthTicker`: swinging at nothing, attacking or
    /// stopping a block break.
pub fn reset(self: *Self) void {
}
    // rust: self.ticker = 0;
    // rust: self.swap_ticker = 0;
}
    /// `resetOnlyAttackStrengthTicker` (`Player.onAttack`).
pub fn reset_attack(self: *Self) void {
}
    // rust: self.ticker = 0;
}
    /// `getAttackStrengthScale(a)` with the ATTACK_SPEED attribute value.
pub fn scale(self: *Self, a: f32, attack_speed: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((self.ticker as f32 + a) / delay(attack_speed)).clamp(0.0, 1.0)
}
    /// `getItemSwapScale(a)`.
pub fn swap_scale(self: *Self, a: f32, attack_speed: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((self.swap_ticker as f32 + a) / delay(attack_speed)).clamp(0.0, 1.0)
}
}

/// `Player.attack`'s extra knockback: `getKnockback` (`weapon`, halved: the
/// ATTACK_KNOCKBACK value, plus on a server the weapon's knockback enchantment)
/// and a sprinting full-strength hit (0.5), and whether the hit is that
/// sprinting knockback attack.
pub fn extra_knockback(weapon: f32, strength: f32, sprinting: bool) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let knockback_attack = strength > 0.9 && sprinting;
    // rust: let bonus = if knockback_attack { 0.5 } else { 0.0 };
    // rust: (weapon / 2.0 + bonus, knockback_attack)
}

/// `causeExtraKnockback`'s cut of the attacker's horizontal speed.
pub const ATTACKER_SLOWDOWN: f64 = 0.6;

/// What the attacking client's own `Player.attack` does to itself on a hit
/// at another player, whose `RemotePlayer.hurtClient` lets the hit through:
/// whether `causeExtraKnockback` cuts its horizontal speed and stops its
/// sprint. This runs on the client's player, not the server's: held items and
/// effects only change attributes on a server and neither of these two is
/// synced, so `attack_damage` and `knockback` are the client's own ATTACK_DAMAGE
/// (or a riptide spin's damage) and ATTACK_KNOCKBACK, whatever the weapon or
/// Weakness. Enchantments don't count either: only `ServerPlayer` overrides
/// `getEnchantedDamage`, and `getKnockback` asks for a `ServerLevel`.
/// `strength` is `getAttackStrengthScale(0.5)`.
    // rust: pub fn attacker_slows_after_hit(
    // rust: attack_damage: f32,
    // rust: knockback: f32,
    // rust: strength: f32,
    // rust: sprinting: bool,
    // rust: ) -> bool {
    // rust: let base = attack_damage * (0.2 + strength * strength * 0.8);
    // rust: let (knockback, _) = extra_knockback(knockback, strength, sprinting);
    // Player.attack stops before the hurt and the knockback when no damage is
    // left (`magicBoost` is 0 here).
    // rust: base > 0.0 && knockback > 0.0
}

    // rust: mod tests {
//     use super::*;
pub fn held(item: []const u8, rest: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(HeldStack {
    // rust: item: item.into(),
    // rust: rest: rest.into(),
    // rust: })
}
pub fn charges_over_the_attack_delay() void {
}
    // rust: let mut s = AttackStrength::default();
        // A sword's 1.6 attacks per second: 12.5 ticks to full strength.
    // rust: assert_eq!(delay(1.6), 12.5);
    // rust: for _ in 0..6 {
    // rust: s.tick(None);
}
    // rust: assert_eq!(s.scale(0.25, 1.6), 6.25 / 12.5);
    // rust: for _ in 0..10 {
    // rust: s.tick(None);
}
    // rust: assert_eq!(s.scale(0.0, 1.6), 1.0);
}
pub fn switching_items_resets_but_restacking_does_not() void {
}
    // rust: let mut s = AttackStrength::default();
    // rust: s.tick(held("minecraft:stone", "64"));
    // rust: assert_eq!(s.ticker, 0, "picking up an item resets");
    // rust: s.tick(held("minecraft:stone", "63"));
    // rust: assert_eq!(
    // rust: s.ticker, 1,
    // rust: "the same item with another count keeps charging"
    // rust: );
    // rust: s.tick(held("minecraft:diamond_sword", ""));
    // rust: assert_eq!((s.ticker, s.swap_ticker), (0, 0));
    // rust: s.tick(held("minecraft:diamond_sword", ""));
    // rust: s.reset_attack();
    // rust: assert_eq!((s.ticker, s.swap_ticker), (0, 1));
}
    /// A client's own ATTACK_DAMAGE: Player's base value, as no item or effect
    /// changes it there.
pub const CLIENT_DAMAGE: f32 = 1.0;
pub fn a_charged_sprint_hit_slows_the_attacker() void {
}
    // rust: assert!(attacker_slows_after_hit(CLIENT_DAMAGE, 0.0, 1.0, true));
    // rust: assert_eq!(extra_knockback(0.0, 1.0, true), (0.5, true));
}
pub fn an_uncharged_sprint_hit_does_not() void {
}
    // rust: assert!(!attacker_slows_after_hit(CLIENT_DAMAGE, 0.0, 0.5, true));
    // rust: assert!(
    // rust: !attacker_slows_after_hit(CLIENT_DAMAGE, 0.0, 0.9, true),
    // rust: "the bonus needs more than 0.9"
    // rust: );
}
pub fn a_hit_without_sprinting_or_knockback_does_not() void {
}
    // rust: assert!(!attacker_slows_after_hit(CLIENT_DAMAGE, 0.0, 1.0, false));
}
pub fn a_synced_knockback_attribute_slows_even_uncharged() void {
}
    // rust: assert!(attacker_slows_after_hit(CLIENT_DAMAGE, 1.0, 0.2, false));
}
pub fn a_hit_that_does_no_damage_stops_first() void {
}
        // Only a server that sends ATTACK_DAMAGE can leave a client without any.
    // rust: assert!(!attacker_slows_after_hit(0.0, 0.0, 1.0, true));
    // rust: assert!(!attacker_slows_after_hit(0.0, 1.0, 1.0, true));
}
pub fn a_server_attack_speed_charges_at_once() void {
}
        // 1.8-style servers raise ATTACK_SPEED: with 1024 the delay is under
        // a tick, so getAttackStrengthScale(0.5) is full right after a hit.
    // rust: let mut s = AttackStrength::default();
    // rust: s.reset_attack();
    // rust: assert_eq!(s.scale(0.5, 1024.0), 1.0);
    // rust: assert!(attacker_slows_after_hit(
    // rust: CLIENT_DAMAGE,
    // rust: 0.0,
    // rust: s.scale(0.5, 1024.0),
    // rust: true
    // rust: ));
        // A sword's own 1.6 leaves it uncharged.
    // rust: assert!(!attacker_slows_after_hit(
    // rust: CLIENT_DAMAGE,
    // rust: 0.0,
    // rust: s.scale(0.5, 1.6),
    // rust: true
    // rust: ));
}
}
