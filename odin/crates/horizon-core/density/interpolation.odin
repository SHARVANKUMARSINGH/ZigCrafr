//! Transpiled from Horizon Rust crate
package horizon_core_interpolation

import "core:fmt"
import "core:mem"
import "core:math"

// use super::*;

// Interpolation over a coarse density grid. Scalar queries and volume queries
// retain vanilla's distinct floating-point paths and child bulk calls.
InterpolatedSampler :: struct {
    input: ^dyn DensitySampler,
    cell_size: [i32,
    inverse: [f32,
}
    // rust: impl InterpolatedSampler {
    // rust: pub fn new(
    // rust: input: Arc<dyn DensitySampler>,
    // rust: cell_size_xz: i32,
    // rust: cell_size_y: i32,
    // rust: ) -> Result<Self, SampleError> {
    // rust: if cell_size_xz <= 0 || cell_size_y <= 0 {
    // rust: return Err(DensityError::NonpositiveSteps.into());
}
    // rust: let cell_size = [cell_size_xz, cell_size_y, cell_size_xz];
    // rust: Ok(Self {
    // rust: input,
    // rust: cell_size,
    // rust: inverse: cell_size.map(|size| 1.0 / size as f32),
    // rust: })
}

    // rust: fn sample_block_volume(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: output: &mut [f32],
    // rust: volume: DensityVolume,
    // rust: ) -> Result<(), SampleError> {
    // rust: let minimum = volume.minimum();
    // rust: let maximum = volume.maximum();
    // rust: let first: [i32; 3] = std::array::from_fn(|i| minimum[i].div_euclid(self.cell_size[i]));
    // rust: let counts: [i32; 3] = std::array::from_fn(|i| {
    // rust: maximum[i]
    // rust: .div_euclid(self.cell_size[i])
    // rust: .wrapping_sub(first[i])
    // rust: .wrapping_add(1)
    // rust: });
    // rust: let sizes = std::array::from_fn(|i| {
    // rust: counts[i].wrapping_add(i32::from(maximum[i].rem_euclid(self.cell_size[i]) != 0))
    // rust: });
    // rust: let coarse = DensityVolume::new(
    // rust: sizes,
    // rust: std::array::from_fn(|i| first[i].wrapping_mul(self.cell_size[i])),
    // rust: self.cell_size,
    // rust: )?;
    // rust: context.with_buffer(coarse.size(), |context, samples| {
    // rust: self.input.sample_volume(context, samples, coarse)?;
    // rust: let [size_x, size_y, size_z] = coarse.sizes();
    // rust: let [count_x, count_y, count_z] = counts.map(|count| count.max(0) as usize);
            // Corner samples beyond the coarse grid clamp to its last layer.
    // rust: let next = |index: usize, size: usize| (index + 1).min(size - 1);
    // rust: for z in 0..count_z {
    // rust: let zs = [z, next(z, size_z)];
    // rust: for x in 0..count_x {
    // rust: let xs = [x, next(x, size_x)];
                    // Corner bit 0 selects X, bit 2 Z (bit 1, Y, is added per cell).
    // rust: let columns: [usize; 4] =
    // rust: std::array::from_fn(|i| (xs[i & 1] + zs[i >> 1] * size_x) * size_y);
    // rust: for y in 0..count_y {
    // rust: let ys = [y, next(y, size_y)];
    // rust: let corners = std::array::from_fn(|corner| {
    // rust: samples[columns[(corner & 1) | ((corner >> 1) & 2)]
    // rust: + ys[(corner >> 1) & 1]]
    // rust: });
    // rust: self.fill_cell(output, volume, coarse, [x, y, z], corners)?;
}
}
}
    // rust: Ok(())
    // rust: })
}

    // rust: fn fill_cell(
    // rust: &self,
    // rust: output: &mut [f32],
    // rust: volume: DensityVolume,
    // rust: coarse: DensityVolume,
    // rust: cell: [usize; 3],
    // rust: corners: [f32; 8],
    // rust: ) -> Result<(), SampleError> {
    // rust: let offset: [i32; 3] = std::array::from_fn(|i| {
    // rust: coarse.minimum()[i]
    // rust: .wrapping_add((cell[i] as i32).wrapping_mul(self.cell_size[i]))
    // rust: .wrapping_sub(volume.minimum()[i])
    // rust: });
    // rust: let start = offset.map(|offset| offset.wrapping_neg().max(0));
    // rust: let end: [i32; 3] = std::array::from_fn(|i| {
    // rust: self.cell_size[i]
    // rust: .min((volume.sizes()[i] as i32).wrapping_sub(offset[i]))
    // rust: .wrapping_sub(1)
    // rust: });
    // rust: if end[1] < start[1] {
    // rust: return Ok(());
}
    // rust: let length = (end[1] - start[1] + 1) as usize;
    // rust: let output_len = output.len();
    // rust: for z in start[2]..=end[2] {
    // rust: let alpha_z = z as f32 * self.inverse[2];
    // rust: let z00 = lerp(alpha_z, corners[0], corners[4]);
    // rust: let z01 = lerp(alpha_z, corners[2], corners[6]);
    // rust: let z10 = lerp(alpha_z, corners[1], corners[5]);
    // rust: let z11 = lerp(alpha_z, corners[3], corners[7]);
    // rust: let column = |x: i32| {
    // rust: let alpha_x = x as f32 * self.inverse[0];
    // rust: let low = lerp(alpha_x, z00, z10);
    // rust: let high = lerp(alpha_x, z01, z11);
    // rust: let increment = (high - low) * self.inverse[1];
    // rust: let value = low + increment * start[1] as f32;
    // rust: let index = volume
    // rust: .index([
    // rust: offset[0].wrapping_add(x) as usize,
    // rust: offset[1].wrapping_add(start[1]) as usize,
    // rust: offset[2].wrapping_add(z) as usize,
    // rust: ])
    // rust: .filter(|index| {
    // rust: index
    // rust: .checked_add(length)
    // rust: .is_some_and(|end| end <= output_len)
    // rust: });
    // rust: (index, value, increment)
}
            // A row four columns wide (a whole cell) runs its columns' independent
            // repeated-addition chains side by side, so their additions overlap.
    // rust: if end[0] - start[0] == 3 {
    // rust: let columns: [_; 4] = std::array::from_fn(|i| column(start[0] + i as i32));
    // rust: if let Some(rows) = four_columns(output, columns.map(|(index, ..)| index), length) {
    // rust: let mut values = columns.map(|(_, value, _)| value);
    // rust: let increments = columns.map(|(.., increment)| increment);
    // rust: let [a, b, c, d] = rows;
    // rust: for y in 0..length {
    // rust: [a[y], b[y], c[y], d[y]] = values;
    // rust: for (value, increment) in values.iter_mut().zip(increments) {
    // rust: *value += increment;
}
}
    // rust: continue;
}
}
    // rust: for x in start[0]..=end[0] {
    // rust: let (index, mut value, increment) = column(x);
    // rust: let index = index.ok_or(DensityError::VolumeTooLarge)?;
    // rust: for output in &mut output[index..index + length] {
    // rust: *output = value;
                    // Repeated addition is observable: multiplication by the
                    // current Y offset does not have the same rounding.
    // rust: value += increment;
}
}
}
    // rust: Ok(())
}
}

// Four disjoint `length`-long column slices of `output` at ascending `starts`, if
// every start was valid and the columns do not overlap.
    // rust: fn four_columns(
    // rust: output: &mut [f32],
    // rust: starts: [Option<usize>; 4],
    // rust: length: usize,
    // rust: ) -> Option<[&mut [f32]; 4]> {
    // rust: let [a, b, c, d] = starts;
    // rust: let [a, b, c, d] = [a?, b?, c?, d?];
    // rust: if b.checked_sub(a)? < length || c.checked_sub(b)? < length || d.checked_sub(c)? < length {
    // rust: return None;
}
    // rust: let (first, rest) = output.get_mut(a..)?.split_at_mut(b - a);
    // rust: let (second, rest) = rest.split_at_mut(c - b);
    // rust: let (third, fourth) = rest.split_at_mut(d - c);
    // rust: Some([
    // rust: &mut first[..length],
    // rust: &mut second[..length],
    // rust: &mut third[..length],
    // rust: fourth.get_mut(..length)?,
    // rust: ])
}

lerp :: proc(alpha: f32, first: f32, second: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: first + alpha * (second - first)
}
    // rust: impl DensitySampler for InterpolatedSampler {
    // rust: fn sample_value(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: position: [i32; 3],
    // rust: ) -> Result<f32, SampleError> {
    // rust: let remainder: [i32; 3] =
    // rust: std::array::from_fn(|i| position[i].rem_euclid(self.cell_size[i]));
    // rust: if remainder == [0; 3] {
    // rust: return self.input.sample_value(context, position);
}
    // rust: let volume = DensityVolume::new(
    // rust: [2; 3],
    // rust: std::array::from_fn(|i| position[i].wrapping_sub(remainder[i])),
    // rust: self.cell_size,
    // rust: )?;
    // rust: context.with_buffer(8, |context, corners| {
    // rust: self.input.sample_volume(context, corners, volume)?;
    // rust: let alpha: [f32; 3] =
    // rust: std::array::from_fn(|i| remainder[i] as f32 / self.cell_size[i] as f32);
            // Samples use Y-innermost storage; interpolation blends X, Y, Z.
    // rust: let xy0 = lerp(
    // rust: alpha[1],
    // rust: lerp(alpha[0], corners[0], corners[2]),
    // rust: lerp(alpha[0], corners[1], corners[3]),
    // rust: );
    // rust: let xy1 = lerp(
    // rust: alpha[1],
    // rust: lerp(alpha[0], corners[4], corners[6]),
    // rust: lerp(alpha[0], corners[5], corners[7]),
    // rust: );
    // rust: Ok(lerp(alpha[2], xy0, xy1))
    // rust: })
}
    // rust: fn sample_volume(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: output: &mut [f32],
    // rust: volume: DensityVolume,
    // rust: ) -> Result<(), SampleError> {
    // rust: check_buffer(output, volume)?;
    // rust: if context.sparse {
    // rust: if (0..3).all(|i| {
    // rust: volume.steps()[i] % self.cell_size[i] == 0
    // rust: && volume.minimum()[i].rem_euclid(self.cell_size[i]) == 0
    // rust: }) {
    // rust: return self.input.sample_volume(context, output, volume);
}
    // rust: return visit(volume, |index, position| {
    // rust: output[index] = self.sample_value(context, position)?;
    // rust: Ok(())
    // rust: });
}
    // rust: if (0..3).all(|i| {
    // rust: (volume.steps()[i] == self.cell_size[i] || volume.sizes()[i] == 1)
    // rust: && volume.minimum()[i].rem_euclid(self.cell_size[i]) == 0
    // rust: }) {
    // rust: return self.input.sample_volume(context, output, volume);
}
    // rust: if volume.steps() == [1; 3] {
    // rust: return self.sample_block_volume(context, output, volume);
}
        // The reference evaluates the complete block-resolution bounding volume
        // before selecting strided samples, including trailing unsampled blocks.
    // rust: let dense = DensityVolume::new(
    // rust: std::array::from_fn(|i| (volume.sizes()[i] as i32).wrapping_mul(volume.steps()[i])),
    // rust: volume.minimum(),
    // rust: [1; 3],
    // rust: )?;
    // rust: context.with_buffer(dense.size(), |context, samples| {
    // rust: self.sample_block_volume(context, samples, dense)?;
    // rust: let [sx, sy, sz] = volume.sizes();
    // rust: for z in 0..sz {
    // rust: for x in 0..sx {
    // rust: for y in 0..sy {
    // rust: let source = dense.index(std::array::from_fn(|i| {
    // rust: [x, y, z][i] * volume.steps()[i] as usize
    // rust: }));
    // rust: output[(x + z * sx) * sy + y] = samples[source.unwrap()];
}
}
}
    // rust: Ok(())
    // rust: })
}
}
