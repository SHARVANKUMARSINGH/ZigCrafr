//! Transpiled from Horizon Rust crate
//! Module: horizon-core_perlin
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::{
    // rust: DensityError, DensityVolume, GradientTable, PERLIN_GRADIENTS, dot, lerp2, lerp3, smoothstep,
    // rust: smoothstep_derivative, wrap,
}
// use crate::{geometry::floor_i32, random::RandomSource};

pub const PerlinNoise = struct {
    table: GradientTable,
};

    // rust: impl PerlinNoise {
pub fn new(random: *mut impl RandomSource) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: table: GradientTable::new(random, 256.0),
}
}
pub fn table(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.table
}
pub fn range(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [-2.0, 2.0]
}
pub fn get2(self: *Self, x: f64, z: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.get3(wrap(x), 0.0, wrap(z))
}
pub fn get3(self: *Self, x: f64, y: f64, z: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (cell, relative) = self.coordinates([x, y, z]);
    // rust: let point = relative.map(|v| v as f32);
    // rust: self.sample(cell, point, point[1])
}

pub fn coordinates(self: *Self, point: [f64; 3]) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let shifted: [f64; 3] = std::array::from_fn(|i| wrap(point[i]) + self.table.offsets[i]);
    // rust: let cell = shifted.map(floor_i32);
    // rust: (
    // rust: cell,
    // rust: std::array::from_fn(|i| shifted[i] - f64::from(cell[i])),
    // rust: )
}

pub fn gradients(self: *Self, cell: [i32; 3]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.gradients_at(
    // rust: self.table.permute(cell[0]),
    // rust: self.table.permute(cell[0].wrapping_add(1)),
    // rust: cell[1],
    // rust: cell[2],
    // rust: )
}

    /// Corner gradients for a Y cell, with the X column's permutation already
    /// resolved. `add_volume` reuses one X column across every Y, so hoisting
    /// the two X permutes out of that loop avoids repeating them per Y.
pub fn gradients_at(self: *Self, p: i32, q: i32, cell_y: i32, cell_z: i32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.gradient_indices_at(p, q, cell_y, cell_z)
    // rust: .map(|index| PERLIN_GRADIENTS[index])
}

    /// The [`PERLIN_GRADIENTS`] index of each corner of [`Self::gradients_at`].
pub fn gradient_indices_at(self: *Self, p: i32, q: i32, cell_y: i32, cell_z: i32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let lower = self.table.permute(p.wrapping_add(cell_y));
    // rust: let upper = self.table.permute(p.wrapping_add(cell_y).wrapping_add(1));
    // rust: let lower_x = self.table.permute(q.wrapping_add(cell_y));
    // rust: let upper_x = self.table.permute(q.wrapping_add(cell_y).wrapping_add(1));
    // rust: let rows = [
    // rust: lower, lower_x, upper, upper_x, lower, lower_x, upper, upper_x,
    // rust: ];
    // rust: std::array::from_fn(|i| {
    // rust: (self
    // rust: .table
    // rust: .permute(rows[i].wrapping_add(cell_z).wrapping_add((i / 4) as i32))
    // rust: & 15) as usize
    // rust: })
}

pub fn corner_values(gradients: [[f32; 3]; 8], point: [f32; 3]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::array::from_fn(|i| {
    // rust: dot(
    // rust: gradients[i],
    // rust: [
    // rust: point[0] - (i & 1) as f32,
    // rust: point[1] - ((i >> 1) & 1) as f32,
    // rust: point[2] - ((i >> 2) & 1) as f32,
    // rust: ],
    // rust: )
    // rust: })
}

pub fn sample(self: *Self, cell: [i32; 3], point: [f32; 3], interpolation_y: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let values = Self::corner_values(self.gradients(cell), point);
    // rust: lerp3(
    // rust: [
    // rust: smoothstep(point[0]),
    // rust: smoothstep(interpolation_y),
    // rust: smoothstep(point[2]),
    // rust: ],
    // rust: values,
    // rust: )
}

    /// Returns the sampled value and adds its gradient into the supplied array.
pub fn noise_with_derivative(self: *Self, x: f64, y: f64, z: f64, derivative: *mut [f32; 3]) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (cell, relative) = self.coordinates([x, y, z]);
    // rust: let point = relative.map(|v| v as f32);
    // rust: let gradients = self.gradients(cell);
    // rust: let values = Self::corner_values(gradients, point);
    // rust: let fade = point.map(smoothstep);
    // rust: let gradient =
    // rust: std::array::from_fn::<_, 3, _>(|axis| lerp3(fade, gradients.map(|g| g[axis])));
    // rust: let changes = [
    // rust: lerp2(
    // rust: fade[1],
    // rust: fade[2],
    // rust: [
    // rust: values[1] - values[0],
    // rust: values[3] - values[2],
    // rust: values[5] - values[4],
    // rust: values[7] - values[6],
    // rust: ],
    // rust: ),
    // rust: lerp2(
    // rust: fade[2],
    // rust: fade[0],
    // rust: [
    // rust: values[2] - values[0],
    // rust: values[6] - values[4],
    // rust: values[3] - values[1],
    // rust: values[7] - values[5],
    // rust: ],
    // rust: ),
    // rust: lerp2(
    // rust: fade[0],
    // rust: fade[1],
    // rust: [
    // rust: values[4] - values[0],
    // rust: values[5] - values[1],
    // rust: values[6] - values[2],
    // rust: values[7] - values[3],
    // rust: ],
    // rust: ),
    // rust: ];
    // rust: for axis in 0..3 {
    // rust: derivative[axis] += gradient[axis] + smoothstep_derivative(point[axis]) * changes[axis];
}
    // rust: lerp3(fade, values)
}

    /// Adds a scaled volume using vanilla's cached X/Z dot products and Y loop.
    /// Extra buffer elements are untouched; short buffers are rejected up front.
    // rust: pub fn add_to_volume(
    // rust: &self,
    // rust: buffer: &mut [f32],
    // rust: volume: DensityVolume,
    // rust: xz_scale: f64,
    // rust: y_scale: f64,
    // rust: amplitude: f32,
    // rust: ) -> Result<(), DensityError> {
    // rust: self.add_volume::<true>(buffer, volume, xz_scale, y_scale, amplitude, None)
}

    /// `BATCH` = false evaluates one Y at a time: the reference the batched loop is tested against.
    // rust: fn add_volume<const BATCH: bool>(
    // rust: &self,
    // rust: buffer: &mut [f32],
    // rust: volume: DensityVolume,
    // rust: xz_scale: f64,
    // rust: y_scale: f64,
    // rust: amplitude: f32,
    // rust: fudge_y_scale: Option<f64>,
    // rust: ) -> Result<(), DensityError> {
    // rust: if buffer.len() < volume.size() {
    // rust: return Err(DensityError::BufferTooShort);
}
    // rust: let [size_x, size_y, size_z] = volume.sizes();
        // Every X/Z column walks the same Y coordinates, so their cells, offsets
        // and fades are computed once per volume instead of once per column.
    // rust: let mut stack = ([0_i32; STACK_Y], [0.0_f32; STACK_Y], [0.0_f32; STACK_Y]);
    // rust: let mut heap = (Vec::new(), Vec::new(), Vec::new());
    // rust: let (cells, fades, offsets): (&mut [i32], &mut [f32], &mut [f32]) = if size_y <= STACK_Y {
    // rust: (
    // rust: &mut stack.0[..size_y],
    // rust: &mut stack.1[..size_y],
    // rust: &mut stack.2[..size_y],
    // rust: )
    // rust: } else {
    // rust: heap.0.resize(size_y, 0);
    // rust: heap.1.resize(size_y, 0.0);
    // rust: heap.2.resize(size_y, 0.0);
    // rust: (&mut heap.0[..], &mut heap.1[..], &mut heap.2[..])
}
    // rust: for y in 0..size_y {
    // rust: let input_y = f64::from(volume.coordinate(1, y)) * y_scale;
    // rust: let shifted_y = wrap(input_y) + self.table.offsets[1];
    // rust: let cell = floor_i32(shifted_y);
    // rust: let dy = shifted_y - f64::from(cell);
    // rust: cells[y] = cell;
    // rust: fades[y] = smoothstep(dy as f32);
            // The Y offset inside the cell used for the corner values, after any fudge.
    // rust: offsets[y] = match fudge_y_scale {
    // rust: Some(scale) => (dy - compute_fudge_y(input_y, dy, scale)) as f32,
    // rust: None => dy as f32,
}
}
    // rust: let (cells, fades, offsets) = (&*cells, &*fades, &*offsets);
        // A column's corner terms depend on its Y cell only through the corners'
        // gradients. When the cell changes often, tabulate per column each of the
        // sixteen gradients' terms once instead of computing them per cell.
    // rust: let changes = cells.windows(2).filter(|pair| pair[0] != pair[1]).count();
    // rust: let tabulate = BATCH && changes >= TABULATE_CHANGES;
    // rust: let mut index = 0;
    // rust: for z in 0..size_z {
    // rust: let shifted_z =
    // rust: wrap(f64::from(volume.coordinate(2, z)) * xz_scale) + self.table.offsets[2];
    // rust: let cell_z = floor_i32(shifted_z);
    // rust: let dz = (shifted_z - f64::from(cell_z)) as f32;
    // rust: let fade_z = smoothstep(dz);
    // rust: for x in 0..size_x {
    // rust: let shifted_x =
    // rust: wrap(f64::from(volume.coordinate(0, x)) * xz_scale) + self.table.offsets[0];
    // rust: let cell_x = floor_i32(shifted_x);
    // rust: let dx = (shifted_x - f64::from(cell_x)) as f32;
    // rust: let fade_x = smoothstep(dx);
    // rust: let p = self.table.permute(cell_x);
    // rust: let q = self.table.permute(cell_x.wrapping_add(1));
    // rust: let terms = tabulate.then(|| CornerTerms::new(dx, dz));
    // rust: let mut previous_y = i32::MIN;
    // rust: let mut xz_dots = [0.0_f32; 8];
    // rust: let mut y_gradients = [0.0_f32; 8];
    // rust: let column = &mut buffer[index..index + size_y];
    // rust: let mut y = 0;
    // rust: while y < size_y {
    // rust: let cell = cells[y];
    // rust: if previous_y != cell {
    // rust: if let Some(terms) = &terms {
    // rust: let indices = self.gradient_indices_at(p, q, cell, cell_z);
    // rust: for i in 0..8 {
    // rust: [xz_dots[i], y_gradients[i]] = terms.get(i, indices[i]);
}
    // rust: } else {
    // rust: let gradients = self.gradients_at(p, q, cell, cell_z);
    // rust: for i in 0..8 {
    // rust: xz_dots[i] = gradients[i][0] * (dx - (i & 1) as f32)
    // rust: + gradients[i][2] * (dz - ((i >> 2) & 1) as f32);
    // rust: y_gradients[i] = gradients[i][1];
}
}
    // rust: previous_y = cell;
}
                    // Four Ys in one cell share the corners: side by side, LLVM computes them
                    // as vectors. Cell boundaries and the column's tail go one at a time.
    // rust: if BATCH && y + 4 <= size_y && cells[y + 1..y + 4].iter().all(|&c| c == cell) {
    // rust: add_four(
    // rust: &mut column[y..y + 4],
    // rust: &offsets[y..y + 4],
    // rust: &fades[y..y + 4],
    // rust: xz_dots,
    // rust: y_gradients,
    // rust: [fade_x, fade_z],
    // rust: amplitude,
    // rust: );
    // rust: y += 4;
    // rust: continue;
}
    // rust: let dy = offsets[y];
    // rust: let values = std::array::from_fn(|i| {
    // rust: xz_dots[i] + y_gradients[i] * (dy - ((i >> 1) & 1) as f32)
    // rust: });
    // rust: column[y] += amplitude * lerp3([fade_x, fades[y], fade_z], values);
    // rust: y += 1;
}
    // rust: index += size_y;
}
}
    // rust: Ok(())
}
}

/// Y columns up to this height keep their per-Y samples on the stack.
pub const STACK_Y: usize = 64;
/// Y cell changes per column from which [`CornerTerms`] are tabulated: building the
/// table costs about as much as computing the terms for a few cells.
pub const TABULATE_CHANGES: usize = 4;

/// One column's corner terms by XZ corner (bit 0 X, bit 1 Z) and gradient index:
/// the XZ dot product, computed exactly as for a single cell, and the Y gradient.
pub const CornerTerms = struct {};

    // rust: impl CornerTerms {
pub fn new(dx: f32, dz: f32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self(std::array::from_fn(|corner| {
    // rust: std::array::from_fn(|gradient| {
    // rust: let [gx, gy, gz] = PERLIN_GRADIENTS[gradient];
    // rust: [
    // rust: gx * (dx - (corner & 1) as f32) + gz * (dz - (corner >> 1) as f32),
    // rust: gy,
    // rust: ]
    // rust: })
    // rust: }))
}

    /// The XZ dot product and Y gradient of `corner` (bit 0 X, bit 1 Y, bit 2 Z).
pub fn get(self: *Self, corner: usize, gradient: usize) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0[(corner & 1) | ((corner >> 1) & 2)][gradient & 15]
}
}

pub const SmearedPerlinNoise = struct {
    base: PerlinNoise,
    fudge_y_scale: f64,
};

    // rust: impl SmearedPerlinNoise {
pub fn new(random: *mut impl RandomSource, fudge_y_scale: f64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: base: PerlinNoise::new(random),
    // rust: fudge_y_scale,
}
}
pub fn table(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.base.table()
}
pub fn range(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bound = (self.fudge_y_scale.abs() + 2.0) as f32;
    // rust: if bound.is_nan() {
    // rust: Err(super::NanRange)
    // rust: } else {
    // rust: Ok([-bound, bound])
}
}
pub fn get2(self: *Self, x: f64, z: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.get3(wrap(x), 0.0, wrap(z))
}
pub fn get3(self: *Self, x: f64, y: f64, z: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (cell, relative) = self.base.coordinates([x, y, z]);
    // rust: let fudge = compute_fudge_y(y, relative[1], self.fudge_y_scale);
    // rust: self.base.sample(
    // rust: cell,
    // rust: [
    // rust: relative[0] as f32,
    // rust: (relative[1] - fudge) as f32,
    // rust: relative[2] as f32,
    // rust: ],
    // rust: relative[1] as f32,
    // rust: )
}
    // This inherited method samples the unsmeared field, just as vanilla does.
pub fn noise_with_derivative(self: *Self, x: f64, y: f64, z: f64, derivative: *mut [f32; 3]) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.base.noise_with_derivative(x, y, z, derivative)
}
    // rust: pub fn add_to_volume(
    // rust: &self,
    // rust: buffer: &mut [f32],
    // rust: volume: DensityVolume,
    // rust: xz_scale: f64,
    // rust: y_scale: f64,
    // rust: amplitude: f32,
    // rust: ) -> Result<(), DensityError> {
    // rust: self.base.add_volume::<true>(
    // rust: buffer,
    // rust: volume,
    // rust: xz_scale,
    // rust: y_scale,
    // rust: amplitude,
    // rust: Some(self.fudge_y_scale),
    // rust: )
}
}

pub fn compute_fudge_y(input_y: f64, relative_y: f64, scale: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let limited_y = if input_y >= 0.0 && input_y < relative_y {
    // rust: input_y
    // rust: } else {
    // rust: relative_y
}
    // rust: f64::from(floor_i32(limited_y / scale + f64::from(1e-7_f32))) * scale
}

/// Adds four Y samples of one cell, laid out lane by lane so LLVM vectorizes them (no intrinsics,
/// no target feature). Each lane does the one-at-a-time loop's operations in the same order.
    // rust: fn add_four(
    // rust: out: &mut [f32],
    // rust: offsets: &[f32],
    // rust: fades: &[f32],
    // rust: dots: [f32; 8],
    // rust: gradients: [f32; 8],
    // rust: [fade_x, fade_z]: [f32; 2],
    // rust: amplitude: f32,
    // rust: ) {
    // rust: let dy: [f32; 4] = std::array::from_fn(|lane| offsets[lane]);
    // rust: let fy: [f32; 4] = std::array::from_fn(|lane| fades[lane]);
    // rust: let values: [[f32; 4]; 8] = std::array::from_fn(|i| {
    // rust: std::array::from_fn(|lane| dots[i] + gradients[i] * (dy[lane] - ((i >> 1) & 1) as f32))
    // rust: });
    // rust: for lane in 0..4 {
    // rust: out[lane] += amplitude * lerp3([fade_x, fy[lane], fade_z], values.map(|v| v[lane]));
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::random::LegacyRandom;

pub fn batched_volume_is_bit_identical() void {
}
    // rust: let scales = [
    // rust: 0.0,
    // rust: -0.0,
    // rust: 0.001,
    // rust: -0.001,
    // rust: 0.125,
    // rust: -0.5,
    // rust: 1.0,
    // rust: 4.0,
    // rust: 1e100,
    // rust: f64::INFINITY,
    // rust: f64::NEG_INFINITY,
    // rust: f64::NAN,
    // rust: ];
    // rust: let amplitudes = [
    // rust: 0.0,
    // rust: -0.0,
    // rust: 1.0,
    // rust: -1.0,
    // rust: f32::INFINITY,
    // rust: f32::NEG_INFINITY,
    // rust: f32::NAN,
    // rust: f32::from_bits(1),
    // rust: ];
    // rust: for seed in [0, -1, 1234, i64::MIN] {
    // rust: let noise = PerlinNoise::new(&mut LegacyRandom::new(seed));
    // rust: for height in [1, 2, 3, 4, 5, 7, 8, 9, 31, 64, 65, 97] {
    // rust: for (case, &scale) in scales.iter().enumerate() {
    // rust: let minimum = [
    // rust: [-17, -64, 49],
    // rust: [i32::MAX, i32::MIN, -16777216],
    // rust: [16777216, 33554431, -33554432],
    // rust: ][case % 3];
    // rust: let volume = DensityVolume::new(
    // rust: [2, height, 2],
    // rust: minimum,
    // rust: [4, if case % 3 == 0 { i32::MAX } else { 1 }, 16],
    // rust: )
    // rust: .unwrap();
    // rust: for fudge in [None, Some(0.125), Some(-0.25), Some(0.0), Some(f64::NAN)] {
    // rust: let initial = [0.0, -0.0, 1.5, f32::from_bits(1)];
    // rust: let mut a: Vec<_> =
    // rust: (0..volume.size() + 3).map(|i| initial[i % 4]).collect();
    // rust: let mut b = a.clone();
    // rust: let amplitude = amplitudes[case % amplitudes.len()];
    // rust: noise
    // rust: .add_volume::<false>(&mut a, volume, scale, scale, amplitude, fudge)
    // rust: .unwrap();
    // rust: noise
    // rust: .add_volume::<true>(&mut b, volume, scale, scale, amplitude, fudge)
    // rust: .unwrap();
    // rust: for (i, (a, b)) in a.iter().zip(&b).enumerate() {
    // rust: assert_eq!(
    // rust: a.to_bits(),
    // rust: b.to_bits(),
    // rust: "seed={seed} height={height} scale={scale} fudge={fudge:?} index={i}"
    // rust: );
}
}
}
}
}
}
}
