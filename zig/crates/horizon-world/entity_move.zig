//! Transpiled from Horizon Rust crate
//! Module: horizon-world_entity_move
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Entity.move ordering around collision, support, landing and movement effects.
// use crate::{movement_emission::MovementEmission, registry::BlockStateId};
// use horizon_core::{geometry::Vec3, position::BlockPos};
// use std::collections::VecDeque;

pub const MoverType = enum {
    SelfMovement,
    Player,
    Piston,
    ShulkerBox,
    Shulker,
};
pub const CollisionFlags = struct {
    horizontal: bool,
    vertical: bool,
    below: bool,
    minor: bool,
};
pub const MovementRecord = struct {
    from: Vec3,
    to: Vec3,
    original: ?Vec3,
};
pub const MovementHistory = struct {
    records: VecDeque<MovementRecord>,
};
    // rust: impl MovementHistory {
pub fn records(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.records
}
pub fn add(self: *Self, record: MovementRecord) void {
}
    // rust: if self.records.len() >= 100 {
    // rust: let first = self.records.pop_front().unwrap();
    // rust: let second = self.records.pop_front().unwrap();
    // rust: self.records.push_front(MovementRecord {
    // rust: from: first.from,
    // rust: to: second.to,
    // rust: original: None,
    // rust: });
}
    // rust: self.records.push_back(record);
}
pub fn clear(self: *Self) void {
}
    // rust: self.records.clear();
}
}
/// The provider retains entity fields so callbacks can mutate them. Hooks below
/// are native phase boundaries; bind collision, support, landing, restitution
/// and emission hooks to their corresponding world modules.
    // rust: pub trait EntityMoveWorld {
    // rust: type Error;
pub fn no_physics(self: *Self) b;
pub fn position(self: *Self) V;
pub fn set_position(self: *Self, position: Vec3) R;
pub fn record_movement(self: *Self, mover: MoverType, movement: Vec3) R;
pub fn collision_flags(self: *Self) C;
pub fn set_collision_flags(self: *Self, flags: CollisionFlags) void;
pub fn limit_piston_movement(self: *Self, movement: Vec3) R;
pub fn stuck_multiplier(self: *Self) V;
pub fn set_stuck_multiplier(self: *Self, value: Vec3) void;
pub fn velocity(self: *Self) R;
pub fn set_velocity(self: *Self, value: Vec3) R;
pub fn back_off_edge(self: *Self, movement: Vec3, mover: MoverType) R;
pub fn collide(self: *Self, movement: Vec3) R;
pub fn fall_distance(self: *Self) f;
    /// FALLDAMAGE_RESETTING blocks and WATER fluids, entity collision context.
    /// Return true for a non-MISS hit.
pub fn fall_reset_clip(self: *Self, from: Vec3, to: Vec3) R;
pub fn reset_fall_distance(self: *Self) R;
pub fn movement_history(self: *Self) *;
pub fn locally_authoritative(self: *Self) R;
    // rust: fn set_on_ground_with_movement(
    // rust: &mut self,
    // rust: below: bool,
    // rust: horizontal: bool,
    // rust: movement: Vec3,
    // rust: ) -> Result<(), Self::Error>;
pub fn minor_horizontal_collision(self: *Self, movement: Vec3) R;
pub fn legacy_on_position(self: *Self) R;
pub fn block_state(self: *Self, p: BlockPos) R;
pub fn on_ground(self: *Self) R;
    // rust: fn check_fall_damage(
    // rust: &mut self,
    // rust: dy: f64,
    // rust: on_ground: bool,
    // rust: state: BlockStateId,
    // rust: p: BlockPos,
    // rust: ) -> Result<(), Self::Error>;
pub fn removed(self: *Self) R;
pub fn can_simulate(self: *Self) R;
    // rust: fn restitute(
    // rust: &mut self,
    // rust: state: BlockStateId,
    // rust: collided_x: bool,
    // rust: collided_z: bool,
    // rust: resolved: Vec3,
    // rust: ) -> Result<(), Self::Error>;
pub fn client_side(self: *Self) R;
pub fn movement_emission(self: *Self) R;
pub fn passenger(self: *Self) R;
    // rust: fn apply_movement_emission(
    // rust: &mut self,
    // rust: emission: MovementEmission,
    // rust: resolved: Vec3,
    // rust: p: BlockPos,
    // rust: state: BlockStateId,
    // rust: ) -> Result<(), Self::Error>;
pub fn block_speed_factor(self: *Self) R;
}
pub fn java_zero(v: Vec3) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: v.x.to_bits() == 0 && v.y.to_bits() == 0 && v.z.to_bits() == 0
}
pub fn different(a: f64, b: f64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let delta = (b - a).abs();
    // rust: delta >= f64::from(1.0e-5f32) || delta.is_nan()
}
/// Release behavior; native IDE-only invalid-simulation assertions and profiler
/// callbacks do not form part of this gameplay transition.
    // rust: pub fn move_entity<W: EntityMoveWorld>(
    // rust: world: &mut W,
    // rust: mover: MoverType,
    // rust: mut movement: Vec3,
    // rust: ) -> Result<(), W::Error> {
    // rust: if world.no_physics() {
    // rust: world.set_position(world.position().add_vector(movement))?;
    // rust: world.record_movement(mover, movement)?;
    // rust: world.set_collision_flags(CollisionFlags::default());
    // rust: return Ok(());
}
    // rust: if mover == MoverType::Piston {
    // rust: movement = world.limit_piston_movement(movement)?;
    // rust: if java_zero(movement) {
    // rust: return Ok(());
}
}
    // rust: let stuck = world.stuck_multiplier();
    // rust: if stuck.length_squared() > 1.0e-7 {
    // rust: if mover != MoverType::Piston {
    // rust: movement = movement.multiply(stuck);
}
    // rust: world.set_stuck_multiplier(Vec3::ZERO);
    // rust: world.set_velocity(Vec3::ZERO)?;
}
    // rust: movement = world.back_off_edge(movement, mover)?;
    // rust: let resolved = world.collide(movement)?;
    // rust: let length = resolved.length_squared();
    // rust: if length > 1.0e-7 || movement.length_squared() - length < 1.0e-7 {
    // rust: if world.fall_distance() != 0.0 && length >= 1.0 {
    // rust: let distance = resolved.length().min(8.0);
    // rust: let from = world.position();
    // rust: let to = from.add_vector(resolved.normalize().scale(distance));
    // rust: if world.fall_reset_clip(from, to)? {
    // rust: world.reset_fall_distance()?;
}
}
    // rust: let from = world.position();
    // rust: let to = from.add_vector(resolved);
    // rust: world.movement_history().add(MovementRecord {
    // rust: from,
    // rust: to,
    // rust: original: Some(movement),
    // rust: });
    // rust: world.set_position(to)?;
    // rust: world.record_movement(mover, resolved)?;
}
    // rust: let x = different(movement.x, resolved.x);
    // rust: let z = different(movement.z, resolved.z);
    // rust: let mut flags = world.collision_flags();
    // rust: flags.horizontal = x || z;
    // rust: world.set_collision_flags(flags);
    // rust: let nonzero_y = movement.y.abs() > 0.0;
    // rust: if nonzero_y || world.locally_authoritative()? {
    // rust: flags = world.collision_flags();
    // rust: flags.vertical = movement.y != resolved.y;
    // rust: flags.below = flags.vertical && movement.y < 0.0;
    // rust: world.set_collision_flags(flags);
    // rust: world.set_on_ground_with_movement(flags.below, flags.horizontal, resolved)?;
}
    // rust: let minor = if world.collision_flags().horizontal {
    // rust: world.minor_horizontal_collision(resolved)?
    // rust: } else {
    // rust: false
}
    // rust: flags = world.collision_flags();
    // rust: flags.minor = minor;
    // rust: world.set_collision_flags(flags);
    // rust: let p = world.legacy_on_position()?;
    // rust: let state = world.block_state(p)?;
    // rust: if world.locally_authoritative()? {
    // rust: let grounded = world.on_ground()?;
    // rust: world.check_fall_damage(resolved.y, grounded, state, p)?;
}
    // rust: if world.removed()? {
    // rust: return Ok(());
}
    // rust: if world.can_simulate()?
    // rust: && (nonzero_y && world.collision_flags().vertical || world.collision_flags().horizontal)
    // rust: {
    // rust: world.restitute(state, x, z, resolved)?;
}
    // rust: if !world.client_side()? || world.locally_authoritative()? {
    // rust: let emission = world.movement_emission()?;
    // rust: if emission.anything() && !world.passenger()? {
    // rust: world.apply_movement_emission(emission, resolved, p, state)?;
}
}
    // rust: let factor = world.block_speed_factor()?;
    // rust: let velocity = scale_by_block_speed(world.velocity()?, factor);
    // rust: world.set_velocity(velocity)
}
/// The last step of `Entity.move`: the horizontal velocity is multiplied by
/// `getBlockSpeedFactor()` (soul sand, honey), the vertical one is untouched.
/// Every kind of entity ends its move here, so the player and the mobs share
/// this one definition.
pub fn scale_by_block_speed(velocity: Vec3, factor: f32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let factor = f64::from(factor);
    // rust: velocity.multiply(Vec3::new(factor, 1.0, factor))
}
