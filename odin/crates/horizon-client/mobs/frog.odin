//! Transpiled from Horizon Rust crate
package horizon_client_frog

import "core:fmt"
import "core:mem"
import "core:math"

// Frogs (`Frog`, `FrogAi`): the `Croak`, `ShootTongue` and long jump
// behaviours as goals, the poses they set and the client's animation states.
// AnimState states: jump, croak, tongue, swim idle.
//
// The brain's idle `RunOne` picks a croak three times as often as a stroll
// (weights 3 and 1; it also holds a do-nothing option that only repeats
// the pick), so a frog that is not walking croaks in three of four idle
// picks: `Croak` takes those, and the frog's stroll then follows at once.
// use super::{
    // rust: Mob, MobEvent, MobWorld, Species, Who,
    // rust: goals::{
    // rust: Breed, Cx, Float, Goal, LOOK, LookAtPlayer, MOVE, Panic, RandomLookAround, Stroll, Tempt,
    // rust: goal_clone,
    // rust: },
    // rust: sync,
}
// use crate::blocks::Fluid;
// use horizon_core::{
    // rust: geometry::Vec3,
    // rust: random::{LegacyRandom, RandomSource},
}
// use std::fmt::Debug;

JUMP :: 0
CROAK :: 1
TONGUE :: 2
SWIM_IDLE :: 3

// `Croak.CROAK_TICKS`.
CROAK_TICKS :: 60
// `ShootTongue`'s duration and eating distance.
TONGUE_TIME_OUT :: 100
EATING_DISTANCE :: 1.75
// `FrogAttackablesSensor.TARGET_DETECTION_DISTANCE` and the sensor's scan
// rate.
DETECTION_DISTANCE :: 10.0
SCAN_RATE :: 20

// `FrogAi.TIME_BETWEEN_LONG_JUMPS` and the brain memory
// `LONG_JUMP_COOLDOWN_TICKS` (saved with the others, as `finalize` sets it).
TIME_BETWEEN_LONG_JUMPS :: (100, 140)
// `GoatAi.TIME_BETWEEN_LONG_JUMPS`.
GOAT_TIME_BETWEEN_LONG_JUMPS :: (600, 1200)
LONG_JUMP_COOLDOWN :: "long_jump_cooling_down"
// `FrogAi`'s `LongJumpToPreferredBlock`: `MAX_LONG_JUMP_WIDTH`,
// `MAX_LONG_JUMP_HEIGHT`, `MAX_JUMP_VELOCITY_MULTIPLIER` and the chance to
// look for a lily pad or big dripleaf first.
JUMP_WIDTH :: 4
JUMP_HEIGHT :: 2
// The goat's `MAX_JUMP_VELOCITY_MULTIPLIER` is the same number.
JUMP_VELOCITY_MULTIPLIER :: 3.571_428_8
PREFERRED_BLOCKS_CHANCE :: 0.5
// `GoatAi`'s `LongJumpToRandomPos`: `MAX_LONG_JUMP_WIDTH` and
// `MAX_LONG_JUMP_HEIGHT`.
GOAT_JUMP_WIDTH :: 5
GOAT_JUMP_HEIGHT :: 5
// `LongJumpToRandomPos.ALLOWED_ANGLES`, `FIND_JUMP_TRIES` and
// `PREPARE_JUMP_DURATION`.
ALLOWED_ANGLES :: [65, 70, 75, 80]
FIND_JUMP_TRIES :: 20
PREPARE_JUMP_DURATION :: 40
// `LongJumpMidJump`'s duration (`TIME_OUT_DURATION`).
MID_JUMP_DURATION :: 100

// `ShootTongue.State`.
Phase :: enum {
    MoveToTarget,
    CatchAnimation,
    EatAnimation,
    Done,
}

// The frog's brain memories and `DATA_TONGUE_TARGET_ID`.
State :: struct {
    croak: i32,
    // The land beside water `LaySpawn` walks to (its `WALK_TARGET`).
    lay_target: Option<[i32,
    // Ticks to the attackables sensor's next scan, and `NEAREST_ATTACKABLE`.
    scan: i32,
    nearest: Maybe(u32),
    // `UNREACHABLE_TONGUE_TARGETS`: the mob and the ticks it stays in mind.
    unreachable: Vec<(u32,
    // `ATTACK_TARGET` while `ShootTongue` runs, and the synched tongue target.
    target: Maybe(u32),
    tongue_target: Maybe(u32),
    phase: Phase,
    eat_timer: i32,
    path_counter: i32,
    time: i32,
    // `LivingEntity.discardFriction`, set through the long jump.
    discard_friction: bool,
}

register :: proc(m: ^Mob) {
}
    // rust: let food = m.kind.food.clone();
    // `Frog()`: SmoothSwimmingMoveControl(85, 10, 0.02, 0.1, true). The
    // frog's movement speed is 1.0, so the controller's 0.1 outside-water
    // speed is what keeps a walking frog at vanilla's pace; the plain ground
    // controller walks ten times too fast (#2213).
    // rust: m.ai.mov.kind = super::control::MoveKind::SmoothSwimming {
    // rust: max_turn_x: 85.0,
    // rust: max_turn_y: 10.0,
    // rust: in_water: 0.02,
    // rust: outside: 0.1,
    // rust: gravity: true,
}
    // `Frog.FrogPathNavigation` (`AmphibiousPathNavigation`, and
    // `prefersShallowSwimming` is the frog's own override): water deeper than
    // ten blocks under sea level costs more, so a frog paths the shallows.
    // rust: m.ai.nav.kind = super::nav::NavKind::Amphibious {
    // rust: prefers_shallow: true,
}
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(0, Float);
    // rust: g.add(1, Panic::new(1.25));
    // `FrogAi.initIdleActivity`: `AnimalMakeLove` first, then `FollowTemptation(1.25)`.
    // rust: g.add(2, Breed::new(1.0));
    // rust: g.add(3, Unless(is_pregnant, Tempt::new(1.25, food, false)));
    // rust: g.add(2, ShootTongue);
    // rust: g.add(2, LaySpawn::default());
    // rust: g.add(3, LongJump::default());
    // rust: g.add(4, Croak);
    // rust: g.add(
    // rust: 5,
    // rust: Unless(laying_trip, Stroll::avoiding_water(1.0).interval(1)),
    // rust: );
    // rust: g.add(6, LookAtPlayer::new(6.0));
    // rust: g.add(7, RandomLookAround::default());
}

// `Entity.setPose` and `Frog.onSyncedDataUpdated(DATA_POSE)`.
set_pose :: proc(m: ^Mob, id: u8) {
}
    // rust: let old = std::mem::replace(&mut m.extra.pose, id);
    // rust: if old != id {
    // rust: pose_changed(m);
}
}
// The animation states of the pose the frog has taken.
pose_changed :: proc(m: ^Mob) {
}
    // rust: let age = m.age as f32;
    // rust: let pose = m.extra.pose;
    // rust: let states = &mut m.anim.states;
    // rust: for (state, on) in [
    // rust: (JUMP, pose == sync::LONG_JUMPING),
    // rust: (CROAK, pose == sync::CROAKING),
    // rust: (TONGUE, pose == sync::USING_TONGUE),
    // rust: ] {
    // rust: if on {
    // rust: states[state].start(age);
    // rust: } else {
    // rust: states[state].stop();
}
}
}
// `Frog.tick` on a client: the idle swim while it floats still. The server
// runs it too, for a window that shows its own mobs.
tick :: proc(m: ^Mob) {
}
    // rust: let age = m.age as f32;
    // rust: let still = m.fluids.in_water && m.limb_speed <= 1.0e-5;
    // rust: m.anim.states[SWIM_IDLE].animate_when(still, age);
}
// `Frog.travelInWater`: `moveRelative(getSpeed(), input)`, the move, then
// the motion scaled by 0.9. `getSpeed` is the speed the move control stored.
// Out of water the usual travel runs.
travel :: proc(m: ^Mob, w: ^MobWorld, input: Vec3, events: ^[dynamic]MobEvent) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !m.fluids.in_water {
    // rust: return false;
}
    // rust: m.move_relative(m.ai.speed, input);
    // rust: m.do_move(w, events);
    // rust: m.velocity = m.velocity.scale(0.9);
    // rust: true
}

// `Frog.canEat`: a slime or magma cube of size 1.
// `Frog.updateWalkAnimation`: the frog's short steps walk the legs 25 times
// the distance (the base is 4), and not at all while the jump plays.
walk_target :: proc(m: ^Mob, distance: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if m.anim.states[JUMP].started.is_some() {
    // rust: 0.0
    // rust: } else {
    // rust: (distance * 25.0).min(1.0)
}
}

can_eat :: proc(species: Species, size: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(species, Species::Slime | Species::MagmaCube) && size == 1
}

// `FrogAttackablesSensor` (every 20 ticks) and the memory timers.
server_ai_step :: proc(m: ^Mob, w: ^MobWorld) {
}
    // rust: count_down_cooldown(m);
    // rust: let f = &mut m.extra.frog;
    // rust: f.unreachable.retain_mut(|(_, ttl)| {
    // rust: *ttl -= 1;
    // rust: *ttl > 0
    // rust: });
    // rust: f.scan -= 1;
    // rust: if f.scan > 0 {
    // rust: return;
}
    // rust: f.scan = SCAN_RATE;
    // rust: let unreachable: Vec<u32> = f.unreachable.iter().map(|u| u.0).collect();
    // rust: let eye = Vec3::new(m.position.x, m.eye_y(), m.position.z);
    // rust: let nearest = w
    // rust: .nearby(m.position, DETECTION_DISTANCE, |s| {
    // rust: can_eat(s.species, s.size)
    // rust: && !unreachable.contains(&s.id)
    // rust: && w.line_of_sight(eye, Vec3::new(s.position.x, s.eye_y, s.position.z))
    // rust: })
    // rust: .find(|s| s.position.distance_squared(m.position) < DETECTION_DISTANCE * DETECTION_DISTANCE)
    // rust: .map(|s| s.id);
    // rust: m.extra.frog.nearest = nearest;
}

// `Croak`: the pose sync::CROAKING for 60 ticks (the croak is the frog's ambient
// sound).
Croak :: struct {
    // rust: impl Goal for Croak {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE
}
can_use :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
        // checkExtraStartConditions (standing), no walk target, and not in
        // a liquid (start does nothing there).
    // rust: m.extra.pose == sync::STANDING
    // rust: && m.on_ground
    // rust: && !m.fluids.in_water
    // rust: && !m.fluids.in_lava
    // rust: && m.ai.nav.is_done()
    // rust: && m.random.next_int_bound(4).unwrap_or(0) != 0
}
can_continue :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.frog.croak < CROAK_TICKS
}
start :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) {
}
    // rust: m.extra.frog.croak = 0;
    // rust: set_pose(m, sync::CROAKING);
}
stop :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) {
}
    // rust: set_pose(m, sync::STANDING);
}
tick :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) {
}
    // rust: m.extra.frog.croak += 1;
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
}

// `IS_PREGNANT`, set by `Frog.spawnChildFromBreeding` and erased once the
// frog has laid its frogspawn.
PREGNANT :: "is_pregnant"
// `LaySpawn`'s walk target is set.
laying_trip :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.frog.lay_target.is_some()
}
is_pregnant :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.memories.iter().any(|x| x.0 == PREGNANT)
}
set_pregnant :: proc(m: ^Mob, on: bool) {
}
    // rust: let at = m.extra.memories.iter().position(|x| x.0 == PREGNANT);
    // rust: match (at, on) {
    // rust: (None, true) => m.extra.memories.push((PREGNANT, 1, i64::MAX)),
    // rust: (Some(i), false) => {
    // rust: m.extra.memories.remove(i);
}
    // rust: _ => {}
}
}

// A goal that waits while `blocked` holds: a pregnant frog is in the lay
// spawn activity, which has no `FollowTemptation`, and a frog with a walk
// target (`MoveToTargetSink`) does not run the stroll `RunOne`.
Unless :: struct {
    // rust: impl<G: Debug> Debug for Unless<G> {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: self.1.fmt(f)
}
}
    // rust: impl<G: Goal + Clone + 'static> Goal for Unless<G> {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.1.flags()
}
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.1.name()
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !(self.0)(m) && self.1.can_use(m, cx)
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !(self.0)(m) && self.1.can_continue(m, cx)
}
interruptable :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.1.interruptable()
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.1.every_tick()
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.1.start(m, cx)
}
stop :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.1.stop(m, cx)
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.1.tick(m, cx)
}
}

// `FrogAi.initLaySpawnActivity` for a pregnant frog: `TryFindLandNearLiquid(8, 1.0)`
// looks for land beside water and walks there, and `TryLaySpawnOnFluidNearLand`
// puts frogspawn on the water next to it. Both run every tick (the brain's
// walk target is `lay_target` here); the wandering `RunOne` is the goals below it.
LaySpawn :: struct {
    // `nextOkStartTime`: the search runs again once it has passed; every tick the
    // behaviour is tried before that pushes it 40 ticks on.
    next_ok: i64,
}
    // rust: impl LaySpawn {
is_air :: proc(w: ^MobWorld, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: w.facts.is_air(w.world.block(p[0], p[1], p[2]))
}
empty :: proc(w: ^MobWorld, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: w.collision_bounds(p).is_none()
}
    // `TryFindLandNearLiquid`'s `findFirst` test.
land_near_water :: proc(w: ^MobWorld, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !Self::empty(w, p) || Self::empty(w, [p[0], p[1] - 1, p[2]]) {
    // rust: return false;
}
    // rust: HORIZONTAL.iter().any(|d| {
    // rust: let n = [p[0] + d[0], p[1], p[2] + d[1]];
    // rust: Self::is_air(w, n) && w.fluid(n[0], n[1] - 1, n[2]) == Fluid::Water
    // rust: })
}
find :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let at = [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ];
    // rust: if cx.w.fluid(at[0], at[1], at[2]) == Fluid::Water {
    // rust: return;
}
    // rust: let now = cx.w.game_time;
    // rust: let search = now >= self.next_ok;
    // rust: self.next_ok = now + 40;
    // rust: if !search {
    // rust: return;
}
    // rust: let found = manhattan_box(at, 8)
    // rust: .into_iter()
    // rust: .find(|p| (p[0] != at[0] || p[2] != at[2]) && Self::land_near_water(cx.w, *p));
    // rust: if let Some(p) = found {
    // rust: let to = [
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]),
    // rust: f64::from(p[2]) + 0.5,
    // rust: ];
    // rust: m.look_at([to[0], to[1] + 0.5, to[2]]);
            // `MoveToTargetSink`: `createPath(target block, 0)`.
    // rust: let path = m.create_path_to(cx.w, p, 0);
    // rust: m.nav_move_to_path(cx.w, path, 1.0);
    // rust: m.extra.frog.lay_target = Some(p);
}
}
lay :: proc(m: ^Mob, cx: ^Cx) {
}
    // rust: if m.fluids.in_water || !m.on_ground {
    // rust: return;
}
    // rust: let below = [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32 - 1,
    // rust: m.position.z.floor() as i32,
    // rust: ];
    // rust: for d in HORIZONTAL {
    // rust: let rel = [below[0] + d[0], below[1], below[2] + d[1]];
            // `getFaceShape(UP).isEmpty()`: nothing reaches the top of the block.
    // rust: let open_top =
    // rust: cx.w.collision_bounds(rel)
    // rust: .is_none_or(|b| b.max_position().y < 1.0);
    // rust: let supports = cx.w.fluid(rel[0], rel[1], rel[2]) == Fluid::Water
    // rust: || cx.w.has_tag(
    // rust: "minecraft:supports_frogspawn",
    // rust: cx.w.block_name(rel[0], rel[1], rel[2]),
    // rust: );
    // rust: let spawn = [rel[0], rel[1] + 1, rel[2]];
    // rust: if open_top && supports && Self::is_air(cx.w, spawn) {
    // rust: if let Some(state) = cx.w.registry.default_state("minecraft:frogspawn") {
    // rust: cx.events.push(MobEvent::SetBlock { pos: spawn, state });
}
    // rust: cx.events.push(MobEvent::entity_sound(
    // rust: m,
    // rust: "entity.frog.lay_spawn",
    // rust: 6,
    // rust: 1.0,
    // rust: 1.0,
    // rust: ));
    // rust: set_pregnant(m, false);
    // rust: return;
}
}
}
}
    // rust: impl LaySpawn {
    // The brain's turn: `TryFindLandNearLiquid`, then `TryLaySpawnOnFluidNearLand`.
    // They run ahead of the wandering `RunOne`, so the selector runs them where it
    // asks first (`can_use` and `can_continue`), before the stroll can start.
step :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !is_pregnant(m) {
    // rust: return false;
}
        // `MoveToTargetSink` erases the walk target once the trip is over.
    // rust: if m.extra.frog.lay_target.is_some() && m.ai.nav.is_done() {
    // rust: m.extra.frog.lay_target = None;
}
    // rust: if m.extra.frog.lay_target.is_none() && m.ai.nav.is_done() {
    // rust: self.find(m, cx);
}
    // rust: if m.extra.frog.lay_target.is_some() {
    // rust: Self::lay(m, cx);
}
    // rust: is_pregnant(m)
}
}
    // rust: impl Goal for LaySpawn {
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
    // rust: self.step(m, cx)
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.step(m, cx)
}
stop :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) {
}
    // rust: m.extra.frog.lay_target = None;
}
}
// `Direction.Plane.HORIZONTAL` as x and z steps: north, east, south, west.
HORIZONTAL :: [[0, -1], [1, 0], [0, 1], [-1, 0]]
// `BlockPos.withinManhattan`: nearest first, then x, y, and +z before -z.
manhattan_box :: proc(o: [i32; 3], range: i32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: for depth in 0..=range * 3 {
    // rust: let max_x = range.min(depth);
    // rust: for x in -max_x..=max_x {
    // rust: let max_y = range.min(depth - x.abs());
    // rust: for y in -max_y..=max_y {
    // rust: let z = depth - x.abs() - y.abs();
    // rust: if z <= range {
    // rust: out.push([o[0] + x, o[1] + y, o[2] + z]);
    // rust: if z != 0 {
    // rust: out.push([o[0] + x, o[1] + y, o[2] - z]);
}
}
}
}
}
    // rust: out
}

// `ShootTongue` with the tongue activity's `StartAttacking` and
// `StopAttackingIfTargetInvalid`: walk up to a small slime or magma cube,
// shoot the tongue, pull it in and eat it.
ShootTongue :: struct {
    // rust: impl Goal for ShootTongue {
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
    // rust: let Some(id) = m.extra.frog.nearest else {
    // rust: return false;
}
        // The start conditions: no walk target, no panic, not croaking.
    // rust: if m.ai.panicking || m.extra.pose == sync::CROAKING || !m.ai.nav.is_done() {
    // rust: return false;
}
    // rust: let Some(t) = cx.w.seen(id).filter(|t| t.alive) else {
    // rust: m.extra.frog.nearest = None;
    // rust: return false;
}
        // canPathfindToTarget: a path that ends at the target.
    // rust: let at = [t.position.x, t.position.y, t.position.z];
    // rust: let ends = m
    // rust: .create_path_to_entity(cx.w, at, 0)
    // rust: .is_some_and(|p| f64::from(p.dist_to_target) < EATING_DISTANCE);
    // rust: if !ends {
            // The target is forgotten and not taken for 100 ticks.
    // rust: let f = &mut m.extra.frog;
    // rust: f.nearest = None;
    // rust: if !f.unreachable.iter().any(|u| u.0 == id) {
    // rust: if f.unreachable.len() == 5 {
    // rust: f.unreachable.remove(0);
}
    // rust: f.unreachable.push((id, 100));
}
    // rust: return false;
}
    // rust: m.extra.frog.target = Some(id);
    // rust: true
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let f = &m.extra.frog;
    // rust: f.phase != Phase::Done
    // rust: && f.time <= TONGUE_TIME_OUT
    // rust: && !m.ai.panicking
    // rust: && f.target
    // rust: .is_some_and(|id| cx.w.seen(id).is_some_and(|t| t.alive))
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let Some(t) = m.extra.frog.target.and_then(|id| cx.w.seen(id)) else {
    // rust: return;
}
    // rust: let at = [t.position.x, t.position.y, t.position.z];
    // rust: let eye = [t.position.x, t.eye_y, t.position.z];
    // rust: m.look_at(eye);
    // rust: m.extra.frog.tongue_target = m.extra.frog.target;
    // rust: m.nav_move_to_entity(cx.w, at, 0, 2.0);
    // rust: let f = &mut m.extra.frog;
    // rust: f.path_counter = 10;
    // rust: f.time = 0;
    // rust: f.phase = Phase::MoveToTarget;
}
stop :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) {
}
    // rust: let f = &mut m.extra.frog;
    // rust: f.target = None;
    // rust: f.tongue_target = None;
    // rust: f.phase = Phase::Done;
    // rust: set_pose(m, sync::STANDING);
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let Some(id) = m.extra.frog.target else {
    // rust: return;
}
    // rust: let Some(t) = cx.w.seen(id) else {
    // rust: return;
}
    // rust: let (at, pos) = ([t.position.x, t.position.y, t.position.z], t.position);
    // rust: m.look_at([t.position.x, t.eye_y, t.position.z]);
    // rust: m.extra.frog.tongue_target = Some(id);
    // rust: m.extra.frog.time += 1;
    // rust: match m.extra.frog.phase {
    // rust: Phase::MoveToTarget => {
    // rust: if pos.distance_squared(m.position) < EATING_DISTANCE * EATING_DISTANCE {
    // rust: cx.events
    // rust: .push(MobEvent::entity_sound(m, "entity.frog.tongue", 6, 2.0, 1.0));
    // rust: set_pose(m, sync::USING_TONGUE);
                    // `target.setDeltaMovement(vectorTo(frog).normalize().scale(0.75))`: the
                    // target's own motion is replaced, and it is drawn in.
    // rust: let pull = m.position.subtract(pos).normalize().scale(0.75);
    // rust: cx.events.push(MobEvent::SetVelocity {
    // rust: target: Who::Mob(id),
    // rust: velocity: [pull.x, pull.y, pull.z],
    // rust: });
    // rust: let f = &mut m.extra.frog;
    // rust: f.eat_timer = 0;
    // rust: f.phase = Phase::CatchAnimation;
    // rust: } else if m.extra.frog.path_counter <= 0 {
    // rust: m.nav_move_to_entity(cx.w, at, 0, 2.0);
    // rust: m.extra.frog.path_counter = 10;
    // rust: } else {
    // rust: m.extra.frog.path_counter -= 1;
}
}
    // rust: Phase::CatchAnimation => {
    // rust: let f = &mut m.extra.frog;
    // rust: f.eat_timer += 1;
    // rust: if f.eat_timer > 6 {
    // rust: f.phase = Phase::EatAnimation;
                    // eatEntity.
    // rust: cx.events
    // rust: .push(MobEvent::entity_sound(m, "entity.frog.eat", 6, 2.0, 1.0));
    // rust: super::ai::do_hurt_target(m, Who::Mob(id), cx);
                    // `if (!target.isAlive()) target.remove(KILLED)`: no death animation.
    // rust: cx.events.push(MobEvent::RemoveKilled { target: id });
}
}
    // rust: Phase::EatAnimation => {
    // rust: let f = &mut m.extra.frog;
    // rust: if f.eat_timer >= 10 {
    // rust: f.phase = Phase::Done;
    // rust: } else {
    // rust: f.eat_timer += 1;
}
}
    // rust: Phase::Done => {}
}
}
}

// `CountDownCooldownTicks.tick` of `LONG_JUMP_COOLDOWN_TICKS`: one less each
// tick, erased the tick after it reaches 0 (the core activity of a frog and
// a goat).
    // rust: pub(super) fn count_down_cooldown(m: &mut Mob) {
    // rust: match jump_cooldown(m) {
    // rust: Some(t) if t > 0 => set_jump_cooldown(m, Some(t - 1)),
    // rust: Some(_) => set_jump_cooldown(m, None),
    // rust: None => {}
}
}
// `LONG_JUMP_COOLDOWN_TICKS`.
jump_cooldown :: proc(m: ^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: m.extra
    // rust: .memories
    // rust: .iter()
    // rust: .find(|x| x.0 == LONG_JUMP_COOLDOWN)
    // rust: .map(|x| x.1)
}
set_jump_cooldown :: proc(m: ^Mob, ticks: Maybe(i64)) {
}
    // rust: let memories = &mut m.extra.memories;
    // rust: let at = memories.iter().position(|x| x.0 == LONG_JUMP_COOLDOWN);
    // rust: match (at, ticks) {
    // rust: (Some(i), Some(t)) => memories[i].1 = t,
    // rust: (Some(i), None) => {
    // rust: memories.remove(i);
}
    // rust: (None, Some(t)) => memories.push((LONG_JUMP_COOLDOWN, t, i64::MAX)),
    // rust: (None, None) => {}
}
}
// `TIME_BETWEEN_LONG_JUMPS.sample` from the level's random, divided as the
// caller asks.
sample_cooldown :: proc(m: ^Mob, lr: ^LegacyRandom, div: i32) {
}
    // rust: let (lo, hi) = if m.species() == Species::Goat {
    // rust: GOAT_TIME_BETWEEN_LONG_JUMPS
    // rust: } else {
    // rust: TIME_BETWEEN_LONG_JUMPS
}
    // rust: let t = lr.next_int_between_inclusive(lo, hi).unwrap_or(lo) / div;
    // rust: set_jump_cooldown(m, Some(i64::from(t)));
}

// The jump sound each activity hands to `LongJumpToRandomPos`: the frog's, or
// the goat's, which has a screaming one.
jump_sound :: proc(m: ^Mob) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match (m.species(), m.extra.screaming) {
    // rust: (Species::Goat, true) => "entity.goat.screaming.long_jump",
    // rust: (Species::Goat, false) => "entity.goat.long_jump",
    // rust: _ => "entity.frog.long_jump",
}
}

// `LivingEntity.setDiscardFriction`: the flag lives in the frog's or the
// goat's state.
set_discard_friction :: proc(m: ^Mob, on: bool) {
}
    // rust: if m.species() == Species::Goat {
    // rust: m.extra.goat.discard_friction = on;
    // rust: } else {
    // rust: m.extra.frog.discard_friction = on;
}
}
// `Entity.setPose` to or from a long jump: a goat's box changes with it.
set_jump_pose :: proc(m: ^Mob, w: ^MobWorld, id: u8) {
}
    // rust: if m.species() == Species::Goat {
    // rust: super::goat::set_pose(m, w, id);
    // rust: } else {
    // rust: set_pose(m, id);
}
}

// `FrogAi.isAcceptableLandingSpot`: no fluid in the target, below or above
// it; a lily pad or big dripleaf (`frog_prefer_jump_to`) or a trapdoor; else
// `LongJumpToRandomPos.defaultAcceptableLandingSpot`: a solid block below
// and a path type the frog walks without a malus.
acceptable_landing :: proc(m: ^Mob, w: ^MobWorld, z]: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
//     use super::path::PathType;
    // rust: if (y - 1..=y + 1).any(|y| w.fluid(x, y, z) != crate::blocks::Fluid::None) {
    // rust: return false;
}
    // rust: let preferred = |y| w.has_tag("minecraft:frog_prefer_jump_to", w.block_name(x, y, z));
    // rust: if preferred(y) || preferred(y - 1) {
    // rust: return true;
}
    // rust: let here = w.path_type_static(x, y, z);
    // rust: if here == PathType::Trapdoor
    // rust: || w.facts.is_air(w.world.block(x, y, z))
    // rust: && w.path_type_static(x, y - 1, z) == PathType::Trapdoor
    // rust: {
    // rust: return true;
}
    // rust: default_acceptable_landing(m, w, [x, y, z])
}
// `LongJumpToRandomPos.defaultAcceptableLandingSpot`: a solid block below and
// a path type the mob walks without a malus.
default_acceptable_landing :: proc(m: ^Mob, w: ^MobWorld, z]: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: w.facts.get(w.world.block(x, y - 1, z)).solid_render
    // rust: && m.malus(w.path_type_static(x, y, z)) == 0.0
}

// `LongJumpToRandomPos.PossibleJump`: a block and its weight.
    // rust: type Candidate = ([i32; 3], i32);

// `FrogAi`'s long jump activity: `LongJumpToPreferredBlock` looks for a spot
// it cannot walk to, faces it for 40 ticks and leaps; `LongJumpMidJump`
// holds the pose until it lands. One goal here, like the brain activity
// that keeps the idle croak and stroll from starting meanwhile.
    // rust: pub(super) struct LongJump {
    // rust: candidates: Vec<Candidate>,
    // rust: not_preferred: Vec<Candidate>,
    // rust: wanting_preferred: bool,
    // rust: initial: Option<Vec3>,
    // rust: chosen: Option<Vec3>,
    // The chosen spot, looked at while preparing.
    // rust: look: [f64; 3],
    // rust: tries: i32,
    // Ticks since the jump was chosen.
    // rust: prepare: i32,
    // `LONG_JUMP_MID_JUMP`, and the ticks `LongJumpMidJump` has run.
    // rust: mid_jump: bool,
    // rust: in_air: Option<i32>,
}
    // rust: impl LongJump {
    // `WeightedRandom.getRandomItem` with the level's random over the
    // candidates, removed once drawn.
draw :: proc(self: ^Self, lr: ^LegacyRandom) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let total: i32 = self.candidates.iter().map(|c| c.1).sum();
    // rust: if total == 0 {
    // rust: return None;
}
    // rust: let mut pick = lr.next_int_bound(total).unwrap_or(0);
    // rust: let i = self.candidates.iter().position(|c| {
    // rust: pick -= c.1;
    // rust: pick < 0
    // rust: })?;
    // rust: Some(self.candidates.remove(i))
}
    // `LongJumpToPreferredBlock.getJumpCandidate`: while it wants them, the
    // first drawn spot over a preferred block, else the first one passed over.
candidate :: proc(self: ^Self, w: ^MobWorld, lr: ^LegacyRandom) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !self.wanting_preferred {
    // rust: return self.draw(lr);
}
    // rust: while !self.candidates.is_empty() {
    // rust: if let Some(c) = self.draw(lr) {
    // rust: let [x, y, z] = c.0;
    // rust: if w.has_tag("minecraft:frog_prefer_jump_to", w.block_name(x, y - 1, z)) {
    // rust: return Some(c);
}
    // rust: self.not_preferred.push(c);
}
}
    // rust: (!self.not_preferred.is_empty()).then(|| self.not_preferred.remove(0))
}
    // `LongJumpToRandomPos.pickCandidate`: the first acceptable spot it can
    // reach in an arc but not by an 8 block path.
pick :: proc(self: ^Self, m: ^Mob, w: ^MobWorld, lr: ^LegacyRandom) {
}
    // rust: while !self.candidates.is_empty() {
    // rust: let Some((target, _)) = self.candidate(w, lr) else {
    // rust: continue;
}
    // rust: let here = [m.position.x.floor() as i32, m.position.z.floor() as i32];
            // GoatAi's landing spot is LongJumpToRandomPos's default; the
            // frog's is FrogAi.isAcceptableLandingSpot.
    // rust: let acceptable = if m.species() == Species::Goat {
    // rust: default_acceptable_landing(m, w, target)
    // rust: } else {
    // rust: acceptable_landing(m, w, target)
}
    // rust: if here == [target[0], target[2]] || !acceptable {
    // rust: continue;
}
    // rust: let centre = Vec3::new(
    // rust: f64::from(target[0]) + 0.5,
    // rust: f64::from(target[1]) + 0.5,
    // rust: f64::from(target[2]) + 0.5,
    // rust: );
    // rust: let Some(v) = optimal_jump_vector(m, w, centre) else {
    // rust: continue;
}
    // rust: self.look = [centre.x, centre.y, centre.z];
    // rust: let walkable = m
    // rust: .create_path_raw(w, &[target], 0, 8.0)
    // rust: .is_some_and(|p| p.reached);
    // rust: if !walkable {
    // rust: self.chosen = Some(v);
    // rust: self.prepare = 0;
    // rust: return;
}
}
}
    // `LongJumpMidJump.stop` (a goat lands with `entity.goat.step`, a frog
    // with `entity.frog.step`), or the end of a search.
end :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if self.mid_jump {
    // rust: if m.on_ground {
                // multiply(0.1F, 1.0, 0.1F): the float widened.
    // rust: let slow = f64::from(0.1_f32);
    // rust: m.velocity = m.velocity.multiply(Vec3::new(slow, 1.0, slow));
    // rust: let landing = if m.species() == Species::Goat {
    // rust: "entity.goat.step"
    // rust: } else {
    // rust: "entity.frog.step"
}
    // rust: cx.events
    // rust: .push(MobEvent::entity_sound(m, landing, 6, 2.0, 1.0));
}
    // rust: set_jump_pose(m, cx.w, sync::STANDING);
    // rust: sample_cooldown(m, cx.lr, 1);
}
    // rust: set_discard_friction(m, false);
    // rust: *self = Self::default();
}
}
// `LongJumpToRandomPos.start`'s candidates: every block of the box but the
// mob's own, weighted by the squared distance, in `betweenClosed` order.
candidates :: proc(z]: [i32; 3], width: i32, height: i32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: for dz in -width..=width {
    // rust: for dy in -height..=height {
    // rust: for dx in -width..=width {
    // rust: if (dx, dy, dz) != (0, 0, 0) {
    // rust: out.push(([x + dx, y + dy, z + dz], dx * dx + dy * dy + dz * dz));
}
}
}
}
    // rust: out
}
// `LongJumpToRandomPos.calculateOptimalJumpVector`: the angles shuffled, the
// first arc that reaches the target clear of blocks. `Collections.shuffle`
// without a random draws from an unseeded one, not the mob's or the level's.
optimal_jump_vector :: proc(m: ^Mob, w: ^MobWorld, target: Vec3) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut random = crate::sound_engine::SoundEngine::unseeded();
    // rust: let mut angles = ALLOWED_ANGLES;
    // rust: for i in (2..=angles.len()).rev() {
    // rust: let j = random.next_int_bound(i as i32).unwrap_or(0) as usize;
    // rust: angles.swap(i - 1, j);
}
    // rust: let max = (m.attrs.jump_strength * f64::from(JUMP_VELOCITY_MULTIPLIER)) as f32;
    // rust: angles
    // rust: .iter()
    // rust: .find_map(|&a| super::breeze::jump_vector(m, target, max, a, Some(w)))
}
    // rust: impl Goal for LongJump {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE | LOOK
}
interruptable :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.mid_jump
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
        // The activity: no cooldown, and for a frog out of water (a frog in
        // water is in its swim activity; a goat has none, so its check below
        // sets the cooldown instead). FrogAi.initJumpActivity also wants
        // TEMPTING_PLAYER and BREED_TARGET absent, and the LAY_SPAWN activity
        // (IS_PREGNANT) goes before LONG_JUMP. The tempting player and the
        // breed target are not gated: Tempt and Breed hold MOVE at a better priority.
    // rust: if jump_cooldown(m).is_some()
    // rust: || m.species() == Species::Frog && is_pregnant(m)
    // rust: || m.species() != Species::Goat && m.fluids.in_water
    // rust: {
    // rust: return false;
}
        // GoatAi.initLongJumpActivity's other memories, and the activity
        // order of GoatAi.updateActivity.
    // rust: if m.species() == Species::Goat && !super::goat::long_jump_activity(m, cx.w) {
    // rust: return false;
}
        // checkExtraStartConditions: on the ground, not in water or lava or
        // on honey.
    // rust: let (x, y, z) = (
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: );
    // rust: let can = m.on_ground
    // rust: && !m.fluids.in_water
    // rust: && !m.fluids.in_lava
    // rust: && cx.w.block_name(x, y, z) != "minecraft:honey_block";
    // rust: if !can {
    // rust: sample_cooldown(m, cx.lr, 2);
}
    // rust: can
}
start :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) {
}
        // LongJumpToRandomPos.start.
    // rust: let (x, y, z) = (
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: );
    // rust: let (width, height) = if m.species() == Species::Goat {
    // rust: (GOAT_JUMP_WIDTH, GOAT_JUMP_HEIGHT)
    // rust: } else {
    // rust: (JUMP_WIDTH, JUMP_HEIGHT)
}
    // rust: *self = Self {
    // rust: candidates: candidates([x, y, z], width, height),
    // rust: tries: FIND_JUMP_TRIES,
    // rust: initial: Some(m.position),
    // rust: ..Self::default()
}
        // LongJumpToPreferredBlock.start: the frog's; a goat's activity is a
        // plain LongJumpToRandomPos, which draws nothing from the mob's random.
    // rust: if m.species() != Species::Goat {
    // rust: self.wanting_preferred = m.random.next_float() < PREFERRED_BLOCKS_CHANCE;
}
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.mid_jump {
            // LongJumpMidJump starts the tick after the leap and runs until
            // the mob is on the ground again, for 100 ticks at most; water
            // switches a frog's brain to the swim activity, which stops it
            // too (a goat has none).
    // rust: match self.in_air {
    // rust: None => {
    // rust: self.in_air = Some(0);
    // rust: set_discard_friction(m, true);
    // rust: set_jump_pose(m, cx.w, sync::LONG_JUMPING);
}
    // rust: Some(t) => self.in_air = Some(t + 1),
}
    // rust: return !m.on_ground
    // rust: && (m.species() == Species::Goat || !m.fluids.in_water)
    // rust: && self.in_air.is_some_and(|t| t <= MID_JUMP_DURATION);
}
    // rust: let valid = self.initial == Some(m.position)
    // rust: && self.tries > 0
    // rust: && !m.fluids.in_water
    // rust: && !(self.chosen.is_none() && self.candidates.is_empty());
    // rust: if !valid {
    // rust: sample_cooldown(m, cx.lr, 2);
}
    // rust: valid
}
stop :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.end(m, cx);
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if self.mid_jump {
    // rust: return;
}
    // rust: let Some(jump) = self.chosen else {
    // rust: self.tries -= 1;
    // rust: self.pick(m, cx.w, cx.lr);
    // rust: return;
}
    // rust: m.look_at(self.look);
    // rust: self.prepare += 1;
    // rust: if self.prepare < PREPARE_JUMP_DURATION {
    // rust: return;
}
        // The leap: the body's facing, no friction, the arc's velocity
        // lengthened by jump boost.
    // rust: m.yaw = m.body_yaw;
    // rust: set_discard_friction(m, true);
    // rust: let len = jump.length();
    // rust: let boost = m
    // rust: .extra
    // rust: .effects
    // rust: .iter()
    // rust: .find(|e| e.0 == "minecraft:jump_boost")
    // rust: .map_or(0.0, |e| f64::from(0.1_f32 * (e.2 + 1) as f32));
    // rust: m.velocity = jump.scale((len + boost) / len);
    // rust: self.mid_jump = true;
    // rust: cx.events
    // rust: .push(MobEvent::entity_sound(m, jump_sound(m), 6, 1.0, 1.0));
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_core::random::LegacyRandom;

frog :: proc() -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let k = std::sync::Arc::make_mut(&mut kind);
    // rust: k.id = "minecraft:frog".into();
    // rust: k.species = Species::Frog;
    // rust: Mob::new(1, kind, Vec3::new(0.5, 0.0, 0.5), 0.0)
}

    // `Frog.travelInWater`: the move uses `getSpeed` (the speed the move
    // control stored, here 0.25, not the movement attribute 1.0 and not the
    // turtle's 0.1), then the whole motion is scaled by 0.9. Out of water
    // this path does not run.
water_travel_uses_get_speed_and_scales_by_nine_tenths :: proc() {
}
    // rust: let ran = crate::mobs::world::with_test_world(&[], |w, _| {
    // rust: let mut m = frog();
    // rust: m.attrs.speed = 1.0;
    // rust: m.ai.speed = 0.25;
    // rust: m.yaw = 0.0;
    // rust: m.velocity = Vec3::new(1.0, -0.5, 0.125);
    // rust: let kept = m.velocity;
    // rust: assert!(!travel(
    // rust: &mut m,
    // rust: w,
    // rust: Vec3::new(0.0, 0.0, 1.0),
    // rust: &mut Vec::new()
    // rust: ));
    // rust: assert_eq!(m.velocity, kept);

    // rust: m.fluids.in_water = true;
    // rust: m.position = Vec3::new(0.5, 80.0, 0.5);
    // rust: m.travel(w, Vec3::new(0.0, 0.0, 1.0), &mut Vec::new());
            // (1, -0.5, 0.125) + (0, 0, getSpeed 0.25) = (1, -0.5, 0.375),
            // then * 0.9 = (0.9, -0.45, 0.3375).
    // rust: assert!((m.velocity.x - 0.9).abs() < 1.0e-9, "{}", m.velocity.x);
    // rust: assert!((m.velocity.y - -0.45).abs() < 1.0e-9, "{}", m.velocity.y);
    // rust: assert!((m.velocity.z - 0.3375).abs() < 1.0e-9, "{}", m.velocity.z);
    // rust: });
        // Without a test world the closure does not run; there is nothing else to check.
    // rust: let _ = ran;
}

    // `Frog.updateWalkAnimation`: target `min(distance * 25, 1)`, 0 while
    // the jump animation is started, eased by 0.4 (`WalkAnimationState.update`).
a_frog_walks_its_legs_at_the_vanilla_rate :: proc() {
}
    // rust: let mut m = frog();
    // rust: m.previous = m.position;
    // rust: m.position.x += 0.02;
    // rust: m.update_walk_animation();
    // rust: assert!((m.limb_speed - 0.5 * 0.4).abs() < 1e-6, "{}", m.limb_speed);
    // rust: assert!((m.limb_position - m.limb_speed).abs() < 1e-6);

    // rust: let mut m = frog();
    // rust: m.previous = m.position;
    // rust: m.position.x += 0.1;
    // rust: m.update_walk_animation();
    // rust: assert!((m.limb_speed - 0.4).abs() < 1e-6, "{}", m.limb_speed);

    // rust: let mut m = frog();
    // rust: m.anim.states[JUMP].start(0.0);
    // rust: m.previous = m.position;
    // rust: m.position.x += 0.02;
    // rust: m.update_walk_animation();
    // rust: assert_eq!(m.limb_speed, 0.0);
}

    // `LongJumpToRandomPos.start`: the 9 x 5 x 9 box without the frog's own
    // block, x fastest, then y, then z, each weighted by its squared distance.
the_candidates_cover_the_jump_box_in_vanilla_order :: proc() {
}
    // rust: let c = candidates([10, 64, -3], JUMP_WIDTH, JUMP_HEIGHT);
    // rust: assert_eq!(c.len(), 9 * 5 * 9 - 1);
    // rust: assert_eq!(c[0], ([6, 62, -7], 16 + 4 + 16));
    // rust: assert_eq!(c[1], ([7, 62, -7], 9 + 4 + 16));
    // rust: assert_eq!(c[9], ([6, 63, -7], 16 + 1 + 16));
    // rust: assert_eq!(c[45], ([6, 62, -6], 16 + 4 + 9));
    // rust: assert!(!c.iter().any(|(p, _)| *p == [10, 64, -3]));
    // rust: assert_eq!(c.last().unwrap().0, [14, 66, 1]);
}

    // `WeightedRandom.getRandomItem`: `nextInt(total)` walked down the
    // list, and the drawn candidate is removed.
a_draw_takes_the_weighted_candidate_out :: proc() {
}
    // rust: let mut j = LongJump {
    // rust: candidates: vec![([0, 0, 0], 1), ([1, 0, 0], 4), ([2, 0, 0], 9)],
    // rust: ..LongJump::default()
}
    // rust: let mut r = LegacyRandom::new(7);
    // rust: let mut lr = r.clone();
    // rust: let pick = r.next_int_bound(14).unwrap();
    // rust: let want = if pick < 1 {
    // rust: 0
    // rust: } else if pick < 5 {
    // rust: 1
    // rust: } else {
    // rust: 2
}
    // rust: assert_eq!(j.draw(&mut lr).unwrap().0, [want, 0, 0]);
    // rust: assert_eq!(j.candidates.len(), 2);
    // rust: assert!(!j.candidates.iter().any(|c| c.0 == [want, 0, 0]));
}

    // `CountDownCooldownTicks`: the memory falls by one a tick and is gone
    // the tick after it reached 0; the sample is 100..=140, halved after a
    // failed search, drawn from the level's random and not the frog's.
pregnancy_is_a_memory_that_the_laying_erases :: proc() {
}
    // rust: let mut m = frog();
    // rust: assert!(!is_pregnant(&m));
    // rust: set_pregnant(&mut m, true);
    // rust: set_pregnant(&mut m, true);
    // rust: assert!(is_pregnant(&m));
    // rust: assert_eq!(
    // rust: m.extra.memories.iter().filter(|x| x.0 == PREGNANT).count(),
    // rust: 1
    // rust: );
    // rust: set_pregnant(&mut m, false);
    // rust: assert!(!is_pregnant(&m));
}

the_land_search_goes_out_by_manhattan_distance :: proc() {
}
    // rust: let all = manhattan_box([0, 0, 0], 8);
    // rust: assert_eq!(all[0], [0, 0, 0]);
    // rust: assert_eq!(all.len(), 17 * 17 * 17);
        // x, then y, and +z before -z, at distance 1.
    // rust: assert_eq!(
    // rust: all[1..7],
    // rust: [
    // rust: [-1, 0, 0],
    // rust: [0, -1, 0],
    // rust: [0, 0, 1],
    // rust: [0, 0, -1],
    // rust: [0, 1, 0],
    // rust: [1, 0, 0]
    // rust: ]
    // rust: );
}

the_long_jump_cooldown_counts_down_and_is_erased :: proc() {
}
    // rust: let mut m = frog();
    // rust: let own = m.random.state();
    // rust: sample_cooldown(&mut m, &mut LegacyRandom::new(3), 2);
    // rust: let t = jump_cooldown(&m).unwrap();
    // rust: assert!((50..=70).contains(&t));
    // rust: assert_eq!(m.random.state(), own);
    // rust: set_jump_cooldown(&mut m, Some(1));
    // rust: set_jump_cooldown(&mut m, Some(0));
    // rust: assert_eq!(jump_cooldown(&m), Some(0));
    // rust: set_jump_cooldown(&mut m, None);
    // rust: assert_eq!(jump_cooldown(&m), None);
    // rust: assert!(!m.extra.memories.iter().any(|x| x.0 == LONG_JUMP_COOLDOWN));
}
}
