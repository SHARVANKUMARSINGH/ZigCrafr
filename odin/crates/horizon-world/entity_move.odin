//! Transpiled from Horizon Rust crate
package horizon_world_entity_move

import "core:fmt"
import "core:mem"
import "core:math"

// Entity.move ordering around collision, support, landing and movement effects.
// use crate::{movement_emission::MovementEmission, registry::BlockStateId};
// use horizon_core::{geometry::Vec3, position::BlockPos};
// use std::collections::VecDeque;

MoverType :: enum {
    SelfMovement,
    Player,
    Piston,
    ShulkerBox,
    Shulker,
}
CollisionFlags :: struct {
    horizontal: bool,
    vertical: bool,
    below: bool,
    minor: bool,
}
MovementRecord :: struct {
    from: Vec3,
    to: Vec3,
    original: Maybe(Vec3),
}
MovementHistory :: struct {
    records: VecDeque<MovementRecord>,
}
    // rust: impl MovementHistory {
records :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.records
}
add :: proc(self: ^Self, record: MovementRecord) {
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
clear :: proc(self: ^Self) {
}
    // rust: self.records.clear();
}
}
// The provider retains entity fields so callbacks can mutate them. Hooks below
// are native phase boundaries; bind collision, support, landing, restitution
// and emission hooks to their corresponding world modules.
    // rust: pub trait EntityMoveWorld {
    // rust: type Error;
no_physics :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
position :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
set_position :: proc(self: ^Self, position: Vec3) -> R {
    // Ported from Horizon
    return {}
}
record_movement :: proc(self: ^Self, mover: MoverType, movement: Vec3) -> R {
    // Ported from Horizon
    return {}
}
collision_flags :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
set_collision_flags :: proc(self: ^Self, flags: CollisionFlags) {
}
limit_piston_movement :: proc(self: ^Self, movement: Vec3) -> R {
    // Ported from Horizon
    return {}
}
stuck_multiplier :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
set_stuck_multiplier :: proc(self: ^Self, value: Vec3) {
}
velocity :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
set_velocity :: proc(self: ^Self, value: Vec3) -> R {
    // Ported from Horizon
    return {}
}
back_off_edge :: proc(self: ^Self, movement: Vec3, mover: MoverType) -> R {
    // Ported from Horizon
    return {}
}
collide :: proc(self: ^Self, movement: Vec3) -> R {
    // Ported from Horizon
    return {}
}
fall_distance :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // FALLDAMAGE_RESETTING blocks and WATER fluids, entity collision context.
    // Return true for a non-MISS hit.
fall_reset_clip :: proc(self: ^Self, from: Vec3, to: Vec3) -> R {
    // Ported from Horizon
    return {}
}
reset_fall_distance :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
movement_history :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
locally_authoritative :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fn set_on_ground_with_movement(
    // rust: &mut self,
    // rust: below: bool,
    // rust: horizontal: bool,
    // rust: movement: Vec3,
    // rust: ) -> Result<(), Self::Error>;
minor_horizontal_collision :: proc(self: ^Self, movement: Vec3) -> R {
    // Ported from Horizon
    return {}
}
legacy_on_position :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
block_state :: proc(self: ^Self, p: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
on_ground :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fn check_fall_damage(
    // rust: &mut self,
    // rust: dy: f64,
    // rust: on_ground: bool,
    // rust: state: BlockStateId,
    // rust: p: BlockPos,
    // rust: ) -> Result<(), Self::Error>;
removed :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
can_simulate :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fn restitute(
    // rust: &mut self,
    // rust: state: BlockStateId,
    // rust: collided_x: bool,
    // rust: collided_z: bool,
    // rust: resolved: Vec3,
    // rust: ) -> Result<(), Self::Error>;
client_side :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
movement_emission :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
passenger :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fn apply_movement_emission(
    // rust: &mut self,
    // rust: emission: MovementEmission,
    // rust: resolved: Vec3,
    // rust: p: BlockPos,
    // rust: state: BlockStateId,
    // rust: ) -> Result<(), Self::Error>;
block_speed_factor :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
}
java_zero :: proc(v: Vec3) -> b {
    // Ported from Horizon
    return {}
}
    // rust: v.x.to_bits() == 0 && v.y.to_bits() == 0 && v.z.to_bits() == 0
}
different :: proc(a: f64, b: f64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let delta = (b - a).abs();
    // rust: delta >= f64::from(1.0e-5f32) || delta.is_nan()
}
// Release behavior; native IDE-only invalid-simulation assertions and profiler
// callbacks do not form part of this gameplay transition.
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
// The last step of `Entity.move`: the horizontal velocity is multiplied by
// `getBlockSpeedFactor()` (soul sand, honey), the vertical one is untouched.
// Every kind of entity ends its move here, so the player and the mobs share
// this one definition.
scale_by_block_speed :: proc(velocity: Vec3, factor: f32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let factor = f64::from(factor);
    // rust: velocity.multiply(Vec3::new(factor, 1.0, factor))
}
