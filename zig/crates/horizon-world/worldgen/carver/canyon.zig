//! Transpiled from Horizon Rust crate
//! Module: horizon-world_canyon
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::*;
// use crate::worldgen::int_range;

pub const CanyonShape = struct {
    distance_factor: FloatProvider,
    thickness: FloatProvider,
    width_smoothness: i32,
    horizontal_radius_factor: FloatProvider,
    vertical_radius_default_factor: f32,
    vertical_radius_center_factor: f32,
    y_scale: FloatProvider,
};
pub const CanyonCarver = struct {
    probability: f32,
    y: HeightProvider,
    vertical_rotation: FloatProvider,
    shape: CanyonShape,
};
    // rust: impl CanyonCarver {
pub fn from_json(json: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let kind = identifier(&serde_json::from_str::<String>(
    // rust: required(&object, "type")?.get(),
    // rust: )?)?;
    // rust: if kind != "minecraft:canyon" {
    // rust: return Err(DecodeError::Field("canyon carver type"));
}
    // rust: let probability = scalar(&object, "probability")?;
    // rust: if !(0.0..=1.0).contains(&probability) || probability.is_sign_negative() {
    // rust: return Err(DecodeError::Field("carver probability"));
}
    // rust: let shape: Object = serde_json::from_str(required(&object, "shape")?.get())?;
    // rust: let provider = |name| FloatProvider::from_json(required(&shape, name)?.get());
    // rust: Ok(Self {
    // rust: probability,
    // rust: y: HeightProvider::from_json(required(&object, "y")?.get())?,
    // rust: vertical_rotation: FloatProvider::from_json(
    // rust: required(&object, "vertical_rotation")?.get(),
    // rust: )?,
    // rust: shape: CanyonShape {
    // rust: distance_factor: provider("distance_factor")?,
    // rust: thickness: provider("thickness")?,
    // rust: width_smoothness: int_range(
    // rust: required(&shape, "width_smoothness")?,
    // rust: "width_smoothness",
    // rust: 1,
    // rust: i32::MAX,
    // rust: )?,
    // rust: horizontal_radius_factor: provider("horizontal_radius_factor")?,
    // rust: vertical_radius_default_factor: scalar(&shape, "vertical_radius_default_factor")?,
    // rust: vertical_radius_center_factor: scalar(&shape, "vertical_radius_center_factor")?,
    // rust: y_scale: provider("y_scale")?,
    // rust: },
    // rust: })
}
pub fn is_start_chunk(self: *Self, random: *mut impl RandomSource) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: random.next_float() <= self.probability
}
    /// Generate a canyon from one origin chunk. Width factors cover the entire
    /// generation height and use a separate legacy random stream. Output bounds
    /// must lie within that height; paths are bounded to 4096 steps, 4064 width
    /// entries and 2^24 candidate cells. Earlier output survives errors.
    // rust: pub fn carve<O: CarverOutput>(
    // rust: &self,
    // rust: context: WorldGenerationContext,
    // rust: random: &mut impl RandomSource,
    // rust: target: ChunkPos,
    // rust: origin: ChunkPos,
    // rust: output: &mut O,
    // rust: ) -> Result<bool, CarverError<O::Error>> {
    // rust: let mut x = f64::from(
    // rust: origin
    // rust: .x
    // rust: .wrapping_shl(4)
    // rust: .wrapping_add(random.next_int_bound(16)?),
    // rust: );
    // rust: let mut y = f64::from(self.y.sample(random, context)?);
    // rust: let mut z = f64::from(
    // rust: origin
    // rust: .z
    // rust: .wrapping_shl(4)
    // rust: .wrapping_add(random.next_int_bound(16)?),
    // rust: );
    // rust: let mut yaw = random.next_float() * std::f32::consts::TAU;
    // rust: let mut pitch = self.vertical_rotation.sample(random);
    // rust: let y_scale = f64::from(self.shape.y_scale.sample(random));
    // rust: let thickness = self.shape.thickness.sample(random);
    // rust: let end = (112f32 * self.shape.distance_factor.sample(random)) as i32;
    // rust: let mut local = LegacyRandom::new(random.next_long());
    // rust: if !(1..=4064).contains(&context.height)
    // rust: || output.min_y() < context.min_y
    // rust: || i64::from(output.max_y()) > i64::from(context.min_y) + i64::from(context.height)
    // rust: {
    // rust: return Err(CarverError::InvalidBounds);
}
    // rust: if end > 4096 {
    // rust: return Err(CarverError::IterationLimit);
}
    // rust: let mut width = Vec::with_capacity(context.height as usize);
    // rust: let mut factor = 1f32;
    // rust: for index in 0..context.height {
    // rust: if index == 0 || local.next_int_bound(self.shape.width_smoothness)? == 0 {
    // rust: factor = 1. + local.next_float() * local.next_float();
}
    // rust: width.push(factor * factor);
}
    // rust: let (mut yaw_change, mut pitch_change) = (0f32, 0f32);
    // rust: let mut budget = 1 << 24;
    // rust: for step in 0..end {
    // rust: let mut horizontal = 1.5
    // rust: + f64::from(
    // rust: sin(f64::from(step as f32 * std::f32::consts::PI / end as f32)) * thickness,
    // rust: );
    // rust: let mut vertical = horizontal * y_scale;
    // rust: horizontal *= f64::from(self.shape.horizontal_radius_factor.sample(&mut local));
    // rust: let center = 1. - (0.5 - step as f32 / end as f32).abs() * 2.;
    // rust: let multiplier = self.shape.vertical_radius_default_factor
    // rust: + self.shape.vertical_radius_center_factor * center;
    // rust: vertical = (f64::from(multiplier) * vertical)
    // rust: * f64::from(local.next_float() * (1. - 0.75) + 0.75);
    // rust: let cos_pitch = cos(f64::from(pitch));
    // rust: let sin_pitch = sin(f64::from(pitch));
    // rust: x += f64::from(cos(f64::from(yaw)) * cos_pitch);
    // rust: y += f64::from(sin_pitch);
    // rust: z += f64::from(sin(f64::from(yaw)) * cos_pitch);
    // rust: pitch *= 0.7;
    // rust: pitch += pitch_change * 0.05;
    // rust: yaw += yaw_change * 0.05;
    // rust: pitch_change *= 0.8;
    // rust: yaw_change *= 0.5;
    // rust: pitch_change += (local.next_float() - local.next_float()) * local.next_float() * 2.;
    // rust: yaw_change += (local.next_float() - local.next_float()) * local.next_float() * 4.;
    // rust: if local.next_int_bound(4)? == 0 {
    // rust: continue;
}
    // rust: if !can_reach(target, x, z, step, end, thickness) {
    // rust: return Ok(true);
}
    // rust: carve_ellipsoid_with_budget(
    // rust: target,
    // rust: [x, y, z],
    // rust: horizontal,
    // rust: vertical,
    // rust: output,
    // rust: |[nx, ny, nz], by| {
    // rust: let factor = width[by.wrapping_sub(context.min_y).wrapping_sub(1) as usize];
    // rust: (nx * nx + nz * nz) * f64::from(factor) + ny * ny / 6. >= 1.
    // rust: },
    // rust: &mut budget,
    // rust: )?;
}
    // rust: Ok(true)
}
}
pub fn scalar(object: *Object, name: *'static str) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: number_text(required(object, name)?)?
    // rust: .parse()
    // rust: .map_err(|_| DecodeError::Field(name))
}
