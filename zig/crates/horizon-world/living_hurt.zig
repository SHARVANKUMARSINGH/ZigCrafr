//! Transpiled from Horizon Rust crate
//! Module: horizon-world_living_hurt
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Outer living damage dispatch, cooldown writes and post-hit service ordering.
// use crate::living_damage::{STAT_LIMIT, stat_amount};
pub const HurtTag = enum {
    Fire,
    Freezing,
    DamagesHelmet,
    BypassesCooldown,
    NoImpact,
    NoKnockback,
};
pub const HurtState = struct {
    no_action_time: i32,
    cooldown: i32,
    last_hurt: f32,
    hurt_duration: i32,
    hurt_time: i32,
    last_source: ?S,
    last_stamp: i64,
};
/// One invocation retains the same incoming source and server level. Services
/// receive live state so reentrant callbacks preserve native write ordering.
    // rust: pub trait HurtWorld {
    // rust: type Error;
    // rust: type Source: Copy;
    // rust: type UseItem: Copy;
    // rust: type Blocking: Copy;
    // rust: type Sound: Copy;
pub fn source(self: *Self) S;
pub fn is_server_player(self: *Self) b;
pub fn invulnerable(self: *Self, s: *mut HurtState<Self::Source>) R;
pub fn dead_or_dying(self: *Self, s: *mut HurtState<Self::Source>) R;
pub fn tag(self: *Self, s: *mut HurtState<Self::Source>, tag: HurtTag) R;
pub fn fire_resistance(self: *Self, s: *mut HurtState<Self::Source>) R;
    /// The hit once the guards above passed: it may change `damage`, and
    /// true refuses the hit. The default does nothing.
    // rust: fn hurt_start(
    // rust: &mut self,
    // rust: _s: &mut HurtState<Self::Source>,
    // rust: _damage: &mut f32,
    // rust: ) -> Result<bool, Self::Error> {
    // rust: Ok(false)
}
pub fn sleeping(self: *Self, s: *mut HurtState<Self::Source>) R;
pub fn stop_sleeping(self: *Self, s: *mut HurtState<Self::Source>) R;
pub fn use_item(self: *Self, s: *mut HurtState<Self::Source>) R;
    // rust: fn apply_blocking(
    // rust: &mut self,
    // rust: s: &mut HurtState<Self::Source>,
    // rust: damage: f32,
    // rust: ) -> Result<f32, Self::Error>;
pub fn freeze_hurts_extra(self: *Self, s: *mut HurtState<Self::Source>) R;
pub fn helmet_empty(self: *Self, s: *mut HurtState<Self::Source>) R;
    // rust: fn hurt_helmet(
    // rust: &mut self,
    // rust: s: &mut HurtState<Self::Source>,
    // rust: damage: f32,
    // rust: ) -> Result<(), Self::Error>;
    // rust: fn actually_hurt(
    // rust: &mut self,
    // rust: s: &mut HurtState<Self::Source>,
    // rust: damage: f32,
    // rust: ) -> Result<(), Self::Error>;
pub fn resolve_mob(self: *Self, s: *mut HurtState<Self::Source>) R;
pub fn resolve_player(self: *Self, s: *mut HurtState<Self::Source>) R;
pub fn blocking_component(self: *Self, item: Self::UseItem) O;
    // rust: fn on_blocked(
    // rust: &mut self,
    // rust: s: &mut HurtState<Self::Source>,
    // rust: block: Self::Blocking,
    // rust: ) -> Result<(), Self::Error>;
pub fn broadcast_damage(self: *Self, s: *mut HurtState<Self::Source>) R;
pub fn mark_hurt(self: *Self, s: *mut HurtState<Self::Source>) R;
    // rust: fn knockback(
    // rust: &mut self,
    // rust: s: &mut HurtState<Self::Source>,
    // rust: damage: f32,
    // rust: blocked: bool,
    // rust: ) -> Result<(), Self::Error>;
pub fn death_protection(self: *Self, s: *mut HurtState<Self::Source>) R;
pub fn death_sound(self: *Self, s: *mut HurtState<Self::Source>) R;
    // rust: fn make_sound(
    // rust: &mut self,
    // rust: s: &mut HurtState<Self::Source>,
    // rust: sound: Self::Sound,
    // rust: ) -> Result<(), Self::Error>;
pub fn secondary_sound(self: *Self, s: *mut HurtState<Self::Source>) R;
pub fn die(self: *Self, s: *mut HurtState<Self::Source>) R;
pub fn hurt_sound(self: *Self, s: *mut HurtState<Self::Source>) R;
pub fn game_time(self: *Self, s: *mut HurtState<Self::Source>) R;
    // rust: fn effects_on_hurt(
    // rust: &mut self,
    // rust: s: &mut HurtState<Self::Source>,
    // rust: damage: f32,
    // rust: ) -> Result<(), Self::Error>;
    // rust: fn player_hurt_criterion(
    // rust: &mut self,
    // rust: s: &mut HurtState<Self::Source>,
    // rust: original: f32,
    // rust: damage: f32,
    // rust: blocked: bool,
    // rust: ) -> Result<(), Self::Error>;
    // rust: fn award_blocked(
    // rust: &mut self,
    // rust: s: &mut HurtState<Self::Source>,
    // rust: amount: i32,
    // rust: ) -> Result<(), Self::Error>;
    /// Looks up the attacker, then dispatches its criterion if a server player.
    // rust: fn attacker_criterion(
    // rust: &mut self,
    // rust: s: &mut HurtState<Self::Source>,
    // rust: original: f32,
    // rust: damage: f32,
    // rust: blocked: bool,
    // rust: ) -> Result<(), Self::Error>;
}
    // rust: pub fn hurt_server<W: HurtWorld>(
    // rust: s: &mut HurtState<W::Source>,
    // rust: w: &mut W,
    // rust: mut damage: f32,
    // rust: ) -> Result<bool, W::Error> {
    // rust: if w.invulnerable(s)? || w.dead_or_dying(s)? {
    // rust: return Ok(false);
}
    // rust: if w.tag(s, HurtTag::Fire)? && w.fire_resistance(s)? {
    // rust: return Ok(false);
}
    // rust: if w.hurt_start(s, &mut damage)? {
    // rust: return Ok(false);
}
    // rust: if w.sleeping(s)? {
    // rust: w.stop_sleeping(s)?;
}
    // rust: s.no_action_time = 0;
    // rust: if damage < 0.0 {
    // rust: damage = 0.0;
}
    // rust: let original = damage;
    // rust: let item = w.use_item(s)?;
    // rust: let blocked_amount = w.apply_blocking(s, damage)?;
    // rust: damage -= blocked_amount;
    // rust: let blocked = blocked_amount > 0.0;
    // rust: if w.tag(s, HurtTag::Freezing)? && w.freeze_hurts_extra(s)? {
    // rust: damage *= 5.0;
}
    // rust: if w.tag(s, HurtTag::DamagesHelmet)? && !w.helmet_empty(s)? {
    // rust: w.hurt_helmet(s, damage)?;
    // rust: damage *= 0.75;
}
    // rust: if !damage.is_finite() {
    // rust: damage = f32::MAX;
}
    // rust: let fresh = if s.cooldown as f32 > 10.0 && !w.tag(s, HurtTag::BypassesCooldown)? {
    // rust: if damage <= s.last_hurt {
    // rust: return Ok(false);
}
    // rust: w.actually_hurt(s, damage - s.last_hurt)?;
    // rust: s.last_hurt = damage;
    // rust: false
    // rust: } else {
    // rust: s.last_hurt = damage;
    // rust: s.cooldown = 20;
    // rust: w.actually_hurt(s, damage)?;
    // rust: s.hurt_duration = 10;
    // rust: s.hurt_time = s.hurt_duration;
    // rust: true
}
    // rust: w.resolve_mob(s)?;
    // rust: w.resolve_player(s)?;
    // rust: if fresh {
    // rust: let component = w.blocking_component(item);
    // rust: if let Some(component) = component.filter(|_| blocked) {
    // rust: w.on_blocked(s, component)?;
    // rust: } else {
    // rust: w.broadcast_damage(s)?;
}
    // rust: if !w.tag(s, HurtTag::NoImpact)? && (!blocked || damage > 0.0) {
    // rust: w.mark_hurt(s)?;
}
    // rust: let fully_blocked = blocked && damage <= 0.0;
    // rust: if !w.tag(s, HurtTag::NoKnockback)? && !fully_blocked {
    // rust: w.knockback(s, damage, blocked)?;
}
}
    // rust: if w.dead_or_dying(s)? {
    // rust: if !w.death_protection(s)? {
    // rust: if fresh {
    // rust: let sound = w.death_sound(s)?;
    // rust: w.make_sound(s, sound)?;
    // rust: w.secondary_sound(s)?;
}
    // rust: w.die(s)?;
}
    // rust: } else if fresh {
    // rust: w.hurt_sound(s)?;
    // rust: w.secondary_sound(s)?;
}
    // rust: let accepted = !blocked || damage > 0.0;
    // rust: if accepted {
    // rust: s.last_source = Some(w.source());
    // rust: s.last_stamp = w.game_time(s)?;
    // rust: w.effects_on_hurt(s, damage)?;
}
    // rust: if w.is_server_player() {
    // rust: w.player_hurt_criterion(s, original, damage, blocked)?;
    // rust: if blocked_amount > 0.0 && blocked_amount < STAT_LIMIT {
    // rust: w.award_blocked(s, stat_amount(blocked_amount))?;
}
}
    // rust: w.attacker_criterion(s, original, damage, blocked)?;
    // rust: Ok(accepted)
}
