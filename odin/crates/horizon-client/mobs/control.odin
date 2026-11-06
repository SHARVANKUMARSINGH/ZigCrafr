//! Transpiled from Horizon Rust crate
package horizon_client_control

import "core:fmt"
import "core:mem"
import "core:math"

// Mob controls: `MoveControl` (with the flying and smooth-swimming
// variants), `LookControl`, `JumpControl` and `BodyRotationControl`.
// use super::{Mob, MobWorld, Species, living::wrap};
// use horizon_core::geometry::trig;

// `2.5000003E-7F` widened: the squared distance controls treat as arrived.
ARRIVED :: 2.500_000_3e-7_f32 as f64
// `1.0E-5F` widened.
    // rust: pub(super) const EPSILON: f64 = 1.0e-5_f32 as f64;

Operation :: enum {
    Wait,
    MoveTo,
    Strafe,
    Jumping,
}
MoveKind :: enum {
    Ground,
    // FlyingMoveControl(maxTurn, hoversInPlace)
    Flying { max_turn: f32, hovers: bool },
    // SmoothSwimmingMoveControl(maxTurnX, maxTurnY, inWater, outsideWater, applyGravity)
    SmoothSwimming {,
    max_turn_x: f32,
    max_turn_y: f32,
    in_water: f32,
    outside: f32,
    gravity: bool,
    // rust: },
    // Goals drive the mob directly (slimes, ghasts, squid, fish, bats, phantoms).
    Custom,
}
MoveControl :: struct {
    kind: MoveKind,
    wanted: [f64,
    speed_modifier: f64,
    strafe_forwards: f32,
    strafe_right: f32,
    operation: Operation,
}
    // rust: impl MoveControl {
has_wanted :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.operation == Operation::MoveTo
}
set_wanted :: proc(self: ^Self, x: f64, y: f64, z: f64, speed: f64) {
}
    // rust: self.wanted = [x, y, z];
    // rust: self.speed_modifier = speed;
    // rust: if self.operation != Operation::Jumping {
    // rust: self.operation = Operation::MoveTo;
}
}
strafe :: proc(self: ^Self, forwards: f32, right: f32) {
}
    // rust: self.operation = Operation::Strafe;
    // rust: self.strafe_forwards = forwards;
    // rust: self.strafe_right = right;
    // rust: self.speed_modifier = 0.25;
}
}
// MoveControl.rotlerp: turn at most `max` degrees, result in [0, 360].
rotlerp :: proc(a: f32, b: f32, max: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let diff = wrap(b - a).clamp(-max, max);
    // rust: let mut r = a + diff;
    // rust: if r < 0.0 {
    // rust: r += 360.0;
    // rust: } else if r > 360.0 {
    // rust: r -= 360.0;
}
    // rust: r
}
// Control.rotateTowards.
rotate_towards :: proc(from: f32, to: f32, max: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: from + wrap(to - from).clamp(-max, max)
}
// Mth.rotateIfNecessary.
rotate_if_necessary :: proc(base: f32, target: f32, max: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let d = wrap(target - base).clamp(-max, max);
    // rust: target - d
}
LookKind :: enum {
    Default,
    // SmoothSwimmingLookControl(maxYRotFromCenter)
    SmoothSwimming(f32),
    // Look controls that never reset pitch (e.g. ghasts keep their own).
    Fixed,
    // `HappyGhast.HappyGhastLookControl`.
    HappyGhast,
    // `Shulker.ShulkerLookControl`: the yaw turns in the attach face's
    // plane and the head is never clamped to the body.
    Shulker,
}
LookControl :: struct {
    kind: LookKind,
    wanted: [f64,
    y_max_rot_speed: f32,
    x_max_rot_angle: f32,
    cooldown: i32,
}
    // rust: impl LookControl {
set_look_at :: proc(self: ^Self, at: [f64; 3], y_speed: f32, x_max: f32) {
}
    // rust: self.wanted = at;
    // rust: self.y_max_rot_speed = y_speed;
    // rust: self.x_max_rot_angle = x_max;
    // rust: self.cooldown = 2;
}
}
BodyRotation :: struct {
    head_stable_time: i32,
    last_stable_head: f32,
}
    // rust: impl Mob {
    // `Mob.getMaxHeadXRot`, with `Wolf`'s 20 degrees while sitting.
max_head_x_rot :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if self.species() == Species::Wolf && self.extra.sitting {
    // rust: 20.0
    // rust: } else {
    // rust: self.kind.max_head_x_rot
}
}
look_at :: proc(self: ^Self, at: [f64; 3]) {
}
    // rust: let (y, x) = (self.kind.head_rot_speed, self.max_head_x_rot());
    // rust: self.ai.look.set_look_at(at, y, x);
}
look_at_speed :: proc(self: ^Self, at: [f64; 3], y_speed: f32, x_max: f32) {
}
    // rust: self.ai.look.set_look_at(at, y_speed, x_max);
}
    // Mob.lookAt(entity, yMax, xMax): rotate the body yaw/pitch directly.
turn_to :: proc(self: ^Self, at: [f64; 3], y_max: f32, x_max: f32) {
}
    // rust: let (dx, dz) = (at[0] - self.position.x, at[2] - self.position.z);
    // rust: let dy = at[1] - self.eye_y();
    // rust: let sd = (dx * dx + dz * dz).sqrt();
    // rust: let y_rot = trig::atan2_degrees(dz, dx) - 90.0;
    // rust: let x_rot = -trig::atan2_degrees(dy, sd);
    // rust: self.head_pitch = rotate_toward_max(self.head_pitch, x_rot, x_max);
    // rust: self.yaw = rotate_toward_max(self.yaw, y_rot, y_max);
}
    // MoveControl.tick (and the flying / smooth-swimming variants).
move_control_tick :: proc(self: ^Self, w: ^MobWorld, events: ^[dynamic]super::MobEvent) {
}
    // rust: if self.species() == super::Species::Rabbit {
    // rust: return super::rabbit::move_control(self, w);
}
        // Fox.FoxMoveControl.tick: still while asleep, sitting or faceplanted.
    // rust: if self.species() == super::Species::Fox && !super::fox::can_move(self) {
    // rust: return;
}
        // Panda.PandaMoveControl: only while it can act.
    // rust: if self.species() == super::Species::Panda
    // rust: && !super::panda::can_perform_action(self, w.thundering)
    // rust: {
    // rust: return;
}
    // rust: if self.species() == super::Species::Turtle {
    // rust: return super::turtle::move_control(self);
}
    // rust: let attr_speed = self.movement_speed();
    // rust: match self.ai.mov.kind {
    // rust: MoveKind::Custom => super::ai::custom_move_control(self, w, events),
    // rust: MoveKind::Ground => self.ground_move_tick(w, attr_speed),
    // rust: MoveKind::Flying { max_turn, hovers } => {
    // rust: let m = &mut self.ai.mov;
    // rust: if m.operation == Operation::MoveTo {
    // rust: m.operation = Operation::Wait;
    // rust: self.no_gravity = true;
    // rust: let [wx, wy, wz] = self.ai.mov.wanted;
    // rust: let (xd, yd, zd) = (
    // rust: wx - self.position.x,
    // rust: wy - self.position.y,
    // rust: wz - self.position.z,
    // rust: );
    // rust: if xd * xd + yd * yd + zd * zd < ARRIVED {
    // rust: self.ai.yya = 0.0;
    // rust: self.ai.zza = 0.0;
    // rust: return;
}
    // rust: let y_rot = trig::atan2_degrees(zd, xd) - 90.0;
    // rust: self.yaw = rotlerp(self.yaw, y_rot, 90.0);
    // rust: let speed = (self.ai.mov.speed_modifier
    // rust: * if self.on_ground {
    // rust: attr_speed
    // rust: } else {
                            // getAttributeValue(FLYING_SPEED): a summon's base counts.
    // rust: super::finalize::value(self, super::finalize::Attr::FlyingSpeed)
    // rust: }) as f32;
    // rust: self.set_speed(speed);
    // rust: let sd = (xd * xd + zd * zd).sqrt();
    // rust: if yd.abs() > EPSILON || sd.abs() > EPSILON {
    // rust: let x_rot = -trig::atan2_degrees(yd, sd);
                        // Entity.setXRot clamps: a pitch rotlerp wraps to 359 becomes 90.
    // rust: self.head_pitch =
    // rust: (rotlerp(self.head_pitch, x_rot, max_turn) % 360.0).clamp(-90.0, 90.0);
    // rust: self.ai.yya = if yd > 0.0 { speed } else { -speed };
}
    // rust: } else {
    // rust: if !hovers {
    // rust: self.no_gravity = false;
}
    // rust: self.ai.yya = 0.0;
    // rust: self.ai.zza = 0.0;
}
}
    // rust: MoveKind::SmoothSwimming {
    // rust: max_turn_x,
    // rust: max_turn_y,
    // rust: in_water,
    // rust: outside,
    // rust: gravity,
    // rust: } => {
    // rust: if gravity && self.fluids.in_water {
    // rust: self.velocity.y += 0.005;
}
    // rust: if self.ai.mov.operation == Operation::MoveTo && !self.ai.nav.is_done() {
    // rust: let [wx, wy, wz] = self.ai.mov.wanted;
    // rust: let (xd, yd, zd) = (
    // rust: wx - self.position.x,
    // rust: wy - self.position.y,
    // rust: wz - self.position.z,
    // rust: );
    // rust: if xd * xd + yd * yd + zd * zd < ARRIVED {
    // rust: self.ai.zza = 0.0;
    // rust: } else {
    // rust: let y_rot = trig::atan2_degrees(zd, xd) - 90.0;
    // rust: self.yaw = rotlerp(self.yaw, y_rot, max_turn_y);
    // rust: self.body_yaw = self.yaw;
    // rust: self.head_yaw = self.yaw;
    // rust: let speed = (self.ai.mov.speed_modifier * attr_speed) as f32;
    // rust: if self.fluids.in_water {
    // rust: self.ai.speed = speed * in_water;
    // rust: let sd = (xd * xd + zd * zd).sqrt();
    // rust: if yd.abs() > EPSILON || sd.abs() > EPSILON {
    // rust: let x_rot = -trig::atan2_degrees(yd, sd);
    // rust: let x_rot = wrap(x_rot).clamp(-max_turn_x, max_turn_x);
    // rust: self.head_pitch = rotate_towards(self.head_pitch, x_rot, 5.0);
}
    // rust: let angle = f64::from(self.head_pitch * trig::DEG_TO_RAD);
    // rust: let (c, s) = (trig::cos(angle), trig::sin(angle));
    // rust: self.ai.zza = c * speed;
    // rust: self.ai.yya = -s * speed;
    // rust: } else {
    // rust: let left = wrap(self.yaw - y_rot).abs();
    // rust: let factor = 1.0 - ((left - 10.0) / 50.0).clamp(0.0, 1.0);
    // rust: self.set_speed(speed * outside * factor);
}
}
    // rust: } else {
    // rust: self.ai.speed = 0.0;
    // rust: self.ai.xxa = 0.0;
    // rust: self.ai.yya = 0.0;
    // rust: self.ai.zza = 0.0;
}
}
}
}
    // Mob.setSpeed also sets the forward input.
set_speed :: proc(self: ^Self, speed: f32) {
}
    // rust: self.ai.speed = speed;
    // rust: self.ai.zza = speed;
}
    // rust: pub(crate) fn ground_move_tick(&mut self, w: &MobWorld, attr_speed: f64) {
    // rust: match self.ai.mov.operation {
    // rust: Operation::Strafe => {
    // rust: let speed = self.ai.mov.speed_modifier as f32 * attr_speed as f32;
    // rust: let (mut xa, mut za) = (self.ai.mov.strafe_forwards, self.ai.mov.strafe_right);
    // rust: let mut dist = (xa * xa + za * za).sqrt();
    // rust: if dist < 1.0 {
    // rust: dist = 1.0;
}
    // rust: dist = speed / dist;
    // rust: xa *= dist;
    // rust: za *= dist;
    // rust: let angle = f64::from(self.yaw * trig::DEG_TO_RAD);
    // rust: let (s, c) = (trig::sin(angle), trig::cos(angle));
    // rust: let dx = xa * c - za * s;
    // rust: let dz = za * c + xa * s;
    // rust: if !self.walkable(w, dx, dz) {
    // rust: self.ai.mov.strafe_forwards = 1.0;
    // rust: self.ai.mov.strafe_right = 0.0;
}
    // rust: self.set_speed(speed);
    // rust: self.ai.zza = self.ai.mov.strafe_forwards;
    // rust: self.ai.xxa = self.ai.mov.strafe_right;
    // rust: self.ai.mov.operation = Operation::Wait;
}
    // rust: Operation::MoveTo => {
    // rust: self.ai.mov.operation = Operation::Wait;
    // rust: let [wx, wy, wz] = self.ai.mov.wanted;
    // rust: let (xd, yd, zd) = (
    // rust: wx - self.position.x,
    // rust: wy - self.position.y,
    // rust: wz - self.position.z,
    // rust: );
    // rust: if xd * xd + yd * yd + zd * zd < ARRIVED {
    // rust: self.ai.zza = 0.0;
    // rust: return;
}
    // rust: let y_rot = trig::atan2_degrees(zd, xd) - 90.0;
    // rust: self.yaw = rotlerp(self.yaw, y_rot, 90.0);
    // rust: self.set_speed((self.ai.mov.speed_modifier * attr_speed) as f32);
    // rust: let (bx, by, bz) = (
    // rust: self.position.x.floor() as i32,
    // rust: self.position.y.floor() as i32,
    // rust: self.position.z.floor() as i32,
    // rust: );
    // rust: let state = w.world.block(bx, by, bz);
    // rust: let top = w.data.state(state).top;
    // rust: let name = &w.facts.get(state).name;
    // rust: let door_or_fence = name.ends_with("_door") || name.ends_with("fence");
    // rust: if yd > self.kind.step_height
    // rust: && xd * xd + zd * zd < f64::from(self.width().max(1.0))
    // rust: || top > 0.0
    // rust: && self.position.y < f64::from(top) + f64::from(by)
    // rust: && !door_or_fence
    // rust: {
    // rust: self.ai.jump = true;
    // rust: self.ai.mov.operation = Operation::Jumping;
}
}
    // rust: Operation::Jumping => {
    // rust: self.set_speed((self.ai.mov.speed_modifier * attr_speed) as f32);
    // rust: if self.on_ground || self.is_in_liquid() {
    // rust: self.ai.mov.operation = Operation::Wait;
}
}
    // rust: Operation::Wait => self.ai.zza = 0.0,
}
}
walkable :: proc(self: ^Self, w: ^MobWorld, dx: f32, dz: f32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let x = (self.position.x + f64::from(dx)).floor() as i32;
    // rust: let z = (self.position.z + f64::from(dz)).floor() as i32;
    // rust: let y = self.position.y.floor() as i32;
    // rust: w.path_type_static(x, y, z) == super::path::PathType::Walkable
}
    // LookControl.tick (and SmoothSwimmingLookControl).
look_control_tick :: proc(self: ^Self) {
}
    // rust: let look = self.ai.look.clone();
    // rust: let fox = self.species() == super::Species::Fox;
        // Fox.FoxLookControl: no turning in sleep.
    // rust: if fox && super::fox::flag(self, super::fox::SLEEPING) {
    // rust: return;
}
    // rust: if look.kind == LookKind::HappyGhast {
    // rust: return super::happy_ghast::look_control(self);
}
    // rust: let (x_d, y_d) = self.look_angles(look.wanted);
    // rust: match look.kind {
    // rust: LookKind::HappyGhast => {}
    // rust: LookKind::SmoothSwimming(max) => {
    // rust: if look.cooldown > 0 {
    // rust: self.ai.look.cooldown -= 1;
    // rust: if let Some(y) = y_d {
    // rust: self.head_yaw =
    // rust: rotate_towards(self.head_yaw, y + 20.0, look.y_max_rot_speed);
}
    // rust: if let Some(x) = x_d {
    // rust: self.head_pitch =
    // rust: rotate_towards(self.head_pitch, x + 10.0, look.x_max_rot_angle);
}
    // rust: } else {
    // rust: if self.ai.nav.is_done() {
    // rust: self.head_pitch = rotate_towards(self.head_pitch, 0.0, 5.0);
}
    // rust: self.head_yaw =
    // rust: rotate_towards(self.head_yaw, self.body_yaw, look.y_max_rot_speed);
}
    // rust: let diff = wrap(self.head_yaw - self.body_yaw);
    // rust: if diff < -max {
    // rust: self.body_yaw -= 4.0;
    // rust: } else if diff > max {
    // rust: self.body_yaw += 4.0;
}
}
    // rust: LookKind::Shulker => {
                // ShulkerLookControl: resetXRotOnTick, getXRotD 0, and the
                // yaw worked out in the attach face's plane (getYRotD).
    // rust: self.head_pitch = 0.0;
    // rust: if look.cooldown > 0 {
    // rust: self.ai.look.cooldown -= 1;
    // rust: if let Some(y) = super::shulker::look_yaw(self, look.wanted) {
    // rust: self.head_yaw = rotate_towards(self.head_yaw, y, look.y_max_rot_speed);
}
    // rust: } else {
    // rust: self.head_yaw = rotate_towards(self.head_yaw, self.body_yaw, 10.0);
}
                // clampHeadRotationToBody does nothing for a shulker.
}
    // rust: LookKind::Default | LookKind::Fixed => {
                // FoxLookControl.resetXRotOnTick keeps a stalking or pouncing pitch.
    // rust: if look.kind == LookKind::Default && (!fox || super::fox::resets_x_rot(self)) {
    // rust: self.head_pitch = 0.0;
}
    // rust: if look.cooldown > 0 {
    // rust: self.ai.look.cooldown -= 1;
    // rust: if let Some(y) = y_d {
    // rust: self.head_yaw = rotate_towards(self.head_yaw, y, look.y_max_rot_speed);
}
    // rust: if let Some(x) = x_d {
    // rust: self.head_pitch = rotate_towards(self.head_pitch, x, look.x_max_rot_angle);
}
    // rust: } else {
    // rust: self.head_yaw = rotate_towards(self.head_yaw, self.body_yaw, 10.0);
}
    // rust: if !self.ai.nav.is_done() {
    // rust: self.head_yaw =
    // rust: rotate_if_necessary(self.head_yaw, self.body_yaw, self.kind.max_head_y_rot);
}
}
}
        // Goat.setYHeadRot: the head is clamped to `getMaxHeadYRot` (15
        // degrees) from the body on every set, so a standing goat cannot
        // swivel it further than a walking one.
    // rust: if self.species() == Species::Goat {
    // rust: self.head_yaw =
    // rust: rotate_if_necessary(self.head_yaw, self.body_yaw, self.kind.max_head_y_rot);
}
}
look_angles :: proc(self: ^Self, at: [f64; 3]) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let (xd, yd, zd) = (
    // rust: at[0] - self.position.x,
    // rust: at[1] - self.eye_y(),
    // rust: at[2] - self.position.z,
    // rust: );
    // rust: let sd = (xd * xd + zd * zd).sqrt();
    // rust: let x = (yd.abs() > EPSILON || sd.abs() > EPSILON).then(|| -trig::atan2_degrees(yd, sd));
    // rust: let y =
    // rust: (zd.abs() > EPSILON || xd.abs() > EPSILON).then(|| trig::atan2_degrees(zd, xd) - 90.0);
    // rust: (x, y)
}
    // JumpControl.tick.
jump_control_tick :: proc(self: ^Self) {
}
    // rust: if self.species() == super::Species::Rabbit {
    // rust: return super::rabbit::jump_control(self);
}
    // rust: self.ai.jumping = self.ai.jump;
    // rust: self.ai.jump = false;
}
    // BodyRotationControl.clientTick (Mob.tickHeadTurn).
body_rotation_tick :: proc(self: ^Self) {
}
        // Shulker.ShulkerBodyRotationControl.clientTick is empty: the body
        // stays at 0 (recreateFromPacket), only the head turns.
    // rust: if self.species() == super::Species::Shulker {
    // rust: self.body_yaw = 0.0;
    // rust: self.previous_body_yaw = 0.0;
    // rust: return;
}
    // rust: let dx = self.position.x - self.previous.x;
    // rust: let dz = self.position.z - self.previous.z;
    // rust: let max = self.kind.max_head_y_rot;
    // rust: if dx * dx + dz * dz > ARRIVED {
    // rust: self.body_yaw = self.yaw;
    // rust: self.head_yaw = rotate_if_necessary(self.head_yaw, self.body_yaw, max);
    // rust: self.ai.body.last_stable_head = self.head_yaw;
    // rust: self.ai.body.head_stable_time = 0;
    // rust: } else if (self.head_yaw - self.ai.body.last_stable_head).abs() > 15.0 {
    // rust: self.ai.body.head_stable_time = 0;
    // rust: self.ai.body.last_stable_head = self.head_yaw;
    // rust: self.body_yaw = rotate_if_necessary(self.body_yaw, self.head_yaw, max);
    // rust: } else {
    // rust: self.ai.body.head_stable_time += 1;
    // rust: if self.ai.body.head_stable_time > 10 {
    // rust: let t = self.ai.body.head_stable_time - 10;
    // rust: let fraction = (t as f32 / 10.0).clamp(0.0, 1.0);
    // rust: self.body_yaw =
    // rust: rotate_if_necessary(self.body_yaw, self.head_yaw, max * (1.0 - fraction));
}
}
}
}
// Entity.rotlerp used by Mob.lookAt (clamped turn, no wrap of the result).
rotate_toward_max :: proc(from: f32, to: f32, max: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: from + wrap(to - from).clamp(-max, max)
}

    // rust: mod goat_head_tests {
//     use super::*;
//     use horizon_core::geometry::Vec3;
//     use std::sync::Arc;

mob :: proc(species: Species) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: kind.species = species;
        // Mob.getMaxHeadYRot: 15 for a goat (Goat.getMaxHeadYRot), 75 otherwise.
    // rust: kind.max_head_y_rot = if species == Species::Goat { 15.0 } else { 75.0 };
    // rust: Mob::new(1, Arc::new(kind), Vec3::ZERO, 0.0)
}

    // `Goat.setYHeadRot`: whatever the look control asks for, a goat's head
    // stays within `getMaxHeadYRot` (15 degrees) of its body, standing still
    // or walking; another mob turns as far as it likes.
a_goats_head_stays_within_fifteen_degrees_of_its_body :: proc() {
}
    // rust: let turned = |species: Species| {
    // rust: let mut m = mob(species);
    // rust: m.body_yaw = 0.0;
            // A target 40 blocks to the side: a quarter turn away.
    // rust: m.ai.look.kind = LookKind::Default;
    // rust: m.ai.look.wanted = [40.0, 1.0, 0.0];
    // rust: m.ai.look.y_max_rot_speed = 1000.0;
    // rust: m.ai.look.x_max_rot_angle = 40.0;
    // rust: m.ai.look.cooldown = 20;
    // rust: m.look_control_tick();
    // rust: wrap(m.head_yaw - m.body_yaw)
}
    // rust: let goat = turned(Species::Goat);
    // rust: assert!(
    // rust: goat.abs() <= 15.0 + 1.0e-3,
    // rust: "the goat's head turned {goat} degrees from its body"
    // rust: );
    // rust: assert!(
    // rust: turned(Species::Cow).abs() > 15.0,
    // rust: "a cow is not held to the goat's 15 degrees"
    // rust: );
}
}
