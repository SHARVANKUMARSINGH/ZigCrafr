//! Transpiled from Horizon Rust crate
package horizon_client_llama

import "core:fmt"
import "core:mem"
import "core:math"

// Llamas and trader llamas (`Llama`, `TraderLlama`): coat variants and
// strength, chests and carpets, taming by riding (maximum temper 30), the
// spit ranged attack, hunting wolves (and, for traders, zombies and
// illagers) and `LlamaModel`.
// use super::finalize::{Attr, set_base};
// use super::{
    // rust: Mob, MobEvent, MobWorld, Seen, Species, Who, equine,
    // rust: goals::{
    // rust: Breed, Cx, Float, FollowParent, Goal, HurtByTarget, LookAtPlayer, NearestTarget, Panic,
    // rust: Prey, RandomLookAround, Stroll, Tempt, goal_clone,
    // rust: },
    // rust: witch::RangedAttack,
}
// use crate::projectiles::{Projectile, ProjectileKind};
// use horizon_core::{geometry::Vec3, random::RandomSource};

VARIANTS :: ["creamy", "white", "brown", "gray"]
// `Llama.getMaxTemper`.
MAX_TEMPER :: 30

// Llama state: `variant` the coat, `variant2` the strength (1 to 5),
// `variant3` the temper, `chested` the chest, `head` the carpet, `flag2`
// `didSpit`, `ints[0]` a trader llama's despawn delay.
is_llama :: proc(s: Species) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(s, Species::Llama | Species::TraderLlama)
}
is_trader :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.species() == Species::TraderLlama
}
// `Llama.getStrength`: the stored strength (0 for a llama that was never
// given one; `setStrength` keeps it within 1 to 5).
strength :: proc(m: ^Mob) -> i {
    // Ported from Horizon
    return {}
}
    // rust: i32::from(m.extra.variant2)
}
// `getInventoryColumns`: a chest holds three rows of `strength` columns.
inventory_columns :: proc(m: ^Mob) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if m.extra.chested { strength(m) } else { 0 }
}
// The mob is a zombie of any kind (`Zombie.class`).
is_zombie :: proc(s: ^Seen) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: s.species,
    // rust: Species::Zombie | Species::Husk | Species::Drowned | Species::ZombieVillager
    // rust: )
}
// The mob is an illager (`AbstractIllager.class`).
is_illager :: proc(s: ^Seen) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: s.species,
    // rust: Species::Pillager | Species::Vindicator | Species::Evoker | Species::Illusioner
    // rust: )
}
register :: proc(m: ^Mob) {
}
    // rust: m.set_required_path_length(40.0);
    // rust: let tempt = m.kind.tempt.clone();
    // rust: let trader = is_trader(m);
    // rust: if trader {
    // rust: m.extra.ints[0] = DEFAULT_DESPAWN_DELAY;
}
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(0, Float);
    // rust: if trader {
    // rust: g.add(1, Panic::new(2.0));
}
    // rust: g.add(1, equine::RunAroundLikeCrazy);
    // rust: g.add(2, super::caravan::FollowCaravan::new(f64::from(2.1_f32)));
    // rust: g.add(3, RangedAttack::new(1.25, 40, 40, 20.0, spit));
    // rust: g.add(3, Panic::new(1.2));
    // rust: g.add(4, Breed::new(1.0));
    // rust: g.add(5, Tempt::new(1.25, tempt, false));
    // rust: g.add(6, FollowParent::new(1.0));
    // rust: g.add(7, Stroll::avoiding_water(0.7));
    // rust: g.add(8, LookAtPlayer::new(6.0));
    // rust: g.add(9, RandomLookAround::default());
    // rust: m.ai.targets.add(1, LlamaHurtBy(HurtByTarget::new()));
    // rust: if trader {
    // rust: m.ai.targets.add(1, super::caravan::DefendTrader::default());
}
    // rust: m.ai.targets.add(
    // rust: 2,
    // rust: NearestTarget::new(
    // rust: Prey::Filter(|s| s.species == Species::Wolf && !s.tame),
    // rust: false,
    // rust: )
    // rust: .interval(16)
    // rust: .reach()
    // rust: .follow_scale(0.25),
    // rust: );
    // rust: if trader {
    // rust: m.ai.targets
    // rust: .add(2, NearestTarget::new(Prey::Filter(is_zombie), true));
    // rust: m.ai.targets
    // rust: .add(2, NearestTarget::new(Prey::Filter(is_illager), true));
}
}
// `TraderLlama.DEFAULT_DESPAWN_DELAY`.
DEFAULT_DESPAWN_DELAY :: 47999
// `Llama.finalizeSpawn` and `AbstractChestedHorse.randomizeAttributes`:
// health 15 to 30, a coat and the strength.
finalize :: proc(m: ^Mob) {
}
    // rust: let r = &mut m.random;
    // rust: let health =
    // rust: 15.0 + r.next_int_bound(8).unwrap_or(0) as f32 + r.next_int_bound(9).unwrap_or(0) as f32;
    // rust: let max = if r.next_float() < 0.04 { 5 } else { 3 };
    // rust: let strength = 1 + r.next_int_bound(max).unwrap_or(0);
    // rust: let variant = r.next_int_bound(4).unwrap_or(0);
    // rust: set_base(m, Attr::MaxHealth, f64::from(health));
    // rust: m.health = health;
    // rust: m.extra.variant2 = strength as u8;
    // rust: m.extra.variant = variant as u8;
    // rust: m.extra.vector[0] = m.kind.jump_strength;
}
// `Llama.getBreedOffspring` after `setOffspringAttributes`: the strength
// (rarely one more) and either parent's coat.
offspring :: proc(child: ^Mob, a: ^Mob, b: ^Mob, r: ^impl RandomSource) {
}
    // rust: let top = strength(a).max(strength(b));
    // rust: let mut s = r.next_int_bound(top).unwrap_or(0) + 1;
    // rust: if r.next_float() < 0.03 {
    // rust: s += 1;
}
    // rust: child.extra.variant2 = s.clamp(1, 5) as u8;
    // rust: child.extra.variant = if r.next_boolean() {
    // rust: a.extra.variant
    // rust: } else {
    // rust: b.extra.variant
}
    // rust: if is_trader(child) {
    // rust: child.persistent = true;
}
}
// A llama's baby as `Llama.getBreedOffspring` makes it.
Offspring :: struct {
    max_health: f32,
    jump: f64,
    speed: f64,
    strength: u8,
    variant: u8,
}
// `Llama.getBreedOffspring` with `AbstractHorse.setOffspringAttributes`,
// drawn from the parent's random with the partner's stock.
breed_offspring :: proc(m: ^Mob, partner: ^Seen) -> O {
    // Ported from Horizon
    return {}
}
    // Seen.profession is the partner's strength.
    // rust: let top = strength(m).max(i32::from(partner.profession));
    // rust: let (health, jump, speed, own) = (
    // rust: f64::from(m.attrs.max_health),
    // rust: m.extra.vector[0],
    // rust: m.attrs.speed,
    // rust: m.extra.variant,
    // rust: );
    // rust: let r = &mut m.random;
    // rust: let max_health = equine::offspring(health, partner.stats[0], 15.0, 30.0, r) as f32;
    // rust: let jump = equine::offspring(jump, partner.stats[1], 0.4, 1.0, r);
    // rust: let speed = equine::offspring(speed, partner.stats[2], 0.1125, 0.3375, r);
    // rust: let mut s = r.next_int_bound(top).unwrap_or(0) + 1;
    // rust: if r.next_float() < 0.03 {
    // rust: s += 1;
}
    // rust: let variant = if r.next_boolean() {
    // rust: own
    // rust: } else {
    // rust: partner.variant
}
    // rust: Offspring {
    // rust: max_health,
    // rust: jump,
    // rust: speed,
    // rust: strength: s.clamp(1, 5) as u8,
    // rust: variant,
}
}
// The game makes the baby drawn by `breed_offspring`.
apply_offspring :: proc(child: ^Mob, o: ^Offspring) {
}
    // rust: set_base(child, Attr::MaxHealth, f64::from(o.max_health));
    // rust: child.health = o.max_health;
    // rust: child.extra.vector[0] = o.jump;
    // rust: set_base(child, Attr::MovementSpeed, o.speed);
    // rust: child.extra.variant2 = o.strength;
    // rust: child.extra.variant = o.variant;
    // rust: if is_trader(child) {
    // rust: child.persistent = true;
}
}
// `LlamaHurtByTargetGoal`: stops hunting right after a spit.
LlamaHurtBy :: struct {
    // rust: impl Goal for LlamaHurtBy {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.0.flags()
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.can_use(m, cx)
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if m.extra.flag2 {
    // rust: m.extra.flag2 = false;
    // rust: return false;
}
    // rust: self.0.can_continue(m, cx)
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.start(m, cx)
}
stop :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.stop(m, cx)
}
}
// `Llama.performRangedAttack` / `spit`: a llama spit toward the target's
// lower third, 1.5 fast, with 10 degrees of spread.
spit :: proc(m: ^Mob, who: Who, _power: f32, cx: ^Cx) {
}
    // rust: let Some(t) = cx.w.target_info(who) else {
    // rust: return;
}
    // rust: let body = m.body_yaw.to_radians();
    // rust: let reach = (f64::from(m.width()) + 1.0) * 0.5;
    // rust: let start = Vec3::new(
    // rust: m.position.x - reach * f64::from(body.sin()),
    // rust: m.eye_y() - f64::from(0.1_f32),
    // rust: m.position.z + reach * f64::from(body.cos()),
    // rust: );
    // rust: let top = t.bounds.max_position();
    // rust: let low = t.bounds.min_position();
    // rust: let xd = t.position.x - m.position.x;
    // rust: let yd = low.y + (top.y - low.y) * 0.333_333_333_333_333_3 - start.y;
    // rust: let zd = t.position.z - m.position.z;
    // rust: let yo = (xd * xd + zd * zd).sqrt() * f64::from(0.2_f32);
    // rust: let mut p = Projectile::new(ProjectileKind::LlamaSpit, start, Some(Who::Mob(m.id)));
    // rust: p.shoot(
    // rust: &mut crate::projectiles::own_random(m),
    // rust: [xd, yd + yo, zd],
    // rust: 1.5,
    // rust: 10.0,
    // rust: );
    // rust: cx.events.push(MobEvent::Projectile(p));
    // rust: let pitch = 1.0 + (m.random.next_float() - m.random.next_float()) * 0.2;
    // rust: cx.events.push(MobEvent::Sound(
    // rust: "entity.llama.spit",
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: 1.0,
    // rust: pitch,
    // rust: ));
    // rust: m.extra.flag2 = true;
}
// `AbstractHorse.aiStep` for llamas, which never graze: the slow healing.
ai_step :: proc(m: ^Mob, w: ^MobWorld) {
}
    // rust: if m.alive() && m.random.next_int_bound(900).unwrap_or(1) == 0 && m.death_time == 0 {
    // rust: m.heal(1.0);
}
    // rust: if is_trader(m) {
    // rust: super::caravan::trader_llama_tick(m, w);
}
}
// The llama's own save fields, over the horse ones: `Variant` (the coat id),
// `Strength` and a trader llama's `DespawnDelay`.
to_nbt :: proc(m: ^Mob, map: ^horizon_world::nbt::Compound) {
}
//     use horizon_world::nbt::Tag;
    // rust: map.insert("Variant".into(), Tag::Int(i32::from(m.extra.variant)));
    // rust: map.insert("Strength".into(), Tag::Int(strength(m)));
    // rust: if is_trader(m) {
    // rust: map.insert("DespawnDelay".into(), Tag::Int(m.extra.ints[0]));
}
}
from_nbt :: proc(m: ^Mob, tag: ^horizon_world::nbt::Tag) {
}
//     use crate::save::number;
    // rust: m.extra.variant = number(tag.get("Variant")).unwrap_or(0).clamp(0, 3) as u8;
    // rust: m.extra.variant2 = number(tag.get("Strength")).unwrap_or(1).clamp(1, 5) as u8;
    // rust: m.extra.variant3 = i32::from(m.extra.variant3).min(MAX_TEMPER) as u8;
    // rust: if is_trader(m) {
    // rust: m.extra.ints[0] =
    // rust: number(tag.get("DespawnDelay")).map_or(DEFAULT_DESPAWN_DELAY, |v| v as i32);
}
}
// The coat texture (`LlamaRenderer`).
texture :: proc(m: ^Mob) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let baby = if m.is_baby() { "_baby" } else { "" };
    // rust: let coat = VARIANTS[(m.extra.variant as usize).min(3)];
    // rust: format!("entity/llama/llama_{coat}{baby}")
}
// The carpet colour on the llama, if it wears one.
    // rust: pub(super) fn carpet(m: &Mob) -> Option<&str> {
    // rust: m.extra
    // rust: .body
    // rust: .as_deref()
    // rust: .and_then(|i| i.strip_prefix("minecraft:"))
    // rust: .and_then(|i| i.strip_suffix("_carpet"))
}
// `LlamaDecorLayer`: the carpet of an adult, else the trader's blanket.
decor :: proc(m: ^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let baby = m.is_baby();
    // rust: let model = if baby {
    // rust: "llama_baby#decor"
    // rust: } else {
    // rust: "llama#decor"
}
    // rust: if let Some(color) = carpet(m)
    // rust: && !baby
    // rust: {
    // rust: return Some((model.into(), format!("entity/equipment/llama_body/{color}")));
}
    // rust: is_trader(m).then(|| {
    // rust: let name = if baby {
    // rust: "trader_llama_baby"
    // rust: } else {
    // rust: "trader_llama"
}
    // rust: (model.into(), format!("entity/equipment/llama_body/{name}"))
    // rust: })
}
    // rust: mod tests {
//     use super::*;
//     use horizon_core::random::LegacyRandom;

strength_stays_in_range_and_rarely_reaches_five :: proc() {
}
    // rust: let mut r = LegacyRandom::new(7);
    // rust: let mut fives = 0;
    // rust: for _ in 0..4000 {
    // rust: let max = if r.next_float() < 0.04 { 5 } else { 3 };
    // rust: let s = 1 + r.next_int_bound(max).unwrap();
    // rust: assert!((1..=5).contains(&s));
    // rust: fives += i32::from(s > 3);
}
    // rust: assert!(fives > 0 && fives < 200);
}
a_chest_holds_strength_columns :: proc() {
}
    // rust: assert_eq!(DEFAULT_DESPAWN_DELAY, 47999);
    // rust: assert_eq!(MAX_TEMPER, 30);
}
}
