//! Transpiled from Horizon Rust crate
package horizon_client_illusioner

import "core:fmt"
import "core:mem"
import "core:math"

// The illusioner (`Illusioner`): a bow-wielding spellcaster that turns
// invisible behind four mirror images and blinds its target.
// use super::{
    // rust: Mob, MobEvent, Species, Who,
    // rust: goals::{
    // rust: Avoid, AvoidEntity, Cx, Float, Goal, HurtByTarget, LookAtPlayer, NearestTarget, Stroll,
    // rust: goal_clone, reduced,
    // rust: },
    // rust: illager::CastingSpell,
    // rust: undead::BowAttack,
}
// use horizon_core::random::RandomSource;

INVISIBILITY :: "minecraft:invisibility"
BLINDNESS :: "minecraft:blindness"
// `Illusioner.NUM_ILLUSIONS`.
COPIES :: 4

// `Illusioner.clientSideIllusionTicks` and the two offset sets.
Illusions :: struct {
    ticks: i32,
    offsets: [[[f64,
}

// `IllagerSpell` ids: DISAPPEAR (the mirror spell) 4, BLINDNESS 5.
MIRROR :: 4
BLINDNESS_SPELL :: 5

register :: proc(m: ^Mob) {
}
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(0, Float);
    // rust: g.add(1, CastingSpell);
    // rust: g.add(
    // rust: 3,
    // rust: AvoidEntity::new(Avoid::Species(vec![Species::Creaking]), 8.0, 1.0, 1.2),
    // rust: );
    // rust: g.add(4, Spell::new(MIRROR));
    // rust: g.add(5, Spell::new(BLINDNESS_SPELL));
    // rust: g.add(6, BowAttack::new(0.5, 20, 15.0));
    // rust: g.add(8, Stroll::new(0.6));
    // rust: g.add(9, LookAtPlayer::new(3.0).probability(1.0));
    // rust: g.add(10, LookAtPlayer::mobs(8.0));
    // rust: let mut hurt = HurtByTarget::new().alert();
    // rust: hurt.ignore = vec![
    // rust: Species::Pillager,
    // rust: Species::Vindicator,
    // rust: Species::Witch,
    // rust: Species::Evoker,
    // rust: Species::Illusioner,
    // rust: Species::Vex,
    // rust: Species::Ravager,
    // rust: ];
    // rust: m.ai.targets.add(1, hurt);
    // rust: m.ai.targets.add(2, NearestTarget::player(true));
    // rust: m.ai.targets.add(
    // rust: 3,
    // rust: NearestTarget::species(&[Species::Villager, Species::WanderingTrader], false),
    // rust: );
    // rust: m.ai.targets
    // rust: .add(3, NearestTarget::species(&[Species::IronGolem], false));
}

// `Illusioner.finalizeSpawn`: a bow in the main hand.
finalize :: proc(m: ^Mob) {
}
    // rust: m.extra.set_main_hand(Some("minecraft:bow".into()));
}

// `IllusionerMirrorSpellGoal` and `IllusionerBlindnessSpellGoal`.
Spell :: struct {
    spell: u8,
    warmup: i32,
    next: i64,
    last_target: Maybe(Who),
}
    // rust: impl Spell {
new :: proc(spell: u8) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: spell,
    // rust: warmup: 0,
    // rust: next: 0,
    // rust: last_target: None,
}
}
    // (casting time, interval, prepare sound).
timing :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: if self.spell == MIRROR {
    // rust: (20, 340, "entity.illusioner.prepare_mirror")
    // rust: } else {
    // rust: (20, 180, "entity.illusioner.prepare_blindness")
}
}
}
    // rust: impl Goal for Spell {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: 0
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !m.target_info(cx.w).is_some_and(|t| t.alive)
    // rust: || m.extra.counter > 0
    // rust: || i64::from(m.age) < self.next
    // rust: {
    // rust: return false;
}
    // rust: if self.spell == MIRROR {
    // rust: !m.has_effect(INVISIBILITY)
    // rust: } else {
    // rust: m.ai.target != self.last_target && cx.w.difficulty.effective > 2.0
}
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.target_info(cx.w).is_some_and(|t| t.alive) && self.warmup > 0
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let (casting, interval, sound) = self.timing();
    // rust: self.warmup = reduced(20);
    // rust: m.extra.counter = casting;
    // rust: self.next = i64::from(m.age) + interval;
    // rust: cx.events.push(MobEvent::Sound(sound, m.center(), 1.0, 1.0));
    // rust: m.extra.variant2 = self.spell;
    // rust: if self.spell == BLINDNESS_SPELL {
    // rust: self.last_target = m.ai.target;
}
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.warmup -= 1;
    // rust: if self.warmup != 0 {
    // rust: return;
}
    // rust: if self.spell == MIRROR {
    // rust: m.add_effect(INVISIBILITY, 1200, 0);
    // rust: } else {
            // `performSpellCasting` blinds the target whatever it is: a
            // villager or an iron golem as well as the player.
    // rust: match m.ai.target {
    // rust: Some(Who::Player) => cx.events.push(MobEvent::EffectPlayer {
    // rust: effect: BLINDNESS,
    // rust: ticks: 400,
    // rust: amplifier: 0,
    // rust: ambient: false,
    // rust: }),
    // rust: Some(Who::Mob(target)) => cx.events.push(MobEvent::EffectMob {
    // rust: target,
    // rust: effect: BLINDNESS,
    // rust: ticks: 400,
    // rust: amplifier: 0,
    // rust: }),
    // rust: None => {}
}
}
    // rust: cx.events.push(MobEvent::Sound(
    // rust: "entity.illusioner.cast_spell",
    // rust: m.center(),
    // rust: 1.0,
    // rust: 1.0,
    // rust: ));
}
}

// `Entity.isInvisible` of an illusioner on a client: the shared flag stands
// in for the effect the server holds, which draws the mirror images.
set_invisible :: proc(m: ^Mob, on: bool) {
}
    // rust: m.extra.effects.retain(|e| e.0 != INVISIBILITY);
    // rust: if on {
    // rust: m.extra.effects.push((INVISIBILITY, i32::MAX, 0));
}
}

// The client-side half of `Illusioner.aiStep`: new image offsets when
// hurt and once a minute, with a puff of cloud and a sound.
tick :: proc(m: ^Mob, events: ^[dynamic]MobEvent) {
}
    // rust: if !m.has_effect(INVISIBILITY) {
    // rust: return;
}
    // rust: if step(m) {
    // rust: events.push(MobEvent::Particles {
    // rust: kind: "minecraft:cloud",
    // rust: at: [m.position.x, m.position.y + 0.9, m.position.z],
    // rust: count: 16,
    // rust: });
    // rust: events.push(MobEvent::Sound(
    // rust: "entity.illusioner.mirror_move",
    // rust: m.center(),
    // rust: 1.0,
    // rust: 1.0,
    // rust: ));
}
}

// `Illusioner.aiStep` on a client of a server: invisible is the synched
// shared flag. The puff is drawn here exactly (sixteen `addParticle`s); the
// sound comes from the server.
client_tick :: proc(m: ^Mob, events: ^[dynamic]MobEvent) {
}
    // rust: if !m.invisible || !step(m) {
    // rust: return;
}
    // rust: let (w, h) = (f64::from(m.width()), f64::from(m.height()));
    // rust: for _ in 0..16 {
        // getRandomX(0.5), getRandomY() and getZ(0.5), which is not random.
    // rust: let x = m.position.x + w * (2.0 * m.random.next_double() - 1.0) * 0.5;
    // rust: let y = m.position.y + h * m.random.next_double();
    // rust: events.push(MobEvent::ParticleAt {
    // rust: kind: "cloud",
    // rust: at: [x, y, m.position.z + w * 0.5],
    // rust: velocity: [0.0; 3],
    // rust: });
}
}

// The image offsets' clock of an invisible illusioner. True when the images
// jumped to new offsets (hurt, or once a minute), which the puff goes with.
step :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let hurt = m.hurt_time;
    // rust: let age = m.age;
    // rust: let mut il = m.extra.illusions.take().unwrap_or_default();
    // rust: il.ticks = (il.ticks - 1).max(0);
    // rust: let jumped = hurt == 1 || age.is_multiple_of(1200);
    // rust: if jumped {
    // rust: il.ticks = 3;
    // rust: for i in 0..COPIES {
    // rust: il.offsets[0][i] = il.offsets[1][i];
    // rust: let r = &mut m.random;
    // rust: let x = (-6 + r.next_int_bound(13).unwrap_or(0)) as f64 * 0.5;
    // rust: let y = (r.next_int_bound(6).unwrap_or(0) - 4).max(0) as f64;
    // rust: let z = (-6 + r.next_int_bound(13).unwrap_or(0)) as f64 * 0.5;
    // rust: il.offsets[1][i] = [x, y, z];
}
    // rust: } else if hurt == 9 {
    // rust: il.ticks = 3;
    // rust: for i in 0..COPIES {
    // rust: il.offsets[0][i] = il.offsets[1][i];
    // rust: il.offsets[1][i] = [0.0; 3];
}
}
    // rust: m.extra.illusions = Some(il);
    // rust: jumped
}

// `Illusioner.getIllusionOffsets`.
offsets :: proc(m: ^Mob, partial: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let Some(il) = &m.extra.illusions else {
    // rust: return [[0.0; 3]; COPIES];
}
    // rust: if il.ticks <= 0 {
    // rust: return il.offsets[1];
}
    // rust: let scale = (f64::from(il.ticks as f32 - partial) / 3.0).powf(0.25);
    // rust: let mut out = [[0.0; 3]; COPIES];
    // rust: for (i, o) in out.iter_mut().enumerate() {
    // rust: for k in 0..3 {
    // rust: o[k] = il.offsets[1][i][k] * (1.0 - scale) + il.offsets[0][i][k] * scale;
}
}
    // rust: out
}

// The wobble `IllusionerRenderer.submit` adds to each image.
wobble :: proc(i: uint, age: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let i = i as f32;
    // rust: [
    // rust: f64::from((i + age * 0.5).cos()) * 0.025,
    // rust: f64::from((i + age * 0.75).cos()) * 0.0125,
    // rust: f64::from((i + age * 0.7).cos()) * 0.025,
    // rust: ]
}

    // rust: mod tests {
//     use super::*;
settled_offsets_are_the_new_set :: proc() {
}
    // rust: let il = Illusions {
    // rust: ticks: 0,
    // rust: offsets: [[[1.0; 3]; COPIES], [[2.0; 3]; COPIES]],
}
    // rust: let mut v = [[0.0; 3]; COPIES];
    // rust: v.copy_from_slice(&il.offsets[1]);
    // rust: assert_eq!(v[0], [2.0; 3]);
}
wobble_is_small :: proc() {
}
    // rust: assert!(wobble(1, 10.0).iter().all(|c| c.abs() <= 0.025));
}

    // `SpellcasterIllager.customServerAiStep` counts a cast down once a
    // tick for the illusioner as for the evoker (`Illusioner` has no override).
    // Without it the count stayed at 20 after the first spell, so the
    // illusioner kept casting: no second spell and no bow.
the_cast_counts_down :: proc() {
}
//         use crate::mobs::world::with_test_world;
//         use std::sync::Arc;
    // rust: let mut left = None;
    // rust: let ran = with_test_world(&[], |w, types| {
    // rust: let mut m = Mob::new(
    // rust: 1,
    // rust: Arc::new(types.types["minecraft:illusioner"].clone()),
    // rust: horizon_core::geometry::Vec3::new(0.5, 64.0, 0.5),
    // rust: 0.0,
    // rust: );
    // rust: m.extra.counter = 20;
    // rust: let (mut lr, mut events) = (horizon_core::random::LegacyRandom::new(0), Vec::new());
    // rust: for _ in 0..5 {
    // rust: crate::mobs::ai::tick(&mut m, w, &mut lr, &mut events);
}
    // rust: left = Some(m.extra.counter);
    // rust: });
    // rust: if !ran {
    // rust: return;
}
    // rust: assert_eq!(left, Some(15));
}

    // `IllusionerBlindnessSpellGoal.performSpellCasting` adds Blindness for
    // 400 ticks to the `LivingEntity` the illusioner targets: a villager or
    // an iron golem (mob 2) gets it as the player does. Without the fix the
    // cast on a mob sent no effect at all.
the_blindness_spell_reaches_a_targeted_mob :: proc() {
}
//         use crate::mobs::world::with_test_world;
//         use std::sync::Arc;
    // rust: let mut cast = Vec::new();
    // rust: let ran = with_test_world(&[], |w, types| {
    // rust: for target in [Who::Mob(2), Who::Player] {
    // rust: let mut m = Mob::new(
    // rust: 1,
    // rust: Arc::new(types.types["minecraft:illusioner"].clone()),
    // rust: horizon_core::geometry::Vec3::new(0.5, 64.0, 0.5),
    // rust: 0.0,
    // rust: );
    // rust: m.ai.target = Some(target);
    // rust: let mut spell = Spell::new(BLINDNESS_SPELL);
    // rust: spell.warmup = 1;
    // rust: let (mut lr, mut events) = (horizon_core::random::LegacyRandom::new(0), Vec::new());
    // rust: spell.tick(
    // rust: &mut m,
    // rust: &mut Cx {
    // rust: w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
    // rust: },
    // rust: );
    // rust: cast.push(events.into_iter().find_map(|e| match e {
    // rust: MobEvent::EffectMob {
    // rust: target,
    // rust: effect,
    // rust: ticks,
    // rust: amplifier,
    // rust: } => Some((Some(target), effect, ticks, amplifier)),
    // rust: MobEvent::EffectPlayer {
    // rust: effect,
    // rust: ticks,
    // rust: amplifier,
    // rust: ..
    // rust: } => Some((None, effect, ticks, amplifier)),
    // rust: _ => None,
    // rust: }));
}
    // rust: });
    // rust: if !ran {
    // rust: return;
}
    // rust: assert_eq!(
    // rust: cast,
    // rust: [
    // rust: Some((Some(2), BLINDNESS, 400, 0)),
    // rust: Some((None, BLINDNESS, 400, 0)),
    // rust: ]
    // rust: );
}
}
