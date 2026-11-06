//! Transpiled from Horizon Rust crate
//! Module: horizon-client_brain
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Pieces of vanilla's `Brain` that species implemented as brains share:
//! memories that expire, behaviour durations, walk targets and
//! `MoveToTargetSink`.
// use super::{Mob, MobWorld, Who, goals::Cx};
// use horizon_core::{
    // rust: geometry::Vec3,
    // rust: random::{LegacyRandom, RandomSource},
}

/// A memory with an expiry (`Brain.setMemoryWithExpiry`): present for the
/// tick it was set and `ttl` more ticks. `Ttl::default()` is absent.
pub const Ttl = struct {};
    // rust: impl Ttl {
pub fn set(self: *Self, ttl: i32) void {
}
    // rust: self.0 = ttl + 1;
}
pub fn erase(self: *Self) void {
}
    // rust: self.0 = 0;
}
pub fn present(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0 > 0
}
    /// `Brain.forgetOutdatedMemories`, once at the start of each tick.
pub fn tick(self: *Self) void {
}
    // rust: if self.0 > 0 {
    // rust: self.0 -= 1;
}
}
}
/// `Behavior`'s bookkeeping in the brains ported behaviour for behaviour
/// (villager, animal, monster, warden): running, and until when.
pub const Timed = struct {
    running: bool,
    end: i64,
    min: i32,
    max: i32,
};
    // rust: impl Timed {
pub fn new(min: i32, max: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: running: false,
    // rust: end: 0,
    // rust: min,
    // rust: max,
}
}
    /// `Behavior.tryStart`'s duration draw from the level random, in Java's
    /// int arithmetic (made even when it cannot vary).
pub fn begin(self: *Self, lr: *mut LegacyRandom, now: i64) void {
}
    // rust: self.running = true;
    // rust: let bound = self.max.wrapping_add(1).wrapping_sub(self.min);
    // rust: let d = self.min.wrapping_add(lr.next_int_bound(bound).unwrap_or(0));
    // rust: self.end = now + i64::from(d);
}
    /// `Behavior.timedOut`.
pub fn timed_out(self: *Self, now: i64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: now > self.end
}
}
/// `NearestLivingEntitySensor`'s scan: the living entities (the player
/// among them) whose boxes meet the follow range around `m`, nearest first.
pub fn living_near(m: *Mob, w: *MobWorld) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let r = m.attrs.follow_range;
    // rust: let area = m.bounds().inflate(Vec3::new(r, r, r));
    // rust: let mut found: Vec<(Who, f64)> = Vec::new();
    // rust: for o in w.others_near(area) {
    // rust: if o.id != m.id && o.alive && o.bounds.intersects(area) {
    // rust: found.push((Who::Mob(o.id), m.distance_sqr(o.position)));
}
}
    // rust: if let Some(p) = &w.player
    // rust: && p.alive
    // rust: && p.bounds.intersects(area)
    // rust: {
    // rust: found.push((Who::Player, m.distance_sqr(p.position)));
}
    // rust: found.sort_by(|a, b| a.1.total_cmp(&b.1));
    // rust: found.into_iter().map(|(w, _)| w).collect()
}
/// A random duration in `min..=max` (`Behavior`'s end time).
pub fn duration(m: *mut Mob, min: i32, max: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if max <= min {
    // rust: return min;
}
    // rust: min + m.random.next_int_bound(max - min + 1).unwrap_or(0)
}
/// `WalkTarget`: where to go, how fast and how close counts as there.
pub const WalkTarget = struct {
    pos: [i32,
    speed: f64,
    close: i32,
};
    // rust: impl WalkTarget {
pub fn new(pos: [i32; 3], speed: f64, close: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self { pos, speed, close }
}
    /// `MoveToTargetSink.reachedTarget`: Manhattan distance of blocks.
pub fn reached(self: *Self, m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let here = [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ];
    // rust: let d = (self.pos[0] - here[0]).abs()
    // rust: + (self.pos[1] - here[1]).abs()
    // rust: + (self.pos[2] - here[2]).abs();
    // rust: d <= self.close
}
}
/// `MoveToTargetSink(min, max)`: walks to the walk target and gives up on it
/// after a random time.
pub const Sink = struct {
    min: i32,
    max: i32,
    until: ?i32,
};
    // rust: impl Sink {
pub fn new(min: i32, max: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: min,
    // rust: max,
    // rust: until: None,
}
}
pub fn running(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.until.is_some()
}
    /// `stop`: forget the walk target and the path.
pub fn stop(self: *Self, m: *mut Mob, walk: *mut ?WalkTarget) void {
}
    // rust: if self.until.take().is_some() {
    // rust: m.nav_stop();
}
    // rust: *walk = None;
}
    /// One tick of `checkExtraStartConditions`, `canStillUse`, `tick` and
    /// `stop` for the walk target.
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx, walk: *mut ?WalkTarget) void {
}
    // rust: let now = m.age as i32;
    // rust: if let Some(until) = self.until {
    // rust: let still = !m.ai.nav.is_done() && walk.is_some_and(|w| !w.reached(m));
    // rust: if now > until || !still {
    // rust: self.stop(m, walk);
}
    // rust: return;
}
    // rust: let Some(target) = *walk else { return };
    // rust: if target.reached(m) {
    // rust: *walk = None;
    // rust: return;
}
    // rust: let at = [
    // rust: f64::from(target.pos[0]) + 0.5,
    // rust: f64::from(target.pos[1]),
    // rust: f64::from(target.pos[2]) + 0.5,
    // rust: ];
    // rust: let mut moving = m.nav_move_to(cx.w, at, target.speed);
    // rust: if !moving {
            // A partial step toward it (`DefaultRandomPos.getPosTowards`).
    // rust: moving = m
    // rust: .default_random_pos_towards(cx.w, 10, 7, at, std::f64::consts::FRAC_PI_2)
    // rust: .is_some_and(|p| m.nav_move_to(cx.w, p, target.speed));
}
    // rust: if moving {
    // rust: self.until = Some(now + duration(m, self.min, self.max));
    // rust: } else {
    // rust: *walk = None;
}
}
}
    // rust: mod tests {
//     use super::*;

pub fn a_memory_lasts_its_expiry_and_the_tick_it_was_set() void {
}
    // rust: let mut t = Ttl::default();
    // rust: assert!(!t.present());
    // rust: t.set(2);
    // rust: let mut ticks = 0;
    // rust: while t.present() {
    // rust: ticks += 1;
    // rust: t.tick();
}
    // rust: assert_eq!(ticks, 3);
}
}
