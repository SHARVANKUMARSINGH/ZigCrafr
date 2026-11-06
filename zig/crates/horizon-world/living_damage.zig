//! Transpiled from Horizon Rust crate
//! Module: horizon-world_living_damage
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Inner living/player damage application after the outer hurt gates.
pub const DamageStat = enum {
    Absorbed,
    DealtAbsorbed,
    Taken,
};
    // rust: pub trait DamageWorld {
    // rust: type Error;
    // rust: type Attacker: Copy;
pub fn invulnerable(self: *Self) R;
pub fn after_armor(self: *Self, damage: f32) R;
pub fn after_magic(self: *Self, damage: f32) R;
pub fn absorption(self: *Self) R;
pub fn set_absorption(self: *Self, value: f32) R;
pub fn server_player_attacker(self: *Self) R;
    // rust: fn award_attacker(
    // rust: &mut self,
    // rust: attacker: Self::Attacker,
    // rust: stat: DamageStat,
    // rust: amount: i32,
    // rust: ) -> Result<(), Self::Error>;
pub fn award_self(self: *Self, stat: DamageStat, amount: i32) R;
pub fn source_food_exhaustion(self: *Self) R;
pub fn cause_food_exhaustion(self: *Self, amount: f32) R;
pub fn record_damage(self: *Self, amount: f32) R;
pub fn health(self: *Self) R;
pub fn set_health(self: *Self, value: f32) R;
pub fn damage_event(self: *Self) R;
}
    // rust: pub(crate) fn positive(value: f32) -> f32 {
    // rust: if value.is_nan() {
    // rust: value
    // rust: } else if value <= 0.0 {
    // rust: 0.0
    // rust: } else {
    // rust: value
}
}
    // rust: pub(crate) fn stat_amount(value: f32) -> i32 {
    // rust: let value = value * 10.0;
    // Java Math.round(float), including negative ties and integer saturation.
    // rust: let bits = value.to_bits() as i32;
    // rust: let shift = 149 - ((bits >> 23) & 0xff);
    // rust: if (0..32).contains(&shift) {
    // rust: let mut significand = (bits & 0x7f_ffff) | 0x80_0000;
    // rust: if bits < 0 {
    // rust: significand = -significand;
}
    // rust: ((significand >> shift) + 1) >> 1
    // rust: } else {
    // rust: value as i32
}
}
    // rust: pub(crate) const STAT_LIMIT: f32 = 3.402_823_5e37;
    // rust: pub fn actually_hurt<W: DamageWorld>(
    // rust: world: &mut W,
    // rust: damage: f32,
    // rust: player: bool,
    // rust: ) -> Result<(), W::Error> {
    // rust: if world.invulnerable()? {
    // rust: return Ok(());
}
    // rust: actually_hurt_after_immunity_check(world, damage, player)
}
/// Caller must have performed this hit's native invulnerability query.
    // rust: pub(crate) fn actually_hurt_after_immunity_check<W: DamageWorld>(
    // rust: world: &mut W,
    // rust: damage: f32,
    // rust: player: bool,
    // rust: ) -> Result<(), W::Error> {
    // rust: let damage = world.after_armor(damage)?;
    // rust: let damage = world.after_magic(damage)?;
    // rust: let remaining = positive(damage - world.absorption()?);
    // rust: let absorption = world.absorption()? - (damage - remaining);
    // rust: world.set_absorption(absorption)?;
    // rust: let absorbed = damage - remaining;
    // rust: if absorbed > 0.0 && absorbed < STAT_LIMIT {
    // rust: if player {
    // rust: world.award_self(DamageStat::Absorbed, stat_amount(absorbed))?;
    // rust: } else if let Some(attacker) = world.server_player_attacker()? {
    // rust: world.award_attacker(attacker, DamageStat::DealtAbsorbed, stat_amount(absorbed))?;
}
}
    // rust: if remaining == 0.0 {
    // rust: return Ok(());
}
    // rust: if player {
    // rust: let exhaustion = world.source_food_exhaustion()?;
    // rust: world.cause_food_exhaustion(exhaustion)?;
}
    // rust: world.record_damage(remaining)?;
    // rust: let health = world.health()?;
    // rust: world.set_health(health - remaining)?;
    // rust: if player {
    // rust: if remaining < STAT_LIMIT {
    // rust: world.award_self(DamageStat::Taken, stat_amount(remaining))?;
}
    // rust: } else {
    // rust: let absorption = world.absorption()?;
    // rust: world.set_absorption(absorption - remaining)?;
}
    // rust: world.damage_event()
}
