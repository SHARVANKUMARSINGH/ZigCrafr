//! Transpiled from Horizon Rust crate
package horizon_client_fangs

import "core:fmt"
import "core:mem"
import "core:math"

// Evoker fangs (`EvokerFangs`): rising out of the floor after a delay,
// biting what stands on them for 6 damage, sinking back after 22 ticks.
// use super::Game;
// use horizon_client::mobs::{Part, Species, anim::Poses};
// use horizon_client::particles::{ParticleOptions, ParticleType};
// use horizon_core::geometry::Vec3;
// use horizon_core::random::{LegacyRandom, RandomSource};
// use std::sync::Arc;

    // rust: pub(super) struct Fangs {
    // rust: pub id: u32,
    // rust: pub pos: [f64; 3],
    // rust: pub yaw: f32,
    // rust: pub warmup: i32,
    // rust: pub life: i32,
    // rust: pub owner: u32,
    // rust: pub started: bool,
    // `Entity.random`. The attack sound's pitch is its first draw.
    // rust: random: LegacyRandom,
}
// `EvokerFangs.handleEntityEvent`: `nextFloat() * 0.2 + 0.85`.
    // rust: pub(super) fn fang_attack_pitch(random: &mut impl RandomSource) -> f32 {
    // rust: random.next_float() * 0.2 + 0.85
}
// One of the twelve `crit` particles `EvokerFangs.tick` spawns on a client
// when `lifeTicks` hits 14. The box is 0.5 wide (`getBbWidth() * 0.5`).
    // rust: pub(super) fn fang_crit(random: &mut impl RandomSource, pos: [f64; 3]) -> ([f64; 3], [f64; 3]) {
    // rust: let half = 0.5 * 0.5;
    // rust: let x = pos[0] + (random.next_double() * 2.0 - 1.0) * half;
    // rust: let y = pos[1] + 0.05 + random.next_double();
    // rust: let z = pos[2] + (random.next_double() * 2.0 - 1.0) * half;
    // rust: let xd = (random.next_double() * 2.0 - 1.0) * 0.3;
    // rust: let yd = 0.3 + random.next_double() * 0.3;
    // rust: let zd = (random.next_double() * 2.0 - 1.0) * 0.3;
    // rust: ([x, y + 1.0, z], [xd, yd, zd])
}
    // rust: pub(super) struct FangState {
    // rust: pub list: Vec<Fangs>,
    // rust: model: Option<Arc<Part>>,
}
    // rust: impl Game<'_> {
    // rust: pub(super) fn add_fangs(&mut self, at: [f64; 3], yaw: f32, delay: i32, owner: u32) {
    // rust: self.next_entity += 1;
    // rust: self.insert_fangs(self.next_entity, at, yaw, delay, owner);
}

    // rust: pub(super) fn insert_fangs(&mut self, id: u32, at: [f64; 3], yaw: f32, delay: i32, owner: u32) {
    // rust: if self.fangs.model.is_none() {
    // rust: self.fangs.model = self.entity_models.evoker_fangs.clone();
}
    // rust: self.fangs.list.push(Fangs {
    // rust: id,
    // rust: pos: at,
    // rust: yaw,
    // rust: warmup: delay,
    // rust: life: 22,
    // rust: owner,
    // rust: started: false,
    // rust: random: horizon_client::mobs::entity_random(id, Vec3::new(at[0], at[1], at[2])),
    // rust: });
}
    // rust: pub(super) fn fangs_to_nbt(&self, f: &Fangs, uuid: [i32; 4]) -> horizon_world::nbt::Tag {
    // rust: horizon_client::entity_nbt::evoker_fangs_to_nbt(
    // rust: Vec3::new(f.pos[0], f.pos[1], f.pos[2]),
    // rust: f.yaw,
    // rust: f.warmup,
    // rust: self.persist.uuids.get(&f.owner).copied(),
    // rust: uuid,
    // rust: self.persist.raw.get(&f.id),
    // rust: )
}
    // rust: pub(super) fn loaded_fangs_owner(&self, tag: &horizon_world::nbt::Tag) -> u32 {
    // rust: match tag.get("Owner") {
    // rust: Some(horizon_world::nbt::Tag::IntArray(v)) => v.as_slice().try_into().ok(),
    // rust: _ => None,
}
    // rust: .and_then(|u| self.mob_by_uuid(u))
    // rust: .unwrap_or(0)
}
    // `EvokerFangs.handleEntityEvent`: only event 4 starts a client attack.
    // `playLocalSound` at `nextFloat() * 0.2 + 0.85`. The fangs this client
    // tracks carry no Silent flag, so the sound always plays.
    // rust: pub(super) fn remote_fangs_event(&mut self, id: u32, event: i8) {
    // rust: let sound = self
    // rust: .fangs
    // rust: .list
    // rust: .iter_mut()
    // rust: .find(|f| f.id == id)
    // rust: .and_then(|f| {
    // rust: if event != 4 {
    // rust: return None;
}
    // rust: f.started = true;
    // rust: let pitch = fang_attack_pitch(&mut f.random);
    // rust: Some((f.pos, pitch))
    // rust: });
    // rust: if let Some((pos, pitch)) = sound {
    // rust: self.audio.play_unshared(
    // rust: "minecraft:entity.evoker_fangs.attack",
    // rust: Some(pos),
    // rust: 1.0,
    // rust: pitch,
    // rust: );
}
}

    // `EvokerFangs.tick`: clients only advance animation, never damage or discard.
    // At life 14, twelve `crit` particles (`ATTACK_TRIGGER_TICKS`).
    // rust: pub(super) fn tick_remote_fangs(&mut self) {
    // rust: let mut bursts = Vec::new();
    // rust: for f in &mut self.fangs.list {
    // rust: if f.started {
    // rust: f.life -= 1;
    // rust: if f.life == 14 {
    // rust: let mut crits = Vec::with_capacity(12);
    // rust: for _ in 0..12 {
    // rust: crits.push(fang_crit(&mut f.random, f.pos));
}
    // rust: bursts.push(crits);
}
}
}
    // rust: let crit = ParticleOptions::simple(ParticleType::Crit);
    // rust: for crits in bursts {
    // rust: for (at, velocity) in crits {
    // rust: self.particles.add(&crit, at, velocity);
}
}
}

    // `EvokerFangs.tick`.
    // rust: pub(super) fn tick_fangs(&mut self) {
    // rust: let mut list = std::mem::take(&mut self.fangs.list);
    // rust: list.retain_mut(|f| {
    // rust: f.warmup = f.warmup.wrapping_sub(1);
    // rust: if f.warmup >= 0 {
    // rust: return true;
}
    // rust: if f.warmup == -8 {
    // rust: self.fangs_bite(f);
}
    // rust: if !f.started {
    // rust: f.started = true;
    // rust: self.lan_entity_event(f.id as i32, 4, f.pos);
    // rust: let pitch = fang_attack_pitch(&mut f.random);
    // rust: self.audio.play_unshared(
    // rust: "minecraft:entity.evoker_fangs.attack",
    // rust: Some(f.pos),
    // rust: 1.0,
    // rust: pitch,
    // rust: );
}
    // rust: f.life -= 1;
    // rust: f.life >= 0
    // rust: });
    // rust: self.fangs.list = list;
}
    // `dealDamageTo` everything alive in the fangs' box (0.5 x 0.8,
    // inflated 0.2 sideways) but the evoker's allies.
fangs_bite :: proc(self: ^Self, f: ^Fangs) {
}
    // rust: let half = 0.25 + 0.2;
    // rust: let lo = Vec3::new(f.pos[0] - half, f.pos[1], f.pos[2] - half);
    // rust: let hi = Vec3::new(f.pos[0] + half, f.pos[1] + 0.8, f.pos[2] + half);
    // rust: let b = horizon_core::geometry::Aabb::new(lo, hi);
        // Every player in the box, the server's players too.
    // rust: let pos = f.pos;
        // `EvokerFangs.dealDamageTo`: indirectMagic(fangs, owner) while the
        // owner lives, plain magic (nobody to name) once it is gone.
    // rust: let owner = self
    // rust: .mobs
    // rust: .iter()
    // rust: .any(|m| m.id == f.owner && m.alive())
    // rust: .then_some(f.owner);
    // rust: let bite = move |g: &mut Self| {
    // rust: if let Some(p) = g.player_view()
    // rust: && p.alive
    // rust: && p.bounds.intersects(b)
    // rust: {
    // rust: let kind = match owner {
    // rust: Some(_) => "minecraft:indirect_magic",
    // rust: None => "minecraft:magic",
}
    // rust: g.mob_hits_player_caused(6.0, pos, kind, owner);
}
}
    // rust: bite(self);
    // rust: self.each_guest_hit(bite);
        // `Entity.isAlliedTo`: the owner's or the target's
        // `considersEntityAsAlly`, teams included.
    // rust: let teams = self.mob_teams();
    // rust: let illagers: Vec<u32> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| is_illager(m.species()))
    // rust: .map(|m| m.id)
    // rust: .collect();
        // A missing owner hurts everyone (`currentOwner == null`).
    // rust: let owner_known = illagers.contains(&f.owner);
    // rust: let team_of = |id: u32| teams.of(horizon_client::mobs::Who::Mob(id));
    // rust: let allies: Vec<u32> = if owner_known {
    // rust: self.mobs
    // rust: .iter()
    // rust: .filter(|m| {
    // rust: let other = Party {
    // rust: illager: is_illager(m.species()),
    // rust: team: team_of(m.id),
}
    // rust: let root = (m.species() == Species::Vex)
    // rust: .then_some(m.extra.counter2 as u32)
    // rust: .filter(|r| illagers.contains(r))
    // rust: .map(|r| {
    // rust: (
    // rust: r == f.owner,
    // rust: Party {
    // rust: illager: true,
    // rust: team: team_of(r),
    // rust: },
    // rust: )
    // rust: });
    // rust: let owner = Party {
    // rust: illager: true,
    // rust: team: team_of(f.owner),
}
    // rust: fangs_allied(owner, other, root)
    // rust: })
    // rust: .map(|m| m.id)
    // rust: .collect()
    // rust: } else {
    // rust: Vec::new()
}
    // rust: for m in &mut self.mobs {
    // rust: let ally = allies.contains(&m.id);
    // rust: if m.id != f.owner && !ally && m.alive() && m.bounds().intersects(b) {
    // rust: m.damage(
    // rust: 6.0,
    // rust: horizon_client::mobs::Damage {
    // rust: kind: horizon_client::mobs::DamageKind::Magic,
    // rust: attacker: owner.map(horizon_client::mobs::Who::Mob),
    // rust: from: Some(f.pos),
    // rust: attacker_species: None,
    // rust: },
    // rust: );
}
}
}
    // `EvokerFangsRenderer`: the jaws snapping up and closing.
    // rust: pub(super) fn fangs_geometry(
    // rust: &self,
    // rust: camera: glam::DVec3,
    // rust: alpha: f64,
    // rust: out: &mut Vec<horizon_client::mesher::Vertex>,
    // rust: ) {
    // rust: let Some(model) = self.fangs.model.as_ref() else {
    // rust: return;
}
    // rust: let Some(r) = self
    // rust: .gui
    // rust: .atlas
    // rust: .sprites
    // rust: .get("entity/illager/evoker_fangs")
    // rust: .copied()
    // rust: else {
    // rust: return;
}
    // rust: let partial = alpha as f32;
    // rust: for f in &self.fangs.list {
    // rust: if !f.started {
    // rust: continue;
}
            // getAnimationProgress.
    // rust: let i = f.life - 2;
    // rust: let bite = if i <= 0 {
    // rust: 1.0
    // rust: } else {
    // rust: 1.0 - (i as f32 - partial) / 20.0
}
    // rust: if bite == 0.0 {
    // rust: continue;
}
    // rust: let mut poses = Poses::new(model);
    // rust: let amount = (bite * 2.0).min(1.0);
    // rust: let amount = 1.0 - amount * amount * amount;
    // rust: let pi = std::f32::consts::PI;
    // rust: p_zrot(&mut poses, "upper_jaw", pi - amount * 0.35 * pi);
    // rust: p_zrot(&mut poses, "lower_jaw", pi + amount * 0.35 * pi);
    // rust: poses.get("base")[1] -= (bite + (bite * 2.7).sin()) * 7.2;
    // rust: let pre = if bite > 0.9 { (1.0 - bite) / 0.1 } else { 1.0 };
    // rust: let root = poses.get("root");
    // rust: root[1] = 24.0 - 20.0 * pre;
    // rust: root[6] = pre;
    // rust: root[7] = pre;
    // rust: root[8] = pre;
    // rust: let light = self.world.light(
    // rust: f.pos[0].floor() as i32,
    // rust: f.pos[1].floor() as i32,
    // rust: f.pos[2].floor() as i32,
    // rust: );
    // rust: let packed = (u32::from(light >> 4) * 16) | ((u32::from(light & 15) * 16) << 8);
    // rust: let base =
    // rust: glam::Mat4::from_translation((glam::DVec3::from_array(f.pos) - camera).as_vec3())
    // rust: * glam::Mat4::from_rotation_y((90.0 - f.yaw).to_radians())
    // rust: * glam::Mat4::from_scale(glam::Vec3::new(-1.0, -1.0, 1.0))
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, -1.501, 0.0));
    // rust: horizon_client::mobs::render::draw(
    // rust: model,
    // rust: base,
    // rust: &poses,
    // rust: [r.u0, r.v0, r.u1, r.v1],
    // rust: 0xFFFF_FFFF,
    // rust: packed,
    // rust: 0,
    // rust: out,
    // rust: );
}
}
}
// `EntityTypeTags.ILLAGER` members, the types of `ILLAGER_FRIENDS`.
is_illager :: proc(s: Species) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: s,
    // rust: Species::Evoker | Species::Illusioner | Species::Pillager | Species::Vindicator
    // rust: )
}
// One side of an ally check: whether it is an illager and its team.
Party :: struct {
    illager: bool,
    team: Maybe(^'a horizon_client::scoreboard::Team),
}
// `AbstractIllager.considersEntityAsAlly(other)`: the base rule (the teams
// are allied), or an illager friend while both have no team.
illager_considers :: proc(me: Party, other: Party) -> b {
    // Ported from Horizon
    return {}
}
    // rust: horizon_client::scoreboard::teams_allied(me.team, other.team)
    // rust: || other.illager && me.team.is_none() && other.team.is_none()
}
// `owner.isAlliedTo(other)` for an evoker owner: `Evoker.considersEntityAsAlly`
// either way round. `vex_root` is the root owner of a vex target (whether it
// is the owner itself, and its party); the owner treats such a vex as an ally
// when its root owner is.
fangs_allied :: proc(owner: Party, other: Party, vex_root: Option<(bool) {
}
    // rust: illager_considers(owner, other)
    // rust: || other.illager && illager_considers(other, owner)
    // rust: || !other.illager && horizon_client::scoreboard::teams_allied(other.team, owner.team)
    // rust: || vex_root.is_some_and(|(is_owner, root)| is_owner || illager_considers(owner, root))
}
p_zrot :: proc(p: ^Poses, part: string, v: f32) {
}
    // rust: p.zrot(part, v);
}
    // rust: mod tests {
//     use super::{Party, fang_attack_pitch, fang_crit, fangs_allied};
//     use horizon_core::random::LegacyRandom;

fang_attack_pitch_matches_the_vanilla_span :: proc() {
}
        // Java Random seed 1, first nextFloat() * 0.2 + 0.85, in f32.
    // rust: let mut random = LegacyRandom::new(1);
    // rust: let pitch = fang_attack_pitch(&mut random);
    // rust: assert!((pitch - 0.996_175_65).abs() < 1.0e-6, "{pitch}");
    // rust: assert!((0.85..1.05).contains(&pitch));
}

fang_crit_sits_above_the_jaws :: proc() {
}
        // Java Random seed 1, the first crit of the twelve. The y is
        // getY() + 0.05 + nextDouble(), then addParticle adds 1.
    // rust: let mut random = LegacyRandom::new(1);
    // rust: let (at, velocity) = fang_crit(&mut random, [2.0, 70.0, -4.0]);
    // rust: let expected_at = [
    // rust: 2.115_439_095_351_645_5,
    // rust: 71.460_080_811_492_2,
    // rust: -4.146_142_579_345_142,
    // rust: ];
    // rust: let expected_velocity = [
    // rust: -0.100_369_766_424_293_3,
    // rust: 0.590_326_772_827_236_1,
    // rust: -0.296_329_690_640_543_2,
    // rust: ];
    // rust: for i in 0..3 {
    // rust: assert!((at[i] - expected_at[i]).abs() < 1.0e-12, "{at:?}");
    // rust: assert!(
    // rust: (velocity[i] - expected_velocity[i]).abs() < 1.0e-12,
    // rust: "{velocity:?}"
    // rust: );
}
}

party :: proc(illager: bool, team: Maybe(^horizon_client::scoreboard::Team)) -> P {
    // Ported from Horizon
    return {}
}
    // rust: Party { illager, team }
}

fangs_allies_follow_teams_and_the_illager_tag :: proc() {
}
    // rust: let mut board = horizon_client::scoreboard::Scoreboard::default();
    // rust: board.add_team("red");
    // rust: board.add_team("blue");
    // rust: let red = board.team("red").unwrap();
    // rust: let blue = board.team("blue").unwrap();
    // rust: let evoker = |t| party(true, t);
        // Teamless illagers are friends.
    // rust: assert!(fangs_allied(evoker(None), party(true, None), None));
        // Different teams: the illager tag no longer applies.
    // rust: assert!(!fangs_allied(
    // rust: evoker(Some(red)),
    // rust: party(true, Some(blue)),
    // rust: None
    // rust: ));
        // One side with a team: still not allied.
    // rust: assert!(!fangs_allied(evoker(Some(red)), party(true, None), None));
        // The same team allies a non-illager mob.
    // rust: assert!(fangs_allied(
    // rust: evoker(Some(red)),
    // rust: party(false, Some(red)),
    // rust: None
    // rust: ));
    // rust: assert!(!fangs_allied(evoker(None), party(false, None), None));
        // A vex follows its root owner.
    // rust: assert!(fangs_allied(
    // rust: evoker(None),
    // rust: party(false, None),
    // rust: Some((true, evoker(None)))
    // rust: ));
    // rust: assert!(!fangs_allied(
    // rust: evoker(Some(red)),
    // rust: party(false, None),
    // rust: Some((false, party(true, Some(blue))))
    // rust: ));
}
}
