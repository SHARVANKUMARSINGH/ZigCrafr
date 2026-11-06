//! Transpiled from Horizon Rust crate
package horizon_cosmetics_trail

import "core:fmt"
import "core:mem"
import "core:math"

// A trail's particles: spawned only by moving, at most `PER_PLAYER` alive for one wearer and
// `BUDGET` for everyone, each living its fixed lifetime. A particle's path is a function of its
// age, so a frame only spawns, retires and draws: nothing is stepped per tick.

// use crate::Trail;
// use glam::{DVec3, Vec3};

// Particles alive at once for one wearer.
PER_PLAYER :: 24
// Particles alive at once for every wearer together.
BUDGET :: 512
// A move longer than this between two frames (blocks) is a teleport: it leaves nothing.
JUMP :: 4.0

// One particle: where and when it started, which sprite, how big, and its sway's phase.
Particle :: struct {
    start: DVec3,
    born: f64,
    sprite: u8,
    size: f32,
    phase: f32,
}

// The particles one wearer left, and what their next move adds.
Emitter :: struct {
    particles: [dynamic]Particle,
    last: Maybe(DVec3),
    // Particles owed by the distance walked so far (the fraction left over).
    owed: f32,
    // Particles spawned, for each one's look (no random source: a hash of this).
    count: u32,
}

// Particles alive across every emitter, kept from frame to frame: `step` adds and retires,
// `clear` gives an emitter's back.
Budget :: struct {
    alive: uint,
}

// A particle's quad: corners relative to the camera (blocks), the sprite's UV corners in 0..1
// of the item's texture, and its opacity.
Quad :: struct {
    corners: [Vec3,
    uv: [[f32,
    alpha: f32,
}

// A hash of `n` to 0..1 (lowbias32).
unit :: proc(n: u32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let mut x = n;
    // rust: x ^= x >> 16;
    // rust: x = x.wrapping_mul(0x7feb_352d);
    // rust: x ^= x >> 15;
    // rust: x = x.wrapping_mul(0x846c_a68b);
    // rust: x ^= x >> 16;
    // rust: (x >> 8) as f32 / (1 << 24) as f32
}

    // rust: impl Emitter {
    // Particles alive.
len :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.particles.len()
}

is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.particles.is_empty()
}

    // One frame at `now` (ticks) for a wearer whose feet are at `feet`: retires the particles
    // past their lifetime, then, if the wearer `moves` (not sneaking, not riding...), spawns
    // what the distance walked since the last frame owes, within `PER_PLAYER` and the `budget`.
step :: proc(self: ^Self, trail: ^Trail, feet: DVec3, moves: bool, now: f64, budget: ^Budget) {
}
    // rust: let life = f64::from(trail.lifetime);
    // rust: let before = self.particles.len();
    // rust: self.particles.retain(|p| now - p.born < life);
    // rust: budget.alive -= (before - self.particles.len()).min(budget.alive);
    // rust: let last = self.last.replace(feet);
    // rust: let walked = last.map_or(0.0, |l| l.distance(feet));
    // rust: if !moves || walked > JUMP {
    // rust: self.owed = 0.0;
    // rust: } else {
    // rust: self.owed += walked as f32 * trail.rate;
}
    // rust: let height = match trail.from {
    // rust: crate::From::Feet => 0.1,
    // rust: crate::From::Body => 0.9,
}
    // rust: while self.owed >= 1.0 && self.particles.len() < PER_PLAYER && budget.alive < BUDGET {
    // rust: self.owed -= 1.0;
    // rust: budget.alive += 1;
    // rust: let n = self.count;
    // rust: self.count = self.count.wrapping_add(1);
    // rust: let seed = n.wrapping_mul(4);
            // Spread along the way walked this frame, and a little around it.
    // rust: let along = f64::from(unit(seed));
    // rust: let from = last.unwrap_or(feet);
    // rust: let jitter = DVec3::new(
    // rust: f64::from(unit(seed + 1) - 0.5) * 0.4,
    // rust: height,
    // rust: f64::from(unit(seed + 2) - 0.5) * 0.4,
    // rust: );
    // rust: self.particles.push(Particle {
    // rust: start: from.lerp(feet, along) + jitter,
    // rust: born: now,
    // rust: sprite: (unit(seed + 3) * trail.sprites as f32) as u8 % trail.sprites as u8,
    // rust: size: trail.size[0] + (trail.size[1] - trail.size[0]) * unit(seed + 1),
    // rust: phase: unit(seed + 2) * std::f32::consts::TAU,
    // rust: });
}
        // What can't be spawned now isn't owed later: the trail thins, it never bursts.
    // rust: self.owed = self.owed.min(1.0);
}

    // Drops every particle (the wearer left the view, or took the trail off).
clear :: proc(self: ^Self, budget: ^Budget) {
}
    // rust: budget.alive -= self.particles.len().min(budget.alive);
    // rust: *self = Self::default();
}

    // The quads of the particles alive at `now`, facing a camera at `camera` whose right and up
    // are `right` and `up` (unit).
    // rust: pub fn quads<'a>(
    // rust: &'a self,
    // rust: trail: &'a Trail,
    // rust: now: f64,
    // rust: camera: DVec3,
    // rust: right: Vec3,
    // rust: up: Vec3,
    // rust: ) -> impl Iterator<Item = Quad> + 'a {
    // rust: let life = trail.lifetime as f32;
    // rust: self.particles.iter().filter_map(move |p| {
    // rust: let age = (now - p.born) as f32;
    // rust: if !(0.0..life).contains(&age) {
    // rust: return None;
}
    // rust: let sway = trail.drift / 16.0 * (age * 0.2 + p.phase).sin();
    // rust: let fall = 0.5 * trail.gravity * age * age;
    // rust: let at = (p.start - camera).as_vec3()
    // rust: + Vec3::new(sway * p.phase.cos(), -fall, sway * p.phase.sin());
    // rust: let spin = (trail.spin * age).to_radians() + p.phase;
    // rust: let (s, c) = spin.sin_cos();
    // rust: let half = p.size / 32.0;
    // rust: let (r, u) = ((right * c + up * s) * half, (up * c - right * s) * half);
    // rust: let w = 1.0 / trail.sprites as f32;
    // rust: let (u0, u1) = (p.sprite as f32 * w, (p.sprite as f32 + 1.0) * w);
    // rust: let alpha = match trail.fade {
    // rust: true => (3.0 * (1.0 - age / life)).min(1.0),
    // rust: false => 1.0,
}
    // rust: Some(Quad {
    // rust: corners: [at - r - u, at + r - u, at + r + u, at - r + u],
    // rust: uv: [[u0, 1.0], [u1, 1.0], [u1, 0.0], [u0, 0.0]],
    // rust: alpha,
    // rust: })
    // rust: })
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::From;

leaves :: proc(rate: f32, lifetime: u32) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Trail {
    // rust: sprites: 4,
    // rust: rate,
    // rust: lifetime,
    // rust: size: [2.0, 3.0],
    // rust: gravity: 0.01,
    // rust: drift: 1.5,
    // rust: spin: 8.0,
    // rust: from: From::Feet,
    // rust: fade: true,
    // rust: glow: false,
}
}

    // Walks `blocks` along x in `frames` frames of a tick each from tick `t0`.
walk :: proc(e: ^Emitter, t: ^Trail, blocks: f64, frames: u32, t0: f64, budget: ^Budget) {
}
    // rust: for i in 0..=frames {
    // rust: let x = blocks * f64::from(i) / f64::from(frames);
    // rust: e.step(t, DVec3::new(x, 64.0, 0.0), true, t0 + f64::from(i), budget);
}
}

spawns_by_the_distance_walked_and_nothing_standing_or_sneaking :: proc() {
}
    // rust: let t = leaves(2.0, 40);
    // rust: let mut e = Emitter::default();
        // 5 blocks at 2 a block: 10 particles.
    // rust: walk(&mut e, &t, 5.0, 20, 0.0, &mut Budget::default());
    // rust: assert_eq!(e.len(), 10);
        // Standing still for the rest of their lives: none more, then none at all.
    // rust: for i in 21..=60 {
    // rust: e.step(
    // rust: &t,
    // rust: DVec3::new(5.0, 64.0, 0.0),
    // rust: true,
    // rust: f64::from(i),
    // rust: &mut Budget::default(),
    // rust: );
}
    // rust: assert!(e.is_empty());
        // Sneaking along: nothing.
    // rust: let mut sneaking = Emitter::default();
    // rust: for i in 0..=20 {
    // rust: let feet = DVec3::new(f64::from(i) * 0.25, 64.0, 0.0);
    // rust: sneaking.step(&t, feet, false, f64::from(i), &mut Budget::default());
}
    // rust: assert!(sneaking.is_empty());
}

a_teleport_leaves_nothing_and_particles_live_their_lifetime :: proc() {
}
    // rust: let t = leaves(4.0, 10);
    // rust: let mut e = Emitter::default();
    // rust: e.step(&t, DVec3::ZERO, true, 0.0, &mut Budget::default());
    // rust: e.step(
    // rust: &t,
    // rust: DVec3::new(100.0, 0.0, 0.0),
    // rust: true,
    // rust: 1.0,
    // rust: &mut Budget::default(),
    // rust: );
    // rust: assert!(e.is_empty());
    // rust: e.step(
    // rust: &t,
    // rust: DVec3::new(101.0, 0.0, 0.0),
    // rust: true,
    // rust: 2.0,
    // rust: &mut Budget::default(),
    // rust: );
    // rust: assert_eq!(e.len(), 4);
        // Born at tick 2, alive through 11, gone at 12.
    // rust: let quads = |e: &Emitter, now| e.quads(&t, now, DVec3::ZERO, Vec3::X, Vec3::Y).count();
    // rust: assert_eq!(quads(&e, 11.5), 4);
    // rust: e.step(
    // rust: &t,
    // rust: DVec3::new(101.0, 0.0, 0.0),
    // rust: true,
    // rust: 12.0,
    // rust: &mut Budget::default(),
    // rust: );
    // rust: assert!(e.is_empty());
}

the_per_player_and_global_budgets_hold :: proc() {
}
    // rust: let t = leaves(4.0, 40);
        // Sprinting for 2 s: 4 a block would make 44; one wearer keeps 24.
    // rust: let mut e = Emitter::default();
    // rust: walk(&mut e, &t, 11.0, 40, 0.0, &mut Budget::default());
    // rust: assert_eq!(e.len(), PER_PLAYER);
        // 64 wearers sprinting side by side, one frame each: never past the shared budget.
    // rust: let mut crowd = vec![Emitter::default(); 64];
    // rust: let mut alive = 0;
    // rust: let mut budget = Budget::default();
    // rust: for tick in 0..=40 {
    // rust: for (i, e) in crowd.iter_mut().enumerate() {
    // rust: let feet = DVec3::new(f64::from(tick) * 0.28, 64.0, i as f64 * 2.0);
    // rust: e.step(&t, feet, true, f64::from(tick), &mut budget);
}
    // rust: alive = crowd.iter().map(Emitter::len).sum::<usize>();
    // rust: assert!(alive <= BUDGET, "{alive} alive at tick {tick}");
    // rust: assert_eq!(budget.alive, alive);
}
    // rust: assert_eq!(alive, BUDGET);
        // One leaves the view: its share goes back.
    // rust: let gone = crowd[0].len();
    // rust: crowd[0].clear(&mut budget);
    // rust: assert_eq!(budget.alive, BUDGET - gone);
}

quads_face_the_camera_fall_and_fade :: proc() {
}
    // rust: let t = leaves(1.0, 30);
    // rust: let mut e = Emitter::default();
    // rust: e.step(&t, DVec3::ZERO, true, 0.0, &mut Budget::default());
    // rust: e.step(
    // rust: &t,
    // rust: DVec3::new(1.0, 0.0, 0.0),
    // rust: true,
    // rust: 0.0,
    // rust: &mut Budget::default(),
    // rust: );
    // rust: let (right, up) = (Vec3::X, Vec3::Y);
    // rust: let at = |now| e.quads(&t, now, DVec3::ZERO, right, up).next().unwrap();
    // rust: let young = at(0.0);
        // In the camera's plane: no depth across the quad.
    // rust: let normal =
    // rust: (young.corners[1] - young.corners[0]).cross(young.corners[3] - young.corners[0]);
    // rust: assert!(normal.normalize().abs().z > 0.999);
        // 2 to 3 pixels across.
    // rust: let side = (young.corners[1] - young.corners[0]).length() * 16.0;
    // rust: assert!((2.0..=3.0).contains(&side), "{side}");
        // Falls by gravity: half of 0.01 * 20² = 2 blocks in 20 ticks.
    // rust: let centre = |q: Quad| q.corners.iter().copied().sum::<Vec3>() / 4.0;
    // rust: let fell = centre(young).y - centre(at(20.0)).y;
    // rust: assert!((fell - 2.0).abs() < 1e-3, "{fell}");
        // Opaque for its first two thirds, then fading out.
    // rust: assert_eq!((young.alpha, at(19.0).alpha), (1.0, 1.0));
    // rust: assert!((at(25.0).alpha - 0.5).abs() < 1e-5);
        // Each shows one of the 4 sprites: a quarter of the texture across.
    // rust: let [a, b, ..] = young.uv;
    // rust: assert!((b[0] - a[0] - 0.25).abs() < 1e-6);
}
}
