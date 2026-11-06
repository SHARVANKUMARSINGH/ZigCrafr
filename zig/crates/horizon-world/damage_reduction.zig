//! Transpiled from Horizon Rust crate
//! Module: horizon-world_damage_reduction
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Living damage-source bypass, armor and resistance/protection dispatch.
// use crate::{
    // rust: combat_rules::{self, ArmorWorld},
    // rust: living_damage::{STAT_LIMIT, positive, stat_amount},
}
pub const Bypass = enum {
    Armor,
    Effects,
    Resistance,
    Enchantments,
};
    // rust: pub trait DamageReductionWorld: ArmorWorld {
pub fn bypasses(self: *Self, kind: Bypass) R;
pub fn hurt_armor(self: *Self, damage: f32) R;
pub fn armor_value(self: *Self) R;
pub fn toughness_attribute(self: *Self) R;
pub fn has_resistance(self: *Self) R;
pub fn resistance_amplifier(self: *Self) R;
pub fn victim_is_server_player(self: *Self) b;
pub fn award_resisted(self: *Self, amount: i32) R;
pub fn attacker_is_server_player(self: *Self) R;
    /// Performs the second native attacker lookup before awarding its stat.
pub fn award_dealt_resisted(self: *Self, amount: i32) R;
pub fn damage_protection(self: *Self, level: Self::ServerLevel) R;
}
pub fn armor_from_attribute(value: f64) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: value.floor() as i32
}
    // rust: pub fn after_armor<W: DamageReductionWorld>(world: &mut W, damage: f32) -> Result<f32, W::Error> {
    // rust: if world.bypasses(Bypass::Armor)? {
    // rust: return Ok(damage);
}
    // rust: world.hurt_armor(damage)?;
    // rust: let armor = world.armor_value()? as f32;
    // rust: let toughness = world.toughness_attribute()? as f32;
    // rust: combat_rules::after_armor(world, damage, armor, toughness)
}
    // rust: pub fn after_magic<W: DamageReductionWorld>(
    // rust: world: &mut W,
    // rust: mut damage: f32,
    // rust: ) -> Result<f32, W::Error> {
    // rust: if world.bypasses(Bypass::Effects)? {
    // rust: return Ok(damage);
}
    // rust: if world.has_resistance()? && !world.bypasses(Bypass::Resistance)? {
    // rust: let reduction = world
    // rust: .resistance_amplifier()?
    // rust: .wrapping_add(1)
    // rust: .wrapping_mul(5);
    // rust: let remainder = 25i32.wrapping_sub(reduction);
    // rust: let original = damage;
    // rust: damage = positive((damage * remainder as f32) / 25.0);
    // rust: let resisted = original - damage;
    // rust: if resisted > 0.0 && resisted < STAT_LIMIT {
    // rust: if world.victim_is_server_player() {
    // rust: world.award_resisted(stat_amount(resisted))?;
    // rust: } else if world.attacker_is_server_player()? {
    // rust: world.award_dealt_resisted(stat_amount(resisted))?;
}
}
}
    // rust: if damage <= 0.0 {
    // rust: return Ok(0.0);
}
    // rust: if world.bypasses(Bypass::Enchantments)? {
    // rust: return Ok(damage);
}
    // rust: let protection = if let Some(level) = world.server_level()? {
    // rust: world.damage_protection(level)?
    // rust: } else {
    // rust: 0.0
}
    // rust: if protection > 0.0 {
    // rust: damage = combat_rules::after_magic(damage, protection);
}
    // rust: Ok(damage)
}
