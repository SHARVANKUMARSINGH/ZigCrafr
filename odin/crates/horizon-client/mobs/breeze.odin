//! Transpiled from Horizon Rust crate
package horizon_client_breeze

import "core:fmt"
import "core:mem"
import "core:math"

// Breezes (`Breeze`): the poses and their animations, the long jump's
// arithmetic, the sounds of `Breeze.tick` and `BreezeModel`'s layers. The
// brain (`BreezeAi` and its behaviours) is in `monster_brain`.
// use super::{
    // rust: Damage, Mob, MobEvent, MobWorld, Species, Who,
    // rust: anim::{Poses, State},
    // rust: keyframes::Animation,
}
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3},
    // rust: jmath,
    // rust: random::RandomSource,
}
// use std::collections::HashMap;

// `variant3` is the pose, `variant` the pose the animations last saw,
// `vector[2]` `soundTick`. AnimState states: idle, shoot, slide, slide back,
// inhale, long jump.
STANDING :: 0
SHOOTING :: 1
INHALING :: 2
LONG_JUMPING :: 3
SLIDING :: 4

ALLOWED_ANGLES :: [40, 55, 60, 75, 80]

// `Breeze`'s constructor: no goals, the brain thinks (`monster_brain`).
register :: proc(m: ^Mob) {
}
    // rust: m.set_malus(super::path::PathType::OnTopOfTrapdoor, -1.0);
    // rust: m.set_malus(super::path::PathType::Fire, -1.0);
}
// `Breeze.isInvulnerableTo`: another breeze (or itself).
accepts_damage :: proc(m: ^Mob, source: ^Damage) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !(source.attacker == Some(Who::Mob(m.id)) || source.attacker_species == Some(Species::Breeze))
}
pose :: proc(m: ^Mob) -> u {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.variant3
}
    // rust: pub(super) fn set_pose(m: &mut Mob, pose: u8) {
    // rust: m.extra.variant3 = pose;
}
// `Pose.id` of the pose (`sync::pose_id`), and its inverse.
pose_id :: proc(m: ^Mob) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match pose(m) {
    // rust: SHOOTING => 16,
    // rust: INHALING => 17,
    // rust: LONG_JUMPING => 6,
    // rust: SLIDING => 15,
    // rust: _ => 0,
}
}
    // rust: pub(super) fn set_pose_id(m: &mut Mob, id: u8) {
    // rust: set_pose(
    // rust: m,
    // rust: match id {
    // rust: 16 => SHOOTING,
    // rust: 17 => INHALING,
    // rust: 6 => LONG_JUMPING,
    // rust: 15 => SLIDING,
    // rust: _ => STANDING,
    // rust: },
    // rust: );
}
// `Breeze.getFiringYPosition`.
firing_y :: proc(m: ^Mob) -> f {
    // Ported from Horizon
    return {}
}
    // rust: m.position.y + f64::from(m.height()) / 2.0 + f64::from(0.3_f32)
}
// `LongJump.canJumpFromCurrentPosition`: not on honey, and four blocks of
// air or water above.
    // rust: pub(super) fn can_jump_from_here(m: &Mob, w: &MobWorld) -> bool {
    // rust: let (x, y, z) = (
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: );
    // rust: if w.block_name(x, y, z) == "minecraft:honey_block" {
    // rust: return false;
}
    // rust: (1..=4).all(|i| {
    // rust: w.facts.is_air(w.world.block(x, y + i, z))
    // rust: || w.fluid(x, y + i, z) == crate::blocks::Fluid::Water
    // rust: })
}
// `LongJump.snapToSurface`: the block above where a clip ten blocks down
// hits, else ten blocks up.
    // rust: pub(super) fn snap_to_surface(w: &MobWorld, p: Vec3) -> Option<[i32; 3]> {
    // rust: let above = |hit: Vec3| {
    // rust: [
    // rust: hit.x.floor() as i32,
    // rust: hit.y.floor() as i32 + 1,
    // rust: hit.z.floor() as i32,
    // rust: ]
}
    // rust: if let Some(hit) = w.clip_block(p, Vec3::new(p.x, p.y - 10.0, p.z)) {
    // rust: return Some(above(hit));
}
    // rust: w.clip_block(p, Vec3::new(p.x, p.y + 10.0, p.z)).map(above)
}
// `EntityType.isBlockDangerous` for the breeze (not fire immune).
    // rust: pub(super) fn dangerous_block(name: &str) -> bool {
    // rust: matches!(
    // rust: name,
    // rust: "minecraft:fire"
    // rust: | "minecraft:soul_fire"
    // rust: | "minecraft:lava"
    // rust: | "minecraft:magma_block"
    // rust: | "minecraft:lava_cauldron"
    // rust: | "minecraft:wither_rose"
    // rust: | "minecraft:sweet_berry_bush"
    // rust: | "minecraft:cactus"
    // rust: | "minecraft:powder_snow"
    // rust: )
}
// `LongJumpUtil.calculateJumpVectorForAngle`; with a world, the arc is
// checked for collisions (`checkCollision`).
    // rust: pub(super) fn jump_vector(
    // rust: m: &Mob,
    // rust: target: Vec3,
    // rust: max_velocity: f32,
    // rust: angle: i32,
    // rust: collide: Option<&MobWorld>,
    // rust: ) -> Option<Vec3> {
    // rust: let pos = m.position;
    // rust: let plane = Vec3::new(target.x - pos.x, 0.0, target.z - pos.z)
    // rust: .normalize()
    // rust: .scale(0.5);
    // rust: let aim = target.subtract(plane);
    // rust: let d = aim.subtract(pos);
    // rust: let angrad = angle as f32 * std::f32::consts::PI / 180.0;
    // Math.atan2 is StrictMath.atan2 (fdlibm).
    // rust: let xz = horizon_core::geometry::trig::fdlibm_atan2(d.z, d.x);
    // rust: let r2 = d.x * d.x + 0.0 + d.z * d.z;
    // rust: let r = r2.sqrt();
    // rust: let y = d.y;
    // rust: let g = m.gravity();
    // rust: let sin2 = jmath::sin(f64::from(2.0 * angrad));
    // rust: let cos_sq = jmath::pow(jmath::cos(f64::from(angrad)), 2.0);
    // rust: let (sin, cos) = (jmath::sin(f64::from(angrad)), jmath::cos(f64::from(angrad)));
    // rust: let v0sq = r2 * g / (r * sin2 - 2.0 * y * cos_sq);
    // rust: if v0sq < 0.0 {
    // rust: return None;
}
    // rust: let v0 = v0sq.sqrt();
    // rust: if v0 > f64::from(max_velocity) {
    // rust: return None;
}
    // rust: let (v0r, v0y) = (v0 * cos, v0 * sin);
    // rust: if let Some(w) = collide {
        // `ceil(r / v0r) * 2` points along the arc, each step clear of blocks.
    // rust: let samples = (r / v0r).ceil() as i32 * 2;
    // rust: let (sin_xz, cos_xz) = (jmath::sin(xz), jmath::cos(xz));
    // rust: let mut ri = 0.0;
    // rust: let mut previous: Option<Vec3> = None;
    // rust: for _ in 0..samples - 1 {
    // rust: ri += r / f64::from(samples);
    // rust: let yi = sin / cos * ri - jmath::pow(ri, 2.0) * g / (2.0 * v0sq * jmath::pow(cos, 2.0));
    // rust: let p = Vec3::new(pos.x + ri * cos_xz, pos.y + yi, pos.z + ri * sin_xz);
    // rust: if previous.is_some_and(|q| !clear_transition(m, w, q, p)) {
    // rust: return None;
}
    // rust: previous = Some(p);
}
}
    // rust: Some(Vec3::new(v0r * jmath::cos(xz), v0y, v0r * jmath::sin(xz)).scale(f64::from(0.95_f32)))
}
// `LongJumpUtil.isClearTransition`: the box of `Pose.LONG_JUMPING` fits at
// points no further apart than nine tenths of its smaller side.
clear_transition :: proc(m: ^Mob, w: ^MobWorld, from: Vec3, to: Vec3) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (width, height, _) = m.awake_dims_in(true);
    // rust: let (width, height) = (width as f32, height as f32);
    // rust: let d = to.subtract(from);
    // rust: let min = f64::from(width.min(height));
    // rust: let checks = (d.length() / min).ceil() as i32;
    // rust: let step = d.normalize().scale(min * f64::from(0.9_f32));
    // rust: let half = f64::from(width) / 2.0;
    // rust: let mut p = from;
    // rust: (0..checks).all(|i| {
    // rust: p = if i == checks - 1 {
    // rust: to
    // rust: } else {
    // rust: p.add_vector(step)
}
        // `EntityDimensions.makeBoundingBox`.
    // rust: w.no_collision(Aabb::new(
    // rust: Vec3::new(p.x - half, p.y, p.z - half),
    // rust: Vec3::new(p.x + half, p.y + f64::from(height), p.z + half),
    // rust: ))
    // rust: })
}
// `LongJump.calculateOptimalJumpVector`: the allowed angles shuffled, the
// first that reaches the target.
    // rust: pub(super) fn optimal_jump_vector(m: &mut Mob, target: Vec3) -> Option<Vec3> {
    // rust: let mut angles = ALLOWED_ANGLES;
    // rust: for i in (2..=angles.len()).rev() {
    // rust: let j = m.random.next_int_bound(i as i32).unwrap_or(0) as usize;
    // rust: angles.swap(i - 1, j);
}
    // rust: let max = 0.058_333_334_f32 * m.attrs.follow_range as f32;
    // rust: let v = angles
    // rust: .iter()
    // rust: .find_map(|&a| jump_vector(m, target, max, a, None))?;
    // rust: if m.has_effect("minecraft:jump_boost") {
    // rust: let amp = m
    // rust: .extra
    // rust: .effects
    // rust: .iter()
    // rust: .find(|e| e.0 == "minecraft:jump_boost")
    // rust: .map_or(0, |e| e.2);
        // LivingEntity.getJumpBoostPower
    // rust: let boost = f64::from(0.1_f32 * (amp + 1) as f32);
    // rust: return Some(v.add_vector(Vec3::new(0.0, v.normalize().y * boost, 0.0)));
}
    // rust: Some(v)
}
// Whether `Breeze.shouldDiscardFriction` applies (a long jump in the air).
discards_friction :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.species() == Species::Breeze && pose(m) == LONG_JUMPING
}
// `Breeze.tick` before `super.tick()`: the ground particles the pose asks
// for, then the whirl sound clock (`playWhirlSound` is a local sound, heard on
// the client only).
tick :: proc(m: ^Mob, w: ^MobWorld, events: ^[dynamic]MobEvent) {
}
    // rust: if let Some(count) = ground_particle_count(m) {
    // rust: emit_ground_particles(m, w, count, events);
}
    // rust: if m.extra.vector[2] == 0.0 {
    // rust: m.extra.vector[2] = f64::from(m.random.next_int_between_inclusive(1, 80).unwrap_or(1));
    // rust: } else {
    // rust: m.extra.vector[2] -= 1.0;
}
    // rust: if m.extra.vector[2] == 0.0 {
    // rust: let pitch = 0.7 + 0.4 * m.random.next_float();
    // rust: let volume = 0.8 + 0.2 * m.random.next_float();
    // rust: events.push(MobEvent::LocalSound(
    // rust: "entity.breeze.whirl",
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: volume,
    // rust: pitch,
    // rust: ));
}
}
// The crumbs `Breeze.tick`'s pose arm asks `emitGroundParticles` for:
// shooting, inhaling and standing `1 + random.nextInt(1)`, sliding twenty, and
// none for the long jump (which draws its own trail). The draw is made even
// when there is no block to crumble, so it is part of the tick's random.
ground_particle_count :: proc(m: ^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match pose(m) {
    // rust: SHOOTING | INHALING | STANDING => Some(1 + m.random.next_int_bound(1).unwrap_or(0) as u32),
    // rust: SLIDING => Some(20),
    // rust: _ => None,
}
}
// `Breeze.emitGroundParticles(count)`: `count` crumbs of the block the breeze
// stands in (else the one it stands on), drawn at rest at the centre of its
// box and the height of its feet.
emit_ground_particles :: proc(m: ^Mob, w: ^MobWorld, count: u32, events: ^[dynamic]MobEvent) {
}
    // rust: if m.extra.passenger {
    // rust: return;
}
    // rust: let p = m.position;
    // `getInBlockState`, else `getBlockStateOn`.
    // rust: let cell = [p.x.floor() as i32, p.y.floor() as i32, p.z.floor() as i32];
    // rust: let in_block = w.world.block(cell[0], cell[1], cell[2]);
    // rust: let state = if w.facts.is_air(in_block) {
    // rust: let on = m.block_on_legacy(w);
    // rust: w.world.block(on[0], on[1], on[2])
    // rust: } else {
    // rust: in_block
}
    // rust: if w.facts.get(state).render_shape == crate::blocks::RenderShape::Invisible {
    // rust: return;
}
    // rust: events.push(MobEvent::LandingDust {
    // rust: state,
        // `getBoundingBox().getCenter()` on x and z, `position().y` for it.
    // rust: at: [p.x, p.y, p.z],
    // rust: count: count as i32,
        // `addParticle(..., 0.0, 0.0, 0.0)`: no speed to the crumbs.
    // rust: speed: 0.0,
    // rust: });
}
// The client's pose-driven animation states (`onSyncedDataUpdated` and
// `Breeze.tick`).
ai_step :: proc(m: ^Mob) {
}
    // rust: let age = m.age as f32;
    // rust: let current = pose(m);
    // rust: if current != m.extra.variant {
        // resetAnimations, then the pose's own animation.
    // rust: let st = &mut m.anim.states;
    // rust: st[1].stop();
    // rust: st[0].stop();
    // rust: st[4].stop();
    // rust: st[5].stop();
    // rust: match current {
    // rust: SHOOTING => st[1].start_if_stopped(age),
    // rust: INHALING => st[4].start_if_stopped(age),
    // rust: SLIDING => st[2].start_if_stopped(age),
    // rust: _ => {}
}
    // rust: m.extra.variant = current;
}
    // rust: if current == LONG_JUMPING {
    // rust: m.anim.states[5].start_if_stopped(age);
}
    // rust: m.anim.states[0].start_if_stopped(age);
    // rust: if current != SLIDING && m.anim.states[2].started.is_some() {
    // rust: m.anim.states[3].start(age);
    // rust: m.anim.states[2].stop();
}
}
// `Breeze.playAmbientSound` (a local sound at volume and pitch 1) and its
// sound selection.
ambient :: proc(m: ^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if m.ai.target.is_some() && m.on_ground {
    // rust: return None;
}
    // rust: Some(if m.on_ground {
    // rust: "entity.breeze.idle_ground"
    // rust: } else {
    // rust: "entity.breeze.idle_air"
    // rust: })
}
// `BreezeModel.setupAnim`: the six keyframe animations.
anim :: proc(m: ^Mob, s: ^State, p: ^Poses, animations: ^HashMap<string) {
}
    // rust: let age = s.age;
    // rust: for (state, name) in [
    // rust: (&m.anim.states[0], "IDLE"),
    // rust: (&m.anim.states[1], "SHOOT"),
    // rust: (&m.anim.states[2], "SLIDE"),
    // rust: (&m.anim.states[3], "SLIDE_BACK"),
    // rust: (&m.anim.states[4], "INHALE"),
    // rust: (&m.anim.states[5], "JUMP"),
    // rust: ] {
    // rust: if let (Some(ms), Some(a)) = (
    // rust: state.millis(age),
    // rust: animations.get(&format!("BreezeAnimation.{name}")),
    // rust: ) {
    // rust: a.apply(ms, 1.0, p);
}
}
}
    // rust: mod tests {
the_highest_arc_reaches_a_target_within_range :: proc() {
}
        // Angle 80 degrees: v0^2 = r^2 g / (r sin 2a - 2 y cos^2 a).
    // rust: let g = 0.08;
    // rust: let (r, y): (f64, f64) = (10.0, 0.0);
    // rust: let a = 60.0_f64.to_radians();
    // rust: let v0sq = r * r * g / (r * (2.0 * a).sin() - 2.0 * y * a.cos().powi(2));
    // rust: assert!(v0sq.sqrt() < 1.4);
}
}
    // rust: mod ground_particle_tests {
//     use super::*;
//     use crate::mobs::sensor_scan_tests::kind;

breeze :: proc(at: Vec3) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = kind();
    // rust: let k = std::sync::Arc::make_mut(&mut kind);
    // rust: k.id = "minecraft:breeze".into();
    // rust: k.species = Species::Breeze;
    // rust: Mob::new(1, kind, at, 0.0)
}

    // `Breeze.tick`'s pose arm: sliding asks for twenty crumbs and makes no
    // draw, shooting, inhaling and standing ask for `1 + nextInt(1)` and make
    // one, and the long jump asks for none.
the_pose_asks_for_its_crumb_count_and_draws_once_or_never :: proc() {
}
        // The mob's random, advanced the way the pose's arm does it.
    // rust: let advance = |m: &Mob, draw: bool| {
    // rust: let mut probe = m.random.clone();
    // rust: if draw {
    // rust: let _ = probe.next_int_bound(1);
}
    // rust: probe.next_int_bound(1_000_000).unwrap_or(0)
}
    // rust: for (pose, count, draw) in [
    // rust: (SLIDING, 20, false),
    // rust: (STANDING, 1, true),
    // rust: (SHOOTING, 1, true),
    // rust: (INHALING, 1, true),
    // rust: ] {
    // rust: let mut m = breeze(Vec3::new(0.5, 64.0, 0.5));
    // rust: set_pose(&mut m, pose);
    // rust: let want = advance(&m, draw);
    // rust: assert_eq!(ground_particle_count(&mut m), Some(count), "pose {pose}");
    // rust: assert_eq!(
    // rust: m.random.next_int_bound(1_000_000).unwrap_or(0),
    // rust: want,
    // rust: "pose {pose}: {} draw(s)",
    // rust: u8::from(draw)
    // rust: );
}
        // The long jump takes the trail arm: no count and no draw.
    // rust: let mut m = breeze(Vec3::new(0.5, 64.0, 0.5));
    // rust: set_pose(&mut m, LONG_JUMPING);
    // rust: let want = advance(&m, false);
    // rust: assert_eq!(ground_particle_count(&mut m), None);
    // rust: assert_eq!(m.random.next_int_bound(1_000_000).unwrap_or(0), want);
}

    // `Breeze.emitGroundParticles`: one `BlockParticleOption(BLOCK, state)` at
    // a time, at rest, at the centre of the breeze's box and the height of its
    // feet, of the block it stands in or else the one it stands on; none as a
    // passenger or over a block that draws nothing (air).
a_breeze_crumbles_the_block_under_its_feet :: proc() {
}
//         use crate::mobs::world::with_built_test_world;
    // rust: let ran = with_built_test_world(
    // rust: &[],
    // rust: |world, registry| {
    // rust: world.chunks.insert(
    // rust: (0, 0),
    // rust: std::sync::Arc::new(crate::chunk::Chunk::empty(0, 0)),
    // rust: );
    // rust: let stone = registry.default_state("minecraft:stone").unwrap();
    // rust: for x in 0..16 {
    // rust: for z in 0..16 {
    // rust: world.set(x, 63, z, stone).unwrap();
}
}
    // rust: },
    // rust: |w, _| {
    // rust: let stone = w.registry.default_state("minecraft:stone").unwrap();
    // rust: let dust = |m: &Mob| {
    // rust: let mut events = Vec::new();
    // rust: emit_ground_particles(m, w, 1, &mut events);
    // rust: events
    // rust: .into_iter()
    // rust: .map(|e| match e {
    // rust: MobEvent::LandingDust {
    // rust: state,
    // rust: at,
    // rust: count,
    // rust: speed,
    // rust: } => (state, at, count, speed),
    // rust: other => panic!("not block crumbs: {other:?}"),
    // rust: })
    // rust: .collect::<Vec<_>>()
}
                // Feet at 64.0 over stone at y = 63: the block it stands on.
    // rust: let on_stone = breeze(Vec3::new(4.5, 64.0, 2.5));
    // rust: let crumbs = dust(&on_stone);
    // rust: assert_eq!(crumbs.len(), 1, "one event of crumbs, {crumbs:?}");
    // rust: let (state, at, count, speed) = crumbs[0];
    // rust: assert_eq!(state, stone);
                // `getBoundingBox().getCenter()` on x and z, `position().y`.
    // rust: assert_eq!(at, [4.5, 64.0, 2.5]);
    // rust: assert_eq!(count, 1);
    // rust: assert_eq!(speed, 0.0, "`addParticle(..., 0, 0, 0)`: at rest");
                // Twenty a tick while sliding, all at that one spot.
    // rust: let mut sliding = breeze(Vec3::new(4.5, 64.0, 2.5));
    // rust: set_pose(&mut sliding, SLIDING);
    // rust: let mut events = Vec::new();
    // rust: let count = ground_particle_count(&mut sliding).unwrap();
    // rust: emit_ground_particles(&sliding, w, count, &mut events);
    // rust: assert!(
    // rust: matches!(
    // rust: events.as_slice(),
    // rust: [MobEvent::LandingDust {
    // rust: state: s,
    // rust: at: [4.5, 64.0, 2.5],
    // rust: count: 20,
    // rust: speed: 0.0,
    // rust: }] if *s == stone
    // rust: ),
    // rust: "{events:?}"
    // rust: );
                // A passenger crumbles nothing.
    // rust: let mut riding = breeze(Vec3::new(4.5, 64.0, 2.5));
    // rust: riding.extra.passenger = true;
    // rust: assert!(dust(&riding).is_empty());
                // Over air the state is air, whose render shape draws nothing.
    // rust: let flying = breeze(Vec3::new(4.5, 100.0, 2.5));
    // rust: assert!(dust(&flying).is_empty());
    // rust: },
    // rust: );
        // Without the vanilla data under .local/horizon-client there is no world
        // to crumble: the test has nothing to check.
    // rust: let _ = ran;
}
}

    // rust: mod invulnerability_tests {
//     use super::*;
//     use crate::mobs::{DamageKind, sensor_scan_tests::kind};

test_breeze :: proc(id: u32) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = kind();
    // rust: let k = std::sync::Arc::make_mut(&mut kind);
    // rust: k.id = "minecraft:breeze".into();
    // rust: k.species = Species::Breeze;
    // rust: Mob::new(id, kind, Vec3::ZERO, 0.0)
}

    // Scenario 1: Default/legacy behavior preserved:
    // Breeze takes normal damage from player, generic damage, fall damage.
breeze_takes_normal_damage_from_player_fall_and_generic :: proc() {
}
    // rust: let mut b = test_breeze(1);
    // rust: let initial_health = b.health;
    // rust: assert!(initial_health > 0.0);

        // Player attack
    // rust: let player_hit = Damage::player([0.0, 0.0, 0.0]);
    // rust: assert!(
    // rust: b.damage(2.0, player_hit),
    // rust: "player attack should hurt breeze"
    // rust: );
    // rust: assert_eq!(b.health, initial_health - 2.0);

        // Fall damage
    // rust: b.invulnerable = 0;
    // rust: let health_before_fall = b.health;
    // rust: assert!(
    // rust: b.damage(3.0, Damage::fall()),
    // rust: "fall damage should hurt breeze"
    // rust: );
    // rust: assert_eq!(b.health, health_before_fall - 3.0);

        // Generic damage
    // rust: b.invulnerable = 0;
    // rust: let health_before_generic = b.health;
    // rust: assert!(
    // rust: b.damage(1.0, Damage::of(DamageKind::Generic)),
    // rust: "generic damage should hurt breeze"
    // rust: );
    // rust: assert_eq!(b.health, health_before_generic - 1.0);
}

    // Scenario 2: Blocking/rejection of disallowed actions:
    // Breeze rejects damage when attacker is another Breeze (`source.attacker_species == Some(Species::Breeze)`),
    // returning `false` from `m.damage(...)` and taking no damage.
breeze_rejects_damage_from_another_breeze :: proc() {
}
    // rust: let mut b = test_breeze(1);
    // rust: let initial_health = b.health;

        // Direct mob attack from another breeze
    // rust: let other_breeze_mob = Damage::mob(2, [0.0, 0.0, 0.0]).with_species(Species::Breeze);
    // rust: assert!(
    // rust: !b.damage(5.0, other_breeze_mob),
    // rust: "breeze should reject damage from another breeze"
    // rust: );
    // rust: assert_eq!(b.health, initial_health, "health must not change");

        // Thrown wind charge or projectile from another breeze
    // rust: let other_breeze_proj = Damage {
    // rust: kind: DamageKind::Thrown,
    // rust: attacker: Some(Who::Mob(2)),
    // rust: from: Some([1.0, 0.0, 0.0]),
    // rust: attacker_species: Some(Species::Breeze),
}
    // rust: assert!(
    // rust: !b.damage(3.0, other_breeze_proj),
    // rust: "breeze should reject projectile damage from another breeze"
    // rust: );
    // rust: assert_eq!(b.health, initial_health, "health must remain intact");

        // Directly verify breeze::accepts_damage
    // rust: assert!(!accepts_damage(&b, &other_breeze_mob));
    // rust: assert!(!accepts_damage(&b, &other_breeze_proj));
}

    // Scenario 3: Successful execution when requirements are met:
    // Breeze accepts damage from other mob species (e.g. Zombie, Skeleton) when `source.attacker_species` is Zombie/Skeleton.
breeze_accepts_damage_from_other_mob_species :: proc() {
}
    // rust: let mut b = test_breeze(1);
    // rust: let initial_health = b.health;

        // Attack from Zombie
    // rust: let zombie_hit = Damage::mob(5, [0.0, 0.0, 0.0]).with_species(Species::Zombie);
    // rust: assert!(
    // rust: accepts_damage(&b, &zombie_hit),
    // rust: "breeze accepts damage from zombie"
    // rust: );
    // rust: assert!(
    // rust: b.damage(4.0, zombie_hit),
    // rust: "breeze must take damage from zombie"
    // rust: );
    // rust: assert_eq!(b.health, initial_health - 4.0);

        // Attack from Skeleton
    // rust: b.invulnerable = 0;
    // rust: let skeleton_hit = Damage::mob(6, [0.0, 0.0, 0.0]).with_species(Species::Skeleton);
    // rust: assert!(
    // rust: accepts_damage(&b, &skeleton_hit),
    // rust: "breeze accepts damage from skeleton"
    // rust: );
    // rust: assert!(
    // rust: b.damage(2.0, skeleton_hit),
    // rust: "breeze must take damage from skeleton"
    // rust: );
    // rust: assert_eq!(b.health, initial_health - 6.0);
}

    // Scenario 4: Special / edge cases:
    // Breeze rejects self-inflicted damage (`source.attacker == Some(Who::Mob(m.id))`),
    // and verify bypasses_invulnerability behavior if applicable.
breeze_rejects_self_damage_and_respects_invulnerability_flags :: proc() {
}
    // rust: let mut b = test_breeze(1);
    // rust: let initial_health = b.health;

        // Self-inflicted damage with no species tag
    // rust: let self_hit_no_species = Damage::mob(b.id, [0.0, 0.0, 0.0]);
    // rust: assert!(
    // rust: !accepts_damage(&b, &self_hit_no_species),
    // rust: "breeze rejects self-hit even without species"
    // rust: );
    // rust: assert!(
    // rust: !b.damage(5.0, self_hit_no_species),
    // rust: "breeze takes no damage from itself"
    // rust: );
    // rust: assert_eq!(b.health, initial_health);

        // Self-inflicted damage with species tag
    // rust: let self_hit_with_species =
    // rust: Damage::mob(b.id, [0.0, 0.0, 0.0]).with_species(Species::Breeze);
    // rust: assert!(
    // rust: !accepts_damage(&b, &self_hit_with_species),
    // rust: "breeze rejects self-hit with species"
    // rust: );
    // rust: assert!(
    // rust: !b.damage(5.0, self_hit_with_species),
    // rust: "breeze takes no damage from itself"
    // rust: );
    // rust: assert_eq!(b.health, initial_health);

        // Invulnerable flag on Mob:
    // rust: b.invulnerable_flag = true;
        // Normal damage does not bypass invulnerability flag
    // rust: let normal_player = Damage::player([0.0, 0.0, 0.0]);
    // rust: assert!(
    // rust: !b.damage(5.0, normal_player),
    // rust: "invulnerable_flag blocks normal player damage"
    // rust: );
    // rust: assert_eq!(b.health, initial_health);

        // GenericKill bypasses invulnerability flag
    // rust: let kill_damage = Damage::of(DamageKind::GenericKill);
    // rust: assert!(kill_damage.kind.bypasses_invulnerability());
    // rust: assert!(
    // rust: b.damage(1.0, kill_damage),
    // rust: "GenericKill bypasses invulnerability flag"
    // rust: );
    // rust: assert_eq!(b.health, initial_health - 1.0);

        // But another Breeze with GenericKill is still rejected by Breeze.isInvulnerableTo
    // rust: b.invulnerable = 0;
    // rust: let breeze_kill = Damage::of(DamageKind::GenericKill).with_species(Species::Breeze);
    // rust: assert!(
    // rust: !accepts_damage(&b, &breeze_kill),
    // rust: "Breeze.isInvulnerableTo rejects breeze attacker even for GenericKill"
    // rust: );
    // rust: assert!(
    // rust: !b.damage(1.0, breeze_kill),
    // rust: "breeze takes no damage from breeze GenericKill"
    // rust: );
}
}
