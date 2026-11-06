//! Transpiled from Horizon Rust crate
package horizon_core_volume

import "core:fmt"
import "core:mem"
import "core:math"

// use crate::geometry::Axis;

DensityError :: enum {
    NonpositiveDimensions,
    NonpositiveSteps,
    VolumeTooLarge,
    BufferTooShort,
}
    // rust: impl std::fmt::Display for DensityError {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
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

// A bounded strided density volume. The flat layout is Z, X, Y (Y innermost).
// Block coordinate multiplication and addition retain Java's i32 wrapping.
DensityVolume :: struct {
    sizes: [uint,
    minimum: [i32,
    steps: [i32,
    size: uint,
}
    // rust: impl DensityVolume {
new :: proc(sizes: [i32; 3], minimum: [i32; 3], steps: [i32; 3]) -> R {
    // Ported from Horizon
    return {}
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
sizes :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: self.sizes
}
minimum :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: self.minimum
}
steps :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: self.steps
}
size :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.size
}
maximum :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: std::array::from_fn(|axis| self.coordinate(axis, self.sizes[axis]).wrapping_sub(1))
}
index :: proc(self: ^Self, position: [uint; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if (0..3).any(|i| position[i] >= self.sizes[i]) {
    // rust: return None;
}
    // rust: Some(position[1] + (position[0] + position[2] * self.sizes[0]) * self.sizes[1])
}
block :: proc(self: ^Self, axis: Axis, index: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let axis = axis as usize;
    // rust: (index < self.sizes[axis]).then(|| self.coordinate(axis, index))
}
    // Find an exact lattice sample, retaining Java's wrapped subtraction and
    // extent multiplication. Coordinates between samples are cache misses.
index_of_block :: proc(self: ^Self, position: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
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
