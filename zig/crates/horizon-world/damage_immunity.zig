//! Transpiled from Horizon Rust crate
//! Module: horizon-world_damage_immunity
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Entity, living and player damage-immunity predicate ordering.
pub const ImmunityTag = enum {
    BypassesInvulnerability,
    Fire,
    Fall,
    Drowning,
    Freezing,
};
pub const DamageRule = enum {
    Drowning,
    Fall,
    Fire,
    Freeze,
};
    // rust: pub trait ImmunityWorld {
    // rust: type Error;
pub fn removed(self: *Self) b;
pub fn permanently_invulnerable(self: *Self) R;
pub fn temporarily_invulnerable(self: *Self) R;
pub fn invulnerable(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: entity_invulnerable(self)
}
pub fn tag(self: *Self, tag: ImmunityTag) R;
pub fn creative_source(self: *Self) R;
pub fn fire_immune(self: *Self) R;
pub fn fall_immune(self: *Self) R;
pub fn enchantment_immunity(self: *Self) R;
pub fn damage_rule(self: *Self, rule: DamageRule) R;
pub fn changing_dimension(self: *Self) R;
pub fn ender_pearl(self: *Self) R;
pub fn client_loaded(self: *Self) R;
}
    // rust: pub fn entity_invulnerable<W: ImmunityWorld + ?Sized>(w: &mut W) -> Result<bool, W::Error> {
    // rust: Ok(w.permanently_invulnerable()? || w.temporarily_invulnerable()?)
}
    // rust: pub fn base_immunity<W: ImmunityWorld + ?Sized>(w: &mut W) -> Result<bool, W::Error> {
    // rust: if w.removed() {
    // rust: return Ok(true);
}
    // rust: if w.invulnerable()? && !w.tag(ImmunityTag::BypassesInvulnerability)? && !w.creative_source()? {
    // rust: return Ok(true);
}
    // rust: if w.tag(ImmunityTag::Fire)? && w.fire_immune()? {
    // rust: return Ok(true);
}
    // rust: Ok(w.tag(ImmunityTag::Fall)? && w.fall_immune()?)
}
    // rust: pub fn living_immunity<W: ImmunityWorld + ?Sized>(w: &mut W) -> Result<bool, W::Error> {
    // rust: Ok(base_immunity(w)? || w.enchantment_immunity()?)
}
    // rust: pub fn player_immunity<W: ImmunityWorld + ?Sized>(w: &mut W) -> Result<bool, W::Error> {
    // rust: if living_immunity(w)? {
    // rust: return Ok(true);
}
    // rust: for (tag, rule) in [
    // rust: (ImmunityTag::Drowning, DamageRule::Drowning),
    // rust: (ImmunityTag::Fall, DamageRule::Fall),
    // rust: (ImmunityTag::Fire, DamageRule::Fire),
    // rust: (ImmunityTag::Freezing, DamageRule::Freeze),
    // rust: ] {
    // rust: if w.tag(tag)? {
    // rust: return Ok(!w.damage_rule(rule)?);
}
}
    // rust: Ok(false)
}
    // rust: pub fn server_player_immunity<W: ImmunityWorld + ?Sized>(w: &mut W) -> Result<bool, W::Error> {
    // rust: Ok(player_immunity(w)?
    // rust: || (w.changing_dimension()? && !w.ender_pearl()?)
    // rust: || !w.client_loaded()?)
}
