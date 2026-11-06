//! Transpiled from Horizon Rust crate
//! Module: horizon-client_dragon_contacts
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `EnderDragon.knockBack` and `hurt` for living mobs.
//! The dragon lives outside the normal mob array; its contacts must still reach them.
// Contact rules compared with the installed vanilla Java 26.3 EnderDragon.
// use crate::mobs::{Damage, DamageKind, Mob, Who};
// use horizon_core::geometry::{Aabb, Vec3};

pub const Frame = struct {
    dragon_id: u32,
    origin: Vec3,
    center: (f64,
    wings: [Aabb,
    heads: [Aabb,
    sitting: bool,
    recently_hurt: bool,
};

/// Wings push even while perched and even when teams forbid damage.
/// The normal mob damage handler owns armor, invulnerability frames and last-attacker bookkeeping.
pub fn contact(m: *mut Mob, f: *Frame, teams_allow: bool) void {
}
    // rust: if f.recently_hurt || m.removed || m.id == f.dragon_id {
    // rust: return;
}
    // rust: let bounds = m.bounds();
    // rust: let source = Damage {
    // rust: kind: DamageKind::MobAttack,
    // rust: attacker: Some(Who::Mob(f.dragon_id)),
    // rust: from: Some([f.origin.x, f.origin.y, f.origin.z]),
    // rust: attacker_species: None,
}
    // rust: for wing in &f.wings {
    // rust: if wing.intersects(bounds) {
    // rust: let dx = m.position.x - f.center.0;
    // rust: let dz = m.position.z - f.center.1;
    // rust: let dd = (dx * dx + dz * dz).max(0.1);
    // rust: m.velocity.x += dx / dd * 4.0;
    // rust: m.velocity.y += f64::from(0.2_f32);
    // rust: m.velocity.z += dz / dd * 4.0;
    // rust: if !f.sitting
    // rust: && teams_allow
    // rust: && m.ai.last_hurt_by_time < (m.age as i32).saturating_sub(2)
    // rust: {
    // rust: m.damage(5.0, source);
}
}
}
    // rust: if teams_allow {
    // rust: for head in &f.heads {
    // rust: if head.intersects(bounds) {
    // rust: m.damage(10.0, source);
}
}
}
}

    // rust: mod tests {
//     use super::*;
pub fn box_at(x: f64) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Aabb::new(Vec3::new(x, -1.0, -1.0), Vec3::new(x + 2.0, 3.0, 1.0))
}
pub fn setup() ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut m = Mob::new(
    // rust: 22,
    // rust: crate::mobs::sensor_scan_tests::kind(),
    // rust: Vec3::new(1.0, 0.0, 0.0),
    // rust: 0.0,
    // rust: );
    // rust: m.health = 40.0;
    // rust: m.age = 100;
    // rust: let f = Frame {
    // rust: dragon_id: 99,
    // rust: origin: Vec3::ZERO,
    // rust: center: (0.0, 0.0),
    // rust: wings: [box_at(0.0), box_at(100.0)],
    // rust: heads: [box_at(100.0), box_at(100.0)],
    // rust: sitting: false,
    // rust: recently_hurt: false,
}
    // rust: (m, f)
}
pub fn flying_wing_hurts_and_names_the_dragon() void {
}
    // rust: let (mut m, f) = setup();
    // rust: contact(&mut m, &f, true);
    // rust: assert_eq!(m.health, 35.0);
    // rust: assert_eq!(m.ai.last_hurt_by, Some(Who::Mob(99)));
}
pub fn perched_wing_pushes_without_damage() void {
}
    // rust: let (mut m, mut f) = setup();
    // rust: f.sitting = true;
    // rust: contact(&mut m, &f, true);
    // rust: assert_eq!(m.health, 40.0);
    // rust: assert_eq!(m.velocity, Vec3::new(4.0, f64::from(0.2_f32), 0.0));
}
pub fn team_protection_keeps_push_but_blocks_damage() void {
}
    // rust: let (mut m, f) = setup();
    // rust: contact(&mut m, &f, false);
    // rust: assert_eq!(m.health, 40.0);
    // rust: assert_eq!(m.velocity, Vec3::new(4.0, f64::from(0.2_f32), 0.0));
}
pub fn hurt_dragon_does_not_contact_mobs() void {
}
    // rust: let (mut m, mut f) = setup();
    // rust: f.recently_hurt = true;
    // rust: contact(&mut m, &f, true);
    // rust: assert_eq!(m.health, 40.0);
    // rust: assert_eq!(m.velocity, Vec3::ZERO);
}
pub fn head_hurts_even_when_perched() void {
}
    // rust: let (mut m, mut f) = setup();
    // rust: f.sitting = true;
    // rust: f.wings = [box_at(100.0), box_at(100.0)];
    // rust: f.heads[0] = box_at(0.0);
    // rust: contact(&mut m, &f, true);
    // rust: assert_eq!(m.health, 30.0);
}
pub fn recent_mob_attack_suppresses_wing_damage() void {
}
    // rust: let (mut m, f) = setup();
    // rust: m.ai.last_hurt_by_time = 99;
    // rust: contact(&mut m, &f, true);
    // rust: assert_eq!(m.health, 40.0);
    // rust: assert_eq!(m.velocity, Vec3::new(4.0, f64::from(0.2_f32), 0.0));
}
}

    // rust: mod parity {
//     use super::*;
pub fn contact_transcript() void {
}
    // rust: let mut rows = Vec::new();
    // rust: for name in [
    // rust: "flying",
    // rust: "sitting",
    // rust: "two_wings",
    // rust: "team",
    // rust: "head",
    // rust: "hurt_dragon",
    // rust: "recent_victim",
    // rust: ] {
    // rust: let mut kind = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: kind.id = "minecraft:enderman".into();
    // rust: kind.species = crate::mobs::Species::Enderman;
    // rust: kind.max_health = 40.0;
    // rust: kind.width = 0.6;
    // rust: kind.height = 2.9;
    // rust: let mut m = Mob::new(22, std::sync::Arc::new(kind), Vec3::new(1.0, 0.0, 0.0), 0.0);
    // rust: m.age = 100;
    // rust: let near = Aabb::new(Vec3::new(-10.0, -10.0, -10.0), Vec3::new(10.0, 10.0, 10.0));
    // rust: let far = near.move_by(Vec3::new(100.0, 0.0, 0.0));
    // rust: let mut f = Frame {
    // rust: dragon_id: 99,
    // rust: origin: Vec3::ZERO,
    // rust: center: (0.0, 0.0),
    // rust: wings: [near, far],
    // rust: heads: [far, far],
    // rust: sitting: name == "sitting",
    // rust: recently_hurt: name == "hurt_dragon",
}
    // rust: if name == "two_wings" {
    // rust: f.wings = [near, near];
}
    // rust: if name == "head" {
    // rust: f.wings = [far, far];
    // rust: f.heads = [near, far];
}
    // rust: if name == "recent_victim" {
    // rust: m.ai.last_hurt_by = Some(Who::Mob(99));
    // rust: m.ai.last_hurt_by_time = 99;
}
    // rust: contact(&mut m, &f, name != "team");
    // rust: rows.push(serde_json::json!({"case":name,"health":m.health,"velocity":[m.velocity.x,m.velocity.y,m.velocity.z],"revenge":m.ai.last_hurt_by==Some(Who::Mob(99))}));
}
    // rust: let path = std::env::var_os("HORIZON_DRAGON_CONTACT_OUTPUT").expect("parity output path");
    // rust: std::fs::write(path, serde_json::to_vec_pretty(&rows).unwrap()).unwrap();
}
}
