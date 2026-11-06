//! Transpiled from Horizon Rust crate
package horizon_world_stepped_interpolation

import "core:fmt"
import "core:mem"
import "core:math"

// How a client moves a living entity it doesn't simulate along the
// positions its server sends (vanilla `SteppedInterpolationHandler`, which
// `LivingEntity.createInterpolationHandler` gives every living entity on a
// client): each position is a step the entity walks to in the type's update
// interval (3 ticks for most mobs), one after the other, sped up while
// steps pile up. A punched mob's first move, sent at once (`needsSync`),
// thus takes three ticks to show, and the rest follow it.

// use std::collections::VecDeque;

// A position and rotation (`PositionAndRotation`).
PosRot :: struct {
    position: [f64,
    yaw: f32,
    pitch: f32,
}

    // rust: impl PosRot {
    // `PositionAndRotation.is`: the same rotation and `Vec3.equals`
    // position (`Double.compare`, so -0.0 is not 0.0).
is :: proc(self: ^Self, position: [f64; 3], yaw: f32, pitch: f32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.yaw == yaw && self.pitch == pitch && same_position(self.position, position)
}
}

// `Vec3.equals`.
same_position :: proc(a: [f64; 3], b: [f64; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (0..3).all(|i| a[i].to_bits() == b[i].to_bits())
}

// `PositionPath`: where a move packet puts an entity, either straight
// there or through the positions the server stepped it through, each
// with the ticks it took.
Path :: enum {
    Linear([f64; 3]),
    Stepped(Vec<([f64; 3], i32)>),
}

    // rust: impl Path {
end :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Path::Linear(p) => *p,
    // rust: Path::Stepped(steps) => steps.last().map_or([0.0; 3], |s| s.0),
}
}
}

// What the client does with the entity when a packet arrives.
Start :: enum {
    // Moves on to it over the coming ticks.
    Interpolating,
    // Already headed there: nothing changes.
    Unchanged,
    // Is put there at once (`snapTo`): types with no update interval.
    Snap(PosRot),
}

// `SteppedInterpolationHandler` and its `InterpolationData`.
SteppedInterpolation :: struct {
    // `AbstractInterpolationHandler.interpolationSteps`: the type's
    // `updateInterval`.
    steps: i32,
    // The data's own position and rotation: where the last packet said.
    target: PosRot,
    // `lastStepPosRot`: where the step being walked started.
    last: PosRot,
    remaining: VecDeque<(PosRot,
    current_step_ticks: f32,
    remaining_ticks: f32,
    speed: f32,
}

// `Mth.wrapDegrees(float)`.
wrap_degrees :: proc(degrees: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let mut wrapped = degrees % 360.0;
    // rust: if wrapped >= 180.0 {
    // rust: wrapped -= 360.0;
}
    // rust: if wrapped < -180.0 {
    // rust: wrapped += 360.0;
}
    // rust: wrapped
}

// `Mth.lerp(float, float, float)`.
lerp :: proc(a: f32, from: f32, to: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: from + a * (to - from)
}

// `Mth.rotLerp`.
rot_lerp :: proc(a: f32, from: f32, to: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: from + a * wrap_degrees(to - from)
}

    // rust: impl SteppedInterpolation {
    // The handler of an entity type whose update interval is `steps` ticks.
new :: proc(steps: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: steps,
    // rust: target: PosRot::default(),
    // rust: last: PosRot::default(),
    // rust: remaining: VecDeque::new(),
    // rust: current_step_ticks: 0.0,
    // rust: remaining_ticks: 0.0,
    // rust: speed: 1.0,
}
}
    // `hasActiveInterpolation`.
active :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.remaining.is_empty()
}
    // Where the entity is headed: the last packet's position and rotation
    // while interpolating (`AbstractInterpolationHandler.interpolateTo`'s
    // `current`), else where it is.
heading :: proc(self: ^Self, entity: PosRot) -> P {
    // Ported from Horizon
    return {}
}
    // rust: if self.active() { self.target } else { entity }
}
    // `AbstractInterpolationHandler.interpolateTo(path, yRot, xRot,
    // hasRotation)` for an entity at `entity`: a packet without a position
    // (`path` None) keeps the one it is headed for, one without a rotation
    // the rotation.
    // rust: pub fn interpolate_to(
    // rust: &mut self,
    // rust: entity: PosRot,
    // rust: path: Option<Path>,
    // rust: rotation: Option<(f32, f32)>,
    // rust: ) -> Start {
    // rust: let current = self.heading(entity);
    // rust: let path = path.unwrap_or(Path::Linear(current.position));
    // rust: let (yaw, pitch) = rotation.unwrap_or((current.yaw, current.pitch));
    // rust: let end = path.end();
    // rust: if self.steps == 0 {
    // rust: self.cancel();
    // rust: return Start::Snap(PosRot {
    // rust: position: end,
    // rust: yaw,
    // rust: pitch,
    // rust: });
}
    // rust: if self.active() && self.target.is(end, yaw, pitch) {
    // rust: return Start::Unchanged;
}
        // SteppedInterpolationHandler.startInterpolating.
    // rust: if !self.active() {
    // rust: self.last = entity;
    // rust: self.current_step_ticks = 1.0;
}
    // rust: if same_position(end, self.target.position) {
    // rust: self.add_step(
    // rust: PosRot {
    // rust: position: end,
    // rust: yaw,
    // rust: pitch,
    // rust: },
    // rust: self.steps,
    // rust: );
    // rust: } else {
    // rust: self.add_steps(&path, yaw, pitch);
}
    // rust: self.target = PosRot {
    // rust: position: end,
    // rust: yaw,
    // rust: pitch,
}
    // rust: Start::Interpolating
}
    // `cancel` (`InterpolationData.reset`).
cancel :: proc(self: ^Self) {
}
    // rust: self.remaining.clear();
    // rust: self.remaining_ticks = 0.0;
    // rust: self.speed = 1.0;
}
    // `AbstractInterpolationHandler.interpolate`, once a client tick: where
    // the entity is put, or None when there is nothing to walk (and the
    // handler resets). The client moves the entity only this way, so the
    // target never needs the deltas `adjustInterpolationTargetFromDeltas`
    // would add.
interpolate :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !self.active() {
    // rust: self.cancel();
    // rust: return None;
}
        // doInterpolate: getNewPositionAndRotation, then advance by the
        // level's relative tick speed (1 at the normal tick rate).
    // rust: let at = self.new_position();
    // rust: self.advance(1.0);
    // rust: Some(at)
}
    // `InterpolationData.addStep`.
add_step :: proc(self: ^Self, step: PosRot, ticks: i32) {
}
    // rust: self.remaining.push_back((step, ticks));
    // rust: self.remaining_ticks += ticks as f32;
}
    // `InterpolationData.addSteps`: a stepped path's steps take their own
    // ticks, turning by the share of the path each one ends.
add_steps :: proc(self: ^Self, path: ^Path, yaw: f32, pitch: f32) {
}
    // rust: match path {
    // rust: Path::Linear(p) => self.add_step(
    // rust: PosRot {
    // rust: position: *p,
    // rust: yaw,
    // rust: pitch,
    // rust: },
    // rust: self.steps,
    // rust: ),
    // rust: Path::Stepped(steps) => {
    // rust: if yaw == self.target.yaw && pitch == self.target.pitch {
    // rust: for (p, ticks) in steps {
    // rust: self.add_step(
    // rust: PosRot {
    // rust: position: *p,
    // rust: yaw,
    // rust: pitch,
    // rust: },
    // rust: *ticks,
    // rust: );
}
    // rust: return;
}
    // rust: let total: i32 = steps.iter().map(|s| s.1).sum();
    // rust: let mut offset = 0;
    // rust: let (from_yaw, from_pitch) = (self.target.yaw, self.target.pitch);
    // rust: for (p, ticks) in steps {
    // rust: offset += ticks;
    // rust: let a = offset as f32 / total as f32;
    // rust: let step = PosRot {
    // rust: position: *p,
    // rust: yaw: rot_lerp(a, from_yaw, yaw),
    // rust: pitch: lerp(a, from_pitch, pitch),
}
    // rust: self.add_step(step, *ticks);
}
}
}
}
    // `InterpolationData.getNewPositionAndRotation`.
new_position :: proc(self: ^Self) -> P {
    // Ported from Horizon
    return {}
}
    // rust: while let Some(&(step, ticks)) = self.remaining.front() {
    // rust: if self.current_step_ticks < ticks as f32 {
    // rust: let a = self.current_step_ticks / ticks as f32;
    // rust: let t = f64::from(a);
    // rust: let (from, to) = (self.last.position, step.position);
    // rust: return PosRot {
    // rust: position: [0, 1, 2].map(|i| from[i] + (to[i] - from[i]) * t),
    // rust: yaw: rot_lerp(a, self.last.yaw, step.yaw),
    // rust: pitch: lerp(a, self.last.pitch, step.pitch),
}
}
    // rust: self.current_step_ticks -= ticks as f32;
    // rust: self.last = step;
    // rust: self.remaining.pop_front();
}
    // rust: self.target
}
    // `InterpolationData.advance`: faster while more than one update's
    // worth of steps waits.
advance :: proc(self: ^Self, ticks: f32) {
}
    // rust: let steps = self.steps as f32;
    // rust: let target_speed = (self.remaining_ticks / steps).max(1.0);
    // rust: self.speed = lerp(1.0 / steps, self.speed, target_speed);
    // rust: let moved = if ticks * self.speed < self.remaining_ticks {
    // rust: ticks * self.speed
    // rust: } else {
    // rust: self.speed = 1.0;
    // rust: self.remaining_ticks
}
    // rust: self.current_step_ticks += moved;
    // rust: self.remaining_ticks -= moved;
}
}

    // rust: mod tests {
//     use super::*;

at :: proc(x: f64) -> P {
    // Ported from Horizon
    return {}
}
    // rust: PosRot {
    // rust: position: [x, 0.0, 0.0],
    // rust: yaw: 0.0,
    // rust: pitch: 0.0,
}
}

a_position_takes_the_update_interval_to_reach :: proc() {
}
    // rust: let mut h = SteppedInterpolation::new(3);
    // rust: let mut entity = at(0.0);
    // rust: h.interpolate_to(entity, Some(Path::Linear([0.3, 0.0, 0.0])), None);
    // rust: let mut seen = Vec::new();
    // rust: while let Some(p) = h.interpolate() {
    // rust: entity = p;
    // rust: seen.push((p.position[0] * 1000.0).round() / 1000.0);
}
    // rust: assert_eq!(seen, [0.1, 0.2, 0.3]);
    // rust: assert!(!h.active());
    // rust: assert_eq!(entity.position[0], 0.3);
}

steps_that_pile_up_are_walked_faster :: proc() {
}
    // rust: let mut h = SteppedInterpolation::new(3);
    // rust: let mut entity = at(0.0);
    // rust: let mut ticks = 0;
    // rust: for k in 1..=4 {
    // rust: h.interpolate_to(entity, Some(Path::Linear([f64::from(k), 0.0, 0.0])), None);
    // rust: if let Some(p) = h.interpolate() {
    // rust: entity = p;
}
    // rust: ticks += 1;
}
    // rust: while let Some(p) = h.interpolate() {
    // rust: entity = p;
    // rust: ticks += 1;
}
        // Four packets a tick apart: 12 ticks of steps, walked in fewer.
    // rust: assert!(ticks < 12, "{ticks}");
    // rust: assert_eq!(entity.position[0], 4.0);
}

no_update_interval_snaps :: proc() {
}
    // rust: let mut h = SteppedInterpolation::new(0);
    // rust: let start = h.interpolate_to(
    // rust: at(0.0),
    // rust: Some(Path::Linear([2.0, 0.0, 0.0])),
    // rust: Some((90.0, 0.0)),
    // rust: );
    // rust: assert_eq!(
    // rust: start,
    // rust: Start::Snap(PosRot {
    // rust: position: [2.0, 0.0, 0.0],
    // rust: yaw: 90.0,
    // rust: pitch: 0.0
    // rust: })
    // rust: );
}
}
