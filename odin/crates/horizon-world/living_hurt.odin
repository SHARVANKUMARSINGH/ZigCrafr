//! Transpiled from Horizon Rust crate
package horizon_world_living_hurt

import "core:fmt"
import "core:mem"
import "core:math"

// Outer living damage dispatch, cooldown writes and post-hit service ordering.
// use crate::living_damage::{STAT_LIMIT, stat_amount};
HurtTag :: enum {
    Fire,
    Freezing,
    DamagesHelmet,
    BypassesCooldown,
    NoImpact,
    NoKnockback,
}
HurtState :: struct {
    no_action_time: i32,
    cooldown: i32,
    last_hurt: f32,
    hurt_duration: i32,
    hurt_time: i32,
    last_source: Maybe(S),
    last_stamp: i64,
}
// One invocation retains the same incoming source and server level. Services
// receive live state so reentrant callbacks preserve native write ordering.
    // rust: pub trait HurtWorld {
    // rust: type Error;
    // rust: type Source: Copy;
    // rust: type UseItem: Copy;
    // rust: type Blocking: Copy;
    // rust: type Sound: Copy;
source :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
is_server_player :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
invulnerable :: proc(self: ^Self, s: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
dead_or_dying :: proc(self: ^Self, s: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
tag :: proc(self: ^Self, s: ^HurtState<Self::Source>, tag: HurtTag) -> R {
    // Ported from Horizon
    return {}
}
fire_resistance :: proc(self: ^Self, s: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
    // The hit once the guards above passed: it may change `damage`, and
    // true refuses the hit. The default does nothing.
    // rust: fn hurt_start(
    // rust: &mut self,
    // rust: _s: &mut HurtState<Self::Source>,
    // rust: _damage: &mut f32,
    // rust: ) -> Result<bool, Self::Error> {
    // rust: Ok(false)
}
sleeping :: proc(self: ^Self, s: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
stop_sleeping :: proc(self: ^Self, s: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
use_item :: proc(self: ^Self, s: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fn apply_blocking(
    // rust: &mut self,
    // rust: s: &mut HurtState<Self::Source>,
    // rust: damage: f32,
    // rust: ) -> Result<f32, Self::Error>;
freeze_hurts_extra :: proc(self: ^Self, s: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
helmet_empty :: proc(self: ^Self, s: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
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
resolve_mob :: proc(self: ^Self, s: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
resolve_player :: proc(self: ^Self, s: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
blocking_component :: proc(self: ^Self, item: Self::UseItem) -> O {
    // Ported from Horizon
    return {}
}
    // rust: fn on_blocked(
    // rust: &mut self,
    // rust: s: &mut HurtState<Self::Source>,
    // rust: block: Self::Blocking,
    // rust: ) -> Result<(), Self::Error>;
broadcast_damage :: proc(self: ^Self, s: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
mark_hurt :: proc(self: ^Self, s: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fn knockback(
    // rust: &mut self,
    // rust: s: &mut HurtState<Self::Source>,
    // rust: damage: f32,
    // rust: blocked: bool,
    // rust: ) -> Result<(), Self::Error>;
death_protection :: proc(self: ^Self, s: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
death_sound :: proc(self: ^Self, s: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fn make_sound(
    // rust: &mut self,
    // rust: s: &mut HurtState<Self::Source>,
    // rust: sound: Self::Sound,
    // rust: ) -> Result<(), Self::Error>;
secondary_sound :: proc(self: ^Self, s: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
die :: proc(self: ^Self, s: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
hurt_sound :: proc(self: ^Self, s: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
game_time :: proc(self: ^Self, s: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
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
    // Looks up the attacker, then dispatches its criterion if a server player.
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
