//! Transpiled from Horizon Rust crate
//! Module: horizon-world_movement_emission
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Movement distances, footsteps, swimming and flapping event dispatch.
// use horizon_core::{geometry::Vec3, position::BlockPos};

pub const MovementEmission = enum {
    None,
    Sounds,
    Events,
    All,
};
    // rust: impl MovementEmission {
pub fn sounds(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(self, Self::Sounds | Self::All)
}
pub fn events(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(self, Self::Events | Self::All)
}
pub fn anything(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self != Self::None
}
}
pub const MovementDistances = struct {
    movement: f32,
    flight: f32,
    next_step: f32,
};
    // rust: impl MovementDistances {
    /// Java narrows to int, adds with wrapping overflow, then widens to float.
pub fn next_step(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.movement as i32).wrapping_add(1) as f32
}
}
pub const MovementEvent = enum {
    Step,
    Swim,
    Flap,
};
    // rust: pub trait MovementEmissionWorld {
    // rust: type Error;
    // rust: type State: Copy;
pub fn distances(self: *Self) M;
pub fn set_movement_distance(self: *Self, value: f32) void;
pub fn set_flight_distance(self: *Self, value: f32) void;
pub fn set_next_step(self: *Self, value: f32) void;
pub fn on_position(self: *Self) R;
pub fn block_state(self: *Self, p: BlockPos) R;
pub fn is_air(self: *Self, s: Self::State) R;
pub fn climbable_tag(self: *Self, s: Self::State) R;
pub fn is_powder_snow(self: *Self, s: Self::State) R;
pub fn on_ground(self: *Self) R;
pub fn crouching(self: *Self) R;
pub fn on_rails(self: *Self) R;
pub fn swimming(self: *Self) R;
pub fn in_water(self: *Self) R;
pub fn walking_step_sound(self: *Self, p: BlockPos, s: Self::State) R;
    /// STEP uses current entity position and a context including this state.
pub fn step_event(self: *Self, s: Self::State) R;
pub fn next_step(self: *Self) R;
pub fn water_swim_sound(self: *Self) R;
pub fn entity_event(self: *Self, event: MovementEvent) R;
pub fn flapping(self: *Self) R;
pub fn on_flap(self: *Self) R;
pub fn movement_emission(self: *Self) R;
}
    // rust: fn climbable<W: MovementEmissionWorld>(world: &mut W, state: W::State) -> Result<bool, W::Error> {
    // rust: Ok(world.climbable_tag(state)? || world.is_powder_snow(state)?)
}
    // rust: pub fn block_movement_effects<W: MovementEmissionWorld>(
    // rust: world: &mut W,
    // rust: p: BlockPos,
    // rust: state: W::State,
    // rust: sounds: bool,
    // rust: events: bool,
    // rust: movement: Vec3,
    // rust: ) -> Result<bool, W::Error> {
    // rust: if world.is_air(state)? {
    // rust: return Ok(false);
}
    // rust: let climbable = climbable(world, state)?;
    // rust: if (world.on_ground()?
    // rust: || climbable
    // rust: || world.crouching()? && movement.y == 0.0
    // rust: || world.on_rails()?)
    // rust: && !world.swimming()?
    // rust: {
    // rust: if sounds {
    // rust: world.walking_step_sound(p, state)?;
}
    // rust: if events {
    // rust: world.step_event(state)?;
}
    // rust: Ok(true)
    // rust: } else {
    // rust: Ok(false)
}
}
    // rust: pub fn process_flapping_movement<W: MovementEmissionWorld>(world: &mut W) -> Result<(), W::Error> {
    // rust: if world.flapping()? {
    // rust: world.on_flap()?;
    // rust: if world.movement_emission()?.events() {
    // rust: world.entity_event(MovementEvent::Flap)?;
}
}
    // rust: Ok(())
}
/// The caller applies Entity.move's authority, emission and passenger guards.
/// Provider callbacks can change distance fields; subsequent reads see changes.
    // rust: pub fn apply_movement_emission<W: MovementEmissionWorld>(
    // rust: world: &mut W,
    // rust: emission: MovementEmission,
    // rust: movement: Vec3,
    // rust: legacy_position: BlockPos,
    // rust: legacy_state: W::State,
    // rust: ) -> Result<(), W::Error> {
    // rust: let full = (movement.length() * f64::from(0.6f32)) as f32;
    // rust: let horizontal =
    // rust: ((movement.x * movement.x + movement.z * movement.z).sqrt() * f64::from(0.6f32)) as f32;
    // rust: let p = world.on_position()?;
    // rust: let state = world.block_state(p)?;
    // rust: let climbable = climbable(world, state)?;
    // rust: world.set_movement_distance(
    // rust: world.distances().movement + if climbable { full } else { horizontal },
    // rust: );
    // rust: world.set_flight_distance(world.distances().flight + full);
    // rust: if world.distances().movement > world.distances().next_step && !world.is_air(state)? {
    // rust: let same = p == legacy_position;
        // The native legacy call uses `same` for events even for sound-only emission.
    // rust: let mut emitted = block_movement_effects(
    // rust: world,
    // rust: legacy_position,
    // rust: legacy_state,
    // rust: emission.sounds(),
    // rust: same,
    // rust: movement,
    // rust: )?;
    // rust: if !same {
    // rust: emitted |= block_movement_effects(world, p, state, false, emission.events(), movement)?;
}
    // rust: if emitted {
    // rust: let next = world.next_step()?;
    // rust: world.set_next_step(next);
    // rust: } else if world.in_water()? {
    // rust: let next = world.next_step()?;
    // rust: world.set_next_step(next);
    // rust: if emission.sounds() {
    // rust: world.water_swim_sound()?;
}
    // rust: if emission.events() {
    // rust: world.entity_event(MovementEvent::Swim)?;
}
}
    // rust: } else if world.is_air(state)? {
    // rust: process_flapping_movement(world)?;
}
    // rust: Ok(())
}
