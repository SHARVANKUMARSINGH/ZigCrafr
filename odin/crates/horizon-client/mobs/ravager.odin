//! Transpiled from Horizon Rust crate
package horizon_client_ravager

import "core:fmt"
import "core:mem"
import "core:math"

// Ravagers (`Ravager`): charging beasts that trample leaves, bite for 12,
// get stunned by a raised shield half the time and answer with a roar
// that hurts and flings everything within 4 blocks.
// use super::{
    // rust: Damage, Mob, MobEvent, MobWorld, Species, Who,
    // rust: anim::{Poses, State},
    // rust: goals::{Float, HurtByTarget, LookAtPlayer, MeleeAttack, NearestTarget, Stroll},
    // rust: path::PathType,
}
// use horizon_core::geometry::trig::Mth;
// use horizon_core::random::RandomSource;
// use std::f32::consts::PI;

// Ravager state: `counter` attackTick, `counter2` stunnedTick,
// `anim_ticks` roarTick.

register :: proc(m: ^Mob) {
}
    // rust: m.set_malus(PathType::Leaves, 0.0);
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(0, Float);
    // rust: g.add(4, MeleeAttack::new(1.0, true));
    // rust: g.add(5, Stroll::avoiding_water(0.4));
    // rust: g.add(6, LookAtPlayer::new(6.0));
    // rust: g.add(10, LookAtPlayer::mobs(8.0));
    // rust: let mut hurt = HurtByTarget::new().alert();
    // rust: hurt.ignore = vec![
    // rust: Species::Pillager,
    // rust: Species::Vindicator,
    // rust: Species::Evoker,
    // rust: Species::Illusioner,
    // rust: Species::Witch,
    // rust: Species::Ravager,
    // rust: ];
    // rust: m.ai.targets.add(2, hurt);
    // rust: m.ai.targets.add(3, NearestTarget::player(true));
    // rust: m.ai.targets.add(
    // rust: 4,
    // rust: NearestTarget::new(
    // rust: super::goals::Prey::Filter(|s| {
    // rust: matches!(s.species, Species::Villager | Species::WanderingTrader) && !s.baby
    // rust: }),
    // rust: true,
    // rust: ),
    // rust: );
    // rust: m.ai.targets
    // rust: .add(4, NearestTarget::species(&[Species::IronGolem], true));
}
// `Ravager.isImmobile`: biting, stunned or roaring.
immobile :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.counter > 0 || m.extra.counter2 > 0 || m.extra.anim_ticks > 0
}
// `Ravager.doHurtTarget`: the bite animation (entity event 4 for clients).
on_attack :: proc(m: ^Mob, events: ^[dynamic]MobEvent) {
}
    // rust: m.extra.counter = 10;
    // rust: events.push(MobEvent::EntityEvent {
    // rust: mob: m.id,
    // rust: event: 4,
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: });
    // rust: events.push(MobEvent::Sound(
    // rust: "entity.ravager.attack",
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: 1.0,
    // rust: 1.0,
    // rust: ));
}
// `Ravager.blockedByItem`: a raised shield stuns it half the time (else
// flings the defender); returns whether it was stunned.
blocked :: proc(m: ^Mob, events: ^[dynamic]MobEvent) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if m.extra.anim_ticks != 0 {
    // rust: return false;
}
    // rust: if m.random.next_double() < 0.5 {
    // rust: m.extra.counter2 = 40;
        // Entity event 39: the stun starts on clients.
    // rust: events.push(MobEvent::EntityEvent {
    // rust: mob: m.id,
    // rust: event: 39,
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: });
    // rust: events.push(MobEvent::Sound(
    // rust: "entity.ravager.stunned",
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: 1.0,
    // rust: 1.0,
    // rust: ));
    // rust: true
    // rust: } else {
    // rust: false
}
}
// `Ravager.aiStep`: speed toward 0.35 while hunting, leaf and crop trampling, and
// the bite, stun and roar clocks.
ai_step :: proc(m: ^Mob, w: ^MobWorld, events: ^[dynamic]MobEvent) {
}
    // rust: if !m.alive() {
    // rust: return;
}
    // rust: let max = if immobile(m) {
    // rust: 0.0
    // rust: } else if m.ai.target.is_some() {
    // rust: 0.35
    // rust: } else {
    // rust: 0.3
}
    // rust: m.attrs.speed = if max == 0.0 {
    // rust: 0.0
    // rust: } else {
    // rust: m.attrs.speed + (max - m.attrs.speed) * 0.1
}
    // rust: if m.horizontal_collision && w.mob_griefing {
    // rust: let b = m
    // rust: .bounds()
    // rust: .inflate(horizon_core::geometry::Vec3::new(0.2, 0.2, 0.2));
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: let mut destroyed = false;
    // rust: for x in lo.x.floor() as i32..=hi.x.floor() as i32 {
    // rust: for y in lo.y.floor() as i32..=hi.y.floor() as i32 {
    // rust: for z in lo.z.floor() as i32..=hi.z.floor() as i32 {
    // rust: let name = w.block_name(x, y, z);
    // rust: if name.ends_with("_leaves") {
    // rust: events.push(MobEvent::BreakBlock {
    // rust: pos: [x, y, z],
    // rust: drop: true,
    // rust: });
    // rust: destroyed = true;
}
}
}
}
    // rust: if !destroyed && m.on_ground {
    // rust: m.ai.jumping = true;
}
}
    // Entity.checkInsideBlocks -> CropBlock.entityInside: a ravager walking
    // through a crop destroys it, drops and all, with mobGriefing; a pitcher
    // crop (PitcherCropBlock.entityInside) goes the same way, both halves.
    // rust: if w.mob_griefing {
    // rust: let b = m
    // rust: .bounds()
    // rust: .deflate(horizon_core::geometry::Vec3::new(1.0e-5, 1.0e-5, 1.0e-5));
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: for x in lo.x.floor() as i32..=hi.x.floor() as i32 {
    // rust: for y in lo.y.floor() as i32..=hi.y.floor() as i32 {
    // rust: for z in lo.z.floor() as i32..=hi.z.floor() as i32 {
    // rust: if matches!(
    // rust: w.block_name(x, y, z),
    // rust: "minecraft:wheat"
    // rust: | "minecraft:carrots"
    // rust: | "minecraft:potatoes"
    // rust: | "minecraft:beetroots"
    // rust: | "minecraft:torchflower_crop"
    // rust: | "minecraft:pitcher_crop"
    // rust: ) {
    // rust: events.push(MobEvent::BreakBlock {
    // rust: pos: [x, y, z],
    // rust: drop: true,
    // rust: });
}
}
}
}
}
    // rust: if m.extra.anim_ticks > 0 {
    // rust: m.extra.anim_ticks -= 1;
    // rust: if m.extra.anim_ticks == 10 {
    // rust: roar(m, w, events);
}
}
    // rust: if m.extra.counter > 0 {
    // rust: m.extra.counter -= 1;
}
    // rust: if m.extra.counter2 > 0 {
    // rust: m.extra.counter2 -= 1;
    // rust: if m.random.next_int_bound(6).unwrap_or(1) == 0 {
    // rust: let yaw = m.body_yaw.to_radians();
    // rust: let width = f64::from(m.width());
    // rust: events.push(MobEvent::Particles {
    // rust: kind: "entity_effect",
    // rust: at: [
    // rust: m.position.x - width * f64::from(yaw.msin()),
    // rust: m.position.y + f64::from(m.height()) - 0.3,
    // rust: m.position.z + width * f64::from(yaw.mcos()),
    // rust: ],
    // rust: count: 0,
    // rust: });
}
    // rust: if m.extra.counter2 == 0 {
    // rust: events.push(MobEvent::Sound(
    // rust: "entity.ravager.roar",
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: 1.0,
    // rust: 1.0,
    // rust: ));
    // rust: m.extra.anim_ticks = 20;
}
}
}
// `Ravager.handleEntityEvent` 4 and 39 on a client.
entity_event :: proc(m: ^Mob, event: u8) {
}
    // rust: match event {
    // rust: 4 => m.extra.counter = 10,
    // rust: 39 => m.extra.counter2 = 40,
    // rust: _ => {}
}
}
// `Ravager.aiStep`'s clocks on a client: the bite and roar run down, and
// the end of the stun starts the roar (the sounds, particles and the roar's
// damage are the server's).
client_tick :: proc(m: ^Mob) {
}
    // rust: if !m.alive() {
    // rust: return;
}
    // rust: if m.extra.anim_ticks > 0 {
    // rust: m.extra.anim_ticks -= 1;
}
    // rust: if m.extra.counter > 0 {
    // rust: m.extra.counter -= 1;
}
    // rust: if m.extra.counter2 > 0 {
    // rust: m.extra.counter2 -= 1;
    // rust: if m.extra.counter2 == 0 {
    // rust: m.extra.anim_ticks = 20;
}
}
}
// `Ravager.roar`: 6 damage to everything but illagers within 4 blocks,
// and a strong knockback (players too, through the client).
roar :: proc(m: ^Mob, w: ^MobWorld, events: ^[dynamic]MobEvent) {
}
    // rust: let area = m
    // rust: .bounds()
    // rust: .inflate(horizon_core::geometry::Vec3::new(4.0, 4.0, 4.0));
    // rust: let from = [m.position.x, m.position.y, m.position.z];
    // rust: let fling = |p: horizon_core::geometry::Vec3| {
    // rust: let (xd, zd) = (p.x - m.position.x, p.z - m.position.z);
    // rust: let dd = (xd * xd + zd * zd).max(0.001);
    // rust: [xd / dd * 4.0, 0.2, zd / dd * 4.0]
}
    // rust: if let Some(p) = &w.player
    // rust: && p.alive
    // rust: && p.bounds.intersects(area)
    // rust: {
    // rust: events.push(MobEvent::AttackPlayer(6.0, from));
    // rust: events.push(MobEvent::Push {
    // rust: target: Who::Player,
    // rust: velocity: fling(p.position),
    // rust: });
}
    // rust: for s in w.others_near(area) {
    // rust: if s.id == m.id || !s.alive || s.species == Species::Ravager || !s.bounds.intersects(area) {
    // rust: continue;
}
    // rust: let illager = matches!(
    // rust: s.species,
    // rust: Species::Pillager | Species::Vindicator | Species::Evoker | Species::Illusioner
    // rust: );
    // rust: if !illager {
    // rust: events.push(MobEvent::AttackMob {
    // rust: target: s.id,
    // rust: amount: 6.0,
    // rust: source: Damage::mob(m.id, from),
    // rust: });
}
    // rust: events.push(MobEvent::Push {
    // rust: target: Who::Mob(s.id),
    // rust: velocity: fling(s.position),
    // rust: });
}
    // Entity event 69: a puff of smoke, and the client's own push. A client
    // of this server (the window of the server thread) gets the event;
    // this window draws the puff itself.
    // rust: events.push(MobEvent::EntityEvent {
    // rust: mob: m.id,
    // rust: event: 69,
    // rust: at: from,
    // rust: });
    // rust: events.push(MobEvent::Particles {
    // rust: kind: "poof",
    // rust: at: [
    // rust: m.position.x,
    // rust: m.position.y + f64::from(m.height()) / 2.0,
    // rust: m.position.z,
    // rust: ],
    // rust: count: 40,
    // rust: });
}
// `RavagerModel.setupAnim`.
anim :: proc(m: ^Mob, s: ^State, p: ^Poses) {
}
    // rust: let stunned = if m.extra.counter2 > 0 {
    // rust: m.extra.counter2 as f32 - s.partial
    // rust: } else {
    // rust: 0.0
}
    // rust: let attack = if m.extra.counter > 0 {
    // rust: m.extra.counter as f32 - s.partial
    // rust: } else {
    // rust: 0.0
}
    // rust: if attack > 0.0 {
        // Mth.triangleWave(attack, 10).
    // rust: let wave = ((attack % 10.0 - 5.0).abs() - 2.5) / 2.5;
    // rust: let scaled = (1.0 + wave) * 0.5;
    // rust: let head = scaled * scaled * scaled * 12.0;
    // rust: let neck_x_rot = p.get("neck")[3];
    // rust: let neck = p.get("neck");
    // rust: neck[2] = -6.5 + head;
    // rust: neck[1] = -7.0 - head * neck_x_rot.msin();
    // rust: let mouth = if attack > 5.0 {
    // rust: ((-4.0 + attack) / 4.0).msin() * PI * 0.4
    // rust: } else {
    // rust: PI / 20.0 * (PI * attack / 10.0).msin()
}
    // rust: p.xrot("mouth", mouth);
    // rust: } else {
    // rust: let is_stunned = stunned > 0.0;
    // rust: let x_rot: f32 = if is_stunned { 0.219_911_49 } else { 0.0 };
    // rust: let neck = p.get("neck");
    // rust: let y_offset = -neck[3].msin();
    // rust: neck[0] = 0.0;
    // rust: neck[1] = -7.0 - y_offset;
    // rust: neck[2] = 5.5;
    // rust: neck[3] = x_rot;
    // rust: p.xrot("mouth", PI * if is_stunned { 0.05 } else { 0.01 });
    // rust: if is_stunned {
    // rust: p.get("neck")[0] = ((f64::from(stunned) / 40.0) * 10.0).sin() as f32 * 3.0;
    // rust: } else if m.extra.anim_ticks > 0 {
    // rust: let roar = (20.0 - m.extra.anim_ticks as f32 + s.partial) / 20.0;
    // rust: p.xrot("mouth", PI / 2.0 * (roar * PI * 0.25).msin());
}
}
    // rust: p.xrot("head", s.x_rot.to_radians());
    // rust: p.yrot("head", s.y_rot.to_radians());
    // rust: let (pos, leg) = (s.pos, 0.4 * s.speed);
    // rust: p.xrot("right_hind_leg", (pos * 0.6662).mcos() * leg);
    // rust: p.xrot("left_hind_leg", (pos * 0.6662 + PI).mcos() * leg);
    // rust: p.xrot("right_front_leg", (pos * 0.6662 + PI).mcos() * leg);
    // rust: p.xrot("left_front_leg", (pos * 0.6662).mcos() * leg);
}
