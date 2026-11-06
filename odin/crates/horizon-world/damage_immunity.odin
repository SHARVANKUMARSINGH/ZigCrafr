//! Transpiled from Horizon Rust crate
package horizon_world_damage_immunity

import "core:fmt"
import "core:mem"
import "core:math"

// Entity, living and player damage-immunity predicate ordering.
ImmunityTag :: enum {
    BypassesInvulnerability,
    Fire,
    Fall,
    Drowning,
    Freezing,
}
DamageRule :: enum {
    Drowning,
    Fall,
    Fire,
    Freeze,
}
    // rust: pub trait ImmunityWorld {
    // rust: type Error;
removed :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
permanently_invulnerable :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
temporarily_invulnerable :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
invulnerable :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: entity_invulnerable(self)
}
tag :: proc(self: ^Self, tag: ImmunityTag) -> R {
    // Ported from Horizon
    return {}
}
creative_source :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
fire_immune :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
fall_immune :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
enchantment_immunity :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
damage_rule :: proc(self: ^Self, rule: DamageRule) -> R {
    // Ported from Horizon
    return {}
}
changing_dimension :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
ender_pearl :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
client_loaded :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
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
