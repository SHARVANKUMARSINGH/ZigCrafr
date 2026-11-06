//! Transpiled from Horizon Rust crate
package horizon_client_phantom

import "core:fmt"
import "core:mem"
import "core:math"

// Phantoms: circling an anchor high above, swooping at the player every
// eight to twelve seconds, scared off by cats (`Phantom`).
// use super::{
    // rust: Mob, MobEvent, MobWorld, Species, Who,
    // rust: control::MoveKind,
    // rust: goals::{Cx, Goal, MOVE, TARGET, goal_clone, reduced},
}
// use horizon_core::geometry::trig::Mth;
// use horizon_core::{geometry::Vec3, random::RandomSource};

// Phantom state in `Extra`: `flag` swooping, `home` the anchor,
// `vector` the move target, `attrs.speed` the move control's speed.
register :: proc(m: ^Mob) {
}
    // rust: m.ai.mov.kind = MoveKind::Custom;
    // rust: m.attrs.speed = 0.1;
    // rust: m.extra.home = Some([
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32 + 5,
    // rust: m.position.z.floor() as i32,
    // rust: ]);
    // rust: m.ai.goals.add(1, AttackStrategy { next_sweep: 0 });
    // rust: m.ai.goals.add(
    // rust: 2,
    // rust: SweepAttack {
    // rust: scared: false,
    // rust: cat_search: 0,
    // rust: },
    // rust: );
    // rust: m.ai.goals.add(3, CircleAroundAnchor::default());
    // rust: m.ai.targets.add(
    // rust: 1,
    // rust: AttackPlayerTarget {
    // rust: next_scan: reduced(20),
    // rust: },
    // rust: );
}
// `Phantom.setPhantomSize` with `updatePhantomSizeInfo`: the size, clamped to
// 0 to 64, and an attack damage base of 6 plus the size. The box and the
// drawn model grow by `1 + 0.15 * size` (the mob's dimensions, `PhantomRenderer.scale`).
set_size :: proc(m: ^Mob, size: i32) {
}
//     use super::finalize::{Attr, set_base};
    // rust: let size = size.clamp(0, 64);
    // rust: if size != m.extra.size {
    // rust: m.extra.size = size;
    // rust: set_base(m, Attr::AttackDamage, f64::from(6 + size));
}
}
can_attack :: proc(w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: w.player
    // rust: .as_ref()
    // rust: .is_some_and(|p| p.alive && !p.creative && !p.spectator)
}
// `Phantom.canAttack(level, player, TargetingConditions.DEFAULT)`: as above,
// and in sight (`Sensing.hasLineOfSight`), so a roof or a wall hides the player.
can_attack_seen :: proc(m: ^Mob, w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: can_attack(w) && m.sees(w, Who::Player)
}
sea_level :: proc() -> i {
    // Ported from Horizon
    return {}
}
    // rust: 63
}
// `PhantomAttackPlayerTargetGoal`: every three seconds, the player
// within 16 blocks across and 64 up or down.
AttackPlayerTarget :: struct {
    next_scan: i32,
}
    // rust: impl Goal for AttackPlayerTarget {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: TARGET
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.next_scan > 0 {
    // rust: self.next_scan -= 1;
    // rust: return false;
}
    // rust: self.next_scan = reduced(60);
    // rust: let Some(p) = &cx.w.player else {
    // rust: return false;
}
    // rust: let d = p.position;
    // rust: let near = (d.x - m.position.x).abs() <= 16.0 + f64::from(m.width())
    // rust: && (d.y - m.position.y).abs() <= 64.0
    // rust: && (d.z - m.position.z).abs() <= 16.0 + f64::from(m.width());
    // rust: if near && can_attack_seen(m, cx.w) {
    // rust: m.ai.target = Some(Who::Player);
    // rust: return true;
}
    // rust: false
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.ai.target.is_some() && can_attack_seen(m, cx.w)
}
}
// `PhantomAttackStrategyGoal`: circle, then swoop.
AttackStrategy :: struct {
    next_sweep: i32,
}
    // rust: impl AttackStrategy {
anchor_above_target :: proc(m: ^Mob, cx: ^Cx) {
}
    // rust: let Some(t) = m.ai.target.and_then(|t| cx.w.target_info(t)) else {
    // rust: return;
}
    // rust: let y = (t.position.y.floor() as i32 + 20 + m.random.next_int_bound(20).unwrap_or(0))
    // rust: .max(sea_level() + 1);
    // rust: m.extra.home = Some([t.position.x.floor() as i32, y, t.position.z.floor() as i32]);
}
}
    // rust: impl Goal for AttackStrategy {
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
    // rust: m.ai.target.is_some() && can_attack_seen(m, cx.w)
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.next_sweep = reduced(10);
    // rust: m.extra.flag = false;
    // rust: Self::anchor_above_target(m, cx);
}
stop :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if let Some(a) = m.extra.home {
    // rust: let top = cx.w.motion_blocking_height(a[0], a[2]);
    // rust: m.extra.home = Some([
    // rust: a[0],
    // rust: top + 10 + m.random.next_int_bound(20).unwrap_or(0),
    // rust: a[2],
    // rust: ]);
}
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if !m.extra.flag {
    // rust: self.next_sweep -= 1;
    // rust: if self.next_sweep <= 0 {
    // rust: m.extra.flag = true;
    // rust: Self::anchor_above_target(m, cx);
    // rust: self.next_sweep = reduced((8 + m.random.next_int_bound(4).unwrap_or(0)) * 20);
    // rust: let pitch = 0.95 + m.random.next_float() * 0.1;
    // rust: cx.events.push(MobEvent::Sound(
    // rust: "entity.phantom.swoop",
    // rust: m.center(),
    // rust: 10.0,
    // rust: pitch,
    // rust: ));
}
}
}
}
// `PhantomCircleAroundAnchorGoal`.
CircleAroundAnchor :: struct {
    angle: f32,
    distance: f32,
    height: f32,
    clockwise: f32,
}
    // rust: impl CircleAroundAnchor {
select_next :: proc(self: ^Self, m: ^Mob) {
}
    // rust: let a = *m.extra.home.get_or_insert([
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ]);
    // rust: self.angle += self.clockwise * 15.0f32.to_radians();
    // rust: m.extra.vector = [
    // rust: f64::from(a[0]) + f64::from(self.distance * self.angle.mcos()),
    // rust: f64::from(a[1]) + f64::from(-4.0 + self.height),
    // rust: f64::from(a[2]) + f64::from(self.distance * self.angle.msin()),
    // rust: ];
}
}
empty :: proc(w: ^MobWorld, x: i32, y: i32, z: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: w.facts.get(w.world.block(x, y, z)).name.as_ref() == "minecraft:air"
}
    // rust: impl Goal for CircleAroundAnchor {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE
}
can_use :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.ai.target.is_none() || !m.extra.flag
}
start :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: self.distance = 5.0 + m.random.next_float() * 10.0;
    // rust: self.height = -4.0 + m.random.next_float() * 9.0;
    // rust: self.clockwise = if m.random.next_int_bound(2).unwrap_or(0) == 0 {
    // rust: 1.0
    // rust: } else {
    // rust: -1.0
}
    // rust: self.select_next(m);
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if m.random.next_int_bound(reduced(350)).unwrap_or(1) == 0 {
    // rust: self.height = -4.0 + m.random.next_float() * 9.0;
}
    // rust: if m.random.next_int_bound(reduced(250)).unwrap_or(1) == 0 {
    // rust: self.distance += 1.0;
    // rust: if self.distance > 15.0 {
    // rust: self.distance = 5.0;
    // rust: self.clockwise = -self.clockwise;
}
}
    // rust: if m.random.next_int_bound(reduced(450)).unwrap_or(1) == 0 {
    // rust: self.angle = m.random.next_float() * 2.0 * std::f32::consts::PI;
    // rust: self.select_next(m);
}
    // rust: let t = m.extra.vector;
    // rust: let d2 = (t[0] - m.position.x).powi(2)
    // rust: + (t[1] - m.position.y).powi(2)
    // rust: + (t[2] - m.position.z).powi(2);
    // rust: if d2 < 4.0 {
    // rust: self.select_next(m);
}
    // rust: let (x, y, z) = (
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: );
    // rust: if m.extra.vector[1] < m.position.y && !empty(cx.w, x, y - 1, z) {
    // rust: self.height = self.height.max(1.0);
    // rust: self.select_next(m);
}
    // rust: if m.extra.vector[1] > m.position.y && !empty(cx.w, x, y + 1, z) {
    // rust: self.height = self.height.min(-1.0);
    // rust: self.select_next(m);
}
}
}
// `PhantomSweepAttackGoal`: dive at the target, bite on contact.
SweepAttack :: struct {
    scared: bool,
    cat_search: u32,
}
    // rust: impl Goal for SweepAttack {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE
}
can_use :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.ai.target.is_some() && m.extra.flag
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !can_attack(cx.w) || m.ai.target.is_none() || !m.extra.flag {
    // rust: return false;
}
    // rust: if m.age > self.cat_search {
    // rust: self.cat_search = m.age + 20;
    // rust: let cats: Vec<u32> =
    // rust: cx.w.nearby(m.position, 16.0, |s| s.species == Species::Cat && s.alive)
    // rust: .map(|s| s.id)
    // rust: .collect();
    // rust: for cat in &cats {
    // rust: cx.events.push(MobEvent::Hiss { mob: *cat });
}
    // rust: self.scared = !cats.is_empty();
}
    // rust: !self.scared
}
stop :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: m.ai.target = None;
    // rust: m.extra.flag = false;
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let Some(who) = m.ai.target else {
    // rust: return;
}
    // rust: let Some(t) = cx.w.target_info(who) else {
    // rust: return;
}
    // rust: let mid = (t.bounds.min_position().y + t.bounds.max_position().y) * 0.5;
    // rust: m.extra.vector = [t.position.x, mid, t.position.z];
    // rust: let reach = m.bounds().inflate(Vec3::new(0.2, 0.2, 0.2));
    // rust: if reach.intersects(t.bounds) {
    // rust: super::ai::do_hurt_target(m, who, cx);
    // rust: m.extra.flag = false;
            // LevelEvent 1039: the bite.
    // rust: cx.events
    // rust: .push(MobEvent::Sound("entity.phantom.bite", m.center(), 1.0, 1.0));
    // rust: } else if m.horizontal_collision || m.hurt_time > 0 {
    // rust: m.extra.flag = false;
}
}
}
approach :: proc(from: f32, to: f32, step: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if from < to {
    // rust: (from + step).min(to)
    // rust: } else {
    // rust: (from - step).max(to)
}
}
wrap :: proc(d: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let r = d.rem_euclid(360.0);
    // rust: if r >= 180.0 { r - 360.0 } else { r }
}
// `PhantomMoveControl`: bank toward the move target, faster on a straight
// line.
move_control :: proc(m: ^Mob) {
}
    // rust: let mut speed = m.attrs.speed as f32;
    // rust: if m.horizontal_collision {
    // rust: m.yaw += 180.0;
    // rust: speed = 0.1;
}
    // rust: let t = m.extra.vector;
    // rust: let (mut dx, dy, mut dz) = (
    // rust: t[0] - m.position.x,
    // rust: t[1] - m.position.y,
    // rust: t[2] - m.position.z,
    // rust: );
    // rust: let mut sd = (dx * dx + dz * dz).sqrt();
    // rust: if sd.abs() > 1.0e-5 {
    // rust: let scale = 1.0 - (dy * 0.7).abs() / sd;
    // rust: dx *= scale;
    // rust: dz *= scale;
    // rust: sd = (dx * dx + dz * dz).sqrt();
    // rust: let sd2 = (dx * dx + dz * dz + dy * dy).sqrt();
    // rust: let prev = m.yaw;
    // rust: let angle = dz.atan2(dx) as f32;
    // rust: let a = wrap(m.yaw + 90.0);
    // rust: let b = wrap(angle.to_degrees());
        // Mth.approachDegrees
    // rust: let diff = wrap(b - a);
    // rust: m.yaw = a + diff.clamp(-4.0, 4.0) - 90.0;
    // rust: m.body_yaw = m.yaw;
    // rust: if wrap(prev - m.yaw).abs() < 3.0 {
    // rust: speed = approach(speed, 1.8, 0.005 * (1.8 / speed));
    // rust: } else {
    // rust: speed = approach(speed, 0.2, 0.025);
}
    // rust: let x_rot = -((-dy).atan2(sd) as f32).to_degrees();
    // rust: m.head_pitch = x_rot;
    // rust: let move_angle = (m.yaw + 90.0).to_radians();
    // rust: let tx = f64::from(speed * move_angle.mcos()) * (dx / sd2).abs();
    // rust: let tz = f64::from(speed * move_angle.msin()) * (dz / sd2).abs();
    // rust: let ty = f64::from(speed * x_rot.to_radians().msin()) * (dy / sd2).abs();
    // rust: let v = m.velocity;
    // rust: m.velocity = Vec3::new(
    // rust: v.x + (tx - v.x) * 0.2,
    // rust: v.y + (ty - v.y) * 0.2,
    // rust: v.z + (tz - v.z) * 0.2,
    // rust: );
}
    // rust: m.attrs.speed = f64::from(speed);
    // PhantomBodyRotationControl: the head follows the body.
    // rust: m.head_yaw = m.body_yaw;
}
// `PhantomModel.setupAnim` (flap time offset by the id).
anim :: proc(m: ^Mob, s: ^super::anim::State, p: ^super::anim::Poses) {
}
    // rust: let flap = (m.id as f32 * 3.0 + s.age) * 7.448_451_f32.to_radians();
    // rust: let wing = flap.mcos() * 16.0f32.to_radians();
    // rust: p.zrot("left_wing_base", wing);
    // rust: p.zrot("left_wing_tip", wing);
    // rust: p.zrot("right_wing_base", -wing);
    // rust: p.zrot("right_wing_tip", -wing);
    // rust: let tail = -(5.0 + (flap * 2.0).mcos() * 5.0f32).to_radians();
    // rust: p.xrot("tail_base", tail);
    // rust: p.xrot("tail_tip", tail);
}
// The flap sound when a wingbeat begins (`Phantom.isFlapping`).
flap_sound :: proc(m: ^Mob, events: ^[dynamic]MobEvent) {
}
    // rust: let t = m.id as f32 * 3.0 + m.age as f32;
    // rust: let a = (t * 7.448_451_f32.to_radians() + std::f32::consts::PI).mcos();
    // rust: let b = ((t + 1.0) * 7.448_451_f32.to_radians() + std::f32::consts::PI).mcos();
    // rust: if a > 0.0 && b <= 0.0 {
    // rust: events.push(MobEvent::Sound(
    // rust: "entity.phantom.flap",
    // rust: m.center(),
    // rust: 0.95 + 0.05,
    // rust: 0.95,
    // rust: ));
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::mobs::world::{test_player, with_built_test_world};

    // The press geometry shared by the pane tests (#4928): a pane wall at
    // x=2 (its post spans x 2.4375..2.5625), the player pressed against its
    // east face at (2.8625, 64, 2.5) and the phantom pressed against the
    // west face at (1.9875, 64.2, 2.5), so the two boxes are 0.125 (the
    // pane's thickness) apart and `inflate(0.2)` reaches through.
    // rust: fn press_setup(
    // rust: wall_top: i32,
    // rust: ) -> impl FnOnce(&mut crate::world::World, &horizon_world::registry::BlockRegistry) {
    // rust: move |world, registry| {
    // rust: for x in -1..=1 {
    // rust: for z in -1..=1 {
    // rust: world.chunks.insert(
    // rust: (x, z),
    // rust: std::sync::Arc::new(crate::chunk::Chunk::empty(x, z)),
    // rust: );
}
}
    // rust: let pane = registry.default_state("minecraft:glass_pane").unwrap();
    // rust: for y in 64..wall_top {
    // rust: world.set(2, y, 2, pane).unwrap();
}
}
}

    // The swoop's bite is a plain box check (`PhantomSweepAttackGoal.tick`:
    // `getBoundingBox().inflate(0.2).intersects(target)`), so a phantom
    // pressed against the far side of a foot-high pane wall — its eye-ray
    // passes over the wall, so the player stays a valid target — bites
    // through the pane, exactly as vanilla 26.3 does.
a_phantom_bites_a_player_pressed_behind_a_foot_high_pane_wall :: proc() {
}
    // rust: with_built_test_world(&[], press_setup(65), |w, types| {
    // rust: let mut w = w.clone();
    // rust: w.player = Some(test_player(Vec3::new(2.8625, 64.0, 2.5)));
    // rust: let kind = std::sync::Arc::new(types.types["minecraft:phantom"].clone());
    // rust: let mut m = Mob::new(1, kind, Vec3::new(1.9875, 64.2, 2.5), 0.0);
    // rust: register(&mut m);
            // The eye-ray clears the wall, so targeting holds (#4929's
            // rule is about roofs and full walls, not foot walls).
    // rust: let mut target = AttackPlayerTarget { next_scan: 0 };
    // rust: let mut events = Vec::new();
    // rust: let mut lr = horizon_core::random::LegacyRandom::new(0);
    // rust: let mut cx = Cx {
    // rust: w: &w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
}
    // rust: m.ai.seen_cache.clear();
    // rust: assert!(target.can_use(&mut m, &mut cx));
            // Swooping (`PhantomAttackStrategyGoal` set the phase), the
            // sweep bites on the box overlap alone.
    // rust: m.ai.target = Some(Who::Player);
    // rust: m.extra.flag = true;
    // rust: let mut sweep = SweepAttack {
    // rust: scared: false,
    // rust: cat_search: 0,
}
    // rust: let mut events = Vec::new();
    // rust: let mut cx = Cx {
    // rust: w: &w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
}
    // rust: sweep.tick(&mut m, &mut cx);
    // rust: assert!(
    // rust: events
    // rust: .iter()
    // rust: .any(|e| matches!(e, MobEvent::AttackPlayer(_, _))),
    // rust: "the swoop should bite through the pane: {events:?}"
    // rust: );
    // rust: });
}

    // A window-height (three-block) pane wall blocks the eye-ray, so
    // `PhantomAttackPlayerTargetGoal` never takes the player pressed behind
    // it (`TargetingConditions` line of sight) — that gate is what protects
    // the player, in Horizon as in vanilla 26.3; the bite's box check alone
    // would reach through the 0.125-thick pane.
a_phantom_cannot_target_a_player_behind_a_window_of_panes :: proc() {
}
    // rust: with_built_test_world(&[], press_setup(67), |w, types| {
    // rust: let mut w = w.clone();
    // rust: w.player = Some(test_player(Vec3::new(2.8625, 64.0, 2.5)));
    // rust: let kind = std::sync::Arc::new(types.types["minecraft:phantom"].clone());
    // rust: let mut m = Mob::new(1, kind, Vec3::new(1.9875, 64.2, 2.5), 0.0);
    // rust: register(&mut m);
    // rust: let mut target = AttackPlayerTarget { next_scan: 0 };
    // rust: let mut events = Vec::new();
    // rust: let mut lr = horizon_core::random::LegacyRandom::new(0);
    // rust: let mut cx = Cx {
    // rust: w: &w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
}
    // rust: m.ai.seen_cache.clear();
    // rust: assert!(!target.can_use(&mut m, &mut cx));
    // rust: m.ai.target = Some(Who::Player);
    // rust: m.ai.seen_cache.clear();
    // rust: assert!(!target.can_continue(&mut m, &mut cx));
    // rust: });
}

    // `TargetingConditions.DEFAULT` checks line of sight (#4929): a phantom
    // above takes a player in the open, not one boxed in stone or glass.
a_phantom_cannot_target_a_player_it_cannot_see :: proc() {
}
    // rust: for roof in [None, Some("minecraft:stone"), Some("minecraft:glass")] {
    // rust: with_built_test_world(
    // rust: &[],
    // rust: |world, registry| {
    // rust: for x in -1..=1 {
    // rust: for z in -1..=1 {
    // rust: world.chunks.insert(
    // rust: (x, z),
    // rust: std::sync::Arc::new(crate::chunk::Chunk::empty(x, z)),
    // rust: );
}
}
    // rust: let Some(block) = roof.and_then(|b| registry.default_state(b)) else {
    // rust: return;
}
                    // A hollow 5x5x5 box around the player at (0.5, 64, 0.5).
    // rust: for x in -2i32..=2 {
    // rust: for y in 63..=67 {
    // rust: for z in -2i32..=2 {
    // rust: let shell = x.abs() == 2 || z.abs() == 2 || y == 63 || y == 67;
    // rust: if shell {
    // rust: world.set(x, y, z, block).unwrap();
}
}
}
}
    // rust: },
    // rust: |w, types| {
    // rust: let mut w = w.clone();
    // rust: w.player = Some(test_player(Vec3::new(0.5, 64.0, 0.5)));
    // rust: let kind = std::sync::Arc::new(types.types["minecraft:phantom"].clone());
    // rust: let mut m = Mob::new(1, kind, Vec3::new(0.5, 80.0, 0.5), 0.0);
    // rust: let mut target = AttackPlayerTarget { next_scan: 0 };
    // rust: let mut events = Vec::new();
    // rust: let mut lr = horizon_core::random::LegacyRandom::new(0);
    // rust: let mut cx = Cx {
    // rust: w: &w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
}
    // rust: assert_eq!(target.can_use(&mut m, &mut cx), roof.is_none(), "{roof:?}");
    // rust: m.ai.target = Some(Who::Player);
    // rust: m.ai.seen_cache.clear();
    // rust: assert_eq!(
    // rust: target.can_continue(&mut m, &mut cx),
    // rust: roof.is_none(),
    // rust: "{roof:?}"
    // rust: );
    // rust: },
    // rust: );
}
}
}
