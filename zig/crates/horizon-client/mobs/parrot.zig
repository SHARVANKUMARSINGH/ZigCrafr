//! Transpiled from Horizon Rust crate
//! Module: horizon-client_parrot
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Parrots: flying (`FlyingMoveControl`, `FlyingPathNavigation`, the wander
//! that heads for trees), flapping and gliding down (`calculateFlapping`),
//! and what `Parrot.aiStep` adds: imitating the mobs around it
//! (`imitateNearbyMobs`, the ambient sound of `getAmbient`) and dancing near
//! a playing jukebox.
// use super::{Mob, MobEvent, MobWorld, Species, control::MoveKind, nav::NavKind, path::PathType};
// use horizon_core::{
    // rust: geometry::Vec3,
    // rust: random::{LegacyRandom, RandomSource},
}

/// `Parrot.MOB_SOUND_MAP` (the happy ghast's is `SoundEvents.EMPTY`: "").
    // rust: const IMITATIONS: [(Species, &str); 41] = [
    // rust: (Species::Blaze, "entity.parrot.imitate.blaze"),
    // rust: (Species::Bogged, "entity.parrot.imitate.bogged"),
    // rust: (Species::Breeze, "entity.parrot.imitate.breeze"),
    // rust: (Species::CamelHusk, "entity.parrot.imitate.camel_husk"),
    // rust: (Species::CaveSpider, "entity.parrot.imitate.spider"),
    // rust: (Species::Creaking, "entity.parrot.imitate.creaking"),
    // rust: (Species::Creeper, "entity.parrot.imitate.creeper"),
    // rust: (Species::Drowned, "entity.parrot.imitate.drowned"),
    // rust: (
    // rust: Species::ElderGuardian,
    // rust: "entity.parrot.imitate.elder_guardian",
    // rust: ),
    // rust: (Species::Endermite, "entity.parrot.imitate.endermite"),
    // rust: (Species::Evoker, "entity.parrot.imitate.evoker"),
    // rust: (Species::Ghast, "entity.parrot.imitate.ghast"),
    // rust: (Species::HappyGhast, ""),
    // rust: (Species::Guardian, "entity.parrot.imitate.guardian"),
    // rust: (Species::Hoglin, "entity.parrot.imitate.hoglin"),
    // rust: (Species::Husk, "entity.parrot.imitate.husk"),
    // rust: (Species::Illusioner, "entity.parrot.imitate.illusioner"),
    // rust: (Species::MagmaCube, "entity.parrot.imitate.magma_cube"),
    // rust: (Species::Parched, "entity.parrot.imitate.parched"),
    // rust: (Species::Phantom, "entity.parrot.imitate.phantom"),
    // rust: (Species::Piglin, "entity.parrot.imitate.piglin"),
    // rust: (Species::PiglinBrute, "entity.parrot.imitate.piglin_brute"),
    // rust: (Species::Pillager, "entity.parrot.imitate.pillager"),
    // rust: (Species::Ravager, "entity.parrot.imitate.ravager"),
    // rust: (Species::Shulker, "entity.parrot.imitate.shulker"),
    // rust: (Species::Silverfish, "entity.parrot.imitate.silverfish"),
    // rust: (Species::Skeleton, "entity.parrot.imitate.skeleton"),
    // rust: (Species::Slime, "entity.parrot.imitate.slime"),
    // rust: (Species::Spider, "entity.parrot.imitate.spider"),
    // rust: (Species::Stray, "entity.parrot.imitate.stray"),
    // rust: (Species::Vex, "entity.parrot.imitate.vex"),
    // rust: (Species::Vindicator, "entity.parrot.imitate.vindicator"),
    // rust: (Species::Warden, "entity.parrot.imitate.warden"),
    // rust: (Species::Witch, "entity.parrot.imitate.witch"),
    // rust: (Species::Wither, "entity.parrot.imitate.wither"),
    // rust: (
    // rust: Species::WitherSkeleton,
    // rust: "entity.parrot.imitate.wither_skeleton",
    // rust: ),
    // rust: (Species::Zoglin, "entity.parrot.imitate.zoglin"),
    // rust: (Species::Zombie, "entity.parrot.imitate.zombie"),
    // rust: (Species::ZombieHorse, "entity.parrot.imitate.zombie_horse"),
    // rust: (
    // rust: Species::ZombieNautilus,
    // rust: "entity.parrot.imitate.zombie_nautilus",
    // rust: ),
    // rust: (
    // rust: Species::ZombieVillager,
    // rust: "entity.parrot.imitate.zombie_villager",
    // rust: ),
    // rust: ];

pub fn imitation(species: Species) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: IMITATIONS.iter().find(|i| i.0 == species).map(|i| i.1)
}

/// `Parrot.getPitch`.
pub fn pitch(random: *mut LegacyRandom) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (random.next_float() - random.next_float()) * 0.2 + 1.0
}

/// The start of `Parrot.aiStep`: a jukebox that is gone or farther than
/// 3.46 blocks stops the dance, and one tick in 400 the parrot imitates a
/// mob nearby.
    // rust: pub fn ai_step(
    // rust: m: &mut Mob,
    // rust: w: &MobWorld,
    // rust: level_random: &mut LegacyRandom,
    // rust: events: &mut Vec<MobEvent>,
    // rust: ) {
    // rust: if let Some(at) = m.extra.party_jukebox {
    // rust: let d = |i: usize, v: f64| f64::from(at[i]) + 0.5 - v;
    // rust: let (x, y, z) = (d(0, m.position.x), d(1, m.position.y), d(2, m.position.z));
    // rust: let jukebox = &*w.facts.get(w.world.block(at[0], at[1], at[2])).name == "minecraft:jukebox";
    // rust: if x * x + y * y + z * z >= 3.46 * 3.46 || !jukebox {
    // rust: m.extra.party_jukebox = None;
}
}
    // rust: if level_random.next_int_bound(400).unwrap_or(1) == 0 {
    // rust: imitate_nearby_mobs(m, w, level_random, events);
}
}

/// `Parrot.imitateNearbyMobs`: half the time, a random imitable mob within 20
/// blocks is heard through the parrot's own mouth.
    // rust: fn imitate_nearby_mobs(
    // rust: m: &Mob,
    // rust: w: &MobWorld,
    // rust: random: &mut LegacyRandom,
    // rust: events: &mut Vec<MobEvent>,
    // rust: ) {
    // rust: if !m.alive() || m.silent || random.next_int_bound(2).unwrap_or(1) != 0 {
    // rust: return;
}
    // rust: let area = m.bounds().inflate(Vec3::new(20.0, 20.0, 20.0));
    // rust: let mobs: Vec<_> = w
    // rust: .others
    // rust: .iter()
    // rust: .filter(|s| s.alive && imitation(s.species).is_some() && s.bounds.intersects(area))
    // rust: .collect();
    // rust: if mobs.is_empty() {
    // rust: return;
}
    // rust: let mob = mobs[random.next_int_bound(mobs.len() as i32).unwrap_or(0) as usize];
    // rust: if mob.silent {
    // rust: return;
}
    // rust: if let Some(sound) = imitation(mob.species).filter(|s| !s.is_empty()) {
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: events.push(MobEvent::Sound(sound, at, 0.7, pitch(random)));
}
}

/// The sound a parrot on a player's shoulder makes (`ServerPlayer.
/// playShoulderEntityAmbientSound` after its one-in-200 draw): the voice of a
/// random imitable mob in `nearby` (`Parrot.imitateNearbyMobs`, half the time,
/// those with a `silent` flag excluded after being picked), else its own
/// ambient sound or a rare imitation (`Parrot.getAmbient`). `random` is drawn
/// from in vanilla's order. Returns the sound, its volume and its pitch; the
/// happy ghast's imitation is silent (`""`).
    // rust: pub fn shoulder_sound(
    // rust: random: &mut LegacyRandom,
    // rust: player_alive: bool,
    // rust: player_silent: bool,
    // rust: peaceful: bool,
    // rust: nearby: &[(Species, bool)],
    // rust: ) -> Option<(&'static str, f32, f32)> {
    // rust: if player_alive && !player_silent && random.next_int_bound(2).unwrap_or(1) == 0 {
    // rust: let candidates: Vec<_> = nearby
    // rust: .iter()
    // rust: .filter(|(s, _)| imitation(*s).is_some())
    // rust: .collect();
    // rust: if !candidates.is_empty() {
    // rust: let (species, silent) =
    // rust: *candidates[random.next_int_bound(candidates.len() as i32).unwrap_or(0) as usize];
    // rust: if !silent {
    // rust: let sound = imitation(species).filter(|s| !s.is_empty())?;
    // rust: return Some((sound, 0.7, pitch(random)));
}
}
}
    // rust: let sound = if !peaceful && random.next_int_bound(1000).unwrap_or(1) == 0 {
    // rust: IMITATIONS[random.next_int_bound(IMITATIONS.len() as i32).unwrap_or(0) as usize].1
    // rust: } else {
    // rust: "entity.parrot.ambient"
}
    // rust: Some((sound, 1.0, pitch(random))).filter(|s| !s.0.is_empty())
}

/// `Parrot.getAmbient`: now and then (outside peaceful) the voice of a random
/// imitable mob instead of the parrot's own.
pub fn ambient(m: *mut Mob, w: *MobWorld) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if w.difficulty.effective > 0.0 && m.random.next_int_bound(1000).unwrap_or(1) == 0 {
    // rust: let i = m
    // rust: .random
    // rust: .next_int_bound(IMITATIONS.len() as i32)
    // rust: .unwrap_or(0);
    // rust: return IMITATIONS[i as usize].1;
}
    // rust: "entity.parrot.ambient"
}

/// `Parrot(EntityType, Level)` with `createNavigation` and `registerGoals`:
/// a `FlyingMoveControl(10, false)` that lets gravity back on when it has
/// nowhere to go, and a `FlyingPathNavigation` that floats and opens no doors.
pub fn register(m: *mut Mob) void {
}
    // rust: m.ai.mov.kind = MoveKind::Flying {
    // rust: max_turn: 10.0,
    // rust: hovers: false,
}
    // rust: m.ai.nav.kind = NavKind::Flying;
    // rust: m.ai.nav.can_open_doors = false;
    // rust: m.ai.nav.can_float = true;
    // rust: m.set_malus(PathType::FireInNeighbor, -1.0);
    // rust: m.set_malus(PathType::Fire, -1.0);
    // rust: m.set_malus(PathType::Cocoa, -1.0);
    // rust: super::tame::register_parrot(m);
}

/// The wings of `Parrot.calculateFlapping`: `flapSpeed` rises in the air and
/// falls on the ground or a shoulder, `flapping` restarts at 1 in the air and
/// decays, and `flap` turns by it. A client runs it for the parrots it only
/// displays.
pub fn flap(m: *mut Mob) void {
}
    // rust: let grounded = m.on_ground || m.extra.mount.is_some();
    // rust: let a = &mut m.anim;
    // rust: a.flap_o = a.flap;
    // rust: a.flap_speed_o = a.flap_speed;
    // rust: a.flap_speed = (a.flap_speed + if grounded { -1.0 } else { 4.0 } * 0.3).clamp(0.0, 1.0);
    // rust: if !m.on_ground && a.flapping < 1.0 {
    // rust: a.flapping = 1.0;
}
    // rust: a.flapping *= 0.9;
    // rust: a.flap += a.flapping * 2.0;
}

/// `Parrot.calculateFlapping`, after the rest of `aiStep`: the wings, and a
/// parrot falling through the air glides down at 0.6 of the speed.
pub fn calculate_flapping(m: *mut Mob) void {
}
    // rust: flap(m);
    // rust: if !m.on_ground && m.velocity.y < 0.0 {
    // rust: m.velocity.y *= 0.6;
}
}

/// `Parrot.isFlapping` and `Parrot.onFlap`: a wing beat each half
/// `flapSpeed` flown. The caller emits the movement game event on a flap.
pub fn process_flapping(m: *mut Mob, events: *mut std.ArrayList(MobEvent)) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if m.ai.steps.fly_dist > m.ai.steps.next_flap {
    // rust: if !m.silent {
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: events.push(MobEvent::Sound("entity.parrot.fly", at, 0.15, 1.0));
}
    // rust: m.ai.steps.next_flap = m.ai.steps.fly_dist + m.anim.flap_speed / 2.0;
    // rust: true
    // rust: } else {
    // rust: false
}
}

/// `Parrot.ParrotWanderGoal.getPosition`: out of water onto land; otherwise
/// (all but one time in a thousand) the top of a tree nearby; failing both,
/// `WaterAvoidingRandomFlyingGoal.getPosition`.
pub fn wander_pos(m: *mut Mob, w: *MobWorld) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut pos = None;
    // rust: if m.fluids.in_water {
    // rust: pos = m.land_random_pos(w, 15, 15);
}
    // WaterAvoidingRandomStrollGoal.probability.
    // rust: if m.random.next_float() >= 0.001 {
    // rust: pos = tree_pos(m, w);
}
    // rust: pos.or_else(|| m.flying_stroll_pos(w))
}

/// `Parrot.ParrotWanderGoal.getTreePos`: within 3 blocks across and 6 up or
/// down (x fastest, then y, then z, as `BlockPos.betweenClosed` walks), the
/// first empty block with an empty one above over leaves or a log.
pub fn tree_pos(m: *Mob, w: *MobWorld) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (x, y, z) = (m.position.x, m.position.y, m.position.z);
    // rust: let at = [x.floor() as i32, y.floor() as i32, z.floor() as i32];
    // rust: let air = |p: [i32; 3]| {
    // rust: matches!(
    // rust: w.block_name(p[0], p[1], p[2]),
    // rust: "minecraft:air" | "minecraft:cave_air" | "minecraft:void_air"
    // rust: )
}
    // rust: for bz in (z - 3.0).floor() as i32..=(z + 3.0).floor() as i32 {
    // rust: for by in (y - 6.0).floor() as i32..=(y + 6.0).floor() as i32 {
    // rust: for bx in (x - 3.0).floor() as i32..=(x + 3.0).floor() as i32 {
    // rust: let p = [bx, by, bz];
    // rust: if p == at {
    // rust: continue;
}
    // rust: let below = w.block_name(bx, by - 1, bz);
    // rust: let tree = below.ends_with("_leaves") || w.has_tag("minecraft:logs", below);
    // rust: if tree && air(p) && air([bx, by + 1, bz]) {
    // rust: return Some([f64::from(bx) + 0.5, f64::from(by), f64::from(bz) + 0.5]);
}
}
}
}
    // rust: None
}

    // rust: mod tests {
//     use super::*;
//     use crate::mobs::sensor_scan_tests::kind;
//     use std::sync::Arc;

pub fn parrot() M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut k = (*kind()).clone();
    // rust: k.id = "minecraft:parrot".into();
    // rust: k.species = Species::Parrot;
    // rust: k.flags.omnidirectional = true;
    // rust: Mob::new(1, Arc::new(k), Vec3::ZERO, 0.0)
}

    /// `Parrot()`: `FlyingMoveControl(this, 10, false)`, the path maluses,
    /// and `createNavigation`'s `FlyingPathNavigation` (no doors, floats).
pub fn a_parrot_flies_by_its_navigation_and_move_control() void {
}
    // rust: let m = parrot();
    // rust: assert_eq!(
    // rust: m.ai.mov.kind,
    // rust: MoveKind::Flying {
    // rust: max_turn: 10.0,
    // rust: hovers: false
}
    // rust: );
    // rust: assert_eq!(m.ai.nav.kind, NavKind::Flying);
    // rust: assert!(!m.ai.nav.can_open_doors);
    // rust: assert!(m.ai.nav.can_float);
    // rust: for t in [PathType::FireInNeighbor, PathType::Fire, PathType::Cocoa] {
    // rust: assert_eq!(m.malus(t), -1.0);
}
    // rust: assert!(m.ai.goals.has("ParrotWander"));
}

    /// `Parrot.getVoicePitch` is `getPitch(random)`, the plain 1.0 ± 0.2, and
    /// `getPitch` takes no age into account: a baby parrot does not get the
    /// 1.5 that `LivingEntity.getVoicePitch` raises every other baby's voice
    /// by. A baby chicken is the control.
pub fn a_baby_parrot_keeps_the_plain_voice_pitch() void {
}
    // rust: let mut parrot = parrot();
    // rust: parrot.extra.age = -24_000;
    // rust: assert!(parrot.is_baby());
    // rust: let mut baby = parrot.clone();
    // rust: let pitches: Vec<f32> = (0..64).map(|_| baby.voice_pitch()).collect();
    // rust: assert!(
    // rust: pitches.iter().all(|p| (0.8..=1.2).contains(p)),
    // rust: "{pitches:?}"
    // rust: );
        // It is not a constant: the two draws move it around 1.0.
    // rust: assert!(pitches.iter().any(|&p| p != pitches[0]));
    // rust: assert!((pitches.iter().sum::<f32>() / pitches.len() as f32 - 1.0).abs() < 0.1);

    // rust: let mut k = (*kind()).clone();
    // rust: k.id = "minecraft:chicken".into();
    // rust: k.species = Species::Chicken;
    // rust: let mut chicken = Mob::new(1, Arc::new(k), Vec3::ZERO, 0.0);
    // rust: chicken.extra.age = -24_000;
    // rust: let raised: Vec<f32> = (0..64).map(|_| chicken.voice_pitch()).collect();
    // rust: assert!(raised.iter().all(|p| (1.3..=1.7).contains(p)), "{raised:?}");
}

    /// `Parrot.calculateFlapping`: in the air the wings beat and a fall is
    /// slowed to 0.6; on the ground or a shoulder they fold.
pub fn a_falling_parrot_flaps_and_glides() void {
}
    // rust: let mut m = parrot();
    // rust: m.on_ground = false;
    // rust: m.velocity = Vec3::new(0.1, -0.5, 0.0);
    // rust: calculate_flapping(&mut m);
    // rust: assert!((m.velocity.y + 0.3).abs() < 1.0e-12);
    // rust: assert_eq!(m.velocity.x, 0.1);
    // rust: assert_eq!(m.anim.flap_speed, 1.0);
    // rust: assert_eq!(m.anim.flapping, 0.9);
    // rust: assert_eq!(m.anim.flap, 1.8);
        // Rising is not slowed.
    // rust: m.velocity = Vec3::new(0.0, 0.2, 0.0);
    // rust: calculate_flapping(&mut m);
    // rust: assert_eq!(m.velocity.y, 0.2);
    // rust: assert_eq!(m.anim.flap_o, 1.8);
        // On a shoulder (a passenger), flapSpeed falls by 0.3 a tick.
    // rust: m.extra.mount = Some(7);
    // rust: calculate_flapping(&mut m);
    // rust: assert!((m.anim.flap_speed - 0.7).abs() < 1.0e-6);
    // rust: m.extra.mount = None;
    // rust: m.on_ground = true;
    // rust: m.velocity = Vec3::new(0.0, -0.0784, 0.0);
    // rust: calculate_flapping(&mut m);
    // rust: assert!((m.anim.flap_speed - 0.4).abs() < 1.0e-6);
    // rust: assert_eq!(m.velocity.y, -0.0784, "no glide on the ground");
}

    /// `Parrot.onFlap`: a wing beat (`entity.parrot.fly`, 0.15) each half
    /// `flapSpeed` flown.
pub fn it_beats_its_wings_as_it_flies() void {
}
    // rust: let mut m = parrot();
    // rust: m.anim.flap_speed = 1.0;
    // rust: let mut events = Vec::new();
    // rust: m.ai.steps.fly_dist = 0.5;
    // rust: assert!(!process_flapping(&mut m, &mut events));
    // rust: assert!(events.is_empty(), "nextFlap starts at 1");
    // rust: m.ai.steps.fly_dist = 1.0;
    // rust: assert!(!process_flapping(&mut m, &mut events), "strict threshold");
    // rust: m.ai.steps.fly_dist = 1.2;
    // rust: assert!(process_flapping(&mut m, &mut events));
    // rust: assert!(matches!(
    // rust: events.as_slice(),
    // rust: [MobEvent::Sound("entity.parrot.fly", _, v, _)] if *v == 0.15
    // rust: ));
    // rust: assert!((m.ai.steps.next_flap - 1.7).abs() < 1.0e-6);
    // rust: events.clear();
    // rust: assert!(
    // rust: !process_flapping(&mut m, &mut events),
    // rust: "no second flap without moving"
    // rust: );
    // rust: m.silent = true;
    // rust: m.ai.steps.fly_dist = 1.8;
    // rust: assert!(process_flapping(&mut m, &mut events), "silent still flaps");
    // rust: assert!(events.is_empty());
    // rust: assert!((m.ai.steps.next_flap - 2.3).abs() < 1.0e-6);
}

    /// `ServerPlayer.playShoulderEntityAmbientSound`: with a mob to imitate
    /// and a coin flip won, the mob's voice at 0.7; otherwise the parrot's own.
pub fn a_shoulder_parrot_imitates_or_chirps() void {
}
    // rust: let nearby = [(Species::Zombie, false)];
    // rust: let mut imitated = 0;
    // rust: let mut chirped = 0;
    // rust: for n in 0..64_i64 {
    // rust: let seed = n.wrapping_mul(0x9E37_79B9_7F4A_7C15_u64 as i64);
    // rust: let mut probe = LegacyRandom::new(seed);
    // rust: let flip = probe.next_int_bound(2).unwrap();
    // rust: let mut random = LegacyRandom::new(seed);
    // rust: let (sound, volume, _) =
    // rust: shoulder_sound(&mut random, true, false, true, &nearby).unwrap();
    // rust: if flip == 0 {
    // rust: assert_eq!((sound, volume), ("entity.parrot.imitate.zombie", 0.7));
    // rust: imitated += 1;
    // rust: } else {
    // rust: assert_eq!((sound, volume), ("entity.parrot.ambient", 1.0));
    // rust: chirped += 1;
}
}
    // rust: assert!(imitated > 0 && chirped > 0);
        // A silent player (or a dead one) imitates nothing and only chirps.
    // rust: let mut random = LegacyRandom::new(1);
    // rust: let (sound, volume, _) = shoulder_sound(&mut random, true, true, true, &nearby).unwrap();
    // rust: assert_eq!((sound, volume), ("entity.parrot.ambient", 1.0));
        // The happy ghast's imitation is silent.
    // rust: let ghast = [(Species::HappyGhast, false)];
    // rust: let silent = (0..64_i64).filter(|&n| {
    // rust: let seed = n.wrapping_mul(0x9E37_79B9_7F4A_7C15_u64 as i64);
    // rust: let mut r = LegacyRandom::new(seed);
    // rust: shoulder_sound(&mut r, true, false, true, &ghast).is_none()
    // rust: });
    // rust: assert!(silent.count() > 0);
}
}
