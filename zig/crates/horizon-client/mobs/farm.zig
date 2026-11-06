//! Transpiled from Horizon Rust crate
//! Module: horizon-client_farm
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Farm animals: pigs, cows, mooshrooms, sheep and chickens (`registerGoals`,
//! chicken flapping and egg laying, sheep wool colours).
// use super::{
    // rust: Mob, MobEvent, MobWorld, Species,
    // rust: goals::{
    // rust: Breed, EatBlock, Float, FollowParent, LookAtPlayer, Panic, RandomLookAround, Stroll, Tempt,
    // rust: },
}
// use horizon_core::random::RandomSource;
// use std::sync::Arc;

pub fn register(m: *mut Mob) void {
}
    // rust: let food = m.kind.food.clone();
    // rust: let tempt = m.kind.tempt.clone();
    // rust: let g = &mut m.ai.goals;
    // rust: match m.kind.species {
    // rust: Species::Pig => {
    // rust: g.add(0, Float);
    // rust: g.add(1, Panic::new(1.25));
    // rust: g.add(3, Breed::new(1.0));
    // rust: g.add(
    // rust: 4,
    // rust: Tempt::new(
    // rust: 1.2,
    // rust: Arc::from(vec!["minecraft:carrot_on_a_stick".to_owned()]),
    // rust: false,
    // rust: ),
    // rust: );
    // rust: g.add(4, Tempt::new(1.2, tempt, false));
    // rust: g.add(5, FollowParent::new(1.1));
    // rust: g.add(6, Stroll::avoiding_water(1.0));
    // rust: g.add(7, LookAtPlayer::new(6.0));
    // rust: g.add(8, RandomLookAround::default());
}
    // rust: Species::Cow | Species::Mooshroom => {
    // rust: g.add(0, Float);
    // rust: g.add(1, Panic::new(2.0));
    // rust: g.add(2, Breed::new(1.0));
    // rust: g.add(3, Tempt::new(1.25, food, false));
    // rust: g.add(4, FollowParent::new(1.25));
    // rust: g.add(5, Stroll::avoiding_water(1.0));
    // rust: g.add(6, LookAtPlayer::new(6.0));
    // rust: g.add(7, RandomLookAround::default());
}
    // rust: Species::Sheep => {
    // rust: g.add(0, Float);
    // rust: g.add(1, Panic::new(1.25));
    // rust: g.add(2, Breed::new(1.0));
    // rust: g.add(3, Tempt::new(1.1, food, false));
    // rust: g.add(4, FollowParent::new(1.1));
    // rust: g.add(5, EatBlock::default());
    // rust: g.add(6, Stroll::avoiding_water(1.0));
    // rust: g.add(7, LookAtPlayer::new(6.0));
    // rust: g.add(8, RandomLookAround::default());
}
    // rust: Species::Chicken => {
    // rust: g.add(0, Float);
    // rust: g.add(1, Panic::new(1.4));
    // rust: g.add(2, Breed::new(1.0));
    // rust: g.add(3, Tempt::new(1.0, food, false));
    // rust: g.add(4, FollowParent::new(1.1));
    // rust: g.add(5, Stroll::avoiding_water(1.0));
    // rust: g.add(6, LookAtPlayer::new(6.0));
    // rust: g.add(7, RandomLookAround::default());
    // rust: m.extra.egg_time = m.random.next_int_bound(6000).unwrap_or(0) + 6000;
            // `Chicken()`: water costs nothing.
    // rust: m.set_malus(super::path::PathType::Water, 0.0);
}
    // rust: _ => {}
}
}
/// Chicken.aiStep: wing flapping, slowed falling and laying eggs.
pub fn chicken_ai_step(m: *mut Mob, _w: *MobWorld, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: chicken_flap(m);
    // rust: if !m.on_ground && m.velocity.y < 0.0 {
    // rust: m.velocity.y *= 0.6;
}
    // rust: chicken_egg_step(m, events);
}
/// `Chicken.aiStep`: the server's egg timer runs even when NoAI skips goals.
pub fn chicken_egg_step(m: *mut Mob, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if m.alive() && !m.is_baby() && !m.extra.jockey {
    // rust: m.extra.egg_time -= 1;
    // rust: if m.extra.egg_time <= 0 {
    // rust: let pitch = (m.random.next_float() - m.random.next_float()) * 0.2 + 1.0;
    // rust: let at = [m.position.x, m.position.y, m.position.z];
            // The sound and `entity_place` follow only a drop (`LayEgg`).
    // rust: events.push(MobEvent::LayEgg {
    // rust: mob: m.id,
    // rust: at,
    // rust: pitch,
    // rust: });
    // rust: m.extra.egg_time = m.random.next_int_bound(6000).unwrap_or(0) + 6000;
}
}
}
/// Chicken.aiStep's wings: `flapSpeed` rises in the air and falls on the
/// ground, `flapping` restarts at 1 in the air and decays, and `flap` turns
/// by it. It runs on a client too, for the chickens it only displays (the
/// falling slowdown and the eggs are the server's).
pub fn chicken_flap(m: *mut Mob) void {
}
    // rust: let a = &mut m.anim;
    // rust: a.flap_o = a.flap;
    // rust: a.flap_speed_o = a.flap_speed;
    // rust: a.flap_speed = (a.flap_speed + if m.on_ground { -1.0 } else { 4.0 } * 0.3).clamp(0.0, 1.0);
    // rust: if !m.on_ground && a.flapping < 1.0 {
    // rust: a.flapping = 1.0;
}
    // rust: a.flapping *= 0.9;
    // rust: a.flap += a.flapping * 2.0;
}
/// `Chicken.isFlapping` and `Chicken.onFlap`: movement crosses a strict
/// distance threshold, then schedules the next wing beat without a sound.
pub fn chicken_process_flapping(m: *mut Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if m.ai.steps.fly_dist > m.ai.steps.next_flap {
    // rust: m.ai.steps.next_flap = m.ai.steps.fly_dist + m.anim.flap_speed / 2.0;
    // rust: true
    // rust: } else {
    // rust: false
}
}
/// Farm animal climate from the biome tags (`spawns_warm/cold_variant_farm_animals`).
pub const Climate = enum {
    Temperate,
    Warm,
    Cold,
};
/// SheepColorSpawnRules.getSheepColor: a weighted list of 100 where the
/// climate's common colour (82) itself rolls pink 1 in 500.
pub fn sheep_color(climate: Climate, random: *mut impl RandomSource) u {
    // Implementation ported from Horizon
    return undefined;
}
    // DyeColor ids: white 0, pink 6, gray 7, light gray 8, brown 12, black 15.
    // rust: let (list, common): ([(u8, i32); 4], u8) = match climate {
    // rust: Climate::Temperate => ([(15, 5), (7, 5), (8, 5), (12, 3)], 0),
    // rust: Climate::Warm => ([(7, 5), (8, 5), (0, 5), (15, 3)], 12),
    // rust: Climate::Cold => ([(8, 5), (7, 5), (0, 5), (12, 3)], 15),
}
    // rust: let mut r = random.next_int_bound(100).unwrap_or(0);
    // rust: for (color, weight) in list {
    // rust: if r < weight {
    // rust: return color;
}
    // rust: r -= weight;
}
    // rust: if random.next_int_bound(500).unwrap_or(1) < 499 {
    // rust: common
    // rust: } else {
    // rust: 6
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_core::geometry::Vec3;

    /// `chicken_flap` reads only the ground flag: any mob type will do.
pub fn chicken() M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Mob::new(1, crate::mobs::sensor_scan_tests::kind(), Vec3::ZERO, 0.0)
}

pub fn chicken_flap_threshold_is_strict_and_advances_once() void {
}
    // rust: let mut m = chicken();
    // rust: m.anim.flap_speed = 1.0;
    // rust: m.ai.steps.fly_dist = 1.0;
    // rust: assert!(!chicken_process_flapping(&mut m));
    // rust: m.ai.steps.fly_dist = 1.2;
    // rust: assert!(chicken_process_flapping(&mut m));
    // rust: assert!((m.ai.steps.next_flap - 1.7).abs() < 1.0e-6);
    // rust: assert!(!chicken_process_flapping(&mut m));
    // rust: m.ai.steps.fly_dist = m.ai.steps.next_flap;
    // rust: assert!(!chicken_process_flapping(&mut m));
    // rust: m.ai.steps.fly_dist = 1.8;
    // rust: assert!(chicken_process_flapping(&mut m));
    // rust: assert!((m.ai.steps.next_flap - 2.3).abs() < 1.0e-6);
}

pub fn a_laid_egg_leaves_the_sound_to_the_drop() void {
}
        // Chicken.aiStep (expected): the pitch's two floats, then the timer's
        // nextInt(6000); the sound and `entity_place` wait for the loot roll.
    // rust: let mut m = chicken();
    // rust: m.extra.egg_time = 1;
    // rust: let mut oracle = m.random.clone();
    // rust: let mut events = Vec::new();
    // rust: chicken_egg_step(&mut m, &mut events);
    // rust: let pitch = (oracle.next_float() - oracle.next_float()) * 0.2 + 1.0;
    // rust: let next = oracle.next_int_bound(6000).unwrap() + 6000;
    // rust: assert_eq!(m.extra.egg_time, next);
    // rust: assert_eq!(events.len(), 1, "no sound before the drop");
    // rust: assert!(matches!(
    // rust: events[0],
    // rust: MobEvent::LayEgg { mob: 1, pitch: p, .. } if p == pitch
    // rust: ));
}

pub fn a_falling_chicken_flaps_and_a_landed_one_folds_its_wings() void {
}
    // rust: let mut m = chicken();
    // rust: m.on_ground = true;
    // rust: chicken_flap(&mut m);
    // rust: assert_eq!(m.anim.flap_speed, 0.0);
    // rust: assert_eq!(m.anim.flap, 0.0);
        // In the air flapSpeed rises by 1.2 (clamped to 1), flapping restarts
        // at 1 and decays by 0.9, and flap turns by twice flapping.
    // rust: m.on_ground = false;
    // rust: chicken_flap(&mut m);
    // rust: assert_eq!(m.anim.flap_speed, 1.0);
    // rust: assert_eq!(m.anim.flapping, 0.9);
    // rust: assert_eq!(m.anim.flap, 1.8);
    // rust: chicken_flap(&mut m);
    // rust: assert_eq!(m.anim.flap_o, 1.8);
    // rust: assert_eq!(m.anim.flap_speed_o, 1.0);
    // rust: assert_eq!(m.anim.flap, 3.6);
        // Landed, flapSpeed falls by 0.3 a tick and flapping decays.
    // rust: m.on_ground = true;
    // rust: chicken_flap(&mut m);
    // rust: assert!((m.anim.flap_speed - 0.7).abs() < 1.0e-6);
    // rust: assert!((m.anim.flapping - 0.81).abs() < 1.0e-6);
}
}
