//! Transpiled from Horizon Rust crate
//! Module: horizon-core_border
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Pinned world-border extent geometry and tick-driven size interpolation.
//! Saved-data codecs, listeners, damage and synchronization are separate layers.
// use super::{Aabb, ShapeError, ShapeOp, Vec3, VoxelShape, clamp, java_max, java_min};

pub const BorderError = enum {
    InvalidParameters,
    Shape(ShapeError),
};
    // rust: impl std::fmt::Display for BorderError {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {Self::InvalidParameters=>f.write_str("border requires finite nonnegative sizes, finite centers and nonnegative limits/duration"),Self::Shape(e)=>e.fmt(f)}
}
}
    // rust: impl std::error::Error for BorderError {}
    // rust: impl From<ShapeError> for BorderError {
pub fn from(e: ShapeError) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::Shape(e)
}
}
pub const BorderStatus = enum {
    Stationary,
    Growing,
    Shrinking,
};
pub const Extent = enum {
    Static {,
    size: f64,
    bounds: [f64; 4],
    shape: VoxelShape,
    // rust: },
    Moving {,
    from: f64,
    to: f64,
    duration: i64,
    remaining: i64,
    size: f64,
    previous: f64,
    // rust: },
};
pub const BorderGeometry = struct {
    center: [f64,
    absolute_max: i32,
    extent: Extent,
};
    // rust: impl BorderGeometry {
pub fn new(center: [f64; 2], size: f64, absolute_max: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !center.into_iter().all(f64::is_finite)
    // rust: || !size.is_finite()
    // rust: || size < 0.0
    // rust: || absolute_max < 0
    // rust: {
    // rust: return Err(BorderError::InvalidParameters);
}
    // rust: Ok(Self {
    // rust: center,
    // rust: absolute_max,
    // rust: extent: Self::stationary(center, size, absolute_max)?,
    // rust: })
}
pub fn stationary(center: [f64; 2], size: f64, absolute_max: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bounds = Self::extent_bounds(center, size, absolute_max);
    // rust: Ok(Extent::Static {
    // rust: size,
    // rust: bounds,
    // rust: shape: Self::shape_for(bounds)?,
    // rust: })
}
pub fn extent_bounds(center: [f64; 2], size: f64, absolute_max: i32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let limit = f64::from(absolute_max);
    // rust: let lower = f64::from(-absolute_max);
    // rust: [
    // rust: clamp(center[0] - size / 2.0, lower, limit),
    // rust: clamp(center[1] - size / 2.0, lower, limit),
    // rust: clamp(center[0] + size / 2.0, lower, limit),
    // rust: clamp(center[1] + size / 2.0, lower, limit),
    // rust: ]
}
pub fn shape_for(max_z]: [f64; 4]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let infinity = VoxelShape::from_box(Aabb::new(
    // rust: Vec3::new(f64::NEG_INFINITY, f64::NEG_INFINITY, f64::NEG_INFINITY),
    // rust: Vec3::new(f64::INFINITY, f64::INFINITY, f64::INFINITY),
    // rust: ))?;
    // rust: let inside = VoxelShape::from_box(Aabb::new(
    // rust: Vec3::new(min_x.floor(), f64::NEG_INFINITY, min_z.floor()),
    // rust: Vec3::new(max_x.ceil(), f64::INFINITY, max_z.ceil()),
    // rust: ))?;
    // rust: infinity.join(&inside, ShapeOp::ONLY_FIRST)
}
pub fn center(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.center
}
pub fn absolute_max(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.absolute_max
}
pub fn set_center(self: *Self, center: [f64; 2]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !center.into_iter().all(f64::is_finite) {
    // rust: return Err(BorderError::InvalidParameters);
}
    // rust: if let Extent::Static { size, .. } = self.extent {
    // rust: self.extent = Self::stationary(center, size, self.absolute_max)?;
}
    // rust: self.center = center;
    // rust: Ok(())
}
pub fn set_absolute_max(self: *Self, limit: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if limit < 0 {
    // rust: return Err(BorderError::InvalidParameters);
}
    // rust: if let Extent::Static { size, .. } = self.extent {
    // rust: self.extent = Self::stationary(self.center, size, limit)?;
}
    // rust: self.absolute_max = limit;
    // rust: Ok(())
}
pub fn set_size(self: *Self, size: f64) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !size.is_finite() || size < 0.0 {
    // rust: return Err(BorderError::InvalidParameters);
}
    // rust: self.extent = Self::stationary(self.center, size, self.absolute_max)?;
    // rust: Ok(())
}
    /// Native start/end tick timestamps cancel in the exposed speed calculation;
    /// progress itself advances by one per tick, independently of wall time.
    // rust: pub fn lerp_size_between(
    // rust: &mut self,
    // rust: from: f64,
    // rust: to: f64,
    // rust: duration: i64,
    // rust: ) -> Result<(), BorderError> {
    // rust: if !from.is_finite() || !to.is_finite() || from < 0.0 || to < 0.0 || duration < 0 {
    // rust: return Err(BorderError::InvalidParameters);
}
    // rust: if from == to {
    // rust: return self.set_size(to);
}
    // rust: let size = Self::moving_size(from, to, duration, duration);
    // rust: self.extent = Extent::Moving {
    // rust: from,
    // rust: to,
    // rust: duration,
    // rust: remaining: duration,
    // rust: size,
    // rust: previous: size,
}
    // rust: Ok(())
}
pub fn moving_size(from: f64, to: f64, duration: i64, remaining: i64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let fraction = (duration as f64 - remaining as f64) / duration as f64;
    // rust: if fraction < 1.0 {
    // rust: from + fraction * (to - from)
    // rust: } else {
    // rust: to
}
}
pub fn tick(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Extent::Moving {
    // rust: from,
    // rust: to,
    // rust: duration,
    // rust: remaining,
    // rust: size,
    // rust: previous,
    // rust: } = &mut self.extent
    // rust: {
    // rust: *remaining = remaining.wrapping_sub(1);
    // rust: *previous = *size;
    // rust: *size = Self::moving_size(*from, *to, *duration, *remaining);
    // rust: if *remaining <= 0 {
    // rust: self.extent = Self::stationary(self.center, *to, self.absolute_max)?;
}
}
    // rust: Ok(())
}
pub fn size(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.extent {
    // rust: Extent::Static { size, .. } | Extent::Moving { size, .. } => size,
}
}
pub fn lerp_target(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.extent {
    // rust: Extent::Static { size, .. } => size,
    // rust: Extent::Moving { to, .. } => to,
}
}
pub fn lerp_time(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.extent {
    // rust: Extent::Static { .. } => 0,
    // rust: Extent::Moving { remaining, .. } => remaining,
}
}
pub fn lerp_speed(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.extent {
    // rust: Extent::Static { .. } => 0.0,
    // rust: Extent::Moving {
    // rust: from, to, duration, ..
    // rust: } => (from - to).abs() / duration as f64,
}
}
pub fn status(self: *Self) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.extent {
    // rust: Extent::Static { .. } => BorderStatus::Stationary,
    // rust: Extent::Moving { from, to, .. } => {
    // rust: if to < from {
    // rust: BorderStatus::Shrinking
    // rust: } else {
    // rust: BorderStatus::Growing
}
}
}
}
    /// [minX, minZ, maxX, maxZ]. Ordinary collision bounds use partial_tick=0,
    /// hence the previous size while moving. Static extents ignore partial_tick.
pub fn bounds(self: *Self, partial_tick: f32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.extent {
    // rust: Extent::Static { bounds, .. } => bounds,
    // rust: Extent::Moving { size, previous, .. } => Self::extent_bounds(
    // rust: self.center,
    // rust: previous + f64::from(partial_tick) * (size - previous),
    // rust: self.absolute_max,
    // rust: ),
}
}
pub fn collision_shape(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match &self.extent {
    // rust: Extent::Static { shape, .. } => Ok(shape.clone()),
    // rust: Extent::Moving { .. } => Self::shape_for(self.bounds(0.0)),
}
}
pub fn distance_to_border(self: *Self, x: f64, z: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [min_x, min_z, max_x, max_z] = self.bounds(0.0);
    // rust: java_min(
    // rust: java_min(java_min(x - min_x, max_x - x), z - min_z),
    // rust: max_z - z,
    // rust: )
}
pub fn is_within_bounds(self: *Self, x: f64, z: f64, margin: f64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [min_x, min_z, max_x, max_z] = self.bounds(0.0);
    // rust: x >= min_x - margin && x < max_x + margin && z >= min_z - margin && z < max_z + margin
}
pub fn is_inside_close_to_border(self: *Self, entity_x: f64, entity_z: f64, bounds: Aabb) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let size = bounds.size();
    // rust: let margin = java_max(java_max(size.x.abs(), size.z.abs()), 1.0);
    // rust: self.distance_to_border(entity_x, entity_z) < margin * 2.0
    // rust: && self.is_within_bounds(entity_x, entity_z, margin)
}
}

    // rust: mod tests {
//     use super::*;
pub fn invalid_parameters_leave_existing_extent_unchanged() void {
}
    // rust: let mut border = BorderGeometry::new([1.0, 2.0], 10.0, 100).unwrap();
    // rust: let bounds = border.bounds(0.0);
    // rust: assert!(border.set_center([f64::NAN, 0.0]).is_err());
    // rust: assert!(border.set_size(-1.0).is_err());
    // rust: assert!(border.set_size(f64::INFINITY).is_err());
    // rust: assert!(border.set_absolute_max(-1).is_err());
    // rust: assert!(border.lerp_size_between(10.0, 20.0, -1).is_err());
    // rust: assert!(border.lerp_size_between(10.0, f64::NAN, 1).is_err());
    // rust: assert_eq!(border.bounds(0.0), bounds);
    // rust: assert_eq!(border.center(), [1.0, 2.0]);
    // rust: assert_eq!(border.size(), 10.0);
    // rust: assert_eq!(border.status(), BorderStatus::Stationary);
}
}
