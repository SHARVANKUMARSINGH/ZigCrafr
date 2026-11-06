//! Transpiled from Horizon Rust crate
//! Module: horizon-core_volume
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use crate::geometry::Axis;

pub const DensityError = enum {
    NonpositiveDimensions,
    NonpositiveSteps,
    VolumeTooLarge,
    BufferTooShort,
};
    // rust: impl std::fmt::Display for DensityError {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f.write_str(match self {
    // rust: Self::NonpositiveDimensions => "density dimensions must be positive",
    // rust: Self::NonpositiveSteps => "density coordinate steps must be positive",
    // rust: Self::VolumeTooLarge => "density volume exceeds the Java array index domain",
    // rust: Self::BufferTooShort => "density buffer is smaller than its volume",
    // rust: })
}
}
    // rust: impl std::error::Error for DensityError {}

/// A bounded strided density volume. The flat layout is Z, X, Y (Y innermost).
/// Block coordinate multiplication and addition retain Java's i32 wrapping.
pub const DensityVolume = struct {
    sizes: [usize,
    minimum: [i32,
    steps: [i32,
    size: usize,
};
    // rust: impl DensityVolume {
pub fn new(sizes: [i32; 3], minimum: [i32; 3], steps: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if sizes.iter().any(|v| *v <= 0) {
    // rust: return Err(DensityError::NonpositiveDimensions);
}
    // rust: if steps.iter().any(|v| *v <= 0) {
    // rust: return Err(DensityError::NonpositiveSteps);
}
    // rust: let sizes = sizes.map(|v| v as usize);
    // rust: let size = sizes
    // rust: .into_iter()
    // rust: .try_fold(1_usize, |n, v| n.checked_mul(v))
    // rust: .filter(|n| *n <= i32::MAX as usize)
    // rust: .ok_or(DensityError::VolumeTooLarge)?;
    // rust: Ok(Self {
    // rust: sizes,
    // rust: minimum,
    // rust: steps,
    // rust: size,
    // rust: })
}
pub fn sizes(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sizes
}
pub fn minimum(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.minimum
}
pub fn steps(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.steps
}
pub fn size(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.size
}
pub fn maximum(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::array::from_fn(|axis| self.coordinate(axis, self.sizes[axis]).wrapping_sub(1))
}
pub fn index(self: *Self, position: [usize; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if (0..3).any(|i| position[i] >= self.sizes[i]) {
    // rust: return None;
}
    // rust: Some(position[1] + (position[0] + position[2] * self.sizes[0]) * self.sizes[1])
}
pub fn block(self: *Self, axis: Axis, index: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let axis = axis as usize;
    // rust: (index < self.sizes[axis]).then(|| self.coordinate(axis, index))
}
    /// Find an exact lattice sample, retaining Java's wrapped subtraction and
    /// extent multiplication. Coordinates between samples are cache misses.
pub fn index_of_block(self: *Self, position: [i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let relative: [i32; 3] = std::array::from_fn(|i| position[i].wrapping_sub(self.minimum[i]));
    // rust: for (axis, value) in relative.iter().enumerate() {
    // rust: let extent = (self.sizes[axis] as i32).wrapping_mul(self.steps[axis]);
    // rust: if *value < 0 || *value >= extent || *value % self.steps[axis] != 0 {
    // rust: return None;
}
}
    // rust: self.index(std::array::from_fn(|i| {
    // rust: (relative[i] / self.steps[i]) as usize
    // rust: }))
}
    // rust: pub(super) fn coordinate(self, axis: usize, index: usize) -> i32 {
    // rust: self.minimum[axis].wrapping_add((index as i32).wrapping_mul(self.steps[axis]))
}
}
