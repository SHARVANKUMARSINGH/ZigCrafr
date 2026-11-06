//! Transpiled from Horizon Rust crate
//! Module: horizon-world_aquifer
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Global fluid selection and the 26.3 aquifer terrain paths.
    // rust: mod config;
    // rust: mod noise_based;
// use crate::registry::BlockStateId;
    // rust: pub use config::{AquiferConfig, AquiferField, AquiferSamplers};
    // rust: pub use noise_based::{
    // rust: AquiferBlockStates, AquiferError, NoiseBasedAquifer, RegistryAquiferBlockStates,
}

pub const FluidStatus = struct {
    level: i32,
    state: BlockStateId,
};
    // rust: impl FluidStatus {
    // rust: pub const fn at(self, y: i32, air: BlockStateId) -> BlockStateId {
    // rust: if y < self.level { self.state } else { air }
}
}
    // rust: pub trait FluidPicker: std::fmt::Debug + Send + Sync {
pub fn compute(self: *Self, position: [i32; 3]) F;
}
    // rust: impl<P: FluidPicker + ?Sized> FluidPicker for &P {
pub fn compute(self: *Self, position: [i32; 3]) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: P::compute(self, position)
}
}
/// State IDs must come from one immutable block registry. Default fluid can be
/// any registered block state; vanilla does not validate its material here.
pub const GlobalFluidPicker = struct {
    sea_level: i32,
    default_fluid: BlockStateId,
    lava: BlockStateId,
    air: BlockStateId,
    disabled: bool,
};
    // rust: impl GlobalFluidPicker {
    // rust: pub const fn new(
    // rust: sea_level: i32,
    // rust: default_fluid: BlockStateId,
    // rust: lava: BlockStateId,
    // rust: air: BlockStateId,
    // rust: ) -> Self {
    // rust: Self {
    // rust: sea_level,
    // rust: default_fluid,
    // rust: lava,
    // rust: air,
    // rust: disabled: false,
}
}
}
    // rust: impl FluidPicker for GlobalFluidPicker {
pub fn compute(self: *Self, _]: [i32; 3]) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.disabled {
    // rust: FluidStatus {
    // rust: level: -4064,
    // rust: state: self.air,
}
    // rust: } else if y < (-54).min(self.sea_level) {
    // rust: FluidStatus {
    // rust: level: -54,
    // rust: state: self.lava,
}
    // rust: } else {
    // rust: FluidStatus {
    // rust: level: self.sea_level,
    // rust: state: self.default_fluid,
}
}
}
}
pub const DisabledAquifer = struct {
    picker: P,
    air: BlockStateId,
};
    // rust: impl<P: FluidPicker> DisabledAquifer<P> {
    // rust: pub const fn new(picker: P, air: BlockStateId) -> Self {
    // rust: Self { picker, air }
}
    /// None selects the generator's default solid block. Java DCMPL treats NaN
    /// as -1, so NaN and density <= zero call the picker; density > zero does not.
pub fn compute_substance(self: *Self, position: [i32; 3], density: f64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if density > 0. {
    // rust: None
    // rust: } else {
    // rust: Some(self.picker.compute(position).at(position[1], self.air))
}
}
    // rust: pub const fn should_schedule_fluid_update(&self) -> bool {
    // rust: false
}
}
