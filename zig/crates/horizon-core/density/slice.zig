//! Transpiled from Horizon Rust crate
//! Module: horizon-core_slice
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::*;

/// Coordinates fixed by the compiled single-axis or combined XZ slice node.
pub const SliceAxes = enum {
    X(i32),
    Y(i32),
    Z(i32),
    Xz { x: i32, z: i32 },
};
    // rust: impl SliceAxes {
pub fn coordinates(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::X(x) => [Some(x), None, None],
    // rust: Self::Y(y) => [None, Some(y), None],
    // rust: Self::Z(z) => [None, None, Some(z)],
    // rust: Self::Xz { x, z } => [Some(x), None, Some(z)],
}
}
}

/// A y-fixed slice's plane: the slice node, the plane's corner (y fixed),
/// its x/z sizes and steps (`SamplerContext::with_planes`).
    // rust: pub(super) type PlaneKey = (usize, [i32; 3], [usize; 2], [i32; 2]);

pub const SliceSampler = struct {
    input: *dyn DensitySampler,
    axes: SliceAxes,
};
    // rust: impl DensitySampler for SliceSampler {
    // rust: fn sample_value(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: mut position: [i32; 3],
    // rust: ) -> Result<f32, SampleError> {
    // rust: for (axis, fixed) in self.axes.coordinates().into_iter().enumerate() {
    // rust: if let Some(coordinate) = fixed {
    // rust: position[axis] = coordinate;
}
}
    // rust: self.input.sample_value(context, position)
}

    // rust: fn sample_volume(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: buffer: &mut [f32],
    // rust: volume: DensityVolume,
    // rust: ) -> Result<(), SampleError> {
    // rust: check_buffer(buffer, volume)?;
    // rust: let fixed = self.axes.coordinates();
    // rust: let mut sizes = volume.sizes().map(|size| size as i32);
    // rust: let mut minimum = volume.minimum();
    // rust: for (axis, coordinate) in fixed.into_iter().enumerate() {
    // rust: if let Some(coordinate) = coordinate {
    // rust: sizes[axis] = 1;
    // rust: minimum[axis] = coordinate;
}
}
        // Keep the original steps, even on fixed axes: cached children observe
        // the complete volume descriptor. An unchanged slice delegates directly
        // and therefore retains the child's tail and partial-write behavior.
    // rust: let reduced = DensityVolume::new(sizes, minimum, volume.steps())?;
    // rust: if reduced == volume {
    // rust: return self.input.sample_volume(context, buffer, volume);
}
    // rust: let plane = (fixed[1].is_some() && context.planes.is_some()).then(|| {
    // rust: let [rx, _, rz] = reduced.sizes();
    // rust: let [step_x, _, step_z] = volume.steps();
    // rust: (
    // rust: self as *const Self as usize,
    // rust: reduced.minimum(),
    // rust: [rx, rz],
    // rust: [step_x, step_z],
    // rust: )
    // rust: });
    // rust: if let Some(key) = &plane
    // rust: && let Some(samples) = context.planes.as_ref().and_then(|p| p.get(key))
    // rust: {
    // rust: spread(fixed, volume, reduced, samples, buffer);
    // rust: return Ok(());
}
    // rust: context.with_buffer(reduced.size(), |context, samples| {
    // rust: self.input.sample_volume(context, samples, reduced)?;
    // rust: spread(fixed, volume, reduced, samples, buffer);
    // rust: if let (Some(key), Some(planes)) = (plane, &mut context.planes) {
    // rust: planes.insert(key, samples[..reduced.size()].to_vec());
}
    // rust: Ok(())
    // rust: })
}
}
/// Copies the `reduced` samples along the fixed axes of `volume`.
    // rust: fn spread(
    // rust: fixed: [Option<i32>; 3],
    // rust: volume: DensityVolume,
    // rust: reduced: DensityVolume,
    // rust: samples: &[f32],
    // rust: buffer: &mut [f32],
    // rust: ) {
    // rust: let [sx, sy, sz] = volume.sizes();
    // rust: let [rx, ry, _] = reduced.sizes();
    // rust: for z in 0..sz {
    // rust: let source_z = if fixed[2].is_some() { 0 } else { z };
    // rust: for x in 0..sx {
    // rust: let source_x = if fixed[0].is_some() { 0 } else { x };
    // rust: let source = (source_x + source_z * rx) * ry;
    // rust: let target = (x + z * sx) * sy;
    // rust: let column = &mut buffer[target..target + sy];
    // rust: if fixed[1].is_some() {
    // rust: column.fill(samples[source]);
    // rust: } else {
    // rust: column.copy_from_slice(&samples[source..source + sy]);
}
}
}
}
