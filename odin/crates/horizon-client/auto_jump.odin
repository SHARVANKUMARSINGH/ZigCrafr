//! Transpiled from Horizon Rust crate
package horizon_client_auto_jump

import "core:fmt"
import "core:mem"
import "core:math"

// Auto-jump (`LocalPlayer.updateAutoJump` and `canAutoJump`): after the
// local player's own move, look ahead along the movement for a step that
// the player can clear with a jump and is not walled in above; if found, the
// next `aiStep` presses jump for one tick (`autoJumpTime = 1`).
// use horizon_core::{
    // rust: geometry::{Aabb, Axis, Vec3, VoxelShape, trig},
    // rust: position::BlockPos,
}

// `Float.MIN_VALUE`, the "no obstacle" marker.
NO_OBSTACLE :: f32::from_bits(1)

// What `updateAutoJump` reads from the player.
AutoJumper :: struct {
    position: Vec3,
    // `getBoundingBox().maxY`.
    max_y: f64,
    x_rot: f32,
    y_rot: f32,
    // `getSpeed()`.
    speed: f32,
    // `input.getMoveVector()` (x: strafe, y: forward).
    move_vector: [f32,
    // `getBbWidth()`, `getBbHeight()`.
    width: f32,
    height: f32,
    // The jump boost amplifier, when the effect is active.
    jump_boost: Maybe(i32),
}

// The level queries, with the player's collision context.
    // rust: pub trait AutoJumpWorld {
    // rust: type Error;
    // `getBlockState(p).getCollisionShape(level, p, CollisionContext.of(player))`.
collision_shape :: proc(self: ^Self, p: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // `level.getCollisions(player, bounds)` flattened with `toAabbs`, in order.
collision_boxes :: proc(self: ^Self, bounds: Aabb) -> R {
    // Ported from Horizon
    return {}
}
}

// `LocalPlayer.canAutoJump`. `staying_on_surface` is
// `isStayingOnGroundSurface()` (the shift key).
    // rust: pub fn can_auto_jump(
    // rust: enabled: bool,
    // rust: auto_jump_time: i32,
    // rust: on_ground: bool,
    // rust: staying_on_surface: bool,
    // rust: passenger: bool,
    // rust: move_vector: [f32; 2],
    // rust: block_jump_factor: f32,
    // rust: ) -> bool {
    // rust: enabled
    // rust: && auto_jump_time <= 0
    // rust: && on_ground
    // rust: && !staying_on_surface
    // rust: && !passenger
    // rust: && move_vector[0] * move_vector[0] + move_vector[1] * move_vector[1] > 0.0
    // rust: && f64::from(block_jump_factor) >= 1.0
}

// `Vec3.directionFromRotation(rotX, rotY)`.
direction_from_rotation :: proc(rot_x: f32, rot_y: f32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let rad = trig::DEG_TO_RAD;
    // rust: let pi = std::f32::consts::PI;
    // rust: let y_cos = trig::cos(f64::from(-rot_y * rad - pi));
    // rust: let y_sin = trig::sin(f64::from(-rot_y * rad - pi));
    // rust: let x_cos = -trig::cos(f64::from(-rot_x * rad));
    // rust: let x_sin = trig::sin(f64::from(-rot_x * rad));
    // rust: Vec3::new(
    // rust: f64::from(y_sin * x_cos),
    // rust: f64::from(x_sin),
    // rust: f64::from(y_cos * x_cos),
    // rust: )
}

// `AABB.intersects(Vec3, Vec3)`: the box overlaps the segment's bounds.
intersects_segment :: proc(b: Aabb, from: Vec3, to: Vec3) -> b {
    // Ported from Horizon
    return {}
}
    // rust: b.intersects(Aabb::new(from, to))
}

// `LocalPlayer.updateAutoJump(xa, za)` once `canAutoJump` holds: whether
// it sets `autoJumpTime = 1`. `xa`/`za` are the float horizontal
// displacement of the move.
    // rust: pub fn update_auto_jump<W: AutoJumpWorld>(
    // rust: world: &mut W,
    // rust: p: &AutoJumper,
    // rust: xa: f32,
    // rust: za: f32,
    // rust: ) -> Result<bool, W::Error> {
    // rust: let move_begin = p.position;
    // rust: let move_end = move_begin.add_vector(Vec3::new(f64::from(xa), 0.0, f64::from(za)));
    // rust: let mut move_diff = Vec3::new(f64::from(xa), 0.0, f64::from(za));
    // rust: let current_speed = p.speed;
    // rust: let mut move_dist_sq = move_diff.length_squared() as f32;
    // rust: if move_dist_sq <= 0.001 {
    // rust: let input_xa = current_speed * p.move_vector[0];
    // rust: let input_za = current_speed * p.move_vector[1];
    // rust: let sin = trig::sin(f64::from(p.y_rot * trig::DEG_TO_RAD));
    // rust: let cos = trig::cos(f64::from(p.y_rot * trig::DEG_TO_RAD));
    // rust: move_diff = Vec3::new(
    // rust: f64::from(input_xa * cos - input_za * sin),
    // rust: move_diff.y,
    // rust: f64::from(input_za * cos + input_xa * sin),
    // rust: );
    // rust: move_dist_sq = move_diff.length_squared() as f32;
    // rust: if move_dist_sq <= 0.001 {
    // rust: return Ok(false);
}
}
    // Mth.invSqrt: 1.0F / (float) Math.sqrt(x).
    // rust: let inverted = 1.0 / move_dist_sq.sqrt();
    // rust: let move_dir = move_diff.scale(f64::from(inverted));
    // rust: let facing = direction_from_rotation(p.x_rot, p.y_rot);
    // rust: let facing_vs_moving = (facing.x * move_dir.x + facing.z * move_dir.z) as f32;
    // rust: if facing_vs_moving < -0.15 {
    // rust: return Ok(false);
}
    // rust: let mut ceiling = BlockPos::containing(Vec3::new(move_begin.x, p.max_y, move_begin.z));
    // rust: if !world.collision_shape(ceiling)?.is_empty() {
    // rust: return Ok(false);
}
    // rust: ceiling = ceiling.offset(0, 1, 0);
    // rust: if !world.collision_shape(ceiling)?.is_empty() {
    // rust: return Ok(false);
}
    // rust: let mut jump_height = 1.2f32;
    // rust: if let Some(amplifier) = p.jump_boost {
    // rust: jump_height += (amplifier + 1) as f32 * 0.75;
}
    // rust: let look_ahead = crate::camera::java_max(current_speed * 7.0, 1.0 / inverted);
    // rust: let seg_begin = move_begin;
    // rust: let seg_end = move_end.add_vector(move_dir.scale(f64::from(look_ahead)));
    // rust: let (width, height) = (p.width, p.height);
    // rust: let test_box = Aabb::new(
    // rust: seg_begin,
    // rust: seg_end.add_vector(Vec3::new(0.0, f64::from(height), 0.0)),
    // rust: )
    // rust: .inflate(Vec3::new(f64::from(width), 0.0, f64::from(width)));
    // rust: let lift = Vec3::new(0.0, f64::from(0.51f32), 0.0);
    // rust: let seg_begin = seg_begin.add_vector(lift);
    // rust: let seg_end = seg_end.add_vector(lift);
    // rust: let right_dir = move_dir.cross(Vec3::new(0.0, 1.0, 0.0));
    // rust: let right_offset = right_dir.scale(f64::from(width * 0.5));
    // rust: let left_begin = seg_begin.subtract(right_offset);
    // rust: let left_end = seg_end.subtract(right_offset);
    // rust: let right_begin = seg_begin.add_vector(right_offset);
    // rust: let right_end = seg_end.add_vector(right_offset);
    // rust: let mut obstacle = NO_OBSTACLE;
    // rust: for b in world.collision_boxes(test_box)? {
    // rust: if intersects_segment(b, left_begin, left_end)
    // rust: || intersects_segment(b, right_begin, right_end)
    // rust: {
    // rust: obstacle = b.max_position().y as f32;
    // rust: let obstacle_pos = BlockPos::containing(b.center());
    // rust: let mut steps = 1i32;
    // rust: while (steps as f32) < jump_height {
    // rust: let above = obstacle_pos.offset(0, steps, 0);
    // rust: let shape = world.collision_shape(above)?;
    // rust: if !shape.is_empty() {
    // rust: obstacle = shape.max(Axis::Y) as f32 + above.y as f32;
    // rust: if f64::from(obstacle) - p.position.y > f64::from(jump_height) {
    // rust: return Ok(false);
}
}
    // rust: if steps > 1 {
    // rust: ceiling = ceiling.offset(0, 1, 0);
    // rust: if !world.collision_shape(ceiling)?.is_empty() {
    // rust: return Ok(false);
}
}
    // rust: steps += 1;
}
    // rust: break;
}
}
    // rust: if obstacle != NO_OBSTACLE {
    // rust: let y_delta = (f64::from(obstacle) - p.position.y) as f32;
        // Negated as in LocalPlayer.updateAutoJump, so a NaN delta still jumps.
    // rust: let jumps = !(y_delta <= 0.5) && !(y_delta > jump_height);
    // rust: if jumps {
    // rust: return Ok(true);
}
}
    // rust: Ok(false)
}

    // rust: mod tests {
//     use super::*;
Step :: struct {
    // rust: impl AutoJumpWorld for Step {
    // rust: type Error = ();
collision_shape :: proc(self: ^Self, p: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(if p.x == 1 && p.y == 0 {
    VoxelShape: :block(),
    // rust: } else {
    VoxelShape: :empty(),
    // rust: })
}
collision_boxes :: proc(self: ^Self, bounds: Aabb) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let b = Aabb::new(Vec3::new(1.0, 0.0, -5.0), Vec3::new(2.0, 1.0, 5.0));
    // rust: Ok(if b.intersects(bounds) {
    // rust: vec![b]
    // rust: } else {
    // rust: Vec::new()
    // rust: })
}
}
walking_into_a_one_block_step_jumps :: proc() {
}
    // rust: let p = AutoJumper {
    // rust: position: Vec3::new(0.6, 0.0, 0.5),
    // rust: max_y: 1.8,
    // rust: x_rot: 0.0,
    // rust: y_rot: -90.0,
    // rust: speed: 0.1,
    // rust: move_vector: [0.0, 1.0],
    // rust: width: 0.6,
    // rust: height: 1.8,
    // rust: jump_boost: None,
}
    // rust: assert!(update_auto_jump(&mut Step, &p, 0.1, 0.0).unwrap());
        // Moving away from the step does not.
    // rust: assert!(!update_auto_jump(&mut Step, &p, -0.1, 0.0).unwrap());
}
sneaking_or_standing_still_cannot_auto_jump :: proc() {
}
    // rust: assert!(can_auto_jump(true, 0, true, false, false, [0.0, 1.0], 1.0));
    // rust: assert!(!can_auto_jump(true, 0, true, true, false, [0.0, 1.0], 1.0));
    // rust: assert!(!can_auto_jump(true, 0, true, false, false, [0.0, 0.0], 1.0));
    // rust: assert!(!can_auto_jump(true, 0, true, false, false, [0.0, 1.0], 0.5));
}
}
