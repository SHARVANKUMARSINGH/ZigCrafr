//! Transpiled from Horizon Rust crate
//! Module: horizon-world_living_air
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! LivingEntity walking, climbing and airborne velocity integration.
// use horizon_core::{
    // rust: geometry::{Vec3, trig},
    // rust: position::BlockPos,
}

    // rust: pub trait LivingAirWorld {
    // rust: type Error;
pub fn movement_support_position(self: *Self) R;
pub fn on_ground(self: *Self) R;
pub fn block_friction(self: *Self, position: BlockPos) R;
pub fn friction_modifier(self: *Self) R;
pub fn speed(self: *Self) R;
    /// Includes entity-type overrides (notably Player).
pub fn flying_speed(self: *Self) R;
pub fn yaw(self: *Self) R;
pub fn velocity(self: *Self) V;
pub fn set_velocity(self: *Self, velocity: Vec3) R;
pub fn on_climbable(self: *Self) R;
pub fn reset_fall_distance(self: *Self) R;
pub fn in_scaffolding(self: *Self) R;
pub fn suppressing_ladder_slide(self: *Self) R;
pub fn is_player_class(self: *Self) b;
    /// Bind to Entity.move(SELF, movement), including collision and landing.
pub fn move_self(self: *Self, movement: Vec3) R;
pub fn horizontal_collision(self: *Self) b;
pub fn jumping(self: *Self) b;
pub fn was_in_powder_snow(self: *Self) b;
pub fn can_walk_powder_snow(self: *Self) R;
pub fn levitation_amplifier(self: *Self) R;
pub fn is_client_side(self: *Self) R;
pub fn has_chunk_at(self: *Self, position: BlockPos) R;
pub fn effective_gravity(self: *Self) R;
pub fn y(self: *Self) f;
pub fn minimum_y(self: *Self) R;
pub fn discard_friction(self: *Self) R;
pub fn air_drag_modifier(self: *Self) R;
pub fn omnidirectional_air_mover(self: *Self) R;
}

pub fn modified_friction(friction: f32, modifier: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (1.0 - (1.0 - friction) * modifier).clamp(0.0, 1.0)
}
/// Entity.getInputVector: normalize only above unit length, then rotate using
/// the native float-angle sine table. Tiny input returns canonical positive zero.
pub fn input_vector(input: Vec3, speed: f32, yaw: f32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let length = input.length_squared();
    // rust: if length < 1.0e-7 {
    // rust: return Vec3::ZERO;
}
    // rust: let input = if length > 1.0 {
    // rust: input.normalize()
    // rust: } else {
    // rust: input
}
    // rust: let input = input.scale(f64::from(speed));
    // rust: let angle = f64::from(yaw * trig::DEG_TO_RAD);
    // rust: let sin = f64::from(trig::sin(angle));
    // rust: let cos = f64::from(trig::cos(angle));
    // rust: Vec3::new(
    // rust: input.x * cos - input.z * sin,
    // rust: input.y,
    // rust: input.z * cos + input.x * sin,
    // rust: )
}
    // rust: pub fn move_relative<W: LivingAirWorld>(
    // rust: world: &mut W,
    // rust: input: Vec3,
    // rust: speed: f32,
    // rust: ) -> Result<(), W::Error> {
    // rust: let input = input_vector(input, speed, world.yaw()?);
    // rust: let old = world.velocity();
    // rust: world.set_velocity(Vec3::new(old.x + input.x, old.y + input.y, old.z + input.z))
}
    // rust: pub fn handle_on_climbable<W: LivingAirWorld>(
    // rust: world: &mut W,
    // rust: mut velocity: Vec3,
    // rust: ) -> Result<Vec3, W::Error> {
    // rust: if world.on_climbable()? {
    // rust: world.reset_fall_distance()?;
    // rust: let limit = f64::from(0.15f32);
    // rust: velocity.x = velocity.x.clamp(-limit, limit);
    // rust: velocity.z = velocity.z.clamp(-limit, limit);
        // Math.max must propagate NaN.
    // rust: if !velocity.y.is_nan() {
    // rust: velocity.y = velocity.y.max(-limit);
}
    // rust: if velocity.y < 0.0
    // rust: && !world.in_scaffolding()?
    // rust: && world.suppressing_ladder_slide()?
    // rust: && world.is_player_class()
    // rust: {
    // rust: velocity.y = 0.0;
}
}
    // rust: Ok(velocity)
}
    // rust: pub fn friction_influenced_speed<W: LivingAirWorld>(
    // rust: world: &mut W,
    // rust: friction: f32,
    // rust: ) -> Result<f32, W::Error> {
    // rust: if world.on_ground()? {
    // rust: let speed = world.speed()?;
    // rust: if f64::from(friction) > 0.6 {
    // rust: Ok(speed * (0.21600002f32 / (friction * friction * friction)))
    // rust: } else {
    // rust: Ok(speed)
}
    // rust: } else {
    // rust: world.flying_speed()
}
}
    // rust: pub fn relative_friction_movement<W: LivingAirWorld>(
    // rust: world: &mut W,
    // rust: input: Vec3,
    // rust: friction: f32,
    // rust: ) -> Result<Vec3, W::Error> {
    // rust: let speed = friction_influenced_speed(world, friction)?;
    // rust: move_relative(world, input, speed)?;
    // rust: let velocity = handle_on_climbable(world, world.velocity())?;
    // rust: world.set_velocity(velocity)?;
    // rust: world.move_self(world.velocity())?;
    // rust: let mut velocity = world.velocity();
    // rust: if (world.horizontal_collision() || world.jumping())
    // rust: && (world.on_climbable()?
    // rust: || (world.was_in_powder_snow() && world.can_walk_powder_snow()?))
    // rust: {
    // rust: velocity.y = 0.2;
}
    // rust: Ok(velocity)
}
/// Ground friction is captured before movement; drag and gravity are queried
/// afterwards. This distinction preserves movement callbacks' field changes.
    // rust: pub fn travel_in_air<W: LivingAirWorld>(world: &mut W, input: Vec3) -> Result<(), W::Error> {
    // rust: let support = world.movement_support_position()?;
    // rust: let friction = if world.on_ground()? {
    // rust: let friction = world.block_friction(support)?;
    // rust: modified_friction(friction, world.friction_modifier()? as f32)
    // rust: } else {
    // rust: 1.0
}
    // rust: let mut velocity = relative_friction_movement(world, input, friction)?;
    // rust: if let Some(amplifier) = world.levitation_amplifier()? {
    // rust: velocity.y += (0.05 * f64::from(amplifier.wrapping_add(1)) - velocity.y) * 0.2;
    // rust: } else if !world.is_client_side()? || world.has_chunk_at(support)? {
    // rust: velocity.y -= world.effective_gravity()?;
    // rust: } else {
    // rust: let y = world.y();
    // rust: velocity.y = if y > f64::from(world.minimum_y()?) {
    // rust: -0.1
    // rust: } else {
    // rust: 0.0
}
}
    // rust: if !world.discard_friction()? {
    // rust: let modifier = world.air_drag_modifier()? as f32;
    // rust: let drag = modified_friction(0.91, modifier);
    // rust: let horizontal = friction * drag;
    // rust: let vertical = if world.omnidirectional_air_mover()? {
    // rust: drag
    // rust: } else {
    // rust: modified_friction(0.98, modifier)
}
    // rust: velocity = Vec3::new(
    // rust: velocity.x * f64::from(horizontal),
    // rust: velocity.y * f64::from(vertical),
    // rust: velocity.z * f64::from(horizontal),
    // rust: );
}
    // rust: world.set_velocity(velocity)
}
