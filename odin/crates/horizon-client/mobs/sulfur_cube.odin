//! Transpiled from Horizon Rust crate
package horizon_client_sulfur_cube

import "core:fmt"
import "core:mem"
import "core:math"

// Sulfur cubes (`SulfurCube` on `AbstractCubeMob`): hopping like a slime
// but harmless, size 1 babies growing into size 2 adults, swallowing a
// block (by hand, from the ground or a dispenser) that stops it in place
// and gives it the block's archetype (`SulfurCubeArchetype`: buoyancy,
// knockback, sounds, contact damage, a TNT fuse), shearing the block out,
// buckets, and the outer/inner models and their render scale.
// use super::{
    // rust: Damage, DamageKind, Mob, MobEvent, MobWorld,
    // rust: control::MoveKind,
    // rust: goals::{Cx, Goal, JUMP, LOOK, MOVE, goal_clone},
}
// use horizon_core::{geometry::Vec3, random::RandomSource};
// use std::cell::Cell;
// use std::collections::{HashMap, HashSet};
// use std::sync::OnceLock;

// Sulfur cube state (on top of `cube`'s `size`, `counter` jump delay,
// `flag` aggressive, `flag2` was on ground, `vector[0]` direction):
// `head` the swallowed block, `counter2` the fuse plus one (0 unprimed),
// `ints[3]` the pickup timer, `scratch[1]` the sounds pending (1 a fuse just
// lit, 2 a hit),
// `scratch[2]` the push sound cooldown, `scratch[3]` from a bucket,
// `point` the item it is after.
PICKUP_TIMER :: 100

// One `SulfurCubeArchetype` (the parts Horizon's physics can use).
Archetype :: struct {
    name: ^'static str,
    buoyant: bool,
    // `explosion`: fuse ticks, power, causes fire.
    explosion: Option<(i32,
    // `contact_damage` amount (`sulfur_cube_hot`).
    contact_damage: Maybe(f32),
    // The knockback resistance modifier (the attribute range is -2..1; negative values add knockback).
    knockback_resistance: f64,
    // `Attributes.BOUNCINESS` (the modifier added to a base of 0).
    bounciness: f32,
    // `Attributes.FRICTION_MODIFIER` and `AIR_DRAG_MODIFIER` (base 1 times
    // the archetype's factor).
    friction_modifier: f32,
    air_drag_modifier: f32,
    horizontal_power: f32,
    vertical_power: f32,
    hit_sound: ^'static str,
    push_sound: ^'static str,
    push_cooldown: f32,
    push_threshold: f32,
}
    // rust: macro_rules! arch {
    // rust: ($n:literal, $b:expr, $e:expr, $c:expr, $k:expr, $phys:expr, $h:expr, $v:expr, $cd:expr, $t:expr) => {
    // rust: Archetype {
    // rust: name: $n,
    // rust: buoyant: $b,
    // rust: explosion: $e,
    // rust: contact_damage: $c,
    // rust: knockback_resistance: $k,
    // rust: bounciness: $phys.0,
    // rust: friction_modifier: $phys.1,
    // rust: air_drag_modifier: $phys.2,
    // rust: horizontal_power: $h,
    // rust: vertical_power: $v,
    // rust: hit_sound: concat!("entity.sulfur_cube.", $n, ".hit"),
    // rust: push_sound: concat!("entity.sulfur_cube.", $n, ".push"),
    // rust: push_cooldown: $cd,
    // rust: push_threshold: $t,
}
}
}
// `data/minecraft/sulfur_cube_archetype/*.json`.
    // rust: pub const ARCHETYPES: [Archetype; 12] = [
    // rust: arch!(
    // rust: "bouncy",
    // rust: true,
    // rust: None,
    // rust: None,
    // rust: -2.0,
    // rust: (0.9, 0.3, 0.01),
    // rust: 0.4125,
    // rust: 0.105,
    // rust: 0.7,
    // rust: 0.3
    // rust: ),
    // rust: arch!(
    // rust: "explosive",
    // rust: true,
    // rust: Some((120, 3.0, false)),
    // rust: None,
    // rust: -1.0,
    // rust: (0.5, 0.3, 0.3),
    // rust: 0.4125,
    // rust: 0.09,
    // rust: 0.7,
    // rust: 0.1
    // rust: ),
    // rust: arch!(
    // rust: "fast_flat",
    // rust: false,
    // rust: None,
    // rust: None,
    // rust: -1.0,
    // rust: (0.5, 0.2, 0.01),
    // rust: 0.9125,
    // rust: 0.09,
    // rust: 0.9,
    // rust: 0.03
    // rust: ),
    // rust: arch!(
    // rust: "fast_sliding",
    // rust: false,
    // rust: None,
    // rust: None,
    // rust: 0.5,
    // rust: (0.1, 0.05, 0.01),
    // rust: 0.6625,
    // rust: 0.09,
    // rust: 1.0,
    // rust: 0.05
    // rust: ),
    // rust: arch!(
    // rust: "high_resistance",
    // rust: false,
    // rust: None,
    // rust: None,
    // rust: 0.7,
    // rust: (0.2, 1.0, 0.01),
    // rust: 0.4125,
    // rust: 0.09,
    // rust: 0.7,
    // rust: 0.03
    // rust: ),
    // rust: arch!(
    // rust: "hot",
    // rust: true,
    // rust: None,
    // rust: Some(1.0),
    // rust: -1.0,
    // rust: (0.5, 0.3, 0.1),
    // rust: 0.4125,
    // rust: 0.09,
    // rust: 0.7,
    // rust: 0.2
    // rust: ),
    // rust: arch!(
    // rust: "light",
    // rust: true,
    // rust: None,
    // rust: None,
    // rust: -1.0,
    // rust: (1.0, 0.3, 1.8),
    // rust: 0.4125,
    // rust: 0.18,
    // rust: 0.7,
    // rust: 0.2
    // rust: ),
    // rust: arch!(
    // rust: "regular",
    // rust: true,
    // rust: None,
    // rust: None,
    // rust: -1.0,
    // rust: (0.5, 0.3, 0.1),
    // rust: 0.4125,
    // rust: 0.09,
    // rust: 0.5,
    // rust: 0.2
    // rust: ),
    // rust: arch!(
    // rust: "slow_bouncy",
    // rust: false,
    // rust: None,
    // rust: None,
    // rust: 0.4,
    // rust: (0.6, 0.3, 0.05),
    // rust: 0.4125,
    // rust: 0.24,
    // rust: 0.5,
    // rust: 0.05
    // rust: ),
    // rust: arch!(
    // rust: "slow_flat",
    // rust: false,
    // rust: None,
    // rust: None,
    // rust: 0.5,
    // rust: (0.4, 0.4, 0.1),
    // rust: 0.4125,
    // rust: 0.105,
    // rust: 0.9,
    // rust: 0.03
    // rust: ),
    // rust: arch!(
    // rust: "slow_sliding",
    // rust: false,
    // rust: None,
    // rust: None,
    // rust: 0.8,
    // rust: (0.1, 0.05, 0.01),
    // rust: 0.4125,
    // rust: 0.09,
    // rust: 1.0,
    // rust: 0.02
    // rust: ),
    // rust: arch!(
    // rust: "sticky",
    // rust: false,
    // rust: None,
    // rust: None,
    // rust: -2.0,
    // rust: (0.0, 2.0, 0.01),
    // rust: 0.4125,
    // rust: 0.09,
    // rust: 0.5,
    // rust: 0.05
    // rust: ),
    // rust: ];
// `SulfurCubeArchetype.DEFAULT_*`: no block swallowed.
DEFAULT_PUSH :: ("entity.sulfur_cube.regular.push", 0.5, 0.2)
ITEMS :: OnceLock::new()
// The items of each archetype's `#sulfur_cube_archetype/<name>` tag.
load_archetype_items :: proc(tags: ^HashMap<string) {
}
    // rust: let _ = ITEMS.set(
    // rust: ARCHETYPES
    // rust: .iter()
    // rust: .map(|a| {
    // rust: tags.get(&format!("minecraft:sulfur_cube_archetype/{}", a.name))
    // rust: .cloned()
    // rust: .unwrap_or_default()
    // rust: })
    // rust: .collect(),
    // rust: );
}
// These unit fixtures share a process-wide item lookup. Whichever initializes
// it first must include both the explosive and hot bodies exercised below.
test_archetype_items :: proc() {
}
    // rust: load_archetype_items(&HashMap::from([
    // rust: (
    // rust: "minecraft:sulfur_cube_archetype/explosive".into(),
    // rust: HashSet::from(["minecraft:tnt".into()]),
    // rust: ),
    // rust: (
    // rust: "minecraft:sulfur_cube_archetype/hot".into(),
    // rust: HashSet::from(["minecraft:magma_block".into()]),
    // rust: ),
    // rust: ]));
}
// `matchingArchetypes`: the last one wins (as `collectEquipmentChanges`
// leaves it), buoyancy if any.
archetype_of :: proc(item: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let items = ITEMS.get()?;
    // rust: ARCHETYPES
    // rust: .iter()
    // rust: .zip(items)
    // rust: .rev()
    // rust: .find(|(_, set)| set.contains(item))
    // rust: .map(|(a, _)| a)
}
// `isSwallowableItem`: the `sulfur_cube_swallowable` tag.
swallowable :: proc(m: ^Mob, item: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.kind.tempt.iter().any(|t| t == item)
}
has_body :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.body.is_some()
}

    // rust: mod knockback_sync_tests {
//     use super::*;
//     use crate::mobs::{Mob, Species};
//     use std::sync::Arc;

    // `SulfurCube.knockback` sets `needsSync`, as `LivingEntity.knockback`
    // does, so a guest sees a cube with a block knocked about at once.
a_knocked_cube_with_a_block_syncs_at_once :: proc() {
}
    // rust: test_archetype_items();
    // rust: let mut kind = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: kind.species = Species::SulfurCube;
    // rust: let mut m = Mob::new(1, Arc::new(kind), Vec3::ZERO, 0.0);
    // rust: m.extra.body = Some("minecraft:tnt".into());
    // rust: assert!(!m.needs_sync);
    // rust: m.damage(5.0, Damage::player([2.0, 0.0, 0.0]));
    // rust: assert!(m.velocity.x < 0.0, "velocity {:?}", m.velocity);
    // rust: assert!(m.needs_sync);
}
}
archetype :: proc(m: ^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.body.as_deref().and_then(archetype_of)
}
// The archetype whose bounciness, friction and air drag attributes a
// sulfur cube's physics use (no other mob has those modifiers).
physics :: proc(m: ^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if m.species() == super::Species::SulfurCube {
    // rust: archetype(m)
    // rust: } else {
    // rust: None
}
}
fuse :: proc(m: ^Mob) -> i {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.counter2 - 1
}
primed :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: fuse(m) >= 0
}
// `hurtServer`'s priming by a hit whose direct entity is a burning
// `AbstractArrow` (an arrow or a trident): a cube with a block that can
// explode lights its fuse, the long one.
burning_arrow_hit :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: has_body(m) && can_explode(m) && prime(m, false)
}

    // rust: mod burning_arrow_tests {
//     use super::*;
//     use crate::mobs::{Mob, Species};
//     use std::sync::Arc;

cube :: proc(head: Maybe(string)) -> M {
    // Ported from Horizon
    return {}
}
    // rust: test_archetype_items();
    // rust: let mut kind = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: kind.species = Species::SulfurCube;
    // rust: let mut m = Mob::new(1, Arc::new(kind), Vec3::ZERO, 0.0);
    // rust: m.extra.body = head.map(Into::into);
    // rust: m
}

a_burning_arrow_lights_the_long_fuse :: proc() {
}
    // rust: let mut m = cube(Some("minecraft:tnt"));
    // rust: assert!(burning_arrow_hit(&mut m));
    // rust: let (fuse_ticks, _, _) = archetype(&m).and_then(|a| a.explosion).unwrap();
    // rust: assert_eq!(fuse(&m), fuse_ticks);
    // rust: assert!(m.invulnerable_flag);
        // lit once: a second arrow leaves the fuse alone.
    // rust: m.extra.counter2 -= 5;
    // rust: assert!(!burning_arrow_hit(&mut m));
    // rust: assert_eq!(fuse(&m), fuse_ticks - 5);
}

a_burning_arrow_lights_only_an_explosive_block :: proc() {
}
    // rust: for head in [None, Some("minecraft:dirt")] {
    // rust: let mut m = cube(head);
    // rust: assert!(!burning_arrow_hit(&mut m), "{head:?}");
    // rust: assert!(!primed(&m) && !m.invulnerable_flag, "{head:?}");
}
}

    // the arrow's knock, then the fuse lit: the next tick plays
    // `entity.tnt.primed`, then the archetype's hit sound.
a_knock_and_a_lit_fuse_both_sound :: proc() {
}
    // rust: let mut events = Vec::new();
    // rust: let ran = crate::mobs::world::with_test_world(&[], |w, _| {
    // rust: let mut m = cube(Some("minecraft:tnt"));
    // rust: m.damage(5.0, Damage::player([2.0, 0.0, 0.0]));
    // rust: assert!(burning_arrow_hit(&mut m));
    // rust: ai_step(&mut m, w, &mut events);
    // rust: });
    // rust: if !ran {
    // rust: return; // needs the prepared 26.3 data
}
    // rust: let sounds: Vec<&str> = events
    // rust: .iter()
    // rust: .filter_map(|e| match e {
    // rust: MobEvent::Sound(id, ..) => Some(*id),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: let hit = archetype_of("minecraft:tnt").unwrap().hit_sound;
    // rust: assert_eq!(sounds, ["entity.tnt.primed", hit]);
}
}
// Client copy of `tickFuse`: count the fuse down for the renderer. The
// server alone explodes (`tick_fuse`); a guest never fires `Explode` here.
client_tick :: proc(m: ^Mob) {
}
    // rust: if m.extra.counter2 > 1 {
    // rust: m.extra.counter2 -= 1;
}
}
can_explode :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: archetype(m).is_some_and(|a| a.explosion.is_some()) && m.alive() && !primed(m)
}

    // rust: mod immune_tests {
//     use super::*;
//     use crate::mobs::{Mob, Species};
//     use std::sync::Arc;

cube :: proc(head: Maybe(string)) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: kind.species = Species::SulfurCube;
    // rust: let mut m = Mob::new(1, Arc::new(kind), Vec3::ZERO, 0.0);
    // rust: m.extra.body = head.map(Into::into);
    // rust: m
}

    // `#sulfur_cube_with_block_immune_to` has these too: a cube with a block
    // loses no health to any of them (and `hurtServer` still answers true), a cube without one does.
a_cube_with_a_block_shrugs_off_the_whole_tag :: proc() {
}
    // rust: for kind in [
    // rust: DamageKind::FallingAnvil,
    // rust: DamageKind::FallingBlock,
    // rust: DamageKind::FallingStalactite,
    // rust: DamageKind::DryOut,
    // rust: DamageKind::Spit,
    // rust: DamageKind::Stalagmite,
    // rust: DamageKind::SulfurCubeHot,
    // rust: DamageKind::WindCharge,
    // rust: ] {
    // rust: let mut m = cube(Some("minecraft:dirt"));
    // rust: let health = m.health;
            // `SulfurCube.hurtServer` returns true for these, though no health is lost.
    // rust: assert!(m.damage(1.0, Damage::of(kind)), "{kind:?}");
    // rust: assert_eq!(m.health, health, "{kind:?}");
    // rust: let mut m = cube(None);
    // rust: assert!(m.damage(1.0, Damage::of(kind)), "{kind:?}");
    // rust: assert_eq!(m.health, health - 1.0, "{kind:?}");
}
}

    // `SulfurCube.knockback` with `comesFromEffect`: a sprint hit's extra push (power 0.5) is
    // `0.5 * 0.25` of the plain push, a Knockback II hit's (power 1.0) a quarter of it.
an_effect_push_is_a_fraction_of_the_blows_own :: proc() {
}
    // rust: let push = |scale: f32| {
    // rust: launch(
    // rust: (1.0, 0.5),
    // rust: 0.0,
    // rust: 4.0,
    // rust: (1.0, 0.0),
    // rust: [-2.0, 0.0, 0.0],
    // rust: [0.0, 0.0, 0.0],
    // rust: [0.0, 0.5, 0.0],
    // rust: 1.0,
    // rust: None,
    // rust: scale,
    // rust: )
}
    // rust: let plain = push(1.0);
    // rust: assert!(plain[0].abs() > 0.01, "the plain push moves it: {plain:?}");
    // rust: for (power, scale) in [(0.5_f32, 0.125_f64), (1.0, 0.25)] {
    // rust: let extra = push(power * 0.25);
    // rust: for axis in 0..3 {
    // rust: assert!(
    // rust: (extra[axis] - plain[axis] * scale).abs() < 1.0e-6,
    // rust: "{power}: {extra:?} against {plain:?}"
    // rust: );
}
}
}

    // outside the tag (`magic`) a cube with a block is hurt.
a_cube_with_a_block_takes_magic :: proc() {
}
    // rust: let mut m = cube(Some("minecraft:dirt"));
    // rust: let health = m.health;
    // rust: assert!(m.damage(1.0, Damage::of(DamageKind::Magic)));
    // rust: assert_eq!(m.health, health - 1.0);
}
}
register :: proc(m: ^Mob) {
}
//     use super::cube;
    // rust: m.ai.goals.add(1, cube::CubeFloat);
    // rust: m.ai.goals.add(2, SulfurTempt { player: None });
    // rust: m.ai.goals.add(3, SearchForItems);
    // rust: m.ai.goals.add(4, cube::CubeRandomDirection::default());
    // rust: m.ai.goals.add(5, cube::CubeKeepJumping);
    // rust: m.ai.mov.kind = MoveKind::Custom;
    // rust: m.ai.nav.can_float = true;
    // rust: m.extra.vector[0] = f64::from(180.0 * m.yaw / std::f32::consts::PI);
    // Created at size 1 (finalizeSpawn sizes it); not made a baby here.
    // rust: set_size(m, 1, false);
    // rust: m.health = m.attrs.max_health;
}
// `setSize`: health 4 per size, speed 0.2 + 0.1 * size; size 1 makes an
// adult a baby.
set_size :: proc(m: ^Mob, size: i32, update_health: bool) {
}
    // rust: let size = size.clamp(1, 127);
    // rust: m.extra.size = size;
    // rust: m.attrs.max_health = (4 * size) as f32;
    // rust: m.attrs.speed = f64::from(0.2f32 + 0.1f32 * size as f32);
    // rust: if update_health {
    // rust: m.health = m.attrs.max_health;
    // rust: if size == 1 && !m.is_baby() {
    // rust: m.extra.age = -24000;
}
}
}
// `setSpawnSize`: babies are size 1, adults size 2.
finalize :: proc(m: ^Mob) {
}
    // rust: let size = if m.is_baby() { 1 } else { 2 };
    // rust: set_size(m, size, true);
}
// `getSplitCount`: two babies, none from a primed cube.
split_count :: proc(m: ^Mob) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if primed(m) { 0 } else { 2 }
}
tiny :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.size <= 1
}
jump_sound :: proc(m: ^Mob) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: if tiny(m) {
    // rust: "entity.small_sulfur_cube.jump"
    // rust: } else {
    // rust: "entity.sulfur_cube.jump"
}
}
squish_sound :: proc(m: ^Mob) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: if tiny(m) {
    // rust: "entity.small_sulfur_cube.squish"
    // rust: } else if has_body(m) {
    // rust: "entity.sulfur_cube.bounce"
    // rust: } else {
    // rust: "entity.sulfur_cube.squish"
}
}
// The hurt and death sounds by size.
sounds :: proc(m: ^Mob) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: if tiny(m) {
    // rust: [
    // rust: "",
    // rust: "entity.small_sulfur_cube.hurt",
    // rust: "entity.small_sulfur_cube.death",
    // rust: ]
    // rust: } else {
    // rust: ["", "entity.sulfur_cube.hurt", "entity.sulfur_cube.death"]
}
}
    // rust: thread_local! {
    // The `tnt_explodes` game rule of the level this thread ticks, which
    // `primeTime` and `tickFuse` read (shared by the game each tick and on
    // a rule change).
TNT_EXPLODES :: const { Cell::new(true) }
}
// Share the `tnt_explodes` rule with this thread's sulfur cubes.
set_tnt_explodes :: proc(on: bool) {
}
    // rust: TNT_EXPLODES.set(on);
}
// `primeTime`: light the fuse (short when an explosion did it), only
// while `tnt_explodes` is on.
prime :: proc(m: ^Mob, imminent: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some((fuse, _, _)) = archetype(m).and_then(|a| a.explosion) else {
    // rust: return false;
}
    // rust: if !m.alive() || !TNT_EXPLODES.get() || primed(m) {
    // rust: return false;
}
    // rust: let t = if imminent {
    // rust: m.random.next_int_bound((fuse / 4).max(1)).unwrap_or(0) + fuse / 8
    // rust: } else {
    // rust: fuse
}
    // rust: m.invulnerable_flag = true;
    // rust: m.extra.counter2 = t + 1;
    // rust: m.extra.scratch[1] |= 1;
    // rust: true
}
// `#sulfur_cube_with_block_immune_to`: the damage a cube with a block shrugs off and is only
// knocked by.
immune_to :: proc(source: ^Damage) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: source.kind,
    // rust: DamageKind::PlayerAttack
    // rust: | DamageKind::MaceSmash
    // rust: | DamageKind::Spear
    // rust: | DamageKind::MobAttack
    // rust: | DamageKind::Arrow
    // rust: | DamageKind::Thrown
    // rust: | DamageKind::Explosion
    // rust: | DamageKind::Fireworks
    // rust: | DamageKind::Fall
    // rust: | DamageKind::Sting
    // rust: | DamageKind::Cactus
    // rust: | DamageKind::Freeze
    // rust: | DamageKind::SweetBerryBush
    // rust: | DamageKind::HotFloor
    // rust: | DamageKind::FallingAnvil
    // rust: | DamageKind::FallingBlock
    // rust: | DamageKind::FallingStalactite
    // rust: | DamageKind::DryOut
    // rust: | DamageKind::Spit
    // rust: | DamageKind::Stalagmite
    // rust: | DamageKind::SulfurCubeHot
    // rust: | DamageKind::WindCharge
    // rust: )
}
// `hurtServer`: fire or `#is_explosion` (a firework rocket's burst too)
// light an explosive cube; with a block it shrugs off blows, falls and
// explosions and is only knocked about.
accepts_damage :: proc(m: ^Mob, source: ^Damage, amount: f32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !has_body(m) {
    // rust: return true;
}
    // rust: if can_explode(m) && !primed(m) {
    // rust: if source.is_fire() {
    // rust: prime(m, false);
    // rust: } else if matches!(source.kind, DamageKind::Explosion | DamageKind::Fireworks) {
    // rust: prime(m, true);
}
}
    // rust: if immune_to(source) {
        // `dealDefaultKnockback`, unless the damage type is tagged no_knockback.
    // rust: if !source.no_knockback() {
    // rust: deal_default_knockback(m, source, amount);
}
    // rust: return false;
}
    // rust: true
}
// `Vec2.rotate`: `Mth.sin`/`Mth.cos` of the angle, in floats.
rotate :: proc(x: f32, y: f32, angle: f64) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let (cosine, sine) = (
    // rust: horizon_core::geometry::trig::cos(angle),
    // rust: horizon_core::geometry::trig::sin(angle),
    // rust: );
    // rust: (x * cosine - y * sine, y * cosine + x * sine)
}
normalize :: proc(v: [f64; 3]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let length = (v[0] * v[0] + v[1] * v[1] + v[2] * v[2]).sqrt();
    // rust: if length < f64::from(1.0e-5_f32) {
    // rust: [0.0; 3]
    // rust: } else {
    // rust: [v[0] / length, v[1] / length, v[2] / length]
}
}
// `SulfurCube.applyHorizontalHitAngleScale`: the knock's direction turned by how far the
// attacker's aim is from the cube, in the horizontal plane, times the scale.
    // rust: fn horizontal_hit_angle_scale(
    // rust: scale: f32,
    // rust: angle: (f32, f32),
    // rust: eye: [f64; 3],
    // rust: aim: [f64; 3],
    // rust: center: [f64; 3],
    // rust: ) -> (f32, f32) {
    // rust: let to_target = normalize([center[0] - eye[0], center[1] - eye[1], center[2] - eye[2]]);
    // rust: let diff = horizon_core::jmath::atan2(
    // rust: aim[0] * to_target[2] - aim[2] * to_target[0],
    // rust: aim[0] * to_target[0] + aim[2] * to_target[2],
    // rust: ) as f32;
    // rust: rotate(angle.0, angle.1, f64::from(diff * scale))
}
// `SulfurCube.applyVerticalHitAnglePowerTransfer`: power moved between the horizontal and the
// vertical launch by where the attacker aims between the cube's top and bottom.
    // rust: fn vertical_hit_angle_power_transfer(
    // rust: scale: f32,
    // rust: powers: (f32, f32),
    // rust: eye: [f64; 3],
    // rust: aim: [f64; 3],
    // rust: center: [f64; 3],
    // rust: height: f32,
    // rust: ) -> (f32, f32) {
    // rust: let half = f64::from(0.5 * height);
    // rust: let top = normalize([
    // rust: center[0] - eye[0],
    // rust: center[1] + half - eye[1],
    // rust: center[2] - eye[2],
    // rust: ]);
    // rust: let bottom = normalize([
    // rust: center[0] - eye[0],
    // rust: center[1] - half - eye[1],
    // rust: center[2] - eye[2],
    // rust: ]);
    // Mth.clampedMap(aim.y, top.y, bottom.y, -1, 1): clampedLerp(inverseLerp(..), -1, 1).
    // rust: let t = (aim[1] - top[1]) / (bottom[1] - top[1]);
    // rust: let factor = if t < 0.0 {
    // rust: -1.0
    // rust: } else if t > 1.0 {
    // rust: 1.0
    // rust: } else {
    // rust: -1.0 + t * 2.0
    // rust: } as f32;
    // rust: let mut ratio = (factor * scale).abs();
    // rust: if factor < 0.0 {
    // rust: ratio = -ratio;
}
    // rust: (powers.0 * (1.0 - ratio), powers.1 * (1.0 + ratio))
}
// The `knockback_resistance` attribute's value: vanilla clamps it to -2..1, and a negative one
// (an explosive or bouncy block) adds knockback.
resistance :: proc(attribute: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: attribute.clamp(-2.0, 1.0) as f32
}
// `playerPush`'s scale: `Math.max(0, 1 - knockback_resistance)`, in double like vanilla.
push_factor :: proc(attribute: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (1.0 - attribute.clamp(-2.0, 1.0)).max(0.0)
}
// What `SulfurCube.knockback` adds to the cube's movement for a blow of `damage`: the
// archetype's `powers` (horizontal, vertical) turned by where the blow came from (`from`, the
// direct entity: the direction of the knock) and, with the causing entity's `aim` (eye, view
// direction), by where it points; the rotation by height uses its feet (`attacker_feet`).
    // rust: fn launch(
    // rust: powers: (f32, f32),
    // rust: resistance: f32,
    // rust: damage: f32,
    // rust: (xd, zd): (f64, f64),
    // rust: attacker_feet: [f64; 3],
    // rust: position: [f64; 3],
    // rust: center: [f64; 3],
    // rust: height: f32,
    // rust: aim: Option<([f64; 3], [f64; 3])>,
    // rust: effect_scale: f32,
    // rust: ) -> [f64; 3] {
    // rust: let (h0, v0) = powers;
    // rust: let (mut xd, mut zd) = (xd as f32, zd as f32);
    // rust: let (mut h, mut v) = (h0, v0);
    // rust: if let Some((eye, look)) = aim {
    // rust: let look = normalize(look);
    // rust: (xd, zd) = horizontal_hit_angle_scale(1.6, (xd, zd), eye, look, center);
    // rust: (h, v) = vertical_hit_angle_power_transfer(0.5, (h, v), eye, look, center, height);
}
    // applyVerticalPositionAnglePowerRotation from feet to feet.
    // rust: let d = [
    // rust: position[0] - attacker_feet[0],
    // rust: position[1] - attacker_feet[1],
    // rust: position[2] - attacker_feet[2],
    // rust: ];
    // rust: let angle = horizon_core::jmath::atan2(-d[1], (d[0] * d[0] + d[2] * d[2]).sqrt()) as f32;
    // rust: let (mut h, mut v) = rotate(h, v, f64::from(-angle * 0.8));
    // rust: let hr = if h0 > 0.0 { h.abs() / h0 } else { 0.0 };
    // rust: let vr = if v0 > 0.0 { v.abs() / v0 } else { 0.0 };
    // rust: let max = hr.max(vr);
    // rust: if max > 1.0 {
    // rust: h *= 1.0 / max;
    // rust: v *= 1.0 / max;
}
    // `Mth.sqrt(damage) * (comesFromEffect ? power * 0.25 : 1)`.
    // rust: let k = damage.sqrt() * effect_scale;
    // rust: h *= k;
    // rust: v *= k;
    // rust: h *= 1.0 - resistance;
    // rust: v *= 1.0 - resistance;
    // rust: h *= 0.4;
    // rust: let (h, v) = (h.clamp(-128.0, 128.0), v.clamp(-128.0, 128.0));
    // rust: let (xd, zd) = (f64::from(xd), f64::from(zd));
    // rust: let len = (xd * xd + zd * zd).sqrt();
    // rust: let (kx, kz) = if len < f64::from(1.0e-5_f32) {
    // rust: (0.0, 0.0)
    // rust: } else {
    // rust: (xd / len * f64::from(h), zd / len * f64::from(h))
}
    // rust: [-kx, f64::from(v) * 1.2, -kz]
}
// `LivingEntity.dealDefaultKnockback` for a cube with a block: from where the blow came
// (`source.getSourcePosition()`) with `knockback(0.4, ...)`. A source with a causing entity goes
// through `SulfurCube.knockback`; one with none (a cactus, a fall) through `super.knockback`.
deal_default_knockback :: proc(m: ^Mob, source: ^Damage, damage: f32) {
}
    // A projectile knocks the way it travelled (`calculateHorizontalHurtKnockbackDirection`),
    // else from the source's position.
    // rust: let (xd, zd) = match m.projectile_motion.take() {
    // rust: Some([x, z]) => (-x, -z),
    // rust: None => source
    // rust: .from
    // rust: .map_or((0.0, 0.0), |f| (f[0] - m.position.x, f[2] - m.position.z)),
}
    // rust: if source.attacker.is_some() {
    // rust: knockback(m, (xd, zd), source.from, damage, None);
    // rust: } else {
    // rust: m.knockback(f64::from(0.4_f32), xd, zd, source);
}
}
// `SulfurCube.knockback` with a block and a causing entity: the archetype's powers, turned by
// where the blow came from and by the entity's aim (`Mob::attacker_aim`, from the game).
    // rust: pub fn knockback(
    // rust: m: &mut Mob,
    // rust: direction: (f64, f64),
    // rust: from: Option<[f64; 3]>,
    // rust: damage: f32,
    // rust: effect_power: Option<f64>,
    // rust: ) -> bool {
    // rust: let Some(a) = archetype(m) else {
    // rust: return false;
}
    // rust: let aim = m.attacker_aim.take();
    // rust: let from = from.unwrap_or([m.position.x, m.position.y, m.position.z]);
    // rust: let delta = launch(
    // rust: (a.horizontal_power, a.vertical_power),
    // rust: resistance(a.knockback_resistance),
    // rust: damage,
    // rust: direction,
    // rust: aim.map_or(from, |a| a.feet),
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: m.center(),
    // rust: m.height(),
    // rust: aim.map(|a| (a.eye, a.look)),
    // rust: effect_power.map_or(1.0, |p| p as f32 * 0.25),
    // rust: );
    // rust: m.velocity = Vec3::new(
    // rust: m.velocity.x + delta[0],
    // rust: m.velocity.y + delta[1],
    // rust: m.velocity.z + delta[2],
    // rust: );
    // The hit sound plays on the next tick (no event queue here).
    // rust: m.extra.scratch[1] = 2;
    // needsSync: the push reaches the other players at once.
    // rust: m.needs_sync = true;
    // rust: true
}
// `SulfurCube.tickFuse`: count down and discard at zero before the living
// tick, including NoAI cubes. Pickup and push cooldowns belong to AI instead.
tick_fuse :: proc(m: ^Mob, events: ^[dynamic]MobEvent) {
}
    // rust: if m.extra.counter2 > 1 {
    // rust: m.extra.counter2 -= 1;
}
    // rust: if fuse(m) == 0
    // rust: && let Some((_, power, _)) = archetype(m).and_then(|a| a.explosion)
    // rust: {
        // With `tnt_explodes` off the cube still goes, without a blast.
    // rust: if TNT_EXPLODES.get() {
            // `level.explode(this, ..., TNT)`: the cube is the blast's source and its
            // causing entity, so its entity query leaves it out.
    // rust: let name = match &m.custom_name {
    // rust: Some(name) => crate::text::Text::literal(name.clone()),
    // rust: None => crate::text::Text::translate("entity.minecraft.sulfur_cube", &[]),
}
    // rust: events.push(MobEvent::ExplosionSource {
    // rust: mob: m.id,
    // rust: charged: false,
    // rust: name,
    // rust: in_water: m.fluids.in_water,
    // rust: });
    // rust: events.push(MobEvent::Explode(
    // rust: [m.position.x, m.position.y + 0.0625, m.position.z],
    // rust: power,
    // rust: m.species(),
    // rust: ));
}
    // rust: m.removed = true;
}
}

// `SulfurCube.customServerAiStep` and the remaining cube additions:
// the timers, a swallowed block's stillness, buoyancy and
// facing, growing up, and players pushing it.
ai_step :: proc(m: ^Mob, w: ^MobWorld, events: ^[dynamic]MobEvent) {
}
    // primeTime's sound, then knockback's: a burning arrow plays both.
    // rust: let pending = m.extra.scratch[1];
    // rust: if pending & 1 != 0 {
    // rust: events.push(MobEvent::Sound("entity.tnt.primed", m.center(), 1.0, 1.0));
}
    // rust: if pending & 2 != 0
    // rust: && let Some(a) = archetype(m)
    // rust: {
    // rust: events.push(MobEvent::Sound(a.hit_sound, m.center(), 1.0, 1.0));
}
    // rust: m.extra.scratch[1] = 0;
    // rust: if m.extra.ints[3] > 0 {
    // rust: m.extra.ints[3] -= 1;
}
    // rust: if m.extra.scratch[2] > 0 {
    // rust: m.extra.scratch[2] -= 1;
}
    // ageBoundaryReached: a grown baby is size 2 (and a baby made by
    // feeding, summoning or the egg is size 1, as `getBreedOffspring` makes it).
    // rust: if !m.is_baby() && m.extra.size == 1 && m.extra.age == 0 && m.age > 1 {
    // rust: set_size(m, 2, true);
    // rust: } else if m.is_baby() && m.extra.size > 1 {
    // rust: set_size(m, 1, true);
}
    // rust: let body = has_body(m);
    // collectEquipmentChanges: a swallowed block takes every goal away.
    // rust: if body {
    // rust: m.ai.goals.disabled |= MOVE | LOOK | JUMP;
    // rust: m.ai.speed = 0.0;
        // SulfurCubeLookControl: square to the nearest quarter turn.
    // rust: let close = (m.yaw + 45.0).rem_euclid(90.0) - 45.0;
    // rust: m.yaw -= close;
    // rust: m.head_yaw = m.yaw;
    // rust: } else {
    // rust: m.ai.goals.disabled &= !(MOVE | LOOK | JUMP);
}
    // travelInFluid: a buoyant block bobs up.
    // rust: if body && m.is_in_liquid() && archetype(m).is_some_and(|a| a.buoyant) {
    // rust: let vibe = 0.2 * (m.age as f32 * 0.4).sin();
    // rust: let height = if m.fluids.in_water {
    // rust: m.fluids.water
    // rust: } else {
    // rust: m.fluids.lava
}
    // rust: let immersion = height - f64::from(m.height()) * 0.2 + f64::from(vibe);
    // rust: if immersion > 0.0 {
    // rust: m.velocity.y += immersion.min(1.0) * f64::from(0.04f32);
}
}
    // rust: if body && let Some(p) = &w.player {
    // rust: player_push(m, p, events);
}
}
// `SulfurCube.doPush` / `applyContactDamage`, for ordinary mob targets.
// Use the same overlap, pushability and team predicate as pushEntities; the
// contact still happens when Entity.push produces no impulse at equal centres.
// The built-in hot archetype has attribute_to_source=false for nonplayers.
mob_contacts :: proc(m: ^Mob, w: ^MobWorld, events: ^[dynamic]MobEvent) {
}
    // rust: let Some(amount) = archetype(m).and_then(|a| a.contact_damage) else {
    // rust: return;
}
    // rust: let bounds = m.bounds();
    // rust: let own_team = w.teams.of(super::Who::Mob(m.id));
    // rust: for other in w.others_near(bounds) {
    // rust: if other.id != m.id
    // rust: && other.alive
    // rust: && other.pushable
    // rust: && other.bounds.intersects(bounds)
    // rust: && crate::scoreboard::pushable_by(own_team, w.teams.of(super::Who::Mob(other.id)), true)
    // rust: {
    // rust: events.push(MobEvent::AttackMob {
    // rust: target: other.id,
    // rust: amount,
    // rust: source: Damage::of(DamageKind::SulfurCubeHot),
    // rust: });
}
}
}

// `playerTouch` / `playerPush`: a cube holding a block is shoved by a
// player walking into it (and burns them when hot).
player_push :: proc(m: ^Mob, p: ^super::PlayerView, events: ^[dynamic]MobEvent) {
}
    // rust: if !p.alive || p.spectator {
    // rust: return;
}
    // rust: let touch = p.bounds.inflate(Vec3::new(1.0, 0.5, 1.0));
    // rust: if !m.bounds().intersects(touch) {
    // rust: return;
}
    // rust: let (dx, dz) = (m.position.x - p.position.x, m.position.z - p.position.z);
    // rust: let horizontal = (dx * dx + dz * dz).sqrt();
    // rust: let (bottom, top) = (m.position.y, m.position.y + f64::from(m.height()));
    // rust: let player_top = p.bounds.max_position().y;
    // rust: if !(horizontal < f64::from(1.3f32) && p.position.y <= top && player_top > bottom) {
    // rust: return;
}
    // rust: let a = archetype(m);
    // rust: let kb = push_factor(a.map_or(0.0, |a| a.knockback_resistance));
    // rust: let len = horizontal.max(1.0e-4);
    // rust: let speed = (p.velocity.length() * 2.0 * f64::from(0.3f32)).clamp(0.0, 0.5);
    // rust: let push = Vec3::new(
    // rust: dx / len * kb * speed,
    // rust: if m.on_ground {
    // rust: kb * f64::from(0.3f32) * speed
    // rust: } else {
    // rust: 0.0
    // rust: },
    // rust: dz / len * kb * speed,
    // rust: );
    // rust: let (sound, cooldown, threshold) = a.map_or(DEFAULT_PUSH, |a| {
    // rust: (a.push_sound, a.push_cooldown, a.push_threshold)
    // rust: });
    // rust: if push.length_squared() > f64::from(threshold * threshold) && m.extra.scratch[2] <= 0 {
    // rust: m.extra.scratch[2] = (cooldown * 20.0) as i32;
    // rust: events.push(MobEvent::Sound(sound, m.center(), 1.0, 1.0));
}
    // rust: m.velocity = m.velocity.add_vector(push);
    // rust: if let Some(amount) = a.and_then(|a| a.contact_damage) {
    // rust: events.push(MobEvent::DamagePlayer {
    // rust: amount,
    // rust: from: [m.position.x, m.position.y, m.position.z],
    // rust: kind: "minecraft:sulfur_cube_hot",
    // rust: });
}
}
// `SulfurCubeRenderer.scale` (after the cube's size and squish, flat when
// holding a block): the fuse swell, half size for an adult and the lift.
scale :: proc(m: ^Mob, alpha: f32) -> g {
    // Ported from Horizon
    return {}
}
    // rust: let size = m.extra.size.max(1) as f32;
    // rust: let squish = if has_body(m) {
    // rust: 0.0
    // rust: } else {
    // rust: m.anim.lerp(0, alpha) / (size * 0.5 + 1.0)
}
    // rust: let w = 1.0 / (squish + 1.0);
    // rust: let mut t = glam::Mat4::from_scale(glam::Vec3::splat(0.999))
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, 0.001, 0.0))
    // rust: * glam::Mat4::from_scale(glam::Vec3::new(w * size, 1.0 / w * size, w * size));
    // rust: let fuse = if primed(m) {
    // rust: fuse(m) as f32 - alpha + 1.0
    // rust: } else {
    // rust: 0.0
}
    // rust: if fuse < 10.0 && fuse > 0.0 {
    // rust: let g = (1.0 - fuse / 10.0).clamp(0.0, 1.0);
    // rust: let s = 1.0 + g * g * g * g * 0.3;
    // rust: t *= glam::Mat4::from_scale(glam::Vec3::splat(s));
}
    // rust: let baby = m.is_baby();
    // rust: let (offset, down) = if baby { (1.24, 1.0) } else { (0.98, 0.5) };
    // rust: t * glam::Mat4::from_scale(glam::Vec3::splat(down))
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, offset - 1.0 / 16.0, 0.0))
}
// The outer body model and texture.
body :: proc(m: ^Mob) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: if m.is_baby() {
    // rust: (
    // rust: "sulfur_cube_small#main".into(),
    // rust: "entity/sulfur_cube/sulfur_cube_outer_small".into(),
    // rust: )
    // rust: } else {
    // rust: (
    // rust: "sulfur_cube#main".into(),
    // rust: "entity/sulfur_cube/sulfur_cube_outer".into(),
    // rust: )
}
}
// `SulfurCubeInnerLayer`: the inner cube when no block is held.
inner :: proc(m: ^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if has_body(m) {
    // rust: return None;
}
    // rust: Some(if m.is_baby() {
    // rust: (
    // rust: "sulfur_cube_small#inner",
    // rust: "entity/sulfur_cube/sulfur_cube_inner_small",
    // rust: )
    // rust: } else {
    // rust: ("sulfur_cube#inner", "entity/sulfur_cube/sulfur_cube_inner")
    // rust: })
}
// `SulfurCubeTemptGoal` (`TemptGoal.ForNonPathfinders`): face a player
// holding slime balls (babies) or something to swallow (adults) and hop.
SulfurTempt :: struct {
    player: Option<[f64,
}
    // rust: impl Goal for SulfurTempt {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: LOOK
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(p) = &cx.w.player else { return false };
    // rust: let wants = |i: &Option<std::sync::Arc<str>>| {
    // rust: i.as_deref().is_some_and(|i| {
    // rust: if m.is_baby() {
    // rust: m.kind.food.iter().any(|f| f == i)
    // rust: } else {
    // rust: swallowable(m, i)
}
    // rust: })
}
        // Attributes.TEMPT_RANGE 8.
    // rust: let ok = p.alive
    // rust: && !p.spectator
    // rust: && (wants(&p.main_hand) || wants(&p.off_hand))
    // rust: && m.distance_sqr(p.position) <= 64.0;
    // rust: self.player = ok.then_some(p.eye);
    // rust: ok
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let Some(p) = &cx.w.player else { return };
    // rust: if m.distance_sqr(p.position) < 1.0 {
    // rust: super::cube::set_wanted(m, 0.0);
    // rust: return;
}
    // rust: m.turn_to(p.eye, 10.0, 10.0);
    // rust: let yaw = m.yaw;
    // rust: super::cube::set_direction(m, yaw, true);
}
stop :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: super::cube::set_wanted(m, 0.0);
}
}
// `SulfurCubeSearchForItemsGoal`: hop toward the nearest thing it could
// swallow (the game marks it in `point`).
SearchForItems :: struct {
    // rust: impl Goal for SearchForItems {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: LOOK
}
can_use :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !m.is_baby() && m.extra.ints[3] <= 0 && m.extra.point.is_some()
}
tick :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: let Some(p) = m.extra.point else { return };
    // rust: m.turn_to(p, 10.0, 10.0);
    // rust: let yaw = m.yaw;
    // rust: super::cube::set_direction(m, yaw, true);
}
}
// `addAdditionalSaveData`: the cube's size, the timers and the fuse.
to_nbt :: proc(m: ^Mob, map: ^horizon_world::nbt::Compound) {
}
//     use horizon_world::nbt::Tag;
    // rust: map.insert("Size".into(), Tag::Int(m.extra.size.max(1) - 1));
    // rust: map.insert("wasOnGround".into(), Tag::Byte(i8::from(m.extra.flag2)));
    // rust: map.insert("pickup_timer".into(), Tag::Int(m.extra.ints[3]));
    // rust: map.insert(
    // rust: "from_bucket".into(),
    // rust: Tag::Byte(i8::from(m.extra.scratch[3] != 0)),
    // rust: );
    // rust: map.insert("fuse".into(), Tag::Int(fuse(m)));
    // rust: for (key, value) in [
    // rust: ("Age", Tag::Int(m.extra.age)),
    // rust: ("AgeLocked", Tag::Byte(i8::from(m.extra.age_locked))),
    // rust: ] {
    // rust: map.insert(key.into(), value);
}
    // rust: map.entry("ForcedAge".into()).or_insert(Tag::Int(0));
}
// `SulfurCube.readAdditionalSaveData`: size precedes the living health default.
from_nbt :: proc(m: ^Mob, tag: ^horizon_world::nbt::Tag) {
}
//     use horizon_world::nbt::Tag;
    // rust: let int = |k: &str| match tag.get(k) {
    // rust: Some(Tag::Int(v)) => Some(*v),
    // rust: Some(Tag::Byte(v)) => Some(i32::from(*v)),
    // rust: _ => None,
}
    // rust: m.extra.age = int("Age").unwrap_or(0);
    // rust: m.extra.age_locked = int("AgeLocked").unwrap_or(0) != 0;
    // rust: let health = m.health;
    // rust: set_size(m, int("Size").unwrap_or(0) + 1, false);
    // rust: m.health = if tag.get("Health").is_some() {
    // rust: health
    // rust: } else {
    // rust: m.attrs.max_health
}
    // rust: m.extra.flag2 = int("wasOnGround").unwrap_or(0) != 0;
    // rust: m.extra.ints[3] = int("pickup_timer").unwrap_or(0);
    // rust: m.extra.scratch[3] = int("from_bucket").unwrap_or(0);
    // rust: m.extra.counter2 = int("fuse").unwrap_or(-1).max(-1) + 1;
    // rust: if primed(m) {
    // rust: m.invulnerable_flag = true;
}
}

    // rust: mod tnt_rule_tests {
//     use super::*;
//     use crate::mobs::{Damage, DamageKind, Mob, Species};
//     use horizon_core::geometry::Vec3;
//     use std::sync::Arc;

tnt_cube :: proc() -> M {
    // Ported from Horizon
    return {}
}
    // rust: test_archetype_items();
    // rust: let mut kind = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: kind.species = Species::SulfurCube;
    // rust: let mut m = Mob::new(1, Arc::new(kind), Vec3::ZERO, 0.0);
    // rust: m.extra.body = Some("minecraft:tnt".into());
    // rust: m
}

mob_tick_counts_the_fuse_but_keeps_noai_cooldowns_still :: proc() {
}
    // rust: crate::mobs::world::with_test_world(&[], |w, _| {
    // rust: for no_ai in [true, false] {
    // rust: let mut m = tnt_cube();
    // rust: m.no_ai = no_ai;
    // rust: m.no_gravity = true;
    // rust: m.persistent = true;
    // rust: m.extra.counter2 = 4; // loaded fuse 3
    // rust: m.extra.ints[3] = 100;
    // rust: m.extra.scratch[2] = 10;
    // rust: let mut random = horizon_core::random::LegacyRandom::new(0);
    // rust: let mut events = Vec::new();
    // rust: for remaining in [2, 1] {
    // rust: assert!(m.tick(w, &mut random, &mut events));
    // rust: assert_eq!(fuse(&m), remaining);
    // rust: assert_eq!(m.extra.ints[3], if no_ai { 100 } else { 97 + remaining });
    // rust: assert_eq!(m.extra.scratch[2], if no_ai { 10 } else { 7 + remaining });
}
    // rust: assert!(!m.tick(w, &mut random, &mut events));
    // rust: assert!(m.removed);
    // rust: assert_eq!(
    // rust: events
    // rust: .iter()
    // rust: .filter(|e| matches!(e, MobEvent::Explode(..)))
    // rust: .count(),
    // rust: 1
    // rust: );
    // rust: assert!(!m.tick(w, &mut random, &mut events));
    // rust: assert_eq!(
    // rust: events
    // rust: .iter()
    // rust: .filter(|e| matches!(e, MobEvent::Explode(..)))
    // rust: .count(),
    // rust: 1
    // rust: );
}
    // rust: });
}

no_fuse_is_lit_while_tnt_does_not_explode :: proc() {
}
        // primeTime checks the tnt_explodes rule: no fuse, no invulnerability,
        // and no draw for the short fuse.
    // rust: let mut m = tnt_cube();
    // rust: let state = m.random.state();
    // rust: set_tnt_explodes(false);
    // rust: m.damage(5.0, Damage::of(DamageKind::Explosion));
    // rust: let lit = prime(&mut m, true);
    // rust: let (unprimed, vulnerable) = (!primed(&m), !m.invulnerable_flag);
    // rust: set_tnt_explodes(true);
    // rust: assert!(!lit && unprimed && vulnerable);
    // rust: assert_eq!(m.random.state(), state);
    // rust: assert!(prime(&mut m, false));
    // rust: assert!(m.invulnerable_flag);
}

a_fuse_running_out_while_tnt_does_not_explode_makes_no_blast :: proc() {
}
        // tickFuse: the blast (and its source) only with tnt_explodes, the
        // discard either way.
    // rust: let mut events = Vec::new();
    // rust: let ran = crate::mobs::world::with_test_world(&[], |_, _| {
    // rust: let mut m = tnt_cube();
    // rust: assert!(prime(&mut m, false));
    // rust: m.extra.counter2 = 2; // fuse 1, 0 after this tick
    // rust: set_tnt_explodes(false);
    // rust: tick_fuse(&mut m, &mut events);
    // rust: set_tnt_explodes(true);
    // rust: assert!(m.removed);
    // rust: });
    // rust: if !ran {
    // rust: return; // needs the prepared 26.3 data
}
    // rust: assert!(
    // rust: !events
    // rust: .iter()
    // rust: .any(|e| matches!(e, MobEvent::Explode(..) | MobEvent::ExplosionSource { .. })),
    // rust: "{events:?}"
    // rust: );
}
}

    // rust: mod fuse_anim_tests {
//     use super::*;
//     use crate::mobs::{Mob, Species};
//     use horizon_core::geometry::Vec3;
//     use std::sync::Arc;

cube :: proc() -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: kind.species = Species::SulfurCube;
    // rust: Mob::new(1, Arc::new(kind), Vec3::ZERO, 0.0)
}

a_primed_cube_is_still_knocked_about :: proc() {
}
        // SulfurCube.hurtServer runs the immune knockback before
        // LivingEntity's invulnerability check, and priming makes it invulnerable.
    // rust: test_archetype_items();
    // rust: let mut m = cube();
    // rust: m.extra.body = Some("minecraft:tnt".into());
    // rust: assert!(prime(&mut m, false));
    // rust: assert!(m.invulnerable_flag);
    // rust: let (health, fuse_left) = (m.health, fuse(&m));
    // rust: m.damage(5.0, crate::mobs::Damage::player([2.0, 0.0, 0.0]));
    // rust: assert!(m.velocity.x < 0.0, "velocity {:?}", m.velocity);
    // rust: assert_eq!(m.health, health);
    // rust: assert_eq!(fuse(&m), fuse_left);
}

client_fuse_counts_down_without_going_negative :: proc() {
}
    // rust: let mut m = cube();
    // rust: m.extra.counter2 = 5; // fuse() == 4
    // rust: assert!(primed(&m));
    // rust: client_tick(&mut m);
    // rust: assert_eq!(fuse(&m), 3);
    // rust: for _ in 0..10 {
    // rust: client_tick(&mut m);
}
        // Stops at counter2 == 1 → fuse 0 (primed until the server removes it).
    // rust: assert_eq!(m.extra.counter2, 1);
    // rust: assert_eq!(fuse(&m), 0);
}

a_rockets_burst_primes_a_tnt_cube_that_shrugs_it_off :: proc() {
}
        // `fireworks` is in #is_explosion, so it lights the short fuse
        // (`PrimedTnt.getRandomShortFuse`: 15 to 44 of 120 ticks), and so in
        // #sulfur_cube_with_block_immune_to; it is not in #no_knockback.
    // rust: test_archetype_items();
    // rust: let source = Damage::fireworks(Some(crate::mobs::Who::Player), [2.0, 0.0, 0.0]);
    // rust: assert_eq!(source.kind, DamageKind::Fireworks);
    // rust: assert!(!source.no_knockback());
    // rust: let mut m = cube();
    // rust: m.extra.body = Some("minecraft:tnt".into());
    // rust: let health = m.health;
    // rust: m.damage(7.0, source);
    // rust: assert!((15..45).contains(&fuse(&m)), "fuse {}", fuse(&m));
    // rust: assert_eq!(m.health, health);
    // rust: assert!(m.velocity.x < 0.0);
        // Without a block it takes the hit, records it and is knocked away
        // from the rocket.
    // rust: let mut m = cube();
    // rust: m.damage(1.0, source);
    // rust: assert_eq!(m.health, health - 1.0);
    // rust: assert_eq!(
    // rust: m.last_damage.map(|(d, _)| d.kind),
    // rust: Some(DamageKind::Fireworks)
    // rust: );
    // rust: assert!(m.velocity.x < 0.0);
}
}

    // rust: mod launch_tests {
//     use super::launch;

    // What vanilla 26.3's `SulfurCube.knockback` adds to the movement, computed by running its
    // three private helpers' bodies on the real `Vec2`, `Vec3` and `Mth` classes: four blows
    // with the attacker at the blow's position (a melee hit), one with no aim (an attacker that
    // gives none) and two from an arrow, whose position is where the knock comes from while
    // the owner's feet give the rotation by height.
the_launch_follows_the_vanilla_helpers :: proc() {
}
Case :: struct {
    powers: (f32,
    resistance: f32,
    damage: f32,
            // The direct entity's position.
    from: [f64,
            // Its horizontal motion, if it is a projectile.
    motion: Option<[f64,
    attacker_feet: [f64,
    position: [f64,
    aim: Option<([f64,
    expected: [f64,
}
    // rust: let height = 0.5;
    // rust: let cases = [
    // rust: Case {
    // rust: powers: (1.0, 0.6),
    // rust: resistance: 0.0,
    // rust: damage: 5.0,
    // rust: from: [0.5, 64.0, 0.5],
    // rust: motion: None,
    // rust: attacker_feet: [0.5, 64.0, 0.5],
    // rust: position: [3.5, 64.0, 0.5],
    // rust: aim: Some(([0.5, 65.62, 0.5], [1.0, -0.1, 0.0])),
    // rust: expected: [0.8944272398948669, 0.536656379699707, -0.0],
    // rust: },
    // rust: Case {
    // rust: powers: (1.0, 0.6),
    // rust: resistance: 0.25,
    // rust: damage: 8.0,
    // rust: from: [0.5, 64.0, 0.5],
    // rust: motion: None,
    // rust: attacker_feet: [0.5, 64.0, 0.5],
    // rust: position: [3.5, 64.0, 1.5],
    // rust: aim: Some(([0.5, 65.62, 0.5], [0.95, -0.3, 0.2])),
    // rust: expected: [0.7428210177564502, 0.5091168880462646, 0.41014247554144134],
    // rust: },
    // rust: Case {
    // rust: powers: (2.0, 1.0),
    // rust: resistance: 0.0,
    // rust: damage: 6.0,
    // rust: from: [10.5, 70.0, -3.5],
    // rust: motion: None,
    // rust: attacker_feet: [10.5, 70.0, -3.5],
    // rust: position: [7.5, 64.0, -2.0],
    // rust: aim: Some(([10.5, 71.62, -3.5], [-0.5, -0.7, 0.4])),
    // rust: expected: [-1.1930282398964365, -2.939387798309326, 0.15109800367878837],
    // rust: },
    // rust: Case {
    // rust: powers: (1.5, 0.8),
    // rust: resistance: 0.5,
    // rust: damage: 4.0,
    // rust: from: [0.5, 64.0, 0.5],
    // rust: motion: None,
    // rust: attacker_feet: [0.5, 64.0, 0.5],
    // rust: position: [2.5, 64.0, 0.5],
    // rust: aim: None,
    // rust: expected: [0.6000000238418579, 0.9600000143051147, -0.0],
    // rust: },
    // rust: Case {
    // rust: powers: (1.0, 0.6),
    // rust: resistance: 0.0,
    // rust: damage: 6.0,
    // rust: from: [1.5, 64.9, 0.5],
    // rust: motion: Some([0.9, 0.1]),
    // rust: attacker_feet: [-6.5, 64.0, 0.5],
    // rust: position: [3.5, 64.0, 0.5],
    // rust: aim: Some(([-6.5, 65.62, 0.5], [1.0, -0.05, 0.1])),
    // rust: expected: [0.9786302987781631, 0.5878775954246521, -0.04777874198383045],
    // rust: },
    // rust: Case {
    // rust: powers: (2.0, 1.0),
    // rust: resistance: 0.25,
    // rust: damage: 5.0,
    // rust: from: [-2.5, 66.0, 3.5],
    // rust: motion: Some([-0.7, 0.4]),
    // rust: attacker_feet: [-9.5, 64.0, 6.5],
    // rust: position: [1.5, 64.0, -0.5],
    // rust: aim: Some(([-9.5, 65.62, 6.5], [0.8, -0.2, -0.5])),
    // rust: expected: [-0.38538593044563885, 2.012461280822754, 0.22688699055044273],
    // rust: },
    // rust: ];
    // rust: for (i, c) in cases.into_iter().enumerate() {
            // The box centre: the feet position plus half the height.
    // rust: let center = [
    // rust: c.position[0],
    // rust: c.position[1] + f64::from(height) / 2.0,
    // rust: c.position[2],
    // rust: ];
            // dealDefaultKnockback: a projectile knocks the way it travelled, else away from the
            // source's position.
    // rust: let direction = match c.motion {
    // rust: Some([x, z]) => (-x, -z),
    // rust: None => (c.from[0] - c.position[0], c.from[2] - c.position[2]),
}
    // rust: let got = launch(
    // rust: c.powers,
    // rust: c.resistance,
    // rust: c.damage,
    // rust: direction,
    // rust: c.attacker_feet,
    // rust: c.position,
    // rust: center,
    // rust: height,
    // rust: c.aim,
    // rust: 1.0,
    // rust: );
    // rust: for axis in 0..3 {
    // rust: assert!(
    // rust: (got[axis] - c.expected[axis]).abs() < 1.0e-9,
    // rust: "case {i} axis {axis}: {got:?} against {:?}",
    // rust: c.expected
    // rust: );
}
}
}
}

    // rust: mod resistance_tests {
//     use super::{launch, push_factor, resistance};

negative_resistance_adds_knockback :: proc() {
}
    // rust: assert_eq!(resistance(-1.0), -1.0);
    // rust: assert_eq!(resistance(-2.0), -2.0);
    // rust: assert_eq!(resistance(-5.0), -2.0);
    // rust: assert_eq!(resistance(3.0), 1.0);
    // rust: assert_eq!(push_factor(-1.0), 2.0);
    // rust: assert_eq!(push_factor(-2.0), 3.0);
    // rust: assert_eq!(push_factor(1.0), 0.0);
    // rust: assert_eq!(push_factor(0.3), 1.0 - 0.3);
    // rust: let push = |r: f64, damage: f32| {
    // rust: launch(
    // rust: (1.0, 0.6),
    // rust: resistance(r),
    // rust: damage,
    // rust: (1.0, 0.0),
    // rust: [0.0, 64.0, 0.0],
    // rust: [1.0, 64.0, 0.0],
    // rust: [1.0, 64.5, 0.0],
    // rust: 1.0,
    // rust: None,
    // rust: 1.0,
    // rust: )
}
    // rust: let base = push(0.0, 4.0);
    // rust: let explosive = push(-1.0, 4.0);
    // rust: let bouncy = push(-2.0, 4.0);
    // rust: assert!((explosive[0] / base[0] - 2.0).abs() < 1.0e-6);
    // rust: assert!((bouncy[0] / base[0] - 3.0).abs() < 1.0e-6);
}
}

    // rust: mod mob_contact_tests {
//     use super::*;
//     use std::sync::Arc;

mob_tick_contacts_only_overlapping_pushable_mobs_with_a_hot_body :: proc() {
}
    // rust: test_archetype_items();
    // rust: let victim = |id: u32, at: Vec3, alive: bool| {
    // rust: let mut m = Mob::new(id, crate::mobs::sensor_scan_tests::kind(), at, 0.0);
    // rust: if !alive {
    // rust: m.health = 0.0;
}
    // rust: m.seen(None)
}
    // rust: let others = [
    // rust: victim(2, Vec3::ZERO, true),
    // rust: victim(3, Vec3::new(8.0, 0.0, 0.0), true),
    // rust: victim(4, Vec3::ZERO, false),
    // rust: ];
    // rust: crate::mobs::world::with_test_world(&others, |w, types| {
    // rust: for no_ai in [true, false] {
    // rust: for body in [
    // rust: None,
    // rust: Some("minecraft:white_concrete_powder"),
    // rust: Some("minecraft:magma_block"),
    // rust: ] {
    // rust: let mut m = Mob::new(
    // rust: 1,
    // rust: Arc::new(types.types["minecraft:sulfur_cube"].clone()),
    // rust: Vec3::ZERO,
    // rust: 0.0,
    // rust: );
    // rust: m.no_ai = no_ai;
    // rust: m.no_gravity = true;
    // rust: m.persistent = true;
    // rust: m.extra.body = body.map(Into::into);
    // rust: let mut random = horizon_core::random::LegacyRandom::new(0);
    // rust: let mut events = Vec::new();
    // rust: assert!(m.tick(w, &mut random, &mut events));
    // rust: let hits: Vec<_> = events
    // rust: .iter()
    // rust: .filter_map(|event| match event {
    // rust: MobEvent::AttackMob {
    // rust: target,
    // rust: amount,
    // rust: source,
    // rust: } => Some((*target, *amount, source.kind)),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: if body == Some("minecraft:magma_block") {
    // rust: assert_eq!(hits, [(2, 1.0, DamageKind::SulfurCubeHot)], "NoAI={no_ai}");
    // rust: } else {
    // rust: assert!(hits.is_empty(), "{body:?}, NoAI={no_ai}: {hits:?}");
}
}
}
    // rust: });
}
}
