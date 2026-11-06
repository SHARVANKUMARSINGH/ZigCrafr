//! Transpiled from Horizon Rust crate
//! Module: horizon-client_ambient
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! What a client's copy of a mob makes on its own, in the
//! `level().isClientSide()` branches of `aiStep`: nothing of it reaches the
//! server or goes over the network, so the window's game runs it as it follows
//! a server.
// use super::{Mob, MobEvent, Species, bee};
// use horizon_core::geometry::trig::Mth;
// use horizon_core::random::RandomSource;
// use std::f32::consts::PI;

/// `Enderman.aiStep`, `Endermite.aiStep` and `Blaze.aiStep` on a client:
/// two portal particles a tick around endermen and endermites; two large
/// smoke particles a tick around blazes and, one tick in 24, their burn.
/// Also `Dolphin.tick`'s trail on a client.
pub fn client_ai_step(m: *mut Mob, out: *mut std.ArrayList(MobEvent)) void {
}
    // rust: let species = m.species();
    // rust: if species == Species::Dolphin {
    // rust: dolphin_trail(m, out);
    // rust: return;
}
    // rust: if !matches!(
    // rust: species,
    // rust: Species::Enderman | Species::Endermite | Species::Blaze
    // rust: ) {
    // rust: return;
}
    // rust: let (w, h) = (f64::from(m.width()), f64::from(m.height()));
    // rust: let p = m.position;
    // rust: if species == Species::Blaze && m.random.next_int_bound(24).unwrap_or(1) == 0 && !m.silent {
    // rust: let volume = 1.0 + m.random.next_float();
    // rust: let pitch = m.random.next_float() * 0.7 + 0.3;
    // rust: out.push(MobEvent::LocalSound(
    // rust: "entity.blaze.burn",
    // rust: [p.x + 0.5, p.y + 0.5, p.z + 0.5],
    // rust: volume,
    // rust: pitch,
    // rust: ));
}
    // rust: for _ in 0..2 {
        // Entity.getRandomX(0.5), getRandomY(), getRandomZ(0.5).
    // rust: let r = &mut m.random;
    // rust: let x = p.x + w * (2.0 * r.next_double() - 1.0) * 0.5;
    // rust: let y = p.y + h * r.next_double();
    // rust: let z = p.z + w * (2.0 * r.next_double() - 1.0) * 0.5;
    // rust: let (kind, at, velocity) = if species == Species::Blaze {
    // rust: ("large_smoke", [x, y, z], [0.0; 3])
    // rust: } else {
            // The enderman's are a quarter block lower.
    // rust: let y = if species == Species::Enderman {
    // rust: y - 0.25
    // rust: } else {
    // rust: y
}
    // rust: let velocity = [
    // rust: (r.next_double() - 0.5) * 2.0,
    // rust: -r.next_double(),
    // rust: (r.next_double() - 0.5) * 2.0,
    // rust: ];
    // rust: ("portal", [x, y, z], velocity)
}
    // rust: out.push(MobEvent::ParticleAt { kind, at, velocity });
}
}

/// `Dolphin.tick` on a client: a dolphin that swims fast in water (squared
/// speed over 0.03) leaves four dolphin particles a tick behind it, two on
/// each side, set back along its view by a distance from its own random.
pub fn dolphin_trail(m: *mut Mob, out: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if m.no_ai || !m.fluids.in_water || m.velocity.length_squared() <= 0.03 {
    // rust: return;
}
    // Entity.getViewVector(0).
    // rust: let view = m.view_vector();
    // rust: let yaw = m.yaw * (PI / 180.0);
    // rust: let (c, s) = (f64::from(yaw.mcos() * 0.3), f64::from(yaw.msin() * 0.3));
    // rust: let back = f64::from(1.2 - m.random.next_float() * 0.7);
    // rust: let p = m.position;
    // rust: let (x, y, z) = (p.x - view[0] * back, p.y - view[1], p.z - view[2] * back);
    // rust: for _ in 0..2 {
    // rust: for (dx, dz) in [(c, s), (-c, -s)] {
    // rust: out.push(MobEvent::ParticleAt {
    // rust: kind: "dolphin",
    // rust: at: [x + dx, y, z + dz],
    // rust: velocity: [0.0; 3],
    // rust: });
}
}
}

/// `Phantom.tick` and `Bee.tick` on a client, which draw from the client
/// level's random (`random`) and never from the mob's own, so a window that
/// simulates the world keeps the mob's draws as the server has them: a
/// phantom's wings leave mycelium dust, a bee carrying nectar now and then
/// drips it.
pub fn client_particles(m: *Mob, random: *mut impl RandomSource, out: *mut std.ArrayList(MobEvent)) void {
}
    // rust: match m.species() {
    // rust: Species::Phantom => {
            // The wings flap every phantom in a different phase
            // (`getUniqueFlapTickOffset`).
    // rust: let flap = ((m.id.wrapping_mul(3).wrapping_add(m.age)) as i32 as f32
    // rust: * 7.448451
    // rust: * (PI / 180.0)
    // rust: + PI)
    // rust: .mcos();
    // rust: let width = m.width() * 1.48;
    // rust: let yaw = m.yaw * (PI / 180.0);
    // rust: let (c, s) = (yaw.mcos() * width, yaw.msin() * width);
    // rust: let h = (0.3 + flap * 0.45) * m.height() * 2.5;
    // rust: let p = m.position;
    // rust: for (dx, dz) in [(c, s), (-c, -s)] {
    // rust: out.push(MobEvent::ParticleAt {
    // rust: kind: "mycelium",
    // rust: at: [p.x + f64::from(dx), p.y + f64::from(h), p.z + f64::from(dz)],
    // rust: velocity: [0.0; 3],
    // rust: });
}
}
    // rust: Species::Bee => {
    // rust: if !bee::has_nectar(m)
    // rust: || !bee::get(m).is_some_and(|b| b.crops_grown < 10)
    // rust: || random.next_float() >= 0.05
    // rust: {
    // rust: return;
}
            // `for (i = 0; i < nextInt(2) + 1; i++)` rolls the bound each time.
    // rust: let mut i = 0;
    // rust: while i < random.next_int_bound(2).unwrap_or(0) + 1 {
                // Mth.lerp(level.random.nextDouble(), x - 0.3F, x + 0.3F).
    // rust: let spread = f64::from(0.3_f32);
    // rust: let lerp = |delta: f64, from: f64, to: f64| from + delta * (to - from);
    // rust: let x = lerp(
    // rust: random.next_double(),
    // rust: m.position.x - spread,
    // rust: m.position.x + spread,
    // rust: );
    // rust: let z = lerp(
    // rust: random.next_double(),
    // rust: m.position.z - spread,
    // rust: m.position.z + spread,
    // rust: );
    // rust: out.push(MobEvent::ParticleAt {
    // rust: kind: "falling_nectar",
                    // getY(0.5).
    // rust: at: [x, m.position.y + f64::from(m.height()) * 0.5, z],
    // rust: velocity: [0.0; 3],
    // rust: });
    // rust: i += 1;
}
}
    // rust: _ => {}
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::mobs::sensor_scan_tests::kind;
//     use horizon_core::geometry::Vec3;

pub fn dolphin() M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut kind = kind();
    // rust: let k = std::sync::Arc::make_mut(&mut kind);
    // rust: k.id = "minecraft:dolphin".into();
    // rust: k.species = Species::Dolphin;
    // rust: let mut m = Mob::new(1, kind, Vec3::new(10.0, 60.0, 20.0), 0.0);
    // rust: m.fluids.in_water = true;
    // rust: m.velocity = Vec3::new(0.0, 0.0, 0.2);
    // rust: m
}

pub fn trail(m: *mut Mob) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: client_ai_step(m, &mut out);
    // rust: out.into_iter()
    // rust: .map(|e| match e {
    // rust: MobEvent::ParticleAt { kind, at, velocity } => {
    // rust: assert_eq!((kind, velocity), ("dolphin", [0.0; 3]));
    // rust: at
}
    // rust: _ => panic!("only particles"),
    // rust: })
    // rust: .collect()
}

    /// `Dolphin.tick` on a client: facing south (yaw 0, level), a swimming
    /// dolphin leaves two pairs of particles 0.3 to either side, set back
    /// 0.5 to 1.2 behind it on the same height.
pub fn a_swimming_dolphin_leaves_four_trail_particles_behind_it() void {
}
    // rust: let mut m = dolphin();
    // rust: let at = trail(&mut m);
    // rust: assert_eq!(at.len(), 4);
    // rust: let back = 20.0 - at[0][2];
    // rust: assert!((0.5..=1.2).contains(&back), "set back {back}");
    // rust: for (i, p) in at.iter().enumerate() {
    // rust: let side = if i % 2 == 0 { 0.3 } else { -0.3 };
    // rust: assert!((p[0] - (10.0 + side)).abs() < 1e-6, "{p:?}");
    // rust: assert_eq!((p[1], p[2]), (60.0, at[0][2]));
}
}

    /// No trail out of water, at a squared speed of 0.03 or less, or with NoAI.
pub fn a_slow_dry_or_no_ai_dolphin_leaves_no_trail() void {
}
    // rust: let mut m = dolphin();
    // rust: m.fluids.in_water = false;
    // rust: assert!(trail(&mut m).is_empty());
    // rust: let mut m = dolphin();
    // rust: m.velocity = Vec3::new(0.0, 0.0, 0.17);
    // rust: assert!(trail(&mut m).is_empty());
    // rust: let mut m = dolphin();
    // rust: m.no_ai = true;
    // rust: assert!(trail(&mut m).is_empty());
}
}
