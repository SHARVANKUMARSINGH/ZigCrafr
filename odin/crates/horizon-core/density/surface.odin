//! Transpiled from Horizon Rust crate
package horizon_core_surface

import "core:fmt"
import "core:mem"
import "core:math"

// use super::*;

// The unsliced search primitive. Compiled terrain graphs wrap this in a Y=0
// slice through `compile_surface_search`, so their upper bound is horizontal.
FindTopSurfaceSampler :: struct {
    density: ^dyn DensitySampler,
    upper_bound: ^dyn DensitySampler,
    lower_bound: i32,
    cell_height: i32,
}
    // rust: impl FindTopSurfaceSampler {
    // rust: pub fn new(
    // rust: density: Arc<dyn DensitySampler>,
    // rust: upper_bound: Arc<dyn DensitySampler>,
    // rust: lower_bound: i32,
    // rust: cell_height: i32,
    // rust: ) -> Result<Self, SampleError> {
    // rust: if cell_height <= 0 {
    // rust: return Err(DensityError::NonpositiveSteps.into());
}
    // rust: Ok(Self {
    // rust: density,
    // rust: upper_bound,
    // rust: lower_bound,
    // rust: cell_height,
    // rust: })
}
    // rust: fn find_surface_from(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: x: i32,
    // rust: z: i32,
    // rust: upper: f32,
    // rust: ) -> Result<i32, SampleError> {
    // rust: let quotient = upper / self.cell_height as f32;
        // Java 26.3 Mth.floor(float) widens to double, calls Math.floor,
        // then uses a saturating double-to-int conversion (NaN becomes zero).
    // rust: let floor = (quotient as f64).floor() as i32;
    // rust: let mut y = floor.wrapping_mul(self.cell_height);
    // rust: if y <= self.lower_bound {
    // rust: return Ok(self.lower_bound);
}
    // rust: while y >= self.lower_bound {
    // rust: if self.density.sample_value(context, [x, y, z])? > 0.0 {
    // rust: return Ok(y);
}
            // Malformed manually constructed bounds can otherwise wrap and
            // loop forever; serialized vanilla terrain bounds do not reach this.
    // rust: y = y
    // rust: .checked_sub(self.cell_height)
    // rust: .ok_or(SampleError::SurfaceSearchOverflow)?;
}
    // rust: Ok(self.lower_bound)
}
}
    // rust: impl DensitySampler for FindTopSurfaceSampler {
    // rust: fn sample_value(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: [x, y, z]: [i32; 3],
    // rust: ) -> Result<f32, SampleError> {
    // rust: let upper = self.upper_bound.sample_value(context, [x, y, z])?;
    // rust: Ok(self.find_surface_from(context, x, z, upper)? as f32)
}
    // rust: fn sample_volume(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: output: &mut [f32],
    // rust: volume: DensityVolume,
    // rust: ) -> Result<(), SampleError> {
    // rust: check_buffer(output, volume)?;
    // rust: if volume.sizes()[1] != 1 {
    // rust: return Err(SampleError::SurfaceRequiresSingleLayer);
}
    // rust: self.upper_bound.sample_volume(context, output, volume)?;
    // rust: visit(volume, |index, [x, _, z]| {
    // rust: output[index] = self.find_surface_from(context, x, z, output[index])? as f32;
    // rust: Ok(())
    // rust: })
}
}

    // rust: pub fn compile_surface_search(
    // rust: density: Arc<dyn DensitySampler>,
    // rust: upper_bound: Arc<dyn DensitySampler>,
    // rust: lower_bound: i32,
    // rust: cell_height: i32,
    // rust: ) -> Result<SliceSampler, SampleError> {
    // rust: Ok(SliceSampler {
    // rust: input: Arc::new(FindTopSurfaceSampler::new(
    // rust: density,
    // rust: upper_bound,
    // rust: lower_bound,
    // rust: cell_height,
    // rust: )?),
    // rust: axes: SliceAxes::Y(0),
    // rust: })
}
