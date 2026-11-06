//! Transpiled from Horizon Rust crate
package horizon_client_turtle

import "core:fmt"
import "core:mem"
import "core:math"

// Turtles (`Turtle`): the egg a bred mother carries (`TurtleBreedGoal`), her
// walk home (`TurtleGoHomeGoal`) and the egg she digs into the sand
// (`TurtleLayEggGoal`). `extra.flag` is `hasEgg`, `extra.flag2` `isLayingEgg`,
// `extra.counter` `layEggCounter`, `extra.home` `homePos`, `extra.counter2`
// `goingHome` and `extra.point` `travelPos`. Its own `TurtleMoveControl`
// sets the speed it walks and swims at, and `travel` swims with its own
// `travelInWater`.
// use super::{
    // rust: Mob, MobEvent, MobWorld,
    // rust: control::{EPSILON, Operation, rotlerp},
    // rust: goals::{
    // rust: Breed, Cx, Goal, JUMP, LookAtPlayer, MOVE, MoveToBlock, Panic, Stroll, Tempt, goal_clone,
    // rust: reduced,
    // rust: },
    // rust: nav::NavKind,
    // rust: path::PathType,
}
// use crate::blocks::Fluid;
// use horizon_core::{
    // rust: geometry::{Vec3, trig},
    // rust: random::RandomSource,
}

// `Turtle.registerGoals`, and the path maluses and navigation `Turtle` and
// `TurtlePathNavigation` give it.
register :: proc(m: ^Mob) {
}
    // rust: m.set_malus(PathType::Water, 0.0);
    // rust: for t in [
    // rust: PathType::DoorIronClosed,
    // rust: PathType::DoorWoodClosed,
    // rust: PathType::DoorOpen,
    // rust: ] {
    // rust: m.set_malus(t, -1.0);
}
    // rust: m.ai.nav.kind = NavKind::Amphibious {
    // rust: prefers_shallow: false,
}
    // rust: let food = m.kind.food.clone();
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(0, Panic::new(1.2).looking_for_water(7));
    // rust: g.add(1, Breed::new(1.0));
    // rust: g.add(1, LayEgg(MoveToBlock::new(1.0, 16, 1)));
    // rust: g.add(2, Tempt::new(1.1, food, false));
    // rust: g.add(
    // rust: 3,
    // rust: GoToWater(MoveToBlock {
    // rust: vertical_start: -1,
    // rust: ..MoveToBlock::new(1.0, 24, 1)
    // rust: }),
    // rust: );
    // rust: g.add(4, GoHome::default());
    // rust: g.add(7, Travel::default());
    // rust: g.add(8, LookAtPlayer::new(8.0));
    // rust: g.add(9, RandomStroll(Stroll::new(1.0).interval(100)));
}
// `Turtle.goingHome`.
going_home :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.counter2 != 0
}
set_going_home :: proc(m: ^Mob, on: bool) {
}
    // rust: m.extra.counter2 = i32::from(on);
}
// `Turtle.getWalkTargetValue`; `light` is `getPathfindingCostFromLightLevels`.
walk_target_value :: proc(m: ^Mob, w: ^MobWorld, p: [i32; 3], light: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if !going_home(m) && w.fluid(p[0], p[1], p[2]) == Fluid::Water
    // rust: || is_sand(w, [p[0], p[1] - 1, p[2]])
    // rust: {
    // rust: 10.0
    // rust: } else {
    // rust: light
}
}
// `TurtlePathNavigation.isStableDestination` while travelling: water only.
// `None` without a `travelPos`, the amphibious rule then.
stable_destination :: proc(m: ^Mob, w: ^MobWorld, p: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: m.extra
    // rust: .point
    // rust: .map(|_| w.block_name(p[0], p[1], p[2]) == "minecraft:water")
}
// `Turtle.hasEgg`.
has_egg :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.flag
}
// `Turtle.setLayingEgg`.
set_laying_egg :: proc(m: ^Mob, on: bool) {
}
    // rust: m.extra.counter = i32::from(on);
    // rust: m.extra.flag2 = on;
}
// `homePos.closerToCenterThan(position, distance)`. Spawning, hatching and
// loading all set a home; one made any other way is at home where it stands.
close_to_home :: proc(m: ^Mob, distance: f64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let home = m.extra.home.unwrap_or([
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ]);
    // rust: let d = [
    // rust: f64::from(home[0]) + 0.5 - m.position.x,
    // rust: f64::from(home[1]) + 0.5 - m.position.y,
    // rust: f64::from(home[2]) + 0.5 - m.position.z,
    // rust: ];
    // rust: d[0] * d[0] + d[1] * d[1] + d[2] * d[2] < distance * distance
}
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
// `TurtleEggBlock.isSand`.
is_sand :: proc(w: ^MobWorld, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: w.has_tag("minecraft:sand", w.block_name(p[0], p[1], p[2]))
}
// `Turtle.TurtleMoveControl.updateSpeed`: slow in water away from home
// (slower still as a baby), and halved every tick on land, never under 0.06.
update_speed :: proc(m: ^Mob) {
}
    // rust: if m.fluids.in_water {
    // rust: m.velocity.y += 0.005;
    // rust: if !close_to_home(m, 16.0) {
    // rust: m.set_speed((m.ai.speed / 2.0).max(0.08));
}
    // rust: if m.is_baby() {
    // rust: m.set_speed((m.ai.speed / 3.0).max(0.06));
}
    // rust: } else if m.on_ground {
    // rust: m.set_speed((m.ai.speed / 2.0).max(0.06));
}
}
// `Turtle.TurtleMoveControl.tick`: ease the speed an eighth of the way to
// the wanted one each tick (after `updateSpeed` cut it), face the wanted
// point and lift towards it; no jumping, and the operation is never reset.
move_control :: proc(m: ^Mob) {
}
    // rust: update_speed(m);
    // rust: if m.ai.mov.operation != Operation::MoveTo || m.ai.nav.is_done() {
    // rust: m.set_speed(0.0);
    // rust: return;
}
    // rust: let [wx, wy, wz] = m.ai.mov.wanted;
    // rust: let (xd, yd, zd) = (wx - m.position.x, wy - m.position.y, wz - m.position.z);
    // rust: let dist = (xd * xd + yd * yd + zd * zd).sqrt();
    // rust: if dist < EPSILON {
    // rust: m.set_speed(0.0);
    // rust: return;
}
    // rust: let y_rot = trig::atan2_degrees(zd, xd) - 90.0;
    // rust: m.yaw = rotlerp(m.yaw, y_rot, 90.0);
    // rust: m.body_yaw = m.yaw;
    // rust: let wanted = (m.ai.mov.speed_modifier * m.movement_speed()) as f32;
    // Mth.lerp(0.125F, getSpeed(), wanted).
    // rust: m.set_speed(m.ai.speed + 0.125 * (wanted - m.ai.speed));
    // rust: m.velocity.y += f64::from(m.ai.speed) * (yd / dist) * 0.1;
}
// `Turtle.travelInWater`: swims at 0.1 move speed with 0.9 drag, and sinks
// slowly unless it has a target or is going home and near its home. On
// land the usual travel.
travel :: proc(m: ^Mob, w: ^MobWorld, input: Vec3, events: ^[dynamic]MobEvent) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !m.fluids.in_water {
    // rust: return false;
}
    // rust: m.move_relative(0.1, input);
    // rust: m.do_move(w, events);
    // rust: m.velocity = m.velocity.scale(0.9);
    // rust: if m.ai.target.is_none() && (!going_home(m) || !close_to_home(m, 20.0)) {
    // rust: m.velocity.y -= 0.005;
}
    // rust: true
}
// `Turtle.aiStep`: while digging, sand crumbs fly every fifth tick.
ai_step :: proc(m: ^Mob, w: ^MobWorld, events: ^[dynamic]MobEvent) {
}
    // rust: if m.alive() && m.extra.flag2 && m.extra.counter >= 1 && m.extra.counter % 5 == 0 {
    // rust: let at = block_of(m);
    // rust: let below = [at[0], at[1] - 1, at[2]];
    // rust: if is_sand(w, below) {
    // rust: events.push(MobEvent::BlockBreakEffect {
    // rust: pos: at,
    // rust: block: below,
    // rust: });
            // Turtle.aiStep: `gameEvent(GameEvent.ENTITY_ACTION)` after the level event.
    // rust: events.push(MobEvent::GameEvent {
    // rust: event: "minecraft:entity_action",
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: source: m.id,
    // rust: state: horizon_world::registry::BlockStateId(0),
    // rust: });
}
}
}

// `Turtle.TurtleLayEggGoal`: a mother with an egg within 9 blocks of home
// walks to sand with air above, digs for 200 ticks and lays it.
LayEgg :: struct {
    // rust: impl LayEgg {
    // `isValidTarget`: sand with air above it.
valid :: proc(w: ^MobWorld, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: w.facts.is_air(w.world.block(p[0], p[1] + 1, p[2])) && is_sand(w, p)
}
}
    // rust: impl Goal for LayEgg {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE | JUMP
}
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "TurtleLayEggGoal"
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
    // rust: if !(has_egg(m) && close_to_home(m, 9.0)) {
    // rust: return false;
}
        // MoveToBlockGoal.canUse.
    // rust: if self.0.next_start > 0 {
    // rust: self.0.next_start -= 1;
    // rust: return false;
}
    // rust: self.0.next_start = reduced(200 + m.random.next_int_bound(200).unwrap_or(0));
    // rust: self.0.find_nearest(m, cx.w, Self::valid)
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.can_continue(cx.w, Self::valid) && has_egg(m) && close_to_home(m, 9.0)
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.start(m, cx.w);
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.tick(m, cx.w);
    // rust: if m.fluids.in_water || !self.0.reached {
    // rust: return;
}
    // rust: if m.extra.counter < 1 {
    // rust: set_laying_egg(m, true);
    // rust: } else if m.extra.counter > 200 {
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: let pitch = 0.9 + m.random.next_float() * 0.2;
    // rust: cx.events
    // rust: .push(MobEvent::Sound("entity.turtle.lay_egg", at, 0.3, pitch));
            // Blocks.TURTLE_EGG with EGGS = nextInt(4) + 1 above the sand.
    // rust: let eggs = m.random.next_int_bound(4).unwrap_or(0) + 1;
    // rust: let registry = cx.w.registry;
    // rust: let state = registry
    // rust: .default_state("minecraft:turtle_egg")
    // rust: .and_then(|d| registry.state(d).cloned())
    // rust: .and_then(|mut s| {
    // rust: s.properties.insert("eggs".into(), eggs.to_string());
    // rust: registry.resolve(&s).ok()
    // rust: });
    // rust: let b = self.0.block;
    // rust: if let Some(state) = state {
    // rust: cx.events.push(MobEvent::SetBlock {
    // rust: pos: [b[0], b[1] + 1, b[2]],
    // rust: state,
    // rust: });
}
    // rust: m.extra.flag = false;
    // rust: set_laying_egg(m, false);
    // rust: m.extra.in_love = 600;
}
    // rust: if m.extra.flag2 {
    // rust: m.extra.counter += 1;
}
}
}

// `Turtle.TurtleGoHomeGoal`: a mother with an egg heads home; any adult
// that strayed 64 blocks away does now and then.
GoHome :: struct {
    stuck: bool,
    close_to_home_try_ticks: i32,
}
    // rust: impl Goal for GoHome {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: 0
}
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "TurtleGoHomeGoal"
}
can_use :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if m.is_baby() {
    // rust: false
    // rust: } else if has_egg(m) {
    // rust: true
    // rust: } else {
    // rust: m.random.next_int_bound(reduced(700)).unwrap_or(1) == 0 && !close_to_home(m, 64.0)
}
}
start :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) {
}
    // rust: set_going_home(m, true);
    // rust: self.stuck = false;
    // rust: self.close_to_home_try_ticks = 0;
}
stop :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) {
}
    // rust: set_going_home(m, false);
}
can_continue :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !close_to_home(m, 7.0) && !self.stuck && self.close_to_home_try_ticks <= reduced(600)
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let home = m.extra.home.unwrap_or(block_of(m));
    // rust: let close = close_to_home(m, 16.0);
    // rust: if close {
    // rust: self.close_to_home_try_ticks += 1;
}
    // rust: if !m.ai.nav.is_done() {
    // rust: return;
}
    // rust: let to = [
    // rust: f64::from(home[0]) + 0.5,
    // rust: f64::from(home[1]),
    // rust: f64::from(home[2]) + 0.5,
    // rust: ];
    // rust: let mut next = m
    // rust: .default_random_pos_towards(cx.w, 16, 3, to, std::f64::consts::PI / 10.0)
    // rust: .or_else(|| m.default_random_pos_towards(cx.w, 8, 7, to, std::f64::consts::FRAC_PI_2));
    // rust: if let Some(at) = next
    // rust: && !close
    // rust: && cx.w.block_name(
    // rust: at[0].floor() as i32,
    // rust: at[1].floor() as i32,
    // rust: at[2].floor() as i32,
    // rust: ) != "minecraft:water"
    // rust: {
    // rust: next = m.default_random_pos_towards(cx.w, 16, 5, to, std::f64::consts::FRAC_PI_2);
}
    // rust: match next {
    // rust: Some(at) => {
    // rust: m.nav_move_to(cx.w, at, 1.0);
}
    // rust: None => self.stuck = true,
}
}
}

// `Turtle.TurtleGoToWaterGoal`: a turtle on land walks to water within 24
// blocks, unless it is going home or carries an egg.
GoToWater :: struct {
    // rust: impl GoToWater {
valid :: proc(w: ^MobWorld, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: w.block_name(p[0], p[1], p[2]) == "minecraft:water"
}
}
    // rust: impl Goal for GoToWater {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE | JUMP
}
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "TurtleGoToWaterGoal"
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
    // rust: let wanted = if m.is_baby() && !m.fluids.in_water {
    // rust: true
    // rust: } else {
    // rust: !going_home(m) && !m.fluids.in_water && !has_egg(m)
}
    // rust: if !wanted {
    // rust: return false;
}
        // MoveToBlockGoal.canUse.
    // rust: if self.0.next_start > 0 {
    // rust: self.0.next_start -= 1;
    // rust: return false;
}
    // rust: self.0.next_start = reduced(200 + m.random.next_int_bound(200).unwrap_or(0));
    // rust: self.0.find_nearest(m, cx.w, Self::valid)
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !m.fluids.in_water && self.0.try_ticks <= 1200 && Self::valid(cx.w, self.0.block)
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.start(m, cx.w);
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
        // MoveToBlockGoal.tick, with shouldRecalculatePath every 160 ticks.
    // rust: let b = self.0.block;
    // rust: let d = [
    // rust: f64::from(b[0]) + 0.5 - m.position.x,
    // rust: f64::from(b[1] + 1) + 0.5 - m.position.y,
    // rust: f64::from(b[2]) + 0.5 - m.position.z,
    // rust: ];
    // rust: if d[0] * d[0] + d[1] * d[1] + d[2] * d[2] >= 1.0 {
    // rust: self.0.reached = false;
    // rust: self.0.try_ticks += 1;
    // rust: if self.0.try_ticks % 160 == 0 {
    // rust: let at = [
    // rust: f64::from(b[0]) + 0.5,
    // rust: f64::from(b[1] + 1),
    // rust: f64::from(b[2]) + 0.5,
    // rust: ];
    // rust: m.nav_move_to(cx.w, at, self.0.speed);
}
    // rust: } else {
    // rust: self.0.reached = true;
    // rust: self.0.try_ticks -= 1;
}
}
}

// `Turtle.TurtleTravelGoal`: a turtle in water swims towards a spot up to
// 512 blocks away, a leg at a time.
Travel :: struct {
    stuck: bool,
}
    // rust: impl Goal for Travel {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: 0
}
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "TurtleTravelGoal"
}
can_use :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !going_home(m) && !has_egg(m) && m.fluids.in_water
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let xt = m.random.next_int_bound(1025).unwrap_or(0) - 512;
    // rust: let mut yt = m.random.next_int_bound(9).unwrap_or(0) - 4;
    // rust: let zt = m.random.next_int_bound(1025).unwrap_or(0) - 512;
    // rust: if f64::from(yt) + m.position.y > f64::from(cx.w.sea_level - 1) {
    // rust: yt = 0;
}
    // rust: m.extra.point = Some([
    // rust: (f64::from(xt) + m.position.x).floor(),
    // rust: (f64::from(yt) + m.position.y).floor(),
    // rust: (f64::from(zt) + m.position.z).floor(),
    // rust: ]);
    // rust: self.stuck = false;
}
can_continue :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !m.ai.nav.is_done() && !self.stuck && !going_home(m) && m.extra.in_love <= 0 && !has_egg(m)
}
stop :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) {
}
    // rust: m.extra.point = None;
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let Some(travel) = m.extra.point else {
    // rust: self.stuck = true;
    // rust: return;
}
    // rust: if !m.ai.nav.is_done() {
    // rust: return;
}
        // Vec3.atBottomCenterOf(travelPos).
    // rust: let to = [travel[0] + 0.5, travel[1], travel[2] + 0.5];
    // rust: let tenth = f64::from((std::f64::consts::PI / 10.0) as f32);
    // rust: let half = f64::from(std::f32::consts::FRAC_PI_2);
    // rust: let mut next = m
    // rust: .default_random_pos_towards(cx.w, 16, 3, to, tenth)
    // rust: .or_else(|| m.default_random_pos_towards(cx.w, 8, 7, to, half));
    // rust: if let Some(n) = next {
    // rust: let (xc, zc) = (n[0].floor() as i32, n[2].floor() as i32);
            // Level.hasChunksAt(xc - 34, zc - 34, xc + 34, zc + 34).
    // rust: let loaded = ((xc - 34) >> 4..=(xc + 34) >> 4).all(|chunk_x| {
    // rust: ((zc - 34) >> 4..=(zc + 34) >> 4)
    // rust: .all(|chunk_z| cx.w.world.chunks.contains_key(&(chunk_x, chunk_z)))
    // rust: });
    // rust: if !loaded {
    // rust: next = None;
}
}
    // rust: match next {
    // rust: Some(at) => {
    // rust: m.nav_move_to(cx.w, at, 1.0);
}
    // rust: None => self.stuck = true,
}
}
}

// `Turtle.TurtleRandomStrollGoal`: no stroll in water, going home or with an
// egg.
RandomStroll :: struct {
    // rust: impl Goal for RandomStroll {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.0.flags()
}
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "TurtleRandomStrollGoal"
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !m.fluids.in_water && !going_home(m) && !has_egg(m) && self.0.can_use(m, cx)
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.can_continue(m, cx)
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.start(m, cx);
}
stop :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.stop(m, cx);
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::mobs::{
    // rust: Species,
    // rust: path::{Path, PathNode, PathType},
}
//     use horizon_core::geometry::Vec3;
//     use std::sync::Arc;

    // A turtle (movement speed 0.25) strolling (`speedModifier` 1.0) to a
    // point ten blocks ahead along a path it has not finished.
strolling_turtle :: proc() -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let k = Arc::make_mut(&mut kind);
    // rust: k.id = "minecraft:turtle".into();
    // rust: k.species = Species::Turtle;
    // rust: k.speed = 0.25;
    // rust: k.step_height = 1.0;
    // rust: let mut m = Mob::new(1, kind, Vec3::ZERO, 0.0);
    // rust: m.on_ground = true;
    // rust: let node = PathNode {
    // rust: x: 0,
    // rust: y: 0,
    // rust: z: 10,
    // rust: kind: PathType::Walkable,
}
    // rust: m.ai.nav.path = Some(Path {
    // rust: nodes: vec![node],
    // rust: next: 0,
    // rust: target: [0, 0, 10],
    // rust: dist_to_target: 0.0,
    // rust: reached: true,
    // rust: });
    // rust: m.ai.mov.set_wanted(0.0, 0.0, 10.0, 1.0);
    // rust: m
}
speeds :: proc(m: ^Mob, ticks: uint) -> V {
    // Ported from Horizon
    return {}
}
    // rust: (0..ticks)
    // rust: .map(|_| {
    // rust: move_control(m);
    // rust: assert_eq!(m.ai.zza, m.ai.speed, "setSpeed sets the forward input");
    // rust: m.ai.speed
    // rust: })
    // rust: .collect()
}

walks_on_land_at_a_third_of_its_movement_speed :: proc() {
}
        // TurtleMoveControl.tick on the ground: updateSpeed makes it
        // max(speed / 2, 0.06) = 0.06, then Mth.lerp(0.125F, 0.06, 0.25),
        // every tick. The default MoveControl walked it at the full 0.25, so
        // the walk animation (and TurtleModel's 8 * walkSpeed leg swing) ran
        // about nine times too fast (#1776).
    // rust: let mut m = strolling_turtle();
    // rust: let land = 0.06_f32 + 0.125 * (0.25 - 0.06_f32);
    // rust: assert_eq!(speeds(&mut m, 40), vec![land; 40]);
        // Facing the wanted point, the body with it; it never jumps.
    // rust: assert_eq!(m.body_yaw, m.yaw);
    // rust: assert!(crate::mobs::living::wrap(m.yaw).abs() < 1.0e-3);
    // rust: assert!(!m.ai.jump);
    // rust: assert_eq!(m.ai.mov.operation, Operation::MoveTo);
    // rust: assert_eq!(m.velocity.y, 0.0);
}

the_leg_animation_runs_at_vanilla_s_rate :: proc() {
}
        // LivingEntity.updateWalkAnimation turns the distance a tick into
        // min(distance * 4, 1), and TurtleModel.setupAnim swings the legs
        // by 8 * that speed, so the rate of the walk animation is the rate
        // of the walk. The turtle walks at its own pace, so the animation
        // runs at vanilla's rate instead of at the maximum (#1776).
    // rust: let mut m = strolling_turtle();
    // rust: let mut last = m.position;
    // rust: let mut distance = 0.0_f64;
    // rust: for _ in 0..40 {
            // Entity.tick keeps the position the tick started at.
    // rust: m.previous = last;
            // TurtleMoveControl.tick: the forward input.
    // rust: move_control(&mut m);
            // LivingEntity.travelInAir on grass: the friction influenced
            // speed is the input speed (grass' friction is 0.6, so it is
            // not above it), the move uses the motion as it is, and the
            // motion is then scaled by the friction (0.6) times the air
            // drag (0.91). The move itself needs a world, so the flat
            // ground is stepped here.
    // rust: m.move_relative(m.ai.speed, Vec3::new(0.0, 0.0, 1.0));
    // rust: m.position.x += m.velocity.x;
    // rust: m.position.z += m.velocity.z;
    // rust: let drag = f64::from(0.6_f32 * 0.91_f32);
    // rust: m.velocity.x *= drag;
    // rust: m.velocity.z *= drag;
            // LivingEntity.updateWalkAnimation.
    // rust: m.update_walk_animation();
    // rust: distance = (m.position.x - m.previous.x).hypot(m.position.z - m.previous.z);
    // rust: last = m.position;
}
        // The ground speed: the input (0.06 + 0.125 * (0.25 - 0.06) =
        // 0.08375) over one minus the drag (0.546) = 0.18447 blocks a tick.
    // rust: assert!((distance - 0.083_75 / (1.0 - 0.546)).abs() < 1.0e-6);
        // min(distance * 4, 1) for that pace: 0.73789. The generic
        // MoveControl walked the turtle at the full 0.25, which put it at
        // 0.55066 blocks a tick and saturated the walk animation at 1.0.
    // rust: assert!((m.limb_speed - 0.737_885_5).abs() < 1.0e-6);
}

water_speed_is_cut_away_from_home_and_for_babies :: proc() {
}
        // updateSpeed in water near home: no cut, the lerp climbs towards
        // 0.25, and it lifts the turtle 0.005 a tick. (Tests only the move
        // control's speed; Turtle.travelInWater is ported in travel().)
    // rust: let mut m = strolling_turtle();
    // rust: m.on_ground = false;
    // rust: m.fluids.in_water = true;
    // rust: let s = speeds(&mut m, 60);
    // rust: assert_eq!(s[0], 0.125 * 0.25);
    // rust: assert!(s.windows(2).all(|w| w[1] > w[0]) && s[59] > 0.24 && s[59] < 0.25);
    // rust: assert!((m.velocity.y - 60.0 * 0.005).abs() < 1.0e-9);
        // More than 16 blocks from home: max(speed / 2, 0.08) first.
    // rust: let mut m = strolling_turtle();
    // rust: m.on_ground = false;
    // rust: m.fluids.in_water = true;
    // rust: m.extra.home = Some([0, 0, 40]);
    // rust: let far = 0.08_f32 + 0.125 * (0.25 - 0.08_f32);
    // rust: assert_eq!(speeds(&mut m, 20), vec![far; 20]);
        // A baby: max(speed / 3, 0.06).
    // rust: let mut m = strolling_turtle();
    // rust: m.on_ground = false;
    // rust: m.fluids.in_water = true;
    // rust: m.extra.age = -24000;
    // rust: let young = 0.06_f32 + 0.125 * (0.25 - 0.06_f32);
    // rust: assert_eq!(speeds(&mut m, 20), vec![young; 20]);
}

stops_when_the_path_is_done_or_the_point_reached :: proc() {
}
    // rust: let mut m = strolling_turtle();
    // rust: m.ai.nav.stop();
    // rust: assert_eq!(speeds(&mut m, 1), vec![0.0]);
    // rust: let mut m = strolling_turtle();
    // rust: m.ai.mov.set_wanted(0.0, 0.0, 0.0, 1.0);
    // rust: assert_eq!(speeds(&mut m, 1), vec![0.0]);
        // updateSpeed runs before the early return: a stopped turtle in
        // water is still lifted 0.005, path done or not moving at all.
    // rust: let mut m = strolling_turtle();
    // rust: m.fluids.in_water = true;
    // rust: m.ai.nav.stop();
    // rust: assert_eq!(speeds(&mut m, 1), vec![0.0]);
    // rust: assert_eq!(m.velocity.y, 0.005);
    // rust: let mut m = strolling_turtle();
    // rust: m.fluids.in_water = true;
    // rust: m.ai.mov.operation = Operation::Wait;
    // rust: assert_eq!(speeds(&mut m, 1), vec![0.0]);
    // rust: assert_eq!(m.velocity.y, 0.005);
}

lifts_towards_a_point_above_by_the_slope_of_the_way_there :: proc() {
}
        // setDeltaMovement(... + getSpeed() * (dy / dist) * 0.1): two up,
        // three across and ten ahead.
    // rust: let mut m = strolling_turtle();
    // rust: m.ai.mov.set_wanted(3.0, 2.0, 10.0, 1.0);
    // rust: let speed = speeds(&mut m, 1)[0];
    // rust: let dist = (3.0_f64 * 3.0 + 2.0 * 2.0 + 10.0 * 10.0).sqrt();
    // rust: assert_eq!(m.velocity.y, f64::from(speed) * (2.0 / dist) * 0.1);
    // rust: assert!(m.velocity.y > 0.0);
}

turns_at_most_ninety_degrees_a_tick_and_wraps_into_a_turn :: proc() {
}
        // rotlerp(yRot, target, 90): from 150 towards about -16.7 it turns
        // the full 90 to 60, then reaches the target, kept in [0, 360] as
        // about 343.3; the body follows the yaw each tick.
    // rust: let mut m = strolling_turtle();
    // rust: m.ai.mov.set_wanted(3.0, 0.0, 10.0, 1.0);
    // rust: m.yaw = 150.0;
    // rust: m.body_yaw = 150.0;
    // rust: let target = trig::atan2_degrees(10.0, 3.0) - 90.0;
    // rust: assert!((-17.0..-16.0).contains(&target));
    // rust: move_control(&mut m);
    // rust: assert_eq!((m.yaw, m.body_yaw), (60.0, 60.0));
    // rust: move_control(&mut m);
    // rust: assert_eq!(m.yaw, 60.0 + (target - 60.0) + 360.0);
    // rust: assert_eq!(m.body_yaw, m.yaw);
}
}
