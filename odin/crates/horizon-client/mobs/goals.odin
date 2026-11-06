//! Transpiled from Horizon Rust crate
package horizon_client_goals

import "core:fmt"
import "core:mem"
import "core:math"

// Vanilla's `GoalSelector` (priorities, MOVE/LOOK/JUMP/TARGET control flags,
// interruption) and the shared goals of `net.minecraft.world.entity.ai.goal`.
// use super::{Mob, MobEvent, MobWorld, Seen, Species, Who, world::TargetInfo};
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3},
    // rust: jmath,
    // rust: random::{LegacyRandom, RandomSource},
}
// use std::sync::Arc;

MOVE :: 1
LOOK :: 2
JUMP :: 4
TARGET :: 8

// What goals may read and emit during a tick.
Cx :: struct {
    w: ^'a MobWorld<'w>,
    // The level's random (`level.getRandom()`), for the draws vanilla's
    // behaviours make from it rather than from the mob's own.
    lr: ^'a mut LegacyRandom,
    events: ^'a mut [dynamic]MobEvent,
}
    // rust: pub trait Goal: std::fmt::Debug {
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // A goal that draws its first start delay in its constructor (a schooling fish's
    // `FollowFlockLeaderGoal`): the delay again, when the mob's random is seeded afterwards.
set_start_delay :: proc(self: ^Self, _ticks: i32) {
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.can_use(m, cx)
}
interruptable :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
start :: proc(self: ^Self, _m: ^Mob, _cx: ^Cx) {
}
stop :: proc(self: ^Self, _m: ^Mob, _cx: ^Cx) {
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
tick :: proc(self: ^Self, _m: ^Mob, _cx: ^Cx) {
}
box_clone :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
    // The goal's name for debugging (`Goal.toString`).
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: std::any::type_name::<Self>()
    // rust: .rsplit("::")
    // rust: .next()
    // rust: .unwrap_or("Goal")
}
}
    // rust: impl Clone for Box<dyn Goal> {
clone :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.box_clone()
}
}
    // rust: macro_rules! goal_clone {
    // rust: () => {
box_clone :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
    // rust: Box::new(self.clone())
}
}
}
    // rust: pub(crate) use goal_clone;

// Goal.reducedTickDelay
reduced :: proc(ticks: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: (ticks + 1) / 2
}
adjusted :: proc(every_tick: bool, ticks: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if every_tick { ticks } else { reduced(ticks) }
}

Wrapped :: struct {
    priority: i32,
    goal: ^dyn Goal,
    running: bool,
}
GoalSelector :: struct {
    goals: [dynamic]Wrapped,
    locked: [Maybe(uint),
    disabled: u8,
}
    // rust: impl GoalSelector {
add :: proc(self: ^Self, priority: i32, goal: impl Goal + 'static) {
}
    // rust: self.goals.push(Wrapped {
    // rust: priority,
    // rust: goal: Box::new(goal),
    // rust: running: false,
    // rust: });
}
    // `Goal::set_start_delay` of the goal of this name.
set_start_delay :: proc(self: ^Self, name: string, ticks: i32) {
}
    // rust: for g in &mut self.goals {
    // rust: if g.goal.name() == name {
    // rust: g.goal.set_start_delay(ticks);
}
}
}
clear :: proc(self: ^Self) {
}
    // rust: self.goals.clear();
    // rust: self.locked = [None; 4];
}
running_names :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.goals
    // rust: .iter()
    // rust: .filter(|g| g.running)
    // rust: .map(|g| g.goal.name())
    // rust: .collect()
}
    // Whether a goal of this name is registered, running or not.
has :: proc(self: ^Self, name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.goals.iter().any(|g| g.goal.name() == name)
}
is_running :: proc(self: ^Self, name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.goals
    // rust: .iter()
    // rust: .any(|g| g.running && g.goal.name() == name)
}
stop :: proc(self: ^Self, i: uint, m: ^Mob, cx: ^Cx) {
}
    // rust: if self.goals[i].running {
    // rust: self.goals[i].running = false;
    // rust: self.goals[i].goal.stop(m, cx);
}
}
    // GoalSelector.tick
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: for i in 0..self.goals.len() {
    // rust: if self.goals[i].running
    // rust: && (self.goals[i].goal.flags() & self.disabled != 0
    // rust: || !self.goals[i].goal.can_continue(m, cx))
    // rust: {
    // rust: self.stop(i, m, cx);
}
}
    // rust: for slot in &mut self.locked {
    // rust: if slot.is_some_and(|i| !self.goals[i].running) {
    // rust: *slot = None;
}
}
    // rust: for i in 0..self.goals.len() {
    // rust: let flags = self.goals[i].goal.flags();
    // rust: if self.goals[i].running || flags & self.disabled != 0 {
    // rust: continue;
}
    // rust: let replaceable =
    // rust: (0..4)
    // rust: .filter(|b| flags & (1 << b) != 0)
    // rust: .all(|b| match self.locked[b] {
    // rust: None => true,
    // rust: Some(j) => {
    // rust: self.goals[j].goal.interruptable()
    // rust: && self.goals[i].priority < self.goals[j].priority
}
    // rust: });
    // rust: if !replaceable || !self.goals[i].goal.can_use(m, cx) {
    // rust: continue;
}
    // rust: for b in 0..4 {
    // rust: if flags & (1 << b) != 0 {
    // rust: if let Some(j) = self.locked[b] {
    // rust: self.stop(j, m, cx);
}
    // rust: self.locked[b] = Some(i);
}
}
    // rust: if !self.goals[i].running {
    // rust: self.goals[i].running = true;
    // rust: self.goals[i].goal.start(m, cx);
}
}
    // rust: self.tick_running(m, cx, true);
}
tick_running :: proc(self: ^Self, m: ^Mob, cx: ^Cx, force: bool) {
}
    // rust: for g in &mut self.goals {
    // rust: if g.running && (force || g.goal.every_tick()) {
    // rust: g.goal.tick(m, cx);
}
}
}
stop_all :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: for i in 0..self.goals.len() {
    // rust: self.stop(i, m, cx);
}
    // rust: self.locked = [None; 4];
}
}

// --- random positions (DefaultRandomPos / LandRandomPos / RandomPos) -------

// RandomPos.moveUpToAboveSolid: out of the solid blocks, then up to
// `above` more blocks of air.
move_up_to_above_solid :: proc(w: ^MobWorld, mut p: [i32; 3], above: i32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: if !w.solid(p[0], p[1], p[2]) {
    // rust: return p;
}
    // rust: p[1] += 1;
    // rust: while p[1] < w.world.top_y() && w.solid(p[0], p[1], p[2]) {
    // rust: p[1] += 1;
}
    // rust: let first = p[1];
    // rust: while p[1] < w.world.top_y() && p[1] - first < above {
    // rust: p[1] += 1;
    // rust: if w.solid(p[0], p[1], p[2]) {
    // rust: p[1] -= 1;
    // rust: break;
}
}
    // rust: p
}
// `Mob.isWithinHome(BlockPos)`.
within_home :: proc(c: [i32; 3], r: i32, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let d = |i: usize| i64::from(c[i] - p[i]);
    // rust: let r = i64::from(r);
    // rust: d(0) * d(0) + d(1) * d(1) + d(2) * d(2) < r * r
}

    // rust: impl Mob {
    // PathfinderMob.getWalkTargetValue.
walk_target_value :: proc(self: ^Self, w: ^MobWorld, p: [i32; 3]) -> f {
    // Ported from Horizon
    return {}
}
    // rust: super::ai::walk_target_value(self, w, p)
}
random_direction :: proc(self: ^Self, h: i32, v: i32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let x = self.random.next_int_bound(2 * h + 1).unwrap_or(0) - h;
    // rust: let y = self.random.next_int_bound(2 * v + 1).unwrap_or(0) - v;
    // rust: let z = self.random.next_int_bound(2 * h + 1).unwrap_or(0) - h;
    // rust: [x, y, z]
}
    // rust: fn random_direction_within(
    // rust: &mut self,
    // rust: min: f64,
    // rust: max: f64,
    // rust: v: i32,
    // rust: fly_height: i32,
    // rust: xd: f64,
    // rust: zd: f64,
    // rust: max_rad: f64,
    // rust: ) -> Option<[i32; 3]> {
    // rust: let center =
    // rust: horizon_core::geometry::trig::atan2(zd, xd) - f64::from(std::f32::consts::FRAC_PI_2);
    // rust: let yrad = center + f64::from(2.0 * self.random.next_float() - 1.0) * max_rad;
    // rust: let dist = (min + self.random.next_double().sqrt() * (max - min))
    // rust: * f64::from(std::f32::consts::SQRT_2);
    // rust: let xt = -dist * jmath::sin(yrad);
    // rust: let zt = dist * jmath::cos(yrad);
    // rust: if xt.abs() > max || zt.abs() > max {
    // rust: return None;
}
    // rust: let yt = self.random.next_int_bound(2 * v + 1).unwrap_or(0) - v + fly_height;
    // rust: Some([xt.floor() as i32, yt, zt.floor() as i32])
}
    // RandomPos.generateRandomPosTowardDirection: a mob with a home leans
    // half the distance back toward it.
toward :: proc(self: ^Self, h: f64, d: [i32; 3]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let (mut xt, mut zt) = (f64::from(d[0]), f64::from(d[2]));
    // rust: if let Some((c, _)) = self.ai.home
    // rust: && h > 1.0
    // rust: {
    // rust: if self.position.x > f64::from(c[0]) {
    // rust: xt -= self.random.next_double() * h / 2.0;
    // rust: } else {
    // rust: xt += self.random.next_double() * h / 2.0;
}
    // rust: if self.position.z > f64::from(c[2]) {
    // rust: zt -= self.random.next_double() * h / 2.0;
    // rust: } else {
    // rust: zt += self.random.next_double() * h / 2.0;
}
}
    // rust: [
    // rust: (xt + self.position.x).floor() as i32,
    // rust: (f64::from(d[1]) + self.position.y).floor() as i32,
    // rust: (zt + self.position.z).floor() as i32,
    // rust: ]
}
    // `GoalUtils.isRestricted(mobRestricted(mob, h), mob, pos)`: a mob
    // near its home keeps the positions it picks within it.
restricted :: proc(self: ^Self, h: f64, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some((c, r)) = self.ai.home else {
    // rust: return false;
}
    // rust: let near = {
    // rust: let d = |i: usize, v: f64| f64::from(c[i]) + 0.5 - v;
    // rust: let (x, y, z) = (
    // rust: d(0, self.position.x),
    // rust: d(1, self.position.y),
    // rust: d(2, self.position.z),
    // rust: );
    // rust: let reach = f64::from(r) + h + 1.0;
    // rust: x * x + y * y + z * z < reach * reach
}
    // rust: near && !within_home(c, r, p)
}
default_check :: proc(self: ^Self, w: ^MobWorld, h: f64, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: p[1] >= w.world.bottom_y()
    // rust: && p[1] < w.world.top_y()
    // rust: && !self.restricted(h, p)
    // rust: && self.stable_destination(w, p)
    // rust: && self.malus(w.path_type_static(p[0], p[1], p[2])) == 0.0
}
    // rust: fn pick_best(
    // rust: &mut self,
    // rust: w: &MobWorld,
    // rust: mut supplier: impl FnMut(&mut Self) -> Option<[i32; 3]>,
    // rust: ) -> Option<[f64; 3]> {
    // rust: let mut best: Option<[i32; 3]> = None;
    // rust: let mut best_weight = f64::NEG_INFINITY;
    // rust: for _ in 0..10 {
    // rust: if let Some(p) = supplier(self) {
    // rust: let v = f64::from(self.walk_target_value(w, p));
    // rust: if v > best_weight {
    // rust: best_weight = v;
    // rust: best = Some(p);
}
}
}
    // rust: best.map(|p| {
    // rust: [
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]),
    // rust: f64::from(p[2]) + 0.5,
    // rust: ]
    // rust: })
}
    // DefaultRandomPos.getPos
default_random_pos :: proc(self: ^Self, w: ^MobWorld, h: i32, v: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.pick_best(w, |m| {
    // rust: let d = m.random_direction(h, v);
    // rust: let p = m.toward(f64::from(h), d);
    // rust: m.default_check(w, f64::from(h), p).then_some(p)
    // rust: })
}
    // DefaultRandomPos.getPosAway
    // rust: pub fn default_random_pos_away(
    // rust: &mut self,
    // rust: w: &MobWorld,
    // rust: h: i32,
    // rust: v: i32,
    // rust: away: [f64; 3],
    // rust: ) -> Option<[f64; 3]> {
    // rust: let (xd, zd) = (self.position.x - away[0], self.position.z - away[2]);
    // rust: self.pick_best(w, |m| {
    // rust: let d = m.random_direction_within(
    // rust: 0.0,
    // rust: f64::from(h),
    // rust: v,
    // rust: 0,
    // rust: xd,
    // rust: zd,
    // rust: std::f64::consts::FRAC_PI_2,
    // rust: )?;
    // rust: let p = m.toward(f64::from(h), d);
    // rust: m.default_check(w, f64::from(h), p).then_some(p)
    // rust: })
}
    // DefaultRandomPos.getPosTowards
    // rust: pub fn default_random_pos_towards(
    // rust: &mut self,
    // rust: w: &MobWorld,
    // rust: h: i32,
    // rust: v: i32,
    // rust: to: [f64; 3],
    // rust: max_rad: f64,
    // rust: ) -> Option<[f64; 3]> {
    // rust: let (xd, zd) = (to[0] - self.position.x, to[2] - self.position.z);
    // rust: self.pick_best(w, |m| {
    // rust: let d = m.random_direction_within(0.0, f64::from(h), v, 0, xd, zd, max_rad)?;
    // rust: let p = m.toward(f64::from(h), d);
    // rust: m.default_check(w, f64::from(h), p).then_some(p)
    // rust: })
}
land_up_out_of_solid :: proc(self: ^Self, w: ^MobWorld, mut p: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if w.solid(p[0], p[1], p[2]) {
    // rust: p[1] += 1;
    // rust: while p[1] < w.world.top_y() && w.solid(p[0], p[1], p[2]) {
    // rust: p[1] += 1;
}
}
    // rust: let water = w.fluid(p[0], p[1], p[2]) == crate::blocks::Fluid::Water;
    // rust: (!water && self.malus(w.path_type_static(p[0], p[1], p[2])) == 0.0).then_some(p)
}
    // `Entity.getViewVector(0)`: `calculateViewVector(xRotO, yHeadRotO)`.
view_vector :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
//         use horizon_core::geometry::trig::Mth;
    // rust: let to_rad = std::f32::consts::PI / 180.0;
    // rust: let x = self.previous_head_pitch * to_rad;
        // LivingEntity.getViewYRot(0): the head's yaw of the last tick.
    // rust: let y = -self.previous_head_yaw * to_rad;
    // rust: let (y_cos, y_sin, x_cos, x_sin) = (y.mcos(), y.msin(), x.mcos(), x.msin());
    // rust: [
    // rust: f64::from(y_sin * x_cos),
    // rust: f64::from(-x_sin),
    // rust: f64::from(y_cos * x_cos),
    // rust: ]
}
    // `Entity.getLookAngle`: `calculateViewVector(xRot, yRot)`, the facing
    // of the body (`getHeadLookAngle` is the one with the head's yaw).
look_angle :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
//         use horizon_core::geometry::trig::Mth;
    // rust: let to_rad = std::f32::consts::PI / 180.0;
    // rust: let x = self.head_pitch * to_rad;
    // rust: let y = -self.yaw * to_rad;
    // rust: let (y_cos, y_sin, x_cos, x_sin) = (y.mcos(), y.msin(), x.mcos(), x.msin());
    // rust: [
    // rust: f64::from(y_sin * x_cos),
    // rust: f64::from(-x_sin),
    // rust: f64::from(y_cos * x_cos),
    // rust: ]
}
    // AirAndWaterRandomPos.getPos: within the radians of a direction, kept
    // near home, moved up out of solid blocks and free of path maluses.
    // rust: pub fn air_and_water_random_pos(
    // rust: &mut self,
    // rust: w: &MobWorld,
    // rust: h: i32,
    // rust: v: i32,
    // rust: fly_height: i32,
    // rust: xd: f64,
    // rust: zd: f64,
    // rust: ) -> Option<[f64; 3]> {
        // Every caller passes `(float) (Math.PI / 2)`.
    // rust: let max_rad = f64::from(std::f32::consts::FRAC_PI_2);
    // rust: self.pick_best(w, |m| {
    // rust: m.air_and_water_pos(w, h, v, fly_height, xd, zd, max_rad)
    // rust: })
}
    // AirAndWaterRandomPos.generateRandomPos.
    // rust: fn air_and_water_pos(
    // rust: &mut self,
    // rust: w: &MobWorld,
    // rust: h: i32,
    // rust: v: i32,
    // rust: fly_height: i32,
    // rust: xd: f64,
    // rust: zd: f64,
    // rust: max_rad: f64,
    // rust: ) -> Option<[i32; 3]> {
    // rust: let d = self.random_direction_within(0.0, f64::from(h), v, fly_height, xd, zd, max_rad)?;
    // rust: let mut p = self.toward(f64::from(h), d);
    // rust: if p[1] < w.world.bottom_y() || p[1] >= w.world.top_y() || self.restricted(f64::from(h), p)
    // rust: {
    // rust: return None;
}
        // RandomPos.moveUpOutOfSolid
    // rust: if w.solid(p[0], p[1], p[2]) {
    // rust: p[1] += 1;
    // rust: while p[1] < w.world.top_y() && w.solid(p[0], p[1], p[2]) {
    // rust: p[1] += 1;
}
}
    // rust: (self.malus(w.path_type_static(p[0], p[1], p[2])) == 0.0).then_some(p)
}
    // AirRandomPos.getPosTowards: an AirAndWaterRandomPos towards a point,
    // out of water.
    // rust: pub fn air_random_pos_towards(
    // rust: &mut self,
    // rust: w: &MobWorld,
    // rust: h: i32,
    // rust: v: i32,
    // rust: fly_height: i32,
    // rust: to: [f64; 3],
    // rust: max_rad: f64,
    // rust: ) -> Option<[f64; 3]> {
    // rust: let (xd, zd) = (to[0] - self.position.x, to[2] - self.position.z);
    // rust: self.pick_best(w, |m| {
    // rust: let p = m.air_and_water_pos(w, h, v, fly_height, xd, zd, max_rad)?;
    // rust: (w.fluid(p[0], p[1], p[2]) != crate::blocks::Fluid::Water).then_some(p)
    // rust: })
}
    // HoverRandomPos.getPos: a stable spot within the radians of a
    // direction, raised a random `hover_min..=hover_max` blocks above the
    // solid ground it is in, out of water and free of path maluses.
    // rust: pub fn hover_random_pos(
    // rust: &mut self,
    // rust: w: &MobWorld,
    // rust: h: i32,
    // rust: v: i32,
    // rust: xd: f64,
    // rust: zd: f64,
    // rust: max_rad: f64,
    // rust: hover_max: i32,
    // rust: hover_min: i32,
    // rust: ) -> Option<[f64; 3]> {
    // rust: self.pick_best(w, |m| {
    // rust: let d = m.random_direction_within(0.0, f64::from(h), v, 0, xd, zd, max_rad)?;
            // LandRandomPos.generateRandomPosTowardDirection
    // rust: let p = m.toward(f64::from(h), d);
    // rust: if p[1] < w.world.bottom_y()
    // rust: || p[1] >= w.world.top_y()
    // rust: || m.restricted(f64::from(h), p)
    // rust: || !m.stable_destination(w, p)
    // rust: {
    // rust: return None;
}
    // rust: let above = m
    // rust: .random
    // rust: .next_int_bound(hover_max - hover_min + 1)
    // rust: .unwrap_or(0)
    // rust: + hover_min;
    // rust: let p = move_up_to_above_solid(w, p, above);
    // rust: let water = w.fluid(p[0], p[1], p[2]) == crate::blocks::Fluid::Water;
    // rust: (!water && m.malus(w.path_type_static(p[0], p[1], p[2])) == 0.0).then_some(p)
    // rust: })
}
    // `WaterAvoidingRandomFlyingGoal.getPosition`: a hover spot ahead, else
    // any air or water spot ahead.
flying_stroll_pos :: proc(self: ^Self, w: ^MobWorld) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let [xd, _, zd] = self.view_vector();
    // rust: let max_rad = f64::from(std::f32::consts::FRAC_PI_2);
    // rust: self.hover_random_pos(w, 8, 7, xd, zd, max_rad, 3, 1)
    // rust: .or_else(|| self.air_and_water_random_pos(w, 8, 4, -2, xd, zd))
}
    // LandRandomPos.getPos
land_random_pos :: proc(self: ^Self, w: ^MobWorld, h: i32, v: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.pick_best(w, |m| {
    // rust: let d = m.random_direction(h, v);
    // rust: let p = m.toward(f64::from(h), d);
    // rust: if p[1] < w.world.bottom_y()
    // rust: || p[1] >= w.world.top_y()
    // rust: || m.restricted(f64::from(h), p)
    // rust: || !m.stable_destination(w, p)
    // rust: {
    // rust: return None;
}
    // rust: m.land_up_out_of_solid(w, p)
    // rust: })
}
    // LandRandomPos.getPos(mob, h, v, scorer): the best of ten by `score`.
    // rust: pub fn land_random_pos_scored(
    // rust: &mut self,
    // rust: w: &MobWorld,
    // rust: h: i32,
    // rust: v: i32,
    // rust: score: impl Fn([i32; 3]) -> f64,
    // rust: ) -> Option<[f64; 3]> {
    // rust: let mut best: Option<[i32; 3]> = None;
    // rust: let mut best_weight = f64::NEG_INFINITY;
    // rust: for _ in 0..10 {
    // rust: let d = self.random_direction(h, v);
    // rust: let p = self.toward(f64::from(h), d);
    // rust: if p[1] < w.world.bottom_y()
    // rust: || p[1] >= w.world.top_y()
    // rust: || self.restricted(f64::from(h), p)
    // rust: || !self.stable_destination(w, p)
    // rust: {
    // rust: continue;
}
    // rust: if let Some(p) = self.land_up_out_of_solid(w, p) {
    // rust: let v = score(p);
    // rust: if v > best_weight {
    // rust: best_weight = v;
    // rust: best = Some(p);
}
}
}
    // rust: best.map(|p| {
    // rust: [
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]),
    // rust: f64::from(p[2]) + 0.5,
    // rust: ]
    // rust: })
}
    // `LandRandomPos.getPosAway`: a spot away from `away`, the best of ten tries.
    // rust: pub fn land_random_pos_away(
    // rust: &mut self,
    // rust: w: &MobWorld,
    // rust: h: i32,
    // rust: v: i32,
    // rust: away: [f64; 3],
    // rust: ) -> Option<[f64; 3]> {
    // rust: self.land_random_pos_away_between(w, 0.0, f64::from(h), v, away)
}
    // `LandRandomPos.getPosAway(mob, minHorizontalDist, maxHorizontalDist, verticalDist, avoidPos)`.
    // rust: pub fn land_random_pos_away_between(
    // rust: &mut self,
    // rust: w: &MobWorld,
    // rust: min_h: f64,
    // rust: max_h: f64,
    // rust: v: i32,
    // rust: away: [f64; 3],
    // rust: ) -> Option<[f64; 3]> {
    // rust: let (mut xd, mut zd) = (self.position.x - away[0], self.position.z - away[2]);
    // rust: if xd == 0.0 && zd == 0.0 {
    // rust: xd = self.random.next_double() - 0.5;
    // rust: zd = self.random.next_double() - 0.5;
}
    // rust: self.land_pos_in_direction(w, min_h, max_h, v, xd, zd)
}
    // `LandRandomPos.getPosTowards`: a spot within a quarter turn of the
    // way to `to`, the best of ten tries.
    // rust: pub fn land_random_pos_towards(
    // rust: &mut self,
    // rust: w: &MobWorld,
    // rust: h: i32,
    // rust: v: i32,
    // rust: to: [f64; 3],
    // rust: ) -> Option<[f64; 3]> {
    // rust: let (xd, zd) = (to[0] - self.position.x, to[2] - self.position.z);
    // rust: self.land_pos_in_direction(w, 0.0, f64::from(h), v, xd, zd)
}
    // `LandRandomPos.getPosInDirection`: ten tries within a quarter turn
    // (`(float) (Math.PI / 2)`) of the direction `(xd, zd)`.
    // rust: fn land_pos_in_direction(
    // rust: &mut self,
    // rust: w: &MobWorld,
    // rust: min_h: f64,
    // rust: max_h: f64,
    // rust: v: i32,
    // rust: xd: f64,
    // rust: zd: f64,
    // rust: ) -> Option<[f64; 3]> {
    // rust: self.pick_best(w, |m| {
    // rust: let d = m.random_direction_within(
    // rust: min_h,
    // rust: max_h,
    // rust: v,
    // rust: 0,
    // rust: xd,
    // rust: zd,
    // rust: f64::from(std::f32::consts::FRAC_PI_2),
    // rust: )?;
    // rust: let p = m.toward(max_h, d);
    // rust: if p[1] < w.world.bottom_y()
    // rust: || p[1] >= w.world.top_y()
    // rust: || m.restricted(max_h, p)
    // rust: || !m.stable_destination(w, p)
    // rust: {
    // rust: return None;
}
    // rust: m.land_up_out_of_solid(w, p)
    // rust: })
}
target_info :: proc(self: ^Self, w: ^MobWorld) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.ai.target.and_then(|t| w.target_info(t))
}
    // Sensing.hasLineOfSight (cached per tick in vanilla).
sees :: proc(self: ^Self, w: ^MobWorld, who: Who) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(v) = self.ai.seen_cache.iter().find(|(k, _)| *k == who) {
    // rust: return v.1;
}
    // rust: let Some(t) = w.target_info(who) else {
    // rust: return false;
}
    // rust: let eye = Vec3::new(self.position.x, self.eye_y(), self.position.z);
    // rust: let v = w.line_of_sight_for(
    // rust: Some(self.position.y),
    // rust: eye,
    // rust: Vec3::new(t.position.x, t.eye_y, t.position.z),
    // rust: );
    // rust: self.ai.seen_cache.push((who, v));
    // rust: v
}
    // Mob.isWithinMeleeAttackRange: the box inflated by sqrt(2.04) - 0.6.
within_melee_range :: proc(self: ^Self, t: ^TargetInfo) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let reach = 2.04f32.sqrt() as f64 - 0.6;
    // rust: let b = self.bounds().inflate(Vec3::new(reach, 0.0, reach));
    // rust: b.intersects(t.bounds)
}
    // Whether the species is a `TamableAnimal` (not the horses and llamas,
    // which are tamed another way).
is_tamable_animal :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: self.species(),
    // rust: Species::Wolf
    // rust: | Species::Cat
    // rust: | Species::Parrot
    // rust: | Species::Nautilus
    // rust: | Species::ZombieNautilus
    // rust: )
}
    // `IronGolem.isPlayerCreated`: a golem a player built, which
    // `IronGolem.canAttack` never lets attack a player.
built_by_player :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.species() == Species::IronGolem && self.extra.player_created
}
    // `canAttack` for the player: a golem a player built never attacks
    // players (`IronGolem.canAttack`), and a pet never attacks its owner
    // (`TamableAnimal.canAttack`: `isOwnedBy`). In Peaceful nothing attacks a
    // player (`LivingEntity.canAttack`, `TargetingConditions.test`: combat
    // conditions fail when the difficulty is PEACEFUL).
spares_players :: proc(self: ^Self, w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (w.difficulty.base == 0 && w.player.is_some())
    // rust: || self.built_by_player()
    // rust: || (self.is_tamable_animal()
    // rust: && self.extra.tame
    // rust: && w.player
    // rust: .as_ref()
    // rust: .is_some_and(|p| super::tame::owned_by(self.extra.owner, p.uuid)))
}
    // `canAttack` of any target: the player rules above, and
    // `IronGolem.canAttack`'s refusal of creepers. The callers check that
    // the target is alive and can be seen as an enemy.
spares_target :: proc(self: ^Self, w: ^MobWorld, who: Who) -> b {
    // Ported from Horizon
    return {}
}
        // Dolphin.canAttack: a baby dolphin attacks nobody, so whatever hurt it
        // is never taken as its target.
    // rust: if self.species() == Species::Dolphin && self.is_baby() {
    // rust: return true;
}
    // rust: match who {
    // rust: Who::Player => self.spares_players(w),
    // rust: Who::Mob(id) => {
    // rust: self.species() == Species::IronGolem
    // rust: && w.seen(id).is_some_and(|s| s.species == Species::Creeper)
}
}
}
    // TargetingConditions.forCombat().test for the player: alive, not
    // creative, within range scaled by visibility, optionally visible.
can_target_player :: proc(self: ^Self, w: ^MobWorld, range: f64, check_sight: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(p) = &w.player else { return false };
    // rust: if self.spares_players(w) {
    // rust: return false;
}
        // TargetingConditions.isCombat: never an ally.
    // rust: if p.creative || p.allies.contains(&self.id) {
    // rust: return false;
}
    // rust: self.player_in_range(w, range, check_sight, true)
}
    // forCombat().ignoreInvisibilityTesting() for the player: the check for
    // a target the mob already has, which ignores the visibility scaling.
can_keep_target_player :: proc(self: ^Self, w: ^MobWorld, range: f64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(p) = &w.player else { return false };
    // rust: if self.spares_players(w) {
    // rust: return false;
}
    // rust: if p.creative || p.allies.contains(&self.id) {
    // rust: return false;
}
    // rust: self.player_in_range(w, range, true, false)
}
    // TargetingConditions.forNonCombat().range(range).test for the player
    // (seen by anyone, within range scaled by visibility, in sight).
can_see_player :: proc(self: ^Self, w: ^MobWorld, range: f64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.player_in_range(w, range, true, true)
}
    // `TargetingConditions.forNonCombat().range(range).ignoreLineOfSight()`
    // for the player (still scaled by visibility).
can_see_player_through_walls :: proc(self: ^Self, w: ^MobWorld, range: f64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.player_in_range(w, range, false, true)
}
    // `scale` is `TargetingConditions.testInvisible`: scale the range by
    // the player's visibility.
    // rust: fn player_in_range(
    // rust: &mut self,
    // rust: w: &MobWorld,
    // rust: range: f64,
    // rust: check_sight: bool,
    // rust: scale: bool,
    // rust: ) -> bool {
    // rust: let Some(p) = &w.player else { return false };
    // rust: if !p.alive || p.spectator {
    // rust: return false;
}
        // LivingEntity.getVisibilityPercent, including worn mob_visibility.
    // rust: let visibility = if scale {
    // rust: p.visibility_percent(Some(self.kind.id.as_str()), w.items)
    // rust: } else {
    // rust: 1.0
}
    // rust: let dist = (range * visibility).max(2.0);
    // rust: if self.distance_sqr(p.position) > dist * dist {
    // rust: return false;
}
    // rust: !check_sight || self.sees(w, Who::Player)
}
}

// --- goals ---------------------------------------------------------------

// FloatGoal: jump (swim up) while deeper than the jump threshold or in lava.
Float :: struct {
    // rust: impl Goal for Float {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: JUMP
}
can_use :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.fluids.water > m.fluid_jump_threshold() || m.fluids.in_lava
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
tick :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: if m.random.next_float() < 0.8 {
    // rust: m.ai.jump = true;
}
}
}
// `ClimbOnTopOfPowderSnowGoal`: a powder-snow walker standing in powder snow
// jumps while the block above is powder snow or has no collision.
ClimbOnTopOfPowderSnow :: struct {
    // rust: impl Goal for ClimbOnTopOfPowderSnow {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: JUMP
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
        // wasInPowderSnow || isInPowderSnow: the freeze tick has read the
        // powder snow the mob's box touches before the goals run.
    // rust: if !super::ai::in_powder_snow(m, cx.w)
    // rust: || !cx
    // rust: .w
    // rust: .data
    // rust: .entity_has("minecraft:powder_snow_walkable_mobs", &m.kind.id)
    // rust: {
    // rust: return false;
}
        // Mob.blockPosition().above()
    // rust: let above = [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32 + 1,
    // rust: m.position.z.floor() as i32,
    // rust: ];
    // rust: cx.w.block_name(above[0], above[1], above[2]) == "minecraft:powder_snow"
    // rust: || cx.w.collision_bounds(above).is_none()
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
    // `ClimbOnTopOfPowderSnowGoal.tick`: ask the mob to jump.
tick :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: m.ai.jump = true;
}
}
// PanicGoal: flee to a random position after panic-causing damage (or
// towards water while burning).
Panic :: struct {
    speed: f64,
    // Only the damage of `#panic_environmental_causes` (an armadillo).
    environmental: bool,
    // `TurtlePanicGoal`: always look for water this far away, not only
    // when on fire.
    water_range: Maybe(i32),
    pos: [f64,
}
    // rust: impl Panic {
new :: proc(speed: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: speed,
    // rust: environmental: false,
    // rust: water_range: None,
    // rust: pos: [0.0; 3],
}
}
    // `TurtlePanicGoal`.
looking_for_water :: proc(range: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.water_range = Some(range);
    // rust: self
}
}
should_panic :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.last_damage
    // rust: .is_some_and(|(d, t)| d.causes_panic() && i64::from(m.age) - t <= 40)
    // rust: || m.fire_ticks > 0 && !m.kind.flags.fire_immune
}
    // rust: impl Goal for Panic {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let wanted = if self.environmental {
    // rust: m.last_damage.is_some_and(|(d, t)| {
    // rust: super::armadillo::environmental(d.kind) && i64::from(m.age) - t <= 40
    // rust: }) || m.fire_ticks > 0 && !m.kind.flags.fire_immune
    // rust: } else {
    // rust: should_panic(m)
}
    // rust: if !wanted {
    // rust: return false;
}
    // rust: let range = self.water_range.or((m.fire_ticks > 0).then_some(5));
    // rust: if let Some(range) = range {
    // rust: let (bx, by, bz) = (
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: );
    // rust: if cx.w.data.state(cx.w.world.block(bx, by, bz)).top == 0.0 {
                // findBlocksInBoxByManhattanDistance(pos, range, 1) for water.
    // rust: let mut best: Option<([i32; 3], i32)> = None;
    // rust: for dy in -1i32..=1 {
    // rust: for dx in -range..=range {
    // rust: for dz in -range..=range {
    // rust: let d = dx.abs() + dy.abs() + dz.abs();
    // rust: if cx.w.fluid(bx + dx, by + dy, bz + dz) == crate::blocks::Fluid::Water
    // rust: && best.is_none_or(|b| d < b.1)
    // rust: {
    // rust: best = Some(([bx + dx, by + dy, bz + dz], d));
}
}
}
}
    // rust: if let Some((p, _)) = best {
    // rust: self.pos = [f64::from(p[0]), f64::from(p[1]), f64::from(p[2])];
    // rust: return true;
}
}
}
    // rust: match m.default_random_pos(cx.w, 5, 4) {
    // rust: Some(p) => {
    // rust: self.pos = p;
    // rust: true
}
    // rust: None => false,
}
}
can_continue :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !m.ai.nav.is_done()
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: m.nav_move_to(cx.w, self.pos, self.speed);
    // rust: m.ai.panicking = true;
}
stop :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: m.ai.panicking = false;
}
}
// RandomStrollGoal / WaterAvoidingRandomStrollGoal.
Stroll :: struct {
    speed: f64,
    interval: i32,
    check_no_action: bool,
    // WaterAvoidingRandomStrollGoal probability of a plain stroll.
    water_avoiding: Maybe(f32),
    // RandomSwimmingGoal: BehaviorUtils.getRandomSwimmablePos.
    swim: bool,
    // WaterAvoidingRandomFlyingGoal: a hover spot, else an air or water pos.
    flying: bool,
    // `Parrot.ParrotWanderGoal`: to a tree, else as `flying`.
    parrot: bool,
    force: bool,
    wanted: [f64,
    // A subclass's `getPosition` in place of the default pick
    // (`GolemRandomStrollInVillageGoal`, `MoveBackToVillageGoal`).
    position: Option<fn(^Mob,
    // A subclass's own `canUse` test, run before the interval's draw.
    gate: Option<fn(^Mob,
    label: Maybe(^'static str),
}
    // rust: impl Stroll {
    // `RandomStrollGoal.<init>` (interval 120, checks the no-action time).
new :: proc(speed: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: speed,
    // rust: interval: 120,
    // rust: check_no_action: true,
    // rust: water_avoiding: None,
    // rust: swim: false,
    // rust: flying: false,
    // rust: parrot: false,
    // rust: force: false,
    // rust: wanted: [0.0; 3],
    // rust: position: None,
    // rust: gate: None,
    // rust: label: None,
}
}
    // The stroll's spot comes from `f` (an overridden `getPosition`).
position :: proc(f: fn(^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.position = Some(f);
    // rust: self
}
    // The stroll may only start while `f` holds (an overridden `canUse`).
gate :: proc(f: fn(^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.gate = Some(f);
    // rust: self
}
    // The goal's class name, for debugging.
named :: proc(label: ^'static str) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.label = Some(label);
    // rust: self
}
avoiding_water :: proc(speed: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: water_avoiding: Some(0.001),
    // rust: ..Self::new(speed)
}
}
interval :: proc(i: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.interval = i;
    // rust: self
}
    // WaterAvoidingRandomFlyingGoal (a nearby air position).
flying :: proc(speed: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: flying: true,
    // rust: ..Self::new(speed)
}
}
    // `Parrot.ParrotWanderGoal(speed)`, a WaterAvoidingRandomFlyingGoal.
parrot :: proc(speed: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: water_avoiding: Some(0.001),
    // rust: parrot: true,
    // rust: ..Self::new(speed)
}
}
    // RandomSwimmingGoal(speed, interval)
swimming :: proc(speed: f64, interval: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: swim: true,
    // rust: ..Self::new(speed).interval(interval)
}
}
}
    // rust: impl Goal for Stroll {
    // rust: goal_clone!();
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(label) = self.label {
    // rust: label
    // rust: } else if self.parrot {
    // rust: "ParrotWander"
    // rust: } else if self.water_avoiding.is_some() {
    // rust: "Stroll"
    // rust: } else if self.swim {
    // rust: "RandomSwimming"
    // rust: } else {
    // rust: "RandomStroll"
}
}
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE
}
    // RandomStrollGoal.canUse.
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if super::riders::mob_controlled(m, cx.w) {
    // rust: return false;
}
    // rust: if self.gate.is_some_and(|gate| !gate(m, cx.w)) {
    // rust: return false;
}
    // rust: if !self.force {
    // rust: if self.check_no_action && m.ai.no_action_time >= 100 {
    // rust: return false;
}
    // rust: if m.random.next_int_bound(reduced(self.interval)).unwrap_or(1) != 0 {
    // rust: return false;
}
}
    // rust: let pos = match self.water_avoiding {
    // rust: _ if self.position.is_some() => self.position.and_then(|pick| pick(m, cx)),
    // rust: Some(_) if self.parrot => super::parrot::wander_pos(m, cx.w),
    // rust: Some(prob) => {
    // rust: if m.fluids.in_water {
    // rust: m.land_random_pos(cx.w, 15, 7)
    // rust: .or_else(|| m.default_random_pos(cx.w, 10, 7))
    // rust: } else if m.random.next_float() >= prob {
    // rust: m.land_random_pos(cx.w, 10, 7)
    // rust: } else {
    // rust: m.default_random_pos(cx.w, 10, 7)
}
}
    // rust: None if self.swim => {
    // rust: let mut p = m.default_random_pos(cx.w, 10, 7);
    // rust: let mut count = 0;
    // rust: while let Some(q) = p {
    // rust: let s = cx.w.world.block(
    // rust: q[0].floor() as i32,
    // rust: q[1].floor() as i32,
    // rust: q[2].floor() as i32,
    // rust: );
    // rust: if cx.w.data.state(s).flags & super::data::WATER != 0 || count >= 10 {
    // rust: break;
}
    // rust: count += 1;
    // rust: p = m.default_random_pos(cx.w, 10, 7);
}
    // rust: p
}
    // rust: None if self.flying => m.flying_stroll_pos(cx.w),
    // rust: None => m.default_random_pos(cx.w, 10, 7),
}
    // rust: let Some(p) = pos else { return false };
    // rust: self.wanted = p;
    // rust: self.force = false;
    // rust: true
}
    // RandomStrollGoal.canContinueToUse.
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !m.ai.nav.is_done() && !super::riders::mob_controlled(m, cx.w)
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: m.nav_move_to(cx.w, self.wanted, self.speed);
}
stop :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: m.nav_stop();
}
}
// LookAtPlayerGoal (player targets only).
LookAtPlayer :: struct {
    range: f32,
    probability: f32,
    only_horizontal: bool,
    // `LookAtPlayerGoal(Mob.class, ...)`: the nearest mob, not the player.
    mobs: bool,
    // `LookAtPlayerGoal(Strider.class, ...)`: only mobs of this species.
    only: Maybe(Species),
    // InteractGoal: LOOK and MOVE.
    interact: bool,
    look_at: Maybe(Who),
    look_time: i32,
}
    // rust: impl LookAtPlayer {
new :: proc(range: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: range,
    // rust: probability: 0.02,
    // rust: only_horizontal: false,
    // rust: mobs: false,
    // rust: only: None,
    // rust: interact: false,
    // rust: look_at: None,
    // rust: look_time: 0,
}
}
    // `LookAtPlayerGoal(this, Mob.class, range)`.
mobs :: proc(range: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: mobs: true,
    // rust: ..Self::new(range)
}
}
    // `LookAtPlayerGoal(this, <species class>, range)`.
species :: proc(species: Species, range: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: only: Some(species),
    // rust: ..Self::mobs(range)
}
}
    // `InteractGoal(this, Player.class, range, probability)`.
interact :: proc(range: f32, probability: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: interact: true,
    // rust: ..Self::new(range).probability(probability)
}
}
probability :: proc(p: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.probability = p;
    // rust: self
}
    // The goal's look target, alive, with its position and eye height.
look_target :: proc(self: ^Self, w: ^MobWorld) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self.look_at? {
    // rust: Who::Player => w
    // rust: .player
    // rust: .as_ref()
    // rust: .filter(|p| p.alive)
    // rust: .map(|p| (p.position, p.eye[1])),
    // rust: Who::Mob(id) => w
    // rust: .seen(id)
    // rust: .filter(|s| s.alive)
    // rust: .map(|s| (s.position, s.eye_y)),
}
}
}
    // rust: impl Goal for LookAtPlayer {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if self.interact { LOOK | MOVE } else { LOOK }
}
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: if self.interact {
    // rust: "InteractGoal"
    // rust: } else {
    // rust: "LookAtPlayer"
}
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if m.random.next_float() >= self.probability {
    // rust: return false;
}
    // rust: self.look_at = None;
    // rust: let range = f64::from(self.range);
    // rust: if !self.mobs {
            // level.getNearestPlayer(forNonCombat().range(lookDistance)).
    // rust: if m.can_see_player(cx.w, range) {
    // rust: self.look_at = Some(Who::Player);
}
    // rust: return self.look_at.is_some();
}
        // level.getNearestEntity(mobs in the box inflated by (range, 3, range)).
    // rust: let area = m.bounds().inflate(Vec3::new(range, 3.0, range));
    // rust: let (id, only) = (m.id, self.only);
    // rust: let at = Vec3::new(m.position.x, m.eye_y(), m.position.z);
    // rust: let candidates: Vec<(u32, Vec3)> =
    // rust: cx.w.others_near(area)
    // rust: .filter(|s| s.id != id && s.alive && s.bounds.intersects(area))
    // rust: .filter(|s| only.is_none_or(|o| s.species == o))
    // rust: .map(|s| (s.id, s.position))
    // rust: .collect();
    // rust: let mut best: Option<(u32, f64)> = None;
    // rust: for (cid, pos) in candidates {
    // rust: let reach = range.max(2.0);
    // rust: if m.distance_sqr(pos) > reach * reach || !m.sees(cx.w, Who::Mob(cid)) {
    // rust: continue;
}
    // rust: let d = pos.distance_squared(at);
    // rust: if best.is_none_or(|(_, b)| d < b) {
    // rust: best = Some((cid, d));
}
}
    // rust: self.look_at = best.map(|(cid, _)| Who::Mob(cid));
    // rust: self.look_at.is_some()
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some((pos, _)) = self.look_target(cx.w) else {
    // rust: return false;
}
    // rust: m.distance_sqr(pos) <= f64::from(self.range * self.range) && self.look_time > 0
}
start :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: self.look_time = reduced(40 + m.random.next_int_bound(40).unwrap_or(0));
}
stop :: proc(self: ^Self, _: ^Mob, _: ^Cx) {
}
    // rust: self.look_at = None;
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if let Some((pos, eye)) = self.look_target(cx.w) {
    // rust: let y = if self.only_horizontal { m.eye_y() } else { eye };
    // rust: m.look_at([pos.x, y, pos.z]);
    // rust: self.look_time -= 1;
}
}
}
// RandomLookAroundGoal.
RandomLookAround :: struct {
    rel: [f64,
    time: i32,
}
    // rust: impl Goal for RandomLookAround {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE | LOOK
}
can_use :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.random.next_float() < 0.02
}
can_continue :: proc(self: ^Self, _: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.time >= 0
}
start :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: let r = std::f64::consts::TAU * m.random.next_double();
    // rust: self.rel = [jmath::cos(r), jmath::sin(r)];
    // rust: self.time = 20 + m.random.next_int_bound(20).unwrap_or(0);
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
tick :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: self.time -= 1;
    // rust: let at = [
    // rust: m.position.x + self.rel[0],
    // rust: m.eye_y(),
    // rust: m.position.z + self.rel[1],
    // rust: ];
    // rust: m.look_at(at);
}
}
// MeleeAttackGoal (and ZombieAttackGoal's raised arms when `zombie`).
MeleeAttack :: struct {
    speed: f64,
    follow_unseen: bool,
    zombie: bool,
    // `PolarBear.PolarBearMeleeAttackGoal`: rears up before each strike.
    polar_bear: bool,
    path_target: [f64,
    recalc: i32,
    until_attack: i32,
    last_check: i64,
    raise_arm: i32,
    // Ticks between attacks (20 unless set).
    interval: i32,
    // Ticks between attacks for a baby, when they differ.
    baby_interval: Maybe(i32),
    // The sound played after each strike (a fox's bite).
    bite: Maybe(^'static str),
}
    // rust: impl MeleeAttack {
new :: proc(speed: f64, follow_unseen: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: speed,
    // rust: follow_unseen,
    // rust: zombie: false,
    // rust: polar_bear: false,
    // rust: path_target: [0.0; 3],
    // rust: recalc: 0,
    // rust: until_attack: 0,
    // rust: last_check: 0,
    // rust: raise_arm: 0,
    // rust: interval: 20,
    // rust: baby_interval: None,
    // rust: bite: None,
}
}
zombie :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.zombie = true;
    // rust: self
}
polar_bear :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.polar_bear = true;
    // rust: self
}
interval :: proc(ticks: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.interval = ticks;
    // rust: self
}
    // `MeleeAttack.create(adult)` for adults, `create(baby)` for babies.
intervals :: proc(adult: i32, baby: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.interval = adult;
    // rust: self.baby_interval = Some(baby);
    // rust: self
}
    // `FoxMeleeAttackGoal.checkAndPerformAttack`: the bite after each strike.
bite :: proc(sound: ^'static str) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.bite = Some(sound);
    // rust: self
}
}
    // rust: impl Goal for MeleeAttack {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE | LOOK
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if cx.w.game_time - self.last_check < 20 {
    // rust: return false;
}
    // rust: self.last_check = cx.w.game_time;
    // rust: let Some(t) = m.target_info(cx.w) else {
    // rust: return false;
}
    // rust: if !t.alive {
    // rust: return false;
}
    // rust: let path = m.create_path_to_entity(cx.w, [t.position.x, t.position.y, t.position.z], 0);
    // rust: let ok = path.is_some() || m.within_melee_range(&t);
    // rust: m.ai.pending_path = path;
    // rust: ok
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(t) = m.target_info(cx.w) else {
    // rust: return false;
}
    // rust: if !t.alive {
    // rust: return false;
}
    // rust: if !self.follow_unseen {
    // rust: return !m.ai.nav.is_done();
}
    // rust: !(t.is_player && t.creative)
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let path = m.ai.pending_path.take();
    // rust: m.nav_move_to_path(cx.w, path, self.speed);
    // rust: m.ai.aggressive = true;
    // rust: self.recalc = 0;
    // rust: self.until_attack = 0;
    // rust: self.raise_arm = 0;
}
stop :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if let Some(t) = m.target_info(cx.w)
    // rust: && t.is_player
    // rust: && t.creative
    // rust: {
    // rust: m.ai.target = None;
}
    // rust: m.ai.aggressive = false;
    // rust: m.nav_stop();
    // rust: if self.polar_bear {
    // rust: super::polar_bear::set_standing(m, false);
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
    // rust: let Some(who) = m.ai.target else { return };
    // rust: let Some(t) = cx.w.target_info(who) else {
    // rust: return;
}
    // rust: m.look_at_speed([t.position.x, t.eye_y, t.position.z], 30.0, 30.0);
    // rust: self.recalc = (self.recalc - 1).max(0);
    // rust: let moved = (t.position.x - self.path_target[0]).powi(2)
    // rust: + (t.position.y - self.path_target[1]).powi(2)
    // rust: + (t.position.z - self.path_target[2]).powi(2)
    // rust: >= 1.0;
    // rust: if (self.follow_unseen || m.sees(cx.w, who))
    // rust: && self.recalc <= 0
    // rust: && (self.path_target == [0.0; 3] || moved || m.random.next_float() < 0.05)
    // rust: {
    // rust: self.path_target = [t.position.x, t.position.y, t.position.z];
    // rust: self.recalc = 4 + m.random.next_int_bound(7).unwrap_or(0);
    // rust: let d = m.distance_sqr(t.position);
    // rust: if d > 1024.0 {
    // rust: self.recalc += 10;
    // rust: } else if d > 256.0 {
    // rust: self.recalc += 5;
}
    // rust: if !m.nav_move_to_entity(cx.w, self.path_target, 0, self.speed) {
    // rust: self.recalc += 15;
}
    // rust: self.recalc = adjusted(true, self.recalc);
}
    // rust: self.until_attack = (self.until_attack - 1).max(0);
    // rust: if self.polar_bear {
    // rust: let cooldown = adjusted(true, self.interval);
    // rust: super::polar_bear::check_and_perform_attack(
    // rust: &mut self.until_attack,
    // rust: cooldown,
    // rust: m,
    // rust: who,
    // rust: &t,
    // rust: cx,
    // rust: );
    // rust: } else if self.until_attack <= 0 && m.within_melee_range(&t) && m.sees(cx.w, who) {
    // rust: let interval = match self.baby_interval {
    // rust: Some(baby) if m.is_baby() => baby,
    // rust: _ => self.interval,
}
    // rust: self.until_attack = adjusted(true, interval);
    // rust: m.swing();
    // rust: super::ai::do_hurt_target(m, who, cx);
    // rust: if let Some(sound) = self.bite {
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: cx.events.push(MobEvent::Sound(sound, at, 1.0, 1.0));
}
}
    // rust: if self.zombie {
    // rust: self.raise_arm += 1;
    // rust: m.ai.aggressive = self.raise_arm >= 5 && self.until_attack < adjusted(true, 20) / 2;
}
}
}
// LeapAtTargetGoal.
LeapAtTarget :: struct {
    yd: f32,
    target: [f64,
}
    // rust: impl LeapAtTarget {
new :: proc(yd: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: yd,
    // rust: target: [0.0; 3],
}
}
}
    // rust: impl Goal for LeapAtTarget {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: JUMP | MOVE
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(t) = m.target_info(cx.w) else {
    // rust: return false;
}
    // rust: let d = m.distance_sqr(t.position);
    // rust: if !(4.0..=16.0).contains(&d) || !m.on_ground {
    // rust: return false;
}
    // rust: self.target = [t.position.x, t.position.y, t.position.z];
    // rust: m.random.next_int_bound(reduced(5)).unwrap_or(1) == 0
}
can_continue :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !m.on_ground
}
start :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: let mut d = [
    // rust: self.target[0] - m.position.x,
    // rust: 0.0,
    // rust: self.target[2] - m.position.z,
    // rust: ];
    // rust: let len_sq = d[0] * d[0] + d[2] * d[2];
    // rust: if len_sq > 1.0e-7 {
    // rust: let l = len_sq.sqrt();
    // rust: d = [
    // rust: d[0] / l * 0.4 + m.velocity.x * 0.2,
    // rust: 0.0,
    // rust: d[2] / l * 0.4 + m.velocity.z * 0.2,
    // rust: ];
}
    // rust: m.velocity = Vec3::new(d[0], f64::from(self.yd), d[2]);
}
}
// What a target goal hunts.
Prey :: enum {
    Player,
    Species(Vec<Species>),
    // Any mob matching a predicate on its snapshot.
    Filter(fn(&Seen) -> bool),
}
// NearestAttackableTargetGoal (+ TargetGoal's continue rules).
NearestTarget :: struct {
    prey: Prey,
    must_see: bool,
    must_reach: bool,
    interval: i32,
    // Extra condition on the attacker, checked after the random interval.
    when: Option<fn(^Mob,
    // Mobs closer than this squared distance are not picked
    // (`GuardianAttackSelector`: `distanceToSqr > 9`).
    beyond_sqr: Maybe(f64),
    // A condition checked before anything else, by subclasses overriding
    // `canUse` (SpiderTargetGoal: only in the dark).
    gate: Option<fn(^Mob,
    // The vanilla class name of a subclass (`Goal::name`).
    label: Maybe(^'static str),
    found: Maybe(Who),
    target_goal: TargetState,
}
TargetState :: struct {
    unseen: i32,
    unseen_memory: i32,
    // `TargetGoal.getFollowDistance` as a fraction of the follow range.
    follow_scale: f64,
}
    // rust: impl Default for TargetState {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: unseen: 0,
    // rust: unseen_memory: 0,
    // rust: follow_scale: 1.0,
}
}
}
    // rust: impl NearestTarget {
new :: proc(prey: Prey, must_see: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: prey,
    // rust: must_see,
    // rust: must_reach: false,
    // rust: interval: reduced(10),
    // rust: when: None,
    // rust: beyond_sqr: None,
    // rust: gate: None,
    // rust: label: None,
    // rust: found: None,
    // rust: target_goal: TargetState {
    // rust: unseen_memory: 60,
    // rust: ..Default::default()
    // rust: },
}
}
player :: proc(must_see: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(Prey::Player, must_see)
}
species :: proc(list: ^[Species], must_see: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(Prey::Species(list.to_vec()), must_see)
}
interval :: proc(i: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.interval = reduced(i);
    // rust: self
}
    // Scale the follow distance (llamas hunt wolves within a quarter of it).
follow_scale :: proc(scale: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.target_goal.follow_scale = scale;
    // rust: self
}
reach :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.must_reach = true;
    // rust: self
}
when :: proc(f: fn(^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.when = Some(f);
    // rust: self
}
beyond :: proc(distance_sqr: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.beyond_sqr = Some(distance_sqr);
    // rust: self
}
gate :: proc(f: fn(^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.gate = Some(f);
    // rust: self
}
    // A subclass's name, e.g. `NearestAttackableWitchTargetGoal`.
named :: proc(label: ^'static str) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.label = Some(label);
    // rust: self
}
}
// `AbstractIllager.canAttack`: a baby `AbstractVillager` is never attacked.
illager_spares :: proc(attacker: Species, target: ^Seen) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: attacker,
    // rust: Species::Pillager | Species::Vindicator | Species::Evoker | Species::Illusioner
    // rust: ) && target.baby
    // rust: && matches!(target.species, Species::Villager | Species::WanderingTrader)
}
// TargetGoal.canContinueToUse
target_continue :: proc(st: ^TargetState, must_see: bool, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(who) = m.ai.target else { return false };
    // rust: if let Who::Mob(id) = who
    // rust: && cx
    // rust: .w
    // rust: .seen(id)
    // rust: .is_some_and(|s| illager_spares(m.species(), s))
    // rust: {
    // rust: return false;
}
    // rust: let Some(t) = cx.w.target_info(who) else {
    // rust: return false;
}
    // rust: if !t.alive
    // rust: || !t.can_be_seen_as_enemy
    // rust: || (t.is_player && t.creative)
    // rust: || m.spares_target(cx.w, who)
    // rust: {
    // rust: return false;
}
    // rust: let follow = m.attrs.follow_range * st.follow_scale;
    // rust: if m.distance_sqr(t.position) > follow * follow {
    // rust: return false;
}
    // rust: if must_see {
    // rust: if m.sees(cx.w, who) {
    // rust: st.unseen = 0;
    // rust: } else {
    // rust: st.unseen += 1;
    // rust: if st.unseen > reduced(st.unseen_memory) {
    // rust: return false;
}
}
}
    // rust: true
}
    // rust: impl Goal for NearestTarget {
    // rust: goal_clone!();
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.label.unwrap_or("NearestTarget")
}
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
    // rust: if let Some(f) = self.gate
    // rust: && !f(m, cx.w)
    // rust: {
    // rust: return false;
}
    // rust: if self.interval > 0 && m.random.next_int_bound(self.interval).unwrap_or(1) != 0 {
    // rust: return false;
}
    // rust: if let Some(f) = self.when
    // rust: && !f(m, cx.w)
    // rust: {
    // rust: return false;
}
    // rust: let range = m.attrs.follow_range * self.target_goal.follow_scale;
    // rust: self.found = None;
        // NearestAttackableTargetGoal.findTarget: TargetingConditions.forCombat()
        // always checks the line of sight; mustSee and mustReach only matter
        // to TargetGoal.canContinueToUse and canAttack.
    // rust: match &self.prey {
    // rust: Prey::Player => {
    // rust: if m.can_target_player(cx.w, range, true) {
    // rust: self.found = Some(Who::Player);
}
}
    // rust: prey => {
    // rust: let pos = Vec3::new(m.position.x, m.eye_y(), m.position.z);
    // rust: let id = m.id;
    // rust: let attacker = m.species();
    // rust: let candidates: Vec<(u32, Vec3)> =
    // rust: cx.w.nearby(pos, range, move |s| {
    // rust: s.id != id
    // rust: && !s.playing_dead
    // rust: && !illager_spares(attacker, s)
    // rust: && match prey {
    // rust: Prey::Species(list) => list.contains(&s.species),
    // rust: Prey::Filter(f) => f(s),
    // rust: Prey::Player => false,
}
    // rust: })
    // rust: .map(|s| (s.id, s.position))
    // rust: .collect();
    // rust: for (cid, cpos) in candidates {
    // rust: if m.distance_sqr(cpos) > range * range {
    // rust: continue;
}
    // rust: if self.beyond_sqr.is_some_and(|d| m.distance_sqr(cpos) <= d) {
    // rust: continue;
}
    // rust: if !m.sees(cx.w, Who::Mob(cid)) {
    // rust: continue;
}
    // rust: self.found = Some(Who::Mob(cid));
    // rust: break;
}
}
}
    // rust: self.found.is_some()
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: target_continue(&mut self.target_goal, self.must_see, m, cx)
}
start :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: m.ai.target = self.found;
    // rust: self.target_goal.unseen = 0;
}
stop :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: m.ai.target = None;
}
}
// HurtByTargetGoal (optionally alerting others of the same species).
HurtByTarget :: struct {
    alert: bool,
    // Species that should not be alerted.
    alert_except: [dynamic]Species,
    // Attackers ignored (e.g. zombified piglins ignore other zombified piglins).
    ignore: [dynamic]Species,
    // `Bee.BeeHurtByOtherGoal`: kept only while angry, and alerting others
    // only when the attacker is in sight.
    bee: bool,
    // Whom `alertOther` calls: a filter on the mob (`PandaHurtByTargetGoal`
    // calls aggressive pandas only).
    alert_if: Maybe(fn(^Seen) -) bool>,
    // `PolarBear.PolarBearHurtByTargetGoal`: a hurt cub only calls the
    // adult bears and drops the target itself.
    polar_bear: bool,
    timestamp: i32,
    st: TargetState,
}
    // rust: impl HurtByTarget {
new :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: alert: false,
    // rust: alert_except: vec![],
    // rust: ignore: vec![],
    // rust: bee: false,
    // rust: alert_if: None,
    // rust: polar_bear: false,
    // rust: timestamp: 0,
    // rust: st: TargetState {
    // rust: unseen_memory: 300,
    // rust: ..Default::default()
    // rust: },
}
}
alert :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.alert = true;
    // rust: self
}
ignoring :: proc(s: ^[Species]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.ignore = s.to_vec();
    // rust: self
}
bee :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.bee = true;
    // rust: self
}
alert_if :: proc(f: fn(^Seen) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.alert_if = Some(f);
    // rust: self
}
polar_bear :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.polar_bear = true;
    // rust: self
}
}
    // rust: impl Default for HurtByTarget {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new()
}
}
    // rust: impl Goal for HurtByTarget {
    // rust: goal_clone!();
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: if self.bee {
    // rust: "BeeHurtByOtherGoal"
    // rust: } else if self.polar_bear {
    // rust: "PolarBearHurtByTargetGoal"
    // rust: } else {
    // rust: "HurtByTarget"
}
}
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
    // rust: let Some(by) = m.ai.last_hurt_by else {
    // rust: return false;
}
    // rust: if m.ai.last_hurt_by_time == self.timestamp {
    // rust: return false;
}
    // rust: if let Who::Mob(id) = by
    // rust: && cx
    // rust: .w
    // rust: .seen(id)
    // rust: .is_some_and(|s| self.ignore.contains(&s.species))
    // rust: {
    // rust: return false;
}
    // rust: let Some(t) = cx.w.target_info(by) else {
    // rust: return false;
}
    // rust: t.alive
    // rust: && t.can_be_seen_as_enemy
    // rust: && !(t.is_player && t.creative)
            // HurtByTargetGoal.canUse ends with canAttack(lastHurtByMob).
    // rust: && !m.spares_target(cx.w, by)
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.bee && !super::bee::angry(m, cx.w) {
    // rust: return false;
}
    // rust: target_continue(&mut self.st, true, m, cx)
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: m.ai.target = m.ai.last_hurt_by;
    // rust: self.timestamp = m.ai.last_hurt_by_time;
    // rust: self.st.unseen_memory = 300;
    // rust: self.st.unseen = 0;
        // PolarBearHurtByTargetGoal.start: a cub alerts the adults itself.
    // rust: let cub = self.polar_bear && m.is_baby();
    // rust: if (self.alert || cub)
    // rust: && let Some(by) = m.ai.target
    // rust: {
    // rust: let range = m.attrs.follow_range;
    // rust: let species = m.species();
    // rust: let id = m.id;
    // rust: let pos = m.position;
            // TamableAnimal: its owner (`getOwner`, none for a wild one) and
            // whether it is a pet at all.
    // rust: let tamable = m.is_tamable_animal();
    // rust: let owner = m.extra.tame.then_some(m.extra.owner).flatten();
    // rust: let player = cx.w.player.as_ref().map(|p| p.uuid);
    // rust: let ids: Vec<u32> =
    // rust: cx.w.others
    // rust: .iter()
    // rust: .filter(|s| {
    // rust: s.id != id
    // rust: && s.alive
    // rust: && s.species == species
    // rust: && s.target.is_none()
    // rust: && (s.position.x - pos.x).abs() <= range + 1.0
    // rust: && (s.position.y - pos.y).abs() <= 11.0
    // rust: && (s.position.z - pos.z).abs() <= range + 1.0
    // rust: })
    // rust: .filter(|s| !self.alert_except.contains(&s.species))
    // rust: .filter(|s| self.alert_if.is_none_or(|f| f(s)))
                    // PolarBearHurtByTargetGoal.alertOther: adults only.
    // rust: .filter(|s| !(self.polar_bear && s.baby))
    // rust: .filter(|s| Who::Mob(s.id) != by)
                    // HurtByTargetGoal.alertOthers: a pet is only called by a
                    // pet with the same owner.
    // rust: .filter(|s| !tamable || s.tame.then_some(s.owner).flatten() == owner)
                    // TamableAnimal.considersEntityAsAlly: a pet tamed by the
                    // player who hurt it is allied with them, so it is not called.
    // rust: .filter(|s| {
    // rust: !(tamable
    // rust: && by == Who::Player
    // rust: && s.tame
    // rust: && s.owner.is_some()
    // rust: && s.owner == player)
    // rust: })
    // rust: .map(|s| s.id)
    // rust: .collect();
            // Bee.BeeHurtByOtherGoal.alertOther: only with the attacker in sight.
    // rust: if self.bee && !ids.is_empty() && !m.sees(cx.w, by) {
    // rust: return;
}
    // rust: for other in ids {
    // rust: cx.events.push(MobEvent::SetTarget {
    // rust: mob: other,
    // rust: target: by,
    // rust: });
}
}
    // rust: if cub {
    // rust: m.ai.target = None;
}
}
stop :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: m.ai.target = None;
}
}
// What an AvoidEntityGoal flees from.
Avoid :: enum {
    Player,
    Species(Vec<Species>),
}
// AvoidEntityGoal.
AvoidEntity :: struct {
    what: Avoid,
    max_dist: f32,
    walk: f64,
    sprint: f64,
    // Extra condition on the avoider (e.g. untamed cats only).
    when: Maybe(fn(^Mob) -) bool>,
    // Extra condition on the player or mob avoided (`AvoidEntityGoal`'s
    // predicate: a sneaking player, a tame wolf).
    player_when: Option<fn(^Mob,
    seen_when: Maybe(fn(^Seen) -) bool>,
    from: Vec3,
    // The mob being avoided (`toAvoid`), when it is one.
    found: Maybe(u32),
}
    // rust: impl AvoidEntity {
new :: proc(what: Avoid, max_dist: f32, walk: f64, sprint: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: what,
    // rust: max_dist,
    // rust: walk,
    // rust: sprint,
    // rust: when: None,
    // rust: player_when: None,
    // rust: seen_when: None,
    // rust: from: Vec3::ZERO,
    // rust: found: None,
}
}
when :: proc(f: fn(^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.when = Some(f);
    // rust: self
}
player_when :: proc(f: fn(^Mob, &super: :PlayerView) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.player_when = Some(f);
    // rust: self
}
seen_when :: proc(f: fn(^Seen) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.seen_when = Some(f);
    // rust: self
}
    // The target the goal flees from, before the random retreat position and
    // the path. `AvoidEntityGoal` finds it with `TargetingConditions.forCombat()`:
    // for the player that is `canAttack` (`LivingEntity.canAttack` refuses a
    // player in Peaceful), the range scaled by `getVisibilityPercent` with a
    // floor of 2 and line of sight required; the species arm needs the line of
    // sight too, because `checkLineOfSight` defaults to true. Without them an
    // animal fled a player behind a wall, a sneaking or invisible one from the
    // full range, and in Peaceful where vanilla animals ignore the player.
avoid_target :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let max = f64::from(self.max_dist);
    // rust: if matches!(self.what, Avoid::Player) {
    // rust: let wanted = cx.w.player.as_ref().is_none_or(|p| {
    // rust: self.player_when.is_none_or(|f| f(m, p))
    // rust: && (p.position.y - m.position.y).abs() <= max + 3.0
    // rust: });
            // `can_target_player` refuses a player in Peaceful (`spares_players`).
    // rust: if !wanted || !m.can_target_player(cx.w, max, true) {
    // rust: return None;
}
    // rust: return cx.w.player.as_ref().map(|p| p.position);
}
    // rust: let Avoid::Species(list) = &self.what else {
    // rust: return None;
}
    // rust: let id = m.id;
    // rust: let y = m.position.y;
    // rust: let seen_when = self.seen_when;
    // rust: let mut hit = None;
    // rust: for s in cx.w.nearby(m.position, max, move |s| {
    // rust: s.id != id
    // rust: && list.contains(&s.species)
    // rust: && seen_when.is_none_or(|f| f(s))
    // rust: && (s.position.y - y).abs() <= 3.0 + max
    // rust: }) {
    // rust: if m.sees(cx.w, Who::Mob(s.id)) {
    // rust: hit = Some((s.id, s.position));
    // rust: break;
}
}
    // rust: self.found = hit.map(|h| h.0);
    // rust: hit.map(|h| h.1)
}
}
    // rust: impl Goal for AvoidEntity {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(f) = self.when
    // rust: && !f(m)
    // rust: {
    // rust: return false;
}
    // rust: let max = f64::from(self.max_dist);
    // rust: let Some(from) = self.avoid_target(m, cx) else {
    // rust: return false;
}
        // The player arm already applied the visibility-scaled range (floor 2);
        // the species arm only got a box test from `nearby`.
    // rust: if !matches!(self.what, Avoid::Player) && m.distance_sqr(from) > max * max {
    // rust: return false;
}
    // rust: let Some(pos) = m.default_random_pos_away(cx.w, 16, 7, [from.x, from.y, from.z]) else {
    // rust: return false;
}
    // rust: let to_pos =
    // rust: (from.x - pos[0]).powi(2) + (from.y - pos[1]).powi(2) + (from.z - pos[2]).powi(2);
    // rust: if to_pos < m.distance_sqr(from) {
    // rust: return false;
}
    // rust: self.from = from;
    // rust: let path = m.create_path_to(
    // rust: cx.w,
    // rust: [
    // rust: pos[0].floor() as i32,
    // rust: pos[1].floor() as i32,
    // rust: pos[2].floor() as i32,
    // rust: ],
    // rust: 0,
    // rust: );
    // rust: m.ai.pending_path = path;
    // rust: m.ai.pending_path.is_some()
}
can_continue :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !m.ai.nav.is_done()
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let path = m.ai.pending_path.take();
    // rust: m.nav_move_to_path(cx.w, path, self.walk);
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let from = match &self.what {
    // rust: Avoid::Player => {
    // rust: cx.w.player
    // rust: .as_ref()
    // rust: .map(|p| p.position)
    // rust: .unwrap_or(self.from)
}
    // rust: Avoid::Species(_) => self.from,
}
    // rust: m.ai.nav.speed_modifier = if m.distance_sqr(from) < 49.0 {
    // rust: self.sprint
    // rust: } else {
    // rust: self.walk
}
}
}
// TemptGoal: follow a player holding one of the items.
Tempt :: struct {
    speed: f64,
    items: ^[string],
    can_scare: bool,
    stop_distance: f64,
    p: [f64,
    rot: [f64,
    calm_down: i32,
}
    // rust: impl Tempt {
new :: proc(speed: f64, items: ^[string], can_scare: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: speed,
    // rust: items,
    // rust: can_scare,
    // rust: stop_distance: 2.5,
    // rust: p: [0.0; 3],
    // rust: rot: [0.0; 2],
    // rust: calm_down: 0,
}
}
wants :: proc(self: ^Self, item: ^Maybe(^str)) -> b {
    // Ported from Horizon
    return {}
}
    // rust: item.as_ref()
    // rust: .is_some_and(|i| self.items.iter().any(|t| t.as_str() == &**i))
}
}
    // rust: impl Goal for Tempt {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE | LOOK
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.calm_down > 0 {
    // rust: self.calm_down -= 1;
    // rust: return false;
}
    // rust: let Some(p) = &cx.w.player else { return false };
        // Attributes.TEMPT_RANGE default 10.
    // rust: p.alive
    // rust: && (self.wants(&p.main_hand) || self.wants(&p.off_hand))
    // rust: && m.distance_sqr(p.position) <= 100.0
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.can_scare
    // rust: && let Some(p) = &cx.w.player
    // rust: {
    // rust: if m.distance_sqr(p.position) < 36.0 {
    // rust: let moved = (p.position.x - self.p[0]).powi(2)
    // rust: + (p.position.y - self.p[1]).powi(2)
    // rust: + (p.position.z - self.p[2]).powi(2);
    // rust: if moved > 0.010_000_000_000_000_002 {
    // rust: return false;
}
    // rust: let (yaw, pitch) = look_angles(p.look);
    // rust: if (pitch - self.rot[0]).abs() > 5.0 || (yaw - self.rot[1]).abs() > 5.0 {
    // rust: return false;
}
    // rust: } else {
    // rust: self.p = [p.position.x, p.position.y, p.position.z];
}
    // rust: let (yaw, pitch) = look_angles(p.look);
    // rust: self.rot = [pitch, yaw];
}
    // rust: self.can_use(m, cx)
}
start :: proc(self: ^Self, _: ^Mob, cx: ^Cx) {
}
    // rust: if let Some(p) = &cx.w.player {
    // rust: self.p = [p.position.x, p.position.y, p.position.z];
}
}
stop :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: m.nav_stop();
    // rust: self.calm_down = reduced(100);
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let Some(p) = cx.w.player.clone() else { return };
    // rust: let (y, x) = (m.kind.max_head_y_rot + 20.0, m.max_head_x_rot());
    // rust: m.look_at_speed(p.eye, y, x);
    // rust: if m.distance_sqr(p.position) < self.stop_distance * self.stop_distance {
    // rust: m.nav_stop();
    // rust: } else {
    // rust: m.nav_move_to_entity(
    // rust: cx.w,
    // rust: [p.position.x, p.position.y, p.position.z],
    // rust: 1,
    // rust: self.speed,
    // rust: );
}
}
}
look_angles :: proc(look: [f64; 3]) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let yaw = (-look[0]).atan2(look[2]).to_degrees();
    // rust: let pitch = (-look[1]).asin().to_degrees();
    // rust: (yaw, pitch)
}
// BreedGoal: walk to a partner in love and breed after 60 ticks.
Breed :: struct {
    speed: f64,
    partner: Maybe(u32),
    love_time: i32,
}
    // rust: impl Breed {
new :: proc(speed: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: speed,
    // rust: partner: None,
    // rust: love_time: 0,
}
}
}
    // rust: impl Goal for Breed {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE | LOOK
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if m.extra.in_love <= 0 {
    // rust: return false;
}
    // rust: let species = m.species();
        // Wolf.canMate and Cat.canMate: both tame. The sitting pose sits on the
        // partner side only, and only for a wolf (`wolf.isInSittingPose()`), so
        // a tamed mob ordered to sit still walks off to breed.
    // rust: let tamable = matches!(species, Species::Wolf | Species::Cat);
    // rust: if tamable && !m.extra.tame {
    // rust: return false;
}
        // AbstractHorse.canMate is false and Mule keeps it: mules never breed.
    // rust: if species == Species::Mule {
    // rust: return false;
}
        // TurtleBreedGoal.canUse: not while carrying an egg.
    // rust: if species == Species::Turtle && super::turtle::has_egg(m) {
    // rust: return false;
}
    // rust: let id = m.id;
        // Horses and donkeys breed together (AbstractHorse.canParent: tame).
        // Sniffer.canMate: calm states only.
    // rust: let sniffer = species == Species::Sniffer;
    // rust: if sniffer && !super::sniffer::can_mate_state(m.extra.variant) {
    // rust: return false;
}
    // rust: let llama = super::llama::is_llama(species);
    // rust: let equine = matches!(species, Species::Horse | Species::Donkey) || llama;
        // AbstractHorse.canParent: tame, an adult, not a vehicle or passenger
        // and at full health.
    // rust: if equine
    // rust: && (!m.extra.tame
    // rust: || m.is_baby()
    // rust: || m.rider.is_some()
    // rust: || m.extra.rider.is_some()
    // rust: || m.extra.mount.is_some()
    // rust: || m.health < m.attrs.max_health)
    // rust: {
    // rust: return false;
}
    // rust: self.partner =
    // rust: cx.w.nearby(m.position, 8.0, move |s| {
    // rust: let same = s.species == species
    // rust: || llama && super::llama::is_llama(s.species)
    // rust: || !llama && equine && matches!(s.species, Species::Horse | Species::Donkey);
    // rust: s.id != id
    // rust: && same
    // rust: && s.in_love
    // rust: && !s.baby
    // rust: && (!tamable || s.tame)
                    // Wolf.canMate: a sitting wolf is no partner.
    // rust: && !(species == Species::Wolf && s.sitting)
                    // AbstractHorse.canParent of the partner.
    // rust: && (!equine || s.tame && !s.ridden && s.health >= s.stats[0] as f32)
    // rust: && (!sniffer || super::sniffer::can_mate_state(s.variant))
    // rust: })
    // rust: .map(|s| s.id)
    // rust: .next();
    // rust: self.partner.is_some()
}
can_continue :: proc(self: ^Self, _: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.partner
    // rust: .and_then(|p| cx.w.seen(p))
    // rust: .is_some_and(|s| s.alive && s.in_love)
    // rust: && self.love_time < 60
}
stop :: proc(self: ^Self, _: ^Mob, _: ^Cx) {
}
    // rust: self.partner = None;
    // rust: self.love_time = 0;
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let Some(p) = self.partner.and_then(|p| cx.w.seen(p)).cloned() else {
    // rust: return;
}
    // rust: let x = m.max_head_x_rot();
    // rust: m.look_at_speed([p.position.x, p.eye_y, p.position.z], 10.0, x);
    // rust: m.nav_move_to_entity(
    // rust: cx.w,
    // rust: [p.position.x, p.position.y, p.position.z],
    // rust: 1,
    // rust: self.speed,
    // rust: );
    // rust: self.love_time += 1;
    // rust: if self.love_time >= reduced(60) && m.distance_sqr(p.position) < 9.0 {
            // Llama.getBreedOffspring and finalizeSpawnChildFromBreeding's
            // experience, from the parent's random: vanilla draws it only
            // inside the `mob_drops` check.
    // rust: let llama = super::llama::is_llama(m.species()).then(|| {
    // rust: let o = super::llama::breed_offspring(m, &p);
    // rust: if cx.w.mob_drops {
    // rust: let xp = 1 + m.random.next_int_bound(7).unwrap_or(0);
    // rust: cx.events.push(MobEvent::Experience {
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: amount: xp as u32,
    // rust: });
}
    // rust: Box::new(o)
    // rust: });
    // rust: m.extra.in_love = 0;
    // rust: m.extra.age = 6000;
            // TurtleBreedGoal.breed: the mother carries an egg, not a baby.
    // rust: if m.species() == Species::Turtle {
    // rust: m.extra.flag = true;
}
            // Frog.spawnChildFromBreeding: IS_PREGNANT instead of a baby.
    // rust: if m.species() == Species::Frog {
    // rust: super::frog::set_pregnant(m, true);
}
    // rust: cx.events.push(MobEvent::Breed {
    // rust: parent: m.id,
    // rust: partner: p.id,
    // rust: llama,
    // rust: });
}
}
}
// FollowParentGoal.
FollowParent :: struct {
    speed: f64,
    parent: Maybe(u32),
    recalc: i32,
}
    // rust: impl FollowParent {
new :: proc(speed: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: speed,
    // rust: parent: None,
    // rust: recalc: 0,
}
}
}
    // rust: impl Goal for FollowParent {
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
    // rust: if m.extra.age >= 0 {
    // rust: return false;
}
    // rust: let species = m.species();
    // rust: let pos = m.position;
    // rust: let mut best: Option<(u32, f64)> = None;
        // Every position in range puts the box's bottom face in this area.
    // rust: let area = Aabb::new(
    // rust: Vec3::new(pos.x - 9.0, pos.y - 5.0, pos.z - 9.0),
    // rust: Vec3::new(pos.x + 9.0, pos.y + 5.0, pos.z + 9.0),
    // rust: );
    // rust: for s in cx.w.others_near(area).filter(|s| {
    // rust: s.alive
    // rust: && s.species == species
    // rust: && !s.baby
    // rust: && (s.position.x - pos.x).abs() <= 8.0
    // rust: && (s.position.y - pos.y).abs() <= 4.0
    // rust: && (s.position.z - pos.z).abs() <= 8.0
    // rust: }) {
    // rust: let d = m.distance_sqr(s.position);
    // rust: if best.is_none_or(|b| d <= b.1) {
    // rust: best = Some((s.id, d));
}
}
    // rust: match best {
    // rust: Some((id, d)) if d >= 9.0 => {
    // rust: self.parent = Some(id);
    // rust: true
}
    // rust: _ => false,
}
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if m.extra.age >= 0 {
    // rust: return false;
}
    // rust: let Some(p) = self.parent.and_then(|p| cx.w.seen(p)) else {
    // rust: return false;
}
    // rust: let d = m.distance_sqr(p.position);
    // rust: p.alive && (9.0..=256.0).contains(&d)
}
start :: proc(self: ^Self, _: ^Mob, _: ^Cx) {
}
    // rust: self.recalc = 0;
}
stop :: proc(self: ^Self, _: ^Mob, _: ^Cx) {
}
    // rust: self.parent = None;
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.recalc -= 1;
    // rust: if self.recalc <= 0 {
    // rust: self.recalc = reduced(10);
    // rust: if let Some(p) = self.parent.and_then(|p| cx.w.seen(p)) {
    // rust: let at = [p.position.x, p.position.y, p.position.z];
    // rust: m.nav_move_to_entity(cx.w, at, 1, self.speed);
}
}
}
}
// `FollowMobGoal` `(mob, speed, stopDistance, areaSize)`: follows the first
// visible mob of another class within `area` blocks and keeps `stop` away
// from it (a parrot hovers by the other animals).
//
// Left out: vanilla also backs away when the followed mob's look control
// wants this mob's position; only another `FollowMobGoal` mob of a different
// class would look at it, and parrots are the only ones that have the goal.
FollowMob :: struct {
    speed: f64,
    stop: f64,
    area: f64,
    following: Maybe(u32),
    recalc: i32,
    old_water: f32,
}
    // rust: impl FollowMob {
new :: proc(speed: f64, stop: f32, area: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: speed,
    // rust: stop: f64::from(stop),
    // rust: area: f64::from(area),
    // rust: following: None,
    // rust: recalc: 0,
    // rust: old_water: 0.0,
}
}
}
    // rust: impl Goal for FollowMob {
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "FollowMobGoal"
}
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE | LOOK
}
    // `FollowMobGoal.canUse`.
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let species = m.species();
        // `getEntitiesOfClass(Mob, getBoundingBox().inflate(areaSize))`.
    // rust: let area = m
    // rust: .bounds()
    // rust: .inflate(Vec3::new(self.area, self.area, self.area));
    // rust: let found = cx
    // rust: .w
    // rust: .others_near(area)
    // rust: .find(|s| {
    // rust: s.species != species && s.bounds.intersects(area) && !s.has_effect("invisibility")
    // rust: })
    // rust: .map(|s| s.id);
    // rust: self.following = found;
    // rust: found.is_some()
}
    // `FollowMobGoal.canContinueToUse`.
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(at) = self
    // rust: .following
    // rust: .and_then(|id| cx.w.seen(id))
    // rust: .map(|s| s.position)
    // rust: else {
    // rust: return false;
}
    // rust: !m.ai.nav.is_done() && m.distance_sqr(at) > self.stop * self.stop
}
    // `FollowMobGoal.start`.
start :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: self.recalc = 0;
    // rust: self.old_water = m.malus(super::path::PathType::Water);
    // rust: m.set_malus(super::path::PathType::Water, 0.0);
}
    // `FollowMobGoal.stop`.
stop :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: self.following = None;
    // rust: m.nav_stop();
    // rust: m.set_malus(super::path::PathType::Water, self.old_water);
}
    // `FollowMobGoal.tick`.
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let Some((at, eye)) = self
    // rust: .following
    // rust: .and_then(|id| cx.w.seen(id))
    // rust: .map(|s| (s.position, s.eye_y))
    // rust: else {
    // rust: return;
}
    // rust: if m.extra.leash.is_some() {
    // rust: return;
}
    // rust: let max = m.max_head_x_rot();
    // rust: m.look_at_speed([at.x, eye, at.z], 10.0, max);
    // rust: self.recalc -= 1;
    // rust: if self.recalc <= 0 {
    // rust: self.recalc = reduced(10);
    // rust: let d = m.distance_sqr(at);
    // rust: if d > self.stop * self.stop {
    // rust: m.nav_move_to_entity(cx.w, [at.x, at.y, at.z], 1, self.speed);
    // rust: } else {
    // rust: m.nav_stop();
                // `distSqr <= stopDistance` (not squared, as vanilla writes it):
                // too close, so it moves away from the mob.
    // rust: if d <= self.stop {
    // rust: let (dx, dz) = (at.x - m.position.x, at.z - m.position.z);
    // rust: m.nav_move_to(
    // rust: cx.w,
    // rust: [m.position.x - dx, m.position.y, m.position.z - dz],
    // rust: self.speed,
    // rust: );
}
}
}
}
}
// RestrictSunGoal: avoid sunlit nodes while it is bright outside.
RestrictSun :: struct {
    // rust: impl Goal for RestrictSun {
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
    // rust: cx.w.daylight && m.extra.head.is_none()
}
start :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: m.ai.nav.avoid_sun = true;
}
stop :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: m.ai.nav.avoid_sun = false;
}
}
// `FleeSunGoal.getHidePos`: a spot within 10 blocks that the sky does not
// see and the mob likes.
hide_pos :: proc(m: ^Mob, w: ^MobWorld) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (bx, by, bz) = (
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: );
    // rust: for _ in 0..10 {
    // rust: let p = [
    // rust: bx + m.random.next_int_bound(20).unwrap_or(0) - 10,
    // rust: by + m.random.next_int_bound(6).unwrap_or(0) - 3,
    // rust: bz + m.random.next_int_bound(20).unwrap_or(0) - 10,
    // rust: ];
    // rust: if !w.can_see_sky(p[0], p[1], p[2]) && m.walk_target_value(w, p) < 0.0 {
    // rust: return Some([
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]),
    // rust: f64::from(p[2]) + 0.5,
    // rust: ]);
}
}
    // rust: None
}
// FleeSunGoal: find shade while burning.
FleeSun :: struct {
    speed: f64,
    wanted: [f64,
}
    // rust: impl FleeSun {
new :: proc(speed: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: speed,
    // rust: wanted: [0.0; 3],
}
}
}
    // rust: impl Goal for FleeSun {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if m.ai.target.is_some() || !cx.w.daylight || m.fire_ticks <= 0 || m.extra.head.is_some() {
    // rust: return false;
}
    // rust: let (bx, by, bz) = (
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: );
    // rust: if !cx.w.can_see_sky(bx, by, bz) {
    // rust: return false;
}
    // rust: match hide_pos(m, cx.w) {
    // rust: Some(at) => {
    // rust: self.wanted = at;
    // rust: true
}
    // rust: None => false,
}
}
can_continue :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !m.ai.nav.is_done()
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: m.nav_move_to(cx.w, self.wanted, self.speed);
}
}
// EatBlockGoal (sheep): eat short grass or turn grass blocks to dirt.
EatBlock :: struct {
    tick: i32,
}
    // rust: impl Goal for EatBlock {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE | LOOK | JUMP
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let chance = reduced(if m.is_baby() { 50 } else { 1000 });
    // rust: if m.random.next_int_bound(chance).unwrap_or(1) != 0 {
    // rust: return false;
}
    // rust: let (x, y, z) = (
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: );
    // rust: let here = cx.w.block_name(x, y, z).to_owned();
    // rust: cx.w.has_tag("minecraft:edible_for_sheep", &here)
    // rust: || cx.w.block_name(x, y - 1, z) == "minecraft:grass_block"
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.tick = reduced(40);
    // rust: m.extra.anim_ticks = 40;
        // EatBlockGoal.start: broadcastEntityEvent 10, so the head goes down
        // on every client.
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: cx.events.push(MobEvent::EntityEvent {
    // rust: mob: m.id,
    // rust: event: 10,
    // rust: at,
    // rust: });
    // rust: m.nav_stop();
}
stop :: proc(self: ^Self, _: ^Mob, _: ^Cx) {
}
    // rust: self.tick = 0;
}
can_continue :: proc(self: ^Self, _: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.tick > 0
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.tick = (self.tick - 1).max(0);
    // rust: if self.tick == reduced(4) {
    // rust: let (x, y, z) = (
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: );
    // rust: let here = cx.w.block_name(x, y, z).to_owned();
            // EatBlockGoal.tick: both halves of the world change sit behind
            // MOB_GRIEFING (`ifeq 89`, `ifeq 182` in the bytecode); `Mob.ate`
            // runs either way, so a sheep still sheds its wool and ages up.
    // rust: if cx.w.has_tag("minecraft:edible_for_sheep", &here) {
    // rust: if cx.w.mob_griefing {
    // rust: cx.events.push(MobEvent::BreakBlock {
    // rust: pos: [x, y, z],
    // rust: drop: false,
    // rust: });
}
    // rust: super::ai::ate(m, cx.events);
    // rust: } else if cx.w.block_name(x, y - 1, z) == "minecraft:grass_block" {
                // The particles and the dirt `setBlock` are the same gate.
    // rust: if cx.w.mob_griefing {
    // rust: cx.events.push(MobEvent::SetBlockName {
    // rust: mob: Some(m.id),
    // rust: pos: [x, y - 1, z],
    // rust: name: "minecraft:dirt",
    // rust: effect: true,
    // rust: flags: horizon_world::level::flags::UPDATE_CLIENTS,
    // rust: });
}
    // rust: super::ai::ate(m, cx.events);
}
}
}
}

// BreathAirGoal: swim up to air when the air supply runs low.
BreathAir :: struct {
    // rust: impl BreathAir {
find_air :: proc(m: ^Mob, cx: ^Cx) {
}
    // rust: let (x, y, z) = (
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: );
    // rust: let mut dest = None;
    // rust: for yy in y..=y + 8 {
    // rust: let s = cx.w.world.block(x, yy, z);
    // rust: let f = cx.w.facts.get(s);
    // rust: if (f.fluid == crate::blocks::Fluid::None || &*f.name == "minecraft:bubble_column")
    // rust: && cx.w.data.state(s).flags & super::data::LAND != 0
    // rust: {
    // rust: dest = Some([x, yy, z]);
    // rust: break;
}
}
    // rust: let d = dest.unwrap_or([x, (m.position.y + 8.0).floor() as i32, z]);
    // rust: m.nav_move_to(
    // rust: cx.w,
    // rust: [f64::from(d[0]), f64::from(d[1] + 1), f64::from(d[2])],
    // rust: 1.0,
    // rust: );
}
}
    // rust: impl Goal for BreathAir {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE | LOOK
}
can_use :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.air < 140
}
interruptable :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: m.nav_stop();
    // rust: Self::find_air(m, cx);
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: Self::find_air(m, cx);
    // rust: let input = Vec3::new(
    // rust: f64::from(m.ai.xxa),
    // rust: f64::from(m.ai.yya),
    // rust: f64::from(m.ai.zza),
    // rust: );
    // rust: m.move_relative(0.02, input);
    // rust: let mut ev = Vec::new();
    // rust: m.do_move(cx.w, &mut ev);
    // rust: cx.events.extend(ev);
}
}
// TryFindLiquidGoal (water): head for nearby water when stranded on land.
TryFindWater :: struct {
    wanted: [f64,
}
    // rust: impl Goal for TryFindWater {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !m.on_ground || m.fluids.in_water {
    // rust: return false;
}
    // rust: let (bx, by, bz) = (
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: );
    // rust: for _ in 0..10 {
    // rust: let p = [
    // rust: bx + m.random.next_int_bound(20).unwrap_or(0) - 10,
    // rust: by + 2 - m.random.next_int_bound(8).unwrap_or(0),
    // rust: bz + m.random.next_int_bound(20).unwrap_or(0) - 10,
    // rust: ];
    // rust: if cx.w.fluid(p[0], p[1], p[2]) == crate::blocks::Fluid::Water {
    // rust: self.wanted = [f64::from(p[0]), f64::from(p[1]), f64::from(p[2])];
    // rust: return true;
}
}
    // rust: false
}
can_continue :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !m.ai.nav.is_done()
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: m.nav_move_to(cx.w, self.wanted, 1.0);
}
}
// The block a mob stands in (`blockPosition`).
block_of :: proc(m: ^Mob) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ]
}
// `MoveToBlockGoal`'s shared state: search, walk to and stay at a block.
MoveToBlock :: struct {
    speed: f64,
    range: i32,
    vertical_range: i32,
    vertical_start: i32,
    next_start: i32,
    try_ticks: i32,
    max_stay: i32,
    reached: bool,
    block: [i32,
}
    // rust: impl MoveToBlock {
new :: proc(speed: f64, range: i32, vertical_range: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: speed,
    // rust: range,
    // rust: vertical_range,
    // rust: ..Default::default()
}
}
    // `canUse` with a custom `nextStartTick` delay.
    // rust: pub fn can_use(
    // rust: &mut self,
    // rust: m: &mut Mob,
    // rust: w: &MobWorld,
    // rust: next: i32,
    // rust: valid: impl Fn(&MobWorld, [i32; 3]) -> bool,
    // rust: ) -> bool {
    // rust: if self.next_start > 0 {
    // rust: self.next_start -= 1;
    // rust: return false;
}
    // rust: self.next_start = next;
    // rust: self.find_nearest(m, w, valid)
}
    // `MoveToBlockGoal.findNearestBlock`: rings outward, alternating heights.
    // rust: pub fn find_nearest(
    // rust: &mut self,
    // rust: m: &Mob,
    // rust: w: &MobWorld,
    // rust: valid: impl Fn(&MobWorld, [i32; 3]) -> bool,
    // rust: ) -> bool {
    // rust: match self.walk(block_of(m), |p| valid(w, p)) {
    // rust: Some(p) => {
    // rust: self.block = p;
    // rust: true
}
    // rust: None => false,
}
}
    // `findNearestBlock`'s walk out from `base`: the first cell `valid` takes.
walk :: proc(self: ^Self, base: [i32; 3], mut valid: impl FnMut([i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let next = |v: i32| if v > 0 { -v } else { 1 - v };
    // rust: let mut y = self.vertical_start;
    // rust: while y <= self.vertical_range {
    // rust: for r in 0..self.range {
    // rust: let mut x = 0;
    // rust: while x <= r {
    // rust: let mut z = if x < r && x > -r { r } else { 0 };
    // rust: while z <= r {
    // rust: let p = [base[0] + x, base[1] + y - 1, base[2] + z];
    // rust: if valid(p) {
    // rust: return Some(p);
}
    // rust: z = next(z);
}
    // rust: x = next(x);
}
}
    // rust: y = next(y);
}
    // rust: None
}
    // The cells [`Self::walk`] can reach from `base`, as a box (inclusive), or
    // `None` when it walks none.
walk_bounds :: proc(self: ^Self, base: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if self.range <= 0 || self.vertical_start > self.vertical_range {
    // rust: return None;
}
        // The heights go out from `vertical_start` both ways, past neither it
        // nor `vertical_range` by more than one, a block below.
    // rust: let reach = self.range - 1;
    // rust: let height = self
    // rust: .vertical_start
    // rust: .saturating_abs()
    // rust: .max(self.vertical_range.saturating_abs())
    // rust: .saturating_add(1);
    // rust: Some((
    // rust: [
    // rust: base[0].saturating_sub(reach),
    // rust: base[1].saturating_sub(height).saturating_sub(1),
    // rust: base[2].saturating_sub(reach),
    // rust: ],
    // rust: [
    // rust: base[0].saturating_add(reach),
    // rust: base[1].saturating_add(height),
    // rust: base[2].saturating_add(reach),
    // rust: ],
    // rust: ))
}
    // Whether [`Self::find_nearest`] may find a block whose state `matches`
    // (its `valid` needs one): false when no section of the cells it walks
    // holds such a state in its palette, so the walk would find nothing.
    // rust: pub fn may_find(
    // rust: &self,
    // rust: m: &Mob,
    // rust: w: &MobWorld,
    // rust: matches: impl FnMut(horizon_world::registry::BlockStateId) -> bool,
    // rust: ) -> bool {
    // rust: self.walk_bounds(block_of(m))
    // rust: .is_some_and(|(lo, hi)| w.world.may_hold(lo, hi, matches))
}
can_continue :: proc(self: ^Self, w: ^MobWorld, valid: impl Fn(^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.try_ticks >= -self.max_stay && self.try_ticks <= 1200 && valid(w, self.block)
}
start :: proc(self: ^Self, m: ^Mob, w: ^MobWorld) {
}
    // rust: let b = self.block;
    // rust: m.nav_move_to(
    // rust: w,
    // rust: [
    // rust: f64::from(b[0]) + 0.5,
    // rust: f64::from(b[1] + 1),
    // rust: f64::from(b[2]) + 0.5,
    // rust: ],
    // rust: self.speed,
    // rust: );
    // rust: self.try_ticks = 0;
    // rust: let r = m.random.next_int_bound(1200).unwrap_or(0) + 1200;
    // rust: self.max_stay = m.random.next_int_bound(r).unwrap_or(0) + 1200;
}
    // `MoveToBlockGoal.tick` (accepted distance 1 from the block above).
tick :: proc(self: ^Self, m: ^Mob, w: ^MobWorld) {
}
    // rust: self.tick_within(m, w, 1.0);
}
    // `MoveToBlockGoal.tick` with the goal's `acceptedDistance`.
tick_within :: proc(self: ^Self, m: ^Mob, w: ^MobWorld, accepted: f64) {
}
    // rust: let t = [
    // rust: f64::from(self.block[0]) + 0.5,
    // rust: f64::from(self.block[1] + 1) + 0.5,
    // rust: f64::from(self.block[2]) + 0.5,
    // rust: ];
    // rust: let d2 = (m.position.x - t[0]).powi(2)
    // rust: + (m.position.y - t[1]).powi(2)
    // rust: + (m.position.z - t[2]).powi(2);
    // rust: if d2 >= accepted * accepted {
    // rust: self.reached = false;
    // rust: self.try_ticks += 1;
    // rust: if self.try_ticks % 40 == 0 {
    // rust: m.nav_move_to(w, [t[0], t[1] - 0.5, t[2]], self.speed);
}
    // rust: } else {
    // rust: self.reached = true;
    // rust: self.try_ticks -= 1;
}
}
}

    // rust: mod eat_block_tests {
//     use super::*;
//     use crate::mobs::world::with_built_test_world_rules;

    // A sheep on a wide grass shelf, ticked long enough for its `EatBlockGoal`
    // (1 in 1000 a tick) to fire several times: every event it pushed, with
    // the `mob_griefing` game rule at `griefing` and `mob_drops` on. `tufts`
    // puts short grass at the sheep's own feet, so the goal takes the
    // `destroyBlock` half; without it the sheep stands on the grass and takes
    // the grass-to-dirt half.
sheep_events :: proc(griefing: bool, tufts: bool) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = None;
    // rust: let build = |world: &mut crate::world::World,
    // rust: registry: &horizon_world::registry::BlockRegistry| {
    // rust: let grass = registry.default_state("minecraft:grass_block").unwrap();
    // rust: let tuft = registry.default_state("minecraft:short_grass").unwrap();
    // rust: for cx in -3..3 {
    // rust: for cz in -3..3 {
    // rust: world
    // rust: .chunks
    // rust: .insert((cx, cz), Arc::new(crate::chunk::Chunk::empty(cx, cz)));
}
}
    // rust: for x in -8..=8 {
    // rust: for z in -8..=8 {
    // rust: world.set(x, 63, z, grass).unwrap();
    // rust: if tufts {
    // rust: world.set(x, 64, z, tuft).unwrap();
}
}
}
}
    // rust: with_built_test_world_rules(&[], griefing, true, build, |w, types| {
    // rust: let kind = Arc::new(types.types["minecraft:sheep"].clone());
    // rust: let mut m = Mob::new(1, kind, Vec3::new(0.5, 64.0, 0.5), 0.0);
    // rust: let mut random = LegacyRandom::new(0);
    // rust: let mut events = Vec::new();
    // rust: for _ in 0..6000 {
    // rust: crate::mobs::ai::tick(&mut m, w, &mut random, &mut events);
}
    // rust: out = Some(events);
    // rust: });
    // rust: out
}

    // `EatBlockGoal.tick` puts the `levelEvent` + `setBlock` behind
    // `MOB_GRIEFING` and leaves `Mob.ate` outside it, so with the rule off the
    // goal still runs (`EntityEvent` 10) and still shears the coat, and the
    // grass stays.
the_eat_goal_turns_grass_to_dirt_only_with_mob_griefing :: proc() {
}
    // rust: let Some(on) = sheep_events(true, false) else {
    // rust: return;
}
    // rust: let Some(off) = sheep_events(false, false) else {
    // rust: return;
}
    // rust: let dirt = |events: &[MobEvent]| {
    // rust: events
    // rust: .iter()
    // rust: .filter(|e| matches!(e, MobEvent::SetBlockName { name, .. } if *name == "minecraft:dirt"))
    // rust: .count()
}
    // rust: let ate = |events: &[MobEvent]| {
    // rust: events
    // rust: .iter()
    // rust: .filter(|e| matches!(e, MobEvent::EntityEvent { event: 10, .. }))
    // rust: .count()
}
    // rust: assert!(dirt(&on) > 0, "mob_griefing on: {}", dirt(&on));
    // rust: assert_eq!(dirt(&off), 0, "mob_griefing off must leave the grass alone");
    // rust: assert!(ate(&off) > 0, "the goal still runs with the rule off");
}

    // The edible half of the same gate (`ifeq 89` skips
    // `Level.destroyBlock(pos, false)`): short grass at the sheep's feet
    // disappears with the rule on and stays with it off, while the goal eats
    // either way.
the_eat_goal_breaks_short_grass_only_with_mob_griefing :: proc() {
}
    // rust: let Some(on) = sheep_events(true, true) else {
    // rust: return;
}
    // rust: let Some(off) = sheep_events(false, true) else {
    // rust: return;
}
    // rust: let bitten = |events: &[MobEvent]| {
    // rust: events
    // rust: .iter()
    // rust: .filter(|e| matches!(e, MobEvent::BreakBlock { drop: false, .. }))
    // rust: .count()
}
    // rust: let ate = |events: &[MobEvent]| {
    // rust: events
    // rust: .iter()
    // rust: .filter(|e| matches!(e, MobEvent::EntityEvent { event: 10, .. }))
    // rust: .count()
}
    // rust: assert!(bitten(&on) > 0, "mob_griefing on: {}", bitten(&on));
    // rust: assert_eq!(
    // rust: bitten(&off),
    // rust: 0,
    // rust: "mob_griefing off must leave the tufts alone"
    // rust: );
    // rust: assert!(ate(&off) > 0, "the goal still runs with the rule off");
}
}

    // rust: mod built_by_player_tests {
//     use super::*;

    // A mob of `species`, from a made-up type.
mob :: proc(species: Species) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: Arc::make_mut(&mut kind).species = species;
    // rust: Mob::new(1, kind, Vec3::ZERO, 0.0)
}

    // `IronGolem.canAttack`: only a golem a player built spares players, so
    // the save restore drops that target (`Mob.asValidTarget`) while another
    // mob's `PlayerCreated` byte means nothing.
only_a_golem_spares_the_player_that_built_it :: proc() {
}
    // rust: let mut built = mob(Species::IronGolem);
    // rust: built.extra.player_created = true;
    // rust: assert!(built.built_by_player());
    // rust: assert!(!mob(Species::IronGolem).built_by_player());
    // rust: let mut zombie = mob(Species::Zombie);
    // rust: zombie.extra.player_created = true;
    // rust: assert!(!zombie.built_by_player());
}
}

    // rust: mod avoid_entity_targeting_tests {
//     use super::*;
//     use crate::mobs::world::test_player;
//     use crate::mobs::world::with_built_test_world;
//     use std::sync::Arc;

    // `(the player is inside the plain distance range, the goal picks them)`.
    // The wall stands at z 5..6, between the rabbit at z 0.5 and the player at
    // z 10.5, so sight is the only thing that changes between the two.
target :: proc(difficulty: u8, wall: bool) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let build = move |world: &mut crate::world::World,
    // rust: registry: &horizon_world::registry::BlockRegistry| {
    // rust: for cx in -1..1 {
    // rust: for cz in -1..1 {
    // rust: world.chunks.insert(
    // rust: (cx, cz),
    // rust: std::sync::Arc::new(crate::chunk::Chunk::empty(cx, cz)),
    // rust: );
}
}
    // rust: let stone = registry.default_state("minecraft:stone").unwrap();
    // rust: for x in -4..5 {
    // rust: for z in -4..15 {
    // rust: world.set(x, 64, z, stone).unwrap();
}
}
    // rust: if wall {
    // rust: for x in -4..5 {
    // rust: for y in 65..68 {
    // rust: for z in 5..7 {
    // rust: world.set(x, y, z, stone).unwrap();
}
}
}
}
}
    // rust: let mut out = None;
    // rust: let ran = with_built_test_world(&[], build, |w, types| {
    // rust: let mut world = w.clone();
    // rust: world.difficulty = super::super::spawning::LocalDifficulty::new(difficulty, 0, 0, 0.0);
    // rust: let player = test_player(Vec3::new(0.5, 65.0, 10.5));
    // rust: world.player = Some(player.clone());
    // rust: let mut m = Mob::new(
    // rust: 1,
    // rust: Arc::new(types.types["minecraft:rabbit"].clone()),
    // rust: Vec3::new(0.5, 65.0, 0.5),
    // rust: 0.0,
    // rust: );
    // rust: let mut goal = AvoidEntity::new(Avoid::Player, 20.0, 1.0, 1.0);
    // rust: let (mut lr, mut events) = (horizon_core::random::LegacyRandom::new(0), Vec::new());
    // rust: let mut cx = Cx {
    // rust: w: &world,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
}
    // rust: let in_range = m.distance_sqr(player.position) <= 20.0 * 20.0;
    // rust: out = Some((in_range, goal.avoid_target(&mut m, &mut cx).is_some()));
    // rust: });
    // rust: ran.then_some(out).flatten()
}

    // `Sensing.hasLineOfSight`: the player is ten blocks away, well inside the
    // 20 block range, but the wall is between them, so the goal must not pick
    // them (it did before: only the distance was checked).
a_rabbit_does_not_flee_a_player_behind_a_wall :: proc() {
}
    // rust: if let Some((in_range, picked)) = target(2, true) {
    // rust: assert!(in_range, "the player is inside the plain distance range");
    // rust: assert!(!picked, "the rabbit picked a player it cannot see");
}
}

    // `LivingEntity.canAttack`: in Peaceful no player is a target at all, so
    // the goal does not pick them even in plain sight.
a_rabbit_does_not_flee_in_peaceful :: proc() {
}
    // rust: if let Some((in_range, picked)) = target(0, false) {
    // rust: assert!(in_range, "the player is inside the plain distance range");
    // rust: assert!(!picked, "the rabbit picked a player in Peaceful");
}
}

    // The control: the same world on normal difficulty with nothing in the way
    // still picks the player.
a_rabbit_flees_a_player_it_can_see :: proc() {
}
    // rust: if let Some((in_range, picked)) = target(2, false) {
    // rust: assert!(in_range, "the player is inside the plain distance range");
    // rust: assert!(picked, "the rabbit ignored a player in the open");
}
}
}

    // rust: mod peaceful_targets_tests {
//     use super::*;
//     use crate::mobs::world::{test_player, with_test_world};

    // `LivingEntity.canAttack` / `TargetingConditions.test`: in Peaceful a
    // hurt wolf neither takes its attacker (a player) as target nor picks one
    // by sight, while at Normal it does.
peaceful_mobs_never_target_the_player :: proc() {
}
    // rust: with_test_world(&[], |w, types| {
    // rust: let mut w = w.clone();
    // rust: w.player = Some(test_player(Vec3::new(2.5, 64.0, 0.5)));
    // rust: let kind = Arc::new(types.types["minecraft:wolf"].clone());
    // rust: let mut wolf = Mob::new(1, kind, Vec3::new(0.5, 64.0, 0.5), 0.0);
    // rust: wolf.ai.last_hurt_by = Some(Who::Player);
    // rust: wolf.ai.last_hurt_by_time = 5;
    // rust: let mut random = LegacyRandom::new(0);
    // rust: let mut events = Vec::new();
    // rust: let mut cx = Cx {
    // rust: w: &w,
    // rust: lr: &mut random,
    // rust: events: &mut events,
}
    // rust: assert!(
    // rust: HurtByTarget::default().can_use(&mut wolf, &mut cx),
    // rust: "normal"
    // rust: );
    // rust: assert!(wolf.can_target_player(&w, 16.0, false), "normal");

    // rust: let mut peaceful = w.clone();
    // rust: peaceful.difficulty = crate::mobs::spawning::LocalDifficulty::new(0, 18000, 0, 0.0);
    // rust: let mut cx = Cx {
    // rust: w: &peaceful,
    // rust: lr: &mut random,
    // rust: events: &mut events,
}
    // rust: assert!(
    // rust: !HurtByTarget::default().can_use(&mut wolf, &mut cx),
    // rust: "peaceful"
    // rust: );
    // rust: assert!(!wolf.can_target_player(&peaceful, 16.0, false), "peaceful");
    // rust: assert!(!wolf.can_keep_target_player(&peaceful, 16.0), "peaceful");
    // rust: });
}
}
    // rust: mod move_to_block_tests {
//     use super::MoveToBlock;

    // Every cell the walk tries lies in the box `may_find` asks the
    // palettes about, for the ranges the goals use and odd ones; and the
    // walk stops at the first cell it is given.
the_walk_stays_in_its_bounds :: proc() {
}
    // rust: for range in [-1, 0, 1, 2, 8, 24] {
    // rust: for vertical_range in [-2, 0, 1, 2, 3, 6] {
    // rust: for vertical_start in [-3, -1, 0, 1, 2] {
    // rust: let goal = MoveToBlock {
    // rust: range,
    // rust: vertical_range,
    // rust: vertical_start,
    // rust: ..Default::default()
}
    // rust: for base in [[0, 64, 0], [-17, -60, 31], [100, 319, -100]] {
    // rust: let bounds = goal.walk_bounds(base);
    // rust: let mut walked = 0;
    // rust: let found = goal.walk(base, |p| {
    // rust: walked += 1;
    // rust: let (lo, hi) = bounds.expect("a walk with no bounds");
    // rust: assert!((0..3).all(|a| lo[a] <= p[a] && p[a] <= hi[a]), "{p:?}");
    // rust: false
    // rust: });
    // rust: assert_eq!(found, None);
    // rust: assert_eq!(
    // rust: walked > 0,
    // rust: bounds.is_some(),
    // rust: "{range} {vertical_range} {vertical_start}"
    // rust: );
}
}
}
}
    // rust: let goal = MoveToBlock::new(1.0, 24, 2);
    // rust: assert_eq!(goal.walk([5, 64, 5], |_| true), Some([5, 63, 5]));
}
}

    // rust: mod breed_xp_tests {
//     use super::*;

    // Two llamas in love, two blocks apart on a flat grass shelf, ticked by
    // the AI until the first breeds: its own events, with the `mob_drops`
    // game rule at `drops`. `None` without the vanilla data.
llama_events :: proc(drops: bool) -> O {
    // Ported from Horizon
    return {}
}
        // The partner's `Seen` needs its kind, so two loads.
    // rust: let mut kind = None;
    // rust: crate::mobs::world::with_built_test_world_rules(&[], true, drops, shelf, |_, types| {
    // rust: kind = Some(Arc::new(types.types["minecraft:llama"].clone()));
    // rust: });
    // rust: let kind = kind?;
    // rust: let mut partner = Mob::new(2, kind.clone(), Vec3::new(2.5, 64.0, 0.5), 0.0);
        // AbstractHorse.canParent: only tame llamas breed.
    // rust: partner.extra.tame = true;
    // rust: partner.extra.in_love = 600;
    // rust: let seen = [partner.seen(None)];
    // rust: let mut out = None;
    // rust: crate::mobs::world::with_built_test_world_rules(&seen, true, drops, shelf, |w, _| {
    // rust: let mut m = Mob::new(1, kind, Vec3::new(0.5, 64.0, 0.5), 0.0);
    // rust: m.extra.in_love = 600;
    // rust: m.extra.tame = true;
    // rust: let mut lr = LegacyRandom::new(0);
    // rust: let mut events = Vec::new();
    // rust: for _ in 0..600 {
    // rust: crate::mobs::ai::tick(&mut m, w, &mut lr, &mut events);
    // rust: if events
    // rust: .iter()
    // rust: .any(|e| matches!(e, MobEvent::Breed { parent: 1, .. }))
    // rust: {
    // rust: break;
}
}
    // rust: out = Some(events);
    // rust: });
    // rust: out
}

    // A flat grass shelf two llamas can stand on.
shelf :: proc(world: ^crate::world::World, registry: ^horizon_world::registry::BlockRegistry) {
}
    // rust: let grass = registry.default_state("minecraft:grass_block").unwrap();
    // rust: for cx in -3..3 {
    // rust: for cz in -3..3 {
    // rust: world
    // rust: .chunks
    // rust: .insert((cx, cz), Arc::new(crate::chunk::Chunk::empty(cx, cz)));
}
}
    // rust: for x in -8..=8 {
    // rust: for z in -8..=8 {
    // rust: world.set(x, 63, z, grass).unwrap();
}
}
}

    // `finalizeSpawnChildFromBreeding` makes the experience draw only inside
    // the `mob_drops` check, from the breeding parent's own random: the
    // breed goal pushes one 1-7 orb with the rule on, none with it off, and
    // the pair breeds either way.
the_breed_xp_follows_the_mob_drops_rule :: proc() {
}
    // rust: let Some(on) = llama_events(true) else {
    // rust: return;
}
    // rust: let Some(off) = llama_events(false) else {
    // rust: return;
}
    // rust: let orb = |events: &[MobEvent]| {
    // rust: events.iter().find_map(|e| match e {
    // rust: MobEvent::Experience { amount, .. } => Some(*amount),
    // rust: _ => None,
    // rust: })
}
    // rust: assert!(
    // rust: orb(&on).is_some_and(|a| (1..=7).contains(&a)),
    // rust: "mob_drops on: one orb of 1-7, got {:?}",
    // rust: orb(&on)
    // rust: );
    // rust: assert!(orb(&off).is_none(), "mob_drops off: no experience draw");
    // rust: assert!(
    // rust: on.iter()
    // rust: .any(|e| matches!(e, MobEvent::Breed { parent: 1, .. })),
    // rust: "mob_drops on: the pair breeds"
    // rust: );
    // rust: assert!(
    // rust: off.iter()
    // rust: .any(|e| matches!(e, MobEvent::Breed { parent: 1, .. })),
    // rust: "mob_drops off: the pair still breeds"
    // rust: );
}
}
