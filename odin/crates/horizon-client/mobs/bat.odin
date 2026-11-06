//! Transpiled from Horizon Rust crate
package horizon_client_bat

import "core:fmt"
import "core:mem"
import "core:math"

// Bats (`Bat`): hanging upside down under a solid block until a player comes
// near, then fluttering about towards random nearby air (`customServerAiStep`),
// and `BatModel`'s flying and resting keyframe animations. `extra.flag` is
// `isResting`, `extra.positions[0]` the `targetPosition`; animation states:
// flying, resting.
// use super::{Mob, MobEvent, MobWorld, data::REDSTONE_CONDUCTOR, living::wrap};
// use horizon_core::{
    // rust: geometry::{Vec3, trig},
    // rust: random::RandomSource,
}

// `Bat(EntityType, Level)`: a new bat hangs.
register :: proc(m: ^Mob) {
}
    // rust: m.extra.flag = true;
}
resting :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.flag
}
// `Bat.setResting`.
set_resting :: proc(m: ^Mob, value: bool) {
}
    // rust: m.extra.flag = value;
}
// `Bat.hurtServer`: a hit wakes it.
hurt :: proc(m: ^Mob) {
}
    // rust: set_resting(m, false);
}
// `levelEvent(1025)`: the take-off flutter, unless silent.
take_off :: proc(m: ^Mob, p: [i32; 3], events: ^[dynamic]MobEvent) {
}
    // rust: if !m.silent {
    // rust: events.push(MobEvent::LevelEventSound {
    // rust: sound: "entity.bat.takeoff",
    // rust: at: [
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]) + 0.5,
    // rust: f64::from(p[2]) + 0.5,
    // rust: ],
    // rust: volume: 0.05,
    // rust: spread: 0.2,
    // rust: });
}
}
// `Bat.customServerAiStep`.
server_ai_step :: proc(m: ^Mob, w: ^MobWorld, events: ^[dynamic]MobEvent) {
}
    // rust: let pos = [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ];
    // rust: let above = [pos[0], pos[1] + 1, pos[2]];
    // rust: let conductor =
    // rust: |p: [i32; 3]| w.data.state(w.world.block(p[0], p[1], p[2])).flags & REDSTONE_CONDUCTOR != 0;
    // rust: if resting(m) {
    // rust: if conductor(above) {
    // rust: if m.random.next_int_bound(200).unwrap_or(1) == 0 {
    // rust: m.head_yaw = m.random.next_int_bound(360).unwrap_or(0) as f32;
}
            // getNearestPlayer(forNonCombat().range(4.0)).
    // rust: if m.can_see_player(w, 4.0) {
    // rust: set_resting(m, false);
    // rust: take_off(m, pos, events);
}
    // rust: } else {
    // rust: set_resting(m, false);
    // rust: take_off(m, pos, events);
}
    // rust: return;
}
    // rust: if let Some(&t) = m.extra.positions.first()
    // rust: && (!w.facts.is_air(w.world.block(t[0], t[1], t[2])) || t[1] <= w.world.bottom_y())
    // rust: {
    // rust: m.extra.positions.clear();
}
    // rust: let near = |t: [i32; 3]| {
    // rust: let d = |a: i32, b: f64| f64::from(a) + 0.5 - b;
    // rust: let (dx, dy, dz) = (
    // rust: d(t[0], m.position.x),
    // rust: d(t[1], m.position.y),
    // rust: d(t[2], m.position.z),
    // rust: );
    // rust: dx * dx + dy * dy + dz * dz < 4.0
}
    // rust: let current = m.extra.positions.first().copied();
    // rust: if current.is_none()
    // rust: || m.random.next_int_bound(30).unwrap_or(1) == 0
    // rust: || current.is_some_and(near)
    // rust: {
    // rust: let r = &mut m.random;
    // rust: let mut offset = |bound: i32| r.next_int_bound(bound).unwrap_or(0);
    // rust: let x = m.position.x + f64::from(offset(7)) - f64::from(offset(7));
    // rust: let y = m.position.y + f64::from(offset(6)) - 2.0;
    // rust: let z = m.position.z + f64::from(offset(7)) - f64::from(offset(7));
    // rust: m.extra.positions.clear();
    // rust: m.extra
    // rust: .positions
    // rust: .push([x.floor() as i32, y.floor() as i32, z.floor() as i32]);
}
    // rust: let t = m.extra.positions[0];
    // rust: let dx = f64::from(t[0]) + 0.5 - m.position.x;
    // rust: let dy = f64::from(t[1]) + 0.1 - m.position.y;
    // rust: let dz = f64::from(t[2]) + 0.5 - m.position.z;
    // rust: let v = m.velocity;
    // rust: let tenth = f64::from(0.1_f32);
    // rust: let v = Vec3::new(
    // rust: v.x + (signum(dx) * 0.5 - v.x) * tenth,
    // rust: v.y + (signum(dy) * f64::from(0.7_f32) - v.y) * tenth,
    // rust: v.z + (signum(dz) * 0.5 - v.z) * tenth,
    // rust: );
    // rust: m.velocity = v;
    // rust: let y_rot = trig::atan2_degrees(v.z, v.x) - 90.0;
    // rust: let diff = wrap(y_rot - m.yaw);
    // rust: m.ai.zza = 0.5;
    // rust: m.yaw += diff;
    // rust: if m.random.next_int_bound(100).unwrap_or(1) == 0 && conductor(above) {
    // rust: set_resting(m, true);
}
}
// `Math.signum`: zero stays zero (Rust's `signum` gives 1).
signum :: proc(v: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if v == 0.0 || v.is_nan() {
    // rust: v
    // rust: } else {
    // rust: v.signum()
}
}
// `Bat.tick` after `super.tick()`: a hanging bat stays put, hooked to the
// block above; a flying one loses 40% of its vertical speed. Then
// `setupAnimationStates`.
tick :: proc(m: ^Mob) {
}
    // rust: if resting(m) {
    // rust: m.velocity = Vec3::ZERO;
    // rust: m.position.y = m.position.y.floor() + 1.0 - f64::from(m.height());
    // rust: } else {
    // rust: m.velocity.y *= 0.6;
}
    // rust: setup_animation_states(m);
}
// `Bat.setupAnimationStates`: client visuals, without changing server motion.
setup_animation_states :: proc(m: ^Mob) {
}
    // rust: let age = m.age as f32;
    // rust: if resting(m) {
    // rust: m.anim.states[0].stop();
    // rust: m.anim.states[1].start_if_stopped(age);
    // rust: } else {
    // rust: m.anim.states[1].stop();
    // rust: m.anim.states[0].start_if_stopped(age);
}
}
