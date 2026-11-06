//! Transpiled from Horizon Rust crate
//! Module: horizon-client_strider
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Striders (`Strider`): their goals, standing and floating on lava
//! (`floatStrider`, `canStandOnFluid`), going cold away from warm blocks
//! (`setSuffocating`) and heading back to lava (`StriderGoToLavaGoal`).
//! `extra.flag` is the synced `DATA_SUFFOCATING`.
// use super::{
    // rust: Mob, MobEvent, MobWorld, Species,
    // rust: data::LAND,
    // rust: goals::{
    // rust: Breed, Cx, FollowParent, Goal, JUMP, LookAtPlayer, MOVE, MoveToBlock, Panic,
    // rust: RandomLookAround, Stroll, Tempt, goal_clone, reduced,
    // rust: },
    // rust: path::PathType,
}
// use crate::blocks::Fluid;
// use horizon_core::random::RandomSource;

/// `SUFFOCATING_MODIFIER`: `-0.34F`, `ADD_MULTIPLIED_BASE`.
pub const SUFFOCATING: f64 = -0.34_f32 as f64;

pub fn register(m: *mut Mob) void {
}
    // rust: m.set_malus(PathType::Water, -1.0);
    // rust: m.set_malus(PathType::Lava, 0.0);
    // rust: m.set_malus(PathType::FireInNeighbor, 0.0);
    // rust: m.set_malus(PathType::Fire, 0.0);
    // rust: let tempt = m.kind.tempt.clone();
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(1, Panic::new(1.65));
    // rust: g.add(2, Breed::new(1.0));
    // rust: g.add(3, Tempt::new(1.4, tempt, false));
    // rust: g.add(4, GoToLava(MoveToBlock::new(1.0, 8, 2)));
    // rust: g.add(5, FollowParent::new(1.0));
    // rust: g.add(7, Stroll::new(1.0).interval(60));
    // rust: g.add(8, LookAtPlayer::new(8.0));
    // rust: g.add(8, RandomLookAround::default());
    // rust: g.add(9, LookAtPlayer::species(Species::Strider, 8.0));
}
pub fn suffocating(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.species() == Species::Strider && m.extra.flag
}
/// The movement speed attribute with `SUFFOCATING_MODIFIER` while cold.
pub fn movement_speed(m: *Mob, base: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if suffocating(m) {
    // rust: base + base * SUFFOCATING
    // rust: } else {
    // rust: base
}
}
/// `Strider.tick` before `super.tick()`: the tempted and retreating sounds,
/// then cold unless in or on a warm block or riding a warm strider.
pub fn pre_tick(m: *mut Mob, w: *MobWorld, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if m.ai.goals.is_running("Tempt") && m.random.next_int_bound(140).unwrap_or(1) == 0 {
    // rust: m.voice("entity.strider.happy", events);
    // rust: } else if m.ai.panicking && m.random.next_int_bound(60).unwrap_or(1) == 0 {
    // rust: m.voice("entity.strider.retreat", events);
}
    // rust: if m.no_ai {
    // rust: return;
}
    // rust: let warm = |p: [i32; 3]| {
    // rust: w.has_tag(
    // rust: "minecraft:strider_warm_blocks",
    // rust: w.block_name(p[0], p[1], p[2]),
    // rust: )
}
    // rust: let inside = [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ];
    // rust: let in_warm = warm(inside) || warm(m.block_on_legacy(w)) || m.fluids.lava > 0.0;
    // rust: let on_warm_strider = m
    // rust: .extra
    // rust: .mount
    // rust: .and_then(|id| w.seen(id))
    // rust: .is_some_and(|v| v.species == Species::Strider && !v.cold_strider);
    // rust: m.extra.flag = !in_warm && !on_warm_strider;
}
/// `Strider.floatStrider`, after the living tick: standing on the surface of
/// lava, or bobbing up through it.
pub fn float(m: *mut Mob, w: *MobWorld) void {
}
    // rust: if !m.fluids.in_lava {
    // rust: return;
}
    // rust: let (x, y, z) = (
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: );
    // `CollisionContext.isAbove(getLiquidCollisionShape(), blockPosition())`:
    // the column is half a block tall.
    // rust: let above = m.position.y > f64::from(y) + 0.5 - f64::from(1.0e-5_f32);
    // rust: if above && w.fluid(x, y + 1, z) != Fluid::Lava {
    // rust: m.on_ground = true;
    // rust: } else {
    // rust: let v = m.velocity;
    // rust: m.velocity = horizon_core::geometry::Vec3::new(v.x * 0.5, v.y * 0.5 + 0.05, v.z * 0.5);
}
}
/// `Strider.getWalkTargetValue`.
pub fn walk_target_value(m: *Mob, w: *MobWorld, p: [i32; 3]) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if w.fluid(p[0], p[1], p[2]) == Fluid::Lava {
    // rust: 10.0
    // rust: } else if m.fluids.in_lava {
    // rust: f32::NEG_INFINITY
    // rust: } else {
    // rust: 0.0
}
}
/// `StriderGoToLavaGoal.isValidTarget`: lava with room to stand above.
pub fn lava_target(w: *MobWorld, p: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: w.block_name(p[0], p[1], p[2]) == "minecraft:lava"
    // rust: && w.data.state(w.world.block(p[0], p[1] + 1, p[2])).flags & LAND != 0
}
/// `Strider.StriderGoToLavaGoal`: a `MoveToBlockGoal` for the nearest lava,
/// aiming at the lava block itself rather than the one above.
pub const GoToLava = struct {};
    // rust: impl Goal for GoToLava {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MOVE | JUMP
}
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: "StriderGoToLavaGoal"
}
pub fn every_tick(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if m.fluids.in_lava {
    // rust: return false;
}
    // rust: if self.0.next_start > 0 {
    // rust: self.0.next_start -= 1;
    // rust: return false;
}
    // rust: self.0.next_start = reduced(200 + m.random.next_int_bound(200).unwrap_or(0));
    // rust: self.0.find_nearest(m, cx.w, lava_target)
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !m.fluids.in_lava && lava_target(cx.w, self.0.block)
}
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.0.start(m, cx.w);
}
    /// `MoveToBlockGoal.tick` towards `getMoveToTarget()` (the lava block),
    /// recomputing the path every 20 ticks (`shouldRecalculatePath`).
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let b = self.0.block;
    // rust: let center = [
    // rust: f64::from(b[0]) + 0.5,
    // rust: f64::from(b[1]) + 0.5,
    // rust: f64::from(b[2]) + 0.5,
    // rust: ];
    // rust: let d2 = (m.position.x - center[0]).powi(2)
    // rust: + (m.position.y - center[1]).powi(2)
    // rust: + (m.position.z - center[2]).powi(2);
    // rust: if d2 >= 1.0 {
    // rust: self.0.reached = false;
    // rust: self.0.try_ticks += 1;
    // rust: if self.0.try_ticks % 20 == 0 {
    // rust: let speed = self.0.speed;
    // rust: m.nav_move_to(cx.w, [center[0], f64::from(b[1]), center[2]], speed);
}
    // rust: } else {
    // rust: self.0.reached = true;
    // rust: self.0.try_ticks -= 1;
}
}
}
