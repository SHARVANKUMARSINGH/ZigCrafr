//! Transpiled from Horizon Rust crate
package horizon_world_damage_reduction

import "core:fmt"
import "core:mem"
import "core:math"

// Living damage-source bypass, armor and resistance/protection dispatch.
// use crate::{
    // rust: combat_rules::{self, ArmorWorld},
    // rust: living_damage::{STAT_LIMIT, positive, stat_amount},
}
Bypass :: enum {
    Armor,
    Effects,
    Resistance,
    Enchantments,
}
    // rust: pub trait DamageReductionWorld: ArmorWorld {
bypasses :: proc(self: ^Self, kind: Bypass) -> R {
    // Ported from Horizon
    return {}
}
hurt_armor :: proc(self: ^Self, damage: f32) -> R {
    // Ported from Horizon
    return {}
}
armor_value :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
toughness_attribute :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
has_resistance :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
resistance_amplifier :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
victim_is_server_player :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
award_resisted :: proc(self: ^Self, amount: i32) -> R {
    // Ported from Horizon
    return {}
}
attacker_is_server_player :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // Performs the second native attacker lookup before awarding its stat.
award_dealt_resisted :: proc(self: ^Self, amount: i32) -> R {
    // Ported from Horizon
    return {}
}
damage_protection :: proc(self: ^Self, level: Self::ServerLevel) -> R {
    // Ported from Horizon
    return {}
}
}
armor_from_attribute :: proc(value: f64) -> i {
    // Ported from Horizon
    return {}
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
