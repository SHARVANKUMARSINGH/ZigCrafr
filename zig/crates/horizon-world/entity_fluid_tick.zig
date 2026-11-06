//! Transpiled from Horizon Rust crate
//! Module: horizon-world_entity_fluid_tick
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Entity water-entry effects and current forces around immersion updates.
// use crate::entity_fluid::{
    // rust: CurrentTarget, EntityFluidInteraction, FluidInteractionError, FluidInteractionWorld, FluidTagId,
}
    // rust: type WorldError<W> = <W as FluidInteractionWorld>::Error;
    // rust: pub trait EntityFluidTickWorld:
    // rust: FluidInteractionWorld + CurrentTarget<Error = WorldError<Self>>
    // rust: {
pub fn is_pushed_by_fluid(self: *Self) R;
pub fn reset_fall_distance(self: *Self) R;
pub fn was_touching_water(self: *Self) b;
pub fn first_tick(self: *Self) b;
pub fn water_splash(self: *Self) R;
pub fn set_was_touching_water(self: *Self, value: bool) void;
pub fn fast_lava(self: *Self) R;
}
/// The push predicate is queried twice: before resetting immersion state and
/// after water-entry effects. Water/lava membership is captured before effects.
    // rust: pub fn update<W: EntityFluidTickWorld>(
    // rust: interaction: &mut EntityFluidInteraction,
    // rust: world: &mut W,
    // rust: water: FluidTagId,
    // rust: lava: FluidTagId,
    // rust: budget: usize,
    // rust: ) -> Result<bool, FluidInteractionError<WorldError<W>>> {
    // rust: let ignore = !world
    // rust: .is_pushed_by_fluid()
    // rust: .map_err(FluidInteractionError::World)?;
    // rust: let changed = interaction.update(world, ignore, budget)?;
    // rust: let in_water = interaction.is_in_fluid(world, water);
    // rust: let in_lava = interaction.is_in_fluid(world, lava);
    // rust: if in_water {
    // rust: world
    // rust: .reset_fall_distance()
    // rust: .map_err(FluidInteractionError::World)?;
    // rust: if !world.was_touching_water() && !world.first_tick() {
    // rust: world.water_splash().map_err(FluidInteractionError::World)?;
}
}
    // rust: world.set_was_touching_water(in_water);
    // rust: if world
    // rust: .is_pushed_by_fluid()
    // rust: .map_err(FluidInteractionError::World)?
    // rust: {
    // rust: if in_water {
    // rust: interaction
    // rust: .apply_current(world, water, 0.014)
    // rust: .map_err(FluidInteractionError::World)?;
}
    // rust: if in_lava {
    // rust: let speed = if world.fast_lava().map_err(FluidInteractionError::World)? {
    // rust: 0.007
    // rust: } else {
    // rust: 0.0023333333333333335
}
    // rust: interaction
    // rust: .apply_current(world, lava, speed)
    // rust: .map_err(FluidInteractionError::World)?;
}
}
    // rust: Ok(changed)
}
