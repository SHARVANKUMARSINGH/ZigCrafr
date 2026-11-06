//! Transpiled from Horizon Rust crate
package horizon_world_piston_movement

import "core:fmt"
import "core:mem"
import "core:math"

// Per-tick Entity piston movement accumulation and displacement limiting.
// use horizon_core::geometry::Vec3;

PistonMovement :: struct {
    game_time: i64,
    deltas: [f64,
}
    // rust: impl PistonMovement {
    // Native queries game time only after the length threshold. A failed time
    // query leaves this accumulator unchanged. Tiny motion passes
    // through before either the query or per-tick reset.
    // rust: pub fn limit<E>(
    // rust: &mut self,
    // rust: movement: Vec3,
    // rust: game_time: impl FnOnce() -> Result<i64, E>,
    // rust: ) -> Result<Vec3, E> {
    // rust: let length = movement.x * movement.x + movement.y * movement.y + movement.z * movement.z;
    // rust: if length <= 1.0e-7 {
    // rust: return Ok(movement);
}
    // rust: let time = game_time()?;
    // rust: if self.game_time != time {
    // rust: self.deltas = [0.0; 3];
    // rust: self.game_time = time;
}
    // rust: for (axis, value) in [movement.x, movement.y, movement.z].into_iter().enumerate() {
    // rust: if value != 0.0 {
    // rust: let sum = value + self.deltas[axis];
                // Math.min in native Mth.clamp preserves NaN.
    // rust: let next = if sum < -0.51 {
    // rust: -0.51
    // rust: } else if sum.is_nan() {
    // rust: sum
    // rust: } else {
    // rust: sum.min(0.51)
}
    // rust: let change = next - self.deltas[axis];
    // rust: self.deltas[axis] = next;
    // rust: if change.abs() <= f64::from(1.0e-5f32) {
    // rust: return Ok(Vec3::new(0.0, 0.0, 0.0));
}
    // rust: let mut result = [0.0; 3];
    // rust: result[axis] = change;
    // rust: return Ok(Vec3::new(result[0], result[1], result[2]));
}
}
    // rust: Ok(Vec3::new(0.0, 0.0, 0.0))
}
}
